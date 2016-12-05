import re
try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

with open('datacollectorapi/version.py', 'r') as fd:
    version = re.search(
        r'^VERSION\s*=\s*[\'"]([^\'"]*)[\'"]',
        fd.read(), re.MULTILINE).group(1)

setup(name='azure-log-analytics-data-collector-api',
    version=version,
    description='Azure Log Analytics Data Collector API Client',
    author='Yoichi Kawasaki',
    author_email='yoichi.kawasaki@outlook.com',
    url='https://github.com/yokawasa/azure-log-analytics-data-collector',
    platforms='any',
    license='MIT',
    packages = ["datacollectorapi"],
    py_modules=['azure-log-analytics-data-collector-api'],
    install_requires=[
        'simplejson'
    ],
    classifiers=[
        'Intended Audience :: Developers',
        "License :: OSI Approved :: MIT License",
        'Programming Language :: Python :: 2.7',
        'Topic :: Utilities',
    ],
    keywords='azure loganalysis datacollctorapi logs',
)
