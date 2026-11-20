Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795183834;
	b=N3LyxCQgyGQ+ClzxZoVmDwtIRhWwnUKiMHh1PyGucIwkw0BdMXOSOZEC2o6sZ/JwIYrD
	 vPZlAVZd3jGiJ934Mn4iYiTQFPr71iUIbmwcvGWT+FxL7Ay9o7CIo+zoVovIdj2ZBka7N
	 X+Ic9FcRcTu02umfgOUSDRbpOx36qEoRQY5UReqOA7CT3T9LuUjGtj0pm63TGOm9+SUo/
	 3a6AwiMSe6LhkIfpe/j/p8vBi9qfVfrtxJwfJLLJokWA6Qfkvb9+lSsUvZowdSZ1hmkrR
	 JGWpxmuUO6kuND3cH7niP65xvAx5d4Hg3YYyi5ZOXKGs/XLtuDRPvXzNvBWl1FQITcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183834;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
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
	bh=u5gpXIu+riVYT5M2PhW68b2yOWw+BXjYtPwbqlNMxkM=;
	b=FCRMOtOCU4r/9vMORvcg5xmhsy+Xb5Xlc0gbdXguZA/9hc3CDGrWX6W35O3CLQugRe2U
	 ll09q5DDLsMOH2Oh3F6CSvROAsRJk9006LK2EnDrL3AVpjFjy/rAgmnd7iux9yVKyrykK
	 mzvrEIWhTAsOVRDdyRJm6sZ2FEWdw5W3s35VUN1pUH8IAl8GnqrYjlMgD5Po0OduWrG6E
	 kxsNoVhJ1fimPsfIxgvvhEK3YCjdd0JkzeeAdKWR/GYKrLD/jzhDNZszLm+rYLYPxPqo6
	 09cbtgjE+k1RFUutfPK4ofRrznrlc44sCrDw9kcalaSydxxft8EKBbbeuzWC1t5WNYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kCk2tXsK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.56
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7ED606A339;
	Fri, 20 Nov 2026 14:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA7ED606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kCk2tXsK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zC/Z6AFDPLftDXw6DzFkzHwF6EVFBvXG/O/LVj49UUaGEf5O0wNh/IbW/IUT5dzh9zBVxghKDHEIm+7c6tWMn4EWiw/WGBeBDclRED2x5D43LFhtf+azuYzD2LibpCWCHM1567SlOek0LRGOLthx2V4wtPgzkbewgs8zvnBZxHpaxszbwnmoLzmDX5OfBf0Z76bSfsEvB4OQWfZl1tVa7S+nC1rQvlr7tzhSo9xYiZvgkXVkLTlL3qWdRLIuQy3skXWd0xA0aQEAZSDmczzpxKhbRP6pQk8tDM9uOeIYQEqBY4TByU456mKpTlN5uc2v6HfJ8atzMouURlvfvwJzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5gpXIu+riVYT5M2PhW68b2yOWw+BXjYtPwbqlNMxkM=;
 b=WDW3Q23iAZAD4+Qku8ZVkTVsQA94OdzSilBx5CmJ+JZJ/D/vA86ZPK3ysF8PXuhFTjY+KPE70C3NfCoRHq3VkNYxOkFazorj4RKEKOgL9KkHDJHhojGdCP8kWzMqH7Yhp3JA6Ubkt4+ZyFfFENbaqAkxGTdcV5Sd7d8/jbEPKBl2EUMvSY5WuTS+iwkfwOtdik2/4nThwcBT3nxKoh4L0KJMknCX+etMzh02Y3td+yDkWLpFjZ3gd2ExaLgltUJP+p9IABiyprQQsBolewg0f58KF+wGOBqN7FXANRTZx/kEvzY6gzdIY9NSXgmUi7BD8pL0p0WHLx5NBHYq05AZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5gpXIu+riVYT5M2PhW68b2yOWw+BXjYtPwbqlNMxkM=;
 b=kCk2tXsKADpYpM6FNMyN0aJpyLbLdA4hdtO49kd0eDe5YMaMpqvl+kT6L+fwxUqkHYJw/RGG+ACgUxShtHkI/ioi2lPH9fIWSpLCFDGhXXvwXafbPuW/vsj4MgBYMRhhIw3FURXATBQ7hmISbIRJie+ejv8lvVqvtfD6gZlnyfk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Fri, 20 Nov
 2026 14:10:30 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 14:10:30 +0000
Message-ID: <fb539fa9-9d9e-4702-a7fd-8c339e57f14a@amd.com>
Date: Fri, 20 Nov 2026 08:10:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpiolib: acpi: Add ignore_wake quirk for Gigabyte B650
 GAMING X AX
Content-Language: en-US
To: Basavaraj Natikar <bnatikar@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 silverducks@altlinux.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: linux-gpio@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20261119083813.390337-1-silverducks@altlinux.org>
 <20261119122844.445945-2-silverducks@altlinux.org>
 <av8EszUWsJIq3hIV@ashevche-desk.local>
 <139a1c14-39a1-4bc5-aba3-673ba603821d@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <139a1c14-39a1-4bc5-aba3-673ba603821d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::35) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad9a2e2-d82f-4eed-ccb6-08df471008c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|261022105027099003|261026140227099003|261028144727099003|56012099006|11063799006|4143699003|261021121427099003|10067099003|261102123227099003|261022075727099003|18002099003|261026121527099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FR4BZLmPvmR97QLeYIF0ftTTjai2Iu0npmIgQerx5c85UuFLIIuuvpSnhMf3jbCu96HQvpVzbzWDF836MNwaaG9iy7dFSmjim1N75OYPo+vjG4spoHsjmUIB/oHWZ6ALWfpe34iFO/5sVjK38k4SRg4RNmHnIBYMuhustdDgpir8BPlcUIOvCK/ckZAGtqjxKYO9Mzrcs4CmT5JnGosBCbWErQ8LXKOx3bEBhr4unypG0ECGLCJWSY2/gHdNrJd2+WvkdnEFy2Cl++CgS3Ll0Lc08xX0gL/YZPyq0tRTAejbAUkKpgK/s3H+uO8wCjNM3FEmzex1SCPHwucA1kItx2EnOdzCk5TA6DVjoUJggiFBD8XgvSqKrb5KmAVy/LjGvowEDuaaaBz4xTNkezbgUSohtJMnwS1H89l45Ti06NDD262G2U3NZSM5XTLAXRN4jqQbzp3XaN4vhdKa/6l7c0SYxtMD+dZiJKmuUy5UKak1Rn0KxB3NaJ7h4Egk58p1wB1vkvcIqFkkLTZ4m75MLUvq2wLJ4qUJE6x6kw1xY6luTP0k6zjgSO68dT33TloXjxGfmzSs3ZF13hwKWxrrxwMFu3aBIKYH1b84154C1o3jgXyk+im1zdsAQWj2T3NrOLyKx0AzP06fzP0M/LlebaLLOyBQvbwcR6q23wXT9U8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261022105027099003)(261026140227099003)(261028144727099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(10067099003)(261102123227099003)(261022075727099003)(18002099003)(261026121527099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUJ2WlZOVVdTcDd0Q3gxblRwZ0lZbUN4SUQyWkQrU3NobVhxWUVBWGRVK0Y1?=
 =?utf-8?B?c3ExU3VFd2gybit1R1RSTHBBNEd3M0dQdGFhLzVoeWV0UVRaUityNGFlY2lQ?=
 =?utf-8?B?em9jMnBuSXVVdmZhYVY3SUc4SkJmNzh1RjBJNDJtbVpZS3k1a2tVcTRFQ092?=
 =?utf-8?B?K0NwT1pPUzlaNlJzeEdaMzJyY3huck9RVWMyUFR3MFhjKzBtNWVvOXFKaWh2?=
 =?utf-8?B?b21lMUYzMmZWSFdtVW12NGhXc2l5eWNsZ2E4QVJjQm1JS09IMjljWSttZk1T?=
 =?utf-8?B?cGN6MHBZdWk1cWFYZVNTVktmVGFGNG5wVk1mWlI3YkcwMTh3bDJodVJGSzNE?=
 =?utf-8?B?K2h1cTQ0YjYwY1d6QVIrY3JxTWxDbjNxaFQrai92Z1dFZWEycmhnN3puM1hy?=
 =?utf-8?B?QUFLN0xYZktVSEk3cFcxbzZBSmRoc3dscWRQV09lWFZhV0x2WGVBOE44K3lP?=
 =?utf-8?B?UGJ6SWxsMEVUVlF4UEt3Nm5abG45QWNDQk4wY1VMVS9aTWQxaXNKQ2syWkVL?=
 =?utf-8?B?czlOaWpWRWdMSmhxMERTbm9XcWhGRXJkYUVMczZGYms5UXRrRG44TXcxOTJS?=
 =?utf-8?B?bllBbVBhNlhXS0twNXN3SlRNdExaRHZKVE5iYVBKcTRXZy9pSTF6NGZxZTFi?=
 =?utf-8?B?eW4yaWo5c1EwaDNlYTd5R25WSzAzM2ZFK3VpVUtMZkJ4cWhHalBzNDNBZ0hD?=
 =?utf-8?B?Q3NsVFN6aG5OdnJady8wYTduSEk0Nk5YWVRxc1REaldRZGkvUThDMHluc3Nx?=
 =?utf-8?B?WUtTVFYzenF2aVBJcURvZmh6dGdmVFNqUWp1RTcvZnYvSkxDZDIxSTNSNDNs?=
 =?utf-8?B?TnF6dDhKajVyNjBObE5NWWZzYkpxTFhpdjh3NzNwUTRoaDh4czBDM2hWbFZo?=
 =?utf-8?B?MHhWcnVzZU5BZVl3NTFhejlxUkVZMXB2ZTFVNTUxVXcrVU55SURLMXdnaWhl?=
 =?utf-8?B?S1ZTSEthWGJFM0xvcFlxUjlSbi9zMEFORVlJcnFEYXo0N2VRYmNCTWZsa2xI?=
 =?utf-8?B?dHk3RFFYdnlSWTlDb202OUNkZ3Z3UWJwZEUwcjBPSHFIc2pTYzNtSDBNSmlK?=
 =?utf-8?B?RDI4Sm5BQlJ3alRiNEloL01QUW01U2RjVmoyUFBKWUJ4UmNpVUhXbXZsSzVF?=
 =?utf-8?B?L2w3VEJiekV3ZkxuRzlsTmxEQkpzZ2FuY1UwSTJlNFJsU2Y2a0h2UURCT1BG?=
 =?utf-8?B?WnZEb1ZySCtITjFSdk9DNnU3U2FyWTFwZ1hmeFVqTDNGcjF0dVJtUzNWR3lw?=
 =?utf-8?B?NUlNRElzREZvbThzK0xyUVpEaUlZS0VBamg5bjJUYUg1VXEvUVlLQmFPYnc1?=
 =?utf-8?B?bUtMQ0t2VmdMTnhmSmt1bXJPNy9ZVkNmb1pGTE4xVEdUVnpzTS93cEovU3Vs?=
 =?utf-8?B?OExLWGdxb2ljYUpqVE1kTld1YXhwQUwyTmhkUE1uUlpueXNCNDlTTEJXRUUx?=
 =?utf-8?B?eU0rQ05EU2hCRU9LUG8weWJwQis3Zk9zek9zRmNaQVg0cFQ4WkJRSStYbXRY?=
 =?utf-8?B?RVVjeGQvUEt2Ni8zYUFjMDRyQVdpeCtWV1cxdEd1WlltL1RLL0huNDA0YWow?=
 =?utf-8?B?L0h5ZU5IWjV0N2VzcUdFTkNPaC9WYVBrSnRwUWZkMFVsRzZXSHF2dFhqUWoy?=
 =?utf-8?B?RVVSY0tmbUNacUNLaDB0R0w2T2VWdVdTMmNBeXRBdWlRd3liY3JkUi8xOVNF?=
 =?utf-8?B?MTM3ZkpDMlBuRi9UY3l5OVUwWXdVYi9GRE1RaDl0dFlGRjFEV0JRU0p5ei9I?=
 =?utf-8?B?bjFLMi9vVUU5Qk5qcUZBM2ZQOXM5RFNTM3VBa2Z5bzJrdkVWeG9ENXBRb0dv?=
 =?utf-8?B?S085Q29KdjNWbE4xK2FLWFlhUjVHZWxCK0JncGUxaG95alRnSDBtYTlzeXhV?=
 =?utf-8?B?TXJxOTlXVjFBbEU3NDRyUEgzL2dkTFBzcitpK3hhRVVIUEtIemJra0c5dzFL?=
 =?utf-8?B?bjlQS2lBVXJuZDVTS01nRndQNmR0RThpd2YzRGVHK3ZyOEk1VE02ays4SXlJ?=
 =?utf-8?B?WlFpT2w0Nnh0eDRKdXRjSXdJV2pFb3AvQ0FKTHFVNFJDaXIwcGh0MGlYRjJa?=
 =?utf-8?B?WjlJMnhuSS9hYUVjQkNFT3p6Z3A4RDZxWjhPM2w5QTd6ZlNoc3ZGSWZ0Z2Vj?=
 =?utf-8?B?YXV1R2pGN2tZWVIvNDU1bTRqUS9QOGVmb01vMWpESmtLMUhVV0UyTmhOV2NV?=
 =?utf-8?B?NnhWNGJGMlNJd1NJTnhUZDc3dFMvckNVODJXTTY5UlJSTGlDK2pkT3piVFRG?=
 =?utf-8?B?SnYxdjM2Y0tDMDFHcWF5YmdXeGV6dlZIUk1vYjVIZHE4WHRQeER4T0tCWXZ3?=
 =?utf-8?B?ZDc5S2xmMnZYVThiVGZlVTEvejF4azNVRy8yNlBaelVPeU1hdUd0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad9a2e2-d82f-4eed-ccb6-08df471008c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:10:30.4572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ijz/4kS4CpNBuESX9+2PFFdYyYAuDLLCqJLDjgxRlydK27CVVFzA8z/eSAt8C9g2myM2BPjrkOoZPjO5+Wjfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064



On 11/20/26 00:44, Basavaraj Natikar wrote:
> +Cc: Mario
> 
> 
> On 11/19/2026 7:46 PM, Andy Shevchenko wrote:
>> On Thu, Nov 19, 2026 at 03:28:45PM +0300, silverducks@altlinux.org wrote:
>>
>> +Cc: AMD folks.
>>
>>> The firmware's _AEI table on the Gigabyte B650 GAMING X AX declares AMD
>>> GPIO pin 3 as GpioInt(Edge, ActiveLow, ExclusiveAndWake).
> 
> Please share the decoded _AEI so we can confirm the pin and
> controller and point to the GpioInt(... ExclusiveAndWake) entry,
> pin_table[0] == 3 on AMDI0030 (i.e. "AMDI0030:00@3" is correct).
> 
>>> gpiolib-acpi
>>> requests it as "ACPI:Event" and amd_gpio_irq_set_wake() arms the 
>>> hardware
>>> S3 wake bit for that pin. The firmware then sends the signal a few 
>>> seconds
>>> after entering S3, so the machine resumes on it's own six to ten seconds
>>> after suspend.
>>>
>>> Pin 3 is the only wake signal the OS can see for the whole GPP7 PCIe
>>> domain, and GPP7 has no _PRW, so ignoring this wake flag is the only 
>>> way to
> 
> You say GPP7 has no _PRW. Can you confirm none of the GPP7 child
> devices expose power/wakeup, and that disabling wake there
> (echo disabled > /sys/.../power/wakeup) does NOT stop the spurious
> wake? If a per-device wake control exists, that's preferable to a DMI
> quirk.
> 
>>> keep S3 reliable on this board. Wake from USB keyboards/mouse and
>>> Wake-on-LAN through that domain is lost as a consequence, but I 
>>> figure S3
>>> not working at all is worse. The power button still wakes the machine as
>>> normal.
>> Hmm... And you are running the latest BIOS?
> 
> +1. If a newer BIOS de-flags the pin (ExclusiveAndWake -> Exclusive) or
> stops asserting it in S3, this quirk would permanently disable GPP7 wake
> on units that no longer need it. Please confirm the BIOS version it
> reproduces on and whether the latest available BIOS still shows it.
> 
>>> ---
>>> v2 - Put real name in signoff; Moved testing information to comment.
>>>
>>> Quirk tested on upstream kernel v7.4-rc2.  Also tested on stable kernel
>>> v6.12, which is the version where the issue was originally diagnosed.
>> ...
>>
>>> +    {
>>> +        /*
>>> +         * Spurious wake from S3: the firmware _AEI table declares 
>>> AMD GPIO
>>> +         * pin 3 (GPP7 group) as Edge/ActiveLow ExclusiveAndWake, so 
>>> gpiolib-acpi
>>> +         * requests it as ACPI:Event and amd_gpio_irq_set_wake() 
>>> arms the
>>> +         * hardware S0i3/S3 wake bit. The firmware asserts this 
>>> signal during
> 
> Wording nit: this is a desktop board, so it only suspends to S3.

Most "commonly" desktop boards currently are S3.  But some vendors 
configure S0i3 and some vendors offer both in the menus.

> amd_gpio_irq_set_wake() sets the S0i3/S3/S4 wake bits together, but S0i3
> does not apply here and your commit message already says just "S3 wake
> bit". Please make the comment match and drop S0i3.
> 
> Thanks,
> -- 
> Basavaraj
> 
>>> +         * S3 entry regardless of the PCI wake sources configured by 
>>> the OS,
>>> +         * waking the machine a few seconds after suspend.
>>> +         */
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_SYS_VENDOR, "Gigabyte Technology Co., Ltd."),
>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "B650 GAMING X AX"),
>>> +        },
>>> +        .driver_data = &(struct acpi_gpiolib_dmi_quirk) {
>>> +            .ignore_wake = "AMDI0030:00@3",
>>> +        },
>>> +    },
> 

