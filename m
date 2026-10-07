Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135FB38D017;
	Thu,  8 Oct 2026 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417606; cv=fail; b=jFGxfalnLrbdRiRDl6N+fVVNofxgzQ+76PoASSwnR7OpEZJ83U+sb+nrNIDDeEFNVBlCrWSwb7EeqHfkLFbrTksl5MnqQ+ZcbwupBTcfDHp46bU3G4l44/6Hlt62yMRlOiD0+XPJKZIGAGUbE+J0f1gUknc1FOefCnAf92WeW8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417606; c=relaxed/simple;
	bh=HN8/K7xJEJjDhmNmStP3vX99Z2JF79MYchm4ehBK1aQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSuRCpgHx4mgDz3x0ayZt1V7KtdLK4n0AEIKSeJRNQCgUdC2RAGAMNWEFP5q69elRTcJcYOrQnx955TBjb9KzvzhzrMYgxbGn0Xo1i04KWPVMDkvSiEQA/wQHpODO0uPQldGdWTRxVAGmXxXFOB7lCpSI5mBfWPg78fuYpvvlqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eyEpqoFt; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DiGSPLDu; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RF6amXwK reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eyEpqoFt";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DiGSPLDu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RF6amXwK"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697LsoVm1873928;
	Wed, 7 Oct 2026 16:59:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=HN8/K7xJEJjDhmNmStP3vX99Z2JF79MYchm4ehBK1aQ=; b=
	eyEpqoFtAD/VvXBqlXnlFMdRgILFRLZO2DmjUgMFGIulz9Sr73er1DppSSq48UK6
	M/hdHJ+U/SvmnPAq7I80fbXs1cVkZSst/oAiCUD6gJ184qFbydJAtVqVZOaQFmFe
	VX8fDnJfLiTbYaso6ofkojOp1WopFtiscczou10BePrs7T7FMgD4/wKAZmCge8jz
	s74h30HYECv2GDCn69pDytGR4rncJZQot/mS03sjygyr7EskSh0pFumK8KAbUQ5W
	/jD/PWm6XSuFCRiWsYnLsjVilkLooXdSxuElsBmKonN2zHfgzIk9R+bk9yjzVR9U
	oROm0nY8lkSNFxzLJ5rmzw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4h5xd30hen-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1791417596; bh=HN8/K7xJEJjDhmNmStP3vX99Z2JF79MYchm4ehBK1aQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DiGSPLDuQrKUXdKB7EIRTg94qE2NcPjimOqrpoy/qrHijHqcMM+OFhTNIuv8B2/Ry
	 U+r0gwuVdAjctoq254Ryue1lSPtb36KvXMrqCNIcNkwTbO2sTTpySKNbYnwApagt+S
	 Zo8OLpZn55vK1ZfNQdgzqdOLO5bK47YQyJWePmnmkU/9G/ncSWJw4ZyJQ3sGBP35Sp
	 vi4azvJFXjRpPjna6l9vnAD97khuXCR2fP1BYmEzqQZwr2lAaqMk+5YlGScNKVKWt5
	 iG2M5vWz3idZvLnmTOgmANsnAyCeKYWZxcvJZ+zvUlqeNxECAP+B+EgANSQGa+RHNN
	 I5KGQu87V4Pkg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7B80940142;
	Wed,  7 Oct 2026 23:59:56 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id EBC5BA00B8;
	Wed,  7 Oct 2026 23:59:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RF6amXwK;
	dkim-atps=neutral
Received: from BL0PR07CU001.outbound.protection.outlook.com (mail-bl0pr07cu00102.outbound.protection.outlook.com [40.93.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 274C940082;
	Wed,  7 Oct 2026 23:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQL12TnVEyP0dP9ClYXiMNRS2/0zYTQfyUzddFZzAhmwzIPbJelWsx38tzXQYWxsENkBv+JPXRp693RA1G3SgmS7Dqjp/m8EIrPLgvBSDgkJSsLSKjoOZWlyDAkn9KNGm3JaiW9rFib+DTtu795RETwgItYWGFUk/XD1mWThvJx4S8/lectr3v3DIK8qSxztr3CWq6Pirc2Z80GGWtvXXosGEW6+T3qwZY/AVSua2IfNg/grtra1l+LaabXqeMhiJ9oCBf98HlGUWdQxreR0CQizVOoP6mMcrzLb8J2+hF/zm6lMO9KLdm5ERXvZNfgGq3FCiYxOPrNlvN0k2GNpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN8/K7xJEJjDhmNmStP3vX99Z2JF79MYchm4ehBK1aQ=;
 b=Y54+u3uJ+YK0MRy5J/7sUKEoALR/60bztwD7r2tjeLY//DNwTCJzkGW5GfFsPqFprq9iUd7d1XclyA3elJLietr/mq+nqU8TRRqJ3tGN85vTqiTwNycwuYxFju8xoEh7A3EeQhMt/EQGMVColWLeflUMR2jZWh560khBgQKzaiV8jDfOP9uRBgyZrBJY1pQmCMoSB9Huxikv8hDsn9ZvAjYwDb8i9DXvZzswABwgezfRMXywSltn2j9acy18AM3GWmhESOmJ/kVPqRItN/hzFP1sEKT+KlPjnLiDVdtVkTjQgOdb0w5jMj/meeX/P94i/DM4shhaz1OJi6tPC8wAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN8/K7xJEJjDhmNmStP3vX99Z2JF79MYchm4ehBK1aQ=;
 b=RF6amXwKyViPUGI8lVGuIDKPYygzMrtUefKIkNwP3B/HEbrdLEW1TPO3uwiLMBC7W9hY67gH2Q6MO8O18M/a0ewa+3xtYs/YranFu1RG3Qewr98D0YOAc2L7JkVJ8YtvinPln4nCrMbweqv3Mnm6/g/pOa9q7/4dFkvofJbFocc=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Wed, 7 Oct
 2026 23:59:45 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 23:59:45 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "pritam.sutar@samsung.com" <pritam.sutar@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Index:
 AQHcp+KIOUWlRKngOUe8KQBAqja6m7WXQjCAgAS6jYCABYeXgIAAj9uAgTzV/YCAB0WsAIAAQgCAgAXz24CABaAIgIAAq3WAgADGm4CAAATnAIAAo2GA
Date: Wed, 7 Oct 2026 23:59:44 +0000
Message-ID: <asbJfaj5OIhHBunD@vbox>
References: <20260306214123.3jnlzd2tmtwggch2@synopsys.com>
 <7f8a7341-3701-4ade-a198-cf86719da931@samsung.com> <arsnMM-GvuXwBKCX@vbox>
 <5d7501ea-4579-44a5-9a7e-91ef1f10b2bb@samsung.com> <asBhDmy-3DymDKQH@vbox>
 <3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com>
 <CGME20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6@epcas5p1.samsung.com>
 <asWmW1jmzedIV5SP@vbox> <ff5d6900-374b-44d8-967f-0af16ae53437@samsung.com>
 <98f16da0-5e24-4dd1-8f9f-79a1a5e7656c@samsung.com>
In-Reply-To: <98f16da0-5e24-4dd1-8f9f-79a1a5e7656c@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|SJ1PR12MB6243:EE_
x-ms-office365-filtering-correlation-id: d5750a7f-6baf-4ac0-1d83-08df24cf0fc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|22082099003|38070700021|4143699003|10067099003|5023799004|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info:
 JiDHvIbCC+aTNPnlCkGmvRNeUwicFvUYarrzTssviDdiRPUOE4mOhbEBx3s3G/JRmeoBVN9g73kUs+FGfivl6j5mUWIjxBGHyLM8LfoIG+VzgXal+JhIaPPG4IT+VpagBoUoMEIPrZ5HK78scHPcWkbLNl9RCRzYkDbaGe36v7cnsGpiaFZ7W+nuRABcv1gHmdiPU+RF5m12ucqGUJNp4NiOfehE9vsITuqu50aPdJyjodE52UgvJMGNF8/mYFlnf0bGSV1SFGF1eh6beuqbwfWhWJY1ECntDk4czIQV9/LneYum6SWsuFTLS2i+yIf7DGnUnGyyk/OoceCsXVEmgw0dNi/fpuiQJGgKAgPbqpL+bD7I7+XCJuNj+ngcfRNEZrxqhVjAS+jygtBpUgMdCApKNULml/n+R8fJQgp0oss0GUHLu+54z98m3OlSD/FMc2iZjzYNOZk5u5XHQM7u4zvoGqFVC9CgW7ABvb6+Bjde5S06kcxHsgD4L1TpKJ3wK7DAof2QiRJnwLPhKg606xtxJy6GHqgRWYz6UieZ8gxbyb3gXoSGd6MgFiWIs1M0c5GlhZNi/2at9ETI0t+L7X9coE+nVZF9kaxW+219ITyt/mN3lfLn2wUx6iE44wgSdI/NKoG1wJNoKB1uxRWC+nw8y3SumYD/1pJrEWapBSPyR5UIJwdICxF2PG2yzosfGl8wIulvOTyjlf3B2ov7F9hdwfy7/vsFLcQcYQ9ZdCk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(22082099003)(38070700021)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3E3aTZRQ3VsSVNzU245U3pCRFFnSGtWVHhCMkdNS2RUdlFIY0w1T1pza045?=
 =?utf-8?B?cVhDOGh4SE1pb05QTjdKTnFSTG13NDk5YWozeFVFVmhRT29OdWtyMXJ1WEFM?=
 =?utf-8?B?NngzYWlBeVZxQVRxdTgvMnpaQmhtUGp4cnRmVS96MUZYa2RQVE1ZZldmUmRv?=
 =?utf-8?B?OWdNSGowN1V3TVdIbXFiVGdlR3BNdG1ZUHhBUExuN1B5RUVSZU1xQ1Y2R1lZ?=
 =?utf-8?B?bUI1cXNMUmJrVWpEK2pucmxzRHBQcG85WUJmN0lGSDdFVFRWYUttWU1mQ3Uz?=
 =?utf-8?B?eU9DSkFJc0NGZzhrTTY5VFBsOXdGaTI3VXpiUDVZcWcyNUNRemdqdlM0WENv?=
 =?utf-8?B?MzlrRkl0ZFM3MVJQK3lFRHArQTFGdkZxeWhCMHR4a2JOOS9kbTRFcFZmUjdJ?=
 =?utf-8?B?blJtTitKeURiOVVxV1FKSWVBNmpsUkF1b1J2cXRKRDJFRHNYZjRZaGtpNVV5?=
 =?utf-8?B?bThzQUgxWW11bWVuYWNpSzhQY1RiZmJxOTZXU0QxRG85MExyWU01WVNqcUlP?=
 =?utf-8?B?OHo5NVI0enJqMVhSNUFFK09nL21nTU13cmRxb2d5RjZUaGkrZlBWb0VCc3Jk?=
 =?utf-8?B?WTVhVWVzalJEdVpmSCtOSWhMOVlNSk1Xa2drQTU3NzdGeXM3ZEs0aGVCVFB2?=
 =?utf-8?B?cGh5dWZyUVN6Y2p5ZUpuSks1eExYV2szTmozN3JlODF3WFRqVE1kSVhSS0RD?=
 =?utf-8?B?SnFXNXZmMzJsN1ZualBwQVJTQUlOMmc0akMzWHVFeHZJbHlQUTZ1dG9HYTli?=
 =?utf-8?B?azVqaFNBYSszK2o1eWw1cnlGNDNRQmdZdkRQRnAyb2pwbXRrRnBGM2kxZWZ3?=
 =?utf-8?B?dmRqS2lkN1NUNHpMNzduY3IyNldkSnFiSUd0RjlwS3hMRlQxQ1ErU0dXeVBL?=
 =?utf-8?B?d29qbnhKcWpqZHBiRUJnMU5vMi93YW1RTGp0ZlNCM2NYWjdQdmIyMUV1NHh0?=
 =?utf-8?B?aXV1NG5FNjBiTVRPM0dtYkpIcWVzeXN1Nkw2MnEzRFZGamZsR1prQXpTOW9M?=
 =?utf-8?B?UTlyNXM0bkVjNUdSRTBWYm5pUHdabG00Ymtudm03QmZiMU0raFRNalc4TnJw?=
 =?utf-8?B?K3UwZzlKRWRrZ1lrc3lhRjh6TDVHOFNBL0wyZU9DNFVaTFJ0eW1nd3c1ZjY0?=
 =?utf-8?B?V3BtVDhwZ05EMlllK0JCSWh0c21RU3pkRm1Ja016ZWkxcTdyNFp1QkxIa0FC?=
 =?utf-8?B?anMzcEl1ajVZWTZ5RTRuYVpLL2U4eG9yNFpETmtseDRLeUtrMjlxNTd4Ym55?=
 =?utf-8?B?bEZKZFFKVnhvNkt2RHNDMngrQlpJS01xSlpPV2djZ0FvRURQdFFNbVRockdH?=
 =?utf-8?B?OE11eG0xZ3BHekRPUXJhV2lJQWd3OVFNcHdOd2p2b3VMT2lZcmVqL1IrNkhz?=
 =?utf-8?B?MG8yNGZnTUtBSFgvbWJRV0tSay95cTUydWxFQzdJdDRoM1hvVjh0M1ZxdDBK?=
 =?utf-8?B?VXZVaXI5eXovU05SZkwzWU9kZk5WTWdjSUwzQSt6S2VWNUtoQ3FidWpmM3hG?=
 =?utf-8?B?RXlUS2ZKQ0hyNmJwa0dIam5Xck5OK3psWG5sWVhoVHFxRU9tMHFwTG1Hbkgr?=
 =?utf-8?B?TjBuNUU5cld5cnI2U3VSUUhzdWxjaDNFdlI1U3hmTGVzQUdRaW5Gd00xNUNN?=
 =?utf-8?B?RzBTNm40V05qZldWMnhxd2kyNko2ajJBUzNFLzZDSmtJRklHY29RL1VSSk5L?=
 =?utf-8?B?MFJZc0JBQk9kSGR3YnZQRHc1UDhwaVBpalNUdUptMTN3Q1E0WUlqWkhtTCty?=
 =?utf-8?B?cXQ4cUhrMWtoc211MnlJN3NSVXBVa21QT09XYjRHaEozTHNkQnFFYnIrbjY1?=
 =?utf-8?B?ZDZsVVAxazNFamtjZUpLU29BNWViWk0rRUcrZnhERUkvdnUxbGhlU1BYVnVh?=
 =?utf-8?B?bm9BTWpTRnZobWwwSkR5aEVqRlZUUzBWWlZuZ091czcxbVU0UVVRa0I0c0JC?=
 =?utf-8?B?eFV0K2N1TDIxd0p3ZHpQRTlKSFpPWFlaNWwwZ1NNUWNGZWdRUEsrOGp5bzhs?=
 =?utf-8?B?Z0NiMlhrWVNMR0NSbzA1TFgvMVdjakFRdERZc0R6Vi9GTkdES0VWYjQ5ZFI2?=
 =?utf-8?B?aEd4Z0RQYzVOYVYrdndaNDV3NDREOC9yV3prTU01Ulp5NzlKeWhuM2pNcmJ0?=
 =?utf-8?B?ZGxBWStBSXYyREFSNXN3R25Na2s3dFowNW9SOFNZZG1ndy9LclhFUkNvOUw3?=
 =?utf-8?B?a0VJbTEySWxsVHZxeVdISkFTanMrR21WVVA3SDNJNElYM2ZJL25rcmhOZGE5?=
 =?utf-8?B?bUV0em8zdzVyMURyUnVXY0I4Rk5FOXdFWkEyTEtnR0oxRDBuQU5wUUxvcXU3?=
 =?utf-8?B?YUtkM0IxK2R6bFowOTI4WXVPYnhDTzM2cTU2ZC9KQ1NwazdZenpCZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5BCA23EE637A445AED2896FBB2AA3F8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	aPl9HSm1nHlLw75AL9Q9oqq7uiXvig1BXWoEC20JF4tGNCMBu1pK+jN/4aPWdU8+sXu9lrA+/dRHer5MnnV8urq/DR7m41gZ6BqnV3IhNxoXfDFiUG+ohH7/gX9PseZdeoJpF/tk5BU/ZRmci6iVTBxGeznQi+PrhWjwz3BFDGB+IsxpFmX6XHRd18w0Y7i1orIyY7dlt8BEQX1Vlxaf2doAAHYVCPdXnk9CMGFdsOx4MhStJOcxTyJ/e1EfqHWNfky6bJJE0nxqdA4D+KRdv86tA8XYRsg5yl+WyTu2CasGKFHUk2li1PVyII/zW2FaIDy56nnfg5BEMdQVN+2XHg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s8LBcyLfuHvcY5oDZKG/IznPz7ot5kx18XsqxJZIJEtVnk2jKp29P4bRlo2LmVY+FT/K8VOM2K6QhDynLDtlsEoDVmipZheqaqqFLAPC5Cy058Q+wyxUeKZoivyq3JCy8t+OzUYEvLnS5OoWhj+RJRww6jhBFZw2cnPP8SnkouhDX7GHp0NGh/VVfknh3/Tv2FA2xblETlYcIDlndXy/5SPGsI4enX/AHCezLuFR58Tgm2/zTx36im4RWipmwxt3bNIk6TXC2fkbkCuC/g3G4G0qFqlTC2LDYosg9uWBRLaRPFfu8BlIIyaCINbpC2JKhQ/v0oqPSKJf22Jl12md26zi1rk9eyow1MNeDQnLIz7aeSKcMr12NVjXcGYM/Rlha1DfZvztOzI8+48KhX48WM6NgAc2qpk2fSGFRYBdx1ukhNHtmao04V5nZFpFgxx2ggkS8akGD65SN8MHhVmaVq+qzTuAhJXNvTQWN4raYYZya4Q6A103NmtgBS0XT8jq2OJyqmbPc6Hlt+2DqoQ6hY3Ctj7epOWkjllQMtdiv19o2Hjkf/zyFM7QxEfekPmST90ORfu9ncZYmV3sPmu/YmpOFma28dLhdbiFN/yIpSsK3kTF1KIsHZPwdzG/lmHW4cD5TrQZDTlEqjerZH2y8A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5750a7f-6baf-4ac0-1d83-08df24cf0fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 23:59:45.0522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CpebWiANaQkmCp14FEKgwEhhJfxzaicX9j3gOrmsepRvp61vZY84X9a7YuYF9ucgri0Qi1nHEHl1tZ3ifCz/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
X-Proofpoint-GUID: Gr_xRUMEhsUpfKooOUtTIpyzgo9NRzAN
X-Proofpoint-ORIG-GUID: Gr_xRUMEhsUpfKooOUtTIpyzgo9NRzAN
X-Authority-Analysis: v=2.4 cv=eYOo7LEH c=1 sm=1 tr=0 ts=6ac6dcfd cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=wxhFYZnfE-4rQSit0K0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5NSBTYWx0ZWRfX/ma8MNxe6ylk
 uln8Z3LYKB/K6hzx1FWtQzD3ayEfUO5p51yZhvCON5Innc2KqpJUFQBw2djHkqPc/IX9QtYwgbr
 VNWKKWWDjDDpYWROrWZYBTnc/WVkST8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5NSBTYWx0ZWRfX7gmCdk5c60Ae
 UsDplu7oSJ3r4HiiM8vV7hbCnev2y4k41ap2SbtyJALFnD3smXi8QS7el3onExSUl6uw5uCRs27
 S53dCkCIYdbNFqHiPB61rViHME5oLqFa01GzUJEAU0RyhWoBwEZnkSurPlUAdMpJbmM5zJ13Xg4
 03pkZfRHWLsmIli/AZUNUhPoBv/ceO0Fcj8B2kRsa2QxY0j8PGRq57wiEdDX6Q2anuBYoIZ8rl9
 qEnJVc+dRrWH/2m1kZ2xmteT32xfHFx5HOMTWKVrNcYggKFNwVNpTSTmuCyKxcp3evLY21CDvy8
 hIXzJr0YBMNK5oIaEwPsBvF26cye9KzMMYEUGfTPT1/mZtqjm8fb4o83pJz/r7mKhmejDeO990V
 /mF8P55pUR9hHgslNytmE1rICegLVnhTvGWed4fX7Cneaxbw0nWWd5GVyGD04W+n1+y/aeKEdj9
 majItLlC2Hz1foAmwow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610020000 definitions=main-2610070095

T24gV2VkLCBPY3QgMDcsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gU29y
cnkgZm9yIHRoZSBmb3JtYXQgaXNzdWUuIFRoZSB1cGRhdGVkIGFuc3dlcnMgYXMgYmVsb3csDQo+
IA0KPiBObywgdGhlIGVuZHBvaW50IGNvbXBsZXRpb24gZXZlbnQgaXMgbm90IHNlZW4gYWZ0ZXIg
dGhlIC1FVElNRURPVVQgZXJyb3IuDQo+IA0KPiBUaGUgcHJvcG9zZWQgZml4IHdvcmtzIHdlbGwg
Zm9yIHRoZSBfX2R3YzNfZ2FkZ2V0X2VwX3NldF9oYWx0IHNlcXVlbmNlLCANCj4gd2hlcmUgRFdD
M19FUF9FTkRfVFJBTlNGRVJfUEVORElORyBtdXN0IGJlIHNldCB0byBwcmV2ZW50IGR3YzNfZXBf
cXVldWUgDQo+IGZyb20gc3RhcnRpbmcgYSBuZXcgdHJhbnNmZXIgZHVyaW5nIGEgRVAgdHJhbnNm
ZXIgdGltZW91dC4NCj4gDQo+IEJ1dCwgdGhpcyBpcyB1bm5lY2Vzc2FyeSBmb3IgX19kd2MzX2dh
ZGdldF9lcF9kaXNhYmxlLiBTaW5jZSB0aGVyZSdzIG5vIA0KPiB3YXkgdG8gY2xlYXIgdGhlIHBl
bmRpbmcgZmxhZyBpZiB0aGUgaW50ZXJydXB0IGlzIG1pc3NlZCBhbmQgbm8gDQo+IGR3YzNfZXBf
cXVldWUgY2FsbHMgb2NjdXIgdW50aWwgdGhlIEVQIGlzIHJlLWVuYWJsZWQsIHByZXNlcnZpbmcg
DQo+IERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcgaGVyZSBwcm92aWRlcyBubyBiZW5lZml0
Lg0KPiANCj4gU28sIHRoZSBiZWxvdyBjaGFuZ2VzIGlzIG5vdCBuZWNlc3NhcnkgaW4gZXAgZGlz
YWJsZSwNCj4gDQoNCldlIHN0aWxsIG5lZWQgdG8ga2VlcCBEV0MzX0VQX0VORF9UUkFOU0ZFUl9Q
RU5ESU5HIGluIGVwX2Rpc2FibGUuIFRoYXQncw0KZm9yIHRoZSBub3JtYWwgY2FzZSB3aGVyZSB0
aGUgRW5kIFRyYW5zZmVyIGNvbXBsZXRlcyBhZnRlciBlcF9kaXNhYmxlDQpyZXR1cm5zLCB3aGlj
aCBpcyB0aGUgb3JpZ2luYWwgaXNzdWUuIElmIHRoZSBjb21tYW5kIG5ldmVyIGNvbXBsZXRlcywN
CnRoZSBlbmRwb2ludCByZXNvdXJjZSBpcyBzdHVjayByZWdhcmRsZXNzLiBDbGVhcmluZyB0aGUg
ZmxhZyBvbmx5IGxlYWQNCnRvIGEgTk9fUkVTT1VSQ0UgZXJyb3IgbGF0ZXIuDQoNCkFzIGZvciB0
aGUgZHdjM19nYWRnZXRfZXBfcXVldWUoKSByYWNlIGR1cmluZyBnaXZlYmFjaywga2VlcGluZw0K
RFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEIGlzbid0IHJpZ2h0LiBXZSBzaG91bGQgcmVqZWN0IHRo
ZSBxdWV1ZSB3aGVuDQp0aGUgZW5kcG9pbnQgaXMgZGlzYWJsZWQuIFRoaXMgc2hvdWxkIGJlIGEg
c2VwYXJhdGUgcGF0Y2g6DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
IGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KaW5kZXggZWU4MzcyMzU2MzBhLi5lYjY2NjZi
N2JiOTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQorKysgYi9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQpAQCAtMTA4NCw2ICsxMDg0LDggQEAgc3RhdGljIGludCBf
X2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoc3RydWN0IGR3YzNfZXAgKmRlcCkNCiAJcmVnICY9IH5E
V0MzX0RBTEVQRU5BX0VQKGRlcC0+bnVtYmVyKTsNCiAJZHdjM193cml0ZWwoZHdjLCBEV0MzX0RB
TEVQRU5BLCByZWcpOw0KIA0KKwlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX0VOQUJMRUQ7DQorDQog
CWR3YzNfcmVtb3ZlX3JlcXVlc3RzKGR3YywgZGVwLCAtRVNIVVRET1dOKTsNCiANCiAJZGVwLT5z
dHJlYW1fY2FwYWJsZSA9IGZhbHNlOw0KQEAgLTE5OTAsNyArMTk5Miw4IEBAIHN0YXRpYyBpbnQg
X19kd2MzX2dhZGdldF9lcF9xdWV1ZShzdHJ1Y3QgZHdjM19lcCAqZGVwLCBzdHJ1Y3QgZHdjM19y
ZXF1ZXN0ICpyZXEpDQogew0KIAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGRlcC0+ZHdjOw0KIA0KLQlp
ZiAoIWRlcC0+ZW5kcG9pbnQuZGVzYyB8fCAhZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCB8fCAhZHdj
LT5jb25uZWN0ZWQpIHsNCisJaWYgKCEoZGVwLT5mbGFncyAmIERXQzNfRVBfRU5BQkxFRCkgfHwg
IWRlcC0+ZW5kcG9pbnQuZGVzYyB8fA0KKwkgICAgIWR3Yy0+cHVsbHVwc19jb25uZWN0ZWQgfHwg
IWR3Yy0+Y29ubmVjdGVkKSB7DQogCQlkZXZfZGJnKGR3Yy0+ZGV2LCAiJXM6IGNhbid0IHF1ZXVl
IHRvIGRpc2FibGVkIGVuZHBvaW50XG4iLA0KIAkJCQlkZXAtPm5hbWUpOw0KIAkJcmV0dXJuIC1F
U0hVVERPV047DQoNCg0KVGhlIEVuZCBUcmFuc2ZlciBjb21tYW5kIG5vdCBjb21wbGV0aW5nIGlz
IGFsc28gYSBzZXBhcmF0ZSBpc3N1ZS4gSQ0KYXNrZWQgeW91IHRvIGNoZWNrIHdoZXRoZXIgdGhl
IGNvbW1hbmQgd291bGQgZXZlbnR1YWxseSBjb21wbGV0ZSB3aXRoDQp0aGUgYWRkaXRpb25hbCBj
b2RlLCBhbmQgaXQgYXBwZWFycyBpdCBkb2Vzbid0Lg0KDQpDYW4geW91IHByb3ZpZGUgc29tZSBt
b3JlIGluZm8gb24geW91ciBzZXR1cDoNCiAqIElQIGFuZCB2ZXJzaW9uDQogKiBjb25uZWN0ZWQg
c3BlZWQNCiAqIGVuZHBvaW50IGRpcmVjdGlvbiAoaXMgaXQgYWx3YXlzIE9VVD8pDQogKiBJcyB0
aGVyZSBhbnkgYWN0aXZlIHRyYW5zZmVyDQogKiB0cmFjZXBvaW50cw0KDQpUaGFua3MsDQpUaGlu
aA==
