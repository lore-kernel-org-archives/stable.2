Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794325680;
	b=naskizUV38Rq6f8e41KPi+DwSgQv0A2LWftkqYrddWL5lDAS59AVoyGLZeHF/O/kgN6X
	 vPJ4SpB1YNYPSEsDxhW1Y/4OrnijOrulh9+AFSEve2DR80K3NnFa57JW3PCHAJ4TTZcjY
	 n+6YrjuGNXeaDQ4clZpo6XOAZrj2glc6FSlKH9TZR4Fr6/5TzuetUfV5r+A9WaFC16aqw
	 MD0EjGgAJYYl+tR4opUYTPp34CMkqpSYBQ0abbyEjo7whLkHKan/hw1zgOrc3IrCvQBDF
	 V50gJPDeNHPjtersJvOBR3y6bVfdkW2Ww0GZiTqp2ImRuaJSKwVtAyFU6CzlTyPZt0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325680;
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
	bh=58Df+rIzBq5xgTYTiEYK5PU8HD9/K/WFi6VRDWxHkts=;
	b=zoMnZOmPCHqnyu9CPrwKXkWOUslv1402+QnVLXZy+THplTqcKUBiC8wXsVSB+sjvL3Gg
	 k2XFoXStXkhcAhx+4vouRyjAB2YqAisrZuatncVDOOaBtFPqrMp0L/uGTPct2JNO8fXMU
	 xgt6Ct+P7AbPrCD6HtTthjkhrrOidm+lu68A5Vt1y9Use337+IENuBZ7D1H5bYFsQASwY
	 uQBqKboY5J9tyl3n5HnvFTERhUbHAThZrBVsiCjRIX6WdyOwgQlskwclslSez3qKu6mOz
	 lCQJruwh5t7A1wlyKvmiCuMmwWlALJCGxFzlEPMYVzVtKfgDSGRDBleED5Gww9zhSvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=mAqWHQc+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.79
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013079.outbound.protection.outlook.com [52.103.7.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAC606A330;
	Tue, 10 Nov 2026 15:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50DAC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=mAqWHQc+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZFcB5duvhPMkIM6XvEaCvfRqV1lKsXlKhAbH1NvVIfliZGeiHvR8eo7SI1w7Np/FjfYY/Zd2Fvl3x7vd8KSvr+jnmukMPAdVdnAxoJ8gQueMpIyXJmCMU9yBxwvhh5/RL9JirJG7BhCJNwiXhDb9H31oZCP6+kcFDHw04NdFwO8NiqpquA8ON9pRL7Q8loWYkoToRWBVF6Z/8ik2cMSelt6qpzAL7MEPG5I3LFVFqdDEBAB3fUOrVBV+8PJaD+DTA5YuFaxCICJJ+r+vT7LG6/NWRgSlgWJ8GCkVgVd7Ox1wZpUVCCO/Y5WqjZvsPB3QUWcZTXKomSvaWcBaHWfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=58Df+rIzBq5xgTYTiEYK5PU8HD9/K/WFi6VRDWxHkts=;
 b=ZFmaTfE7m5ANaMkyoLJjF/mVgMjAsx+Bs04zCJiF15CFs432mgkMh++Emvass2eBEWXhyxW0QD+T6LHmFdoZkD6SgdkG/UDjAyx77Jzaj6s7x29WaNPWybz1/0K2mEHi7T7f/0y/1bJSl0ePwVyl/rxE4k7qdNACbkO3CVONBBbvmImkNmFGRy059VW9sg9JOb2zVholK8a7tdeqK6vkMBpcX0GvGqNxiLOrCRoNtsmPyjGCuwy6qM2CClmvGhLijjEfDrCChYS/QAGdjTT4lX2V5aH/hywAsCme1pTIoE8r+K0bUSP8aiaf2qOG+N8UX+GSDWRLE+rlkuwgI1IExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58Df+rIzBq5xgTYTiEYK5PU8HD9/K/WFi6VRDWxHkts=;
 b=mAqWHQc+mbiSyZCBIdS2WzJkX96ZJopUi68sss6Lfn8Bk84K96YdL8/jQ4mGfQ6IgNOYb8ZoeLOgJ9r2kxjWqTajY4medafJHQB2T5wDoPkTLzUC4v5Mr4QgHRZ5/P2VSNwTAcqhi7Nqp+0zi7xAHb7hdLOK/d5UC5Ucj11Jnq5aB+kGMV+CxB9q6jE8969negimB/icYWjIhsDJUxDXzYGzcBAeALF7fYTZXXzNzlC3fq/dfvCJe6FcJ5+2Lgd/UevzbAONuQ15cmbKUULUHI9KFz61wk6Rbo6tWGFgPwvkmrkzOab41fqD9fplHzMHVPpd6iWMHVI8O24u5ATv2A==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by SN7PR05MB7775.namprd05.prod.outlook.com
 (2603:10b6:806:105::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:47:58 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:47:58 +0000
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
Subject: [PATCH net 1/2] tcp: avoid wrapping Fast Open blackhole timeout
Thread-Topic: [PATCH net 1/2] tcp: avoid wrapping Fast Open blackhole timeout
Thread-Index: AQHdcSrbrMBlKf22GkaKiF/PgIzGQQ==
Date: Tue, 10 Nov 2026 15:47:58 +0000
Message-ID:
 <340d9f1f96e235642e8b47b5e7c836a18de8dd56.1794325665.git.x-professor@outlook.com>
References: <cover.1794325665.git.x-professor@outlook.com>
In-Reply-To: <cover.1794325665.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|SN7PR05MB7775:EE_
x-ms-office365-filtering-correlation-id: bb530568-1b35-4e9e-96f5-08df3f41fe6b
x-microsoft-antispam:
 BCL:0;ARA:14566002|4140399003|24021099003|25010399006|31061999003|38102599003|24121999003|22091999003|41001999006|51005399006|8060799015|8062599012|19110799012|15080799012|40105399003|30101999006|26121999007|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OpxACHBxDS8TCxaqjjmt0x8p4TYmkwhz67/fsOJJulrrTfN+VXAjgltooj?=
 =?iso-8859-1?Q?syaX8rFYfv1gjvXPPYOi6/Z8YxB8lxwE6oEkPLb7lwIWaVLCLi+luMAaEh?=
 =?iso-8859-1?Q?MGn+42W/I/QkNYivdx98qvPl3hGDbVcUmmkE5lxLrW8+W9xqfRJHgaYEAX?=
 =?iso-8859-1?Q?fhvKhAxuUquRdxhUhLGprKavrzwkvmz0a9yPxltlm96W2dbV7crCk1/uTu?=
 =?iso-8859-1?Q?L4VGXSw38q+6n6Ljbt0XYA3ayGTa12FM2CfwfyqF2HmFNdR6TcBIRKP7pF?=
 =?iso-8859-1?Q?M2DFvNdhpVWFgiHmkzj6OPyjcYXdMmBKV/nDXlMace2yUGAY2fu447FuKG?=
 =?iso-8859-1?Q?ccmsdKTDqLrbMQEmdvvqLzTyg7voog9R3jXaavOeaj9hslTzzNNKIZ6XXb?=
 =?iso-8859-1?Q?BMoVr68OvQypONqzAOtg25ooSJo7Kmg7hGKARG4nS5U2M05tUWxVrp41I5?=
 =?iso-8859-1?Q?224weBx11Tk7WvLhUUxbNw3vkMCUsTJJ0iNrIpAIAiKqzIOEncEj9Ugx+W?=
 =?iso-8859-1?Q?/T1+c6h5cijJQpUyJQ+CrsXLWySu8xoJLuowgwileu7n7tIRpPbnJmf6Kf?=
 =?iso-8859-1?Q?pp/13Hkno8YeFP4qah5OnZBaIXo4aWfLlmcrgANqzBBzYpg7VK5Ju2/AUT?=
 =?iso-8859-1?Q?vAQD7/cZBnGl4corJvRjDCPHHLCYSGa9pRfTL+yL/yUoVvw0jp/ytHIYXP?=
 =?iso-8859-1?Q?EEACBz71oVWTGFYfqDAPKf/EUsfSl4HlED5DwxIAV6Z2wrNkMLwXo1iQzt?=
 =?iso-8859-1?Q?64bzeZwADMw77O133aoQ+GIAODwJtRdP4IX5MnTQ14jV40CIB88q35zTct?=
 =?iso-8859-1?Q?GxfD5ehhpUNDE4sJ2Dxrx6gsm3Ap5xYNyx75vKV1KCgamD0iDRM1cFXL7k?=
 =?iso-8859-1?Q?Llhq2z5jaZQgDDRIYzQlW7jiC+qlXlrHbgWSH6ZRYCpLcum5XVXDHGqYzA?=
 =?iso-8859-1?Q?aOZkssQ+AFGTuzbBvxOYjYu3xQotQnKMQerXRmrxAp7AGWOHvE8721jdtT?=
 =?iso-8859-1?Q?jrf6ZW6gB0Ml5w0IFXMtB8u7OaJ+GFngfEzVCboH+/UWLQ3H/TgF57PEfe?=
 =?iso-8859-1?Q?6aGkaAT557lAjRsWI+/f1Sp4D55SaSR3XJ66IAqdVe6WPkru2yEzI+PPik?=
 =?iso-8859-1?Q?YC16RrbjoRIUQFXIknm3WrknIHTVDnr6/FXv9XtxvcmGtishDl?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HrQTqy3F8syBNbG1Mtl/iviUWptll6bw8Isidd5lZH2bCKSwq/YpRegJch?=
 =?iso-8859-1?Q?c/UWRz5e66omXB/vtJj9gktVpmoVOR56vkDJERw72j+HOgjBXvr2ZNWa+R?=
 =?iso-8859-1?Q?uD2U7oONY8LFVaXXicQi36JT9d4p9pn/VIbIlUCUeSl/ynQEZYHpfk06oE?=
 =?iso-8859-1?Q?NvnILRwm1/sSHIlzimdScmZK/AeS2RGKLyb1LeWRqLy+cwp+rJ0jcfclQ2?=
 =?iso-8859-1?Q?EZvN7DmEkvVJLqP3LQ9gI+YHcTa5QdS+HEEKXv3QvkINvM2iip4OW+WbsX?=
 =?iso-8859-1?Q?0AYiLiK0xLAJ8lg4b7Dw+JNKThd0P2Uv+QrxltzG9pXeMGFdwzMsJAhHZs?=
 =?iso-8859-1?Q?vmqnBgHBrPMBmlLIiiKWhjXSDir8kvl1DxLSOOdWy5OiozLRVHhLOvfkPF?=
 =?iso-8859-1?Q?rc3vgyIGo6QsAAFLm8sC5/3Pkrm5nGx+llFwRdA+fIWPpFPDJnAgEF6fdJ?=
 =?iso-8859-1?Q?kASyPRLpgOd9oKn+WEIZO/qvGjx57biNeHHsOEj4x1bgbDhbIALECSPZTI?=
 =?iso-8859-1?Q?zBJfASQGpA3QOOfm4lx3mTMIfIREAspKs/wfiq3rtB5T5YrON/MKX6pUwq?=
 =?iso-8859-1?Q?CWWXNM8TN2E2nIh/ByqXM8QVKMWt8/DMiCafvGXX07CIkjnXkV9/uo2RCK?=
 =?iso-8859-1?Q?/UU7g8Gqh694bZb/eq85Bz2nEXCk2zT7lt6MS4OvSU1GNIdnh47nzToz3w?=
 =?iso-8859-1?Q?j/N/zjMnHuKJ46/QWmlubveeOcbDNvXr2Vuee0BQk5Upl+EeTtZZjb8o9y?=
 =?iso-8859-1?Q?t4Waishg3wMfEBNgAwdQ8zuW+TnPZaJEboReRnWIF8h+RdQJ+kz857PT7k?=
 =?iso-8859-1?Q?8BeOqdVO/+vUf39Zp/ZDNREeVlB0+MblgcpYaanTEMTcfdFViTU+fRXUuI?=
 =?iso-8859-1?Q?VWbgdBy4+DI6Nu1kYHqSWRUNhnJl1QL7+rTI3FL+yowQpsvOtUiJPFfgHD?=
 =?iso-8859-1?Q?JOsQvZRJxgK7E+4VxM3Zl3Za7KvSwyeGrSz57l6R9KqHhI/24+iFcG+E2J?=
 =?iso-8859-1?Q?9UdGgacUXGPpgvkaqIXWq5D61/BXGwruXWbgJc6KnTZBNXK+pFMpvZM6jj?=
 =?iso-8859-1?Q?yXDu1k9Ad4IyGz5Bna0cS1jtxFRNra2oDt+C7mewjAJQHkeSU4LzRGa+dS?=
 =?iso-8859-1?Q?sfigrFCUVdzeZY2jWCfvcc46fh34EPmvzOM8Y0bBNUuSWHabNFhGsYSuyi?=
 =?iso-8859-1?Q?Z4PHej5rraOunYTxIg7cklZmEWbUmegNYE3KReZecb+mY4rXvdVcEnJbip?=
 =?iso-8859-1?Q?7PkbRC7huh3yo73duK460aH389fL6Psz2MzlOlX9NLM/rsqF1ArLSzP+E4?=
 =?iso-8859-1?Q?dSMKVFnkPG3MtrmWAzhZLaShuvRu9l8YaUlzoVYFxeCZE0jhoOoQfAjs3j?=
 =?iso-8859-1?Q?o+Te515+pvdMFFd/mZ/lCPFZqwZUDuLSMceg8CwgD2FU+Dw/OlCkdN9jxz?=
 =?iso-8859-1?Q?1J8Mx3i7IJpqGFAV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb530568-1b35-4e9e-96f5-08df3f41fe6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 15:47:58.3763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB7775

tcp_fastopen_active_should_disable() calculates the active-disable=0A=
interval as multiplier * tfo_bh_timeout * HZ. Since all operands are=0A=
32-bit, a large tcp_fastopen_blackhole_timeout_sec can wrap the delay=0A=
even on 64-bit kernels and re-enable active Fast Open too soon.=0A=
=0A=
For example, with HZ=3D1000, a timeout of 6912213 seconds and the maximum=
=0A=
multiplier of 64 should produce 442381632000 jiffies, but the current=0A=
calculation truncates it to 512 jiffies.=0A=
=0A=
This issue was found using a static analysis tool. A loopback reproducer=0A=
induced 12 Fast Open blackholes and waited 1.2 seconds before opening=0A=
another connection. The unpatched kernel retried active Fast Open, while=0A=
the patched kernel kept Fast Open disabled and used a regular TCP=0A=
handshake. The reproducer required neither kernel modifications nor=0A=
fault injection.=0A=
=0A=
Compute the interval in u64 and cap it at MAX_JIFFY_OFFSET before adding=0A=
it to the saved timestamp. This preserves the existing exponential=0A=
backoff for representable intervals and prevents large values from=0A=
wrapping into short timeouts.=0A=
=0A=
Fixes: cf1ef3f0719b ("net/tcp_fastopen: Disable active side TFO in certain =
scenarios")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
---=0A=
 net/ipv4/tcp_fastopen.c | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c=0A=
index 7f7eb3cc1c04..aeefd605414f 100644=0A=
--- a/net/ipv4/tcp_fastopen.c=0A=
+++ b/net/ipv4/tcp_fastopen.c=0A=
@@ -613,6 +613,7 @@ bool tcp_fastopen_active_should_disable(struct sock *sk=
)=0A=
 	unsigned long timeout;=0A=
 	int tfo_da_times;=0A=
 	int multiplier;=0A=
+	u64 delay;=0A=
 =0A=
 	if (!tfo_bh_timeout)=0A=
 		return false;=0A=
@@ -626,10 +627,11 @@ bool tcp_fastopen_active_should_disable(struct sock *=
sk)=0A=
 =0A=
 	/* Limit timeout to max: 2^6 * initial timeout */=0A=
 	multiplier =3D 1 << min(tfo_da_times - 1, 6);=0A=
+	delay =3D (u64)multiplier * tfo_bh_timeout * HZ;=0A=
 =0A=
 	/* Paired with the WRITE_ONCE() in tcp_fastopen_active_disable(). */=0A=
 	timeout =3D READ_ONCE(sock_net(sk)->ipv4.tfo_active_disable_stamp) +=0A=
-		  multiplier * tfo_bh_timeout * HZ;=0A=
+		  min(delay, MAX_JIFFY_OFFSET);=0A=
 	if (time_before(jiffies, timeout))=0A=
 		return true;=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
