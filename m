Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700813;
	b=z7/5n17HceNAGwRQov28EAC37KLArtraf7l5pNocJXLStE6iF0hn/8nI0T5QSlgjrs1m
	 8iwC9JZf6zq461FLZ0LexR0eZTVl0b38xUVoAvX6xObePF9RUYMmbRNdjnJfMZfKIJJxV
	 nUT8w8bSJmHiz300i2mMi2jeoWKzGz9E9ts/UZjjxRpRttH2fbBWszNmiDxDXGvarE8iu
	 S96h2UvI8UDy3rYbK8InXPAoV+n/w3WZo+N34lNCX9mYkTU/hKvBeJrMWCiYRtcaDglx2
	 s256ErkJQI/kCUqYYo3taS1AZyaaADj+6IGBryfH6NzCF6aIv8Q5UnEj2UoISK2pv9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700813;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ay5QBVTupXpoCiXn6UZZm9RK4cKeTVdq6BJnnY3kAgU=;
	b=3gaw9pV9akTGczwxUOfx864g+wJ3msc3UHYiCJCfyF3o4Pg/WamdHqgKcm+D0XVlOelK
	 rS2wY9QKC/xekI5j+6V5u4HjlD5FITkgsvlubIU/un1wDPDhrTGN+se0Ju8kV9zQgMIeh
	 18l/yYffKsDv1I2we5TOk7oRsIe1AdTMJ/VjC5Y9ZsmhdFM08ZlZ5xAmhieInzPg324Al
	 OTJ+4RqE11KfbTvhssKq+AhfkfOgbfQrVisZ8OUuFZvvBvESrclaxDI5b8O0cI88hmBop
	 p2F+k+d5ZCwFnT0hwhhSoshI0NmgKpNy7+QMkqh6Ss+5VPwDHnMSBVX4iNTlw8SG1OQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.co.uk;
	spf=pass smtp.mailfrom=hotmail.co.uk;
	dkim=pass header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.a=rsa-sha256 header.s=selector1 header.b=glH2tIi9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.32
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011032.outbound.protection.outlook.com [52.103.33.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF16606B116;
	Tue,  3 Nov 2026 10:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF16606B116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.a=rsa-sha256 header.s=selector1 header.b=glH2tIi9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxTbdgbazeHGPY7ZrxWOM9N+acZn9iboEARjARhScxwroki2OziAied7/4vfLncTA2pblK/W7XFjxuyHLJZGAH/b5p1x7nctDXogazEtxoKo3BFdEMj/FAWjLd8jSDuNspHU7I/wZE38JiJTU9JEYd6/OmYjOq9iHIRvUVI/6MySHL0Cuu9MVjM4apLwlTN+eRYUP9x/D9Ho+69IHtDBvdqyyA8oeCNyuUok3+PTjieeiQQypDwqI9EuCarLmT9oSkYHjbsSZIuaNzmufalUF/UjWE/jXEa+YnsGlMQfQn1ZQKhE4RTZu/Zyaf/7KhpNln0EKjbRwS03CVbE1BgnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ay5QBVTupXpoCiXn6UZZm9RK4cKeTVdq6BJnnY3kAgU=;
 b=HmU4afQu5m2NaNR2/YSFeTQ8ZJOiB6v+aLL0tr0m5JBoL2LImmSVpowKxQ9xEm005KnmiqRj/uk5VkoDMMF+RofyeN1g8nUOPX5SMw0q2Ppd0pjICewyxaDWBZ10dA0jXq78Qpy/UeiGOQEZ0bLxb06O4yF+aOkWl0+T621NFcbXxIGKcFydP4Wfitr/JvOMFLlHX4A8ObXwOazCrWedFnkRo0SAjkfc4tot0NIrXTpIpVxPh6PXF/3Zi8Dx/+a7ELdlrpLy64WuWNMXVZp/ZWDE7UrKJfoI2j4O0WDhpUGfwNsnAfk/iG/lTeE8FuDm7HMKap0e2Ht7nKhQxo5Fqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ay5QBVTupXpoCiXn6UZZm9RK4cKeTVdq6BJnnY3kAgU=;
 b=glH2tIi9r0lKu4pk9qhmTXCMj5OTMHABB6QMYh/wo57oY/J+b/B+xRv8NiiwIomrkdiIDX6Uuil7pPVpbFCNlV5ewkUTd+pt4/4cQrgA1iq8CFumMexzq2WutRi1YtV7yOOUY6ZUnUjE2lETXAQnjNHjQEZg4cpPS4nqjiV12e1xRnxv1l2AS5hr0F53OXlquiz1Xe0CC9EQOW2PBCasyo16/88wzCs2v31vkeXeQnFp7oaTZe1xOd9p7gQiwvCxyBj+kx2HFpNCWh5AqpkQkHzBSsPU/lWUDWIbImIY9hAl/5oi9cU9+yFi4m/3M383opqSwFvZg9VJ1XqzuN0Cyw==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by DB9P251MB0077.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 10:13:30 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 10:13:30 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Jason Wang <jasowangio@gmail.com>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] vhost: Run TIF_NOTIFY_RESUME work in the vhost_task loop
Date: Tue,  3 Nov 2026 10:13:28 +0000
Message-ID:
 <AS8P251MB000115355C9F818CBDE48A79C8692@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102170928-mutt-send-email-mst@kernel.org>
References: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM> <20261102170928-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0103.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::6) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20261103101328.22586-1-elb12345@hotmail.co.uk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|DB9P251MB0077:EE_
X-MS-Office365-Filtering-Correlation-Id: 39183dba-877d-4eeb-ce1b-08df39931bbc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|6090799003|15080799012|5072599009|25031999004|37011999003|51005399006|55001999006|24021099003|8060799015|19110799012|25010399006|260925184616899003|4140399003|26104999009|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFlrM08vQVdqZUJXUWtheVJIdW1qTHRpTEsyMEpKTTVuSFJjTFZOWnk2OE9o?=
 =?utf-8?B?ZXFhcmkyR2ZUcjZMMEFua2VHQmgwZG5PczZRVGl6SzlZSGNMQW9WbXFjb1BC?=
 =?utf-8?B?UDl3aHdTSmxFbDhBWlltZEd5ZnVaWWpqZzhuVmJwTWU3Y0NnS2ZWK3JQQ2F3?=
 =?utf-8?B?RHQwVkt1L0Z5YVBXL2hDb3hwUlpicE9laWs4eDJubVBrcVRXQUZJdEszV3F0?=
 =?utf-8?B?WWtTNFdDUzNjWXg2S3ozeTBZU3Y4Nm5xQnVxdmNrNys1dEZ1RmJsRHpJNnV1?=
 =?utf-8?B?RVZXaldRcEpPQkpVcjdoa0h4bjlqUUlCcWZibXI4a0hjV3NuQ1pjWE9LajEy?=
 =?utf-8?B?MUVoOS8wdVgreDluSVpBS09wMzYyWHhHaHhLRGlEcWRkYVZoN1dHKzdFYUlX?=
 =?utf-8?B?MGVnb3gvZEh6UG1RVU5aa3RJQnpBd0tDRUtsUEpvRitqdWtOUXhhNUs4Q1B2?=
 =?utf-8?B?UlVZVXlKSU85QVNDVDdMTUFJb25jd1UrQ2tPRisxNmtlWkVsQlBnK20yalNw?=
 =?utf-8?B?OThWcld1dEptQ3Z0ZWZ2d2dHZTBJb3U0L2lPSFBRYVdwOVhYTGZiNVI4REZ0?=
 =?utf-8?B?MllLakwzNHRCMFVtaVJJeUVKdjN5eDFycXVjUHE5Y0lQZ29ISVB0MXdRODlh?=
 =?utf-8?B?YmtpMEg0eG4vTFBLNDk5K0h6bjViMWFCbkVXeWgycENHM280K1BjYlFmamZI?=
 =?utf-8?B?TEZ3ejRMcDZLdUNGMnFPUm1KeC8vSE5zNU9scG5PU1EwbTdUZUhNTmZnWjN1?=
 =?utf-8?B?VFpINjdTK3NmOEJHNUVOSldQTmFmOUgzeWFKbWxZbHZoWVgrdkNhNlpvcnVv?=
 =?utf-8?B?ZUlOTFhJOTNTMnhCMFNmSnJteU4zcDFNdURidGp6ZjhoSkNabFM3Rmp1ODBM?=
 =?utf-8?B?eFNXVCt6cGh4VzJUWXM0elhEMGdyc2FNN2JEQUgxSHRDdFdiSnBMdkxBaHc1?=
 =?utf-8?B?RFdQL3F6dXQ5VVNkZmN5aU9xMFNSb1lwYS95Sm5vdHowbDQyVFRLbXRoS2lB?=
 =?utf-8?B?Ukd3SHJJdXlWT1NWZk1OSlZLWWVTS3orbTdoS2I5N0dsbHMxaG4xb1VrK1ND?=
 =?utf-8?B?UGhYUEpxN204VlFlczMxWWJzSnlXbnptd0VWdmlZTnpWYklvczFjZy9UUGdW?=
 =?utf-8?B?UDlxWjlUd2E0RWZLS0cxTlNNeStZMVV5K2t2OEFGK291Q3NBcDBvVlpKN3BR?=
 =?utf-8?B?eEd6bUplMzFxRjA5Skw1U2kwOGlQQlhKZkFGWE1LWm5ONGNJL0NFM0xRZWRO?=
 =?utf-8?B?c2FWR3c4ZDZsZHdrbWwvWG56UkMwMjBJVGVNdXNweU9aZnRQOVJvcGU5dmtq?=
 =?utf-8?B?SEJ3ZTVjb0UxbUFwSVlUb2l3RTNFaFp4cVNIZ0F3dkE3RmNwai9KbFA1eXU4?=
 =?utf-8?B?Z1lXS3p4SUdQdExwak1FQnBrQk1MTHFWakNGTmpCeXlmdmlBY1dlSDJaYi9l?=
 =?utf-8?Q?EMJ4issR?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0NEYzVheFlDeVlMbm95ZjRRekd1MnBGRUNsQjhzNkt2Uk10cGtIaW5MaWt1?=
 =?utf-8?B?SGR1S2t1QnpHWENtUUNvZ3g5M1JOTjgzNWgrRUZDU0F3ZnVJL1RjbUdLOG12?=
 =?utf-8?B?anJZcW1vY21WU0xSRnVqMkRGcGo2cTZxcDZYeG1KSTVzZnk4QkM1d2ozTStP?=
 =?utf-8?B?RmlhbUVycUx2OVJKcTF6cGxsTFg4aWVUTG9mVU1pK3FDa295YXkvdDZEbzZ6?=
 =?utf-8?B?Q2MyMldNeWRVd0dqT0xBQnBURkMwVmJuNHJtaTNrTmc0ZUtsa2plMFFjeGVr?=
 =?utf-8?B?RnYydG11SkxZczZGNkJTK1k5NzhtY29yK2sybDhuZnR1MlhjbTZxSmszTFNo?=
 =?utf-8?B?VHlwZ1I3Sll6RGRDamFsc1RuWmQ2SURvM01rTXlheStIQVBIVVFqK0d6Sjd2?=
 =?utf-8?B?alFSSC9ER0RtZjZPTm81ZFRPekt5dkc0VVM1Q01TVHhTeXkzQnAwbUNPb1pD?=
 =?utf-8?B?S016dnF1WTdVZVcwS2FoZ3NsOXA0RnVoOGVXb096MXdnRGRUY3hDZ3Z0akhy?=
 =?utf-8?B?QldJSkpvMkZPRWNRWmxRbStwRlRHQzRrLy9nV1RNbHIybklOaHNHVFc5bGRL?=
 =?utf-8?B?Rko2QUlUMDBQVUhOY0IzNzRLYTlndzFYaE0vdk1HVWdGQXpiTXZMTVhrdnpV?=
 =?utf-8?B?VGRUTzVHZVViSVd3RjFVZVRGTzBZcDlrU2hsSmp5a1JvOFhWaGZHeXhVT1Fl?=
 =?utf-8?B?bmVXNy9vc21JcmNqbFAzb2krYXFUNzhoNlJmbzRraFl4YzZEdWdXMUF1UEtB?=
 =?utf-8?B?aUV5YjBOL1BqVlRjQi8wdVQ1ak9keGZnZUxWdndtQjdPZTZEV3BqK1VEeXNL?=
 =?utf-8?B?RHJnc24yK0FzTHJNQXA5b1V6VnFiV2kzSE4vSHdiREZEN2s5ZmNIOGRlRlla?=
 =?utf-8?B?TWFJR254VlFrb3RJclNjbEVaOXZsRm8wdEJ3dmt0RmZwVDJHWVJrYUQ2cHJi?=
 =?utf-8?B?QjFQM010b25MaVZEeERMTzUxMzI5Z2xRd1BnTXh0bENwcnE1R2t3ekIrbVlU?=
 =?utf-8?B?MDd5bHU3OVhQbXh1bjNVKzJ4cjFPOXBjZmRqcGdVMVdiaXQ2WlZvUEF5eHRQ?=
 =?utf-8?B?USszZUVtSDZKek9XWGR0bFBlVit6d0FvdkhmeTBucE1ES1JVNlJBeDA3eml2?=
 =?utf-8?B?QXZNZjBRVEJVOWdBM3hOTDM0NGlVNVJYclBOMlJHTWtCS1c0MHRNR1JOclhr?=
 =?utf-8?B?MHByRFhkMEVRQ0RKUlpUT2hUOVdtN2dnNHk1VkU4RktLZnBQek9mbUFGSmNE?=
 =?utf-8?B?d0tudmNZTEZlRFl5SWdSRzlEMlpMK1JRcGdDYjk3YjNUSk52VGp0OEdLL24y?=
 =?utf-8?B?SnBTaVlzcWxLYmZsRTM5Mi9IbTBDM1cyZWpDamZ3L3VjL1RtbkdadTNtRE9K?=
 =?utf-8?B?RitKTnJpZmhqdmR2bmJCN2NPWm9IMVpaalVGc0ppQjNLNjl3dDh3dnY1NHM5?=
 =?utf-8?B?OVh2SVBOM0dYQXhnMktjZDlheTBHSm14Uld2dzNXcUFQRTRpQWpQSGxTUVNR?=
 =?utf-8?B?WkdOWnYzOW5kbXljTzRrS2xKaVZMQmUveTZ5c25iRlhqTDh6ZVVwNjIzVWtQ?=
 =?utf-8?B?NHJEZHNJTHZQY3N3eHVpWmlINGJPT1NSZkg1RCtCZ0lpN2ROaHRpL3E2QWNG?=
 =?utf-8?B?UUNLMkUzNzhFQ1AzWjJ5N2QzamgwdVplZCttTlJvSUh5d3dpWUVvcGw2MUR0?=
 =?utf-8?B?RG1vTVBmRUVkSnJhdzRXKzV2Rk8wRWVIbUV2NjJnYmZlUFRnTy92MENUZGV0?=
 =?utf-8?B?K2RaN3huT0I2R3dvaDZhZTA1SGJ3OVhsYTlSYmx4bnVJL3VVSDdWeUcrMkJB?=
 =?utf-8?B?THhLdStTRkNjdng5OHpqcHFRcHIwamJPRWgvQjVCSk5kOHpKSTNaeC9HVTFO?=
 =?utf-8?B?S29lczZuUGpKT3NwT1U0OXNqYmNmd1hrQ1NKb0FwaHV6L0kvMjQzZndTUHZI?=
 =?utf-8?Q?uXijVxcORt16KROka5B7WB3D9beC6CzJ?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 39183dba-877d-4eeb-ce1b-08df39931bbc
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:13:30.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0077

On Mon, Nov 02, 2026 at 05:09:42PM -0500, Michael S. Tsirkin wrote:
> Could you pls respond to Sashiko's review?

On review, Sashiko's points don't seem to hold:

1. throttle_cfs_rq_work() runs from task_work_run(), which calls
   cond_resched() after each work item:

        do {
                next = work->next;
                work->func(work);
                work = next;
                cond_resched();
        } while (work);

   throttle_cfs_rq_work() has already called resched_curr(), so with
   preempt=none/voluntary the worker is switched out at that
   cond_resched(). With preempt=full/lazy it is switched out earlier,
   at the rq unlock. Either way this happens inside
   resume_user_mode_work(), before vtsk->fn(), with no locks held.
   Traced on 6.18 with preempt=none: each throttle switch-out was in
   __cond_resched() called from task_work_run().

2. Depends on fn() running while throttled, which per 1 doesn't
   happen.

3. Re-armed throttle work is queued at pick time and run by
   task_work_run() before it returns. Anything armed later is handled
   at the next loop top, which is normal deferred throttling.

Will raise a v2 now with Shakeel's previous points.

Kind Regards
Aamir
