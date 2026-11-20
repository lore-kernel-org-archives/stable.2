Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.85
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795178948;
	b=Y2qQ9Q0Lhw+DYbf5mlmXrBcO3MO8VIn6IAJVFmWacyoq4eMAOwYvMhik6dR0wAc2tsrH
	 3sq2CG1GyC7hh8M4fNccCIjDzQy0xghbIu/OrYgTCsn5B5h76LiSNdmQxMUupWziJEFDR
	 oP09hh/4iSnh9lGNo6YMrFFegggDxQVr46edz6SICRYzFqTEwDOe66X+AoisCgcki/A7N
	 CxRU/MBNLTT1gjsYpEhXd/V/pxYPVlv0HmEjsKSj1CrDJSA39qjNV5DbeO26+TyT9ZRWQ
	 1nYQL3bZ9kXbcTRFhdasUWYrnftIs4y9LUBWv1/APgVFWM2pSbwR0L9nfI5orvVAd5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178948;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
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
	bh=FBBYV+IvGLBq1XOdscqZtOwDlUSaV1CiQAP5RKeBDZQ=;
	b=hY8GynMkYOof9o+p9/PgYKF6swAmMrg00a2uuF0AUoevL78yTS6nlbsIDsWHbu8XrtpU
	 nxW8qJlmUC7KmjlLp86cyz4mRcdY35xkG+0LyE5n6/VRw4z16rjPa8d5Mrlo1S7Pi978h
	 2bc1QTBhBA3+FzJx5mnc8qqgFJuP5Bc5ultuH5KlOqW4YZ7yQ3BZcqijKqXhum2ncDqAT
	 PZD/+6C12djPnmal7llNtiVDEWgA6EWuCnU/4Gu7ao7FzcGWPa0NWVi0Y+wDEY7Ckwm6g
	 pTequ5EUZJlRdthebMwLFQ0ji5oSwGj9J38yKVG6jCv5NGtMH9rZ56U8dv1afnwYaKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=MP4Ulve7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.85
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013085.outbound.protection.outlook.com [52.103.33.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1F606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78D1F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=MP4Ulve7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izRojUiuXFX34ugQTazfxIxNAFv2Pt9oRDqXn3NNk3WnGty421Ta2KcTnv3BD3sohlPuTlBOnQGgGmBw1f5oBeW/xRxFVvn27C0Y5lMpXz59SGmA2Wj45fBJMYvO7MyE+q3UKgae8S7cDzdoal4BTaSvDqv+V0tPVF/sxS6gu1+nkTX6WY8fpnEVo2Cx9gAY7AK2gl+OWLw5AqAucmZkEYmLmm/xoLh9AN5EXf6uB19krAL8uiqOYKCsf/Iw1nkYjYptDlrUF0g5vDy+OtdMJ/40P05cW8mfdaIdn+9Xr51UQtWflXaJQEmKHhw/NbmPWiw4OOhcGrje+RKSOSJkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBBYV+IvGLBq1XOdscqZtOwDlUSaV1CiQAP5RKeBDZQ=;
 b=n3E84JNjZwjoESIGgBIrPVdpx8d7R62Ima83PcII99WdccLVzHNty3mdp0VOSHVdGDDQU9WASsuRoIDhnBVvh2NEA94HzFtxkNP5W5JMxHRPdri23v8lzhKzQmTWnMsU9YQOeIJq44myCVQRnLz27PErsXrN7MJVH+zw8XwzZ9Vpc6nqZ7aSWcvGdb+rtRT4qND6iP1WaLHV6/SC++ae/d69Z4+SEiMchH4vSo71oRv5hQusL/UWrq5xhG4Bf6pX3wsZjcrXTuhJ8Pq4+Mf/n8emd7OTjiKCMpWBk5yIUv+vRpC8HgUCSY16rg2R8L+YcNnNHKaMATefghK0gXYQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBBYV+IvGLBq1XOdscqZtOwDlUSaV1CiQAP5RKeBDZQ=;
 b=MP4Ulve771jLim278y+FYHfJS0PMQXariSXZngUR3nF2EXWq9KgMrh0X7YBNJcNfS4aw8+XchXNC+AFxAnb0SquIBDTMgH+5wr8QCi9whzD6Ip0PkpdV2nEVDB8ya07T+GxgmM0KjPd8V2Lk9dJyHA5IoWhKHHEAS/Y3wkN0H6o7Onz2j1Ptsa5H/9vfoDlpUkqFr6sXJ6GbK8sRppsNvcSNMch0zIGiDo8bACtS5GR3DMaPr8S5jzCMagq/l+Q4aLKgev9uWiaYPBhe5ib5BTSHxb9mafaXHeSDndp2EQ2XA1DLUrs8PxB5El5l5P63stxVQobjvY+HRYUOEK7nFg==
Received: from VE1P190MB0877.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1ac::12)
 by FRZP190MB2215.EURP190.PROD.OUTLOOK.COM (2603:10a6:d10:139::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 12:49:04 +0000
Received: from VE1P190MB0877.EURP190.PROD.OUTLOOK.COM
 ([fe80::b9ea:ba75:b983:11fa]) by VE1P190MB0877.EURP190.PROD.OUTLOOK.COM
 ([fe80::b9ea:ba75:b983:11fa%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 12:49:04 +0000
From: "d3nchk@outlook.com" <d3nchk@outlook.com>
To: "ntfs@lists.linux.dev" <ntfs@lists.linux.dev>
CC: "linkinjeon@kernel.org" <linkinjeon@kernel.org>, "hyc.lee@gmail.com"
	<hyc.lee@gmail.com>, "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [REGRESSION][NTFS] Linux 7.3.4 mounts 64K-cluster NTFS read-only
 after $MFTMirr record 24 mismatch
Thread-Topic: [REGRESSION][NTFS] Linux 7.3.4 mounts 64K-cluster NTFS read-only
 after $MFTMirr record 24 mismatch
Thread-Index: AQHdeO2GTFIG3wiCfUeuSBEr21/wVQ==
Date: Fri, 20 Nov 2026 12:49:04 +0000
Message-ID:
 <VE1P190MB0877D026E2C3905F0324B46F85782@VE1P190MB0877.EURP190.PROD.OUTLOOK.COM>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1P190MB0877:EE_|FRZP190MB2215:EE_
x-ms-office365-filtering-correlation-id: 9c3b08e0-e61b-4633-a5a5-08df4704a897
x-ms-exchange-slblob-mailprops:
 ZLYX9kf+sFZxKjlXyB2wc/pvxSEMppw8L/3RxB8jtVUk3m6IGL7YaLXMAg4Ia2R+7mqLCCUoUB88EpRrgWwxpy/4wdX1vF0Q/3LAc4FtDAMOZbcxmQxpMuI+FsKAZgnLENrftTzwCnyVP2yPUtf73KQuy5sYL3PazcMy8RwPh6zHgFhJtZAOFDtheBKKkkNNpikctqoOcwV/Vw2VIVQZqB3S+xJrWecKhDiVJEH+qzZBIz2wTqKZ7Cnj1PVNJBvI9RwLGx8E73CUDkfX4mg9ODW6VaXheGmmI4hEFVRd4iQnQRhX2pXCX4ZxDhuInLFxQro76wOa2Mmi5OcyK+pDpShluUkRaR+DUutR1tM8oPVMppYoKol02qiUFWvQ9RkqF28li7lsTttQdDFq5b6wXKOWhHs+moaynJYZ5N9fpC7DNhvO69BqC5TQ0PQ1Smz7YE3jvqBO6o5Rx1lQF7WNx5gfLIl9+gxpqitjP+z1CGmML/hvIVy7bISQ9unyYkZybNMY2PJMUTcPfGnMW46DOdEZ4gtIUqREN2xOOEkIZ0J/gYkBJP9mnygWOEqL8vGcMQ023vUicHohvlUKra3Qd4w0dmQoinYljxt9tmjimBxnIwYRPnCQADUv1TZUy5QaO7uLYX08zJ6kD5zFEz31WBnF/TGGo9JzYrN68axxFseX79aYTptOv/1A80OY2DtvlavT/tjqvm0PT0ggkAi74tAwmXENVobD2MCkHcTTQU1tlL5ywocHFiiw5cltP720VLHkkyh6fPj6C56vuYoisKIX2dDGrUSNQrrwoLjLqHg9hplJ9dnMTg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|31061999003|4040399003|13031999006|8062599012|8060799015|19110799012|22091999003|24121999003|15080799012|38102599003|24021099003|51005399006|40105399003|26121999007|3430499035|102099032|26104999009|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xanryZtYrCihrx40ILWd8mKxBDEFWBRuOy1uHZaBqPaCxoyFs4WzAE8rXxeJ?=
 =?us-ascii?Q?VJ7EDOtADyTWD9vGfLdp24W5qzPVUlDTq/rbj/NGirqi8GObqaFgFugGjyGF?=
 =?us-ascii?Q?cyEOWxEgf7wm5e35FWvaXiWDCstvp4OGgwb6sfohOGaE5DgpH4HC4f995duX?=
 =?us-ascii?Q?RKYOLxm7Md4UB9t6kzWnMYf6pTqhi2iNjTI1cNE8qfciw1Kl6029b2Z5Pl2u?=
 =?us-ascii?Q?l+qKmjfxTgDH6huo+cIDkfUJ0fzOUCTy44AYAFV9DcMXCuf2qws816e6d5or?=
 =?us-ascii?Q?moi7jASdvD1GZzvUudtCsIpil/DLO1+luToJA6fclar2n+r8GoeRKguygtEz?=
 =?us-ascii?Q?5EZo58joA7MgEQ3rJ+g6mSWMUWEhMPbPjcCenTiMpl2VGYuwQlUMWl6oIyr4?=
 =?us-ascii?Q?xWxBD0nycaBKQXoDcmzYgwNjELV03I6LFMwigOW3Qns8XVBR9L9VqrerD0zc?=
 =?us-ascii?Q?TcixCOaXr7y+D08Bix9hW4UHVrHJXIHhzKFMqHjfyQyjJp2XaS//t1J4honv?=
 =?us-ascii?Q?n6cUPKNVgbHUV81IzKcGRo6qB/JGRxlgVcNZFIri3h3oiLnGsjg3O3h81Ger?=
 =?us-ascii?Q?NHL3dWu5iFhmv4PkAVx0QEFEkEDod0Gf24+0bYQTFk5fIPuyaaOXowD5XLwM?=
 =?us-ascii?Q?Nk59BMahzo+SUg01EcE3YQlxhwXLgA46lNDvkgUKmrnfmg5cT47bryZJ0Nir?=
 =?us-ascii?Q?UaWZyR/1dLzwxptrLYLiDbi4nI4Wd7hpgSPgd3EaljHZldNwfbrZwzi+7nV6?=
 =?us-ascii?Q?zTXmwOdz00KAQRSQEjOkInHBXWgmeLDpui/owxxAUFOw5UYINN8ii2rIa5C9?=
 =?us-ascii?Q?1RgYhDe7hUfkKGbfy0vrLThr3sEEAvP5KfWqrNsC+LxiUBOQxvn+vObtEtYi?=
 =?us-ascii?Q?HioBsFpwTupkezUthVC0LhBs7yh07aAgplrGNjp2kdBlISaDvEPpB/ke48pQ?=
 =?us-ascii?Q?OLkVclcsRcKq9M4Xmyxa24ibi/VGhMxdqFedf1Y6EhztHno/XrUPE+eCWQLt?=
 =?us-ascii?Q?iLQZQBq/lScUxrAjzd+/ujd8bp6fzFQZHac8ylDAfnbxwHvTOaPBcVLEQvMc?=
 =?us-ascii?Q?+r5mGp9n4OYqxtIDgfEGIBHmnWSINDK3jrVpmlNo4eKCb7+eU9DOeVyp57z+?=
 =?us-ascii?Q?K3tDVpAtKyrG?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c8gxEkRUgmERwxK3clMV0k3DFDfQO/RbmPCtpJvWvVLlBGb7+kDwzOIeFPI+?=
 =?us-ascii?Q?VuipzxzXXr+2opfNBe4v1SWtfq5RwbNqdbAm0FyJtkUySwLa8kBsV5QSo/Xu?=
 =?us-ascii?Q?/TQTIhiuY9mKauxNd2A0nAkOdOuq2fJ/qusUL+9pkQ39efH9fWtN100Bs5DW?=
 =?us-ascii?Q?3GtZwHALFDMdmQB+kwudibswSxaIjaH0+vf+0Lt6EJ10hTRRrMGkZ3LtOvlW?=
 =?us-ascii?Q?ubG/RAwJxD9WizjeqENFVujMtDzZxxGqT24aUFu8s7Y+FnobmPc6BQYT+2p7?=
 =?us-ascii?Q?6DZNlf7AcrUu5ThnJoZi80+NT0r6BsvhK0GlRw4eTtr9gD62vOAcf4jn8Hqu?=
 =?us-ascii?Q?BB5+rGXlQClMd1TD0Q+BQ0S2gDGQ+mlNRZekzlVJQLdH15wbYHi3MIWQhD94?=
 =?us-ascii?Q?yyJSPvbTN27MtdPQBnvcFxaYudomkUoc3qCf+Y9dzjS6BAN8qGTwenwauLpt?=
 =?us-ascii?Q?NPKU1+vOmM+Xn1CisfXOiWz0W7Bi2OiUarJa1OaH9SVXOErEe78pYmLsjXCc?=
 =?us-ascii?Q?V6QnQYQH3vGPqY2XMJ+7tm+YHdorX200lursElhNY0QMEA5pfmO1Febwwk4v?=
 =?us-ascii?Q?3Pf3Cw+i0OxgztRPcojKWvMAKWVRIcA3nJINsBktGvdl95MGctbh8nTDvXtP?=
 =?us-ascii?Q?U81rLfDHIiLl4zRWxY9M0HhB+K2tBqQT/h4vt0satkH69KmNW2BfzNlvET4E?=
 =?us-ascii?Q?uDMFj4yGGLQaJcuDV2KdZNmEgismZmldkz3BNH7b2eEygyg4pLRJdWSMdHA7?=
 =?us-ascii?Q?hKH2okQRJedTUP5YoN6RV716VC8CpcwODjsV42ehHZxQ0/kSRjd5ptxhV0yp?=
 =?us-ascii?Q?tB2zjOZyMIZBb4H9NF+MW34b6t5+l0ueVSQ8MmWLgW0dfwzxlfDBr7pfiART?=
 =?us-ascii?Q?rQfGSQo82QKYb3PPiG92rabmT3XPT0OkBw2vAGOnUsPrZEU1Su0ImacfcAtD?=
 =?us-ascii?Q?NrAA8C86aVZeRfdvv3z0b3IBFK+jf02wx2/7uKsfgeEfJlQNfslFiA7OCIUh?=
 =?us-ascii?Q?zhM5FpJsKtOlLa8eeanYuBxtIzY5nyWiUlFUTdek7K/TfoGYY3QIDUw5Jxmx?=
 =?us-ascii?Q?9mQuttBXZ/1n4TLsu1ycWzC5uaszrs+mFq0k+A7xoY8lYakIHxhQyYYNq+tJ?=
 =?us-ascii?Q?pT8qS67t5FNBhLy9sV2Tg62J4uWTT4u0B34Ed/kyF3XeB3X9onhRZ0CXT8zc?=
 =?us-ascii?Q?mOEK6CanVaR/o8d1yONHetn+LgmlnCnhAJNANTOrODXNmRBQWytvWDUOA3lj?=
 =?us-ascii?Q?S22AwCJMOZhbeArKU48rm21Q5TMIHVkSlqvxDqoFMjhaTyfqTOrK4xfHJ5Sh?=
 =?us-ascii?Q?Y7/AWet0afnw1O8QjTE39JXutn9gXdNp28gjA2mHgrj9XU+A0BtHjzExyDeD?=
 =?us-ascii?Q?T/N2Z90=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-AuthSource: VE1P190MB0877.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3b08e0-e61b-4633-a5a5-08df4704a897
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 12:49:04.3703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZP190MB2215

Hello,=0A=
=0A=
Resending in plain text because the previous HTML-formatted message was rej=
ected by the regressions mailing list. Apologies if this creates duplicates=
 for other recipients.=0A=
=0A=
I am reporting a regression in the in-kernel fs/ntfs driver (NOT ntfs3).=0A=
=0A=
Environment:=0A=
- Distribution: Debian 13, backports kernel=0A=
- Working kernel: 7.2.12=0A=
- Broken kernel: 7.3.4+deb13-amd64=0A=
- Device: /dev/nvme0n1p1=0A=
- Filesystem: NTFS 3.1=0A=
- Cluster size: 65536 bytes=0A=
- Mount options: defaults (including errors=3Dcontinue)=0A=
- Driver: fs/ntfs/ntfs.ko.xz=0A=
=0A=
Kernel log:=0A=
=0A=
ntfs: (device nvme0n1p1): check_mft_mirror(): $MFT and $MFTMirr record 24 d=
o not match. Run chkdsk.=0A=
ntfs: volume version 3.1, dev nvme0n1p1, cluster size 65536=0A=
ntfs: (device nvme0n1p1): load_system_files(): Errors were recorded during =
mount. Mounting read-only. Run chkdsk.=0A=
=0A=
This volume worked read-write with kernel 7.2.12. After upgrading to 7.3.4,=
 it is forcibly mounted read-only, making normal file operations impossible=
.=0A=
=0A=
Windows chkdsk has been run repeatedly, both through the GUI and command li=
ne, including dismounted-volume checks. The issue persists after rebooting =
into Linux.=0A=
=0A=
I suspect commit 749357bd48c16c4cdc09093450deca609492f012 introduced the ne=
w read-only behavior for this case.=0A=
=0A=
There is also a potentially relevant NTFS compatibility issue: modern Windo=
ws may not keep all $MFTMirr records synchronized on volumes with large clu=
sters. Here the mismatch is reported at record 24, beyond the first 16 reco=
rds.=0A=
=0A=
Please investigate:=0A=
=0A=
1. Whether the comparison of MFT mirror record 24 is valid for modern Windo=
ws-created NTFS volumes with 64K clusters.=0A=
2. Whether this is a false-positive filesystem corruption report.=0A=
3. Whether errors=3Dcontinue can be honored for noncritical MFT mirror mism=
atches, while retaining mandatory read-only protection for Windows hibernat=
ion and genuinely unsafe filesystem states.=0A=
4. Whether a fix can be backported to the Linux 7.3 stable series.=0A=
=0A=
This regression prevents normal read-write access to this volume.=0A=
=0A=
Thank you.=
