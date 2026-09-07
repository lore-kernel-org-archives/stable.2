Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D550AC0C;
	Mon,  7 Sep 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795291; cv=fail; b=GDEwExMfc+htdeQwtyAJiNfFGxW8jC4njXMA2kf2AJzr8l5Qdoh9sfPi2MdchUdogA8GqMfEhlt7zlJIZv83skvYrAL0aOvg2qpIQPqvJxdLqanA02aR7GRf9rKtNMNtxtdtUhtYH+gw6bK7vzyOGn3e2uQmTkDT/cRTXu2xJj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795291; c=relaxed/simple;
	bh=NKshpJR/nXNg2pEJ4Tdo8mF1hAH/tQOQoQV4IcUC1xQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jWbv6BbFoE15tA7AcCwxSDl+mO5FFEVtbLLeGn1nXPvwCB2CorUWVKqc3XS3mfR/VFvLZU70Q1OrkjM/o8HpLLLIS/8ryWXk9+auNwh/Ni4gSrqgnHRjLemdPsB6OpxDKK6baQ86nrGrvdOdHuLzQ4qyxsc7yQbiMOZ7yHzjZP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=AsyOo8M4; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="AsyOo8M4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7unWIplOZS/9MW8jb4sFL1OFVmvdgSIh88LzwEZU2trtp2V54EWVnWWRq/+WBFjxoy25nBRWlExY3NHDN4geirlWP9aDo5AqjT+qF1JRrD9yho3L/HE7shuWuQZ3jh+sJ9ye+rwHcjaopWC1vtvbXvx8iHjXW3gQpe2VeUG8FYYxoaj/IT6UTDuNu7Mn4BGI5MYdpeKurwDMKwGB2Nyowfionk/oEGhGHaRo56xgsgw4zWNPNCuBFu881aaCSV2f68dFSTpvlrw6tPyr+Sy99KVpqeMc1ITkUfh2JlSB6gcmyyBM6gjHs1TFHg9jSCU+Zzg5L20/k44oLmMswNQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKshpJR/nXNg2pEJ4Tdo8mF1hAH/tQOQoQV4IcUC1xQ=;
 b=frOc7yNvtG1zyg5N7iZVvRyGuLb8TWf3vjcUaaS7EKwn8ASIIM9VbixF2BeUUg+4TCCUBg7yJynDKnWeAcftzLyPesmuej5WELtSdR//qnNQ9WsbIS6NxFFVIOsX/RWxgmhz8nga5fmluXHtkuXAt4/ztTEvObyQ7dN5voZ9PbFgzcuXqNZgXeE3rxl5/9DKtjmbpNf+VjXJ4TtJV5g7NwloJC/GBMOPhx/lLWtj9Aee3zIOmBLkCT9FqZ7arZOMeRw70+XpWWDMmTNPVPTDCyZP3XGDy0pRxDDPbD+89rG+1s2c0syv4FXSReN898TSmzCfxiYIWDHLGWClC+biOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKshpJR/nXNg2pEJ4Tdo8mF1hAH/tQOQoQV4IcUC1xQ=;
 b=AsyOo8M4eGBjqWv+dPzw6zEogkCGX++TucNRo71PwFMhAhEqEiV0NH+gXBBaoO0Ztbv4G5FkoHrmmhkf6DHAy7bsgln7r0AIr8yCG4jEGKuLiB2z7al6oaewGi+MOQdRTVRAItomxEqZ9AIKuVixIvvHQq0vlvf4wRsvxsFgMVTAF6S0CVxUvUTyjxLuSexr4RFJ2a9MR5EJTeK5DBTXiegGyZpVIXmp5zL0/u4JdtdYxfwOQklAxtowKlTBWmLFgm3dnFWP+V6+qHBfLcxBVN4tqJ2bqVDIHmLn0TFL2s1stLi9CVQljjjNnPFei2rFSUurRCtA5yc1Ybw+M5Gu8A==
Received: from GVXPR07MB12099.eurprd07.prod.outlook.com
 (2603:10a6:150:2c5::13) by AS8PR07MB8314.eurprd07.prod.outlook.com
 (2603:10a6:20b:37d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 15:34:45 +0000
Received: from GVXPR07MB12099.eurprd07.prod.outlook.com
 ([fe80::f0e5:e65d:145:fd0f]) by GVXPR07MB12099.eurprd07.prod.outlook.com
 ([fe80::f0e5:e65d:145:fd0f%5]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 15:34:45 +0000
From: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
To: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>,
	"syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com"
	<syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com>, Kuniyuki Iwashima
	<kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>, Florian Fainelli
	<florian.fainelli@broadcom.com>, "David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "Atul Joshi (Nokia)"
	<atul.joshi@nokia.com>
Subject: Re: [PATCH stable 6.12 v2] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Thread-Topic: [PATCH stable 6.12 v2] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Thread-Index: AQHdPJwfkdwn80RKEEOmmv2uuDBtMbbBj1SAgAG0QwA=
Date: Mon, 7 Sep 2026 15:34:45 +0000
Message-ID: <22b7bae35253cebe11b515d11b245d7c551c0f29.camel@nokia.com>
References: <20260904183500.3841094-4-florian.fainelli@broadcom.com>
	 <2026-09-05-daily-reply-0047-tcp-syn-recv-race-v2-6-12@kernel.org>
In-Reply-To:
 <2026-09-05-daily-reply-0047-tcp-syn-recv-race-v2-6-12@kernel.org>
Accept-Language: en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR07MB12099:EE_|AS8PR07MB8314:EE_
x-ms-office365-filtering-correlation-id: 86d8f0c1-a1b7-48d6-fd12-08df0cf58b22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|38070700021|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 ve2kXonRM7OGEjKzO7PDQr2wEOciVtBtV11whHP8wWU6cKZcCilSxtYi1IbCQDFsoi95UKLoG7tq4x1NcuMbla/9FNpcHfxjta2Z3H2NV+HBa6kBk6ocFqtuU5d1ejjoaTBXOU0VhdePxNtGIKO0orD+FpsEbZoAYfHpqGYpjrNv8OpWDIvdOyggKa7RlZqBVNsHL6O0XysabaEOYFF+UFoYa+GrOG5VixyP7/BgmShAWZhVkscBdbLuACblh57+5fMO7Y0N+GtEfIEeB6xLurpL9XJglscgPRkkbSPRSKT50ExxsAHirkmgczUow4w/B+XTA6MlStCTBBWDvslSYxZGKzMhSDdupLb1T9BDU2LVJG8VCrdenGWdEQgivhSiRtM1T1xQT47jeGsXv26zbuF81eBzJjWmREPkR2GeD6UkkbTRrRTyNBcDjdYuFVJPQ28Yp/Trsq3BlLwQaj0e7S5AcM/OBuwTA8PsL3v2vw7fUG2c3LhoB8U5mO0jRrI30MYw0cuBx1AB9skj30n9RnCjhY5QiN45yb1zOT1pZAqBQ4D7hR/z3wPNKk2XoBq37tp8mfEEZZgUoZ97Ru6wat+rGniJ7Dl2SjeMetUy75TEqeVhqLce/aVTHpYIy98obrR6KdchiUfp8mj1EEZd76led5uj3Ekm+872YcPUK/p+e47a561vXvrfNbsrZUevo7qZwAvbGZALUxz/k7q0ew==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR07MB12099.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWVleG9mcG50TFd5Q0VtaElRY0VudnRWQzY3eFJrTEpUakdXOHkxUE1QUXpa?=
 =?utf-8?B?OFBJUFMzeU1ZME1ZMmxvdXNBbUd1SGxBVnpZdXI4RWc1cjRGQkZVTW9wNmww?=
 =?utf-8?B?WkZkNSswZCtpZzBiMzg5cTZyVGVHY3p2MEpGTnNEUmEzZmdKcUNIeDcxc2Fz?=
 =?utf-8?B?OUV6MWR6VHdTK242c2h4aERlanRZd0dhZ29JNU1BdVlhQTE0anh3Q2gyeXVC?=
 =?utf-8?B?TWlSaGNDV1lMdjV5N0xmd3BUQWtaT3R1dE44bHlyNzZUZzF3d2lkYjJ3Vitj?=
 =?utf-8?B?ZG9RbktlYTU0QTk2aDlyWWJKWGxZd3lRTTBaNFJqK3NMWEw3WWlJNW1YMm5n?=
 =?utf-8?B?eG5Jc2NjdTNZblZ6UzROY2c0eUZCckVERmhtQU5iRTFySmxtQkx6OEhSbkpM?=
 =?utf-8?B?aGw2ZS9PRVJLTDVJa21OR09sWXZDdkQ1eGF5dGN2dXBYZEg1ZElhdEhlN2Qz?=
 =?utf-8?B?NDRkYm94WXdaNHhhQ3VOWE4vbXphejFxYWdlRjV0d0pQZFd2NnZjN1hqT0VN?=
 =?utf-8?B?OVVSUjl5Ym5tK2hCdG9mejRvdXJiR0dIZUhzQjRCN3E1MjFlNEI1Qlc3S0Z3?=
 =?utf-8?B?bWxMVFFObFVjZ1p3VlViSXBVeDJ4RkRHTHZMeWgxcEk5UzJsN1B0U1ppQ3Z2?=
 =?utf-8?B?OWJxYk5jWUJpdk55WHpLRzRaQ3ZWRWhwdHNzeXAzYVM2b003Vi9KdlJJWTln?=
 =?utf-8?B?d2VraXB6dVdseExLcDlyVW8wUTlRVzk4dFdEU1UybXN3ak41aUdnTFRLKzR3?=
 =?utf-8?B?VjNEdE0rQUV2Q2JyQUxnQnVSSmFwVGdIWnNoTkVlcElweTlnWHRFdWxYOHhT?=
 =?utf-8?B?VlhsTjFDc1F1OVNkUHQwUnl6SkJEZDJjaEszTGFWWkwvTDNVS0t6VFByY215?=
 =?utf-8?B?MnFlVDhLVGtSZldzODdCQ1R6T2ZreGxjZndCb0xVTWxXQ1BEYmFyV2pnd2V2?=
 =?utf-8?B?UkQ3bXJyanVRSm5oMnZLUWpSZ2FhYjMydjdWbWx1UHZBMy9scTcxTnNaSVY3?=
 =?utf-8?B?L3dyN0dwdkhzajBnemU2OE9PM013R2VwWXVaUkgzV1VoeHRlZDNaYWE1MU1Y?=
 =?utf-8?B?MG9odWlVVWVPb000MDNhd1NWbUNIWkhudUFXSGNYZlp2V00yMVZ6V1dlWGRj?=
 =?utf-8?B?dHAyQVUyMGJKM3IvMWl2d1NPZFNuRnkrZDdyaTdUNzFaS1A1eG5OTGp0SDFG?=
 =?utf-8?B?L1VrQmw3Q0dLbk9ETEprRVA0ajJNbndZTDB3aXFpMG1hU3FsN1c2Rm5nY1lz?=
 =?utf-8?B?eUVtRnZtVGZ1QTIzV0txSDkrc2ZsbkZuOFBCNnBEdGhrT3hPS21qYWxKSmtS?=
 =?utf-8?B?T3QweGtBRjQwdTFMc08vTFpXcGdzcW5seVBJU3lhRzMvSjNaazRPazFBSUZJ?=
 =?utf-8?B?M2VUamRic0lGanYzUUtURDNvNEhxeGJ1TllIOG9lK2xGTlBDR1NpcFJ4T2Y0?=
 =?utf-8?B?Y010NHNMSUx3STZuMFVYNTNpMm1obFBVYWpPVmFFRE5RWXpyZDB6OUxoOTJ0?=
 =?utf-8?B?UHNLZmlOZzhjSXZTS0IrbFRQTEx3b3o2VWpybFBqYk5mU3A3RTZRYWs1ZDJ6?=
 =?utf-8?B?WlBVTnltaEFtbWZFem9nMzlBOWFYSHBHV1RDbHZOZWZNM3l3MDIrTnFCNTds?=
 =?utf-8?B?VzdhQWhzTGEzcmlxcFRrZTdGVm1mYkhaYkJWMldkaHBucmtwL241UE84ZWFN?=
 =?utf-8?B?NXFwVlZCSmxaRXMrZ0ZJSDJWZlBhMjR3eVh1TkJ4SjFPNXNTL25tTU9Vd1Fm?=
 =?utf-8?B?L3BUVXkrRjY4dCtteFlscEZoL1ZzUUUzNjBoS01sb20zVGs4ajFPc1hYR1U4?=
 =?utf-8?B?TFpRTmVRSUlFTzRScXNzbFFpcDVjK1BYdUpRQ1A0TmN6bm9iNjlpZVRGUURv?=
 =?utf-8?B?RWFXakZqWWZOeWtCYkdYcXhqWERXZFFZTTJYa0wwaUNVZFhNNWRyaVJkZG00?=
 =?utf-8?B?bENGRmNGRnliNEN1WGYrRGFaR1ZZeWxBLzV4RE56STZxRW5LSE9iYTJiY0Uw?=
 =?utf-8?B?QXBKRW5zVFBKcG95U3pqdmdDdy93NERCOWUwL2dFOFN6TDlqazBEZ1ZCanov?=
 =?utf-8?B?WGNyLzZ6RHFSZTJDaVhNdW5qZnV2YjY1c1kzbG1CQ2t6YVFDazVOSmVmNUxP?=
 =?utf-8?B?ZTROMW81NWRqRWVzU01tSUJXelQrblpKcklXbmQyOE8yQTdFRDVkRTBNQTh6?=
 =?utf-8?B?d21ZK3pvc09kR1ZzMHhMOGViNkRoRU9KQ1VWRHFxU2lBTTZoSzZBeUpKR28z?=
 =?utf-8?B?KzFRU0N4Y2FIN2NRM0IrZTdWWStMTEcxVURIbDdmUTNYNDRnVlVsbk96T1pw?=
 =?utf-8?B?NkFxM1lGOTlqNkRBSjJlc1NrV2MwanNtWWx3MGx1SEhTbnJhRTdIdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DB1EFC9014B4C4EA1FF3420DFE50A3F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	j+87BOoRU6jRSjzM2JpCgbrtyEuDHDLAmgppFD1S+88aJXWYux/mBaWl9Vpyz3N7Vw3B2hOGbFfkRhKyHMGZb9RtMnrF3lgIyvU+PnDMRULeSPJr9CewmDSEROFf9q37BNp/Or5B0VzMg3Ync2RtzbZH09AfSGFl+yNM6geESYvxFErgKse/Ruq5qtDZhERODdfjbfcO063ddlJ+GNvvFIXxzFHkTHqKbTw+U5QBEu8XSeun7vkao6Sp588H78KBrHrCRK2B/QwM0AvaQ+qQ4d95I4gU4vD/A/0VnFDRJTS7ZwtXFtItKpzz2eBpgESdqF15MIi4st/T/QZcSIe54A==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR07MB12099.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d8f0c1-a1b7-48d6-fd12-08df0cf58b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 15:34:45.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqx/9I5LQAj4tSbSQ7mL0Y+EGU/xYoFaG/KEjK1NrDn0YCWzgTmj49CZwNkGCHkcQlFL7WzV9foB0//mriPxm26STm7r9/T0teCyVi10wkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8314

T24gU3VuLCAyMDI2LTA5LTA2IGF0IDA5OjMzIC0wNDAwLCBTYXNoYSBMZXZpbiB3cm90ZToKPiAK
PiAKPiA+IFRoaXMgZml4ZXMgQ1ZFLTIwMjYtNDMxOTggKHYyIC0tIHYxIGJyb2tlIHRoZSBEQ0NQ
IGJ1aWxkIGJ5IG5vdCB1cGRhdGluZwo+ID4gZXZlcnkgaWNza19hZl9vcHMuc3luX3JlY3Zfc29j
ayBpbXBsZW1lbnRlciBmb3IgdGhlIG5ldyBhcmd1bWVudCkuCj4gCj4gUXVldWVkIGZvciA2LjEy
LCB0aGFua3MuCj4gCj4gLS0KPiBUaGFua3MsCj4gU2FzaGEKCkhpCgpJIGRvIG5vdCBzZWUgdGhp
cyBvbmUgaW4gdGhlIGp1c3QgcmVsZWFzZWQgNi4xMi4xMDksIG1heWJlIEkgYW0gYmxpbmQ/Cgog
Sm9ha2ltCg==
