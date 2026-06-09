Received: from mibc-fr-09-outgoing-02.mailinblack.com (mibc-fr-09-outgoing-02.mailinblack.com [137.74.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445103E6DC6
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=137.74.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991987; cv=fail; b=OHF14Kb1HPW0pGjxKizKz8gwJksiszRB89BHPsTCQPp80ZHq2v3ZdAlc7/atejIBtenq+5xfKhGXqx0Xb0hjtxDnEYZkJbR2+HfdOANJDkLy3rYX+aazi6Kv+mRSR0fhF3O8kEbScU1MjmWgVBXtKgveBSTmskhc++A55aMnhV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991987; c=relaxed/simple;
	bh=1zGuw4b4gpy1N0bnKjoxDFnBSaX6NNYGJoCwy1bs2+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyMMewagj58wExkaDKHq3tqh5c3i1SuKM0VeiMNMq4XrrrdTX8wiNqQpjXZQ+JUhPczYjPjTmRyT1+2JSL2QuZfWoFXGJA7rvT5UXADg0LqMFJIxXmBkBBuuOE9815H5fNolvAjD+SXE6guZefBx9yIdPi2LwMoyrs2fogOhRfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leroy-agon.com; spf=pass smtp.mailfrom=leroy-agon.com; dkim=pass (2048-bit key) header.d=leroy-agon.com header.i=@leroy-agon.com header.b=UxqGttYr; arc=fail smtp.client-ip=137.74.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leroy-agon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leroy-agon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leroy-agon.com header.i=@leroy-agon.com header.b="UxqGttYr"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020117.outbound.protection.outlook.com [52.101.167.117])
	by mx-2-mibc-fr-09.mailinblack.com (Postfix) with ESMTPS id 5887E1F4003D;
	Tue, 09 Jun 2026 09:59:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axl6daSQIqkpRlWx8d49dISxKf3NoIWg8x2zOtjXjMVcj5gTreqJG/Xc/EI049rj58lIRnxxXb0lVN5iayVBGkqJYN1lPtcahfAz9Sv3pjBysnf8PHjit0wMdACkbWEE9F8MmKloEKFXRgdsD20MsWOqPygkD8rBDTm+QTufj57w/a/cfc47Ht1wKvGh1cL5XHuSSJY62lKzpstXdSsB0PbqQAX4x7SMBFTOapSoR2D/pfNDa1PQvZu8qjGz8Ct3snIaHYd6WmHWmQB7kTnI+Z37/oi6cd9F7vI8v3nsAIIUPw+XHiCaC35Ne8O6Rg6OhWCxGmEErddejF8+My3Atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zGuw4b4gpy1N0bnKjoxDFnBSaX6NNYGJoCwy1bs2+4=;
 b=KzGS6iMmEpH3bfiK7QtH0nA9Pe9zyDfyDVQG0a90NJfjuS8vbCUBHiLcbBEO4Por5Ib+/Hob/mmuUpVu9w5rpN/L/NXgF0Q54xPTHfqo3ZAUR0910xzi6gyiOdCE3GladLf6Q1rPvecf1KusCUB09FcWmbC9N1MSEcM4vXhd65Ha46brbc2PodOa875XMCzp2q67pKtGhoZxVyNumQMLVcvwJ+2H/tKEyMkR3P+6dwMIzrFTEVSbFiv+7grnehLfa5vKO6e6VufJdjjcKDPnj/Evb1eFqWgVqcmApwry5WTeFO2wGXpm2oDF6wCDJtP4MrN50dG5MpiZheF6QmvtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leroy-agon.com; dmarc=pass action=none
 header.from=leroy-agon.com; dkim=pass header.d=leroy-agon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leroy-agon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zGuw4b4gpy1N0bnKjoxDFnBSaX6NNYGJoCwy1bs2+4=;
 b=UxqGttYrTq0sFPt2FLIZcv9Bxx2GN3cPlCmmFU9ZkpCPOq/YIfHf7X/qETwb7IdFtQX07uxxaSBkKgO00+P36NT6Hry3SpYiTk5osJO6JR1IrrDJEAqn3ivXA2C7xnCIjyhTf5mvFiGEnw9WuVifBjSc/lx24qJXCDvUfqKXdySxPPC9khmoYt2kj/CXqHisF+lsuPSorItdbUTCq66VLzNhuy6hHyjBbi5OQs9sUXl5K7TdkC87gwergpSlduTlQJSosKM+KGH9QX5icJfTDTWqPnUAcMGlmL9n9EH+WvojJDAUA0IuEJbIaZ5D5WNFxebDF5+ob4CsMtODPne0Tg==
Received: from MRZP264MB2681.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1e::10)
 by PR0P264MB2582.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Tue, 9 Jun 2026
 07:59:31 +0000
Received: from MRZP264MB2681.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7076:2b3:9a13:82c4]) by MRZP264MB2681.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7076:2b3:9a13:82c4%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:59:31 +0000
From: =?utf-8?B?Sm/Dq2wgRVNQT05ERQ==?= <joel.esponde@leroy-agon.com>
To: Sasha Levin <sashal@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Robert Marko
	<robert.marko@sartura.hr>, Jakub Kicinski <kuba@kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: Re: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
Thread-Topic: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
Thread-Index:
 AQHc70+Wp1K41CMp+ka10OJNNdD4ubYs+JEAgAErZICAAkLSAIAEUeEAgAC9DoCAAHd3AA==
Date: Tue, 9 Jun 2026 07:59:30 +0000
Message-ID: <b0dd8c38-3d43-4fba-ac89-253ddd6e6855@leroy-agon.com>
References: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com>
 <20260603105137.lan8814-qsgmii@kernel.org>
 <f27cff89-b439-42b4-b29d-2a54e4efd3b6@leroy-agon.com>
 <20260605-stable-reply-0003@kernel.org>
 <e03a6f5d-1f90-44ba-b000-925c43faa9a8@leroy-agon.com>
 <20260608-stable-reply-0009@kernel.org>
In-Reply-To: <20260608-stable-reply-0009@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leroy-agon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2681:EE_|PR0P264MB2582:EE_
x-ms-office365-filtering-correlation-id: cc396b10-eb43-4d1c-2349-08dec5fd0973
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 u2Von3jNUVHHXpgak9p5dmxeIvXtP4lyBmvKEnvf6KFB6ddxgtYIXv7oMrCNboVn5Et+Fja++Liz2K45v53nRGLvMbISE3WaVBIaD4dSvJw97NMecIE1UAqkJNL1wW0IlIzNqbDYaNA3Zp9WM22RsTRYeRaTq3R7PWMXNL5bhuEYe6wsaj8uoDbk2gY9sci+zTGm0lyWZMHuYTzPuwvLZ7oI8vL3gm636jXMAGsu7+A2r2Mijg0UnuuC4nBZUVQbriKb4kjzXQLCZQqvk/qLCvCOAROhTgFtpCoCkd1X3O+9yIL08Y35gA5oHcUPjhdadrej+UB84WhWYlHtK4ZHfNE7CgNB4bFPvftxWtyp5zDFtFKPNpPmeGXdPfj0bC6kYIDaJJMRodMLqWfRE7opx0ZVEeNoymzFKN5KYUWkTI2f69j/uFCXR9HRCY+E/NbbBxC+E2KyxPBfxDh4wpkDGfExoupfM9XWCb7lXPQBqu+kYwWBi61fD+hCJi2CqMEsThwqm3HAtPPEuceGG0cx5Ls+cvNzXOkxNhODBZ9ZYb9oTIwT9Wl8J4MwHdZ8ldJzG9aT8YDpcHMm/S0A2+6PeY7dtXhGpZidqRZX2ePl2hFQXWDtZFNJHD2yjjAwaeKuNB1iDWSKr+7FKR/jhmOOFLXfIrI7HB+0bV/R83P3W6wsMyS9zyY4PubpsNL+7BfWbLt4f7ySrxjHghCW/ber2HzVNDq+BooTG6VWTwIIcKly1mNggGgcOCoagFsxpGOg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:fr;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2681.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUlScFBsOUpLajdMb3NHelBSeUJqR2hOaGFhK3V3eE05SG9aVGZlTm1lU3hR?=
 =?utf-8?B?MnlEQjJwMnlCQ092MEV6Yk5LQThmeTU2bFNqTlppak1ZTXM1MnNxYUo0MlN2?=
 =?utf-8?B?QWxlQVNma1phZGxDcW9LWS81cHFZUkorL2l2TUc4QkhBTGs3aEVlUDQ1bWZ1?=
 =?utf-8?B?dnBLeTFvTWtWeGJDWVpFNExCcGxFTHJyWEpGckcxNHphdi9raTNXVktzRDBK?=
 =?utf-8?B?dUpkSk03cDd0TVFMTk1rS0V6UjMzWDZibVV6UUd1MkhIbXMwREs4a1diOWlL?=
 =?utf-8?B?cEM4UG90Ync2R1pLaEtJam0yTGJ2Tm0vSTdBOEJ1em52dk5EMGZNSGNWN09T?=
 =?utf-8?B?eWo0cEZGSW5SSmxqbWdROHc2ejAzcmgwVXd1dzVsd2VCRmh1dEErRzdPdHpn?=
 =?utf-8?B?dTcrU3BuMEo0Z3J0M29OUFVlNDZFYzdpMGtYWUg1M25udThONHNpajZuU0Ux?=
 =?utf-8?B?Mm9OVnN5Z2pSRXhyUUd1bDlYcEVjQjVLdVowekV1UEx4dE5taXFHL0U1YjNs?=
 =?utf-8?B?RTNOM3lOS0lCTlBubnBRKzNpS09YbktwYmZvU0N5VGdxYUVybUluQW5ua3Fw?=
 =?utf-8?B?NUhjUEcrU0xzWDBUbGluWXpGOUt1ZnFGSVlmR0puMVFnSi9NeE0xU09Fc2xC?=
 =?utf-8?B?L1JDVUJ1VTRQNFBnYW1xUkF4Yng0dzM5d2NZcmVRbnBHb2ZWbVFBRlROT2Mz?=
 =?utf-8?B?RTlrYjFZbEhzNDZFZGJEbnhtWjBLb1ZDOW1mYTQvTEZuVVlOWTJWU2RENTBS?=
 =?utf-8?B?dGdPcklWNHMxWlptKzJXRzZzRGNZU3RaYndpdi9wQ1lsSDEwdEhzSUFXSzdm?=
 =?utf-8?B?WG5lUmNEUkNiVzc5c3dpenJ2REkwZGlmYUp2YUIwYUFzZGI2SjZCZEs2NkJo?=
 =?utf-8?B?OEVxQjVnd0RyVUdubUE5WTlsalVIKzRWZjhxcjFENFdMYlh3bUcrSTlMc09q?=
 =?utf-8?B?Y016N0xMZHU3TkN6OHpIRzRONmxySjR0T0FuVnZYR0Zac3VsYkYzeENQK3BW?=
 =?utf-8?B?U2k5T0dxS0R4VTNENGRVaGR6SllkZkd4N3lubXFGS3hvSkVGSXQ1bG9tMXNU?=
 =?utf-8?B?bTBra2VwcHVLK1ovakxwL2ZqZlJEOFloNGVpVVVBUEJQN2ttbi9rc24yZ3I0?=
 =?utf-8?B?T0lNQmJMK2VyRTNXY2VCbUwzamQ2dHlmM3Z3MERIRnYwR0Uwd0o2S1Y4UTZ5?=
 =?utf-8?B?aCtESUYrZjQ1SXJoY2lUTUpzZVhWNEtqTm5uQ0NBYVY2WFBwSUFkSFVNM0pz?=
 =?utf-8?B?S3VwNm5DU0NrK0J6N1doeGZ5eHVSZ0h2d2RxR0ZYY2lNZVZRMFU4YmlNZXlh?=
 =?utf-8?B?RDNSYUxqeDZJSWhzNjdualR4bDdjblJLRHM1dmxUNmZ6bVhMTitUSUJQYnRR?=
 =?utf-8?B?Rzg3S0pYUmdHRG9XN3lPdEFVaS9rRFdYcDNNeklmR3pCQ0NmSldLbFk4c2Q0?=
 =?utf-8?B?MFJjZThxUWtuRzE3SGlsVy9OQXpMUFZuZ3FXaVZHTThLdlBvUFNRMGg5UDkr?=
 =?utf-8?B?RHVwNnAyZlc2UTk5S0ExdlhHZWVabG1lb0pQeFdUVEtJb3kyMGFpYjRXZ256?=
 =?utf-8?B?ek51MXZpNzRIdHhuOGRvYklENlRFa1RtMXVsYUNwbk1DQ2N0alM1djNCTWVK?=
 =?utf-8?B?b0taV01CT0tlaDk4NWczVUFsS256NVNMbURiL1FTRGhleTY2MDkrWVVsTEda?=
 =?utf-8?B?RGtiOUNVbHdOS0NWTWFNYWpQaWtxS0RMOU8rd0F3UnAyWVZNOFhhREwyazlv?=
 =?utf-8?B?L01wMGJPS0RuVUtxZ2JEdzZhS2Ftbmp2K21FaGc2TCtMRlBMUU5TMFlib1pK?=
 =?utf-8?B?Q1RNNFY1Rks1NXNNajl6RnJDbEtickF5TFNReDRHTk5XRXVFZlU3aThPeGh4?=
 =?utf-8?B?emVqMHdKZHRFQ09Mb240eUw1cXdLN2kra28yN0NJM0MrZk9rV00vSGd6WEpl?=
 =?utf-8?B?RlJnUVVmNnBpWFNRZ3dmWkg1MzdtV2J4VFpuWXhDNEp5b0ZucDN0aWNnbSsz?=
 =?utf-8?B?MmtIcEJKdDFpMEZRUUppWXg3UytJOENBSHBjd2ROYis4NlpSVThmbzhaM1Jj?=
 =?utf-8?B?QWJMd2xoMHZrTDJzUmpPcHU3MGdBRTc0ZFVUdk96eFI1Rys1S2wyT2J2NHpk?=
 =?utf-8?B?L2JqTlVsUEdyd01pbzY0aXo0RlY0TlhhdjBhQy9IajEzMDRSU0s2dXVtdTRT?=
 =?utf-8?B?VnBSRmpldU9PVU5rVUNZVmd2VjJkSTlJeGl0OXRnbTNkQ2VxY3ZSNWVKUng3?=
 =?utf-8?B?ZU8yOWtuT2hFQks5RFlRNzJDNllRcXA5cmFPbW9GWm9RRGhEOTgvdUZKMlBD?=
 =?utf-8?B?VVRpL1o5dm9sbUhhNDB5SzVJOEpkd2ZwK2YyQVUxM0NUb3A2clA2S1cwWXNL?=
 =?utf-8?Q?S4hG7WVxM4558xRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <475AF73152E23645992308950EEE4A36@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eZRrKxabZdLOL9cj3abwbZ3GgbJvhEx4FNewng0rM6LQIst6eyuk8C36MxNLYkYO3/Ldalw4477ezhHdVdsndWMtxR2qa2WGPudLyuXQyXWi60YB0or1GLMVjkTB/Mjow3BYPDngPRnI8lwqywkadjSHoRGSxcPlTuN2r8PWifEH27RWjYab9OMCgRi4gbOuCZNJtRC3D15vDnfbB4GyBpUSY48JmCpbsoqJ7sxlPkdpQNOjx4OY+4d6BJfV2iNml94SMH1nMlNQaJOBb/Ze2SCe3UCgCgN5A60i/Hlb6JNnCNpTuc4p/GdzVOzX4ptwm4Ex5EBMuwbOQ5obISr5Gw==
X-OriginatorOrg: leroy-agon.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2681.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cc396b10-eb43-4d1c-2349-08dec5fd0973
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 07:59:30.8279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b97cad2-240b-425a-b0cb-987a43def8d0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjyhG7mKrpB/S+6RibW8Jz0INUK70UibRZT8TnSVj2bAvSLWLLtR3fgI+6PiUikPQMzm/Aj2sTdZAL2qPfsD+PRFEFDpzMPuH67VNMi03/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2582

PiBBdmVydGlzc2VtZW50IGRlIFPDqWN1cml0w6k6IE5lIGNsaXF1ZXogcGFzIHN1ciBsZXMgbGll
bnMgb3UgbidvdXZyZXogcGFzIGxlcyBwacOoY2VzIGpvaW50ZXMgc2kgdm91cyBuZSBjb25uYWlz
c2V6IHBhcyBsJ2V4cMOpZGl0ZXVyLg0KPg0KPj4gUmU6IFtQQVRDSCA2LjEyLnldIG5ldDogcGh5
OiBtaWNyZWw6IGZpeCBMQU44ODE0IFFTR01JSSBzb2Z0IHJlc2V0DQo+IFF1ZXVlZCBmb3IgNi4x
MiwgdGhhbmtzLg0KDQpUaGFua3MgZm9yIHRha2luZyBpbiBhY2NvdW50IHRoZSBwYXRjaCENCg0K
QmVzdCByZWdhcmRzLA0KDQpKb8OrbA0KQ2UgbWVzc2FnZSDDqWxlY3Ryb25pcXVlIGV0IHNlcyBw
acOoY2VzIGpvaW50ZXMgc29udCBjb25maWRlbnRpZWxzLiBJbHMgc29udCBkZXN0aW7DqXMgZXhj
bHVzaXZlbWVudCDDoCBsYSBwZXJzb25uZSBvdSDDoCBsJ2VudGl0w6kgw6AgcXVpIGlscyBzb250
IGFkcmVzc8Opcy4NClNpIHZvdXMgYXZleiByZcOndSBjZSBtZXNzYWdlIHBhciBlcnJldXIsIHZl
dWlsbGV6IGVuIGluZm9ybWVyIGltbcOpZGlhdGVtZW50IGwnZXhww6lkaXRldXIgZXQgbGUgc3Vw
cHJpbWVyIGRlIHZvdHJlIHN5c3TDqG1lLg0KVG91dGUgZGl2dWxnYXRpb24sIGRpc3RyaWJ1dGlv
biBvdSBjb3BpZSBub24gYXV0b3Jpc8OpZSBkZSBjZSBtZXNzYWdlIG91IGRlIHNvbiBjb250ZW51
IGVzdCBpbnRlcmRpdGUuDQpMJ2VudHJlcHJpc2UgZMOpY2xpbmUgdG91dGUgcmVzcG9uc2FiaWxp
dMOpIGVuIGNhcyBkZSB0cmFuc21pc3Npb24gZGUgdmlydXMgb3UgZGUgdG91dGUgYXV0cmUgY29u
dGFtaW5hdGlvbiBsacOpZSDDoCBjZXQgZW1haWwuDQo=

