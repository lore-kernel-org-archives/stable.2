Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F86D3955E4;
	Sat, 10 Oct 2026 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623520; cv=fail; b=RZoctbH6Sv+Zx2rz5mb8zYWF7GN6h+LFUxZxX88o5XHpJFT1QyLq+ojmJSY9CyE8C6VQZ0Ix80oAJgyB78rUDvS3EGAgTtDCkXr5KoOWfoq1dQLAArI7AJJTjPolalbiL2RsXpYpKAT5Vxkejg7xqKUMXLroVKrLKN8pIx1PCNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623520; c=relaxed/simple;
	bh=rG9XeD4ITr1/MbX1VK5JbHjWlXyBGwfb0mJXZL9QPrw=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=VnjnuBETb2du+RVvBAYeODhOX3fS7vFdxRvQeuHUcQc7pePxDnWhah0wyXCVuZS34yKjxfC7Mk7YDbGPs954vHbgT6QPJVIlHgfcisoW7duTH24fB5QGhz/cIhazXkyPsu94TQjJqa9YISfqFEHPtiNbXc6KrBW5QCelWJNRwKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K7dDd9xI; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K7dDd9xI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED7zrIaAMYXnfDlxpyALCV25vCKqAH/bMRMmlWcmKPivopt3wSzHx16irqdKP6n4K9YXS+l6KUiPbv44AaTBdldBJDR1hAjpmt7ZeT+mT8ibSXsG2A+AK3BJYZFzN/T4jUaDPf+BxBGsqNF8x+CE8Q9xmnmJPckLcjqvNTKiAT5J2WA+jUPiHYJKswKogFVzg22rPCRL/JWVnpVWi2rXJpOkysrXGaRjuEwPfWoEOMwb9QWqcFZKDpu2zJAhvpT5jYYSdL2nZ5W26xIZnLwpyQsvvPN6MGtipJLtCR4NktJCQXSleJP/04lyvLZMJS4WQafNsqYzFBU6FMHAZUSEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s4gqxwWp498s3XeOOsfn024RsnjakXIeKJLhiXph5s=;
 b=EPQJ4m2HcyLfYfXGn9DiWxUhMMC1P2F63ciALoytMFJrrP88fj9714u6KTNaO+zjAbX9PlGcf2Q3nt3wvCiF/VLZnm2Saag6UTnou0VGjZmjFO+O3GPS4oHDaC04oht8zdoVbW1OH78POaHqtDMF4uzZW/w2ftLMJwgRGhYt8myqW4Zjic7UBdaVqpT9iRNnbvX/ykvO0c156R5dYfqBnsWlRo+4PyCYOW34Jz4FzTkVY11EU/GDKSDBpcJoQ87ovPjGrmNgbh+4txxh0TtOwTImUWyDApTupbm9hj0sGUSETu8mIqFAU2qhlwVDP4uEeYGyekQ6vBxCGIj78Eg3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s4gqxwWp498s3XeOOsfn024RsnjakXIeKJLhiXph5s=;
 b=K7dDd9xIWVJEdqwVOlsyg/UYD9v+07jCokzpasMpjiE3EcfNPMufvjQ50IpHlvCrfzXXgC50YhR4yYqlsN01IwaMACgriosgNk1Mng+6GwSDbrLjHSf+qTtMnLxQnISI2EtqcOVxOtRgdmA5uQ7ZGJPK9dC4AnkS4ersoTWdsh4h6dB+3efMUMqpW88CaFjirJrB+CcZ6FXHKl/AQ9NrWChHyx42jkahMU6tZZMBKDvcjw1MyYtHJDcrLNST3j1Nj5fRK5mpwJqmbV+PS6HR2cYJ1TKcEf8A810nMqowxfWzMre2yyNb2fXcMId1yVDIulJUQZ78agrrpXx/segihQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPF5C0B6C3B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::64e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 09:11:56 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 09:11:55 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Sat, 10 Oct 2026 18:11:25 +0900
Subject: [PATCH] arm64: tegra: Override ethernet FIFO sizes on Tegra194
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-t194-stmmac-debug-202610-v1-1-dbee21235296@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWTuQtGlEryJdJJOxjtAqmVSE0
 rsb2+Xjw19BOQsrXJsVMn9E5TVX2FMD9AjzyCipGlrTemusweiw2ItDLdMUCBPHZcSjYt+l4N2
 ZUucJ6uGd+S7f/X4bDusSn0zlv4Rt+wHUsatVfwAAAA==
X-Change-ID: 20261010-b4-t194-stmmac-debug-202610-53da647cd36c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4P286CA0113.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPF5C0B6C3B6:EE_
X-MS-Office365-Filtering-Correlation-Id: d60cfaa7-78d6-420e-fd71-08df26ae87aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|366016|1800799024|56012099006|11063799006|10067099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	ht7nsBHqU+S7EZ79bGrjh3V6lxkeDqSYlyhEsVQq6vszjN+3rE7MPJpu4Jpqx8OwKW2sIZ9q54bL8+eOwgOBVdLdCjZWT7xdIvkkKU7pHMrZ3v2zcTxWgYc7s/lUFBbIW8stCdDcBs1v28Ou9hzBC3+6ZVYhNsKg/2XrwEez0cQDdgLrelfdaDTGn16318qdtIWmKCpUKPKRpcHA2uH6+i6vHIn5ZKiKz8nJ15jSTIS7/yEL3dpG0sSlnlAIJLAKjLzMP3JkM77KPNKKjgbrKSJ6j4pYFwnKNyDPFrm+QIpHPL6a/uN6BO3j+Z0hcwTGHfiO1/8RQ90jprbfFBbaofNRe8QZPYF5nkylpr8DTm9ZpdJ2L3vOgnMg/Y7JTvx14Sybeq4Uja3e9mVwDNKFnamCU5AEE/kAvBKnAIKKzV0hbo0XbldVIAiOFSVUUEaIhjU9e6lnt4hCC/3y1oUZu0skYPL5ouJ4rkcUembze9R48hoeawuNGx2xOvN12fweK0DBGeVS9gtAhwSWo/4mTVqqdImojnbxwaJKd/yEMGDkSFvrfFYZYDNRv+1tD50hYltFNqS/BND/zwfMrCv9wy6Qzfwq5odCPiKn4xR5CFiwv9EbhykIEdldIxhub2qOW6hSp6zXZ6CRxO7D/khvlaNKVSPBsc+5ey5ASsh7YRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm9wRWRlZUxYQThvN2swU1hGTHg4UnpzRHZkRHpKeFBWS2IyUlFTY0tURmU0?=
 =?utf-8?B?MXdNYnNGbkxkRENMZWc2VzVYUE5NejJWNTdOOUVYNWV2WElDdzY5REIrR3o5?=
 =?utf-8?B?TTByVlZmTHEyc01BUERvTlBiYW9JUWdDd3h2SFZmWGZjbXY4OW42SHlDMDNj?=
 =?utf-8?B?WVdoNE1YNC9uRlNqVElWSVp3NWRsQmVwaVBTVk9obmNVejBLUWZZQUVEdjJ4?=
 =?utf-8?B?QlM3bU1MUjZLZ2o2RnZJOEdvaFlMaWk1R3pPV05XcG5Wc0J4bjlidDdOeHA3?=
 =?utf-8?B?azF5YWJGWXhRd0JlQVRsUEVLa2dSejl4dEZodU5PaXg4VzZJTEpDMDFsNmln?=
 =?utf-8?B?aTZjcktPKytZcXF6WkZxb1JTeXIwNmlLbERtend5eUVsbHd6Y0p0UmdQZFN3?=
 =?utf-8?B?S3lrZkxNZElYTW1rd1NMNlFaT2cxTEp1TTRKUzZQZ0hGdW02THN6UFpWdlpD?=
 =?utf-8?B?dE51Uk83ZWJVdDl5MmVxV0dNM0t4Y3o0MjlGVnBxbXY1aDcwWHBhOTU1Z2wz?=
 =?utf-8?B?d28rRDZhek81RU5MZXpqZTlCRHE3bE1FbjIvU3FDbGkrRE8wNUY2RGt4Qmxu?=
 =?utf-8?B?Sm5NNkFQa3dWTmdZOFJkSjVWbHRmWVJEeDV6R29RTXFpdGJFdmhYTElTNEw3?=
 =?utf-8?B?S0NxUGYyQ0NLTkVqVWVwdXcwc1J0bFBXRFJNYUt1THIrMENJbzlFR0FQS2VO?=
 =?utf-8?B?dGVGL2ZPUjRGOG5MMnhFNWpOVVBBaHJpcUMyRVN5MFh1TzBZRkJ2cUpwYy95?=
 =?utf-8?B?aUkzN3FyUDBDREw0TUkzVExkaDZaMjJEQjNGMlllQ1RUd08zZmJZeVlNQmkr?=
 =?utf-8?B?YkoxWmc2bWhFK1JSOTlUQ21UZXM2bU9CeExHZklkOUxjTk5wb3QxcVJwVkZ2?=
 =?utf-8?B?Vy9seVpKakZRZ0pTclpsTk04Z0VWT3hoS3owWWZUK1lUZWRPOFF6TjUyL3hR?=
 =?utf-8?B?MmEvSUp1Vm9IZzU3K3Zlb1dvdWVmWjhXbTNxdWtHd3FlR2NLZ2ZaVGtra1NP?=
 =?utf-8?B?alZ1RHFnY2RqakpCckkyTndZTHZpZm9QZUs1Vm5qbGVnLytNTVZpZjNsNUQx?=
 =?utf-8?B?VTE3VEVSM1YrWGJJZGtuSUlBNXU0Z3lIWUdVQmpKR3lRN0lDbW13WC9QL01X?=
 =?utf-8?B?RU9ORk5pNVYvNDB5MUx2R25NaExZYXVHK2JXOU1FcFdaWDI0Y0RRV2dyTzNj?=
 =?utf-8?B?N0taWFdxS1lrWUFURWNRTjN1ODFXV1IvMTAxOWxrSTRZQkxUUHNtU0JaM3BU?=
 =?utf-8?B?bHoyTXg2TkZlV1B5RXkxWjJsQUZpT3YrRmN3cG1wRmdYdloyYlcwWGYzU3Ju?=
 =?utf-8?B?Y1pLaGZDcHpWVXU0b2VKVkkrUmlMNGsycmtqSjZJUUVBNmRCRUF1VGN5b0ZN?=
 =?utf-8?B?blhiMG1BV3c4Y1Y4ZWxQeWpSa2dGek11WEVSTlNETllHY2Z0Qm44WWYyS295?=
 =?utf-8?B?VEI4d1pCWlZnb3oxSFhOZWU4bGVIaHlSOGR1UEFuaXJQYm5WQ3A0SE9wL2Ro?=
 =?utf-8?B?ZlRhbVQwYlR5dU5UZUtOalpqektIVm1vWVZLZ2RsTWJhUkZEU0xwaEt1RlFi?=
 =?utf-8?B?WXZDZjV5S3hIbStuL3ZIYzVSdkNuUFhzV0dHcnlXNDUwakFnbm1FRnpGcnRL?=
 =?utf-8?B?V0xLSGZWOHM3cVpBYnFON0dBQVg1TzFWVjMwdXltMWIxWVZhK252WDBnM2Z0?=
 =?utf-8?B?aXcrb003dWV1Ry9FSGNyN0ROYWJmTXNUMmNVNUs0K1hwL0xEK0V0YkFwV3l0?=
 =?utf-8?B?VkdrRUhna0JkYVBsZ1piNTRJRVJRRG5oWXQwVUJwNjJkbGUrZCtwZEVWMkZi?=
 =?utf-8?B?M2h0UmFTU28vUHZFUmdjenVSWUkrbXVlY21wNnd4WHgvRXNNMUFxUkgzSUFN?=
 =?utf-8?B?NnpCTFZnZ2o4OFIwelFJdHpLQWdsS2V2UEZpTzBoS1N4QXpBcEVrWkFlaXR1?=
 =?utf-8?B?ZUhtN2RuQTUwRzVFMVRmck1RNVU5K3EyYkJxQ0dhQ0JDV1BPczkrTVBhZzhN?=
 =?utf-8?B?TnNxWDE5UVV0Z1hTZytzSElFL2pRNW9CZXVaR2VlemJjQmlVYTVaUVdrOTQv?=
 =?utf-8?B?dHpGN3FQdzFjZXVpZ3VOYmdoSFFjV0JoL3YyZkhKeDVKcGh0Y2hTK0txYU4r?=
 =?utf-8?B?by9mZ1h4b0M0dEEzdVY2a3l0UUtxLzZpUjNZczBXdFRDTXZKdXRoQkFrRUJw?=
 =?utf-8?B?cmo4Z2Vpby84d0ZsWDBFMmFDckI1eUhJYWVKNHlmT052dC9ZdENpQWtnUEc4?=
 =?utf-8?B?QUFDM1V3NG9YR3FoTDg2Nk04YWJQV0VabHkySWYvSFBhU3hDZ096R0RCeXlO?=
 =?utf-8?B?Q1hMb0c0enl6MVBLUmpFU1JvWkJ1bHBsVSszMXdrZFQxdDJ6OGswdlI5WlNI?=
 =?utf-8?Q?fnoZtnrD/cbXkRBkVFLw+aepVkLOp6BWzqeIpCKNtuT1L?=
X-MS-Exchange-AntiSpam-MessageData-1: Nnks77D6R5Kbwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60cfaa7-78d6-420e-fd71-08df26ae87aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 09:11:55.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5t1LpOTuzgDczwWDIlsJ01XedrHjKL2YgQNgmQPfSGk7i3ujlSbdZ3fc1B0qIhbmtZi6B4ivFmK+43qCD4tM0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C0B6C3B6

The eqos ethernet device on Tegra194 has 36KiB of each of RX and TX FIFO
memory. The hardware registers that report the sizes to the driver only
work in powers of two, and are rounding up to 64KiB, causing
intermittent network hangs.

Fix this by overriding the FIFO sizes to 36KiB here in the device tree.

Fixes: f89b58ce71a9 ("arm64: tegra: Add ethernet controller on Tegra194")
Cc: stable@vger.kernel.org
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 43d82841b3cd..fe2a3b81c829 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -156,6 +156,9 @@ ethernet@2490000 {
 			iommus = <&smmu TEGRA194_SID_EQOS>;
 			status = "disabled";
 
+			rx-fifo-depth = <36864>;
+			tx-fifo-depth = <36864>;
+
 			snps,write-requests = <1>;
 			snps,read-requests = <3>;
 			snps,burst-map = <0x7>;

---
base-commit: bf1ee2bd5c2da8992f33c8950ef194aaff74ed6c
change-id: 20261010-b4-t194-stmmac-debug-202610-53da647cd36c

