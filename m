Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230BD3C2BAF;
	Mon, 10 Aug 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367243; cv=fail; b=aTzExvrLr/J0IU+Ro+G+IKxuu4rcz/TSqdLoTnpnqDJqveL6fyO0a2LAoYTmePdmkmOayGzE6lVxi40z/7mPMnP0b/TIOuKNp9sbi/D6w0MFblznUfnv2ZKGHRNZ45qIzI4diTpSSFURNccGQLhwEEekR5YxKpf7uMHDqm+9GNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367243; c=relaxed/simple;
	bh=x2/JRIW1oRSQfOZWs7jkwvUNTTLePm/r5tNFzAH8nzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oQfaelvifJJNSmsb0+kUu52Re58M+GjHGv6qskIUVkT9vUqhO4fBMzuV6iIWjR6J1aLV8lilgFvjg8sac8viS/3qGXdfhVBDbLdGFzTwpvFPK6YATzbkVXm4VtdMMJ3aWpvf9kdZ83N2kjd6fnBNa1WKt+dGRNl6Vy6RnYE9urc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h9XT5lVz; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h9XT5lVz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNbU6Q3xvQpNPYJDYgjNXSOrcwl0gWRKdJmlfdl/RTbEp9UGenh2OBTqum2ZUuY1mRZrm8Enkg6vA+nAyD0i0weBk9FL31k2wMebkOLsjXF+lfVIGpFiQ2BZlbfIGRWbiTa/8bhWtmH+khNzVX0ujuJxRo/a7cxEIXjmZ8i3KqXbS5IHtadAJ3d2OWdP35s0OQkKg+UI8I7UK4a5YQTuUTe1X3HAxvg/brh4c4y1tKRYioyCYb31aRM2uW6JadAN+lR4p5SRKG0VNRAMsyMUO1d8ScwqPJvueKSe1DNLXpSo0uE7cxBQn5El4fteyRvlYM6HTyIv8lYoECzdCvjoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQQEMy4N8DqjdcWf12S1AqZ9Y4uAx5YA3VxGNs49NXg=;
 b=ufKRPsA4cwnxjFA63J9K+xD74XUyOGWyCXa3W/0sQR0z61fZcIAIa4/ZOoBcDRBCH8cyscIk/ei9PEVlNHqu0gwx7Iy4LSqc9LXgibngjDFl8/a68TxYuxUaBgU9gBu4OB2gwKO5cNvNacz80pmOl32CMHwcO7QbsNZ4dng2cq4nopa2aHfM7GoRnvHbm+hHm8hB2ArUOJXC3i/JDut4+bg+natykphO/l6VBFKKq5+KcIuxioIbr0cYwNm8Sw25FPFabwkGa3Nr0TR3hW2+xQUWHFpbKPOpfqXTTT8T7awnSx+1PxzKuR+E9TEFwddvtmipNP04nHB0ExB0WGuGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQQEMy4N8DqjdcWf12S1AqZ9Y4uAx5YA3VxGNs49NXg=;
 b=h9XT5lVzu7ahFIdW9kgygn22GDsIdsT8nzb1niAXM8LbkYelmJLCQadO2vhN26Q7cZp04Mo7zlHssbJW9gAOtRt6iuW0VcYQ3Ls7+coQKNfLc8M9MKps+PTnyJTU6HXMkoUV+d817NeGLOhwA7xCzMupXAjJPF4EGBSLbcLy5+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:07:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:07:17 +0000
Message-ID: <8a1d942a-2b2d-4525-83d1-3c434c0a3679@amd.com>
Date: Mon, 10 Aug 2026 15:07:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: fix VM update overrun on non-4K page
 kernels
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
 <20260806-amdgpu-fixes-v1-2-ce247012d4da@outlook.com>
 <88f614f4-5001-4cf1-ad2a-00802508a4f6@amd.com>
 <B5DD8C80-AB11-4D23-A602-EBEACD6EE04A@outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <B5DD8C80-AB11-4D23-A602-EBEACD6EE04A@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0421.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0031e4-0f8e-4519-003b-08def6e04db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xe7AknByRt45kYgsC0Mz6RcuthgTUHVuIiWlXiOwBLaDHkS63zYxY+d8mQm8u3IPxpFsRO3aXp+kUGMBWQ0/sI66+z1yNs02rJXw0joRw6Ykac/YUh2DgyT1BSM9mWYqH8ZGESc8Wn5vCtn/iIpcuQLZomEFGqwTb9x3VqE2FCYLYfiXb8lMx0hz8pj4h8kstfYapMyi/DlDM2BVOpxDn1IaTpZrj+8/W/+TIgzdxQUJf/nk1G0BJ+kaetCQLnb8Mp7DxjLoRSMHUSB4uF/sya5lzDKDtHYWRcu9Dehy9f7oAm4bmDor+N646YmAXVt7SeNI9vaUzls+uYQdUTUUkTSAUW1q7wVsR3XJYZn/LuI+8Av/7VL97pzfj/IPqwO86Pez7N6uNz6i1DDF+xsFdcsnceN962XrAkxMidtT9dtvdVOueM3p4X+BNUA/JzKaXFmJ0t73gFbtyjwesYpoHqfgENT2QWgE6GpAtoNzq3ukW7Ng2l5B5V56xl8mbIH6FHLk0i4Uu1OUkmrjxNnsjkAD6mc2IdxsMw2oT0ymhLCzTWPCBwgtMWOGr6erjqaOt9SZOZVrFQBSURA2AmIdNsM8UMI/CQuc4DUedmMlnfz7E21kb/9v3su1EHQgWogvX61ihI/4bGJgPMZUsjYwC00uVmnR4v7y36l4iRNlES0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHdwV3NPVVI5ZEV1WVRmR2VJSGJGMVoxcVRNR3BUOC9GZklOektJcUNJdFRN?=
 =?utf-8?B?cjMrV0h0MWcrR2N4MTRNeGw2NkY3bE5mOXprVGJDRDI1Q2U1OThYMCtsMWNY?=
 =?utf-8?B?OHppV0dhbzJGUTFMMUE3OUJOb0dQTjZyZzl2UmZsQ0UyN0QzK01lcW1rb1l1?=
 =?utf-8?B?ck5mc0YvT0d3NmFJUko2NWFhendaNDZ3cSt3dFlqbG1EeWZkbHNkVVJWN2FU?=
 =?utf-8?B?OVpMc1Y3OW9mN2NSUzF1cXVWQVhVejc1UlloUDQ1YUFlQ3ovaXVnQTNqYnQr?=
 =?utf-8?B?NmpXRU5NdlJnVW1MWXV1MnZWUjBjNlFUb3prV3Z3ajdnTXNpSWU4bGdqNVht?=
 =?utf-8?B?a3d6TFdUenBKeWhpczNrSjNQeEpJZFpwUld3K1BQTHZlN3pUYnZWZkJwSm1Q?=
 =?utf-8?B?MU9Dek9iT0xDOVFSN3ZacDBOV25DRE1FQkUyaTY3bmRMZG1HYzFDOU5VL0Ri?=
 =?utf-8?B?Mm1BNzlQWjNpbFcxZ1U0cjNzN2Z4ZUljVHNoME40dHhrR0dtMzNkT0lqWmpG?=
 =?utf-8?B?a3Bxd3dSTm9Hb1pKM0t6d1FjOEJKNkZlditZcW1PUUJFSXdFQ1NmT0FwSUZY?=
 =?utf-8?B?VkNrZ1o0VGxwMEhKYWlyT2RTQnNqVGxrV2lJbmZQZFJrR2RFSE51TDlnaXJx?=
 =?utf-8?B?ZDN3aW80THVoUFJaaUtKNXV2WGEzSHBVc0pacURJdFVmRlR5dVBTRStrOGpW?=
 =?utf-8?B?N0RDOHFkZEg5dm5DNmxBajRtelVoNzFEVUZidmc4dzlQbVV3ZkxVKy96dGpT?=
 =?utf-8?B?M2MrUmNPT09iRURFUE5hRnJxelFYRXRRZHdSSVRNNXFxZE83cUNreXkwN0FQ?=
 =?utf-8?B?Zk9PeW5QemdFVEpIQkhOK2hWbUt5Qm1aNEtQRFlyR2RGRkh5L3ErWlF0NnRp?=
 =?utf-8?B?b3V3ZlNXOCtRYjlVMC9GKzVTVVBBZFJRdkxGaFlMbERsNWUvVitCNHBIKzJY?=
 =?utf-8?B?SmovTFFVVkdEd1UzOUk2WGQxc0VxNFBDazV1RjdyK1RFYTgzOTA0TXBmb3I5?=
 =?utf-8?B?blpBTTBWN0R4TE9SMkM0eFl5UzBoU05HRGVuemZWdVpoK3ZTQXcydzRqWGV3?=
 =?utf-8?B?Q296VlFORTJSTWZMVk1PbEZJRWVWOUVmakZVT0lHWHRHRjRnN010b3lOSDhZ?=
 =?utf-8?B?UWZ6U3ZuQnZmMjJZS25nbk5wUjZnYktjTThjeEhIQ1NPaUdSZkJKYktqK1Zl?=
 =?utf-8?B?MFU4Mjh0SnNnQkFVK214MkloTU55eXNVcUlzdTlVV29jeGFyWkV6b0tpZFI3?=
 =?utf-8?B?QTFrMUNDYUNWdDY3TXF6Q3JYUG9kdWFLMlg0cDd3OUdlU0Y5dUVhNEFrem85?=
 =?utf-8?B?UkR1YzRXc0k5RnlQcmtTTkVOL1Fac281NVdKVjJyZUtLTWZWRlVpa3NLTCt6?=
 =?utf-8?B?VzF0bkJZQkVIUk80MmZwd3V0TGkzWWUzTE85b0M4ak1xRkROWENIV2xuQTdr?=
 =?utf-8?B?ZVdNcmROVDIySnNYZURYaDk2ODdtd3pYOVpBTFg5Y2tIaldEeUh1YzNsMjRY?=
 =?utf-8?B?ZjdGWWtLZkZKZjhxeVM2TlR0SFdNVEJ4RVJIc1BnYk5QUVZKeWJsNEJ6WDFV?=
 =?utf-8?B?aktKYTBISEwrUUhHa08zNjNPQ1FNczc3MXljbjhSUzQ2OTlsd01BTHBVR016?=
 =?utf-8?B?cjhDM0VBVFZvVlp5OFptMlB6S2ZKbUFXY0xPell1UnArVkUvV0l2RXVzcHZT?=
 =?utf-8?B?ck14aU5uSXpTNC9DZUorcUVIU1hlMHE1dkNyS0hyd2xqa1pFZHFyOUlZMWlE?=
 =?utf-8?B?NmwxOXlIYklLdFR6M3JUUmZadzNyUGZ0NUhqaW9xb1FRWUp2djFvZndieWlK?=
 =?utf-8?B?YXhBeis5UmoxYlNObFRXTEdYdFRNZkoyQXN0K3cxT1Ayako5R0Vldyt3OHdl?=
 =?utf-8?B?THIxTkZzYVNoWlJJUXlDcldvTGk2cW1QOUxSWFl6S3RsRUFnVXVBUWt2UURE?=
 =?utf-8?B?M3dkZVI2OHpKVkM5UjlrSHV3MVZCbGtoeUlvNjBnSmtpR0ZTTTU5MDVWdGRP?=
 =?utf-8?B?S29CeVBMaXdWYldOWnRJQ0F6TlNYZDJLUVVMRndBYW51NVdHOGl1TkxoZlVS?=
 =?utf-8?B?ajE5enNjaks0R1lYMjVkeENhbEV4RnNIVWo4a2xqVVFCbW5WZWZRWHlRN0Z4?=
 =?utf-8?B?cys3YTE3ZnlwUzZra1hLbWNKL0dUR0lDMUJSRC8wT0s5NWxhZzhUTDRLSGJp?=
 =?utf-8?B?MUlDT3hzaGhLcXNTeDVUenBFUmZTb1pyQlp4Zjgrb21ZRlloZnplM2szMnNt?=
 =?utf-8?B?TUpBSnp1ZTZjTzREMFlrUDFWbFdaRGJRVDBGTURWSis2R2Z4OUMxZ2lCdG9p?=
 =?utf-8?Q?LZW0Yg4FmJ3MMVoknx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0031e4-0f8e-4519-003b-08def6e04db0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:07:17.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW9PWKERFM0g5GlK5n9ijYQb+n1HGcxqYIRuxZKeJVagJVX9ilasiYFUGKZJ/tDT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505



On 8/8/26 19:03, Junrui Luo wrote:
> On Thu, Aug 06, 2026 at 01:59:52PM +0200, Christian König wrote:
>>
>> That check is clearly not correct. The pages_addr must be fully consumed, otherwise we run into major problems later on.
> 
> Is that an invariant today?  num_entries <= AMDGPU_GPU_PAGES_IN_CPU_PAGE
> skips the scan and is used as it is, so on a 64K page kernel a 4K mapping
> maps a single GPU page and pages_addr is not consumed in whole CPU pages
> there either.

Exactly that doesn't work. On a 64K page kernel mappings *must* be 64K as well.

> So what should the code do for a mapping whose size is not a multiple of
> AMDGPU_GPU_PAGES_IN_CPU_PAGE?  Could you sketch what you have in mind?

That case simply can't happen for user space allocations in the first place.

Regards,
Christian.

> 
> Thanks,
> Junrui Luo

