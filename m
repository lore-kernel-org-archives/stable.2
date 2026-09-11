Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7161371D11;
	Fri, 11 Sep 2026 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116046; cv=fail; b=jk7OPJRXTk/W8zqmLTw+kJDQN6JGKfFxDGJl24XMtQunTORCGntw4YnVgCgaVN9FxMqWYytzM5/lTh52NOgVFT3Phe7KbMiSZZTM7vVEkqVdV3a0vJtNxGaFylDs6IZxeNjoTvOqxVKLbvK1Ca8duNisTWT+ITcYphtOXhv8QcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116046; c=relaxed/simple;
	bh=GawntyeHJ7mY+Y3sTf4Y+2YbL8yPTKcnXz7tTnko+U4=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aoBWE2bIE1wpn76Y4qMZQxCKdv/OR4j1xDZVEYnYYmV0OkY9WponpahXAA3xK95OaYm3WUG6gfypZhX1TKxDbT5PrMnNYuougOBIWOs+mrrzMHh7EBl4jOJt839VTD/7uamfGiEDfPr+JwOx69n49IrUoQnGSqjyvPNySxnfX18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=IUT6zxlM; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=GtNmsqUz; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="IUT6zxlM";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="GtNmsqUz"
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7oXWN3342453;
	Fri, 11 Sep 2026 01:12:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=GawntyeHJ7mY+Y3sTf4Y+2YbL8yPTKcnXz7tTnko+
	U4=; b=IUT6zxlMuJ1LF+L6WA64OYmqBdbEZGbbm8wbeSuwAjkCscAfWEGOD55Zn
	KDPXRVjwXJmDMVeEFLzzHhavZ+XD+/NxkEHaPUCorJB/d9ufCZz6wqbnSAdlOWP7
	IC8zTSaKGA5MsZBt0Jv1gxXz2qQ9r7fRXg50PoWriMyelInYNQnZJ9DDzTXvWyRh
	/80y3NMrA9dkM/kmjBpN1qp6h5GjfEF5x7M8GiqD1aVDUwsKm749g/MjmRIhiWNZ
	CXmx6ecK0e3yhqTPNwgc2AxcZzdAn2d9H6cTx3YEOMcossqWNaSZpvU/XZ+ubm0T
	3XSOQlc7tzy7SuccjiyxTIkbb1wQQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022127.outbound.protection.outlook.com [40.107.200.127])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gkcywcfvy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 01:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/k+GIoEsLPsxnRpMJf0k+/YkIo4mLvm7ekuKfg+ot8tgSz1MR+KbBm3UguRijvM/tVYXoeEUw69Cf8G9W3eTiF5VG373q1+BYBHrFovl3l4g4CUTVyhE7svnntLVIIVdYlU2YM5iE28jjw6y5UAdIv4oXIg7o7OXFKv5chw5XBQR8kioQFGQ8lRruKQSyK4IKe5Iz1oSTGRe/VChzXaslL5dDx85vI6DmHRMf6xK4P9PRWTv+r9nJe2P2R5xA1RhaKsdRca9g3UB8CntM9+ouHcyz81ncQcrq61UWKWaAHmFVVAaMO5s3la2fveCibf9Q5dbysR8oOBQe4uiC+whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GawntyeHJ7mY+Y3sTf4Y+2YbL8yPTKcnXz7tTnko+U4=;
 b=phfkcZ0OEyXIOOiH1Rj2ylfIWY8EehsrmRVhxVcp+DvrARI4/xjskUchqMx0AtJgocO4GwMTFGQBExRmcITgqkz8Ji91CpmGOtDcXEMXDQugiLBghn1OQJL1HMvxJt50UWjDvbA0VRavI7UYgm/3H3uPQhnpCH7eKLpXU/RrtzLPQpPoqDeut6CKuEmiR4G4wejQDZce9a6ojvyGaQhy1Qe3T1Hlca5FhExfMPks1wsyNKiHFDrQKWWALyu2DDLt/Uy6maiOHgwQ/MeYX9wxVJ1G1DwCO/BcgkuB9f5DBVm5ORQZmcuY1fEQIh4tTEChBJrWrF7296Sa5G69WIwvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GawntyeHJ7mY+Y3sTf4Y+2YbL8yPTKcnXz7tTnko+U4=;
 b=GtNmsqUzd4AscYBafMEHugDSJsXOxld4RfaC8xTq8gdedp6DHDQaard/0yABtkNWlMUBXLTnpTx6/3zWHvWXhlW7QL9vmgmHEQ88TGAwIQG9bfYq6Na8meg85afgswCoSHg86COU/xDazSar1l5sSVaLZU/ULxdzU9hNPvdUSvguJoV3XxBUDSc+9SmK7ybsxIp3KnnCWfYAowsLFrZr/OHXVdh5R8Jb7ToC3MxMQAhnQKv+9s9qVIgjsAGUYYaWxiQTljaKW2K6NUIxc8S2yjflZSEM2Pd+2A03NGE+WAJeGP3JKrgpiFihOEY1z+shddQ12g9y2YBB5pz/HmfQQA==
Received: from CH0PR02MB7964.namprd02.prod.outlook.com (2603:10b6:610:105::16)
 by MW4PR02MB7458.namprd02.prod.outlook.com (2603:10b6:303:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:12:26 +0000
Received: from CH0PR02MB7964.namprd02.prod.outlook.com
 ([fe80::16d4:fbca:6e1f:f66e]) by CH0PR02MB7964.namprd02.prod.outlook.com
 ([fe80::16d4:fbca:6e1f:f66e%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 08:12:25 +0000
Message-ID: <9829c704-9592-4235-b97c-dc1f5e4ea795@nutanix.com>
Date: Fri, 11 Sep 2026 09:12:20 +0100
User-Agent: Mozilla Thunderbird
To: ljs@kernel.org
Cc: catalin.marinas@arm.com, christoffer.dall@arm.com, fuad.tabba@linux.dev,
        joey.gouly@arm.com, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, oupton@kernel.org, seiden@linux.ibm.com,
        stable@vger.kernel.org, suzuki.poulose@arm.com, weilin.chang@arm.com,
        will@kernel.org, yaoyuan@linux.alibaba.com, yuzenghui@huawei.com
References: <20260901-kvm-arm-nested-virt-fix-v3-2-b154676f7e4c@kernel.org>
Subject: Re: [PATCH v3 2/2] KVM: arm64: nv: Fix null ptr deref on nested
 wp/unmap, teardown race
Content-Language: en-US
From: Jonathan Davies <jonathan.davies@nutanix.com>
In-Reply-To: <20260901-kvm-arm-nested-virt-fix-v3-2-b154676f7e4c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::6) To CH0PR02MB7964.namprd02.prod.outlook.com
 (2603:10b6:610:105::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB7964:EE_|MW4PR02MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c4d613-f051-43c5-fa9e-08df0fdc69c5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XQ8zqahKbtOnB+38ODPL11/DNDpxEUtmu8F+Iu25PU7IfVEpNTIBcVTE4/xZCMU4xsNNnLVnL4Metsx7Yxiq8vWynbDUvXhP7teYcaDsPHqPZOOVeo6ebg9fL20/Bom1saqlK9O0qrRwXGO3RCJrdHbL4uDSoYBDtV/GD+8Clt4O9VduFkz5qnze2NAilLwM3w7NekOoGOcrAomyD0O4cXsWRNpMaBO9716U1nvnO7Nx/eVSy78x+5Yk/ivp/RN3ofJTP6/6GbOwUEkfvZKeNaIfBuZk1XZ2hvCcnY24rU4RfXGcJPLi+Tz3Fi2cbz4hoZNZ/IFjPBOaCeeMFr0r+kYpRD6pIpdpA6Y53f+vpWb3ltUeGEym/CmuXj0GdXcL2DapcQC6xyG2O7ovt4ahLHvuLeRzDqcJW10eDQzqAPHNne/mUkA8/phPRQlG2o7qWBFLuumciaoxA/hHK6F+YSAYbgpMye++DxC0hmTXpMLpANLyXaUU0C2QrL+p2Imt5y5Y5RP1+jcL8xK315a8Ua6NCWH/WTYINaiwjgLHAkVB5Qg+XytEP5R0xzjeqB50Q9Rscyf45PZiphD5uPRPUWXXJ5CVTFjYrlMc7GGoAk5e3HV2kJSeJIzvmGoKC9RtbjpjOJ7uDb7RshmWjpmtxyQ1W/ir+e8T+oLrZ9oPBdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7964.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHEyMWVGN0VjYit0SWxZTkZCMG1NOUpxamVhZjVDVXcvZTlOdWNsSkFJTlB6?=
 =?utf-8?B?eFZ3QUZrdnc4ck9XaUdPdDJuV0RwTUNSZWs0by94SzAyejIzR0hUa3IyUmZo?=
 =?utf-8?B?SEttaG80L0Vzd2R1WVkzQkwzM2RwbDV0MVdTSjBWVFdSamtzaUk2TWpKcnJh?=
 =?utf-8?B?VUh3czkvSTFiK1BCN1Rvb0hLL29SSG5KcFc1NkhjWmMxMnB6clQ1OXZkdUZ3?=
 =?utf-8?B?V0pLZlpaNzZteUhNWWdnV2w5bHdDV3R6SkdHbFpseEQ2aFhjbHNqcFQ2YU5W?=
 =?utf-8?B?VUtsYUZXMUZUVGh5QWVtTyt5QmNnOER5cithNUhDUGRFOHZ6enFlZmxVandl?=
 =?utf-8?B?aytCcFZSbkRqWXRLUWhZRmdjNVBWbi9WUFdZRzMyOUdJbXVsOGFONEFjSlhF?=
 =?utf-8?B?TGhYeFVUTVRQVXJ3UTNvT0pkRkhveXVtOHNUVUdiWVQvTDVxVTNmbk4rbWNu?=
 =?utf-8?B?anJMaUNnUnc0UmJwYWVtdngyTWwyVXN1ZFVTSUdrcnVNOHpVVHc0YXZWVnQv?=
 =?utf-8?B?OGVDVzk0c3REc1QrTVNkQVMyV21KTmZSRm0xYWV5TWVzd1F6RXdPbGEyZ1lK?=
 =?utf-8?B?Mk1NSjM2MndlTFE4RGRSaE05L1VXWHVzV2hsb0E2eUZnRm9PN1FpZGEzQndQ?=
 =?utf-8?B?Nld2Z0Z4NnlXWjR2VFVVd2k3cnFGZEJkUDZWWHdvbkdDWkw1enoxaXRuU0pC?=
 =?utf-8?B?V1gxRjFGWW40LytXK1ZUVEFqZVFVVFY1d2hHTURqY211U3MxcVRIckViVEln?=
 =?utf-8?B?b1daTTVzWTdST25rZVNUeFB2MXZEbzUxdHMvSzVLUURaay9Uc21la2g2cE5u?=
 =?utf-8?B?TkwvTkpFLzdPTEtSV04vVmNXeVFpTEdhT1RQUDZzSG1EZDNleXM4WUlpdlJj?=
 =?utf-8?B?VGRPQWNYUHRiTVJ1SHIzeU1ZVW9obEFEM3pKMWdTY2hGVnZhNC9XVE9aTnpP?=
 =?utf-8?B?OVhoV21weU5sdXNEQzBSZXl0czFWbStOV3dHalBNSFk3Rkg2TVNtTmh6d2kx?=
 =?utf-8?B?YURlM0hCWG9qY1dEanFuUFdIMXdVWVdXVXl3VzF2REtUTjdSaVFxb0FpaEoy?=
 =?utf-8?B?MFlod0M3ODE2U0I4WGEycnBmenpLdlJkbFdQazZBaDM2OVVKbGZqYUZpUk1E?=
 =?utf-8?B?K045R3ZYVStPNTY5QWdaY3RNZ0RBSW13MjRDeG1vVWxNUmFITnA3NUl6b25l?=
 =?utf-8?B?ZFdZTCtFaXlKeExPZkdLQThib29qaFN5ME5EY1JwQ00rVndQTnNQMHNGaSs4?=
 =?utf-8?B?dldVM2pMRFFQUTZJRXd5UlZmSWZQNE1sQmdTTHhLS2piRi9IZG9WNmE1aXVX?=
 =?utf-8?B?dlZNVW8rTzBmV0JRRlBhQnVkcnJ1VTVSbGNIcksrNk5JRmUvNW52dVN4ZGFV?=
 =?utf-8?B?dHBBeXFyaE90RlJEenJCRGR2aHJzY2RJMTNMQ1RZYllOMmN0VUVxTjBLZU5v?=
 =?utf-8?B?bTl6a09lTENQWTViUnczdHBLY2piVlpUb0hjWVpjV3NadkZuVm90UXJRdEVO?=
 =?utf-8?B?UncvcDJua05FNFZDSGNvNkFRbzU3a2VkdWozeDA3VVA4SGFuZmo2dE1RdmFC?=
 =?utf-8?B?Z1grNUo0MVhVYjR3L2dzb1dEVWN1cGxrNHBQT3l3WkR5ZzRpZ2VPKzg1bDNG?=
 =?utf-8?B?dnhQQ0ZtQXlWN2xaUnpHTzBqQmhTWE1OQWxOa09MWlZyZXFxcUZOeUcxZ09J?=
 =?utf-8?B?S0dmL0M1MW5MK3dqcVhJTGdEUkRXZkFMaDMrRkUwNExZVUpMUXpNdU05L3dM?=
 =?utf-8?B?ell1aXB2S2w4M1hhTVJybXRWL2NKaVc3ajhDQk4zUldTdFYzbllWRnVqOEF4?=
 =?utf-8?B?NUd0SDlqQy8rUHJMcndlcDBPaHRvdWNIZlc0eFhJbDRwWm1lMHpWek1aZ2Ix?=
 =?utf-8?B?c1ZzTDBqSTZoNklmNlBCZDhEYUt0U2wyT2VFcy9pR0RrY2ZJTUk0SmxuVkRw?=
 =?utf-8?B?MTk5c0REeGRYTHk5ODFCMGZEa09xai90b3BONzRDOHZXSDJpT1lXL011MWNO?=
 =?utf-8?B?Y0ZBTGMzdWY0UjBqNmRxaHV0ZExBZDB0cGlkWlQzdzBDem5XdEt5RU50NnNi?=
 =?utf-8?B?c3NiUlNKbWROdUVRZ081NFpGeDFnMVQrWmQxWHp4enhQa3d0SEY5VVlzcFl2?=
 =?utf-8?B?WWl6RHhqeHhIU1FkMUhpTFlhd1RzanR5Mm1xa29USVFJZVI1aXpERkhXZnIr?=
 =?utf-8?B?bzFpN3lxVXQ2ZmFDbUhWeU5HWlB3RXBZakE3RWp1Tm5xYUVoVTB6a3VkWkl1?=
 =?utf-8?B?cU1rck5vQkR3c3JCVDkrNmdpdEFiVVBkcU9LdlZNa0dCRGhxZWxodFhuTFN2?=
 =?utf-8?B?OUdFeVZ1VjhQL0RkNFRzSXlWYW5MSVdEdXVMV1pWOUN6NVVja3ltM0FTOTNN?=
 =?utf-8?Q?n4gfhKMjtdp6kBAc=3D?=
X-Exchange-RoutingPolicyChecked:
	klMBJ7Ihv0HmVdWPMy06tIjAt1KRhogZmW7NIsHVgWldvIAuH06fXOHx028dA16iGtH961mzjsSx1LL7er1fnY4Qfu7h01vjsGgbrfK09+/DeGJmg0dugzOh9GgW7CEhKQ+np7D0wgC348hEd/iKTyEs2wejoLGFLeMHvqnQ84BOHynCHuj6iI+yDqnlS51yoMmkRUyl/MTN4R5po1x7vSFtyfoVC7F228aOsBRtmhAc5PGEJSIj/5Zf+q8Ejnr87lU5jagLDs6ImUNz4FblUNme1vX9+nmEYFHMcZ7g36bPyU0jW6DePIg0Td1JeSYoeAsw4au3NfTSHZhwyu8RIA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c4d613-f051-43c5-fa9e-08df0fdc69c5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7964.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:12:25.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj13pYDvsQ0Ny0MTDMC30i1JCKVHmqorucHk4GU6jIz5BwA6XXSArM7OyjoZI5ya20dr6MRLZowdvJd5JKMoXO6XwSYkR4OVPgujmSHS2no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7458
X-Proofpoint-GUID: GGFPG1ah4aqggLr0MlohhRJEcg2IHk_4
X-Proofpoint-ORIG-GUID: GGFPG1ah4aqggLr0MlohhRJEcg2IHk_4
X-Authority-Analysis: v=2.4 cv=I+/w19gg c=1 sm=1 tr=0 ts=6aa3b7ed cx=c_pps
 a=JUmpB3/3x7NHV7iXOe9JbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=OYlk_aYH0AonTVLPQygA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDExNCBTYWx0ZWRfX8//4af6dF2Td
 tdrxD4YLZBI+pWr1MFFwrQ0OZyu0xHIkkyytjl+aTUc4Si6UT6/LUNNhZRtDQPogSLUdmRAAmSu
 dyB+jOadukbOrv2lL/3bHmwzTFtKwA3uYnE5E6X5Qlu2ZIfn/GBP5dO565Jh/EHiIqhkS/iYPZv
 hdLl1jgL/uytCuh+5YEyGXYqKNRquMb9VPu2OVN3f7NyhZQwRCbHWPywpaQsJojpxikORHMLrmy
 eO/qYN91Poseag0EHNKV85SjJUouFD5jha/Mw6XanTwnQivt+5hroJcA+xuQR2dvjfP+1KbHORW
 I2KLPzGWxSGWT7vY5YTnXy5oSv6l/VGLRxOY/lCUZsE30g/bmHALhtwvEVQrpLiz66pvTSpiXqb
 TIIZogk4ZS7D39+/dwoXbyWhq6qBsyoY6xWK+OOmOA014VZkWdF4Yy0+EY3z+AlnA/VjARUiLYA
 q5NqaEluep1H5O+3GzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDExNCBTYWx0ZWRfX2uY12VM06hhY
 CmEqgC9hK5l6nH2XYZy3SHb+8hm37c97Eg5aILboTnF9arA3XliHYjyO6o1Kka2WvddxcmKFX8t
 srDIjMe/NlLTvCzeNRx16iLgrgJwCrM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

On Tue, 01 Sep 2026, "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
 > This means that stage2_apply_range() can drop the kvm->mmu_lock and
 > thus concurrent progress can be made in lockstep with
 > kvm_arch_flush_shadow_all().
 >
 > If kvm_arch_flush_shadow_all() advances ahead of stage2_apply_range()
 > and completes its operation it guarantees a NULL pointer deref.

I've reproducibly hit exactly this problem when running nested guests
with concurrent memory compaction on the L0 host. This patch fixes it
for me perfectly (applied to a 6.18 kernel).

So, for what it's worth:

Tested-by: Jonathan Davies <jonathan.davies@nutanix.com>
