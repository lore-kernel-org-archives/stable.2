Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.32.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795597013;
	b=dm33mEHfmBTolNo6ubwFLXM7vgsyOh4Q3Rh3YLHxTU8jZpxjIwnTLkDCqDmDvSPqtz5C
	 KSdTwvGySdiEonW4IHzZaifFuiPgaOLoS7fb1BLMWWn3bE3CZFIxO3z7kZi/JaW2MEaHP
	 axxRI4dZKU32jCXCSfOLfAMOYfSyM6K4Z9S7PEzQ72Lh0N7n+1Wy6UDokR+oI6xh55qyu
	 nIF8zNLI7QSm1+/5S6QAZ13WA2A7u5oism7hbtnmetRC1Ui6WcGWTOK9ivJMcvH9aLl3G
	 d6+KmIzklwj//yLWHbY7eLKJNbDLWC4+URR6yau4Aq/xyItDTD3njReDbY/0XLqwZuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597013;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
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
	bh=KTFVhR9M258J1lCWxdpGZRxa403w0iSjZHXTjqCNp6I=;
	b=VmoGzPflrmnkDAOFEsCIQrbRGiB35nnsBoz7XMb8u/4SIPkdw2828wPmA3uLDrpFZtMD
	 l8Ed1nVrpRwS3eMcneZ25wStQ/WglmhvAE0VZPGRVw1kbiULyB9r7AFENhBkSkKOT7EBx
	 6ltEhBmbAH11TNVmWcnU5P2dAY9EUDqhO/HuFBv8aH+1PeDd3mR9VQcWYGbznDd9l626+
	 2UL2in/L30vuEF8Z6//iL65xR6Tz2ikcGC0jnuct3wov8reoDjF7SgGIXua3nubrb1Yz6
	 Nk+GEumy9Ld1qiT/9nXZbnz+gTQERAlqOhdHneRNO6tIUQ/pN5qtPrZbWGvyhaaG85g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=W5gjXK0I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.32.27
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011027.outbound.protection.outlook.com [52.103.32.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF3606A31E;
	Wed, 25 Nov 2026 08:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DFF3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=W5gjXK0I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeHR2n/x3I0i3tRnON3Jk3F1MxYHqiZWtTsQbB7obiPxV9jeZ1ToN3JJ3q+YLDLnmIfA1WGoPULi0hlL6p+zfGJmUpdpixS3OOvdPGb5I515tDJWuYZDubY39aGAD6vvyxzHOLtQQbmV2Y9LO+wNqQRsPNmuLx2EwJ2LzFXGlcNqP9HAn/cmM5c/oxjuRtM0vLxS/ecpoR3YvNyuRNWTzeK9OYHZPn8NQ/80EQFuD2sYCa2FPY6NnnlfYCmXTb3LvJvHK/IJwb07mN3ZhxdJ9fzrlWnA3Ie1wAYHJbgfxy4F5mqziaRx6W+Dz/UvHyjVAcEy8Nt6igmSJBwV9u8vaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTFVhR9M258J1lCWxdpGZRxa403w0iSjZHXTjqCNp6I=;
 b=KjiiXCuRt/YqskYIaoKvhVh4bYaUSAHkpCfZn7NF5NlH1NSObVALXTFDSwp2qELn1cnERSV5jF5dQ5dmbb4tI55kIRPja/qOEnGyryiw/or8luwZRQnnyVus04i3PIJ986tRdQP+hFdLiKmQqPeVugG671pShRCIw1VhoRY+eqwAyJy8mi7S9X3x+hs8+24eONiBOE5cN45OE6MoKeW/hWFSk+zJx/omDbwzyy0pCTFs8DxDoUqomdRCubGMKYRsKy1sEOBx5V6q9W96QYJ25xAh6W7a8TdHfQc0Hpx1GaIGsLHIO+zJyxvLk0Hsybp+jFPTKtChyrgMHG+31sn5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTFVhR9M258J1lCWxdpGZRxa403w0iSjZHXTjqCNp6I=;
 b=W5gjXK0IuJhNcy4UgzIuYXOe+w3I2pUsBrpiIbztAdvSDCst5BElst/IFA/UPbDdu+xuJxNxaDEdzVed8aDr7sWeWGy7g6RV7yJQgwuvWBSkCsfw6kWvCeh7pV9gvGYNLY3dvTV+uG06IGEgXKCzEAfsd77U0QqaEoLoq+WctvifjugRSG8OAM5L/CrHCHAkG0SOVxJF0x6zn0DzdJhfolwkib1suSMfbd3nhpBH/ZQeD2g1/PL+/APUKQfeaLmKPtTjt3sy7cYZY+WuY2vzoOR3TFGbZE1g1OkBx17QC38XCa9Xj1WYIrgqhJ+R5jdcIPXBxtZ75RNKA3YPpmBchQ==
Received: from BESPR02MB12296.eurprd02.prod.outlook.com (2603:10a6:b10:fe::6)
 by AMBPR02MB11930.eurprd02.prod.outlook.com (2603:10a6:20b:765::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 08:56:50 +0000
Received: from BESPR02MB12296.eurprd02.prod.outlook.com
 ([fe80::8c6b:a501:2866:86db]) by BESPR02MB12296.eurprd02.prod.outlook.com
 ([fe80::8c6b:a501:2866:86db%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 08:56:50 +0000
From: Guillaume Laporte <glapt.pro@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, "leon.hwang@linux.dev"
	<leon.hwang@linux.dev>
CC: "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>, Alexei Starovoitov
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux@roblab.la"
	<linux@roblab.la>
Subject: Please backport 7a0855e73757 ("bpf: Disallow interpreter fallback for
 BPF_ADDR_PERCPU insn") to 6.18.y and 6.12.y
Thread-Topic: Please backport 7a0855e73757 ("bpf: Disallow interpreter
 fallback for BPF_ADDR_PERCPU insn") to 6.18.y and 6.12.y
Thread-Index: AQHdfLlkY+dlQLPL4EakJKtjnocH4Q==
Date: Wed, 25 Nov 2026 08:56:50 +0000
Message-ID:
 <BESPR02MB12296D62B1B3F33BA21C4F24AF1432@BESPR02MB12296.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BESPR02MB12296:EE_|AMBPR02MB11930:EE_
x-ms-office365-filtering-correlation-id: 32cefc6b-6c1b-4d58-4090-08df4ad20b70
x-microsoft-antispam:
 BCL:0;ARA:14566002|5062599005|24121999003|19110799012|22091999003|15030799006|15080799012|41001999006|4140399003|4040399003|31061999003|8060799015|8062599012|19101099003|440099028|3412199025|4302099013|102099032|1602099012|10035399007|11120399003|3430499035|261005200801699003|40105399003|52005399003|26121999007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+LbzZzjDunUn+W6rZ5NSjCxNChBOFSVYHlyIYNOnCXgjUAQ3dog9t+r4/C?=
 =?iso-8859-1?Q?x5VPRyf6xc/FiryJ2R20CZi/ptG2CVWdv4zJ4ajVH1Xa1ZEF3UXsv2yPUG?=
 =?iso-8859-1?Q?fq33VAO1JGZOUGDsvmuGd8E3AdLgW++zJ3jb63rekptgUup3aP/FF734Kq?=
 =?iso-8859-1?Q?aoOgLThDwdkPYy3NEej8EH0F8MJjNJjDqXtNFQXAGiWhay2iveaBixpDmC?=
 =?iso-8859-1?Q?sRRZaWZCQXdK8TcJlg9RXSF+RBFCxv6mbipVFQR+TwsndfsfB5PIuJdj4/?=
 =?iso-8859-1?Q?gOY2E3yfHRoHXCVPz51CaIjJmxUCozZi3wkwjmRk6uLzORPu4HSVQQEE+m?=
 =?iso-8859-1?Q?hGQhJ/9mW2xHc97sPTfTT9IpVq+Ly82BRtu/wx3Xbz/uv0FO72Jd+Zqwvk?=
 =?iso-8859-1?Q?AX7cjyKcG0PEXlWL/R4GOydruG6IwMnR9isOLUCwVQzg27pVZoThPTYpaH?=
 =?iso-8859-1?Q?cpsUUJyy6HhwZQq/w8QGexjb6v4N5Mr0DrNFhPK/Gja0fs86RYTz4VE4+G?=
 =?iso-8859-1?Q?Eao1vu4LeV/ZkegwLPYiyVXHqf5kumM7GU3Dxi2UNRyYm6ZjAGe0+pXr8R?=
 =?iso-8859-1?Q?AfzNDLE7uUxDpBwIgcp+WdORF5nMITk6uICr4mjCCaRWavY0dLvw6TgZmN?=
 =?iso-8859-1?Q?BIXUYMsg9q3dT5NlH8lfjg4rfIanQL8So9L4Oip/Rb5JTg77JBEFS/IOhO?=
 =?iso-8859-1?Q?jYkAnbie3iQ6JcYsgWEmohwAF7Spjyb/BDbpCsQBjX9h1UNq3FYuz3jzS9?=
 =?iso-8859-1?Q?qn7MJER0IoGlrBFw+D+ILrpWj8k0UG8t8UWZYII10S8zXDjeGClKKI3tWe?=
 =?iso-8859-1?Q?37DRyu+eO8Ygp2kuikLugaanerZRrBdIA7VMWXUORYRqwyBbnWa4X0WbY8?=
 =?iso-8859-1?Q?k0lyUa8H3+DMwM4bZeZZ3sd9lebN6xxKtPAqDSg4YVypj6u/sF8boLREAp?=
 =?iso-8859-1?Q?0iUCEuuy5C+2a3kz+8NGiZCb6NveHXCmw70+V8qagozYvlQvjOspgshP+j?=
 =?iso-8859-1?Q?zBWRG2wt5lTjhBNZ5IxTzvHAp/GUGclzmxIFF0Nwf0SQ1whCV1wLGpKFAN?=
 =?iso-8859-1?Q?ASvkF/KQiL6GGD/8G/KWUBdhFhXewltjc0NID2LMyh0eXZD/tbCjlxqdM+?=
 =?iso-8859-1?Q?cl1WR8ttUQhndz9ZiBgfUT8EfGufSNgvEX8RAgEQCTEvQnurplGY3fQ+r1?=
 =?iso-8859-1?Q?/Zb7ZREJZnU6tKk9LV8VMO5xFPT/3XTD/LvdxhkVIHZTWe9QJnn0ytwrft?=
 =?iso-8859-1?Q?7/NIt/ZzOPbAKJJ6D+qg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?v8jHYEMn7N4Z8TyB91TNwwq/vxeZowjmCnLA7vnTtUAuNLKl17GzT0uwAl?=
 =?iso-8859-1?Q?UcgscnYj6aVGQGRWhEvHXFMZmWAddikIrUiZm0Y29DmgtfAcOXIV3a302S?=
 =?iso-8859-1?Q?U0xgJV1tWRSnLzV05g6hQ+IXFyJ38wEKMqEoUM5UK8rwawEFppoFpcx6J5?=
 =?iso-8859-1?Q?hqbfD7Q6qztDlPDi1zHf2rXxA8cHHl4PGCoIvWpBKIkzIsLaarmlzM66T9?=
 =?iso-8859-1?Q?qLt1KyYPbbc2rEQfFSvKcJaoigKkdhwPf7D21JxUlWyL6hsQXBU+Ic65jR?=
 =?iso-8859-1?Q?Ob/emsRETvq8Kwb8KpP/mGWdacmuorw2Cr+pSE37awH3792FhK7JypFlC/?=
 =?iso-8859-1?Q?PLlqSO1l9HKSJI+oQhUFLKjT+3rN1iS5FAzQi0cnHZLnr+tiSnC+4233OU?=
 =?iso-8859-1?Q?n8S7uFlManfsQRNLTSBkFqKWxNowkEAS7fqIFS/ephAnj6C1s4txJpSCtd?=
 =?iso-8859-1?Q?LLOb9RutzF7CA2v1c9gTmSie1OPjmjPEelx7n8jrVMZ2QLsKlywNeyMFRu?=
 =?iso-8859-1?Q?UhTklrkirHQaH04akr1azNcB+cSd877Gbz479nnFauWAdqFSukq93Dw64T?=
 =?iso-8859-1?Q?nlF7XMBf4XX6mcbEv3evRdBQ7gfGqx8lsZSJ3K044cBrqoEdnI1FuuVl5G?=
 =?iso-8859-1?Q?BYfuTbuEgvG4f1vdf3YJ06Z6RKOHPn3PyuWg2ZlxA9VTvVdn//XEwHoXqd?=
 =?iso-8859-1?Q?OyXasJxcH9u61jYXIAYwZPZ9fnAF+PNlTHFksvXTsvdbmgWXwEn5Z/iKvd?=
 =?iso-8859-1?Q?avSAu080D4+TQrOQ1fRx8viP+1WV5FqIErHyExW9/fn1UktSbgM5hPZozE?=
 =?iso-8859-1?Q?6uVGca1C6Ef/4XhzpuRa72cidEqJv+duT+b+Cxy475F55U//3AaqaB7tOB?=
 =?iso-8859-1?Q?bAGQvgQd7wAgM7AfSFaO2zWcxaWR93SEDUfTa4+aaMRYKi0oVDH/1ZyIWz?=
 =?iso-8859-1?Q?vvvPCZAGO6W3v6b7vNfuuGG3aDjKlYoHcx6crI8VWBO02kpxl2glztr6sI?=
 =?iso-8859-1?Q?wOUiXhiA2wivf56KWH6b4oX3mZPR0otOl/WxEBOOOVcQYINDmOmN5m1i1u?=
 =?iso-8859-1?Q?B7HshPDXv9/7vEGGAvotQdIMoxiwmKthGkaRH8J1LOcMSlPkHagbAqKmiB?=
 =?iso-8859-1?Q?hLYY/Td2tYpBwbjNj80D3PJu4h4h+K/oAFpIvKmFVYzpRx4lrR5/c4n8hc?=
 =?iso-8859-1?Q?bMJoXKmS3CjFJRNGBpCVXTZnOgmniLHXstbLoSNfvCtmaC4lRJpDnytwxN?=
 =?iso-8859-1?Q?DD6hQgWuemSZ/WPIpmB8//PzGJb4dqgeFKrjMb6p/WCTgaaMC+9NiNTcmY?=
 =?iso-8859-1?Q?Q3rei9De+QZHYi9SKo045Ulzz69HtX80pJeZJ6hV7CNsVp/fDAPwJBLkor?=
 =?iso-8859-1?Q?xndMDqcCGxvRzwRGFGPrVTN+jViZAaUFGkMtcNLPW5qCbLz+dR7Ek=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BESPR02MB12296.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cefc6b-6c1b-4d58-4090-08df4ad20b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 08:56:50.5308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB11930

Dear maintainers,=0A=
=0A=
Could you please consider backporting the following commits to 6.18.y=0A=
and 6.12.y:=0A=
=0A=
  9a6df65d5c6a ("bpf: Introduce jit_required flag and remove bpf_prog_has_k=
func_call()")=0A=
  f1c27922576e ("bpf: Reject programs with inlined helpers if JIT is not av=
ailable")=0A=
  7a0855e73757 ("bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU ins=
n")=0A=
=0A=
All three were backported to 7.2.6, but not to the 6.18.y and 6.12.y=0A=
trees, which seem to be the only affected longterm trees: if I'm not=0A=
mistaken, the issue was introduced in 6.10 by 7bdbf7446305 ("bpf: add=0A=
special internal-only MOV instruction to resolve per-CPU addrs").=0A=
=0A=
Without these commits, on kernels built without=0A=
CONFIG_BPF_JIT_ALWAYS_ON, a program that looks up a per-CPU map can=0A=
crash the kernel when its JIT compilation fails, for instance because=0A=
of constant blinding with net.core.bpf_jit_harden=3D2.=0A=
=0A=
As far as I understand, the verifier inlines these lookups with the=0A=
internal BPF_ADDR_PERCPU instruction, which only the JIT implements.=0A=
When the JIT compilation fails, the program falls back to the=0A=
interpreter, which does not handle this instruction: the register=0A=
keeps a per-CPU offset instead of an address, and the kernel oopses=0A=
in ___bpf_prog_run() when dereferencing it. Depending on the context=0A=
the program runs in, this results in an oops or a panic.=0A=
=0A=
This was reported on the bpf list with a reproducer [1]. We have hit=0A=
this crash on Debian 13 systems, and the reproducer's program still=0A=
crashes 6.12.119 and 6.18.65 built with Debian's config.=0A=
=0A=
The three commits prevent this issue and some closely related ones:=0A=
- 9a6df65d5c6a adds a jit_required flag, making it possible to=0A=
  reject a program at load time when its JIT compilation fails;=0A=
- 7a0855e73757 sets it when the verifier emits BPF_ADDR_PERCPU, which=0A=
  fixes the crash described above;=0A=
- f1c27922576e sets it for programs calling helpers that some JITs=0A=
  inline, which the interpreter cannot run either.=0A=
=0A=
Unfortunately, the commits do not apply cleanly to these trees, as=0A=
they modify kernel/bpf/fixups.c, which only exists since 7.1. Leon,=0A=
thank you for fixing this upstream. In July you mentioned that the fix=0A=
should be backported to 6.12 along with Tiezhu's jit_required series=0A=
[2]. Would you have time to prepare the backports for 6.18.y and=0A=
6.12.y? We would be glad to test them with the reproducer and report=0A=
back.=0A=
=0A=
Thank you for your help,=0A=
=0A=
Guillaume Laporte=0A=
=0A=
[1] https://lore.kernel.org/bpf/MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P=
264MB3314.FRAP264.PROD.OUTLOOK.COM/=0A=
[2] https://lore.kernel.org/bpf/b76ade17-44cb-4e60-97fc-41ba55258691@linux.=
dev/=
