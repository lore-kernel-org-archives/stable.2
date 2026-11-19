Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.104.111.126
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109416;
	b=12DhQH8gX62VbwR570PRWtojNFq/EDHhsoefpNjNcM8ZqIOgsQ25m9Nt3yIDMufV1lBg
	 TeE6SbZvAfBIfAkpYg49OniXaJ+OXMPVCvT43TD5TULWDroxW9uj/rzkF6SVK7uRpc5nq
	 jyJ6lyJ64O8xdwJ/ehWmyWr1T6lm6lwIJZt68fB3uN5q2RdVgHE3dslf6t/zQGtMTB4P0
	 RzPzxTXu33pin1/jP5U9y9X7XArbrUyY9G7CLLoymK4re0E0R8Gr5S/ysQBtsCZECBGKp
	 v8eYNy73KAKzOojz6rM+lJQQBK+Zok8gqn2EZoJIs1D2PTtn0Czc3InqvRYZuIGOr9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109416;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
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
	bh=y7cjZzv1IlDLrfgzr3NrNfR2FLKP9U+YpXy2c9bC5sI=;
	b=igyLrp5YjGVVzcJKEdzi2WnWZxHVOWiLMqYaGbEK8SeMa/M0P97P2yRzYieih/oIJAmZ
	 nVVODxYlYrUgpbzzexoSemPscv497J5khiqZ9RTz1uT0KJyvRgND0Pz8TBeU9XIprFQce
	 oreLKurnI1pwk3NiWfH7MJiFDUssFyvToSfJRwUxJNp+XGcsRQN2Bkf/rSm7EmXwP/NON
	 fvXYSvVTvs/2JPlfDqXNFVTpoAQsBrMT63n7kvHGz2ve6oas4ZgfyoXdWMzwvv+gxtaJd
	 NO+6GnO0zKZmXeKC65meUkz3jg+0FjgXGR8HDTKhzROtzZ5vRPZpgWAZpKMbVQNFHxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=francetv.fr;
	spf=pass smtp.mailfrom=francetv.fr;
	dkim=pass header.d=francetv.fr header.i=@francetv.fr header.a=rsa-sha256 header.s=mc20251209 header.b=W1XBgqp1;
	arc=none smtp.remote-ip=194.104.111.126
Received: from de-smtp-delivery-126.mimecast.com (de-smtp-delivery-126.mimecast.com [194.104.111.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B0606A338
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F3B0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=francetv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=francetv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=francetv.fr header.i=@francetv.fr header.a=rsa-sha256 header.s=mc20251209 header.b=W1XBgqp1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=francetv.fr; s=mc20251209;
	t=1795109408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7cjZzv1IlDLrfgzr3NrNfR2FLKP9U+YpXy2c9bC5sI=;
	b=W1XBgqp1k35Uc9fj02z1U2gaukPpsulFDTBpXIbh7wD6Ra/AtzJaO1eFOSFgIKvHBgrDZJ
	3SQapWX/5fNJUAx3k51O62a3AVqp8ihHGKEIba5r/X8VEzlvMkXtNuFjiKtYU+eHZY9s+G
	s5YMYcSCDhpENyexQh3UJxl0vfajuaRPPoDOYavB7k38IEPZI8CZtNAv2BOryob/lO2dRJ
	TR/GB8CxF4nGKSIl/7aQ57Ko9+VMVdHSSpvnA81D9cYe+2K+ScMGXoF7tRS2i2Rg2tKsV7
	YBJhE97EbZX/kvlwPSMiPq9s5PTzpEvgGxU9KJW+ZMxds2ZwYp4SPlIynn08Ow==
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazon11010061.outbound.protection.outlook.com
 [52.101.167.61]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-40-nXv_n2i6Mty82DRMYAAcfQ-1; Thu, 19 Nov 2026 17:30:00 +0000
X-MC-Unique: nXv_n2i6Mty82DRMYAAcfQ-1
X-Mimecast-MFC-AGG-ID: nXv_n2i6Mty82DRMYAAcfQ_1795109400
Received: from PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b2::19)
 by MR1P264MB3475.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:29:58 +0000
Received: from PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f6d2:e60e:fbde:58fe]) by PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f6d2:e60e:fbde:58fe%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:29:58 +0000
From: =?iso-8859-1?Q?DESNO=CBS_Jordan?= <jordan.desnoes@francetv.fr>
To: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH 6.18.y 0/4] libceph: add CEPH_CRYPTO_AES256KRB5 support
Thread-Topic: [PATCH 6.18.y 0/4] libceph: add CEPH_CRYPTO_AES256KRB5 support
Thread-Index: AQHdeAQFdZHh8UJ140Gs2wrkimE5e7c1kFYAgAAVJ84=
Date: Thu, 19 Nov 2026 17:29:58 +0000
Message-ID: <PR1P264MB18059C3971471D3CD7E5F7DD88792@PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM>
References: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
 <2026-11-19-1-daily-reply-0014@kernel.org>
In-Reply-To: <2026-11-19-1-daily-reply-0014@kernel.org>
Accept-Language: fr-FR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR1P264MB1805:EE_|MR1P264MB3475:EE_
x-ms-office365-filtering-correlation-id: ced8e9b4-818c-4fbb-0984-08df4662bc1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|4143699003|56012099006|261022075727099003|261026121527099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003
x-microsoft-antispam-message-info: JsjnZ40YQJCrfZ8skealskAOtRKHlA5FK+Qn+i7XQPCxnFAGP0qf1JrtXfxXu5/XfXJ7GGETN/JbmQnx1xCBU3umEfTczHDvx7Tmj+ynkpuGexyr8ZUtwx/jCHIAYrAWtKIRj6MVwOcRLtmm5R4lJ+4MOUOSsvSPaQ4dAuqd6RWo9wAqvpWSNZmFHeKO6LIrZeomtKoJSJju7YMU9pshUIa0fYb0QNPoWrYSno3e0Uz7mij5f3tbzivtrXQ3RIsCfznzBTKjcP8nKl/cNk3puutarU8qldz87MMTd9WWWVWM9ij45ElyoDAv33gqwtvWH0XBaEtuf+9O0tK04gVyLYLixyJsSm8ZZRkUPw6lRwIrTHY8mUa0Igy6lV1NrM1kRi8YvLY369GPQVGWEjdh9Ldh3Gmm8iYM2/rbr93gQqiLeL2ADo1BwFJAGGwb3Hu3CpMFEy2aX7YYaLafSuMLCfNB6khaBSxXccMc1IeH2HAI4AtDFJkM15feyOZVJ73h4gJfLaueIZ2BOjeiC/l3StUKIMxBA8rx/FD/vnOVEhTpg0oWv7e0FgZb/72Qvl87VapyU1b/FQ8ZcSXqU8MQ+2nDlj4QuGOlk31/VCbSOpkpE4W7V5nqnZhCQlPxPLAzDRJg6STE2bLZ5INItdyr8fUYAidD8biJ3o9uok/JYfo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XPAd0Ve5XaDTrW7LZ+rfx7qZWL8SJZBGcFpD2TMBv9st+AzkGPKr1B5Nmy?=
 =?iso-8859-1?Q?n0PFLYrXfEMtIdLBsSRSzosQxk4BUww8r80t87uPTY2K4aJsMfiX/phKUs?=
 =?iso-8859-1?Q?jTMfBmTKECQnDciNZ5U8Il8/TMgWXOk7auQ+Q2F8xpjY2LP9CfezISTqp9?=
 =?iso-8859-1?Q?PcrUDLzuNiXq9l+O3td/hGSsiilCq4YX6/pnTNwyDS/fkOoENLEX7/qEqL?=
 =?iso-8859-1?Q?LqAKWfzTmxg2oSYqtHZq59sTlZfIKiOVhvFS5QTQY6trzT3qfzZFuSIIJ+?=
 =?iso-8859-1?Q?YyQe7YUndRasyDLtcGso//oE3lUAZGZhHSgRm3WGoPN0A1rohJs/t1kEvk?=
 =?iso-8859-1?Q?znXM4DA4v5MiewrG0FyKl4i4rgbo0ztP2OOJZHRslGYgrP//ayNK4soxwk?=
 =?iso-8859-1?Q?KquugcGay5T/8M7o2dbaAMS/kzPJsuZYywMIpvyw4Wft1f4ew4eUMR6yVt?=
 =?iso-8859-1?Q?KMbWVst/RnCvNyNqms5a2/Kjve0TQkwwJ8Al3wZK1YXy7cLOHizmE1Klzv?=
 =?iso-8859-1?Q?r71PqEQwDezlLTybN7UirNM7LtBn8mIJTLJ5EwPku1z6U3Rw7JjNyawsZk?=
 =?iso-8859-1?Q?G4d13amS6trjCdhjmdoSbc6pdysoDDR/N8MFcfxhgIUtYy2ARjguzZYtJD?=
 =?iso-8859-1?Q?NhRAgtRWXDn84f85PklasWXZkdvxjP00s3k2FBtro5QGZr08aYHvTnO0Ba?=
 =?iso-8859-1?Q?B2rIjPA9ahHPJeRwJJkYg5XLVlScKSLUCgfVhs9Vu/GfyQYHNUFJ5VrNJf?=
 =?iso-8859-1?Q?YLjZH1jz4iTaZIOX5eusOFcgCdl2tYeCC1QUJ8fLU417Uz5aLHCzWMM2ua?=
 =?iso-8859-1?Q?zyhrGAElrL2twy47PpQ+Pgb86V/IdNfcY/aPteU9BkqemtQQ4jkuuNWgq8?=
 =?iso-8859-1?Q?uNiLYp3HG/swytNTBjpnov5RtlLsXM29uerjPt5OTMT7csVDiVVaCoBB01?=
 =?iso-8859-1?Q?E4W7ftcTiDM7nhrLVbpNsld8IEYE5DGtNNkytOwgSn9VCO/pmsz5TTbJKK?=
 =?iso-8859-1?Q?Q7xbirduXG6stcJNXgDet1q1G6equMX1La+PKi596cXFv4DIomgFed7tbx?=
 =?iso-8859-1?Q?p475zDpL+PhofnvYRb6gB9B4KrLNZWp/vM++tBpAXvybpJgH+vzoyCyECU?=
 =?iso-8859-1?Q?dzMGN8a37KLPmHU6cYntwERgcjBisyRhvaRxOQegYAOTYeyaxRPn8cKwL+?=
 =?iso-8859-1?Q?cPY+3me/ID7LzXQUOu9NFim1mV4HgD9u0lSkN32eF35L3eqhkSLwyOqW1c?=
 =?iso-8859-1?Q?d48J6K4QJ+J3PWg3dG3nsta4irGmhDbWkD0jzaFoq3c06tHD+3FpHcyNHC?=
 =?iso-8859-1?Q?eXGMicjTML0IL9Usvk7F5dn6Sowz8eCo3/sLCunr96DtBEYziFXLqMtz3+?=
 =?iso-8859-1?Q?ud/mjBgoXGKcdwZIgv/OCNU1ITbDXyCsVlgebeUQVr7Vvj+5eUU592ctgC?=
 =?iso-8859-1?Q?GHxJ4/VVIa8KJBS0iKgL2gPKkx5GRbIzHKrpQblo7+VajW8u+Ta8cLM5PG?=
 =?iso-8859-1?Q?kEzyVvfCW2vDgQ8EBCBSZ7xWZcQDTviYx4tTs4bSFUy04uq5Qd1RVLF/N7?=
 =?iso-8859-1?Q?TQ7kqZ2lh3eKGK/GKn1r7Z49Tu/x+Kmi3ysrO35CKYwGnfDTFbgMVB3kV5?=
 =?iso-8859-1?Q?fQ1u2hcqR6z5hVaQdwpCqmOF5UA8VPND20xQ7EwkpgvD5ck9b74Fqi9o+O?=
 =?iso-8859-1?Q?SmvgQCNhR6EZ1uzWTSC8TXutpJtFra9vFi9t9hFlxmE5wpdZtXynpUBQme?=
 =?iso-8859-1?Q?eEDBkeaIBRcjyieDVbnOSSu5fJkM7wWI6JM9260ADAFPnWzgtjt6d64EWf?=
 =?iso-8859-1?Q?/nHcNjZTpw=3D=3D?=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h+4bteAny4TDIFwLqC/RWXzCjDFh/Z3ncu+je03OQwKfFGO84xJSCace3OlRC7xrbJuNLcnSbO7zey82ijnW4PgY0T69mw2Vvk1XqwtorWQE6Lgtu6HS08XXjupv8C6/gfNZtsJOmCmnZL2hpbevlhmERb709exd1f4Y/L3eEMHSxLTAEuxGNMPPKxuEjINdB8G9PseiosoeUOiNR9lK/MnjPQ1V1X6W+SsdxObeGa/OxdAMp9V03yM5qRfH5KxnmMqimie9kg6tngE2C/uOY1+9Pmm7BpYVG2MDF/JWsDi3uNO9gbvyc5hu6R91cev99bIVfLrhRCGHXXx417q73g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1auuWAjIyTNIbkcO8kyBqj79sXFYIz4OV9lRHpuLZ7wHg/gg/g2sm3fnDfsTJ2Xuy2L9/NLQGx4a3cRANcT5Xh9ohD8M2m5aT/e3geQxX3cQgdm+b2EeLy5zgpg6WCDkAia4RZ3YTuSl5ykTNE6/tKKazVNZQKUDuDggPRwIVAZ8X+h1H1Ry0yhKPLSlq3FPyOnW7l7rbJ7+dbVn+ISCYefRVHHXGomulnJIr73FeibDvegqqs8YCSmVnvSyfcWSRddJQqoDPR48Ky0C90l5Vu+wWKJALa8uHjfnecXV9QWBxVdhCrwsNUiP1Rt4iSlo4BzEz3q2ou20hOG1/df2iQiUTVOtmyF9/j6Xg2joF1WfXwmklLSsKuoCisNCQbwNBFA8gWbgd9ETVZRW4x6S4f1D86reBFrgxO341hd9qsUisbY1kfa2B975X+tKA32qc3VN8dFc0hkCYZAmk1Egu3kixlfMoNanONSHuvW7uji3NbmKCT3+A3V8fk5MPivT/88iISmPuKqq9OqwyFla9Vvq9bwEVPYZ6K+6OeTv8btcs1V2jt0qEirfA88xWhLxuVduCp6gR29vce42OAl7gPyFLTE/cHafx6hyQ3NfWqucUtg9VufUbOWJH68TMOC+
X-OriginatorOrg: francetv.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ced8e9b4-818c-4fbb-0984-08df4662bc1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 17:29:58.6612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aed0e243-afb5-4e96-af34-ea4e5df4979e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyJgBpva+6tD/0iqNQzKigIFFzYteRXX5Ve9CkhevJU+45o8Tp0NL23wdyYIdqHUkiWv1Uk3uYsoUda0vfgj0Yup4V46tnWLV7Wl6rKVotQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3475
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xvsp32-MtsbMloo7dg-H5SHfOSSlPj0WyfXZJIryz_s_1795109400
X-Mimecast-Originator: francetv.fr
Content-Language: fr-FR
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 Sasha Levin wrote:=0A> Ugh, this really looks like a b=
rand new feature... Is it not?=0A=0AIt is, but it's the client side of a se=
curity fix: aes256k is Ceph's=0Aremediation for CVE-2025-30156 (CephX auth =
bypass via the old "aes" key=0Atype) [1]. Completing the remediation means =
disallowing "aes", which=0Abreaks kernel clients older than 7.0 [2]. CentOS=
 Stream 9 and 10 already=0Acarry a backport, and Ilya is fine with this one=
 [3].=0A=0A[1] https://docs.ceph.com/en/latest/security/CVE-2025-30156/=0A[=
2] https://docs.ceph.com/en/latest/rados/configuration/auth-config-ref/#cep=
hx-upgrade=0A[3] https://lore.kernel.org/stable/PR1P264MB1805408F7C4A11E6F4=
D2F6BE887B2@PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM/T/#u=0A=0AThanks,=0AJord=
an=0A

