Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D11472782;
	Fri, 16 Oct 2026 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153005; cv=fail; b=tm21JP15KDYIVwOkEfSbF+KOykov3p84ue4K4rRIfEdbMTT69R+rp3mqDQQcOx0ueypq1Jjt2RReJvZKz7DsysoNhWGcXpNz6prnPt0Fyw/c/tJDPaDjj+XvlA2NVv3b4x5FxVJR0LSbd6+t/yuqZs48B5+VnmWIVvwwPhsotIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153005; c=relaxed/simple;
	bh=RpQ0DEXUO2U/KCjIO505R3H9gci5zGq4bN+Afze/Gec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V+wreFOOAeAyObtqAnyDFpOGH44VuJz2spzkhZvLHmcvRSh4YD7h67ihEZBAVti3ohiRL3V1c4ycL3hJiqxbmueaQWJoG21c7L3dVy9/GqcxRBkyXDxCHsKjDq929c1OgBb6cNHc8TAaJ8KNuHN61py+q5KtUDShJCTz5kQA/Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JVkZPC+H; arc=fail smtp.client-ip=52.101.46.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JVkZPC+H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrrjZrsytimZZTU+WWQBOgFCDoVr5BQMuGPuq4qL++jN2lavWlqCom2iKei0wD2y+v4UmftoOeITbfq8sGIcvjtgZsqRVNm1FhhXxfhMN2YOY+fKwfr/wMO08kq2pj+spsbpYIHgRZYDkg+QidTraZVKygfDU86pp4HYTfzjdRlouRJbHlHTQC8kIWdvSt1iGNJxCxD9Er2HrvvEri3NWuS7BqXcDouE3SlmuXsMpBi0efYLWilBBgor9JKfZsE5sOAOudVZYBVAqhNa6je3pAtYOtNbypYHYcH4NTiXyeeMVpXkGbDFLgijGZn1UmQel8JgS0/mw/uecsE33VnpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Rfcsqeo4enPM6AuyGnCJxiGnd+s4O5mnXliqfplvOo=;
 b=dnC8bcU4A+cD9/rivcGib0VRul3ZeJwYlAbbqhDtMLepFsInMjMlIxKBKRG0fU3pZqVEMcqjTX3o65VShuuP98t3vf9qsr4vmQXb22EWvZXOX2V7N0JpMKLERQYvBqOGqUdC+HJmDUz9TBTMXKMRB3+RahABiPz/cAkcN70wFIzDku3XZn9QgTgYbnG4DbcSl6HtYnE4uiDfTCeKehL3WC4e17wj8m2bqcgd7aELIKa5NdqrDZiAB0ZrKT5oYViXdhCOm+TSUQSJ7s1jB9q8clnLiQIGBzDHHKr6VAZ2tU3lU6OLA+PzU4jqWaBF0SOumnJDL0BSjD9ZrTP0C+fXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Rfcsqeo4enPM6AuyGnCJxiGnd+s4O5mnXliqfplvOo=;
 b=JVkZPC+H/mTUHNB14NE5+x2Nez4QvWdaimBsEcuEH+oHkuI9ZtNh63clax6TbJt0EVrXCi4/G+rWeLFzvspW0MhL61WusFk9b+GaoXLet8k+rv3/H1d5ZbN7m5Gj3f6OnwiSZYuzshUjmuayp5R350PYM8T1cIkmPbqVFUBnBcI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 12:16:42 +0000
Received: from DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c]) by DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 12:16:42 +0000
Message-ID: <b2d9229d-2f34-4a1c-b288-9332917c3b8e@amd.com>
Date: Fri, 16 Oct 2026 17:46:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: amd: fix len==0 underflow and FIFO overflow
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Raju.Rangoju@amd.com, Weibin Liu <liuwb@xiaopeng.com>
Cc: linux-kernel@vger.kernel.org, sanju.mehta@amd.com,
 stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
References: <20261014-spi-amd-fifo-fix-v1-1-9fec9ab753e8@xiaopeng.com>
 <179210311701.134795.14035717437104935583.b4-ty@b4>
Content-Language: en-US
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
In-Reply-To: <179210311701.134795.14035717437104935583.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0211.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::17) To DM4PR12MB9733.namprd12.prod.outlook.com
 (2603:10b6:8:225::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9733:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1e91c3-62b2-414f-114b-08df2b7f56a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	0VZxrYDrfn/lrRv6L0jF3nbKtkv2t+fQHEsrpgrTii/GtQJOYK5S38Jh9nTDYWuOdJxA6Fp6fcB9CUIg9WXILHC+WvExcVdXz4a9gpZTkl2BexLtHqEV6pwM57FAQACOrgGJfH9nYf2PYPTkDa/uiDVXJgT6VUDiqNtkNaHX8ZVmOWLXyzY4Kl2rhc/H7NBevPZReRF2jmLW9TYnlgbMaXam33L2tLpSvNTtFQmub/GsubCIBVVhsu6iqLqZXc7eIf0inqrcR4+ZeumuNeOTSHnlbBJoUJcUMZmPDkz/H2cof6sutgYrTIKr7DgQHvEzKJvsnCfFFEh9CcvXB71JNiLOX9OLoWjcZVbXHdb2UlVv/BhedRgAqCPYIML8mEY0TiB2NRYHPj0f+2pBoRx2KsRyKX6geN+2uUpQPYpVBwz3O2r4IPf208jw5nFZC32O+vdjdrSGEjTNCjW4HMHLk7mHOZwrDPOrpm33HmJnSd/lxAx4Rwvt4R9gBWuGUux2+qHUjMwhKL4f0AyV+W7ei462Tqy85yqFPXIdBf/Q5OUNQrQLDA1UbWzhQKtdDoEoJ/inv1hXG8iPfTxbZ9earD0HLL5qACJ7k3RPRkl8k9O5APlmnczLpJhYMUWKL7or
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3R4blR3VnZNbmVzN1ZzbHJpSlJVbGFmendhb2xHcDRmWmxUWTJ4ZXhZSDMy?=
 =?utf-8?B?VnhVSEs1VFVlaGlITy9RdE1yVmk3cnFwNEc3eXpCcUZzSzdJRmpzUHpsTUNq?=
 =?utf-8?B?YjdkaHk2Q0dHMkYxYWhLS0NZUEZwZGwwRGZyb3UwbnpRb1pUdm1WUnNxbERh?=
 =?utf-8?B?bG5WT0gxcERFY1Y5aVJBNkVwVy9jRFlXN1FiQ1hDOERnUEFPTStXdEIvd1lU?=
 =?utf-8?B?QWkvalAzY28zNTJnYW9qazdPYUd5U2tzbWdBNHZ2b1RmbG11KzVIekcwa0hy?=
 =?utf-8?B?OFBTSlhWSno5QzlXVkg3TkJITS95Szh2TWg5ZXpqdnhOR0RzdnBuUXl2c3JT?=
 =?utf-8?B?NUlIcGNRS1FQM01pMnE0NCt4SXYyNnVyS2p0RjEyUlB2OENFT2F4SzFGbmpw?=
 =?utf-8?B?K2ppR3ZKeDF3NWNPMUg1WjZZUEJOWUlhOW1rY0prbi8rdnRPaWx5dkFtakJ1?=
 =?utf-8?B?cW9ZTnFjelhTa1N4NktiMWsyNm04T3Nma0x2S1Vrei81NnlERDI2VktabmJ5?=
 =?utf-8?B?NGhJK2dpMHJrbkUwTGpzV2hsQVZHMHcyQkoyYXFZYWJhcmdMWnJNbUN3T0gr?=
 =?utf-8?B?V3BFbzIrMUNNSkI2MnZrT2tDZ2RqWTlHK2c1Z2hRaENoYW5jMURCK3hiQUhH?=
 =?utf-8?B?dXhtbzg5NG9YOGVvNksrR0ovdTlHRzNpdEpzeHBaMzE5VXJwZjRoSDF0L0cw?=
 =?utf-8?B?S3VZNFcrUGZ5TlRHb3dYTmdvcXp3R20rVlJtc2RJZFEwMmpBd0ZMRGhUQVhQ?=
 =?utf-8?B?Zlp2dFByUmhQYm5KR0EyZ3FsRExUbUlIU2c1bWlYdDUzcEh3Z3FxV2twWEFn?=
 =?utf-8?B?THkzcEZRL0J3N0dudTZMSEE1VmVWb2ZCZ3RIQkttdXRNQ0dPU29Id2EyQmFC?=
 =?utf-8?B?cUxjR0Q1b0VibWNtQzY4cTRRVU91eFpvSjVHOTlwaU9qTVRLZXBDYkFGL25o?=
 =?utf-8?B?NnRnTU9UODBoUTQ3cCthRDRCNlNDR1B1em1IMDFlSSs3YmpUQ2Z5VSs2UElK?=
 =?utf-8?B?NjA3eWx0dHlqTE9XbjBnZ3dNcFlXNHhGcmtaK1lWRnJVekxodXB2Z2V2bHVZ?=
 =?utf-8?B?bzVNcStpTkZxcnVKaXE5ZTkrVHo0WUlNSERMRFE5eEY3ejN6cTA2Z25LWGhE?=
 =?utf-8?B?Zytrc0V0cXNMdklDbW1IbUNKcEtZY1o1TTR5V0hvWGxTNjV3SmlwdkhRZlUz?=
 =?utf-8?B?YmsyNkJ2U2xwVzl0ZDdRcVVLcXhvWEJDdXMvQ2RUUmdxUlV1OU1nWFlSa05n?=
 =?utf-8?B?QkFzWmhtTGNVaGRqdlBnT1VDQisxWG5vOWZOZ0NobDM1bXZZRDBzVnJnaEY2?=
 =?utf-8?B?d1ZXenREd1hmQnRNV21iNmxYKzE1RUxlTHBOZW9lbUZyc3RidWUyckhQNDI2?=
 =?utf-8?B?YVRmV21vRDRJNDFGRC96UGg0cmFya3NFMkRRMklsQkhjMkJxTVE0M3pvKzdK?=
 =?utf-8?B?OVlvY2VXbFJpQjdWeVVORTdwd043Y3hZaFR2Nkxpb0Q1bFhsYnJBb2U4ZWVX?=
 =?utf-8?B?Y01veitQZTRNaG8yVTVhM2prRUlUQTJJdGNrWitySHg3TldNM1FmOW9lQzJv?=
 =?utf-8?B?RDhubUlUOCs5Zit3R0JGWXlhQVh5TjVleVdUay85S1B1YTVkQ0FWV1dKRjYw?=
 =?utf-8?B?aVBvays5RExBekFJNEh0MTkxbnNqNTkzT3JDYVB0a3ZDeVRtOWVJcERvQ1lv?=
 =?utf-8?B?bHBSenpNNVRRWTBiSE0yZjRKTFZrNDZGQ0Z3dkZWYkpEcmJKVmYzLzV6cmRI?=
 =?utf-8?B?eGxXcjY0K012RVZ5SVZtd0dHTjFucjNERTVLT0NZc3M0NTNkVklkQjhGZFo2?=
 =?utf-8?B?TzhRUGFGbjFLRVFDYjg5NzJiSFUxc2dUOUE4TXVNSDFvZmVNM1IrcTZzT3RW?=
 =?utf-8?B?VzlhZ294NStYeFFwZFdPS0hqS0NWWXNmMHFZd2JYRlJRSzYybmNDVzd5RTk3?=
 =?utf-8?B?bDVwS2hkL1dpWkd1L1o0WjlTdjhrZDMvUHFWbDdlQXA3NGVpKzZkWW4zenBJ?=
 =?utf-8?B?VzVzUWJkaFV4d0t2QmxLZkI1MDYvS1NLQ3pVeG9udEp3dVZnREk0dWIyaXdl?=
 =?utf-8?B?K2ZEMDBsRkl2RWpLR3ZaV1NqOVJpUFFiTFlDckRTekhJYk9hUW95aE0vcVBs?=
 =?utf-8?B?U1RhYm5Lb3Y2VHBEaFVEMTdEVzV6Q1ZNdWlVZ25CSUZVbjJFOVRZNEpnUCsx?=
 =?utf-8?B?eURNbGtDcTY1VjV2TnhIclVRNWs5SWFUMkZCNWg3VWR6Z2U5Z25aNG1ET2xQ?=
 =?utf-8?B?YWl0VlBBVWRSVUtKME90OGZyRFJTbHg4MHpKbFV1R3VYY004aldZUmJiM21F?=
 =?utf-8?B?R0dlOG5OOVNycml6d1hCdi9zcXVlWEJYRy9jT0FDZGhQNU10YjB4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1e91c3-62b2-414f-114b-08df2b7f56a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 12:16:42.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J53S6jW59b0QqoFmCFqJsMB6+24+fP8wR+Gp2wN9sYM+1RaIoOdIccv2M9qXeDBVshSsWi7kTWtlRaiTJvIM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375

Hi Mark,

On 10/16/2026 3:55 AM, Mark Brown wrote:
> On Wed, 14 Oct 2026 20:39:13 +0800, Weibin Liu wrote:
>> spi: amd: fix len==0 underflow and FIFO overflow
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4
> 
> Thanks!
> 

I sent review comments in parallel without seeing the apply mail - 
they're not a blocker, just a minor improvement.

The applied change is already memory-safe; the rx FIFO bound is just 
checked after amd_spi_execute_opcode(), so an oversized message drives 
one transaction before being rejected. Since the patch is applied, the 
change can be taken in a follow-up patch.


Thanks,
Krishna
