Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795585230;
	b=5QaZCy6qmqJeVKehG8zTllQdqJ/6VJ9gweN7mfErUVBQcPuCGVRcT/0NxfF2aE4+l/YV
	 P32fw/R3PkxVgGx2Mde44AyIx3tQrXm6frDlpF6oCTHCwwy/W3nS6MYNdgKMl+bLX+4Iq
	 /lNXgTTORqbEg9vFN3yB5GEA8PF5ey+1PVepKF+5+RYngeJxAkaydD4lfrsOsmgSM3q0z
	 7wwSi7Fpl2FHPjeNR92gDpmLsO+32DaoanBvmWZq+mdbjiTrDPG9FsZuINPXmw5tm/d1/
	 XeEUx5vJA+y4Soh3Z80Kn9Sjp2BfIEeH1LQ4MkA33lwdVQD3oZ6vCKUcJjlnzTsIZMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585230;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ttoR9PRDJaBhGp3KDccIJTBoBfcd2Mo97HPtcBnyf9E=;
	b=wMLKpG7BNOfvVJLElqXrUX5J5IhtD56VhDw8A7y364eLertNc4nYCJu6s6C0qr1tKO1w
	 H5nTrSfs2cPjpP980Q6jx75oPY9TZYh9I3HY1ux5i3DCAeqYWg8bmtBsUrwYEEJeLLleJ
	 wsIgX8UNCzhhQJEoyGRNNx4Y9SQXtAPP726VPbFDfGroKOCT8seJKoVGorBFe1b/uWdbT
	 wbp53aTf+FMp48SiVUUJAY5RTphhpMZ5y/Tdrull8YO98s3b4MY4+6XvirO2KUjrbxMbo
	 8DAZrxPh72F4f2MMKBwz5yTC6CZCmYEYqU3+PF3uCpwYVdgPD5d4DO4EHomTb0qC1xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=atlr-engineering.com;
	spf=pass smtp.mailfrom=atlr-engineering.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.121
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023121.outbound.protection.outlook.com [52.101.72.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FD5606A31E;
	Wed, 25 Nov 2026 05:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5FD5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlr-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlr-engineering.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fREV3KMXS4jKe2PzODhu9I+Qkamzx1oziwba6p3bKezZA3FDTUjozACqMmNo2cRKyZsaEhGVBFfwLHJjbqdDzpf/an+hSLn8nD19iz1S8TW2aJGIoJUvKLj+jKlm46TpTRUSvYlQ6e3tlVv/jEzA4N8ztjLFbwsYLFP0/sODa2bgn2xkKoVAslIdLG3q1ZISK5EYcnKrJJhRoF2oC78/iJbGByRbk5gwBgT8ItqUv6PrNAOlCS1z5VcsTbRu5NcgDnw2E9Tp9ZF4M7w0rTYiSfcCac61pgg2pJ9Y/cmk3fMyNN1Pup5xj0tmRwYoSB3SIPcqFEyTs7q3+MtBB9DtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttoR9PRDJaBhGp3KDccIJTBoBfcd2Mo97HPtcBnyf9E=;
 b=yxFNWynypB2kPSGkpBZVYYXbpc61IVjcKeEXRXOIVsx/9NLlc8bPmLa7Pxaf3dfGQdPWeXoWtuj/UICButyegP+JJ4LdslGBiFBU0vBiFRmdopw7L2uI7dkw5bB7ct3vrLWitXOGveuE9IKw7tNsRIh9Ln/sTGzFvY6WNptmzaoUT9ZXq/8t7tuprKJndou9CC3NtAjwRFKcpXB0zCAqH298la9StdOIkWAq8KK9Ac2t4sVr2fpgH7wK9ev3z68rvNUvYAGY/eoTIgK9B+1RkV37K5L7KL4Yi+ZPiiiVynWVxqgZgDaltvNUTX5pAnqgy5V0Igsf1XMvCnY6HVgknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atlr-engineering.com; dmarc=pass action=none
 header.from=atlr-engineering.com; dkim=pass header.d=atlr-engineering.com;
 arc=none
Received: from DB7PR06MB5324.eurprd06.prod.outlook.com (2603:10a6:10:73::22)
 by AM7PR06MB6626.eurprd06.prod.outlook.com (2603:10a6:20b:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 05:40:25 +0000
Received: from DB7PR06MB5324.eurprd06.prod.outlook.com
 ([fe80::b923:2ab6:f430:9f47]) by DB7PR06MB5324.eurprd06.prod.outlook.com
 ([fe80::b923:2ab6:f430:9f47%2]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 05:40:25 +0000
From: Alexandre Rapaille <arapaille@atlr-engineering.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson
	<andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa
	<abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Loic Poulain
	<loic.poulain@oss.qualcomm.com>, Luca Weiss <luca@lucaweiss.eu>, Eugene
 Krasnikov <k.eugene.e@gmail.com>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wcn36xx@lists.infradead.org" <wcn36xx@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Luca Weiss
	<luca.weiss@fairphone.com>
Subject: RE: [PATCH v2 1/3] ARM: dts: qcom: msm8974: Fix WCNSS wifi interrupt
 trigger type
Thread-Topic: [PATCH v2 1/3] ARM: dts: qcom: msm8974: Fix WCNSS wifi interrupt
 trigger type
Thread-Index: AQHdeMX2813u/DAARU+RFnC48SnXnbc7z+mAgAJ9LJY=
Date: Wed, 25 Nov 2026 05:40:25 +0000
Message-ID:
 <DB7PR06MB5324CB68F21677A6C21B1E5F85432@DB7PR06MB5324.eurprd06.prod.outlook.com>
References: <20261120-wcnss-series-v1-v2-0-3fed518decfb@atlr-engineering.com>
 <20261120-wcnss-series-v1-v2-1-3fed518decfb@atlr-engineering.com>
 <f6eec0d4-1d37-4bdc-b09f-8bec0dcb8dec@oss.qualcomm.com>
In-Reply-To: <f6eec0d4-1d37-4bdc-b09f-8bec0dcb8dec@oss.qualcomm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atlr-engineering.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR06MB5324:EE_|AM7PR06MB6626:EE_
x-ms-office365-filtering-correlation-id: 054091b9-dfd8-48d1-078d-08df4ab69b20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|6133799003|18002099003|22082099003|921020|56012099006|4143699003|261028144727099003|261022105027099003|261022075727099003|261026140227099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 WuTFpFfI14gfYI4099nww/uEAC6gv/K8mAtFOQuSIqw+G9bD4UbiccXeAtfPMdk43F6uk3UHkuJCaaWKSvu7z/R6oEEwc+Y/L1wJpfaQ0wQmbK7a7tkwmBrF9a3DyFVQJu9w7Fox4QJDxnVoK1/6io44okkKt1/K+0eNR/jnQupsihyYxdT8O+LoEERVXMYibuy4KxdWvNXnquj73XBEt1xvXsjZfgLd+zmmJ9wPi6lsd0MeLHL8vyc6PkRWcF7dQt95ABHLdvdpdS0BP7BBSBbVM7C99d2X+9u8fV2XkbWjO1cX2uM7NPDLpdxjua58/jo/3xMaob950Yw3ilDg1RbVya3txg02zra/5LtqXSSuSgOV3StCv+i0tLe64Xu/UIdnEExJ6YPD3sqaLP5FqhOYiWzOMRXaQEGymahRJctRjbdjw2MnzAaYDZwxfGKevBib8qNQ7CcBkGt757nDGrqnr/w7yUlx9bnrrGzsDQYg5S5+HlTF6KQjY9NQ3vb05XoaL4b4j6dykkwwPK8itbkxH+wxFZu3u5d+RcAHTcdRvxca4ql1l9acyfGaB0RHV7gjbKCxxmbxYCGHOmNRDRj6nkYtMhIUxaTh4aiP1NZpVWXhsDFFKRbREcAP/n4mwYI+LHOj0db3j7VZZQ19fbQvGS5qInC/xoeVRkD/DAqL+51GoS37u2fxYCpjQB/+gPZ7T2yQvAzFE0qzGK4ylV2FLHaaKfn29C8Ff+sFaQ77yJZSwXVtsm2nchKsyuHb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR06MB5324.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(6133799003)(18002099003)(22082099003)(921020)(56012099006)(4143699003)(261028144727099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?l9vPIYonSJzz2rrWLG6DBImqveKHd9HS+FKw3qXO2nT9J3HcwiIf9H9REo?=
 =?iso-8859-1?Q?GPQeyt+Pjp/BWr7SO4hdGBOn2V8t/pq7peo4JTx6ouBHvt91g1kgh2FYfc?=
 =?iso-8859-1?Q?XNulc7KjNjKxvbqWPdPi9MWe79UKDrZqKhbMRklQ5TyQIoMY9yMJTMIVKY?=
 =?iso-8859-1?Q?O1W50gBrOP5h8ISY6I0G3w3uZSgnS7fTLjuxwrzITA2hoQEJL+QjyyjbSH?=
 =?iso-8859-1?Q?10uu89xKnsTNNxmTzFv9+Zs7NzlBt9IZLDBu9CI+c/hRmpQcdpXC7zL8zP?=
 =?iso-8859-1?Q?SX6OTsPJ1BU7BJSB5uW04RXtZ6uvC9w4sWM4hVESswZYDNBcoYGx3uNISe?=
 =?iso-8859-1?Q?BjUwSY1l9J8FT0UpXNyFkubcS84T/SEYQ6AxaL2S/hH0DJ6u4SxcxzEl7R?=
 =?iso-8859-1?Q?BakcgLfA1vmJshY6eedPQ5a3XtmWKCt94Ioh7sErv9k9W3XLZo3jYMntBh?=
 =?iso-8859-1?Q?AdrMA3csMz7XyFiUvKmPV7Wh263QuoODzERe52sCLn6PI70z4M5sZOqTjC?=
 =?iso-8859-1?Q?LsoNttiVsXuJhEsljrkIZEK1XBttmFZsTorzTHh/mJKMczmnUjr6GoH5z+?=
 =?iso-8859-1?Q?pb164hIxxvlpyxq1dq00BXqnfX2UK/jzkfv03m4RWvu5i4zKrEi0haHiXu?=
 =?iso-8859-1?Q?gJSGKozNlfEKZ9PU048pS+aRTuunnQhP4c6niNohnQK7bYqeinn2dnNDiy?=
 =?iso-8859-1?Q?z764wFsA7ZZLZr69jcHQJnJshkkA4Tvv+9Sw5YtbukOLQMn8X+Do59+g08?=
 =?iso-8859-1?Q?IhU3stHwHy9ksDNmGDgLfkNkxr5yWOvU4wxTzozfdqWH3Ozm7cB91RQMWW?=
 =?iso-8859-1?Q?/1MyEOqFCHV+WoTmlUuehb07qD/aBnkmcIMH+ONQ0mYw1ImotLUNiy4Lcd?=
 =?iso-8859-1?Q?1g3JSt6pfq5pjTDuhTes/eaTlNomnaq78j6Nyr0LYj48RXuU32Rq80klRm?=
 =?iso-8859-1?Q?bFKbg+WidJBtrZYpYzhFzfWPEGI9c/9D9CQIH6Uhs8M6S4wFW3WNdScvKN?=
 =?iso-8859-1?Q?K2b1lnH2fuynSQqjHYQwJzOsRuD/cUv5xcNobMuF8Rf/4dX8M3xesPYUtG?=
 =?iso-8859-1?Q?65eP3bRh2g43iWBOwJBL4UBvSdvof3j4cofXPj1oKkHbEW41JYkIz/wk6u?=
 =?iso-8859-1?Q?euXCb5EunzpwIOMdm1UwKjF8ck+aotafmrH0kj6Em08rPsdJGJh7JzJllM?=
 =?iso-8859-1?Q?ltQDdBoE1rLRKQD7R6HOxRGnNfnXO+/rYmzBDtIZdefyxKDDx+Onn4eYJT?=
 =?iso-8859-1?Q?pmJVaWFERb2IEYZIuvwDsIJWgKN7kgtPQ+g5U4m8u1E+PMrwkDRmwpS+xR?=
 =?iso-8859-1?Q?wgvc/vSnKx3CKzkzmVXzzoR+8BXrN0k74M9BHo438ipZcK60tdjxo6C8Oi?=
 =?iso-8859-1?Q?l5vqI2W7j7/Vdi6FnBF7g7lQ1rdzeKHkHarATxlsRpV+JitLwQpWH7xdsu?=
 =?iso-8859-1?Q?awlNRafXSNfydlpUi7YSC0E2ags3abWrZp2c8sx8HEgkqRYXOJlmEIYLcS?=
 =?iso-8859-1?Q?RuPDD09IzTYGerf6KjjMz9m+V3ZIBb9AOiWoFOXbM2kuk6wbLYCgGOZ61x?=
 =?iso-8859-1?Q?9WM5SDS7uKq8sUTHTOgPxad4QTlmNsgS4eo9YRK1goSE9DnYad40GiNRGz?=
 =?iso-8859-1?Q?6u/bFXgfcPXnu9zc+LYlnjiisFMNknCfrLvrPCgCAFbgJgwFj55ell6grk?=
 =?iso-8859-1?Q?kMoNKJcEUsyME9lDowDcNv6slFKajvQmd2/iOd9nfJHXl9qM5zUqJtni6B?=
 =?iso-8859-1?Q?t7l65+vmCYvyyfiw54r8P1FGsgXdVscmZhTxAhnLTS7KNiwaPkMKtihlkV?=
 =?iso-8859-1?Q?po0f6EiQdWfCCfgbe6Mx2oj/Smn2CWzCJnOVrmCKI8pRWrpvSlhc64BRou?=
 =?iso-8859-1?Q?53?=
x-ms-exchange-antispam-messagedata-1:
 uFgpMyRcb6hmFiIcpxYX+XO+yZ/h7Rp2ZLa82wyh0jwCIUK8FXsE7h8Q
Content-Type: text/plain; charset="iso-8859-1"
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
X-OriginatorOrg: atlr-engineering.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR06MB5324.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054091b9-dfd8-48d1-078d-08df4ab69b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 05:40:25.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba695f87-644d-4185-a9a0-94d2dfd2f6c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +i7bTcoZhPBY1PjI8ccHJKp0fURnnbC72Q/LT3dDyy9vvIWONfCx1fvaqbcYszptKB+zMcF2zXiSqPOMvfwggUDjHFWJjulXddBHQlQ2uvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6626

> Docs say this is really a rising-edge interrupt - perhaps the driver=0A=
> is wrong here?=0A=
=0A=
I tested that on a Fairphone 2 (DT at EDGE_RISING, patches 2-3 only).=0A=
2 of 5 WCNSS crashes never recovered: wlan0 re-associated but no=0A=
traffic passed, so the DXE interrupts got lost. With LEVEL_HIGH, 12/12=0A=
recovered in ~20s.=0A=
=0A=
________________________________________=0A=
De : Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>=0A=
Envoy=E9 : lundi 23 novembre 2026 16:38=0A=
=C0 : Alexandre Rapaille <arapaille@atlr-engineering.com>; Bjorn Andersson =
<andersson@kernel.org>; Konrad Dybcio <konradybcio@kernel.org>; Abel Vesa <=
abelvesa@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <k=
rzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Loic Poulain <loic.=
poulain@oss.qualcomm.com>; Luca Weiss <luca@lucaweiss.eu>; Eugene Krasnikov=
 <k.eugene.e@gmail.com>=0A=
Cc=A0: linux-arm-msm@vger.kernel.org <linux-arm-msm@vger.kernel.org>; devic=
etree@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kerne=
l.org <linux-kernel@vger.kernel.org>; wcn36xx@lists.infradead.org <wcn36xx@=
lists.infradead.org>; linux-wireless@vger.kernel.org <linux-wireless@vger.k=
ernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>; Luca Weiss <lu=
ca.weiss@fairphone.com>=0A=
Objet : Re: [PATCH v2 1/3] ARM: dts: qcom: msm8974: Fix WCNSS wifi interrup=
t trigger type=0A=
=A0=0A=
[Vous ne recevez pas souvent de courriers de konrad.dybcio@oss.qualcomm.com=
. D=E9couvrez pourquoi ceci est important =E0 https://aka.ms/LearnAboutSend=
erIdentification ]=0A=
=0A=
On 11/20/26 9:05 AM, Alexandre Rapaille via B4 Relay wrote:=0A=
> From: Alexandre Rapaille <arapaille@atlr-engineering.com>=0A=
>=0A=
> wcn36xx requests tx/rx as IRQF_TRIGGER_HIGH, overriding this edge type, s=
o=0A=
> the re-probe after a WCNSS restart fails ("type mismatch, failed to map=
=0A=
> hwirq-177") and wlan0 never returns. Use level high like other WCNSS SoCs=
.=0A=
>=0A=
> Fixes: c7c0edecfba8 ("ARM: dts: msm8974: Introduce the wcnss remoteproc n=
ode")=0A=
> Cc: stable@vger.kernel.org=0A=
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>=0A=
> Signed-off-by: Alexandre Rapaille <arapaille@atlr-engineering.com>=0A=
> ---=0A=
=0A=
Docs say this is really a rising-edge interrupt - perhaps the driver=0A=
is wrong here?=0A=
=0A=
Konrad=
