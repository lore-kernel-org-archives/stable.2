Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B493B14AD;
	Fri,  4 Sep 2026 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491721; cv=fail; b=bErumLvsYbGUWjG7aUZ+pZkwLPitGTOzfO3id+RmeBtK+tbLXALP544ZfXg178od7d6q5GvEQL9yj5uEnNksWYRTe+8Jm+ZSwASky7qmpv9x0EEryF1H14E5luYR6zY6bSR3unOhESNH2hM9rTIXzkg95Vz1DHUm8Gq0O+pYshA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491721; c=relaxed/simple;
	bh=o2DDI9oh6iQ6k/zUUAcCExjMOE9PkaVK+aLibJQ+7tQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oSUXpuuG48EtW/V0Dh8M60DsqLdrBM+uv23sV4ieYKsRdReXo1TcO5F0tzXA+xDK/vS4p0aOHHJWFhKdO39Cm4Gv/VA4iH4GexS4sIth/I05yNi2DnPcCVGo+j2l77bVq2H0T+XlkICFwX+LxjLDDNYacMO7lc+70Rd1R6DjZ4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q6Q7+zzU; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q6Q7+zzU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHsNJ9/xNx+3H/Q6n53jV1ZAXWkVY8GN21U5KBeVvIlbVS6u+cPX8xqDgcn1SAvkH8ik+IB6mn97leVf/NTKCXK2xKTEAyi9W/z2Y5kHWW7uIotqcBzQV4U4XMT1Sz8H43V+gdH1rRLCngA73EtOuROhzeggYA2YsilYwfEg2zut8Qhvse6c8EygIXAhCVr4IFJr+JHQ1qOnyDumzCRlzXn3f5KGKuetJq67eC+UM4sNZ2nQI57LDocudY1CKRZi8qQXwx6+dobv1mkSZCr/Y+pqnSJWLf0bqJdqQ1Ql3Npur5UNLs4tYwMTLVECKrvWCYIxAWMyNo7qIUiYWFXTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2DDI9oh6iQ6k/zUUAcCExjMOE9PkaVK+aLibJQ+7tQ=;
 b=uSpwVUB+s5YdUIjmo7NQ3QjwxYL2jN1C0GwvLoy5ez9dFwHoxIpiazln/b+6Btq2e/BOujkRv95NouBcgYxz/a8hNStAahqWMybfyeBzgiAgh65ZLd1RNNsQrggGLEbYtlUO0Du257OVoE2fpB34Ncul2k42ER9nm+THIA21XvU0jc8/PVgMsjz2e3Mhnm2J3266hVtHXcVAb2f6v8cQoLP2q14gy318D38WmVTjZHGrd0GWOewAKisLR+QFlsoOrOm+Wu0yCxDjK9KaTRYEimjOgZrMs4g9aezgwTTsgLQBCOM2GkK12+6y74hOltl6khz6ELnWzJDXFe1nq658Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2DDI9oh6iQ6k/zUUAcCExjMOE9PkaVK+aLibJQ+7tQ=;
 b=Q6Q7+zzUNrA7EizPle8aXhxz60XUnhwR+nBNCjO5qk/fAcLAyjR6bTlQjmsUMF/T9Ye4WnNJbhtFWvdGlIK8N3Nf25yoBALBZaDerCNA8ZwaNnO6CpoR/ZnUKm5izf7YSAQxaV0iBNHGxFkGcG7UgnZ6SrGQUrlRv50CwVY8iZxK+bs0GHKUZFjb0imDlgJVegfGxPkxE0sNNb/feW3UDft6Vulwpwh9/BD3oY3bGzEHCeG7cKk+0Zb7Iaam1yiRILZHb18nSYuQ2x93didgdfo5iwbD7pxqTvKMu6HLoY22ml8Y90l14dLvJm9vR5oZfLz4CtE4YZbqyIvonY8p5w==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PR3PR04MB7386.eurprd04.prod.outlook.com
 (2603:10a6:102:85::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 03:15:13 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 03:15:13 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shengzhuo Wei <me@cherr.cc>, Frank Li <frank.li@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Troy Kisky <troy.kisky@boundarydevices.com>,
	Fugang Duan <fugang.duan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
	Fugang Duan <B38611@freescale.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net 1/2] net: fec: don't leave a stale PTP clock pointer
 after unregister
Thread-Topic: [PATCH net 1/2] net: fec: don't leave a stale PTP clock pointer
 after unregister
Thread-Index: AQHdO+ELkH70Ic1+20KqjvCxAUm+gba9vvAg
Date: Fri, 4 Sep 2026 03:15:13 +0000
Message-ID:
 <GV2PR04MB11739E67E12529585010DEB7488B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260904-fec-ptp-pps-event-uaf-v1-0-9af446be4a11@cherr.cc>
 <20260904-fec-ptp-pps-event-uaf-v1-1-9af446be4a11@cherr.cc>
In-Reply-To: <20260904-fec-ptp-pps-event-uaf-v1-1-9af446be4a11@cherr.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PR3PR04MB7386:EE_
x-ms-office365-filtering-correlation-id: ac6c26a5-4e7c-4940-7f2e-08df0a32bc83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|38070700021|921020|4143699003|10067099003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 P8eUuGMYxeCCelalFD7y0Xhymq1RT17Dgt4/CpLuF829A0AqDndJevCc6XNMsQG18OQ+zGDmt25Md40uHkkjQIdcLjiSO71W8nNf064UR1ZcmnVGpdYrBc0vHG6zvD3DPEPLQnYja8vYMfaSwGNKM2UB7jY49/npave9xVR4WthlVDtc6bQS0SmsIEYl3aOkc5glSMisb/+hCLEi1L6ojeJ2vedc2PMPX35pdohKh9h6jC+MFTKzhi/5QwlXmF9VxeVqWhoy7SkM9DrXdk7y3Tu7huD6/nngSVNnNSruycToX7VO/9AzBLkcHhS3KRMk2ersDpbbc/WAv7DKiQXtV1jFTSw5fo7FhtOSbHkfv8piEM33/+Czr3A4tO7BcESY3/DBurcW2DUCNHliXtzz20Z0BAXG1iCJSIJWW1ipDe43oAoOx5iF4TfP7/2A7uQwgrBDKIv8HT+8kVsSo69du/Qzub48bF/56RoqCu7c8Xr8gVpvCKmhmtXhtm2or6bk2sJUKTXzeEzYwvPrNnQhMGxu7YWZHEEdqC34m19wWDBIL+C1TTtkubWmV7+wKlgNcau2zFU5W1LX5kQrQlYIag66jZsp5gD9D7C1qJA/ZsOXqZMtAvQmSmQ+WAUil03/+18WGcdoj2aRlkefMhet01qWjqd9C9cwjL9p3vMECc9ISW8zX4vrIrsfwctqaSySzC6VSV2PfwftEwJHLPJIaPj3UOTewsY+MPpR9v09zcfpECuyXqJB5DXRqXVpH9qX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RG1DMk0rM2dheUNSanJyVXJGeHFyYmd5YXkrRnl2R1ZZWHpDVm1jcm9oVkk3?=
 =?utf-8?B?dWwvV3VoQ2U2ZW9GMW9JTkQ0aDA1MWl4cTdTMXhKUEVEcmtDWXBiVHlEUWNv?=
 =?utf-8?B?NVk2K1phSnB3TEw5emtKVm9jSnJCMHozUXFDTVErNUtOYUJxbkJmWEU3UU5u?=
 =?utf-8?B?VThDUzFHVHJYeG42UHpXanRFLzBqMksyR04yWlJsamplSVB2U1hVeVRvOW9a?=
 =?utf-8?B?cFN2a1VnRlI0MHZ2VllXR0hYN1hNbG82OVd5cWl2M2cxNDJ0L2xlQXVrRjBy?=
 =?utf-8?B?ZVpoVG8wSFFzbVI5eDNsbWVkNkZvRE50Yk0vUVVxM2QvTjYwSDIxcjkxOTJ6?=
 =?utf-8?B?MDBzMU55R3Z3TTJta1ZUL2pMVzhJcDlTZlJLc2E0dGNHS3ZRZHdnQWZXUTI1?=
 =?utf-8?B?eENDU2V6a21RSXFQQnVYSVdQSWJBaWlCYU8zMStHUW9TTlNMN0VtVFJrWHpx?=
 =?utf-8?B?K1NxZTNXK2YvR0xPK1lZemlVVnNiUmtjTE90bGhNbDFTeDh6NEtETHZmN2lG?=
 =?utf-8?B?a3ZEK2swZGdXeFNnbXgxcDVnVGs2aXRuWnoxaTkvZGcyaExnVkdPTUY4d01Y?=
 =?utf-8?B?ZXdhRGVXSS9tMUg3aDZKTmk1b1F4Qms0U0RRdWJTSnZrWjBjV1BERGovOVd6?=
 =?utf-8?B?SFZ2Q0tCK0MrMXphVUVhSDRwalRCdHQwQjNEWkQ3MEVrSU4rWXNJWWVaaDRz?=
 =?utf-8?B?T1NCMjB5eFZaejdmV3dLQTI5Qmd2OFJwTGdYRFF3WHVCOFoxZzFBejVZNUk1?=
 =?utf-8?B?Z213MDdWRWlJUHorczFOQUExcGx6VTUzY0JTZWtUVTUrTHBEeXM0Z0xtSm9W?=
 =?utf-8?B?a2U4NWg2RlFUR2Z4TVdua25zalVMOUdRcVl6KzFUWjU1UzZFcUFnSWlSQktN?=
 =?utf-8?B?b0ZyOGg2T1A5YWRBSndTVWNCTExEeWZZN2ZiUUFzUDNybWl0dzMxNHpCa0tX?=
 =?utf-8?B?V2doY2lqZndtUUlZTTBhd1JzcHRKSk9KTEtLMitLNHgzaFdaT3VJNStuMnYy?=
 =?utf-8?B?a3VVTHJXTmp0VWJjRi9aMFZKZEJCVFBzVnVJYVlMN3FUdWQwem1lOW9GOUw5?=
 =?utf-8?B?eEJmWUZBNkJUSzNBdm1hTGRCbTZhSlVwa3J6YzJXM21jTFV6aXE3Z2dZWTUv?=
 =?utf-8?B?bU5Ic01Ra0FZbVBrNzF3YXdHV3VCQVBIQVI4SlJxWWJGNFRSMkRZOStlNU5H?=
 =?utf-8?B?Njh0UWMzMGZJMlg4aitXcEoxdWNuZHIweEhVakZjN1F5OUdBT2ZWV3l5U2V5?=
 =?utf-8?B?aG9ic1E4ZnlHa2J0aXI2aXVtenp5NGJqK3VKSUVhWk1vcUdiejl0ZmVzNk5m?=
 =?utf-8?B?K0haZ2Z3cldFVVphVFFzR1dUYWc3NkVyQ2hZNHpUdE5xaWJNYzdsQlJSWXNn?=
 =?utf-8?B?VngyQ1FPN0w5bTdNNTBWbTRkeUtiSUFTcnVOZTBGSXpoSVRiM1dySDNpdHJ3?=
 =?utf-8?B?UjhwTGJxYUNJZDF6TDl4ZzdMZDRNMGNSclpTWTF2NksxMWdVM1R6aWFUMFJj?=
 =?utf-8?B?OUJmWm1oSjNNcmlwd0JoSDVVNTVNMndONktsNjg1OXV0ZEludDUwQ040Y3ZY?=
 =?utf-8?B?K3NtRzN1YzcyZGpnVVU4L3ZoWGk0NEorUDVZWXlUVTNqQWFiQjAxbXdSaXVS?=
 =?utf-8?B?am51enVCWU92TGQ2RnJ6bUtDazVzcG0rYmpCQ2hTbWw2VTFtSkNiUytmckpS?=
 =?utf-8?B?dUlnQnlqTG5vckc5SDJKWklRTzE4LzR2MTlCZkdnNElLditkWjhYNFh1UTBn?=
 =?utf-8?B?eHpORHJBWDQ4UjVwSmxyV1lMVzU5Q1drZTFYYUNKalBDbFhtczZCWnBvK0hv?=
 =?utf-8?B?UGoyRkRZeitiRlZvbjNyV2kvYU11ck1VVUdXenNPenp5TDBwNkhRVmxOc3k1?=
 =?utf-8?B?M1pCOS9hMkJoNFc3SlFVNDB2cDdjRmMwckR0VGtzOG15UDdTL01zWktWanUy?=
 =?utf-8?B?UjFrLzI3cGtvd1htdldRMm1YYjdIT3hhcGF2bnVXaUovRGZnWDVMZE93UnpO?=
 =?utf-8?B?NHBoa0Q4SW9iUHpiUWp6Z3dHMU51MVJLVzNaaWlsVzhKQ0pNZnMwaDYwcmZp?=
 =?utf-8?B?OG8zY2FYemdLUURLcHErVVZtdDhrbEJ4eUtxWUx2T1ZLdjJ1SUdnY01QcEFH?=
 =?utf-8?B?dFN4QWYzVHh1K0lZOWhlUGNKS1dkQ2wwMk1SNFFEQXJ4aUFqRlZkM1I4NWJ0?=
 =?utf-8?B?RUtZTVNidm9SWU1JNlVxanNuUzNFeVdzenI5cjRIdlpOSmRvVko0VVlFV2Qr?=
 =?utf-8?B?azVNZjR1cTRVamFIYklzMFhrME5Odmh2UzEzS3AzbWNaNjExNlhlUDFTTlVn?=
 =?utf-8?Q?y0fT0uuEfoxxccCXqS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6c26a5-4e7c-4940-7f2e-08df0a32bc83
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 03:15:13.7087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5YbhoXLqk4PWnZmKpxze0Tm1FvvG5BvJJy9Q1M8nMvF6gTGKu4YdIncEqOB04VHwrhHLga3wgWJb6IJ6RMAug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386

PiBmZWNfZHJ2X3JlbW92ZSgpIGNhbGxzIGZlY19wdHBfc3RvcCgpIGJlZm9yZSB1bnJlZ2lzdGVy
X25ldGRldigpLCBhbmQNCj4gZmVjX3B0cF9zdG9wKCkgbGVhdmVzIGZlcC0+cHRwX2Nsb2NrIHNl
dCBhZnRlciBwdHBfY2xvY2tfdW5yZWdpc3RlcigpLg0KPiBBbiBldGh0b29sIC1UIGlzc3VlZCB3
aGlsZSB0aGUgbmV0ZGV2IGlzIHN0aWxsIHJlZ2lzdGVyZWQgdGhlbiByZWFjaGVzDQo+IGZlY19l
bmV0X2dldF90c19pbmZvKCksIHdoaWNoIHBhc3NlcyB0aGUgc3RhbGUgcG9pbnRlciB0bw0KPiBw
dHBfY2xvY2tfaW5kZXgoKSBhZnRlciB0aGUgY2xvY2sgc3RydWN0dXJlIGhhcyBiZWVuIGZyZWVk
Lg0KPiANCj4gUXVlcnkgdGhlIFBIQyBpbmRleCB0aHJvdWdoIHB0cF9jbG9ja19pbmRleF9ieV9k
ZXYoKSBpbnN0ZWFkLiAgVGhlIGxvb2t1cA0KPiBob2xkcyBhIHJlZmVyZW5jZSB0byB0aGUgbWF0
Y2hpbmcgUFRQIGNsYXNzIGRldmljZSB3aGlsZSByZWFkaW5nIGl0cyBpbmRleCwNCj4gc28gY29u
Y3VycmVudCB1bnJlZ2lzdGVyIGNhbm5vdCBmcmVlIGl0IHVuZGVybmVhdGggdGhlIGxvb2t1cC4g
IEl0IHJldHVybnMNCj4gLTEgb25jZSBubyBjbG9jayBpcyByZWdpc3RlcmVkLiAgQ2xlYXIgZmVw
LT5wdHBfY2xvY2sgYWZ0ZXIgdW5yZWdpc3RlcmluZw0KPiBpdCBhcyB3ZWxsLCBzbyB0aGUgZHJp
dmVyIHN0YXRlIG5vIGxvbmdlciByZXRhaW5zIHRoZSBpbnZhbGlkIHBvaW50ZXIuDQoNCldoeSBu
b3QgbW92ZSBmZWNfcHRwX3N0b3AoKSBhZnRlciB1bnJlZ2lzdGVyX25ldGRldigpPw0KDQo=
