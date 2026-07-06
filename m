Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025F39150D;
	Mon,  6 Jul 2026 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325551; cv=fail; b=MtGT0jg0elg9wapkZW9QYvpa646G6XQZCdbcGpYfp9uZQ2oXbl864RLzuXBontgXKx+6pfTuZ1u+3kMeGgAXasUz0ZwJtJQhrOV3WId7acddd7ykGIJ+u7UVZpPlMnP6YTWXiCGKTKCh7GqHr/F3QssRmVo70U7vfCLI57aYUpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325551; c=relaxed/simple;
	bh=RGkytGD56MAEgifIUG1hNo48VxR4KLXeNfFy9EqWt44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tu+rPtmfUftpSTn2y+Z7sPDtUDLrzuF1AUy0hwFXcrB27jCEnL3M3jLICNxY06zIVRari4TQ3WLYakxWq7yiGBDiWjM2esZPC4m86NKb6hfAXkWX2gXfdh8RsifMQGreapnAHpqSqapAaRdFtnJkMefimNzktObaSe1B05C9wM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=MlplHtTw; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="MlplHtTw"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MvNYU638670;
	Mon, 6 Jul 2026 08:01:01 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012023.outbound.protection.outlook.com [40.107.149.23])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4f6rhvha2t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:01:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBO8AvpfgBrKKkyONIlAIXHvyDVYOpEe1TMvBV3qjnnWKu7s5n6f4nd4viTia24WGpWlWVpNFSkvne/7dmDtn+s33KdeNlw88rRm8cgIEFltz+99x3XqQFTjoS8ko/VoJkB1pNISS55Oufh3vSvFOX6C/7Sfj6STLALDAk8KWBXJGY+y8xJAJghpYISHEcZInqqh3fb5w1HDNF/kLhtW8gt6760NXoXDVqXySpvHZZsd70VUt2Wyho012HGFr/J1Lbotww2qZsbZV6O+gbZYyOo1tMpUDHaPv2glbqRxvoGuOkAu9r8p4ELW5X8xOVWLv827Dy77yfz3OKAZZIvKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGkytGD56MAEgifIUG1hNo48VxR4KLXeNfFy9EqWt44=;
 b=zOw3I3AErFhc3y52gaJkTBTihqWFI382sqyTqCg5To3yx9Gf+hVwhMsedP0XR2HOFn7TLGJBasOdYnnY01F1iONFiKPwKF/hxdDsZy3ne2oaqG3ds6j/5rPN/pVALwA7xUf6lWSyThxIpGZrJ3f+ElktlNUV1qMiE/MYmdErUVc5wwJjpm+htKtOy+Z+RSiWRr8kUz1rCOjge1oP6I9HzHMd/c36bBoxtY57EqhsN5JZaIVQt8CVRyUL0H1i0O0u0X99HXt3E3ZMPruwhfnYsr8ZJEWDMIIryFl8WWQkZoZy7VQt8vAV9nUlGxUVchyr4Tbrp8gAkG4pn+1MzbXPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGkytGD56MAEgifIUG1hNo48VxR4KLXeNfFy9EqWt44=;
 b=MlplHtTw9LJfro87eEEfK0tJOYTMzFDFuoL4Z/UQ9hz8WBNwc948BLp1vJNZw6WjXoKu1jNjcGzpjMMSg4qMYJ9Ts6xjwv0eAc3XvPL6ocMyh+tRe5U+zRUs56cFGyPxXbrsl2FgL7J3Ywyna8O2x0wFMIYx3dwx7WNr1Z8Qk2VXTQS2nvdDub6e/ytQiu5bgv/q3Fclf/6FzltQq5cn//hZrHHIJwnWNTVD+pjZUaURoovdO+s+Cjv48MeYuHtfdAAvUhjJ06fUdqkDDfQMXnVkeD58XHr6C0U11ztlSVZJGHgnTSxfaJajxNulrqcUKD0iMUAjmX2aY6yJ1hmmLg==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by BEUP281MB3618.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 08:00:47 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 08:00:43 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol via B4 Relay
	<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp clock period by
 using lower value
Thread-Topic: [PATCH] iio: imu: inv_icm42600: fix timestamp clock period by
 using lower value
Thread-Index: AQHdAxu+cE2mHNJ2kEmDUcLwMYfkDrZcNr8AgAP8VFA=
Date: Mon, 6 Jul 2026 08:00:43 +0000
Message-ID:
 <BE1P281MB1426AC573E4DFA75DE2D522FCEF12@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260623-inv-icm42600-fix-timestamp-clock-period-v1-1-82184d2429f4@tdk.com>
 <20260703200224.69d60475@jic23-huawei>
In-Reply-To: <20260703200224.69d60475@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|BEUP281MB3618:EE_
x-ms-office365-filtering-correlation-id: 5d01e2be-46a7-41e2-7fda-08dedb34adf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|10070799003|38070700021|3613699012|18002099003|22082099003|5023799004|4143699003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info:
 ucS/f622iK02Ym2m5skDFC0nNzUy+VrKrAEBf4G9RiWe3unbCodXtfkABVmfZUk2xTow+AcHHS93iI2AlzaWXJVH0eWCMnIUBOXu6ypD5Pevvcu2VpN4tK8LsQ9BPwlOPRZQRrEIQr4zADI7zu4XKQquZm2tXE5KAPan3z3tFwXwuO/QAzIUbJYzwfGYlBml6WBcaSmZuf5qXjlnC8ABaIyH2B+DJAXoMqBWKsUxpP4rEiLyyAc64ZN+yoF2DqPgoLxLH/SY0OOI2YVULBIYKHYaw5FIi97l3eyGQpAmykDblVdQz0KyMbH4ZuU3d8vZPVXsr13+leJpv0psQablUhnHqVjiME6ZbMQoeZOPOoOr4K016JBPxJgMpAt+iNNh9ng049NEs/zHtFvpTpxWhchDCcTd4CBSuPemPiY11kYAZ86eBOcbR5RUMB3fO4BoEmDKAnCFMZwMaL4qJgb5XEXQRruPpOYuMK3Qx1ef/b9+HKD+g2Fs3TSAHBMMAbx9zPJfpm+RoXmjmZ6kn6FrjW4ETcUxAhWF8C9nOFlknhvrsfs2oLh1S3G1BKj4TCLYuBfXY9olFwHacVsrtMmpTpj9f3j6vM7EdtytuEv4/SGUHHAnUl20PdL5UMeYSLJGKoga7WdvfXpLwL/Zy2bizcv8ID0TPnukNC/P9bVWBPb1H0iEUf5DB8t1vugwC02dzkvNygjEtqc5d7B684da9M0JtUYx9zeyNJDt4C66nHAfOE8Y+AB6jiSwkSd6HHP2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(10070799003)(38070700021)(3613699012)(18002099003)(22082099003)(5023799004)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dCt4N3RSOFdUN1B4TFFpbGdpVGh4UmJ6Y1lDcDVOd0dGRFlQQUJWZCtIb1Nw?=
 =?utf-8?B?dkhRamk2WGxKbFpENXdmSkxGb05WdjBtV3JQSlJlTEhveWRLQVczcy9NbnJX?=
 =?utf-8?B?SDBqK1ZTQmlFTGllZ0tzMXJqUnZoWmVZdjk3cGt6eG9Kbm00ODVEeGo5UWFr?=
 =?utf-8?B?TG5HQW1lcE9YL0hNVkVmbDVJWVBYMkx6UVUrM29mVkdPRjJxWmZBOWVZd3No?=
 =?utf-8?B?cjJTWHZDaEo5WlVYYkE1NFZGcmUza2ZFNm1lRWRaQWpHaWRyQ2xldzc5QU1y?=
 =?utf-8?B?Rjk5VzcrcFRHdlBydEhnTEFVMzNOMGpGYTFGYUVTQXhOS1E0YTZiZEQxYU1X?=
 =?utf-8?B?c0ZjZklDRXVlNCtHMDBrR2Rhd2hUSzRIVWdaWUw3cVFTYXNzeVpjUXBGNmZV?=
 =?utf-8?B?ZEFGM3BKOGhZYTI1SmNubnh4UEI0eWxUUzVWRzQ5RlVsV1k2b3dqdSt4bG9z?=
 =?utf-8?B?VVVnL3lBSXNGUnJKeG9vNkY3WDZQT0NPeUJ1djVTa2NmNWtyVGo1ZVZuZmtn?=
 =?utf-8?B?K2dVSXdReVVLZXZpbkVaWjdYR1NlTTJpTHB5dUV3NkRPZ241VGFMOFkra0V0?=
 =?utf-8?B?UlozeDhTODlZeDhxdTZCVXlQRWg5Sjg2THhBVTFpeTFSajFzRzFrQlRmQjNq?=
 =?utf-8?B?cW5yeTc2KzdUWDYvVURlZ3dnaEM5REZCMzRHYm0rZm5sVjZ6K1gwUFpCSHJC?=
 =?utf-8?B?M3grRHJOZzQxN2lMcnoxRExTdFRxaXVtaG1CdFZ0ZU43TUJzdW80a09hdWow?=
 =?utf-8?B?dGk2UFM5VjdZOTNZa2hJL05QZUQrZlZoZ29mbEpJUkR6V2UzMmlTWWsvaFc5?=
 =?utf-8?B?eVFLU002MDZaWFZDQVljV3RNWXZXVVJoMzlOcm1IVUw0b2diZzhrVkZRMEhl?=
 =?utf-8?B?L25lNXFnUWJMbjc0dWc1RS90dUtLazJ4OTA2YUVycmZKaDBscUVMall4UzNV?=
 =?utf-8?B?RkQwdDJoS3o3Q0xSeXZORTZibGh2amcxdXUxVmZVWTZWZUE5Q1NPSmp2MUU2?=
 =?utf-8?B?YW5tam1PNnBqQVRscFd0dVJoQ3ZtUmQ3QTFFN2c4YUN6ZHUxbUJKTlZXZUZm?=
 =?utf-8?B?KyttZWxFTjlxQzl5bVNXVXJmMEFxbTNBY0kreHI4MHNxMmRoZHpxOUhOakRN?=
 =?utf-8?B?eE5Qekgvb0Jid3FqMzlQWWU4RmlZeUlOWVNPNE9pSTNlNGF1N1ExdG5GdURR?=
 =?utf-8?B?OTJRV2NtTU4xdW1VK21ZVjVIY2ErZkZySzRPTzlIMng4TFk2ZHY2RXZUelNh?=
 =?utf-8?B?ZUJCbER3SVVvcndxRkxFZGt5K2grbTN1SHgwUkE1YU1VMWh3TXpiTmk1UlYw?=
 =?utf-8?B?S29ENThEdkxrd1RlQU9HaERvaUVyZDZVT09hbC9CVE4yY3hmMkRETkkwYzR2?=
 =?utf-8?B?KzBWSHZuRUtGM2ZWNmpZTXBlNGJ6T1hUQmpjUWFNeUVUZlZqOVM2ejRPWmkr?=
 =?utf-8?B?azkvcytWaEFDL3lQZ2d4QUplSTIweEhrSFA5RDQwN3h6MllKeXRMK3hsMUw2?=
 =?utf-8?B?VWtSZVhyOTY5emVyamR1MU51dHhtODlWRStTUlhCMDFTNUhLanp0MFNXYWcw?=
 =?utf-8?B?dUZYSUc0RWRUK1VpbTRIQXBjN1BCazNRSlAvVTBNcDRLQ1orbUM0WkZ5dTc1?=
 =?utf-8?B?alM1bkF2WE9UWnRRN2pGVHpmcmFackpsWDFUWDRpc3BZcVZDRkwxd3I4d295?=
 =?utf-8?B?VmhLc1k0bURGNFRBUUtzb1dwV1hwV0lPc2MzeCtMS21YM1I4KzJVbVhsZTMw?=
 =?utf-8?B?ek1KUjIvbWhnY1dvNWMrWnJsYU5GVG5uSktIR2FVWkFIaFVKdUQyQW1mUTdT?=
 =?utf-8?B?Ym5USmJmMVg3cEpTcmZDQU56VWVWQzY0QVhFL0h3RUM2ZXVETFQweVFhV1lk?=
 =?utf-8?B?T21HNjZlRDQ4blYvdm9hV3NJdklxQVdOeFc0Q2VXUGRtM1dKTTNpV2Y5Ynp3?=
 =?utf-8?B?clJoaHZnSTVxQUxKTzVabTFIcVB0a011N2JRc0Q4WjJrdmptdXROaUtNSlZI?=
 =?utf-8?B?ZCtjY2NhQkhhU0s5bk1RcFlaRXhGUnFwZS94cW82eEppV1pETmpXdEdvaXdD?=
 =?utf-8?B?VGhHWlcrbXFQZ0xwa3pZTXprT1RsU1NtWHltQXpFdituTUt5L1BnQ0NTUGpX?=
 =?utf-8?B?dzBSY3BIcEpCcEFEc1hmcFpBTjFka1FiZ2xWMGs1TEpXdTNSRm0xMmtnR251?=
 =?utf-8?B?ZVZubDh0K3hUR0c0c3lSU3lackE4YzZRUU02UHNmekpnVHp0UVMrZ0RwMEdu?=
 =?utf-8?B?OWF1Nm1CZDJSNXllTVdjeFlHY2hkdFMwNmRQQlcvalpjQjIrL1dUaUowV3hM?=
 =?utf-8?B?TGowTWkzSnJLWjF1TytNVzVBRFdnQldrOEloY045T0pYOUpTWUg1eVVHUmd2?=
 =?utf-8?Q?1GwKXRinBWpVWA//WHs+wT5Hq8p3FIJ6axog5D5x4rsPq?=
x-ms-exchange-antispam-messagedata-1: NN05Y1H6AmC4HvHh0NXscEDbPiZSksQeHzk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	M7zeEICTczL9vVR6roWvh3ndiMumUN9F+T+60HMiI8EMqzboJIIabqviN9jdq6yboeJEMsnORPCKWCWcj07mjv464X7BcH6sGdZvmdEnNas+yf8wdMchqhIhlQjQBm3Nzqox/nxP//lynXIlxW/ipaVafq3whuUvUjmMAOjTTo4kvm6cuqvggLr55E2SSS51xYjwhYIC0mwAkTg8MkqlFQCo+80Xu5mL8OqxZqeeFN2A9GIv3dGAkG9CxNfIsfCnx4waNSxg3ee1uU+sQW0fZPWsL7gT3PuCyqi/xWiKBkchJm2radTux1EKP62G3CAFG6XGNeG/8w6gD5FJTQzH4w==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d01e2be-46a7-41e2-7fda-08dedb34adf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 08:00:43.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsJGv2TAzPX4/1/0YxSRjdkpgb3gFdCaivJmOrkxYQzLYBXYVtvywxCH+E1rBLlIWIClJv9eTPjLgiRICwmk9dcrqysId6vYM7g0/FpObCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3618
X-Proofpoint-ORIG-GUID: x-JsUhaOt9VwTggKjDORpfAG_LdeFBH7
X-Authority-Analysis: v=2.4 cv=EJk2FVZC c=1 sm=1 tr=0 ts=6a4b60bd cx=c_pps
 a=N2ol+Y8Rty2aEG29Io+oCQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=VwQbUJbxAAAA:8
 a=In8RU02eAAAA:8 a=x4eYViDw78l5cAe9M_IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3OSBTYWx0ZWRfX4JZP7ypyGEs1
 H6giMzgscYVou4ks0Ssa7FAIDTNMcbVHW+EUIw5CDVzaHEOzakdteA2Z7teu8ULzF3aPGGxT4JU
 fBGS/4SucEwCYD0FRJSsFh6ZqTmYRlBmEHSgwecB42GUitQSd4GG8nrtga1EPmTF91F2qyS/+DE
 wT8L+WGb7SqTbLaEo9RC+ZX5MAB1V3O3wueLxqGgryef0nSIywkMMb4CgYIgfdB5HXwfdCbSgEq
 zU0hdU3K9ypT4zD2ZmNWXcEqlsBLuyL35s84jloKA0o3UvkNMY1FHHMRpVCzQXJGxazOShjo6es
 W3M6cXuwNkg32h2tkYekwGLJ/y+LQWPD7ka9Z6uYjAjElOXNMOtBpkD9p1HMKAGBDW1XCQ4ef11
 FnMF5XF7SzQwKCYvdB1bPljt1+zNKzhhgDwDZ7Gc8DtdpcyG1BjO7743imOTid54qGT4zPHpWvm
 CxFiZhlRlAHLuOrG/+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3OSBTYWx0ZWRfXxVxOR2bSMB/P
 BtQEf5yag0HK+nNs61/yOb1/Kr6MY3RZIOL06b91eXZc0TqjIyior1okZRda0vuQpHe6m6hNSh6
 XzR/PJYeHj3zuXTio+Fo60BJdyPMhfNLFFJMkY+Qnoyl8IpcT+a7
X-Proofpoint-GUID: x-JsUhaOt9VwTggKjDORpfAG_LdeFBH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060079

PkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+Cj5TZW50OiBGcmlkYXks
IEp1bHkgMywgMjAyNiAyMTowMgo+VG86IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgdmlhIEI0IFJl
bGF5Cj5DYzogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbDsgRGF2aWQgTGVjaG5lcjsgTnVubyBTw6E7
IEFuZHkgU2hldmNoZW5rbzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+U3ViamVjdDogUmU6IFtQ
QVRDSF0gaWlvOiBpbXU6IGludl9pY200MjYwMDogZml4IHRpbWVzdGFtcCBjbG9jayBwZXJpb2Qg
YnkgdXNpbmcgbG93ZXIgdmFsdWUKPgo+T24gVHVlLCAyMyBKdW4gMjAyNiAxNjrigIoyMjrigIox
NSArMDIwMCBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheSA8ZGV2bnVsbCtqZWFu
LWJhcHRpc3RlLuKAim1hbmV5cm9sLuKAinRkay7igIpjb21A4oCKa2VybmVsLuKAim9yZz4gd3Jv
dGU6ID4gRnJvbTogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0ZS7igIptYW5l
eXJvbEDigIp0ZGsu4oCKY29tPiA+IFNvcnJ5IGZvciBkZWxheSAtIEknbSBmaW5hbGx5Cj5aalFj
bVFSWUZwZnB0QmFubmVyU3RhcnQKPlRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNl
bmRlcgo+VGhpcyBtZXNzYWdlIGNhbWUgZnJvbSBvdXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLgo+
Cj5aalFjbVFSWUZwZnB0QmFubmVyRW5kCj4KPk9uIFR1ZSwgMjMgSnVuIDIwMjYgMTY6MjI6MTUg
KzAyMDAKPkplYW4tQmFwdGlzdGUgTWFuZXlyb2wgdmlhIEI0IFJlbGF5IDxkZXZudWxsK2plYW4t
YmFwdGlzdGUubWFuZXlyb2wudGRrLmNvbUBrZXJuZWwub3JnPiB3cm90ZToKPgo+PiBGcm9tOiBK
ZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxqZWFuLWJhcHRpc3RlLm1hbmV5cm9sQHRkay5jb20+Cj4+
Cj5Tb3JyeSBmb3IgZGVsYXkgLSBJJ20gZmluYWxseSBnZXR0aW5nIGJhY2sgb24gdG9wIG9mIG15
IGVtYWlscyAoZm9yIElJTyBhbnl3YXkhKQo+Cj4+IENsb2NrIHBlcmlvZCB2YWx1ZSBpcyB1c2Vk
IGZvciBjb21wdXRpbmcgcGVyaW9kcyBvZiBzYW1wbGluZy4gVGhlcmUgaXMKPj4gbm8gbmVlZCBm
b3IgaXQgdG8gYmUgaGlnaGVyIHRoYW4gdGhlIG1heGltdW0gb2RyLCBvdGhlcndpc2Ugd2UgYXJl
Cj4+IGxvc2luZyBwcmVjaXNpb24gaW4gdGhlIGNvbXB1dGF0aW9uIGZvciBub3RoaW5nLgo+Cj5T
aWxseSBxdWVzdGlvbiAtIHdoYXQgYXJlIHRoZSB1c2VyIHZpc2libGUgcmVzdWx0cyBvZiB0aGF0
IHByZWNpc2lvbiBsb3NzPwo+Cj5MZXNzIGFjY3VyYXRlIHRpbWUgc3RhbXAgZXN0aW1hdGVzLCBv
ciBzb21ldGhpbmcgZWxzZT8KPgo+Sm9uYXRoYW4KPgpIZWxsbyBKb25hdGhhbiwKCnRoYXQncyBu
b3QgYSBzaWxseSBxdWVzdGlvbiwgaXQgd2lsbCBlZmZlY3RpdmVseSBsZWFkIHRvIGxlc3MgYWNj
dXJhdGUgdGltZXN0YW1wcy4KCldlIGFyZSBtZWFzdXJpbmcgdGhlIGRlbHRhIHRpbWUgYmV0d2Vl
biAyIGludGVycnVwdHMsIGFuZCBmb3IgYWJzdHJhY3RpbmcgdGhlIE9EUgp3ZSBkaXZpZGUgdGhp
cyBtZWFzdXJlbWVudCB0byBnbyB0byB0aGUgY29uZmlndXJlZCBjbG9jayBwZXJpb2QuIFRoZW4g
d2UgY29tcHV0ZSB0aW1lc3RhbXBzIGJ5IG11bHRpcGx5aW5nIGJhY2sgdGhpcyBtZWFzdXJlZCBj
bG9jayBwZXJpb2QuIElmIHdlIGRpdmlkZQp0b28gbXVjaCwgd2UgYXJlIGxvc2luZyBwcmVjaXNp
b24uIFNpbmNlIG1heGltdW0gT0RSIGlzIDhrSHosIHRoZXJlIGlzIG5vCm5lZWQgdG8gZ28gZnVy
dGhlciB0aGFuIHRoaXMgdmFsdWUuIEludGVybmFsIGNoaXAgY2xvY2sgaXMgMzJrSHosIGJ1dCBt
YXhpbXVtCk9EUiBpcyA4a0h6LgoKVGhhbmtzLApKQgoKPgo+Pgo+PiBTd2l0Y2ggY2xvY2sgcGVy
aW9kIHZhbHVlIHRvIG1heGltdW0gb2RyIHBlcmlvZCAoOGtIeikuCj4+Cj4+IEZpeGVzOiAwZWNj
MzYzY2NlYTcgKCJpaW86IG1ha2UgaW52ZW5zZW5zZSB0aW1lc3RhbXAgbW9kdWxlIGdlbmVyaWMi
KQo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBKZWFuLUJh
cHRpc3RlIE1hbmV5cm9sIDxqZWFuLWJhcHRpc3RlLm1hbmV5cm9sQHRkay5jb20+Cj4KPgo+PiAt
LS0KPj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2FjY2VsLmMg
fCA0ICsrLS0KPj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2d5
cm8uYyAgfCA0ICsrLS0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYw
MC9pbnZfaWNtNDI2MDBfYWNjZWwuYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52
X2ljbTQyNjAwX2FjY2VsLmMKPj4gaW5kZXggNTMyZDVmZGZmYWY4Li43ZGY5MjBlZjNjZjAgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2Fj
Y2VsLmMKPj4gKysrIGIvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBf
YWNjZWwuYwo+PiBAQCAtMTE3MCwxMCArMTE3MCwxMCBAQCBzdHJ1Y3QgaWlvX2RldiAqaW52X2lj
bTQyNjAwX2FjY2VsX2luaXQoc3RydWN0IGludl9pY200MjYwMF9zdGF0ZSAqc3QpCj4+ICAgICAg
IGFjY2VsX3N0LT5maWx0ZXIgPSBJTlZfSUNNNDI2MDBfRklMVEVSX0FWR18xNlg7Cj4+Cj4+ICAg
ICAgIC8qCj4+IC0gICAgICAqIGNsb2NrIHBlcmlvZCBpcyAzMmtIeiAoMzEyNTBucykKPj4gKyAg
ICAgICogY2xvY2sgcGVyaW9kIGlzIDhrSHogKDEyNTAwMG5zKQo+PiAgICAgICAgKiBqaXR0ZXIg
aXMgKy8tIDIlICgyMCBwZXIgbWlsbGUpCj4+ICAgICAgICAqLwo+PiAtICAgICB0c19jaGlwLmNs
b2NrX3BlcmlvZCA9IDMxMjUwOwo+PiArICAgICB0c19jaGlwLmNsb2NrX3BlcmlvZCA9IDEyNTAw
MDsKPj4gICAgICAgdHNfY2hpcC5qaXR0ZXIgPSAyMDsKPj4gICAgICAgdHNfY2hpcC5pbml0X3Bl
cmlvZCA9IGludl9pY200MjYwMF9vZHJfdG9fcGVyaW9kKHN0LT5jb25mLmFjY2VsLm9kcik7Cj4+
ICAgICAgIGludl9zZW5zb3JzX3RpbWVzdGFtcF9pbml0KCZhY2NlbF9zdC0+dHMsICZ0c19jaGlw
KTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQy
NjAwX2d5cm8uYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2d5
cm8uYwo+PiBpbmRleCAxMTMzOWRkZjFkYTMuLmExOGRjYWM5MzkyOSAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfZ3lyby5jCj4+ICsrKyBi
L2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2d5cm8uYwo+PiBAQCAt
NzU1LDEwICs3NTUsMTAgQEAgc3RydWN0IGlpb19kZXYgKmludl9pY200MjYwMF9neXJvX2luaXQo
c3RydWN0IGludl9pY200MjYwMF9zdGF0ZSAqc3QpCj4+ICAgICAgIH0KPj4KPj4gICAgICAgLyoK
Pj4gLSAgICAgICogY2xvY2sgcGVyaW9kIGlzIDMya0h6ICgzMTI1MG5zKQo+PiArICAgICAgKiBj
bG9jayBwZXJpb2QgaXMgOGtIeiAoMTI1MDAwbnMpCj4+ICAgICAgICAqIGppdHRlciBpcyArLy0g
MiUgKDIwIHBlciBtaWxsZSkKPj4gICAgICAgICovCj4+IC0gICAgIHRzX2NoaXAuY2xvY2tfcGVy
aW9kID0gMzEyNTA7Cj4+ICsgICAgIHRzX2NoaXAuY2xvY2tfcGVyaW9kID0gMTI1MDAwOwo+PiAg
ICAgICB0c19jaGlwLmppdHRlciA9IDIwOwo+PiAgICAgICB0c19jaGlwLmluaXRfcGVyaW9kID0g
aW52X2ljbTQyNjAwX29kcl90b19wZXJpb2Qoc3QtPmNvbmYuYWNjZWwub2RyKTsKPj4gICAgICAg
aW52X3NlbnNvcnNfdGltZXN0YW1wX2luaXQoJmd5cm9fc3QtPnRzLCAmdHNfY2hpcCk7Cj4+Cj4+
IC0tLQo+PiBiYXNlLWNvbW1pdDogY2M3NDYyOTdiMjNlODliZDVkZjlmOTFmM2EwY2EyMDllODk5
MTc2Mwo+PiBjaGFuZ2UtaWQ6IDIwMjYwNjIzLWludi1pY200MjYwMC1maXgtdGltZXN0YW1wLWNs
b2NrLXBlcmlvZC05MzEzMzhhODQ4YzMKPj4KPj4gQmVzdCByZWdhcmRzLAo+PiAtLQo+PiBKZWFu
LUJhcHRpc3RlIE1hbmV5cm9sIDxqZWFuLWJhcHRpc3RlLm1hbmV5cm9sQHRkay5jb20+Cj4+Cj4+
