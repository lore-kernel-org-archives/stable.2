Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.87
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794325682;
	b=qLLhvQ9neVLCwtUhLvEU5SCq8Imr+gS7bePhR/GuqxvZkESSSYcWwN5kMHR/N7wEpw28
	 ApdnWxT11J7G3WJ/vXUrZocUO0ZBMDEFFTb5wJ876+vJjTNHgMQCnXX+tnMJvviui4mL8
	 FdFq/NvMR+bH3RPGPkvNsN+E6IxzmrUOOGpgKtvy1nX8S7VKEbgDi7gwjHLpXGwdpOrF3
	 0YeHBE4094rPBcSg1+RmYEI+pFopnY3ciWQp1gO8pUg7EHbjfVjhZakLdXkQ1hQdgsFA0
	 H5y6G4xar87y58OqMS5Wx7/6jmyw+ugcX0GtmwiounjDCLogrOrPcRLRcIvVpvZMvkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325682;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=WQ7EzJuXxYOeIycWNH7CbWme2ZO1NFYrSwga7OF/N1Y=;
	b=Cry2a722lWlrfZWTGbDJs8hQXRlWzK4XG/amusncgPmupBOMR05m4TS14+qLmTFKRZgz
	 Y7BeDMkOi9zEkTLRz28VNrQaLmYDT1m4QmhWL8woLoEbumSZuTsEmm1gNoInI1zJvFbQo
	 zMb5uenvvT2l8kWV8UJFfCEP7tKeF4xqqxJFqiN65ot/1yXdzGoTGO3CMaF9Fegn/eo9G
	 sjJYkZEbdsO2nzgfiYuO9alkiTTEkpR1DEuAaPP1I0tRBzRc0cX5YXCOM94vPi9E9Rrlo
	 xOMlLFYqDDHIEJYuOsT4nSsLm54B1twGiruX8SdchdtoEdfHUg9gtTMGZ3O1buARMrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=sU5csDz4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.87
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013087.outbound.protection.outlook.com [52.103.7.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479BD606A33B;
	Tue, 10 Nov 2026 15:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479BD606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=sU5csDz4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWxmEcuafPiw6IS5mKPgm/TKmEDpJqzgKASjO1Ok9m2nt1cV6xN/zOtDzCldciv7PSPPqXjoHuQVTQOfBoF+iTEowIbhReb3H9GKto2o0t6l8h2pG6m8a7FHYll10c8ZNxYMAGDSLPq6ehfnBLKiltT/6ZBhRvAGHEjOzDYj5JvfzZ+t+xWDhkUg0eB6Bb5LPlwLAI2eNGaDmM2e6cR4yy1KVimhjsrxGP5UHyMgW33m7DM9OYPC3xC0P2Lz+A619fSqCOMGsGBGZevdGuGxH0Kd/fHBjsWvtelqe4rhtNa8pzkrtpeKBMcub14gjJaMVk0x3v1DTyfhmVZ3K+AXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=WQ7EzJuXxYOeIycWNH7CbWme2ZO1NFYrSwga7OF/N1Y=;
 b=D5U6w3CWssyTJnIJDa76VGGkrd/TM8iOFzoJk1t0FwOzYSrRuMaGW0jvQKTU7F4zqw0IvisFja4cqnZ4/D+QDhdpDi+80rhERgtKIbP895lqEGGuo2RnLcoMnjWvejWTb45ivj4lwEmmch+KA0fJ0687E4/rUSoBpP7/1zjHub9HZtP708jeDOMBMO9K38MPgDj8ovrERM8N4rZzoSU20/GaOj0Ra/J75UxzwvPit7Cna3TTUZuL6fosjkESZ6QfEceyC+uvXwD7IDc/o5ZyErzL0wwNTKSDfwSBTXlL9dDMbz/zsmGpDPyCUzfPmpop0w9HMnQ7E6lY6fjzuD4gZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ7EzJuXxYOeIycWNH7CbWme2ZO1NFYrSwga7OF/N1Y=;
 b=sU5csDz4K/W+CqjAmDSSR9Q0Ste/CLRfEXe7FGKvi41O/D1lWhDFrpnm4NKAswnhGnOKnnWeEJJxdnUk+ImXn0lZAiIYLs5w57AFYLC78mGSUZvsNAdawDh7XGxeAB5Hy35kubA3KRikJS245r5F+zIGWXKKRIaJxDXpy3loH8XprS5RQSWtwmBYouX8l2g9fbZGRGtl3SIPjrsLeTXSpk9jVsNHu7/XutyOOdZHJsOcPa1a0v68eIOldmnIHeuoOD9wgznRvlkXcNamLb/49Iv4031zO0EXZ5HzpqJy7leaz+r8gXGSO/PL2lxCNBvIiw49a2QppjreN+67E7Liuw==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by SN7PR05MB7775.namprd05.prod.outlook.com
 (2603:10b6:806:105::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:48:00 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:48:00 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "kuniyu@google.com" <kuniyu@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "matttbe@kernel.org"
	<matttbe@kernel.org>, "martineau@kernel.org" <martineau@kernel.org>,
	"geliang@kernel.org" <geliang@kernel.org>, "ycheng@google.com"
	<ycheng@google.com>, "weiwan@google.com" <weiwan@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH net 2/2] mptcp: avoid wrapping blackhole timeout
Thread-Topic: [PATCH net 2/2] mptcp: avoid wrapping blackhole timeout
Thread-Index: AQHdcSrdwPuoRpGo5USJG4gPdGHMbA==
Date: Tue, 10 Nov 2026 15:48:00 +0000
Message-ID:
 <738e11db58137c0082b53fb1662ab0b70763f51a.1794325665.git.x-professor@outlook.com>
References: <cover.1794325665.git.x-professor@outlook.com>
In-Reply-To: <cover.1794325665.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|SN7PR05MB7775:EE_
x-ms-office365-filtering-correlation-id: 1dad9ba6-40b3-4639-1a80-08df3f41ffb2
x-microsoft-antispam:
 BCL:0;ARA:14566002|4140399003|24021099003|25010399006|31061999003|38102599003|24121999003|22091999003|41001999006|51005399006|8060799015|8062599012|19110799012|15080799012|40105399003|30101999006|26121999007|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UIR60Q6KWQerP+PQ4KlzRwW70Q0vbUy8VKIyecEnzbVrR/wzDnyRmb7Mho?=
 =?iso-8859-1?Q?Zm0fWNm37A3uNK+XzVdZr2cvWIIM3p9vz+b0jBNFpoBY9ypz+XYfhmnVqG?=
 =?iso-8859-1?Q?HsXFN7QzK+JVjkHxfpgN2n2fB3Ode5m4S3HHCoyDeXvzjBbEjxRry6cdgI?=
 =?iso-8859-1?Q?FLwI9cFWZ0qMw/dqbqltOxiyAAU8wECyhHBMzE0iw8c4GrzS/aDsMUZowQ?=
 =?iso-8859-1?Q?hKRajcGPp01lr5bxV9lKX/53W803EP834TXgq3xfsNBxPDZ3L3ai+UfRCk?=
 =?iso-8859-1?Q?+cETgTN+k8q/vW5ylAOwq+LRrkvsQUrXx1mxMBN978iyWBBx3IMlwyQ9O9?=
 =?iso-8859-1?Q?pyoMCj1vj88K5hLMVO5Bly/RLI0moZ5xD7dtDqHs43uauN8UJ34S7VhN2w?=
 =?iso-8859-1?Q?i8QRP+CDv+1H5ZGdEcHzu0+tozJZ2ZozocaWwGONMBTGX3OiaLkXGzNPEa?=
 =?iso-8859-1?Q?ir9KJqp5lM/5SNVhDKbiXcUcR1TeJgw3xtPmPb9feFkmKXleS673xks+1l?=
 =?iso-8859-1?Q?tPVfB78Xtz8xdGeKdGhhXFeTl+/F1I6/7lTLywPjDcJH5fdiAItaVlTnT9?=
 =?iso-8859-1?Q?fQODmG0xXW9kbsui5kwaEC0cXqYmPNW6zIX8u5AoUTMiFMUGDkkSZhvycf?=
 =?iso-8859-1?Q?z2Llfbv0aMWkdr6AYwEweXCWnelnOasscdvlUaZ/jwzrVLC4qS28yFNmCo?=
 =?iso-8859-1?Q?28GOh1v8aDX8rkRN14S0WF4r2vnPiZPGNNGdNorbj++iNkgSf/HIDF9+9o?=
 =?iso-8859-1?Q?supvkQ3s4cDg6orIoI5zGD/Xd++Xv6I/bgvNe8Bd1DCYOzSa+FYycHpw2X?=
 =?iso-8859-1?Q?sKiqtvDvj5JQCC7xAFMS/fxj+LrIob7B2PgJ9451lqhseY3/tS76y4RgRE?=
 =?iso-8859-1?Q?kEvCjPsPobCcOuL14qK9cJvymX3OgrfymNUw/aup5WE97u7hRJ8hllWMJs?=
 =?iso-8859-1?Q?lxx5USSjQ2xrpv4S/6O8FaoS/vm+tUg222Ruq1TtBEYxn+azLYrp8JQlwZ?=
 =?iso-8859-1?Q?AKCuxE/HQp0g88DIb5ABFQaWhcMt+Qa+vpuWDa15C/Z6WB13hAHA/MqGF9?=
 =?iso-8859-1?Q?uRg3J/mT5vbHbLEbTmgQeAGE20JvtBOJdx8zu82FN5YMv6lWO206pSv+NW?=
 =?iso-8859-1?Q?5AkNcLr4cDegnzJi8Z0URN06A2443ZzPKb/rTprJpIRCBjkoh2?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Q+wVMXuy75+Dny5bpPJqxtbgB0U+fBrr2Nq9Wij9lE1OrzvtZHHq2ILFMW?=
 =?iso-8859-1?Q?3n7tQcHVXGNp0tSsgTFLf9PTZDyqkE9/gGuChMV0vA4is+xFRtkJ6NVLQW?=
 =?iso-8859-1?Q?MLcrBxFwsRRBuK3l6hcQzjBIJQOj5FnYHHq0QpBKKDJF9GJgKo1Kr8qHHh?=
 =?iso-8859-1?Q?t2UKc4nhMY6C0iTweyKWiXKcdEBsaLeJqvMf24wQTIEM29vpYovsHmVGP2?=
 =?iso-8859-1?Q?4t+IAQwX80t3jJsva/EjkLgGA/kyL8pKlOchwCMs9DEBIL1JCglqfoAItO?=
 =?iso-8859-1?Q?RrLarJ4QdiL0vFzTN6VEZWpdXE0uiZYekxky6Akgr48RrHze/WydfG+K+1?=
 =?iso-8859-1?Q?4P0JXsToiqSeWuW2tlw3J4WAk3+VJLudqs3iJjpVWHuRzzqTVNiGw7DncJ?=
 =?iso-8859-1?Q?4ISNba411EmSvEzFRplfy8Dn9PQsbOfyxXYICZRbLtmUvxoTUWhI13q4+4?=
 =?iso-8859-1?Q?YoWijaidx/XrKfM9UtTd6IttvHqIFxExuPkudHGspqfcM4JRR2V6VqEnCz?=
 =?iso-8859-1?Q?Uzaog7Iic5TfA86Vz5F8BIbehdw7xmU5Wvza4dIfHYgur84QC5LkduG1D4?=
 =?iso-8859-1?Q?pII5tVP8HEYqIJmxJHG5ZyQOkKpx4ZO/zQUI60SP18zxyhVcyefc+AOnn9?=
 =?iso-8859-1?Q?mCZJEo2ApR7XFjBsS6BzsQbdVOXuGhAkdhLm3JVaxysO/bxaKI9Arv+eOp?=
 =?iso-8859-1?Q?pL3KriDg7YBZXDFbqVvbYFgETx9OTajh6zq7jATalxH2p3gfSvrY+zLLKt?=
 =?iso-8859-1?Q?E5CA6SDMRaKC8LKN6NXs9wHvMkS5ohEFdYHCGAsbzdrBTcARb/qzPGT8oP?=
 =?iso-8859-1?Q?Bl/kXXEOzqQMtS61mI4mtyHGThJddwip7uiRvq0vwfkhg9Cs1/VqgPLo8m?=
 =?iso-8859-1?Q?MEFK5wJW/dx5zbpwXBQ1C+i4UF9jeNvqiW5kEGBg7mae/epS2wFo2rTxu5?=
 =?iso-8859-1?Q?x1ZCQqhvNKdozDBAJZCp5Gk6MXhOI9SUj5YP+Tz3YOswJY3s7gG1iaP8kL?=
 =?iso-8859-1?Q?HqhQiXfyalr519swbkDJC4zAEYkilliwBHP7bAvVdckj6JQlsghHznku4h?=
 =?iso-8859-1?Q?F+PgEYrUdwiHt3GM32tERYGepW41ia+5R9xswILVaxraeJsBYCAwjhTAHA?=
 =?iso-8859-1?Q?ZqVFAyt6BoFQomX6HM+ieLUodMXNUaDDjTdGNW0r9z/ftMNZc4cRxFwESY?=
 =?iso-8859-1?Q?NS18TQIqo2kluuMUEX0IYmHQmjjnlWFpC4i8Mn7nwImBgvgtJ6VQXYiT9X?=
 =?iso-8859-1?Q?/aRSE7O3W4m0uzxvJwsCBh6nJZElowoYWANhU4alC+Q7DELoXS22GHRobR?=
 =?iso-8859-1?Q?FHm89T+AUpIOv8Ra4F46qzScR9RTkifD2LSiGOiOJVMrwtuf3bWFYos3xU?=
 =?iso-8859-1?Q?pi3SocVeSw136S2zm0wL61Jgl5KjSkdiVpsmCZtF3yJnhhVTKY+nGsiYAm?=
 =?iso-8859-1?Q?30/nXixG9rb0sU67?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dad9ba6-40b3-4639-1a80-08df3f41ffb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 15:48:00.4973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB7775

mptcp_active_should_disable() calculates the active-disable interval as=0A=
multiplier * blackhole_timeout * HZ. Since all operands are 32-bit, a=0A=
large blackhole_timeout can wrap the delay even on 64-bit kernels and=0A=
make active MPTCP available again while the blackhole is still present.=0A=
=0A=
For example, with HZ=3D1000, a timeout of 6912213 seconds and the maximum=
=0A=
multiplier of 64 should produce 442381632000 jiffies, but the current=0A=
calculation truncates it to 512 jiffies.=0A=
=0A=
This issue was found using a static analysis tool. A loopback reproducer=0A=
induced 12 MPTCP blackholes and waited 1.2 seconds before opening another=
=0A=
connection. The unpatched kernel retried MP_CAPABLE, while the patched=0A=
kernel kept MPTCP disabled and used TCP fallback directly. The reproducer=
=0A=
required neither kernel modifications nor fault injection.=0A=
=0A=
Compute the interval in u64 and cap it at MAX_JIFFY_OFFSET before adding=0A=
it to the saved timestamp. This preserves the existing exponential=0A=
backoff for representable intervals and prevents large values from=0A=
wrapping into short timeouts.=0A=
=0A=
Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
---=0A=
 net/mptcp/ctrl.c | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c=0A=
index 63c5747f0f63..5224cfb3ed1f 100644=0A=
--- a/net/mptcp/ctrl.c=0A=
+++ b/net/mptcp/ctrl.c=0A=
@@ -487,6 +487,7 @@ bool mptcp_active_should_disable(struct sock *ssk)=0A=
 	unsigned long timeout;=0A=
 	int disable_times;=0A=
 	int multiplier;=0A=
+	u64 delay;=0A=
 =0A=
 	pernet =3D mptcp_get_pernet(net);=0A=
 	blackhole_timeout =3D READ_ONCE(pernet->blackhole_timeout);=0A=
@@ -503,10 +504,11 @@ bool mptcp_active_should_disable(struct sock *ssk)=0A=
 =0A=
 	/* Limit timeout to max: 2^6 * initial timeout */=0A=
 	multiplier =3D 1 << min(disable_times - 1, 6);=0A=
+	delay =3D (u64)multiplier * blackhole_timeout * HZ;=0A=
 =0A=
 	/* Paired with the WRITE_ONCE() in mptcp_active_disable(). */=0A=
 	timeout =3D READ_ONCE(pernet->active_disable_stamp) +=0A=
-		  multiplier * blackhole_timeout * HZ;=0A=
+		  min(delay, MAX_JIFFY_OFFSET);=0A=
 =0A=
 	return time_before(jiffies, timeout);=0A=
 }=0A=
-- =0A=
2.43.0=0A=
=0A=
