Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501179;
	b=hDeKR6+GZBuGltkKEC/el0F380hfE+HYbbzlTE7fGz/S54WGjCEAlVcstJo2ceOhA3Q0
	 RuwvTpAd7FUOt9Xb5mb7LQgnVRGIG6jlzdIXhl1zWUxV3cUzwDLq1qsf5viPOQ8/diRt3
	 wWjOcTc6+2mCIKNRmwj+eUnoqSAw+Kv9SfWCfXP/OtA/3qEIBxnsdu+w0D3leQClUPJM5
	 sBuVvuWUa03SlPok3sK+JdxwZU5KIftQPYFPqjt6bCpi96pn5ynsXYaiGh5w310E63q0Q
	 hHOUd4zEADK/AC8yD8gW+5ezIub0Yf5P2MNR+EL7Ohxvzj52M2XR/eCNGsWFkRfz2SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501179;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FZzBv2cKJJOoHkdKfJ5CGsGk4hboNl0GEf5NNyCGjtU=;
	b=H4k8EFDkzPL3yXHpOl1mVSDPfdSFMjIeXDNCZBS+/aK5OSnANzEuAuETE4nACrUWswDX
	 eOHoLyWw59oPUQoBvorh1tb3YVltlLTD7tbcb66/RXLh1Zfm5IJ6eAQ+0uDvqY5FGJD4R
	 fIuEyLjO35keWj9Z1eQWTVQXNQMMBSw70xtfCmiUPK+xksuyIZhyXWLXoKtbZn8y8uQjU
	 XPRvqmcK/pC9bkc64kTHbGE7dZaDqtemdK7DF+92QkBDsCGgGVdSoFzLuBQj3ddh5kwml
	 Gjp9OrKNkjlGG8mMWdCGdcEzJfZ7hOHWic3P3kiNJJqfqbd/YULxErnE2QUL2xkhRZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RnttbHTW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.7
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1A606A31C;
	Tue, 20 Oct 2026 12:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC1A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RnttbHTW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oq7/+yjT2xr1a4BxWXNaeR4swydp8xBOPLHqHCFm3Al1KUZY8rhhyX0TowLatxXjcx+/UguiMMD8FexzQhCX1jxH/i2Kg5sQH5AJOqItuBdELDly03RLAIaGQj1xotiDFm43aq+TMGLa2X4fscvuH6rxi01oWCkVa3KxmEhCs6FzmkMu/eW377UIKmaa/7yRZTbFW+nR33GmGFVPkvxXe4JPU56UHL20LsrKQa+nWl09RxGntCJT9EzHFbec/u3mFnuCJI90PZGlvMM9d9KdUGMduV/YAOHx2Rwk1UM+xF/yN0HfV2ICr7z9kvqTegIio1vz0/041Hb6fUx6AkQKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZzBv2cKJJOoHkdKfJ5CGsGk4hboNl0GEf5NNyCGjtU=;
 b=qMZmkrxjXPj/CnMsTrZsbi1iMfHT8omxMP24ZmPmRRuAkhEzOEaQUm/VMZyaIghtSixXwR4KQOJhzLu37JEEF0XZA9Q5EDa5ZkmIVpCp7RACMvVpaOHF9ZL1uIoy3p2pDMmD4ZGzojH8MdiQo0clj+i0VxEdBZ/OZYUciuSc890dN15dfUWat8gj13uepRDMSOD2U1Toj/cztgP5AQn+O6GfRoAa33FKtyV2aq6+IfUXyzSix4Pg1plRsvHl+wUaLIwv43jAmw+BEKhKzsvgeu0PpnHNcRVNRj1WIuaAuhM9Qijj2TH13X2JeUIbfNg+ZXe/PN9p1vEySulAwpsECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZzBv2cKJJOoHkdKfJ5CGsGk4hboNl0GEf5NNyCGjtU=;
 b=RnttbHTW/Df5rg/Nwv4T46pOZNVjpOTAWio9WLYsOwa5gsKBRpC+WvO0wzfYDYmkIc8By2mhUUQUdpLHRDmnmB+qpF43H0fO24dK1l3i+FHLSJkIMNYBL3cxHvOnWavI+H4g0K/19302KMX0ppXHaz1cAXux3N3D+0LVu0AcvNAIxfbMhj/mzcJB5Lr987MR4i5lVnzGgEmaIqgk7XT8pGAdHyR8oZTuq+Lv/fQzDegOaC1SzM7C9GBBQ+omRfmIfKvEyoSg9nsOrLJYcIxthSSy8q7cJtHZgeUDoT8cnrUKyUtoX/uvCmEFyRbOcmo0LcqX6nyHWxZCWh6+jeLllg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:59:33 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 12:59:30 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] gpiolib: free the label of lines released after their chip was removed
Date: Tue, 20 Oct 2026 15:59:23 +0300
Message-ID: <20261020125921.2896041-6-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atIouwa5R8sb0nS-@ashevche-desk.local>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com> <20261016-gpiolib-chip-removal-v2-2-aambrozewicz@nvidia.com> <atIouwa5R8sb0nS-@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 371d1831-5b5e-4133-c204-08df2ea9fb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|4143699003|11063799006|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XpL00wuhaATmK+bjCQZ0TCZ/5TUyiVZ+3xVOOCAsy0OGqY74rdJwKIPEkZhxe3WhKKBntICe6z55XB1BCjPhT49H0E9/G9gMgxIAPi1PRNGjk37LRwSrOX19OBWJ5/8L8JmMKBnehe0fYNg7dTHa9mOIKwKlBTnv+5XM/qPmSyVYwz4DByBTV1UYUZGzVUkhbhIamsTFknzC88DGVfFW9UHdqapwHguQpT+xLU4fPiMAPVD9GI8Y1s45JE6edmA0RSK+w0z4G8iz0ckL4VqRsC1A1U1zKd57ldJI6a6C8WQJdDlA+7lp7E+qkkM+lkef2983LYKwquHqHOIrKlHWPkyB/5hw2PLY1g9nTxIa6gNAdZvFA0XQddk75SIp2EJxzJzPlR5RtmwmtDlLDYYR6C4Wk/VZnL4Md8ElEbA96LdWEoMfit3tfJgbpqTiCv+5CzUAMXBbEZEh+c7Cy4r3dNZ0czjErhVOr4yuGsON4bGU2AQ4+PBMWzB0mXtGrOeVIWuxcIHxZWHGVSch3XB6fhEbSksOyIz6C8XisALmxA00qww+juUbFwAgbohyqhw6yv9Y9F9UVbTKGw1M1RRD9bBeuQQ/dnDUD7Bn/OC4Ay9VljG8EenJtSSee+m3WdZtoAchwvLzPtqMTaiu1m8bnYss5sCitWigmDf4v9ikJB8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EExAWnTXTML/IVxnri0aIHrMvcgyg5R8z13vSC48CG1tryL9TttMrp7fqe9z?=
 =?us-ascii?Q?oMU0AH7LCrQc/1JaOXjIrrB9Ymxsdj/7No5K2gXWzpjlgGFOyI4XnEiK0Uvz?=
 =?us-ascii?Q?nONFK/c7DQdYKaU9DmRskVhIJ3e1fIwQpT28pKsJGaw4OuD70u0XW1CGyb41?=
 =?us-ascii?Q?yMjPYnCWtpaG9rxGV7W8YhG04T8cdJBPfhwfh6QZuHu9GUDWXGAMXeTLaYsF?=
 =?us-ascii?Q?X05salyW3kkhbwXPFbpaguoboSX6q/w/7gA4rz6slF7nZpjLTxWKL1RjXFDz?=
 =?us-ascii?Q?SW2YnfRQRMCkXg2mbzkTeHHJB35UwNRlzGS9i0PxhNIs3chVHPhSgEfp5tQN?=
 =?us-ascii?Q?TGxDtSe505M4sqevFMjDSUszwjvFoq3kdX3ZRGBxfBSH856s2NUT9Yj6DQZQ?=
 =?us-ascii?Q?3K35WiHRysyWn9TyoX3HBXLsPtae8db3serB3ihoxyUYO13CAwkz2RnWoume?=
 =?us-ascii?Q?h9GlmKI34HZNv91s3uSDCWURMavtO9N1e3WIbTJgi7U9WoqU95B86JRSHdVY?=
 =?us-ascii?Q?1Cv3S/JahCXfWMPRMaLmttRMI3pabuAwRu9SFvTe+0/ncGkNw+/4RYDoC+NV?=
 =?us-ascii?Q?i6bFZjsf0I9q+Xar/fFkUFz45Ja2nOrueBjBzckDan/T2MnQMNR3b3SGLbQD?=
 =?us-ascii?Q?qJRkKHqcCyLJy7KDy2H80UraiJCHNwusJwFdc+artyWlPUrIDGhCs8atMGq2?=
 =?us-ascii?Q?oR0eGHIdQUTZ7zPiuSd7+J+5JKtBKVIe1zaAqWdosCCHt//I67sFcXuCeuo5?=
 =?us-ascii?Q?0zjNH00dok5v22XD+TF3wgtub4t4MzOCBq4RwJTFxf8YQjTwnvgBdFXVIUz8?=
 =?us-ascii?Q?X3Wj6NRR2YB9VEEGEXYpX+sv+tvMN8u/y5kHvZi7/JFgW31XYjpuE9GjB5o6?=
 =?us-ascii?Q?I4fjVqSrRbbkBdJ845IH0hS5hqcq0tI5gkAwFcDf9+saKizHBA0cvw0l3wXg?=
 =?us-ascii?Q?tUulcf/6wlyri/7F8HUInUCN5AMszze5/cifpq/b/sAKhiOYxTq7V79vEBzQ?=
 =?us-ascii?Q?qg30CwLtUFOOdidIrBNJLFkmKFz1+q/Gf+PFx9S1j7YfN57Zxp4HnCERvS4A?=
 =?us-ascii?Q?CA/jNP5tXLFss3Ty/hSgiZdJPSGdXpTyc0tJgGZLdmaAxXZOXO97I/KO4Qhh?=
 =?us-ascii?Q?YvbA9M/vnEMxpbvYCwBFd6LlDhqlPCbxfORQotohJiY9hQ2+wrxJD/fv+k1l?=
 =?us-ascii?Q?KAwuDlnHZqQI3cque/6DcBEzkr4shEaiJZao7gqrUwoMd8YBSUElWY5vow2+?=
 =?us-ascii?Q?2x/Q+x/H5/m11BTLqALO3ihYxga2KjPfZZ+9AjVvxmxbdwOzg4eyKYvxvmRQ?=
 =?us-ascii?Q?egekhHQqkE52qwovTaOKqxMa2WyOSnti7rPdZqHhRycELj2Jc5KdL+DmzoI8?=
 =?us-ascii?Q?RnbhXSdh+2OZSXxTSqMoQ8fj/hs7YWHquffT0NNl5BCvDbxpsbbDSj5WbxYv?=
 =?us-ascii?Q?NWBo8xM0pVTPvIKDxugA6/25IUdhU4YIRllHjzkW02M0mzmtrwreN/1OUKlC?=
 =?us-ascii?Q?ylYZu1ug1Bonl/tZ/WjJ/YJc6YpEaSl/+RbDvz5zrzB5by+BjO9dbx7F4sk6?=
 =?us-ascii?Q?QPWmfiUVMAXstsN4juh4EkXxZueTzhh6XB+DitY5KWDi9G++U5/ePVTOT+GR?=
 =?us-ascii?Q?WbDW3r0q+FJBSx0KwW3gxWl8MNsWJLOzxLG2JTURVqRmvFQS/BwQsoeI5WAp?=
 =?us-ascii?Q?ReHY3+Al4u3su/jQjw5QcBHg2ZM2pE0T7WomuFQENh+Joe5MtwBV7K7mfOwY?=
 =?us-ascii?Q?kl1GMoYbyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371d1831-5b5e-4133-c204-08df2ea9fb17
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:59:30.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkDltY6fZNF3yW4nJHXg/J1XNNLFcdmin87pZeV042jO3gKsWGh/uNmmBdzBXkHlDD2A23oABgQaFaXArAiZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

On Fri, Oct 16, 2026 at 04:38:03PM +0300, Andy Shevchenko wrote:
> Be consistent, in other patch it's called Call Trace:. Is it really different
> wording in the Oopses you got?

This one is a kmemleak report, not an oops, and kmemleak prints
"backtrace (crc <checksum>):" there (mm/kmemleak.c); I dropped the
checksum along with the object address. 5/6 quotes kmemleak too.
Patches 1 and 3 quote WARNINGs and 4 a blocked-task dump, and those
print "Call Trace:". I plan to keep each report's own header in v3,
checksum included.

Adrian
