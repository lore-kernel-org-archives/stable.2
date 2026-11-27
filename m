Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.104.111.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771290;
	b=a3CvMrv7YWxxRFA5dXcDD/pP8G4spY1/XnodPCsCcNvVskLdK+xfBWdhAsrKyiK6FAfQ
	 tLNOnaKo3FFLmfjAz1IdWdN2REkCft7H7Ii4sJfCmlOLpsWWB8CSlOZRT0fypLY6m6OIy
	 x0AvUbeaS7LeM3nNToXThF0B0FGHBuY9dobxl1mMGkS9x3thch7B5fvWREJm59/rBvJGU
	 Ge1dC0PcT6qKwlVWCo1g/qO+WIRWaUSD1SQS++wmdBysj2qoc/OlFTYLyM0zbxI3zA1I7
	 OkhhmC7MybhirlA6DY8iDCF9pnm/VkWN+iaurWDwwinsD9f3RwkzSbrcPCAcpu1J5Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771290;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:DKIM-Signature:Received:
	 X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:msip_labels:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding:
	 X-SM-outgoing;
	bh=PPtIKqp5j9sJI1gUInXCnCFQMW0C4T7bBTkq3va+/MU=;
	b=Vp2fixPEzkUNHrAsPar1o6zjQthxap/cmGXJGdwRc/P9fGvEEhaDZAQbhmnJOwezgEyY
	 GNetS0fzVgKyvpzEoUKjvD23wcJ8JNK5WPCcEiX6cdGkR2NxDTOUsAaDk+e3pOd5h+hwt
	 dhcvc2rJG3dJqClKlyJ1Sf9deM0mGfQUm9+u2lJxKBx7KtE7/AoUKqywRB/um9nBpFAFx
	 Pd5Et69m7w1Q2lwgfCnZi55nUXWqtIBlZnUIvgFY/fM68+Kb3fk3FApToW0yczVCeNFks
	 BvZiGvAKmvsmskr4iIqPb7ff+jJFwCd8hUgI+/S0T4ewpO9BJGvdNlZQOQjLeIY0N0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rosenberger.com;
	spf=pass smtp.mailfrom=rosenberger.com;
	dkim=pass header.d=rosenberger.com header.i=@rosenberger.com header.a=rsa-sha256 header.s=mimecast20250212 header.b=ULbyjdmT;
	dkim=pass header.d=rosenberger.com header.i=@rosenberger.com header.a=rsa-sha256 header.s=mimecast20250212 header.b=DaDiF5h2;
	arc=none smtp.remote-ip=194.104.111.116
Received: from de-smtp-delivery-116.mimecast.com (de-smtp-delivery-116.mimecast.com [194.104.111.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43BB606A326
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D43BB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rosenberger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenberger.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosenberger.com header.i=@rosenberger.com header.a=rsa-sha256 header.s=mimecast20250212 header.b=ULbyjdmT;
	dkim=pass (1024-bit key) header.d=rosenberger.com header.i=@rosenberger.com header.a=rsa-sha256 header.s=mimecast20250212 header.b=DaDiF5h2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenberger.com;
	s=mimecast20250212; t=1795771279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPtIKqp5j9sJI1gUInXCnCFQMW0C4T7bBTkq3va+/MU=;
	b=ULbyjdmTd93ozPleQc+NAfTCdQ8U5pyTyb6PecHGPDAjAtF4gdXLTXPMtUahJ38xQJvnGk
	nYUcm7XN2FdY2DfYqy6bqQHQKz4C9xylyqrDo+0KDRW4zQ+oN0VsWRQnqrIVTR5QAc8q2+
	hHEvbQN8i4R8JnTW8O8lYTga5Y2VxbY=
Received: from rt21-61v.rosenberger.com
 (ltea-178-013-127-133.pools.arcor-ip.net [178.13.127.133]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id de-mta-34-aQqIDA5eOaSHBra_fCXTGQ-1; Fri,
 27 Nov 2026 09:21:17 +0000
X-MC-Unique: aQqIDA5eOaSHBra_fCXTGQ-1
X-Mimecast-MFC-AGG-ID: aQqIDA5eOaSHBra_fCXTGQ_1795771277
Received: from rt21-61v (localhost [127.0.0.1])
	by rt21-61v.rosenberger.com (Postfix) with SMTP id 4jbSb11PfDz4g8n
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:21:17 +0000 (UTC)
Received: from de-smtp-inbound-delivery-1.mimecast.com (de-smtp-delivery-1.mimecast.com [194.104.110.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by rt21-61v.rosenberger.com (Postfix) with ESMTPS
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenberger.com;
	s=mimecast20250212; t=1795771276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPtIKqp5j9sJI1gUInXCnCFQMW0C4T7bBTkq3va+/MU=;
	b=DaDiF5h2cBT2BDPUqhs3c5I+ZFTJaQkDBspXn+ZDl8ZH/69mmO+pbycv7dsJj9rs1ROI5t
	fN0idnnapkJPYwPOX+tsyZOx0iTOCZ1qxKUQ3HnJzhoUtKKMMCf84JRFiNIAo3ujxIFXTN
	h72aOoS8rqKNEc/yxVzM3kNX8l/uD80=
Received: from RT21-12P.rosenberger.local
 (ltea-178-013-127-130.pools.arcor-ip.net [178.13.127.130]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-134-iJ2-G3B-PVeswyf-mE6ZIw-4; Fri, 27 Nov 2026 09:21:13 +0000
X-MC-Unique: iJ2-G3B-PVeswyf-mE6ZIw-4
X-Mimecast-MFC-AGG-ID: iJ2-G3B-PVeswyf-mE6ZIw_1795771273
Received: from RT21-32V.rosenberger.local (10.206.32.32) by
 RT21-12P.rosenberger.local (10.206.32.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:21:06 +0100
Received: from FR6P281CU001.outbound.protection.outlook.com (40.93.78.20) by
 RT21-32V.rosenberger.local (10.206.32.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 10:21:06 +0100
Received: from FR4P281MB4840.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:146::7)
 by FR5P281MB5077.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 09:20:59 +0000
Received: from FR4P281MB4840.DEUP281.PROD.OUTLOOK.COM
 ([fe80::880b:63e1:7649:f879]) by FR4P281MB4840.DEUP281.PROD.OUTLOOK.COM
 ([fe80::880b:63e1:7649:f879%7]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 09:20:59 +0000
From: "Haberlander, Markus" <Markus.Haberlander@rosenberger.com>
To: Thomas Richard <thomas.richard@bootlin.com>, Andi Shyti
	<andi.shyti@kernel.org>
CC: Lee Jones <lee@kernel.org>, "mfd@lists.linux.dev" <mfd@lists.linux.dev>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] i2c: cgbc: Fetch the status of a write transfer
Thread-Topic: [PATCH] i2c: cgbc: Fetch the status of a write transfer
Thread-Index: AQHdflCdHfa0mnd/zkGtec0zAEzvWQ==
Date: Fri, 27 Nov 2026 09:20:59 +0000
Message-ID: <FR4P281MB4840894892BD79C05D844CEC84412@FR4P281MB4840.DEUP281.PROD.OUTLOOK.COM>
References: <20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com>
 <179568834099.302193.16315749597111506309.b4-review@b4>
 <awgwO98qx3zX4MaY@zenone.zhora.eu>
 <b0d32861-c123-4f4f-8bac-aa0e7e48c719@bootlin.com>
In-Reply-To: <b0d32861-c123-4f4f-8bac-aa0e7e48c719@bootlin.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-8859-1?Q?MSIP=5FLabel=5Fdc23a535-3dbe-411f-b447-26a71d90608f=5FEnab?=
 =?iso-8859-1?Q?led=3DTrue;MSIP=5FLabel=5Fdc23a535-3dbe-411f-b447-26a71d90?=
 =?iso-8859-1?Q?608f=5FSiteId=3De57e7749-9b21-4cf2-a972-bb95d4afd826;MSIP?=
 =?iso-8859-1?Q?=5FLabel=5Fdc23a535-3dbe-411f-b447-26a71d90608f=5FSetDate?=
 =?iso-8859-1?Q?=3D2026-11-27T09:20:58.832Z;MSIP=5FLabel=5Fdc23a535-3dbe-4?=
 =?iso-8859-1?Q?11f-b447-26a71d90608f=5FName=3D=F6ffentlich;MSIP=5FLabel?=
 =?iso-8859-1?Q?=5Fdc23a535-3dbe-411f-b447-26a71d90608f=5FContentBits=3D1;?=
 =?iso-8859-1?Q?MSIP=5FLabel=5Fdc23a535-3dbe-411f-b447-26a71d90608f=5FMeth?=
 =?iso-8859-1?Q?od=3DPrivileged;?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR4P281MB4840:EE_|FR5P281MB5077:EE_
x-ms-office365-filtering-correlation-id: 7c9e21c5-d8b1-4946-92e9-08df4c67bfc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|11063799006|18002099003|22082099003|10067099003|56012099006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|38070700021
x-microsoft-antispam-message-info: JPccDsYcyTjbbqGt9iopvSnvZCJTzHKOoi0cKq9QcxGFV3ST7etVW32mf02m2PMfRuBg/HUfZgL9dvLDLBQxsCOT7hUeCSkY9uM55Mr8TFonwtAAOyCuu58rExb2UK963q0GG/q61sZhYXPVs2RbOMzd4ihfYEVSSAMJVJNClSNgobyE2T6YrNnhBllVksjjwzpyCchZv4QMyXqJ3ea+PAA0ELr+QVDwI4/nyBm5/TvK5cN5S4y8NbTPYR/ZbjHcue/fguyEk0OzeBG2JM05Rm4Onhb06EejnQRSkJ3NPGhiyv5vR8IpO0vOqZ1VxwDU6CARC6rvVCxXbzWDWGaKZNFbItrvkzngm4A5FmjhI/Myf10hhVQ7wWlBPGTXrNlYEBZ6mgjggwh26Q/6iMBf2OEPdm3J4xQA+WjP2oCSyOwtq5w6mdQt1UEt4NNYgXEFUrVHu/319h0XflFeFjX3poeqoPVopOU2FHMZx+s7v3DRveGhXhhkMQhTyZW4MiIbh3l7i4O/3X6pkbWCHLXhj1Dd50mEL04PshAO4XtxXX+deGs2Maxnvuu/0t3bEcm9sFphc4mUGFuM1zWWrBDZBnDNPoRooOtZEwYlpJYjzCEjbdG/IE+9e1Bx3ZlPMlJQ4HzRr3eDb2qqurCixlxVzC0ucwY5eEV6OGZcQFXasbi3OEKudF/WLUIox0SjLA+ttx1dhbZ22+qXaT9IDbSEtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB4840.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(11063799006)(18002099003)(22082099003)(10067099003)(56012099006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(38070700021);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G6tXDUVn5b7v9hbHNgChaAJtYgleBVhVH91XpPH2UJ2/soE39bmguoAs0l?=
 =?iso-8859-1?Q?41nSLmgX5tiHXwaCj1fV/iObMyseUmQTh717Xt6YveR/KJiXYLMYhmCJSU?=
 =?iso-8859-1?Q?2BMDn2bxdpN3j5ZMhWFdH8FojcBEXlgABm3qR0VhxpIIZ+FQlpt7uQ3CM6?=
 =?iso-8859-1?Q?j34mtZ+5DYOahmjgYRdoTNSByBofgjBG+6Q+3a/VmlQ8uqAsMdUuktGanH?=
 =?iso-8859-1?Q?AciVYCjsqIohtVTs40aWA6CVvF7BqHXpuhRbtYwDX9FNxA48eSKaTsRRpt?=
 =?iso-8859-1?Q?FqjaDsS5QQSnD8fqDfBu/PCCtnSlLX3LKkdi/ZALOYbtvqSZ5n1lVqvHhE?=
 =?iso-8859-1?Q?Uf831pguZhMe0jc3Yi6a1GzoGNf6TuyA3eblPYymIPcZsmaMaArH4Sir2A?=
 =?iso-8859-1?Q?8MebMMfsmVJo60IF7epl9V26Nv1nSUpKrsVbzzXmn50nVxXJc5oA9putcd?=
 =?iso-8859-1?Q?reDz7SpioOl2wZfnirC0icltmITSHNNfutT06SP+5HTdploBqP9gRXDvNv?=
 =?iso-8859-1?Q?+h7BHzJYepdBH8iNgpfol5kFwWjdc1nP1j/ynTV0RsXCtWhNx+Rq7mZfSG?=
 =?iso-8859-1?Q?fh5WB6SaKqK3OJKPhD5zrrQXXpqbEGw1dlHD/d8jqJlEp+7NAgcxfQwQVJ?=
 =?iso-8859-1?Q?B45LOzPbzEiujfwYXburdtQ9PHegSeVr0tdu86atsG9Y029RWTJrLvw/TK?=
 =?iso-8859-1?Q?Fax/n8flfnE0aL9Z6SfsZaSsZ6eMsOfY7Uf9dJEjZPrN2oFpP6bCNmyix7?=
 =?iso-8859-1?Q?0EBSK9Ja9Xd9nr1g2JqDJN/C1Rgr36k2feZzt4Mit62GXs3QLCkIINVa3/?=
 =?iso-8859-1?Q?AKq7kBJt8gS3c673hG/U5pHVMX1xc32Qp6JCjdimrmWLD5tBEOgeTCqLmc?=
 =?iso-8859-1?Q?U1OYm1OD3zLCkHvPaP1RNcZ6NWOB5YsiZQ2PmaH9JBF1plr0rv/F7WgJbE?=
 =?iso-8859-1?Q?EjjaXXvOdmsMANGJmUJJwSxVxNm1HaG+iVq9bdKFhB+8U5pikuuo2rQ8Ov?=
 =?iso-8859-1?Q?7lxzuwD0TDcYpixZmmXaKqhK7OXVJ5n82+juv+1Mp2EKbJ//otMGxhZB7F?=
 =?iso-8859-1?Q?x2VmCbiQq1X67CFPHsl29+O+3VYGie2Jl1IETOil6JyvGNiZ0+o4LDZKIC?=
 =?iso-8859-1?Q?eGHupiB1Rxfujh/cXsQR1UZB6+Mo7sE2wVm/prUUV8wLAlVG8h5JHY8+eK?=
 =?iso-8859-1?Q?iIfJyPGJe8GBFU1T+PoDm4V4dyZ77Y4Cvjav6hDXgB9fYYKB/bM0RM6C/4?=
 =?iso-8859-1?Q?4qtfp+V/uLU5RvHFYacjxmKBo/TxA3VII0xXSbgS4VfSWPvwm+hEAunpLr?=
 =?iso-8859-1?Q?wdZdHd+lMZM+9DLIrd9RVzgmBagcyQlBTWWn+fSj2LqIb7qU94zvwNOlRl?=
 =?iso-8859-1?Q?wuH22btIM2rriVX20WihyfNfXOXWktvPhmzoJ0u1xxzoxFneAugLiN4ipl?=
 =?iso-8859-1?Q?iLZs2TiYHXiO/BB1omUmbMv7qrJe4a+fvBXPmEMg2Ygrh9Ntg+4JIH2VmE?=
 =?iso-8859-1?Q?pZFNCa69oGu+0XtfW0iTB0dAwkkLnudmghpxZdHLI23fQaFsH1htIU9aIK?=
 =?iso-8859-1?Q?fHiA/56ZARsXNdle+P893PmxXtOnFOAveP4CbF+eTxJ+R4vAHCf0fZuT2d?=
 =?iso-8859-1?Q?iG2qVQRt5WzmrLFW1Jpl9iSRSAV6j+dCUEEoD/4MAYi2+Bal3YHgW4Av6O?=
 =?iso-8859-1?Q?clDpFe/cs38WYb/prohVx81Af/TXwVnNhwHUj+eDMTUn+kAYABsRtqO7Xj?=
 =?iso-8859-1?Q?IR4aMOBfTUdcd1x9j4/JdOBXKQLMfPghVaWoaiCHVD1l6lGwim4dhaw5LA?=
 =?iso-8859-1?Q?LHsZ/m3crIAhPvJGwKXUXeKnNtz7XPU=3D?=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J2Ra8PhMBa7c9VsbtR1BOc+YeXLXrlMUPvlry/+izMSwCQtW3Qcs3KSuMI6RvhDza40S3+MnAX3KHiIr5jvlDGZyXurJpNhQytgh8vpniXjfBslrpY+XfBh+WJpxVgLvTcA5HwOUqJTKOV7wW5v9aNeM+41nevmOyRLRqaVsE5OcDVE2fGfp+pu90nZMlvzFxMLOGKMQmj8QffIG0l0RxcVC4fOi8/pukib03xUD86vbKWPfYhM3s5DgHAYxS5ny2ODocSxnGyU/zY3aGZ7Efj5I5W7i4D9irtBqKMunJIQ4KJEHC49YIJwqwLl3upPfcqUTVkyZxjmNbfdmX59HyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB4840.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9e21c5-d8b1-4946-92e9-08df4c67bfc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 09:20:59.2360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e57e7749-9b21-4cf2-a972-bb95d4afd826
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjeZQFXcWWucWBuoXCNu+tapK64DyZiUMA2IgDAC8s/+6xfjOEGIjSVFrCGaKX6wsP6RGFq2TJkTxltnWGZwPP2SEfeLjev1x+0eb6rfVkOEfp7nvVCMmQy41HySl/2T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB5077
X-OriginatorOrg: rosenberger.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TchxXitSEyVbT1XjcbQ0hw4ZHScquYjnrHBj2ZXMZ9A_1795771273
X-Mimecast-Originator: rosenberger.com
Content-Language: de-DE
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-SM-outgoing: yes

Hi Thomas, Andi,

On 11/26/26 9:18 PM, Thomas Richard wrote:
> If I'm not mistaken, USEC_PER_SEC is only used if master_xfer returns
> -EGAIN (arbitration loss), else __i2c_transfer() directly returns so no
> 1s timeout. And we never return -EAGAIN.
>
> So why should we wait 1s?

Thanks for looking into this! I think Andi means the one-second loop in
cgbc_i2c_xfer(). Before my patch, when the controller was still busy
with a write, the next call returned -EBUSY and that loop simply tried
again, for up to a second.

My patch now waits only 2 * read_maxtime_us for a write to finish. That
is enough for the transfer itself. But if a device stretches the clock,
the controller might stay busy for longer, and the write would fail
where it used to succeed. That's why USEC_PER_SEC sounds like the safer
choice to me. I'm happy with either, though - you know this hardware
much better than I do.

If you go with USEC_PER_SEC, could you simply change the timeout when
picking up the patch? I can also send an updated patch on top of your
series, tested on our conga-PA7, if you prefer that.

And could you keep it right after 2/10, with its Fixes and Cc: stable
tags? Then both can go to stable together.

Thanks,
Markus
The information contained in this message is confidential or protected by l=
aw. If you are not the intended recipient, please contact the sender and de=
lete this message. Any unauthorised copying of this message or unauthorised=
 distribution of the information contained herein is prohibited.
Diese E-Mail enth=E4lt vertrauliche oder rechtlich gesch=FCtzte Information=
en. Wenn Sie nicht der beabsichtigte Empf=E4nger sind, informieren Sie bitt=
e sofort den Absender und l=F6schen Sie diese E-Mail. Das unbefugte Kopiere=
n dieser E-Mail oder die unbefugte Weitergabe der enthaltenen Informationen=
 ist nicht gestattet.

Data security advice: Please be aware, that data exchange via Internet or E=
-Mail is not 100% safe. Therefore, please handle sensitive or confidential =
(bank) data with care. Please take note, that Rosenberger is not asking you=
 for bank data or providing you such data via E-Mail, in principle. In case=
 of deviations or questions please contact us immediately.

Rosenberger Hochfrequenztechnik GmbH & Co. KG, Registergericht: Amtsgericht=
 Traunstein, HRA 5566
Pers=F6nlich haftender Gesellschafter: Rosenberger Hochfrequenztechnik GmbH=
, Registergericht: Amtsgericht Traunstein, HRB 4405
Gesch=E4ftsf=FChrer: Josef Rottenaicher, Jochen Ehrenberg, Hauke Sch=FCtt

Please consider our data policy: https://www.rosenberger.com/data-policy

