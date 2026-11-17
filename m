Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.104.111.126
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920849;
	b=vHbNCXGnWfrQfAAxHVzWEEaPQv5GjMgwu07q/aePpx4thZc894AGsRaFTZ2a2wQSdyvQ
	 NjxowrJvTtrd/b8K96cqmY0w6fd4u7ei7w8kxfer3xBRpRumX9jq69b8JcDP5eeSnnKYH
	 hqtD5GMbyTBNQLqdrqw6um4NYRn2pBoJoA1LEt5U/mktXul8/WW6sjFn8iDLFAKqY6aW+
	 ScOpSq3AOjrw1vEUVMoe5PZE0617Gp5O3+rB9Lmz7Butdh1k8wC5dWXrEWng03Gzswsz4
	 H4JvUiCf2J9uRqPgK+6R1MXhDrZz66qNBRHxOypemQWkUX7kH+6DgOIONNdGaXRDSrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920849;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	bh=toIqTCdO9IP7j5k1gednTusKJhkMcbDrqCHtauHu2Ng=;
	b=AwV1itNPi3e8/S6T2MmqJjrozuidKUihSLBreWCS0UIWgC3Kwhc7Yq7SeA+BSOvgrdXD
	 lJ2Kt1OKMJmWzqxnmHZ7hTej3cSRTSmSxqS9A0ZpYzkCP/+UDesum3x2UisjkxGwvtQBL
	 4BnA/ZDNRHdafRqPiIc1BQp9kLkCov/n6ajN51HyjyIx61x0DjTmdT8LOi5mxbGu77vqK
	 mR7Bqnhp5lv18GlIDXR5ykzMg1W/mZogffR+EsStU9qMJ6/QlHeLtSkWIlYvTo0V1OlyM
	 7Rr8jHqM7ITYoH1WqKuGCFvkbnBwpvzcfkp2Xj4Qx63fEa37R2DXVqWtiV/j68yXkLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=francetv.fr;
	spf=pass smtp.mailfrom=francetv.fr;
	dkim=pass header.d=francetv.fr header.i=@francetv.fr header.a=rsa-sha256 header.s=mc20251209 header.b=fGZuFzN+;
	arc=none smtp.remote-ip=194.104.111.126
Received: from de-smtp-delivery-126.mimecast.com (de-smtp-delivery-126.mimecast.com [194.104.111.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98B606A8A1
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F98B606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=francetv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=francetv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=francetv.fr header.i=@francetv.fr header.a=rsa-sha256 header.s=mc20251209 header.b=fGZuFzN+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=francetv.fr; s=mc20251209;
	t=1794920841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=toIqTCdO9IP7j5k1gednTusKJhkMcbDrqCHtauHu2Ng=;
	b=fGZuFzN+V0blgoyE97iKR6sGlJFlwQhnIEZydIcPVPnnGtdPcMLUvflVecR56ook8kzHJ4
	nsYU37ZD6Ov3yMHGrMt2nj4HzpWBkmlvLHpr3fUYnZ3CwFBQg5uvwzbXe5VdmlKc/SQtSh
	eqn5KQZYdHKXZ9vVSWcBoZfdoaciDhVxRZ4LkIxacHM+hfz0ZKX0PoDDLSnGhr8qSxrBsw
	ckGcth0lRceml73uN6vLoRkDbKwvCeaZfNlEds8hn4/0dbIJg9Cm43FsJIj52cfOsRCftF
	PCSeaCvC1e43l2KNRa+HIqRzQGLWxK6fGxM/o4n006GNhKUIoV9XzKQPTJ+SGw==
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazon11010038.outbound.protection.outlook.com
 [52.101.165.38]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-32-ddDtzi2qOguVb8vrniEhNQ-1; Tue, 17 Nov 2026 13:07:18 +0000
X-MC-Unique: ddDtzi2qOguVb8vrniEhNQ-1
X-Mimecast-MFC-AGG-ID: ddDtzi2qOguVb8vrniEhNQ_1794920838
Received: from PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b2::19)
 by PA3PPF839E893B0.FRAP264.PROD.OUTLOOK.COM (2603:10a6:108:1::668) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 13:07:17 +0000
Received: from PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f6d2:e60e:fbde:58fe]) by PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f6d2:e60e:fbde:58fe%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 13:07:17 +0000
From: =?iso-8859-1?Q?DESNO=CBS_Jordan?= <jordan.desnoes@francetv.fr>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Request: backport libceph CEPH_CRYPTO_AES256KRB5 support to 6.18.y
Thread-Topic: Request: backport libceph CEPH_CRYPTO_AES256KRB5 support to
 6.18.y
Thread-Index: AQHddpRkO62KMFVY50aT4bXNdmrocQ==
Date: Tue, 17 Nov 2026 13:07:17 +0000
Message-ID: <PR1P264MB1805408F7C4A11E6F4D2F6BE887B2@PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR1P264MB1805:EE_|PA3PPF839E893B0:EE_
x-ms-office365-filtering-correlation-id: 195aa3a8-5bde-4a96-7dbb-08df44abb4ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|261009223027099003|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|38070700021
x-microsoft-antispam-message-info: gXNxP81aAjENBywxtHuXAzLHDx58YGkY8FmEMj4M0mKgX1kzkO5GPHEpCCZGps+IjYDKBSVXkT2LtGthqLmvJmF4tuQkhv+S0AY8QqbNHyjgDcdiKpYlrqfeBov55jnUN2qlWVB6kdopdiZ0h3rxL0zFzpjKbLwA73LpSmT3UsjVlo6wDNlcsGfYbnQ6wV2HyJWdFnn0vSqx2JNo0FXpmowXD10YsbnUeCAMgb5y9vx0Gzp0qv4ucMXGMxaa9Y/iSrUrW/2Kci6FrjVwNo8/v35JVHONdIPSIum7hXQ6w5FPwbQ/kRusgvhEnfmX3wUiVmOUnoQ82WKt7HYkXLcD65CdTpKW2djcFOGlmgfwhTFJp2QguT2VEDSrygHpaj/8eS814Jz4jN9RM+H29eti2txv4WxxI3lGMqsNfwJnjyfPlE4eG7BCcF1YN59/4S+qCiqXfwtuOmRU+M72kmIKe3k1UhcWBYpSjVuNhu4A8jwgqV0sK2e6HhLEBmM1453B0VHArRc2oMEDvP+LvQwnFPwuC70EXWI+FH8XsA49I2sbRZhaKMFsREAgsWzZ3WmDWhqIsXn3fF1Dw3If5dodxwD1gWQAanoqlmzdmEo0u/fEo6coEZ3lt5F54XI1+cafGTLldZ1djQgI8JLOk+Yq7083J81E55n8tNkV35VbyT+h4kyVWKV/icZcpQOfWsvbxXLCbj61ZzAI1GCdWTmOI9PL+JCdvrnYsP2IUiJjQgM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WsFy0Dj39ztSVqCNguOsreeukc+cZDhT3gssCuEXfLGCJw7wgCvzKlaTVz?=
 =?iso-8859-1?Q?54sxB3tGFPZYO/Zzu/uCT0DfCLrb1XThi7gQPb30g59FIXrXF3gGkT9fTY?=
 =?iso-8859-1?Q?ULB+e6DWz6f7PTlku7RsdEtaiNqw0CEJYsCGGzTbZ4njUq0qHho/ORHhVy?=
 =?iso-8859-1?Q?umVuoaYE3Lp5jqCebFP5fTI7Xosn00YYKLxbFixE3WzVfP/gAAUa39lj4k?=
 =?iso-8859-1?Q?mJz2R3g/mmcXpr6YcmIdbR2I7QMNkkH3NgMPB23egpE3O5ETl7fnWeTY60?=
 =?iso-8859-1?Q?4rxuIhirdGQbixvqjCpWWaLNbW7e6buH5ARI7svUx5eRN83nj8rg9ABi6I?=
 =?iso-8859-1?Q?gJa9Aji88dzjQUYc+DO6sqiStqITafmH8To1Mzp+7TcJZgG/BX5unfghkR?=
 =?iso-8859-1?Q?xvgL6OBKNQiH4HoSb/W+XHfq0wGkHfb50OiUbFBFUl3MQJz8HBAg9spao4?=
 =?iso-8859-1?Q?LpLR7RhBRJkNR/35pmj9sV9BELDh+oG7xg3lq5Ezm15/u1qk+z7uOH9vFH?=
 =?iso-8859-1?Q?5/lDBKKZC45mQAy+eX1H/mZSCkconMs4MLQ6lFx0atnltcmsyMxRaE5FLo?=
 =?iso-8859-1?Q?vLFULbzQ1JaEqpnOlLuhPQbLzVAUSdpe4vXY8yX1QluB0rROuepOccZ9QE?=
 =?iso-8859-1?Q?194PPPl7p0KoI86XEKyPQUO4Gqyw2b6UgTvsMXCG7w1niYTXmrUSGoNhgT?=
 =?iso-8859-1?Q?ZqKnEB/6wGXDo+Dl5jV1XR+i8Gu5LL5+5+svlcImdSVc0RBc1T2btV9uoq?=
 =?iso-8859-1?Q?NdPvkssPvGTDqs+PsgTv/Lfpy3ZpPnbyRWMpRVYGW+8BCb1QLUg6Ur/GW3?=
 =?iso-8859-1?Q?fJeCe7O9+ovfy5EFjav04agaXNvvhBI9pt9Yar6F39h/SrJMU2dWnBhMt4?=
 =?iso-8859-1?Q?wQbyb1jEnqwCcYCohHlyRqPABm+v6RT3u8TCul2cVjjjIdG9faMbAGSpkr?=
 =?iso-8859-1?Q?XsxGhHbhIeT1sSaNO0Q5q6XTzZ76QQnwtb2gdTz1LT2xtIhBcL85K8d/Ri?=
 =?iso-8859-1?Q?CNii84rRM/p3WIgPRI9K6RNZCtkTD3Yl5AemQrjC0PcH8CpVxmQoZ7bhVj?=
 =?iso-8859-1?Q?uGG0sS+UJwglaHzepY2lrUuk5iw0/PWHOk2oUXORvmK4VR19ikuzYUPSiP?=
 =?iso-8859-1?Q?c0Z8TU1Id9ni3m0SXUI/W3ihnz2g398NJLPDrc4ubEnUvm+0aszKBGWJcm?=
 =?iso-8859-1?Q?AD6YyJnkhsDeuV6vqwoxYa8B2047EHalIzJa5+BPW61OkF1yL/v5CnJwSO?=
 =?iso-8859-1?Q?YErloNl/GbqAC/xMlMgOnzJnlg3K8j3gocWhH9JTkmDJcKkmQ0yaUSf6Vh?=
 =?iso-8859-1?Q?mDnZ6IrZAzLIjALZsB/xXwyks8UMdVm90VuOtzHFRFGbF+TqGjfBLpEpmT?=
 =?iso-8859-1?Q?vkfwTRG6wqLlnav2gtDZGzZTamJxrWqYQE9Oof7u+7AllXAZSD1pkWW1Wu?=
 =?iso-8859-1?Q?Rkq/a3QlUjI4d7p1SEr8H5aze5ZPgX0/0dvSf8ssUrT3IqpxvTA8HhgkOM?=
 =?iso-8859-1?Q?R0AdELtzoe1Y10l2kLQx1phRTKrGXu2XCBJmShLb2qBR2zXozf5q+a/UGg?=
 =?iso-8859-1?Q?KYVbCRi1StbTaAVrghI4N9oYoHTuA4xoaTDUv7yAgFKkK4MqpBbU/TiR4d?=
 =?iso-8859-1?Q?OH0PU2s4PQo58tg1p6XwwVQR0dqktKthR355Cz19AlNOT0KgnplBZB7uTL?=
 =?iso-8859-1?Q?eEqr1wiwsciKL7WBA25VUF6KK+q7CC2ApDgYipYzzB6hbhssFZV+/rikm9?=
 =?iso-8859-1?Q?ZIKEXxNe8HQSvwP7fI/EZ0tVuSL59vCDav/ffHbkXW/WxDH+TSp3pgptI6?=
 =?iso-8859-1?Q?JW1pK63HPQ=3D=3D?=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lXw8g9rFfvbHhbJE9eHAP0P0AXbDp788MvTCRYl8mtVhi/7ZZsJCPrZWwJqS9aHguNaT+Y817qHrb5wc5UguzD97ayWOPB2MouXNNl2ZyOgUXZZ4BrmAYWLffqT/zzgCFPIHe5U00QhD9hUsiFB6DbTmL9mr7bt+NA3mKzAOQU8AeWDtusQeN51PcZQGTOGCQlolIGSoEwbcX4lmF1dFDWv1rDaiJSjaB/g7jZjCbSisc/7QudLcIeKzPr90X7OAlLn8cMIh62OqGbJ4S6dDD3V3Xpm6/jSg9XH4+vxo50NK04eAY2MPLuyVfZidw2HKPqKrfEX+YUITJbBHxDcSUQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 44xcunWBSulYMO568VL7jv+DPzqk8rgmVpBgpDg5Q7T9IjKiXTU7pNcNK8UCabVDA72WtO9WVCSE0ae19X60fKKwakYhkzTPyYer5Y+CkY+7YzA5aYkHHSBWFA1ztj6FK2vFO1nGCdbegu83AAstYAY1ntSFBSlCRZIfTnjxYgmYnfdAlB1mVuE3Iwv+rdrjrERbrL8+Ea8LnvnjWnUrrGyyKcAJpyUbtUVAWorcKIpOc5QLFJdGPSTeCpj8Wk6KAhkOdgbBHURCIl7v7fV8PZd+c+boL7EuoDHBLByJp4Ycp3HSGxK2uzuynhmfBRAI1bor1f4lJPW4wgQ9qj41DHnBbnJfx/l2jjkpubFWQFh7iUU1gN5uKC57bIpZuK9BtKOlME+fswWbHDDYSy7MN6lJjTuUevC3Ang3B3eBf4GdxN3cKEqwRptb4RlU6bNHQF/QogNbq8iSDKo0W1fw2XS8cb8PlBUTHl4TLFLcDvG3v36sOOq1hfTTrBAegU1HNMbHPfLL9Y40C2/nRUP6dNS4jP/00ZZzG5/DMEHx1z61ftXZfha1J40G97yExNsf23UZesz8n5xJRhd6JGEAx2Xk5pBugQJE7jA0mKzUgChDOxhJpewy2gcog60cfY6D
X-OriginatorOrg: francetv.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 195aa3a8-5bde-4a96-7dbb-08df44abb4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 13:07:17.1593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aed0e243-afb5-4e96-af34-ea4e5df4979e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2j6J2OQqDqI17A1XyjKoXDRkJsEc6S3UgUox4Y1wO/ElYDanw/HTbimAHRXlK6Gux96xPRgupyS1aeQYTRQyH7FwdG/mIru6KIe88YjobQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPF839E893B0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PNWCWMAFKQ3YiT-J39BzxqlckvzEPSzAFhZOcAryCis_1794920838
X-Mimecast-Originator: francetv.fr
Content-Language: fr-FR
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0AI'd like to ask whether the following libceph series, merged in v7=
.0,=0Acould be considered for 6.18.y:=0A=0A  0ee8bccf7396 ("libceph: genera=
lize ceph_x_encrypt_offset() and ceph_x_encrypt_buflen()")=0A  6cec0b61aacc=
 ("libceph: introduce ceph_crypto_key_prepare()")=0A  b7cc142dbafe ("libcep=
h: add support for CEPH_CRYPTO_AES256KRB5")=0A  8356b4b1103b ("libceph: ada=
pt ceph_x_challenge_blob hashing and msgr1 message signing")=0A=0AI'm aware=
 this is a new feature rather than a fix. The reason for asking:=0Aa Ceph c=
luster can be configured to only accept aes256k cephx keys, and=0Athe 6.18 =
in-kernel client (rbd, CephFS) cannot authenticate against it=0Aat all. As =
6.18 is an LTS kernel, users of such clusters are left with=0Aa userspace c=
lient or a downstream backport (Talos Linux carries one [1],=0Aand one is p=
roposed for Flatcar Container Linux [2]).=0A=0AAll newer stable trees alrea=
dy have the series. It does not cherry-pick=0Acleanly onto 6.18.64: 6.18.y =
already has 821365487aa5 ("libceph: Fix=0Apotential out-of-bounds access in=
 __ceph_x_decrypt()"), which landed in=0Amainline after this series, so pat=
ches 1 and 3 conflict in=0A__ceph_x_decrypt(). The resolution is trivial an=
d gives the same code as=0Amainline. The CRYPTO_KRB5 dependency is already =
in 6.18.=0A=0AI tested it on 6.18.58 against a Ceph 20.2.4 cluster restrict=
ed to=0Aaes256k: rbd and CephFS via ceph-csi, map/unmap, reboot, and 24h of=
=0AI/O across ticket renewals.=0A=0AIlya, would you be fine with this going=
 to 6.18.y? If so, I'll send the=0Abackported series.=0A=0A[1] https://gith=
ub.com/siderolabs/pkgs/commit/2da2cdcd7c19=0A[2] https://github.com/flatcar=
/scripts/pull/4363=0A=0AThanks,=0AJordan

