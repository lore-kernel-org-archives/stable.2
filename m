Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.104.111.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879313;
	b=ojiveOiJLq+lwJGKQiUXdHJuyYJX/9NDMEYAN1UjaZUIm1KXvJWvXFfAfBm2lp3dDUHK
	 EsbCZlmfGPwGFL/sH6YWO52Oi/AdjDGI1bsU99r3ebTvRXHNlaujhZAFI0+QvregmJ7GW
	 yIcneLR6zHPdJ44hdx65Uak9+ZjF1pqVs5FW2AZBaOtegu0QVgtTOV1sSIXrPM21F6Dc9
	 YehXlg/Nj4YfHfQaSgarUw5yJx1rLS1wPODTTrRbroXUMv6IY+23X2BdXfzEmxYt1R/TD
	 N7HQierk89pO3Ovf9DYcqoKZ9+0sCrfC2M04lJCLJGxrg3Hm/OKY29aBAt0w/OcLA4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879313;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	bh=O5jziIrb5OgGNmTSQFkCrPShLqqVIUx1FYTnQu96EX4=;
	b=f6bHArDt9lnkscJMOiq6FVCV/ucW+1qXuchzCM4rFxC9NHfZ+jvW7Ehfp0gXgf0zGbLQ
	 enofpRbXduH7xM5cWaZ2mPcRUt6DydXpoea6JstRGMrKMKYvFywKjS09bpztus5SSrlH4
	 c7qMA+TO07Y+cH4ZefkZMNeX5MrgH+83USCwRfUqhG7ThSHEQqsE8VHooWYspaOl3UVA3
	 7JRxlNb5gkCk5BjtWoewofoTHjTYFPr8oj+6XYQmBvdvVX4GupXip9FFv6D+vTx0xRSuw
	 cRyPI7kUE/Rlq+WP793nEvK60lgcgIdEf1BVBSlqHrHAf8AjRVhJ8bmQpoMZYmaEMVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sparebank1.no;
	spf=pass smtp.mailfrom=sparebank1.no;
	dkim=pass header.d=sparebank1.no header.i=@sparebank1.no header.a=rsa-sha256 header.s=mimecast header.b=pvge7EL0;
	arc=none smtp.remote-ip=194.104.111.116
Received: from de-smtp-delivery-116.mimecast.com (de-smtp-delivery-116.mimecast.com [194.104.111.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75C7606CEA4
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 11:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A75C7606CEA4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sparebank1.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sparebank1.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sparebank1.no header.i=@sparebank1.no header.a=rsa-sha256 header.s=mimecast header.b=pvge7EL0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sparebank1.no;
	s=mimecast; t=1793879304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O5jziIrb5OgGNmTSQFkCrPShLqqVIUx1FYTnQu96EX4=;
	b=pvge7EL0xC1xYmHmHNMm/LQTSIXRA+LktEl8oxqcazAnsfo3TULXBIoaLXCfoTzcM9n3zY
	D2q11pnLKON3heEQfKIicB96QmVbvmyftS8zgYwXORpq1DS8xDTr/H/QjPbv0oh2GU0x90
	2HL0q1TsegQ4YBFOQ6DoQCsEq+fR9hHpICUpCpvndl/gW/DyxoF5cQB2G7QhRsu+CfSybc
	5ZPX9zHqHt9+E30CZWjHio6+4mJoXSDziTNWzBw6eZA3mOc+3fQrYwxitE1kP7yHOvPk41
	Seu3qcm1eMy4OAks7SUxcvfHrogHiS4J4/BFBR+SofBimfXyapYAtKEhbE1BDw==
Received: from SVZP279CU002.outbound.protection.outlook.com
 (mail-norwaywestazon11010019.outbound.protection.outlook.com
 [52.101.180.19]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-12-a19NB5rsPHW0iwJIVtbwGA-1; Thu, 05 Nov 2026 12:48:20 +0100
X-MC-Unique: a19NB5rsPHW0iwJIVtbwGA-1
X-Mimecast-MFC-AGG-ID: a19NB5rsPHW0iwJIVtbwGA_1793879300
Received: from OLAP279MB0086.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:7::13) by
 SV0P279MB0579.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:22::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.9; Thu, 5 Nov 2026 11:48:16 +0000
Received: from OLAP279MB0086.NORP279.PROD.OUTLOOK.COM
 ([fe80::83a:28d3:9a5f:2335]) by OLAP279MB0086.NORP279.PROD.OUTLOOK.COM
 ([fe80::83a:28d3:9a5f:2335%7]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 11:48:16 +0000
From: Kjell Arne Rekaa <kjell.arne.rekaa@sparebank1.no>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?iso-8859-1?Q?Tales_A=2E_Mendon=E7a?= <talesam@gmail.com>, Matthew Brost
	<matthew.brost@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
Subject: [stable request] drm/xe: Implement Wa_22016122933 (d5b0bf3f37f1) for
 7.2.y and 7.3.y
Thread-Topic: [stable request] drm/xe: Implement Wa_22016122933 (d5b0bf3f37f1)
 for 7.2.y and 7.3.y
Thread-Index: AQHdbQtS+BsTgw/SbUGIN1Jc67rLzQ==
Date: Thu, 5 Nov 2026 11:48:16 +0000
Message-ID: <OLAP279MB00864A857672EED0E6BF554997772@OLAP279MB0086.NORP279.PROD.OUTLOOK.COM>
Accept-Language: nb-NO, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_604121a6-36f3-4678-bd5a-1ffd39207b5b_Enabled=True;MSIP_Label_604121a6-36f3-4678-bd5a-1ffd39207b5b_SiteId=491e8cc4-2204-4312-8565-17f85046df01;MSIP_Label_604121a6-36f3-4678-bd5a-1ffd39207b5b_SetDate=2026-11-05T11:48:15.569Z;MSIP_Label_604121a6-36f3-4678-bd5a-1ffd39207b5b_Name=Intern
 -
 Alliansen;MSIP_Label_604121a6-36f3-4678-bd5a-1ffd39207b5b_ContentBits=1;MSIP_Label_604121a6-36f3-4678-bd5a-1ffd39207b5b_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OLAP279MB0086:EE_|SV0P279MB0579:EE_
x-ms-office365-filtering-correlation-id: 1a32b4df-b9ae-422e-f567-08df3b32ade6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|11063799006|56012099006|261021123027099003|261022113327099003|261026121527099003|10067099003|18002099003
x-microsoft-antispam-message-info: a2QjpHGSleylkT115J4QgWlmemVtAWHzbX0TyAr1VBd5dpMPRIx4uRhPrkVdGUfQ1nInyGA5rT6Sh9Z3IeaIpcLLg08iBBsLspAwkMNmyV0zRWXRvDYlfRJpEcXWACsg5JBXNuyqqt+HReSPkbq7zXWHGdZ6j8q9e/5P9WFZaZSjOt5Jgm7QjS+EFRb6+hfoZV97Z8r4KsNqQqAS2htRtdsk4s1HD1M2UkDCxaklmT58dII2xBzQlkh5wpienRWfX0/9NERpcrm/0nUqmbJesTw38JfcDPr0sExEjITmVMRad2MFEdh5GGxMLGcBUSg4/GuCSYMyoT7sOL+q4uvjBX0HiD4HAuGECQkLpojRjjmtTT065b4ErBkP2Ab7/gc2w/mAsqiKvtS3Ua6NZjmAEf6/fpImu31V+zQ11XFH/86LQtDZmtMvdGJKtsqGlalek+uM7ADSyYy1MNaPICN1ja61vbbbeSjlCiCfR+QpvJhVVUhzmZeBe7i4lKv0SeHFlDXtlHoWeWGGUfYMwFtiGNsCWeQvB22rq0PaVVw2DzWLt/SvGo9l/8wkBX+6d0ogSgniZ0C+Vlg1IZ/5yBfF9aN3SaDQxuuI4jC+AyillUV5CsCbipPIjxKxlstQ90abHCBjW2V+CNukKnkjE7DSxHMIbDsa958hOZIcmL3noxzjS+JvmBFDPBHiKU9NZ9iNU8hM7PY2n6oCj9fhibMogmdMVeBxkPzHTA6wb5L/sAw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0086.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(11063799006)(56012099006)(261021123027099003)(261022113327099003)(261026121527099003)(10067099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JJPGUzHrb+q9ARq29IDw8j7gJUEaFaJTry0UcwsIKs1WgRSG9R2VVjbpAg?=
 =?iso-8859-1?Q?MM+TLPimDs1RJ4xy8X2TVwJ1OU4dt2eUvP4gTgODHFZ6snuk4SXRrB2H9P?=
 =?iso-8859-1?Q?FNKx7KHo8wH7p9dyu4opdxYTO8QIVX78rrg/KFEqjo6iccMAGHNnOZGi3D?=
 =?iso-8859-1?Q?awm3QD8ni4M8FFyHKpkO7jXln0LlF7YeQ/m0SA291PVftT8bxRpy7JjvkX?=
 =?iso-8859-1?Q?QGPOmlyxWJulDL86XcMGrLJ5f4daoCpOqNGipQLYTb3RbVhSvj66JXixAN?=
 =?iso-8859-1?Q?+0+5OM4qBejYwsFHZFvWuGyVoqV2ChfCF7Y09j3LNI6QNyrWtI0Ya76ZDQ?=
 =?iso-8859-1?Q?7pjSrQb8tnDLgfk9GzdkayfzWf5/6pFyEDxJg1FmayfVFLI7Zo0UGwRmAM?=
 =?iso-8859-1?Q?OaxqT8yToTvHZW892bFV+qTL6ylLOa6NDaMFIF8j9cCilc06M9/hD2vvQ+?=
 =?iso-8859-1?Q?GiPJi9g5GpmNKnv/PZ/IXgQO32XUMRg5EoUz2VBRVC0o2Y/eGB/aZ+2QQn?=
 =?iso-8859-1?Q?87KxxodevSk4EKPLymwfkSn+ZvPM2osb7pZoH5a/MES78/z39zDDAydeoW?=
 =?iso-8859-1?Q?gJyYucH+SXZJYF1hwwgmCwoS7Pod0DTqwA+C+fo91p5Ox2Ge4/j8E4ph9H?=
 =?iso-8859-1?Q?umLbFtyU7oVrwembQGGcQ69CpoLnGcgiOUlreJZjM8KRkPDGNUu0Xcu2pv?=
 =?iso-8859-1?Q?JUCqWEFGw3R4DVR8yhYLq9F70BlduO4yTsd97vd0thRzXymT0SLQ4l5PhJ?=
 =?iso-8859-1?Q?xeSKUP3XSFHObNwWarzVtBkMcTCkMLip7TqZkwGK5PrDk5TcpF3s7xYf8d?=
 =?iso-8859-1?Q?j/AXKbCBg0oI4//NfGhBP5ZXfdQTBf/oUUV4NahdqmKyWNUhQnxBQzukUd?=
 =?iso-8859-1?Q?RPoRDWDH2KY1pFjgNrO6YpiwrJKvvJKIVxsUPZRltrbYjKllzFcViBLFe0?=
 =?iso-8859-1?Q?8ykmb4Y8svGuhlz9iz8Wf1SX6ol0rOiUmORT1wGLlsO5qGtaPlYkeHcr9X?=
 =?iso-8859-1?Q?lPkzGNHY8j1aW88bwTBk0iNmbvij2Xw6wh4biclUtFCxDGTcH3+TuBXYl1?=
 =?iso-8859-1?Q?ABTzIeAl5xwhgOuqIkCBEeegRnebKVgPLJEJ7tuCTCuStREud46oDgboPx?=
 =?iso-8859-1?Q?I1CiuTCHP610R6ww4ciUP1SYUGO+3hpguSElbEmtpljyciKRoyPorqROG9?=
 =?iso-8859-1?Q?2wO3fToH5z06ej15OzVXF09b1DECtUEe7rZVqG19ZYGxLafwmaSpJ9RMio?=
 =?iso-8859-1?Q?vSZ9VKXUHzWok39M+fGmCi+IKqfX4vLIVasAJa9AkMR3gr4I3YTKTA//G7?=
 =?iso-8859-1?Q?jaj4AfJEnhBwybkWsY5Tm5njVYIe6g4yiNiSleWIJR7iEd7IYoFmyPwOdo?=
 =?iso-8859-1?Q?LBSa5BQ0qn2hlPC7loVXPYTk7BH7J9YJSzlwQ5EHcXsCWWxkVJdrFPgRTM?=
 =?iso-8859-1?Q?Apxx40OXF2SKPYuQ/0zrEMwQSpIB+8vWUx4oQcQpTiJY0ZA5toMARabCr6?=
 =?iso-8859-1?Q?3u8ppQuw4C/+Dm+uwYm7a+R2NQkcsEmtpqYpwr6jKg315d5pf8JJF/16hw?=
 =?iso-8859-1?Q?195P+16glbhcuRbSCobdZmFprxwtzJkxC7UoPqmzd64i7uJUO82TeWxMgJ?=
 =?iso-8859-1?Q?LgJQC+/xwCqZjHqfaBDwGK7NZMllLMhOOrb5gl01fMJyDZalm/Glbw0lXD?=
 =?iso-8859-1?Q?fWohux6uUB5QUD0s17QpDP8WEt5km6fhS0FGQ5oX8CyMLUcO+TEO8Zb5Hw?=
 =?iso-8859-1?Q?rDUZD5k4taGeAsf1YdSk9T+z7IGuiKVVKpwd9z3YeZNqfzUiFEUbF8U4Nx?=
 =?iso-8859-1?Q?bdezwrilna015+L5LP2vj4jAqq/j43A=3D?=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1uoqYx51xGyZkaLSzmJmksW1S5Y/fVEkj6wCCtypXrAGhk4Sd5bty+/1GYzYw4x+nL7u24o3ZNYdtRQdVi5Bb1gY3m+vpU3DsFVQFZoK8LsDc6/FIGuEsbF90o3iyStaPrbyCCDEPZsYF5hLxckr12MT6SIF8AafcLf86GXwhFxgmlSoq6COYg2nFF0AnnLGiFK8oZR14aCCXuNq1DADDXPwINsAEtm0UXsgayYwMj1x1rAx5xswU+CZsS1BYelEYEt/SkxazYmDlT+D+n2TTdosABmnolsnF2XQL7uWPnvovK0upxDYW56Dp0d3U6MNNFd98Gkas9r56H4d2Dwjkg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kdRRb6k5yzpfLGBtKr07GPzGoTwio7GVmbo0zqXtvTNNPcItxsR2vJGi3JJrOM0ouaYQLIVkvrENDKBWNx9Yy3DVfOFRp0UZW4Q4vNspiauHJS6ifCxMM7TuSiWegZgJYyGkL3g7j0xClgmpOf5N76rNq5AxY/AAOyPsZKxWg+/vzCtPBC+Y9M49S+Cg7V5WbFEHBRAILdeQNpFGZVWoeKwas6P/IoYCxRMKdEJXIi4C/MIKJk2eS4N4WnKh0PzT0/PkSV1nFpDlRpkOkSe2ZYf6qRD8FGNDtU9Dlv62iyZgFLvXhVbcyzF3HpcIisVcwKYO9X0TfPaIeWGh/kG7rZ+SzegbQ+v2v+7oesGWFw90YnVkRQFzsYGjpkXItoK7d5HMibVaekdzWEu3QctVU7Q61UZVpqsoLRrk4fE7yHjjzcXbaB3X/9MAtOonTL0oDR/95ZfWJAVqlNlaOlo8WCRTWtKSz/8HjtceEnNl5x87U2izGJenc91bwWPKk8+QSIxZ3PBEW+om1M5rSIapfc3RNAO70DM04uWoLzgLieGZtwdmHCE5eGA0zQu+1zuJRGcZS28ug38vwG3xqsgZuX4jnlAfL69AKz8YPisKR4ZgJn7C69nSRItBJEvqVrTKTUWhL93W1lmtE/PMmpBKDw==
X-OriginatorOrg: sparebank1.no
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0086.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a32b4df-b9ae-422e-f567-08df3b32ade6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 11:48:16.0559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 491e8cc4-2204-4312-8565-17f85046df01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45k8kBNrFNRHNTGmMbEPGtCY5nQNkdf26i+PShphHZvzPa+P4r1ncjT4Gnna+Z7gUzvKyNyHtcLYCvahrVrcwwG+7n951b9PPMdkXDB2tB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SV0P279MB0579
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qc6DETNiXrBjFI6PG1LjMpRs8AGr5wRC59PQLCcef80_1793879300
X-Mimecast-Originator: sparebank1.no
Content-Language: nb-NO
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0Aplease consider backporting the following upstream commit to the 7=
.2.y and 7.3.y stable trees:=0A=0Ad5b0bf3f37f1 ("drm/xe: Implement Wa_22016=
122933")=0A=0AOn Meteor Lake/Arrow Lake with a standalone media GT, the CPU=
 reads a stale cached view of the GuC G2H CTB, so TLB invalidation acks arr=
ive about 2.3 seconds late. The fence timeout fires first ("TLB invalidatio=
n fence timeout, seqno=3DN recv=3DN-1"), and the desktop freezes for a coup=
le of seconds each time. i915 has carried this workaround for a long time, =
but xe never inherited it, so users who move from i915 to xe on these machi=
nes get a regression.=0A=0AWe run a fleet of HP ZBook 8 G1i laptops (Arrow =
Lake-P, PCI ID 8086:7d51) on Fedora 44 with kernel 7.2.x and xe. Every one =
of them logs these timeouts several times a day, and users report short fre=
ezes where the mouse pointer stops. The commit message also describes platf=
orm freezes on an affected ARL machine that went away with the workaround. =
We see hard freezes on the same model and hope the workaround fixes those a=
s well. We have also just started provisioning the ZBook 8 G2i, which is ot=
herwise the same model. It is too early to tell whether it has the same pro=
blem.=0A=0AThe commit applies cleanly on both v7.2 and v7.3 and has no depe=
ndencies. It is a hardware workaround scoped to media version 13.00, so oth=
er platforms are not affected.=0A=0AThanks,=0AKjell Arne Rekaa=0ATeam Linux=
, SpareBank 1 Utvikling=0A

