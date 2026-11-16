Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794844327;
	b=ZkQlHpFS+40vyz1VaGSbZYTzkktFsiw0fF/f0Ok7cBrOrs8GyqmyR0dtjpVTAm3tnO9u
	 xJk9ShA4BK17o2A8stE5S0WVUiywsTcOuGak9lQGwYThbaxVpi19YuM8ofYvUWAevMGs/
	 d/oeltR9NCPlGTNNKZEKZioBDktTqHDCRKN9/pwZfoXxB7svSBsh5RGUKOvBoWSJnTxRG
	 n80D8R8B7O5NfXSwnQm9YTrD9Uj7E2VQIk7sCflRyQ3uibm/MQl+IsZb0YbLMUijbG4Mj
	 lf4Khb0x//T7a+x3gCATGxS7898m3PATKrueVotisdJ9B+fpxpeB8Q6wiQYy+eVOSlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844327;
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
	bh=ij58lxQsKr14Pm1xSdZM8rMDG5yp2ABGVy2VzjtZGDI=;
	b=EJlmnt1RWmlcjM2bRjy+gGEZv8lrwYs2nRE8BWYh1fBzajlsnSJXBjF98pzni+WvrqEr
	 akA4/2VaolH5xwd4rP2uDacu6J8JSSyU92l0SWguFy+/NGwt/1fAvNtcKFWDjfNOuTjaF
	 I15ZEILpgh3+AI/1BnhbPyofkevlhKCUf5Rv/hZ///UqLt5AEfXNYOsZKs95ICpD23egg
	 SvtR5i5gVAhwV6MKg6ijxQHmLUuDeqbFUvDxem7CVGUAhMi/9CuD6e/HW+v5zmlPgtWqM
	 QkCuGCbnXken/JgXf/KJAG8cCOcmnxgVVpkhhdHac9zLUUOb9PwJuTx5eGm0nRHjySw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y8Uf0lj7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.71
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159B606A323;
	Mon, 16 Nov 2026 15:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2159B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y8Uf0lj7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEKak6TyMl6Tvwg1ShcSvowmIxp/fCf/7VZm3c8qseFZ87zzI5KNz/tamVE6+6+SXBPh2aQAFvyr4OrukHEi0NqevLzZXNoFu/4tHY/rDMiWTZLsCXVg+4dJQ1jdcM1Q86Gr1q7u3Y+lLUy/hUkDo3GrfXYkloyLwEzIdClCv82hw8L8rtlg3Knh2qDS12PVv1DksPpBJzR8aI0nXHsMUoTexywIyB1fJqed4EuQx9CAtsYkZSK0z7KmtXhcEtFT+skQnkR8AuXII42BL9Eg9Vo3U7e5Qe9bGdzBxR7Qnmx9vEuhgWJuLg9e2kFZ6nJO+MTwS5R2cFRKbOI/5NGYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ij58lxQsKr14Pm1xSdZM8rMDG5yp2ABGVy2VzjtZGDI=;
 b=OZxJQWEIxb1pNNNlaHLnrxRLQwhEadOpih00U9ISBIn4W6cK/+/W7vbwzAq+J3uafWi/sJFEWWEmzzOxAbw5eLkHA+eLrxaa3UXdttM815ZLUiytwcZCifJBRGonlbdZal+VaKOop1t9Gh5fgo8tokhn/eBlEdFrkkT2422rZ/vEew4Ix3ivmtKIsDKs+WU/Pf71vXYYHtLkAzru1YETd2xLuYOaVE5g1Pp9H2SuZygoNxydzojgqvVcNvbgaAI0NlCjKpAf+Bm5PnSGoxg/slWWGMJ94ze+FDFkf1XXs/TbA/RanD9r+d8Nu4cNbPlNLrURPQCa+WaZ8Ee9jgx1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij58lxQsKr14Pm1xSdZM8rMDG5yp2ABGVy2VzjtZGDI=;
 b=Y8Uf0lj79YhSwDj/YqRhwjUeDhJ1tpnvC9ypZlN95snB6vwTvRjplSAr3zMQG4s9ofeEYLOpnewuO2ZEzAqodz5BzDVSubhYJUZJ9GltabuoO1ukzxRr94pvTXXMDLrfrB1W8qZswuR3Z9jU24Sk0b7OPnh4LBr/Hxu6AR3LhgM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 16 Nov
 2026 15:52:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:52:01 +0000
Message-ID: <980220a5-390e-40a7-bd5c-16a2225bd75b@amd.com>
Date: Mon, 16 Nov 2026 16:51:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mm: check permissions and bounds for vm_ops->access
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 Matthew Auld <matthew.auld@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, Chris Mason <mason@kernel.org>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-5-988a5c470db2@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261112-access_shite-v1-5-988a5c470db2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:408:e4::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e7071f-ce8d-42d9-a252-08df43f98dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|921020|261102123227099003|56012099006|5023799004|11063799006|261009223027099003|261021135927099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|4143699003|261026121527099003|261102130727099003|261026140227099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3snhvh5FIjUsD2Zs6dx31G/cGmuF/ydKp6cyZL9Q21wT47PH6Hg3p2Bu+I94QZJD0D6Ye8USEV+3aO9UVL+5NSD2ih820YcHi3//6GeiKkKlSV7UKa5GaqXUJ29uaC23oTU7cjqEfi2uF93P7Uqyaktn3XIfXl/69VKDhaZiabZxfrdnoXsN5mbf8xLTKPJAgMczxmoyTT6e9iOUIXd4/36KIF5rTXOPhcig9rPMm1rZlqMhM2S4e4einoFgNy0fsZuIsI/aKvVjV0OCmv3RZuK/7UYsxvrWfZHNwDyYMKhwBt6fERKosj3RRwkG/ehaRYgOf6R8ijAZizMGNmqyIEktN8oeNsUb+LdL/v1lxmhZKXV++i0dODx4yDksGM5x1lIOjTNmTdsfRETexIyNN8v4joXrm05j0ByYGw62RwbZJ4OibALr/pfC4w2b8uveWb9P7GJ8y7mLO6aGUJTZz5uMrXsS9KB2sQcy681z9mgnjn5zd1N0iM3i/1s9/NDeRQGc44Mx+/jfd1iR5Be54OlqIzADsrOW7oPVAc0jw8UuRXBROJGJv1iTmK2H+VKPJZ4xSxLJzem3Tui/x9nOt1WN9mJEz87JxZGF+rwy4aKknG7RgSe7w/VPob1HcJSTHa2WGH9zJw4zzrRKxiH/Id9/25JO5IPnvZEo3RV5ojA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(921020)(261102123227099003)(56012099006)(5023799004)(11063799006)(261009223027099003)(261021135927099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(4143699003)(261026121527099003)(261102130727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkhwSmRFTWZVYmlWYU5CK3l2QVhLTjJjUi9jY1pEN05vOE1xdHptQSs0R0Y1?=
 =?utf-8?B?dWV1ejExQjF0SEpIeGRTSzdiRUkzMzRYajg4endhdytRRFp5RXVCTTRiTFMr?=
 =?utf-8?B?VVk1SWtwNGNaS2p6TnNjc2tadWJTTUwzSFp0elZvSkh5eFplOFhxS1RwTEpx?=
 =?utf-8?B?akxqZDIvV0RoSGtaR2s4MSs4OWpCbGhEeVRGZUJCR1VqODZBWHdQbnZlcjQv?=
 =?utf-8?B?QW0vSFlsK0hWNERDdlF2SG55N1NkTTQ0RjMzTVZ0VEpabWF6WUVMdWwwNVNF?=
 =?utf-8?B?MVBjdzZhbzhSaUVDY3RHSmR5cVAyYjZCN2lZZWlqNzk5WUNhMjZGbGJMZDJm?=
 =?utf-8?B?bitJRWpXUytSTm81MHpNTWRtcXptOStkbm45WTNMWk9nZ011MEJFRWJmT1pM?=
 =?utf-8?B?bDk4MFA0VEtoWCszMVYxUU5BdVhDMjJvWm9CMFN3aDBwcUFJWUFJVzVMeUZO?=
 =?utf-8?B?SnEweVRrMFdRclV2NGJOK3RpRTZhZTRTY29MaTdHckdPZDhVWWlSMnNGdjBx?=
 =?utf-8?B?clRQaEFub3FkOFdxVUhTY1R1eDkzV2VqV25IVkl5bmF3djZJZWcra0tFNS9Y?=
 =?utf-8?B?T0ZCNk0wWjZ5dFhQSkhCTXNSQkZoWFYvOXpDbzQwaU1PVW5GOXhFc1dVdDJR?=
 =?utf-8?B?ei8zRUVmV3RIMkk0NG5FS0EwdVlvSUJvSGxmT2RHeFQ0Szc2WGEwdCsrZnhG?=
 =?utf-8?B?Sitjb1BKN0R1TzIzNEh6L2E0Qjd2WlRmQ2R6OHpSclZtNGJrL213MEl3azJm?=
 =?utf-8?B?aWpkVUhVdGFUVDByRkp5TWFHT2FmNFh2dnM1dGlueUFJRFA3U0ltbU9mbkgy?=
 =?utf-8?B?Q2xOczRkbUlSWUFzVk5aWWJaYllFNStLajFFcVV2RFlpRWc0TlRoeHJxbHVF?=
 =?utf-8?B?d2VCZ1BOQjhNdmZ1Vnd1SGxMTFdoQVhZNW5hT1hRemhYRWtUYjdvWDd5cFE0?=
 =?utf-8?B?UFVMaWlsaWMzbVU0NGFza21TWmpZMWVtRnoxYnNJaGUraEtFSC9MYmRiR1p6?=
 =?utf-8?B?TDhCeUltUU9mTHVBWUcxVWhYb3d3R2RWRDBxdzFNMTN5NFpFRDhic1hXM1NM?=
 =?utf-8?B?bWEvTitNV2h0TUJkQTJ3UElXck5xNnY0V0MwYlZXcWFXNVgyc2p3T3RNUXZ4?=
 =?utf-8?B?L3dxalp4S3gxTVZEZ0I2cVR0VTkvdGJIazd2WXBLZ0cwUU1WNTdxTmZKWjJz?=
 =?utf-8?B?bTFHWDV1RG1SYkM3akpyN1FjSDUrZHBSclYxSEw4bktNNmg5YWhJWmVuN1Fv?=
 =?utf-8?B?dW5ZNHU0a09vNWkzbktKcUxzalNBR1c5VVRiZGprOXdqenFBdEs0Z3NQS1Rr?=
 =?utf-8?B?L2hjTVZEM3dyQ2l0SE5YQUFJYkk5cXZYRXdudmVYKyt0dnVqeEp4RDVxUlky?=
 =?utf-8?B?YTdvTWxjd3pMNkpnRzA0WFNjeCtsUThhLytyTytxY3NsdzlacGxOT2lneloy?=
 =?utf-8?B?aWNrdGRIZmNJcXdVOVcvbWJRZjc0bysxbkNKamhiMDFXKy9ILy9TaHduVnpG?=
 =?utf-8?B?dTNoTWJDcis3WmFUYkRaOU1DMXNKS1BRb2wyZytTRnBOWmc2UWxVbjUvd0Yx?=
 =?utf-8?B?QkU5WHVnWi9JQ2FyYTZveWo4cVBNdCtCejNCaE0yVnY2WGc5SUE3OVdSQzJw?=
 =?utf-8?B?WGdOaVVoZVFIeFFLOHBtSWwyRk9nNlJTWEp3aTBjckhqY0U3SCtzTDQ2M3FO?=
 =?utf-8?B?NDFmZ2FpcjJQZlVIYVZjd2FUZ1RQdXp6cit3ZzBLSjd5TEttTDlsanVmbWIy?=
 =?utf-8?B?SjVaK0NlYWFLTVppYkF0SlBHMEhzQVRZTTJHTEtXZ3l1ZjNvcjYxWVErSlZa?=
 =?utf-8?B?VGJHQURtVmF3TUJNR1MvekFoV0VmOWU0Tjdpa0gwRGpsVGdJUVNlSWJyNC91?=
 =?utf-8?B?NXpicS9pc08yNGVZaVQ4WEZvVHcvUFdxY2F4VFhzNzFuYkNJcWtpVUZ5Q1J6?=
 =?utf-8?B?eWlTY0JnL3VXSDQwdXk2YUlMd0lHTStPc0VpOFVKNytFa3hxZzJuWC94eVdm?=
 =?utf-8?B?Mm5OOWlQdm9sVFdabXZnRXpmUGh0ZFhEUER1cUhCQVVjckhwcEprOUVjQjFj?=
 =?utf-8?B?SSs5b1V6d0pZQlZqSGh0cEVFUWNUYmprSU5pR2k5RVN3Qyt4NFY1R3IraldD?=
 =?utf-8?B?Z3ZEVFRpTEFJQWRaVFFJQXlZMFV2eHZObnBOOHdEWm1BdVlBMUtHVmZDTG11?=
 =?utf-8?B?NWpmQ3U4VS96U2pGaGJuTEwxcXBHdWRTRTMrS0hwUlVnNWl5Q2FLQ3h6NEcx?=
 =?utf-8?B?OURFMXEyMVNWQTBsTGNWSU5mOENoaTNNOWZIRXhRa0hQNWl2NzI5RHlIbHJO?=
 =?utf-8?Q?C2LaC6UVyr+7P3f9m9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e7071f-ce8d-42d9-a252-08df43f98dc2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:52:01.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waA/3lS9d9VVasydbCt2S+29Igo+X04osKTot6VuJqgpOPT7mmMt7dRtqR5T0nib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787



On 11/12/26 23:09, David Hildenbrand (Arm) wrote:
> GUP rejects VM_IO and VM_PFNMAP mappings early. __access_remote_vm() then
> falls back to vm_ops->access without checking VMA permissions and without
> limiting the request to the VMA size.
> 
> Consequently, /proc/<pid>/mem can bypass protections even without
> FOLL_FORCE, or cross into another mapping without checking its
> permissions.
> 
> Check VMA permissions before calling ->access and limit each request to
> the current VMA. Implement similar access permission checks as GUP,
> however:
>  (1) Reject writes to CoW mappings because the callbacks access backing
>      memory directly and cannot handle CoW.
>  (2) Allow forced writes to non-CoW mappings with VM_MAYWRITE.
> 
> This intentionally breaks forced writes through legacy amdgpu PROT_NONE,
> MAP_PRIVATE debugger mappings. The workaround in commit fa5239f2af98
> ("drm/amdgpu: workaround failed COW checks for Thunk VMAs") cleared
> VM_MAYWRITE to avoid CoW, but debugger writes still succeeded by
> exploiting the missing access-permission checks fixed here. Reads remain
> supported. Userspace must use MAP_SHARED instead; ROCm 5.5.0, released
> in May 2023, already does so.
> 
> Link: https://github.com/ROCm/ROCT-Thunk-Interface/commit/fea44fab6e84eda52fcf6b419b35600c18f4c022
> Fixes: 272ddc8b3735 ("proc: don't use FOLL_FORCE for reading cmdline and environment")
> Cc: stable@vger.kernel.org
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/memory.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d4370c1b331c9..9872f289c1e49 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7362,6 +7362,7 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
>  static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  			      void *buf, int len, unsigned int gup_flags)
>  {
> +	const bool force = gup_flags & FOLL_FORCE;
>  	void *old_buf = buf;
>  	int write = gup_flags & FOLL_WRITE;
>  
> @@ -7401,15 +7402,35 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  			if (gup_flags & FOLL_ANON)
>  				break;
>  
> +			if (write) {

> +				if (!vma_test(vma, VMA_MAYWRITE_BIT))
> +					break;
> +				if (!vma_test(vma, VMA_WRITE_BIT) && !force)
> +					break;

I might be wrong but IIRC that was brought up before and was rejected.

We even had a bug report for AMDGPU from a security researcher claiming that you could circumvent security checks using vma->vm_ops->access() which turned out to be complete nonsense after spending tons of time investigating it.

The technical background is that there are applications which runtime generate shader code which is then protected by making the VMA read only. But the debugger is still allowed to write to it using vma->vm_ops->access().

That behavior is ok because drivers specific and drivers have checks in place if their backing store is read only or not.

For an example see this code here: https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/i915/gem/i915_gem_ttm.c#L1163

So if you do this here you might break intentional uAPI.

> +				/*
> +				 * In contrast to GUP, we historically allowed
> +				 * FOLL_FORCE write access to non-CoW mappings.
> +				 * However, we must always reject CoW mappings
> +				 * as we cannot CoW here.
> +				 */
> +				if (vma_is_cow_mapping(vma))
> +					break;
> +			} else if (!vma_test(vma, VMA_READ_BIT)) {
> +				if (!force || !vma_test(vma, VMA_MAYREAD_BIT))
> +					break;
> +			}
> +
>  			/*
>  			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
>  			 * we can access using slightly different code.
>  			 */
>  			bytes = 0;
>  #ifdef CONFIG_HAVE_IOREMAP_PROT
> -			if (vma->vm_ops && vma->vm_ops->access)
> +			if (vma->vm_ops && vma->vm_ops->access) {
> +				bytes = min_t(unsigned long, len, vma->vm_end - addr);

Well that check looks totally reasonable to me.

Regards,
Christian.

>  				bytes = vma->vm_ops->access(vma, addr, buf,
> -							    len, write);
> +							    bytes, write);
> +			}
>  #endif
>  			if (bytes <= 0)
>  				break;
> 

