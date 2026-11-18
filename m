Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794983025;
	b=ARyWjLIsNx7OVcryiuzAx5TaYyxRVXftmli+nEaXFh7KgOoR+EArg9vnayJ/uGYj0RWS
	 tJuD683Yf2D1t/GsIdXvuPF9jj2KJVjp/+0jkUFuQsxd8YbQ+HDv5wx/peUROzaZZKIK5
	 oqC6KvziN1yA4Q7PGrcxHsnKe+KplxtT3KjIPkKlBNMzdW/3RnmNnCM4nkfWNgaCVBBlX
	 q//R/gEdpO1ESp5W4yZx4HMN+lQaQgBnWuQKH6uI0HaPZspakttGxdC5YcpG70IjbtS0G
	 RGUR/q7eUNt2ASVdfQUBBNuyCwJKPqkRsDouGqBP0qPx9ZDTbvoym3WcyzxOzyLMvNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794983025;
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
	bh=f7sIVxw5Vv7BVcCvdFUAtha2zMQR6FOZMtxRw5P0y0w=;
	b=QOHqd7A5NWl7KJjXHvPLOdH02/yGdFbWV6NLun6x1VwwahQJ1LyIxGM2ejpLZ0EYdNZ0
	 eHR8wxUi0XUh00yIvie+SmOx1Fv6pPB7TMkO01mPHbtGjjUqMeKuac5CaZUy1KmQwifxA
	 qhiskT4BXKBZ6GUw1XFN334ckuniaduz4to9Osqlog85W9plejebPYH0lJZw0SczEnuzg
	 6WfnyMjfjadKpsgLrv3g7lkBiw++fhDR2TWcgeFAHqHvCwqQir0ED9k75jxy+az6cr1ab
	 +AxNqV9B8PsESNcCyaglRQFyZdTiVBFjQjuTYGv7UyPJqXraXYIncGSBDve2F2gjGBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=dlCokYll;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.94
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023094.outbound.protection.outlook.com [52.101.83.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C21606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C21606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=dlCokYll
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFQqg8JuZ0y08PDa8LdX2bttybm8EeKgrRDNJjolnZOaTtBsxxa8sAF218ey5C/cwfuE5qUEG6M8XNOQLAYEwKDYXu4GQadi0/hjHNw0aAalYiDqXi0pGyoJRdz2IZogwosFKYU/FSpCguGimnGFz3qOOvsS3GrMXnZs7I77Uw75RXnVhGbltSLK6rO2/tVZlxpQ4y5i4vDR9e+00a9aIHeyy3Tju/y7PWNaMx9AyNmluBE6sAAHIBLiRXE7HkbLLF6IyCXFIYShbfvCFC7skLlNI7SmxTf8uauPQLbunh8fEMhzoiyQZm/sf/4FnLPMmOJWz97DmYFg9ig6JN7zSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7sIVxw5Vv7BVcCvdFUAtha2zMQR6FOZMtxRw5P0y0w=;
 b=J3hslca0yFzRg1JRDiQWyxxI/otr4uEwOsHD7e4/6gpQfAnc5sy6s/lR2iydNiHVS/9NMKCfZDpahWcmKx4p/e457luEBi9ZKJVBoy7jNP1BIgAVIEkuE3LsJrzOxH+jvk+VseBfa8K3iq0JkxQc+Cb6chbYKWhIgVE8nWS9bmxfvq1h/iOQxrgPnV0n21+6PJaT0xI5l+g5ycp2v20pVuuolJV/9zNH/IV2OpcDvDhEC9joCuGbFS0krUVlDh4L0KWJrY++vlwSFQ5iRGY/WPYn5NfRof+5JXkBaimH7lQ7x0nVgaXZ3eVkj7JbuV7QZi3RlHnF0pfN4Z9uG0klpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7sIVxw5Vv7BVcCvdFUAtha2zMQR6FOZMtxRw5P0y0w=;
 b=dlCokYllBT8IMQs53cLXjP1VqRzJCY6+OptYJjUleTwovWJJaT4BlDGXurO2we9dVLtGEbRdRt4fm2XAhq/YoVJ8O42RNfXvQ+W4JNn4AcOeZdEV/91fBzK5XX3U646aooqekMrU8hSJJVbYFQ+bGpZHaEGJqVV4Lbc5H0FwufxeF9fqfmGonwKHIzTaLyl2w5mojNoxytep2UNwn/wkJDdA0+PZuM3nGqZsGv7yIZY6ZT+xUUS5E2tSv22GhZFxQeENDepNgaB69dKZQdpTVbMtHjR07fVLHRNvbodlFCAwlYBCBXoGTvO3NArd5yzYP1QZMgBJypIiCkhye+AtfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by DB9PR06MB7659.eurprd06.prod.outlook.com (2603:10a6:10:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 06:23:36 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 06:23:36 +0000
Message-ID: <b68885fe-223b-4b55-aae9-768456d4fa30@vaisala.com>
Date: Wed, 18 Nov 2026 08:23:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "serial: max310x: drive RTS in software when hardware
 delays are too short" has been added to the 7.3-stable tree
To: stable@vger.kernel.org, sashal@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20261117144521.1678735-1-sashal@kernel.org>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261117144521.1678735-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0005F69D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::136) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|DB9PR06MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 48300635-1cf7-4cbf-0ed6-08df453c7a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|261026140227099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+o+pqlf3EJLxz2w6AQupDfdwQ4YvSRD3LnOa2YASm5WCdRdAsXPjGQkfcODIEKgKsaCUFtynhC3iudVZ8p+w3R1g9C4YGmlxC8RSfWvl+/swwpMYhxKoBn0B8VxsD5UEyRFL24213bcOFd2NI2AZaHAAIABOt5/uxO7GSicaCxyU6SVMyyN5ts5jbqdkFPRSN9Q/yGh8qQSKAtIS33JWXr6NGDKktnleUvycHggwCvJYxIw+fZYECq9kMS6T6tGACLKNqebPuW3w7axDooHKMZ4SlAIBrKyHOecNneDv0EOTyJpDJ8gy7xbJno+eQmNH/IWsxuHlrYN+fVb4a/8dQejfq7/Zoo5smApwJ7zvaTvBCkyo87bZANRhKXDvPinZ5t0yVgQ1SCvfP5Zv0jlyN9Id8vBMwIHUHPbrc07/McViAktQWa4iOCmo9qdHrUE1XtX9cchGpf7fcHw8fmj1jZYcTn2aaY2bH2+KF6AZYNF/ZneVbjaAkGU6nwHtzIH0DRVbkDjoZTpNin1f0Ubb50nDDFzrGk1RngijxX+/20SOzIGynvnv8ih4RR01aRJmoTYa3Hl4vCcHbUS6jjiJbGgcaCr+drWn6xVsHmuawu4h05bxy6UzbYB5S/WyEDE1BKLh6IzuYbF/wRNgSFrklVsCU8w1nKBCCEWb4UTBZgo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXE2QWZlam1yQll5ek4rbXJMVjU4Wm9qTmJVRFJnTHpma1QySmtOYmNWN1VI?=
 =?utf-8?B?UWxXcmZXMkhmdXRzZmw1blBVeGdtUzc2amtNME5sRE1HRXQvcFU2c0RpSFIw?=
 =?utf-8?B?cUlLaGFaZTkyN2V0N0Y5Wk13U2ZnYndBZ2Q4aVFEYkl2ODh0MStqdGFOQUFP?=
 =?utf-8?B?YnFhL2FQN08zYjR2RmJmZ3lYRkJMZUxzQUlwOUFxamNMb1ZnWExFTWdNVmlX?=
 =?utf-8?B?cmxIM1YzMHF0bG1yODI3WXFpbFBFblpLdWk4NjNXd0txTGxTS3EwdlBMbUVR?=
 =?utf-8?B?Yi9acmE2OG9PbVJRNXdkS2lKQzh6UXkwamliRDRWZVpPN2tBUXVUU2xKZmE0?=
 =?utf-8?B?SGpTcUswQ1VSaFRVMFJGWjhjbnJxeEtuSlkrelU2aWg0ZlV6akJ6Wis3b01I?=
 =?utf-8?B?T0pkdU9ic1M3YTNaaG95RGRsQjR4MVRqdGZHZm9jbHBwMWhoWTI4emJ6YUg3?=
 =?utf-8?B?Vit3S1RtaFpqamhMRVRZRlZZTmlZR0ZxR1VNamtwZnV4eENDdlVZRWk1Q1Zk?=
 =?utf-8?B?RGZhUjRtQWFCemFXdkpMVjNJcE1qcTBneTdPTk1xWm1pNzFCbXhRYUFXeTBI?=
 =?utf-8?B?VDJ0UVgwRlVNNHRoNzd4ellLTDkzZTk2N0xiMVpQcnFvby9XdlRHT3lCcVhm?=
 =?utf-8?B?c0d5aHVLcHBpeFd3THVJcXgyOUl6STBNTW9ycExYcGxMM3g1dlNOcTlBR0pr?=
 =?utf-8?B?NXV4KzBuOWhtM3ZKa05pS2JNcVY0U3h0MWVpMWtmQzBwaU04R1JlTlV1amkw?=
 =?utf-8?B?VU81cHdtaTNKdVpWUjRYQVR1SjlyS3RzTlorQWN4dEZoZ05zUTBMUmx6ejhI?=
 =?utf-8?B?ZjdGb3lES3lRYnA2VENmS3lSY2pGL3lQVHppK0VkN2Z4S09YeUxqL3cxMzFY?=
 =?utf-8?B?Z0tSbU43M2FZNWdiYmhIdmk0cDJzOTJqVW44dUNJYVdLY0h3N2puN2NueUFZ?=
 =?utf-8?B?ZkZZTTU2bjBNemFiNW8xNER2dWZ4aVFIVElRUjlLZ0hNTHZ5ZXhlMUpid0hR?=
 =?utf-8?B?VUNIUnJBMFBBNjBTSHlST0NDOE5MZENCNFFlbW0zMC9SYzNkK0o3RVlWZWNV?=
 =?utf-8?B?UzZqZ2o4WHZra1duYXFzSUUwOGdrMlZDSUhqbUxsbWFlblJnTXZYT1NyVHNl?=
 =?utf-8?B?TmpkU3FEVzBGZ2tjcTgrUDdyZExPUnVDWE1yNzVxQnlrenZ0ZkxZZ0J1RE41?=
 =?utf-8?B?bW50WVk2Y010b0RiWFM0RmZHK21yVUFEL1pqN2NIT0Z1VXdFVzF2Ykx6azh1?=
 =?utf-8?B?VFExU0Rzdk1vWTVkK2ZYN2xta2VHU1FOUHZYUU1WZ3RjYVpVMDU0eEdTSTNG?=
 =?utf-8?B?Qm5LODAwUGlhT3RMNVNZYVpCZlFpS2ZDM0Znc1kyQmdBWXpzMFB0NlI5aHUx?=
 =?utf-8?B?dVdPNTl1dUpSS3VhTlZjNWdFbmtwVjFaOEFES203Yy9CVGQ3MW1ZMWd0Nktw?=
 =?utf-8?B?VzQ1U0RwOG1YZGloTzA0L3lOU05pZTdCMTlmMFNpbGZDcDN6a0dkdm5May8v?=
 =?utf-8?B?SUJONTNUMU1NeXNFMFJGai8zNm92Yk9HSTk4TEpkTlZ6Skx6OXhSRXpmQ0xY?=
 =?utf-8?B?WWtpTDhZWTJOODVhbGVkUXd6UmV5K01hRmdtdEhGUXBXZmNrQ2VXczZGQ09K?=
 =?utf-8?B?YzFUbEFZSHczaGdhTFNnUm4vMjh5bGdRQ2tpMmxnMlRWYUxid2tmZlBQSG54?=
 =?utf-8?B?c2V4Tktzb0ZsSWpoTGt5bW5JTHZUa01TR0x4eWIxcEdWWHpVdmVaR2hHMkls?=
 =?utf-8?B?Y1Z0enRZV2FwbzQwWTN4SFFWNGpDS3pNNXcxNWdMOXNxTWR6V245azJjZ0dK?=
 =?utf-8?B?SXJESk4xcFpsSHlyczZHTXRKTnFyZE1JS0cxZE9ORWVLam1Ra1BxalZsQm9l?=
 =?utf-8?B?Z05uZmVKUWRwbDJJRVY4UnVkenBaTkdDL29iNU9wRjlLOG5sZmZGcEIwaDFv?=
 =?utf-8?B?ZmYyNDMzSHYyRUZuaVFWVU1xUDhGZTNpVFhCV1NBVUQyZ0tLYXlXc3llekJK?=
 =?utf-8?B?SGo5b256Q3dIVVFnU3hSOWUwaHBmVmg4czFnSXZrUU5nTmR2c25ldzV2YllV?=
 =?utf-8?B?eU5TZkMwYXcvMG5aaXZoUXdob3hlRjkxdHJnRU1lNklJQ1BIQStYdjNpVThV?=
 =?utf-8?B?SVh5TGRIUFlCUmVXREc3d1FXOThpK2Y5Q2QycTFlQ2R5cEZqV2QrMHBPV1hI?=
 =?utf-8?B?RStaWGhZbXVxU1lrK3V6RGtqWnNmOE5MQ1owSm5FckdwOXVnZ2RHV3dKZTJN?=
 =?utf-8?B?LzBkaGpnVmxySVJGTzNlNzc1YkJXc0Z1SUhPNE95eWdNS1UxakJhZS83b2hC?=
 =?utf-8?B?d0g5N2ZMek9ZRENycDV4NjI5WnFLK0xSaU5ycXNIVHBpbVlDTGlwaGNUa3VU?=
 =?utf-8?Q?wbopDF3zsU7Dx+i4=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48300635-1cf7-4cbf-0ed6-08df453c7a7d
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 06:23:36.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSdODGq5cxCwGekr8DbFICPV7BgrDyMeFeAfF/xf3cxcI+lPazvSGzWkZgGLXLzcsyc5E6IbR/snR82D/V1h9gtYQYmB0EEoNmKZvi1qHL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7659

> This is a note to let you know that I've just added the patch titled
>
>     serial: max310x: drive RTS in software when hardware delays are
> too short
>
> to the 7.3-stable tree

This patch depends on

  c06fcc258db0 ("serial: max310x: schedule tx_work directly from the
  IRQ handler")

which is in neither the 7.3 nor the 6.18 queue. Both queues have this
patch.

Without c06fcc258db0 the interrupt handler calls max310x_start_tx()
on TXEMPTY, without the port lock. With this patch applied,
start_tx() also starts the RTS envelope and can drop and retake the
port lock, so a TXEMPTY that is handled after the transmission has
ended can start an empty RTS envelope.

Please queue c06fcc258db0 before this patch in 7.3 and 6.18. If that
is not wanted, please drop this patch and ae588038e31c ("serial:
max310x: don't transmit while an RS485 reconfigure is pending") from
both trees; the second one builds on the first.

Thanks,
Tapio
