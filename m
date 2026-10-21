Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792543102;
	b=QTyRoVcamh8P/h6NQhAefQ6YFBMtc31NyHgCMRrn/9bcUatqLuWtYMgdv2ZtNILrOOjF
	 QL/EazkbosJouDlQo1U2bdzwcOFvQFZSwbMQ9L3RqM52ILvWeVO2cDWPnEYvPUaf2T2Zb
	 aOiOxzP0tPYSdlF+orpjoJwezNMOq/EzschnZ57L7mdHLO5A0XrNGj6w435OWtz0liznN
	 dMaNV29GdPlEkiteYXGbisroIUpFlhR2Tf6PeDxblU2XW71LojvrIrmYP2aBi6B+8Mp7f
	 y1Z5FO+uYE0dvvS9J3ydBpxKTiWgCCh+b6Ze6RJvvhgZyTnBq9VtVAbQhrPhn85Bw3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543102;
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
	bh=8CHTs0ltwkYzzB+G3dDQGSg5vdbDyqH+No9ldjXB0nU=;
	b=GItCjAdxHDc+NEy2ec5AfJ/+Oex5tt6zoVOAMBoCXJq7TJOdRSF7wSdVVIDe7caw7tjN
	 h1RfAjDiba8PCtxn83eYOH1CNtO0rprgVPx7ON/DulU7JK/Ep7TEHnR+QY9N2OdfBf7wz
	 wxKYGO8dnQkoZWrPT4x1a+XE/zcD7z6og8q9Zwv6BgiRASu+cQ6wgFMalhOdm1QZxhPrW
	 Y0apupskvYwSzPfNGD6diqPFbaEbacYFVfR8nrKhmGGRTOhWYHFPOw7DMoivYuCOCq1Hf
	 EpK/79jHxAhrCBna6LJnp60Q+nPqcRL8yffRTTDCJR1spLVBYlTm346a8IsTDeKgz1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=CTmQeuzn;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=HbgLcV0L;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nL70I12U;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31BB606A328;
	Wed, 21 Oct 2026 00:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E31BB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=CTmQeuzn;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=HbgLcV0L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nL70I12U
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KKvpVe2052411;
	Tue, 20 Oct 2026 17:38:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=8CHTs0ltwkYzzB+G3dDQGSg5vdbDyqH+No9ldjXB0nU=; b=CTmQeuzn8vuk
	Fe5GEXbnD/90haD+D7FNmVtvA/d39hA0bo4dRn5sujuhLgYOJCBe5DQZDDsaRdED
	+yEvEhChQqH+Cpje35IEkSFD6vK/z50xIl3d8O0XmerDWmeYNLYjh1T9fEj+RGl8
	gm5OaVpgDrVBj779kwcnbL7pYbmuf/WUiAvNIIVh35QCbVDwUON4g8mcm1N2XuOl
	GkJv/AcB91Phgrxt/EGbzbPjbObNgb6S2A5/eGQ7ZaODxcrfLWS9mT7q43nFQkdd
	5wwZ4pchlrwfuPEBdy6cwA3qQir5fjtLYqt0yUKhELlO7kbjKxz35diJ4fEvWJqH
	4ONOfxHfDg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4hdw6v8evq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1792543082; bh=v3+xpDaOsy1xcc5cGoFeSkYhTBI+GTNeA4McDOaEdSo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=HbgLcV0L/f8/g1ebAdao4TYwCh2aoy8Otf3rT/o3iC8ySWADmBCPa7DGIzhRTDa00
	 PvO2jsrLM0Jum+mmytdkqazgiJ/E1TOWfdB497TYpE2ka6yxq9m2ri4DqB/7Xj9Iod
	 Amlw1x+ZUvyjf2g827lUxi6b+DLQ665Uui06lnwrAiECUJPmRDp4HwrYL4eDqHj5jY
	 +KvZ6kln/wEVEWHO+W7zDeRwSOc5ux2R28zReDPjrB6wgsQZISCDGQts8xGsGv6byO
	 ifhUrNLnPA6idAQQyzSxoG+BXm8GqfYTSSlIP8eHs8cbMsfm0nAJF2cn0udEtNCTI3
	 o6e98ifQibUxw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EBB4D405E2;
	Wed, 21 Oct 2026 00:38:01 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 9DDF2A009E;
	Wed, 21 Oct 2026 00:38:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nL70I12U;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00101.outbound.protection.outlook.com [40.93.14.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8881C40E01;
	Wed, 21 Oct 2026 00:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjAIHghf+TQjpgx4LYXP7vxc0Tf03A1s0Jhz1ACmKpGRB+63SU9xTa908m1WzYuhVzt/h7TkIi460WxpU8/KyW0FJMpnkAq4+QkDJiE2lRZ7C6h9h1uKfPaugGHzwP8qfdO62/b9b4iP3H3fvogHccTP0Ac6Q4Q5lHxAqZrN7Hszu2pFtOLlHKfu49BNXjsHZ8QLTfevaLZWBh/1uJNDbZ5XiqRFhM0+km3Luug29B5lwJzCo4WMqk7/kTMjzxM8XxXNMod5Cj29IGRAR7QBWuIbXjgG3EjORt+H8JBTT025C/mQyWqC/WO7HZypmwaf8ul144LLIsWLMnKdezBcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CHTs0ltwkYzzB+G3dDQGSg5vdbDyqH+No9ldjXB0nU=;
 b=I7iFfHrp0XcXq/D2O0R8XvhsPVjK5iDdVo7Hre2QrdqURB2jwIA1Vq0mUDVnVFihiLF+NMAifFBMuQE1ulBgJueJlE5dQCwe1UqN9+WZXFRoLJkqYdqcZSgDea0FCB/jMRN9ObiR5vk/exaBPTDcJ402/sUdLtSLlQOITLZTeQLq1+yHox+WvOvJ7xkWCWCmV9wykJU+laoOlw/Bk9SzSExRqVso8/h5/qRYmdLnqxB/W0zbPoiXrfaRURiJcmEFaqIdaGuPcIhIxUZDSv4pLiBCy1JZii0QIJtx9ZCtMK19UqpmAfYfPIyRmjb2UnaJ+RifGHFiawZUx3APRR3Hig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CHTs0ltwkYzzB+G3dDQGSg5vdbDyqH+No9ldjXB0nU=;
 b=nL70I12U8zt4Or9GvzkniK5jKrhQGRQNj5BsRL+DzBNp/dJWhk624MUpGsGgl8ijqCVox135aQXEB/rYdBpt/Ipb+ogzVKOwyPsahrR3k1tfXXXhKHk8mR491FfkNhbbVa4Rt6149ebW+cNuN6qky9OGmlCxJ+kkjnD8vIhK3FA=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 00:37:56 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 00:37:56 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Michael Grzeschik <mgr@kernel.org>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH 2/7] usb: dwc3: gadget: Track a timed out End Transfer
Thread-Topic: [PATCH 2/7] usb: dwc3: gadget: Track a timed out End Transfer
Thread-Index: AQHdYPRqi06ezYURC0a11ThkuaHWNQ==
Date: Wed, 21 Oct 2026 00:37:56 +0000
Message-ID:
 <5815c41a7e7923edb114741f29697cf0161f523c.1792542945.git.Thinh.Nguyen@synopsys.com>
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
x-ms-office365-filtering-correlation-id: 473923cb-aafb-4606-5e1b-08df2f0b8d0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 t4TSEDGqAf0uWcNu1Sqp1HrdfRtYO6RNtYaAi6XoO0xgbsqPD9iAZxocufmhei8y19zTreabPhvA7wMowXF6r7mulWPO88bn2j4uEhd4CFRWg9NBSy+uxU/SVCDZYkeSEXIrDRsrKOym0Bd+yHBGPG2dKcTuAW88NN63iEwXCsYaSzFzQDTaZ4Kta9O3JlRiOgCzA+78Zz2iERfhWiEZM2A8QQ4lZyMbEVc+D7BIBpkoCD85NsgAJF1QnAxPtwhFRBEI4hwW0c3x4GWzIxfnJOGHP9trHOykVTc0pL7vxRcyRzMSUN20gWvtLMfo+lJlpje4/J/d8pZkSBMkgvhtCJLkkDp31rrRquoPBN8URXjk+msIGaGnmlCMPzWOYPoAy8rGWWyaie2rBaz+txSihaxEwjlHWc/yv1P4pvWFf1vdUmTZIXwgeBAD6a9bgUWSLQ3faoz4aHsWpP3vuV8/NjfJkeaiUkPD0MyBAs3bc+6gdnRcj4CNHMZyFfndBfgrZMO6DKkQ0sWuECMVRpbCa3u2NGV5hEKJilJmk1JgKLlxnCbyCjcl5DjEiBRKO4sovKC4sggXLzDl6W4XZrjD8ZAmqtla+vtKQXmvXgWtBfJKYaFsOfF1Ob0mlusxLMaquxDuNdA93Lelt+jaBphRA3yfS3YJExny5+yxQhRpU2A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KHn5o7fZbnwKspJ47TdRVcaHDjBpzsjN98bNksu7HPlU7poZdzdJp6/0hG?=
 =?iso-8859-1?Q?Dw4lF21fxPjkhRkvX7swpkGL4wqm9YS1FRPzDGHbT+ha2AzJ+MMy4BUp1Q?=
 =?iso-8859-1?Q?PC0NtKKZUVaouLw4fBm6XUU9XQ5yeDUMA42yj9QbPIhtx7q4shF8nml+MY?=
 =?iso-8859-1?Q?wGZDP04+3HOF84P7MVsFysHAnbMfaHoH8FirsnGznRzFR/nmJZlFUYB7Sq?=
 =?iso-8859-1?Q?K/9ERlEinsyhKA6Q5LVWpeiaW42xRo2ZUqgQq4JDwEmdIJDm6FgY/LPjlm?=
 =?iso-8859-1?Q?/sXnWnZXv6ayQimQWUESsjzyxxfRH7RfaxleGGMKeL7+38QX7H1KF4yKr5?=
 =?iso-8859-1?Q?dDRsOjaylvULn2Bk7EZ9PwS2beehiub+k/HDtpl8gaX/NRQXcPwBUvzCuv?=
 =?iso-8859-1?Q?fURpCXm0q3jp2PksIocPqYZBQlgVWHGR/Ffbue8l/eISdDu5yI7ZlQP59p?=
 =?iso-8859-1?Q?rvLSsBNJehRjnSHF9q/1WBeHiRYsq4wbW22qSnbzf+tIW8Z+xpgqVJdQil?=
 =?iso-8859-1?Q?TfrxinX8HGZAoFGHrZf7aWg8CslBoZDmNo7sbdGJ+sIp0FZdJJLpPAZHuV?=
 =?iso-8859-1?Q?kuv/ujBnXiqVF0Hfvat3xgtAjsK8enrA+OAciYG3XnGRRsoCcMzdrDuyTw?=
 =?iso-8859-1?Q?YxOk7swK+NrZDX5u67qSDCAvfF5UnB1jleYJR6MFq+xuCUBNGpduuJ5fwy?=
 =?iso-8859-1?Q?yQEuq3gifa8zVLmvDG5gup7PBOgvcJG9QgiMKCacfWNn5cz1ijLbRgdkDA?=
 =?iso-8859-1?Q?KrCt7e1FPADrw/MolTyG65d4tVBmYkZ06Dhoamv9bhWe+UwmPWCspdPvbv?=
 =?iso-8859-1?Q?QQ7hOZpIZ9v74Gypr9HOenwlPNQ+kp+TyuMbfJi4vrN1cfyUbce0R0gp9E?=
 =?iso-8859-1?Q?HaHSf6qbR3r5e6zA1utahe/4LARYrg+qIf5LdKi/qIza/x89/9/CCaXaDq?=
 =?iso-8859-1?Q?TENnwkBMTdVwKZGaX863+D6Fm/ICTUn0mh7c+KPJBSGuWIHy0Yka1xNhq5?=
 =?iso-8859-1?Q?PV6MsYIsrl2R92XDb2MCf7AaPJaaqB7GU2zH6CkXmZ35fsQ/7TTe04zJDc?=
 =?iso-8859-1?Q?QPtZz5rcpMFvTOdws+x7gyNrF90eHJPTQGyIGpAZuMC1pbUrlxsSmWJodb?=
 =?iso-8859-1?Q?h/F2OC243Q5bvbWMDn52QVOmb9gINghksYTbDME0am1LU9kBIGqlPOJgES?=
 =?iso-8859-1?Q?Az42+G7LOQG+6tYve8KpzklY4ZOC2KehLqMbHyum0/4V3eL/71itxR9VVk?=
 =?iso-8859-1?Q?W6RS15ohrkezMadjIl0b8k20tJGUV/LCAy/q+FXyKoau/XXwDA/FoaIPGv?=
 =?iso-8859-1?Q?JZw6EWHw6XMQZEPIN+RtDZnnI8pp6Ttc17Vz/RAE5pKBvz99LCJmKMKjc2?=
 =?iso-8859-1?Q?bq2EEB4H/eDc6ieLMiYpRbAiAxE980wJ3uy9wUAb0rEdWvIMCslEXtHZeO?=
 =?iso-8859-1?Q?lpNFk6DO9zbAA7Wh5BgHUcVgyJEQa35fWEfQMXqh/Ekq0JAI0X4ixYnKB8?=
 =?iso-8859-1?Q?V7HNgkmmUYdPJE00fHrDziNQGYgwFkAaj7Eu7oCOUkHasqwOEALux2bZao?=
 =?iso-8859-1?Q?JS2lme+4eXZ0T3HTcBP0Sp5rOFgqLXyYpcpfMmq3ySd75I/WL+tsGjRo2O?=
 =?iso-8859-1?Q?Ui7AusVoPZYSspG2cjY7TpZHg6TpOJLSoTVRo1fKptUPT2Rp9Hqa7jVLcE?=
 =?iso-8859-1?Q?e1L25IC6PLxNIQgzMCinJiCfWCCHswpMRA8EI+F8fLhQuR0roFZnVfRVOG?=
 =?iso-8859-1?Q?h+oPiqtx/kU1Ii8KNtlCh4/5ZFd4E4TZ/8MlXgLDihVrLy1I3MDiKRw9mb?=
 =?iso-8859-1?Q?Rn7lST2CuQ=3D=3D?=
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
	aPOS9FVRDbmJgbtTAMhRHE5PjsWg87OoQyK06oRLnE1D2J8P0V+YrzRtOLQ22PyI8c12NBZZ1Q0EIe6TfK0V4OwoSUA6DDYymDP3qBOcnLLWIpyjh9LC0jGqaiYpzXr0CHF2n90/GFjtvXUYQZdbHMJpraNjSZmhp0ed33QhjdiT3SuRRCzXt1uAiCGvUvFn1CnvRQOVDPpGUqFOvZjTIEpY8jWReMrzdNVpmZpvKydszYFTIGEO0bsZXSlYorxDSaF5X4S1pWoaeYG+ahDZUCxHGx8OcLCu0l0IPNpv3MA07AG1wNYcAeg5mwyIJ6sUu02efuC1hAycIdbcPiXUwQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	13sA5cO1rMSXdeFg5tbGQ5vi1ieeed4l9y+czNGTXlACTiTGrwPp8YkBnuOz7d8J3IzP+v/KgiJMKchMVG/d8dlOUc3RaBc+jMUXWkaD6e383zCVlp+i6FLfgidaO2dmP2xc9R6i8kuHImLn4zpSlda2fAZBl8pL12PzwhibOHhrmxP2BiqybC+zDJ5Y4UA+3DMcAko3MA/Znp+zarFRKkVYZIRVEj06cp3pIUaRKO2sT6ZWS4osPZ85IUNSX3E+P3R54RlDw4df2FEUqjPY5Ckj3Vtk2H26MDRcGn3ilDO2NrCT8onHgTt2AN0QPBYD3uWsH1da/VcfJreOv+JlNCPXWuleWBpy3Zq19vjCVPpj+/MOs/P1uXkR64zvE1y1cP7MWnYc6eUc4AYjpQMvatbgSAuLu5M5BFxjMaXVXXVj7AJOnpMYkrNdH9gG9MUh0DIGH/gEt2uUOC5w90LR+MAIz7kzFW4a9NH9NJzhmGl6oQDNagTXjq49CFWmKz3SYcOanwlJf4VegtYbB/w2BDNL64L96xIiL4ZzfTERv4BOmCQkHW32i+XZvTe8h8b9cHT6ezSofttJpNgDIslgTGl/kqdgYW1p42n3QjEP/yy7+Ex1GxiPJr9/W86vF+pj7/VlmYvRRdCz7C8ypWaB0g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473923cb-aafb-4606-5e1b-08df2f0b8d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:37:56.6984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0B9XQQDPoON62LBk5FsuNJjFCyIij3LUXxCJ/w1pLWAXZV1RFcFJUe5h0Mhdk0gzE0eYP9AXzZ4bLOQE6Bu57A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX6lGNjTYtyGM5
 MPCtBzNcUJ6nzmpximFue/PEUGpyBixXg/Qyh2IE+pxDUd+v1zzwY6smgpTGCMcILQagza5Ic5l
 QFCLUkrFDy4//BVTwjG2How4RgkG2mo=
X-Proofpoint-GUID: vX3r9szELkmaY6hjCMB-ftmqHo8riCWB
X-Proofpoint-ORIG-GUID: vX3r9szELkmaY6hjCMB-ftmqHo8riCWB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXzTl2K4hlpYcl
 vMIGXc0oRDSeXlbgsyPe/OgJLBoQ75PoI4OtrjJ61WNR50g/ZqRYhnY2UmxsofiPw3J1V5ACkfA
 UE+URqs9oxrgHu8Hso+bQuZvPzA3DB2F/FvyB4tuQp9idFoCma2TuJ9uhE+MRgfIaX7WTiF6473
 bIzw7WBFCiuJPW78w0Lrg9fNeDr3DIYe8cfsbUqUSZ3pbcxWsXUWoa3E18ESCyQ0E3+hkm39HrW
 sS6odiNJIx0ygu1qEv6WfTZFHIZdeahGdRqRwz8Rxd+vj2q14NmyfhWXTJWTaJyJKG2r5SueKoC
 P41L1PkFcVY6BhX1FnkQ4aD/fE5DX1yRpCZb8KsF3EA5l2k9FRpN+W5c6/ks858O688DcGcisGU
 kgplWkFjZYV0+1PMNpQ7SLiwBTZmvkJO0bW51tnQBmZUFp2VDZ1JZrG5GGGcYfcq2pAMQtk5zWy
 8v5DUH7OafW/R4GcwrQ==
X-Authority-Analysis: v=2.4 cv=LK3z05W9 c=1 sm=1 tr=0 ts=6ad8096a cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=jrSeYK05MLPENkRGUnsA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610210001

If an End Transfer command with CMDIOC times out, the driver clears the
resource index but keeps DWC3_EP_TRANSFER_STARTED without setting
DWC3_EP_END_TRANSFER_PENDING. The command is still outstanding, but a
later stop issues another End Transfer with resource index 0, and the
next Start Transfer fails with "No Resource".

Mark the timed out End Transfer as pending so that no other command is
issued to the endpoint until it completes. For any other failure, there
is no outstanding command, so clear DWC3_EP_TRANSFER_STARTED.

Fixes: e192cc7b5239 ("usb: dwc3: gadget: move cmd_endtransfer to extra func=
tion")
Cc: stable@vger.kernel.org
Reported-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Closes: https://lore.kernel.org/linux-usb/3fdda532-8181-48e9-b58d-cad728940=
8e7@samsung.com/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index eb6666b7bb98..df5407e75788 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1798,9 +1798,9 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep=
 *dep, bool force, bool int
=20
 	dep->resource_index =3D 0;
=20
-	if (!interrupt)
+	if (!interrupt || (ret && ret !=3D -ETIMEDOUT))
 		dep->flags &=3D ~DWC3_EP_TRANSFER_STARTED;
-	else if (!ret)
+	else
 		dep->flags |=3D DWC3_EP_END_TRANSFER_PENDING;
=20
 	dep->flags &=3D ~DWC3_EP_DELAY_STOP;
--=20
2.53.0
