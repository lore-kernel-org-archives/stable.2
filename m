Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178D3E7BCA;
	Tue, 25 Aug 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656134; cv=fail; b=RSkldn8peuPBFgqOrX+p14CXk1t4xXkw1qUN5ebZBWdd/5J/2a4yk1MCxjB/My4Q6sLx8RaPRmyroVkFZUgL8ZuBdjTSp6uOMlpt9lqBopVmt0Ll81CmJwVASsXqr9bz0z03Rc/6Gxdodvo51hiLg1CcvUdL6eLRktRjAA+tlZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656134; c=relaxed/simple;
	bh=FRL5vDqDapobtJhP9xmMtwV8bZaRhy+Su0ZWtNZEBhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AAnd4fno8/D0vCmy9vsiNuCJqMlC8/slTYFndaQNG00YPHI3qCJdVCkb0NjWblIf7ejoii/Iw8/sjkVulE9QNZ8smSK47mlE1I32keMov8UPQhyFMuVdkp4fYccLg76rPlkJ2V92qx2DXMkRjM72elNnX2bxiUMLVLI3/PRIiA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=BBvnzUbn; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="BBvnzUbn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6O/+PUCY358Fwn6P3eu14cQIDoelow5RrWUIvxHGVu5VZ2T4JDexJcirOYmGWV9Ar3mKMxEYLmBITUgnYS9ACSRztJpyfIF4Eppo8HKDnalkfnHNTjdkIawfj+1YwTAjr5UnsIAt5MyCaiouAO1E1zNq5fo6XkExe4x4v6h6SXfllr+wkiVxlVhmA8PQfbdbD383NjoilNH26njAWD0+qQXlhzzgaD5BlrstOs8C/tVYS44ei0zwhFfaR7A0jGQRYQoiCCfd4LVGO9RDGav1Kq1qs5a0AC6Dm1gyHphhYkQgSU3ts/8J7WqPjl636Z1WDciVV+J3fjsnFBLE7sCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7zHLe6t2Zvg4XvJtVNCi3qGeF7x0ElGBPO9T30vhcw=;
 b=E9bPdpd8lDLmjoEpQDm2EgHBeHJBf8HMEnz+K2muvPz6Rb4b01OONFwgjVkEztCQh1E/zwtgyYUPxbRb2VDSoVaa7m2pr/RVIkOoo2TeqRJE5sfg2Hq1cNCh1ORG/KAXa3isVaudaW367MLZs5tX9Wyg/0SPV9OJfHHGtY8bAXTVbFks7MYSEpn/zzsowpnu+zJqUQGllM2w5eSsWXh2S+aOH6vzxADXgrYXD7eUT9SAaX2gqgblJkuTdac+r1lqxMY2LJOd3xgbEqU51o2d83jCuEMutzs068aQv8N3GYXxLyTbKyJg8XuLf0Sr+Dsso326vys2PaHH8nLM+9j61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7zHLe6t2Zvg4XvJtVNCi3qGeF7x0ElGBPO9T30vhcw=;
 b=BBvnzUbnmNyTJquDhftdl/+TueS3yCcEJ6p1LJnDrr4f2FJzan8XTSkoRuRCjt4ErAvOGcLgLxP5aQY+SUpKVKm8ES4bWQPo5GKhGvy2iUBdCXh7ShxJAjQKnH/0d4pwU5lPK2cOEiBRoL+ceoUD7UYGeR5hvg8jjqDkuay/19hUHkS0pJQA7cfImGTI6VtA6L5oKXBgZmp9lSRWa4VlOHk5JOVl+EVjbbO5SPIFtQek+WXfiZKJ61i/tB7hxYZzxcYkLL6E0Y1pNCY/BOiYRpNG/NesjddEbFHnzGP6J7iCfomFGFFttesc0qrjFSscPr2dZ83zuo3JLt7+MPdXTg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS4P189MB1965.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4bf::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.6; Tue, 25 Aug 2026 11:08:48 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 11:08:47 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jon Maloy <jmaloy@redhat.com>
Subject: Re: [PATCH net v2] tipc: protect node reset trace dump with node lock
Thread-Topic: [PATCH net v2] tipc: protect node reset trace dump with node
 lock
Thread-Index: AQHdM8Uz48K7/iomlEK6EkWWu/znq7aum2H6
Date: Tue, 25 Aug 2026 11:08:47 +0000
Message-ID:
 <GV1P189MB198892ACCF53DC750EBBE0BAC6AF2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260824122929.210431-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260824122929.210431-1-nicoyip.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS4P189MB1965:EE_
x-ms-office365-filtering-correlation-id: aa849dca-4336-42f1-5df4-08df02993c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|10067099003|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 p8W5YKNKWDshfb+jjkWBOYT58Ec3y7h1lAzMVKjQEQZGcJIJOfybchWY65zbHvVmzL3Y8DXBCxzSYrbI5vi7L6Sk0H2JIyX2b99AegPFqzxkvrPmoG5/cbORsaIq6v6MuP/UyuNvqjiPIoQXkJYulqXB/dRARJ9d8qE/c4IiyJX4muMu5hncIgKGpBrjwzxwQAgE5lSHCh6c+D2f1HyucE11+uS5sO8VR8tUVkYssDRteudhi9vampAPXDRJ3pUTcDmdWfBpP99+GmMPFQyVdy39tXcD7Je3IncVhoAoop0IfgyJoZShPHbUcRpj2D6Xxi48wo/xUSVrbvO4h+3+Ws5z0WqSQvoSYWhy2wpwcLlVowcG5GhuAyrypUvi5LUP+tsYWV7JCD46LGqEdLjnWxVRjy2Xc/Zgojo+nCnNZWf/p24t33TMQNPiNQDPqeTNYRvtybURqi7Xd3E/rVlvrRVSoBnus/4l/YMIXc7UphaxXho3jYyhBn7MbHQZP2gP/kk5VIunzP7K1BKY7dw5NxMhg6mRosCi+QrPXNQZ0lPRmHfLXFWoCrDAz0H3BVS73fqKDoO5bDtWcgTcMLCh90pBLJ9HtHCwJoNkXh8IycrCHjcAWQjL8d3Du3ksKDhfSk87RX3gAU+2Yz6GnFTi7Co66/1T1omMcUegOYI0eubWgweoeQgrBiOgP/lOKpOwsVEY6HSBd2B/urwIA5N7BA7Nq4KI3jCJWgOjOFK/6bo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Qgru8x5BXTDSd7JtNihvdCQGDW/nvpXUmciaWLMlkJXGf7CyXF6nyr6evE?=
 =?iso-8859-1?Q?7BqKs9iiDf6FThdMpqJ+bbRyh5NiGyWnV2nKW2FTTV8I2AGwYxBICQDkHZ?=
 =?iso-8859-1?Q?0Bpf1U9iRq0sTOwZrxhfDeIP/3oAEPDq+tWu0l0RijBwhTcVUHMHxxZ4vA?=
 =?iso-8859-1?Q?2SjrFVv8Q6yHqzg4XUq4AqT1NLY7IP/adEk/SBpt8S0oBMJbLlpPQYrVXv?=
 =?iso-8859-1?Q?RuvePQ2e8MZ151dptOYmy+eBvBUXY0qinym3zLeFD9Fm/dAvCV3QXng+fD?=
 =?iso-8859-1?Q?D0HGYz7derQxZVBVwrwupEyve2uA5BcPRoeyc2sdTRGa4UDyVcdLW7kP7V?=
 =?iso-8859-1?Q?sziP9WPa1Ook8Sz/DTLarkAL3tbd4ORWRDVEAak2avD5+p82GhXMM25sfn?=
 =?iso-8859-1?Q?B1RjYjhGUYM9njoSchCDQZiDPLK+fOKAVFJa3Ddp2Hc0/9Qo943WyidmH/?=
 =?iso-8859-1?Q?Ib0pU8J/mawb4taRPJWoVuhncTNkXj9+eHtMHEkN2I/l4NW3rTg7jqZtCX?=
 =?iso-8859-1?Q?cLXzm6c6kOO8Iotc/MlaOUYsAwpLEtrrCT5UlGgMvM1fj2KDY1GNQPS4wz?=
 =?iso-8859-1?Q?d5sPdeC6pz8Un55WjyDgrYWYZDXBT8Nfvv0uH9ovYFuj8XWc4a9KwRCB4P?=
 =?iso-8859-1?Q?u0o/fY5j81uRUNQvzzpT2OMsPNgk09OD7EeeJibFkihLrrUahQATbLsTtm?=
 =?iso-8859-1?Q?nZQCJMt0zp5tXknMHvImeEmlxmrrBuNIesJ2Rm0/c0g4Op4GgrogIvcODN?=
 =?iso-8859-1?Q?vsKirjQb0UIgp54aHF8wFqlDkLM4XRW+apetNbSbQ85nq1g8qTdAFy5ri0?=
 =?iso-8859-1?Q?6WraHUz5SggfUrdjBTCo6d+6hAe1F7IIKBXjVys07BnKmPqrUx9130gXfb?=
 =?iso-8859-1?Q?SpPF1oXHeFv648PGRiL+yBCOivJsyC8empgGgwLHySuAAITSjGRu93qGxX?=
 =?iso-8859-1?Q?/FyEQirTlYVLFiPOfJPM0wVbRmCNS3/1lHU9ImthhbWZ/Mkl3U45q9yvzy?=
 =?iso-8859-1?Q?SS/dZOTAtY0E4O6cwqy7vu9zdtW8uxRHbXcQQzBo0Zj8RixEYMbXlMzuag?=
 =?iso-8859-1?Q?+13wCy982u72b7y5LVjlGoMN++rdLmPuQ/PzvC+VBmV6YBuoNcq5WRBtDn?=
 =?iso-8859-1?Q?L6xpcVVUOZWT2AxfBomsiDss9B8u6WuBUdn3SmKF/xj7QlMbGsbBaT2mKC?=
 =?iso-8859-1?Q?YVoTUP09YOrebc27U8b1sgtCrEkKWuIrybdFpyNHl+NBfYoJbd2xTAiMri?=
 =?iso-8859-1?Q?N2gFrxnnEpM7BouWgO6AZoJk9KKUD4Sh3Z0rgyg1ayZt+AqngEmQRiCP/5?=
 =?iso-8859-1?Q?ru1UXKKeJttmIh9a8mNxnsCVUVLDqBI3N4Dp5coykn7gwK/VZbFLYkaUm/?=
 =?iso-8859-1?Q?cg/aT8gMxyPJBybAqq2NrYGgoQr5QVnXYznSWzSf8JdwTptR/kYdLH2DW6?=
 =?iso-8859-1?Q?NN3DALnbsBKvP/kVFBAwBP94pL2ljNtsWSFlrPI07ittEcwAWGDuKl7laa?=
 =?iso-8859-1?Q?tovVUkiA6sSIRDLHBC5fP2vJbM/nEg7ITAPvuHgMwM4VLMfKEd+4GqWwNO?=
 =?iso-8859-1?Q?2WTyZe83a3xatln5OYuoDkxUogxt5/6Ff8wtmg6l1YZwByOMZkttl7kCz8?=
 =?iso-8859-1?Q?pIY7bGP7BqPV2Z7zDG52aHZr0R6kbyGAIVe7o72nCMmuqdttyKH6T/HDXx?=
 =?iso-8859-1?Q?GS5PYMyoJ1SU/q/ngR2Ptq2i+7INsX7zD2v+QuPAboJCnEt6oUvGAf8v+7?=
 =?iso-8859-1?Q?ZtBv2U8BOggGOZLIEGsYuqnxoFne5MBw0l+l7UUm5yFy+vkMvIs9jR64mA?=
 =?iso-8859-1?Q?h8z4GmzZTg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa849dca-4336-42f1-5df4-08df02993c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 11:08:47.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3cMGNx36hYmMu//AsHZjf4xlbynW4BJFkdozW6akT3yDJI/aA8dCYaKlIbNv5y4Zenz/WzjejSoTEmfxchcwEXaAMLJFsKbqP3zG6bUQng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1965

> +       tipc_node_write_lock(n);=0A=
>        trace_tipc_node_reset_links(n, true, " ");=0A=
> +       tipc_node_write_unlock(n);=0A=
Please use tipc_node_write_unlock_fast(n) as I mentioned before.=0A=
=0A=
