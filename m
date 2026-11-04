Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793762660;
	b=ZGko6rbTUGqRrJci5keN5qdLsFlDfUnTiQt7Gt8iX85/blWgasyyqkfdyiRtpMJkAxmq
	 Rs+q9Vu5sQqb+GQOJKvAIN7WELGnORA7l51rgldF0FA/0FDa7AinNU0NhfKliCqo9XNgs
	 xHn66krKdUDMisOt00yUy9NayPZtB4pJuf8/JtEbsSznQ2SxX9OegoRfL8L9CHB1TOjty
	 nuwX8gGXDDb7cVxuK4okvlBFO8p7aFXR5lS87SLL/UHPJxHM0WamBQUzTHFkg4AkxWqBB
	 /fi8Gx76oG1FfOgs/Y37zamHoHEgDcJ3WoO0e8XTv56NoudUKfXfdfEDfLhljykGy+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762660;
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
	bh=xG1xMoAr1JJbivx8fnZFji9nR644SOufyH7NVYwdJB4=;
	b=U9Ik8suP4fJc3ufLMfnsM3+XYPCgD1FnqsQVqMBF1lDND4pVJoBNgujVtN5VQ7YBbJXu
	 EqE6V85vptpSjvEKxIlRKa4c+j8esKk5Ihbgdh/025H0msZavYpJ4UId8ZMNMhwnsYQsB
	 7KTkJzpJRz6Z8ulnejcydO1piEA3h0ntI8+angkwnWEvFCS0lmKNKIliFykLB7IGmrfLI
	 1O2W6NZcpaJplYE0bov5fvK5Q0x6Su2fP6RJ/h+vyELABtsHt/1Yh5fW20+m1bkW3B0ZR
	 YeXpobgYJVrPyJJ6vcvPDAEzStGul6SaXU/eLJkn/oOqMYDK8GzbW3l2hZ8IWFQoTHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=tPyZEvaz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.120
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022120.outbound.protection.outlook.com [52.101.66.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B559606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B559606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=tPyZEvaz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iedGDC+iMty8PsS98sisOuWNGqPByYAmfKVndLqqB6mfNyiHI1rUzizbFWsRIweCbihaSxnNGc2JqphMj4jcYt9JqrPxgpeLbGoFztdMmu0rIe7389Yad64FTq47L/0BvyyHY/1oWWqtWT6itN/YlFSNQYHc1UYGUu85bMVxVRJSFb85HJaDdMxugGKGPz0pK1inlKqO63tMA4pb0Dg0NXDYgdX2vYc4BRVNlY594x0GRS0ATTcSk3dZFV3AutoQqNSAE81ZnZbCvenN2Nfue8YriMOfgBOpLizQJHvjn5S7M2nsQAzh6cED2/BDJObXBCf3V54jcsSFCABVMlF97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG1xMoAr1JJbivx8fnZFji9nR644SOufyH7NVYwdJB4=;
 b=VZJdrEP6UF+OWxyJC5UPrL+1lCKW7K6UA1nDMZTnc2R96ExORjYGv/HQq3L0uxZ+vpPfCkez6fylQTok2GG6TWKEhDQwHe5phDXGGN0ZAWnwa7DBKwdhVMVnclNWCxJfomvK1UkjJUKx65ar6lK4Kx3a11JLyPUOYeu2R+OzhSmgzsBK+ylGOPy+fvlZTIH84UTfSTiXvSpcdBalNq7EktjSEaVfK6jn5AOYb/COF3KZ+lQqmeJfgDqE+lIrfGAIF+dCMiY9NlhtEqZJXa5Llb+HkGco9MMGn+4vorprvXt1avSrWVpBasaYK+9i3MBr0oN5rH8Ne1BA3divd5KKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG1xMoAr1JJbivx8fnZFji9nR644SOufyH7NVYwdJB4=;
 b=tPyZEvazDxY8jrpDSXR63PSD0/dtKQ9MjBCH+akMbWFrqFzTqsjiDFDGFoQUi9GP5WGXWEf7WdQOin1lYepc6A4YuPMVvZscJoKbjauT7gKXwFUBRNoidQu7QIdA1q2hXV7GoZtqNoVTl0uhdHJlZvUKaFUYXsQLX9b2l7nAopU=
Received: from DB5PR08MB10062.eurprd08.prod.outlook.com (2603:10a6:10:48f::10)
 by MI9PR08MB999879.eurprd08.prod.outlook.com (2603:10a6:290:ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 03:24:14 +0000
Received: from DB5PR08MB10062.eurprd08.prod.outlook.com
 ([fe80::cd17:89dc:ddbb:2f38]) by DB5PR08MB10062.eurprd08.prod.outlook.com
 ([fe80::cd17:89dc:ddbb:2f38%3]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 03:24:14 +0000
From: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>, Paulo Alcantara
	<pc@manguebit.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Backport: FAILED: patch "[PATCH] ksmbd: validate security
 descriptor offsets before pointer" failed to apply to 6.1-stable tree
Thread-Topic: Backport: FAILED: patch "[PATCH] ksmbd: validate security
 descriptor offsets before pointer" failed to apply to 6.1-stable tree
Thread-Index: AQHda3z80BCms7aQnEGevETDHCU0sbcdP8Wz
Date: Wed, 4 Nov 2026 03:24:14 +0000
Message-ID:
 <DB5PR08MB100620A5BE5A4EE2F978D001AFD682@DB5PR08MB10062.eurprd08.prod.outlook.com>
References: <2026110319-default-yelp-9aa0@gregkh>
In-Reply-To: <2026110319-default-yelp-9aa0@gregkh>
Accept-Language: en-BE, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR08MB10062:EE_|MI9PR08MB999879:EE_
x-ms-office365-filtering-correlation-id: a0521fa4-e839-49f9-ca07-08df3a231a2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|786006|366016|23010399003|22082099003|10067099003|261102123227099003|18002099003|38070700021|11063799006|56012099006|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261009223027099003|261021121427099003|261021123027099003;
x-microsoft-antispam-message-info:
 qNrHOTWTM+87gdjEoSQiaM8BttCjXr+iWAfqn9vX6u1GmaUb1molu2p2f7OOzDWfIRtxxHhxIJWLiF4yeLK/nmDdlGpa7OnTq6M+kXdgFRXRAiYuht3hVNh0MwVF+2axHa+xagjOV7vnyjKCR+w4n2so4BrDHbJIAMiw0D8+TwabTBuGNYyfq4ZnNnJ2CRzsWLCWOAfVQke166n747YYoLjyY4XznW5wUJIxyXwmG6MQcrfF7uLN7e/+qCmvPSQewc2zkUsPQEHMxkVYUr1kD++JhYu218J/u8bxXccUZ8e0N47gJ8C1eK2HtPygW518aVu9ec1/DyzvSCI+XzJK/PQ4QcXX5j4Nwx7Vx9yCFohxwf0j35JOkqgKkGT4irVjwPD9aHOvuEh+yxMijfD2HKwjNheRRU3M0kYI2Nmcpo47agDrsl3Up7dFRWkZ1MKXTMmD+t18TE0rP5xZIb3NUpLmxHndjJQyJezHrnSN2rPCDETd8VYZIHXu3wRFj9AKkDqIaSDkF+v12FH4cWDg82WGYuvJFavX9/NIDV9s5G42zBgsz/xSAhoSLp1EIRKT1ZQg5R15LYPMw9Lmo/igNaZTMqygtZMX5XVjfN6aVww39i+KH/kYRpClGjVeLsuugCkuZ7/2Vkp1E5Rzuy+lX1GSaEZTstBAQ29KnXH6MQEQf7R66SOj953TBJhJ14yervTo3h4CbjjSY4NIaumSkovlrLDYc0m/de4W2loTTlU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR08MB10062.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(786006)(366016)(23010399003)(22082099003)(10067099003)(261102123227099003)(18002099003)(38070700021)(11063799006)(56012099006)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261009223027099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TUfd1QtoiyvrLH+a295HIA+FdbrvkrMzCBX2N9U2xCR6aa/cKuy4Q/beOaQv?=
 =?us-ascii?Q?t4iv8BNuiLdHmCXIn0iDLcuwMtp0u9bNClKWu/dniTib75EESVfLCRwWEnQJ?=
 =?us-ascii?Q?XaIfxo+3jaEfk4xApQAhcbvR+s9Py9UbQCNVpnGBiX9Al2JWwXK4bPX5ldDV?=
 =?us-ascii?Q?H9EvJnc1/0Tul35n/UYDyLuPcOqYI2evFehnCxQqLeExW0b+Rng2Rup/MZv8?=
 =?us-ascii?Q?MhS0nGxr823V2PGA6ShgARnVmqbLNhERMsT1eggvfh9mY31KSKTMFPGSe9BB?=
 =?us-ascii?Q?dJ4Yed0UmQl+cIb63JP+Uk0CvffxXsPnMbwrP+lVYL0wev0s5+iJ/LZXkMWp?=
 =?us-ascii?Q?1pW2QTPkzLvoU/1zdftEyFpYtcQ85CBVDuWrnmfK9S2DFKJ1CcjWTFPdy4co?=
 =?us-ascii?Q?ipaYof4l09rNCx5S6oKMWXAGY7U1L9tUCV8xjah5KfHq44LfwqltP9wVByQu?=
 =?us-ascii?Q?w9Htqoxa6jE8ehZ6W27PTltP+vwPFWXcbSOzWc1qvjzx6X7nDTewgJb+m5ot?=
 =?us-ascii?Q?04N5HDbgtOMG/lVcYNlfNAchV56MyhcMpswYkR9p56sfm1tPkbMoIps00co7?=
 =?us-ascii?Q?Pmd8zddiuK3E44I0qYYTTt2d4cWtTw2IwPxFyAXnwR2BlsJ9gT/0jTFQVHjU?=
 =?us-ascii?Q?m0q87mScX8R1SvhRVTqJ0Uon2EO3xOQfpqu5vThIbKfjjP9x5VlZZi8R0CTS?=
 =?us-ascii?Q?TLVOHCKURR8IYk2NytPwVmac7B9xtTA2ADUz9f0JzYoMMN/+zXPux8McO2NW?=
 =?us-ascii?Q?MLeO/4qNvgELMDvhYDS0s1O9tFollBN/DmhCIFekANxwTUCzOn8Ls+GId0HM?=
 =?us-ascii?Q?rQMbkfnQ8SlN4AvW4I1DB1osys8C+lpvY0THG6UU5JNkHcjG/01UohLzlh95?=
 =?us-ascii?Q?qHPxZFcSRk6whf7+wFkvG4IO3Wv9asmut+FZWMvMAHmaMdssBL/28X9t0uN4?=
 =?us-ascii?Q?St840egETX+YzZfE0SnODsufmXnEQDqp2zrqKRemiMIqO+aXlcoeb6eNsk9j?=
 =?us-ascii?Q?jK5Y/g83hN7kM8MlrfzFe6usWZplHbBV4iG1+xnq6of1Mj62ui7eDfciZUBA?=
 =?us-ascii?Q?QsdF8pPkY/n/Lc9AWJ/6n+zc+aWPz2ks+MN82iKfBfAuk1Srjk5jr2csaRRk?=
 =?us-ascii?Q?sttQJSEsWPKuIwDSImb8G61p9M78qHn6+9yiK6JQkmcHJgv+QyjKPtLlQzfZ?=
 =?us-ascii?Q?S2HDUQfA2gZe2xyafuZ/hQMA29Qe1jSPuq0LHENmjIDAXjIOTdpJCWepO6ni?=
 =?us-ascii?Q?wy8rsfjoMeLcqStl1qiUe5q3AlmDt872ytMJqF6vZD2GY0xx1aS2G3pB0CAW?=
 =?us-ascii?Q?2yUpPduf9P3/J98dkR9pW1ABIjIoOs18uzIReTBana+xz9MNtzrmVyvEbApV?=
 =?us-ascii?Q?PaeHzxw+dlS1o3YZrUiv7Ftphx8tEB9F09rfQVYp9tR2OMPozFjgEHhXAyfJ?=
 =?us-ascii?Q?zPk8qoHlY2UpZ8SINe5N5b/9VaPcl8nKtpTLxGohIki1dTUeeU7kDs8vfwkP?=
 =?us-ascii?Q?cTiv+HuGocFWJCoCMMl9xLNju6DkPyo9LfIw7aGII7dEjzGP+dG5DMFytDer?=
 =?us-ascii?Q?yeyA4vvWblPZ88Hvyi9Ypkst7daKtbsYMMN2FD6Nq+dp51/Vf6/IfExkzddC?=
 =?us-ascii?Q?Calojt4NVtRPqcNz1d5XBwz8ZvRmKGx0Hl3CVN2pwmzxY2TSOOLQDe3VTdCm?=
 =?us-ascii?Q?dBFpISmzuxgAVXkbwW5S5EnPmgR3sZkOnrl5MwdTyhMzGR/WmKnKrnRlHm0G?=
 =?us-ascii?Q?hx3xZpQXk9hfI8cjCAF+cK+M3cW8BN0wh4vYPV7pwbzn5IUxA+pm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0521fa4-e839-49f9-ca07-08df3a231a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 03:24:14.7085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tz7kEgjnhTSAKOmzsRi9PXKF1PRsMgpaOZN3iUYRV3M9NUw3/J9Q3E/Ol4m/36LmB7zx2Kwji0NtAkSn3sQxzV8F36VQmqBgciJEY0mtugY=
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
-       struct smb_sid *owner_sid_ptr, *group_sid_ptr;=0A=
+       struct smb_sid *owner_sid_ptr =3D NULL, *group_sid_ptr =3D NULL;=0A=
        struct smb_acl *dacl_ptr; /* no need for SACL ptr */=0A=
        char *end_of_acl =3D ((char *)pntsd) + acl_len;=0A=
        __u32 dacloffset;=0A=
@@ -897,12 +897,7 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
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
@@ -918,9 +913,12 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
        pntsd->type =3D cpu_to_le16(DACL_PRESENT);=0A=
=0A=
        if (pntsd->osidoffset) {=0A=
-               if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd=
))=0A=
+               if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd=
) ||=0A=
+                   le32_to_cpu(pntsd->osidoffset) >=3D acl_len)=0A=
                        return -EINVAL;=0A=
=0A=
+               owner_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
+                               le32_to_cpu(pntsd->osidoffset));=0A=
                rc =3D parse_sid(owner_sid_ptr, end_of_acl);=0A=
                if (rc) {=0A=
                        pr_err("%s: Error %d parsing Owner SID\n", __func__=
, rc);=0A=
@@ -936,9 +934,12 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
        }=0A=
=0A=
        if (pntsd->gsidoffset) {=0A=
-               if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd=
))=0A=
+               if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd=
) ||=0A=
+                   le32_to_cpu(pntsd->gsidoffset) >=3D acl_len)=0A=
                        return -EINVAL;=0A=
=0A=
+               group_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
+                               le32_to_cpu(pntsd->gsidoffset));=0A=
                rc =3D parse_sid(group_sid_ptr, end_of_acl);=0A=
                if (rc) {=0A=
                        pr_err("%s: Error %d mapping Owner SID to gid\n",=
=0A=
@@ -960,9 +961,10 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
                pntsd->type |=3D cpu_to_le16(DACL_PROTECTED);=0A=
=0A=
        if (dacloffset) {=0A=
-               if (dacloffset < sizeof(struct smb_ntsd))=0A=
+               if (dacloffset < sizeof(struct smb_ntsd) || dacloffset >=3D=
 acl_len)=0A=
                        return -EINVAL;=0A=
=0A=
+               dacl_ptr =3D (struct smb_acl *)((char *)pntsd + dacloffset)=
;=0A=
                parse_dacl(user_ns, dacl_ptr, end_of_acl,=0A=
                           owner_sid_ptr, group_sid_ptr, fattr);=0A=
        }=0A=
--=0A=
2.43.0=
