Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F88548EC83;
	Mon, 21 Sep 2026 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988753; cv=fail; b=X9PN1w8GeCkn41462eumVww7E7KQjbaz9Cd4Q3bZ507QvzYf0b5gBhjVzS/pidOlfke3YNlqbM44fLgyvfMgGvXTSjUfOJa2gm0BK4bzqNocQL4uBNyu6g5aCfPCf2tX7U8vw8gC0SSkK/pA8guTkHr60IQ0mRdaVqKMjTAwRC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988753; c=relaxed/simple;
	bh=djJHD9BUkeDfQxDyAfL+U643heatsykrlvMwv9JiQ40=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=urt+WAiE2PG16k8bPFT8UMdOdBKVkTm8b19fY76x+jCg/DlwBDDV39PG+I11B1+BQ78Bv5RX9WMqy0QMofuq7FwZkZ67NJozqRh87dypl4eZ6izGWgvwUMs8dx/D+dxcXgUvixk0+V+bU96kWO/xnu9Ps/482qrMtNUPj4mED6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oS5DK+yg; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oS5DK+yg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwhHNsB8hyo8RFxbeENM48ibWON6BOE6L4W0i+tD9W5ar1RMOLgElxBEk6K9GuSLniQGyew2kSMs4NtAw+RtiNLFGnyg9a/U4lIg4pGVA6lTAf8By3FLmg47eMjpuUd3b2oZSv8AN4wfZ3r3aUqc+uGXtvn/J3Fz8CelPritjGNOqrADWYhTzzp4uaawCSF/45ezZPbabWsDUp0UEYZ2w4zmRZFmQsxKZ/eUxtxWPoL/Ij/BGlzDAszyMkorXY+LovjawMVqnUlvOiAXHVu5opOhVJJ6F3Vzu2dhxypdH49ZpYu4j1fvcLev+eZ+yQ8J9eTgaMdsRA0w81ASAxANJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDirGNLUbqlhnbBnK0kK+bV6fcy8djBIPmkWTIiIwzw=;
 b=GGZXb8M0JtZIpkYdpUgiCfHj23R6bPDu0Svj1NfcAjKs3yBZaLzTqBGjpHN1lCrtJ3xJYKaxeMWRYMzbuMb7XohWLqp3HU/fKQbyJZCmEIxseNLFBHMl3l03CHnI6B7OHJE+ZEyOoPNnR21ghjOZXSrCI9U0pPksEOqyceoqFaJNGMwfUaXBekN9xxP/OHcw55KSw4wX5kNz+YGNeVayr6LQfVAs3LsFgEYgcFQwxHii7HeB+S7mtzEuk1iZolO0Lu198SNm8Cf+SrKH9mnj5rC1AMN3FpHuu3LkjM2ZrUzSmbvY8Si0mjBxC7/5g5yzw3pJ+Vow06Fy6U40WhsQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDirGNLUbqlhnbBnK0kK+bV6fcy8djBIPmkWTIiIwzw=;
 b=oS5DK+ygYI8KvrE6WhN0lqG8sneNq5g39iNYRyFR3LQqacorMPyBdzoTd8TsvCmVu/qoBtv9vStxJNCaD+czXpegOpC5l5UOgxtS+rqP8MFNZQNVFWDqaXdiMngNcwcVb4IkptNZ1FxuYdrR3G/hkPJNi6Khpm+S72kB5w5ajcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7)
 by CHBPR12MB463627.namprd12.prod.outlook.com (2603:10b6:610:36c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:05:41 +0000
Received: from DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2]) by DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:05:40 +0000
Message-ID: <3f5fb659-c7a8-41cd-91dd-565cb46c0165@amd.com>
Date: Mon, 21 Sep 2026 13:05:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Accept AtomicOps already enabled by the
 hypervisor
From: "Prica, Nikola" <nikola.prica@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Nikola Prica <nikprica@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jerry.jiang@amd.com, haijun.chang@amd.com,
 andy.zhang@amd.com, jim.chow@broadcom.com, matthew.mcclure@broadcom.com,
 gbayer@linux.ibm.com, regressions@lists.linux.dev
References: <20260918170735.GA1162623@bhelgaas>
 <e7708479-1e9f-45a2-878a-cd857d5468d5@amd.com>
Content-Language: en-US
In-Reply-To: <e7708479-1e9f-45a2-878a-cd857d5468d5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0067.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::12) To DSWPR12MB999127.namprd12.prod.outlook.com
 (2603:10b6:8:36c::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSWPR12MB999127:EE_|CHBPR12MB463627:EE_
X-MS-Office365-Filtering-Correlation-Id: 8801e787-3240-42fd-f3fc-08df17d04622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	4B0gN99rGo/Zrf/xzzp1iI3cWjkxNDMsO8xd60WjWBydoegJDL9UHIumIp41FWv8nlAh6rM5ZBUsYuNZVbE8CFD7Iuv3WsskyHrcX2DQLozs//VpMmle2WgCWYOtHQjRmDUPrIYPkzuDMainK8Jljc04DdQiKbRM2PjGqmX2cSmD0F0b/iCbCIXyqOIAACDOFf4FX8APVEJT07T5rGswC1HHg73iqTGOSovbFJizHFYo04qNx7S6u1+46yXVsW+kNe3Cyt1v5UyyROWk2jZ4MBulPrCZfF7TtgAQUYuxfQ8lmR8bZraEArvKr0ZTAVMRNUWg4N2w1wq/kOixojaFPl/pPjGUz4UapqgImMb9thv1fdgWJR9Wj0VrNfpzu3akHDvjFmeIKpcN4Bk+tIDyuHWTa/gVPpqkB447KJW9rbSwNCiXlIk0K7hw//GlKIEIsEi03JaLBT6aRPati7iRyZc9IjJHNx7ddKWLUWOlSP6aixqw+M9J6gcVezRaXOS2wOjnvXY//JPq+v5DHCnPvDx/EZNznUGyAl6UbyB7ocvrThnGvl9D4idPuZCZoOIyjSSc5Uh5fuhq5ZcyEJHnoneNGw3F29fN1PVjaGyX0+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR12MB999127.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWdwUW9Qa1RlTzVRNEZXWXdEODl4Yk9leVN6N01Bc0pSaWNjQ1JzNGJzM3U2?=
 =?utf-8?B?R3lrYnV2eFFEL2RxM3Z4TGgyVzJQR0l0NFVLd0IxRWxycWU1RG01YWp4dWVj?=
 =?utf-8?B?b2RjV0w2b2d5ZHBzWGhpZEQzTTFsSlBZQm1sYTJIRTlyYlNHRCs5VndEWE9n?=
 =?utf-8?B?ZEZtR2JEampnQXJGUlBwMEdlUU1NU3BVbHhrTWt5STdyZW1TU2FoaTZFTFBN?=
 =?utf-8?B?RWYvd3FsTllUVW9DNVdqaFdFRnVmMVZ4V2diNDVMRVFEWUFRUkxhK3pXekxL?=
 =?utf-8?B?Zk5pVlVRdG4rNGJjbWZDSlRqQVJoVGFuZGpNTzZRMy80R2ZWa1p4OWc1Und5?=
 =?utf-8?B?cGdCemxvRDhFcy9CQk5MMEhjU3NjTjNsaEt2Slh2aUd0cDFnVEFQUndUdEo0?=
 =?utf-8?B?dWFHdlNUdEZzall5OVB5WlZlZFRhZGNtUEVMR0lDYTZ1STFHZ0NBUzloZDA5?=
 =?utf-8?B?T05YM2xyUzI4Y2ZIMklGSmpBQkVhMlZPL1l1STRxS0V3cHdwazEzSktDL200?=
 =?utf-8?B?VjVkSUw3TGhSR3cxUnFBQVRkeDI0ekUzYWZFeUV5SzJmQnZsOTBUT0QxdC9K?=
 =?utf-8?B?VU9WdHhLV3ZJai80ZUoxeXhOOWxFVTJ3NDRVM0VVZVQ4dmZiSnVEVWE5cW9J?=
 =?utf-8?B?SGhoY25VcHc3UjlHTUV2TW9naXNVOEkzUTUvSjRTcnQxYzhveGgyRmI3eWE5?=
 =?utf-8?B?YlJWTmpZemhGSk1Yd3pzb0ZLaFVoOGtqRU9tVFVXZjZhL2FFWmE3eFdrOGRK?=
 =?utf-8?B?MTJlU2IvTG5ORzM2b1hDTGlWb1FiZzJrWEpaU2dmTEJ1dGs0M3RoN05UZzRK?=
 =?utf-8?B?WXdlZXRCSmtyTGdCdDdsNU9YT3B2OXVoOS9wU0lCMVAyLzZGemFicUJtSklr?=
 =?utf-8?B?ZDJGMzhLM0lnVmtkT3FaVmRsVFRETG9XRFFLV3pvSVJOTDdCMDVhYXRxQlBN?=
 =?utf-8?B?eHFxaXB2NHNIU1U1VlFhdW0zRmdmR2RFQ29wZHBwQmxUV3I2ODdTNTVVUDZ0?=
 =?utf-8?B?Ry9tVVlkZXVzTS92ZGdzdWxrTnJST2hVNGtFWjQzOElkamVGQlVQbTVmOEF0?=
 =?utf-8?B?ZUIzVEFlT1FvVklGZEZGQVBhUWJodnltdkx3M3grMTNMd1RhU051bTF3MEdr?=
 =?utf-8?B?U0RGL2RDSDR4d2JYdEUyd2lOc2RwZk9SYTZjc05ybTIyWUhIV25CM0x4UjhE?=
 =?utf-8?B?YU5OdGFLTDlkTWpFRXg1WHZuWGQwSWYrWVZOYnJjVW5IOUlaSjI0bEY3ZWxu?=
 =?utf-8?B?RTQ3TFBRMUtGQkZ0QzRpSUFDQUtPYlVLR3ZhNXZPRDJQRSt0K1l0b2R2WDBx?=
 =?utf-8?B?aUpGSE1xU0VZSmdxMStJd21BNUhUUHdhRnlrR1A4M0dvMWlNay91VU16QXo0?=
 =?utf-8?B?Z1hzaTNvbmxseWx4Tm8zaFhUdkxJU1lIQnU5d1RqNUdxWVlMMC94cCtUKzZE?=
 =?utf-8?B?TTMvSnNhb0p1a0YvMkNmNWI3cFA3eVpLdjV1d3Z4T2pkVTVPdTRmemJyTkZM?=
 =?utf-8?B?RTFLUisrK0tXcFB4Q2pRc2ZSTVdFRWVVd1JjM2dzVU5xdU4zZ2Z4ekg2M3pP?=
 =?utf-8?B?WFg2ZTNFTUhvQm1PSkNKSHIxdythYkVJaFh0cXIwQ3FXME9nRC9rdXMyTStS?=
 =?utf-8?B?SEk2b2N3OUVhdyswR2RORFcxbitKUWtIQ09RRTdDT1h5Um9ueVhzdktRRVgz?=
 =?utf-8?B?bGFPT2hzS0MxOTc0KzFCWmp5cmdwSW00NG5PdG9KbUI0bnRrZUZKaWMydG1U?=
 =?utf-8?B?WmNONkN1MHExZUREZHFQRTJGVGt0ZXIvQzVlM3RwazQ0cGFQbElaMEYzR0ta?=
 =?utf-8?B?NWZCbVpNSmhJNm9naUNBZFlqbHVyS3IwL1k0amtrR29Zenk1c1hKeDMyUDNV?=
 =?utf-8?B?dEpSQno3OHhsZTVCaUZiK1l4SHVXQUpmOWR5eGl1M0t3K1dXaFlGaTNlY1I5?=
 =?utf-8?B?YW1KOXZiaGMvV0N6bE5uQmZNdzdCOTVjZEtDODdzUU5QOVIvZ1pGRHlYeVJI?=
 =?utf-8?B?d3ZrVU1MbDc2eXNCNjhTSVRjWnZUWTBnUFd6K05WY3lmVkZxUmNwN0Vsd3k0?=
 =?utf-8?B?cVR5RjJ1QTA4cTIyVXVoS0c5QWI5bUpERXBZVnB2dUZ3MGJKNW9haEdXanhh?=
 =?utf-8?B?ZjdBUWh3Z01ISzlFemJPaW1pL21kWnNXYm5ZdGozZDF6cjRDYjVRbUNjZXgr?=
 =?utf-8?B?ZytvTWFqRnBCZmQxbEM2dzhaK0kraDlPdTRSN1Q1cEQ0b1hiUnZTY3F6OGEv?=
 =?utf-8?B?T1h2cHNCdFh2R3YyTjRNam9RZWYvZWFDanhHeTU0dWZxMzRrdzJUdjFFUUJG?=
 =?utf-8?B?N2JMU09HRzVGSStVYS9QMGVZUnJCaVluZ1BtTjB3QmlMcmJ2Zks4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8801e787-3240-42fd-f3fc-08df17d04622
X-MS-Exchange-CrossTenant-AuthSource: DSWPR12MB999127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:05:40.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vnXWTVPKtB4uNCM8f0nrxz14uYt/A33BaQukablv48HTCBpkKRDzelgicYy2BLixZXeoGerX98JKILRbCA3Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB463627

This patch fixes a regression introduced in v7.0-rc1-2-g1ae8c4ce1570.

#regzbot introduced: 1ae8c4ce1570
#regzbot title: Breaks atomics operations for headless passthrough devices

On 9/21/2026 1:04 PM, Prica, Nikola wrote:
> On 9/18/2026 7:07 PM, Bjorn Helgaas wrote:
>> On Fri, Sep 18, 2026 at 02:07:46PM +0200, Christian König wrote:
>>> On 9/18/26 11:28, Nikola Prica wrote:
>>>> From: Nikola Prica <nikola.prica@amd.com>
>>>>
>>>> pci_enable_atomic_ops_to_root() currently fails when no Root Port is
>>>> visible. That is common in passthrough guests (ESXi, Hyper-V): the
>>>> endpoint is assigned to the VM, but the guest topology has no Root
>>>> Port above it.
>>>>
>>>> In those setups the hypervisor may already have enabled AtomicOp
>>>> Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
>>>> treat AtomicOps as already enabled and return success instead of
>>>> failing the Root Port walk.
>>>>
>>>> Fixes: 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports them")
>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
>>>> Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
>>>> Signed-off-by: Nikola Prica <nikola.prica@amd.com>
>>>
>>> CC: stable@vger.kernel.org # 7.1+
>>>
>>> Bjorn do you want to pick that up? Alternative I can push it through
>>> drm-misc-fixes.
>>>
>>> Initially I thought that this is a new feature, but it turned out to
>>> be an regression and we need to get it fixed ASAP.
>>
>> Let me just talk through this to make sure I understand it:
>>
>> Prior to 1ae8c4ce1570, pci_enable_atomic_ops_to_root() enabled
>> PCI_EXP_DEVCTL2_ATOMIC_REQ unless a switch port didn't support
>> AtomicOp routing, a switch upstream port blocked AtomicOp egress, or a
>> Root Port didn't support the requested sizes.
>>
> 
> To be technically correct, some hypervisors do not allow guest VM to
> set the PCI_EXP_DEVCTL2_ATOMIC_REQ. So there were cases where this
> set command didn't get through. But drivers relied on return value
> of pci_enable_atomic_ops_to_root(). It may be good to read it back
> to make sure that set went through.
> 
>> 1ae8c4ce1570 added the requirement that the Root Port be visible,
>> which fixed an s390 case where pci_enable_atomic_ops_to_root() enabled
>> AtomicOps when the Root Port did not support them but was not visible
>> to the kernel.
>>
>> IIUC the regression is on systems where the Root Port is not visible
>> but *does* support AtomicOps.  Prior to 1ae8c4ce1570, we would have
>> enabled AtomicOps in the endpoint and returned success.  After
>> 1ae8c4ce1570, we return -EINVAL because we can't see the Root Port to
>> verify its support, so the driver thinks it can't use AtomicOps.
>>
>> This patch fixes the regression by assuming that if we can't see the
>> Root Port but the endpoint already has AtomicOps enabled, the
>> hypervisor or host kernel that *can* see the Root Port has already
>> verified its AtomicOps support, so all we have to do is return success
>> so the driver can use them.
>>
>> I'm happy to merge this for v7.3, and I think we should add something
>> like this to the commit log to make it clear that it's a regression
>> worthy of a post-merge window fix:
>>
>>    After 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port
>>    supports them"), pci_enable_atomic_ops_to_root() always fails if the
>>    Root Port is not visible.  On systems where the Root Port is not
>>    visible but *does* support AtomicOps, this is a regression: prior to
>>    1ae8c4ce1570, it enabled AtomicOps in the endpoint and returned
>>    success.
>>
>> Is there any problem report for the regression?  I don't see anything
>> at https://linux-regtracking.leemhuis.info/regzbot/mainline/, so my
>> guess is no.
>>
> 
> Yes. That is correct. I'll send new v4 patch with updated commit log
> that appends your suggestion.
> 
> 
> This patch fixes a regression introduced in v7.0-rc1-2-g1ae8c4ce1570.
> 
> #regzbot introduced: 1ae8c4ce1570
> #regzbot title: Breaks atomics operations for headless passthrough devices
> 
> 
> Hope that this will be enough to mark it as regression. If not please let
> me know.
> 
> One more question though, we encountered this issue with 6.8.0-138-generic
> kernel, we figured out the regression point is 6.8.0-135-generic. Since our
> validation teams are using older kernels too, is it safe to assume that
> fix will be backported in new release for 6.8.0-*-generic version?
> 
> Regards,
> Nikola
> 
> 
>>>> ---
>>>> v3: Add Fixes tag
>>>> v2: Be more strict and only apply logic in headless device case.
>>>> ---
>>>>   drivers/pci/pci.c | 12 +++++++++++-
>>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index b2879a6be5f8..62729ade496f 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>>>       }
>>>>       root = pcie_find_root_port(dev);
>>>> -    if (!root)
>>>> +    if (!root) {
>>>> +        /*
>>>> +         * A hypervisor may expose a headless topology with no
>>>> +         * visible root port.  If it has already set AtomicOp
>>>> +         * Requester Enable, there is nothing more to do.
>>>> +         */
>>>> +        pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
>>>> +        if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
>>>> +            return 0;
>>>> +
>>>>           return -EINVAL;
>>>> +    }
>>>>       pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>>>>       if ((cap & cap_mask) != cap_mask)
>>>
> 

