Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012021.outbound.protection.outlook.com [52.103.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11A3CD8A9;
	Sat, 11 Jul 2026 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793205; cv=fail; b=OgeE6AW/lecMeF1rdxqJ/Kr5XnkMCePQ6sjJE+yH9fwu8C1BK1G8IayQ35OnIdWEq/4cVt/iox3R4UHczP/MKULy/wYsSFS1M3KhPhqQYqNUP+ZUK3OKxy40TPBGioHR18KKz3J7rjkVz0l5xtriiDaAKjbrHCWjVlndYz+3/og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793205; c=relaxed/simple;
	bh=eDmstlaEUh2PxcCp0UVGsnrJ9ND/kkLvpNdJ1yBTauE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=udoq8Ka70iNCwRgLVwQ+wtsw8T5KL5R+ivkE10bhdIZD/8Fw4HUd47wak9gfSsHhbAGl7XA8wMcBejYeEIYtgcgimeP1HuerYdM1Los0L6AV1W2zuKdQycRuXJPSm0/Q7zg5uwUcpKp9VhGxJnmUogac7VLFpeodWC3AcrSa+u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Jmtje7SW; arc=fail smtp.client-ip=52.103.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Jmtje7SW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbB2jaWKLgzZtq7nSHB8aap9VCmZOD8EWSjl0Jf+wUnSSiyIe4KYEOr3e3ODihDaqo8nYcZABdIWp17D52fY+h6gtvdPE7ol1/F/H4E4yU4UfA+S+Gyb4QNja1XdSh1Ct3mFmcKtnL607O4dISHFVmal9ZQxdt4TNfT2kknk58TM0bcAEmhT9X+yRKpO6icqKfSCZZpSb1iCfShbZWnOwwpulnvTi9ya51xnUIr9+NHdY49+KKq6Do+wxp5vyv7D4PNytERjWVRviqA/TsGmHVtNodWr/nVvRWDX7AsKm7dNwxYnKKCe4XzfzSq/Jgzla9NPkhQfuwSI66XRvcaR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i79v9JQlGkJDc2S74npd6rnvyQ8CfAa7STSWGJKtY/g=;
 b=O/NsRFDVcXk5a6n3/Nh2oXMV3Txq4+eVS9kWWDyAV7i762YWw6P6e75ZR86ewWwNqQprUduUPpUTuPsiFPjoGqyiZDZBllpBpQc2CIt47qxcUeGGzScFpWQrcCjvfVzCM98LF98LB21twWyNxrfyurj5Rb/Rx6nhPIXqEU69lpP7qitF/6ADrdgCdWDbUHt6k+VFOtM7dmDVraV71QfSDX7UdOryO/oOffAaaIEBAOwUPU/oNnqW1xzqXXYU3oDELlMHWOjHFOB5RSGErj7WyPfke9CeGBhUOTmHUw+dw7IhmUUA2ebd/w8ML8spq2iVt3pqe/iaYcLMHtz/dHFaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i79v9JQlGkJDc2S74npd6rnvyQ8CfAa7STSWGJKtY/g=;
 b=Jmtje7SWYXTFyRuYI69m8CSJoAnWDGQ6sXm668ETwchIvYwekWGMTsM3G8QD74AdI6vaZcOEd0kRDOzFuQQw/mNQV/HmYq09+1hv+fKpQigVIlOFD3s5pYqZO6yQpCAD6vGZfgGB56Z4aYsRfrQtRa/lOC7QMivVSIJewmnU2CsLzfhy8OttUjGi1FTV0DWKY08r2zuWvZKvbNoGFGUghgG/uPSgBzP4kjkoPRfzBb2EjKLNZwmWjShjtap6+bvCCBT2D0d5WaG4xQGFHRaoHOuODcS2pcpI6X2FBinrBZ46fDhK9n2gW9T5XipG2kaFbvnsPZNDpVnCk3TDRt9saA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SAWPR02MB11439.namprd02.prod.outlook.com (2603:10b6:806:4c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sat, 11 Jul
 2026 18:06:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.017; Sat, 11 Jul 2026
 18:06:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Jiri Kosina
	<jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 0/2] HID: hyperv: bound initial device info descriptor
Thread-Topic: [PATCH 0/2] HID: hyperv: bound initial device info descriptor
Thread-Index: AQHqIQBWpWEJ7wPGIDK8IqS/5c/pZLZOecHw
Date: Sat, 11 Jul 2026 18:06:41 +0000
Message-ID:
 <SN6PR02MB4157EEE7437300BE9443AF84D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
In-Reply-To: <20260710022854.3739558-1-michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SAWPR02MB11439:EE_
x-ms-office365-filtering-correlation-id: 5c3693c6-142a-44ce-aca4-08dedf772932
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|37011999003|8022599003|15080799012|31061999003|8060799015|13091999003|19110799012|24021099003|8062599012|3412199025|440099028|4302099013|102099032|10035399007|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aaFbWFpgxRS2TVpeC7WMMv/mcFRKndZwZ03PEbCMuHkc6+taKmwh7mPQLqGd?=
 =?us-ascii?Q?jKP3lboW2goQzyYkZSII+cN06HP3j9iBSkuQUNSA2QUAUhwJY3ciIUydjyah?=
 =?us-ascii?Q?g8eccOPxJRNhStRZ8LW3RdhujihCj5PSRuUG4vSq6YaCVYM68I7lg+PT4B6a?=
 =?us-ascii?Q?jP4Z8wJ8u5Z3JocI8UV3mlHhELbYRdn8pQBaJPczfHaHqwtZrsTaHeL3Ra4j?=
 =?us-ascii?Q?TZ0F/LapHv4Gt+vgLlTKU+eay77rM0SLjQuLRKTSPwHa5f8s3VMNcUeY5t59?=
 =?us-ascii?Q?3A+CD6Xmy6ZhtkWz3i5KRmHEKjwOL0yghVRiw7BI8x4brexXugx0OHvRTeA9?=
 =?us-ascii?Q?5jUBgNTB5YXO3T2ygMn3Lo1AGzepzV/1+5fU34+Yh1/ePt+EpZCnzV6t6R7O?=
 =?us-ascii?Q?bUtke7oGHPuFiLBtdr07A6+uQQQX770+Om+nAsRhSg2eohvHei0sV/2R9T2w?=
 =?us-ascii?Q?Gj7qU4bftzXTbdna2Kouw7GsZwKfpgfQt4qn9sSjptJ3stwzNwyqJsQ4ghgo?=
 =?us-ascii?Q?4WnxwnPSqVlUP7YvKocvYhOiq/jzXHrL/cfAXhklbhIAnkuSsauu5rSUmgx2?=
 =?us-ascii?Q?DeFRCjDh6LFMAer6BNAImLdt1uDtmGTBcHAwclrrWQv1dswnutlnAFSspnu9?=
 =?us-ascii?Q?5WP1HgX0g2KbDkoZi11RVG2hpEo4AG3or160X0p34FVTXorRoPpmnU4F1Qji?=
 =?us-ascii?Q?PoSEDm/favzF7ccyPUI1b0KGl5SRFHNejrXT8A1JHUcISp27VZuRZN2P6GNq?=
 =?us-ascii?Q?bROHRG9lmRNlumXgqW/RThDcxr7dUQYlCaLdNqG4v0NuDJJfZe130zjD/7yK?=
 =?us-ascii?Q?n51NbXNadDqzj7mfdh0QI3u9eAKOv2ULlVi5aeyyeyZKvWsFYNsWOk80prXA?=
 =?us-ascii?Q?u7KlG+dYLrFLgVqKP8pb06EqVc4A19RzRcbYjZtBW7Qns1itO2ShRVpEmTdU?=
 =?us-ascii?Q?w/+RUdcIrvFDvkIk1t9XELWj3Ai+LeJTESJLklLio/85wo4vhalndM6m20oU?=
 =?us-ascii?Q?t5vmJbiBZuU+0eVGcvRkrQvYssbv6jh0vFzkcFnWXYJw+CetT2laNqN7aCAv?=
 =?us-ascii?Q?XiVlNObr?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ozx1Op/DsHliNbgfU/1v8wadJ5FWSRnrg8KFRrdnYa2gt3VuApmBypxOwlO+?=
 =?us-ascii?Q?xqQyTUIoHhftIrT3ScRK+PYkvu2vUfzR0/TxF9NNKhZ1boYPj7LYw4fbViPn?=
 =?us-ascii?Q?bx2dDzoVgshy3Rjgajb5KWZpODpUlbM7szn+U71uPBG48cddhBb7ueZU5wxc?=
 =?us-ascii?Q?79FE/bHE11L2RTNfQ97V1jbCUTc5sdgtBCWi9ZCCx4GZaUJhi0qytv0WZiX3?=
 =?us-ascii?Q?yewb9Aw9JU3dO6jhQa+gmW+sKJDSmept9tuB9UWBQ+QeHFDfsQQu6tN9VD5k?=
 =?us-ascii?Q?Wnf/NP8upNqoEAdXIefkFUr+8CzaIb/QcM1gK1mop/ivkrZoG+crlGZpNlAu?=
 =?us-ascii?Q?k6EPFKFRvdI59KNrdDqRdYxtOywaux1lFReaAunS5VWxZNVhXsDEbdcn2ieo?=
 =?us-ascii?Q?Q+J9CLjlIIgsz5Nr+OqR8vApXlhNGzdEVmwmBr2L8FQzquLAYwYQbFXd4bya?=
 =?us-ascii?Q?IL+DZljzeQXG6tlgjBLvGuS9tGphR1aC15xceu/v9L0IOnOxeZjeiU2NWWAv?=
 =?us-ascii?Q?rxQmFH/Fmb6XduUzRrlgzTxFn/wuuHbJXQkA4Trs+lfbXQ3iAeX/sOQcZgn5?=
 =?us-ascii?Q?aKCzKNDIByWqR/yRODrJwvnUGNccOeIY1Ze3SUlI9XUE59rTgMUV9Qz+G0na?=
 =?us-ascii?Q?gkxf/3EJU6ZAtIYD6+sptnYFdxn+yqB8x33GysvpdtHViK3DTYcN5KbFaQmq?=
 =?us-ascii?Q?RlfsUDet9uSRMcrCBgy1p6775EFgB+nUg12QC7q0hrNVY+3leCaiL1UGhqrM?=
 =?us-ascii?Q?/hlQ8RpAJVoFArMVXaZgfl2QXxtSsmGznWAXILVfC+78Y4APV4EGbyqNN+Qv?=
 =?us-ascii?Q?WYbj9xt3l/Z2zLdXHyesQS7r6+XdIc7f6mhii3kLS05Cage/T1L6M35P1Der?=
 =?us-ascii?Q?vpJu1ekuYrn+SlIcuYJppmTKQSHKbXViVS+c/SZ7UbC1kbazVdPHWAw3DvXI?=
 =?us-ascii?Q?KjoFHCoxtM3b3lMglDalqZCkV6tZfUte/8K+HgP/LduInVHbwBEaaoWP7LW8?=
 =?us-ascii?Q?s8LuvumGglzBMygTjdLC6Ti4/U/wG+Py94aFidBfwiKRqnVxMfAeZstO27iz?=
 =?us-ascii?Q?OVS8MfkOBxac/BHos/fd+OIyd6d3DyZDgYvFxmemmbjLTK/4D+p7a9DePwu1?=
 =?us-ascii?Q?WhqEM3gCN8YiyW1JNqpbQrqzQNYMpV8T0q4qogUnOR/9tTfHGVWWkmasG61w?=
 =?us-ascii?Q?mAahiG4kwWS5m2fuczcaI7qJ0ii3Uz8rtPMr6D9agzdHdmhE4v2teQGbx43S?=
 =?us-ascii?Q?vWX+3qe+t7+a8Q3qS36rvBzYNVHTfVxkj0Y0X2gJU6aPN+qvpal9OO3gHsnD?=
 =?us-ascii?Q?YgHPA9ITHvLCGo5u1OzB9Y6vBWW6mbbO5XH0uz4rbPGfBXiV1nz527a/n4vJ?=
 =?us-ascii?Q?CxUPMks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3693c6-142a-44ce-aca4-08dedf772932
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2026 18:06:41.7588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR02MB11439

From: Michael Bommarito <michael.bommarito@gmail.com> Sent: Thursday, July =
9, 2026 7:29 PM
>=20
> A malicious Hyper-V host or backend can crash a guest with a short
> SYNTH_HID_INITIAL_DEVICE_INFO message. mousevsc_on_receive_device_info()
> trusts the HID descriptor bLength and wDescriptorLength without checking
> that the received VMBus packet actually contains both byte ranges, so a
> truncated packet with an oversized report-descriptor length makes the
> guest read past the received packet while copying the descriptor. This
> matters most for a confidential guest, where the host is outside the trus=
t
> boundary.

For some additional background on the assumed threat model that
underlies this kind of validation (and lack thereof), see [1]. This Hyper-V
mouse driver has .allowed_in_isolated set to "false", so it is never loaded
in a CoCo VM. In normal VMs, the threat model says that we trust the
Hyper-V host not to provide bad values.

But as I said in [1], I'm good with taking additional validations. But Wei
Liu as the maintainer for the Hyper-V drivers is the person who should
decide whether we want to take additional validations.

If we take these additional validations, there's a separate question of
whether to backport them to stable kernels. I'm inclined to *not*
backport to avoid introducing churn (and the risk of breaking something)
when it isn't fixing an observed or likely-to-happen problem. But Wei Liu
should probably weigh in on that as well.

[1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157D595B990A321BFA85B40D=
4002@SN6PR02MB4157.namprd02.prod.outlook.com/

Michael

>=20
> Patch 1 passes the received initial-device-info size into the parser and
> rejects descriptor lengths that exceed the packet. Patch 2 adds
> same-translation-unit KUnit coverage: a well-formed message that must
> still parse and the truncated/oversized message that must now be rejected=
.
>=20
> Reproduced with the KUnit/KASAN test: stock reads past the packet on the
> short message after the benign control passes; patched rejects it and bot=
h
> cases pass.
>=20
> Cc: stable@vger.kernel.org
>=20
> Michael Bommarito (2):
>   HID: hyperv: validate initial device info bounds
>   HID: hyperv: add KUnit coverage for device info bounds
>=20
>  drivers/hid/Kconfig      |  10 +++
>  drivers/hid/hid-hyperv.c | 144 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 144 insertions(+), 10 deletions(-)
>=20
> --
> 2.53.0

