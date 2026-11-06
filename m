Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793941747;
	b=3xvJwJWaz936n0rpH9PYlmnVyhlkBmokJCaHhNGzslNLxi39CNtMYxzuWXhpXvrJDtjD
	 Ir+MCd1+R1aAbW0q3keiWFqyCQiRGhZnuYMKQxv0p0kKc3fqZnOohMdvPf/Q660BlhQ89
	 i20MH0nhtdm6YdiTT0mRLnM7O4sEyRuGza/FlOgsmYBVqsythpXcrNyt//RTtF168DNnN
	 7Kx7UZ5xc0L3YaPv0OiSs4V6K2pVDsreqQwZdRFDPYlELuMGVPIlvVob/rXQWwZnpjPv9
	 GneWU2AI0/uR2+3mlIt3Z+7cPZC97dieYSZmXT5KLbqUMo2uk0S9xeFk6/eqep4gbdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941747;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MBHbLslr389j//83MkfywuyGralPV80DViS8tU9jTlo=;
	b=Z+2SClaHdqLPh4F0slG/33Eyr6EV00Qr0IVdmxO+w3D4SH8Ba7bS2rJZOIWvYWSP+rqW
	 DNrxYvYiDS4WYEJf7kKXaAeLFBq8DU/e9rmtsplaldIUOQG4XI3Fq60LNe9UiZcAPxQjh
	 VN1I9j+3eua3djB1ST3NJTiyy6wlcv8n66Azrn8amqoFqu+SGyZChaRp47P7lXP+mphhp
	 USofcw01YDCR7R0BatcX7mYSAqYxmKQfBUFsJp78bS5zunU3HzP8fBCVkQyU3plIAs+VK
	 dLqX08llPMwkE9deWcCDCLWj6nr6WxxxaW0RJWZrs1gZ47uPJxUmZgiskqHSP6DDa+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E7li3ePP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.69
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2257606A31B;
	Fri,  6 Nov 2026 05:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2257606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E7li3ePP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAgop6elOKTKAHD9rWtZr4d+yV5IqDlTLFGiY4tyYDHvB4AdZNhescqcMbvwEKtRQif3b+bH4sXFvUZvwSTVk0E7xbooh24nm7fi+e1vnIoxt8iAc8sTcRlWS6QS1YUMeIVz/OCWM7NLCPKySwccKst2zMuQacuOmT32myk36xsBVlj/EJNaJZSrQyUMkGw5v5Zr8cmNF8i5nTzgnfugWAvX0rAoa25DXd7ukI79lSEgvMIDcGiC0Max8Ut3V5sXqkDFeCaF2eoiSF1bCikLyKXdgFdW656PAIZRVMnwilapLUaQRvhe4AnWRKOzIKldKRmVILjorbM52++QRx1+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBHbLslr389j//83MkfywuyGralPV80DViS8tU9jTlo=;
 b=N2v1rIUCpIRhwjDmOj8LkiBo6t5H8ftJgkoKLyn+tP+nvLaGxUDtJS45JDoH0MOfrQf5l60OXcCRGl7NU92CMX1xn54FHlAASB+rGH233jjsaNTw0BJlxU48rCYmIl8/2gM7u/d43Wxp1a2V+IIaXhkWxH2i4bU9uL2NRCwPRzvpHOU5XDbuXn7yTMVsFy2PSWJhrjnc7So3fI/OPVmVGXFe5XCs7ZojbMpGojkrVfM6DuqZ7JJ4WYfh4xKt/6U6CFveNSIRUue428d5sbByDmJF6a2x7J1+AX8Qx8m2acUoRumCfn1BY+/8pA6omgP7lxcAqDKGQ/ul6MHHivnPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBHbLslr389j//83MkfywuyGralPV80DViS8tU9jTlo=;
 b=E7li3ePPwT7EP6iZD0e485GRrnbGhhSlw0s+IGsbwfuAIkQtxL0340AEcofjVuHqDwRP3hy+pvRUp0ZdKG9HyhNGXYhQK6DIY7PZXsNLrn0Xo7OfOdq5YjaesVGkSK+l2v0zfTMCfqM8o9I0ceVqeEBgpB+5gq0hXD4w5AjtcTpPirvGftysGL/bl4BFf/tpUjA1KsMxxtjLRyCwRyyX5GUqoAm56M9dghJvGBczz18YJVzAM9JZIe1NnVqyjKWEHDuciAsehR3HA0r5w46MeKBWCfdm3GisIhSBejy3R/eQxHy4xVMpW/CzQSufq1pOEhKzRcTdZYwmvruQSJ+Wlg==
Received: from PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:09:02 +0000
Received: from PH7PR12MB8794.namprd12.prod.outlook.com
 ([fe80::275a:bcb7:918e:7313]) by PH7PR12MB8794.namprd12.prod.outlook.com
 ([fe80::275a:bcb7:918e:7313%3]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 05:09:02 +0000
From: Daniel Trujillo <datrujillo@nvidia.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "dsahern@kernel.org" <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "alexander.h.duyck@redhat.com"
	<alexander.h.duyck@redhat.com>
Subject: Re: [PATCH net v2] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
Thread-Topic: [PATCH net v2] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
Thread-Index: AQHdWHl1kW8JApKlHk2ofqWtKk1FMbb32KkAgCjP51I=
Date: Fri, 6 Nov 2026 05:09:02 +0000
Message-ID:
 <PH7PR12MB8794FE0E2AE05E38AB9EAA81B2762@PH7PR12MB8794.namprd12.prod.outlook.com>
References: <20261010-fib-trie-nospec-v2-1-30319b4db8d0@nvidia.com>
 <179169799489.434549.6127227149225091641@kernel.org>
In-Reply-To: <179169799489.434549.6127227149225091641@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8794:EE_|SN7PR12MB6715:EE_
x-ms-office365-filtering-correlation-id: ba44fbc1-380a-4fd7-b0b0-08df3bc412ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|18002099003|22082099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 JUCkoV4OQqUnZgNW91Ibq90v91bRYvtKAUgqfmHdZOWTklwdpeEOydFebp5/TKPnyRtODtIMIYL/KfhjZCCwraVn6kk00t3EkHezQEDx3zwNdvUlQREwCcjSm4I0zzo41lSjlkgRrqqh8p4PCpYJZzvm7ccXK+LiW+hvB65Wd1306bWSFfHw3yIcSukxmcQ0EYvGRGhqXF5tn/M/c4qv40enjnF1NU1unGE1vvAzBnDbCoM3AElq8tYoNl0N/nmDbMoX2rUdSHDIQJRtRwJ12wy0P6Fa1f4BUzSJYCXifyipWO6QfNYMs8bUI/6hUV+ueaXNYewmHV5ckw4Ee6XNliroKC8E7vaOLJDUJYqCWTe9ZSEKDeyelOR7HlFDn1+Fes5CsLVS2YoV2aS3PL1SThwWHKniWKtjd32ralH/mObWb1jALI2M1ZB96Yc4yENRu9eSANFzDMRXUvIYlFkPTPXyJ5i9BvG80yjze+MErMcN9irGS0U1OBmIV1BLM8OTgaYNhgqEuAi56ht356Nb3eW+iDNZUVN8LiohxRGDuCZh5oilhpUUqPvnVjUgsADZD7BucD+uAFShdidaAumV5dAsfQWTUChB600NBEL/ROLPmDFSoyVhhRSYMj1ruZlJC/yd2TPhGMqoFgi4qHyjJxCvQ05/ebpdo6Gg3jozigE8dOpX7dWlvvZhtWMG4dVu+u5iNEG8pOXalv5rKRCEmzYLuYVCES6A4Zm9dPk4lGc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8794.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WiCiL9CImPNUJguIeTI8guC6J/530pbdJ3KV+aLchs67KSIY9WN5IaC5nR?=
 =?iso-8859-1?Q?CeduXyKpo1vkoxIzb2Q0BOdK1bnFp/cCqi4gjW+vS357SqwmJ2S2/x/zqC?=
 =?iso-8859-1?Q?V50gVhtU0PaD3Rrxbd53V43jY+LYz3+loduGY35ybOGPXw9u4tVOtv7Rv6?=
 =?iso-8859-1?Q?fW/pFlJVYWQNpzQGBIvCuhyvPz09uZ6Oi98gAO8IpRRhEUzKphnwzrQyBN?=
 =?iso-8859-1?Q?SA8ESFRNnj8rMs403M/X+ERga2RqREoGNRomujD52TiWc5NzqU1Vz668Qc?=
 =?iso-8859-1?Q?jMDsjYw1iIjkW/xyXq3GhFmhlF27iXXsjbjQre0Iw5cac7qfRWxu4ldHUQ?=
 =?iso-8859-1?Q?KD1K/+CWM7GXm150kFBokwd8q/6JO4vgmTFAo/tv4T0Qy7719tFUNMCu4n?=
 =?iso-8859-1?Q?CacExaSoBvzNNI7MWoLwcou+uEFEJLKk2Im5qDsUY0JddCK/kvXCvPjLHq?=
 =?iso-8859-1?Q?U+mo0r13WY42kjlALVX0Jf6BycyQnogyxKUPFA1NcCcFpIAqPGxPMaQkmC?=
 =?iso-8859-1?Q?QYHAqkqPLn+d8V/e72wbWg+ILk+fpxEdJJ8AOEIWrrmAj6ClNb6vrFFyzc?=
 =?iso-8859-1?Q?9yZ13p8kmyzfdbo+fQd327+MeiTntmCJvlymo1H5EKVv0OriwRhvdsDTyI?=
 =?iso-8859-1?Q?bUI+RNbJVDyoP8y+MhQK0gREZJRQAC75YR/YsRNonRHJsrhuWzvIGByshM?=
 =?iso-8859-1?Q?63Tx4m3Cb6e9ORzhSiirxIma5vRHTlqyIQ6FF/2baWECYW//CTwV+60Txj?=
 =?iso-8859-1?Q?KJc7yHaRQIXGZbDZeq49BbFVkD20Fd3t0Nx8wG5q8zjWM/JwRyxghVV2J0?=
 =?iso-8859-1?Q?cxI84ZSADEyMqxz3shII2YYT8JYZtmi8p/wy++kv6aAU5qmXx3XJ9qRiNy?=
 =?iso-8859-1?Q?9XePlGRM/7OYq++LckfNjBvAiVpPdBSsbS7GSi5OI7RGRjAu0lfXe7VYwe?=
 =?iso-8859-1?Q?IaLcKPfVBEPEKvZtxwyrZNGj3RjvKcBdQl5MSV1nmSI7Ce29i8mfHbHZ5e?=
 =?iso-8859-1?Q?1M69IPEW42KtrcsVdjp1h9eYej0AhjvSi/Q5XHlGfz/9+xGB1M6qB5Ojw9?=
 =?iso-8859-1?Q?pfRAl9KAyEadvAHFj/guRZcWrNf5QHoPG9T2BhKJueWQPSs1EvFP/n/nYO?=
 =?iso-8859-1?Q?qi1zDUYN67Nq1mwtVuSxFrHZ58pF3Qv20v23JmbhHH+1eK195SMuL5dzQo?=
 =?iso-8859-1?Q?h9EHnsHubt/5zW7eS/UIC7OFW6KgiD7nCa3fR55IPzgbbMBhOvUqHYedBC?=
 =?iso-8859-1?Q?RwY0kpsG+XSKmFfySwhRTzvtDDdevr+bS4e8mzqgY9fYWQoJuCEolP2AKg?=
 =?iso-8859-1?Q?2V2v4lqAF/9tuIVWhnAHdxkRYZQe3l4HYu14F6Tp4RYoxdeySXpT3x8s1k?=
 =?iso-8859-1?Q?JOE7vynhEtWMPhpXCx3qmSEcQ9vI4zNKI0krR1JAxaOEJIgEUyA5RZKulM?=
 =?iso-8859-1?Q?WqlNYOO9OAm0orNIXL/kn/37gXlvIucAQwnnMW8wziwslxyR1HFsUJ7wE4?=
 =?iso-8859-1?Q?fzVttH2vmemjV8RXN4iXvygxCe8R/IJ/3m2E9vaxYWkYAsmvTbsxLrglm2?=
 =?iso-8859-1?Q?HSuwVhxGG6cqVwjpSt2cBXkhPdiAedIrmus8uxySOaFKMyExH2xIzFNrNl?=
 =?iso-8859-1?Q?4n1g4qySUoYm0M1P9w0iFhQZWmx7KDBQey1dzPc8TuvQ/8aB5/Ujbdr9xf?=
 =?iso-8859-1?Q?0hGqi4MafbrPfksYqJTjVPSAzrd1e0SGuyqYzyhJt50UooyVokIZgk5l/M?=
 =?iso-8859-1?Q?a57J2dNSMcGhJxEK0OMoP71BaqltVTN8jRCOSpxcOL1mseDiWRiwYxJYlh?=
 =?iso-8859-1?Q?b/e+VJc4yA=3D=3D?=
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
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba44fbc1-380a-4fd7-b0b0-08df3bc412ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 05:09:02.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIbU2fcAa0Mpf6ytSIqBZgIpSBJxZvz+S70oqQZh5hEMg1p4VUlJjkop5AyDlWMIG5jvXbofc8PXiLvmsg9S+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715

Agreed that this access can be hardened as well for consistency. I've added=
 array_index_nospec() to fib_trie_get_next() in v3.=0A=
=0A=
pw-bot: cr=
