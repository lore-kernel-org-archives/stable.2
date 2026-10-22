Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792653741;
	b=iXvX08ENtDciKdZ2KnxWvjbE4mSrnFsrW2cmx5btrr5iACk90jT8OJY2dskYxJGwNbtq
	 Q/qy25+OcxIuKexgMluRgEvvzCldTV95bb49sjUaU5O+Zdv05kR88PTVbIqCI8ar3J9ks
	 Q3E7+U+CW6523KV7dw+XVewBHzKWdrhTJjaclZUdSdV5niZlGtzw8ocSSi962JZEdFMGE
	 nTQvWedPfBAJeDnl215bEq680F+2n201EnkybC0m94dSKkdaoH68KNIGBgaIRIVZ+rG62
	 GpNAP4ICSIWuAZZBZysjxvaVLmrcU06sUBsYfRTEP+E/YYqFQIcZZh8q08rL/OcHAdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653741;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=XxmMDLReZ9Ll9AOlZ3BAPOjGNhWdTwu4FBH32haAqWg=;
	b=yJ4MKL7CjFNWnjcMNp632+iPqQgcHIciypVQaQOs3FjNbf287yFl8btdlgOoFKA4YleO
	 MK2CxitGxzjKR7SdyN0S8pMixFFjGrLtOgxO7+X7J0EuSbWQbu/hS3aXL34KLW3cAlcfP
	 RDK0+XrzUQCYAN3SYWvRbeANicgckVi4ktxpUo+A1gpUzyceAMXCAEVSdX/gMzUzihKmC
	 tEuPQ4cXDdJUo+ml59tQOVoWbAvYPevRGbDZ2IagM7jlzUPZ25w5ld9/6C5Tg6cwONjD+
	 9fje91CQTBp/p1RfCH5qOjgxJRPVwygCgkBIcQ65nD+cULi3uEfc/YlXV+Vtn0BvCpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=sPJ1ySGk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.6
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F110606A31A;
	Thu, 22 Oct 2026 07:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F110606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=sPJ1ySGk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlbmbYsDZm4atBH/PmigJM0TqDPyAhK5cpIYL2VFdKPRANHX5cFtAC8oS5OdD0gcOPX1p9XghigE47d8C3vLvpBCh1qw63viOK0wJyYC4J4ukSTbprF9W+E3ixgyFksCH29NoxwSDHYWOuR289qfSpzmisjaPQ5fLIQAOFRLa5aotjUF5PK5xChnC4fOjB4Nq6tBAN56ty8Hs9rAUFKQUhKemJOnVdsxUTRlGwZ4/cX+LMk0WNURr1mwPk7EZESO1RESpoVIVqhvW0DRSttppczdl8O+VJ6eKkyEJokfKZHaywKnhGuFPhu+nZRYpveb/Mk0Gjc0QMyvPc6DfzdyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxmMDLReZ9Ll9AOlZ3BAPOjGNhWdTwu4FBH32haAqWg=;
 b=M+1ynLJtjjLHfLtvmRXouW8Y9lZjdkAobq2QJNxDtbzinaGev8budUzt57fbvZHBbPqqlabVcCU58/aYgYyTU0Qz5MmA9N2suDsZK0QZSA8ZMnEaSt+wteSrDwauMqAlN52KTEnOAvQ8o1jHLvulhrx8NJejOY9r0EQCbEtw9b2bb4K8cXgZO8Uea2Dssc56HtJljE+2K81JyFbajNyrFuRIslAbySVi6VDB3JVl+sE/CQDDomTMpA1JDbwk8ZcYRjOI/1ZS5Uc1t+iK7lXq/anne4EofxwZ2hdBn+Tl3pBpeuxxxrMmZpplkF2oeYRaaXvy/EAmVoTX1m4jsRMsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxmMDLReZ9Ll9AOlZ3BAPOjGNhWdTwu4FBH32haAqWg=;
 b=sPJ1ySGkrFt4/aw7uVZhtZMfqmIS84iHmoTKf3UVP11t3htPUUuTnay7xR1RT8nB1fByboaTAStwO7F+sBxb/aVFM4yQIUs+ICzZLCJ2UaYGAsE0cswoyf5OGpQkw1C4JBM8DIsFkJ5t2majrwdHKHSAaDk2kvhrhsKsBg5Grum4Q1o76O4zuE0bP3U7NsjzQcZg1e8RhvwczRckhTk+pelI37L5w+OqGXY9tJ6oOtLL35w4Pg6EwsiYnFpUZ8nF26CeVY79gYj67w2uaqU4x6AHKTH3zQDRO6HQG3WKh0OGisA0hAxb+bTjXPVit79/ocJIlRgh8Bvf+k+D/5u+Xw==
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 PH0PR02MB7351.namprd02.prod.outlook.com (2603:10b6:510:c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.17; Thu, 22 Oct 2026 07:22:18 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 07:22:18 +0000
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: Matt Johnston <matt@codeconstruct.com.au>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] mctp i2c: fix double free of midev on netdev register
 failure
Thread-Topic: [PATCH net] mctp i2c: fix double free of midev on netdev
 register failure
Thread-Index: AQHdYdPZt9L4lwA9tkiaaSIyPqksNLcI+vmAgAAkp1A=
Date: Thu, 22 Oct 2026 07:22:17 +0000
Message-ID:
 <DM8PR02MB8087DCE3AE16D853D284FF2D8E652@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261022031704.2295541-1-kenny_hsieh@jabil.com>
 <51bf6b10b2fc1c5d6ed7234e61067869380eebad.camel@codeconstruct.com.au>
In-Reply-To:
 <51bf6b10b2fc1c5d6ed7234e61067869380eebad.camel@codeconstruct.com.au>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8087:EE_|PH0PR02MB7351:EE_
x-ms-office365-filtering-correlation-id: 0ffdb94b-0d1b-4b3c-4325-08df300d3448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|56012099006|261021123027099003|22082099003|18002099003|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info:
 kq3ut+fveuweuOviObMYIHL8V1oAWRtaeVNsJRrWYWIf/mqMydv6POj++ERQ8o3MIF0fWVoooGSIYld2yyBCnkWHCpFkbsxouITdH1qQd0h8aog5LwdUAcwQ6ZlytHJctfz+iS4rJ2ShU0LcmEWVqbkICWC8Irs/52MBlppybSo30zXG/6jZ05/EDLnHACvge7mJo/MWXYUFRaSyZ/GgCQLCqunObIEF6NjrUuSZOy9s7eMMf7vE8V7DBjhM8IZ9S3kNmvo5zUSD13raKqmAQMbtY/y3oWfYPKx8XOb5F0GCudvsbDR645yOby1xJHtDnB2RZzB9emB4XDF0QXDZ34DPV98u0wS9bHKNvsKzliLgYW25kV0SWaMV/daAyATt4O1swR+ei5CyMMfQuZCPf3VyCk2ktXYscSVfvKMRjnsNvBi1te82QtYcHZ0a6huxctIbQ6/Nlo9Kujd1NYgYVMTp64YYni28/YcKdMlWEjZPiuBboOX1eAzsjdmmcCs4vYsnIKQl1K4cCfYEHghZmI+JkzbpjbtFBZNEowyCAjVqoNYJND4fwJJ1g6w62WSdYRu73vzbOwsWZI/1LEH/+TBB8Dgs7vIT3zUBHL1+0+0kYSdJwsxHIMHbhHzGrPNkZ1c5XRL6LULhF/jJuzFUyAfdG9nHG+Rg18e18NvLgdm6Ct20s8IarNhvgVjHEOuRJ8xCbBX2WCL2NYo7/MxzRQ5SBsBb3TmrsxAORH6e8+4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(56012099006)(261021123027099003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dU84dlpLcnoyRUhPUTdXY0xlMDV6OE1PN0RwLzhoVzlSTVZTUDBNeVk5VnI1?=
 =?utf-8?B?MjNvdVNpYU1rYWRDR0RyWC9RUjMrVEVwdG9xQ3J0Q1VoY2s1NG8vd2FUbDNG?=
 =?utf-8?B?cVdQWkllM2QrV04vcHRiSFZac3laNnM4cGIrc2N2U1Z0TGJ0Vi9IUVdBVS9J?=
 =?utf-8?B?Q203eUVLd0E3TUFwV0NycTl5ZmlsTG0vZlI3azE0eVQvQjY1L3ZwalBITlV1?=
 =?utf-8?B?SVBkaXlxRHJnZFhyN0RCKzd4cStjT1pZMklod1RNZlhxM2VYRUh1Y2hnRVRi?=
 =?utf-8?B?MDAyd2ptWFY4UTZLZm5FdXFvdVVEQ3poTm85MjQrZDI5Zzh1cVRDRjVrZjN3?=
 =?utf-8?B?WUx1WFk1M2FYTTBkOXlBL0JEaTBWQmxrNUhlcENNSmdzWHFnSXYrcGx3NXFr?=
 =?utf-8?B?bkVoQk5QUGFhcVJZQTFjMmIzUnBrbXl4N3JadlhQSnN0WjNSTVpCdGUwRVIz?=
 =?utf-8?B?SStwd01ib25ZM09FL0FGS3F0OStDZmZvdzQ4NjlRSzMvdGM3anVtSUltZlps?=
 =?utf-8?B?enJ2UFlxcXJzbDhnMkdPdHhucjBpWjkxWU9KRlVQbkZldmcra3VNSkRwTTEz?=
 =?utf-8?B?YXVGQ3pERERWQnVYRXhZMnNNaWRkaWtJZ3FycEZ4azBpMXJzQk5ISE0yZXcw?=
 =?utf-8?B?aUhUdUpieHhJbWVLbzcrVjZVR2drM2E5M1lhZkxvQ0ZpK0xVZHR5Q1prQ2hi?=
 =?utf-8?B?UWJsdzBna2t1QmZrUE1GVGVBQmt5aXVTOTJCWlhKdUdiT0l3Wm9FSmdwdCtq?=
 =?utf-8?B?S1k3dUNVMVM0VFBJcDJXQ25Wdko3Q0FIQ0M5K2ZTQjJOY01JYWxucFE2YlRE?=
 =?utf-8?B?cU92NFBIQ2Z5bzAzejNBaFNSN1R6T3c1eUxoY3FwVFhrb0xnS2ZjMTB3bXhh?=
 =?utf-8?B?VDhvY3RZU01YUzlOQ2Q1VFQwZE9TWmNEU2NvWmxRa0JLWTNoajdIOVRDak82?=
 =?utf-8?B?S0d2REtRYTdlT3hROEFxQUxhYjJQVm83anV6QTBua3dJUGFkeStoY2tackFs?=
 =?utf-8?B?NkovVmVDbmhXalJOaEs1dU56OUlLNWpOL3NyOCt0M01HNEpHQ2J2VXdtWXRE?=
 =?utf-8?B?T21nVFBic0ViZmlzR0R1TnNFN3NmTytkQXgyejByMUFMOXJwNkUwdzhlcWky?=
 =?utf-8?B?Q3VkZnVMTXVoc1U4YzlnTGZIVm1BZ00yc3pqMlFrUzVZZk9ySnFGSnNwQnlD?=
 =?utf-8?B?NE1BaW9ReUFjL0w0bkVZQlV6Y3R4S0RzcEllc2NPbzlqYzd6MkMzd0QxYTd2?=
 =?utf-8?B?SU5TVCtXd0EwU3RqMFBONi9OY0FhMGFvODlyUVkxK2xoUk4rU0p4c05Lblpu?=
 =?utf-8?B?eENCNXRvcUwzVERreEhQcXcrdnh5VFJ6T0dZVmhySklGSGpUVXM2N1gwaEMr?=
 =?utf-8?B?NWM3SUtwcFNlSGVGTmlnNnV4TGZERm1WSm1USElnSnpuUnN3Y1A0S254WFVV?=
 =?utf-8?B?WFpWdktNdGhTYUJSM1drQWw1UzIyQjhSWEYrcEhUeGlxVW5DYTViekFhSHRz?=
 =?utf-8?B?M3NrL2hKaFBDTit3ajBPdXhjZjBndlU4c1RJUm9yTGJmZGVjRklqY084OTRD?=
 =?utf-8?B?UEZIRG5RUzRwMXFHVmExSlJhSWo5dlVHOFFtMXBVb2NXQjVKV0l4YklseWNy?=
 =?utf-8?B?aGo5bEdwQ0RKOGREYXVIWFE0VVF6WXJ3VlpLV3dyZ0VIYUJCbVZmMkZXVVZ6?=
 =?utf-8?B?UzUxaDJXOFh6ZWpMSk9PeXd5S1o2K1hFMXljczlBMzJoM2k4SHJNdnpVY3k4?=
 =?utf-8?B?T2lIcSt5NHU3ODJBMWJJWXhGeVdrNzZTZitRcUlWWGVjR1hEWG8vQVQwY3Na?=
 =?utf-8?B?TDVKY3Mvb3JMT0JEdGNSQjNjckVFdTNpZlhNd2dDbnB4Tnd5ZzNSaUxMVWZB?=
 =?utf-8?B?NC9NcDdVNjBFeVR6MXdrQlU0UElLa01KSVdFL2w3d2ZYcWx6T2s4bTZNd1FC?=
 =?utf-8?B?dnVRazRvMmZHWE11Y21MZVR1WVFvMmpRcnA0eXlxbFRTVmcrNFMvVDh6Rm1B?=
 =?utf-8?B?Q2tHTmVVZHh3ZnVEUzNhZEdWYmRGcVRtRERIT1F0OTJiekxNNlk0eWlLclJk?=
 =?utf-8?B?U0dwK0tBbnIyTjRYTGxLQ3lqTTFWQlllQWRlWU5VWm9YNHBLTThDWE12SUlC?=
 =?utf-8?B?V09HdkxmaDBlT0ZQVzExTEhuQUM3WXAvVkpQV09pNTQ0US9yNXFuZlZrb1Vu?=
 =?utf-8?B?Q0Y4L25HeHVBQTBCSmM0a0ZQVUpqaDVJWk5vQ1ZLbjdDQVFUakNJRTd3TFJZ?=
 =?utf-8?B?RW1mQ01uVG42K3h3M2ZNUzEzSGFrZ2g3N01kMC92dDdaMzI4b1RRS0tWTzBx?=
 =?utf-8?B?cHNtcUJDSkdZaG4zaWNURGpUWXNRR2FsMExLQmdIRnJ3NXdPbEZPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8087.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffdb94b-0d1b-4b3c-4325-08df300d3448
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 07:22:17.9419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ThyKUw6CDMQCyy4lgPMf2iXmKFgMhwsGjCOiIW9inEOYqs+yKHTLQALG3V4vzUF+AVwZUcwZ5A5F0Edk6gPUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7351

SGkgTWF0dCwNCg0KT24gVGh1LCAyMDI2LTEwLTIyIGF0IDEyOjM5ICswODAwLCBNYXR0IEpvaG5z
dG9uIHdyb3RlOg0KPiBJIHdvbmRlciBpZiBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gZGVsZXRlIG1j
dHBfaTJjX25kb191bmluaXQoKSBhbmQgbW92ZSB0aGUNCj4gdGhlIG1jdHBfaTJjX21pZGV2X2Zy
ZWUoKSB0byBtY3RwX2kyY191bnJlZ2lzdGVyKCksIGJlZm9yZSBmcmVlX25ldGRldigpLg0KPiBU
aGVuIHRoZSBmcmVlIHNlcXVlbmNlIHdvdWxkIGJlIHN5bW1ldHJpY2FsIHdpdGggdGhlIGluaXQg
c2VxdWVuY2UgaW4NCj4gbWN0cF9pMmNfYWRkX25ldGRldi4NCg0KQWdyZWVkLCB0aGF0IGlzIGNs
ZWFuZXIgdGhhbiBtYWtpbmcgdGhlIGZyZWUgaWRlbXBvdGVudC4gSGVyZSdzIHdoYXQgSSdtDQpw
bGFubmluZywgbGV0IG1lIGtub3cgaWYgaXQgbG9va3MgcmlnaHQgYW5kIEknbGwgZ28gYWhlYWQ6
DQoNCiAgLSBpbiBtY3RwX2kyY191bnJlZ2lzdGVyKCksIGRlc2VsZWN0IG1jbGktPnNlbCBpZiBp
dCBwb2ludHMgYXQgdGhpcw0KICAgIG1pZGV2LCBiZWZvcmUgbWN0cF91bnJlZ2lzdGVyX25ldGRl
digpLCBzbyBpdHMgZGV2X2hvbGQoKSBkb2Vzbid0DQogICAgYmxvY2sgdGhlIHVucmVnaXN0ZXIu
DQogIC0gY2FsbCBtY3RwX2kyY19taWRldl9mcmVlKCkgYWZ0ZXIgbWN0cF91bnJlZ2lzdGVyX25l
dGRldigpIGFuZCBiZWZvcmUNCiAgICBmcmVlX25ldGRldigpLCBhbmQgdGFrZSB0aGUgc2VsIGhh
bmRsaW5nIG91dCBvZiBpdCBzaW5jZSB0aGF0IG5vdw0KICAgIGhhcHBlbnMgZWFybGllci4NCiAg
LSBsZWF2ZSB0aGUgbWN0cF9pMmNfYWRkX25ldGRldigpIGVycm9yIHBhdGggY2FsbGluZw0KICAg
IG1jdHBfaTJjX21pZGV2X2ZyZWUoKSBhcyBpdCBpcywgd2hpY2ggdGhlbiBiZWNvbWVzIHRoZSBv
bmx5IGZyZWUgb24NCiAgICBhIGZhaWxlZCByZWdpc3Rlci4NCiAgLSBkZWxldGUgbWN0cF9pMmNf
bmRvX3VuaW5pdCgpIGFuZCAubmRvX3VuaW5pdC4NCg==
