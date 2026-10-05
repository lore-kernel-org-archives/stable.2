Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E2F2C11FA;
	Mon,  5 Oct 2026 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173364; cv=fail; b=DzCA/MY6/hjqeyIakoqxwyiWZ2ueWIbcUh3/Z0ObkDAOPN5NeOo1osJ+46C/3O+Oy+rpqn9ULD11I9s8fiRMjAqjUepcIxgqngySo1PdOOL9MfWiah7aWMtyQ3fwp34LolgNLX9MdEdxZDy4zkx6o4iWieSqkFLOKSJy3aJg4Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173364; c=relaxed/simple;
	bh=Du2G4D+lofaP1u3pCL5Q68zGr+4zvu3NCRNOlLTrjSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTXCLcnSTz5sfWAAlnAB9j5PZ+CCnplVZH4lXjaykaJx5IhuL7zI/vDBOuEyulqWgEwZILjIxlHC8D2S1d/1t/lpvwXboex4RnmZL+5pFTjuE9Qy2rwWuDGLFSvaV2LpiCwu7OHMQmoeMpFbux5lGHF8sxGZQlDWLjcai3CzbMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=ppqG/cMP; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="ppqG/cMP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1b6HTS8eXoC/XGyhQlm2la5yLWOTMqisRkkbbyFptXp3yMDqb6WfYeU5qtKnxV5vZRUygLmbf+oGUaD6FT+uGFerYSYUqFnE6VBNBv+t9WHuLajZ6h3h/Lq7ceY5Hp91gOl5RaGL4V0by87g3WKBvgGISN/xh4Cg85GycIWlai3RQSuIuEXX7+7vArE6Q6EENjF4VGwNY4DM2z2M0D7HmTtyVMYtvBsfThQxZbispxshGl8BoPvrbpA6jnXY3abfb9B9uUsapH3Cpi8xPgYe3WftdqpGfxLgYyXeN/sCzpTHplTTwlVJXSQoOdCeY2cy7sJGYXUxd7u3LzrWsDR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgPYIdL+c3vz6aAoQ95LrEFETOVI/pYux4LjLQV7M4s=;
 b=T0JeXtQ/4M5lvlHJDXBDNQJ2Tekd7maaaiJiMNn9Bd/cTCf5kVFHVF82+iBmRts2osMnadFS4pM54WaPBVjJeqMdkj3QHMiSO1IsyUjoeDNJMI+/BWAEk9A9dLT+TDah+92Ec32q+Tb5bdvEWrASXqS1F5vPHxpytvUgj2RQruDMPxggy5hdt0j2zFOYsBytShoKjDBiiw1RG+bttkBVYOWtjytWxWqptIKj7d0CCjN9gVe7ubFdka5+9HrrgJoEqSi4BTp0lsXqKAioP2OAMYU9YAt8j1CJviILPNBlh9ZBF7uS/hDhef3P4/AORGRU+A1ohbi5sHXX16UH1qYyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgPYIdL+c3vz6aAoQ95LrEFETOVI/pYux4LjLQV7M4s=;
 b=ppqG/cMP1O+8A4qbNvaupGZ3Kwizw2LTiFXdE4FwFscpEqwCacCJQoa289mkZNfZpIX4GzaVzWrwVJHIgOiw6Fo4+h2MM9wA6J3zwS/zBiQql7BpK9ppZ1yzc924aRnSNRKKOZ/RyCmm9rcF7Pno8zrjRVpWJ1j07faJoqlH77I8Cgx+oZ7EDqNU6DBTgoY6I+/721a26A4qEzO7SGhaEPi31YDRndsySX/nhm6TRGb6EGwgYjz+S6j1uu3lfXoGWEWBAXAVyTy5VBYu+bWQubGSR8ZVo4nXtjgQIHrXufCffbS7iM615R6zGtTEDqlCY54mA9RRUU2E3xz81b5+4w==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by PR3P189MB1147.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 04:09:20 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 04:09:20 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net v2 2/2] tipc: serialize publication purging with name
 table updates
Thread-Topic: [PATCH net v2 2/2] tipc: serialize publication purging with name
 table updates
Thread-Index: AQHdUdLYwJjQ9I7wq0GjAc4uGnSVlrbuWsYA
Date: Mon, 5 Oct 2026 04:09:20 +0000
Message-ID:
 <DU4P189MB37503788C74C8F9C5BF4DDF4C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
 <20261001182924.3928331-1-nicoyip.dev@gmail.com>
 <20261001182924.3928331-3-nicoyip.dev@gmail.com>
In-Reply-To: <20261001182924.3928331-3-nicoyip.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|PR3P189MB1147:EE_
x-ms-office365-filtering-correlation-id: 6e47f6a7-072d-4db6-da4b-08df22966e4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|38070700021|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 iVbh89t6LBSqz82OdsizEGPUwSX+g9wcRMkRcI61IhtidqSNGTO3ZzRMqJpQRR+EJKbgmsPndNpJ5/pyRsbKsBY3nzsKR9oEoaujOdz1xx+g1vuyiO0aRWGCnkNYWEzOfZBUJoWt9JE8k/rQG7Cbcm6dtcaMZMBr/u3/cqXPRXO85ZCcvi5msbgqSYmm5ckidbvQgeNBoi4oQwE/dzdMglSSPiV37KDHih8l92cRozBywn4FV6UdSbWQsXb3/2eVoyBBc4y8GjgRinRK9yDOiGT9n6Jx5TgTtElrkY/qSdAmwrN/jQtjNLN3B8u9SWPIh6iypTozNNIFAEggcg45+yZFn+fFcygZkWZkMXPDaW5gR1xnNgD7FUpUUvBTptlQLT9PSLSGxFDvdlY5vTSxjRTAMUfKvOZqrbg35eyVCk1wnQQaWo7hylVHQCSO1C62i4dFcMSOfOqUDbcUIE63RTulRyVhQrZH8o7ayJP+F4sPLlkR1RT3DCnGKY0v9JV/q3MCY2+MbwW8DcXVwjI4zZcBOzhOuA6V3kuRukLh/P5fT85i+XSVnXFkku8eBk6IHo146wpKY6NFRnv+n6H/7FuzpiNOHGxJSrsNulGfIP+lD9Evdojm1UADV+xnqOZ/GaRrA7lqOA8ihLzQLTB1sHenXDjkPhGt5MEq2XA3ITULqCIi4erIXm7x8PU3goPzJacU/G3gZjjVFIMWeMLNsJrZKoYOVMjvayzbrbTVop0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3RqAK1XD2qJ5X7aupw7hdJGjcIVauN5SO2WMiC7zM5pgnTtAjedENV8QJk6L?=
 =?us-ascii?Q?qEAW013VspP9K5Kz8duEDSvf2CbzNx1fAQNmcauYAfwqwspRSkMttz2iI0ZR?=
 =?us-ascii?Q?iQp5A+MStPKFBlu1Btwc/Dzr6f5utJQ6CUs13/b/qitaC4uWhGzmCLng1AJI?=
 =?us-ascii?Q?IZQuSnlFvIWnpuZCtC65jwbdfXTax9XqexpNiVlWFT4VbyIRcWWEBf30MqV/?=
 =?us-ascii?Q?a6chXPb77XSmMf9GA/H0784GNT1thrqQax+D7oXstC80fGF7bPD04tFN5brQ?=
 =?us-ascii?Q?Rm4wW1vd1ifdUKejpwruOSwdAacJ1+XIRHm8XXBXXWjnrEpekYXwQ6/QaxA6?=
 =?us-ascii?Q?zeltdPAUhRxkkag64pFM8YATgj2xIxpPt4fLaSkUD7vA+yxM+R1aNtMsTxb3?=
 =?us-ascii?Q?yyJqJA6RxZbLEux5I6WGOL7+QWmcCsGcKxcbl7chCR2eHuRFxIv0Y02WV+dt?=
 =?us-ascii?Q?YXWtbDIJM7u3GSmvoLVnDhdYuVFdL2bPsca6qT0nWxUObF+YiZ9szQojZ0OD?=
 =?us-ascii?Q?3XBo9nKE5acbkO8VOkHstFNL08q/LQqH6vXwUK20rfUKrViE9M+beqm8p0jE?=
 =?us-ascii?Q?YCpN/mqfVXBtn1xtrNC7Rr682M7BC4sOCNrln/DuAF3/qelYNn/KwDOUffz6?=
 =?us-ascii?Q?yvBBTqX5lKpnL0tbF7bBtW6w5zYwjfTO3yP0Np2fLSwRsno4SkCQXB3JqAqX?=
 =?us-ascii?Q?jMk6vrUeD0nZ2ry/vQIne/v4OB7ALRiR+Q0O55gDR1zlGJmQUngg7gaKEEfo?=
 =?us-ascii?Q?TKcJX2y5seH4fGNjjLAPrhzDKDPedE8HuRO1pcpfLaMJNLiTOBAak73lTvi9?=
 =?us-ascii?Q?AgvR+QsZ2S3FGK3xLtDDthT/RHVAiScAi8CfH08LxAj/ynkQKRhyftJZJyYG?=
 =?us-ascii?Q?N9Th8RrcdpuemJsAEDPbdpnCYj56+qQvaNL+OILXAynHMg6/05uJRxtyo7hK?=
 =?us-ascii?Q?1jFKpwy0hq+xMfnK/p4F609zZfeIUAAl1V9U7oGYGnTWj1WTLx8c6Vnx5Ivb?=
 =?us-ascii?Q?5jDO8cPqNhxBqFUUj4BI+T1pYwYzIXh1l008YMgfJlYpQk9LV/l0vEhJOXbf?=
 =?us-ascii?Q?GoAkgmOdh7hFtHRYrt+uzg2UUg0HTlqg1D+N2StK/CLHL8lOOe7zye6NTHDo?=
 =?us-ascii?Q?eChhP2dmdGoZh9RHNkIhxbnKcHGQt4OdsuWfdHeAWmidB59GFaJQWTAWN+xA?=
 =?us-ascii?Q?woVbr29UBRzmGEdkeaC6npF8merBjdpxr6rNrusRhOSffi+PUs/BK2gzxG3E?=
 =?us-ascii?Q?c/o4RicDtgl2lx8zg5tx6HoPX7VpcBGd9L5tikzP+2TYU95J0LrtB//TdlJG?=
 =?us-ascii?Q?1Hd690woDpXIozi4marpiV2q2uhrIjsEIzl8qQ/1nHNxpuT5LqCCLHdRLU07?=
 =?us-ascii?Q?aLe92pA0P30exH4cpJBAi+TTdMHxjiGv/RMLPi6qcSnErTu7lVauI54fw5we?=
 =?us-ascii?Q?lL/BhNVEZykd7LLekbN1LshCdrZWArGZ+yULHyKq6AXXTcoqkkibhkH8dFuE?=
 =?us-ascii?Q?8vR2ewjWc9BHcc2eh64LTPQ93J9/oZedj339rSAeSSwdcKxR1KGXLU3p55Ws?=
 =?us-ascii?Q?dYHFhuEZxRWxHGeWS9yuEK7lfWy+gnNF51DormkPLqyudOPFkSnX5vg3rBzm?=
 =?us-ascii?Q?F/eucQ5S5awvPywfZC4nogBlEJdBlwCvJXA8087uM64u7LfxmnzqvDY/MDt7?=
 =?us-ascii?Q?h/1bPOKr6bwPv3AZy2DWENqGORlFNz7yJZ7pvDe0gL8bSJNhucLfk5zjNqdL?=
 =?us-ascii?Q?i3Q5kFsgHw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e47f6a7-072d-4db6-da4b-08df22966e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 04:09:20.0635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oC+qDTz2K5enxP+WHXlAzBnuF7FGu/dDvx9qVkZGec4t18bbPFil5rbEJ3J4arxuBGkWw5oV3j0IIP3JBtnGWVhjxsGrWnhyu7WG3MmTvvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB1147

>Subject: [PATCH net v2 2/2] tipc: serialize publication purging with name =
table
>updates
>
>tipc_publ_notify() walks a failed node publication list after the node loc=
k has
>been released. Its safe iterator is not protected by nametbl_lock, which i=
s
>acquired only inside tipc_publ_purge().
>
>A concurrent withdrawal can unlink and schedule the saved next publication
>for freeing. The purge iterator then advances to that removed publication.
>It may access freed memory after the RCU grace period, or repeatedly follo=
w
>the self-linked binding_node before then.
>
>The decoded causal stack is:
>
>  tipc_nametbl_remove_publ net/tipc/name_table.c:543
>  tipc_publ_purge          net/tipc/name_distr.c:244
>  tipc_publ_notify         net/tipc/name_distr.c:261
>  tipc_node_write_unlock   net/tipc/node.c:425
>  tipc_node_link_down      net/tipc/node.c:1094
>  tipc_node_delete_links   net/tipc/node.c:1325
>  bearer_disable           net/tipc/bearer.c:414
>  __tipc_nl_bearer_disable net/tipc/bearer.c:992
>  tipc_nl_bearer_disable   net/tipc/bearer.c:1002
>
>Move the failed node publications to a private list under nametbl_lock.
>Select, unlink and purge one publication during each lock acquisition, so =
no
>publication pointer is retained across an unlocked interval. Concurrent
>withdrawals can remove entries from the private list under the same lock.
>
>Holding the lock for the whole purge would keep bottom halves disabled whi=
le
>removing every publication. Releasing it after each entry avoids an excess=
ive
>lock hold for nodes with many publications.
>
>node_lost_contact() purges queued name-table updates before scheduling the
>node-down notification. An update already dequeued by tipc_named_rcv()
>holds nametbl_lock until it updates the publication list, so it completes =
before
>the snapshot and is included. A publication accepted after the snapshot
>remains on the live node list for a later contact.
>

This does not fix the root cause of this issue: Not holding proper lock in =
tipc_node_write_unlock().
I will post fix for this issue. Thanks for your report.
