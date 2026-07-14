Received: from mx0b-00756801.pphosted.com (mx0b-00756801.pphosted.com [205.220.182.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D621A23507B;
	Tue, 14 Jul 2026 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.182.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040745; cv=fail; b=qip/Jh4+ofRy7NLJk8R4uhna+e+alQ8oNqBJFxqwnj6yO3gL45ZVsZz64Mz8m0D9XNNpO6Vp9pIdVpA0CyupqEBudGF/RhS5eFf2dFDhMPXfYhgm2SsPR63umZuac7QJDMLVyNK85h1fjvOGzVrNWjcRPVetVbdha2k0dqXF0Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040745; c=relaxed/simple;
	bh=DE9xz3XsgT5cKi8MvbdwjNxq1ON7LO1NIetfO9hrYdA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FBo/i4LvjKZ4NnOt4xAqOeUDnViJUBsnVTuPexAnJAIgrn9z1Y16uNESk8wUluXanO5wWTQlferU0u5OY5lxYmM7f9t1jAiyMUFYQKduhaL3chSd9SSPI8geMhl/8vdnt2K6L8cF/sah0FhzgDrdkueTSkdxPxyzdYEITCSbt9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com; spf=pass smtp.mailfrom=nozominetworks.com; dkim=pass (1024-bit key) header.d=nozominetworks.com header.i=@nozominetworks.com header.b=ON6sAfjW; arc=fail smtp.client-ip=205.220.182.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nozominetworks.com header.i=@nozominetworks.com header.b="ON6sAfjW"
Received: from pps.filterd (m0297687.ppops.net [127.0.0.1])
	by mx0a-00756801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EEgUMd1026752;
	Tue, 14 Jul 2026 07:52:09 -0700
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11020114.outbound.protection.outlook.com [52.101.84.114])
	by mx0a-00756801.pphosted.com (PPS) with ESMTPS id 4fbjsvadha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXLoQ1+a8c557W2/aTfH5kj5nlr1ukPN/7E+rOmf7/x578vijoyQfcTZSPwd/Ek0VZiG531cGyAqUkHrFpRj3/El3XS9IuQO3hv1UdfPbWwCuinl9QaysJjMr4LpI7hAL8KXLdEvvqknOEgT1FYMAxzJKxLWhaxIEgiTq8OKwpQIL4sKQSSSGZLDOc78BXOCwrAUQk3u0aAraPbuzCVJuXnGU/1odwITwxfbqMQkyQuLcTwMmB7hsmyvjoIbocp03htKbscUsLmNLClGTu9SRd+Yutlz9raKqvAnXQ1jWw3bjzHdCrEaBOedf3K+RBJNYwRRuH7n/wYN3Bz4tz2z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUCGq/D2pPoWKLx2qOvTFI6qLWiGzzZV712ypXLaC0I=;
 b=L2tb+LJ+Kyj8YqLbMlm9A9jjwEYdPpv8nOhhBm8SeP1TlDmNp0nZ+903eiayhF68q6OpPUdLmIQaynzAI0D6mdcS6jSdPtmYcA9WnTip1+FuQ+FhYLOjjTSvLNRSotwb72Hh9CNShs2w0q0qkeZmWnkJ1WlwmbpXWWhodASjD7a0zqvii+iYrj/QjhnfR3+SdQrWs0+hbjH1oizttXMXisyJTPzRfvgeTaEoUxaEaMy7m0rXGUaMNNgFsCP013aRZfUaH+yQ3SCVRoVMuDkLxD2DbGa39btBlAiZnStY1vBDBR29btsyMt5CifWRBVlWP29MLYtKIidXzOwAoDkrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nozominetworks.com; dmarc=pass action=none
 header.from=nozominetworks.com; dkim=pass header.d=nozominetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozominetworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUCGq/D2pPoWKLx2qOvTFI6qLWiGzzZV712ypXLaC0I=;
 b=ON6sAfjWPJc6YK8e1khMnxf63vG84VlYFwTdddLeogNdC2BnVMDd8JUIJVspGt4GX4fO4l6As/CDr5DzcaTjJPzT3BNaxuZnZYPLC3WqlqrV0W71YQZznPiGqdXy3E8LM+FWHnphmpvOC4oOUWM0QBnmZNUliVu/C9SgZ7iFFDw=
Received: from VI0PR03MB11174.eurprd03.prod.outlook.com
 (2603:10a6:800:2f8::12) by VI2PR03MB10692.eurprd03.prod.outlook.com
 (2603:10a6:800:272::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 14:52:05 +0000
Received: from VI0PR03MB11174.eurprd03.prod.outlook.com
 ([fe80::478a:c992:bbc3:ca3f]) by VI0PR03MB11174.eurprd03.prod.outlook.com
 ([fe80::478a:c992:bbc3:ca3f%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 14:52:05 +0000
From: =?iso-8859-1?Q?Alexandro_Cal=F2?= <alexandro.calo@nozominetworks.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "hyc.lee@gmail.com"
	<hyc.lee@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/ntfs: Fix min_len for compressed/sparse attributes in
 ntfs_non_resident_attr_value_is_valid()
Thread-Topic: [PATCH] fs/ntfs: Fix min_len for compressed/sparse attributes in
 ntfs_non_resident_attr_value_is_valid()
Thread-Index: AQHdE6BWNXcQ0RKAOEWMF7uI0LIExw==
Date: Tue, 14 Jul 2026 14:52:05 +0000
Message-ID: <C449CC7B-A988-4DDC-B3C4-281794E6A410@nozominetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR03MB11174:EE_|VI2PR03MB10692:EE_
x-ms-office365-filtering-correlation-id: 2859f364-2a52-44b8-4666-08dee1b778e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|11063799006|56012099006|6133799003|18002099003;
x-microsoft-antispam-message-info:
 2XQmTto3o6WTqGYrLUNxxLMmr+gnHZXIndz0Zv0hPo6mbHSCWgTHLVbJj8eK8fI/cicIaqaoThtI5JD6Hlwi8iw1dOSmSuJLmu2s5yKGwpL7BtuuqgBl3I4cjQinRaAzl2MMbp5yirUeQMOh0nadH3yInqh0a7cQz+uxdvMf9/RfrpxwruV86PLw3ALWC8GdpsR7kRH/zM29ZVRhiAoT6z79wkcT6cbvziM8I5af47YrOVfDItzWu9rgeq2UywXisB87xpmXRVHA7zx/K4/mocNVNk77tXmQxz0sdihDkRTy3IUxpuCHoHfJEiXJ0FSrpxgBlmnusyXbj05O/GMBq1JEz4h/vWtSspTsE4dQgghqAOsrAmsZVcNylIwYp7v12XfMhm7La0X+aPYYsE+psPjfo+5YqWl7jnp2LiG09ZzDjHqm5JwAohMNuWYZRS1uuQ5G7FFLhxwI0/VPLnVDZzJzf6UUC8uWiwZj0DRc9LNtTXw5YPeczsIclWX0QL/Rcuazn1fB2qcW6uoY5KbjFE/GSP1Dwk7jICm4QLw85U13X8QZ3QGXN84xGhJb0DVdKvzMgdVUcv62tTFsK8Ih6SH0wCDK9+CMSZ3Cw+fcpt0zcnrLwh3lgx5lI9st0eYH4L9NxGtRGoqXH0X8Q5SCs0SlrDGJjZPvs1SIrB8RYuPiiuZNreJyeiMJIxGXsopA1c7kd7h2etcI0CAn6aBXux0UAIgIPHgWAigRaEG5m+Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR03MB11174.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YLu70slnmDaME7qZIXOehjF2TA+xGRqtdc6aGh/A2NW9qKBlvYsuUo+5im?=
 =?iso-8859-1?Q?gZ1rHDzgVVia22ML8nc0Z8OFJsM8zDU/CiceAy7c/vz9w1j8ZlnbPRrsf1?=
 =?iso-8859-1?Q?dQnBQHvlSv3Q/O5pwidaQc7onYcuprtzxoU25G76emz7dXAL3LLnqkvrIF?=
 =?iso-8859-1?Q?+u9CdoI5gGFed08q4U1fP7yTSoTLCPQeBdUVo6XDoz93pnJGM1btlc8R7A?=
 =?iso-8859-1?Q?MSPxy31K5rizI8sXcdp4EKQbdlC7GcDY1T5X+/jZ6b2qhMiiBjIaEExbyp?=
 =?iso-8859-1?Q?LQuaNaVeDGvNISgNB5XrZ6t1Knm+7p5Dr9PWlXtCHvETPsTIsAPJm4LBsE?=
 =?iso-8859-1?Q?EVuhuc424Puyr0JI9H2+RXUYcd4AsuZ+SzERs+MPAu18K5ugE638v0lUNh?=
 =?iso-8859-1?Q?i0NkIUHUHx3u/dvnHQ0OVuUvnWlAx0/8eyLXohYqkT0qvfk4tt7DgiGjNo?=
 =?iso-8859-1?Q?z6H7xUVMoKpC51osfhRWDd7v+5fv6/IQxh272LBx3V38i7nSYQxvDFhN8w?=
 =?iso-8859-1?Q?tXjssc11bM2DWlmiL4R6U6uTLEsqtObV7N7RAFbN0KW+i1H7U14joBs3YL?=
 =?iso-8859-1?Q?mCbMKAZiU7BKDcP38uUx1BNV6mez74jO7fEUcybbmNeXY/oxABhEkQnAW5?=
 =?iso-8859-1?Q?HeXlVAUPrXatyH8527+z4uMCNGTMVyW3npGOsXhrwy2i80QiW6hrJ7L4z/?=
 =?iso-8859-1?Q?uwMWqnmHxgFmyMBy4OCvXII1bElXBg2FBXX3WdCdg9lPOa/ss+A+KE6gBd?=
 =?iso-8859-1?Q?X9e1hGfWy2PN+zhYdh5Qi+CmGJKzN6+pFL35WBj8EVt7VMGREQKhqjix+2?=
 =?iso-8859-1?Q?owcFqwXmJlraeunKxtt5QzdKCpqhabSrI0eB9lAUgQhQj4abKSDmlSiYcc?=
 =?iso-8859-1?Q?GsqbSZlB2TOr2q7yLPBzLBA7m6VfYh6Un6A9VsD7yoxBTZRpbrg+r/azni?=
 =?iso-8859-1?Q?m6H15gy4tfsoxR9MiMrWwuIYAPPDmTOUYGyRTste21ENl1hXUZE+svCCUD?=
 =?iso-8859-1?Q?rTHoSEXQfr88ktUuaILtICZrVSxPxI0YCfWR5vGFETUAVVmGF0pBpxDWdp?=
 =?iso-8859-1?Q?9jR+2GB7bdaHpRDR2o0BzNFpINvF59Q8MxfsdmN/HRJIbF7CeQg4/5d7f6?=
 =?iso-8859-1?Q?xby2c1NviAQpBxMhtyKGDNcC2BjRiUmTUPG5O/zYf8z5Gaj4KtE9Vi9ThL?=
 =?iso-8859-1?Q?phQZdP53DVtQVm0fXWkBjckRIa3C7Ks/Qoh9hGqvbUM7XtDPlUcGbL8Gjd?=
 =?iso-8859-1?Q?mvekTh49QAid+M5nAkyZSS7yOKXg+S2xMv45npUEeW/Sxsk9VerBB4Y24c?=
 =?iso-8859-1?Q?L9zrT4Xogm0/Hh/8el8DxBKzl31d4WAAchWu/9y/VWrIQOrlysRer1rxUf?=
 =?iso-8859-1?Q?W2bbmrPj4MuBa4gmYfPLo8HUt34ez7urGAJOhXw2sO4+6zunJNnz2kdtBY?=
 =?iso-8859-1?Q?uifRdHZViLY3Yw26i7MReCUnK6paxTfCdi1YWcNR0zm15ec0D6RfNRPy1n?=
 =?iso-8859-1?Q?6cyKsuVovTkNS9Oofe9KIhYaW3UTTEuWXpcuof+hhpet81mLXBj7/HpCKI?=
 =?iso-8859-1?Q?UfzTSozaB9ypEhvCSLVykWbNOVG6W65DSUbmICP7TcF4Eby8W+tHMXPYgU?=
 =?iso-8859-1?Q?UwvOTVOB7On80OLWs/tA5SoW09JRvb4u3GdMdSBJ8ArCzXg/sOjT0/k/2x?=
 =?iso-8859-1?Q?BswRDIrNng1jSh7RGco5ZqwVny16K3F+4gh2czBKKvNyU+US/QZSnPgB91?=
 =?iso-8859-1?Q?AnBpXdPvfUJe5DruciPeUttLQEvjwEv5ptHJCdJAJfBLlyA5sQKEzBSknz?=
 =?iso-8859-1?Q?uoc+XeMDPGWh+4lSKx9wiYdpylmktlhoszWm8Q+KthU0Yri0o5zL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D214846FD8DD214DA9CB82E4E61A4CD7@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LA7VBUXYzNW8bB7VnBklcZpwb7AwT7mKoBA5vB+JL5kYZi5tX5JnEOOaNVDq0vM8b7BEauWGNkMDTv2rpLseqq+PVPqyk6Cl6RLfiREYKCNIj9PFI0l9kYBRKEG0xgtLkCyGlrCbGfkMAEDw8C0vlS2jpI2Q0k9VlOi2JSI6cR3X2QVxBKpcsLieSeHHeWyk3lc+pFq1st12LeTlIdMttClJR0brVHBLSqvWN9DnJNib2rQJpwHdsTSlDOLjYn/t5nngeclH3BVO7P+d7oUb7V1jm5UyOzomeEaSDKgAfoO0ywB+uUMDsqGEK/zQr+DPUjJPEMfm95gD8k1C76iRkQ==
X-OriginatorOrg: nozominetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11174.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2859f364-2a52-44b8-4666-08dee1b778e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 14:52:05.6800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f04d14b-0796-4b81-b7fd-779778e05341
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8++E8F3poZdkGDPNDEw/EBvQzjmPDJWT2X6E0GGwGNKffUd/qKJGlef0F35kAs7s6FmWNWN+7MH0pzYLtGv2R5cpGYVWla+g2P33FunD0CSyjca77101QftHA5N5IYDg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB10692
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE1NCBTYWx0ZWRfXwwnJUheCdsvE
 /oHSkfn5UrIJHmea4fyn4sknOqpITXjjpHUcKqcbwaw69hrGOh5rHMLscezPhMMJ3huWrEik0ho
 1qbXVEWPu8qAz7tZS42FQTzdCc1F6Jkrlj5wnn28D3JQ+hToAwEZ
X-Authority-Analysis: v=2.4 cv=NdHWEWD4 c=1 sm=1 tr=0 ts=6a564d19 cx=c_pps
 a=fQ5iMA6Ggk6c3vVxUsQcvQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=LLPZWm0_0O8A:10 a=nBHfkqHukZMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7VS2YgxpqphC4cixgVMD:22 a=sCtaNhFbwZJXAHy4C4eS:22
 a=GqK9ZfNKAAAA:8 a=C3ptz2KJ4X610lhNjkYA:9 a=wPNLvfGTeEIA:10
 a=BFatPaWxP-aY11LYkd1a:22
X-Proofpoint-ORIG-GUID: aaoawszS5YMYDogyUmdpN-KSeMSrHNcK
X-Proofpoint-GUID: aaoawszS5YMYDogyUmdpN-KSeMSrHNcK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE1NCBTYWx0ZWRfXx8cVgbvszAeF
 8mKWjbijeZL6KYy2sf93OUgcFX+YOyM6O+cqO/RUqolgIrS9xdc6tMZb50jotbB5EzRfSTk8029
 IFqbK/mQ0W00kTYTnsI9bETYVk7/JQxVdox1UvFzJjLbWo9XYyfILiBJPW1NZBw7d2zA7Pw+e43
 GIoM6/OesEFJevpy+Szc5jO2CM5zni+S53DFwg0hybxW/oC9ilNzemImRatdAszs4QCnN72tSnw
 aaPZDMr8RKjrTpm9hzDzlG1Pj4Log6JdZO8tPUVNpoQ4qFGmOsm8SGiGs2Lh0C0vuaVgywQPle3
 2D5/PXoc9zHANYP4EPAAVknetXHthcWnAJfB2EuGNOY88+CEF1SGXCN8H4nqn4CtYqVaegKVf2I
 n2wUIZD1ulz9eSAuWxq7Rw4ssS+3mh2G8casbNksZiCTB3G3Ea8SgdC1a843OoRBJbvUYBqYhW3
 NeV2dxaO5YhN0tkDZJw==

From: Alexandro Calo <alexandro.calo@nozominetworks.com>
Date: Tue, 14 Jul 2026 16:13:51 +0200
Subject: [PATCH] fs/ntfs: Fix min_len for compressed/sparse attributes in n=
tfs_non_resident_attr_value_is_valid()

Here the attribute validator computes a single min_len =3D 64 (as the end o=
f
initialized_size) for all non-resident attributes regardless of the flags=20
field. This is correct for regular non-resident attributes but for sparse=20
or compressed non-resident attributes the fixed header is 8 bytes longer,
it includes a compressed_size field at bytes 64-71, min_len should be 72.=20

Since the validator lets a sparse/compressed attr_record be less than the=20
correct lenght, caller's accesses to compressed_size
(e.g., ntfs_read_locked_inode() or ntfs_attr_update_mapping_pairs()) can
extend past the attribute declared boundary.
This can cause OOB reads or OOB writes past the MFT record buffer if the
attribute is positioned near the end of the MFT record.

The compressed_size field is accessed from:
- ntfs_read_locked_inode()
- ntfs_read_locked_attr_inode()
- ntfs_attr_open()
- ntfs_attr_update_mapping_pairs()

ntfs_attr_make_non_resident() seems to be safe.

Fixing this by raising min_len for sparse/compressed attributes in the
validator.

The OOB reads and the OOB writes require a crafted filesystem image, which
is not in the kernel threat model, anyway, fixing memory errors would be
nice to keep things secure.

Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
---
 fs/ntfs/attrib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 239b7bcbaedf..3e21640a6534 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -697,6 +697,11 @@ static bool ntfs_non_resident_attr_value_is_valid(cons=
t struct attr_record *a)
 	attr_len =3D le32_to_cpu(a->length);
 	min_len =3D offsetof(struct attr_record, data.non_resident.initialized_si=
ze) +
 		  sizeof(a->data.non_resident.initialized_size);
+
+	/* Sparse and compressed attributes have the extra compressed_size field =
*/
+	if (a->flags & (ATTR_IS_SPARSE | ATTR_COMPRESSION_MASK))
+		min_len +=3D sizeof(a->data.non_resident.compressed_size);
+
 	if (attr_len < min_len)
 		return false;
=20

base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
--=20
2.47.3

