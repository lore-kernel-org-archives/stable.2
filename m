Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2131ED93
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437555; cv=fail; b=jQQMWeDBFQmNTRxG74Ii112uL0lIxRgIxi9VZ5PpGPnRxu+iO1BRUgqKZ910t9f4gto0DfXPypVKDDUl4lRMzUAIcxxv9NqhLiE2f1PXjaEEtxI7EZIM31oovcDFd8yIJVdBp5y2cG0Jcu0V3dp02OWd/5Xd7H0fGTk+rcKzS60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437555; c=relaxed/simple;
	bh=vUH54eGphPLEeU5E5+9TwySmH1CFp8jmvqDfiWMf0a8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m26rx3EXrPDeCkubIcHZDTUQQbs3WxlA8bevCUEkLXyzJEdi27IVBae7p3RX3fY3ih7mEu+fI4EWAuPyCSCTlvADkW5N4FPLvMT9MPhZShN9KhuO9UYE9vTHSperSZ1WTEY4q09tPOV1fn1b/oigQBOCWLqXCPAly7WlaFLzTkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xe11Q7xk; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xe11Q7xk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWZk2c+wYxvniUBQtYNfUynJ3WJ7WEukuF90takhDYzqGCfg9Cr2qwbfDvRDaQMItvhIHJrpkEZjCWU7tfHibnYNZXTprQOZO9ZjdiFXFzcG1WTQQ8LZbQpcurD8iN6IhErZIpRm6jft2WgH32jtUrG5bY/X7w4afNgle2it3EKc1vGUKALDRd/4I9+QyI1omccPu3LYlW75en/QoWP+iiC41bwZ86peoiXdVIr5X7tXyi2fwX73IeYbSqZYRyY7XfqCNcTZy0FQSEKxcYVqTrf0dSQ/RLJDQtK/iyCUXHrVWqfgnb3eOP/32tdidCHyx0J6+t+zLHPWol2lzollsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUH54eGphPLEeU5E5+9TwySmH1CFp8jmvqDfiWMf0a8=;
 b=qURXNTJhjn5e+DxDa58iGmKmT8zlp1bHhi682yvV9StvEDkC17CSTEHLpWb0SzMn+uN7kqwBO/MZrDvQE59FN2478XZoxAeCWKhoHAdtrv4WAwwliWifxdZ+oDtyNW1DkA5/9b0100WhKc6gDUvoJJf6N8N4TQDl/ysBwmBB96YLaeWLoXh/UgdsgVm9nApKsGsvklqHg3xAmYTSUcdPZGAPfkyMM9v0OyL71k7QRrEiikvlC7U+PRFGTQFI4cj1f6MTIKGpQ4cRt/bkU+wad6lmhyIeoluorlpG2x1wZKdSFOJmMlPbyICaw9OkqlPhEABCxa0wh+lGvtuKUWmK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUH54eGphPLEeU5E5+9TwySmH1CFp8jmvqDfiWMf0a8=;
 b=xe11Q7xkzT3huu83JjfABTesnAFamB/ReoP9n98qwn8nR3kDCDYMcyjc+2a0IhzrbyVlsdRlc6tewHfSb4qVKN9Z3wcP9ay25/LK5SUD58hn5oYHRwQWFEI54e+sUzcWR9TpyLPpv1OdrOCxAOyY6ABvgWJAaIrZ6JicrlPUV88=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:19:07 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 15:19:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Greg KH
	<gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>, Linux kernel regressions list
	<regressions@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Koenig, Christian" <Christian.Koenig@amd.com>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: RE: Some 7.1-post fixes that might be worth picking up rather sooner
 than later
Thread-Topic: Some 7.1-post fixes that might be worth picking up rather sooner
 than later
Thread-Index: AQHdDfoahSZTdNFtL0OBzo/QyKFBh7ZiK2UA
Date: Tue, 7 Jul 2026 15:19:06 +0000
Message-ID:
 <BN9PR12MB51469BC3FEC959A89AC9CB54F7F02@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <91281f28-eccf-4681-8f62-faaa8a3ba529@leemhuis.info>
 <2026061917-flinch-idealism-898f@gregkh>
 <2026062236-ludicrous-detached-6e20@gregkh>
 <d3d467d3-637c-49fe-8516-8da65cf4261b@leemhuis.info>
In-Reply-To: <d3d467d3-637c-49fe-8516-8da65cf4261b@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-07T15:17:15.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DS0PR12MB7629:EE_
x-ms-office365-filtering-correlation-id: c94ccdd6-7d0a-4e39-4f29-08dedc3b1662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|11063799006|22082099003|18002099003|4143699003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 pbPMeuxn6hyeFbYUTB3mcoZaDpd0N+W5CEuQBRhjxXMI1ckcKdG/AP4UpxwW/0ktHqy19zXJysJRWemx5cG3MJYLuPD58LXJxCqYzm2OzaJHWx0PVTe7/jgunh11bgK8vFhA5CmV5kWZhV5tl1V8vKZvVBDopWUwO0inDS0y2vRLKnof3MCTYTjh+cbX3oZXOTgguUdNTtuRbMCUwGHLqcvwPK7KXhexEkImeIM2GNXrJXx1d/U81WssXy3S2LW+eM1IZ5EUQHm4nyH5LDaQtlfFroroZwg5P2Fd6XtvRhz5Su0TeeILcPOQHLRpjsVsNy8LPxCtbjPwm31+ICLgdGNsocNdK5fj7CC77f2Ste8MfCdOokEjbiDWgOQntWu33R4mNjE72Gn5Xg8MIr13DIG23md94ZYmmCDi1l8tnKwt9oGaFj3mWIVkOVFPJjUn+orX8P1eslM0VKADQmBVLUTYLQchEG384EuWVq1TOXBe6P1KTRAj5yLiNT9YsD06N6B97kiXrHADfdOF8eUlbQ47sZEsz4/uOEYiH0O+/kxhfXDJwhV2asYVX2EABhUlSC4fS9pUp/X1r3muCZ78YyLmvAoNLDB9rXsq0d931SZexU3aOrLcnCPWjOey/DwzeWPMJeFjeE0UroAhv4ylAokcOu/EVhbM1eUtIyU6+aE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEREcjNCL2t2eFBZSHdwTGM2SzRyMnZPZnF3dEI5ZFVnelZzbDUzbi81eVNp?=
 =?utf-8?B?SThSbzJxdW5DM0JZVEpVMkJDYmliam9ab1FwbGpxcDBLNklTM05YcUR1aGk2?=
 =?utf-8?B?N3BVVTJOWnVlQVRQWDBkSWxkQVpZcGNsVGduNGdXUDRObnlHd3lYRmdVRS94?=
 =?utf-8?B?N0xLVFVBcCtraTlpN0djek1JMHlYOHlCOFI1MFBnZXp1Z2FnSzJEaUdlVnNa?=
 =?utf-8?B?eDBsRGxzaEhsbzRPL1FoeXdWZmhQc0xONXhRbFFIWndTbEJaZ0FlcTc5V1Jh?=
 =?utf-8?B?U0EvVTdHbDUrbUtMQjJiVXRMN2xoNXlCSVNkcjBzbXJ5RkJ5OGE3VktvRVFI?=
 =?utf-8?B?QzJmTnJlRnRlZUlkVkJlZUgvOGh1UFkxZk1kVjBRL0Z2c0RDSXVDSERKL1pN?=
 =?utf-8?B?YnkyVnZrTEF2R2FjYnVWbVdJTExFalJEZzg4bmdKTVRzalR5OGNka1pMaklr?=
 =?utf-8?B?K1RiMW12VW5EbnVlcXE3dnBWZS9Cdk9zOEJOd1lGaTV5TjJoL21LUE1lQ2VF?=
 =?utf-8?B?encyTmVueStCYjFOU051MUFTcmpWSjMvY3lFMnFtaktxOFIrNWN3dTNZVFZK?=
 =?utf-8?B?UFFFa1YrY1hTUWtWM3VoRFJPdzd5MDNlQ29NY0tzRUtobklZWFk2QUpPMng1?=
 =?utf-8?B?YktnV1RsNWt4eHUxQnFSWCtkUklxRk5Nd0FKV0xvQUJkamk4QllmV1p2WDZP?=
 =?utf-8?B?c1k2bWVpL2M0TzVCN29ZdWxzRXYwbmZRSjFjUVpuR0tXa0puWXMwc21CWmV4?=
 =?utf-8?B?UDFvYWRKbUF0OXo4VUpVQmR1QlVPTU01NG9xTGtBdDdZbkszR05oMkp0anhh?=
 =?utf-8?B?QWZ2T0xRVzJUS3pkcjg3WEUvNGVUenNrRlo5U0JBbFUzQzkybmhaSGorRmR4?=
 =?utf-8?B?M21ITk9uTGx0bUUwcGhWcngvYVVoNTNXT29yM1Z4YTZEemxFbkVHQUNBYW04?=
 =?utf-8?B?MTRMblg2QisxSDlyYUUvMUlHUVJiY0FhZy9EbDBvOXNqMWlzRFV2VTJNZXdi?=
 =?utf-8?B?S1YyV0g5LzJ3ck5KU1UwaUE1Qjlab0Z1VmtTOVI2cVBtTUtiWHh1L0dBdzYy?=
 =?utf-8?B?TGM1VlRsTXA2L2NtbmZwR0ZCVHAvUWdyL21IZWhEMnV5VDZibzJWcnpYeElI?=
 =?utf-8?B?eGdnQ1AyaGRSMEtIRE9QU1FhWkJsejNud1BtKzkzRHJlcTAvRGMvWWZHUUho?=
 =?utf-8?B?V0RWMlA0eS9vU1Y3emo4SlY5ekZSUWNYM3VzUWRzTmVnUW5tOUNia0RjbThW?=
 =?utf-8?B?S002ZzlMeVlUM1VOKzc4SHZzM0hVRzZpdDJ3RlpPeFBROERDRG9Gakw1a1V3?=
 =?utf-8?B?UDB4L1ZtYlU5RnZQKzBubU1sZGUwbnZsN0MwamJMNXN4QzF5R2hiWEVDeDFn?=
 =?utf-8?B?Q2N0WVdXemxyQ0YwampiVHpwdTQ4T0c4Qm50eFVUK2RQNzBycEpSRGhsbVQ1?=
 =?utf-8?B?SDlFSXRNT1p4NjhZQUF0c25Fc08yT3VxMTEzTm03QlAxL1hHbUFpSUVpQmxE?=
 =?utf-8?B?NUd0SkV4b2VPK2tVL2lLRE12UWt4VFlMaWNMeUVSNDZvUWpOUUdYMkljWGVG?=
 =?utf-8?B?bnlFZVhpR3VRT0tUYThRb3pjc205bHEvOVF2WUZFTDBVcnF6NDJmSzU0dnY1?=
 =?utf-8?B?RThBaXdNdWsxcDBjMEJUM1NxMm5TZWxZb2kzTjNiYlhGNm1uM3BQQnFsQTJU?=
 =?utf-8?B?SFlrZE9xSHAxMDMyZkJqMk0ycCtqcDVNK2d3WS9aQ2ptVDlRWngzQkYzK0tG?=
 =?utf-8?B?TXVBY3g4cnJZRFpPTWlLQWdRZUd5WFcySXRXSStRVlpaZXNYalUrQ2ExZTZ1?=
 =?utf-8?B?Q1hXQVFiQnk0RDlXNkYrdEFPckJ3Y1Y3d2hKUTUzTVFObjg1bXdVSVY5bjMx?=
 =?utf-8?B?TlU2d1Y1VEdNZGZsam92UmdNNDJsamRkMUdYU0FMRWdRSXJreTJrOHBxM1ZK?=
 =?utf-8?B?U0piZ1o3YzczcUZHTDN2NVBmenJVRTFvRXJldktVVk5LaWwyOG80aWthcldU?=
 =?utf-8?B?dG5jYzFjbHI3bEQwdm5OaGRyWWpPT0FCbjdSRW55ei9QM1gzVWdjdDlzeXlm?=
 =?utf-8?B?MFdxaUpzODREMVFtOGxhL1FsSjl2OXdjRHZBcnBrNGVFOFNpNkw4L1BFZGFQ?=
 =?utf-8?B?OU1rN05URTRoUWhUbWdVRnNuS2x2b2ZjT0RBWmpYNUtSSnUvMnNQSjNTa3RK?=
 =?utf-8?B?T0tzV1BOalo3NE00YUZKdjhFQkdHYTNDRmRqcmxyTmY5akdkRFllc1g1Z3Uv?=
 =?utf-8?B?WGRhZlhHdno1VWRJMVNGWTZIY3VFSjJqdXNKdHFzMVRWZW1KN1BzWnpNdDJ5?=
 =?utf-8?Q?UN/UyI8H4s5+d+Q5Ph?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94ccdd6-7d0a-4e39-4f29-08dedc3b1662
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 15:19:06.9309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0AgLWXupY8ZEeaJ8K4S8QQDi4DVJmsNq4CBaUjzLw1x0qdjA/l2t1eCKi/EYI2+WHxOCX2Rce3QaRIezt/cyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvcnN0ZW4g
TGVlbWh1aXMgPHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm8+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1
bHkgNywgMjAyNiA2OjE5IEFNDQo+IFRvOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4NCj4gQ2M6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz47IExpbnV4IGtlcm5l
bCByZWdyZXNzaW9ucyBsaXN0DQo+IDxyZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY+OyBzdGFi
bGVAdmdlci5rZXJuZWwub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPjsgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPjsgU2ltb25hDQo+IFZldHRlciA8
c2ltb25hQGZmd2xsLmNoPjsgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRp
b24ub3JnPg0KPiBTdWJqZWN0OiBSZTogU29tZSA3LjEtcG9zdCBmaXhlcyB0aGF0IG1pZ2h0IGJl
IHdvcnRoIHBpY2tpbmcgdXAgcmF0aGVyIHNvb25lcg0KPiB0aGFuIGxhdGVyDQo+DQo+IFtDQ2lu
ZyBhIGZldyBwZW9wbGVdDQo+DQo+IE9uIDYvMjIvMjYgMDc6MzIsIEdyZWcgS0ggd3JvdGU6DQo+
ID4gT24gRnJpLCBKdW4gMTksIDIwMjYgYXQgMTE6NDM6NDFBTSArMDIwMCwgR3JlZyBLSCB3cm90
ZToNCj4gPj4gT24gRnJpLCBKdW4gMTksIDIwMjYgYXQgMDg6MDQ6MzVBTSArMDIwMCwgVGhvcnN0
ZW4gTGVlbWh1aXMgd3JvdGU6DQo+ID4+PiBIaSBTdGFibGUgVGVhbSEgRnJvbSB0aGUgcmVncmVz
c2lvbnMgcG9pbnQgSSB0aGluayBpdCBtaWdodCBiZSBuaWNlDQo+ID4+PiB0byBwaWNrIHVwIHRo
ZSBmb2xsb3dpbmcgY2hhbmdlcyBmb3IgdGhlIG5leHQgcm91bmQgb2Ygc3RhYmxlIHVwZGF0ZXMg
KGUuZy4NCj4gPj4+IDcuMS4yKSwgYXMgdGhleSBzZWVtIHRvIGZpeCByZWdyZXNzaW9ucyBJJ3Zl
IHNlZW4gbXVsdGlwbGUgcGVvcGxlDQo+ID4+PiByZXBvcnQgd2l0aCA3LjE6DQo+ID4+PiBbLi4u
XQ0KPiA+Pj4gKiAxMmY1OGE2Y2FhZDNiZSAoImRybS9hbWQvZGlzcGxheTogRml4IENvbG9yIE1h
bmFnZXIgKDNETFVULA0KPiA+Pj4gU2hhcGVyLA0KPiA+Pj4gQmxlbmQpIikgW3Y3LjEtcG9zdF0N
Cj4gPg0KPiA+IFRoaXMgZG9lc24ndCBhcHBseSB0byA3LjEueSwgYW5kIHdvdWxkIG5lZWQgYSB3
b3JraW5nIGJhY2twb3J0Lg0KPiBKdXN0IGEgcXVpY2sgc3RhdHVzIHVwZGF0ZSB0d2ltYzoNCj4N
Cj4gSSBwb2ludGVkIHRoYXQgb3V0IGluDQo+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9y
Zy9kcm0vYW1kLy0vd29ya19pdGVtcy81Mzk2ICwgYnV0IG5vdGhpbmcNCj4gaGFwcGVuZWQgZnJv
bSB0aGUgQU1EIHNpZGUgYWZhaWNzLiBUaGV5IGhhdmUgbXVjaCBvbiB0aGVpciBwbGF0ZSwgSSBm
dWxseQ0KPiB1bmRlcnN0YW5kIHRoYXQsIEkgZ3Vlc3MgaXQgZmVsbCB0aHJvdWdoIHRoZSBjcmFj
a3MgKG1heWJlIHRoaXMgbWFpbCBoZWxwcykuDQo+IFRoaW5nIGlzOiB0aGUgYmFja3BvcnQgb2Yg
dGhlIHJldmVydCBpcyBxdWl0ZSBiaWcsIHNvIG5vYm9keSBlbHNlIChpbmNsdWRpbmcgbWUpDQo+
IGRpZCB5ZXQgZGFyZSB0byBzdWJtaXQgaXQgdGhlbXNlbHZlcy4NCg0KSSd2ZSBwdXQgYSBiYWNr
cG9ydCBvbiB0aGUgdGlja2V0LiAgSnVzdCB3YWl0aW5nIGZvciB2ZXJpZmljYXRpb24gZnJvbSB0
aGUgYWZmZWN0ZWQgdXNlcnMuDQoNCkFsZXgNCg0KPg0KPiBTbyB0d28gd2Vla3MgbGF0ZXIgdGhl
IHJlZ3Jlc3Npb24gY2F1c2VkIGJ5IGU1NmUzY2ZmMmExYmIyDQo+ICgiZHJtL2FtZC9kaXNwbGF5
OiBTeW5jIGRjbjQyIHdpdGggREMgMy4yLjM3MyIpIFt2Ny4xLXJjMV0gaXMgc3RpbGwgdW5maXhl
ZCBpbg0KPiA3LjEueSBhcyBmYXIgYXMgSSBjYW4gc2VlIGl0IC0tIGEgcmVncmVzc2lvbiB0aGF0
IGlzIGtub3duIHNpbmNlIG1vcmUgdGhhbiB0d28NCj4gbW9udGhzIG5vdywgYXMgdGhlIHJldmVy
dCB0byBmaXggaXQgKDEyZjU4YTZjYWFkM2JlLCBtZW50aW9uZWQgaW4gdGhlIHF1b3RlDQo+IGFi
b3ZlKSB3YXMgc3VibWl0dGVkIGFscmVhZHkgb24gMjAyNi0wNC0yOSwgYnV0IG9ubHkgbWFkZSBp
dCB0byBtYWlubGluZQ0KPiBkdXJpbmcgdGhlIG1lcmdlIHdpbmRvdyBmb3IgNy4yICh0aGlzIGlz
IGFub3RoZXIgdGhpbmcgdGhhdCBhZmFpY3MgZmVsbCB0aHJvdWdoDQo+IHRoZSBjcmFja3M7IHNh
ZGx5IEkgb25seSBiZWNhbWUgYXdhcmUgb2YgdGhlIHJlZ3Jlc3Npb24gYWZ0ZXIgNy4xIHdhcyBv
dXQsDQo+IG90aGVyd2lzZSBJIHdvdWxkIGhhdmUgbWFkZSBub2lzZSBlYXJsaWVyIHRvIGdldCBp
dCBpbmNsdWRlZCBpbiA3LjEpLg0KPg0KPiBUaGlzIGFsbCBzZWVtcyByYXRoZXIgdW5mb3J0dW5h
dGUuDQo+DQo+IEx1Y2tpbHkgaXMgc2VlbXMgdGhlIEtERSBQbGFzbWEgZGV2ZWxvcGVyIHR1cm5l
ZCBvZmYgc3VwcG9ydCBmb3IgdGhlIGNvbG9yDQo+IHBpcGVsaW5lIHN0dWZmIGluIEt3aW4gNi43
LjENCj4gKGh0dHBzOi8vaW52ZW50LmtkZS5vcmcvcGxhc21hL2t3aW4vLQ0KPiAvY29tbWl0Lzkw
NzlhNDE3YjgyMWY4MGMwZDllM2JjNTAxNGEzODhlMGUzNDBmODINCj4gKSwgd2hpY2ggYXBwYXJl
bnRseSBhdm9pZHMgdGhlIHByb2JsZW0gZm9yIG1hbnkgdXNlcnMgKHNlZSB0aGUNCj4gZ2l0bGFi
LmZyZWVkZXNrdG9wIHRpY2tldCBsaW5rZWQgZWFybGllcikuDQo+DQo+IENpYW8sIFRob3JzdGVu
DQo=
