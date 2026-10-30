Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793365511;
	b=ufCP9O8mb7fdC8Z70BLGNFPDHK+m/SRbdvZbk/o1hZpDfdK6qj3DGbNDh+GT9mRTEi4Z
	 +Aeu3TXEm0YcraXX/oythbNglgvY9bGrazCxDusJkkRG98g2QeVGvYa/Tn17NIdn0xHWr
	 DjcFhJzf4zCedKJZR3xG5Clf/NiXJ+PW+1StPle5fccDupKuM8AzZWCEH5GOaWyIV/K4i
	 WduQ88T1ocEAZcgdyhAbcFyQN9XX4k4xwQTNErnSATEPiMKBnLl4WsOifpZm/lMBk7jFE
	 vNatEu0lLLr2y+CgmXu9Ya7sT1VM3yvQXD6b7/NY0jCAoEGVLzGaor3xuQeAo7DH92A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365511;
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
	bh=KloRoCarfZauClUR0Avxh7Gc7iacwCDguU4le4efiSg=;
	b=kHHsPBXfQj/P2kaH++4hTkzim/GY3QzfOLLuo1UDdf1CVJznrYdLnDP1hCz1Tgx1MFbt
	 WJ2eevoBfOgRU4hjnemdARkb1m2QFGsKxhIbas2eGaSU7G1qJ5asD0Dl9i4o7vJYdMzGp
	 BjN4uRBL5LbLJM7JoKnUHR7Vz6w7KXOEWRYlHdF6u/Ig5oo6qI5A//DScEzeBTVecKMUC
	 8t64NHlBShRPS9UuvjBJgQYR+n+lpsLSJCIUCdwMZRdbT7bnUW3k9neH9L6nj02vwS+wp
	 SUEzPRG4JP4vgy7SDypPS/Ov3Mcuf7w3OhPGVg0tIYO4C4eJS8fTCavQ0N5lVSLH0Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ez9bRo+7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.0
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D57606A31A;
	Fri, 30 Oct 2026 13:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81D57606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ez9bRo+7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jqhj4Anl+ldeHPCmTYM7nedz5ZN66cwP9EEIOR8N1oXqcrLng3j7GWr/dWvKdj5Pp3yak0BvqOZ0ZppeIlAIa8CV76Yflp3XueXEABDyrwHtBSMivqKORaFnOsS9BxS9vy2tFz+iwKGgIWCNtRbVLL3isH8amgF4toNT/c/QINjvh0ayhzQxLs8roZS7vCJTU6sPbZ0QYI4ta0zTTiBaavyvf+ejcRni0o1bxCwTS/6mupC1iDNQ3j/Ly2WDCsGBYvEFIBgsi9GIA4u1NhTbetE3eLFWsnq18bUYVuIDVyVpNtMSibnOkKOVCMlxx+8aRDpMlLhs+I3sF2sJLNF3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KloRoCarfZauClUR0Avxh7Gc7iacwCDguU4le4efiSg=;
 b=nI9nz+OLFxonGgz26ARgrPt+azjWkGUCl4ra8YyLYHlYGz1VIudIJMYnJM/0qQpJufskA6wydgXAP+rR3fRFPabrXd0iST0QE5hpdr7MZ+y78yEC49iajUxapf32Jqi8iEBXXiAkT4crqLuALtDnxEBZSxjLugQkfhIFb6XPS0t/gdCuQoQav+flIClHNdWi+RbicWe5N+xQkfUd0gSlZfye2+b/djIWHxsCqyaUQB0Tx1yxFbhEkfVHEY5aHU0Sdcl7PWpks6MmOjAd0SaBr6cqFL2yBsQmNDsSk0a4wCo3Zd0erWcylGd01bAtbeKt0I3uRdyLlVjJr+XfZFYaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KloRoCarfZauClUR0Avxh7Gc7iacwCDguU4le4efiSg=;
 b=ez9bRo+7vialbxffR5syBGdwR9N7lF5Ji7deLVWTYg01gog5nYk4u5WLyTGf8AkReStVjxbcLu2t9PhjwYXK50La2Y5cN2NVS+aYdHmVWY1wtwOz3ow10LrnsXl6vN6dJu4Jb9hPuNpnzlT4ZIQC7UDsXQ+knTj2CmwYm/fdn2A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 13:05:07 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 13:05:07 +0000
Message-ID: <72d9422e-0289-4412-ad79-a209b9519624@amd.com>
Date: Fri, 30 Oct 2026 18:34:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/21] soundwire: amd: Check for NULL manager drvdata in
 sdw_amd_startup()
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <Mario.Limonciello@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-13-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-13-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0056.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::14) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: b167354f-4db4-4756-15ce-08df36866b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|921020|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	+mrrwWk9mEW6PapO9XIdAXBnwePiNVrWf7MCr0sY0RJ972zK3zCETcvGTR7CsvA9mnBRSKhdcbOY67M8nOOOm1vGxkbvIedFunpGhEVh3gFBKadrrz4NFU0rOXDXdTZsk0OzGSY/0vAE5ZbdUcjsxq/JS4IeIwEXq7S4K4beBkI2LOCvkUM+cuKda7/Az6zP7za78rXvWmSFE08I31SPuneEyUmosFJHCcTRKmPidZSntkEY15IzY3rrhzXB6M84vUFTxuVd1VLd39ogylA/zFrKrb16J7Ulevj69oRaSyXtRiG6JGyMJvwCTM1h3qRH5elNNGrx6f2slo0cojzaz3kS6NZHJokVxNVRph/138gkjoFeJitIhGmegBHuKUTcyBGi2PSSufA8KouZDCge6pyGol6ZUYZvtFbn3DO7YQQ6CD+QvUtPCNADdc60/c+rjN1vgrLYXp1DbsPcDbcjp1zPz0XMWVRkhTWHFR9KWSNOrJPewd+KogUUdB86fzsCNhKwp7p2gah9YLOsO2x1DGcIhr6EM2ZuCqOMsNXTDJ3SoA2Cx8nxoKufp7kIJ548VJaMfaMZDIQdvHefAcGCbsabFpMXoJ9fH6aVZc9+c6z0yvLGO4w2Xl4PM+6zIpBD+sCFE8vcUJTnqfGLPwcVWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXBrMkw4QTFNTVZwa1ZkYUhrbkFVci8xY20vT2xoMEZkSE5kbFZDbWpLUDZR?=
 =?utf-8?B?L0JhTENWQVl0R2JTT21HS2pBRWxETWx3amFLRHJjUzFBeFpOZ0FIUCtpQ2tU?=
 =?utf-8?B?RlliR0lNa2tXODJsMm92amVTcVA0dkpndWh3RExoWUxNSm1yMXlCWW94ZGR0?=
 =?utf-8?B?aDVaZlRrWEgvdi9nZEYvUUhJV0ppUWlsZEFxV1ZzcnVaTzNUWUNIMDAzZm1r?=
 =?utf-8?B?RHZYVndwWHg2N0JhcUMyTDQvVzJ4TkZLb2pBRXNsWVM5TEl6YkxmUFlZRGJ2?=
 =?utf-8?B?ZWNIZXBJczdhOVNYSDZiNGlJVUdiZjdSTm9DVUJVWGVjaGY1MElkUnFsaktZ?=
 =?utf-8?B?VFNkb0pZREQyblgxaFpzaFhOSm9wZXFFaVVkNmNTY21IRE5pNVZPUEJORG5F?=
 =?utf-8?B?YklVcXJmUmxadXEvcmdaZGx2bFJCNEFEODY3Vm5xMGRoZ015eUtMa2Z5dlZx?=
 =?utf-8?B?bERmcm9kNWErODUzeW5Fd0hPeVAvT21FNUN3WktoUDZjL1VmNzJBcmg5c3M2?=
 =?utf-8?B?OG5RT1VhZGVRb08xT2JBUkNUMUFmdzRVRkgyemdDeHdYRExQVUlrZ1RZNTQ1?=
 =?utf-8?B?b1NEL3RYK1RTRGV0c3h2eDJEdkJuS1NaVUpHaW5DSkR4SmRVM0tBcVhvZlla?=
 =?utf-8?B?aW5pTm1mcVdmajVMT3VWbjBmV2NjYmszbkhSbUVMZzNqOFQ1cWthcXNVa1Y5?=
 =?utf-8?B?Z1g4Uis5ejErU2lKRUdFMW45WWFNaHByMWMxQlo2VW5ORC9GUG0vNnB1OVNV?=
 =?utf-8?B?YW5uaE5sZWUyMC9IRFBVc0h3Y1pPcnRQNC9VL1hqNGI2MTFKMmxDT2tGS2ow?=
 =?utf-8?B?RlB1OUg0dnRXcGdEc3h5U0ZGTXZEUyt1WlZOYWVYL3VpL0xUaUFVZGN2S1NG?=
 =?utf-8?B?Z1o0RGZEV3Q5dHd3TXM1Z2tRcUROT1ljUGNOUFUyYURmQmJMbU5IOUI5blFj?=
 =?utf-8?B?L3hudlFMZ1J3MkZFNkl4VVM1Wnk5M2xJZG9oZ3lUdjBxUFhuQnFpQXYvUEtz?=
 =?utf-8?B?UCtOUWsyQUxTUllOUjZLaldtTDRaTVZ0dytlK0hVeks3dE83MjRGbXVHYjhj?=
 =?utf-8?B?bmM4NlJidHJjVnpqNjhUa3E4NmxnQzFNbVdaQUM0N0dDWk5vczkyT3FnRElU?=
 =?utf-8?B?NlhVVmNjUVVNTnRUb29TTnJIOXpTUWY2cVFMbFM3bXFWSDZTVXd6WWFNeW9j?=
 =?utf-8?B?L2lBWVBsaDFwVUZxSml2bVR0cDErK3gvWS9kZkg1Q3phRytmNjY3Qmc0Y2R0?=
 =?utf-8?B?ZTFHTjdSUEIvTkZFS2tMV0R3RkUxVzNFZGNVUlVxa0htVWFLUTB0ZDBhS0ZT?=
 =?utf-8?B?dWlMVkpxZ2RMR2c1TTNMRllkODRmQmNIV3BKeXN6SDc3eDNxOE5nUDhWMnlJ?=
 =?utf-8?B?emNPSHBnell4TlN3UVZHSE14SXNRNG1lVjh5ek1ya0FUZURJblhuU2kxUnJt?=
 =?utf-8?B?N3o5VWVqZ0NjS2dZQU52czF5Y0hvMDlCWkNXWE9zSGRTUDFSa3FLQmphQWxV?=
 =?utf-8?B?U2FuL0ExSy9FTHVsOVI1bFJPZTZQRUdiaEJrZEdvQXRUYUFZVkQ1eXlNVHJi?=
 =?utf-8?B?YmpqTm9kUThsY3RXY1QwN3U4ZVZ3MmtDYk83dnFDeFRUQ0xuZG5WdC9iN1FM?=
 =?utf-8?B?NFBDa0QzZ1ZZSzM5U0U2UTI2dVFsU1hoUjJLR0lIMHN6NlF2bzBzeDFoNE9W?=
 =?utf-8?B?N1ZZTThGa3prbnhaWG8vM0lnVW1aWUkxczNNc3JGSnE4VFg0ZkpCV3lsOWVG?=
 =?utf-8?B?cXZJOU5CK2NqbTZkZGFOMzM0K3cya25Rdjl3aStndEVhdUdIMUYycEtCNi9Y?=
 =?utf-8?B?OHhTeGtSbHRTNGJ3MHNLb3FmMmhFWjU4VnAycGN6R21lK0ZtWFlndGZnMmhQ?=
 =?utf-8?B?amwvWjVuRXNQUjhUS3hCa0d0OCtxYTNxZGZ0L003U2ttbmk4SjNJMHFTcTBW?=
 =?utf-8?B?UEFaTzBZTzdKYm9HQWRGM3M4YWc1bkFNNWFiSzJiaW5rc1E0ejN6YklPZnl2?=
 =?utf-8?B?Tkg5NFZ3K2JQL0ZkTmdtQlFSaUdpckdsYmdwdnV0WHVpSmRNamxIZytmS3JJ?=
 =?utf-8?B?NlJkQ3JpZ25Bc3haYXJVRm04aU03MjFURkJkV21RUUtwbnN3S2djaXFPVUF1?=
 =?utf-8?B?STdDdFlPckxzV294M2JET2ZoaWJ6RHVRUm9XOWNBSWx5MnBJNFVVMG1Zb000?=
 =?utf-8?B?byt0TFhsQ0IzTzVqN0orbldha0xoOTF1UVZPaUhuZHlyYlU3cUY0eWVhRVNy?=
 =?utf-8?B?aW1Sb1Q1RWtjLzREN2g0RG0raU8vQWdaclNYUXdYSXRheU94dldWbDAraEx1?=
 =?utf-8?B?dUJ6dTdXZmFXVjlhRGtHRnFReG5DSTFEL2FpVVZHTDM1QUtSdkc2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b167354f-4db4-4756-15ce-08df36866b81
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 13:05:07.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p4ezd9aaY3U0pTY0tpS2POzyJdtPjJfzGOdETfKn94LO5BDT+Virrf8QhFBUGWf9358kts+kOW6NeSTChYXYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028



On 10/30/26 16:16, Lee Jones wrote:
> [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> If amd_sdw_manager_probe() fails or defers when registering a SoundWire
> manager platform device, dev_get_drvdata(&ctx->pdev[i]->dev) returns
> NULL.  sdw_amd_startup() passes this pointer directly to
> amd_sdw_manager_start(), which dereferences it unconditionally.
>
> Return -ENODEV in sdw_amd_startup() if dev_get_drvdata() returns NULL,
> matching sdw_amd_get_slave_info(), and clean up the allocated context
> and platform devices via sdw_amd_exit() if sdw_amd_startup() fails in
> sdw_amd_probe().

The sdw_amd_probe() cleanup fix — calling sdw_amd_exit() and
nulling *sdw_ctx on sdw_amd_startup() failure — is already
addressed in our v3 patch series posted for upstream review:

https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-Vijendar.Mukunda@amd.com/T/#u

The NULL check in sdw_amd_startup() is a valid observation and
will be addressed in our upcoming v4 patch series. Please hold
this patch until v4 is on-list to avoid conflicts.

>
> Fixes: ed5e8741b8db ("soundwire: amd: refactor amd soundwire manager device node creation")
> Closes: https://sashiko.dev/#/bug/linux-6834a8a0-632f-4c73-9174-0fe7e06b5303
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_init.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
> index 8e419ddfa516..adf410fafb7e 100644
> --- a/drivers/soundwire/amd_init.c
> +++ b/drivers/soundwire/amd_init.c
> @@ -156,6 +156,8 @@ static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
>                  if (!(ctx->link_mask & BIT(i)))
>                          continue;
>                  amd_manager = dev_get_drvdata(&ctx->pdev[i]->dev);
> +               if (!amd_manager)
> +                       return -ENODEV;
>                  ret = amd_sdw_manager_start(amd_manager);
>                  if (ret)
>                          return ret;
> @@ -166,11 +168,20 @@ static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
>
>   int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **sdw_ctx)
>   {
> +       int ret;
> +
>          *sdw_ctx = sdw_amd_probe_controller(res);
>          if (!*sdw_ctx)
>                  return -ENODEV;
>
> -       return sdw_amd_startup(*sdw_ctx);
> +       ret = sdw_amd_startup(*sdw_ctx);
> +       if (ret) {
> +               sdw_amd_exit(*sdw_ctx);
> +               *sdw_ctx = NULL;
> +               return ret;
> +       }
> +
> +       return 0;
>   }
>   EXPORT_SYMBOL_NS(sdw_amd_probe, "SOUNDWIRE_AMD_INIT");
>
> --
> 2.56.0.317.g454f8302e1-goog

