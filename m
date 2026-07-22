Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53A2C21E8;
	Wed, 22 Jul 2026 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698330; cv=fail; b=Z9/HiTX5vMyTOJngljmdj5D4CWIyvH4cXoidOe6HrxNWQe7yedoIKPLcSX4zihw4suCaxcx+w2RuIre6yWnkXJQB7basMY6frZzjOCJASEhvY2lpAyO7K4eNnC9I8/Y/IoSdqioDdKmg3R0OtgvA2TYSRx1BbCSvPcHwyuxSV0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698330; c=relaxed/simple;
	bh=vfQlCpAydTF8vOEdMYh5QlaiEF7WMqHQkoAvXLZaI0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pUzXBYeNIpgUeIpBwl7iuQ9OO+WmTfxZBDgeAuYZngHD8RTVRevN7IUQYaYWUJ12ZsoQ3zgAxLWMYtRsVH9iJfMvkWZv0doJE5WZTOALiR+46UEINq6DL8agelJLgohzvo8GhQCHGnq9haOiTqchNymEml85YMHOHBYzAtji8xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KTbRrG8Q; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KTbRrG8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J978czZEF8cpbFPmIYDwPTK8WfzP/a0BxUbYRmnBqy2kyrsj/2dk0WybVcpNAo4RUi3MVSXOBp/uTgFipHXGs+2lpPK/lJdGP3Ovj116ADSS/xX+TRw/HMJ3+8aZEdEHC2vZbLpzM/v16WQgR78lAK6nj0mN2zkboxaI8PWthPXVoiwsY8v58pmyFhWlKSPvT6UuNQiGKKV+1dTd9RN5zqt0hio1aZKBthK94w5AxJEn4MEbjjdCO6dh4YZtp2v8szp8IDmINzDxy4PmqYDEDFdHAztT3UnJtXIk1rVDw9Z7bLJ7m3+6KQXUdG3hMVIOuneZbONh6eXWyleC6q809w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfQlCpAydTF8vOEdMYh5QlaiEF7WMqHQkoAvXLZaI0w=;
 b=GZB8ri5A7PECgyxxcMJCQBkXDXKDk1EMMeU+Ox+ppeJ5ZoXQjcSTEGbV/DIAIrc16vxTGieojTA+lQTiOlKMjpMd46FioGC0V8h5mem29dq5HNpy+ddt5c7BjLRX4Tqz+k3fghzkUiInixzjSIzj3sAImRxshcDJ24rTadxJupcpRwTTWRwOxpga8YIL3JeXaUpLobf/eRNz89MvJdEE/XtlElYiTYRlQMOPsieqDK3c6bLsYgNDhf6o85F8sy2/R+v7d0PyqA1yesM0WDIprT+BkXw3it+NQgeIJ/BG45Sh3vrVuFLZmd8rrMDY4Pw7uUgHYR5yJjdlzgbVxYfQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfQlCpAydTF8vOEdMYh5QlaiEF7WMqHQkoAvXLZaI0w=;
 b=KTbRrG8QlBIJhQQ3xUWudqgJvT3oVgiTxUtsK91LTAWz0kKzTInh//S7QzVrgLmFn2+6KHuDzfZI/3yb/UXBiYyHXGPcVN/AgUYHhi4i1Uy/WTa1dVYz+O97KmGMc15T6PVVMswX22J69mlJ2jLtw71m5R99t0wXvfMMUDlwbyeqO23jdRw/9HjOVGwGKyYf8jnK07L1Mpb/vfnsZlYtUOq2u/gYN4g/RbQQOuQH4QYX+rYJ+0vKQeHmgXl9ZEWja797gGMFusbcswlHp393reg36aqvIKGLHyfUDQh/WR6s9ne1vWImIMwZSZk/1GShl4RCYAcu0713FxLJ8k+ppQ==
Received: from SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7)
 by PH8PR11MB8015.namprd11.prod.outlook.com (2603:10b6:510:23b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 05:32:05 +0000
Received: from SJ0PR11MB4910.namprd11.prod.outlook.com
 ([fe80::7af:4219:9135:f1a5]) by SJ0PR11MB4910.namprd11.prod.outlook.com
 ([fe80::7af:4219:9135:f1a5%3]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 05:32:05 +0000
From: <Balakrishnan.S@microchip.com>
To: <ehristev@kernel.org>, <mchehab@kernel.org>
CC: <hverkuil@kernel.org>, <sakari.ailus@linux.intel.com>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] media: microchip-isc: fix WB offset and gain
 register field masking
Thread-Topic: [PATCH v3 10/10] media: microchip-isc: fix WB offset and gain
 register field masking
Thread-Index: AQHdGPvYcrzaBzVtMUWVi6wkjYbMlrZ39S8AgAEPtAA=
Date: Wed, 22 Jul 2026 05:32:05 +0000
Message-ID: <288d023b-59ce-4157-88ea-8ae70d87413c@microchip.com>
References:
 <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
 <20260721-balki-isc-prefix-fixes-v1-v3-10-ffe10640a2d9@microchip.com>
 <a1720828-f0cc-41fb-9060-b8f937eaded2@kernel.org>
In-Reply-To: <a1720828-f0cc-41fb-9060-b8f937eaded2@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB4910:EE_|PH8PR11MB8015:EE_
x-ms-office365-filtering-correlation-id: 2bca8a51-e694-4ab4-7bbd-08dee7b290bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|56012099006|4143699003|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info:
 SjMW4kDeDZLlc9KawLaiYPrp7/vAEgusg+MagfEnp9kCAnuJXgS5sVSY96xrBVCq1aWA7IevODD1WnDC4bm9zBRGiv8Poj4vIoOgwrppGL06yzLylh/WWg8+54pPcAtQsP9tu2IbK8uKbdFpeNM/dVPw45vJRY6bZgNn8BRkiy0HehaMQJWIBB9SWiQOvJybyGCF0yID7MSw9PY3pkI16FAXsNA7Jhc4QoUESXvoxX7UtT5vWJRiJFBxf/p7sWCi4RgTCxxDjxQ3bbuaAvyPvZlJDSrKGOQDR/OOb+sI7W4ENZp4dn5sObeRkQtsQ8ch7KCoD8RiDO47tIpgm13gLdrlyarJ/EMEDUcbMK08a4BNu9JSCSPvuJd482dvSnDDezu0SRETUO0mHpPx7IShAhSy3xDceyKnNgf0zOgskldvNS8o3BT6OQgzGCU/yFtpKmkYSfgML/709MqHor2Zs6nLrxiHc2+5GQxP6LVwrbEytceEm/ttkVO+jUpobfPmTnoh9BrGKZMG0pCfEzPmw4YNPMEEUqqUQ8ovHJ/EMS82FIVu+O8Mf040nwFcI4tj2aXyStqu3j73N5ebY4/WXLsTyEXE52iwZxKpkx+Ssfj593YicQufeaNTAUODrHVMLTxZuYNS2ORlD6JvLOn6cOLA+ctAWChpgxp0e6zrLfMesllfTmGZ/eJ+TZ+bXXdXYHHSb7NBFqT/ylhKqMe3r0Gs5oc3PpJd8yc0uA5P+0o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4910.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YllyOVhnUFB4bVZvMzRvRlEvUXZxUEFWbjRXbUY0YS9CR0JZd0FKN0ZVVkRj?=
 =?utf-8?B?OEsyOHFPODNqWml2dmdxdTlvNGlpL0huR0FtZm9hOFR4Qm9VQWNLdVZtWWlX?=
 =?utf-8?B?dlQ1QkVWZkpzVkZsZThvMDdWM2NGaVI1N2tNaWNhNHBTdXlsb1YvVXhkRkFp?=
 =?utf-8?B?YTE5UW5KZy9rNnkyVXc2azNwVUdJRFVRWm9Ya3IvWTh6d0JRNTZuQ29XcXNN?=
 =?utf-8?B?bDUxTmorcmlXa1p0WUVoREs2WkVCVWxCUGpKL3RDQTNiUVpxSHFGb2ZLZXpk?=
 =?utf-8?B?aUpGb3ZrTFY1UVE0SHczTUp6b2F2NlptRXBDaEJzbHNBVXBRV0xjd3BOSDNV?=
 =?utf-8?B?NkJCc3hGSVhUeHZkc0lzSk82ZkFRQ0JQQkJSK3pRK20vbW1IWndTMWpjT0k1?=
 =?utf-8?B?clRCT1pxNTJJVm83S0djL1l0OGtsVWZlTHBzallsTEpTTWdnQTdkQ1FIVWV2?=
 =?utf-8?B?WFFTUUVHWVI3d04wVmJmczZWbUVic2ZjZ2h3TCthREVtRWpHcDhFSE1WMDVu?=
 =?utf-8?B?dWlBTlBpZlk1ZG5EMERUVW1FVjhibis3TkNITlJnblhuQ2xnbDJ4YnRMVlRW?=
 =?utf-8?B?aXZlRXo0cTVNSDZTVlpvTUlUeVFjRE5YUmkwYzRHejBTVnRHNWdGOGRPc0Vt?=
 =?utf-8?B?L2lYbWF0WVZlYmViakh0NFhpYmdwRDZpNzQxRExrMGY0ZmFOQTdGSDh6SGJx?=
 =?utf-8?B?RXVaOEFaNzk4WWh2eEgrKytqaGUyU2ZpaWZuejU1OWRqZ3dKelRJUmhMVGFC?=
 =?utf-8?B?RTg1S3VFS0VTK0FPMWtsWjREN3FZYWpkdEpXNkNCQldKWW5WeS9KSWdNRk5U?=
 =?utf-8?B?RHRHVU5xRGtCWFpmRVpjVW5mR0R0V2dLNENjM2paUnVIa1h6elBlS0doT1k5?=
 =?utf-8?B?N1BSRWI4b2Y4MHkrZHFORks1VXFSV0l0czlTaVVWN3NJMEZxb3BCTFA2bG80?=
 =?utf-8?B?TVV3MEFPQStnUHdYNUpQcUNOei9UNGVxV0RqOUE0Qnl3QTZoQTlFLzBQUG51?=
 =?utf-8?B?dytSOEVITHphT0VKSE12bzFzeUZCQkgxZWxSeG1Jb3dDSlNHSVdETUlkNXoz?=
 =?utf-8?B?Z2VkUXZDMWYxSUQvYmd2a044QkFIeTZqRkNUZVgzTEk1MENHMzJydlJwUGJn?=
 =?utf-8?B?RVhQZ1B2Mk9nSXFkNmw0M1hyYTJyUFNjVURIVStTSERHNkYvV2lNblo1ckFV?=
 =?utf-8?B?NlRtWWQzd25sYWhhNzJnNnc5Q3dTZ1Yrb1dkNm9qYmtFaWxnL3dJcVc5Mllv?=
 =?utf-8?B?Rm1KN0pSYkFCS2xweXhDTDdDWU1pemx2Z3RJOU5WdEJUTnl5c1dweFZ5bUlB?=
 =?utf-8?B?NHRwRzRIeFhFNWl6blgwVlcrUkF5Yk5JZUpuYkpnS2hSQlRqNE95RXFhdHUv?=
 =?utf-8?B?UERxRWdoSUxKdm5MOTdRZWJJTnNRWEN2b3RwMFFCejlmTi83WElRcEYxMjNH?=
 =?utf-8?B?V2xLSlhnaEV2NjZtLzhQZWcwbDJQV1dhdTY1REJrK1VjZzU0VGJ4NkVGaG1h?=
 =?utf-8?B?dVNVYnlTYVNsS1NKbVpmNi9HTXdNcGtzT04xN3VlT3FySXJ4VlVoVFBJQSt2?=
 =?utf-8?B?ZlZmWGEzVXgrQ0JoY3lZY29nRmxkOUw1ZDRPaHRVQjZyQnBGUGg3dUI4WG55?=
 =?utf-8?B?bWs4MUFBbmdzRFhGWXZaMXNJY29aYi8zZG9LMk93dXJnSkp4QWdXOUpGTDJz?=
 =?utf-8?B?STd4VWRZdThybnpJdGdsSHFzUDQrcGlrdlNzSlE4Ti9HRTdHSTJzbHJvWUZl?=
 =?utf-8?B?cjRiSTR3UWM4eG9lb2NJMllLS0U2eHYzNkQwM0tLRlhCbHg4SWw4K2t0dXVp?=
 =?utf-8?B?YkM1MmNweFJnMFJTQ0krVGxsOHlYUis1dzd5djVXR2N5c21DYmhEOUtYb2hy?=
 =?utf-8?B?NklUOHBIeFZGcHluK2RZZFNhVlhwUFFBL3BUaUVnTDhxaFBZWG9CcWYrUDlk?=
 =?utf-8?B?REU3enVKNm1UdzZsbWNiUVZmWlQrOHByY2tiMjZ1SitPc3dXZk1ubzh5djZa?=
 =?utf-8?B?SDRWNWJadld5eVdwN1NGY0doT2xFdHJWWGVwaXU2L09ZZzZFakRLZEg2M2hu?=
 =?utf-8?B?SXRGWGN1Nk5wNnFMZzVaTXJLSlZvVzA3N0RFL0o0UHdQM0JPZkswTC8vQkQ0?=
 =?utf-8?B?REJvOXNEYVZlNERhM2owNndreUJmak9VNGVVTW0vTHdkL3UyK3pSSEdsNWJQ?=
 =?utf-8?B?WDZMc0Q5aUVSdzZWWjdqSEJJNnRXMXBqSURyMzgzRWFQditBVTJnWFJDZmx6?=
 =?utf-8?B?Y2JzWktDS0dhYmw0ekZkQWxpZzFMMHFpbGlYVWt5R0ozSXBkcjYvQ042eXdZ?=
 =?utf-8?B?TTEzenF5NSszSVNWUGRDalkzL2VlV0tpdUxlMVRqT3RkQmxVQTA5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <724D683CB34FD047B2AACEE9BC538418@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4910.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bca8a51-e694-4ab4-7bbd-08dee7b290bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 05:32:05.1322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmONP6BLf/4AdRjJBdIjCByidWovZSB8rEo96gwISVsQsgoHCpHLPy6yCPR0GTlnp7se188uy2gwYuVMEw8zJU1eD8emqs05IUcVKJLPr/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8015

SGkgRXVnZW4sDQoNCk9uIDIxLzA3LzI2IDY6NDkgcG0sIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gNy8yMS8yNiAxMzoy
OSwgQmFsYWtyaXNobmFuIFNhbWJhdGggd3JvdGU6DQo+PiBJU0NfV0JfT18qIGFuZCBJU0NfV0Jf
R18qIGVhY2ggcGFjayB0d28gMTMtYml0IGZpZWxkcy4gQSBuZWdhdGl2ZSBvZmZzZXQNCj4+IHNp
Z24tZXh0ZW5kcyBhbmQgY29ycnVwdHMgdGhlIGFkamFjZW50IGZpZWxkLiBBZGQgbWFza3MgZm9y
IHRoZSB0d28NCj4+IGZpZWxkcyBhbmQgd3JpdGUgdGhlbSB3aXRoIEZJRUxEX1BSRVAoKSwgd2hp
Y2ggbWFza3MgZWFjaCB2YWx1ZSBpbnRvIGl0cw0KPj4gZmllbGQsIHNvIHNpZ24gZXh0ZW5zaW9u
IGNhbiBubyBsb25nZXIgYmxlZWQgYWNyb3NzLg0KPj4NCj4+IEZpeGVzOiA5MWI0ZTQ4N2IwYzYg
KCJtZWRpYTogbWljcm9jaGlwOiBhZGQgSVNDIGRyaXZlciBhcyBNaWNyb2NoaXAgSVNDIikNCj4+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBCYWxha3Jpc2hu
YW4gU2FtYmF0aCA8YmFsYWtyaXNobmFuLnNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAu
Li4vbWVkaWEvcGxhdGZvcm0vbWljcm9jaGlwL21pY3JvY2hpcC1pc2MtYmFzZS5jICAgfCAyMSAr
KysrKysrKysrKysrLS0tLS0tLS0NCj4+ICAgLi4uL21lZGlhL3BsYXRmb3JtL21pY3JvY2hpcC9t
aWNyb2NoaXAtaXNjLXJlZ3MuaCAgIHwgIDYgKysrKysrDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwg
MTkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9taWNyb2NoaXAvbWljcm9jaGlwLWlzYy1iYXNlLmMgYi9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL21pY3JvY2hpcC9taWNyb2NoaXAtaXNjLWJhc2UuYw0KPj4gaW5k
ZXggMWE5Yjk3ZWRmYTMyLi4zZDI1ZDdkMjg2NTIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL21pY3JvY2hpcC9taWNyb2NoaXAtaXNjLWJhc2UuYw0KPj4gKysrIGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9taWNyb2NoaXAvbWljcm9jaGlwLWlzYy1iYXNlLmMNCj4+IEBA
IC02MiwxOCArNjIsMjMgQEAgc3RhdGljIGlubGluZSB2b2lkIGlzY191cGRhdGVfYXdiX2N0cmxz
KHN0cnVjdCBpc2NfZGV2aWNlICppc2MpDQo+Pg0KPj4gICAgICAgIC8qIEluIGhlcmUgd2Ugc2V0
IG91ciBhY3R1YWwgaHcgcGlwZWxpbmUgY29uZmlnICovDQo+Pg0KPj4gKyAgICAgLyoNCj4+ICsg
ICAgICAqIEVhY2ggcmVnaXN0ZXIgcGFja3MgdHdvIDEzLWJpdCBmaWVsZHMuIEZJRUxEX1BSRVAo
KSBtYXNrcyBldmVyeQ0KPj4gKyAgICAgICogdmFsdWUgaW50byBpdHMgZmllbGQsIHNvIHNpZ24g
ZXh0ZW5zaW9uIG9mIGEgbmVnYXRpdmUgb2Zmc2V0IGNhbg0KPj4gKyAgICAgICogbm8gbG9uZ2Vy
IGJsZWVkIGludG8gdGhlIGFkamFjZW50IGZpZWxkLg0KPj4gKyAgICAgICovDQo+IA0KPiBJIGd1
ZXNzIHRoaXMgY29tbWVudCBkb2VzIG5vdCBtYWtlIHNlbnNlLiBJdCByZWZlcnMgdG8gYSBiYWQg
c2l0dWF0aW9uDQo+IGluIHRoZSBwYXN0IHRoYXQgaXMgbm8gbG9uZ2VyIHZhbGlkLiBJbiB0aW1l
LCBpdCB3aWxsIGJlIGZvcmdvdHRlbiBhbmQNCj4gaXQgZG9lcyBub3QgbWFrZSBzZW5zZSB0byBt
ZW50aW9uIGl0IGhlcmUuDQo+IEF0IGxlYXN0IG15IG9waW5pb24gb24gaXQuDQoNClllYWgsIGl0
IG1ha2VzIHNlbnNlIGlmIG5vIG9iamVjdGlvbnMgbGV0IG1lIGNob3AgaXQgb2ZmLg0KDQpUaGFu
a3MsDQpCYWxha3Jpc2huYW4NCg0KPiANCj4gDQo+PiAgICAgICAgcmVnbWFwX3dyaXRlKGlzYy0+
cmVnbWFwLCBJU0NfV0JfT19SR1IsDQo+PiAtICAgICAgICAgICAgICAgICAgKChjdHJscy0+b2Zm
c2V0W0lTQ19ISVNfQ0ZHX01PREVfUl0pKSB8DQo+PiAtICAgICAgICAgICAgICAgICAgKChjdHJs
cy0+b2Zmc2V0W0lTQ19ISVNfQ0ZHX01PREVfR1JdKSA8PCAxNikpOw0KPj4gKyAgICAgICAgICAg
ICAgICAgIEZJRUxEX1BSRVAoSVNDX1dCX09fTE8sIGN0cmxzLT5vZmZzZXRbSVNDX0hJU19DRkdf
TU9ERV9SXSkgfA0KPj4gKyAgICAgICAgICAgICAgICAgIEZJRUxEX1BSRVAoSVNDX1dCX09fSEks
IGN0cmxzLT5vZmZzZXRbSVNDX0hJU19DRkdfTU9ERV9HUl0pKTsNCj4+ICAgICAgICByZWdtYXBf
d3JpdGUoaXNjLT5yZWdtYXAsIElTQ19XQl9PX0JHQiwNCj4+IC0gICAgICAgICAgICAgICAgICAo
KGN0cmxzLT5vZmZzZXRbSVNDX0hJU19DRkdfTU9ERV9CXSkpIHwNCj4+IC0gICAgICAgICAgICAg
ICAgICAoKGN0cmxzLT5vZmZzZXRbSVNDX0hJU19DRkdfTU9ERV9HQl0pIDw8IDE2KSk7DQo+PiAr
ICAgICAgICAgICAgICAgICAgRklFTERfUFJFUChJU0NfV0JfT19MTywgY3RybHMtPm9mZnNldFtJ
U0NfSElTX0NGR19NT0RFX0JdKSB8DQo+PiArICAgICAgICAgICAgICAgICAgRklFTERfUFJFUChJ
U0NfV0JfT19ISSwgY3RybHMtPm9mZnNldFtJU0NfSElTX0NGR19NT0RFX0dCXSkpOw0KPj4gICAg
ICAgIHJlZ21hcF93cml0ZShpc2MtPnJlZ21hcCwgSVNDX1dCX0dfUkdSLA0KPj4gLSAgICAgICAg
ICAgICAgICAgIGN0cmxzLT5nYWluW0lTQ19ISVNfQ0ZHX01PREVfUl0gfA0KPj4gLSAgICAgICAg
ICAgICAgICAgIChjdHJscy0+Z2FpbltJU0NfSElTX0NGR19NT0RFX0dSXSA8PCAxNikpOw0KPj4g
KyAgICAgICAgICAgICAgICAgIEZJRUxEX1BSRVAoSVNDX1dCX0dfTE8sIGN0cmxzLT5nYWluW0lT
Q19ISVNfQ0ZHX01PREVfUl0pIHwNCj4+ICsgICAgICAgICAgICAgICAgICBGSUVMRF9QUkVQKElT
Q19XQl9HX0hJLCBjdHJscy0+Z2FpbltJU0NfSElTX0NGR19NT0RFX0dSXSkpOw0KPj4gICAgICAg
IHJlZ21hcF93cml0ZShpc2MtPnJlZ21hcCwgSVNDX1dCX0dfQkdCLA0KPj4gLSAgICAgICAgICAg
ICAgICAgIGN0cmxzLT5nYWluW0lTQ19ISVNfQ0ZHX01PREVfQl0gfA0KPj4gLSAgICAgICAgICAg
ICAgICAgIChjdHJscy0+Z2FpbltJU0NfSElTX0NGR19NT0RFX0dCXSA8PCAxNikpOw0KPj4gKyAg
ICAgICAgICAgICAgICAgIEZJRUxEX1BSRVAoSVNDX1dCX0dfTE8sIGN0cmxzLT5nYWluW0lTQ19I
SVNfQ0ZHX01PREVfQl0pIHwNCj4+ICsgICAgICAgICAgICAgICAgICBGSUVMRF9QUkVQKElTQ19X
Ql9HX0hJLCBjdHJscy0+Z2FpbltJU0NfSElTX0NGR19NT0RFX0dCXSkpOw0KPj4gICB9DQo+Pg0K
Pj4gICBzdGF0aWMgaW5saW5lIHZvaWQgaXNjX3Jlc2V0X2F3Yl9jdHJscyhzdHJ1Y3QgaXNjX2Rl
dmljZSAqaXNjKQ0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWljcm9j
aGlwL21pY3JvY2hpcC1pc2MtcmVncy5oIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9taWNyb2No
aXAvbWljcm9jaGlwLWlzYy1yZWdzLmgNCj4+IGluZGV4IDlkZGJiYjZkZDY4Yi4uZmUxNDViMTQy
YjgyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9taWNyb2NoaXAvbWlj
cm9jaGlwLWlzYy1yZWdzLmgNCj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWljcm9j
aGlwL21pY3JvY2hpcC1pc2MtcmVncy5oDQo+PiBAQCAtMTQ5LDYgKzE0OSwxMiBAQA0KPj4gICAv
KiBJU0MgV2hpdGUgQmFsYW5jZSBHYWluIGZvciBCLCBHQiBSZWdpc3RlciAqLw0KPj4gICAjZGVm
aW5lIElTQ19XQl9HX0JHQiAweDAwMDAwMDZjDQo+Pg0KPj4gKy8qIEVhY2ggV0Igb2Zmc2V0L2dh
aW4gcmVnaXN0ZXIgcGFja3MgdHdvIDEzLWJpdCBmaWVsZHMsIGxvdyBhbmQgaGlnaCAqLw0KPj4g
KyNkZWZpbmUgSVNDX1dCX09fTE8gIEdFTk1BU0soMTIsIDApICAvKiBSIG9yIEIgIG9mZnNldCBb
MTI6MF0gICovDQo+PiArI2RlZmluZSBJU0NfV0JfT19ISSAgR0VOTUFTSygyOCwgMTYpIC8qIEdS
IG9yIEdCIG9mZnNldCBbMjg6MTZdICovDQo+PiArI2RlZmluZSBJU0NfV0JfR19MTyAgR0VOTUFT
SygxMiwgMCkgIC8qIFIgb3IgQiAgZ2FpbiBbMTI6MF0gICovDQo+PiArI2RlZmluZSBJU0NfV0Jf
R19ISSAgR0VOTUFTSygyOCwgMTYpIC8qIEdSIG9yIEdCIGdhaW4gWzI4OjE2XSAqLw0KPj4gKw0K
Pj4gICAvKiBJU0MgQ29sb3IgRmlsdGVyIEFycmF5IENvbnRyb2wgUmVnaXN0ZXIgKi8NCj4+ICAg
I2RlZmluZSBJU0NfQ0ZBX0NUUkwgICAgMHgwMDAwMDA3MA0KPj4NCj4+DQo+IA0KDQo=
