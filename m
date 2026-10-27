Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119983;
	b=nQK7YLTgiBqpyYFF8WSvkqSHpHYxyEdSd1Wj7WAEyEu2aD+1VrZB01qKlpY1hTm/3uid
	 ti4S5HzosbdKnxE9wM35PIZVje7YGq1ef4IIutTDETYZp94x0mIAyJZJpbKoNc9fuJ+MS
	 hPWBa4yC52rQ0lBnnw3Jj/egBL+T+3hwDHVDqNyyAwwzxY0+n8CjgIcbE734LnGpwo+OI
	 ESrDL+mWogUjOZ9VwbbUbzcnP7lL6lU2JsCt1XkQASueAidCQSp3uiMtfH40SUamc+uBn
	 VgJupkTrg7wlfI1/tHc+gIDbfdsmiN2h5UqUB21zWerA9rXo4hwV3Uqx5GKMcu80zPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119983;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=7KblPiVWZqgcZxi5eEvlh8KeQ/C30uTkiG2z0Zz/we0=;
	b=LuLO+1j20V+wujaGR+KlWYWjPJM5FAVg0beSPQaydIWNAHeo3bjroo+faZb3uVwnc+6k
	 j2IZlFsKNTP+YzHAw3RoEfCjn1AO7VGjVMS8PHc1y0mmbR4YFnkKwYSiU1iZsFQ3KLdmI
	 TK/ZXkMmpWfTNSedgnLu0bFyrK9PL6cfRUMwzJaL0LA+pntSgTM381DJApmxO3tl2a8cv
	 pKJnm7CBboaAxJ0Yc6czzinuHFdYlVamSwjFB+FsV/XF0fAvfoShWJ4pnCAg3sb0f5/Ju
	 sLmhkCTLATRDKB6mW3Z2gekTNIZDLnXiMeydpPRAfZRvzU1ebjHfQENJlC0wdTaLGyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="oz/mYmdK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.49
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012049.outbound.protection.outlook.com [52.103.20.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2A606A31A;
	Tue, 27 Oct 2026 16:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E2A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=oz/mYmdK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wy8QOz6mT3MArEsYzJpwrNkXVbueo9lFVQw/R6JHBH5DHorxRUBPmViYwAKjb+LNeGMtxYiJ4+g9jOW0ZJcAGqfdcwIHa4d4WjzQZVIU/yvYGoCoyQwA14bJQqYH2MdTBHqmsWQAbXqQoX3GeEiiatUeeJBbSeYaN6G147pTpxyDHq3/CKj8HoFKqvXdUV2lLJAJVdgvQW52xfVQPXvAag9gYrJ8r9bHKEAjpo3ppxmiEBxSkbw/JxRLGNx2ozQvrqU/1X3dxyNgBD7mmDizgG2X2snZPFfWiuSwO6Jfz84H1bb0GIogImIJ2TC01bShobogY8uA+F2k4s2y96fFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KblPiVWZqgcZxi5eEvlh8KeQ/C30uTkiG2z0Zz/we0=;
 b=RpRGa5HXBzRKluDVcs3tgqoR2E7PHCVqnj2+LM+o2fsUYhZQeWNvi1eIAWyYT4BKQvmUa9cCwNIY7gx1AYdV6Bz0jbVavQU3dCeSaC21qVLL4OqFlqisr11Ql0YE4n6rwdH2H33ZkUxEGxnLt5hc3UULyNImUXlzBPnWq+3tG+rDX5lAaugQlykBW4+jynjYE/L3BoBjGt6yxUUbF39M162WFz/IM0G4SV+PmI8pW2bS5GgTi7cWBmsTis8aXdOaOdREXUlmWtzlWhaOA/tVd6VVzVTNhA82D3doPA8lr2PNEd+cwOIYDU0HzjRrhvJmc+PdPDXQWK8cicyWdMTnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KblPiVWZqgcZxi5eEvlh8KeQ/C30uTkiG2z0Zz/we0=;
 b=oz/mYmdK3K41o9js50hYjeMQvkfd6c2jL/OJ3frAmpv1jRzU9whFJV84B2o8VCl7d5eMpzbEiXKrDrGCHa/rEDFs1iqe2PccxvpLfcqzQtLwPX9fARlhqb5UaWNA9ABZ7cyrTzF1HzLkleyELYk37KI+p7bmQ8Fx3Vpisa4gpcxhjz0fk92JgoLeVkYWhOD5fwSKnJw6NsQRXEW7XMKUbSqn3JSCQItUVb1qQ2KU3cH1mQY8WAMA1vzNdLvbort/KV0RIab5q1SZzgAW1And14MlAvmhI/05ZIG4m9lQFjmfpobhhCww3G6JBTWSRNRaNeAIc5UWcC6cI7LSJLwpfw==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by DS7PR02MB9508.namprd02.prod.outlook.com (2603:10b6:8:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:53:01 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:53:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jiale Yao <yaojiale02@163.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Hemminger
	<stephen@networkplumber.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Kameron Carr
	<kameroncarr@linux.microsoft.com>
Subject: RE: [PATCH v3 2/2] Drivers: hv: vmbus: copy dynamic IDs before
 dropping the lock
Thread-Topic: [PATCH v3 2/2] Drivers: hv: vmbus: copy dynamic IDs before
 dropping the lock
Thread-Index: AQFxSm9HVMFxOTFM+hFv7ncFU97/HAIffMU/t9jQ+EA=
Date: Tue, 27 Oct 2026 16:53:00 +0000
Message-ID:
 <MN2PR02MB68638470758B9B7CCAC3377AD4602@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261027065642.2280297-1-yaojiale02@163.com>
 <20261027065642.2280297-3-yaojiale02@163.com>
In-Reply-To: <20261027065642.2280297-3-yaojiale02@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|DS7PR02MB9508:EE_
x-ms-office365-filtering-correlation-id: b72da566-5fe3-4634-6c07-08df344ac2bc
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnrlC5lHdFGci+YUsdS3F/CI4lAy1IAOP8v3+KTgQndRedK4pSA0l3hsxoErF4heqGLaK6EBjPGNCOvA7BtGX1wzwQOvpdMzqAhCItakPwDNFrL0NK18QBv/y2wCapGMfNM9c/YAC2WYnTRR/hgR7PjnM3G5WT7atymIE6uxoENT1RPxffshQOzTIWToxg/UOqEKoDgo4y+z//Za3HxrxA37hlrXsFkCCRVYLPgE5KcV5T/OqN8X9+zUPunzoGRSKQyz7hLJFCYDchP7dv+DL0D5IXDpLbhAeYLLwcmM/hG7gku7xsIRKm1DzY6Uh2Ovun9t63wyXL0SADe4OLAOyRYKFENnCIOvT1NGuA00ixAqA8Zcvf/TCaP8QkIx3YrKLVcQL+0oUjgPO5OLLuChUymHheMXOFbNlst9uQ9/HbuqBeGl1aesSxwRjGrDCLTXv+Q0sbgmjiyHxqBxzxCRuDRsQD5ZzNbzeHQ784kq88JYt13LGtkXiVKqMGXfSKygVwGhNWC4pVmz4oVmUXTbM5qD9BTSgqwzb+zNfjaowfuE3tN5Iz5HuzfvdHMPh8FSoN0lyWU1F+6plqiqZI7z2CVeyd2+In7vOjTS8WxLgI8xXyYNmOf5pcBTBBc7KJ/5fmNO95rVYSvTLO/zqvmszNWh+BlSGwfB/KQefC+7kJXMhIEGO41wJUvV9JR25JuvAtNC8Ck2HVOJm4B52/elCjhwZKtI2CcQdvtvygpvISffR8RQm/ENBvFBf1usY8Ky0uc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|41001999006|55001999006|24021099003|37011999003|51005399006|12121999013|8060799015|8062599012|19110799012|13091999003|25010399006|4140399003|56899033|3412199025|440099028|102099032|12091999003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XNb70xbI3ixkKxoykUVyEfUgRWcOKN4JjHLQlESc4DmRt5TXljReQmgkhnmL?=
 =?us-ascii?Q?ixdYpDGXtvY5Z+g7n13zObaHb6ylnubeay58ByUpL1gPyjOUkPFhV7cUQPxF?=
 =?us-ascii?Q?+cDdy1EuLVhYEhwwVbJBmK7MxU/axfZPHW6FJy87sqTnODIZGSsb0lkHHSql?=
 =?us-ascii?Q?rF7ThleTVJ3KUCCEZdkz8aiAcyPg8P8ZW3oyfTdsoNRGBIdm/f3Q8gNJsyM1?=
 =?us-ascii?Q?vlfJQ5DqLYvnaYuLrTkUC/9khmqGkZOHhXIqiOhTCJA/KLM2ztycR+On8qGN?=
 =?us-ascii?Q?tTNw2JoOQccqAsNabRh6EBpESd8Zk9k4nD0bR1iuCjMxaz21iJUNPcFoJxnt?=
 =?us-ascii?Q?MMGgTvFV0n/8VBZy4vihPhb8NMOT/Za+z2LhWtLPdm2FAGyvDtzfY/dH42zI?=
 =?us-ascii?Q?1igaCuNxIjzWtKxihF65LZxcNuUnQDhuIN1ojDD8sZSPOBq08SbaqH4L8hgq?=
 =?us-ascii?Q?8ccFvdwQUYZRkgLg/ScRxb8/ktvmwqR5WWq9ZnJRHHfMwEMJjIOAB9Ctd156?=
 =?us-ascii?Q?QGkChy1nPJeNPtjaSjcPF/pLw+EuujQKSfEWPOGdwZVIQJeJjv00k6c4hMmw?=
 =?us-ascii?Q?o3x13hZS8D0KIYnytzAvvgI+R1eE/3+qRpMcPecwS7pi368iT4jnelvWDNQd?=
 =?us-ascii?Q?x9VbuzLQFiWWTbbDbJDqsHAMaqOhwx8I5ia/kbholj+rkIl8ioFCCESfQUeQ?=
 =?us-ascii?Q?cM3g6e3Bps9D9Ui8MyIN+QAYZ93oXPj0n7kNnr84zX9GqjcSrfLCBa8m5kjQ?=
 =?us-ascii?Q?h0OrZOizOf7pVWl7CEJKbNuwwik5cnZkxKfZWcOtTCSG9t63h+rxdIbUCmmc?=
 =?us-ascii?Q?xeLA3H8rmmFuHecZE8oMIYiWbuVDEOxRLzzLFCvbOgHXFSowETrOz3s2CE6t?=
 =?us-ascii?Q?VKODoBKgkyq1EmoWUMce+YoQNNZLDBW8VXHnpGZUqttNEID2pt8AXjmmKhDD?=
 =?us-ascii?Q?UQ5W9B8S0xRFVIpy7zXKf9ZkaGXt9hIJBhVNqw3x9I5BUQjE+O2zAplChpbv?=
 =?us-ascii?Q?yVKkXdMfJJPkQ/e7jeSHNaALzESRrM+tgoVQ54u248HDrEsv9sobm4d8g1sn?=
 =?us-ascii?Q?hvuodWYIJHNx2lzhSI8f5Rz/WUtCmnE9GuG1doAQSGntFpfLo79U4/rw39An?=
 =?us-ascii?Q?eTErKGyYpdP/?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Inz9Fdy4AUsJIO19K5LcJjjtO9dn6OHHYPCxR5pry/0YGz1kRwWovDSv0lSO?=
 =?us-ascii?Q?dYPbrbQi2kgWFXS3VDhUvs9U/sK+7p7HRfVjN/V6dlCG5AENpzceKF4ASFOK?=
 =?us-ascii?Q?zI2KP4w/bU9tCb1Ws9HsK+AU6c9rzrdJN1MOnoL3OdzRx5L+wWYRn+90bCxd?=
 =?us-ascii?Q?ho73ZhT7xvdqllUADZCtVtWJwR+D+2dvy4Lz/nu2R+TFdXbbgTLgkKvn9uqv?=
 =?us-ascii?Q?m0IjK8Udgm3sxrledE+8a/p/HiNL/+Y+3gvI1onhUjUBH75Td1QK4X/zfjhg?=
 =?us-ascii?Q?2sTWJ0gl5VeD9uOEytL3XSCWI+Fylyoqlm/ql84oZDfXxueqPskNIz0hy/nQ?=
 =?us-ascii?Q?cTmRogVcwONgxGn+ffqU9cw3FBapLeOafYv4pKupZ4/2UXEAUZtQzx2yA96H?=
 =?us-ascii?Q?fmOH+9cmESTgfdPDLQDLUjnkttVR92mk/4D5KAqqwvBxk/HKD18wReCVwLBu?=
 =?us-ascii?Q?AD3G8IZ/kJ0H3Af20jnvDtW4CqWCW6gcDXnOQLJw9JY6XnjLncWOA/yZ1CfR?=
 =?us-ascii?Q?S7y33msTfMwDWutICV9E+M9FFblX+GIbFKZbPtOKqctBCXsz67C9nK7k/V7l?=
 =?us-ascii?Q?Lq/7AIFeAdSW7xI17CCWk4jWvPFVVxZuecSMHYnc7k8QHFdIOm6c26nxT/BO?=
 =?us-ascii?Q?agqtv9zJ8y60wChk859UC1aYjjIY25lB+qXQ5XjIX0UjjfSfHEJcsm3IFy3u?=
 =?us-ascii?Q?/kC5AnLMaQDSzgn5vrC9MCX3sC1/cQmCmGk6vkiTnsEoh6tGOcg3xWVBXsN+?=
 =?us-ascii?Q?w9Lebq0BeJVbP1hGPX+Xa5yMtv4701r+PS626fCrLUkZoj+UPQUFkp/3ss9q?=
 =?us-ascii?Q?9CKBlYIzxRQurIA1ZZf+H4z7lxsmBLMvzrvwcn4hPwT9u4Bkjoid5t5lubl3?=
 =?us-ascii?Q?6QzJs8ulhiyz0cKSQMjB+LT/Nrufc0Ewerwp23ERBOBwR+FDGHIYf/aISsZS?=
 =?us-ascii?Q?jQ+7tateaelRTTJPMKnPRL5wPkwvlukb3bXx5mrzVakXIpW7J0CrBy9KjOYP?=
 =?us-ascii?Q?mvlTFMj2sPzC7nfTqWNWO7UZ/TUENnZ9nU05D1Z+wlHRuBWRie9lfdOcorTg?=
 =?us-ascii?Q?o0Rh0wAWCXPQVy7TDfUN0uZyvL03DW8ovxay/7hv+RpQD9gjo4w+EQh57nxz?=
 =?us-ascii?Q?vkhiyzuCaazGEoyZrU4ydBIY6txqsQLR2DUdewYehzU/hLCtQ6RsDPVMUvvO?=
 =?us-ascii?Q?HqRGI9KRYlAl2WJWgIQ4ihQDfTVSu+GR9fAVDldA9M3YTGpEzeBvzWYHo848?=
 =?us-ascii?Q?/os7jisvHLxafR5CUkarvSRfwMprLDdLF4hBvMf/LNP9dt6ykmPdCUbpmREU?=
 =?us-ascii?Q?FB6RPLVclfdW/kvvQF50AeJOsVnyvJnKhBST6CsTiQKkL99FCPb3k4ffY+g4?=
 =?us-ascii?Q?SXRbZXU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b72da566-5fe3-4634-6c07-08df344ac2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 16:53:00.8206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9508

From: Jiale Yao <yaojiale02@163.com> Sent: Monday, October 26, 2026 11:57 P=
M
>=20
> Dynamic IDs are freed by remove_id_store() while holding dynids.lock, so =
a
> pointer into a dynamic ID entry is valid only while that lock is held.
> hv_vmbus_dynid_match() currently returns such a pointer after unlocking. =
A
> concurrent remove_id write can therefore free the entry before a driver
> probe dereferences it.
>=20
> Copy a matching dynamic ID under the lock and pass the caller-owned copy =
to
> the probe callback. This follows the lifetime handling added for PCI by
> commit 3ffc4c9690c3 ("PCI: Fix UAF when probe runs concurrent to dyn ID
> removal") and for USB by commit ef8154d8b52d ("usb: fix UAF when probe ru=
ns
> concurrent to dyn ID removal"). Document that the ID is valid only for th=
e
> duration of probe.
>=20
> Because matching and probing perform separate lookups, removal can also
> happen between them. Reject the probe if the second lookup no longer find=
s
> an ID instead of passing NULL to drivers which dereference it. Keep the
> hvsock exception because it does not use an ID table or inspect the ID.

I had a little trouble mapping this paragraph to the code, but eventually
figured it out. For more clarity, I would have done this paragraph somethin=
g like:

   Current code in vmbus_probe() assumes that hv_vmbus_get_id() will
   always succeed because vmbus_probe() isn't called unless there's an
   ID match. But matching and probing perform separate lookups, so
   removal can happen between them. Check the result of probe lookup,
   and reject the probe if it fails instead of allowing drivers to derefere=
nce
   NULL. But like in vmbus_match(), make an exception for hvsock because
   it does not use an ID table or inspect the ID.

Don't respin the patch set just for this change. Maybe Wei Liu can
tweak it when he applies the patch set.

>=20
> This issue was found by static analysis of the dynamic ID lifetime.
>=20
> Fixes: fc76936d3ea5 ("vmbus: add support for dynamic device id's")
> Cc: stable@vger.kernel.org
> Tested-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> Reviewed-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/hv/vmbus_drv.c | 34 ++++++++++++++++++++--------------
>  include/linux/hyperv.h |  1 +
>  2 files changed, 21 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 1037117e2d81..1cacbc71266f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -661,21 +661,21 @@ hv_vmbus_dev_match(const struct hv_vmbus_device_id =
*id, const guid_t *guid)
>  }
>=20
>  static const struct hv_vmbus_device_id *
> -hv_vmbus_dynid_match(struct hv_driver *drv, const guid_t *guid)
> +hv_vmbus_dynid_match(struct hv_driver *drv, const guid_t *guid,
> +		     struct hv_vmbus_device_id *id_copy)

This change to the function signature, and similarly for hv_vmbus_get_id(),
produces a rather unusual result. Upon success, the function returns the
new 2nd argument. It took me a little while to figure that out, just
because it's unexpected. A more normal function signature would be
to return a result code to indicate success or failure, with the new 2nd
argument containing the actual ID value that is wanted upon success.

I realize you are following the pattern established by PCI and USB
commits mentioned in your commit message. And there's real
value in consistency. So this is just commentary and not a request
for a code change. Leave it as you have written it for consistency,
but it is a bit weird. :-)

All that said,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

>  {
> -	const struct hv_vmbus_device_id *id =3D NULL;
> -	struct vmbus_dynid *dynid;
> +	scoped_guard(spinlock, &drv->dynids.lock) {
> +		struct vmbus_dynid *dynid;
>=20
> -	spin_lock(&drv->dynids.lock);
> -	list_for_each_entry(dynid, &drv->dynids.list, node) {
> -		if (guid_equal(&dynid->id.guid, guid)) {
> -			id =3D &dynid->id;
> -			break;
> +		list_for_each_entry(dynid, &drv->dynids.list, node) {
> +			if (guid_equal(&dynid->id.guid, guid)) {
> +				memcpy(id_copy, &dynid->id, sizeof(*id_copy));
> +				return id_copy;
> +			}
>  		}
>  	}
> -	spin_unlock(&drv->dynids.lock);
>=20
> -	return id;
> +	return NULL;
>  }
>=20
>  static const struct hv_vmbus_device_id vmbus_device_null;
> @@ -685,7 +685,8 @@ static const struct hv_vmbus_device_id vmbus_device_n=
ull;
>   * If there is no match, return NULL.
>   */
>  static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_=
driver *drv,
> -							struct hv_device *dev)
> +							struct hv_device *dev,
> +							struct hv_vmbus_device_id *id_copy)
>  {
>  	const guid_t *guid =3D &dev->dev_type;
>  	const struct hv_vmbus_device_id *id;
> @@ -697,7 +698,7 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_=
id(const struct hv_driver *
>  		return NULL;
>=20
>  	/* Look at the dynamic ids first, before the static ones */
> -	id =3D hv_vmbus_dynid_match((struct hv_driver *)drv, guid);
> +	id =3D hv_vmbus_dynid_match((struct hv_driver *)drv, guid, id_copy);
>  	if (!id)
>  		id =3D hv_vmbus_dev_match(drv->id_table, guid);
>=20
> @@ -843,13 +844,14 @@ ATTRIBUTE_GROUPS(vmbus_drv);
>  static int vmbus_match(struct device *device, const struct device_driver=
 *driver)
>  {
>  	const struct hv_driver *drv =3D drv_to_hv_drv(driver);
> +	struct hv_vmbus_device_id id_copy;
>  	struct hv_device *hv_dev =3D device_to_hv_device(device);
>=20
>  	/* The hv_sock driver handles all hv_sock offers. */
>  	if (is_hvsock_channel(hv_dev->channel))
>  		return drv->hvsock;
>=20
> -	if (hv_vmbus_get_id(drv, hv_dev))
> +	if (hv_vmbus_get_id(drv, hv_dev, &id_copy))
>  		return 1;
>=20
>  	return 0;
> @@ -864,9 +866,13 @@ static int vmbus_probe(struct device *child_device)
>  	struct hv_driver *drv =3D
>  			drv_to_hv_drv(child_device->driver);
>  	struct hv_device *dev =3D device_to_hv_device(child_device);
> +	struct hv_vmbus_device_id dev_id_copy;
>  	const struct hv_vmbus_device_id *dev_id;
>=20
> -	dev_id =3D hv_vmbus_get_id(drv, dev);
> +	dev_id =3D hv_vmbus_get_id(drv, dev, &dev_id_copy);
> +	if (!dev_id && !is_hvsock_channel(dev->channel))
> +		return -ENODEV;
> +
>  	if (drv->probe) {
>  		ret =3D drv->probe(dev, dev_id);
>  		if (ret !=3D 0)
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index e61f9a4cb7c3..1d5862725f24 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1264,6 +1264,7 @@ struct hv_driver {
>  		struct list_head list;
>  	} dynids;
>=20
> +	/* The device ID pointer is only valid during the probe callback. */
>  	int (*probe)(struct hv_device *, const struct hv_vmbus_device_id *);
>  	void (*remove)(struct hv_device *dev);
>  	void (*shutdown)(struct hv_device *);
> --
> 2.34.1
>=20

