Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4F33D509;
	Tue,  9 Jun 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014950; cv=fail; b=OuLTakXgu0k2NnoHh8M2lZNW7iQp8P/ohRepUxNrfcdH6tOisSsxMwL3I/2EM4rP1VppwgEBtaUtwtHfOGjawQC+HHrF1g8JpS2Hb6Yp3rx2WcbdxM9Erp+ahFQWxc66J5xdmE/fM91nN5UZDcB27uQEzNz+70DlU/jr1H2z+js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014950; c=relaxed/simple;
	bh=F7yni4SyKU0b361OdR0N5AM8VEAYH1+ttY2RApei5nQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kttnjCUzwQ8a/QdqB3U3tDlUIyGuZJ9rvEkvTWp0kaP4vUDy8+tL95GG2p7eYo/a1JvjCe+PykhCJcqPY6s4Wo6gqon4XUUmjZO2WSv0ESdRdOdHZL/Yyh2o5FpQRtbMPDJ5y5/QAI8aFDeKmrYCsOSZmj+vNh/88Xp5arx+z+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MqgQ7PSz; arc=fail smtp.client-ip=40.93.198.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MqgQ7PSz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrqFahpZc/os9A4vL1QKtwLxMDcroSV+5FuDrrCJvXfQDiSosQnZPok1dMzUhNHZ7U2HkFN8FzDhhu9+9IwR90fhj19JciNWEuhDJjlfBVeaqcwY64tuftkdqb0kaxo66LrfMsdWjcDBxMmK4SCOYwbAllOnALMkCdud89+EMgTpm6a7w645IzLKASpnMSNB8T4lMAOxwqAPs4m/6bu547L3wS7BWbZuij7aA3in3Fy/bJ++ee/CrH5BN7d9N7kPfEnR1+zbvSnQvQccH+GQUE2xjsHNuO7VCTd3jSNTBm4Tw/UlmLlCnJQYEHyBd7XOidzZlXjaAR3lsZQArgEOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeWXbg17q1lykqo0t0oHe6HbwqHsGrXiCUQwYSiLJM4=;
 b=ABjBR/pLAoq7uVRUiCNMp4qX/7O9Z3psbqaAZ2d5TWyagy49OBBARQzCii7DBSl+WUXkMDQY7lucrE33Q/uZrSNMDNCRJ7mKRRAf9igThuPFL3ZZaTigMGdFLmgmho4WaBxOpRAmeH6whk5Y55xdj4bxEHgpw1kvTNHGE+CCaw7Mau5av+pc30Es4ID3Uu2Ttn1wZtZqi93q2pr2hRHVL8BOvnUVqkDhxGOmO57F3HgUg0y6DA/NaLrQTkr7e9t7alBv1Y64Lm4/lAFn+s6lZuykvdSYAbOtpJNhi1DUE/HPamOhC+a37rPRVLJyAvmNmTYrVV1XF4xSPtnDo1Y1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeWXbg17q1lykqo0t0oHe6HbwqHsGrXiCUQwYSiLJM4=;
 b=MqgQ7PSzoaUhXRL3yxFNB8v5umjYkphLHsjCvOnc1x/Wgfh+Je3iHLdca9/M3EPCohj7E9miw60l8VvH+0a7d6rayP1HUxSrxxa8P24XOeo3FXn3pEwaaIU4hREUygSTY7umkh62oc4QwqegdSsbC6C5jU+hBMHs1RcmMIVAMtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 14:22:23 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:22:22 +0000
Message-ID: <eaf8f1d9-5557-44cd-9013-0b452310d64a@amd.com>
Date: Tue, 9 Jun 2026 09:22:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/port: Fix missing port lock in cxl_dport_remove()
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, ming.li@zohomail.com, rrichter@amd.com,
 Benjamin.Cheatham@amd.com
Cc: Smita.KoralahalliChannabasappa@amd.com, stable@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 PradeepVineshReddy.Kodamati@amd.com
References: <20260608223533.583278-1-terry.bowman@amd.com>
 <be149ddc-702b-46c2-b6a7-d9195aee0eee@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <be149ddc-702b-46c2-b6a7-d9195aee0eee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:610:e6::12) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: b11671b5-48b6-49ec-017b-08dec6328548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xhUPwcvMYXyOAKwpgcj2tKtOSN5Rw7ONATeANkVEBXSwG9lqI1HsI2mzYog2A/mSC6F1P6Di+6iZQ0oiDxNtHTzvwvCvLqvoV4QvkvgrdmmNlLw+l2030E3zv+HQAiusqAqQUHSakV5jZSthtPbKndLBaJHvSnCNHjFwYpRgaSlmRZfNO9OE8ZJbkzo6LEwh9Jo5hNyxx2rEkvUzNk5S13/FMb3kKFSNdeX1xyYJnWt076wZkZg3yubWaDUBsfkVSxvzBVxqG6gEHR4gaSANC3aZw+xpnSqMdfP5fF7Kw4ObAqRFxdCv8IOAL3+HWIxchtqs6bpSn93rvm/le86DmZTXUgqzzRPPq4aLmHveXxnmdIApUtZlB+aQqXDN/WdRRw24KCBJ1WyU7eXNs3VmskYXdgGRFqyRaBqXaKKFvkou1b9BuIEvD14dIoWcSSwEPfR+dX/J/7saZvAOQfUK/JnMW4Qbtz+qfF9wbMhmPSUsBxnhNjmkyqJlxBSToPlmvHswFNA0C0mf4xRVffEMBwNmPZQ9v2j/s7K+2DlCpJ13FENzBko2xBml3FviHBZrS5a78F4Be8gKhIjReWUZYJRAHnbh9c2GnEp5B2rEk9au0H87n9LJMQuwVJUC14lId0h74STTJn04nJF+L1yTlIFb1WXHccLr4b/8TypVaFckoma8nX5DYvre0YQ5TUvQKUHy3gXChHf1rsVxu9cdVgnWt4zjZT/QVEIcTaAJ0KCb1gXHWRJaUKd6geQgaXe7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVk1V242eUNLZEdPVEFvcEpYR1c2bmJzdG9xb2ptY0U1TWNRZlRmTlNFdHJR?=
 =?utf-8?B?bDlkU2Z0YWZJZHNvNnJCZm90U00zdXl5VTJiQlJ3V0F4ZkJUUE9vdWJTcFVW?=
 =?utf-8?B?REJ3OElPWlNPSWcwS3hDTzdQV2pwdko4bnh6UTVJcnRHUVdmVlZPQkJKQXdu?=
 =?utf-8?B?TG9oN2c0c0lVdkE0YS83QjZrQXBENGdaUzBVa0JCQ0dkd3lZN1Bkam5JeG9j?=
 =?utf-8?B?N3d5aGE1Y3Uzb3NRUHpmVnhvcFRjSWRHSnk5U3ZRTVh2VldZS2FuZGc2bU0y?=
 =?utf-8?B?V01KQ0hnVStVTnpSL1FGRnBsWWFpZzRXMitaVFZLa0U0OU13VlV3K2lQa3k0?=
 =?utf-8?B?cS9MK2hJaHZkZHdLSjNCT1NrekpZNzJ0b1d1QVI4TXhZdmtucE9tbmY4enIz?=
 =?utf-8?B?bWEvQmZtdHRrVVQxOWVwa01FcGNUNnZjV1h6R2g4QUZDdGdLQXh1YkJMR3d1?=
 =?utf-8?B?MHl0Tm11VDRRc1gyZjBkc0RsQldnS1NQb1BuQ0gxdGhHdjNwWU1TU3Vlc0V0?=
 =?utf-8?B?RW5QUmZQWFFIbHl0K0NiREV1Snp3Z0xFd3hRS0E5d2pZMW91dTJxMFVzeFJE?=
 =?utf-8?B?VldVYUY5MzlOdjk3bEg3VFZCVmt3NVRpS3ExclNKWmtZRllCd29odkNlbnEy?=
 =?utf-8?B?cDVUbEdBWlcveWUvaExjYll4K2dCTzJiVXRJZnBaM3hyVy9qMzJ2NG5nZW10?=
 =?utf-8?B?S2NSa2dqb2Nha1FmWWZSVUxyWHBTbUZMdGo1ZVljc20zQ1hKeTdNMTBZUWJi?=
 =?utf-8?B?K3d5aWFJTloyZTBqVjZmV1FtVjYzbGNLOGtNV2hJRnNuVFdUdnF4VERBaXVR?=
 =?utf-8?B?cHNLL1h2QUNPbWcwY0F0YU9WbW05Kzc2TFV4VHM4S2t1V3Z0Q0YvcU1paklu?=
 =?utf-8?B?WlRUWHIxQjZxN2ppTkZDS1JVNHVNKzBqQWhZK2p4TjgvREpZZjErVG41M1NW?=
 =?utf-8?B?TVNaNTJucjhXYnlZZkRHWmZkVUE2RUxzRWVJMEVaMEllL1FUYzhOM0pVd1Rv?=
 =?utf-8?B?MEtLQk9QNyt4cFM5aVRuUWFJa0xhNFJSeWFhL2cwRDVxbGdhS2h3Wk9zdE9K?=
 =?utf-8?B?T0dsV2UxTHFhNS9aM2RiZmdUS2MvMFJDZUpMalBuV0sxN0cwVElDaGJJUzJ3?=
 =?utf-8?B?WUFMeHhDVDVwbEg5NVNIR21XRzhBa0dYOUs2Uk9KMFNaYUxrdENYRG5WZkJW?=
 =?utf-8?B?bmYxdHZwazRGVnhXNjBxSE1pL095Y2FpeXBYTHJETlNjQ0ZHcGxzb2krTFFF?=
 =?utf-8?B?bzErV0dHNURCK1FJL2xwcHBKTjgrMW1FM0xQZEsycDZ3dDM3am9FMzlLalVM?=
 =?utf-8?B?YXdCM1NQbGFPZHd1MmZnSXlMZHdxK2RMaHBqZjBUZk5Fa2JyU2hXbDFNN21Q?=
 =?utf-8?B?TTQyQjhDWnFNQWk5dGhRaEpqSVR4eFBzbFJmL2RLNE5RWkEwNTc5SnJ1dW41?=
 =?utf-8?B?Z3BNNzhTZkFaY1QwTERQN0dXZndWelNRUGJsMFZRV0VMRlV5ZlBqRGVNNlFL?=
 =?utf-8?B?U3hNZ0orWlBrREJiK1JiS2FpRTUva2N5OGxudGhRUXpDNmdkWTVWSzkxQ2hU?=
 =?utf-8?B?am90ZnVwTTBBZ1o1dExsUE1Qb1FrOWxiQU9lVGpJdjJ5RDI4TWhWK3NUaksr?=
 =?utf-8?B?Tmt3KzBoRU52UUpPaXNVZnpYS1ZsVGI5UWNvZFhQQTZUc0Y3V2RuSFAvM0VR?=
 =?utf-8?B?S2NmMkNaYkQ2enQxNWdkNHk1TG5BWFcrUnJBZ0FJOWEzbXR5Q3dRSFBoMXVZ?=
 =?utf-8?B?ajd6OC9xQ2hBL1BFb3UyZmIwN2RmcEdoL0NMTW5sY1RUc0hVdFZTV2t3L0tQ?=
 =?utf-8?B?QStQK1ZXTS9rQUpPNTlrRGM2TFRJV3laZ1k3cS9uRVhacDBDUmxmRXpiKzEw?=
 =?utf-8?B?dmhaTHpOaTZabjlLTWxKQmtuRjd1UmhxdHNkTDErWmlmQ09SaFIzQkticHN6?=
 =?utf-8?B?UTA2YmowYjBrNGY3RkhNeFM1eDhkRjJZa0xzaWloQ2daSVRqTG56N2twL1Jw?=
 =?utf-8?B?QlorUGRYblpJOG9STzVUa21YZXpVbVVjYnIyQmF4ZXpFbEJWUG53a1dLSm1Y?=
 =?utf-8?B?SGZ2L1BtK2pPWnBob3Y2RnJwcGNHWVpWM2RXcHRVOVZtRGttRXhVbXBQeDNr?=
 =?utf-8?B?MjZYODNhR1Zhd0p5V0dpRlgyTDh5UXRudGpCeGk4cUZvVzg2TVFaSVoyWEtM?=
 =?utf-8?B?NEF4VW1kcUZMMUU4UGlqTml0SjhnOVF4Uy82NkVXaDIwd0NPbXkzanc0UThL?=
 =?utf-8?B?ZE9ZU0loNFlCMUZYOVpDQ2U1NmN4YWZhaGVhZXBGYkx5NzlCVnBjT08rVXUx?=
 =?utf-8?Q?6bEOGQYKe9t8Yyt4rE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11671b5-48b6-49ec-017b-08dec6328548
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:22:22.1744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoBgR3EQCcltESAFOR9XzWhLva/v5s/7G5WD1q1e0QZIf/B7BeCVW1PDjFp/TyMCjA5WLVYFMcpsxSk7nbwpuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728

On 6/8/2026 7:35 PM, Dave Jiang wrote:
> 
> 
> On 6/8/26 3:35 PM, Terry Bowman wrote:
>> xa_erase() in cxl_dport_remove() runs without the port device lock,
>> creating a race with any caller that does xa_load() on port->dports
>> and then dereferences the returned dport pointer. A concurrent
>> cxl_dport_remove() can erase and free the dport between the xa_load()
>> and the caller acquiring the port lock, causing a use-after-free.
>>
>> For non-root ports the port lock is already held by the caller on two
>> paths:
>>
>> 1. Driver unbind: devres_release_all() is called from
>>    __device_release_driver() which holds port->dev.mutex.
>>
>> 2. Dynamic endpoint removal: cxl_detach_ep() takes the port lock
>>    before calling del_dports() -> del_dport() -> devres_release_group(),
>>    which synchronously runs cxl_dport_remove().
>>
>> Use cond_cxl_root_lock/unlock(), which only acquires the port lock when
>> the port is a root port and the lock is therefore not already held.
>> This matches the pattern used in __devm_cxl_add_dport() for the same
>> reason.
>>
>> The write-side fix to cxl_dport_remove() is necessary but not
>> sufficient. Callers that obtain a dport pointer via cxl_mem_find_port()
>> use a lockless xa_load() and must not dereference that pointer until a
>> lock that excludes free_dport()/kfree() is held.
>>
>> For root ports, dport_to_host() returns uport_dev, so all three devres
>> actions (free_dport, cxl_dport_remove, cxl_dport_unlink) are registered
>> on uport_dev. __device_release_driver() holds uport_dev->mutex for the
>> full teardown sequence including kfree(dport). Holding uport_dev->mutex
>> on the read side therefore excludes concurrent dport freeing.
>>
>> Fix rcd_pcie_cap_emit() by passing NULL to cxl_mem_find_port() to avoid
>> capturing a lockless dport pointer, then re-fetching dport inside the
>> uport_dev guard via cxl_find_dport_by_dev(). The previous guard on
>> root->dev was wrong: cxl_dport_remove() releases root->dev before
>> free_dport() runs, so root->dev does not protect against concurrent
>> kfree(dport).
>>
>> Fix cxl_mem_probe() similarly: pass NULL to cxl_mem_find_port(), then
>> re-fetch dport inside scoped_guard(device, &parent_port->dev) for the
>> VH path, and re-fetch again inside scoped_guard(device, uport_dev) for
>> the RCH path. This closes both the TOCTOU window between the lockless
>> xa_load() and the guard acquisition, and the window between the two
>> sequential guards in the RCH path where a concurrent surprise removal
>> could free dport before devm_cxl_add_endpoint() dereferences it.
>>
>> Reported-by: Sashiko
>> Fixes: 391785859e7e ("cxl/port: Move dport tracking to an xarray")
>> Link: https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowman@amd.com/
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/cxl/core/port.c | 10 +++++++
>>  drivers/cxl/mem.c       | 65 +++++++++++++++++++++++++++++++----------
>>  drivers/cxl/pci.c       | 17 +++++++----
>>  3 files changed, 72 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index c5aacd7054f1..0b8f144596e8 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1092,8 +1092,18 @@ static void cxl_dport_remove(void *data)
>>  	struct cxl_dport *dport = data;
>>  	struct cxl_port *port = dport->port;
>>  
>> +	/*
>> +	 * For non-root ports the port lock is already held by the caller
>> +	 * via devres_release_all() during driver unbind, which holds
>> +	 * port->dev.mutex throughout.  Acquiring it again unconditionally
>> +	 * would deadlock.  Use cond_cxl_root_lock() which only acquires
>> +	 * when the port is a root port and the lock is therefore not yet
>> +	 * held.
>> +	 */
>> +	cond_cxl_root_lock(port);
>>  	port->nr_dports--;
>>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
>> +	cond_cxl_root_unlock(port);
>>  	put_device(dport->dport_dev);
>>  }
>>  
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index fcffe24dcb42..345b56f215ff 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -70,9 +70,9 @@ static int cxl_mem_probe(struct device *dev)
>>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> -	struct device *endpoint_parent;
>>  	struct cxl_dport *dport;
>>  	struct dentry *dentry;
>> +	bool rch = false;
>>  	int rc;
>>  
>>  	if (!cxlds->media_ready)
>> @@ -107,8 +107,7 @@ static int cxl_mem_probe(struct device *dev)
>>  	if (rc)
>>  		return rc;
>>  
>> -	struct cxl_port *parent_port __free(put_cxl_port) =
>> -		cxl_mem_find_port(cxlmd, &dport);
>> +	struct cxl_port *parent_port __free(put_cxl_port) = cxl_mem_find_port(cxlmd, NULL);
>>  	if (!parent_port) {
>>  		dev_err(dev, "CXL port topology not found\n");
>>  		return -ENXIO;
>> @@ -123,21 +122,57 @@ static int cxl_mem_probe(struct device *dev)
>>  		}
>>  	}
>>  
>> -	if (dport->rch)
>> -		endpoint_parent = parent_port->uport_dev;
>> -	else
>> -		endpoint_parent = &parent_port->dev;
>> -
>> -	scoped_guard(device, endpoint_parent) {
>> -		if (!endpoint_parent->driver) {
>> -			dev_err(dev, "CXL port topology %s not enabled\n",
>> -				dev_name(endpoint_parent));
>> +	scoped_guard(device, &parent_port->dev) {
>> +		/*
>> +		 * Re-fetch dport under the port lock to close the TOCTOU
>> +		 * window between cxl_mem_find_port()'s lockless xa_load() and
>> +		 * this guard acquisition.  A concurrent surprise removal can
>> +		 * free the dport in that window.
>> +		 */
>> +		dport = cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->parent);
>> +		if (!dport) {
>> +			dev_err(dev, "CXL port topology %s not found\n",
>> +				dev_name(&parent_port->dev));
>>  			return -ENXIO;
>>  		}
>> +		rch = dport->rch;
>> +
>> +		if (!rch) {
>> +			if (!parent_port->dev.driver) {
>> +				dev_err(dev, "CXL port topology %s not enabled\n",
>> +					dev_name(&parent_port->dev));
>> +				return -ENXIO;
>> +			}
>> +			rc = devm_cxl_add_endpoint(&parent_port->dev, cxlmd, dport);
>> +			if (rc)
>> +				return rc;
>> +		}
>> +	}
>>  
>> -		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>> -		if (rc)
>> -			return rc;
>> +	if (rch) {
>> +		struct device *uport_dev = parent_port->uport_dev;
>> +
>> +		scoped_guard(device, uport_dev) {
>> +			if (!uport_dev->driver) {
>> +				dev_err(dev, "CXL port topology %s not enabled\n",
>> +					dev_name(uport_dev));
>> +				return -ENXIO;
>> +			}
>> +			/*
>> +			 * Re-fetch dport under uport_dev lock.  uport_dev->mutex
>> +			 * is held for the full devres teardown sequence including
>> +			 * free_dport()/kfree(), so this excludes concurrent
>> +			 * hotplug removal through the entire dereference.
>> +			 */
>> +			dport = cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->parent);
>> +			if (!dport) {
>> +				dev_err(dev, "CXL RCH dport not found\n");
>> +				return -ENXIO;
>> +			}
>> +			rc = devm_cxl_add_endpoint(uport_dev, cxlmd, dport);
>> +			if (rc)
>> +				return rc;
>> +		}
> 
> Still reviewing the patch, but thoughts on moving the two new big blocks to a helper function?
> 
> DJ
> 

Hi Dave,

Yes, good point. That needs to be done.

- Terry
