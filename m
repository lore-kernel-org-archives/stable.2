Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA449317173;
	Wed, 30 Sep 2026 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762344; cv=fail; b=NFK/UQ6ebVUHbYzUHIaVfUlzFajnSolvbGTdAarzYrR0YTAQxN/mv5SWEy27o2v/gUGVtAKRs+vHblwZmHdjAHKHFF0Q1Z9QOBX7otfsmuOsTYMgsm1P4sidPrhLIvpYQU1sFZZoPCfUetQdm9RJ2zjfZ+/FG7V5JUMaHhbOgd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762344; c=relaxed/simple;
	bh=7Qsju7Jprp/4kggu84KYQErncHTwO56nHkx0v8onAlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GtZsHlYCjznkhxfvUTEpmubr1Odi1JXN4tkN7JrPTY4aSCcPilmubb5fPja1GKzV8EFaFqbb5fxR0LOaIwErzxQbct/eDWnATqor2ok2o9QTRhhvPuuxyviw7bn77pew9eBlih5v9ckhZkXzUOSWbK2PGN97ALy2dHFSoEFr23k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wrht6u8Z; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wrht6u8Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyTSNFqYJkGStx3QxdKLUnuYY7IqBKJBfk2AlKsAS2zJ6pGKcFknpxKKhtuabx/kfyIZR7TM++cNTP9kAjh4yVgRwgYMVWl902PALiU4Ks1mwT93tOTJaevA7DMNFM/guX8PJXSf8p7B4Zfq5qDiwcwaljAB+IlN0WiKCSfZdttvbSvTFALL6kTSHotw7QWdimcg/2GtTF8TTBvhbsSUOK1NByI5uPtBVBlwh9Jw/d9iU87JPJHzWKHyrzG+VX2Oqwz2bXTgqLQ4BW/OM8HXOT+rCy3j8qxKwp+DIuLxhCJouc6/nnsqt1tRxydITn5LF+04k5JhlKJ5IafDKpVFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP+Ppcrp5fRcM5GfGQY+bDeLbYqLs2YACroxgyxTZ00=;
 b=U+CmzTAshAEA9s/cv895p/DkBA0fLgnU1q4i3I8NLtcmXKN7mhTP4ksuFj+uLwFZ5pJJpLJFWJP9yYUo523eAZfZWmE/hORR7SeorFCGHM2EZJvBFGET+aMoD26TAlbDDRtxSOCrEo8LLcojV1jctl8AWBtEkO+IY/1N3e6SBCqxsg7DKzEnyFIJv3GlCbk0efkQT8K/9+v/6eoFwN3iEmjL0Ge0VC5pmFdY5ann8XNcx/RR9jJVSHlaw+oUt/EnRHgUYdekIukZM+mE9qNlyNd1cRYYUIH+HMNvTaMPWJTpGUxkzdsZdL27pXMuwjo8vkb9Ep8CVDPZt5mBDaKZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP+Ppcrp5fRcM5GfGQY+bDeLbYqLs2YACroxgyxTZ00=;
 b=Wrht6u8ZgrTBbKe1nK0Wy2xwDobyoUbNFFtRU2QtMyLNBDbR3T/KKfc87SvcUu9f/6rPhmtZBKRrS6DNpJRraDvmquT7iIq4/P1vHXKftfUeWhv4Y8m8doeAy/iXlUQngBWaOfQbNzSJvevV8o8mgDye4jSSqHGwQK4CZBZSiN4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SJ5PPF816B88375.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:58:59 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 09:58:59 +0000
Message-ID: <214ea1d6-8b3a-4d8f-b0f2-e2f1de9d5632@amd.com>
Date: Wed, 30 Sep 2026 15:28:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Fix PCI device reference leak in
 iommu_call_iopf_notifier()
To: Wentao Liang <vulab@iscas.ac.cn>, iommu@lists.linux.dev
Cc: jgg@ziepe.ca, joro@8bytes.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, wei.huang2@amd.com,
 will@kernel.org, stable@vger.kernel.org
References: <20260916185804.2093996-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260916185804.2093996-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::18) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SJ5PPF816B88375:EE_
X-MS-Office365-Filtering-Correlation-Id: a526ade2-7e74-47b6-125b-08df1ed9730b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	N1EidKnwvO0kHfe335JClDG1vxFzPIKhPffcuQIjChzEqGkHz6zBqK8Fml35e8kSUOD43ZOT01x4mxjBzyYt/INL6K6XvxvzKBCmGL/aVW+/CU9C1kv9C56JloIFAASzPvxCA65Pj7l1t0FU/9RPc9zYYdIWV9b2vt74BpSbuvCfM/4JDCL9/1vB9A7u33Ot7NKEGpdf+WeHVz8w7MUdUz62zqTkOuQnAce3z42dud3+XEvzp6x0rt2quxFGSB7mioPh2BocvsrUeTnTa9HYOADOYk10+F35zEZ3gxX+ZQe6YnUIXXOubl/AKBTftwjQ9n4ly3uIUZQOO5AkDs3eojMJCJPuuoKqiiBT1fhwvcIhG+A5dBfLfSxgofaFEIbANb6EuPsw2PYlDJhGJXN8yNaBt7FAjrOInbHFhxht0cJDt1C7opivZLYINTj488AO2Gu3QGQTQuAhErmdv0zlQtEnlLeWnpcyDrPb+EDiQ2OG7FHbllEVYRPfPY/HwclgYGncGsLpQ32tzJAWR3SA0c/Xdgb9WIjQi6if8jwi09uZl98ET+5oOs6mO52IShZhr3T38MzDOxP9wVgM1D2wpgclYd/2bHU+dd99wIUAqDVZRfqSYT5gB0MM0ZuOF8GG0aKju+Dm+MqRFrumrLUM+tUHILimdaZllQYQ5UrmtXM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGd3MlpQbWFqWXZxVEd3RHQ2NndtemdualJZaDJvWU11emRLT0pMajdubndO?=
 =?utf-8?B?VDh6eTNKaFI5WHFuQmlMdDRiMjRvMnpEQzhKUmRqL1dlSitTZ1hoMHJNRjZa?=
 =?utf-8?B?bWxtdTJheXFZenVJcDNHK1pLQjNoU3l5QzBWSVA3YU1vUTRkVm56Q2ZTbVpE?=
 =?utf-8?B?T0gxUXpzcG5zQjRuS0RueXhnU0JsL2dBTVgyZm9odUh5b21NOWEwSlg0STFJ?=
 =?utf-8?B?WlpHOENYVGJRVy9pb0tnMDJ1RE1OQmZVRTdBZ3Rmdm42b2hLWkU5cGx3Wld2?=
 =?utf-8?B?RmJ5M21GVDAwS1lURjQveFJoQ0p5b2Z1N0NmQiswUkRQMGtBUWJqZGI4d01v?=
 =?utf-8?B?dUVDbkM3c0dOeFdPRG12T1QvNmNrMGQyQk9pM0NLbS9VVFhqZnZFUG5yZVJQ?=
 =?utf-8?B?RS96MDZOZlZEMWsxUzFKa2ozOExaTmpMUFZXVlV6b3RuRDFIdzBwSW51d0hT?=
 =?utf-8?B?aGFybmFWcEw5ejRQRWpOZnI5WDdadzREblpYRWRvQTI3TzMyckgxVzJ0WVhZ?=
 =?utf-8?B?M2hKaGZkSUFSTE1MNVVFQkUrNjRGTk1XeUNhSk9yR3I3SHE3blViUVJIMFh1?=
 =?utf-8?B?YzVqQ1BUMkZhdW5tcndrZE5QYy9rMERZRzRCcUF2VG9BaUtwdXpRKzd2N2dJ?=
 =?utf-8?B?UmplRUY5WHNkZ3VmSXlKczhDRkZad2J5eHlKTDR6VE84cEowM29SckJyckln?=
 =?utf-8?B?OXpXZkdqbWZYY0tLSUhkM05mY0g0RFZpSk5JZDl3SjhoNTZkUDdiRDljdG05?=
 =?utf-8?B?V0REK1hYYkx3OWdvVnBVVEpNYlUycXNwT0MvT1E4RlYvZGdoVFovODU3RXBN?=
 =?utf-8?B?TmE0Z3MwTytyRnEyL1Y3RENuQUFEVEdjZVJjT01yNHRScjFYVzdwa002TXZq?=
 =?utf-8?B?UnVZL0kxVU1ZcldOZ0l0SjN4TE9RaEVhWXp5ZEo0bDJZNm15TlJ1VjZ0S2Fi?=
 =?utf-8?B?bEh2Umd6eTZONkxmN2k2aFlFZ0dIY3VvL3hXWDFZZXhrQk10VUM4cVJRSFdM?=
 =?utf-8?B?aXpDeW9sQTVRUmJ2am1OTVZER2k1Nzd6c2tpRnBSdUtoendmNnBLQWxibW9h?=
 =?utf-8?B?Ly9GejZtQVQ3NWQyL1NxSlIyNVhxTkZzQ0pEbDRzVFIybXZoVDB6NDRrZk5P?=
 =?utf-8?B?WTNwUzJMNU92YU5xbTQxOFdoMEZvdHBRbFYvYWlYa2hXRzZFR3NkSVduY0lQ?=
 =?utf-8?B?ZUQzc0xqTnJoWTJVSEZncEtjTStkQ0tRN293QnNPekg2Ky9qNDJVZ2VpcVVR?=
 =?utf-8?B?Q2VQSjJCbW1OQVJ1TFVWMHJsL243TkNHTktiVC9ERmhVS2Z3R3poRVhGV3I2?=
 =?utf-8?B?SUJCMUVPMG5YK2xrRHl2bWxvbVhuVU41dVRYYmRXSkRqdnl4cE1uOXdwUlhM?=
 =?utf-8?B?QVN2YWVCQlJCWDRGdGJxNDRob0JmenRkTmRuUUl6SW80Slc2c3loM3NWeFhU?=
 =?utf-8?B?ajVFKzM2K293WHFIMXBRMTRtdjFrK3RnU2pyQWhPVElrU0RGRTlBRkVaVCtY?=
 =?utf-8?B?eE1UUXdYVGpyOWpMZ3hXMHpvK0RYbXBWM3hWZVIwK1NwVHlCVnVBMmh5RkdI?=
 =?utf-8?B?YXRTMWhnQ3Y1WlhxNlJsNzVSMnEzOXM0a3VMUjlHSTNnYXZURkp2MmxuTTdk?=
 =?utf-8?B?NlhHd21LbXVQU3Zzb200YWdyOXNnRklCcGtzdnpqWTEwYktndk5RYVNFMys4?=
 =?utf-8?B?bDZsd09CQmpncEFyTFFNUTcxVXZ0b2xwMG9mTmlQOTM0dTVWblZYWitYbE9n?=
 =?utf-8?B?MEQyUWZxck9UTlJNSDMvTlo2b3dYKzNmaGJIVmxGbjhrTTdlN3NOTVpkM2R3?=
 =?utf-8?B?a3U4dG5DUkpiS2NBY3JtZittWS9pamIyZlNqWkZIRWlaTXdRbXg3YkwxbWor?=
 =?utf-8?B?S0ozaUovdmphdHZWN1hrWUVubmRtbjJjZERnRDZPVlVHeHdsdDhKMzI4UnAz?=
 =?utf-8?B?NG9lN2ZSU211SSt2S1F3NnlPaktPRmQ0VTZQTmp1YXQvRmthdElIaTh2Rm1h?=
 =?utf-8?B?ZmQwbWVBTHhaSFl4bGk1d3lvWVF2NHNCTFRQaTVyaE82anl6dkpLVitoSld3?=
 =?utf-8?B?Yk0yZWw5UzV5dXZ1YmRLY0JUSmFPQXA0ejZpeU9yU3hQVkRHQUVqRWxMSTlx?=
 =?utf-8?B?bnBDUVU5UmIwM1V4cjVMNzlLN3VxSjJ3SVF2M2pYZTF5RmFPaGdaMWdFaUZT?=
 =?utf-8?B?LzBqR1ZSVmUxZ2pnVU5OM3QwQmQvMmpXM0FWM0t3VW5PcXRaYW85SXlqSXdX?=
 =?utf-8?B?RExObmFZclJLOWRoaUs5UVlVZktXZ083Rm0vN3Q3c3RIUGMzSVZxNUJKdi9J?=
 =?utf-8?B?ZTYzL1JnZHZLeFIyK0k2MDQ1TzhpMExEMCtXdmZXbU5uL1drYzU4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a526ade2-7e74-47b6-125b-08df1ed9730b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:58:59.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhX0SC41GTQJD6WFglYafjnt9Unq7yL7C6iTpljfm/5fjnk8c1f8jp4a2ZpdTjogM4G26qsU+jt7TmRVpXjgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF816B88375



On 9/17/2026 12:28 AM, Wentao Liang wrote:
> pci_get_domain_bus_and_slot() returns a PCI device with an elevated
> reference count, but iommu_call_iopf_notifier() never drops it, neither
> when the page request has been reported nor on the abort path.
> 
> Put the device reference on both exits.

Its already addressed by commit af3b69b16383.

-Vasant

