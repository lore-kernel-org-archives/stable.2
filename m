Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852771;
	b=w9GOV7lvQ4yZZdiX+i64F/VKRtK0bIba4LOnCJxwiTtnqKeQsoX5NjJFO5ORKizKNGI6
	 jzqVwD26uzXyQYRradS6j1O1zhnsMFRY22C7LAGhfAfG95vjwuGr0+CCiNpeOwgROk0Te
	 WndRZ4CzBBBke63bAi5mSyEdxfl2KpD/NA7nTI3tBfe/SWy8l89cWduEmVhm+MDyrHJOh
	 PzfHq0MD0Zsw7CVMb+HqVdE51/G8xcqwUHtdlpB414pees5VF/mbFRyMunW6TRMELYkPw
	 ygwVCkLASAI5Ln+n9FzKud1aXRXHc7nJpKqYuSOzaqVnYGfwnN+cScVJScPnl3R7Oog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852771;
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
	bh=ECbdxdZQgqVJlpbvzkg5t0NdlHFMKvT4Z7tso4O3nkc=;
	b=KH+cNivPg6biD5DGMpjyiVuCoy8EjTE+Sn3sfTBmzXac/vc1PIubuAz5yo2udqjXK72v
	 +QOlT2cDLSFDgkaFy+ZBHHabnRa/9YpQfdVk21ysUcdPeTOrONqAH2oKocsOBiq1ghk87
	 dA6wyJAg9KAGhv/yf3JVN7e+JzXHMaCsNjFoLXrqkJWpkbuEDdw/Y16gu57cwUp8OrYyg
	 XYIBmcYY91TpDHcBNFxwrqSx5RMKijySldp/TV1TKplm7Tuk25wEKK3cMOR89tuiIvGs2
	 MsUZ9LHPzRWPxnzRvApETTx5V0LKEluNtaFxggQxstNHxrDYKzVkTrGB4tMRm8J60pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=aI4zJ5k2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.83
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021083.outbound.protection.outlook.com [52.101.70.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB8606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AFB8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=aI4zJ5k2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djaimRE/29mGEJFOYtvzftxXFtmzAKw2l3bkd88luN7DGZRxzStJFR1gev8lBAL3ZVXi99EZ6FAFFkh/5n1RCDmh5bvMO4/WlMjCu/ANqMKASvAP/LO2NirrilcVPHvH8yFClTaB98kqHT7cNDhwaWkVJcm2z0hRmqf9ZzptBR8UNSCQ+i5BrwX2pi3Vr2VXFigEsR7TmupRkxJQttpVntcTVh5cYNxGRtDzU9GHjEhgnNbMphBHh1gdSNQT9zt4T4x9SJ7asaSI9IsqOBIrUXkUQ5rvUFLRMwHDVJi5pMwR/h9NKBOPYUqItM7fnLOBQ2aQ0vV31vPxzKWWio0BAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECbdxdZQgqVJlpbvzkg5t0NdlHFMKvT4Z7tso4O3nkc=;
 b=Cv8685bAFGnL2m8Cwcs4SkMunFAq1GLm5bjr7+f3UrpyRVq/5v4HQtJ6v2DFhplCokU7RMSQBzU8v6l6Iu3uU7tHOFBJvEAOxOGixrcETuRQH4NDHk7yJz2VyQQP6QyhZ41mN/zuWJcRsq1VMAcarsdG073It+IJsrr2SttpVdbBUbpyh1pypldf79OMmS0XZCgbVDJXj95NiB+YqgZhBdDxkPCHtLuagKGQAGRz6kOQhsq8gIlpTCnQE/7fjtZdraBW36W6+JPJRB5xN1DsZHfTUKtVN3sC37l7W/tpU4HH1DlL9z5SL9g5j3ZtCt3RR4yA8CnwiusdQMriOruiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECbdxdZQgqVJlpbvzkg5t0NdlHFMKvT4Z7tso4O3nkc=;
 b=aI4zJ5k2BlVJa0YuOvMZs9jIB6ZojxJfnqq0DXRrQGB4Obd3l0kZSrtIq8O7uoo5SqWEzksNdxxHO7EyBGWmGrSBTOVPd6bWZrBHqTTmt2FaeyFUXFFuuxCCUvB918WncDIqfsFgbEizb9wpXpQGQ25H2h5ZTUI+V4CQEcACQZU=
Received: from DB5PR08MB10062.eurprd08.prod.outlook.com (2603:10a6:10:48f::10)
 by AS1PR08MB7610.eurprd08.prod.outlook.com (2603:10a6:20b:475::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 04:26:05 +0000
Received: from DB5PR08MB10062.eurprd08.prod.outlook.com
 ([fe80::cd17:89dc:ddbb:2f38]) by DB5PR08MB10062.eurprd08.prod.outlook.com
 ([fe80::cd17:89dc:ddbb:2f38%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 04:26:05 +0000
From: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
To: Sasha Levin <sashal@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 6.1.y] Fixed ksmbd: validate security descriptor offsets
 before pointer arithmetic
Thread-Topic: [PATCH 6.1.y] Fixed ksmbd: validate security descriptor offsets
 before pointer arithmetic
Thread-Index: AQHdbN3Fv4YBMuGDkUmIUZ409a9jpA==
Date: Thu, 5 Nov 2026 04:26:04 +0000
Message-ID:
 <DB5PR08MB10062B7BF093BA770036A83AFFD772@DB5PR08MB10062.eurprd08.prod.outlook.com>
References:
 <DB5PR08MB100620A5BE5A4EE2F978D001AFD682@DB5PR08MB10062.eurprd08.prod.outlook.com>
 <2026-11-04-1-daily-reply-0002-re-ksmbd-sd-offsets@kernel.org>
 <DB5PR08MB100627622C33C426D3138E1FAFD682@DB5PR08MB10062.eurprd08.prod.outlook.com>
In-Reply-To:
 <DB5PR08MB100627622C33C426D3138E1FAFD682@DB5PR08MB10062.eurprd08.prod.outlook.com>
Accept-Language: en-BE, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR08MB10062:EE_|AS1PR08MB7610:EE_
x-ms-office365-filtering-correlation-id: 4fecb941-d504-4e74-acf4-08df3af4e7fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|23010399003|786006|366016|1800799024|10067099003|18002099003|22082099003|38070700021|11063799006|56012099006|4143699003|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003;
x-microsoft-antispam-message-info:
 oYe0BWhon7UhjqYy4/puj4Db2SNY1PuPL1o/PO2MUrhp0mHLAuwpJdfg+/qX9vQVwW3YZUADrLcePMSoYMnkfoubGnCDLtmwlqJ1S0lhGIWfYLbfazkIEbdKlOZYd1IUnwFzc6+26i8pm016PuMpQRP1rFRnBTJLdOJe55tPHu/K/DN446zO/y2x4iV5WTbKK82rqS9KYjKYUDR/rBveBxY7ervrJppdxTJRABu45I5RzgIkTTXHRfPjdNbsKGvh3UbxMQSM0jo7cu9BWlPHBCTfFx6Kzsg1b3lrrTaDA++FKbhvLxrgg/UFp2klgwV0rBhOxfFpSKy2zn5vzGtxvXaBKHm/U8pg0Fweal8jjsJo2beCo/vEj22zHhbgvJhyYhEbCTmnDK6ihMnUw9Xiu0ENqITKXhC5G5dQTM2DIfx3IzT7Wd4t65NJm8QLtdtKVXw4cewKvXsc9MMOL6IRKTlgpmwqSEB+fDdu4c4kKo5yhK1cS+SJN98yKWyVFAOrVzn2ea3pMo5KBd2Nkt4NTi0UyaMudvqKYtQ9d+Vzs/WIWu1DJcXI8y1d2mh3n/MrqkNfb+X/U9/RolMHz9/NjeT8g5vfw0DMfrUlZ5cOYSBttc3C4Rs5Agy/9OuIUBinRpFWgSLULkwNraizv7TLJdNuV94O81mRN7xTosnACjQlPOMyA3bl1L/J1Mg/DfCRHGLmUInDcvUdF2QlTwP14P+U0Xjlw6ijdGDhLTmcQNk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR08MB10062.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(23010399003)(786006)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(4143699003)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0oGRDS3g0JTgUQWrQkqi67OSHMt/FQ9avFvD4Yg2/6cvVUGlPIReQosysK43?=
 =?us-ascii?Q?YVz5bRuxcFn8HAe9j96tTOWmv/xb0h7cf4iik3nvyDgNkXU/Z+CK8nSnym2e?=
 =?us-ascii?Q?gn3iNWrTcJMimNuvF0u6QNtJHka8k4Uvi01sYB2dIGkdtNOLhwHZVRZW0FsD?=
 =?us-ascii?Q?4aNwlfZdQIJ7UEIEUmDFsDi/cRdnw+rUVALG9MR8PIqP0IhvvgTq+OVJK84p?=
 =?us-ascii?Q?CgYZawL2No9TQYUxEcbuleh0cndj4wB4ZWvvy98VFYubuykIAjdfeWd8LJ1V?=
 =?us-ascii?Q?hEcX2ftuJYKIY3qZV9SjP0jATMbeOFv9/XI54+COej1Wryce8Rpb7tcN69Re?=
 =?us-ascii?Q?AHXhC1zVVKzYRlPZpDU3wuUyFcYqGL8pYL7mdv+C5DWeElPc97pYpW+IuhYm?=
 =?us-ascii?Q?CFmIwFtSvrgMNToRQTMC1340ZLxImyKJhyxjpc09SQb03z3FRzFFAs+YcLl2?=
 =?us-ascii?Q?YwOpv7NmHWHIvaQgmM4f/GXBsADiEMbXuf5N05z1CFvBNw23LKUWaE2I67AE?=
 =?us-ascii?Q?Q+/+viby/KEqJLGRxUewklzVfxnB0b4iqV+d3oB+lLxVX/lRODJCLyBajhy5?=
 =?us-ascii?Q?rgPq8uEfs44WXmTFzBPJIQE/QUq60/OEQKp+O4kvRJLM0KobVot5WYB3HXma?=
 =?us-ascii?Q?afwlC+WmtntUmO7y2fGq5C+Aib6/eWqNo++r7F43CF3Z9K6kLhD+WtQetGgv?=
 =?us-ascii?Q?TQxAW8p7cdnTO3XHvWjRfwGwMI9LrH+X45xSBbzmysTlOEe042wcnvbwm/JT?=
 =?us-ascii?Q?M/WOgPd9qEeBZO9LOKy8ZPbzQv1NrYpLXRo2MWLWsB2UiwJPwjJf/epM5a7U?=
 =?us-ascii?Q?F6s/666w9Ln/UigA6AVc1nvFqYpuY6509faQSxAO4TNnPFnIrhOHzm7KuSjq?=
 =?us-ascii?Q?EvVBd03wkJYngsdGhzWYADGkE7rM4NkZYyNIft5ZlDXcXTajYBtIJgW1OV9p?=
 =?us-ascii?Q?QxVAxlDGW8as4PAy0sn+q31V11oALbkxxkfxBGqSPvM1tMVT+5jVy5kv/Kch?=
 =?us-ascii?Q?z5IHmoRdKlqlv7WDcwz7ErDmPiqn2lEEqVenFR6zLItnW5sY5F4w3/JQU9++?=
 =?us-ascii?Q?i+xfI5ZcoG7C2A9pd+WofA+uRoRZa9m0hSuSO4f/X7iiRQJxCAxs4nO8bo6d?=
 =?us-ascii?Q?C+BmGbMfscumZDJzB8757cPI+1qJzI74GYvh9S1yPJr3ZsaFpShSaQ1/oqtj?=
 =?us-ascii?Q?CGC5nb9S0wk4WJqLPIdaRZ8iZEoAxLgT+Uj8PKhi+uDYAH2bksaA5IzBbWqJ?=
 =?us-ascii?Q?xUpZOmHLVhzloiMUx1KrKrAsIeraormulAmSkij4SuV6/OlGVz2sEE8wJNvu?=
 =?us-ascii?Q?sbcnlqf2lI2XvOV2WzyB3FZ8s15YsDi6PbNmFC/a3L08aLhJ9sJf8MZWG/Z6?=
 =?us-ascii?Q?kilBfu7w4TwKS08MOE/BO8yZe2jgTvgbEHPMLZ+TTxGiuvJ7bxBbE1svjFWM?=
 =?us-ascii?Q?Vg1BZNS0qVwG/n9rqGCfik54/Yd3m4s+B/xuS+afg8d7HPTkVujHtBV6iJFe?=
 =?us-ascii?Q?QEkUmhAbFCNe991Z/LvWJObmr8TGWBi0f/6kEb0ytyHUa42WNO/adeayiIcQ?=
 =?us-ascii?Q?CfVCHHdxc8EuSXZ+h98f0LUkzLn2OFBylHMCBllfaYCWx0jKmAjNsXJa7J1k?=
 =?us-ascii?Q?8SkxJC9Yn9KJo24dnWS14vl5I1GJ02iUXuA1dt3r8bCnYOuImP6ZEgTGln6k?=
 =?us-ascii?Q?ovvqXvS4fG9S1H10QsJh+ZKkSRha0S/LfRhKQwV1obw0+ctgihZbrHtPb0EC?=
 =?us-ascii?Q?HtBZo1hDl37tFBsdJ7sa6vpY7Jojl5auCQEy6x335OaYeYA+z/ld?=
Content-Type: text/plain; charset="us-ascii"
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
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR08MB10062.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fecb941-d504-4e74-acf4-08df3af4e7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 04:26:04.7909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laXMAK7oN+KGaSUuwR8wY86c3Wkuk9w1opzfN/mf9lPvuyfPMCGkeN2bmYjPO2sYNI6kI4qjTV8ehTZKd/t5m8WQfFSfHAq4itTsjNG35KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7610

From: Namjae Jeon <linkinjeon@kernel.org>=0A=
=0A=
[ Upstream commit 3474e1a304fbf9f7c996b24adcd519e031227a90 ]=0A=
=0A=
parse_sec_desc() constructs SID and DACL pointers by adding untrusted=0A=
32-bit offsets to the security descriptor before checking their bounds.=0A=
The existing checks reject offsets into the descriptor header, but do=0A=
not reject offsets beyond the descriptor's length.=0A=
=0A=
On a 32-bit kernel, a large offset can wrap the pointer before the=0A=
descriptor. The end-only checks in parse_sid() and parse_dacl() can then=0A=
accept it, allowing an authenticated SMB2 SET_INFO request to access=0A=
memory outside the security descriptor and fault the kernel.=0A=
=0A=
Check each nonzero offset against acl_len before constructing its=0A=
pointer. Initialize the optional owner and group SID pointers to NULL=0A=
so an omitted SID remains absent when parsing the DACL.=0A=
=0A=
The 6.1 tree uses a void parse_dacl(). Preserve that interface in this=0A=
backport.=0A=
=0A=
Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and =
tranport layers")=0A=
Cc: stable@vger.kernel.org=0A=
Reported-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>=0A=
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>=0A=
(cherry picked from commit 3474e1a304fbf9f7c996b24adcd519e031227a90)=0A=
Signed-off-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>=0A=
---=0A=
=0A=
My earlier reply in this thread had its tabs expanded by Outlook.=0A=
Please disregard that copy.=0A=
=0A=
 fs/smb/server/smbacl.c | 20 +++++++++++---------=0A=
 1 file changed, 11 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c=0A=
index b0bf27cab..4a8812336 100644=0A=
--- a/fs/smb/server/smbacl.c=0A=
+++ b/fs/smb/server/smbacl.c=0A=
@@ -885,7 +885,7 @@ int parse_sec_desc(struct user_namespace *user_ns, stru=
ct smb_ntsd *pntsd,=0A=
 		   int acl_len, struct smb_fattr *fattr)=0A=
 {=0A=
 	int rc =3D 0;=0A=
-	struct smb_sid *owner_sid_ptr, *group_sid_ptr;=0A=
+	struct smb_sid *owner_sid_ptr =3D NULL, *group_sid_ptr =3D NULL;=0A=
 	struct smb_acl *dacl_ptr; /* no need for SACL ptr */=0A=
 	char *end_of_acl =3D ((char *)pntsd) + acl_len;=0A=
 	__u32 dacloffset;=0A=
@@ -897,12 +897,7 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
 	if (acl_len < sizeof(struct smb_ntsd))=0A=
 		return -EINVAL;=0A=
 =0A=
-	owner_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
-			le32_to_cpu(pntsd->osidoffset));=0A=
-	group_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
-			le32_to_cpu(pntsd->gsidoffset));=0A=
 	dacloffset =3D le32_to_cpu(pntsd->dacloffset);=0A=
-	dacl_ptr =3D (struct smb_acl *)((char *)pntsd + dacloffset);=0A=
 	ksmbd_debug(SMB,=0A=
 		    "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dac=
loffset 0x%x\n",=0A=
 		    pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),=0A=
@@ -918,9 +913,12 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
 	pntsd->type =3D cpu_to_le16(DACL_PRESENT);=0A=
 =0A=
 	if (pntsd->osidoffset) {=0A=
-		if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd))=0A=
+		if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd) ||=0A=
+		    le32_to_cpu(pntsd->osidoffset) >=3D acl_len)=0A=
 			return -EINVAL;=0A=
 =0A=
+		owner_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
+				le32_to_cpu(pntsd->osidoffset));=0A=
 		rc =3D parse_sid(owner_sid_ptr, end_of_acl);=0A=
 		if (rc) {=0A=
 			pr_err("%s: Error %d parsing Owner SID\n", __func__, rc);=0A=
@@ -936,9 +934,12 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
 	}=0A=
 =0A=
 	if (pntsd->gsidoffset) {=0A=
-		if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd))=0A=
+		if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd) ||=0A=
+		    le32_to_cpu(pntsd->gsidoffset) >=3D acl_len)=0A=
 			return -EINVAL;=0A=
 =0A=
+		group_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
+				le32_to_cpu(pntsd->gsidoffset));=0A=
 		rc =3D parse_sid(group_sid_ptr, end_of_acl);=0A=
 		if (rc) {=0A=
 			pr_err("%s: Error %d mapping Owner SID to gid\n",=0A=
@@ -960,9 +961,10 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
 		pntsd->type |=3D cpu_to_le16(DACL_PROTECTED);=0A=
 =0A=
 	if (dacloffset) {=0A=
-		if (dacloffset < sizeof(struct smb_ntsd))=0A=
+		if (dacloffset < sizeof(struct smb_ntsd) || dacloffset >=3D acl_len)=0A=
 			return -EINVAL;=0A=
 =0A=
+		dacl_ptr =3D (struct smb_acl *)((char *)pntsd + dacloffset);=0A=
 		parse_dacl(user_ns, dacl_ptr, end_of_acl,=0A=
 			   owner_sid_ptr, group_sid_ptr, fattr);=0A=
 	}=0A=
-- =0A=
2.43.0=0A=
=0A=
