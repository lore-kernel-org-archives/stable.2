Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198047;
	b=CUJzbevPI/zSTUziBDFKiLGWKH8FpXX5Di1FExWCX/or1fIuBeZLmmLPSkQhLm4gnsQO
	 aWpvW2Bh1dDJAJiSjbBMu4Z/o3a8VRhez4I0cWXmD9kkQyAJb1eDv4Q6z1HQZeDPeFclX
	 dGcCyf4nuNf92R4MVQ6rrh8cSih7i1gFoW7bbadaj425kyJhbut6YpruterJ1ru/HGzjT
	 R1nQeppoImwCA/c4VxcMa0ifT3fXsaj2lGTPtVzWkqwwO55lqydbHWHk2YM4f9hyxbAep
	 ssqkvdNH0LnvLDvO65iUabmZTrNMuFDzsVuXm4Ztzo6p2AXTateJOBJHWOvca50LQyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198047;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=9+tE0IVOBH1jxcRtn2gvtL38QyMCJLC5uuX9AYcEIrQ=;
	b=sH/f/rz9gh60YV9l0QZbrJDH9YXRh+VtRlPl3eSlya8154mRcUwlbRgXQ+7Xh330871/
	 mjgCMIwGKQkeXwx/NFH9dDwMy/wn6PdvPKyT/od3TGmtpYupl1HtwkMzzP4bpzQ0NYP7v
	 Av9uAvr5jUIjKNLFTp+K+owgrYXSrcw3Xyzl2riwxGa3YVbqV+brYuadVbh5FoNHKOnc4
	 Jm+mJ+XooweNl0l5rqq61YBTcxOJtYvVDcky7qMJJtUPb4yRUg7Ynu3po0bQppOxfzeBv
	 sHUxgXPERJlo+vT2nrJ20IhuWp+OBzeCN7o3VjCd6qfgYnzM6NEKajSLjIR4Cq8O8xA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="tHQoILc/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.25
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BE606A892;
	Fri, 20 Nov 2026 18:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 480BE606A892
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tHQoILc/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNuB3wQhQ2b/zDcT8eoeP60A2k9GjOFa3nYlzrcZXUile/qu7XGxLRMUBdsG5S96Pd6acghE6SkiMq3eLzslJ0RH/KZPTK7UI8nE23tckdcmfwpSiVyMGj+mE+4MoPXfTTzsmMwiK5UdMRRSzD39DfLO1F8A7YndBwQ3qQltOc9VwC3Z25eMVmHkKU7b89IjaWDbu/HV90Fsj/AdcLTQePpu1aCb3qvOFIoqCn1YrUYYk3MrjUtaTFPUz6IsMps97ZTD+AyXA5gE91ZwW6E2gjDuj+KKGutUCXbG+c8PNLDieXhmEBLgscjGZmyhxbaACncUoo0eC+bVI3lOJ1/ioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+tE0IVOBH1jxcRtn2gvtL38QyMCJLC5uuX9AYcEIrQ=;
 b=JII6/h7/Mkeq7H/WIi/ginsD8H+QA89j8NoGCY9xpT67TzzVo6ilUqG1GyoH05WnOGFVuvz1yytcnAI5NBtUb7Vd71cDlvrHjyxZ0+6ig86Luueg04OAac/yvyYR6MgfEIV1j6o+9jRH586puDJf33WUp4rTfleQJ+imIeXA2sy4zc3kH7jupyNq7q76lStcUb05CXhNBa6b28QQ+Y5r+RxrzsWVB0Zh10YXAuxeIF2jCW1wRUfYRedRZ7BljkzkXeBtRRvxcq1f2XrWIBcss+LbAcSrNPd3wCPDf1VjQ11njyjj+nuwStujtqpBjfSc/sbt9i5QphlNoBw8ZvEdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+tE0IVOBH1jxcRtn2gvtL38QyMCJLC5uuX9AYcEIrQ=;
 b=tHQoILc/MjlzoN5NFw6LIIRUfqwOC6BvyxVnTfzYmOTBT0tQprJj6h/chCIgVre7Rxw9y0BtvmGGkP4im/d2ng4kpJMdmaleqeHH8E9nCwr70qkUex84w4shTkIVAF9rwl6iB/bxdUZnxtMTQY5Wm0lPwXL/eHoUx4JCeAYl7twtGHgAgLrtbCfiI3fVw2n2lIKoc6F29qxNHnqjjFzD3STLZ5KZVsH67xOCHbuMioVnZHMIHC5iAm39t2x1OesQhgbV7oJ0Vi1pjctlLljbHYnT7yN5575jgSoqZqZ47O65vomTAMKGXZ06b+Hll0OeVj+xhHX2qc+/G18JzCVqiA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by SJ5PPF665EE4E73.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::996) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 18:07:21 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 18:07:21 +0000
Message-ID: <eea1d302-91f6-4578-8718-fc466972e0d9@nvidia.com>
Date: Fri, 20 Nov 2026 19:07:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdpa/mlx5: Bound the KLM count of the user MR
To: Vladimir Petrzhikovskii <vladimir@dfb.sh>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Nikolai Kalinin <nikolai@kalinidze.me>
References: <20261120-b4-mlx5-klm-v2-1-5b37ace483ff@dfb.sh>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261120-b4-mlx5-klm-v2-1-5b37ace483ff@dfb.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|SJ5PPF665EE4E73:EE_
X-MS-Office365-Filtering-Correlation-Id: b65a4a81-2d58-4c8a-4023-08df47311f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|261102123227099003|261026121527099003|11063799006|261022105027099003|261021121427099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a3UxG4CJsF1fctT9x/qh3/ayCdLAV+qI8n5RIZV05BFfYR+AhypZbaM0GNQRfm9k432MWlHY3DaWwWIDFr9XSaJm+ZhUgAzfivXzjorHUwBGK66MDtk5oy/WL1KXuVGY3dzc8E+NzoN7nUb829qhBTZ+golN9+MKspm9eZr+YQizfpHe+Ij7RRy0J5ca1yke8C5Zt0/WNFEDqW1en+kU+9EUnjJjd8Tok3qkso1Kfi7mrkNaUkvDHP6SuiZp/cvos65pf1ZpCd+e/aSLcqxpEcYkL1v+9qMCfELOsMrQj6CsaP4Jr9nSkV8bNh+tkZm2AELcEtc56Ytt6hQx1cx5dWP6utJ06hDBdjGjxs1lwK6rj3ncL2Vxp0D2wJI2qp25KKwpWDxtVKzLyoM6M1UL0R76uBG4aMu8iWjxb2ENL0sfmQ7CwBYT3CTwp+ru/yL7oDQDzY2zapAAPzGlTzx8kJUESavTwhiYc164qyHfGLyIejRJvgsk34T/cIfyZvZNE8AN+8CrYU9jtHmZdv34n057/medjP3JTPDs1bGIXATFmCD3FO81kW+Bp13Qa0x1L1CYMTts3X23Kl3EOg5Zb4l6OZ81fBE24xrBGVwyGfYcCDHkMhyf3mLRMWlYHuhoyLmQv+eg4hLZBOw/KWk4JsPfJ8ZQ/jMF+sEsA00u8E0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(261102123227099003)(261026121527099003)(11063799006)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVdQWGhkY1I0N0d2MzlkY3VZZFVtaEdEWUU1T0M5QjRyWGY3cmVGMmc5cXVJ?=
 =?utf-8?B?Z3J6bUU3allOQVE5VEpnTWZBV3c0YW9SbWgveUVNd242Z2FCSmw0RjZQblB1?=
 =?utf-8?B?YWtrZUl2ZDlHOEpQWkFPRzRhVDNiNUJvMXhCVlBjLzJkZU5jVkwxMmRhdEVK?=
 =?utf-8?B?d3NPY0c3TG9La09EZ1RXY2l4UDYyWWFXWktmQmlMRFZPcFhORllaSmxuNzB3?=
 =?utf-8?B?RFQvN3RVeGdxQnBpTFV1UDFyQklZYlV6bGYxMldTb0VMMWdmVlNRejdtbWNx?=
 =?utf-8?B?aEErMXlhRjFDb3BMRlNRS2h1ZFkwQzZic2hENTd4bktXOXdGT2VhblVyWUVW?=
 =?utf-8?B?QnQxVnltZ2Yyc0ZybVFZcFUvRTZjR1luTVc2VXc2ait2VXhxbHFlOUJLbncr?=
 =?utf-8?B?MkNOL0tkaktYQ0wzZ2F5MG1PbVJVSy80OWtHNkdZVk1sV29kcUxKZ2N2NTZC?=
 =?utf-8?B?cEhqa1FUQXhGRzJXdUNSQ2drcTZvbklvSXdjU1ptR0MyRnZzNHB0UEtGSE5j?=
 =?utf-8?B?TzlUYWRUQnN3RzRnRXBpTkMwWjViVHQ1QW9UUWdZU0pQc3NZZ3dxZEJjY1Rx?=
 =?utf-8?B?cFYzbUs1MHV5b2dtNmF5cmFOVE51b2JxS2oxeUdiTldOaTRrQzJUN1VuRHZz?=
 =?utf-8?B?YzFPS1Vveld3eEZkVmpROFp0M2UrY1hkV090aG1sVy9BT2RvMnBWZmxvRExD?=
 =?utf-8?B?cHEzbThDdC9vNDVMRlVVbElpSDdyNVVVMEhlN2dpVTc0THpoTkZVdXhDTGhk?=
 =?utf-8?B?ZHo1MXhWenlvd1NDc3o1K3NnWEVJNHVmQXp4bmp4bElvakNhN0QyNFFXZnpx?=
 =?utf-8?B?MEFzRTdJNUUwZk15d0JHTlc1M25rZzB6VUZyTlMxM2tMVjQ3RTM5T01yY0Qv?=
 =?utf-8?B?UlB4WE0vcDNYK1hNbjJHQUdtWDNtT1Q5SFlXM3IzSHRtSFQwbTJPNDlUUHdV?=
 =?utf-8?B?UGlkT25nK3BCNU0xdmZwdWF0UnpSeWxmMStBMWNMRFg0a0VyWllmVUsvTEMy?=
 =?utf-8?B?OFRGTUU0YlNkRG5xRU5IUUdNVkV3ak43S0RCUk9qS1hzVzcwUUlPcS9HaEp2?=
 =?utf-8?B?c28ybitVM010Vld2THZReTR5cmhDdmwvUDU3Vyszc0JEQmJNdEhaczd6N0Nk?=
 =?utf-8?B?T2VHMjdCeGVEQnhqRG95dWR2aWdEQUhjazRxWGE0WFJpT2VRUkNLMVllU2FO?=
 =?utf-8?B?b1VmbGIvaEtrNkwvM1lzcWY4NDFRUHdCVFBSeEk3YStXVmhIeDhVMlE2Szhw?=
 =?utf-8?B?Z1dtejFLQy83ZVJFMVFxL1J4Q1lUQjBtRDBiZ2ZUaEIyRUpiWUNjMFlUeTVw?=
 =?utf-8?B?eDFma29QZFg5bCs1L0VVbGs3RDN5b0puTFJRYWwzSGNFQmNQZEJsQUR6Vk43?=
 =?utf-8?B?dzVkdlhuUWViVmF6WCtJcjBsSWt4RlBWUlFVUkNzSnFuZXZ6VzlRMlhNUnhT?=
 =?utf-8?B?cURFRVF0NktHZmdFeEdkTTdKYlRabmMvNk5rQzh1MG1uTVg2S1dkbERQNExW?=
 =?utf-8?B?WWlEaTVLMGVrY2NsR2xnTVBaU2JzYU41ajRkSnBmZlluODlDbXVtdjZWbDQw?=
 =?utf-8?B?dXVaVXVQUm1oN002Ui9GZFBjSnQ0bG5aRXkxVld2SkVUaU85SnlxelZpUzBO?=
 =?utf-8?B?dFQzZ3dTendvMzNhMTUvTStJS1U2bXZmcXZGclRCTFB2ZTYyNDdRUmVHYWla?=
 =?utf-8?B?ZXFVWENSaVJSekNzU25xOHR5c2xub21tQjFMamcrUlcyYUhPY1RiT3BlYkIx?=
 =?utf-8?B?cUdhMThYSS9UVGtkK0QyUXNHRS9GdnVydC81YlM3QklQc2JlY0IrSlVuU1l1?=
 =?utf-8?B?MGZ2T0FhZnJreEJ6ZlBqTXpWMmZ3b1JmKy9ybUVoTFJ3MVZ6d203eU9USlgy?=
 =?utf-8?B?UlZwTnRVaFpBbGZWOG5SNHBqVzhOV3RMZGNZY0xoU2I4L3UrVWpPSzN0YTdE?=
 =?utf-8?B?eHV2S3Y0czhJTXJRdkVtYUlqbVE0bTFzb0txVWk2VVpvQzB0eVRyanJTNE5w?=
 =?utf-8?B?bEc3S1ZXS2U2TUVJbE14WlVpWjIvM0ZxNkhiNSsrR3laY3VINkRpZ2pabnhV?=
 =?utf-8?B?QmduK3h2S3NISXVTUG1MbENOck9DVkl0T2dBcUtGN1dubCtETGtiWGJPZlFy?=
 =?utf-8?B?b0dQVlAvQU9HbzdNT3lHOEYxQXArSGdLSGtRR25DYURrSFZYc1RQbENLTGU4?=
 =?utf-8?B?ejJXdDN5RFdRWkRnSVozVmVDMGsvSHlqNTBvbGFjQ3B2WHkzVlNEOGlvTWFj?=
 =?utf-8?B?dnBIK3Vib1diZWRFQXJDTC9HeEZEMUx2NU9sKzdBNnlCSzZhSC9JR1lMMTJI?=
 =?utf-8?B?MWlUeEprZVdEdXBNcG93WkZxa2dTSm5ZMEFQWmxXdW5JNWlUcjRHQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65a4a81-2d58-4c8a-4023-08df47311f51
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 18:07:21.6195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQXfY3zKLio3zrPQ2pjYA2lsMkGbdAuHn7sJVIp27wuRWvJDD+/4CtLbkCgoYCsE5DLBpTVKWO+QItfixndzBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF665EE4E73

On 20.11.26 14:23, Vladimir Petrzhikovskii wrote:
> create_user_mr() builds one indirect MKey that covers the whole vhost
> IOTLB. It fills each gap between two mappings with null KLMs, one per
> GiB, and never checks the total number of KLMs against the device
> limit, MLX5_CAP_GEN(log_max_klm_list_size).
> 
> With a virtio-IOMMU the guest chooses the IOVAs: the VMM (QEMU)
> forwards each map the guest makes to the vhost-vDPA device. If the
> guest maps one page at IOVA 0 and one at IOVA 2^58, the driver needs
> more than 2^28 KLMs. create_indirect_key() computes the buffer size in
> an int, which overflows: the driver allocates 336 bytes, and
> fill_indir() then writes 16 bytes per KLM, 4 GiB in total, far past
> the end of the buffer.
> 
> For a huge gap the count is also wrong: the number of null KLMs of one
> gap does not fit in the int that holds it, and rounding the gap up to
> whole GiB wraps.
> 
> Refuse a map that needs more KLMs than the device supports, or more
> than fit in a CREATE_MKEY command, before any key is created. A normal
> guest is unaffected: memory at 0-3 GiB and 4-68 GiB needs 68 KLMs.
>
What do you mean by normal here? This sentence is not needed. Not
sure if it is worth a respin though.

> Found by an LLM code review agent auditing vhost-vDPA backends. We have
> no mlx5 hardware, so the fix is untested on it.
> 
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Co-developed-by: Nikolai Kalinin <nikolai@kalinidze.me>
> Signed-off-by: Nikolai Kalinin <nikolai@kalinidze.me>
> Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Thanks for your patch.

Thanks,
Dragos

