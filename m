Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792543096;
	b=lfVCE/hBpQubcZP8qWRpDegMlNVsgr04oyWuIEAjTUjiThITlY67z6szj7jVYaNHNpDE
	 vmma7zhiRn+gidwOmGT+zkROCFmpYzQtRJR1l6rVGLxasJNGiM1+QyG48KsgQyY3XwnZl
	 Rm05JPJxgLs+5H3L/2Mk62ko1jkzLy/ycpiyMhvc1iS7KoJlbHE+qJRMuUoue87sk1/L3
	 ouhzSpFXfSzPiBKMy4/Du/Q/P+YvL3Dl7MymkP2yVnmXKIPImOj3TSEkGI35jJV5UjnQn
	 7UBFF1CH4jWbSA9mxunuzoxlOxbrrk1PJWXkUQY8ZAxEWRgZLwWxL67KfjwK/CslyMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543096;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:Received:DKIM-Signature:Received:Received:
	 X-SNPS-Relay:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=At4sjfEDSFaIgPDTxt0YSdrr2gBRPnOx44OqAo/wp3o=;
	b=c/6UC4eUwHHsD7AcRadPI1/6UW7WRAv16xgHelEbdGkRceu50G+dQ/xOuk34ns73Q3b0
	 tTFsFqKNxPmqrrYGREk2EQ6mDSyTPJot19qOLM0N38ddCWMkwGu4EqIK2CjDxrzXZ6K6u
	 2oYTOTBTiyNx4htJO2Ob+pqDFjLYrzo0YU+khh7uwBWlCvdAne8O5/4Rz9LHH3Hc1hkR8
	 2A9PuIDUak65ziiXpP+p8HTzN0wzsMpxGKKnXF5s0JEEC6sbaG6mxhzjqxJjyr9VjFbo2
	 GWJNtmMC1VcFrlShvNRxdnDCY//IeU5Kyz/7sEA4Q9P7BD1FC2oqnln6DuZux6x8jLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=ffUBxZyZ;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b="k/XvZoqH";
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IawpDhjn;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519C606A31B;
	Wed, 21 Oct 2026 00:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1519C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=ffUBxZyZ;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=k/XvZoqH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IawpDhjn
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KKvpLS2052420;
	Tue, 20 Oct 2026 17:38:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=At4sjfEDSFaIgPDTxt0YSdrr2gBRPnOx44OqAo/wp3o=; b=ffUBxZyZqHfb
	2WU9JSkIPP01LdU0aKNHcZvYN7WlbnKmQ5HmFzNv+e8qAXIhb+ltAKMHoum8Zsgi
	OlOPW8gVGL7yfzx6lGACjYq8Xv89TbMSPAilKbQRm2aji/ZerLmcuzWNJny6UBwu
	0Vvrs3rFrGQhvuHZ/7TnFmTZ9Ef68B9ERAkwMN6TaAx5bfsC88eBOHY/TVL8lrhR
	CuXU9XmCGaPAHJ1lFKc0gYkq+Hi0WRIA49Mhb//ynV2yrG6pOlCA8KuD1rum1+7d
	9hPbrcw3pVC5/oqmcS8HP4Aasa5BEL3tCvM6AYLx6GUf3cYskiITWas/KEkkUOWM
	mWMJhVIclQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4hdw6v8ew1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1792543087; bh=4VO3xOFxomSYl13LvIpHMlSe45ftxI9qonoBJJoOBcs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=k/XvZoqHNV4HVbrdH0OX7NVq8jFY7j2H2xvnTyVwuA2qylt9C9bYpFdluu2C2wuvH
	 Q/2rF9VUfw7wRTkgIVnzJo2k3TZZjCT0O2uPzCqR35MShTV7PX7ADEcU1t7v0CKrh6
	 qjY42khOMsmOLWWFQ5N4PZ6W6Fmdj6zyS9iYE5tsE+eCjY8OwL+kN1m5WOHZUgudWI
	 MQZ8mz0CTtVGED47pGIBziYSMbVUTWjrz6r/rF+sVPUICigfZsQ6NHblWBmJEjQJCy
	 GANZn9uACjd5gGOx357bHAEKwzYbFLrGWz15ZWHKwakOM5mZfmpsxp/r0aLZij3VB2
	 7SWIMRYRMnVYg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F39C8401C7;
	Wed, 21 Oct 2026 00:38:06 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 74194A05AB;
	Wed, 21 Oct 2026 00:38:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IawpDhjn;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00101.outbound.protection.outlook.com [40.93.14.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 18E43401A6;
	Wed, 21 Oct 2026 00:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNav3v6V9ROFCKRB8z6GJVSoBCKZAM5/qSyz5aULdIk3RdC3TRKksCRtw3OPhu+/v8Axweo+LaWOLYH6R5+slHL7UJYhrKC0TYQh2FXTN3W1239mWRym2EZlfHAz8YDgDkwRy75PRGjIBF4zQBGneAtg06aOJiOGHnxq3RTQxlwSjlLKtoBu5qBiic7Va8MZSWNvp5xWSf7lkzgoZRIDOj2XJhaCKA9gGUyhhL+uYwKrAVThbGyPLQSGl1EyY9uX8yq3/BzrbGTWRsrM/7s8HNiKUDXj1xOjjXbruSNE2bt9AXEmD4DRZznSpPwZzfdGKVtSsxgAejDeFYZUx447iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At4sjfEDSFaIgPDTxt0YSdrr2gBRPnOx44OqAo/wp3o=;
 b=SWAlxbgSGQ7HxVIoFtAc0zhcTVaREPVIrV2srHmo009mDzVQCkbNx8n9hHZUfl9LOFQ49eUEEyGz46kEkSLRtzShQZ5O2dmDYyoB+50VqOOorXmi5iwr5DsfdUMYaCtsu3ZLU/HMp6zbhMEqzAIJPzHdTG/K+W94pNfob3sqxkNMIyY8Uf4/bRTF6BG89iAwgA/HCCslIP5iUpLDkvlIvr07qBvUgfcWOSfnTMGjy+JTn0iCvOrAkvBAoGHcnzH4ktow1Ysmy53ugGRJdlycBoGlIR6HGxElboqVvFRm6CAm9sE7IoA34FSEVlLxYy1HzPeG/l9gSagelvWjaMfcBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At4sjfEDSFaIgPDTxt0YSdrr2gBRPnOx44OqAo/wp3o=;
 b=IawpDhjnAQgV8tFXqNGJQ8uNGprxZlMU7y52CMIRQfZR56FoPcCMIB1Pb+Mpv7KJ3P+zwFuqboLfeh59So9397hs6R2NIuFf3JDqHyXwQE3Y82KFYKPOeXP52LqIZK2ivkLtz7aRrNZgq4+KO5Iv2+dr9yAcaB8RIhv3wmoAdks=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 00:38:02 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 00:38:02 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH 3/7] usb: dwc3: gadget: Clear delayed stop on End Transfer
 completion
Thread-Topic: [PATCH 3/7] usb: dwc3: gadget: Clear delayed stop on End
 Transfer completion
Thread-Index: AQHdYPRtezAjg/r54EKIF4w1vlvw6w==
Date: Wed, 21 Oct 2026 00:38:02 +0000
Message-ID:
 <c28a9660f7b6bfa626077ddcfbadd50e6b503f86.1792542945.git.Thinh.Nguyen@synopsys.com>
References: <cover.1792542945.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1792542945.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CY8PR12MB7433:EE_
x-ms-office365-filtering-correlation-id: 036d7ff2-ca28-4c2b-2754-08df2f0b9067
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|5023799004|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 RUklPQc7uwvxAhg2Ls1b5zpDAELWXd2M3XzLYJjuTfzZj4DHBls2tpjsgotijcbGX6j69B6pC48kHHWTMWQPI0SfG1Pdu9Vi5nWyvLrUhga5+f1xZ787k1pH1JBgM1BqK1TcmsmY0inkI54rquVqo24HfC0V606N0XDii9D8WNvkTAvEm/OWcZDqG3kUO42Q+Vk9kw60F8P8jbK6DQqm/Kbz/HXu9kzieTzcrxE2cZ2CSRWAiLJ7/SBbxktx8C8/E7bydkx8sjZR2iMXLqRmseTBTb4ihyYv+ldnwmWbI3Eu5qPuHfh9LvntE0p3VGiRVUIzX8fi3JvsoFe7lIOmg6vO3RvMs8cMqUpqk1XccWHMpa2pKYzBhK3VeIoR99crm7sTEDJiVmRBx+hLtfmDuKswZp5uvMzjIvCY272dfA3Q3ut5aPcqXIy2Mr+Fc8ajyBnsySFurWwCunPzLJcqcwanl1D0mlNqYXbaksPZs+InzG9AnoubO6quTDPx0tpiy1eayAVjYUMGnKUQxORU73qdDR8Fgzne2hB5L9GM6StxrEJV8tQY/9BPcMiaMwzKkEUmr/5oCe/VFSfZUwcXOGJWl5w5NskuDT72g/oqNad9f3NLGp+43tS76PBxQSb86ne/gmqAK6Wbd/j9lJR8FpoVgARWjJviSUggZpQ5H8TXqz/MrVSk5mpRddCn6mtGaHruwElhWNkMR1Fgvo1RepwTCSBAEA0+wkQ3QhO1OwM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(5023799004)(11063799006)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Zg41Bn00XME5IJbn/rbmC/1ujbI0LKbNPtPZli5LvKtDK6Xwd9yr6m+v8o?=
 =?iso-8859-1?Q?nDcVDC/GFPI+UF8xsKgGS+tPc6Iv36ygZGnUoIbYkMI5EoHs8SESAI4uTn?=
 =?iso-8859-1?Q?GcUK4FvwOUW/OXqlyhuovZdXYNCzueBn5YFLJ3EgHL+XRTejctH8BYzQ7H?=
 =?iso-8859-1?Q?0QyjbE8e83X//EBEp0kGmlLqE2XR9qgsHbZam3Y98ELKsXyyiDnGRhMcH/?=
 =?iso-8859-1?Q?+rhB3inRQN+mNC4y+1hnb+iHyxUzCNlqr1DALpckXzuSAznl8zPUCizvuX?=
 =?iso-8859-1?Q?rTMLgLENOin2jF5dhOqaR4ofzoLlgsE7MxsomM06vpdNmoCnsL3gAzZCpd?=
 =?iso-8859-1?Q?UlZllNBtVbSBZbV4Sf0xu4DLbjlr+rrLxNeW2uRXYIucdqaPZEM5IgVepv?=
 =?iso-8859-1?Q?eHTU5AU/Pw6bU1hajyYFU0PLJ79hvIDv3aKsgaGR10nU8DQUkK7XRvLIl1?=
 =?iso-8859-1?Q?Mq5h8AEoDpxV6ET4ESC9RBxvchjvEk1cVBtKqIz8LuLsKAZB4Zrj+NL/4J?=
 =?iso-8859-1?Q?YJs17PBWTs7xvlyDLtLVvAp82qYS6NtiLfP4Q+fjOEQmn6Jnu9866SDwXw?=
 =?iso-8859-1?Q?6xV6NSvf9IL3jXK3SQjhMEqja1CkayIpwS2FW+pFdnBqWy/RfS3Obw3Zd/?=
 =?iso-8859-1?Q?WSS+1gHpe0cknf5algM8HcndGNc4RvXNIVYxIlkDlhf3j+Cxi2J/+TBH6t?=
 =?iso-8859-1?Q?j+e2Z74bYeVCIRSI4AwQJwY+6+cIqnq5QEvS/vZVpIAlN3/2y2dPX0fDdc?=
 =?iso-8859-1?Q?+cHexiNKd3lrCTWc58Os8HiX5/qL9M9mAN5Yo6FNvQBM9owPS3AT58PaRY?=
 =?iso-8859-1?Q?42D0V0qnXHHJnPfTcJOc96zXntA1/aXfMgaxlOduoUSp4ul9xKxLM4Kvu5?=
 =?iso-8859-1?Q?aSA9GAKR7XjQKOFGu++Q9fYR/IrUuL/a2yMqeyRog6/tZHrVBR2qm/OR3O?=
 =?iso-8859-1?Q?U+ylP+kRcdzfi0a53C9OlSG3qA+P/2xA7P2gtfE1oyGxy6xJrBV8BKXSJM?=
 =?iso-8859-1?Q?WY+Psc96mfpiCihdRX9Q+wtRnG44M8yL+19DmdOfGwEm5s71anT+mWaQtV?=
 =?iso-8859-1?Q?iLNW3GbqAoT2h5VH09/dlVGFbY9k4KYAIxIGMBVqnQyPkeMaZuUR693+WZ?=
 =?iso-8859-1?Q?ZeCvJoWKlrhQzJHPZgrPj0x1u/FKjVdKBZeMW5HltjUDOzLqaXUDcWp+aX?=
 =?iso-8859-1?Q?XxVoKzb+FTzJWxhW/fukhYLLhVfSBl7EOnMReTu33zNe6zaXCHI5dyBZOJ?=
 =?iso-8859-1?Q?D+nVZGgcXq3HWfE5t5Il9lDSmh3wsEqbMP7zjQjh1un2fxvnMPF9hUFrnr?=
 =?iso-8859-1?Q?ds5xyFzw/5we7sPuSO3QqL6CZ5DiOkN5xLy7kWMFUXdcTT+WCA6D1gtRfT?=
 =?iso-8859-1?Q?zdy0nytoSeWVYs+tZDvNsIvlgf6bUzW/+e01BhwlalQsNRFbytPW6LXf3a?=
 =?iso-8859-1?Q?nI4YkCQhx5dAE/GKUU1nvLN/fI+4Y+vVlSjErn7t92If3hGIs83m+2x/Pg?=
 =?iso-8859-1?Q?3ER+NNaE25USlmBjj+Di0pbRk4aPWyWj45+SSux6PyG4Ogd2P6OChu2A22?=
 =?iso-8859-1?Q?Wc6dBARNKwTF8fkTv/7TtsiPzKUUfQTxZNhbvcUlc0d+yVffnQEKg7gLC3?=
 =?iso-8859-1?Q?ChxV/l3/k3PEtOjuqY/sGDqWjWsjezKxBgzq4LsPKLVRRweNDVs63mzNoP?=
 =?iso-8859-1?Q?NcS+vhPBXLpNrdhsNc2ecldkmb/F/fV1er4ZGsRhHcoHIKY3e/FinVuyV3?=
 =?iso-8859-1?Q?isSXtqkg8Ar7B3nG8erdIe5fkw1AP4BWUU4cQapkcYHLX8y3B3cbarjMMi?=
 =?iso-8859-1?Q?nWMWxqZvjA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-Exchange-RoutingPolicyChecked:
	QtoE3DUwF9lMEE97eXNRvbYr4cIje58eqLdg1vkMM2JMfVuRaVCXE07nmOHloKPebWfskVt46yv4dd2R0yxWAk89oaErmRM26Jn+d+ntw1sh5GiwILoSTYBP9yU0jOZ0GX8qNfGY9YG17tyGcwICM3K4A1Jhtg6YMrQz0tj5YnB8xd+0+uvlnvHWsz61eoBhX66H+kwRmEbQPHBoIi6lPwCTW1CdeyAqJ2ax9QlIDTW8i0LGMhRFPJdjv1NuXpCd6Oxn0D+GfEqj2KupeGQaJxJYJJSDpIvgiWHdjHPJJ5l3nfJU2rXWpwkkhKTOvydr/xXX+vHmqSUiugxpjPxx1A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	46NBVnrVtIWylwwxn/sNNXEpT7pSlKZPzGOC95sHmmlMCkZwx5mm40jGzreSHmZuEKh/+BxaLmJWbeZX56HbIwSC0ubIHUvnSG12iWeTHvfjBlWtd7s8IivRb8MnFYWl5j0qmlqS7Mwqn3CvGJF+FtnwcRCO5tSbsBGlZQguLxBgnQV8aB8xUqqTfLmBeYjIem7aKRRjNJofZxmmiPLEhol82NispyFP03B632XJhjROO0Tjv5ZQ1YLkwuoFISuVSc7Q13ZdjHmKkQkHV0bvZiTf4ODyEy7YVdu9tllcCrOnD3nMbzjR4ktZjtdVUkRhWSynhkTBP8LXWkZJsS1dYDoBwu3yvqDgr6FNx0Tp3YJ0U+8pyy+vyqqMTBw827zyPakxDb4zVyLEEvNSbrgay/fHGYjQpm8vEs8x+7MbNVXVtiyoVpV9GJKE+3c2MVE+8gsSmNg3G1OgbOXir67ZushIk8bg6xfmO9ImHGJcMuUZg2eK6QJvhLZ5lmSVLW3KRx94w36GTU44dRtcQ+f84q6tq4aptilBkyJTH4qqI9K2drLvCV8oWYxq7tg2OeKJnnbkn0hx5+GQ6CrzSHqS0Ha56VYgN0t40vALQTvIKNngWjoc/TQdf8WsLZZhBEkF0M2qOgWxTkEMjbL6suqT/g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036d7ff2-ca28-4c2b-2754-08df2f0b9067
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:38:02.2618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P84ZVtwZk1E1A4/dOBcxQg/FkNf+33vcyiBj5JKskidAYOifJbCCFaQVJvXBcPSBbcEdCLMdfhdOllZn4JtqpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX1y5tK8ZntDuq
 GmABN8YU8fTlwjEdvgy2IIZ981X4ArnIdBp7TE9Esm2893YgLQ5b9+1X0RdfaBFOL1XWIUFXula
 UZxeCLjVWZ/xPL1xQQvSyi0bOhI33IQ=
X-Proofpoint-GUID: 84nKhllB4F6VRWWPHpOPr2jI_Fz7sSZz
X-Proofpoint-ORIG-GUID: 84nKhllB4F6VRWWPHpOPr2jI_Fz7sSZz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXyN79IKFeDCjG
 Fzgb1Rt9wXSXWt0k3dGvhP8vS3gMOIoxA2Jxk/oPhrsMs0+KD3ptlRhVGzWZRAkudsxHO/OVZQU
 dNkeyHww0cPvsZigKU0b2ecmGjXvJvu7O8qNFn9axUAIP0rs9gbTdovhjD+gdVF1lAPQrDNbC18
 iE3/M1VLShz6d8ZvbOPOkSkX0XbP0MBigCyWnrZYvkaTrKJ0/t9RVszn2hpjxZE10Y4hHESEkuS
 McY4eitt8RLOhLxjvYAZE0z+OFxzt52FgjzampBDToODiG0xjycSahgHuvAYfQSZShSrTYlouc8
 1Sjaw/ViXo5h8b10+mi0+XicsW5OeKc75Xhjs9NhGrCgQ3CKOcaIrbAn2y5ZdrXym9hNqNzkXyq
 1T9TCfIGh0LqX+zzUKlXBlroIR0Iq62m9hYqof8MztmFgC+LiXGYUAD6bWkl9hL1+tSQ2eB2Sey
 Xj+2Ol0jXXJ3j5xsT4g==
X-Authority-Analysis: v=2.4 cv=LK3z05W9 c=1 sm=1 tr=0 ts=6ad80970 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=f52QzsS8Gf1U9SSVqOMA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610210001

When an End Transfer command times out outside of the SETUP phase, the
driver sets DWC3_EP_DELAY_STOP to retry it on the next SETUP phase. If
the command completes in the meantime, the flag is left set. Requests
queued to the endpoint are then deferred, and the retry may end a
transfer that is started later.

Clear DWC3_EP_DELAY_STOP when the End Transfer command completes.

Fixes: 4db0fbb60136 ("usb: dwc3: gadget: Don't delay End Transfer on delaye=
d_status")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index df5407e75788..4de3b81cb678 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3875,6 +3875,7 @@ static void dwc3_gadget_endpoint_command_complete(str=
uct dwc3_ep *dep,
 	if (dep->stream_capable)
 		dep->flags |=3D DWC3_EP_IGNORE_NEXT_NOSTREAM;
=20
+	dep->flags &=3D ~DWC3_EP_DELAY_STOP;
 	dep->flags &=3D ~DWC3_EP_END_TRANSFER_PENDING;
 	dep->flags &=3D ~DWC3_EP_TRANSFER_STARTED;
 	dwc3_gadget_ep_cleanup_cancelled_requests(dep);
--=20
2.53.0
