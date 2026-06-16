Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3B383C65;
	Tue, 16 Jun 2026 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609697; cv=fail; b=BY33IMSJqpqUogk0+b/n9o3WNhDdvWHzeV68qaGuwbXfqfpzmx8xBg19qmr/l2AgFGTgiFoABaRCsagLbqxBgGF1jV1o9g7rzGjrfLizHcopZDdgRd6iIqcoLOwiLgGX2Dih/BkQXct4T/R7S68uruXbMK3BHBnPBXK3igdAuFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609697; c=relaxed/simple;
	bh=dYOBP7WcVgGeW1BwOCI36266Z4vIGjWACoHCK73Kp/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MPkhV1JRqfXKh2Bsk6t0goWQbrgTa5uhhCVUXngbHxgWPboGmNmvCX3tDpCMMyyhJfhOcFZHe9FLiYmU55tYc/4yhTnw+gtScEr8rbFHC82Ir1P5w2za5MyTqEv2JjSYckLjKHhv7fF2WNkdA1pcv2ViqFfzUWhL+6XWRyl0j2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=a0CtzMkb; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="a0CtzMkb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chK/6kp4N0MaISIBWaLKM5TIZJKiItiNrEZQ3A9/qWzMS87JGAbP1KVQZLhANX5nr/Pv6ETbNOXsFfLTPIHlDlEsaOZBBW7JfLhY7+B1QuQ/vkaA8hYjrCYiQzJajWdmVIE53StGOm6SqZYbbhdhTWqFTFtpkHLURli5hHRa/PcYJtcB3ZiNiBZJVxik9wZD7sFVphPJi60bomGo97D59ZlhlBlVdOi3PyZoKqWiVVhTaodo4mK1KntpfOlFumMSySTapj7IV0u13qb147nmeifeCzP8aPMPlZyfZfUTX9nBhkLuLWOzESfsMcvdWqfRCrtNnmqPLanIl6zv3iicLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYOBP7WcVgGeW1BwOCI36266Z4vIGjWACoHCK73Kp/w=;
 b=cn9UtckKPsK9tMJ4bkVnF7QJbo6HeDJDVKPMAVoKCsOPpQ6M2hlkVwopy/CdS6jgFeFs0ur49Xpd2x6EH98DzLvbeuruX4yUcOIQMIUSuv9TINbeAAvv5V2ROOyoQXsJBpq+W8LkVcAAT9UNAC0ObAXFIeHs48gi2D2ihpFHapSDIqPCMurlr52mmrhD3InvQNjPXX6eLuK5gqByAPQSC53L9V1c9mbova9MNXQGay6F1M0iwnAOmtMZogXgh3a74+bUqteoo7IwCC3AGBCg0TqeAi9si6kDYCnQ1Yq0oaEx+w3jH4B1sx6XJJciRAjg0nkdywvPs452a1E3Nope7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYOBP7WcVgGeW1BwOCI36266Z4vIGjWACoHCK73Kp/w=;
 b=a0CtzMkbr5ygBsajHP54owWxkkvj7GmoCOoztYSinfgS/tDe/v+EyTvQ9WbKb7OB0I6YZkyBcvkaLB2BXGGVpnaY67cassipLRwfuQ8ejF52HhANCbRbOOI8Qu0uB+ZDhQY+a64+ffSvNu7ibCGQUjldGbWhB+dtGrkm9W6IhyqFdBBIPRmln4a9G+QZbX74vQ9vI8QMHp64bxYHFc5VSpuspptmH5f5/FK5RfUHFGwKa06srRavM9wCtsMjb0f9GFdFXJMwCBnvwzyiB6muc1OttdafIK+GAWBHYm9HCWjc4fTuJvCd6B19m/JbopkpUzXvFwdZH889dPlX7NKchg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS8P189MB2467.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5ab::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.14; Tue, 16 Jun 2026 11:34:52 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:34:51 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Sam P <sam@bynar.io>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>
Subject: Re: [PATCH net] tipc: free bearer discoverer via RCU to fix
 tipc_disc_rcv UAF
Thread-Topic: [PATCH net] tipc: free bearer discoverer via RCU to fix
 tipc_disc_rcv UAF
Thread-Index: AQHc/NgOlS3jRPn6sEuvn9KJLah7KLZAzXLQgAA4rwCAAAY7Kg==
Date: Tue, 16 Jun 2026 11:34:51 +0000
Message-ID:
 <GV1P189MB198826C04CB2DE2451B4B4F1C6E52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260615150009.1734270-1-sam@bynar.io>
 <GV1P189MB19887A9A37B5B170C112DF8EC6E52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <fa2e0cfb-9d60-4295-8a46-f69ce1229094@bynar.io>
In-Reply-To: <fa2e0cfb-9d60-4295-8a46-f69ce1229094@bynar.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS8P189MB2467:EE_
x-ms-office365-filtering-correlation-id: 70d04100-6043-4507-6eac-08decb9b47d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|10070799003|7416014|1800799024|376014|366016|4143699003|11063799006|56012099006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info:
 1c53HXXRt2N4eFlQWyks8gsn2+xmuSJjt+ct2BFaFSOsANQ5mt8u3On5E2Kq3ck2+M1PbTE/LhaLFcqG8Q5PtLuAOoprX0hGpR69K7vhN3amwvfNwq5lLy8Jth2OV8+t3yIwEcs8lnmAl3bIK1YHB/fcIlBjqXaD9G5WXrWQeMweDXHY9r9zlH8jP4gOt+TeKg99b414cxY6ff8C1y235U8ObgUWMxIVJOXwwRr9MJ2r1d6QN7nQnO/WUyfmLwTo0OQGgzCYy7aLvVFY5F889ns1dYcWBln2who3u891KS0QYZZ2E5/8yZs4UxrYTk4BNv1kNEsielNcKDv/cwfXJ2X/6MWdtb6Vxvs11EECvefynT1mlyYjSMKKDf4pybJ8BrNB05gQJWQBeFC+EEER4kYsGqzEX83TIqN80G0f8QFDmjNMSNwPR/pM/IoyI4UUm+8isQAZX2vTi4KntAKK7gYpNpAtZ6ZoAhbMah71ZfWEnmXeGhKc49N6MwhF+zGMn4vbftf3X3YH2qBSAvwHfOE5IuhDJaO0VUq1o/A6IdxzVaP4cEM+AI2mtPI9bOFoz85MfCzsG5BKDUQhmbOwPOKtFRz51p+jwxA/8Oma14Tg/KENa/eEjsnUYa9Z+ozYgFxETuq90xDvttZzYWiEBxuaAHdm8Lm91qdLhy6pV2WZ+F3qoVrSkCAoPXxaS+JVqdDRW+1v2MmpNV8k6J2xAJu773NiJtTHarS9la3bhYRRZM1I4TCqtn46otWkqg1O
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(7416014)(1800799024)(376014)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?S29rifIBdkLu75i8aKL9v46j+DmDtBECFy7mAGmah1uhPJga+y7qzAMPRc?=
 =?iso-8859-1?Q?eiJW2rfe/zAls2zUpYF6oWKKuJTZ6/Gesg3g3eBvGgs9Z+KEuNwB8LAodl?=
 =?iso-8859-1?Q?bbjOZ7vZw79HFGSP3XAWn3t22Kh5q2bx+C8V4RQTFLG1fJqGacd3XzNzff?=
 =?iso-8859-1?Q?8xGiRkZGt7HkHF5XxxkdXOoG1TibInN6c0dfOAtU2gc4vO2x8KMJQHaUfv?=
 =?iso-8859-1?Q?V6ueO7G7xyLyte9oJsJ2nnluo9B50aCqgDF1xBl1ZH4frdkYyeGCyewxul?=
 =?iso-8859-1?Q?yUdEVN+3wBYpl7ucv4xgHaLEijnJqpwlthQS3q9cZCHlGTF2n8iSZ+T+hs?=
 =?iso-8859-1?Q?h58QMKjAw/csUMYbqbDwdk56BGyBM/+DxICqdNmUOlH8cwdUhYw8f80NYY?=
 =?iso-8859-1?Q?NlgGM+n7XSP8F3c5zDRaHdkCBUIhoXh5O8fcVzXmvFmmTBh7i/pezuSbaJ?=
 =?iso-8859-1?Q?Lfc4BATysCdDrFtPOx6rx5oU2erRHbiT878aIx4MjC20WInWKbbLjg/SrP?=
 =?iso-8859-1?Q?wJcxlapBzple+IjDIuojj9iNlSlY3f1O5+cqSX6S6PNeCjgBB7zS1vlG3D?=
 =?iso-8859-1?Q?x0oe9jkKePPyBjohuCkQ/OkyMI+HHJpuGUQw/x/KSyPjzP3fyfI5mrlWyk?=
 =?iso-8859-1?Q?F81r9MdmGdZqr7VRpIujIzmdeo4mNQtekwRdksvGcpeqIWBpysK8alBzAK?=
 =?iso-8859-1?Q?1EjZ/w2OiSfekQMu2kQD69ixgEWskK3ngjFuNfrfC6eHVhIZlJ5CKFW3ZA?=
 =?iso-8859-1?Q?LbkCT4/XxHiTVvrrS8F5ayq3jwf7/lTC2KKMRn7g3BRCRMP2IgmR1oB1tr?=
 =?iso-8859-1?Q?xJM5hsuQx7ajilDTnYcDLOTJod478eteiGxCpCzPyyBMI1gnNhRJN7cME4?=
 =?iso-8859-1?Q?8P/VFCEQNVJOsFAu3ld54MH4JwCbw+I7XcYJHKnZmjPx/D3uQntMKJlXvf?=
 =?iso-8859-1?Q?OdP8gnv1/uiUX8L9RmBEElJdeQNmt28pG8Km5TZGlsUwEh8JIoxku+fe7Z?=
 =?iso-8859-1?Q?ONYWEnRg8vB9AzxrESHXzgBGs/f5XewrZ04Vbh7bSzGqs7QeF2dYnc+xo2?=
 =?iso-8859-1?Q?aRkqPB+F6fSx7jJCZrQ22o21Xk74PH6VMU0EV8tByBmynqlhbAL7oj1T9Z?=
 =?iso-8859-1?Q?H88aEp5K9RrByS/Xxy3D5jlfA4mp0kBoKCooR6/VO47RxB7M/vOF3HPQdz?=
 =?iso-8859-1?Q?Lmlwmnxke3dSV3YjcLJsg8z/93KPnn/oQrGPRJeAeYdQrwQomLDi+7H8HA?=
 =?iso-8859-1?Q?jA4AXo4Ka4E9xbmA36KT7gHMs7PLoJ7MqwZlnmM44BEeCB3rSiib5lSoFg?=
 =?iso-8859-1?Q?15a94nwWY1+hgq3+Kv4YqBk23V/9YUNRxl9H5Sx9ZUIkL29ibGgWOt0eLD?=
 =?iso-8859-1?Q?TrIM1B8HYDVf2/BW0S5D+/1qwLd5xlrmijt8NgWffTAvpjxOlmlpgn+5B4?=
 =?iso-8859-1?Q?TfP/1AqmdJc3DPYf0Tzqjpg5n8W5HxI5hWHUR7nW4u0OF+/pi3ijQchXwF?=
 =?iso-8859-1?Q?2/3Gy3otGIELzMyaN4ZLK7L0IJaoCRJS+vN21pPBAE+7hPHxnCmCS7EMPn?=
 =?iso-8859-1?Q?pWnHJcxcLM4nmUjIcXyetd5Y1YDxHb6noyf/p2OhakatGtbGVN3qDXY3p3?=
 =?iso-8859-1?Q?C/yBqcRCTtNrPE8PHKQ3DjMM9lBpbiFc1dQwj8tZlGQV43OlRVobB8KDVh?=
 =?iso-8859-1?Q?QAt4C2K7Ic+GE4KwqQoIhv7o338IMYrkec1FSCe09x/WVlIp0X13wNiWk+?=
 =?iso-8859-1?Q?folHF3WBPzkGxrZdgG2GXZS3UVXkMfPNLBFEtFzL545DO3zb9xz6ycG7Mc?=
 =?iso-8859-1?Q?xAEbD669W/3MusMQ70+Gw2IJBnDAL25Zrd08X/j8PjA/Mw+I9KSi6AbMG3?=
 =?iso-8859-1?Q?+Q?=
x-ms-exchange-antispam-messagedata-1: xbmkPBfEKPVw1g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d04100-6043-4507-6eac-08decb9b47d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 11:34:51.7940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0nwXjGtMlehI/++NX9yW1YnXa30iK/6kTEHdMj9rfTOy8Lll7JVuaNFSO+Ywkw+YP9MbHcxjeZZ/2jvuaz/+KGMk+/ujpPgqMRl6leqWiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2467

Subject: Re: [PATCH net] tipc: free bearer discoverer via RCU to fix tipc_d=
isc_rcv UAF=0A=
=0A=
> Oops, I missed that patch! I'm not sure what the etiquette=0A=
> is in this case, but I'm happy to defer to the original=0A=
> submitter (CCd) if they're working on a new patch and/or=0A=
> add any appropriate trailers to my v2.=0A=
=0A=
> I've prepared a v2 to submit after the ~24h period,=0A=
> addressing your changes and taking into account Eric's=0A=
> feedback from the earlier submission as well=0A=
> (adding an rcu_barrier() in tipc_exit()).=0A=
Eric's concern is correct but it needs to be addressed in a separate patch =
because it is a pre-existing issue. It requires another reproduction (load/=
unload TIPC kernel module) and other considerations (calling call_rcu() fro=
m timer etc.).=0A=
For now, I think you just need to address my comment.=0A=
=0A=
