Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F730FC12;
	Thu, 11 Jun 2026 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146265; cv=fail; b=bSD6eHryaxF3veT5caxEmQhOgVYJL8mARH1GKzaL1WZr/oeouPTLHDREFSwWl2LXyMnixIbe/2AU5164uaRbP1HbDGWPN3GvwxQHXdF2jm4aqza+NqZwJHi7gEN72gQVGnQGrIWJPLUJ0Bb1ufV2qwaAhK3ZjdFw+oJWSDW+PdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146265; c=relaxed/simple;
	bh=m2ajJXL0cLMbqPIyX8RCqd+dKLhLLerb6DfUqdKYhKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e8H1QP3P7sRZs8p1Bx9cko0C6kQbTDTlpid8mBRK5lEHBoYQWRXgXD4u3rOkSu7zt2Sg6a154oZxruHefJOpxPwNp1ozjkTDtESkkB2b2XzkQid6q93EBjdYq60Cuuu8KL7dm0eF7Ep8olDhEatZp8Z4Q+NNqXytOi5PNlJ4VJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fjARkSJf; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fjARkSJf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/kqf59tpP8R70bJg4DYfzWcRgKqqy+G2TGWX68ma4ky3Y4yTqbGbFTXdccBNHUfN8vQzrvp4Cw1guYizBGmCZLK+LGz+vwY/hvmPLiWdR6gN1z91xRkg6C2W4yCsa5uq/L4yl3OL6JdjRfB678g50MuetuVyiq3zg65ATWH6DAsL0scdNRfSJ0bJZcDoTJ1LKKAu1ZAKWHK7Wzto/mirp00hlwxjouDdz9d1/GZuTPo4IvKQGEa7mMzH0/NDfVHYhMMUSsCxxds1i9Yi/qvAAuukChptt/AAe6pIwXUYmBii8++JaYq/F59Ee4XfBeT8IuXkZRUkfKeW6faLdcvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2ajJXL0cLMbqPIyX8RCqd+dKLhLLerb6DfUqdKYhKo=;
 b=VuzDWP7CtgRTELtgRRGfioj4EOS65ae2uYwgCUsUF9z/bOVUjuanFnqnVj6OdS7kNBJfE6GN3+wHIxBDBl+xplm0uh7Jx798DYfeFZ1H2skU8LUJ4/wuoIWTuExOGtcIzN80DIekHndOyKXcDRa9VoaArbHRqSDDOl0jpSJ9KzvE06uAhDEp+km8105EFzLQbTwd/ka+wz4FGg5dyc9he2mm3GcEO+w4SxD7podkpZpncvzru7/8WoSBNbXStmbKxXISzm0yjzwZ4PXtwEWog+dM8QeRvuhTIDU8j3Zymym0u5Mi2Ts4bT+totIpH16DjnOu6DOXukBmynrCtklPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2ajJXL0cLMbqPIyX8RCqd+dKLhLLerb6DfUqdKYhKo=;
 b=fjARkSJfKvm5aDCUJ54yVWISb9gUE0YU2EkrOpj/tP3G43ii9KcoFhvmpbnN5Oi11pq5Mui8KoqsO93gnhJcF45zQIwVn7BNVvQ6k03yV1qd7qDStFdaNssBf0iLvBPsSOsotxCbGYsXz/1Tl9Is1KpSm2sFs3p4tCHfjuAeHBm872r8Y6BmGLLi3l8x9cBxbApUXssdMlI/BztPqYStQX7G7r1q7lB9a/YZYKgwUzBGWBnuJGj1DM+SR+Qj4NmNFV814KywJAhSyYO7157lUfvY4g7gnRpX3Uy0JyhxRRnVHMn9y8aogXwUQDh1M5o5e7mCYpTjoIU7sb8A8Jh3Yw==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by GV4PR04MB11307.eurprd04.prod.outlook.com
 (2603:10a6:150:297::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:51:01 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 02:51:01 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset
 for i.MX95
Thread-Topic: [PATCH v2 1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset
 for i.MX95
Thread-Index: AQHc5pd2moy7hQYUOUq8AVBw2ter87Y2gWOAgAJFx9A=
Date: Thu, 11 Jun 2026 02:51:00 +0000
Message-ID:
 <GV2PR04MB12019455B1CACA213C78644C08C1B2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260518072715.3166514-1-hongxing.zhu@nxp.com>
 <20260518072715.3166514-2-hongxing.zhu@nxp.com>
 <xwupi3bxiihnmddqkdc6xsixkbirdpnips6qy5n4xchtcysnfq@f6pa5usw2a4f>
In-Reply-To: <xwupi3bxiihnmddqkdc6xsixkbirdpnips6qy5n4xchtcysnfq@f6pa5usw2a4f>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|GV4PR04MB11307:EE_
x-ms-office365-filtering-correlation-id: c141dee5-0e36-4759-6a00-08dec764457b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|7416014|366016|6133799003|38070700021|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 21fGUw3Bi86DEHJox05wZA8KnkAdMde7pHxAPAs5tLR/c0/XIn/OTJEiUN7+mMACyB5y20X3fDkWdy6c/42JaXsd0KFezsuLK5zPyynWaur23mcRuVtkmzG57KyiAzqCEOdLIeWosPyCkr2YKBVuw/EzGeI84wF1rfGbFRM1+Qd3jfvbQYVPn9aasS8LjhLyGStogfHYZNu+XotQ+ncicMi9ZXFF1/z1kNIcYBwxSXImq67+RZFlOyzW+XMMJ3+oyGLATDKFV+YaCkSMlKQRJIUYg0E+i6zgKoXI/ZiS8JRl4gza719JA4reH/1vwOEKAFE8vH/+ZrpokGmZDNDioQIaumXjB+wgS9iWuio0bU6xmAp2nPUC7eNXoqAOJh+Wfn1rQt6iLNzaYrxH1UMzUhbDAhTMs0omOA+SMjMTg8hbqfdJVrDpj+b0kxfxpkDDLbVGsfSlicgC/tq14mqO3aG3/1gufFP+PZAzIha3fjo2pLLajBpuy7ssvstuMNCA+tbYJei5rdBy3H4cOXHHfpnUfvezJxliCwA2CFiIAhYcT5tTRH+89sALtZMnMCjN1Ou0+2lOCzf0fYH4Ufe2FPJet74Qt89KVRwU5Td5bDedVhmaeDPWz9mnbkgALz5v+r45KAPleU75WqnTly3QTQt6xw6/BqG5S0dEgrDeHgEM83jzWeRUNXUV1tzG0TlDdxnDx2doNlvvCPkOUPJdlkmHPVnC65ai5csW+1zbBox0/73yoFJ2q11CVWYmXpUU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(7416014)(366016)(6133799003)(38070700021)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVJEQmxFUXJNbStKR2J2WXpvdDROVjhPUmZSR09tTmovL1lMQWpQN1pJb3N2?=
 =?utf-8?B?aThEdVRrVllpcVVqQ0ZVcGQ5RlNkTEpXSG1mZmJEckduTFJRdnNINCthVWFD?=
 =?utf-8?B?Sld1eUhNQ2VtT2pTT2xITUVuQlJWQzJEcEg0VXNsSXdwUDhneGJnQWpYcG1N?=
 =?utf-8?B?UExFQlc2aUpycWxCL3Q1bThaOFYzQTJxbDdXMFo0bjUzcTJTbXVUM1A4SHoy?=
 =?utf-8?B?SnhycjJrZEtzZDl6cDg0dmRJREtJNzUzQy9HSGg1UUlucVNHZzZrMVZXYWlv?=
 =?utf-8?B?UDFYNk53S2Q0S0JLbVY4Zmw2VHEvdlpDTUZNYkRGdFBqaFJjQy9xOHVCRkNo?=
 =?utf-8?B?clBIS3RVSzZnajgwVHZFWk0yeml3NHk2aGxLRmljcTFwR2R6THI2Z1p1bnFS?=
 =?utf-8?B?WG1TWnNqNzIrSy96bnpwVHRDWEpBUGtLb0dzMFl3QVBSK2I1UnJnRWlkQmJM?=
 =?utf-8?B?V3RscitBVlRJOVkwQzFJMW5CSUdaZkJ0UnZzcjdQNS96N2JsVGkvVDhqL3hR?=
 =?utf-8?B?T3NPMGdGNXpLWnRLbnhqS0hGZHNHaFJseUQyYTlScUtEQmFyQkNjSGpSR0du?=
 =?utf-8?B?M25pV2V3aFpmT0hRL2lxSzhRQzg0RnhyYml6OEh5bUZwTVNUSXMyVmVYelY3?=
 =?utf-8?B?bDB2cFNVMVBzNldlTTNYTTMrSU84dmtydkVUSDVBZ2MwdUx5MVdTL29acWxN?=
 =?utf-8?B?b0wyeHptS3ArdjB6UkFvTzZ5bzcvd1ZPS0hBZ1crd1lpQlQ0TGc0Nit3eDRS?=
 =?utf-8?B?THRacXV6d2U5NytkMVg1T3dsTXBLclVmdWVBS3pjYW1ic0p3ZWUxcmpJeWhQ?=
 =?utf-8?B?STJMYm15V2x6ZzIwZ0ZXZVNVVmhqekt3c2dKSm9GaWtMaFFQQWhrZWM5UDlI?=
 =?utf-8?B?VDU1aXRnQ2w3OGVwTzNRTnE4YnFHR1dvN0FFMm5SeGNVZmRwT2t1SW5jbE1D?=
 =?utf-8?B?aWQyMUNaamdkVkh0aThYMDFva2VnVlhJd1YzY0tCakliRHUwK0xJSjR0M0oy?=
 =?utf-8?B?SHFjUVhrMW9mYTRJT1ZibDhBRG1KQ0pnTEtzNFhXUmpES3MvalFnbW5GL2ZJ?=
 =?utf-8?B?cy9NRDZmdWN2OFVWcnBkcWYxKzhYYVNSL3E5cTUxMVMzY2NpZ2E1VGlManR1?=
 =?utf-8?B?emMzNEFWYVZockNRQUk2d2FBQndMZmZBc0J3NGNBMjRZamRVTEVLZjdyY05n?=
 =?utf-8?B?Y2VCKzMwK29KK3E3VWk4NGRhMmV1QWtGNHc2K2UvUGwyeVBJc25uSWJrOGo0?=
 =?utf-8?B?cFYwWXFQcTh6NUt4aG1mZktsdmFnV2tjcXNuV3RVbkp4dWxteGpDVVplVWRa?=
 =?utf-8?B?S2hvWVBSaHdXQ0tBN0JjV0VLd2FCV3VwSmlOczRJeE42Yk8xV2tVM0tLeVRS?=
 =?utf-8?B?UTlzT0FYR3l6TXdCM2F5ZCsrd21jbENpZnBFdTR1TXVwcytBazBhT3VlY2NW?=
 =?utf-8?B?Nlh2aHZjaVhKRmp0eTBKQ0FhcXBoMGxsOUpNSDYyMUw2MHlORVlMVjRXRnVr?=
 =?utf-8?B?dGoyZWNxVEVrZ1hram83QTAvMEFDdGxsMTBWZWFCdzNCRkZjOXhreEFKK1hU?=
 =?utf-8?B?UGYycE50L2oybU5GaTE4ekpHYk90OWRlZzlxS2kzS2F6bkh6WFhmUzJIT2Iw?=
 =?utf-8?B?YmlITlN4dFM0bFZIcDlDdnpzbU9kN0VKcm1Ta2FXblU2b3NGa3orVnVvMDQ1?=
 =?utf-8?B?aUV4WE5uYkg0WXMrcUhaTlZvY3hnaTdjKzAvUW55dHBwVzEwU2llWlVDWktL?=
 =?utf-8?B?TEJCUkFvYWJqUGR1bi9lTWwwNTFxSXZaVVZVK3lEdFJZalI3NmZGelhtTzNT?=
 =?utf-8?B?aE5ITTFZVHphb05XaDEySkdxQ2tmKzl0R2FlcUViUkFXWmwrbHI1STd3ekhE?=
 =?utf-8?B?cFRBUlBTclBIRFRuMVN5WDJ0UzZ1Qm1ZRTRGVEtFOUlWcjRmNHpkZGp2UmpD?=
 =?utf-8?B?WUh3aTZUVFQ2TDVXZ1Bpd2NuTWExK2I5ZFR1NWVwd2JKenN2QS9xU2FzS3pI?=
 =?utf-8?B?REdEVG9MalpOeHlYeFRySGhDM2lYZ25XOWNzLzMxMHVtWDF6ZGs4SFpxVXZY?=
 =?utf-8?B?OS91UHRWNjZEU09CcGdtMHY5d2dveGJXVDJzQzdzZnFUQ3J0WHNiSlIvdGxJ?=
 =?utf-8?B?aHVrQURIYkZNTFRCUzlXZDNJUEpKdnIyK2hlK3hQMUNzcnhxbGtFM1paRW1p?=
 =?utf-8?B?alZ1MHdRSTEzK1NMbzRqM241cFdJNklFUGZ6blA4NHFyRWt2UDZ2bVhjc2dP?=
 =?utf-8?B?UGYydEVMTmdMYVVReUZpZ3kwUVVoZURhcm9rY0VhbVFNRGs2RGttWmczK2x6?=
 =?utf-8?Q?WuT0c7ZfmL6TaSZTHD?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c141dee5-0e36-4759-6a00-08dec764457b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 02:51:00.8996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRWRPETKEFpEx9MHsKUdKBuQ7wMHSBwrKd7QKel8dAxsLCuEmBT78ehrbShJgUMWNLonLVc7bEO+MHth8aj48w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11307

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgSnVuZSA5LCAyMDI2IDExOjQ4
IFBNDQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogRnJh
bmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFs
aXNpQGtlcm5lbC5vcmc7DQo+IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9y
ZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LQ0KPiBwY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGlteEBsaXN0
cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIFBDSTogaW14NjogQ29u
ZmlndXJlIFJFRl9VU0VfUEFEIGJlZm9yZSBQSFkgcmVzZXQNCj4gZm9yIGkuTVg5NQ0KPiANCj4g
T24gTW9uLCBNYXkgMTgsIDIwMjYgYXQgMDM6Mjc6MTRQTSArMDgwMCwgUmljaGFyZCBaaHUgd3Jv
dGU6DQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBpLk1YOTUgUENJZSBQSFkgRGF0YWJvb2ssIHRoZSBy
ZWZfdXNlX3BhZCBzaWduYWwgaW4NCj4gPiB0aGUgQ29tbW9uIEJsb2NrIFNpZ25hbHMgc2VjdGlv
biBzZWxlY3RzIHRoZSByZWZlcmVuY2UgY2xvY2sgc291cmNlDQo+ID4gY29ubmVjdGVkIHRvIHRo
ZSBQSFkgcGFkcy4gUGVyIHRoZSBzcGVjaWZpY2F0aW9uLCBhbnkgY2hhbmdlIHRvIHRoaXMNCj4g
PiBpbnB1dCBtdXN0IGJlIGZvbGxvd2VkIGJ5IGEgUEhZIHJlc2V0IGFzc2VydGlvbiB0byB0YWtl
IGVmZmVjdC4NCj4gPg0KPiA+IE1vdmUgdGhlIFJFRl9VU0VfUEFEIGNvbmZpZ3VyYXRpb24gYmVm
b3JlIHRoZSBQSFkgcmVzZXQgdG9nZ2xlIHRvDQo+ID4gY29tcGx5IHdpdGggdGhlIHJlcXVpcmVk
IGluaXRpYWxpemF0aW9uIHNlcXVlbmNlLg0KPiA+DQo+ID4gRml4ZXM6IDQ3ZjU0YTkwMmRjZCAo
IlBDSTogaW14NjogVG9nZ2xlIHRoZSBjb3JlIHJlc2V0IGZvciBpLk1YOTUNCj4gPiBQQ0llIikN
Cj4gPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBGcmFuayBM
aSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWlteDYuYyB8IDI3DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMN
Cj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCAw
MDJlMGEwZDkzODIuLjY2ZTc2MDAxNWM5MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWlteDYuYw0KPiA+IEBAIC0xMzgsNiArMTM4LDcgQEAgc3RydWN0IGlteF9wY2ll
X2RydmRhdGEgew0KPiA+ICAJY29uc3QgdTMyIG1vZGVfb2ZmW0lNWF9QQ0lFX01BWF9JTlNUQU5D
RVNdOw0KPiA+ICAJY29uc3QgdTMyIG1vZGVfbWFza1tJTVhfUENJRV9NQVhfSU5TVEFOQ0VTXTsN
Cj4gPiAgCWNvbnN0IHN0cnVjdCBwY2lfZXBjX2ZlYXR1cmVzICplcGNfZmVhdHVyZXM7DQo+ID4g
KwlpbnQgKCppbml0X3ByZV9yZXNldCkoc3RydWN0IGlteF9wY2llICpwY2llKTsNCj4gDQo+IEkg
cmVuYW1lZCB0aGUgY2FsbGJhY2sgYW5kIGhlbHBlciB3aGlsZSBhcHBseWluZzoNCj4gDQo+IHMv
aW5pdF9wcmVfcmVzZXQvc2VsZWN0X3JlZl9jbGtfc3JjDQpUaGFua3MgZm9yIHlvdXIga2luZGx5
IGhlbHAuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IC0gTWFuaQ0KPiANCj4g
PiAgCWludCAoKmluaXRfcGh5KShzdHJ1Y3QgaW14X3BjaWUgKnBjaWUpOw0KPiA+ICAJaW50ICgq
ZW5hYmxlX3JlZl9jbGspKHN0cnVjdCBpbXhfcGNpZSAqcGNpZSwgYm9vbCBlbmFibGUpOw0KPiA+
ICAJaW50ICgqY29yZV9yZXNldCkoc3RydWN0IGlteF9wY2llICpwY2llLCBib29sIGFzc2VydCk7
IEBAIC0yNDksNg0KPiA+ICsyNTAsMjQgQEAgc3RhdGljIHVuc2lnbmVkIGludCBpbXhfcGNpZV9n
cnBfb2Zmc2V0KGNvbnN0IHN0cnVjdCBpbXhfcGNpZQ0KPiAqaW14X3BjaWUpDQo+ID4gIAlyZXR1
cm4gaW14X3BjaWUtPmNvbnRyb2xsZXJfaWQgPT0gMSA/IElPTVVYQ19HUFIxNiA6DQo+IElPTVVY
Q19HUFIxNDsNCj4gPiB9DQo+ID4NCj4gPiArc3RhdGljIGludCBpbXg5NV9wY2llX2luaXRfcHJl
X3Jlc2V0KHN0cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUpIHsNCj4gPiArCWJvb2wgZXh0ID0gaW14
X3BjaWUtPmVuYWJsZV9leHRfcmVmY2xrOw0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBSZWdh
cmRpbmcgdGhlIFNpZ25hbCBEZXNjcmlwdGlvbnMgb2YgaS5NWDk1IFBDSWUgUEhZLCByZWZfdXNl
X3BhZCBpcw0KPiA+ICsJICogdXNlZCB0byBzZWxlY3QgcmVmZXJlbmNlIGNsb2NrIGNvbm5lY3Rl
ZCB0byBhIHBhaXIgb2YgcGFkcy4NCj4gPiArCSAqDQo+ID4gKwkgKiBBbnkgY2hhbmdlIGluIHRo
aXMgaW5wdXQgbXVzdCBiZSBmb2xsb3dlZCBieSBwaHlfcmVzZXQgYXNzZXJ0aW9uLg0KPiA+ICsJ
ICovDQo+ID4gKw0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteF9wY2llLT5pb211eGNfZ3By
LA0KPiBJTVg5NV9QQ0lFX1BIWV9HRU5fQ1RSTCwNCj4gPiArCQkJICAgSU1YOTVfUENJRV9SRUZf
VVNFX1BBRCwNCj4gPiArCQkJICAgZXh0ID8gSU1YOTVfUENJRV9SRUZfVVNFX1BBRCA6IDApOw0K
PiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IGlt
eDk1X3BjaWVfaW5pdF9waHkoc3RydWN0IGlteF9wY2llICppbXhfcGNpZSkgIHsNCj4gPiAgCWJv
b2wgZXh0ID0gaW14X3BjaWUtPmVuYWJsZV9leHRfcmVmY2xrOyBAQCAtMjcxLDkgKzI5MCw2IEBA
IHN0YXRpYw0KPiA+IGludCBpbXg5NV9wY2llX2luaXRfcGh5KHN0cnVjdCBpbXhfcGNpZSAqaW14
X3BjaWUpDQo+ID4gIAkJCUlNWDk1X1BDSUVfUEhZX0NSX1BBUkFfU0VMLA0KPiA+ICAJCQlJTVg5
NV9QQ0lFX1BIWV9DUl9QQVJBX1NFTCk7DQo+ID4NCj4gPiAtCXJlZ21hcF91cGRhdGVfYml0cyhp
bXhfcGNpZS0+aW9tdXhjX2dwciwNCj4gSU1YOTVfUENJRV9QSFlfR0VOX0NUUkwsDQo+ID4gLQkJ
CSAgIElNWDk1X1BDSUVfUkVGX1VTRV9QQUQsDQo+ID4gLQkJCSAgIGV4dCA/IElNWDk1X1BDSUVf
UkVGX1VTRV9QQUQgOiAwKTsNCj4gPiAgCXJlZ21hcF91cGRhdGVfYml0cyhpbXhfcGNpZS0+aW9t
dXhjX2dwciwNCj4gSU1YOTVfUENJRV9TU19SV19SRUdfMCwNCj4gPiAgCQkJICAgSU1YOTVfUENJ
RV9SRUZfQ0xLRU4sDQo+ID4gIAkJCSAgIGV4dCA/IDAgOiBJTVg5NV9QQ0lFX1JFRl9DTEtFTik7
IEBAIC0xMzQ4LDYNCj4gKzEzNjQsOSBAQCBzdGF0aWMNCj4gPiBpbnQgaW14X3BjaWVfaG9zdF9p
bml0KHN0cnVjdCBkd19wY2llX3JwICpwcCkNCj4gPiAgCQlwcC0+YnJpZGdlLT5kaXNhYmxlX2Rl
dmljZSA9IGlteF9wY2llX2Rpc2FibGVfZGV2aWNlOw0KPiA+ICAJfQ0KPiA+DQo+ID4gKwlpZiAo
aW14X3BjaWUtPmRydmRhdGEtPmluaXRfcHJlX3Jlc2V0KQ0KPiA+ICsJCWlteF9wY2llLT5kcnZk
YXRhLT5pbml0X3ByZV9yZXNldChpbXhfcGNpZSk7DQo+ID4gKw0KPiA+ICAJaW14X3BjaWVfYXNz
ZXJ0X2NvcmVfcmVzZXQoaW14X3BjaWUpOw0KPiA+DQo+ID4gIAlpZiAoaW14X3BjaWUtPmRydmRh
dGEtPmluaXRfcGh5KQ0KPiA+IEBAIC0yMDQ3LDYgKzIwNjYsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGlteF9wY2llX2RydmRhdGEgZHJ2ZGF0YVtdID0gew0KPiA+ICAJCS5tb2RlX21hc2tbMF0g
PSBJTVg5NV9QQ0lFX0RFVklDRV9UWVBFLA0KPiA+ICAJCS5jb3JlX3Jlc2V0ID0gaW14OTVfcGNp
ZV9jb3JlX3Jlc2V0LA0KPiA+ICAJCS5pbml0X3BoeSA9IGlteDk1X3BjaWVfaW5pdF9waHksDQo+
ID4gKwkJLmluaXRfcHJlX3Jlc2V0ID0gaW14OTVfcGNpZV9pbml0X3ByZV9yZXNldCwNCj4gPiAg
CQkud2FpdF9wbGxfbG9jayA9IGlteDk1X3BjaWVfd2FpdF9mb3JfcGh5X3BsbF9sb2NrLA0KPiA+
ICAJCS5lbmFibGVfcmVmX2NsayA9IGlteDk1X3BjaWVfZW5hYmxlX3JlZl9jbGssDQo+ID4gIAkJ
LmNscl9jbGtyZXFfb3ZlcnJpZGUgPSBpbXg5NV9wY2llX2Nscl9jbGtyZXFfb3ZlcnJpZGUsIEBA
IC0NCj4gMjEwMiw2DQo+ID4gKzIxMjIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wY2ll
X2RydmRhdGEgZHJ2ZGF0YVtdID0gew0KPiA+ICAJCS5sdHNzbV9tYXNrID0gSU1YOTVfUENJRV9M
VFNTTV9FTiwNCj4gPiAgCQkubW9kZV9vZmZbMF0gID0gSU1YOTVfUEUwX0dFTl9DVFJMXzEsDQo+
ID4gIAkJLm1vZGVfbWFza1swXSA9IElNWDk1X1BDSUVfREVWSUNFX1RZUEUsDQo+ID4gKwkJLmlu
aXRfcHJlX3Jlc2V0ID0gaW14OTVfcGNpZV9pbml0X3ByZV9yZXNldCwNCj4gPiAgCQkuaW5pdF9w
aHkgPSBpbXg5NV9wY2llX2luaXRfcGh5LA0KPiA+ICAJCS5jb3JlX3Jlc2V0ID0gaW14OTVfcGNp
ZV9jb3JlX3Jlc2V0LA0KPiA+ICAJCS53YWl0X3BsbF9sb2NrID0gaW14OTVfcGNpZV93YWl0X2Zv
cl9waHlfcGxsX2xvY2ssDQo+ID4NCj4gPiBiYXNlLWNvbW1pdDogNDBiN2Y2MWExYTRkN2ZkMTgx
ODhmM2Y4N2UxNWZmNWE5MGNlMWQzMQ0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCj4gDQo+IC0t
DQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40N
Cg==
