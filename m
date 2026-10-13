Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021079.outbound.protection.outlook.com [40.107.130.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C384F7CAA;
	Tue, 13 Oct 2026 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893388; cv=fail; b=PMIDbMXZbwzyk1YkkKRtOMCWcKwxEgT2l6xrDqGCc8ZQXJzrNxi4zr9IK9hc9Gg+/tB4owok6sKAkue6AWYHsAk9wKxtfoR3t55bVrQ7w/QaUPFa4GT5IQoptOMKdCGseIb6jd+CwQypsFYSo1pPsyBlptX2C5DkdlDOXEMJvQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893388; c=relaxed/simple;
	bh=3pCs3ry52eCSOsI805MNAF2BfkE+w7rRNfNEBBKfQcg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cx8zZ4ForBI6M32HVNdWwn+uiXVIqyGzD4ENRwi2kpMrluJ84rfWUj5abSsfWr9YvAfPfsPPNtN5nQ+/nvuaJRJtnOGg6LeVzd4Q5GXtgmBNvHPsIn7pot79os6I2MD+LnubE0tfuMwOytd5MrBrD5Aru6PyEN6EjIubdoda7pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=Ql98EkDN; arc=fail smtp.client-ip=40.107.130.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="Ql98EkDN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUQ0riEdRBgsTHZPo3c2lZFM3HS7LXVZ6ApMIs4j4yMbOVs2GemsY8PWdiLVfDevjWvhxuNbKMHXdMOoRjJVq7Vr4137uhGrtDdJePCCjxfvEhE312gBEynnM2HQbz0OlBtDaLPqcXUeK2YW4T9Lvuz0Rwwo9Y2zQIyOlH8niF6rTzpBIxse+tKt9E0+uBDrInkFwajZj3XVNpLU7NjGkY4KWvnc3AzFC/EQHQDyCZbyZtbxhSYBKm5TukSeD7DmDmTShl0QbqWZvTH5f/RzEnpkcnqHVfunseGlo9SHmZ7qBwFZf1QCg1miR0E3VK05jNk1NubN7c3ng2IJ/RmGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4pKv6kcJVC6kYOHEJco727mhwyeYwSHi9wWqXRM5r0=;
 b=NFtn9wyH8gt0YY9ryrSsF+lt5dnc+mUdeMt8fGBv9IcH3RtjtFaNthRFqunwY5RtBYQT7hlfm8PQ5n0HCsK/6948IicREZk2smT0mr2oftX0cQrWoZjpg63gbIB4kNdKUCkckT1PxMXw98Lr7RSZHFs0EcEXxv1shPeydBxs0D/7+q9euhxfGjoW7bl0QrnC4/qr7uwMyLUOyRHvALmcBBAfK+4V7jKaBOsjemmkKcwpPJDdwg4xUFjatvvsQPNFfLzncWwbGx1/oyvVchXr7p/yWvS/Kb61yhFhHbw9PqpoifUG7c89MT3I1vZrxEIdCwq/aUvVQLpObs3T8ox4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4pKv6kcJVC6kYOHEJco727mhwyeYwSHi9wWqXRM5r0=;
 b=Ql98EkDNOeXgymKKlH2w+eo8OLvzeekTcwETq3fyT/dJZgnLGYJ3pEa8/pNIUyluszRrUGWdb/7C3m7I1Q9yitFpb7Q8uR9H00FdnjyvTMPZVcbHNEBS+W5YPNBJ9m4d5vEyQQr6Mx4Pso87WuWwIED8HiquLVMHMAsCCtk+5im/AuPS8A1WtJogF5lvw14wYxWwojNFfkh9Tz7IUArwLfX9nnQ94vqjCTTwBADtXPd+MgCSgcfB8blZR06o+YLszUha5ByC+RoX3dvzxExdkHAFCBvmSPLmS1kr1X2/o5d8xslwM3iZoSNCY3BZVV+VKHkL+vESBohrEUzVWuk/bQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by PAXPR10MB5182.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:289::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 12:09:39 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 12:09:39 +0000
Message-ID: <a754faba-f904-458c-8ddb-7502e684c868@kontron.de>
Date: Tue, 13 Oct 2026 14:09:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] of: property: Make fw_devlink follow GPIO, PWM and
 clock nexus maps
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>,
 Frank Li <Frank.li@oss.nxp.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|PAXPR10MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: ad115888-c241-4384-56dc-08df2922dae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+aziyQFpG9oCn66dOXmNwDbHvBC7daJvafcd7Tp1Sv3/0RO9TPXqjvg5pLmbY5+yUkCDxCupx1syvCK0H7MGCtrDrSbKi1oLDUyaFZ+ShW5Ik/6IBpM1GGI6/Dgj6f6EX8XBb0RNrMVq0OBDB2F7xKQ+IqT0Y7e6tf8ZRc1Ov7cLH8cGTML299gJZ+H/OXk6ivFJ3Nfspr/YxK/yw8kV5V4Nf2dYOC3etAfE+wQn5wtnHnLOwWUmgXIAJy6CapwI5YYU36rbn4nteZodNFD32rSMPYsbMvB17Z3HZQtXNohhqIk+zx2fHg5Aq5Ey5vCnKx47q8zOopgypLjtjlobKsraPFH+jHyx34kw5ct//cV6tmuukXblryr9Ck/UuKU1s+5bzn/zejEbuNaPGGmzm+zsPLBpKbjBayz1nxdbBAzVZzEQq/eX1tNXaEOb7Si0dD/MFQbsEkMskWFXGWqmcR8U8kowvqo0q5DUm328rzEueapKfUlQFFG76naoPG1PV8zepMPTZ56fGrapxXROg/FxT46/hL/C9VeXkP1WQXAc0UQVyjziXtsuucpSNF9TchzoW1EKx6NGcZHxzmhCsV0YRJ+0qVoQ74y1nXrAfvV8eEoO+vq8YHOxLG/YyYW8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dSsvVGl3YnJtTGNidTNZRjlDbUdhQm52Vk9GYVNvblVMZlNEdHpTRkdWQ3ho?=
 =?utf-8?B?clBuUE1ubjlqYzFhSHZFaW04OHhrNWNsYjdYWlZpVlpVakdkOFF5b002bEsy?=
 =?utf-8?B?M09sNUhoK2x1S2hqcVJxRFdGTnEyOUVqR0x0b2tzYUFHODRQeHVpSXdIS1Zm?=
 =?utf-8?B?b2ZkMVo3WDlqc2xLNWF6RHpHa3NIUENzWXJZaWQwRFhVYnc4anNVV3VhUVlU?=
 =?utf-8?B?WjFyT2VCR050WERySDl1a0l5bjd1SlpjcVd1RWdQbkZBRFdINEZ1UmJ3d1By?=
 =?utf-8?B?T0hGdjJBbEFYZEp0M2FhQjFwLzZSWVhoTks3STNxUjRmUS9DNStVNzY5WjZk?=
 =?utf-8?B?dzU1OEtMajVWZjdmREhHeU85RzlVQjNYWWMzbkcreWtNNGRxWjZ1UTNMWHNq?=
 =?utf-8?B?QlE0V21oWUVTYTJzWWtENmwyQmZWTmoyL2gyT2YzNStBVlBOOHRkZStzVTQv?=
 =?utf-8?B?TlhiaTFGWDNYR2hKMHg3ZXozU21uR0U5SmdJSjVYL2hianU4OEo0cDV3Z253?=
 =?utf-8?B?aFFLcUhacGl5b3B0RFhDWXBnQ1VhYy9qRE85NWdmb0ZvdE40Zm1BSnNQdU85?=
 =?utf-8?B?bm9GWExta1IrbEtiRjF3QWY0ZjEvakRtWTFVc2dsb2JOd3I1VmVKVEF5UFBn?=
 =?utf-8?B?NXZSekIvTkxFMTF3a1phamNXRndtc2NzRDFWN2tVNW9vUXAxbkY2eWxHUUpD?=
 =?utf-8?B?aDRsZVIxUXU2eUk5RGQzT3NDeVQ2Tk5tbzZnSnk1Sk42Rk03TE5JNnZReG42?=
 =?utf-8?B?WGlEOHNEUWFjckhpRVY5T0g4WW1MWEx5MTVpNWNhSXJaendMVnJOT3dGQTBU?=
 =?utf-8?B?dWt5Y3V4VmVyZjNhcGxCYllXRTQzSXhsL0szdFlQZG1hY1NnRE8yd2N5OSt1?=
 =?utf-8?B?a0RoLzdpZ3E3N25VQWFuUnVWamJMRUM3OVptS0p2N0J2UlErdS81NzB6U3Iw?=
 =?utf-8?B?Y0REU1gvWmtZNktNZDN1TEVuUStQZDlkRUhHQjVOYktrN3ZHN0dCeEorZ1VF?=
 =?utf-8?B?SWVVUHU1NjJoUnBIYTdBWE9Ta2h2MEtITTVieXBIQ2hLQnJLZmtnWmdvZFFK?=
 =?utf-8?B?Uzg3VUYyS0R3bXl0aHFBZDlhL3VnVy91RkdVRjNTUUVSRXFWSGx5QW1HT1NF?=
 =?utf-8?B?Vkd5THdXN2ZKbWJiWTJKbEJDUFhEM3o2ODV6RXo0YU1ZbFZJaTJQbk9UUmJo?=
 =?utf-8?B?KzA4YlBlM2RmY2lTTlByVXhIWHRFRWxscVpLakFEeEdUT3UzSHM5MVdYMWpJ?=
 =?utf-8?B?aDE4Snc4K1FrYVRhMXRwUVZ3dWM3eHFTQnU1Z3VRb3pnSXF3Z0pUVXYwYnVR?=
 =?utf-8?B?Tk9xa2RzUWtIMnEwSjdDUUtDVTFxUXF2UDIrZVNyM004cXNmbk1tNEd3dStN?=
 =?utf-8?B?ODZMaFBMMk9BMmdoN0lkdjdtTklFa2J6a3pEbHBGbzFWdkRnZVdweWQ2dHZk?=
 =?utf-8?B?QkNrMUlyM1lNMzJJc0hhSXVHWVRrbTltdGlJU2Jlc0txcGRZdCtZQldiVmx3?=
 =?utf-8?B?ODh6d0oycys3aFlva21uZndoUC9iL2d4UE9TeWZlQ1Vkc2F4U0ZXTWRKbklG?=
 =?utf-8?B?UzY1ZE1pVjV5aC9FbzZabVJtOEtDdmRsbElIQUh5blRNMG9BUUtHNDlXeUZM?=
 =?utf-8?B?aVdyb0NGclFwdnpYWFVsNVlIUElpSDdGZGh5YUtCTlFkNVl2N2JRZXBVaXVJ?=
 =?utf-8?B?cllxVEhuSm84L21NeE1DU0tQR2krNlhYYTlqS3Ztck9obys4MU1heXdaRW1q?=
 =?utf-8?B?TVJudUpHZzMvVmduNGNOaTdER3VqRjEwc0J3UW95VGFwMmkySWJMTDNHOFQ3?=
 =?utf-8?B?alpONXhxcmYwZjdQSnBEQUdQRXdXZytmSjhIdkVVdUxaNTNVOEtEbVpmOVJM?=
 =?utf-8?B?NXpxaGFYaHR6S0NnZldUS0kzTnl3WlluR0huWE5XYXFEc2RvK0tMcHk1elpN?=
 =?utf-8?B?QklRWEFJbVEvZFNYU25NVnhjaU9NemF2amw2emRoOWt3dExXNW1Ha3M0ZGQy?=
 =?utf-8?B?WkxOdjhJRm5FSDdMQTVmZkZpWXF0SDVvV0ppSTIxUkhnQ1R5eG1wdFRlN3Aw?=
 =?utf-8?B?TWlreGJtbXN3cDJYQzhCcDZEeWdOOVcwZTZ4VmczTVR1ZzUvcmhDQ3ZxbmUw?=
 =?utf-8?B?aVJ2Y21BWERYcHh3SXlRQU1HNE5PejViMG82ekdIVExrejNIWGYwTUtMd0FN?=
 =?utf-8?B?b2NFd2E2d2dHRlFYNHhMd05ZZEs2bVJLYTF0THZzWGFFaDBQWXc2M2d4SXhq?=
 =?utf-8?B?WkE3OXdZZDlNRll0NEFVRkZoSGprQUV4a3Vkb1ozRlZjdkZjSWRwZ3pQWWQx?=
 =?utf-8?B?L2NlYUlUajRDMldxVE10TndKR2JLMENXUnNyYTBCMjUwdjhQeFJCMnZKdzRS?=
 =?utf-8?Q?HSKDXek3mhPwHQgU=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ad115888-c241-4384-56dc-08df2922dae6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:09:39.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgFudMeMcWqje1oMmv1jaRhKtY8LRlc0c3LnrqSkwrDpVs6v9eSf3kMHca56KiWT6iLDC8ovO2iPaiB1eaSZe1Gxkg/y+Dm1fS/wkokvir4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5182

Hi Ernest,

On 10.09.26 16:16, Ernest Van Hoecke wrote:
> This series fixes an fw_devlink supplier-resolution problem reported by
> Leonardo Costa while using a Devicetree nexus to describe GPIO and PWM
> resources routed through an LVDS connector. Consumers referencing the
> nexus could remain deferred because fw_devlink linked them to the nexus
> rather than to the providers selected by gpio-map and pwm-map. [1]
> 
> GPIO, PWM and clock consumer APIs use of_parse_phandle_with_args_map()
> to resolve specifiers through gpio-map, pwm-map and clock-map
> properties. The corresponding fw_devlink parsers use direct phandle
> parsing instead. Given a consumer which references a nexus, the consumer
> API and fw_devlink therefore resolve the reference to different nodes:
> 
>   consumer API:  consumer -> nexus -> mapped provider
>   fw_devlink:    consumer -> nexus
> 
> A nexus is a translation node rather than the resource provider and need
> not have a driver. The link to it can consequently remain unresolved and
> defer the consumer even though the mapped provider is available.
> 
> Make the fw_devlink GPIO, PWM and clock parsers use the same map-aware
> resolver as their consumer APIs. The resolver also handles valid direct
> references by returning the original provider when no map is present.
> Use dedicated exact-name and suffix declaration macros to opt these
> bindings into map-aware parsing without changing unrelated property
> parsers. Retain GPIO's existing exclusions and compatibility handling.
> 
> The regression tests call the OF add_links operation and verify that a
> mapped reference creates exactly one link to the final provider, not to
> the nexus. They also cover valid direct references. The GPIO tests
> exercise all property spellings recognized by fw_devlink, including the
> deprecated singular and unprefixed forms.
> 
> Tested with:
>   - The new CONFIG_OF_UNITTEST fw_devlink cases under QEMU/x86_64 all
>     passed
>   - W=1 builds on x86_64 and arm64, including the OF unittest data
>   - Toradex Verdin iMX8M Plus hardware using a connector nexus for the
>     display GPIO and PWM resources: the display probes successfully
> 
> [1] https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
What is the status of this? Can you send a follow-up?

Frank is asking me to use nexus connector nodes and it looks like I will
run into this issue.

Thanks
Frieder
