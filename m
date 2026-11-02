Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793638135;
	b=h25n9Gz4fLF8VxuMtxhlyTF+BnwbpkcIeaTHkdS3A/89o5IS3cXfrEhR9p5zpeRB0ifv
	 QtJjMkaEoxhV71W2OfmJ6tWRPrnHraFXSfIJUsH/VZ9Tp05PKZKfr3sgCA89b4y1sZrJ5
	 G/nW/VYh0W/p5wuOGE2mietTg5sP3UH1W7te7uK2kaICGecYjFpz34XwBb4r+6/SPE/on
	 WB6VrdotEuKHnb6MFYOKtmvj8Mr3K7qLnSPMZ0jxZwREd+pT5HoRZ9ctJC71n5lVpyj1I
	 AHqtPZSemVW90ZtFq/ZAIZQ65R4/LUYQsD0gspzXYz++24LXcldahQdWkRFjm+OFhgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638135;
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
	bh=+fC3Z0+jU7ZdURktJbbHEBtzUTZEk3jonbQqoN1ZuZ0=;
	b=h7/TgJma1i7yQTSiMceYs1JfCkGDmJ/GFywyJ3zWfzC5eVgwcEYujNEug7W6sk5T6mOT
	 TCLJDlja2karSCZ4+BtNwxC46Q3cLvO29j7FOFSbkvffg/y64v27E2Qo52qs92s/H7s/5
	 eH0zYUmRjaD7MZBl4EDcbn6C3bS1ih3f8P4q4ybJdSPBdkiXjNzekhGr6jmE0Lb3iuaJd
	 qY5Ed3OP/bU7RBDKBVNf8u8qO0CXKjF+eVyfiX6MhGUVv7XYLnMJ7VMwG+16/QTRojzgb
	 8lohR6A93rOEv8/2U1RD+LmW2SxHy/DTvcIOHS0GBU5dHhEuM+Lm0v8kxHX5F3Su9Mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wVgiw6n9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.38
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9052A606B1F6;
	Mon,  2 Nov 2026 16:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9052A606B1F6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wVgiw6n9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6eZGoLXIPK/sZ91YxJLdiSvju4Oa0nWKmc2UYmkZPLMoQZB6D9yQkI6WOoRO+Jba047pQlu0feqcsRfG95qu0FClX38C60mju3BEz6j0Vv4gk3hr0yloPNuXM/km/bMw2Ippx9/3tmisfr+O7sXwgQJFu498fQ96AHvYmXw/Z2AVlzhDXx+8Rg9DmBbvvLIKVaPgam0cB76sExexLAJMxBQlcLmGhUPNSH1ugDJHJzqe95kNiH9Wrz3ZtLP5in6kaZV0isKbpYnmJv9n09CM+RiaYqggg0DoBhJPjeMDW52HdUhgLXb4HcRaKtO1zXvBJvBSJe0YFRse78uIXFVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fC3Z0+jU7ZdURktJbbHEBtzUTZEk3jonbQqoN1ZuZ0=;
 b=LqWh96LvIs3AjCh4JmxssPgNZchn3sdbz4QhHeNwpEsVFp1Kv2lZR11pEGJRS0PKXsaJBWvwEMz5PxNzIBzYV1hKbcM6ivFMiiJZ9gnWVANGGJixvVMSDuadIj25JH820Z/VrKXoW1jc3+F2apMdrP8Ix/Te1cRyiYFqNob1N/8cX111Ac/VctftkSmZfufDR1hP1Rd0RdV2y+JK8ENvuJnbfawZKRZMnPrldURPwFIMsf9alM00TTq4j3hQkNQc4y2hpeAW5hLDGymrgW9N+ZbkwcEVBcXa2pRoO2sd89lgJdwJvCqFUjFFCYtBIiZ8O8/RBh0kH8m27/KwjlelzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fC3Z0+jU7ZdURktJbbHEBtzUTZEk3jonbQqoN1ZuZ0=;
 b=wVgiw6n92LIzK5iYX8Egkl+oGef8wChqmoi/YrvliM5j2If3Xp3hOnK75oUpOJoGxLscUqmcXjU4HVJ3d5awsEFWTASsh4dJMRk/qYGSVfp49BYDZHToODj+5FT7ea+ejkJBem991gpGVctcNhWPu18LpL7qOkIzH2chzU7l/V8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:48:49 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:48:48 +0000
Message-ID: <f4c1a296-5cd9-4917-9a21-db39146e8751@amd.com>
Date: Mon, 2 Nov 2026 22:18:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: remove obsolete domain pointer warning on
 release
To: Kevin Mitchell <kevmitch@arista.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: stable@vger.kernel.org, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joerg.roedel@amd.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20261013222402.673852-2-kevmitch@arista.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261013222402.673852-2-kevmitch@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0358.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::17) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb30339-463d-4f0d-9756-08df39012ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|261026121527099003|11063799006|261022105027099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	le0903h1UHdSjdvIzp0WWClJUIZJDkebu5eS3lIdJL/njaQCfJBPBRg1a9fs6AsFm7lqD5kvYgMDkWeptY2aAcQzjEZZa3HBYSYn3F8SuG8WlWS7wEW6sybR6AVymkQt+zEoqaEnUt1sm573a51zY5g7Slai3OZMTPhW3mDNVhxJA5l650kKeCHGiPtlHRu1fRvjh/fnmlQ4K2zNgjDA4ZWGYlbusW7UzyukEy5Db84GhFrNQTH2NbV4mOAFX/8a5/EXDn4j4kPuIYzPVM7RjmBBGdg2Vrv/6CIgQ/VyinZfMX9NeHx2wJRmFxnVesBvoWvHp/uv/AERQypioJdfY4nm2ufMFtxVnEC0WPHhS8GLyWbbI+6G/PjlQRpPvMDrJXSbCRUPRRbyeqOXIN3qQ4l0T9sze1CYOVRSRxrRQGSEmKUxLuQuQhg5vFIdV3ZTg1oBBKC4EOdfbrFFzTs4QBURFNWJEsK1SoKyxXRNQI1cPn4e/o5VMv7iRt+Gq5cbI66wBTwlmNlyK0wbAg4jTX1RKOq2cCoz3+Om+RgW0a/bjoGukaCU4/+ufju4Mt74WfOCh2GhqXmf/m72uMhQIUP8d2oJxYoELG/IdkKC0hNX3dVppAB5oIHmY0vw4P10UNdV7ZRefyFJavFajO30QEvq05Mnm0stQ+dNnnPQ1T8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(261026121527099003)(11063799006)(261022105027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnFxQ255dnNWWDFKWGVuSW9QdlkzcGlVbGh0eVF5bkVZZTVEbWI5cjVWaGd4?=
 =?utf-8?B?ei92b0hRWDUrSmlWbUJIU2FUbXZrR0d0dTducEhZSE1CMVIwOGNDT0FuL0pW?=
 =?utf-8?B?NEVVR1psRnM3WmlYSnZqTVFHck9kbUZCUXBGeTJzY0FSQkRXN2h5TTBVT2I0?=
 =?utf-8?B?aklWMU9VcGFobW9MRWpCNzQ5VTRxa1N1M002MnVRNXFEcnpib2VXMTk0ZFd4?=
 =?utf-8?B?YWJZQmVkRlBYSXkzOEZCSnJXbGtUclVFcEN3SE9ERi9OV2NOYUZ1NFg4aG1W?=
 =?utf-8?B?SlRUWEFqdVM1d1FXVzJuNzNhMXBmVVh6aEpQaTNBc25qOE5SMFJWNDk0Q3ZH?=
 =?utf-8?B?OGxXbDhOUUJ3bUV5Q0pkUy92ZmdmOTVPT3YvejBnL0FENVlaVW9GM0R0L0tR?=
 =?utf-8?B?aXhGMVVKNlBucXNBSGdJaFEwYUR2bTdnOE8rcGlSYjV1SnhtdzEyRVVhV0gx?=
 =?utf-8?B?dTRlWExsVVVsbkpNRmxyTFV1Q0k0Y1ROK2hKUUNnZzJ0TXFZdGMxTVlNL0hp?=
 =?utf-8?B?aXpsUkhIS3h4bEZ4WjI2LzA4S2ltZTZ0SGtIWS9pLzJ0dTM0aWFNSUlCWDMy?=
 =?utf-8?B?dVVQVDUrM2tGalBkWmJBa2RWQzJkRmFYZHJRZHNTNXdabEdlaFVoVGdJRDZB?=
 =?utf-8?B?Yk1TS0hyaTZXZkVrekswM1N3YjlJUW1tMXBXUFd2NS90cVJtSXAyM29zUHZ4?=
 =?utf-8?B?a3RGTWhsa1MwZjVTQWgyTXF4ajJvL056SHdSS3lRNHZxUFVKNFpJbk5VenFz?=
 =?utf-8?B?NHFVSGMxWXlYTkxJVHhIWmtVMUMxdE5yR3lER2cxWVNlM291REpCQllVdUVD?=
 =?utf-8?B?eVVpY256Z01TMmtYeGxHMjVGcUJOV2JiNTJmRldvNmV2UXVtSEdQWTB5bUJU?=
 =?utf-8?B?eEMvZ0REelFONjZ4RGR1S3E3SzlqWE9xR25xa0JHU3pGYzRyQ2pjMkxPdGRt?=
 =?utf-8?B?c1pnL0ZOSHpRK21hakhia0c5U2k5MWwvVnhGd1psbm91cnF0MXozaEpNN2kx?=
 =?utf-8?B?cTgraHJoVVBrTy9yRUM0Zjh6V2pXd3k5b2lFbW5kd3BuVXZ5blp1ck5UM0ZR?=
 =?utf-8?B?QXVDVDdCT0ZxZ0hFR1FQSGFucE5EeHdRcWJ6TXhZRjRmZFBFa3ZFMmxRM041?=
 =?utf-8?B?QnR6akhpV0V3MXh6cGZ2KzF1N2Q1MDVLYXVUbHhIZG9RR25uMTJvV0RmZGZa?=
 =?utf-8?B?alJicHBBN05paWsrKys1dzBFaW0vcVowM29GQTJqNUoxOUVLb2ZMWUxjeGxO?=
 =?utf-8?B?dHlvRDR1RVFpNjFhbUYyODNLUHp4R1A2K3hvU0FQSm9YR1Y1SElndkFWZkJM?=
 =?utf-8?B?N3c5RnBCRDN0dmE1R0VOV1crcHlrNnNIekhLSWxiNm9mNkRLRlpVZmhGNVp4?=
 =?utf-8?B?Q1VNUTQ5NmhEb1F6YXNXRDE1d3NWYWJJMDBnRWt5NndnZmVJQnoreGgrMG5M?=
 =?utf-8?B?TFlTNlZTWXFzSHpFTHplZXBpQkZhZTNnV3BuM1JIa282dWorTlVLeko2R0lh?=
 =?utf-8?B?U0xzNHEyK1ZORzg1SmR5dXpwYWZXWE9hR2tpckFqNzVvM0dTRkV2MzVwNkVO?=
 =?utf-8?B?UitOMkVEcWY0N0l6dTYzZFRVMFNDWUlWaCtsR2ErV2xWUVY5R2M0dzBNQUJn?=
 =?utf-8?B?R1RJQWJ6MEFpQUNrcUtINnJweHBLdHpPZURhRjZOY05tQUpEWTdFNDQvem5n?=
 =?utf-8?B?Z1pPMEdVMGpxQU9vVmt5b0RVSEJadGs5cVgyMTZHVlZESEE0RC83eXd4Rnp5?=
 =?utf-8?B?OHFndFVVcXRKRGl5M252VFFCUlYxTlM4V0F1MmI3N2JRT1ovMVNBUXpkMEdS?=
 =?utf-8?B?WkQ4QXkrMTRLZWFlczYvcXlmUjJUSnFHclRQV290VnU3RGhyNk9FWXFIdTlC?=
 =?utf-8?B?RG5wLzRTNjJrUDlCOEM5eXNtQVlta2M0Tm9zNVpWVFE2OU9xYUF4eUF3L2Vu?=
 =?utf-8?B?MHNVSGRvM1hnTnIzc2g0a01BTGlVL3dzZWpRNUU2S21WbnRZb0V4djdEdmU5?=
 =?utf-8?B?VjBoRmwvdVJjYXBvWmNoQWQ2UFFZUitTTXNiUmQ4YUl0Q3ZnUnYyTFMyU0dY?=
 =?utf-8?B?cHBUUndLZnFydDRGYVBrZDlOZVhiZUZRYUZualpReFhuL09iUU9rYTZLNzg1?=
 =?utf-8?B?dVkxdmQrd1BkN3hNNWQwdzd6RmtaeFc0eE1SOWgzcG1ienVxSmYydG9IQnBa?=
 =?utf-8?B?YUY0S3BsZU9WN2VSODZ2TTJteHR3UlNmOWhDNllybzdiVjVObklOWUR2UVhx?=
 =?utf-8?B?U1F4SnVETU9XN2ZNcXUyOXlXQTU0THpLUWlVVzhaY0kzYzk5ZHdqd09IRDN0?=
 =?utf-8?Q?BwBSj40THHuoMovhL1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb30339-463d-4f0d-9756-08df39012ac2
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:48:48.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgoBxvRx/sZ0vs4ID3kOgHs5jJEUAItADxc+zJ+4jM3DuZHuSM6A9PAMc5GTDFXB0Yf5fqRnj1Vp83eogKXCwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649



On 10/14/2026 3:53 AM, Kevin Mitchell wrote:
> [You don't often get email from kevmitch@arista.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> A warning is triggered in amd_iommu_release_device() on removal of a
> device with an IOMMU_RESV_DIRECT region. The warning is based on the
> false assumption that correct attachment to the release_domain will
> always result in a NULL dev_data->domain pointer. For devices with
> IOMMU_RESV_DIRECT (and consequently dev->iommu->require_direct), the
> release domain is the permanent identity_domain which sets
> itself to dev_data->domain on attach.
> 
> This behaviour was added in commit e94160488e65 ("iommu: Generic support
> for RMRs during device release"). Commit c21b34762e2f ("iommu/amd: Set
> release_domain to blocked_domain") caused it to take effect for AMD
> IOMMU.
> 
> Remove the warning as it is no longer strictly an error to have a non-NULL
> domain pointer. As this leaves amd_iommu_release_device() empty, remove it.
> 
> The warning was observed for a device with direct mapped region:
> 
> /sys/bus/pci/devices/0000:04:00.0/iommu_group/reserved_regions:
> 
>   0x00000000fee00000 0x00000000feefffff msi
>   0x000000fd00000000 0x000000ffffffffff reserved
>   0x0000fffd00000000 0x0000ffffffffffff direct

Thanks. Queued for rc.

I have a patch series that adds more things in release_device ops like disabling
PASID/PRI etc. That will bring back this ops!


-Vasant


