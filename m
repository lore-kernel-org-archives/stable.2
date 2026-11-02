Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616962;
	b=1tdwrtGuZKP3wvCsV36FYgxiJQ9gpNmGbX4TTt/Blxf/cWLkCgXexPpFqFyYNWjZ3bEK
	 flIXSX5VZBpJDb69rCJFxTYa+6AvlYivSHRESmzUYzuTBLyULJk59+vJ8CL2Keq1Y2elM
	 Nb/Cu6CHYRFqeIIGzXaNZEXfKHzNR7HWrTL/wsuV3dhSBO2NiRCDt3E1lTs5LhCAZt7sO
	 NnDiqqzi08ohfyg7ZPPUnS3G0v6NXQ3hEzyrC8Y6TKB6MQ2jsy09R0tEPJyynCcUo/aWO
	 /TVmyas9GVobW//JmY827/VDOWHYStps7UvAuQuQTo3sjM6Q80IwdkqobE19fmgRjkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616962;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=aQSOwc9cmXcpesIfKcYslw8ZqvuuM8rC+Pn6bYZx388=;
	b=pOz3uCpLfkmii7hIT1M1U5Ws+W21rt7/pjoDzpq11YekdrgWL/izEygFqA06FmVYDFYe
	 LF8+/0POwSyjq2R4Rox0SB8CQVSGkkYTJS7SsP5Zn1axDaq5Z81IjPT8BmoflRFhbqyzk
	 penNRtqwYXqMwNZDZrSqVLSk1yetph1Ugg85XTUJlFAGKYHjpU+96CDD9yobg5qR7mYsp
	 9pGpwgQTk3+BfJtSIkH/b5+GQtYgeL4pEHPhLB7kTkRx8Vv4gNDDjcFy/J1bmwLihZm4D
	 9LR/GM7ili+jdaIElS9kekNSIGQ1cQyYcZSh1VnyzNxLzCD0xPxGwHRDhLPx6nR/csQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=gQRXzRXr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.0
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010000.outbound.protection.outlook.com [52.103.20.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA630606A32F;
	Mon,  2 Nov 2026 10:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA630606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=gQRXzRXr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTNLjow+uEAR3pE9DbTbrOKb69638octdmChJCIujdQige/0IpXSrZOvSDVRQr6xmJK/ve0MLOq44VttU54Of/j4rkaifZonxWQlGXRI0rhBDWBIkZ3jAtXa4pZRDWYQQFWOV2sMginsmO0EeEhRAYmtQSeTN42tSCmM9nPjRTQUk9UKeaQFI0WdX+cl22UJEPkvCDYFcqTkf/XN5CMv7tzZSLEOr1R/FjCf/m2QaoWWrasiOA63PCjCGq0LZo/0isWRPkGI/k+wqolA1XltwDmBmI/WGSrSjbQi9/Pamvd8/iDzL68MjctnplvSj428QPrKsoUx+9h5hlZWSfnWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=aQSOwc9cmXcpesIfKcYslw8ZqvuuM8rC+Pn6bYZx388=;
 b=GuD5kwwkuMhmATWNtD8NXbojtH5Dcufka65NnK+Uc6gPU8tu218INxKmAEl7NqPXxJuUPOQ7iJAjU8UaagezzBR7GrryXRVeEF7RTlsmXNBkxrH3LZj+ZqRHUuYYROquwVJp7G52e4ZtLyv1kCj6FcSiSgM9Q/SjuF/cltSXUG73lSeKvGcxzM0fnFXD+m8fAVzJy3hrx0ngzL8UCuA2EKXJbWLhPzZVK2MnyhBW5IqaohAn+UnPz71jfsu6DS0k0ypK6uTKIUZZ3xLYAIn8oQaN6G2n9Rs13WOU0/WKJdnz5UBWPqBs2Ne97w59s8Mt0TWwoKlvNShlhV8cjZQUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQSOwc9cmXcpesIfKcYslw8ZqvuuM8rC+Pn6bYZx388=;
 b=gQRXzRXrm0ixR+0aWYTZvwkhDVaJHXYgJmCsBF+zIEcXSbcB3gqs9atonV0Ulipnsxjqs0yrTVINsxJhzH/JpEFW0Mh6At+ekXXaOlHKzq2mDFS7iV3az883Is3j388akMGQAon2MzqDicfT/Rra2f2rq8cYdRq+EHN/xAHdcdvtzsxyYVFzUIeiFa6UHr5j3PayuzbwpEIEBnc4CsAkmDpn5rdBjgSWzTMbRKxYiQnjAgl9zcOhd6mpePrHJaIV0aVsUwvNPnvB30GrtQsMtIjb64ahRvqV7A2/Rfof8dijoQdIGVGw7fRa7W061l0moAe7ZO8Q3avyN4K35HSwxQ==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by PH8PR05MB999189.namprd05.prod.outlook.com
 (2603:10b6:510:430::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:55:59 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:55:58 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>
CC: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann
	<daniel@iogearbox.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net] tcp: free saved_syn after an RCU grace period
Thread-Topic: [PATCH net] tcp: free saved_syn after an RCU grace period
Thread-Index: AQHdari+bccwth3yzkqADfh5v5W7qA==
Date: Mon, 2 Nov 2026 10:55:58 +0000
Message-ID:
 <34f32e63b803f9f7faf0b0a5754219e48a986136.1793616950.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|PH8PR05MB999189:EE_
x-ms-office365-filtering-correlation-id: 9076a8ed-f090-40cd-e7de-08df38cfe0a5
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|4140399003|19110799012|8062599012|12121999013|8060799015|38102599003|24121999003|15080799012|22091999003|5062599005|31061999003|51005399006|24021099003|12091999003|11031999003|40105399003|26121999007|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmdSWWROanZTSi9kOUgyVk1NbHZ5WjR4TmhBYk5JL0s5bFdTcnlxTVRIdFdt?=
 =?utf-8?B?Y0JBeUZhbE5DRXhqZGl3MmIrQzlFQmJNdkRJVjMzY0w5YVpzZjhmTGYySUVv?=
 =?utf-8?B?S2tDM2E5aGZybExBdzZ0eEl4RDRMdVVOdFVGbG9XdHh3NmhBNlAzd3BLd1hp?=
 =?utf-8?B?ZnFRV3FVcWt1VEtzTzU3U29jaGJyOVlDSVF0TmlIK1lEeCtpZUp5SU1nUmVO?=
 =?utf-8?B?OW5sa04ycFJocVBXaWo1VEVlM2FCQVgrb2NkaFRTZ1lYOFR0UEJRckpNb29r?=
 =?utf-8?B?aWI2VjJQd2JybnlIZ0x1YitSdklXMGZlUkloUHI2SmxpUHIweXArRXFsOVJV?=
 =?utf-8?B?cG45SDBIZ0NIZ1BzZk1yMEJyWnZ3U0tDc2d2SnRqYm4vbGc0cDF6UlR0Q2s1?=
 =?utf-8?B?MTRoN3N0dkZoUkxtQzRCZnRRS3R3Ujk2RFlGTjhZNE9icEkyWmc4MGZxejRR?=
 =?utf-8?B?bmFpTWpLR0lxOTE4VStLWjR3Mk56cHVMTzc3WEFjU0lhZktEU1NYMXZ6ZDZG?=
 =?utf-8?B?SWRrN1Y5ZHlKd3R0bmo0TytwbG5jRU9aaFppdG5NUXE1dm5iZEJDNittNGp2?=
 =?utf-8?B?Qld2V2FNc01NeTB2UG91N0x2SXVMb3RKWGpiMkppQWkvcVc1d2VjTkQrSVZL?=
 =?utf-8?B?bVprVnJ3VXJEVDVmMlIrd0lWK1dEN3VKQ3ZaK3Vlbzdvd2Z3L29wNmZlRWNQ?=
 =?utf-8?B?MXg3Si84R3hyNjZ4NlpWSHI1elNTNXRRR01YU0hQL2R0aVAxUDM5S0J3dmUv?=
 =?utf-8?B?NTNZV1ZJcTlVZ09iajJweldWa1J2MitQdE8rVHRRWTBRbWxjMnZRSFh2YVVK?=
 =?utf-8?B?Y1YyWDFodGl5L3FKK3J1blZTcUJDT0ZUSlhmUW5iMjgyMEtsOFFUUG5vRE1P?=
 =?utf-8?B?M1BsVkhxbERzZ3hQUE5DYzlRRmo2ajhIaU5KMEVEcTl1N3NsY2ZxcmE2czF4?=
 =?utf-8?B?dHJDQ0JiUHp3SENDNmFyaGpJNG0zL2dvRWswQ3Era1UyK2ZnaHJNK21lWE5B?=
 =?utf-8?B?OWN2NGQzL1FnV0wzWENpaXdXdlkyL0pMVDJmT1R3cmNLMHVGOW0vdlVXSUd3?=
 =?utf-8?B?SHBZdURidFlBL1orUVkvdGlhcklVTUpjbkJFYXVLR2gwUWVGVzhiOVVmT3Q5?=
 =?utf-8?B?dFBIWE9lOUZXSnZnUXpFYmQ5UlFGMHI1Mk1JQlNDbG9jYk5lb0wxSGNvK0E4?=
 =?utf-8?B?bEUwL0dMb3NJYmNoRU04SlJsVzk3anBGVE9WaUh1dDRvR0JWV1pOblc0ak5K?=
 =?utf-8?B?YXpnWEIyN25UNG5FY0NzMXFMcVB1VlNQVHdxeWdhSHNvazNaVmw0WmNqb1U3?=
 =?utf-8?B?aU16cFNES0Y1M1RTOWNuRk8zRG5vU3IzdUk2USszbmw4ZHdYb1dyQ0RUcmtv?=
 =?utf-8?B?WFYxK2NlOE9FN0owczQwNGFjMEkyOHNMY2dpQWRnSXdXcFZQNmVJU0NjcURJ?=
 =?utf-8?B?bEFhWFlXeklxWFV4NVlGR2lleFl3RCsyRDVmcXJwWUJjamMrV3UwOXdsWmQ5?=
 =?utf-8?B?UkNpUjMwejlid2owenZhbUJFVS96Y2g3UWt3RnUyS0NHMmY2Q2NiZ2ZIazNT?=
 =?utf-8?Q?E90FGWWbLtse+k1AlXov0k0yBcblnO0df6h/KENoIJ2MuV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXBMQ3cwYmthNlIvMVVad3BacjRvNXNwckhPamh1WFNraEtJZEwyLzFsTlln?=
 =?utf-8?B?QjVOVkoxSVIvTGZVR0FTa1VOVlp2ZU9RR2hsbmQwNWVUQ2RscWlWRmtUanhX?=
 =?utf-8?B?Vk9oMVV3bm43QnMvSEJ4c3hmY21KTWpIYWllUGc5UU5BNERJMU91L1NlNGFB?=
 =?utf-8?B?MmZnYUVncjdTRzN0UXIzTTFvRlZ3cmFJQllzVTRJbG9LQnJacnRnU0JUYmFa?=
 =?utf-8?B?c1VpS2l6OE95U3Bhcm5sZGVIOTBHVjd1c0k2SU5hT2pTakVJNURMUmgyR0wv?=
 =?utf-8?B?dnVTNXpMZzJDSjlra2ZFRUg4WEJMS3IwR1RqQnZra05kR09lcUZNd2V6cEtq?=
 =?utf-8?B?NDRuKy8vMlZiYllSSlUxZGd1RVUxR2pUTk1NdkkvVEVuRElNOFZqeUhuOEp4?=
 =?utf-8?B?REdQZmxZcjFyeEJnUzdIQWVmT1ptQW1RdWdaYUNza3ZHa3dHWHN3bk9KK1FB?=
 =?utf-8?B?WmRvTXU0RCsxSGdEenliZUlZT2d4aGllRHZFbStEQ3NQV1gycTIvdVBpU3F3?=
 =?utf-8?B?b1VxaGRHUzk2V3diYzdsK2pTNVpXTnozOTVZT3hPOHA5VDkwano3Y3cyNW9G?=
 =?utf-8?B?b0RCcmJvcjJMSHkwWGl0L25BTkNOVk50czg3clFVVXM4VlpYeVFyWlFFbDBo?=
 =?utf-8?B?MHU0SVh5d1Bha3dtOHcycVdDeXoyM3Zvb3N3ZjVxR0VaTFdNU29OZDZyYlp4?=
 =?utf-8?B?MGk5T3hIcFVnUytzNm9EOS9MZWZXVHZaQU9QakJadWl1cVNJVWgwUGNtc3RK?=
 =?utf-8?B?SXZ0aG8ybG5YamZsNVNoWGd6NmcvN2dOZVV4anp2UGVVcnpTaWlYL0VsWHgr?=
 =?utf-8?B?eDNnVUpKRHNHNi9sZE1iak9qVlR4eTNlQURILzJiREdZTGwzOSt1Q2FzY2pT?=
 =?utf-8?B?TG14VzBIeVhIbERvNUMxVlJpUmtIaTdmUE1ZZHg1WEdFQ3Z5cHZEajNFUTRl?=
 =?utf-8?B?ZU5BVU9tbXJ1aFhwVnBuWGdmMTZmS2ZlSWxyOUhJNU5FZUlkOTgxaUlnckti?=
 =?utf-8?B?dTVURURaNGkwaHI3aDRocEZLenE2NWQ2cDFKbWFweEVqZVg3NEFwaHo5UGJG?=
 =?utf-8?B?aFVFVUtUY1grMGswT2REaDU3aDlHS1NwSzl4Y3V3RENZdkFzcnpFazYvOXNH?=
 =?utf-8?B?bnN6ZmZzVEhHcyswdnJzYTU5QmZBRm9XMHhKaUVvY0dlMGxVVTRLWlR0cVM5?=
 =?utf-8?B?R202VHMrRStrazlodkFFTnV6SEt3cGc4SGcvTGtDRnhzQkl4aXpmNlNidURZ?=
 =?utf-8?B?YVFKUitHMGRmaGdXZ3kvQWs4eUlEZUU1N012blRvdUpYeXByYlRrZWEzekV3?=
 =?utf-8?B?bEUyT3lvR0FPSFp3MmdNZjU3amFzcHRkYWJKN1pHQ28rRGpsc1BaZzZhNmtx?=
 =?utf-8?B?VnRyUGI4M2VCdTlsWWxXNW9UQ0toTlNSclFIYmdZMzdFWTJxUFJnWVBveUo5?=
 =?utf-8?B?bTg4ODB3YVlDOVZ3aXdGVUFqNHlGSkNUZVByc2plclNyVzI5YnRxQ2RjaWh1?=
 =?utf-8?B?YUdyN3lTM3VQYXRTZElHN0xOR0hrQzlwejFudmlvMVdFMm9kNlloMXhYdHp1?=
 =?utf-8?B?UlVaUHJlcTA4aXRteTB1OXRLT2xzOVhUUEpZY2diak96T3lUVDh6OSt0dDJN?=
 =?utf-8?B?RGlmWC9mRE5GK1FvbWtEQTh2VFpkQW15NUF5YWhEMzBPYU9zZUZaWkFkR3J6?=
 =?utf-8?B?eU9lUFdUbWd2ZWFrZmVNOG44akdiQWtpTi9uYnJkbWplR0QrZ2lSdzhWVXBy?=
 =?utf-8?B?VTdZeDcxazNrUVR4cUtoL01wN1A0STV4dVlQNm9pSllYT1dNZ21VbHdDYXJw?=
 =?utf-8?B?THZtTEFnaEJCWklUbkhjVVZ5a2plNUZ3elh5bUI3OWRTRVdLamNVYjY1d3J3?=
 =?utf-8?Q?Kw3eMmMBHyf8T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9076a8ed-f090-40cd-e7de-08df38cfe0a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:55:58.8158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR05MB999189

dGNwX3JlcXNrX3JlY29yZF9zeW4oKSBhbGxvY2F0ZXMgc2F2ZWRfc3luIHNlcGFyYXRlbHkgZnJv
bSBpdHMgcmVxdWVzdApzb2NrZXQuICBicGZfc29ja19vcHNfZ2V0X3N5bigpIGNhbiBsb2FkIHRo
YXQgcG9pbnRlciB3aGlsZSBwcm9jZXNzaW5nIGEKcmV0cmFuc21pdHRlZCBTWU4gdW5kZXIgUkNV
LgoKVGhlcmUgYXJlIHR3byBvd25lcnNoaXAgdHJhbnNmZXJzIHdoaWNoIGNhbiBsZXQgYW5vdGhl
ciBDUFUgcmVjbGFpbSB0aGUKYWxsb2NhdGlvbiB3aGlsZSBzdWNoIGEgcmVhZGVyIGlzIHN0aWxs
IHVzaW5nIGl0LgoKRmlyc3QsIHRjcF9tb3ZlX3N5bigpIHRyYW5zZmVycyByZXEtPnNhdmVkX3N5
biB0byBhIG5ld2x5IGNyZWF0ZWQgY2hpbGQKc29ja2V0LiAgVGhlIGNoaWxkIGNhbiBiZSBjbG9z
ZWQgYW5kIHRjcF9zYXZlZF9zeW5fZnJlZSgpIGNhbiByZWNsYWltIHRoZQphbGxvY2F0aW9uIGJl
Zm9yZSBhIHJlYWRlciBvZiB0aGUgb2xkIHJlcXVlc3QgZmluaXNoZXMuCgpTZWNvbmQsIGluZXRf
cmVxc2tfY2xvbmUoKSBzaGFsbG93LWNvcGllcyByZXF1ZXN0X3NvY2sgZHVyaW5nIHJlcXVlc3QK
bWlncmF0aW9uLiAgVGhlIG1pZ3JhdGVkIGNsb25lIGJlY29tZXMgdGhlIG93bmVyIGFmdGVyCnJl
cXNrX21pZ3JhdGVfcmVzZXQoKSBjbGVhcnMgdGhlIG9sZCByZXF1ZXN0J3MgcG9pbnRlciwgYnV0
IGEgcmVhZGVyIHdoaWNoCmFscmVhZHkgbG9hZGVkIHRoZSBwb2ludGVyIGZyb20gdGhlIG9sZCBy
ZXF1ZXN0IGNhbiBzdGlsbCBiZSB1c2luZyBpdCB3aGVuCnRoZSBjbG9uZSBpcyByZWxlYXNlZC4K
CkJvdGggcmVxdWVzdCBhbmQgZnVsbCBUQ1Agc29ja2V0cyBjdXJyZW50bHkgZnJlZSBzYXZlZF9z
eW4gd2l0aCBwbGFpbgprZnJlZSgpLiAgRW1iZWQgYW4gcmN1X2hlYWQgaW4gc3RydWN0IHNhdmVk
X3N5biBhbmQgdXNlIGtmcmVlX3JjdSgpIGZvcgpib3RoIHRlYXJkb3duIHBhdGhzLiAgVGhpcyBm
b2xsb3dzIGNvbW1pdCBlM2YzM2IwYTFkODkgKCJpcHY0OiBmcmVlCmluZXRfb3B0IGFuZCBpcmVx
X29wdCBhZnRlciBhbiBSQ1UgZ3JhY2UgcGVyaW9kIiksIHdoaWNoIGZpeGVkIHRoZSBzYW1lCm93
bmVyc2hpcC10cmFuc2ZlciBwYXR0ZXJuIGZvciBJUHY0IG9wdGlvbnMuCgpUaGUgaXNzdWUgd2Fz
IGNvbmZpcm1lZCB3aXRoIEtBU0FOIG9uIHY3LjMtMTYwMDctZzM2YWFkMjFkNTBkMSB1c2luZwp0
ZW1wb3Jhcnkga2VybmVsIGluc3RydW1lbnRhdGlvbiB0byB3aWRlbiB0aGUgcmVhZGVyIGFuZCBy
ZXF1ZXN0LW1pZ3JhdGlvbgp3aW5kb3cuICBLQVNBTiByZXBvcnRlZCBhIHNsYWItdXNlLWFmdGVy
LWZyZWUgcmVhZCBpbgpicGZfc29ja19vcHNfZ2V0X3N5bigpLCB3aXRoIHRoZSBhbGxvY2F0aW9u
IGZyZWVkIGJ5IF9fcmVxc2tfZnJlZSgpIGZyb20KcmVxc2tfdGltZXJfaGFuZGxlcigpLiAgVGhl
IHNhbWUgZXhwbGljaXQgbWlncmF0aW9uIHRlc3QgY29tcGxldGVkIHdpdGhvdXQKYSByZXBvcnQg
d2l0aCB0aGlzIGNoYW5nZS4gIEEgcGF0Y2hlZCBrZXJuZWwgd2l0aG91dCB0aGUgZGVsYXkKaW5z
dHJ1bWVudGF0aW9uIGFsc28gY29tcGxldGVkIGEgc3VjY2Vzc2Z1bCBtaWdyYXRpb24gYW5kIHNl
dmVuIHNhdmVkLVNZTgpyZWFkcyB3aXRob3V0IGEgS0FTQU4gcmVwb3J0LgoKRnVsbCBhbGxtb2Rj
b25maWcgYW5kIGFsbHllc2NvbmZpZyBidWlsZHMgY29tcGxldGVkIHdpdGggVz0xLiAgRXhpc3Rp
bmcKd2FybmluZ3Mgb3V0c2lkZSB0aGUgbW9kaWZpZWQgZmlsZXMgd2VyZSBtYWRlIG5vbi1mYXRh
bCB3aXRoCktDRkxBR1M9LVduby1lcnJvcjsgdGhlIG1vZGlmaWVkIGZpbGVzIGVtaXR0ZWQgbm9u
ZS4KCkZpeGVzOiAwODEzYTg0MTU2NmYgKCJicGY6IHRjcDogQWxsb3cgYnBmIHByb2cgdG8gd3Jp
dGUgYW5kIHBhcnNlIFRDUCBoZWFkZXIgb3B0aW9uIikKRml4ZXM6IGM5MDVkZWU2MjIzMiAoInRj
cDogTWlncmF0ZSBUQ1BfTkVXX1NZTl9SRUNWIHJlcXVlc3RzIGF0IHJldHJhbnNtaXR0aW5nIFNZ
TitBQ0tzLiIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IFlpbmdq
aWUgV2FuZyA8eC1wcm9mZXNzb3JAb3V0bG9vay5jb20+Ci0tLQogaW5jbHVkZS9saW51eC90Y3Au
aCAgICAgICAgICAgICB8IDIgKy0KIGluY2x1ZGUvbmV0L3JlcXVlc3Rfc29jay5oICAgICAgfCAy
ICsrCiBuZXQvaXB2NC9pbmV0X2Nvbm5lY3Rpb25fc29jay5jIHwgMiArLQogMyBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC90Y3AuaCBiL2luY2x1ZGUvbGludXgvdGNwLmgKaW5kZXggZDE4ZjdiYzFlNWQwLi5k
ZDNiMDk3ZGFhYzkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvdGNwLmgKKysrIGIvaW5jbHVk
ZS9saW51eC90Y3AuaApAQCAtNjI0LDcgKzYyNCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB0Y3Bf
bW92ZV9zeW4oc3RydWN0IHRjcF9zb2NrICp0cCwKIAogc3RhdGljIGlubGluZSB2b2lkIHRjcF9z
YXZlZF9zeW5fZnJlZShzdHJ1Y3QgdGNwX3NvY2sgKnRwKQogewotCWtmcmVlKHRwLT5zYXZlZF9z
eW4pOworCWtmcmVlX3JjdSh0cC0+c2F2ZWRfc3luLCByY3UpOwogCXRwLT5zYXZlZF9zeW4gPSBO
VUxMOwogfQogCmRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9yZXF1ZXN0X3NvY2suaCBiL2luY2x1
ZGUvbmV0L3JlcXVlc3Rfc29jay5oCmluZGV4IDVhOWM4MjZhNzA5Mi4uYjZjY2ZjMzExNDdkIDEw
MDY0NAotLS0gYS9pbmNsdWRlL25ldC9yZXF1ZXN0X3NvY2suaAorKysgYi9pbmNsdWRlL25ldC9y
ZXF1ZXN0X3NvY2suaApAQCAtMTYsNiArMTYsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+
CiAjaW5jbHVkZSA8bGludXgvYnVnLmg+CiAjaW5jbHVkZSA8bGludXgvcmVmY291bnQuaD4KKyNp
bmNsdWRlIDxsaW51eC9yY3VwZGF0ZS5oPgogCiAjaW5jbHVkZSA8bmV0L3NvY2suaD4KICNpbmNs
dWRlIDxuZXQvcnN0cmVhc29uLmg+CkBAIC0zOSw2ICs0MCw3IEBAIHN0cnVjdCByZXF1ZXN0X3Nv
Y2tfb3BzIHsKIH07CiAKIHN0cnVjdCBzYXZlZF9zeW4geworCXN0cnVjdCByY3VfaGVhZCByY3U7
CiAJdTMyIG1hY19oZHJsZW47CiAJdTMyIG5ldHdvcmtfaGRybGVuOwogCXUzMiB0Y3BfaGRybGVu
OwpkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvaW5ldF9jb25uZWN0aW9uX3NvY2suYyBiL25ldC9pcHY0
L2luZXRfY29ubmVjdGlvbl9zb2NrLmMKaW5kZXggOTNiMzA2ZDkxYjZkLi5hMjYyMmVjY2FmZjEg
MTAwNjQ0Ci0tLSBhL25ldC9pcHY0L2luZXRfY29ubmVjdGlvbl9zb2NrLmMKKysrIGIvbmV0L2lw
djQvaW5ldF9jb25uZWN0aW9uX3NvY2suYwpAQCAtOTA4LDcgKzkwOCw3IEBAIHZvaWQgX19yZXFz
a19mcmVlKHN0cnVjdCByZXF1ZXN0X3NvY2sgKnJlcSkKIAlyZXEtPnJza19vcHMtPmRlc3RydWN0
b3IocmVxKTsKIAlpZiAocmVxLT5yc2tfbGlzdGVuZXIpCiAJCXNvY2tfcHV0KHJlcS0+cnNrX2xp
c3RlbmVyKTsKLQlrZnJlZShyZXEtPnNhdmVkX3N5bik7CisJa2ZyZWVfcmN1KHJlcS0+c2F2ZWRf
c3luLCByY3UpOwogCWttZW1fY2FjaGVfZnJlZShyZXEtPnJza19vcHMtPnNsYWIsIHJlcSk7CiB9
CiAKCmJhc2UtY29tbWl0OiA5MDI0MDdiYzU4ODU3NWFmMGNlYWU1ZGU0ZjYzNWZlMWUwMjRmMjU4
Ci0tIAoyLjQzLjAKCg==
