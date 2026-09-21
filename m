Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57033244667;
	Mon, 21 Sep 2026 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959353; cv=fail; b=EV7JKkSRvGHGQJIVe1NfHSZr36L9amHxVqdoulI8FXkURjQDloxgxzdU0p9eUGdxbd1Kh52slAIrJq7S1J+R+CoTz1u8/8ON+5VF9D0nUNG3UTYD3U/h5xmX/jN3TvpDW+LhfLU/alMlITWmMjTKEIgm34+/ZAQ6L4Da4Sj5eeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959353; c=relaxed/simple;
	bh=9dvlsjhw4gSO6nYFr/4LjdhUldSzT1TiLMde/NNXu7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mRoE8wwJcLz2UgX/ELvbAuyLjvz/aMPLFBHz5ldE9ZoRB7uCJaN3P9io7S5E8Y+gTTsodDYtOQDvpRrheBi0V6OE4flWMYEAmVHbW5FU/c2t+G6T7YbDBoJ6hgKV9BFWXhi5uIUY+LO8yMCsgnPeqLEklBHsjT6q9REZYL9+X+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=AJYkLheI; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="AJYkLheI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjkSohaCsR2LI5ffIu9YHVd2iSv2Ll+hv5Nub25ADGXOpaSxTCBKMrZxJTGk+sPOOY6Sbraja1ZEKztIRareSoiWhjszYh0o0KXCgcU1RWEcO+zPFI3bUGOqUBCdCGhLbfEqIR6mG8HJt4D095Pm6bR87VT0OXrI2Mr6T4lZcZFABLEWbDHqdepba597v+ctPO9AB6oJf+ioPAUv7j5cKQQj30kEuzJcfl9wsWsqDM7VdAsT6X4u5FPBH/7lM3PR4TxzvR5JK8XcDxspkk5BodsRiXl+ZNUIE4rT/OsWbpOcFHrGQ5U9Ph8cMz0hIZkPVNIcVlTmbJqH0Mbliz8iHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dvlsjhw4gSO6nYFr/4LjdhUldSzT1TiLMde/NNXu7Y=;
 b=G4t2ij10kh8xehHnpRfYbRhgunlghFB3qUiT2PDfTXqN6PCKdPo+mF3NeRVqoakoV8vsxp7wCx+lONluuXNw5jVC1NkVbAMSuzTFyviw2fJF2V/KpMsSEYULs2NXnvu3DjLHeP8ZLSDW6EsL7vuTJKBXtgP5q9s2LC9TISg/ic1Jt9FYEF5h0PIXZ3RJlAfDYN2ZiZxDoDfnldTw74MFP+LJ+992Evcjg44RsnQ6KO44hKlPwFPD9bYQ4VlDxu/1CN/HHapQh6B3yIEkih48e9x8h5E2uQywiRIvt4v8MRhXgkXFjNzYyLNcINN7FkqNUwlgmUCX9ESj4mz5k6DEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dvlsjhw4gSO6nYFr/4LjdhUldSzT1TiLMde/NNXu7Y=;
 b=AJYkLheI9A1PIvUMZzd6WU0NQl4g2Q8MjuY6aZYWiYWSYoTOqcEVGDA1Fa4a52nHYeunZKyTe7hGxtRH/CSSFZyGOGozJxXmQA6z8QJcmSkyxVdUEJ40t5XHXv6hrVMQYnb3bmgHF91q5+7W4CkiX05HC7ZWAGXXo0w60gFKhHmxE+AHSLjLFFmrsT7j02sL0ekyL2UzRb46mpKpKf+eFLvW422Xk3OKQN3yGZRoqnIIhkL0lmceO7RTCfop4hbdYeK5dnjCfrR6XVf8RxCgEjwJHp3KV0LHlLg2HrAwWahWFwplS1kbaVAN5PlXZIFL+GAgzFHxtwaCLjt+m6PBew==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by VI0P189MB3236.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 02:55:47 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 02:55:47 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Yuqi Xu <xuyuqiabc@gmail.com>
CC: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@google.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Vega
	<vega@nebusec.ai>, Ren Wei <enjou1224z@gmail.com>
Subject: RE: [PATCH net 1/2] tipc: stop the listener before draining
 connections
Thread-Topic: [PATCH net 1/2] tipc: stop the listener before draining
 connections
Thread-Index: AQHdR08cndSAUeuhKUu8z3zFs+GD1rbYV5Aw
Date: Mon, 21 Sep 2026 02:55:47 +0000
Message-ID:
 <DU4P189MB37501C3EC7A972C4F2C4CC82C6842@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <cover.1789722780.git.xuyuqiabc@gmail.com>
 <48f16f41da6ece5aa646c28617031d00a126411d.1789722780.git.xuyuqiabc@gmail.com>
In-Reply-To:
 <48f16f41da6ece5aa646c28617031d00a126411d.1789722780.git.xuyuqiabc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|VI0P189MB3236:EE_
x-ms-office365-filtering-correlation-id: f82986e8-d49e-4316-2c7a-08df178bd666
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 v8P8nAmmMimwUnx4EoSmqyBYVopG9Vg8KGyNClkZVhZ3xG+XXXeG3v30/axKQqFcFLEvLEFl9WsLCbLSzUqeVISuBK++/DcAolym+Nkj7zWRVI9VZcUgL3/KRFkVdZqtRWyQLbC6QZ0td3cj4KQKGI6t023KXYkmlEgn2T4IEAr2yvjjDB9uQU8riGUE5M3T3GOAC1AOY8zi3BFgBtvYnf6CFso3ny6WO3n4aC5Papi4L+5DFdlvjVn7d0p9h6JvMTDmKBiKJmEmC+lSXtPrSj36dtZMW9nL7xstjfRJ+rhQeDVDJYkbDFv4aV3DU/6v4xfLzDA+4DD+2apTwckAg15GiM+T0LIdetYGrX10IPVUF77B4hhGyJKpvaiUZHbtfSFcJN0x4dZRFlUOlhozTz9yJXuofzzE8REInI2rsgL48kQ8q+XeofBO3Dqr3AcwouTE5DQhdMXGQFuWn21OPj+pykvNrwRQbQm+fe+CausTHD6G+l9derLRviWGTfAT73FeR6VYBz10KwmMkfC4iWqYW2jA4RvpuUT7Bx/tz84mSRWt//zwIngnqgTKb3VyWVRLFbwAIN+JxCugCIAh3iBAwM6UWAjjWZCdUvCyrikJ6zBeYgGp3MyTsK7p7IjLe8+1I5w/nsmw7r5sOOLBPYpaGxotwUzElC6Omlnpy/ktGWZ+A9E+J2ghvijVcC3hfJ5GVLzJs9NYfbPzeML4WgUVmOL7uRmyTcXnDVDH+1M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6Vl7L3KE8/szLQNQ9ZlYc8OIwQGcfZoyQjuAkRPG6rZrAiM6NdA6+QyfQgpI?=
 =?us-ascii?Q?/iGh4RuH3JjwXXbsyhpWPg0OrBtD0JB7HhKi4D2Alf5VOIjzR3GUjIFjmOYz?=
 =?us-ascii?Q?DGImf1miUy7jAZred0K7zWj3bFMC1nxT8gOI7VUiz58vpTr4kVcyZgRsw4Mf?=
 =?us-ascii?Q?eFQ9zzeYiOLGxxqW+J+G27ACpzb11w/7bDH6j7nHHI/+RaE86OkDjUT5+FBe?=
 =?us-ascii?Q?MxyYpF6nv/nrRydXNhfZfu+hwhygiCKoQlqqCZfQhWAGogqqRPsWI+g1La5L?=
 =?us-ascii?Q?64f8M3ZDIVTlp8XTv8YP/FbFiBXnQaazRB6rR/vzSfCB5sgJZcO6y9FvoCfo?=
 =?us-ascii?Q?8WaBBI+F9ELWfyMhIRVDmG3gtltGRcF733IvmRJipF6gjhGwlMtUKssin/yr?=
 =?us-ascii?Q?+jIpRkjc57Hv+NAW9dQWSrMFLSCKriQaK1c3uGWb6+ScKVPdtID7en1A1UX3?=
 =?us-ascii?Q?HgVkujVCRLMfv9di7oNtP2jbvDMQshrl08f4hui7XsutoipoQ3/b7ocjmNrq?=
 =?us-ascii?Q?rmyYpnZ5/xY6eszmY/toV9haMrBtK0YQrEArCfLEWzufn9pzlt2vK98sgjby?=
 =?us-ascii?Q?pU6WM9pKqn4zBBtxXKzUtyVvCYpGKrGBSaS+mHpkXWW1HVuBHyD04MHV7kLs?=
 =?us-ascii?Q?XR7DPO9nVXq3MmggHK1mk/AJDAX11Ycnn1RQLBQV3FBcez9Bo3lv0zppDlpY?=
 =?us-ascii?Q?xG63lDSpMoAHhrrtWhWc7XXhVyqkSulqIBcSzUwCZD18PkpkvHg0t+t0dB64?=
 =?us-ascii?Q?MXae1PogshWuJ0CafCCwG6TmFVsH55m0qrYPiJWpv5OcyI0AJjL/qrKVD0P2?=
 =?us-ascii?Q?17yoVfjjaU/Pq56rH2Rdl1IM0YOiuX38PlonXZZtfRzEteZ8846x8boOM3ks?=
 =?us-ascii?Q?l3fDCdim+Q8JVrHPJdAs2SNBkaPu+VMmvowouttOrIVz5kgvwwzkeg0+ZNGW?=
 =?us-ascii?Q?wHSFZnNP9DgJyx6B3tXR8aZ5RYZ3teDTOZp0I5KdSEeyfdSgBeBTMu1SAHaR?=
 =?us-ascii?Q?gjkBz7EugL8xHOkXqUWYK8diiVOdTBBvE5AfjcK4Ib4qceeO/4Pz237U9PPh?=
 =?us-ascii?Q?72SqgFU64Oxf18C/uqOgvnCswsvE8jUvxBAMjBRENrX5tKtgDbe+09IThV32?=
 =?us-ascii?Q?HOOj4/QoLLFSi3BSFEsMJ5tSY7HGaYF/Hx9xXTdUwEhmARBXQ1s5LMD+ZldW?=
 =?us-ascii?Q?vFf/ry2KKJq9Yo0iTGhUgvPrvmwDRc8J1LbM0h4eWRPsDG1jyymOS89hQDbw?=
 =?us-ascii?Q?Xj5VI5UZT+4b3yDb5APGME75F95FzgaDycV6M5Yzghs4e3LjJYCGNjeK/lCt?=
 =?us-ascii?Q?uQdx64TI/O7MgIUVKIGH6xf/SMkWdWGe8FOQ22XoKrSgR9tn9jJrscIxCKFS?=
 =?us-ascii?Q?pkhGqybO6zlVolzyKlMhXfAPeSxsJqjT6D5pg9xicsiRH2FG2NE76g6LIe+1?=
 =?us-ascii?Q?igubTy/qGJZyCr9nRiEl2A/ou24PtwPLdiiYpjuyI5b+Ml9Sun5U8qjW4076?=
 =?us-ascii?Q?OHnO5rWX0cV3p91sg7B6suHNpt3luKUdk+guvENsAHeRpcpVqmKkl1eqA1Vf?=
 =?us-ascii?Q?qQa+87tJfdd38DMEYqo+2VUu/iJ8kr7BsotwwNNRr2DoiWDOS8nmBCtXnnTX?=
 =?us-ascii?Q?DUpcI/FVJgl7vwj1GtK6yupat/VCC0skbNnN9dEwJU/ANani1juQgELtpYd5?=
 =?us-ascii?Q?oLQatvW+xiEMWm7mT+9g1Pln1A1mdbqn0S2QMZES4An766BeATGUNjdou/+h?=
 =?us-ascii?Q?rV4Fy+gYQA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f82986e8-d49e-4316-2c7a-08df178bd666
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 02:55:47.4686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMXwd0b3nG9OzdiB+eT4MdxNzOGyDsxtaeQaOZ1LDXi/T0McGNZGX5sjMzhhWbPItkQxJK1ISbmIKdCIB15E+6k9X0DkBQduB/bw93rzYJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB3236

>Subject: [PATCH net 1/2] tipc: stop the listener before draining connectio=
ns
>
>tipc_topsrv_stop() destroyed the receive workqueue while the listener sock=
et
>still had its data-ready callback and sk_user_data installed.
>An incoming connection request could then queue srv->awork on the freed
>workqueue from tipc_topsrv_listener_data_ready().

It is not clear what kernel stack trace is observed when the issue hits aft=
er reading the cover letter.
Can you add the stack trace and command (./proc with concrete arguments) to=
 trigger this issue to the changelog ?
