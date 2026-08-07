Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D32395AD4;
	Fri,  7 Aug 2026 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786080991; cv=fail; b=Y8UVxooYbsrzUh6dTAtZt9a1NNJM3Pc9x0f56WwG38IDlN4H3RNvmqZ2kjfbeo2stxv2Nqm8Fva7hpjle5F5QyoeCxkdfQpBdDF21U8kvetF56rmvYxLIn+rNR/zNmyccXysOD5HXck+iELdfYZFTtjoVlDs81QCrUJH94eLY60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786080991; c=relaxed/simple;
	bh=KNhfxWDdQgiT38JEnCeTLVy72dH8hALCs4iE8EP4ijA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JqLba9Yip2ERuNWUZGQT1ywNwZolSW2gVwt70MEvi/pcJXJ6QQ/u7pqpVMWr0HlKyuDGw0vHLz4zJT5yKLcjjKDq57gpgwNbMPXDgMzfTIShgLuL8G4Aw8VyZJk73spz32HWzIXLkr0NL+W0ogH/x3SHoYumoOs2NEk2WXDatAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TkFH+62Z; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TkFH+62Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yo0+nPEFjoKxRAFGx3pSR3nRnM3AUQZ9STDPacQAiULJtWAbxgOZzrDAkG0Ll0UUk+5mdfh7aEnVp6Fl6STMRiRIRLQN1jubfdeqLAD0DlFaJKgEyUQS37deghuMM2Ki4hBd02/fMLmWK58Imf0vx0inGClOCUqASsM/CYvPVzwvjjwjsDlTpZOwGtDc595X8cPO4O7vrgJF/dDPnCQ8mFOoJAGXinw/0stcu+fb5pbjERJ3CVUNsLpJXM02o7wIEFFgptWcXEoGZ0WhPhBppEf9m2B2iL85ETDa4aZeFGuGPYKVp/PZ1XqZ4LO/1Iqdp1BhMSOsoOWELmoHiBKhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gINZ/JRrbyf4YhFSM1cWF7jV7Sk6a1IxdSENxCtoVw=;
 b=LinzdhokAIUE0+uor38txU6N6rBVEVxTIFHGMZGbg5HOjUpNvGov28h6fCGrpg5sQVeYDodR//tH4ViPuWrTXjyhhsot63to22jPMZENibBrB6xtG4KwOD1FhaJMUr3XctslQrKyY0KF4qoDDLwqKC6NE7nOTTw8zAxQjUw2Ss+3kThA9PYASUuLmpFk5nIzWJq0rJBEaKRgC21/0KbMUj5LxOkIIOsAa8y9aCG8X6QIp2ZPPbXhGGoADPzfHtIzrK7B+rcy60kUQ9fHP5cTEqdSOLrQhlWgmREBiCoDMsS61Ql4IynhI15gRdgijp8f5hdGsqaF+ja8PBt/wZVxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gINZ/JRrbyf4YhFSM1cWF7jV7Sk6a1IxdSENxCtoVw=;
 b=TkFH+62ZrHgaqM3tykqaygD5nnKPZ8VFkXRWMTdoJQvIiXAwstSGmC6fqBi27RGyOmR53BQo5xdXRHxbpELsSdQ3pr2fasa8HDtTKG+EDgOKJW30kTZ8lJzdopjknciD2w5gpUfdW02dPhSesqhsrb76eho3MPjkVMK2YZhPBZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) by
 SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.21; Fri, 7 Aug 2026 05:36:24 +0000
Received: from DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587]) by DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 05:36:24 +0000
Message-ID: <054a8997-3578-4d8c-9e8f-2556e9999819@amd.com>
Date: Fri, 7 Aug 2026 11:06:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iommufd: Fix NULL pointer deref in
 iommufd_ioas_change_process when racing with iopt_map_file_pages
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, kevin.tian@intel.com,
 jgg@ziepe.ca, joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, steven.sistare@oracle.com, stable@vger.kernel.org
References: <7344B7A7B9957A65+20260806045059.1884737-1-peiyang_he@smail.nju.edu.cn>
Content-Language: en-US
From: Tushar Nimkar <tunimkar@amd.com>
In-Reply-To: <7344B7A7B9957A65+20260806045059.1884737-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0127.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::12) To DS7PR12MB9475.namprd12.prod.outlook.com
 (2603:10b6:8:251::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9475:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 5326bf13-61cf-49b2-7947-08def445d1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MiUN7L4NGEl28yZH3r38Jrtyr30ZB9UcVRMmFh7zXhWIslrDqvWgNWaiGUdYdg8Fc5QoYjrNeWYfB29rHaa+qRfG+iyaaodzhpKIh9DTPEWbH26e0gmXhBTEwUHTVcS5SwfmXw8bpVEdc80U1mY4r4RHRN+8LcwRSdA2folyAU14g6crkwdanNx6mWIEhX/sQAF7NEWH4F/jJnnqpdWbeTqR8nohgF7nfdrvO1B6tcxvt/9/lqxo2sLIhCd1ffuras8g9OumSf0f6HyHQN9w91FmNIiuig7b3DlOvxazkh5skDA5VieYExllhWY/L10K11CTqABwZFDXewM3eyBQfq6yZqrPZEWIIyZuZmvY+vz3YuQSaMbrhNvBJHvFiL10/UqKR4YxGla4wE4t57pAlzMKUyq4xXVsnq9CpHoj+jkQBQOUV72Ym80w/Eo8CGJmBwrgXOMwLdrmaNtvcIR77eOUi3O1ylNL7zdA6ZfGFpAfIA67wG4tPM6KOyaCiSBP4vG6LTnCiY+N3eZn8VBGoXDZREgHdL4dBSVe+fBnfsDF8x51faMigEYMCG/TeoUXIlr09yG4YsKFhClMoHzakmrRuFeoEdmMApJy2ZeU61xcrXpEZZ+x1Ds7nclvF6rmPo44aBpdBupExvX8ztLe3ZcqHEQoIxbSVI9YYuEHWLA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9475.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWhwSTZlcU1KZkU2NnJLZkl3WUIyM2hzbURHL0ZkV0lCYmtKSU1BN3EyeXRE?=
 =?utf-8?B?VkhXczYwdG5SMjNHRHRoYWo1K0dpbWRzcUJYRTUrRTZldm12Sm41VUVqaTN6?=
 =?utf-8?B?NHhUbzhvUytQL2M4NjZDRXNXaFVvWGtobzcwQkhjUlBSdU1HV2x3OW4zM3d4?=
 =?utf-8?B?REMxd1UwK1pURE1HYmJwMVdjT3hRQmFrWm9OV1hScE00OTIrRlh1Q0hFWVlT?=
 =?utf-8?B?ekNaVDhBVTFacTNXejhZVEd3amYxS25xSTRHakc3Y0poL2JoY21aYmtSVTBK?=
 =?utf-8?B?blc4MkhHOWVrZnh0SStUYkM5ZWZuRzFCU0tsZjVqRlhiNWgyMnc2ekd0cGlG?=
 =?utf-8?B?eXIyRHBWYUo0c3ZtMjV6NjhHbituTWpWbWdzSjVhOHhZUU1idnVOb2pydTZM?=
 =?utf-8?B?Qm1wa3gxaE41dEVpRHpha3hUR0wxZEFadk5wb2VlVTVIZUcwYW9PNVg1c3dH?=
 =?utf-8?B?Umc4NUp1NUxMQ1hxQ21mYjB4K0tXa2tFNHYxS0h4NFY0MFcwMjN2ekJEdDVa?=
 =?utf-8?B?N0pqMnhTSEVPeEJReDl4MC96RHZ0TWE3dkJ5L3lxUlJyekZvVlBYY3hDcStw?=
 =?utf-8?B?S2ZtS3hKWENSTVVQem9aV016WXlKRkJ3N0Vac2RjM1l3cXRSbG4wQnNjZXpt?=
 =?utf-8?B?Z2toeElsMkkxRmZoMDl2cHI3ckN5cmlUM0RTYjVua1NNdm9lcy8yVDg5Z2Ux?=
 =?utf-8?B?N3Yya3JSdDlwTzNtTzhqQjVJcHMvbnp3WC9Jb0puMEdSaHQ1L2FHdWxJa0VE?=
 =?utf-8?B?WGxDVlh1OHVWQWVBbGFTdDhpTFdZNGhMSXdlcjVhVlQxbEpCaXZDMDNPNXRh?=
 =?utf-8?B?Sll1NGVjNmM4UiszQTB3bVA0Lzg4SWJGNk1sTnpNWXFVc25QOEF6MUR5aytY?=
 =?utf-8?B?L1VZQVVlcUZnOVQyM2ErNHFYd1ZPOGhZZlJVMDdCd3NVWXU5V0dhWmxMWnJB?=
 =?utf-8?B?SytxUG8xRnZaRWljNW54Yml2aUVadUZPV0ZWZFhwZ09ETnM3eVI5dkpWS3pa?=
 =?utf-8?B?OHJMdlcrR2hyNzVQZnBRWG5OejkvWUJPcC9SOWRhbHlJcTF3aCsvcWZNT0Zq?=
 =?utf-8?B?bk5PcnZSOVRVZWMrbUt4MG1YVXFhY0hMemI2L05qYjcrSFExeHVXKytnTmNJ?=
 =?utf-8?B?cFVzT3ZNa1FXQlovUTF6Qmc2cGtzY29nN01MZm91WmV6dW1acStqamt4OFll?=
 =?utf-8?B?S01XNnRqZzA2RTNaK0lRcWpYYzg2MWJCK3ZqenNwSzdOSDJqbGYyQ0JaUWcw?=
 =?utf-8?B?MC9oTGZSY0xIZjVKcUdxS0VHK1krSlpuTGhsS0hnTlVWRzVkdDZ6b0N0ejhz?=
 =?utf-8?B?Ty83OWIxTGpPaWdIbkl0VTRmWGJmM2hlbE0yTHNHNEFnTGNRQlRPWGVORURt?=
 =?utf-8?B?ZnZUQVl2L3ZxQ1FsRnRjNnZwYkNGelZaZ0owTXVmRmVCS2dUWGxISENRSWwz?=
 =?utf-8?B?bHA2RjZEV1lsU25WSG9qdm5HTkJ6Ry9aUlJhVUxkWlA5aE44T2Q0eU5qcm5H?=
 =?utf-8?B?TzZkeXVzSmx1ZjZseXpOUklURjFlK3JzaE45NVBPNHVZaGQ1c284QnlLR25P?=
 =?utf-8?B?WDdrRk8vb0FGdGFuK2VBY2hpaWtrMmxIVGtkY2kyS3ZjOUpMNVlycHR0K2J1?=
 =?utf-8?B?cTVNR1JkLzVrcmN5OGZOLzlUOUVnYjVQV1F1QjVFV2xiM0Jva1BXbG1ZM0kv?=
 =?utf-8?B?TnFXZW0wL0ZRaCtvdnBnQ1R0R09rV2p2ZGRjRG5tSTZVRU9MNm80dk55TjNG?=
 =?utf-8?B?SWhSaG11Wkx0L1ZxWnVnajFQYWsvRTZrVGFYUTdTdUdFejlJZURtZ2ZpM1RC?=
 =?utf-8?B?SUNaOC9teGN6OHlNc3lweFc5T1JlNi9SYzhhS1d6Yis1cjQ2dTFKb2tlNm5Z?=
 =?utf-8?B?dy9vWDYzTUlWYmc5RGNwYU5rcUFtVUZPa2FPOEcwOGNtR0MybUlPWW5IcFFh?=
 =?utf-8?B?QmwrYnEyK25ZakZuYndET1k5QnZucHNuNlJJUVB1eU9acEZFUXJzT0FrMmFD?=
 =?utf-8?B?aG9DdXB2VWo5ekxJL1Y2ZnNsU0FhMWRlZ0E1R2oyN09mUFplZSsxZGhCZ3lT?=
 =?utf-8?B?Q1ZGdzB5eHVzZ0pBRk1vN01zZUhUSndpaXJHMzVRVmRVZDZmRUtxamxLakIr?=
 =?utf-8?B?OU42aWpiWDJKM2ZjL2ZQK3M2TU9lYWd6ZmFidExnNDVla28waFg4WkxiOS9C?=
 =?utf-8?B?UHp6OFhUdHk3UlRXNVlXeVNzVjJkL3p4bFNLLzh1eXFlNVJ6R2gydGJaZ0NM?=
 =?utf-8?B?NUJWQkE0cE4wemVMUXlyVFVsNjhtUStTZXNuUnZtNGJldnBjL1Z1M3l5bzFC?=
 =?utf-8?B?S3htdnlrL3RTbkc5TE81Rlo0eGlKQ29ORTlUajdhU2NNNU5Ub3kzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5326bf13-61cf-49b2-7947-08def445d1e4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9475.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 05:36:24.6256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlyJC8r2lVOMvtAjmws72L2Vo9iUaW+6uaEHkETLpa+YCaHe4G/65khW59MubFhgsvfG5Ij32+8s6gUi9XUTTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719

Hey curious to know,

On 8/6/2026 10:20 AM, Peiyang He wrote:
> [You don't often get email from peiyang_he@smail.nju.edu.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> iommufd_ioas_change_process() iterates every IOAS area while only
> holding every IOAS iova_rwsem, so it assumes every area has a non-NULL
> pages pointer. That assumption can be false when it runs concurrently
> with iopt_map_file_pages().
>
> iopt_map_pages() executes in two phases. It first creates the area and
> inserts it into the interval tree under iova_rwsem, with area->pages
> still NULL. It then drops iova_rwsem and later fills area->pages
> under domains_rwsem. This leaves a window between area creation and
> area->pages fill where a concurrent iommufd_ioas_change_process()
> can observe the area and dereference a NULL area->pages pointer,
> leading to a NULL pointer dereference:
AFAIU, the flow must be

iopt_map_file_pages()
         ->iopt_map_common()
             ->iopt_map_pages() <- here it does create and write pages ..


iommufd_ioas_change_process() <-the page pointer is being accessed..

1. Why IOCTL got triggered before setting the respective functionality ?

2. Since here unlocked_ioctl() used which means driver should have 
manage locking as user space will not hold global Big Kernel Lock  (BKL).
      We have pages->mutex - do you think we need it some where instead 
of "-EBUSY" return ? - if yes can you try and repro ?

snip:
  *
  * The locking order is domains_rwsem -> iova_rwsem -> pages::mutex
  */
struct io_pagetable {

---

         down_read(&iopt->domains_rwsem);
         rc = iopt_fill_domains_pages(pages_list);
         if (rc)
                 goto out_unlock_domains;

         down_write(&iopt->iova_rwsem);
         list_for_each_entry(elm, pages_list, next) {
                 /*
                  * area->pages must be set inside the domains_rwsem to 
ensure
                  * any newly added domains will get filled. Moves the 
reference
                  * in from the list.
                  */
                 elm->area->pages = elm->pages;   <- maybe page mutex to 
protect this ?
                 elm->pages = NULL;
                 elm->area = NULL;
         }
         up_write(&iopt->iova_rwsem);
out_unlock_domains:
         up_read(&iopt->domains_rwsem);
         return rc;


Thanks,

Tushar Nimkar

>
> BUG: kernel NULL pointer dereference, address: 00000000000000c0
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 4b655067 P4D 4b655067 PUD 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 11841 Comm: syz.1.628 Not tainted 7.1.0 #3 PREEMPT(full)
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:iommufd_ioas_change_process+0x419/0xd50 drivers/iommu/iommufd/ioas.c:538
> Code: 48 89 c3 48 85 c0 0f 84 cc 00 00 00 e8 10 f5 cb fd 48 8d 7b 68 e8 a7 b5 eb fd 48 8b 6b 68 48 8d bd c0 00 00 00 e8 17 b2 eb fd <8b> ad c0 00 00 00 bf 01 00 00 00 89 ee e8 85 ef cb fd 83 fd 01 74
> RSP: 0018:ffffc90015c17d28 EFLAGS: 00010246
> RAX: ffff8880186d5328 RBX: ffff88801d25e240 RCX: 0000000080000000
> RDX: 00000000000002d7 RSI: ffffffff83ba9e10 RDI: 00000000000000c0
> RBP: 0000000000000000 R08: ffffffff8e781eb8 R09: 0000000000000000
> R10: 00000000000000c0 R11: ffffffff83ba9e29 R12: ffff88802e216008
> R13: ffff88802e216000 R14: 0000000000000001 R15: 0000000000000000
> FS:  00007f4aea3f66c0(0000) GS:ffff8880b1fa1000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000c0 CR3: 000000004b75c000 CR4: 0000000000350ef0
> Call Trace:
>   <TASK>
>   iommufd_fops_ioctl+0x287/0x400 drivers/iommu/iommufd/main.c:533
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:597 [inline]
>   __se_sys_ioctl fs/ioctl.c:583 [inline]
>   __x64_sys_ioctl+0x120/0x170 fs/ioctl.c:583
>   x64_sys_call+0x1092/0x1fb0 arch/x86/include/generated/asm/syscalls_64.h:17
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x10a/0x680 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4aec1a82bd
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4aea3f6018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f4aec436090 RCX: 00007f4aec1a82bd
> RDX: 0000200000000180 RSI: 0000000000003b92 RDI: 0000000000000003
> RBP: 00007f4aec250295 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f4aec436128 R14: 00007f4aec436090 R15: 00007ffd04ef23e0
>   </TASK>
> Modules linked in:
> CR2: 00000000000000c0
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:iommufd_ioas_change_process+0x419/0xd50 drivers/iommu/iommufd/ioas.c:538
> Code: 48 89 c3 48 85 c0 0f 84 cc 00 00 00 e8 10 f5 cb fd 48 8d 7b 68 e8 a7 b5 eb fd 48 8b 6b 68 48 8d bd c0 00 00 00 e8 17 b2 eb fd <8b> ad c0 00 00 00 bf 01 00 00 00 89 ee e8 85 ef cb fd 83 fd 01 74
> RSP: 0018:ffffc90015c17d28 EFLAGS: 00010246
> RAX: ffff8880186d5328 RBX: ffff88801d25e240 RCX: 0000000080000000
> RDX: 00000000000002d7 RSI: ffffffff83ba9e10 RDI: 00000000000000c0
> RBP: 0000000000000000 R08: ffffffff8e781eb8 R09: 0000000000000000
> R10: 00000000000000c0 R11: ffffffff83ba9e29 R12: ffff88802e216008
> R13: ffff88802e216000 R14: 0000000000000001 R15: 0000000000000000
> FS:  00007f4aea3f66c0(0000) GS:ffff8880b1fa1000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000c0 CR3: 000000004b75c000 CR4: 0000000000350ef0
> ----------------
> Code disassembly (best guess):
>     0:   48 89 c3                mov    %rax,%rbx
>     3:   48 85 c0                test   %rax,%rax
>     6:   0f 84 cc 00 00 00       je     0xd8
>     c:   e8 10 f5 cb fd          call   0xfdcbf521
>    11:   48 8d 7b 68             lea    0x68(%rbx),%rdi
>    15:   e8 a7 b5 eb fd          call   0xfdebb5c1
>    1a:   48 8b 6b 68             mov    0x68(%rbx),%rbp
>    1e:   48 8d bd c0 00 00 00    lea    0xc0(%rbp),%rdi
>    25:   e8 17 b2 eb fd          call   0xfdebb241
> * 2a:   8b ad c0 00 00 00       mov    0xc0(%rbp),%ebp <-- trapping instruction
>    30:   bf 01 00 00 00          mov    $0x1,%edi
>    35:   89 ee                   mov    %ebp,%esi
>    37:   e8 85 ef cb fd          call   0xfdcbefc1
>    3c:   83 fd 01                cmp    $0x1,%ebp
>    3f:   74                      .byte 0x74
>
> Fix by mirroring the handling logic in iopt_unmap_iova_range(),
> i.e. return -EBUSY if area->pages is NULL.
>
> Fixes: 829ed626499c ("iommufd: Add IOMMU_IOAS_CHANGE_PROCESS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> ---
>   drivers/iommu/iommufd/ioas.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index fed06c2b728e..71bffece84b5 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -535,6 +535,10 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
>                  return rc;
>
>          for_each_ioas_area(&ioas_list, index, ioas, area)  {
> +               if (!area->pages) {
> +                       rc = -EBUSY;
> +                       goto out;
> +               }
>                  if (area->pages->type != IOPT_ADDRESS_FILE) {
>                          rc = -EINVAL;
>                          goto out;
> --
> 2.43.0
>
>
