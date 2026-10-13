Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0FE421242;
	Tue, 13 Oct 2026 01:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791856362; cv=fail; b=TlUdWAGomroAmwnpgL5QmfJq20/w7Z00939Yz0ETR4AuleiwPnVr1H7MB+D3VeCb9X/hTXMGWGrlNE8N03hPFQH81SN7iF0KOlmPX2vIRr2dMHkbJBRo8abCU5sX8NdUsoOZpxyDOqox2qqq/rtEtVvE3qL6eMGgEGqrklUv1jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791856362; c=relaxed/simple;
	bh=BtgYVEV8CLiK70HPafMz6hEppU/RBMun8zEtSpjwwME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SORdTe1wp/OupKDS2U88DgGfdgGVXi3HezWFfPaoQ0puoLaDra+hSdUiklNvoGc39PprQOKNuR9XWHyXfwaXjlQTRMJ8hjAnNjQTmhJ1ykvZcimbIAKPRX8JM3Xz4Mry8JfpHW++PbdTXaIqtImHU3wn1QffqT09A14M8Jzalew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ubTe3wh4; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eM65Flpa; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VMma1KEs reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ubTe3wh4";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eM65Flpa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VMma1KEs"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CNehA82982552;
	Mon, 12 Oct 2026 18:52:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=BtgYVEV8CLiK70HPafMz6hEppU/RBMun8zEtSpjwwME=; b=
	ubTe3wh4gS/+BAKpT/4E/fjceVF1WsHuD3DGtwX3+G6OxIviXeX3aL0ugzdjfdi/
	pNTsn2YgxHFWaCdGOgX70G+wbtqHUPaQ3OZ+OgRG2bsMbC8+Z6he73lMtHqB3Ljs
	XVDb8FcSASTM7TrdBdqQh4RtloEtS7yyyrAYVFHwZo6EH6YyMu9oV6+8JvBNotRe
	15UZjYH6r3ageO0B/Si4KRozHFjmXJSIi6jpF6MYsD8mY2WLdpqC/8sr1vv7WJmT
	wdhSqOc484xH9GXU75T/d2MFX/3OIfHR1mU4l9KnEhN5D8cyzwLU9k1kf7IJms91
	druLRH1YFPHscOmpSeZA9g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4h9419aa1b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1791856349; bh=BtgYVEV8CLiK70HPafMz6hEppU/RBMun8zEtSpjwwME=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=eM65FlpaXsx2XzOC/p/gclpQ8GGtMb7DVKOkFkj6X5jm4JT2j4NosTes0+npLnQaj
	 u9WFtAYtW/zDSsII/pKV4DCemSnO16+ri81+d6A4hidqujkhxTmQlAqpFNu1FjkTaj
	 58oDHGZuWrXHoE4+qhMElO49triqlGhSS3PV6mBcdFz5zwRVU/7MNk3gfHj6jC448S
	 iS0hzM/LxG31ZIi+QEFz19G1SW+fCKjH8xifgTuRXz8YVHzKZwfKkB0O4WQ77GHb/+
	 Ah63bcTlH64PKlYNEajP2QFGU62AgzPRef2ERO2coTKBWcZGCXXkUnZXVnQPy2aHvH
	 wpOGJF8snGcBw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EF7A0404F3;
	Tue, 13 Oct 2026 01:52:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 53D31A0088;
	Tue, 13 Oct 2026 01:52:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=VMma1KEs;
	dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com (mail-dm5pr08cu00401.outbound.protection.outlook.com [40.93.13.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 806644021F;
	Tue, 13 Oct 2026 01:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjP5DsLmATAWRt8cdn1+W+P1Ee4AcaFJUAQFu4xsgH7szoXjdvv+PWbXQY6yDv/0KUfJ9Dw+2J6E+JPhyYBw5oCIMLHnQLjgcLUO9jaj8NrdtRqK9WC/9HaiOn6Aq10KoSukomt25sIwblNMwObJElpjHsvjsm+lXIjTogT3ycwdSyuizuFOueyw5Czz4jTG6ghV9PGfvqSJWcS+4ZxlwxSJ+Jl0pvTcULv97t1AxpixqSaj20bAw4JlqnMWElUQEhjza4f2idqwX2GQn3GwDhcA3GNUEwjTv+OLbtE8s59LcMpwgU0zpPYlLvEG5ALAelamI6UuIO88VdY5Es0iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtgYVEV8CLiK70HPafMz6hEppU/RBMun8zEtSpjwwME=;
 b=jUQfhE0XDe5XPcNnBuDz6wmkoaYrwOTF6gG0OGh1hKifsOAaPuY0N0QZjYjYUo2T4JVPzINVLYXxEMQ3z0dsPmEwsL2MI7vT4HoisHA+nkNjkx5TI+Ft/KCYG9yr00T2QLf6kNXennfBsSvubW380DuwsOTrN7rHGkLXb+UKJH3ZxapJxZPHsoI+fyJmlbkqbLcrnyqtXbkWTecyVCCQ0WcSJw0YNU4pYrqNrId3rinx5crBmc8glWoGvyYpnD/ggKXz8f28cGPURpjGmBblT9EkBVjGGkda6slR2NbjTmfKbb9G8mrEF7OK/ieYZN7h1ickC/0Acs05S12dW2OBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtgYVEV8CLiK70HPafMz6hEppU/RBMun8zEtSpjwwME=;
 b=VMma1KEsFK7/S/sAaPatqLepK2KMpm0gbeY1LFnNAiFFsSAalix/8gTtNBcthRfV81q85/kK6MrCLWfBR725V7zrq0z+2xeBC70KIqwBXmNzFnT9dfc6exHIXpK6+4lw7AcPqltuJcDjTBj/NQ3IMkSJSASByb9AAuKEEjFDCiU=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 01:52:23 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 01:52:17 +0000
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
 AQHcp+KIOUWlRKngOUe8KQBAqja6m7WXQjCAgAS6jYCABYeXgIAAj9uAgTzV/YCAB0WsAIAAQgCAgAXz24CABaAIgIAAq3WAgADGm4CAAATnAIAAo2GAgABNrwCAAUxggIAFyh8AgACW7YA=
Date: Tue, 13 Oct 2026 01:52:16 +0000
Message-ID: <as2N1JlPnpKBYcsb@vbox>
References: <asBhDmy-3DymDKQH@vbox>
 <3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com>
 <CGME20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6@epcas5p1.samsung.com>
 <asWmW1jmzedIV5SP@vbox> <ff5d6900-374b-44d8-967f-0af16ae53437@samsung.com>
 <98f16da0-5e24-4dd1-8f9f-79a1a5e7656c@samsung.com> <asbJfaj5OIhHBunD@vbox>
 <bc43e3f5-ba0c-4f91-b765-ee35021bf089@samsung.com> <asglyrMYkopr3EOz@vbox>
 <0a2bc277-3977-46cd-9759-ba273b5c2c4d@samsung.com>
In-Reply-To: <0a2bc277-3977-46cd-9759-ba273b5c2c4d@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CH2PR12MB4293:EE_
x-ms-office365-filtering-correlation-id: e1cfd5c5-d586-4c24-6085-08df28cc9c44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|5023799004|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 x75uUz7SA/PDHJDPwmOVUvfvF7GYOws/3cjWrfg9et97SCePXjC3RQUhev3S8QYRDJDOUKSzMa6+Qu6ziEpBkMiy1TNOMdyL9y+CxyCXbHGBuGse2UzFUXyLLntDy8G5Aeq0yYiT0/y0SCCM8PYpbOgrJ3rBgWFprEWp7xSeCKkKpry/Nr+2EFi2YmFrHOn5wkAkQvYShlCOpDVQojnnxeXjOsJTdv3c5NLP2G33dNIDhuIM50CsJsTJTCNOHdtTJMFv/F3RKBvDvHFrPrmFfeV/jBTSABkagZ+2Kq560cS5bYHnjqKFjgRWePWlShcGA2Ewx6h9hbfkC45Jko283UEmfOsaHeU+QKw0KbPGmxUlmB0Xd7pcronAtNcNrRngJo19eax45cQdiDEt73LWBqGptzxLh/k48rjuc63nAn7PGjSdkIqMinj10B0S2up0UgQrsEn2SL/8ZM2mdWCUQC95q8t07aP4Mwa4/+hFTAuefgzfcJsaYJIADYzaOUe8s5CicOELPEJUgZGIX7o9khBUvCBeWr2MF7ao8gcU9CAy4d+zDUpkFAv+966FMige/10b0HbeUbnXKkwythHiFM2RRaZ5qqNmpUVliCyT5ccxXhCHLmX8SYfRgrOwfA6A2wjn2Q1a8Q2RBVwkSvsd7asscJZMcfiusps1nwCq4YOeUyk7kwHmvhGFWkTIurmw+69ZnPQDazJSWpPfBA4JWOFqx5gRJFU3sGY3AIXN/iE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(5023799004)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3pXUG9SdGdHMTR5d0RMaVBNM1ZNQU91R1ZQT3BVYXpSakRFUmNtSDhmWFJG?=
 =?utf-8?B?akw1MjMyM2ltYTRGQWIvNXNOK3pCUldsUE54ZWhjWkltNWlvZ3dHK0t0NmEy?=
 =?utf-8?B?MGZ0eHJTbG9VbllTUGV2MG9HQi9jNXlwTHdZUDlydGlSK0lBWkl3d1Rqampy?=
 =?utf-8?B?dVdUTmcyd2o5WWhhZVArQVNJMWtvTDNlUEVOZGpyNTBkZmh6MFRHMTdRRzZN?=
 =?utf-8?B?Y2hJL3kyUkZjRHVLcVlicmt3blVuV0xtL3hZWmVzSUhDamxRZmpjRUZTMHNM?=
 =?utf-8?B?S25Pajd3Nyt3R2V1SlNVZmJOZFNFNGR2UnUrWWF2UGJvcWV5UFBwN0VldjhT?=
 =?utf-8?B?cDZkNGlJOFNXR2w3TU8rUkp3UDBucnFlRWo0Uk5XMTZVcVRQNmN4KzJXNDg1?=
 =?utf-8?B?THNPeUdHRVluaGh4RGNKSytqWm5wcE1rNG1CWm9qbWhCTndwa0hxVmRCbjZW?=
 =?utf-8?B?aEpWYTlwRGZqc0F2NE1YY0RUTkVUbEN2cGNyMGFmTjRhaDVZamlsOTRmdEpH?=
 =?utf-8?B?RkNWUVU2K1l0RUdOQnN5L1U1VWoreG9LRHErK0Q2R01nOFAybHZGNTRPMnNE?=
 =?utf-8?B?cDYwblN0M1JCYk8zZWdCVkptdC9SdkUyL1VtZEFGWldrNklaNmZ2c09hWVlU?=
 =?utf-8?B?R3UrQkJLd1lRYmFKM2Q5dnBvZEYyQ2hrVnVmQnY2MDFtaHBVcDFhblp0U2Jp?=
 =?utf-8?B?NGpMN1FHVGcyZHpPeTJvdnhON2RQNDJUbTFMbDMxdVR4ajRjYWNZcDhDbHZU?=
 =?utf-8?B?QWJjeklEb3N3RmdQeitidlBzeUxuVUhrclpzaGR6T2ppYm52aXQ4N1Q4Sjhr?=
 =?utf-8?B?dHdkcVlESlpYRHNPZEQ2M0VFK2JxMDFIRlVFYmNGNmp0all4eTZDMVpiV055?=
 =?utf-8?B?dTA2NG5IUkc2di9nVU5NTmlZSERPeWxFZ0VBU3UwTTJmSW9OYTV4OUR5QlZ1?=
 =?utf-8?B?WUswWUdlT3d2eDNvMFlhSFpCeFdzanMyU1hMNXBpdFIrRDNwTzZxZXRrSU9Z?=
 =?utf-8?B?ek9ZY0UxcEZ0Tk1hZ0FRSklwZWRNSWdhQ0dzeGdiWUo3T1FwM2hxQTdpWU1K?=
 =?utf-8?B?QkV2WXNUdkUrcXNEdlhqVEhWelV3dUJKWjFPQzBHV3ZpRTlwMll1UXVrNWFP?=
 =?utf-8?B?OHNkMHo2d0l6YUxvZlU3YzU3ejZsbTdQTWxybkZ6S285Z1RFY0lXMkZkRDBP?=
 =?utf-8?B?ZXFuT1RRZi93ZkY5b1NXaTNSdnpXcWsxN0R0Z0ZqUFBWSGVFcTZTN3g3K3NE?=
 =?utf-8?B?ZGc4bW5GcVFSUFpXbEE0TDFnREdWdWhSMWRhQzQ3VjhXSHdDdEVHcCs5V0I4?=
 =?utf-8?B?UmEwRSs0Q2pxbGR0Sm8vanRDYnZzQUdxcnYxc1hWQ28rWEhKWmtzYUg1eExp?=
 =?utf-8?B?enhsakkrc3NyWlVnK2tnVzVuTzU0VHY5TEt4N0RVQjBEOWRYbVU1VmZyRkJS?=
 =?utf-8?B?UmhsYXdvT3k4M20ycXNVZEZvYXAzbmxOYVB6ODVGQjdjbmtPbjN6ZnFTM1F4?=
 =?utf-8?B?MkpybkJ6ekxEZktQYlhwVkdmYlhrR2hTSWVHWnlpWWZoZUQzYVRQcHBwczRB?=
 =?utf-8?B?YUFkYWxzTisxdnhlbmFiTGRxMnQxNmdSK2c1aEVGa3YxVEZUbWEyZWVpdGpm?=
 =?utf-8?B?OFA0RHVkcjlFN0huZGc0QTgzMXdQeUxLZmkvMDdJWkQrdTg5WnZTSi9OdS9B?=
 =?utf-8?B?SmRuQUZKOFZxTC9oU3duUWtMb3ZSTHhKRDUvTVhrbWptZDZtV00rczdUenQw?=
 =?utf-8?B?ZTVKUXpOejNEKytmU016ZXRqRXNXY0Yrd1I3Y2FlSkxxWFBrTUJ2dklwMktz?=
 =?utf-8?B?MG5pVFd3V3NvZjRkNTl4TWllV1k4cHVuL1Z2YWVvM1drTStEaE9yek5BdjBh?=
 =?utf-8?B?cmFyVnVBc2prMmxJeTZ6Mk9QUEQvTVU0U3FwOEt5YnpiRTJPYzgvaTh5a0lU?=
 =?utf-8?B?MmFCNzF0a2RIZ1orbThhRnpmQkFIT0wwWFVpR2dwbnV0OVQreXAyQnZHa1VG?=
 =?utf-8?B?WHczQmUveWRyUEJkNlZBUjJ2eWJRNk44M1BrbnAyZnJLUkU1WlpKdmJvUGNY?=
 =?utf-8?B?cEgvdjlvYVhNMUNJZ2l0UjFsUmdsRWRYaU9RZ0tBQXc5V1RteEdYUGNqWGtU?=
 =?utf-8?B?OFlvNlhTQ24ySFdra1dhWW5WZnhuSE9EdjB6RlFpR1U5YUhVaERsbURMWDRS?=
 =?utf-8?B?bmhIQkJLS3ZzcUVWWTZsc1B4Yi9CSDdzdndTL3lpc096VDRBYkZaeFZtbkVq?=
 =?utf-8?B?clY5Sk1zK2hSNkRzVHlkcDg4WFNCTTQ1L2NnT25oRHV4WlhYdmx1ZkVFTkR6?=
 =?utf-8?B?a2lBWnk0QkdyVEdvOWlyNE9vVFF0dnZ1UVMrRGNuQTBpTHFLZjNFUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEF52D9CC39C694AB11838955338A728@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lvyG72nTDUfSkXqxgx2E47oCWmVTt90AThbgbK09QQRiH2q6ESs3+8RFaI0+RNrt4ynEmx7ZPOzHssoCI1BHWCmKoTHw0ndazhsEVuHAw1Uoy0MhgKv2imaoabX9q5JbiclTKv5MtP9q8pqip6xOxbXiiIg6w0/ztxhezOtRHlcocDzssX9qeOa+SBhcDllKl6tG5sbt/Q2kIqIOOL54EwQTQaRILbo/MVvZUiqk234y8ySU0sgmTYtqC5Dd+2VsOYD2asHE1dEz8RzKW7fZFuEh8ojkh9z5exftL0G1bcYrhlCXC1eXnR5jjZtfk6Se7T/3V6uzl483g4Fhe/8Msg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gm3XVdoFuBPNxJHwc7SLv32Y+qMPhCYRaQa5iBFRfAAnXPfiBwGQPKvDGKqfQ/Nr1xQmrIAuNsufirJ9NwVc7Q83jjmGoICIPIw63MobP9lGsbzn7pm6HaZsoIcYZvG6vSgf4sn8LUJB4ZTWNxXA6jgTzBwuknMxIUslJXMELMZDa84Ug3V0D2CoMuLGhf8ROd7KHCHsY+HO6lTp1SPz+qRpapjYwWc8/kGFUulzgV93inHwGNkvBNzhXAGRBeZVYtVsmZRbe9hwFhGZTddRnlrzvtDSfqtjil2uRubQQ25mLIKItDRHkN1cLcTmbxhHbsggZ9npHqTe2I3y4HnaTPGZzOBRuTJDAprpdEQ7ZEMfcIKnFYtkpfgjthOCj9MdZc8lPgq9nqJaBSq9K6XCcuwjuWpo4ToR7iY28L9jDQSBQLwe8BsfKXP8NaSsoFVKwS9fJYMs6oFLpHdcK0LR4Qlgq2a1i7zSeti1aBAOII7zphClgEhDYLISCfQxhVZ3iBz7pEnwvP2m5zhED67AaPDuYqaTt3dymy/IZpVSepAkYdHe4KMuyWNot9namy17B1bbx5ZptLyJ9pL98KT4RAdrA3z2f9mNU8QmNZJsPU3LFAYboeQMbH2AV/H/lNnc+r74RbyjdokppRJS/M8zLQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cfd5c5-d586-4c24-6085-08df28cc9c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 01:52:16.9524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnJDr6XuHUDCVRuSG19WlhldyAjoCSQuXmSz2ZUBAvnTPAsXxZNRtItL+pIVVZrJ7+YFikpaAE6mJU4JO9S/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX/AU8ek6jv8AF
 tJ9NERS59J+m8Vv7DKhWH8brDRt1oWJtmhzc8drqJYUNKd24BPtQff0ZTSj8xMOOUs0MyrRCDvx
 rGXbD/Szagf0a4i8lsFcsZg6xp4P2VSUEAewYYDLWykUOwCfJ6+SpiHCufzwCzktiEE0C8/j1le
 fsBzH/cSIzPIhVCkykT5kmKceSeul3h6URk99Jyj0eXXyyk1IFCj3DsWwIQI3vv7R857XUdPs/D
 KximH9ZVJEP35fiH/dSm5egsk4lJjKAMJsSk/q9sza6cybX/OxTPlGRXlDC24ircBuJ6hAweGyX
 h1gMiilbfKO1KfoQAclMMVW1PtIaA4RNkR085RduJqg1gWX8gowWHAZsj9sxDgFsKOcdp3B6R1c
 9Z719tHKnK2GcgJ52kkShy8yBDhMSbtA5G54KJvuEQ2Qb5o3vbvIos4UKReoWFd4jXFgh3XVytv
 cQec/XntZywx9FdWxnA==
X-Proofpoint-GUID: lTQzJue-L7zgYHGtSSkhb1RbEy93P8AV
X-Proofpoint-ORIG-GUID: lTQzJue-L7zgYHGtSSkhb1RbEy93P8AV
X-Authority-Analysis: v=2.4 cv=bZf+w+PB c=1 sm=1 tr=0 ts=6acd8ede cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=N7apsDaOz40ugMpgncoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX44Eg8e697hFC
 IqlfAIGdWkBBBt56gYoTGOk+CNO6r+qQqtY08K4BPJf08dUaw/Z1vRzLrWrp/Pk/DTe1mdk5ecF
 M5jY1lwk/coCuyH4Hb80rkI2T3xp4ns=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610080000 definitions=main-2610130007

T24gTW9uLCBPY3QgMTIsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
MTAvOS8yMDI2IDU6NTcgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBUaHUsIE9jdCAw
OCwgMjAyNiwgU2VsdmFyYXN1IEdhbmVzYW4gd3JvdGU6DQo+ID4+PiBUaGUgRW5kIFRyYW5zZmVy
IGNvbW1hbmQgbm90IGNvbXBsZXRpbmcgaXMgYWxzbyBhIHNlcGFyYXRlIGlzc3VlLiBJDQo+ID4+
PiBhc2tlZCB5b3UgdG8gY2hlY2sgd2hldGhlciB0aGUgY29tbWFuZCB3b3VsZCBldmVudHVhbGx5
IGNvbXBsZXRlIHdpdGgNCj4gPj4+IHRoZSBhZGRpdGlvbmFsIGNvZGUsIGFuZCBpdCBhcHBlYXJz
IGl0IGRvZXNuJ3QuDQo+ID4+ICAgwqBXZSBoYXZlIGNvbmZpcm1lZCB0aGF0IHRoZSBjb21wbGV0
aW9uIGV2ZW50IGlzIG5ldmVyIHNlZW4sIG9uY2UgdGhlDQo+ID4+IHRpbWVvdXQgb2NjdXJzIGZv
ciBlbmQgdHJhbnNmZXIuIEl0IGFwcGVhcnMgdGhlIGNvbW1hbmQgaXMgaW5kZWVkDQo+ID4+IGhh
bmdpbmcgaW4gdGhlIGhhcmR3YXJlLCBhcyB5b3Ugc3VzcGVjdGVkLg0KPiA+Pg0KPiA+Pj4gQ2Fu
IHlvdSBwcm92aWRlIHNvbWUgbW9yZSBpbmZvIG9uIHlvdXIgc2V0dXA6DQo+ID4+PiAgICAqIElQ
IGFuZCB2ZXJzaW9uDQo+ID4+PiAgICAqIGNvbm5lY3RlZCBzcGVlZA0KPiA+Pj4gICAgKiBlbmRw
b2ludCBkaXJlY3Rpb24gKGlzIGl0IGFsd2F5cyBPVVQ/KQ0KPiA+Pj4gICAgKiBJcyB0aGVyZSBh
bnkgYWN0aXZlIHRyYW5zZmVyDQo+ID4+PiAgICAqIHRyYWNlcG9pbnRzDQo+ID4NCj4gPj4gKiBJ
UCBhbmQgdmVyc2lvbiA6IDB4YzEyMDrCoCDCoDB4MzMzMTMxMzANCj4gPiBhbmQgdmVyc2lvbiAo
MHhjMWEwKT8NCj4gDQo+IA0KPiBWRVJfTlVNQkVSID0gMHgzMjMxMzAyYQ0KPiBWRVJfVFlQRSA9
IDB4Njc2MTJhMmENCj4gPg0KPiA+PiAqIGNvbm5lY3RlZCBzcGVlZCA6IEhTIG1vZGUNCj4gPj4g
KiBlbmRwb2ludCBkaXJlY3Rpb24gKGlzIGl0IGFsd2F5cyBPVVQ/KSA6IFllcyBpdHMgYWx3YXlz
IE9VVA0KPiA+PiAqIElzIHRoZXJlIGFueSBhY3RpdmUgdHJhbnNmZXIgOiBObywgVGhlcmUgaXMg
ZXZpZGVuY2VzIGZyb20gdGhlIGxvZyB0bw0KPiA+PiBzYXkgdGhlcmUgaXMgYSBhY3RpdmUgdHJh
bnNmZXIuDQo+ID4gVGhlIGhvc3QgbWF5IGhhdmUgc2VudCBkYXRhIHRoYXQgd291bGQgbm90IGFw
cGVhciBpbiB0aGUgbG9nIHVudGlsDQo+ID4gY29tcGxldGlvbi4gQXJlIHRoZXJlIGFueSBhY3Rp
dmUgdHJhbnNmZXIgb24gb3RoZXIgZW5kcG9pbnRzPw0KPiANCj4gDQo+IFllcywgd2UgY2FuIHNl
ZSBhY3RpdmUgdHJhbnNmZXIgb24gb3RoZXIgZW5kcG9pbnRzLg0KDQpXYXMgdGhlcmUgYW5vdGhl
ciBTRVRVUCBwYWNrZXQgYWJvcnRpbmcgdGhlIENsZWFyRmVhdHVyZShlcF9oYWx0KSB3aGlsZQ0K
dGhpcyBpcyBnb2luZyBvbj8NCg0KPiANCj4gPg0KPiA+PiAqIHRyYWNlcG9pbnRzOiBUaGVyZSBp
cyBubyBkd2MzIHRyYWNlcyBmb3IgdGhpcyBpc3N1ZSBhcyBvZiBub3cgZHVlIHRvDQo+ID4+IGl0
cyBsb3cgcmVwcm9kdWN0aW9uIHJhdGUgaW4gdGhlIGN1c3RvbWVyJ3Mgc2V0dXAuDQo+ID4+DQo+
ID4gSSB0aGluayB5b3UgbWF5IG5lZWQgdG8gZmlsZSBhIGNhc2Ugd2l0aCBvdXIgc3VwcG9ydCB0
ZWFtIGFuZCBwcm92aWRlDQo+ID4gYWRkaXRpb25hbCBkZWJ1ZyBpbmZvIHN1Y2ggYXMgc2NhbiBk
dW1wIHRvIGludmVzdGlnYXRlIHRoaXMgZnVydGhlci4NCj4gDQo+IA0KPiBTdXJlIFdlIHdpbGwg
ZmlsZSBhIGNhc2UsDQo+IEkgYWdyZWUgdGhhdCB0aGUgRU5EVFJBTlNGRVIgdGltZW91dCBtYXkg
YmUgYSBjb250cm9sbGVyIGxldmVsIGlzc3VlIA0KPiB0aGF0IHdlIGNhbiBkZWJ1ZyBzZXBhcmF0
ZWx5LsKgIEJ1dCwgdGhlcmUgaXMgYWxzbyBhIHNvZnR3YXJlIGJ1ZyBoZXJlLiANCj4gTGV0IHNl
ZSB0aGUgaW4gdGhlIGJlbG93IGVycm9yIGNhc2UsICJkZXAtPnJlc291cmNlX2luZGV4IiBpcyBy
ZXNldCB0byANCj4gIjAiIHVuY29uZGl0aW9uYWxseSwgZXZlbiB3aGVuIHRoZSBmaXJzdCBFTkRU
UkFOU0ZFUiB0aW1lcyBvdXQuIEEgDQo+IHN1YnNlcXVlbnQgRU5EVFJBTlNGRVIgd2l0aCByZXNv
dXJjZSBpbmRleCAiMCIgbWF5IHN1Y2NlZWQgYW5kIA0KPiBpbmNvcnJlY3RseSBjbGVhciB0aGUg
cGVuZGluZyBhbmQgdHJhbnNmZXIgc3RhcnRlZCBmbGFncywgbWFraW5nIHRoZSANCj4gZHJpdmVy
IGFzc3VtZSB0aGUgcHJldmlvdXMgdHJhbnNmZXIgaGFzIGNvbXBsZXRlZC4gU2luY2UgdGhlIG9y
aWdpbmFsIA0KPiB0cmFuc2ZlciB3YXMgbmV2ZXIgcHJvcGVybHkgdGVybWluYXRlZCwgdGhlIGVu
ZHBvaW50IG1heSBub3QgcmVjb3ZlciwgDQo+IHJlc3VsdGluZyBpbiBhIG5vLXJlc291cmNlcyBl
cnJvciBvbiB0aGUgbmV4dCBTVEFSVFRSQU5TRkVSLg0KPiANCj4gVGhlcmVmb3JlLCB3ZSBuZWVk
IHRvIGZpeCB0aGlzIHNvZnR3YXJlIHN0YXRlIHRyYWNraW5nIGlzc3VlIA0KPiBpbmRlcGVuZGVu
dGx5IG9mIHRoZSBjb250cm9sbGVyIHRpbWVvdXQuDQo+IA0KPiBTdGVwIDE6DQo+IF9fZHdjM19n
YWRnZXRfZXBfc2V0X2hhbHQoZGVwLCB2YWx1ZT0wKQ0KPiAgwqAtPmR3YzNfc3RvcF9hY3RpdmVf
dHJhbnNmZXIoZGVwLCB0cnVlLCB0cnVlKQ0KPiAgwqAgLT5FTkQoZS5nLCBlcDJvdXQsIHJlc291
cmNlX2luZGV4PTcpIGlzc3VlZCwgYnV0IHRpbWVvdXQgb2NjdXJzDQo+ICDCoCDCoC0+IHJlc291
cmNlX2luZGV4IGNsZWFyZWQgdG8gMA0KPiAtPmR3YzNfc2VuZF9jbGVhcl9zdGFsbF9lcF9jbWQo
ZGVwKQ0KPiAgwqAtPiBmYWlsZWQgdG8gY2xlYXIgU1RBTEwgb24gZXAyb3V0DQo+IA0KPiANCj4g
U3RlcCAyOg0KPiBfX2R3YzNfZ2FkZ2V0X2VwX3NldF9oYWx0KGRlcCwgdmFsdWU9MCkgLT5SZSB0
cmlnZ2VyZWQgY2xlYXIgc3RhbGwgZm9yIA0KPiBzYW1lIEVQDQo+ICDCoC0+IGR3YzNfc3RvcF9h
Y3RpdmVfdHJhbnNmZXIoZGVwLCB0cnVlLCB0cnVlKQ0KPiAgwqAgwqAtPiBFTkQoZXAyb3V0LCBy
ZXNvdXJjZV9pbmRleD0wKSBpc3N1ZWQgKHdyb25nIHJlc291cmNlISkNCj4gIMKgIMKgIC0+IENv
bW1hbmQgc3VjY2VlZHMsIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCBjbGVhcmVkIGluIGNvbXBs
ZXRpb24gDQo+IGhhbmRsZXINCj4gDQo+IFN0ZXAgMzoNCj4gdXNiX2VwX3F1ZXVlKCkNCj4gLT4g
ZHdjM19nYWRnZXRfZXBfcXVldWUoKQ0KPiAgwqAtPiBfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNm
ZXIoKQ0KPiAgwqAgLT4gc3RhcnRpbmcgPSAhKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX1RSQU5TRkVS
X1NUQVJURUQpIC0+IHN0YXJ0aW5nPTANCj4gIMKgIMKgLT4gSXNzdWVzIFNUQVJUVFJBTlNGRVIg
KGJlY2F1c2UgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEIGlzIG5vdCBzZXQpDQo+ICDCoCDCoCDC
oC0+IEhhcmR3YXJlIHJlamVjdHMgd2l0aCBOT19SRVNPVVJDRSAocmVzb3VyY2UgNyBzdGlsbCBo
ZWxkKQ0KPiANCj4gDQo+IFdlIGFyZSBmaW5lIHdpdGggdGhlIGZvbGxvd2luZyBzdWdnZXN0aW9u
cyBmaXggdG8gcHJldmVudCByZXNvdXJjZSBpc3N1ZSANCj4gaW4gdGltZW91dCBjYXNlLA0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+IGluZGV4IDFmOTczZTU0NjIxOS4uYmFjMDMyODQyM2NkIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4gQEAgLTE4MTksNyArMTgxOSwxMSBAQCBzdGF0aWMgaW50IF9fZHdjM19z
dG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1Y3QgDQo+IGR3YzNfZXAgKmRlcCwgYm9vbCBmb3JjZSwg
Ym9vbCBpbnQNCj4gDQo+ICDCoCDCoCDCoGRlcC0+cmVzb3VyY2VfaW5kZXggPSAwOw0KPiANCj4g
LcKgIMKgIGlmICghaW50ZXJydXB0IHx8IHJldCkNCj4gK8KgIMKgIGlmICghaW50ZXJydXB0IHx8
IChyZXQgJiYgcmV0ICE9IC1FVElNRURPVVQpKQ0KPiAgwqAgwqAgwqAgwqAgwqBkZXAtPmZsYWdz
ICY9IH5EV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQ7DQo+ICDCoCDCoCDCoGVsc2UNCj4gIMKgIMKg
IMKgIMKgIMKgZGVwLT5mbGFncyB8PSBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HOw0KPiBA
QCAtMzg5NSw2ICszODk5LDggQEAgc3RhdGljIHZvaWQgDQo+IGR3YzNfZ2FkZ2V0X2VuZHBvaW50
X2NvbW1hbmRfY29tcGxldGUoc3RydWN0IGR3YzNfZXAgKmRlcCwNCj4gIMKgIMKgIMKgaWYgKGRl
cC0+c3RyZWFtX2NhcGFibGUpDQo+ICDCoCDCoCDCoCDCoCDCoGRlcC0+ZmxhZ3MgfD0gRFdDM19F
UF9JR05PUkVfTkVYVF9OT1NUUkVBTTsNCj4gDQo+ICvCoCDCoCBkZXAtPmZsYWdzICY9IH5EV0Mz
X0VQX0RFTEFZX1NUT1A7DQo+ICDCoCDCoCDCoGRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfRU5EX1RS
QU5TRkVSX1BFTkRJTkc7DQo+ICDCoCDCoCDCoGRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfVFJBTlNG
RVJfU1RBUlRFRDsNCj4gIMKgIMKgIMKgZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jYW5jZWxsZWRf
cmVxdWVzdHMoZGVwKTsNCj4gDQo+IA0KPiBCdXQgcmVnYXJkaW5nIGJlbG93IGNoYW5nZXMgaW4g
ZXBfZGlzYWJsZSB0aGF0IHlvdSBzdWdnZXN0ZWQsIGlzIHRoaXMgDQo+IHJlYWxseSByZXF1aXJl
ZD8gSXQgc2VlbXMgdGhpcyBjb3VsZCBjYXVzZSBhIGJ1ZyBkdXJpbmcgYW4gZW5kdHJhbnNmZXIg
DQo+IHRpbWVvdXQsIGlmIGNvbW1hbmQgY29tcGxldGlvbiBuZXZlciBoYXBwZW5zLCB0aGUgUEVO
RElORyBmbGFnIHdvbid0IGJlIA0KPiBjbGVhcmVkLCBtYWtpbmcgcmVjb3ZlcnkgaW1wb3NzaWJs
ZS4NCg0KWWVzLCBpdCdzIHJlcXVpcmVkLiBUaGUgc3VnZ2VzdGVkIHBhdGNoIG5vdyBlbmFibGVz
IElPQyBmb3IgZXBfZGlzYWJsZS4NClNvIHdlIG5lZWQgdG8gdHJhY2sgaXRzIGNvbXBsZXRpb24g
d2l0aCBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HLg0KVGhpcyBoYW5kbGVzIHRoZSBjYXNl
IHdoZXJlIHRoZSBFbmQgVHJhbnNmZXIgY29tcGxldGVzIGFmdGVyIGVwX2Rpc2FibGUNCnJldHVy
bnMuIElmIHRoZSBmdW5jdGlvbiBkcml2ZXIgcmUtZW5hYmxlcyBhbmQgcXVldWVzIHRvIHRoZSBl
bmRwb2ludA0KYmVmb3JlIHRoZW4sIHRoZSBkcml2ZXIgd291bGQgaXNzdWUgU3RhcnQgVHJhbnNm
ZXIgd2hpbGUgdGhlIHJlc291cmNlIGlzDQpzdGlsbCBoZWxkLiBUaGF0J3MgdGhlIG9yaWdpbmFs
IGlzc3VlLg0KDQpJZiB0aGUgRW5kIFRyYW5zZmVyIG5ldmVyIGNvbXBsZXRlcywgdGhlIGVuZHBv
aW50IGlzIHN0dWNrLiBDbGVhcmluZyB0aGUNCmZsYWcgZG9lc24ndCByZWNvdmVyIGl0LiBUaGUg
ZHdjM19zY2hlZHVsZV9lcnJfcmVjb3ZlcnkoKSBpcyBub3cgaW4NCm1haW5saW5lLiBXZSBjYW4g
dXNlIHRoYXQgYXMgcmVjb3ZlcnkgZm9yIC1FVElNRURPVVQuDQoNCkxvb2tpbmcgYXQgdGhlIHJl
Y292ZXJ5IGZ1bmN0aW9uIG5vdywgd2UgYWxzbyBuZWVkIHRvIHJlc2V0IHRoZQ0KZGVwLT5mbGFn
cyBvbiByZWNvdmVyeSB3aGljaCBJIG1pc3NlZCB3aGVuIHJldmlld2luZyB0aGUgY2hhbmdlLiBJ
J2xsDQpzZW5kIGEgcGF0Y2ggZm9yIHRoaXMuDQoNCj4gDQo+IEBAIC0xMDk2LDYgKzExMTAsMTUg
QEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoc3RydWN0IA0KPiBkd2MzX2Vw
ICpkZXApDQo+ICDCoCDCoCDCoCAqLw0KPiAgwqAgwqAgwqBpZiAoZGVwLT5mbGFncyAmIERXQzNf
RVBfREVMQVlfU1RPUCkNCj4gIMKgIMKgIMKgIMKgIMKgbWFzayB8PSAoRFdDM19FUF9ERUxBWV9T
VE9QIHwgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKTsNCj4gKw0KPiArwqAgwqAgLyoNCj4gK8Kg
IMKgIMKgKiBUaGUgRW5kIFRyYW5zZmVyIGNvbW1hbmQgaXMgc3RpbGwgaW4gcHJvZ3Jlc3MuwqAg
RG8gbm90IGNsZWFyIHRoZQ0KPiArwqAgwqAgwqAqIGZsYWdzLCBzbyB0aGF0IHRoZSBlcCBpcyBv
bmx5IHJlYXJtZWQgb25jZSB0aGUgY29tbWFuZCBjb21wbGV0ZXMuDQo+ICvCoCDCoCDCoCovDQo+
ICvCoCDCoCBpZiAoZGVwLT5mbGFncyAmIERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcpDQo+
ICvCoCDCoCDCoCDCoCBtYXNrIHw9IChEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HIHwNCj4g
K8KgIMKgIMKgIMKgIMKgIMKgIMKgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKTsNCj4gDQo+IA0K
PiBBcyB5b3UgbWVudGlvbmVkIENsZWFyaW5nIHRoZSBmbGFnIChEV0MzX0VQX0VORF9UUkFOU0ZF
Ul9QRU5ESU5HKSBpbiANCj4gZXBfZGlzYmxlIG9ubHkgbGVhZCB0byBhIE5PX1JFU09VUkNFIGVy
cm9yIGxhdGVyLiBZZXMgaSBhZ3JlZSwgYnV0IHRoaXMgDQo+IGNhbiBwcmV2ZW50IGJ5IGJlbG93
IG5ldyBzdWdnZXN0aW9uIGNoYW5nZSwgc28gYWJvdmUgY2hhbmdlcyAoZG8gbm90IA0KPiBjbGVh
ciBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HIGluIGVwX2Rpc2FibGUpIGlzIG5vdCByZXF1
aXJlZC4NCg0KVGhlIGVwX3F1ZXVlIGNoYW5nZSBvbmx5IGNvdmVycyB0aGUgZ2l2ZWJhY2sgd2lu
ZG93IGluc2lkZSBlcF9kaXNhYmxlLA0Kbm90IHRoaXMgY2FzZS4NCg0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
IGluZGV4IA0KPiBlZTgzNzIzNTYzMGEuLmViNjY2NmI3YmI5OCAxMDA2NDQgLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYyArKysgDQo+IGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBA
QCAtMTA4NCw2ICsxMDg0LDggQEAgc3RhdGljIGludCANCj4gX19kd2MzX2dhZGdldF9lcF9kaXNh
YmxlKHN0cnVjdCBkd2MzX2VwICpkZXApIHJlZyAmPSANCj4gfkRXQzNfREFMRVBFTkFfRVAoZGVw
LT5udW1iZXIpOyBkd2MzX3dyaXRlbChkd2MsIERXQzNfREFMRVBFTkEsIHJlZyk7ICsgDQo+IGRl
cC0+ZmxhZ3MgJj0gfkRXQzNfRVBfRU5BQkxFRDsgKyBkd2MzX3JlbW92ZV9yZXF1ZXN0cyhkd2Ms
IGRlcCwgDQo+IC1FU0hVVERPV04pOyBkZXAtPnN0cmVhbV9jYXBhYmxlID0gZmFsc2U7IEBAIC0x
OTkwLDcgKzE5OTIsOCBAQCBzdGF0aWMgDQo+IGludCBfX2R3YzNfZ2FkZ2V0X2VwX3F1ZXVlKHN0
cnVjdCBkd2MzX2VwICpkZXAsIHN0cnVjdCBkd2MzX3JlcXVlc3QgDQo+ICpyZXEpIHsgc3RydWN0
IGR3YzMgKmR3YyA9IGRlcC0+ZHdjOyAtIGlmICghZGVwLT5lbmRwb2ludC5kZXNjIHx8IA0KPiAh
ZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCB8fCAhZHdjLT5jb25uZWN0ZWQpIHsgKyBpZiAoIShkZXAt
PmZsYWdzICYgDQo+IERXQzNfRVBfRU5BQkxFRCkgfHwgIWRlcC0+ZW5kcG9pbnQuZGVzYyB8fCAr
ICFkd2MtPnB1bGx1cHNfY29ubmVjdGVkIHx8IA0KPiAhZHdjLT5jb25uZWN0ZWQpIHsgZGV2X2Ri
Zyhkd2MtPmRldiwgIiVzOiBjYW4ndCBxdWV1ZSB0byBkaXNhYmxlZCANCj4gZW5kcG9pbnRcbiIs
IGRlcC0+bmFtZSk7IHJldHVybiAtRVNIVVRET1dOOw0KPiANCg0KKENhbiB5b3UgaGVscCBmaXgg
eW91ciBtYWlsIGNsaWVudD8gSSBoYWQgdG8gdW5tYW5nbGUgdGhlIGRpZmYgYWJvdmUgdG8NCmtu
b3cgd2hhdCBpdCB3YXMpDQoNClRoYW5rcywNClRoaW5o
