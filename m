Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEDB48423D;
	Mon, 21 Sep 2026 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988678; cv=fail; b=QjjWs0zKOLXY9NSjyO5DKP+ioHqsUadHrWVzu6AkeWtWjECQNiawouY4iPZs5IvQdBy+hOf8fpP3fATfpABw8I9Ztutf/0Yk6qbst08OLXDHL5uA45P2fKNqdxyg4e4R/EGDp+9OPZWN8e96Q+3OB0hqx68J91iSS0dDZqm/zqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988678; c=relaxed/simple;
	bh=ZiRhdNsZ6WN0jMx7II39PhHyjImuFnxakhPqhxSIAbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UwEc2Dxjx78KU4bkEnpcEYhzHi/Sl3L+4RyqjjvRjMQbfKNIRJji16I3XdFyUDHr/flzK1lc3rXSfLnQfMSaiALzO0gBEG0qhOQz7ZgkeoPfMARM6B3TS0XTf99ARByRiosKDY+pWZdJKebAaX8A5B/pRmAVhX3sUzuC2FjtSIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bNlpy09W; arc=fail smtp.client-ip=52.101.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bNlpy09W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsHtz7D/kUqSn2z5i73S9XxeGCU83l5qlHm/EGFLObXIgPiPoTqoCLPW/EQtYi6NV8011gihN3L5nibTMobB9GLSYbiyAHj5yptI2RwqZSuttNB3OKO9F8wr1bb2s6GTsBH/cp67ZlvetYaFRWRNfJ/xCbLAFuTanhjZmFq3nRP7fi86qj/hh0577cp2YHGH19OCsJVOmSIWna/KLJnRu+NPUH2aqGZhzurRpYztvgTR5+xcigmn8lbNiaqaNSiBHxk/N8ZfoMWwwtplvAFHfw2rehcoFP4o2BGssM4qcN77LOY7/XV+JiuTauizH3vtghp2yk5lNOo1DFdfn9N8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zycuNWg4I5dbrPOsCuB6+uAJSXb1WB3KhkEbsAj3zI=;
 b=qRf4BkP65wnYiHl/ZgZwTjvRvOUBJfV0kE0k3EKky8+FuzaUGTDoGNfEaHFUmTvQ1QlR7ClPHAjAEVgjsS3ZEVfvhdhp20bDUOpaFfLq5eapprTxN14R3yGUpf/kBisPdfGN1LJ8/SatBt6kjM2VgiW67lX99wnl2k+gV95DkXblgwqgWSwBYbUfSbyDi2725O7DIUt2hWYOfjJwy5qvr5GmpU0rpC6aJ0B8CZuMrdED1Ud0YwPBK8Oy+GuW9odVhWpCmJU/LMn06gKmKguBT/7Zk28WNZmiI2oyRmfepcHshv++QGq2oI/lCQamIcQ+54J8nZUy6XRdaCETdaxpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zycuNWg4I5dbrPOsCuB6+uAJSXb1WB3KhkEbsAj3zI=;
 b=bNlpy09W7sVY+mDhEDzzqIuzEw4GBEqJs5VE+RvAnYBX3jW3ucAQ7b4BT13tc4BXeOzf+jfrTOJLKzTYT9UpY2LWF3K/K9oUqxgewlrDbgNmXG57fAlrkDk0FzSBbs43XnbpvmY9UZYRN1juo2IVF77JaZC7WC6MuW4IHxQ0KzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7)
 by CHBPR12MB463627.namprd12.prod.outlook.com (2603:10b6:610:36c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:04:29 +0000
Received: from DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2]) by DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:04:28 +0000
Message-ID: <e7708479-1e9f-45a2-878a-cd857d5468d5@amd.com>
Date: Mon, 21 Sep 2026 13:04:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Accept AtomicOps already enabled by the
 hypervisor
To: Bjorn Helgaas <helgaas@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Nikola Prica <nikprica@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jerry.jiang@amd.com, haijun.chang@amd.com,
 andy.zhang@amd.com, jim.chow@broadcom.com, matthew.mcclure@broadcom.com,
 gbayer@linux.ibm.com
References: <20260918170735.GA1162623@bhelgaas>
Content-Language: en-US
From: "Prica, Nikola" <nikola.prica@amd.com>
In-Reply-To: <20260918170735.GA1162623@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0063.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::18) To DSWPR12MB999127.namprd12.prod.outlook.com
 (2603:10b6:8:36c::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSWPR12MB999127:EE_|CHBPR12MB463627:EE_
X-MS-Office365-Filtering-Correlation-Id: b221254f-2b64-46cd-2c44-08df17d01b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	4IrzTR62WjhyJhLSn2q8BmvSa3x3h3fcsIwUXkB7Kgpt0JOi0+wjUQQhlwE1Ijsb4s6jfTR07oXtdSa3eBangVwMCZiURtj9W5kHnO+Tkd4REHiTdWPuuaLKm1QuooXrXr9dy44ZzOWCEm/pydrHTnG0lyFH2fQ3/zkPU/BQ9w3wfSl40cTWiZG2iRNCdqShth/igq2WGjlAz8BxKbW3jpIGjU6e7u9chd4GFjfwLpLBX9w4aB2nv8UF2/nunEbDH9SZ31AjjYuly+56mPvpiPRtZdMDHX2xhRvQUK/qtewT9MzMDoWIIBtxDUF8eQgN3ry0H2O2YvFbW11esIglee8OUPF18+nKZ0+x4EVSjWlWN6XBjj4FAubqrZRoIBzF7go0oAAH7PAMTQJPwUv6zeEnDL5matWZMXGY2hHq/2Wh+80WcKjPZ+bHozgkY3/8tvdIA57vFqcg2MXnbQA4wtYwC6/8mLzVwF+rutvhs5GpoAZrQ3Q4I1Bz8YYxJCATGPZdxruTMIRtqhQOa35YftmFZKzPs/Q0xKCnGOvU49vspiDxwzwtuVOCOTw9H5a/WqILaEm7GtBZUCpwkV+3JPQnZYNuUwc95SLMJ2CqABs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR12MB999127.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3phSkhjQ1hYNXlEdk8rMWhzc3Z4dXBNdGN3SnlWSE5rdTZrWmZUczhqbGdP?=
 =?utf-8?B?Q2JSVUkrNGZhSlBRRTVEZlZhNWR2U3lDZXRjL0s0eDJ4bUJya0xIVTBadndO?=
 =?utf-8?B?ZVpzc2cxb0RQaWVWTVRCby9RY3J6Vmc5YUtkOHBmTGkrd0pjWE1jTlNrekpW?=
 =?utf-8?B?bEE1TVVXcmF3aUpsdWdmcDJvdCtabHZnQm1ZaUF2RituUjBMSzduQnk4NlU3?=
 =?utf-8?B?V3VlL1ErTjY0NUU3SmhZN0p1Nm81RWhBQzQ5YjB2S2JNU2dlTFdTZllyMjRo?=
 =?utf-8?B?ZEp6V3ZOcHpCcjBIdyt5NnBoUHFtMmdIWnFFbEQ2Q2lDcGIwT3hiV1pUbVl6?=
 =?utf-8?B?M05xL1RQWUlNRW5zK0RMbjcwdFoybmp0ZWtJMFFZVUc1b1VWcjZDdFFXUHhw?=
 =?utf-8?B?Nm1hdmNQWjUzK25FT25DMy82REVnSXZoSnQvVjYzeXBubHZqVzZWYVkyMTlC?=
 =?utf-8?B?bDR0SVBoM0FpS1lkbnVOZUlRMEFOL0VqZnRIR3I2ejZnSE1GY0p3dHFnYjlv?=
 =?utf-8?B?YW1sbUNMNHIzcFI1NEl0cnQvdmFRMFdwQlVtOFFEV09tSTNlZ3dWajlGd1Vj?=
 =?utf-8?B?Y0sydlJRMDZDUDQ0ZSt5OGlHN2JEWC9lQ2xleGJnU1hPM2xZNDZMd3NNZ3lk?=
 =?utf-8?B?S3BhQWV6QWw4MUM1VmdxSDdrWVRQZDJUdzRzQVY0MHdManJGVWVMUE5WaFhE?=
 =?utf-8?B?dXYwdkp0cjB2TitCbXExZFlWRWJDVHVSZjhsRy90anpoNnY4dnNHZ2V2MFVL?=
 =?utf-8?B?ZGYyZEh5QThYOGNFNmhSU1docC9YZGZmOGVSbG5nUmJLZzRid2xid09OQjNY?=
 =?utf-8?B?WGNabk1RNVptanliTjNLWlMzU3BON3FZOXpGd0c2SzZjNVVsc3FVYm56dzRC?=
 =?utf-8?B?KzJyUnlhQXpTbGNhOU9BUnNPK2pQa1k5OFBkVElETWF5aEhPRThpUE12M1o0?=
 =?utf-8?B?djdJSkRzei9leVVtTmt4YU9Ua1QwRUsxOWZlR1dtQy9SWmxMamQvVUZjcFF5?=
 =?utf-8?B?Qk91SHhNd2laZUhWQXN2STk1c2t2T1BjS3FxZngyMHErSkNOZU1hZXlDR0xE?=
 =?utf-8?B?bmRYblNCOFdiT0ZuU0hUdE9nU3JwVnYvS3VpWTdreVFuYzBObXB2Y2M1d1FC?=
 =?utf-8?B?cDkyNVd6dVN5dDlVQm1JVmpYYStXWktVMEtIQ3BwTUNGc2J2ak16WVVuWTQx?=
 =?utf-8?B?RDdSV0VCQTF3S0xnaXBNbk1tc3lETXROS01TL0pUNkh1QkJEQW1xaGRNVWhT?=
 =?utf-8?B?dTdyeXFETS9oNzZxeW9FTGdDTmNGcFArNldhRUV1RHpWenpPTUVQMllQWWJR?=
 =?utf-8?B?ditxdzdTZ3dRcUtUaTVxZlFKWndUTmcvOVYySFlhM0ZUemljOGNLcUxqVXFC?=
 =?utf-8?B?djJLVVpoMEYrUEFGU29iK0VDZitqa2JKWmZ3RENSdlB1NUs0T084cklNZW5K?=
 =?utf-8?B?V3RQd0s4WDdFWTN0S3V2b0wxWXNJSXRMVVFKQ2pWMDRtNVhTUlpTR0JBaHE1?=
 =?utf-8?B?UlJ5Ri9NVklnL0drNy9CWVZKazE4aENiNE8wdjlVL3JnK0VCa0J5VHF1d0lL?=
 =?utf-8?B?dWRDOGJZSndpOHdFVlBuRFZqM3QzWnlBZ1V0TXl0dFhKNXMrYk0vYUZLb2Ns?=
 =?utf-8?B?ei9ocWhicmdOWW9LaXB5ckZ5T0dWdjI0aFFhMjNzM3pGWjNrZUVKOHR3ZWNv?=
 =?utf-8?B?T0NkODJHM3dZUVh4ekpqdjg1dGFrRVBPbUVMTGlFYzFmY1FmNGRaZTA1WGtz?=
 =?utf-8?B?bnkzcFhicmlDaXY1QVplOFE4ck9VQjk5WnpYSi9uVmtvSlhrU0hkY2RDRlZ6?=
 =?utf-8?B?SDZOUXJrUFhRZThaRGFPZDkyT2Y3QWR2VlU5YjBaenRIRHplSGFUSXcxR2hF?=
 =?utf-8?B?YlFNa3ZYUGpNcjA1bUxOVExGL0YyWUZxSEdlRVFhZUk3QjU4RFZaRjNTK2hs?=
 =?utf-8?B?NXZNR0lIL1lIcXh6dzcvK3ZqSE90L1FaT2hSTFV3Mnk0UUpPZVptcjh4bnhG?=
 =?utf-8?B?bVdzVFNtUURNVThmclM5U3hyaXl6cUw4MFViTHdyM3R6ZDY0aStkOHM0eXp2?=
 =?utf-8?B?aG1LakNKb2VwRFRDUTc5aE1RNkdYRWxxaGMydE04djJyV0FSZk0zcnVVOHR6?=
 =?utf-8?B?REdLVXVVWEtjdEIrbm53SkRqWk9SdGx1bTBpNEwwYkFIcU1Ed0I0dFFKbW1S?=
 =?utf-8?B?aENsRjRBVktwWHJmdVJwVFcrbGY1a01Pbmd0RTFhWGdLVCtqTk5XRU0xVjRw?=
 =?utf-8?B?T0FSQUpvdjYxUHpWK1lDcGlsVitBTGNkV1FTQjJqbllYSXdDTnlMaDhqSzAw?=
 =?utf-8?B?OEJlNkVJUmNPZTVvYVVyZUw5RXc2ci9GWDk3dkpmQmN1ejZaV2JNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b221254f-2b64-46cd-2c44-08df17d01b2e
X-MS-Exchange-CrossTenant-AuthSource: DSWPR12MB999127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:04:28.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjjL0whdJ6XOCctr4pqsVEEhztO1XgLC2vwv26DorrKATGa7FWCcLb+HqMNQyc3jT5qS3RzhAfmw5YXCLUlMWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB463627

On 9/18/2026 7:07 PM, Bjorn Helgaas wrote:
> On Fri, Sep 18, 2026 at 02:07:46PM +0200, Christian König wrote:
>> On 9/18/26 11:28, Nikola Prica wrote:
>>> From: Nikola Prica <nikola.prica@amd.com>
>>>
>>> pci_enable_atomic_ops_to_root() currently fails when no Root Port is
>>> visible. That is common in passthrough guests (ESXi, Hyper-V): the
>>> endpoint is assigned to the VM, but the guest topology has no Root
>>> Port above it.
>>>
>>> In those setups the hypervisor may already have enabled AtomicOp
>>> Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
>>> treat AtomicOps as already enabled and return success instead of
>>> failing the Root Port walk.
>>>
>>> Fixes: 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports them")
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
>>> Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
>>> Signed-off-by: Nikola Prica <nikola.prica@amd.com>
>>
>> CC: stable@vger.kernel.org # 7.1+
>>
>> Bjorn do you want to pick that up? Alternative I can push it through
>> drm-misc-fixes.
>>
>> Initially I thought that this is a new feature, but it turned out to
>> be an regression and we need to get it fixed ASAP.
> 
> Let me just talk through this to make sure I understand it:
> 
> Prior to 1ae8c4ce1570, pci_enable_atomic_ops_to_root() enabled
> PCI_EXP_DEVCTL2_ATOMIC_REQ unless a switch port didn't support
> AtomicOp routing, a switch upstream port blocked AtomicOp egress, or a
> Root Port didn't support the requested sizes.
> 

To be technically correct, some hypervisors do not allow guest VM to
set the PCI_EXP_DEVCTL2_ATOMIC_REQ. So there were cases where this
set command didn't get through. But drivers relied on return value
of pci_enable_atomic_ops_to_root(). It may be good to read it back
to make sure that set went through.

> 1ae8c4ce1570 added the requirement that the Root Port be visible,
> which fixed an s390 case where pci_enable_atomic_ops_to_root() enabled
> AtomicOps when the Root Port did not support them but was not visible
> to the kernel.
> 
> IIUC the regression is on systems where the Root Port is not visible
> but *does* support AtomicOps.  Prior to 1ae8c4ce1570, we would have
> enabled AtomicOps in the endpoint and returned success.  After
> 1ae8c4ce1570, we return -EINVAL because we can't see the Root Port to
> verify its support, so the driver thinks it can't use AtomicOps.
> 
> This patch fixes the regression by assuming that if we can't see the
> Root Port but the endpoint already has AtomicOps enabled, the
> hypervisor or host kernel that *can* see the Root Port has already
> verified its AtomicOps support, so all we have to do is return success
> so the driver can use them.
> 
> I'm happy to merge this for v7.3, and I think we should add something
> like this to the commit log to make it clear that it's a regression
> worthy of a post-merge window fix:
> 
>    After 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port
>    supports them"), pci_enable_atomic_ops_to_root() always fails if the
>    Root Port is not visible.  On systems where the Root Port is not
>    visible but *does* support AtomicOps, this is a regression: prior to
>    1ae8c4ce1570, it enabled AtomicOps in the endpoint and returned
>    success.
> 
> Is there any problem report for the regression?  I don't see anything
> at https://linux-regtracking.leemhuis.info/regzbot/mainline/, so my
> guess is no.
> 

Yes. That is correct. I'll send new v4 patch with updated commit log
that appends your suggestion.


This patch fixes a regression introduced in v7.0-rc1-2-g1ae8c4ce1570.

#regzbot introduced: 1ae8c4ce1570
#regzbot title: Breaks atomics operations for headless passthrough devices


Hope that this will be enough to mark it as regression. If not please let
me know.

One more question though, we encountered this issue with 6.8.0-138-generic
kernel, we figured out the regression point is 6.8.0-135-generic. Since our
validation teams are using older kernels too, is it safe to assume that
fix will be backported in new release for 6.8.0-*-generic version?

Regards,
Nikola


>>> ---
>>> v3: Add Fixes tag
>>> v2: Be more strict and only apply logic in headless device case.
>>> ---
>>>   drivers/pci/pci.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index b2879a6be5f8..62729ade496f 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>>   	}
>>>   
>>>   	root = pcie_find_root_port(dev);
>>> -	if (!root)
>>> +	if (!root) {
>>> +		/*
>>> +		 * A hypervisor may expose a headless topology with no
>>> +		 * visible root port.  If it has already set AtomicOp
>>> +		 * Requester Enable, there is nothing more to do.
>>> +		 */
>>> +		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
>>> +		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
>>> +			return 0;
>>> +
>>>   		return -EINVAL;
>>> +	}
>>>   
>>>   	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>>>   	if ((cap & cap_mask) != cap_mask)
>>

