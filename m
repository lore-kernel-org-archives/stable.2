Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B93290A6;
	Tue,  8 Sep 2026 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788833149; cv=fail; b=m/wSwokQfMP9xqyxxIbR5GBt07JrdNUG3nOMyqok2gpMLolUWxieMzYif+8Sy3JQCFbLWLPHDIn8JjZKBLObz2FNE/J0QTETmBWqYrUyb2pzrygeGPBg8OemJTb7oHqREgtHEd0ZJyFCrQ8JXGJ6KF2q0bgs//MSSQ/f9uHp+Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788833149; c=relaxed/simple;
	bh=iwMbxAA1/XFmehbywE8MoGrFam5ALPD5HlM4BU7hheY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JmdcCpW45JFqVxw2ndGL5SzOzAIeAyl9bcznf1j+MWjw/M5bNHMRfj9egbljLKw22DnuJcAUko4MjRn9tQrDdE7AeorxYl5frhEBXNSVi8VZR5/1msQTm4VhLdmQEw5xJ9vosj1sOa2OrY0ptTvFfRx1jxvwOWhortdj9iiO+Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=lMfR9WkX; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="lMfR9WkX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQt+M0yv9obZBKsZP2Y9hDtPkfk2Vrf27MzBp3EIpmHHvapl6BiRHAW6qliv5jhqk8AEo+r8MYfu/0ZYuZMByLD72t4o1Q7sHrLSJKadQB1xtfftUN1AB2MEEClN6gC1kL1nKgMJWHsa/DozQ7YmjKfn1LskI+vAfmAdfBFR5JT0T1iYIphUW0EVl/dxLNNAXLfKP2oHVygZmjNRLzX0F0ODtnBOP3neVlf9ihmB45FUwvH8g9/rTty0WXxWwddYYWETVINprjUNPp/LYUv5dDU41RmjNbGH6wupbrT7FdoFR/zIOgNyaicPFvP1XiPKrMh2+7UP52vW6emfiyjLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aawg6PEGWH9jO4wUcdjYjJk8n4YD1vBxEjdCXLofml0=;
 b=MaOYNMndY9NwNwJP06qtcEaI5FyUkxCl9g+QOulEg7ihfImFka+5ZsaZNufXBq5ii5CZkFy9PPTNiBHbLiJ8aozfo04+7qakAnrP2TBytSh/lVDENeTtL/jCTaxnLQHuIbDpmqm7MhJCmWzUz16pPMkaaqrNKXQgjC+ohMwzj9Rl2jgFGKy8JjCWgp3+/7hcgcUfO3FO/kJlLCxZvoMFxJCfq2bEKxkIpHZpT/Oc3uwcw3/vIBJQB6uZeafiAJnr30xr87Q8o5F4y9BlMGCSu/QScorHRU2gp2rGWHiWQHUhy6oup7RegPTeqDDcheDKl0c1hKjve74vDe2f743LBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aawg6PEGWH9jO4wUcdjYjJk8n4YD1vBxEjdCXLofml0=;
 b=lMfR9WkXFT6VsdymAXtI5ItW4PRQnSISwEv0Q7j7ihm/swNjnn6x2Vdk0hmoH+l9ePr2A4wSToytRnPq0kGHxo5BooVeexPMVm3WaS9Q2DqLQualSdDDbzNw+SV58GMp7B7++MRZI1GC10AeLhPXLRjCuVcZ3eZ4cPTxeORM8+1t46Jm2EXCjp3KHrtMb1Dsvm5uGnkRWC8Idoxn29YvYQvIy9rBqtNPen5k7/k3pzzhncHSgpYPtfWJVWZglRQmEsZ5tDDBsgp0e8COVAazPlqoWaFGNrn9cmlVUtndwFlwJIf8H5ydqUyvIu/Q0SOYemZXr48IWNow/wVFE7IwgQ==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by GV2P189MB2862.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:26e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 02:05:42 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 02:05:42 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
CC: "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH] tipc: validate data size before reading Gap ACK block
 header
Thread-Topic: [PATCH] tipc: validate data size before reading Gap ACK block
 header
Thread-Index: AQHdPljRGxR1ivZKNkyxmJwxSMDyXLbD7h4g
Date: Tue, 8 Sep 2026 02:05:42 +0000
Message-ID:
 <DU4P189MB3750CBD6A79FFD1255DFF593C6B12@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References:
 <AS8P251MB000136A75E6C720544CAC017C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To:
 <AS8P251MB000136A75E6C720544CAC017C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|GV2P189MB2862:EE_
x-ms-office365-filtering-correlation-id: 1c248b71-2864-48fb-21ab-08df0d4dafd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|3023799007|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 dCBbcp8OV2QUNVxztXeC6iUaCD38WxRXymJpZ4BwraA7a5RxizIFu722WfOxzq66MuZNXraqfECQgdjvXcVutElrGjYDrIlU7m+Rhopm0ONy835QF6p0qDRPWZN9gofSjAA3VGgzRNcUm49ZEFBZXMGTxzpAivH6+2uDzExUjzDBMePloxdX4LH6utEVbqCbTk9MTlVP+jHIpdbHqL9b3R8UwV0BdX+QS6kQZOXP6O4CKwA7H1JH76XtG+z7rNJcqChlZVywPfAPe7qtLoZKwPU9/VzmJCMV8EgXXd0xr/p9sSgdjOtWiGIGYSeEO+pw/vCJqR7U//sR/Ue//6EbY4NaGKYFv7TJhXDLeh8tS7o3JktrnzUMbZwKM9SyyCJAC+x0E8CjZ5AiiOU+7bM5iuNBNk5X7CZJEre939hsoEOd0zLDEQkLtO0JVVvZETfaogscu71J9OGGS9nT3Kr2SkZbi+4xNTYxk5OankWG63+C+iGYcruhga7GBUMwk9SrDyOmu/1fodLfHAaH9Cencw+WT8A59yEoMRb+T+Ud1PcL85O9OiZBVW9A3nvKaQcMqxMrKe11kRbO5jHNfOK3OBac3Zz134/UDJZZ+UX6miH1LFAb+0AlwVeSTTJgGtFQdFOtoHEUbB8vBrxqrj/FNDYTiKz6B1DfT7nQNT2rSZROP68IGTJeCtEi4axC//V7x5R57WNocQEOC67XcGliCaPuE4c6QLyY3GCrvnaqQ18=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F2O8HhIDHVOUAC3VNOPLVqh5GZNosTtyTNw2Cy5IJjfphTxj/jE/+qkUDvS9?=
 =?us-ascii?Q?/dDGkK2IvsRDEmFitkNql5bXBI9vsUyhti+gb00wEWzMcp4Xq73ooOli97wd?=
 =?us-ascii?Q?cbUet1lzFX+xSvJeZUQ5y0SJPU1BzHYxb3tiAZ8dovUNR0HUN5p9EuM+BU5s?=
 =?us-ascii?Q?k7f4q2M6WU7AkU5y9a10uFvCHqRsU09bR20FAtq8GslENUSxHnDvEArMyJAV?=
 =?us-ascii?Q?vQbC4EHIjHd2MPkzC9ZEJFwJ2ZgM6+IQyraCl44xHGzqDodx/8LGjpfRI3P6?=
 =?us-ascii?Q?uOCGVjVPDYIPlAMbGmMBBfC7qG1TxtFpYcfGaLsw2ekfQI6ncYp2kzGN7xLV?=
 =?us-ascii?Q?O4cQhM6rZkn/RIMizy3gDaNNZOnFIfI+saeMTvF35pHxBcq9xGfzMTHxqiWz?=
 =?us-ascii?Q?Xh+83HtGr2oDcraDrYpGlsw2mrIO5E3AJS8YVtwjwEXI1G4Wjv2EJoperj+0?=
 =?us-ascii?Q?ipOAQhHRcAQ/zPVnbuasSrYhcpc9wspHAoD+tDNec5gnIZj88a0kZ8nl6Kxy?=
 =?us-ascii?Q?mj8WT3mtCceKTp6fV2HgNJAXxX0V2FHpolMNoyNhprzmnqt2TJdAaVX9znZa?=
 =?us-ascii?Q?OjYszvAs70n9C2+ZNSZb3ucVXZyXTbGCQRDbHWfdJPZb1/r4V8y1LOmMBAjv?=
 =?us-ascii?Q?L4E4830KH/4lY32fKjVrJjYaCu1zL4dAdJu5v5PVt91LrQ42aLtjP+JQEzZK?=
 =?us-ascii?Q?pyl5JZ5uu35JB5jy9n8/Cc3W/j/EQbjbv9rFKgzjVN/4vVTD5zXOLgsiiEyj?=
 =?us-ascii?Q?ylSl4SJmnsJOO7+18d1hYLLHk8JbadSGXKPxgXZTTR3K6FGRbCoI3Brh6Oqb?=
 =?us-ascii?Q?tZaWWVQQNqvHgb2AHH1vBeVa0CPkeWQk7T/7z1qS58E2EauU5ElyvCowbgw4?=
 =?us-ascii?Q?4v19Gr0Ulo4BFT4088YGFVeY8B2D1TgCYxp7Ytj2GsoeGeJqbLPs2gg42qBX?=
 =?us-ascii?Q?IHngKmPB4i/K19X32h0OcbxUbLb+30+DZyt3NpkrOlE0nZHvxEZQj27TPAq1?=
 =?us-ascii?Q?jYDFXmRC07nEfJoNE4L2rZSVSOrLIowrM9uqCAhFIOjzliFNfahjyx4V+dll?=
 =?us-ascii?Q?3rE0Wbms1lUWNpCslITfFu5Q7yiwkFM3099+gkZszQRrNAxALfrPLpCoYgdE?=
 =?us-ascii?Q?oMFhK8SIVmVVZE5nvlXSUv7VxLPGaJicEY/TMe1UhHcsLgejiQUzP/QfASiz?=
 =?us-ascii?Q?4qlLseDbNzX7XSvR8TEGCBjsjeqHqlmcfm/vi5y+SaasD1ZgAOgIwzbPN50R?=
 =?us-ascii?Q?w1UrFBqcNLcHvKYbbcpAMqLUD+RZcdg35ICmHByOJ+7XsPwxLQV0BpUqcJ3S?=
 =?us-ascii?Q?nD6ff2R4aeQXAytT8D7oIg+paHfrwzzZuV6SuEQN9axjUJ9PzjaEKJ3AQ6Z7?=
 =?us-ascii?Q?Swviur9rdtIOw5Bxn6FUTpwnCEo/eYU+vQkD0ILye55j/0LS6vQoBEXhxsKw?=
 =?us-ascii?Q?e+w71f9PcXrxlpKQYiOwB19Lo3YoEe6T4AOy4nSq6jd2hh4IyBwsvoFzSlPF?=
 =?us-ascii?Q?Si9NhZrAp86y9kdu4FaXS++MNseVGcBB8psCe1Md1dNtSVBDShw7KlOAt3gF?=
 =?us-ascii?Q?4wADqMu66h969SOhrYiuq8f5UuQ4hEC3gwRWkzIAK16QqnxocemG3TC2ntJ9?=
 =?us-ascii?Q?IYeBNmq0QqWjJzDHm30Uv4Vg0RdqEstgI1dUm13TPWgTKrL0gokoE5hgTfCU?=
 =?us-ascii?Q?+uXvSN3QLqtiN3hVoo7ySxzz0UIjPuCMaT8vW2ELp9RuiObmbGVuRAMGUcgk?=
 =?us-ascii?Q?9YbP/woyXA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c248b71-2864-48fb-21ab-08df0d4dafd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 02:05:42.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRBMk0i8QCwGOBXqYeyorYFCW98bWEI6Q/C/k1wbI1n9nRX6iEAu0tBmwWiaM4WbxTx9Djdoqe3Bh8U1PeYzblfFopFY0k1/ArNHUZoN1+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2862

>Subject: [PATCH] tipc: validate data size before reading Gap ACK block hea=
der
>
>tipc_get_gap_ack_blks() reads the Gap ACK block header fields (len, ugack_=
cnt,
>bgack_cnt) from msg_data(hdr) without first checking that the message data
>area is large enough to hold the header struct.  A peer that has negotiate=
d
>TIPC_GAP_ACK_BLOCK capability can send a STATE_MSG or broadcast
>PROTOCOL message with a data area shorter than sizeof(struct
>tipc_gap_ack_blks), causing an out-of-bounds read of up to 4 bytes past th=
e
>valid skb data.
This cannot happen. Please send me your reproducer.
Note that it is not recommended  to create fake TIPC protocol messages via =
UDP bearer in insecure environment.
In such insecure environment, IPSec must be used: https://datatracker.ietf.=
org/doc/html/draft-maloy-tipc-01.txt#section-6



