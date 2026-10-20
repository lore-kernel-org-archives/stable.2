Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792507650;
	b=oZ+S9kyaUMw2JzRe9Vo11evMZagxashHh6J8kuWTxS7o+5SJHeNYG8FzX4H2NK6diVj8
	 CHqOsiLLr77XquRy3IvlVu9zmI/N/sEZ4ZS79GUd5KQKmj8AGjVAElSbw3DSfkydMImfI
	 CZpP5KL4AEsRdr2/wjNpOX6qg0grQgO1tGTGTJL5+v95ZBxYlptS87KjFTVN8R1obIFqs
	 WIOdnYwiKKEIAj7BgMfWFVO8d1iLegbuuJBtORCawTNqSDEyr+/2Y9QnfgvR182fAD4uZ
	 YJNc2xIodZtuCcvtWinHmGxdrfHeq9cjC4n2lTvL3qfAWGJytz2D+E8hi4GXYIdPC8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507650;
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
	bh=Fv72O8dGXt2bEi98UE1bYrEFTbtpgsnGwN1pxuDEhxU=;
	b=v6E1zWmacItQeZlr9f3+isjWcLm4m6S4Ok66OJnnKT1ncqw7dGFbJIuXJj0V21/hEi5b
	 iCs3aZBZM5AeWKEVTLwlveRb8oMzFA/saKVrJyjJkcrD1wKfnyhpJKp74tYtnbdySxMn7
	 lrZHkkBCahOTwgKJsx4qdLdLu+1m38VvY8m6s5aFJYYUEInnPPSp9uTUPJKho9Ovl9DLC
	 nB3QMjXGJCnAdhHWRONSq17UKBWMppLhDM9TGkivcCzK6X6oznaOgTWyzfTRsnEZpTZeV
	 hZjVrVUCBu0YGOpksYrrttfh3oEbTVk7t/E4gPcQxHstG9KEiJD04qQsBHKxP+6zTHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h3IZFySY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.44
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D15260A2608
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 14:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D15260A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h3IZFySY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKythbmt3exBvhDBgPnMeaRgiSV5gZZbwo5lQjDb0Fgn1RYRmYOiVGGsz2MZIen9aiqOH85vo9RqfKUv3A1LVl8Ky2tNyHT5WNBilsjGxf2jvlZXjcN5u253N73duDut3XJdZxq+h+3QDAHsDuyL27rFJk/nH438Bh5yUEg/EC6Mtj+TnGzIgHxmMPEvrrPfURmZhgRHoHtFrJbVEWG7G5qs1NjZszakiJDOopikIeElFMWYz/hKOch99iyToAHJSrbEG83w2oFyJLdKru0AyE3K3pnS6s9JsEj1DcdFaEfLay3Ns6B1vvlsp2/UxVi2G9JsCW6YEi1MgbnPs1agnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv72O8dGXt2bEi98UE1bYrEFTbtpgsnGwN1pxuDEhxU=;
 b=UoDKgejZ+doUDbQjjlWVFvnBv4OFm8ZKnofWgrvnpz1Yms2INgr0Oi/N6r2b50ZjL6qryCi+RiaWKrjF+a088sExWST/H+D7J/EY5vxEPwkAUi+B2C3jtJopknAzjg9G65/f1xwVTPt+gZml5oWSjqa9YHgxWukWCb+0WMqQvL/qu3cjQUUQ/c5xXKA5sgREn49ov/Q09EQm7SVJ6e/MSMa8RwH5CetCNYWEL/96yCydgK1pYMqMOnz3j+KZcS2E3kDXLWGxpWkZP4EgmWcqoWwQChsIjsVugdqaFrGk81ZQwJxJPSQtWUm/pWayD6em1qQ99ep4U5nRRkwmOSWkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv72O8dGXt2bEi98UE1bYrEFTbtpgsnGwN1pxuDEhxU=;
 b=h3IZFySYDNBgqxMEX5MCqcwePxI0u30J+i7JwHrAfx6CPIA9mn7lgCyv4sL6ZsZhwLSdoVY6E0nujW/9DpAmYe3rxs6/Dxp9VazmYSbEDQkxjNcQvX7xTI8kAcMF21NegKKSwiv+q0kFNwXA2Hntjfp+gr6J5FHpN7UayN+2f8A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Tue, 20 Oct
 2026 14:47:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:47:25 +0000
Message-ID: <7f00dcf5-db4d-4af5-ae35-d5401ef78997@amd.com>
Date: Tue, 20 Oct 2026 16:47:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gmc6: restore FB location and HDP non-surface
 programming
To: Brad <drury.brad@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20261020-gmc6-writes-only-v3-v1-1-70730a302504@gmail.com>
 <36edbff3-fb61-4bc9-ac2f-0ba549ffe248@amd.com>
 <CADnq5_PtxMPr41RgUEeEDOeXQDWVvse8=3WayZcHHE85NFj+jA@mail.gmail.com>
 <CAPMJPtyZ7Qh_JA+DXZJUENY_yiQZ5pJO4nP-Erf7FgwE79HJFQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAPMJPtyZ7Qh_JA+DXZJUENY_yiQZ5pJO4nP-Erf7FgwE79HJFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0338.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::11) To PH7PR12MB5685.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d67e84-35ec-41d9-5f9b-08df2eb90e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|10067099003|18002099003|13003099007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CzCqIXvIBH+ykyDfpt68zKOHVnAbVOwMRh6nJ00MNlure2UXWO/dx/gCnGI052D63wNg/6K9CwH30fu735HkN39QqlJaE3FX6+O1tPZc2A2tlCPMIAHu+lISLyu9Al4pzcy4dJmpDk/I1DIl7H2SDjA+8sdBv3UgAFq8XBCmvqJHoNehyfILL/KuB2FnpWcT31IkdE74Gsr4hn5nVzPygGCLnFOYvCVqcOnpgxG/g5trKG3leLtQsAiKosOqLKsiALJCgq7SeFsf/9EG/KuZYqrd8FX25FgyqXSVmqpKeUsyqiLMUVLuy0foV5T7tPSDJBvhMG38/9Be7gWkMxTkjMkhI9Ai795WBAtI8U+7Ubf2nVecd90IvTwgbCJwu/DhY3XbkzmxIzY12yVyFXG9kFD8Kj2tv4OX54cF7G3NasK+TZDar6jqGsPS3y9dQKcs9KS6an9a2vJ8cDNpgzs0ZvUGXPtyiY+aQvT4lUG0S+AKLrIKk/KdjwRgTnIUHtb3w5R+OxHMktficYhGQ+hI0GFG9CfLVukGRw7FeJg80sHXBo/5mSABGuxkBdEa4pqGqnY0gI6Bnh/azz9QHGzAxwobrtL4DmynXXB6NyHgqzgbgGtLoK5i6lPvwpnlebE/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(13003099007)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVZHNThHWmFZcU1wbEgxYWxSMWxjT285ajJVcGVkTVk5V1cxd28wSmVKbXdh?=
 =?utf-8?B?UEdud2JCd1I1MHpVQWU1UDZxSnV1S2U3L1lVSHA4bXExQnVyVGszamxxQXI2?=
 =?utf-8?B?NHo3NXViUFBIY2R0Y3pmb1VsNXVxMy9ndEQvZmxkaDh3T1V3Yzd3SHlCSEhF?=
 =?utf-8?B?bWJkUGxBQU9Wb3l0VG15dzdRZzJnQkxoeDQwSW0rRUdOSW9MS1NicG5rcGI1?=
 =?utf-8?B?L1BPQXQ2aVNxc29TOGxiYzlFbWFPOWxXWnpEY0tsb2c0aUZWZWNOMTRLaTR2?=
 =?utf-8?B?NEFaZTFMWVhJN0NSSzJPcksramNsa0k0OUo4YytpTzhpeVJtUDgxWXpoVmJm?=
 =?utf-8?B?YXBwR3RiT0RuL29yczJURThzQWJKZGphZDhXQmk3UllmcjJOUlI4bmRPWVNs?=
 =?utf-8?B?RkIvVDY1d092NDhWSVAxWXIxQTRVZ0tYTnMvQzBNNTdWeGVkZ3RZWUVST1Av?=
 =?utf-8?B?Y1hJUkllaFBob29oV09nUHVKK0VqK0RQR0hNek9IRERrUjlEbGVDSDBWY2s5?=
 =?utf-8?B?a2hzSFoyNVJXam9waCttQ1hkV1hsL3kvenU3ZDMvdithbFNDKzVxaWZFeHlr?=
 =?utf-8?B?Uy9tR0ErL1lZQU04NzZIUExvOWQrR2JGZGlIdXo0TkpHNkpnVkxXL0lhSith?=
 =?utf-8?B?TTlvSlpJVHpsNlhYaFdnbW5pVUUyZFNPRVR2QnB6TTF4SHhxbkllTjNoU1Rk?=
 =?utf-8?B?ZnRwRkhKSVpGb3lUellqVFdVYmUydEVWWjVxOXpHSkhBc2FYM29VYmpUR0Zm?=
 =?utf-8?B?d0gxNFpGZW4rOXpIbXhQdHFaRlBSMFlpS3VRUFA5aFZFVTh5WEpkVWZPZENO?=
 =?utf-8?B?SlBtbDVMSVRIZVFGMlJGZElHRnVGNmpiR3dLK1I0OGdMSXpZTEQxeDZtUjFP?=
 =?utf-8?B?ckZJcHk3TkMwQ0NaOVQxMEJuSm8yN29rZGU0RFlhdUxKbVcwRDdqTEhJRzFS?=
 =?utf-8?B?WGU3QXpqTnBBNE1RU2tIVUR3eU12dng5K205R2VKVkkzMTdWWXArRWgxakdF?=
 =?utf-8?B?V2ZlR0xHOGZDN2kxS2FtTW5uUEQ3YlpUYW9rMm1iSjNSYW9sWjNCalJJMTBI?=
 =?utf-8?B?WUdZcGhXbVFOZkhJWHBiOTQrTWhVRW5RditTN0J6eXduODE1OHFvWnNMOUpM?=
 =?utf-8?B?UThGR2tQVXc5NkQ1RlgzWUZwU3JHZnRPck5VYjBYYlNUVzRGUmdhaU9UaEdT?=
 =?utf-8?B?Z1NHM2xzTUJNcXNGTzJySDFqVU41bzgrUTUwNU9qSXl0N29ycHRyL3RPRzMw?=
 =?utf-8?B?Ukx3US9JTktJRmJ5MXQ1dlRzckxFdkNISUROS01lRmFJckNNSDd5WmVSQ1JG?=
 =?utf-8?B?RGNTdnVvdXRhbUxoNWx6SlhNbjkycW9uZVA3ZVN0Y05yc21rNDZmWGNDUFJB?=
 =?utf-8?B?d1NFdEtaY3NtTGFlQnJZWlpQOGFCWVIxb1A0MEY1eUlTdnV0YlQ5RGZxSXNG?=
 =?utf-8?B?OVBXRm04T0Zud0YySzQwQXF3V1FKbWFoRElUOW12N3FiQWwrUmtGQWh5Rktr?=
 =?utf-8?B?UGtaNDFBQ1l4M3d2R1B3WlkyazBmNlNORDZlVUZwbURTQyt5Y3gzNWlsY21r?=
 =?utf-8?B?cEpXYTA0RFpiaThZRFo0dHh3UHJBcFNXMGVUZGRMMnhBRW9qZHhONytWMWs0?=
 =?utf-8?B?OERIVlBIUnpydklrWlJnLzFRT21LdkVDMHltbisza0VQZ1F1Q3FHOStwWVpz?=
 =?utf-8?B?a2czaGc5OXhMaGkydEIvalp3MXZzZlZRaXVUem91OS9pRWFOOFlrUmY3WXVn?=
 =?utf-8?B?SHpOeS9pQkc1UFgvbHNNLzk4endHTmxoYmZtME9NMGllOUlrL1pPSVhNeVlo?=
 =?utf-8?B?ZFdrRSs2ajdQMnNLbzgyVUtUME1xbzEwbmhBNVZTaE5KSzQvQndHak5WUUtB?=
 =?utf-8?B?ang2YjNTdUNZSVNwUjVDWUIyaGVNR2NXSDM4YmJQT1UzZnNTbnhobVVvZHJa?=
 =?utf-8?B?WGJUTW9rNm5RdW0zWWFpR1ozNHJxS2FsY3oxajducmtSUnMvaDZQYmw2WkJS?=
 =?utf-8?B?SWVpaTRRU2t1UjlqQmlZdHZvQzY0aDdWUktmZk1vb0FXaVF0R3FKOUhuQkhD?=
 =?utf-8?B?ZVE5aHhmZCtINXUvSDl2VjJLK0pzWEdJWHdnNytVSDZzcGp0ZXdreTZrRHpt?=
 =?utf-8?B?OE9KNi9UY1dGcEZnQmUwTis1RFp0QWh5N1hZQW9lM1RyUis5TFI4aEYzR2cz?=
 =?utf-8?B?NWpreHY5ckNzcllhdWFzVXRaM1VyUEw0eWlCTVJ3bFB5YjFPNE5vVXdxMkM1?=
 =?utf-8?B?NWdDUGQ4WTJOclZSaWphK0tubEladFVjKzVpL1FUVEFxeis0N2NMOUZFNTNI?=
 =?utf-8?Q?Y3Rdbi1/Ra7HZ4CSUx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d67e84-35ec-41d9-5f9b-08df2eb90e7b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:47:25.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgWWPU95F6/ScCBnI+mjzIM2YvstyFd0qxoTsJ1jVTsjGgmFdFxCbKq2z1xewpeY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

On 10/20/26 15:32, Brad wrote:
> Great news. This was my first ever attempt at patching the kernel and it is working swimmingly for me with the switcheroo config, so a bit nervous sharing. 
> 
> Thanks for checking it over. I’d be keen to know, Christian, how my approach is dangerous because I genuinely want to learn. Email me if you have time and feel so inclined. 

The FB (frame buffer, e.g. VRAM) system aperture and HDP (host data path, e.g. CPU access to VRAM) config can only be changed when both the GPU and the CPU doesn't make any access to VRAM.

Otherwise if you are unlucky and a display write or read happens just in between those register writes it can be that the HW says "Oh, I can't handle that!" resulting in PCI error and usually the whole system just hangs.

So yeah there was a good reason for removing that stuff from amdgpu.

The problem you are facing is that on Macs somehow the boot manager reprograms the GPU to have different FB and HDP config than what the VBIOS does with an ASIC reset.

We don't know exactly why that is done, it only causes tons of issues because the HW setup is different after first boot then after GPU reset or resume from suspend.

So doing one ASIC reset on first load and getting things into the state we are used in the driver seems like the best option for now.

Regards,
Christian.

> 
> Great that there’s contributions rowing in the same direction and looking forward to seeing the outcome in future kernels. 
> 
> Kind regards,
> Brad
> 
> On Tue, 20 Oct 2026 at 8:50 pm, Alex Deucher <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>> wrote:
> 
>     On Tue, Oct 20, 2026 at 7:40 AM Christian König
>     <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>     >
>     > On 10/20/26 10:40, Brad Drury via B4 Relay wrote:
>     > > From: Brad Drury <drury.brad@gmail.com <mailto:drury.brad@gmail.com>>
>     > >
>     > > On a MacBookPro11,5 (Radeon R9 M370X, Verde, PCI 1002:6821), used as a
>     > > headless PRIME offload GPU with the panel on i915, every S3 resume with
>     > > amdgpu fails:
>     > >
>     > >   amdgpu 0000:01:00.0: [drm] ring gfx test failed (-110)
>     > >   amdgpu 0000:01:00.0: resume of IP block <gfx_v6_0> failed -110
>     > >
>     > > followed by SDMA timeouts and a failed GPU recovery.  The GPU stays
>     > > unusable until reboot.  radeon resumes the same card fine.
>     > >
>     > > Instrumenting the resume path with a write/read-back VRAM probe through
>     > > MM_INDEX/MM_DATA shows that VRAM is still intact after the driver
>     > > re-POSTs the card and at the start of gmc_v6_0_hw_init(), but is corrupt
>     > > at the end of it.  The gfx ring test failure is a consequence.
>     > >
>     > > Commit 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
>     > > removed the MC_VM_FB_LOCATION and HDP_NONSURFACE_* writes from
>     > > gmc_v6_0_mc_program(), on the grounds that the vbios sets these up.
>     > > That holds after the system firmware POSTs the card at boot, but it does
>     > > not appear to hold after S3, where the card is only re-POSTed via
>     > > asic_init.  radeon's si_mc_program() still writes them on every init and
>     > > resume.
>     > >
>     > > Write them again, with the same values as radeon, after the AGP aperture
>     > > registers.  gmc_v8_0_mc_program() already does the same for SR-IOV VFs.
>     > >
>     > > Unlike radeon and the code removed by 71086a3e8470, this does not black
>     > > out the MC around the writes.  The old gmc_v6_0_mc_stop() relied on
>     > > amdgpu_display_stop_mc_access() to blank the CRTCs first, and that was
>     > > removed by commit e4f6b39e8bcd ("drm/amdgpu: remove *_mc_access from
>     > > display funcs"), so restoring the blackout now would stop the MC under a
>     > > live scanout.  On this machine the writes alone fix resume; a variant that
>     > > also restored the blackout behaved the same.
>     >
>     > Yeah that is exactly the reason why this approach here doesn't work.
>     >
>     > We can't stop the MC access nor the EFI access to the PCI MMIO BAR. So what you try to do here is inherently dangerous.
>     >
>     > I think we just need to do an ASIC reset on load like we do for other Macs as well so that the FB config matches what the VBIOS programmed it to.
>     >
>     > Alex any opinion on that?
> 
>     Should already be fixed with this patch:
>     https://lists.freedesktop.org/archives/amd-gfx/2026-October/154974.html <https://lists.freedesktop.org/archives/amd-gfx/2026-October/154974.html>
> 
>     Alex
> 
>     >
>     > Regards,
>     > Christian.
>     >
>     > >
>     > > It is not established which of these writes is the one that matters.
>     > > At boot on this machine FB_LOCATION and HDP_NONSURFACE_BASE already hold
>     > > the values written here, but HDP_NONSURFACE_INFO/SIZE do not.  The
>     > > register state on a failing resume could not be captured.
>     > >
>     > > Tested on linux 7.3-rc7, MacBookPro11,5, amdgpu.si_support=1
>     > > radeon.si_support=0, mem_sleep=deep, with this change alone on top of
>     > > the stock driver:
>     > >  - 7/7 S3 cycles clean, from a few seconds to 10 h 49 min asleep, on
>     > >    battery and on AC, including two back-to-back cycles woken by the
>     > >    RTC alarm
>     > >  - DRI_PRIME=1 glxinfo (radeonsi), glxgears and vkcube (RADV) work
>     > >    after each resume; no ring, -110 or reset errors in the log
>     > >  - cold boot unaffected
>     > >
>     > > The variant with the MC blackout passed a further 6/6 cycles, up to
>     > > 9 h 40 min asleep.
>     > >
>     > > This patch applies to amd-staging-drm-next with only a line offset from
>     > > the tested 7.3-rc7 change and has been build-tested there.
>     > >
>     > > Not tested: other SI parts (Tahiti, Pitcairn, Oland, Hainan), and an SI
>     > > dGPU that drives a display.
>     > >
>     > > Fixes: 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
>     > > Cc: stable@vger.kernel.org <mailto:stable@vger.kernel.org>
>     > > Assisted-by: Claude:claude-opus-5-5
>     > > Signed-off-by: Brad Drury <drury.brad@gmail.com <mailto:drury.brad@gmail.com>>
>     > > ---
>     > > I can run further tests on this machine (MacBookPro11,5, R9 M370X /
>     > > Verde) if that would help, e.g. register dumps or other variants.
>     > > ---
>     > >  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 +++++++++++
>     > >  1 file changed, 11 insertions(+)
>     > >
>     > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>     > > index a7c353d1a..d6e315f4b 100644
>     > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>     > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>     > > @@ -223,6 +223,17 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
>     > >       WREG32(mmMC_VM_AGP_BASE, 0);
>     > >       WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
>     > >       WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
>     > > +     /*
>     > > +      * Don't rely on the vbios having set these up.  After S3 the card is
>     > > +      * only re-POSTed with asic_init, and without these (as written by
>     > > +      * radeon's si_mc_program()) VRAM is corrupt by the end of hw_init.
>     > > +      */
>     > > +     WREG32(mmMC_VM_FB_LOCATION,
>     > > +            (((adev->gmc.vram_end >> 24) & 0xFFFF) << 16) |
>     > > +            ((adev->gmc.vram_start >> 24) & 0xFFFF));
>     > > +     WREG32(mmHDP_NONSURFACE_BASE, adev->gmc.vram_start >> 8);
>     > > +     WREG32(mmHDP_NONSURFACE_INFO, (2 << 7) | (1 << 30));
>     > > +     WREG32(mmHDP_NONSURFACE_SIZE, 0x3FFFFFFF);
>     > >
>     > >       if (gmc_v6_0_wait_for_idle(ip_block))
>     > >               dev_warn(adev->dev, "Wait for MC idle timedout !\n");
>     > >
>     > > ---
>     > > base-commit: f307e9d20cc7bd6dd54a3fd8c2af767dd7ef2931
>     > > change-id: 20261020-gmc6-writes-only-v3-33151aacabfb
>     > >
>     > > Best regards,
>     > > --
>     > > Brad Drury <drury.brad@gmail.com <mailto:drury.brad@gmail.com>>
>     > >
>     > >
>     >
> 

