Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793762713;
	b=2HVlSrGKw2svYnzp9aihR/1ZfhuLf6EfI/iaMD1BjKLanoqhbJ2AxACdOHwVIoRqjsJW
	 u2TylI5btLH92jdGJXmhVlq2dYvHMXfpELWOh0u/MSZpfFQiPtSNIAedD4PPcyYXCTFw8
	 90FKbv2toIAiMlGYS+tY5GFVYO9wBx9YcJFQssY30Mhr8WvzT1sECg3tp36JBQa7KOq+6
	 FgCgMxeUOJDLxM4XmWm8EZqdsA+IgkeYZp7sgIfLOpaNxqdf7anYFiqcw8n7cJmVgCnQi
	 ORxArzsd4uad/wjYQuN2Tu5LOjRDGTxuEan1JwiTt3Qjhrv/Q6N98eyLsWy/nGwL9TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762713;
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
	bh=z2uYIHlmzNrzc5a7IWdQARfhwpVScVopd3jFdrBLnrM=;
	b=BUxmFnjR5ZBaalvkpoObq9XwzBtdsMeysav2SPUF1MDy4vOwrH1flP0ril92o87y6KxI
	 QLMXGy2p0vEDXp0knDoy9PpCF8ng3IhsvCKdcs6w70+8dV+Vx+sC2+2J2qEkYB/4IlTzq
	 Jf+YVKjXFQ2lwJVrJaIw75uzYuRFJ16vPc7wVIzpUqHTJPgXboZglySE6d2Q3fEWJxGtD
	 3sb+RLLPvnxY5YtNYJQ9FU/TuNTg9o7fB2H8BDR/xNJJ4lQaAZHVvs++1LcUpfe2+uAwo
	 2rSE18zsYM0CMYlynJTZQHWV4yrQWA3JmFsgnjI5p9gl39WzyBMPN4POJpV20Zv2Pvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b="gVvOJHh/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.120
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021120.outbound.protection.outlook.com [52.101.70.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DEB606A336
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02DEB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=gVvOJHh/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf1h5kenNsRRwiJRJ2aMMfl/VWjiM/Tg3zBZuUUpZiP7ITGpkjPQIF5zAI/tO9TngZoN1uCJvcaAS2SxUqnzYFOUWeWomv6/z+7lMGc2WF08OFXBVqjHGLCeiVsjsTIczahGtmPHInhPek03buOCE3GyvKrfT0pmJi/lC2GuhhAo7a1+AjAqmrus1VFLshrEMECLgwke+16SAM9mGsgxcwwXwuKjMXnjjDm5tzRckJIasaVJZK/2BBr3Ue7N6AURV/ksD9TeI3SYbbHhYyQRgCEdlgIFUmfDLfThiq0iK36sirAMjWXoghta0rP6LzbYqAlBcfn/q2PCKb4T6cPvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2uYIHlmzNrzc5a7IWdQARfhwpVScVopd3jFdrBLnrM=;
 b=Uc0hTnh13y0aTSvUx02dbKbT4LQrZSakIvn4zxiT78W+0BrB2WUgauWy3/JQWg0EkarlVzg1qebohCmLIwvL7C17ApLHHeMVfXPBcMZYEMMzyiY7ysDu3ojgTuNiQBNr0os2HH8/gw8hSQjK47BFjVyBKRrGmlRSPbzLya22r5gtcakqPcoHSs9bdBb715fbHzwPYJxduIym4nq3tVYIKOX2rraQQ/wNx5scB14t0ag/ES3CDzNhOy74G8x9LxpGvGYzxrubFuhp4nm73NHIO/cbI5aszIxGUgTpVYHURbKbVWZ9H7LBywQLGJVnVOQnmT7nNp7Dilpm636c65vCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2uYIHlmzNrzc5a7IWdQARfhwpVScVopd3jFdrBLnrM=;
 b=gVvOJHh/czKFx1LsxmzLLsR38h+ZGKYgswN9zN9y4WVzT3w3VYRl+5M3/sfaE91RMMOctq+llW2uf4oBUrn+Mozfktu7QwAAaI8QG7vs5XjCjSDPWsKfCUi0IevFCaavYL5pOoj2okNa1bvBPtwDAWzjvdn3E4HbH2Xoa3M2khY=
Received: from DB5PR08MB10062.eurprd08.prod.outlook.com (2603:10a6:10:48f::10)
 by MI9PR08MB999879.eurprd08.prod.outlook.com (2603:10a6:290:ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 03:25:09 +0000
Received: from DB5PR08MB10062.eurprd08.prod.outlook.com
 ([fe80::cd17:89dc:ddbb:2f38]) by DB5PR08MB10062.eurprd08.prod.outlook.com
 ([fe80::cd17:89dc:ddbb:2f38%3]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 03:25:07 +0000
From: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>, Paulo Alcantara
	<pc@manguebit.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Backport:FAILED: patch "[PATCH] ksmbd: validate security
 descriptor offsets before pointer" failed to apply to 5.15-stable tree
Thread-Topic: Backport:FAILED: patch "[PATCH] ksmbd: validate security
 descriptor offsets before pointer" failed to apply to 5.15-stable tree
Thread-Index: AQHda3z+nnaxK4zPX0KhLuldbS1oBLcdQP4O
Date: Wed, 4 Nov 2026 03:25:07 +0000
Message-ID:
 <DB5PR08MB10062A51C82290EEE2CE45203FD682@DB5PR08MB10062.eurprd08.prod.outlook.com>
References: <2026110319-apple-willow-5e9e@gregkh>
In-Reply-To: <2026110319-apple-willow-5e9e@gregkh>
Accept-Language: en-BE, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR08MB10062:EE_|MI9PR08MB999879:EE_
x-ms-office365-filtering-correlation-id: 56c9f6ba-c716-415c-d73b-08df3a2339ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|786006|366016|23010399003|22082099003|10067099003|261102123227099003|18002099003|38070700021|11063799006|56012099006|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261009223027099003|261021121427099003|261021123027099003;
x-microsoft-antispam-message-info:
 0xSCsznwYi/4heWReGjEdxeqbTVnIKEBBcQHrg8WoEKf7U+UFZCVGmQ5lYP3b+JR8J+rs0n7WiaqdGVC4Y9w+D0OuD2IpioLmonn3xmw19rBmM7eNXyphiE+vw/2VKEI8sFZ+e0G8160e5gKUhb3M0dmb5Kl8HlxVIWm3gStiWcZysIwT5FFbhbhXp+wmsMYyfnf5O79NIBmM4N/SUpw0v5yPMN0WZX20C6cEQV2cxkco/anW+E2M/m1YggeRZvpuJvKMUl/LBlTxHl2G/jP/Zo7g+9BNxTEDISciJCN+bDdLiMd/jQXAPKj40rTfWweSznnf+lUFR3GqqdxqRr4Cn8V5z5OHZAtjPZqiGkH30rIbGAnXFR9Yl+V/GCFhVONsDbS/o3r9DzDzNg8JWICm/hwS8PWyLs8vSrtsSYT4w4EJraQXRCMrdQcIPh2Hybs4SweRgzLSfWnsxBX3Uo3iGUq2LOHtGBHupOku1n0JCcb6+jbmrl+fSpbP9ljX9IMQMpMlAMRQg15DqKL2mQOuR3XzCSLuBNB9BMnRmxwMYCXiNs5a6MYDOT2ylGm/M313jlsG+gezeixNeMdku2F+WTJ3TRZFANkhCh4o/Eh6Du6K/Dc8ToyDG8GVocIJOXPEoKLkHBUOR2JN/HegTBI7GrNV28+NzGJfXlqUARL0c1kTZUc7d3a7udAV7ewDyz0KblLEqAeYiH8CpGlxX0OYZSJL4s4kbqbJKRxUCajNiY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR08MB10062.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(786006)(366016)(23010399003)(22082099003)(10067099003)(261102123227099003)(18002099003)(38070700021)(11063799006)(56012099006)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261009223027099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VGdXQDLKTHiBAKg5Yig5+Wg8ac+b6OX0UuKjiDl9ugfdikhxFS97EQlQdGnM?=
 =?us-ascii?Q?kKmMxrsb/53aUrpWBAakZc2n3fyoHUHukVMMZjTilEbFgNjveMdfI5uNf1cl?=
 =?us-ascii?Q?LRMp0/kTP8muj2I72oCIYS5NV1kfpRkq1/djJAJBb8HMWGMeZw5QskCUpBdJ?=
 =?us-ascii?Q?JWjIPUwawFEFaHzjzH7hlQNWMT4s9R+osxHXXaeOzj1GIeIPqb7af22emezb?=
 =?us-ascii?Q?/HmqDDCRsz/w0KlLzH8Sx/y2X5EFgQi7U/gHMGrJubX3agtohThQbo8aAysQ?=
 =?us-ascii?Q?lFABRIS1VcnoY6AfMpTaOtYhSp9CaJshZ9D6CSBhiBbgrcKZzXQwhLzFLMez?=
 =?us-ascii?Q?p0uJtZ8NLr093752o+WIusmS+QzLQcJ1GKL0lJuVGQb9KDKxku1Ah9Y0+Fyp?=
 =?us-ascii?Q?U1lPWLIUixsS81Z166S5n/MEj0ZEI7FayD4mnHOIAG/x61yrSAcZGArMSDtp?=
 =?us-ascii?Q?fhm/UNKdoPUwRiJIYnturWqITyD/5rYyj9gPWnZrBSwxU8nG4appiktbzW8S?=
 =?us-ascii?Q?Air89g6wUxQ/8tQsaoqODIv16/VPbSHYfCOnNViuiFHeW6AD9Ou1aHKAzyn0?=
 =?us-ascii?Q?Ly8v6eoe5+uhS1384KN+yT0rLVo+9bly3r2ZHCNEfkufuNsjWkmhWi4UaE+J?=
 =?us-ascii?Q?P3lAv8X5snr0eA8LeainbEMtOnfo3oa5bkEJAWHEsyNcaSImvKau6jf1Lhzf?=
 =?us-ascii?Q?4NnL8D4TB7bEQ12aHZUYrGLzxIz4N5k6Lpu2vhIFu8Rr3D6mK69r9IG+e5XP?=
 =?us-ascii?Q?5D+kmGTLk3RDKUTc9DvN/w6+4l4yqC67yT3Z6Q5cCfPyh7gzbr22eNniwyPi?=
 =?us-ascii?Q?uPBYWC/v/6QLKeqD81k17r2nQ5AyWlH8ZSembmbjJdSS/gCwowsHIYKFm5Ij?=
 =?us-ascii?Q?U3uVGJFBVsd8UEixagHJ+Pj3rECD8wTpcZpY+b8XVaqBJ0pN6ljbGBBRvoAd?=
 =?us-ascii?Q?BD9CcXI/N2pxEklIIkexiHlTC2vfARTBbUwMYUZGd07yk4QNOpHWhtGdPANh?=
 =?us-ascii?Q?pKzrXs3e2v3a7+VZDvOpY05E7VEdtpfsldjno4+R0J7D0Q+YsAA+1bo5BJaq?=
 =?us-ascii?Q?n+LbNbzKlHX/0rGc7bY5XzfHHAqFWPtnsjsHOr7gVcwBP/KQtYr3wX6m9+fB?=
 =?us-ascii?Q?8cb/SMtbtSX+0xM/6O0n+Ntj0DxUXbjN+x6NPIqROlx+O+jcMPmiAwyQ7kB5?=
 =?us-ascii?Q?ZjW12VskHqaHeRKAMz/MIV0nESBPDmyBeLQOG0CMA6WkPB7pZMj3HqB7gvce?=
 =?us-ascii?Q?fzLpbFdewCUTTTCtZuQLAQc3Cc3AiBL9fkNB36L8LVY7cuIZ/wLystx4xpYw?=
 =?us-ascii?Q?VqvrHkVY+JVLgKDJY7YmZBq1usEDq/7k+bBSbL1jfgMY6d9bdkn3ArLN/ACp?=
 =?us-ascii?Q?pM8M05oGyLxA2LKjb/e+PPxDC/lRg9MWUuWVLav8R0gv1UErlOPEX37FfTMR?=
 =?us-ascii?Q?sIvNE2IV4BBEnMK8b0kaSVZvMw4Qac3cyXKAwpCS3dLkNbVy97J6p1KCFcl/?=
 =?us-ascii?Q?O9vwrZv1Ycc+/utpGLXHLdrYN5UVkcZKSCxMg9Umuu4jkofciu28GbL242Vx?=
 =?us-ascii?Q?/w3O6N8VpWdJQrYbfBqD7HEbpn7RL0qsB9twwfhY1LbOcNASCjtbGTWza0uw?=
 =?us-ascii?Q?51SRXI8no+JCoEQakY0I078kJAgNKct7vO9jHNRc/vfaUSavAP0GL3gtX2sd?=
 =?us-ascii?Q?u2tfSKsrZb+8shdMATzQ0tvg6JS5tLbwAfth+NRDeKnebG7gzZAVV5TcVH6b?=
 =?us-ascii?Q?VAwHDZbR5rqOR/+ucNyLzemk6woCHWHHzabfq2Cmm0+Od5Iwhn0+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c9f6ba-c716-415c-d73b-08df3a2339ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 03:25:07.7625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2L+9x/HPDA59sRQEkfLpBDXJr+LkyJWyKmRahCa8RtXAHu+2c2FjHlQLmhOFwRtn4N22uLM9cSVx0J3G7nwlYG4ciAd4Vnm9j3yl2VtjOgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB999879

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
The 5.15 tree keeps this code in fs/ksmbd/smbacl.c and uses a void=0A=
parse_dacl(). Preserve those interfaces in this backport.=0A=
=0A=
Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and =
tranport layers")=0A=
Cc: stable@vger.kernel.org=0A=
Reported-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>=0A=
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>=0A=
(cherry picked from commit 3474e1a304fbf9f7c996b24adcd519e031227a90)=0A=
Signed-off-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>=0A=
---=0A=
 fs/ksmbd/smbacl.c | 23 +++++++++++++++++------=0A=
 1 file changed, 17 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c=0A=
index 05c768225..515830f75 100644=0A=
--- a/fs/ksmbd/smbacl.c=0A=
+++ b/fs/ksmbd/smbacl.c=0A=
@@ -830,7 +830,7 @@ int parse_sec_desc(struct user_namespace *user_ns, stru=
ct smb_ntsd *pntsd,=0A=
                   int acl_len, struct smb_fattr *fattr)=0A=
 {=0A=
        int rc =3D 0;=0A=
-       struct smb_sid *owner_sid_ptr, *group_sid_ptr;=0A=
+       struct smb_sid *owner_sid_ptr =3D NULL, *group_sid_ptr =3D NULL;=0A=
        struct smb_acl *dacl_ptr; /* no need for SACL ptr */=0A=
        char *end_of_acl =3D ((char *)pntsd) + acl_len;=0A=
        __u32 dacloffset;=0A=
@@ -842,12 +842,7 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
        if (acl_len < sizeof(struct smb_ntsd))=0A=
                return -EINVAL;=0A=
=0A=
-       owner_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
-                       le32_to_cpu(pntsd->osidoffset));=0A=
-       group_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
-                       le32_to_cpu(pntsd->gsidoffset));=0A=
        dacloffset =3D le32_to_cpu(pntsd->dacloffset);=0A=
-       dacl_ptr =3D (struct smb_acl *)((char *)pntsd + dacloffset);=0A=
        ksmbd_debug(SMB,=0A=
                    "revision %d type 0x%x ooffset 0x%x goffset 0x%x saclof=
fset 0x%x dacloffset 0x%x\n",=0A=
                    pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidof=
fset),=0A=
@@ -863,6 +858,12 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
        pntsd->type =3D cpu_to_le16(DACL_PRESENT);=0A=
=0A=
        if (pntsd->osidoffset) {=0A=
+               if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd=
) ||=0A=
+                   le32_to_cpu(pntsd->osidoffset) >=3D acl_len)=0A=
+                       return -EINVAL;=0A=
+=0A=
+               owner_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
+                               le32_to_cpu(pntsd->osidoffset));=0A=
                rc =3D parse_sid(owner_sid_ptr, end_of_acl);=0A=
                if (rc) {=0A=
                        pr_err("%s: Error %d parsing Owner SID\n", __func__=
, rc);=0A=
@@ -878,6 +879,12 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
        }=0A=
=0A=
        if (pntsd->gsidoffset) {=0A=
+               if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd=
) ||=0A=
+                   le32_to_cpu(pntsd->gsidoffset) >=3D acl_len)=0A=
+                       return -EINVAL;=0A=
+=0A=
+               group_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
+                               le32_to_cpu(pntsd->gsidoffset));=0A=
                rc =3D parse_sid(group_sid_ptr, end_of_acl);=0A=
                if (rc) {=0A=
                        pr_err("%s: Error %d mapping Owner SID to gid\n",=
=0A=
@@ -899,6 +906,10 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
                pntsd->type |=3D cpu_to_le16(DACL_PROTECTED);=0A=
=0A=
        if (dacloffset) {=0A=
+               if (dacloffset < sizeof(struct smb_ntsd) || dacloffset >=3D=
 acl_len)=0A=
+                       return -EINVAL;=0A=
+=0A=
+               dacl_ptr =3D (struct smb_acl *)((char *)pntsd + dacloffset)=
;=0A=
                parse_dacl(user_ns, dacl_ptr, end_of_acl,=0A=
                           owner_sid_ptr, group_sid_ptr, fattr);=0A=
        }=0A=
--=0A=
2.43.0=
