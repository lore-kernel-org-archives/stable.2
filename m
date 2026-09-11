Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DF375F80;
	Fri, 11 Sep 2026 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170289; cv=fail; b=emxXhxikMROqNpWipbyrB5U4vzgt3azcph/PC1dmf8MowZohKN7A4FMrm1nov4AY58V7o9ywhTFXUCAHi3tTgkfPtzN8V1TdiAl+VHKgh9Ka1QVmoaJJBZpV9XO2977wY6CPDWGm7pffuHmRmcObe7MO0j0FAly4g39m7SZmk88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170289; c=relaxed/simple;
	bh=1CpiVvpZxcFMhIBnWytyLB0eJ9idVZVllhrybBKnLH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=otgj9Cotx4FNkNiJRr4BqOx+4Ajx2siYDiHxly87WtHSGvZNEsLUl44tMnMNi7UJGlxov8X4uMZLRwdo67FTz0BJHyErTWuvA30udG3tf/SRdDAjzo4CRaWql2MJB2nkHw7uBvJ6h/7rKxWBg0kZRF2oVj94XFXA/5dqmlaNcBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LwcM9J/P; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=axwP2G2+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ImM2s6Zm reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LwcM9J/P";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="axwP2G2+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ImM2s6Zm"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BNhFoR2436899;
	Fri, 11 Sep 2026 16:44:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=1CpiVvpZxcFMhIBnWytyLB0eJ9idVZVllhrybBKnLH8=; b=
	LwcM9J/PZTm7zI86eu+Lu/rvrmblfP4fMc2xJH+25ys4fjJhnBhmPb/M9yR0JSCo
	Zq8V8mJVRvd148bTwed4ha6oAGtVL3o4cdvmrbjnbcoo4vSKhtOMKMeVesqejJjg
	gDtOCIzGhXo/PfwiZvo6nAFWYCEQvLWOES0bwpWMNmz9SGMszBqgnFUxHJw8weNd
	XPFMBWXxgGgCrCZY+m+6ChRhzn3WfPFsIZuNFdm2+f98XAIitbWBrZuKLIaoJUWE
	1UCS/U5AoPDoljGwimP8eq3Vf5RnzRl0nRDau9v5BrBWAeuqYM2BeTtFcUSal4oF
	8/wTW3T9cNIm8rjz+rqLYQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4gmrj4h32a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1789170280; bh=1CpiVvpZxcFMhIBnWytyLB0eJ9idVZVllhrybBKnLH8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=axwP2G2+m3QSpsscnhhZRfZ2uKfAGrKKHCybUodC8vv4hdsdafTVIxAZu4y+EDROo
	 3beL1sH0oKZvQebba2IkFPZvoAyK+Oh/HveiyOqwzVW9fP7yvKNc7xxOQJQrAjWhXX
	 FLAzy/jDrxIFU3/8soHoI47iQQBgjg+Koso9IUSM/y4OyUI2TvaYf7DMoBu3UYHnnW
	 FeUqrZvDg/VgH2m+EL2mXyEOL6NJWhTODJe7P5mx/f9zMHJKkOWHzvYWdLg+XX7veX
	 nd38hgDQorwxetrxg6x3qICjg3i3mI5mZn5IfE+qcfEHGvaKhEX3zfYk6QxCcvxWsH
	 6+oJdzYyI2ucA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AA796401F5;
	Fri, 11 Sep 2026 23:44:40 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 68954A0E90;
	Fri, 11 Sep 2026 23:44:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ImM2s6Zm;
	dkim-atps=neutral
Received: from CO1PR07CU001.outbound.protection.outlook.com (mail-co1pr07cu00106.outbound.protection.outlook.com [40.93.10.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A0BC22200D6;
	Fri, 11 Sep 2026 23:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYKyCPh/XBx8R8nWKyw1faM3A+8WMSkJ8j8xssxALJfvkvUCyXH+QLUU3UgzMzu10E8UOaXsOfit4L1R3o8U83/ZRa2tAL0U74c7Ci6RUQoaww5ENUg7rHIpEI6t7mBnCN7BFK8J+2M6du+oRYDrq/oJcnEzYLqqYRRZYqyvjT/x0d4EhCo9c/CDFqBZCEmlPez96FvG7F9M4pdGC7/3lhIXt7R+l4dVwVuLmBGfeLIjxr+chMtvCFdZytToLlRG5lTudvOTiI03UwhEUyLB01624LVptz2oLIkHmEBWNYpj5VFcp01gw4eqJBw5NxgM+HzACW8TRTpcTLBarx1iAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CpiVvpZxcFMhIBnWytyLB0eJ9idVZVllhrybBKnLH8=;
 b=e8CQw1LVhaYryojaVeLcgMZEQ/CmeEbXBWKsT9e1173niLDNZNq1foL7+6p5E/ea2s8j5la4OtMvQ0Q6JlgS7cxkkl59yStjQabCi9orA5brglPamCYWNfgh76Wa/2gXb5xptdiHGIhDgDGN2U6vQ6q/esfCj8MKFO0PovMOafAgdskTGwv52RXfNPIUACHzJ8TjW3b94X8fLq8M/cu6iqSASAXR3zYLSRM69Sv6Ay8zepIUeNNWtmNnPXSnsm+4HV10DUfenLYFOu8R5AEzRbunuxOL/AYy1nj2J7Ag4q//62OJKpGsuHwLldZZu3317kY7rIlNc2NnpoJSOoicoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CpiVvpZxcFMhIBnWytyLB0eJ9idVZVllhrybBKnLH8=;
 b=ImM2s6Zm4zbeqsVzY3vklPe0Lxv/Ki1JDWhhGq9ghYRVggKvqV1VRDVcG/ckYXmNQFJYEv4YlHUQX3/IcM9jGg3M4l7OqOWezDzCw0mKz/DwSRcs+z3nh6cKUqXpOiuIX+rIUv2myFJQBKtEkVMHOiI9WGDcFfuQBEXcdWW5ZNw=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 23:44:31 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 23:44:31 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Saranya R <saranya.r@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Fix spurious suspend event during
 HS link training
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Fix spurious suspend event during
 HS link training
Thread-Index: AQHdPrFzEpdDvVVdDEGZnz/cYYSDu7bKEZcA
Date: Fri, 11 Sep 2026 23:44:31 +0000
Message-ID: <aqSSVkeFkKAVcxe1@vbox>
References: <20260903110947.2761354-1-saranya.r@oss.qualcomm.com>
 <20260907101236.1543438-1-saranya.r@oss.qualcomm.com>
In-Reply-To: <20260907101236.1543438-1-saranya.r@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|PH8PR12MB7327:EE_
x-ms-office365-filtering-correlation-id: 261368ba-cbd2-4974-31bf-08df105ea06f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 V/re93D4HeKZLlyokR8EA3cP2DD+ovhUAVU/GpyJAwD72GmdHJidf7FxlWUqoRQURWnfd5UblxIlnSGUdWDX/mEdUru6zVPIeocnI6u5XcNSgtc/jyyaBMAR8VtbhYlkKyr7aQp9Rec3j1RCdBh+iDO07FP0EQKH7jZw40/kpkB79iCQRCZwJX8Yw9pPF9uH4X7UaMdjI0epkiT1FBz3y7VHxjSNh3Yx4dNRLJxE3aBSxKwbouCxS+Ulo3YveRyWJlmfnv365+30jj6DyA9oMuPwCP3pfyMh9IOgnrU4Q5suMGXcvCEVQ7FJUVWQozgMyMZqd2G0neGl/zbVK9t0lTevX/xog+UYwVfc77ZazHstFXReGhuLxOvdK9BItHef1RTfWCLf2XqDcYZFFKA1zssexBFr7o/kS0xf1dL1Uu/ZGAbug76qnSVGml2oLZoVRMhlJL1HhU6LDg3AscCyRjV76bm1yarDnJPuaF76LwT3q5D6WYK7BrViMR1HxN2FrMUQN4L+L19SkqfnmWD3k7R3zpsYSkkB0Evx3TGjH5lxo8E1Jq1g3hJfq8cujQMeMPyh/hrJ5Dz6JE0GuXd5v28EslOlGorwNh7AR7r3zfcM0t5LJFaDL3ixSYn9i5Aoun/UEtV5irPplaRdO0Pfj/9qx6m3+4zAYLEoZPp0RZmokm/mzbZiLAP4Yut+HjhW9nC2n/+x0HQztSNM7WvmHyAgKvz/g7/N/7CCwntFofA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEUwYkVSbEo1TXpNc3pOdzgwc3hWcDB1RGpZdlRQSHRKWTFuT1ljeStoTE9u?=
 =?utf-8?B?YVNiTTBvZ3RLNGJCcFpWeEQrNVF3cmJyYm9DZ2FVRVhEN1pCaU1QUHBORHZx?=
 =?utf-8?B?RDdvdkJZWlpPU2RsRjg0cXZHVFQzd0orUFBFTkxKZWZGWkVHL2lTSGZ3VDZP?=
 =?utf-8?B?TFBZZ0pjb09uQVdBdUZuUVFuamlrVzlKTnNWYVdkcDJ4UU1tQUtOQWVONEdt?=
 =?utf-8?B?eFRpSE5ETWk5TWtvNTFQTEhFVXRXOXFYU3dWeEdZRjVKNGNDRStwY0piU2wv?=
 =?utf-8?B?Q1A1TGhnWE5uTmFwNUlGQVlNQWphU3JZYXovcW14RnpObTU3emxBTU1Za2Rz?=
 =?utf-8?B?dElYMWlzbXY4Q3FsekZ5ZEl1eFFWUTA5K1RXK3M4TGw3YTdodk9Ocld4Nncx?=
 =?utf-8?B?V0VEd0h3QVJZVitaZnVibjNjZzFNRHBTeHZDLzJGM1pOWVloTU96bEplZGtE?=
 =?utf-8?B?Y28weVNmQWNBQzZFTThxSm1McUFFbDBldnV4WjV0RzFtR1RhMVpoVVdESVNt?=
 =?utf-8?B?TkRjNXJpN3hyUWVWQW1YV0N0SUdza29rTW83a2JMTUsweU8vcUVPb2Nka2o3?=
 =?utf-8?B?VUVIRGRLV1hpNXE0TFkrNFRyakNnK1VKL1VyR1BCdE12MVczMjd3ODdPcEZN?=
 =?utf-8?B?ZFRtNjRsTHNmRzBGN0pmZzJYUGs1aGZpcUpDU3I5T2ZxVm4xSFZpdHFYbUhy?=
 =?utf-8?B?NitJQWR3NlVtV1o0ajNlZk10dEhrV2hkL05MdGJ1Yjl2Z0ZKZ0pTbXZUVE9q?=
 =?utf-8?B?cjJXakRpZG1GRS9tSTRQZmwxUkFxbURJSllKa3FxUlVtaStHS0R4Uy9mTkZY?=
 =?utf-8?B?cXpzY1lSUHNKVnlkdE9ST2c1aXBoQTNtTnplU1FmSVdMS2FDQmhhcTV2K3Zi?=
 =?utf-8?B?UE9tTStjclVHTnBGam9lSlp0MWVlZmlxMDFpUFhObnFYL1lkT1Z1YXNFWkR2?=
 =?utf-8?B?Q3dqbUYzNXlLOVVoOUpqMUQvSm82eGFiSXg3OTByTjV5SkFxZmgzUGN2c2Fm?=
 =?utf-8?B?bmV6dytrOWI5cHFFNTMwMXZ5QTlOcHczQ0VJankyYXNqN3BXeDRWc3FGZjBM?=
 =?utf-8?B?dE5KdTBkSVh5ZlRBS2JxYTQ0M1Bld0dqb2xuOGxsTkpxUWtkYmdqSlUzZDlU?=
 =?utf-8?B?emQwakxDd0I3WUhYcThSWUoyd0plTDc4NHpLblgvNFVZSUV1WnVvTGpGeVBi?=
 =?utf-8?B?Yk80Q3FuK1FFL0FwL1NGMEF2akhHbDNOaGkyK3I5cjVOYks4bjI4cWdmL2xN?=
 =?utf-8?B?QzJmL3pXTDZ2N0ZHSDVOL1YwUDRyT24ySS9PaUFjSUQrRGJaazZGNmdORHo0?=
 =?utf-8?B?SnRleDlpY1hXUkw4blZ0Nm1QVHg3ZTR3bTltd1R0bFlkMG03dElkbnoxZlV5?=
 =?utf-8?B?NTVMdFdMUlFBWm0yTWJzQWxrNU9RWDNFbmtPaVdGVVBlZzl2L0FjYytVbmp1?=
 =?utf-8?B?NllJQVF6bWZtUmQvUU55MzE5dVlWbU9rWXJYc25WZElQTWlZaDc2ZWZvb0JE?=
 =?utf-8?B?Wi9PN29PMlp0MW5LWDNPUDUxQVRMZTlvajVFMWhGalAvM1NMd3NIOGhqRUVo?=
 =?utf-8?B?WlMxV1ZXNFFDTjB3cWxxZjQxdWE5UWptM3A5WVB6ZXZZaURRd2hKQ05WMXNS?=
 =?utf-8?B?Nng0ZjAxYWdSQ0tycHllNDlEWVA2QWRhS3NFQlR1eFlJNk9FSVRoVE13aGo5?=
 =?utf-8?B?OEpObCs5NktrUVNrNzR6UUtlek5nSlpET0tqdXQ4VERibTIxNDhhWDhZWWF0?=
 =?utf-8?B?NjRWWjhrQTZzS0JFMjlBcWlUZnhleFhsZmZBVGFrVjNPa2V3MzNXVnR5TmVl?=
 =?utf-8?B?Vk91M2VxWWovdEZHRXB6bmxiT2Z4Ui9jMklLdHlUZ3I2em9mQk0wOGhuaEdH?=
 =?utf-8?B?ZnY4R1hJeWtNWVp1Q3ltMllCclJCVlFvN1o3STlnazIwY0o4bUJNMXJHQU9K?=
 =?utf-8?B?VG9uYnJwRzRTd21FMWF5bE85RUZXQjNqclh1dGQ5dkFMeDRGSGJTQ251L2Z6?=
 =?utf-8?B?OTRvNmQyNkFSeS8vakNzQ3E3eXY4bFEwMHdIbXdMZ0ExRldXNVcxVmpHS2o4?=
 =?utf-8?B?Q1Y5ZUpqVGlKd3NXLzROK3dyUTh1T2JKaDVIbVdnYnJUWjQ2ZlByRHZLK093?=
 =?utf-8?B?cTVqekVIZjJMNnhxRlU2ZlUxK2o0RTVYRWo5aE1Jbm94cnRnU0pLMkgxWlhF?=
 =?utf-8?B?Q0tvU2NQbmwybTEyeWhMMGYwdGk0SW5ZK1BCRjNsdmZMMS9VTnM1Q0VHUURq?=
 =?utf-8?B?bkV6aC9GMzE3dnBzQ1h5WlhySjdQNlZYRmVDR0lOa3JjdVZ5a2VHZjNEM1pu?=
 =?utf-8?B?WHRDZVJqNHVsMXlJUlRablRtWmpBMExwTnJOVkpYQ3pMaHBNTTZPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10929C958F38A747AF9649E2B4812866@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	aLl90e2ANUN9WS7AxFa0yP6R0FU2fWC2ifU5IG7JWoiUeA3abZB9oY7Qu8V04xUSNv6xK7wQ+o3zzlT6vHVzpoa+kOjLn8oDBNGETLYgVGTxaaiaAVGLGFUJFHp1Yg2fAWIhW/P8Qm25zHCZKK1jIovhrZaAGxuM5L74pS1TZnw13VwicRvPpw3DoCfIAqhWRlD7+YXbvvJD/lKrs45Ro9yTqGz/cHXBMzBJdl9aRh2gaIkEKbt3qh4hAMKrUXZPIL51CF0oKPEHse+E5UgemW8qQ3v0oOrIsHzXKD7HZZpq8aJ9AaiOaMuXgwO4KosmOtYQDsbEQiqoRvOjefq98A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ntdfMJ2HkYYFEtWDlMbygaiILmMu+lmt7t0jNHWuihtAym1TZCXwo0S+rl+GTHNVutWQORVjJ/bpzXOpjmq7BMzWfFu4iYePht40Eze8CcS+rX3hGbUQLCnjW5MhqBz8/VzBTpuxIptExNEsNW3ffUWE6inB1u49wkVxtaT6/PfPd2zOE+5JShKa8Dzg36cmkrzP09Stq7KONkdWTQDYJ6deXMvR9dtyqBygnxNlIW66pBz0+a2DpLQ/YbF68RgXHJ5MuKwKMP1QQyuOqe7/huO2pIERJKq7SKkYwNcKhYz3Oyp2CwqBDySPViibw5t8HoCmLolU1aC3ZnRM/DOM8iLqr5ya+cQaD1GUShb863wqv0lrcB9l9qZfXeVadof0Y9UowU2ljuHMCHeskvnUWcXTs+CgZ+frHJ9vt+/1BWz27yw5+SjPAF81TGItbywZCAIzPCTG9BCpjVrFxu4VEMEzIUKftVEFmQcf6Pje/f0sf5IO4bMuKm2E8R1EUUgLb9d0rPwtMdJxtgrPE4RaKBKiC/CiozmkEpuSWi5CQ7coWzxihi7htQQ6cvgKJJuRbKOc0EHd5591Y7W+J3KoHpZq7mZAiwKJyhPB0K4ciD/7NEnvb86ZxlOfHyxG1WaM5BeCS6tzjBbzdXER0VUf2A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261368ba-cbd2-4974-31bf-08df105ea06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 23:44:31.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJ2vpUwXnEl0EwcyDqhgMFSr110dPopND5RxNeBJTWRGQRHC2JiKRo10DFGa4LTdbLyD746jZnevKCWlEHmMMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327
X-Proofpoint-GUID: SGUexw2rIz3BthKmIftkp20smxOYC5JI
X-Proofpoint-ORIG-GUID: SGUexw2rIz3BthKmIftkp20smxOYC5JI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDMzNiBTYWx0ZWRfX0IXFt9LC8Eps
 Ht7B2CxTg+4TNxwHbJEqm09jhveZzU2bzh6abCBRmMC/O8D/6oW8KUVDc36QUZVsgH1F3LuYF3r
 yPVz69NU9rlIO6GhVg/s/FT6YWD4qXWpH5yfhsku8g/sPprddo0eCslvogqpqbOiYITUkQcDLBS
 iaSVeeCXy6+x45tH48H4Enf0EvK/50MwtylSShaXwdEk/zMIAvZVrfkzP+AWJouMFO1b0gHNfRZ
 S0FqE+7KrbKwAMMO2OsXqt9hdzB0oxd7EdwjCtT15HGgiPiYmY4KNau0FVTtcJ/8fc5ldQagpZK
 Z/cAW1rzQ7L2WFswq8X+KlpKwukhjQN6+6pQFr2gdxVYBTANtjBdMnLUk96x6mO+nb9TI2JIJ8R
 ZdADLs0zR22fmyEbQ8x/V0RNjEsOkZwJyRR7qBfkXDh2BVrwvg6Qo5d04m/xSrXJsNsZQ7pY9/E
 LClBz4IeMHpyumJSEUA==
X-Authority-Analysis: v=2.4 cv=E+lYNqdl c=1 sm=1 tr=0 ts=6aa49269 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8 a=DOypaSJddHch3ODEwdUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDMzNiBTYWx0ZWRfX4wXLVJ7ryt61
 9xRXw4mlwqi66X6CGIGllOfKkH/JGpWTVeYQ1ApcRXkxMXgaFWAdnaAuWJw72jpTYDaJsCSCvxn
 3KROKpgmI3xqeQFiVrTWwwp12x4NKKs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609110336

T24gTW9uLCBTZXAgMDcsIDIwMjYsIFNhcmFueWEgUiB3cm90ZToNCj4gRHVyaW5nIEhTIGxpbmsg
dHJhaW5pbmcsIGEgc3B1cmlvdXMgRFdDM19ERVZJQ0VfRVZFTlRfU1VTUEVORCBjYXJyeWluZw0K
PiBsaW5rIHN0YXRlIFUzIGlzIGZpcmVkIGJlZm9yZSBDT05ORUNUX0RPTkUgY29tcGxldGVzIGVu
dW1lcmF0aW9uLiBBdA0KPiB0aGlzIHBvaW50IGdhZGdldC0+c3BlZWQgaXMgVVNCX1NQRUVEX1VO
S05PV04gc2luY2UgQ09OTkVDVF9ET05FIGhhcw0KPiBub3QgeWV0IHJ1bi4gQ2FsbGluZyBkd2Mz
X2dhZGdldF9zdXNwZW5kX2ludGVycnVwdCgpIGhlcmUgdHJpZ2dlcnMgYW4NCj4gdW53YW50ZWQg
Y29tcG9zaXRlX3N1c3BlbmQsIGNhdXNpbmcgdGhlIGNoYXJnZXIgZnJhbWV3b3JrIHRvIGRyb3AN
Cj4gY3VycmVudCB0byAybUEgYW5kIHRoZW4gcmFtcCBiYWNrIHRvIDUwMG1BIG9uIGV2ZXJ5IFVT
QiBjb25uZWN0aW9uLg0KPiANCj4gRml4IHRoaXMgYnkgc2tpcHBpbmcgc3VzcGVuZCBldmVudCBw
cm9jZXNzaW5nIHdoZW4gZ2FkZ2V0LT5zcGVlZCBpcw0KPiBVU0JfU1BFRURfVU5LTk9XTi4gVGhp
cyBwcmVjaXNlbHkgdGFyZ2V0cyB0aGUgcHJlLWVudW1lcmF0aW9uIHdpbmRvdw0KPiB3aXRob3V0
IGFmZmVjdGluZyBnZW51aW5lIHN1c3BlbmQgZXZlbnRzOiBhIHJlYWwgc3VzcGVuZCBhdCBBRERS
RVNTDQo+IHN0YXRlIChyZXF1aXJlZCBmb3IgQkMxLjIgY29tcGxpYW5jZSkgb25seSBhcnJpdmVz
IGFmdGVyIENPTk5FQ1RfRE9ORQ0KPiBzZXRzIGdhZGdldC0+c3BlZWQgdG8gdGhlIG5lZ290aWF0
ZWQgc3BlZWQsIHNvIGdhZGdldC0+c3BlZWQgaXMgbm8NCj4gbG9uZ2VyIFVOS05PV04gYXQgdGhh
dCBwb2ludC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhcmFueWEgUiA8c2FyYW55YS5yQG9zcy5x
dWFsY29tbS5jb20+DQo+IC0tLQ0KPiANCj4gdjI6IHJlbW92ZSBGaXhlcyB0YWcgYW5kIGFkZCBj
YyBzdGFibGUNCj4gVGhpcyBpc3N1ZSBvYnNlcnZlZCBvbiA2LjEyIGtlcm5lbC4NCj4gDQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDE0ICsrKysrKysrKysrKy0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPiBpbmRleCBmYTk0NDg1NmY5NTYuLmEzYTU5ZDlkOTJlZiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+IEBAIC00NTQwLDggKzQ1NDAsMTggQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRf
aW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MsDQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgRFdDM19E
RVZJQ0VfRVZFTlRfU1VTUEVORDoNCj4gIAkJLyogSXQgY2hhbmdlZCB0byBiZSBzdXNwZW5kIGV2
ZW50IGZvciB2ZXJzaW9uIDIuMzBhIGFuZCBhYm92ZSAqLw0KPiAtCQlpZiAoIURXQzNfVkVSX0lT
X1BSSU9SKERXQzMsIDIzMEEpKQ0KPiAtCQkJZHdjM19nYWRnZXRfc3VzcGVuZF9pbnRlcnJ1cHQo
ZHdjLCBldmVudC0+ZXZlbnRfaW5mbyk7DQo+ICsJCWlmICghRFdDM19WRVJfSVNfUFJJT1IoRFdD
MywgMjMwQSkpIHsNCj4gKwkJCS8qDQo+ICsJCQkgKiBBIHNwdXJpb3VzIFUzIHN1c3BlbmQgZXZl
bnQgaXMgZmlyZWQgZHVyaW5nIEhTIGxpbmsNCj4gKwkJCSAqIHRyYWluaW5nIGJlZm9yZSBDT05O
RUNUX0RPTkUgc2V0cyB0aGUgZ2FkZ2V0IHNwZWVkLg0KPiArCQkJICogSWdub3JlIGl0IGF0IHRo
YXQgcG9pbnQgdG8gYXZvaWQgdHJpZ2dlcmluZyBhbiB1bndhbnRlZA0KPiArCQkJICogY29tcG9z
aXRlX3N1c3BlbmQuIEEgZ2VudWluZSBzdXNwZW5kIGF0IEFERFJFU1Mgc3RhdGUNCj4gKwkJCSAq
IChyZXF1aXJlZCBmb3IgQkMxLjIgY29tcGxpYW5jZSkgb25seSBhcnJpdmVzIGFmdGVyDQo+ICsJ
CQkgKiBDT05ORUNUX0RPTkUsIHNvIGdhZGdldC0+c3BlZWQgaXMgbm8gbG9uZ2VyIFVOS05PV04g
dGhlbi4NCj4gKwkJCSAqLw0KPiArCQkJaWYgKGR3Yy0+Z2FkZ2V0LT5zcGVlZCAhPSBVU0JfU1BF
RURfVU5LTk9XTikNCj4gKwkJCQlkd2MzX2dhZGdldF9zdXNwZW5kX2ludGVycnVwdChkd2MsIGV2
ZW50LT5ldmVudF9pbmZvKTsNCj4gKwkJfQ0KPiAgCQlicmVhazsNCj4gIAljYXNlIERXQzNfREVW
SUNFX0VWRU5UX1NPRjoNCj4gIAljYXNlIERXQzNfREVWSUNFX0VWRU5UX0VSUkFUSUNfRVJST1I6
DQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5n
dXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
