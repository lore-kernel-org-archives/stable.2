Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794026933;
	b=Wwq450WuEFjkkmDHeGRVhanOR4WDEEmNGgay4m+lnzHFCAmO3+YZoxiNSKx63+dZTPDK
	 x6GVRw97UtYNKgaPkYjbukFVFPn2l17OFd1Cq8dTQZpkmmljSO0V9PLr/UnPGE3Ajw5xR
	 0LRSLPWsn9V13HdqvfsAs3OCi5FMMyBNjgLmD9t+RuET8HIQnG+q4XlOgiaHp1BnCPkd9
	 dlUmZ47jomLFTKs+M4zIwZbNtyem8WisYH0dTJE16mGyl+XAap5vGzYqVkJbGB0On5hJJ
	 2KQaVxnKFDoe6miWwxUZRpdka09sQb+HxdROi+N3a05w5Y/+BFNu4YNjDIfu1JDpdfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026933;
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
	bh=NaxFYcpYWR41DDr/N03h5zX2moEkTXoY7Z6UpiXGTPs=;
	b=BoLi5hYvZ1rCxfuVGlGWDON3H0Paf7qLIlCEOdbBlAobq3Mm32/3Ee/kjPoAS6C65A4V
	 XHgvTzquvvVc8E3oY5EvXXV76Su/BNrVsIn2YgD8cMvh7KViUEuXO/EaBzb9NfC335qGE
	 YBXbBDddZdpw7mXQyB24H4qUt5u08svCYXOPRcFcmpoM/PgHrXqY5Ux9zhUb6H5Ee2pqM
	 4AOqOtsNTj+QJhPmc//ivj9RmSGuEuvqZ6WZXpTltSdZwDcVqBmqg+dF9Geqmz6KcjTPy
	 NbLTeJSPTXYQBNPkXRRnJ6GAcu6YALrsBiAKGSuwIKvvfBf/DE1PkyR7e6K+V6T951g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="mGyppX+/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.20
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010020.outbound.protection.outlook.com [52.103.12.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C319606A326;
	Sat,  7 Nov 2026 04:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C319606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=mGyppX+/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4X7p3Z42vpYK5xh3a+qRyaren/m4k9tfzVDjMcjjbfg9Rf7nqoDNDP2uwrgTi9LzBClCqX6lTUV/JAYu+SXRLfHQ1mwfKXZQIgVt8hdUpzFSuzJoAj8oHzEhzxtsCOPEPip9X60G53+hk7k0VmtQaWqkRRWIeOeSPwyh9DGcDSYfwOD5C5v17o6s8eimg6bNeLFb+AEUAQHGHmNIxcQdaYTzE05AjLblTNFHspLsq6CzKySqG8GITKdOG/pID11l0XhWae7msYIOcdBrQr+heqvW79zFeGzw1ozS5pTZthkbdKtCIaeHkXyQgJaItZizWjEBGGjz4eNZQYViLgb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaxFYcpYWR41DDr/N03h5zX2moEkTXoY7Z6UpiXGTPs=;
 b=XZre6+RbHjgoQwrNYeZSTaVLM92/qiLpzZ0rN+FrPiFgqoKBwiVYcSGkvTTFe1C9KtWWd7VNMbl/kzcWNqNFJxKEZB6WZ4pcxD+78p/TZXJa/fCd17/90yXl1pyw1hVjaGndzLRSOW7Ly9Tist02tic6G0ISzINSqSdZIhi74jn6jsAOZteY4mKgn7rY2IgEm5tWfggUCLeMPjGvaJ2yqkNfQkREmT2VfB+a5nbrvWergW23TEJ4IztEu2YSTf+Gc/sgUsIVBuseTeXDu4Ez+nvw1hMexo5oT9SYTfrdhUxNR6ufgjX7dM3k2bAA4XLvNGomXianvQoKgpV7MJZ77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaxFYcpYWR41DDr/N03h5zX2moEkTXoY7Z6UpiXGTPs=;
 b=mGyppX+/jm5wvHJzzRIwk9jy7Yfs2Je2XFEZUlEc6PJ/MF5DCERYS8yS5GPJQDSvdudEchcaIDbdbeIdo+g5CFCvXeGDCrPzhOxCGu/+TnL7Dtssj73w1DaDo/7b44K13xArJ1CQpQfKGrctLEqZQI7hGQVh+MXd9+sJV0prnJQSG/jIqtaGh5a+BxmQJ9b8U9P2UlVDku3QhWl7T/71UmNF7hqJdOhT+l1p7U/SWmjhHOskxHFqedCcE6s4BPj3xuxWnRTPbn/AupVSVp0rmDRYUlBCYn8vhnl17wOHESlKMdOr6fyOiMKMrFFyzIWEn3b1ln95Fve2T1CIshzyrQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by IA1PR02MB11006.namprd02.prod.outlook.com (2603:10b6:208:5b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:48:51 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 04:48:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: Patch "Documentation: hyperv: Update documentation for sending
 VMBus packets" has been added to the 6.1-stable tree
Thread-Topic: Patch "Documentation: hyperv: Update documentation for sending
 VMBus packets" has been added to the 6.1-stable tree
Thread-Index: AQHdbmSgkr3V9IKZDk2fSptcHnqwzbciCZ2w
Date: Sat, 7 Nov 2026 04:48:51 +0000
Message-ID:
 <MN2PR02MB686320410C539AAA5F31212DD4752@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261107030349.2752678-1-sashal@kernel.org>
In-Reply-To: <20261107030349.2752678-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|IA1PR02MB11006:EE_
x-ms-office365-filtering-correlation-id: 1d57320a-9545-4404-b694-08df3c8a6b5e
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|51005399006|31061999003|21061999006|13091999003|12121999013|19110799012|8062599012|8060799015|25010399006|24021099003|55001999006|102099032|440099028|4302099013|3412199025|1602099012|10035399007|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+84tMoENlnntcNw/zEWzUCyYP5p0ZJDK4tQP8c2Ng/Sloqmpitb1SUZypSLT?=
 =?us-ascii?Q?ukh10cWtD6JGNiGtol5/VxYlj//0jWIF+Bbjqp8337kGxI5Z3JpGVb+hBgH4?=
 =?us-ascii?Q?OvMyDph98TMNUVmDbeyfclVLM8ttRt32D2EP0ch10CRLJch2p4FqNwFeIpUq?=
 =?us-ascii?Q?b+hbQailMl+h6BiKS4r5dfuLyLvN3BXw4fo7J3ReWdFGItbx+d2Zh9xfc6j5?=
 =?us-ascii?Q?w5LoiyClj28IGJtaWRqQ01/+dcfp/0iyw+Vtg59nspUGQXymNIsP7KsTMwKa?=
 =?us-ascii?Q?iMtnfBxR52IVspleKTzL09AVCbXdhSeoUeGL/MhULsNg1R4bp9Gl4JvH7S1V?=
 =?us-ascii?Q?cu1OXwgO7YxH9vssdoNoav/8k+jGOGRvkTt8Ht3BE30/76Hgz62qOOXRhqte?=
 =?us-ascii?Q?FDAc1obhHXnmB1gNgeMhbRK9P5rodfaVefoNs3EevCvJOSvb6Rnc8ErIU5Ck?=
 =?us-ascii?Q?5hxUcK0hV7YEaWg7GaLdQwWQMkX808AM8ITu/qNotjRQpDXVpN6TmLyn0w5z?=
 =?us-ascii?Q?PaPT6xeGU68j24PDlEosczd/vQvTe+qqiRvdevAHlaPTi2y7rkfdy+pAzQ/e?=
 =?us-ascii?Q?BtbfGm/5lCnr/kY2QVVp6TS55CdUZD6QVF7oFiQQ/op5LZG2/BIOtR6FJCwQ?=
 =?us-ascii?Q?O1gXcaQk7IskAYCW0mxUmX4Ip5D1UeINHKBi5EyTZBcczDmwocUsa3vZ/sUW?=
 =?us-ascii?Q?2DqaLLbGqqS8MDA4AOBsxS7/xwfymHzNKeuKTFyfpCD7dJmjjeCIFFiTjABz?=
 =?us-ascii?Q?2+LZZV06it+ukmKrKiVF8CxmeUqplk2CLG3dDmZax/NHFu6i8glAXPtFyRR5?=
 =?us-ascii?Q?YM7lrCmmBuajeF0jhnu0AfkGUITvw4kQUw8wMR0BNM41kjdttrugHSI3WzN0?=
 =?us-ascii?Q?Fyq5zTkecA/WGTYzdZjWPutVXCvwIGtZH996PUGADbQOrs+IuT2o4cENrsuF?=
 =?us-ascii?Q?sGYieL1AOPBEcudKRsWF6Xug3dbRgnMAMLuQ/830aV+K3b1gKQVfojuzkKpt?=
 =?us-ascii?Q?4DcLly2/daOrm8oKl7EmTFmifUx54cRAKtERwGMF1/G8U+IpOlPrNMV9wfWW?=
 =?us-ascii?Q?PlkhHgmQi88Rs6s/mIu8/Ei7VLewL1JciKNiCUuQYy6/mboHZKa4cC6+18wf?=
 =?us-ascii?Q?4dMmzPyCO7yB?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?phTfM6y02STp7LVIQa5dU7y+9geZidSr67oUAqWOZLYr5l8hKMrqUw6Opnpf?=
 =?us-ascii?Q?EovT7KLzV5WQPBvlqiZx1ClPR5QA/9HipMqRsAILNfzBJ+22kKLIuYdaFlGx?=
 =?us-ascii?Q?W8Xfjpgr8mNZ4mzg0tRne+Sglm9YCKIW4gaAJGpf0FEOMcCPy4qQmGMgHJs9?=
 =?us-ascii?Q?H0+5o6of2QC36rYRgnhjnKsSXuEhTrg68PtBcyTJjT7gHuqsJlHhFl+Y7IPq?=
 =?us-ascii?Q?67Lky1AWxbXfwm+VkHvu3tIkZpTdjgiwOJt2iQIEiIjE8XlJ8J8vb2q01duh?=
 =?us-ascii?Q?0gDmL5wehGcmBipHSLnMil3Zx1mBSl+limbS2rmdCS75c88/xH0RrsC+SO3b?=
 =?us-ascii?Q?4ccqDVNWn9CKFTSMd/MKWlfHNvpgDd2oml0EArLUyF3vu2MBo05Gs9Ghh+8L?=
 =?us-ascii?Q?h9Ms4Y9/IwNbcFKi7alWd917tSI6JTyIkFf9lC+2tnRo7GKaVdmBbgPKg7yM?=
 =?us-ascii?Q?OmmLfeiMzZpQGxVaLTgZ1bqphMJwBIh5aH7JfChINoXa8SLER71hI930Z+lZ?=
 =?us-ascii?Q?id0JCXfE4cjPvrzYMXoWExfzdl7bw5fFUFp87M9u6f3hz7PjVGa1hrp/F1kH?=
 =?us-ascii?Q?fVLcdYSWJjHJDNeT6o28FKs3Ktpowmtv+xhqv0Urld+e1NaMJdJK+6pvJEPo?=
 =?us-ascii?Q?jVGq4nsqZ9lWRM0gZ3ICTf1TaccF2eKPdsBW8XuNcYfo/wxwPJknNYfw1OHF?=
 =?us-ascii?Q?UJ2sdyPzZ9z9H0DbWGTvqaB7XrOtq73tir/en+TAzKP7S2+FM8oTEE0TPODY?=
 =?us-ascii?Q?5fqenefjUEJxJ0gSLzlvSbbwJbieZq5zAxrxzZhg03GxbaENPkNz4CK3Xspv?=
 =?us-ascii?Q?IwQXJaE5tZ/bL7clm59Wm/cr2kIFytqGWhEXTQ/YZHj328TtOPXBBCemNsbF?=
 =?us-ascii?Q?8truWLOfLpC8piKiouG8revr2MyswW7DCPE7iyITFTTMmNLwopRXpcfMPD1w?=
 =?us-ascii?Q?jrEcu/Zq25qf7FWBX7Ei3UJR4y/W+xRy2N9NHABv6Zjexb1WaprViIjWyjut?=
 =?us-ascii?Q?NLgT0PuzJ6XnNShxg/9N8pXR0b6DP5c639S0R5uBKMBCOpPrahkxoCqqWepD?=
 =?us-ascii?Q?Y+xb8tDlknwS2rXpKWpZctJClVGsrOtYzlIBiSJxw//hbRWdq47w6wfHEhCP?=
 =?us-ascii?Q?dE5wy1DFCWMvBCU4yL70n4+klTd4MESP50IYFyZMEDjti7ILSi4f2r75gvqB?=
 =?us-ascii?Q?HI0jniq+vYvQFo5klfgrJOeSyYXt40XJHrPdbUXfn/ooRmsa3EJvTaVmMSOA?=
 =?us-ascii?Q?5jlKg2O1EthieaoYI1N0fpASVnhPlD/F6/ltOn4UfLIdsQRIH20nmAbqH6og?=
 =?us-ascii?Q?+L+i3liMQWPIeRYqmQJy65arYTnKO2ALy8e3qidIXCEurDFiME7qdrkdE7C8?=
 =?us-ascii?Q?+PYfilc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d57320a-9545-4404-b694-08df3c8a6b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:48:51.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB11006

From: Sasha Levin <sashal@kernel.org> Sent: Friday, November 6, 2026 7:04 P=
M
>
> This is a note to let you know that I've just added the patch titled
>
>     Documentation: hyperv: Update documentation for sending VMBus packets
>
> to the 6.1-stable tree which can be found at:
>
> http://www.kernel.org/
> %2Fgit%2F%3Fp%3Dlinux%2Fkernel%2Fgit%2Fstable%2Fstable-
> queue.git%3Ba%3Dsummary&data=3D05%7C02%7C%7C798809b7cd2142ff688308df3c
> 7bc1ef%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C6392961743599812
> 89%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> MCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata
> =3DWY5HSpDhcGtlzJOwVVfE7PyMTzFMfe3eEMlifkm9STc%3D&reserved=3D0
>
> The filename of the patch is:
>      documentation-hyperv-update-documentation-for-sendin.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

This patch should not be backported to earlier than 6.15, as
vmbus_sendpacket_pagebuffer() was removed in 6.15.

Michael

>
>
> commit 1351f5be3a916061e7e76e540bf2db191156c21a
> Author: Michael Kelley <mhkelley58@gmail.com>
> Date:   Mon Oct 12 18:43:54 2026 -0700
>
>     Documentation: hyperv: Update documentation for sending VMBus packets
>
>     [ Upstream commit 6a3d77a0a8cf69cf3d234305e6711729eb5d10c4 ]
>
>     The functions for sending VMBus packets have changed.
>     vmbus_sendpacket_mpb_desc() can target multiple ranges, and
>     vmbus_sendpacket_pagebuffer() has been removed. vmbus_sendpacket_geti=
d()
>     has been added. Update the documentation accordingly.
>
>     Fixes: 45a442fe369e ("Drivers: hv: vmbus: Remove
> vmbus_sendpacket_pagebuffer()")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>     Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
>     Signed-off-by: Wei Liu <wei.liu@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/Documentation/virt/hyperv/vmbus.rst
> b/Documentation/virt/hyperv/vmbus.rst
> index d2012d9022c5e..3326bb103a5ab 100644
> --- a/Documentation/virt/hyperv/vmbus.rst
> +++ b/Documentation/virt/hyperv/vmbus.rst
> @@ -141,14 +141,15 @@ Three functions exist to send VMbus messages:
>
>  1. vmbus_sendpacket():  Control-only messages and messages with
>     embedded data -- no GPAs
> -2. vmbus_sendpacket_pagebuffer(): Message with list of GPAs
> -   identifying data to transfer.  An offset and length is
> -   associated with each GPA so that multiple discontinuous areas
> -   of guest memory can be targeted.
> -3. vmbus_sendpacket_mpb_desc(): Message with list of GPAs
> -   identifying data to transfer.  A single offset and length is
> -   associated with a list of GPAs.  The GPAs must describe a
> -   single logical area of guest memory to be targeted.
> +2. vmbus_sendpacket_getid(): Similar to vmbus_sendpacket() but returns
> +   a transaction ID that is matched against a reply from the Hyper-V
> +   host. Useful when the struct completion (or other rendezvous data)
> +   must reside on the caller's stack. By invalidating the transaction
> +   ID before exiting the function due to a timeout or other error, a
> +   late arriving interrupt is assured to not trash the stack.
> +3. vmbus_sendpacket_mpb_desc(): Message with one or more data ranges
> +   to target. Each range consists of a single offset and length plus
> +   a list of GPAs that describe a logical area of guest memory.
>
>  Historically, Linux guests have trusted Hyper-V to send well-formed
>  and valid messages, and Linux drivers for synthetic devices did not
