Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793965380;
	b=DOgcnsNiuxnK4ePhWkOgOvJCXSs0vEryVR3XjyLyuGRsKNLiu2xpjIqV+CAPQM1Kc81x
	 1U6NF5R6HOdFcu/ehm9OcsohgBVMdT+syPoLuvs0EyGGm7RkEjktQnNIMdXejhoi598Qt
	 TYWfmidYDyFc+JjG63u5sWfkbS/2AMlnma+w/fpPm9PVDK/EUhth8vQdia7Oa/Fi/YUZ6
	 XufjbQheCTjcWqZGCVVNJdS+kvnhJa1fQ1F95XWrDXq4AQQeTGRTXUlqotFFtg1SaxPeF
	 DjqNBARFsAvN21/6huxTCXnCvmy9cXU5Lo/qHAwLZ2VfBwNtQNgqbDqUQairJhTz+Sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965380;
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
	bh=fihmiBshth1iC7m2JVB59RvPRIQbBYRo6l5+0CcjlcE=;
	b=yGFiktkcGjqh7oU4OzEDoPWPaAGFI+qcGBcenKpp2EHclOzLMwpYRxIaZh8gHuMJu8JD
	 R19tTc2o8i0FrLDp9hbPI1cv3/4MPKSyLl1Y84vyKu9VmPC2vb6jsaizGrhRZMje1Wal9
	 HlC8zDAAcdF/MLI8TYBi1k5AX6aue2dpW38W3ruSOYaZ8Hswh355KKZO5gwtMDlz4o15A
	 Zywd1Z/dbJTaHhzUFHO9V8/6P4Zlj/t0UxzddNSM67RZ7w/o52KL8gluXj+61kqJl9pke
	 iq9tcCYwLzpLH3gqVBonES+qaMkJ26yqAcQwiYMvCiSFbFnChQHusjYn3NSn3kHA0ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qDWMaJuz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.71
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C8606A91D;
	Fri,  6 Nov 2026 11:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239C8606A91D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qDWMaJuz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHd72dado6c5WQooV3P+q4tnJNeVaiy32wlDGGJNq3LvXrjuE4opXoWe0uBe0lEWGOT6Vw37Hfo2UgFGAcypUgLnS6xZU5uBFZryJZVf8+LHlc60+VNtDMTH+M7NBobCwwEdA6JydmXwKTYNdA+8Q3IXWGPPt1R+CwN6ckKyKEJ5tOHrNrVX6E3DX0dC5/+wnK9jy4l/eoDCa+CtS71PB9boN/c8Npt0TDSFr2VMVcOCaxskzjOwWX+1qY/P7Z5PQQrc4VJGkz6g48jf/A/auSw8ga4aluDMq/ffe7cyeTVyQKSN1xUGPosCGPASPbIO4pDOhPWesw2rbDrMiWFIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fihmiBshth1iC7m2JVB59RvPRIQbBYRo6l5+0CcjlcE=;
 b=BBC4n84+bSt3Wgka26iVFWC+f6nzcWy+Z0cjKa/wl2Qf8/xl6NvO7lLhikEOl57yML0vQWddXUQvzYMgtC2PCQjo5pjyCSUtmLtfn0wem8CQvCB+883boyzhKWrRLOerzDAPSTj11n1riNZPcRsUmmAnkhd7qqiPaJJvyEcpmzMyPbJxD8UnhM6TrDFIfC7awXDowu7py8Fv/oTzmkMqopFWQ18nWP6cNnXejICLkTZgt+QoubrYWii40pnYfCu7cSJy7JlqDl/dmlUoTFuMHYI6uQz+Z4LAnQvOOUdT2zS+FpHraeacBosRWxgoLsCokkkHhnGyJkLIPKehu6So4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fihmiBshth1iC7m2JVB59RvPRIQbBYRo6l5+0CcjlcE=;
 b=qDWMaJuzh82ROK6tmJbam7sunEacMDulhBq8ZuoajXR3jhzd3mcPSzuJg3QN6kQtJuiBLFl10L/jZnz62UC9IxL/XEBv+iRbXzPjJXNSP7n1T60TYTJb94cjMjXN/fp5WXXbnOsN5oiqdtXYbtMHTdcrz/v+NpYVMYXQhCuCUDw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21) by IA0PR12MB8277.namprd12.prod.outlook.com
 (2603:10b6:208:3de::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 11:42:57 +0000
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1]) by IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 11:42:57 +0000
Message-ID: <9859121c-06c9-4e2f-8003-d9d782658dda@amd.com>
Date: Fri, 6 Nov 2026 17:12:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
To: "Guo, Wangyang" <wangyang.guo@intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "Liang, Dan" <dan.liang@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261102070930.1803698-1-Vishal.Badole@amd.com>
 <MW4PR11MB698287F2EBAD1EE84171931592692@MW4PR11MB6982.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <MW4PR11MB698287F2EBAD1EE84171931592692@MW4PR11MB6982.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0087.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::16) To IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21)
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
X-MS-TrafficTypeDiagnostic: IA1PR12MB292992:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: cae99011-e01d-4fed-1afe-08df3bfb1a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003|261026121527099003|261028144727099003|261021123027099003|261022075727099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	X/D27E3FiGetFu/eSvT+iicDfOUR95Yfwn03A74DrW2jCAASOIC6lyZWlHmI1ZmK6ZkawaTrbFjQZIWObj96G3ZNc+z4Z2ssWC3qLNtT70bMo9wv5T6czQ+JD8aH4xiXb/5lVqcaz7UwqrMvt8h/RG8eg+RYWY26OaA2oiWFRQRlVTLJJW/FrJ/mfRhMyK1cpBI5XLCXW3Ccq1hRHmWCpk3EMWRNF1MeC8t8HFVdUxpza4yR6OFkjg29zPZWSL1eXunDAolKj8cuZfzuuHEKJS8TAXjW/h67b+GLJksshOmkG+lb5mho9TGJdpo2UqWN29fLneDL/t7jWZX1fqKPYuV+OQ5PIM6bcZJzQu7eBoP+UHDQ7DIzPliyqXcYRxy1DTmT3NczHpQImY9WFm2U4QiyOY8k0useukbqZ86Qjes+mMwhLkanaerawBpYmvx+CDvARoWXTGl/pTTedXEVRcW0kNINtlOjHivgZRG2q70bZgUPGuShFDFRBTyCshJF9S1fPJXx7uMZ9PS6c5HNeamtS8zjNs8mmwvUjBRfpMk1zBrnHF5riW3EbjTPRcmPGQ24eqRyqTnW55NsQdZSXnMOfP3ddyh8ns7hgKF0yWs9CyG0QnVsTZGULaFvVap3LP8kFd19AyAVTRnW42es07KFH+n4h4eFO16qghBZib8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB292992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003)(261009223027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uzljc0VkcHdqeDluRmEwQThZWkdpZ3JwSEd2bmJUOW9zN3M0ajZlanQyL2lz?=
 =?utf-8?B?NEoxQWR1dDg4SFlPbXFIdjI0L1dvYmF0TmRhWTBESE5ZSmVPckpodjIrcDBX?=
 =?utf-8?B?VWJTd0l5N09PMFJnazNwbXhpM1ZWV2VpRU1IaTFLNjhTaUxzdVgxampRQnVj?=
 =?utf-8?B?OTYreTh5N0VzZmtweWtUVmdpc3JKMzJabjdTYTAvTUpXMzd0MkVkNFlGOE1M?=
 =?utf-8?B?VFlZUElHVUpWSEZZZXZEU2pVVmtqU0pVb2JsV1dqTUM5Y3gwV3FXenZ5dW05?=
 =?utf-8?B?M1lNV204aDF1aGIvUzJhWWVMRHZhZVd5eEQvUWdqUy9ZYzgrS3A5ejJlQ2Ja?=
 =?utf-8?B?Mjl1SVpxUnNkTktpYWR5eGhDYU1SQlJGL1pOTTc3amxZYVBLZ0dVeHF3dkhz?=
 =?utf-8?B?NGppS05OOWNjbG5EUHZ2b21OWlcwU28xMW1ZZFZVbUxEZ2tadW9rckFsU0VD?=
 =?utf-8?B?YTBwaHIvZDRPT3ZONVplbFJWTFIvUGNycmZpTEpFUTdWQ2FsTy9pb1RGYUYw?=
 =?utf-8?B?bVZta3pBeUVRMC9NRFVHS3Jqd28wTzNYbGVDbFJSeHVmSU1aQVdtUW9GYjZK?=
 =?utf-8?B?Y1dydGZCSmRHWWppVjRMcHdNRzh2Wmh2NWlvSTJUVVNubHBvL2VYbjBCTmtI?=
 =?utf-8?B?R3BoaEdqd25YWXRjYU9TUjEzVFRpcDBvWXVaWEJWaTgycHkvdHVNSi9pK1BU?=
 =?utf-8?B?a3JrYS9DWlBwREEzWUU0ekp5NEtvSzRha2V5Rjc2VzZSUTBrSk5HNWt1bC9U?=
 =?utf-8?B?R0xVMjd0UkpCQnFxRWR6YUltOTAvcG5ueDdJUi8zRHlNZHhmNUw1T1U5amZ4?=
 =?utf-8?B?RGx2eTUyQUlpaGN3ZjNpaUJ1eFdSTjJlLy9Oc2pZTWdsWVgzNk11bGZRenVr?=
 =?utf-8?B?bEswMUFkOFlQbWNSWFE0NkxubDhUdHVkQno5T3ByYVBIYkVIQmszNHdzZGJh?=
 =?utf-8?B?cmx6cmNWTUNFaWZSSmJNZm1PU0lEYTZnaWM2bHZaRSsycklNL0xJNmNXeTJj?=
 =?utf-8?B?STdmZTNWdDRPQnVGT1g2Y0Z6UFA1OG95RjRGWUZlL1hFYmJVbmlvR2tucmlW?=
 =?utf-8?B?U3pXanBYK2VOdW4yV24yMFRoYm9JNjlTSUJXczdHUVk1V0FoTnkyczdlRmJI?=
 =?utf-8?B?N0RVZ3UxcW42cEhlSnF5amdPbVdVRDlTN3lsOFJUNGNLb1ZrN2hyTFJUUjhU?=
 =?utf-8?B?a2JEdWdQLzRPbXplcmR1SWFnQ3pKY3RlMVFaejRTNDRGTVNhVSt6NVp3Y2wr?=
 =?utf-8?B?WUxsbVYySWxqUlh4RHkrQjVqZmtsTG1VNkxpSHVGZHNRbmxySC9ZUmRxSWcv?=
 =?utf-8?B?VDgzU3EvVU1GeWgrejlEam9qaE5RWkpuUGprN0pOaE9PRmhacklOR1RYRnV2?=
 =?utf-8?B?WTl6RlBvd0ZJOUR1bFpCcVl1QlZaRFNSVTRTbGZMV2l5TE9WalU1NEhxTi90?=
 =?utf-8?B?dkNTSWtqYjZVQkhhRXhvMTl4c2JMRkV2dU1UdzM4a1VlU0xLOFhaUDJQMTZm?=
 =?utf-8?B?SWE5emxTYXB5SGYvZkRPZW9DRVMyOFMzLytuU1RSTnl6dDd6SlZ0SWM5T0tJ?=
 =?utf-8?B?dXlXRDE1VnBnQjhGYlkwajFzTUxFRW03KzFxWDZWV2N1TnI0SThmSHF6QTNr?=
 =?utf-8?B?WWptWTNST3o3RzNBcDVydWRkbjQwUWw0akNUeHpCUUxkdXZpK3ZEdjI3VkVu?=
 =?utf-8?B?MEdDVlJUV3U4U1VNdGJPZTdGQllaNW5sSEVrb2pyVXJROVNIRmtjN0hTMXVJ?=
 =?utf-8?B?WFlZK0JueS9DSEh2OFptdGpPeVVHSGxKUFFIemo4WXMrc0o1aTVBcGxTdkZQ?=
 =?utf-8?B?MWJsN0VYYkxYYzV5bmpKa2hBbnRVdjRndVdEa0c3ZGJ0T1hTMVlKaFlFeFF6?=
 =?utf-8?B?cnc2SnkrUjRUVjNaTldURDdPS2NjQmlFWFRCSW5vSjJjQUpVb3hYMHl4Z29D?=
 =?utf-8?B?ZHJQeTQzNjFSYnhEVEJPTW50OXpPZEd0UVBPTGNlNTBpNHErRElHRTlXSmZo?=
 =?utf-8?B?dWhmd0lEd0h1c1BnbXZNN0FVM0dRN3NnTHU4bytLSG5ERVE3ejcreEVoNEtI?=
 =?utf-8?B?dldjQXk5Q1M3Z3VMdXhNMGZwTVNnZGdYcHBCSm5ObkRLbWFuV3ZzZzA3TEto?=
 =?utf-8?B?SkhodVgrdVdaK3h2L3BLeXBmZzU5UVg3YXV2SFRFSU1MZ2U4YjYvb2c5UHF5?=
 =?utf-8?B?RG9lalNYZWZEUjFyQ0VXOVNzdy9mUTZoWGtPbFFFRHlHYkdFRUlWVFFsbkFX?=
 =?utf-8?B?a2xrT3NaL2Z4TVlnMlkrUWNkYU5Ga2QzbVBWV25TN0JVUGYvakg4cisvU0tk?=
 =?utf-8?B?TUR0d1B3OHVTdW43M0lmWEpkL2N1aitlWXQ4SElPR3FNU29Ib3lsZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae99011-e01d-4fed-1afe-08df3bfb1a76
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB292992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:42:57.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Dn1uQBUM4FxOPbzhwdtTzz2coHsdTLKE0h6HXQvPC1nFrFu8bkjTN1z21MJz4h/xzgK00NxqB9NlEMURBnTTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277

Hello Wangyang,
Thanks for reviewing this patch.

On 11/3/2026 11:55 AM, Guo, Wangyang wrote:
> 
> Why not use original topology_sibling_cpumask(cpu) if snapshot not
> available?
>> -		siblmsk = topology_sibling_cpumask(cpu);
>> +		siblmsk = sibling_snapshot ? sibling_snapshot[cpu] : cpumask_of(cpu);
> 
As Andrew noted, topology_sibling_cpumask() changes during CPU hotplug, 
so using it as the fallback could change the grouping. cpumask_of(cpu) 
deliberately drops SMT preference when no snapshot is available, keeping 
grouping independent of the online CPU set.

> 
>> - * Return: true if success, false otherwise.
>> + * Return: 1 if successful, 0 if inapplicable, or -ENOMEM on allocation failure.
>>    */
>> -static bool __try_group_cluster_cpus(unsigned int ncpus,
>> +static int __try_group_cluster_cpus(unsigned int ncpus,
> 
> If use ncluster as ret: >= 1 successful, 0 inapplicable, and -ENOMEM for
> error.
> the code should become simpler.

Sure, I will include this change in next patch revision.

>>   	ncluster = alloc_cluster_groups(ncpus, ngroups, node_cpumask, nmsk,
>>   					&clusters, &cluster_groups);
>>
>> -	if (ncluster == 0)
>> +	ret = ncluster;
>> +	if (ncluster <= 0)
>>   		goto fail_no_clusters;
>>
>>   	for (i = 0; i < ncluster; i++) {
>> @@ -392,12 +477,11 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
>>   		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
>>   	}
>>
>> -	ret = true;
>> +	ret = 1;
>>   	kfree(cluster_groups);
>>   	kfree(clusters);
>>    fail_no_clusters:
>>   	free_cpumask_var(nmsk);
>> - fail_nmsk_alloc:
>                return ncluster;
>>   	return ret;
>>   }
> 
> 
>> @@ -442,6 +526,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>> -		if (__try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
>> -					     masks, &curgrp, last_grp)) {
>> +		ret = __try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
>> +					       masks, &curgrp, last_grp);
>> +		if (ret < 0) {
>> +			kfree(node_groups);
>> +			return ret;
>> +		}
>> +		if (ret) {
>>   			done += nv->ngroups;
>>   			continue;
>>   		}
> 
> There is duplication for "done += nv->ngroups", my suggestion:
>      If (ret < 0) { kfree(node_groups); return ret;}
>      elIf (!ret) assign_cpus_to_groups(ncpus, nmsk, nv, masks, &curgrp, last_grp);
>      done += nv->ngroups;
> }  // end of "for" loop
Thanks for the suggestion. I'll consolidate the done increment in the 
next revision.
