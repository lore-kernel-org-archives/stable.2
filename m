Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013049.outbound.protection.outlook.com [40.107.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AF4D2EEC;
	Mon,  7 Sep 2026 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800295; cv=fail; b=PFySN1LiO2uJrWZY3CPq/7aJZSCqGwVicyaoGNdJClMf2Uuj0ywJKXaw+w4E7xChfNkL7IX9yCAc2PWyZqBbYEajBVUs4fdR47dzIQ9Gx8kRQGsy3hH1EyoKXLXinYVuMizZ4T4iQBVj+D8GX46QGW0fypP8adlBVaIF2PZQot4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800295; c=relaxed/simple;
	bh=eMfbktzDNL+gk2PkVE/8BYQjIoc0ZEug9rKdXr+fivE=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=QYVK4DqKpRbTvnDQQQM+GKEmcuGmiOEOgRVovxQb2Kl6viFK/FIPAkbEDMUBU0BlrxDR5zII8GQZKFw28ounXXSPbbr8Lg7foNh453zx8oHYlb3dqsupziYbNNLtaGC9NAQC9siGWOmj1QdUuU6NJ05FPM/j+EzlJlWIU3+9QRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I4ulMRAB; arc=fail smtp.client-ip=40.107.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I4ulMRAB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjdo0kPfZf0pyseeowT12im6z4XrWYuOWL037GIGfwmPeKUPvfkpOcnJjMs4VrGKQ30WVxShxEAz2V8xYSzMTeSta9j03r/BFXNR4zGDcE5jxl/RJE/Jt0baeo2R3LykPNsR6tcOiHRiE8klxt9cPmPeHrFFoFHuyKhL2wDLCUSTr9p5nsKkiqLD4lfZzhhC0bpOE3Nju3ZkwtcDHHiGkOgg56aHnLMUvm0b3UaVlYQGaWDQQ+BnH3ePqXTEh/9EcSbYx3rxLJW3sb51og5oCv5q76Mj0igvd/a1qtEQPWx+OSDyyq761zgIg4n5o22AlIPzjcy6cIbWetTljCiMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMfbktzDNL+gk2PkVE/8BYQjIoc0ZEug9rKdXr+fivE=;
 b=kg3HR4Y6HxAZZxP0C3SMw9IFU1DWcPINQ7q3g3hrgEDjk7ZFXfu8uTRDm1Dh3SaqoGJKkDSkenvInHEvYMCstpUxWg0PnEstwIZvZ9p9qetBAFjH3nQ9tNYTUBufTk0+NUdfct0NaKHnGjUy93aW6hm+hahpWwe/VYPsE3UfJUWEbC6Hf4tf+WlB5elnFjwal8QZJFwJb7ZuZkVQlZBKlgs5RsgieuLi4tmbyxd7vptmIYRhog3XEgU6mN4HSbd4O8xwkQMvXg0g6lWFxTq3B0KOawwv4n3fjQP9UV3rVDvz2m0KdgV1FuZkAGXapIX0Xq9JoZ1nPX5iC99vtu1d1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMfbktzDNL+gk2PkVE/8BYQjIoc0ZEug9rKdXr+fivE=;
 b=I4ulMRABy3kDLIXqnH3I27IayDeD2HC8to8Ftz8W04JoYyn4V0MJqfhjVOPvmq/TAlhQZlfvwG9yeR5OyENHDdPR+1fRs1UoLmTq4IUDCftl2JTc9pl6CkX01/aC/7lHAf432xYIvAU2RPq9R5eSfe2bqmrQUXpjR/hECTd1uJiCioD57ClbLPiC+cjThetbOwm5alUgETu4fef8rwnrzYLORLC7pETJWMGrEdC9+HfasHQ0q39ATkd339Gts5CL2XJIVmFW+jZiEuFi8TgG8n8Pr+lyb/yH0EnQs/Iqdm8BChit/2BLyr4Vbzix6dTFiDqI0SIpzjM/9XAPCupR+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 16:58:08 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 16:58:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 12:58:06 -0400
Message-Id: <DL98S34F6I6L.12UZGOT6NF1J6@nvidia.com>
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap
 mappings
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
 "Nico Pache" <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Usama Arif" <usama.arif@linux.dev>, "Peter
 Xu" <peterx@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Cedric Le Goater"
 <clg@redhat.com>, "Saravanan D" <saravanand@crusoe.ai>,
 <stable@vger.kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
 <DL08J4JGJ4UK.2G92WO0NK8XU3@nvidia.com> <apEzvfGgsvbc3vBI@gremlin>
 <dc52dd1d-f62d-4278-ab4d-95746383fd50@kernel.org>
 <ap7i1vLkfZj4rbNM@gremlin>
 <4743f22a-c24f-4f93-80f5-3260f29bd410@kernel.org>
 <ap7mZ1Ktd_rRRrdX@gremlin>
In-Reply-To: <ap7mZ1Ktd_rRRrdX@gremlin>
X-ClientProxiedBy: YQBPR0101CA0256.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d364c5-76ae-4ec7-b884-08df0d01314e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	h73VlNw50rd+BL+MBQQfwappLmbPTvmcVB/J3PZfX/5uC/9SNBQ+PckdTzhX1MnSaBirDKQzahLTWNra64nK506edsMxD6PabMtHZxvZTxbANBleB3/mSFk3KwrtdUp4B8iZxUarvvC9valvf0/Yx36WBDDDkdqftLjQDiDoVxfFoW9ETJdIYwbqiBOZBzHkMerPVnyxOyDwv0/BpxuCaVRKP/E2KLIw1QCaW5DBapkSECSsZ3kjKnF6+10prDapMmXLf+kY01hZaQdrCe87JczjJxKYheBxDmvjMhtIiTpKfbTlKzXASB8y8CD5dXiUTAWueQunupEG6/yCUGF6WjII+JTJAW4bkTuLM6z/HKyblT+yp19wfol9cH06i+jSA5FczEiYbrcXlqq2GX1nsMakFuHY67WK5R0U76gJICTh6XGJNlrnnHO8rV9gXd5ojukNx3Bs67zz2BGbt/UxW/S9QLaa9Y/1QcKBLuA0jDQXqa0dtikiY862Cle7zefGxBInVSiMdzQyyDiEjRF5snU1FH5YNErLY91STJMVGePYM86khUfCZkDSh8bX2Yuxrs34dtCI9vPNLNQ8NdCE2lk+nnDVcg1S9lXaXfQCrs86AOsPSmlfr7bI5JOttL7ft7wczcoo25IdfjPYbGeH1JHJYQd477ZYmJlvWmM/q2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SktrWU10UUdGWDRzN2NoL0xnck84MHpBQmFDMkt3dEU0ckFVYnNGRFFSYWQ0?=
 =?utf-8?B?c1hLRXl1aW5ENklPUlltK3VBZWo5cSt4ZkFmZHJmVmRPVHlHVlJSa2F3Y2ZE?=
 =?utf-8?B?MEJ1cDlyZzVWKzQ5REFPZkQrNndpdWtTVU1GcE01UXJjM08rUU04SEhCTXdI?=
 =?utf-8?B?eTBXUzhLWnpJK2hubG9yL1ViSStmT0IxVlRQdGdvckNIL3d4cnpHMGhCOHEv?=
 =?utf-8?B?c2V1eStIREZuL2dMYzZieTQraXJFZ0x0SmYxRmphaWc3ZGFnUjg1UllEN2tq?=
 =?utf-8?B?OFJsZXNSQk13UDFmNjcrajR0SFIwaFlTMjgrY3hTcnNmdFU0UTkwWG1DWDVP?=
 =?utf-8?B?ZVU5VTg2WHk4ZzhvdlFVblhnYW5xTHcxRkoxaFZMZ2xudTJKZWRTWjJiRC9L?=
 =?utf-8?B?NTd4MEFKbVhoUmdxcExnOXQvNE5zZHhPOTZId05EODM3SlgzV2VrZ2h4OHhB?=
 =?utf-8?B?ZjEvUVF3Si81U3ZxTEQ0dDMrVCt4Mllvd09XM2tyMEduejRCQVZ6UzFzcmNy?=
 =?utf-8?B?NmVsSmtWVnpud2xUV3k0aUFzRWUvWFl6WGFRbk1PL0h0d0tyT29JallhejBW?=
 =?utf-8?B?SzNRTDQwU0tSeVliSW1Ed1hqMTlLQk9ibFpGSEU2SjNmZkdXQ1daUWRmWitr?=
 =?utf-8?B?TEQxQThJNmZUenBXOU9ObnVpSHBRakRBL3k2OVJ3TzNWOFpCd1ZPd05SbFBX?=
 =?utf-8?B?M2lENUtITG1FdjhQMklrallOK0RpUUV2WEhkcUJTSXpPeDRQZFVXOEpxRHJo?=
 =?utf-8?B?QjN4RTNvSW5yZ25XRllqcTdOdldSYzNrSUdWRU5mVy8vcER6VHFpUTFpdUdw?=
 =?utf-8?B?bHhra0F4VmtKbkIwTlVjR2NST0szMjZwVlg1ekx4V0dLNys3M28wa1V1TUR4?=
 =?utf-8?B?ajM1Sno5ODRuaGdHalJiS1cyTWdRNjdTR3dqcFllTXQzeVY4allhZFR3dW9F?=
 =?utf-8?B?NFFqeVpHQm0rLzNuQ0hJRWNzQ1A5eTFMcGNGSjcvZTlJaHlLazdQUjE0Snh1?=
 =?utf-8?B?aktmZVVBT1g1MlVBRC81dk1IQzFDUjJHa2VCRGwzUkJkdnlEZmVVZVdsMWo3?=
 =?utf-8?B?ZXhUSVhHVlY0eDlvUFJpMkRkRkRBWmRmOHliQm9ObUp1SjcrS0RyM05QMVRX?=
 =?utf-8?B?SEthd0NyK2xyYkF1L3FydG1WYk9heU81MDMyYlE4N05yWjlSWFRtRVQ1V3NK?=
 =?utf-8?B?V2lXcUpBR3JHSm9tYW9qUWhlU0VPTmdtN3E2KzkrMS9zdFo3ak1aVzU4S2Rn?=
 =?utf-8?B?eWxmUkNobCtheVdKWnd4aUVUNEZsaFI3RVNyYjU1aDR6cmhOcWdyRGRmOGor?=
 =?utf-8?B?SVdCdC8zOUl5d3JtUGpTT3JJdVRTdTZPWkxxVmZBdWw3TjZsKzRVUnBTZ3FQ?=
 =?utf-8?B?Wk5zVEcrNjBEL1BVdDU0K09pS3VZOVpKWjFoekN0Y2RXVG00dDBEcHRSL1o5?=
 =?utf-8?B?SUgzSi9mQjl6cnpPamdYMSt3c2cvSm5oNHdlTXZpUklQOGIxdURoMEY2SXFx?=
 =?utf-8?B?VzAweHZRbjVIeWdhME0ycWVSYjBKbWJXb2lUWVMxa2ZyTHU1MXluRjR1K0Rk?=
 =?utf-8?B?RmZOMlYrTlpHRDM4anlDV1NwMnZVUVJNNkU0RjBKeVBWWTJ0cmVEU2pwODhV?=
 =?utf-8?B?b0cxcXVKZ24yY0dvZTdLdVFqeWFmRW5wMFR4eDFGTkFwU2F4Q2EyQVNWdEVH?=
 =?utf-8?B?dkVLbmZvN0dxdDFTRXdUL0E3TXo0MFd0TkgwRXV2YjFIeTZiSU9kSTQrWlVw?=
 =?utf-8?B?Rjc0UnI5ZEx1T1FLcUtBUmZ6L1BkWjFWOEhTSTR5MU5tZ3ppamJQdU42YVpi?=
 =?utf-8?B?b2toL3ZYcU1xenYreVBSOWNpWFhCYi9ZOHQ5ZXhIU0E3cmN0RGFGaWR4c25D?=
 =?utf-8?B?NlJWR2tnclRWUWJTN3N4NEJaSW1lcDA5NHIyMDlKNCtVM3N2YWY3NXkzZVFo?=
 =?utf-8?B?d1gwQ2xEOUpZd0FKOGY1OGEwU0JxR3kyOWVZNlZzYXlON1BmUWdER0JjT2J0?=
 =?utf-8?B?KzU5aXB6cW9yR1NaMWd4Q2NPV1RGZkp4Y1B1YjlaZmtVTktSQm40N21JdG9i?=
 =?utf-8?B?SUd1bDdNTENFcDhNNnBNVDU0TUJROGN5L1h5NlQzL1pJWGFIODF2SkRPYUVQ?=
 =?utf-8?B?Y2VFM3g5RUFZU3hvTCtkcjRQR0E0ekl5MC9ucmhvdmtNc1MrOFM4TkRIN2Rt?=
 =?utf-8?B?bUFlUTdNUkQwOHNUb1lMSnNzd0V2UkpnLzVLSnhNV0djNFJVWHluZm4vdDBH?=
 =?utf-8?B?WEZ6NnpBWktTK1J5Si9kZFJVR2kvNHFrLzB0YjR4dFlxa1c0QVF3QXhwMnZo?=
 =?utf-8?Q?fEiEacQztpZq2cOCJ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d364c5-76ae-4ec7-b884-08df0d01314e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 16:58:08.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JX9E3K6kMZUrHc8/SGC8P2YTNMG2Wq9ttRVwSph6vdBt/tWkFljxFwin2Xyvx7uf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309

On Mon Sep 7, 2026 at 12:30 PM EDT, Lorenzo Stoakes (ARM) wrote:
> On Mon, Sep 07, 2026 at 06:19:30PM +0200, David Hildenbrand (Arm) wrote:
>> On 9/7/26 18:15, Lorenzo Stoakes (ARM) wrote:
>> > On Mon, Sep 07, 2026 at 06:08:31PM +0200, David Hildenbrand (Arm) wrot=
e:
>> >>
>> >>>
>> >>> That's a good idea! Much better thanks.
>> >>>
>> >>>
>> >>> Yeah, it's an annoying one as kinda want to say 'file-backed VMA' bu=
t I think
>> >>> you're right vma_xxx_file() -> vma_file_xxx() is better.
>> >>>
>> >>> Andrew - could you fix that up in place?
>> >>>
>> >>> Obviously if there's further feedback I can respin as well.
>> >>
>> >> Just as a general note I really hate these in-place updates.
>> >>
>> >> For a reviewer perspective (like me stumbling over this) this is just=
 a mess.
>> >>
>> >> Resending with b4 is as easy as it gets.

Probably worth putting it in the process documentation. Always resend if
a patch has any change.

>> >
>> > Ack, you are right to be honest, and I do empathise obviously.
>> >
>> > I will respin these in future!
>> >
>> > Let me know if you want me to respin this to make life a bit easier?
>>
>> Sorry for being grumpy. With 1500 unread mails, playing Hensel and searc=
hing for
>> breadcrumbs in my inbox is hard :D
>
> Tsk, that's not grumpy, you're speaking to the king of grumpiness :P
>
>>
>> (I did see some reply from Zi to an mm-unstable patch, but not sure if t=
hat was
>> applied in the end -- or whether Andrew fixed up any of that)
>>
>> I just saw my reply to my other mail, maybe a v2 would be best :)
>
> Sure no problem will respin.

The latest version from Andrew's tree is
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
everything&id=3De384abeb559d10d6505aec053ede9368d81d4c71

It has my renaming suggestion folded in.


--=20
Best Regards,
Yan, Zi

