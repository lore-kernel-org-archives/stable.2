Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793853001;
	b=TzOgvDYnDodK98XHQOV6WAHC9CSiXNWIRcXkyWEFBSe1ISczobPStpPeyZno3/tUHjvw
	 c2eoSsVNsDQ6SP9ZQw7BilcGmfdVC5nYWVPlr2RswCIc+3sjajUuYX+nhBYetJk28LAzx
	 y5ETPT79+CyIk3ACWihmYj4xF1EhPIWsFWtqxO51r9PgqOFqPsivulNHbxAjXAKpGcha/
	 N15HobiPgarJc0NdBtzelOIhqNuc8Xrz90C3RS2GdNMHWOscTlxU3IpnMl+ZfFR276irN
	 Hey7V/2kcxezCSVEPF4cCV6tx0rK6dAjK/6wmlWQqHSUK+55UWIwD6arPM3MKvcmEoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853001;
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
	bh=HORLSkz38vOQbrJ3gped6jMd3y7mELXX/aOGM9YYTNM=;
	b=OKOZKTZ2EBj3P8zwT8exTfJdhn5evJgSeHP6AI8VqBIYYJmoDExGzQ6dIRpbZA/kT+iI
	 R6BXcPugrZlSV8spjsmUXwwVYMJFQqT9f9yrvGH+ebvNqGc2F15kkBxYn2PWvCU0y0ljp
	 srpbu8y5tWv8FmrlfRJeRr9Mx9X6ytotVVDRKYptEs6omLcfZeBXWI1ypgqeXnu8sL1Us
	 FitQWHD9e8w6UfLdzB3XftmdGXpCLsMJqydGmqU5mR95wTcNLbZLwSIzsPd5iqJurs+h5
	 GJbAWdZrfyTSBOMzCPKByZIyfANQB3OM4NvTZIVunAQfJaqIsONNiDsfoWVO8P/zJ0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=dzE1NNLR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.116
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021116.outbound.protection.outlook.com [52.101.70.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DC4606A33F
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32DC4606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=dzE1NNLR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTGQWPtsiNN4f9ZwdCqFd9dGSlqYfq7JWjfosCbOsvSSshbLWaCLgPEVMVd9g4RuwzqhjCa/xZoO5WJ219G83Kp3NS/lUwQAUHOCESK1Xd7LY5xWAK0Ed8iXW4lmjtWmx2ADioPg7pnvGysOm5JD2yhIFADBnsywfwOvEhZtlvVLs7ffscUZwfV8llVC5lhskW+5SxWTE10GogsAjavn5wASxlNm6E4EbBjUpUmL1NerdDQIe/SLQ19YTlEcTQ2O/v8RgfWv8Jl689iv5NSXa+3LJYQ1fgYtjrnqxLprR5KcS8qg5GDJkePzLRef2yJ8Szl/FlptxWfAXfZkK+yXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HORLSkz38vOQbrJ3gped6jMd3y7mELXX/aOGM9YYTNM=;
 b=OIbQASwi8YOwBPA6hnin4m5WcUfyi+Zu6cAL9vZIfigzbm6qWHvyfSgRbVsnsfiwdlQWsmCjQ5qPutvDJWi/laPornF42hQDhMlo95DtZYXR1ttpzSTOKM09GHJ47m9R+bGNUl961u36eQsZhQDe64TC9fc2zTQOWL/dBXz6N5zEH5na5qy/ZDKEd9JZEXEtaDdPmS8gdAMpdmpsG52IRSNdoNWnoYR/bNgBaT4P6cmSIqF823UloDnk4tnOC1sRrcWZLjZuhEkytz8hbp1qlp/jG7xGOUNK9GsTgfb0VLcBy5HB9kICkxwxy9ELRmLxF7Bl6q4tl5X8uKLl94d7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HORLSkz38vOQbrJ3gped6jMd3y7mELXX/aOGM9YYTNM=;
 b=dzE1NNLRfLGk5o8xESFhxFOHFqIvJb02YDTRexJtF3M/lcsP+G0nMAn3c4FyTX2A7obC0X7uhVWoyHwrGUp8e91TsapGDvOT5pAFBjTV9bmOQt/N8N44QehoWRpXMov8erWM4TJ4ryS4eW6/jndyOQ5sJqmapPz41k+xQWxMK1M=
Received: from DB5PR08MB10062.eurprd08.prod.outlook.com (2603:10a6:10:48f::10)
 by AS1PR08MB7610.eurprd08.prod.outlook.com (2603:10a6:20b:475::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 04:29:58 +0000
Received: from DB5PR08MB10062.eurprd08.prod.outlook.com
 ([fe80::cd17:89dc:ddbb:2f38]) by DB5PR08MB10062.eurprd08.prod.outlook.com
 ([fe80::cd17:89dc:ddbb:2f38%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 04:29:57 +0000
From: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>, Paulo Alcantara
	<pc@manguebit.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Fixed Backport:FAILED: patch "[PATCH] ksmbd: validate security
 descriptor offsets before pointer" failed to apply to 5.15-stable tree
Thread-Topic: Fixed Backport:FAILED: patch "[PATCH] ksmbd: validate security
 descriptor offsets before pointer" failed to apply to 5.15-stable tree
Thread-Index: AQHda3z+nnaxK4zPX0KhLuldbS1oBLcdQP4OgAGj09U=
Date: Thu, 5 Nov 2026 04:29:57 +0000
Message-ID:
 <DB5PR08MB1006256D47F5978B53488262FFD772@DB5PR08MB10062.eurprd08.prod.outlook.com>
References: <2026110319-apple-willow-5e9e@gregkh>
 <DB5PR08MB10062A51C82290EEE2CE45203FD682@DB5PR08MB10062.eurprd08.prod.outlook.com>
In-Reply-To:
 <DB5PR08MB10062A51C82290EEE2CE45203FD682@DB5PR08MB10062.eurprd08.prod.outlook.com>
Accept-Language: en-BE, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR08MB10062:EE_|AS1PR08MB7610:EE_
x-ms-office365-filtering-correlation-id: 99debba8-40dc-4377-10b0-08df3af572eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|23010399003|786006|366016|1800799024|10067099003|18002099003|22082099003|38070700021|11063799006|56012099006|4143699003|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003;
x-microsoft-antispam-message-info:
 Hji/Burbf+R0HBLMC6Vz0ksEvXy+JgJrSu1Lg+p5Z2mTNRLpi/6zlVCz2I6reE5QV1zat2Ps33R7TUvc7aV5M3Vuxpnh3Rsj/MMPg1aAG+2SnOw4BMmP/jPefZy7crdg1W4CVolW7HzSV9Stdb0T2nsatujtpA70quD190Ct7pAmx1A+ukEwGwmQ7PTk9yEo0BeFzUUIlCRPwDAIO70CHaqlF67Z7+mwuIp4i5ViVmWWKYbhp0A9SjezETeFTavvLAwtCAhSV0ZnifKgFUwGkFFU33+mBSXY3rutWUJ4wUgwIa0TQg/tXMqlOCfKp9yBigA+ktE5WGjsade9p0IMhfR3ovTP3KZAnrzKmvWf04vTMqRWFqd0EPrnTG+3AR8ixuU3+4bcel0sLDFpvFOqSGVZMxyQDetBEdJZbS+GV2PETj7Pf27zzBK3AF4pXu528LnBtbuspTXNeWXPrE/s64l6Z7YcNiSvCHz+j98g38tsaqc7SYUstR1X39C/2TPtQbGNgJeX++CCHZYPQUYCSuGbaQoTXA6HhhejkIVTMakL5uuM27Pmzoz9Jx2Jh6cyeHi4jYWblSImgfOCuustSF+eJl2PAP6+ZKp/haDky8hE8L8oabDf67h2Zne6gBOV71ohTbjWojerR2RtpzOfj2dy32iPue/OfYwuhVkMu7eB2CGipPxwT+hUjF7euv9yDKAEOJYVc5RDN9Xrb731XE4vi01qQJLqon8BYXfzgoQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR08MB10062.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(23010399003)(786006)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(4143699003)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N1ZxBPL4iCkBq+HahChzHdgJ1DDY2Uv9jX9miERVpQ4ArhjsFJO/dg494MVJ?=
 =?us-ascii?Q?WOFLyRuT1op48LlkOj8rzOKKyOGc6G3fu4PgfMq48cLB+/W+RFRszhTbAoLE?=
 =?us-ascii?Q?E/prM2mXcNHDbysEfhtRw7oMdbTVzS0AZmAfFaJLb6VblsONUD3NhIBzyCaW?=
 =?us-ascii?Q?lvtONoEUtjT000Drr9O6kc6jn7Q/yYLPkCu4jVlB46GzWqDA/D+XmVBkVZbS?=
 =?us-ascii?Q?No9YkfYwyY1upitbtCr+ROV1RQC3eSNeukeDAuYfqp/qPweYm3mwwtuOdUk4?=
 =?us-ascii?Q?bgxrXnbvZVUrKAAEXlQEzTnmYlkSpG9Mi3jCdne35nj3u1Udn2nJSgeLD1YR?=
 =?us-ascii?Q?YODdt0ipJoB/v0FUoklakHspYE2r4Ob+PklzoST1/69r/kAAS2tdwx2upMYr?=
 =?us-ascii?Q?G/KBknKjtm493RsXW12yYNxkKtG03YQEuGRxmNmn/0eq+Tr/DfnAkDHCYIuj?=
 =?us-ascii?Q?IhJisSeITLKaMUaoaDdYiAkaZlbOAGLxGsDPCrQi0U6n5L6NkbavfZ/XeUMO?=
 =?us-ascii?Q?JUNTALLkSsEP3Wzfq7352fmMFMUtt15D6YC8OQ+dlRS40aKfmOF0B7YgTHpm?=
 =?us-ascii?Q?dFUCNWu2Lb+DQvDU2JlSWQe/G/98Py5mR8qWMpTz9Z9KeJAFv7p1gOzwt4X+?=
 =?us-ascii?Q?YyCbvpYoVnkCmF+X6BVA93E3hg4CUjvhIausgTYfGfZEXQtSYdpjJaObJbk/?=
 =?us-ascii?Q?kVNg+T3gz1Oj+pvaRotKtvqDPQ6itOZodRRiDXFnPBxTKFyqXtNpRoZ0DUBh?=
 =?us-ascii?Q?jLA7LFAD7j8K3Qcrogb1AEYgFiP7XfIH5gyUGsmfFHYOUd2yni/s0yIBHGHX?=
 =?us-ascii?Q?KlZh12oTRSm9FC9hLiBBtz1OdFqm4d8IwZBYoO1yOzxS22mBYPUBlKC8tsNj?=
 =?us-ascii?Q?Na5kZ5DL9vDZJVeRcduAC3zNQU25IMDa+HqPR5ZvVnzFx/FhaO1O3Q7T7vv7?=
 =?us-ascii?Q?J3yBNxiK1v/FZvYZM+VEwrYSqsvu3L99qyjHEkIns3+3VeB8UECMwLY7OYYV?=
 =?us-ascii?Q?aPZLyuUQmUNUjyeQxYOvleEDKODHqUjvxdrj7T8feHSCr/Vz+zjcoAYmF04g?=
 =?us-ascii?Q?0ROp0O4bUIaoVMQ+iG1Eh0yulKuYsKgcV7oYaY6RFJ3rx8Kb6oGF0x75c9q8?=
 =?us-ascii?Q?tBT6ht/qH1ty2awAPqZwD/5FRyvswlbIBRQcBPwJhgD1uZfgBRRC/q+89ZbH?=
 =?us-ascii?Q?BTDfQMMcOfRcd/hS1VfIIMjw0SUxOFm6PS0jR/ihhFp+WJE0lW7wW4ObItfu?=
 =?us-ascii?Q?lxzVGkS91/ytegRBQsQLix+VN6AtfjrrsoEcCyB+eLaaEEG6Nt6K8sYoXraz?=
 =?us-ascii?Q?3SxKpg5RZ/8YqboosIn54d5zFfVWzYwXgQFA2gJpVkwg3SGtMhv6rdBx/NcN?=
 =?us-ascii?Q?ICWgeWroEBkTeghRE6GkasTbHYfaTSq174JkBnMbqvy3dhI6Y6iHhsCRyAYp?=
 =?us-ascii?Q?rWWYMD++no+6qTFDhB1e9g03oPllWjdwWz+ybrZg6iKTnEudB2eXSwJew01h?=
 =?us-ascii?Q?qfTQlrqPMfT5EVcKGKLYNjsrdURwXG2KA/Urq31c7fjsbx+WAVNnqzlllPqL?=
 =?us-ascii?Q?isFG3Br3VQbwcayGpgMeqNgJBOlayHsccYiDe1WmTkMPkiGqD22oYc43sgr+?=
 =?us-ascii?Q?1Wl91poAsYNxkr54SNhi/XSjmqE9v0nQeQKX7RquvRc/qqTFFI2cvonMzAXs?=
 =?us-ascii?Q?AjpnWl93pb+SXlUgFIGauGlguA+AlinBK5dN98+gv9CiCfotpRh1267itVG6?=
 =?us-ascii?Q?jRelrjMZDKZ0iBz0micpTYg3E0+b3G5U5mYEg8cWFLeX0lYhJZuK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99debba8-40dc-4377-10b0-08df3af572eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 04:29:57.9056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyebV3LhOQ9y7Bx7ThYa4mOfAP2PG4k4ajDGEf4Gv7Cx5EmXhhpWSqNpxMLpAF+M01u+JabTGvK+S/n/GMMRQ2zePmlmMel9NZJr9fSH0K4=
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
=0A=
My earlier reply in this thread had its tabs expanded by Outlook.=0A=
Please disregard that copy.=0A=
=0A=
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
-	struct smb_sid *owner_sid_ptr, *group_sid_ptr;=0A=
+	struct smb_sid *owner_sid_ptr =3D NULL, *group_sid_ptr =3D NULL;=0A=
 	struct smb_acl *dacl_ptr; /* no need for SACL ptr */=0A=
 	char *end_of_acl =3D ((char *)pntsd) + acl_len;=0A=
 	__u32 dacloffset;=0A=
@@ -842,12 +842,7 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
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
@@ -863,6 +858,12 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
 	pntsd->type =3D cpu_to_le16(DACL_PRESENT);=0A=
 =0A=
 	if (pntsd->osidoffset) {=0A=
+		if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd) ||=0A=
+		    le32_to_cpu(pntsd->osidoffset) >=3D acl_len)=0A=
+			return -EINVAL;=0A=
+=0A=
+		owner_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
+				le32_to_cpu(pntsd->osidoffset));=0A=
 		rc =3D parse_sid(owner_sid_ptr, end_of_acl);=0A=
 		if (rc) {=0A=
 			pr_err("%s: Error %d parsing Owner SID\n", __func__, rc);=0A=
@@ -878,6 +879,12 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
 	}=0A=
 =0A=
 	if (pntsd->gsidoffset) {=0A=
+		if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd) ||=0A=
+		    le32_to_cpu(pntsd->gsidoffset) >=3D acl_len)=0A=
+			return -EINVAL;=0A=
+=0A=
+		group_sid_ptr =3D (struct smb_sid *)((char *)pntsd +=0A=
+				le32_to_cpu(pntsd->gsidoffset));=0A=
 		rc =3D parse_sid(group_sid_ptr, end_of_acl);=0A=
 		if (rc) {=0A=
 			pr_err("%s: Error %d mapping Owner SID to gid\n",=0A=
@@ -899,6 +906,10 @@ int parse_sec_desc(struct user_namespace *user_ns, str=
uct smb_ntsd *pntsd,=0A=
 		pntsd->type |=3D cpu_to_le16(DACL_PROTECTED);=0A=
 =0A=
 	if (dacloffset) {=0A=
+		if (dacloffset < sizeof(struct smb_ntsd) || dacloffset >=3D acl_len)=0A=
+			return -EINVAL;=0A=
+=0A=
+		dacl_ptr =3D (struct smb_acl *)((char *)pntsd + dacloffset);=0A=
 		parse_dacl(user_ns, dacl_ptr, end_of_acl,=0A=
 			   owner_sid_ptr, group_sid_ptr, fattr);=0A=
 	}=0A=
-- =0A=
2.43.0=0A=
=0A=
