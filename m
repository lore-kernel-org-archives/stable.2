Received: from mx0b-00756801.pphosted.com (mx0b-00756801.pphosted.com [205.220.182.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4E3B7747;
	Wed,  8 Jul 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.182.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522616; cv=fail; b=uVxMVc4Y3Wm+hp3mMObyBZv0vYufKHLmaNAgvCXHYp3aErsHgeiwt50FDV+EyQrYk0eiaDY/pZ04MH1K25/lRS6gBCYkqlgI++Gi3//mxMaPz3o/4o9ZjLpmR+FR/X6PDsvJaGu4QpArNMqMAYLbJrlIkGU0gv+6h+IJ7Xdn8as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522616; c=relaxed/simple;
	bh=9VJ6FJxDJT74qEPQxO61Ft+uP6lb9fVcO4gOCOGr81o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oY53Qs2ZW7hwNkOutdiuV4EjisZRB8HOtJpqUdivwi9kKmCJQIei7R9d/y+QHu6W8xmRqSNlwMycVIRWYtii/1uLk2yi2TRGc1VwT5mnq4lDlK3Q98Izv2xgiPhw1uRpbrxSs3KL02MRVuHl1XQlSrM9dgZHd63v3SrA7J6FbYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com; spf=pass smtp.mailfrom=nozominetworks.com; dkim=pass (1024-bit key) header.d=nozominetworks.com header.i=@nozominetworks.com header.b=m0cq9RG4; arc=fail smtp.client-ip=205.220.182.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nozominetworks.com header.i=@nozominetworks.com header.b="m0cq9RG4"
Received: from pps.filterd (m0297687.ppops.net [127.0.0.1])
	by mx0a-00756801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CB84K1838781;
	Wed, 8 Jul 2026 07:56:49 -0700
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023088.outbound.protection.outlook.com [52.101.83.88])
	by mx0a-00756801.pphosted.com (PPS) with ESMTPS id 4f8t6bse17-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 07:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCWl7amLy8/8d1gkKpZ54lIbH7to6JOwgSkuExATBvlq9sbnaCR3QNsgDb1HdkHi6YITlzSBTGF8ODRVsbF33BMDh8aoGO5f+KmLEC9C2wqEsPG1eBmpicxj/JLIihnUAjwtxaHSD04eDRKQgSwfq72LfHwIm6ReP61y8ZKvYZtg1QvcQFa61W+pNnAvzf+0pz1NLbIRla4QwtQNhKREUhbYlhBLIWRIdre4iTkEhZngiSLNjLBSd4Q2726if1CNnKjqi2eTd4udtMFLE9vmjBcsNMAGcVeg2C9WM1P+QzHu2nuKakq2tWDzAYvRk6O9Z+DkQsDSxkwqQFeIaoi8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMf4mbxYBTqBa+DFPqtsUBmJQqtu8oizdM2Amrz+qvA=;
 b=eaOKy+jBaSbwL7OqIDklKFFv29exSplRuXTPrSfHSwoB4Q/K7gMNOmmZ0ldsoslXIC9ZhtzBW0vTyTNfzmn/P00ssVC4NJQ5sCqsl1ghSOFH4QAUjd3FMv74B4lcu6X/EaolI/RMOnTUP1aFrsudAQ4ZPPn7aMR3r/VGimyjl2X1QulnV3CU1G1kDeHVYLPcSqDj/xJGDGiyOirrFCpfjxM0e3kczeu0aYzaVjDFrvKzG1DnEdoAGZUiUAb1PkYwQDxHNUZd1MJ/4kv4PA07Epo7lIzmTAGrUgGDCSUdwGI4yehV2jVOUeq+vmtnTw/kd8+0XpYV80JCHu2nsDMcBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nozominetworks.com; dmarc=pass action=none
 header.from=nozominetworks.com; dkim=pass header.d=nozominetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozominetworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMf4mbxYBTqBa+DFPqtsUBmJQqtu8oizdM2Amrz+qvA=;
 b=m0cq9RG4iCw2cwxUBcxEZGrjm4+yzHBHjACgFRdcUOWWZVB9HpG7aG/Ir6rkva+BK6Q5NhyYx1lcFmGjJAESiFi65a6aL6jRypGoYevjPvwvFadyEj7j2445fU6wJ1EFHeK6n8Qb4kWb16eFyBXmpaVs0pDpP+wJOTLQJUzpd5g=
Received: from VI0PR03MB11174.eurprd03.prod.outlook.com
 (2603:10a6:800:2f8::12) by DBBPR03MB6732.eurprd03.prod.outlook.com
 (2603:10a6:10:200::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 14:56:46 +0000
Received: from VI0PR03MB11174.eurprd03.prod.outlook.com
 ([fe80::478a:c992:bbc3:ca3f]) by VI0PR03MB11174.eurprd03.prod.outlook.com
 ([fe80::478a:c992:bbc3:ca3f%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 14:56:46 +0000
From: =?iso-8859-1?Q?Alexandro_Cal=F2?= <alexandro.calo@nozominetworks.com>
To: "almaz.alexandrovich@paragon-software.com"
	<almaz.alexandrovich@paragon-software.com>
CC: "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] fs/ntfs3: Fix heap overflow after ALIGN in mi_pack_runs()
Thread-Topic: [PATCH] fs/ntfs3: Fix heap overflow after ALIGN in
 mi_pack_runs()
Thread-Index: AQHdDun/fO0NLncEOUa/YR+ba72fHw==
Date: Wed, 8 Jul 2026 14:56:46 +0000
Message-ID: <D3832EA7-E99D-4705-AF8F-7E17310B8B05@nozominetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR03MB11174:EE_|DBBPR03MB6732:EE_
x-ms-office365-filtering-correlation-id: 37108a5b-bda8-433b-0c4a-08dedd0121f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 H9n646olTiZ7wBOqsraqqTT2fTqUp7llly3ykeNnBuxCdQCbq7QYKSVBcs2JAx3f71YgPyPaAskwYVJ8MWhvQNShD7jHXzYPu05pbvD1uIMJff5wD1A/mfgHRnjjjZCYXOX/eyZBUrbwX1Qqf4u3TsiQT1MqptpY4wuyz9OqhcHjyrV0cJasK0rzKRdW8wNd+cz4Z5leTmMTXjBu1CRllCculUm51HdOuynk5eOmMYtAsFg13zHBJ/Py94oC05gjOd2KtAezN0GsxNRgsZ/x3wlMa1yJvvf7RjbFjgc78jIVMiQ1yR5AU1Frfd4fk/zmWHbOtDKV/kN+mWIf+tk8whB5Sc7s4AWtIzHNPjuL+y9DBxw29d7lxNJbsOr72YonePiZ64WYcUVA1jjW58UMhNZbmBOXO81XW8ObD6A53OyvpLm4czr82TDTbs1LsgrH8ONu0EqFcyXTqI1gWb1DwLAts4agUa9pE6DQIbz8Btqj6cK9mvd2UJ/CM++sBXxoRF99hqa2FFO/5NP7W/tM8NEL1x/crCXVCpeLqq70vuIMq7Dz1WmSLptu/BJXjOCfvBT1h3shBdsQivJQKw5xAo/bXX7DCB4gExbQJ8fmirHTDbFHY0H6bfm+3PoNrXxeoE4JpSeQd6C9GcGAWVGfyWF5bnWyYFqSi07SvrGIYcMp0OAXAtcdynqYWaaQqQBa1tJw2Fegg+6M7GD8FHep6w65os6sRfYhXrGa9ot1AW4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR03MB11174.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/9U8SS7yCj7+uvhyruw1w6BJA81dLnnUmZ88qGqM2IvB2pc//H3btj3B69?=
 =?iso-8859-1?Q?i2P7akE6pv75netPrviHyCy2NIkatGRWFLYVxICmViJp6qoO6DQhXg4rHH?=
 =?iso-8859-1?Q?Pe4zKQO3S394/8ApV0+UueGBXdAuF8H+VNfJJV+e/gEmJrXv7LvD+4dKv+?=
 =?iso-8859-1?Q?sA5GqX/iQdWFkRM9GrrIjyWpvUoAsHN7YmF3d4f6Htj72EGQK1gty164D7?=
 =?iso-8859-1?Q?MTkUuX+UgjcOGF5MgfvC709tCpFJeRy45RBUllJXA8p1Fe6RN2X6lCURXZ?=
 =?iso-8859-1?Q?enZi3PrxWfYN0MOchN8Xdi4iv01RTYvkM5hQR3F183QV6E2Qvv60atgHVQ?=
 =?iso-8859-1?Q?60GkbCSKMZO4oIOqQmMj3ttF6w3qKP8MCyslmdIQOidB6lF7MJjmeGGGum?=
 =?iso-8859-1?Q?PIPATMlVH3WdjJin5WIJmxW38XULR+xLbVROwtyjKHeerC1oNo7OWm/gE1?=
 =?iso-8859-1?Q?Qs46J8yZzGGeuQsX9xYM/D1+lXi+LozHm5vu3QHWnoG+F3NRuXETr4zHeM?=
 =?iso-8859-1?Q?j/giIlqw5uSxysWf44h+NfODlfdxBC+mLMRkgpGz+Lk4lhwS51Su3gH7EM?=
 =?iso-8859-1?Q?hKpK+eju2SxCUuFVKW3R2pFcobjio58SKexUyCEuU3rtLBqXDAEvktdWQn?=
 =?iso-8859-1?Q?ATe1+37suJucRpfNOct2Ap92GhJ7itooQAIz4eK2bEbQbpoWnM9kr/4RNh?=
 =?iso-8859-1?Q?8YwDu6UplM5mYTuTLpf6qAtvJ4daQ+KTCld+isYoq9q6lnV209TvAHg3jJ?=
 =?iso-8859-1?Q?/oRNSKOMoH/n6S1mwLtyJp+WMHLuZff3dihOMAFna10ggB0uSG4LUrsxxQ?=
 =?iso-8859-1?Q?VfjNUQIIoI4wkc9K78iwAnX9R4MiS36WWXk5AYXm5vR3eN2SYJ/kFy6igb?=
 =?iso-8859-1?Q?Cpe3Pd7ihFUBoCe1CiqLAXG6/mC2PjrOvTHsHzSD+ZLutAoOl6DUK0Uk1o?=
 =?iso-8859-1?Q?YIsaIOaIFXlMy0vont+Yy1HgE+KQVbkjxDyoZF2wxRsW9nEnISPViqvRCm?=
 =?iso-8859-1?Q?EIwJBQ3+2Fo3+C/snYi0NZiKzSXYDZk9SAD5pa6A2ouFn4Gju4Fb8cBiZR?=
 =?iso-8859-1?Q?W+uWG2v3fSu6ePplUfOCpQGlz8/8L/wpwLlJNB1xMyami9HWJBECbU87Cr?=
 =?iso-8859-1?Q?iEKg0NpVXRJUvZII4W7Cz4+UvfDFNgZ0EiW/cZbyphGJ47OQE/ntjyN5fL?=
 =?iso-8859-1?Q?dXawFrEWEy8JYuynGRKAGuDq9NEK3oq/pq8u917G1jN1oHXfTfwyEFdZgb?=
 =?iso-8859-1?Q?0dW7gqol3hbmFRhhN8oBiMnX3vnrX/PDjwrm/BYgBXB7Ahx5N8kU+8Jd5F?=
 =?iso-8859-1?Q?CIp8+4069zVHJKR5/rW9CPHCEC9/oEFnAiC7N3Oi4sfC+9CT26OcnagOHO?=
 =?iso-8859-1?Q?XlJXAGBUv6kjmyZI4G2GtoG99M2oq5WW+5XP3JcUs7GzdBD95LU0IJfMLk?=
 =?iso-8859-1?Q?EQVKb+adr/oyBzR0LQDGw/rf1/slK8q0lqap64O5wUduKFL8S9uWfIT+k4?=
 =?iso-8859-1?Q?Gvyw7hjR4tRFShHFvkHNX/oS8GOrvK2f/ZI7bFmMwP8iHlaJ+8d2BNiF9O?=
 =?iso-8859-1?Q?jsiR698MbU9znfcwY3EdPQx4W06YH9GA5/eKrmEOGH2of37b9TKaK2MI1Q?=
 =?iso-8859-1?Q?sG0OMlm1/qVXvf5Q9vRvDBlbOacxLd6fHx2M4Tl8JQn1udk9tVo1qNKODW?=
 =?iso-8859-1?Q?3tHT7vwezbAMTIfIX+3hYKcD3dKprN+4XOXnFsUG/L3VUFR+szeGQdWw8p?=
 =?iso-8859-1?Q?bJZjoI78aV9jXibuOCvID9Y8wjjgoMw12NCU1vEAosv2EMv+xm9aGqUUfj?=
 =?iso-8859-1?Q?qJt3Ed1aFuGgwP78Wu+rH3M1Yu4OtzDfgo+GQCnN0p1JkfaV8Pb/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0608D8F5232E234B87AA5F183D1DB519@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Is6DQOFG8XRjM6lSeF2iAjkyykO4FRxtF2fge5Hl8UVBf1a67P11cZ1EjeeSc1EBjz22M9CPoI9dmfx5TE9crLFP6Ez4viBtU5cuKCuodExzX90aajT9QOvm9IzuyaHY/92lgmp4kAEeGuslSGmv+axhFU7jPB/y3/kj9AJzrqAkF2yAkpk62bCnAOHV13WGFBSR8zMvL2nZXnuAoTyY0p9QIHeovPwGu8TzB0rcvU5xTR6y9MFxxbTpjca5Sg2xvDc5ZnfCzn91gRUgBcnf+yivfUI1uakj0EynJz4Y5TgOWel1yMUXoLhqJvbQ1ptBVUUw32tL7m6HNv3NrwkKYw==
X-OriginatorOrg: nozominetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11174.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37108a5b-bda8-433b-0c4a-08dedd0121f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 14:56:46.7289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f04d14b-0796-4b81-b7fd-779778e05341
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sfvrB5gk3efXTUPs6jufwfD1IMZMTXMWV3ZMbLNs36tnDqpa99B5E/KqT47ECW0XbjMDYHAm+BoZBDwIsMArorD8a+OfboZwpuM3PruP2ZpyQ3c2tUM/BCuneeKWKhH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6732
X-Proofpoint-GUID: jweWXCHyC6V7emb1LbI1S10q3TUVRIO3
X-Authority-Analysis: v=2.4 cv=AsveGu9P c=1 sm=1 tr=0 ts=6a4e6531 cx=c_pps
 a=BndV9kuYSvdMfOmTEN0A5g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=LLPZWm0_0O8A:10 a=nBHfkqHukZMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7VS2YgxpqphC4cixgVMD:22 a=sCtaNhFbwZJXAHy4C4eS:22
 a=GqK9ZfNKAAAA:8 a=aCr3vMpJ8gJ4_DxwHcAA:9 a=wPNLvfGTeEIA:10
 a=BFatPaWxP-aY11LYkd1a:22
X-Proofpoint-ORIG-GUID: jweWXCHyC6V7emb1LbI1S10q3TUVRIO3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0NiBTYWx0ZWRfX8k4YG7fV/BSf
 B0+slmGmi61RixnipZ2uZHQkH2/ynPkq5BAemuYko3TMG2wLKsNIcbS0DnS/MQ9GKhjyNyWP3r8
 TFOb7DGLJ3QlbrKGtxtfVFDzgstHQdeEcnQiqSVcMuAno8mkm9a1n+vIjoYKqeL2JGbx9+85l6M
 JYG/E2NjbGiSdtDraiuteegUOaxKzB4bI0kxABr5gq2tzE5J3hiSaiVtQEDDX87XnQgN0BIxbFx
 oHgLm2g0RIvzYaTf0CBZE9uH4WqHyIHzR9Nnbe0HX7hfcqWMIKMM71q7IcdkMfm3miHIpRPP6BL
 tnxZNk10//ZCMskyTwTVtxd7AFAEb8vBu2m8i0gNXl0fMs4S+l+buKbYObXH3bP52P5pq15OUIB
 YCK6iLgi31RZUbC4ELsT63p2axz5s9CFwVXJzALEHLdr4Ln0iyHdFERiQq8+zXISwDgOVJ98U4n
 Vp6qLlHN7buXUIg0DAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0NiBTYWx0ZWRfX+0hCJw1zo0wi
 axyKJmBhr50ywDtZRmPKCbx7MFiU1kBPGzj6SZaYlkOpY/DR9oUBcNrDmavjsSUy1z2E/bZz6PI
 JaU8EulleQGkbyE5dalAI6Etq0eab5c9WHc3LyhRqRkdxMi3IsFp

From 70cdcdc3203f73fe2a77b70aa32d31140290cc99 Mon Sep 17 00:00:00 2001
From: Alexandro Calo <alexandro.calo@nozominetworks.com>
Date: Wed, 8 Jul 2026 16:16:39 +0200
Subject: [PATCH] fs/ntfs3: Fix heap overflow after ALIGN in mi_pack_runs()

When run_pack() returns a non-aligned byte count, ALIGN(err, 8)
inflates it by 1-7 bytes, and since the destination of the memmove() is
computed from that inflated value, the entire attribute tail could be
copied 1-7 bytes past where the record buffer ends.

The memmove() destination is next + new_run_size - run_size. For it to
stay within the record, new_run_size must not exceed run_size + dsize,
the space actually available.

Since new_run_size =3D ALIGN(err, 8), a fix could be to ensures there is
enough room that whatever ALIGN does to err, the result still fits within
the available space. Restricting the budget of run_pack() should
guarantee that.

Something like:
    u32 avail =3D (run_size + dsize) & ~7u;
    err =3D run_pack(run, svcn, len, Add2Ptr(attr, run_off), avail, &plen);

Now, run_pack() should never return 0. As now, the function returns at
least 1. So this is fine. Negative values are caught as errors by
if(err<0).

The rounded-down avail may be smaller than the existing run size,
if avail=3D0 run_pack is called and will write run_buf[0] =3D 0; that will =
be
OOB, because the buffer size is zero, so imo the caller should avoid
calling run_pack() with avail=3D0.

After run_pack(), if plen =3D 0, then svcn + plen - 1 becomes svcn - 1.
So, after run_pack(), it may be worth ensuring if(!plen).

Lastly, I'm not sure if -ENOSPC is the right error code here, but
it seems reasonable for a space condition.

This heap out-of-bounds write requires a crafted filesystem image,
which is not in the kernel threat model, but fixing memory errors would be
nice to keep things secure.

Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
---
 fs/ntfs3/record.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 32bdb034c2a3..2466dba15241 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -637,18 +637,32 @@ int mi_pack_runs(struct mft_inode *mi, struct ATTRIB =
*attr,
 	u32 run_size =3D asize - run_off;
 	u32 tail =3D used - aoff - asize;
 	u32 dsize =3D sbi->record_size - used;
+	u32 avail;
=20
 	/* Make a maximum gap in current record. */
 	memmove(next + dsize, next, tail);
=20
+	/* Leave room for the 8-byte ALIGN() to avoid OOB write */
+	avail =3D (run_size + dsize) & ~7u;
+
+	if (!avail) {
+		memmove(next, next + dsize, tail);
+		return -ENOSPC;
+	}
+
 	/* Pack as much as possible. */
-	err =3D run_pack(run, svcn, len, Add2Ptr(attr, run_off), run_size + dsize=
,
+	err =3D run_pack(run, svcn, len, Add2Ptr(attr, run_off), avail,
 		       &plen);
 	if (err < 0) {
 		memmove(next, next + dsize, tail);
 		return err;
 	}
=20
+	if (!plen) {
+		memmove(next, next + dsize, tail);
+		return -ENOSPC;
+	}
+
 	new_run_size =3D ALIGN(err, 8);
=20
 	memmove(next + new_run_size - run_size, next + dsize, tail);

base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
--
2.47.3

