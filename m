Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895948821C;
	Tue, 15 Sep 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491008; cv=fail; b=gUwrxzk7ieQlFFvjA8AG+Dy2/gHX3kpvpJRnD5qOxEyjgqhqoTpl38C+FGtXlz32QEWg1bdbeVpZH06xgRNsNWakDS+7aHQTF7z34BZu+4Bdch0XXFk39wsfUatQYm0hYr3ZV3z9F5x2MwcEG9Tq1QchOGPSJ2rJJEupIc6nM20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491008; c=relaxed/simple;
	bh=XUSGrz5a4x0eA+3rxXUI6Z/3pmlN9A4Q708DtEwy/Qo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TnGO5LHIXFDbux/XGiubo1t/d8i8t3ruqXa3YvxYehz5Htp1HqetDW+AZ4/ubsZuJGF3syWrxRIYpTFNUCHfM76IfqfhWm3kgv8vsUtV6VED3hl/VfrGi1HQy+nT/nBybtACzChYJpZTGeGUDhyJyqAT3GE3yG1hGLGnPT7fJmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=NFaUj0C2; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="NFaUj0C2"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FF8LSD2533562;
	Tue, 15 Sep 2026 16:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=XU
	SGrz5a4x0eA+3rxXUI6Z/3pmlN9A4Q708DtEwy/Qo=; b=NFaUj0C2TOFd2+EpsC
	HPstn/7IFRa0qXxPb/Fzr5XcOz8qOk78mR/+cfJP/9KgBlanWiNJrh7c0djwsHLe
	RgBCqkHzy9aA5uXXrpPQ+ymH0sO2lLG5rgkJX9SznYd6FqVrZmR7C2NZpoFrfFWm
	KQ8ZNylmK88Lt6BSv6oDq2SyZX2KLJY8FFwTtrIgVui4hej6lVw7jDhsmVNeR1g2
	DyhyxT5Bgz+zGAct1zBUH4efAPRRV3HxzBn43PRQoCWj/yNgep02Q1r+CJmMxmKp
	JlbQf0IAca36B6gGXoPLYd9m7aCoRyedJSl0zkF5x52jptWFtyOkmvcBak/7xe/Q
	uVEQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gq5sw4cxu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 16:49:40 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 2B649800EB5;
	Tue, 15 Sep 2026 16:49:06 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 15 Sep 2026 04:48:37 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 15 Sep 2026 04:48:37 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 16:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx+alQfSguc28MwdufSGBIOGlyOpBgrcShXvPkDH4V3sXHSp+hydA1DVZLvXf128TFq9KNv+u/eljqtvLdp3aFyDqYv5lesuD/teTKMrYtLAlMAg2z4UIE/gSYhkTkkfr98+p3lPnI7D2k15EihAwVoDyDTOjDxtgjyE7fJHV0woTi1tfS348SyY5DOqpDIohe7vqclGTonypG7OGxjpcpeVGeHE2K/WyKwhXRZ3DQjEHbXle8vEtS0mQ9gaUihyjQZ+3thOjXfhTd43QthjzzD8ay5BglbbUwcBWNdZsRwOhZeULLB0WiWp1jVpSz7uoydzXYgpWyFBuTjOCZW5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUSGrz5a4x0eA+3rxXUI6Z/3pmlN9A4Q708DtEwy/Qo=;
 b=KBCF2Icli+NuCGC9G6BBhpFPr4i5GhlPfHe9fwWNz96T9231IA96v5/MQYWOowGxcB1vTDiugUvRN75fAT9QrnR/7J65O4RI3EwJosqLoJWZcZly1gG4aQBrIJjBqS3JycXR3nPWhMYCydvAnQiQVITF2apfSgaAUdKUddn0jQ2xGgjk0bzuv7qdMIAG3T44+8pV5IUQLyMi8loJHG2S+l83NjG2+bPDeF6px5P/CiNymGKmKK04R+PaNiZc94CAngshAEB9pyNh7P7QIgegKRWSMP+UPCTwYQHkCKtVVEeHb9kXjPw+4DNdwNNuyw9vC/RHjXu0PmEoHb1OVlpR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV3PR84MB3580.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 16:48:35 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 16:48:35 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 1/3] hwmon: (pmbus/tps53679) Fix TPS53676 phase page
 decoding
Thread-Topic: [PATCH v2 1/3] hwmon: (pmbus/tps53679) Fix TPS53676 phase page
 decoding
Thread-Index: AQHdRTIMBtc9dKXtJ0KuZ/216AGGBg==
Date: Tue, 15 Sep 2026 16:48:35 +0000
Message-ID: <20260915164823.160977-2-sanman.pradhan@hpe.com>
References: <20260915164823.160977-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260915164823.160977-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV3PR84MB3580:EE_
x-ms-office365-filtering-correlation-id: a26c5274-dcb8-4fac-8e1f-08df13492f3b
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|38070700021|3023799007|56012099006|6133799003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: FWeC/SvcisuP8RwOQnV2451v1zmlBCTC59KDUn0KdERA+4UOFc5qaVAapRDjsT1rkSARpPufpdHG/jbt/spXvcfMzkTCK4Xj0cPEppJ52ng1TdMF9HZw2haHc+gE+fGDVgsJN+9CHg2RZUDCP3OFpFn3gy3OrDbpnkNTq591inF2NIsXlD6nK7KwqojRyPW7SF5VyhlIg2nkGOidZG+RfWbPnlWStcnEkFBxfWtxeYHO8GRJy/j0ZlEmEkLws1cBqA5Wi4nDbL1YEBd47wA+MtmAoYnAQdXnPgp6Oo4n0+m44k4etOrcNKPDm05nwcw5HMdURRLu2UDundfumEnf1W/egLn3+2i0FS30t8LFMhGGmYctQFQh640c5PUVRB2XqQYKQCQgkUKiXWBgx1b5FyUKpWPi071zXpyPcsk5cCuof2rBwSUuOcPCAFu2WU4pmuOmMD2jwD/imGm+uA3ClMtYS+7kv28WcRhZE+L/nhSrntkOoDCKp4xnUEHGYWtREJa+qu0HFjC/BJSgBs5yy2TvczNYT3RJbG75bdVPbYu4KP11X/yg7s4FgK3sVwIyI3rMor4oIZm3ygwpomUQNMq2Ev+l04XjgJONVYlNViJGzpOPVNKEx91DAA1VeXWVDA0SV9HrBpw+9qu2iH3onIBtABG0XlCJOykcN+qRItMF9tM+2mrPq872hcIQGqKTwLcqjhzz0tEsIkJvaXa0kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(38070700021)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVQza1kzZk1QVVh2cmEzd0pmdWtwV01PZ1QwTDdRV2t1eFgzY25rZ2wyN042?=
 =?utf-8?B?ZnV4Qi9TSUgyRGVvYy9ZbDJNZGZVY25LemVCbGh6VzM1N2wzN2JMZStPWHhM?=
 =?utf-8?B?aERjNFd3UUtVUU5qL1h2VkZCTmlrdnFBSUkzY2JvSGYvR29KZWdBYm50RVFp?=
 =?utf-8?B?b3RSdXp6S0xZSUtiNnd6eEo3Rnc5c2gxMTVsNEU2ME55WEVaVmFWamwwZ3Yz?=
 =?utf-8?B?ODRzNDN1VlcxYnBoUWVNRkdjNmZpem14NmdpdWxmT1JUSlg3YWlFNUl1VTFi?=
 =?utf-8?B?bjFTTC9qRmJpSFVBQ1BnSlU1ZUMzR2w1TERTR0hXYW5JbDlYSTgrZ2Y1WVNn?=
 =?utf-8?B?ZkhhTzU3VVBIa3QzU1M1dldIZitEVzBrQytTMHFtbHZlQktvcGRGS2tOaURB?=
 =?utf-8?B?VmJiT1loWkpFV3pjM0pRRm1pR1M2SEMzREtrT2Q0anc2U1c5SkI1cDVteVdn?=
 =?utf-8?B?RVRXVHpyZ2tQUDcrcEI5RXZtOUFzZWowandyTldmcnFrM0d0cVpHZ0s0ZGVT?=
 =?utf-8?B?NEJhZ2dqNTF2ZVAvMGpVcXdqWGJONVJiMjQ3TktqSmR2Sk9teFRpR3o2NmZX?=
 =?utf-8?B?Y25LUWhGMkpMbGtvbmxlQm96cU5OYm83SDh1ZlgrdmcyeUc1WmtpT3hXTEt6?=
 =?utf-8?B?VHJnaHZ3c2dpT2tPSm5qVEhRRlFYZ3BpdXhsZ2dYbTljUDFLZkJhME8rdklB?=
 =?utf-8?B?ZlpwWTJlOTRJOFhYSWNBWWtGK01EYUZQMHZrWDlUU3FIYnU0bkNzYWQzNkJO?=
 =?utf-8?B?eElJZmFBTytkNW9QRGoxckZxbzV6bVE2RXpKRWJUdi9rSWptc0RraGlvMnFW?=
 =?utf-8?B?dHNablR3cjhJN08yS1JQZGtJR3A4Lys3cFRVZG1XOGRXamR1cWovdGx1RkhK?=
 =?utf-8?B?Qkh4QmxxNHRXbmtESFlJS3Rxd3M0d1o2UGxVUlFKbXY3Wm55UlYxTGJKVUNz?=
 =?utf-8?B?RXl3bXpiVWFjNFpNZER6QjJ4a2ZnRTRwQlN1c3hjS05OTTViV3pmL1I5ODlI?=
 =?utf-8?B?bS9WcGErRStwMnZzOTJ2NUVNR1RtbFYxYmY2ZFU3QmdHQkk3aWFVS0txTmov?=
 =?utf-8?B?S1dpTitRbG1DL1B6WFRpYmJIaGhuaW51RjRSckRmeE9PZTdSZlN1R1VKQkdP?=
 =?utf-8?B?UWc2OFQ4QUxNaFFvcmt5bWpPSVRXRGtUTy9KYkJHWWRPWUN6U1dLRWI5Mkl4?=
 =?utf-8?B?TEwydDIvc1B1UWU4OEJXeWZhTlErTlM5UWV3UEZxcU1laTZWVkRhb0VOaWtB?=
 =?utf-8?B?bjh4Z3UrVHpuSS9HbkxkU2JTbTFHU0dMN01jdWMxTVJjK1N6Y1VlVTBEQ1Vr?=
 =?utf-8?B?enNjS1VweElVV2piV2E4R0R3cUg0QUZ4anAwaGRTY0UrK1VFYUY5ekMzVmNP?=
 =?utf-8?B?d2VhcWZWaVdub3VoZGZ3VThWVXBSelY5UlpHd2p1NFZaQjcxVmpHcmJnSmxh?=
 =?utf-8?B?YVlYVS9VMW4veXVoczM2d3MxUmxpaDVCakROc1RBYVpFUGI5RlFZRHhGQkcv?=
 =?utf-8?B?NVBVc0l5K00xZHEwTVJvcWNDWlJJcTlJblZXbDFwRzFVS2J1V1d3OUVrRzZ5?=
 =?utf-8?B?ZCsrekw2b3A0Y2pmZEFMdnNpbCtOTHN5V1hXSkRIc1RaZ0hpSzBSNkF5R0xJ?=
 =?utf-8?B?SVBBaTMvbm5NSmM1c0VRUEozWHdWa2dRTWdYa2w0NkwwY0pNb3UvcUFKVFBu?=
 =?utf-8?B?RTNzU2hmRno0dWZQcmhteitPOWpBek80NVZqYU9rRXRSMnRFRlZrSCs0QnJk?=
 =?utf-8?B?UUpqR1RLRHoyMGwvbUI2elJjTnIwN3pWeWNPY3huNUk0V3oyS1M3dGt5NU9O?=
 =?utf-8?B?S1MrellucmJlTFBWc2hhK09yem5iZGd6QVlKUk9RdStyV09WbGlTSzd5SnEx?=
 =?utf-8?B?NG1ta0o5Z0xva09vbGdySWtoY1lYVUZyRzg5QllrRC9MNzdycHFwRTRQN09U?=
 =?utf-8?B?STRhZC9HaS9Lby9La0paZTcxQVNSSno4Y01QTm5HdUJzd21TZmFua0lOS0FB?=
 =?utf-8?B?UGYxZnNFamUycXNuV29TU25iZVIrRVNWUVRvNXVHdkFDRlVyTngvYW9EMDZO?=
 =?utf-8?B?eWJtenZYYk51NHhPRWhIeFlPQmJBTE9EYU04UVUyY1hpS1J0bDM4OXBvMmFr?=
 =?utf-8?B?ZFJvYmdzVlF2ZGRhY2ozNDJ2eDBtYmE0YzZoYjdtOWVwWURNTGFFem5ZOTd1?=
 =?utf-8?B?R2Q2b0RxZncwQjRzWnN4czZnMDg0UEFkYm9YblVKZ3REa3hTb2tXRXR6M0lq?=
 =?utf-8?B?NUp6ellDenZlUm03bFBpWWdJckEwb3YrMU41cit5K3pOTkV6dXo0U0IrSHFU?=
 =?utf-8?B?MVdGeFgyYnlKVDlnTWNMcERjdkppMUUzL1BDYXpzcTk4c253Ym1Xdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1HdliJ3AamtZ6F2A231ZYbsaoJLGn6ceI6u7XIk1Z+ku9+lhzuijcQB4vipWjnyyv0NqccryCjG9DNVa1TpLl7lcvZvRxC/LT7ZZMVYjpDvKP0kl2EtlbQIiXsGXylBXlNIvKeZtw3PVKkDWKJL31i31fAGeR5SlaGH6k7hbDYKslXyi9Q2eglfZyYC6JOthYYfYo7YUVojl8EMLIiLpEaz3RpGkqHFFegNXxEuhDoQF+pdxitID67QhC7ykuhYYMq4PE+9ua8f21veFBElHWM74jj4O2erA3nSQPSwgZpX9NRM87iDTDB4MTgicE6f5Gst7cHmSiR4ncAtPMx5uoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a26c5274-dcb8-4fac-8e1f-08df13492f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 16:48:35.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4NO2s19YI5MAbtj4ryQ3bmKCBbaX/SFxuTiRExbqYq4H1a3kp8HZIsnmwNveBjMScLDky3myvR5RpJcwxNKSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3580
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: x_DtOCWBtI6RYO_rmPqNG91wm25yMu1O
X-Authority-Analysis: v=2.4 cv=YMoKWhGx c=1 sm=1 tr=0 ts=6aa9772a cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=HKJLD0rnby66v6-aK0UA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI0NSBTYWx0ZWRfX9Az67MZlRKLP
 KGlLjAPRQibmddDeaIhqJVgZRkslPVwjOG9m9zATsG5XYydj+ExngKCAKE3hhCQ3ez0z7WNenTv
 BMDPDhDJVYg+k4XjOk6MJ5jtEm4WXcA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI0NSBTYWx0ZWRfX30+rLPhbVWUK
 mYMexUjw8dWy7e6sZrWonmPfx/V7zlR2PFSmWhvjZRV/5ppTKWbOL/bEFG8KpLp9QkXFwBtHEMw
 jh0MqogCo4dWbeTAKlrxMQYERURZGn+2YjW3xPrRKhYrqg161hkZOn6MobJqnWNxdWHKQxoK+U3
 WaIKdMk7kz/HPAkX2Na4TJFGdmlU3M5MQgEHcMbbwv5Es3cpgUTe5fE9obQveuGnZyXXu3vn4UF
 6FoB1Ze64myuu5IucMMGZIIiy15P7X6NfDlyDgMZFR9svOLck4sFTv/I4kOwQMn5gFXg2IuEL6h
 aC7Pl/9qb9S9DlPLRxVHgGMdktNtQblnQTVwUZym59NvpXZvJ35QwNU89PgBvMariDdN14RRA8f
 f1Mt2RIbwBu6xslfaoLIL9+4BS3ZdrX9pNG+aufQ6SUlMsCa6AJcVikMGrKUq0d4hgR7ngdxIZA
 IQwxzXdiilH7puN1fFQ==
X-Proofpoint-GUID: wZC5f3mn8TQDHcrTAUPo1epRsGolJkQO
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150245

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+Cgp0cHM1MzY3Nl9pZGVu
dGlmeSgpIHJlYWRzIHRoZSBVU0VSX0RBVEFfMDMgcGhhc2UgY29uZmlndXJhdGlvbiB0byBjb3Vu
dAp0aGUgcGhhc2VzIGFzc2lnbmVkIHRvIGVhY2ggY2hhbm5lbCBhbmQgZGVyaXZlIHRoZSBudW1i
ZXIgb2YgUE1CdXMgcGFnZXMuCkluIGVhY2ggMTYtYml0IHBoYXNlIGRlc2NyaXB0b3IgdGhlIGNo
YW5uZWwgKFBBR0UpIGlzIGVuY29kZWQgaW4gYml0IDQgYW5kCnRoZSBmaXJpbmcgb3JkZXIgaW4g
Yml0cyAzOjAsIGJ1dCB0aGUgY29kZSB0ZXN0ZWQgYml0IDMgKDB4MDgpLCB3aGljaCBpcwpwYXJ0
IG9mIHRoZSBmaXJpbmctb3JkZXIgZmllbGQuCgpUUFM1MzY3NiBzdXBwb3J0cyB1cCB0byBzZXZl
biBwaGFzZXMsIHNvIGZpcmluZy1vcmRlciBiaXQgMyBpcyBuZXZlciBzZXQuCkFzIGEgcmVzdWx0
IHRoZSBleGlzdGluZyB0ZXN0IGNsYXNzaWZpZXMgZXZlcnkgZW5hYmxlZCBwaGFzZSBhcyBjaGFu
bmVsIEEuCk9uIGEgZHVhbC1jaGFubmVsIGNvbmZpZ3VyYXRpb24gdGhlIHBoYXNlcyBhc3NpZ25l
ZCB0byBjaGFubmVsIEIgYXJlCnRoZXJlZm9yZSBtaXNjb3VudGVkIGFzIGNoYW5uZWwgQSBhbmQg
cGFnZSAxIGlzIG5vdCBleHBvc2VkLgoKVGVzdCB0aGUgUEFHRSBmaWVsZCAoYml0IDQpIGluc3Rl
YWQuCgpGaXhlczogY2IzZDM3YjU5MDEyICgiaHdtb246IChwbWJ1cy90cHM1MzY3OSkgQWRkIHN1
cHBvcnQgZm9yIFRJIFRQUzUzNjc2IikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVk
LW9mZi1ieTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+Ci0tLQogZHJpdmVy
cy9od21vbi9wbWJ1cy90cHM1MzY3OS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9wbWJ1cy90
cHM1MzY3OS5jIGIvZHJpdmVycy9od21vbi9wbWJ1cy90cHM1MzY3OS5jCmluZGV4IGZhMGZkZjFl
M2U2YzkuLjY4MDMzOWE2YjkwZmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaHdtb24vcG1idXMvdHBz
NTM2NzkuYworKysgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMKQEAgLTE4OCw3ICsx
ODgsNyBAQCBzdGF0aWMgaW50IHRwczUzNjc2X2lkZW50aWZ5KHN0cnVjdCBpMmNfY2xpZW50ICpj
bGllbnQsCiAJCXJldHVybiAtRUlPOwogCWZvciAoaSA9IDA7IGkgPCAyICogVFBTNTM2NzZfTUFY
X1BIQVNFUzsgaSArPSAyKSB7CiAJCWlmIChidWZbaSArIDFdICYgMHg4MCkgewotCQkJaWYgKGJ1
ZltpXSAmIDB4MDgpCisJCQlpZiAoYnVmW2ldICYgQklUKDQpKQogCQkJCXBoYXNlc19iKys7CiAJ
CQllbHNlCiAJCQkJcGhhc2VzX2ErKzsKLS0gCjIuMzQuMQoK
