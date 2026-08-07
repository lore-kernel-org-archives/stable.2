Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08511B640;
	Fri,  7 Aug 2026 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786144200; cv=fail; b=sHIHJtgyKfUySLLOL2/L8MH9RdhKs7cV8o9NT7w5xPWj6ezOSejfOQUPC50aJRlj8Oza1PGxTFzW2F4ZbizaZqE2VRMjjMWP8vq18abzhcs8Np0KeZXM8BNTd7rhCCaQ6mFFkxR0C/1k/rXu5hawIvfNzQwYGcL845nRYHaz9ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786144200; c=relaxed/simple;
	bh=tY/BV2Tm6VQhDFzJySu3KK5/lEOoIxVzUk3OYPdvD9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dOx2PKzXs86G4bdu9POkzMQc3EzXoppQKuss5clRh66Nh5jmJbvsmn4rZc5d4y/Me4JWk4fYqiDtMYwDWQntnCcizSswjqzzcQwn063ORASvJeLicciOapc7cjnkcUbXlW9oIV56oSaU92jhDoFkyPivQ9y5R/YwQ9pSE8ODgWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Z1CwEuFg; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=c+++jtEp; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=wQeiuhFP reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z1CwEuFg";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c+++jtEp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wQeiuhFP"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677LcVUv1634997;
	Fri, 7 Aug 2026 16:09:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=tY/BV2Tm6VQhDFzJySu3KK5/lEOoIxVzUk3OYPdvD9s=; b=
	Z1CwEuFgSqVLVGsr4+xVFGFl3y9MCGMx30VwMJRf28K5XFGlKt1V9vKRQv/Llzbb
	Y5pLFS6gQgmiTUTcUuMBpkbiq+P0Vyo/1ZuTqJll+EfJfHSpCWERINwcBcnJFhQy
	QVtEryQ8ogaZ8U8TJP14HnpN0jM+2aLQHGQhisn9qT3nZpIJu8uNWNqNphqqU1ok
	/iKNM0bJSBY/OaByAShQzB9kOv9CYRvlJhdWvy/uYcLR59U94BvPPxkrZnBg3clr
	p0GFWYi0wtAKbbsWmvXLzckok32D9ItNBnDYx3nr75Oei6nkVug9f5ShFPW0xW/5
	ziGJA9lhwsQwddA81YXMQA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4fvy9xc3cd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1786144189; bh=tY/BV2Tm6VQhDFzJySu3KK5/lEOoIxVzUk3OYPdvD9s=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=c+++jtEpvmQPE/5u+dJ3OPrg71pQr5QsdwRRJ+hEzc6h2FTFFuqasdNfjfXQDbPqv
	 GSxlx1KpNPxkjqvwUnzKypdciy4BO30omjUsPVVpc1iYhLPrYxmWFM1VCyeIQ4SD3x
	 M/U3u5RKUf6QjI/PddBF6NCgsH4lWviN2xCIIJbXLHeVxuE4oFCuMeBsC7sV4INE8C
	 5TrCRb8aMTVEd1HjqR+EJhNk9bPfriDFIR15bT0WO+jccuFVKL/lxqKywuSrl4iD3u
	 JS50ZPcupJenfLxhSiFcfTpi/KXwdEai9/ALt0hgobREfM4Uvxz7SFXdXYQFbfzZiR
	 OPvE4xFfSPyqw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5195A401A7;
	Fri,  7 Aug 2026 23:09:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 07C32A0ECD;
	Fri,  7 Aug 2026 23:09:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=wQeiuhFP;
	dkim-atps=neutral
Received: from DM2PR04CU003.outbound.protection.outlook.com (mail-dm2pr04cu00300.outbound.protection.outlook.com [40.93.13.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 233EF40139;
	Fri,  7 Aug 2026 23:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1SaDA9dos+KOOPMWe6yfak0gkIVDhODrnbP4gHS79PhIXmeGF5IrncWGSdNM5tJlRQa3VJj2/v0FWuv2hs6CMb6CNRAYMYM6hkuGV/aguIoJcgwFLuLdKXpRD0LtjsUA9dk/KOiZMsNMD/Zifa2Jibec86dnHMAcdqg/uUag6Ttpj6ENOdiiL0U3QUhb6DajlSHD2cKUEUfYHdif12s5lX38sJ8HuH1VIwZusuRoBvSuInbzX4WQpx+SkdnHTmJyP5ZFg3mwMhCD6o/KypNzYWhm3GObsWlJEMtPiCUvdm2foAXMndtzfH7mT+xP1yXd5pd6+8PSr7p/TdqlydqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY/BV2Tm6VQhDFzJySu3KK5/lEOoIxVzUk3OYPdvD9s=;
 b=eHmUs6I/pCNZV/RbFwaXJTw5RG+5gNd2uFK9drJh0TuACR4EKKK43fHpd+d4e1TjdpJXeFezS72dmrsv3zGgpt0wGNXaa1XNdmBlCf7gbonsojWqQJdZmeVhEbP7a/GLZP8JtcZIBOnsEjBpjzqxKtTTZspCrT4LBA/cd46KTlPEZoQtDD5/MaUzS4deFeLtEXO8K+p/Ponexk8uV0NOrF7Be990a3Tjp3jsdyz+KO7pD4BHUifaqessHVHyQrdwEDaNftrv9isXmS7LehU24dIrM8xeU4RfOZ3Dlzpf1I/YXNDtq0/Zz+b2VhD3DwtWNbMcQp7QseVnuZ6xeZYbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY/BV2Tm6VQhDFzJySu3KK5/lEOoIxVzUk3OYPdvD9s=;
 b=wQeiuhFP/tayHt1cVJqAsMfE10BdGKVqT2WLNf8RA8Z4NItZeeSdgZCHY9eXQVj2x/Ns0h34LjL0bworGsQ8iYZLgzC5I+IEt1AksGEMNbmR771DR0xfJz+fYDGgiGCDgPXCE1v0pGEo73hh908/qmIBc92oejXnC4vRi7nmCB0=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 23:09:42 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 23:09:42 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Liu Jiazi <jiazi.liu1984@gmail.com>
CC: kernel test robot <lkp@intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jiazi Liu <liujiazi@amazon.com>
Subject: Re: [PATCH 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Thread-Topic: [PATCH 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Thread-Index: AQHdHawGuYxuzFPO6kGdHse9sTxJSLaQyXqAgAG0HQCAAMq3gA==
Date: Fri, 7 Aug 2026 23:09:42 +0000
Message-ID: <anZYnWfDlNPRQBq3@vbox>
References: <20260727094015.5101-1-liujiazi@amazon.com>
 <202608061759.sIcC6h4C-lkp@intel.com>
 <CAAcjFgibrFJYKYp1Q-ig6hHE_WCg5KSSZV2Fvv0zawswEdHZEQ@mail.gmail.com>
In-Reply-To:
 <CAAcjFgibrFJYKYp1Q-ig6hHE_WCg5KSSZV2Fvv0zawswEdHZEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DS7PR12MB9550:EE_
x-ms-office365-filtering-correlation-id: 1dcb3611-5d32-4c60-5af5-08def4d8f6ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|4143699003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 SWuepZeMrIxJkj32QoqPUH44q7PIFKXl9lBnZKsS/PNmYhKTzxHlUUg5xfmFdzc+LDP88kkg2EB6yRqJbWr0IGARfwBk2efIJC2HkR9dKWnaAxZLu7sCYfIs3AUsMn+cY3j8C+/XG1EwTeELtvY+1KhKIwpnpRPa59MfbmXNEeNPabJoJeQ35JWaUjL6d8W2WQcfzlfqb2keb7NgFBiLhdXY7lChDVJ6zmlnnOseD9QwxG1qMoxWz+Rs2CwHYTn2O6k/i/s86wqxPIFe8rxKMsAqad+Y0KNF7WDmV8IO7MUVFoEuzWgHAyy4wZWWwnxCSTdPkpwfJbCoU9PSmtOWeSyhYofEqXtUDa875pTAMqMYgroqjH+PMAncz8FM0GKGCAVA4ve+5Z2eeEB/zzqRWyitFsV0aLwfPotHN9PiFn4NeTevgYlDc33MpnZYUoLfX/VjBVaQehrzAOoov7dkXG0jQfSrLQm3B42BI8KgMgCHXWLCw8NYQlKI/r4poAXk9qjULxCtLfNczUvCFnephBCCgb/Nzo1Xd8h849ccaPsOExZx+Y6EI2yR2Sy1I5zHc+xWEzYs4Ii3ehY5U/nZBzA4oAQhAsxCANCPNAnQrTeU8LW0HLXUdH3SMlayyiv3bDKT1oH2J5mjLTEkDPGDQB09ITUbra0VHN4RxshdyXwdoKz4bJv7dLKB2AAYQGN5FsSa1DDW58VmpobZCkY5Qh2zIgOTcuDS67Epob9WafM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUI1R29pdEhjMzVsV1ovR0EwdmJDa0FlbmFsWWRWVUcwQVFGNFQwTW9MVEVP?=
 =?utf-8?B?by96ZmxhUTFYOThKUmhBclZZRHkzNmFIb0xHeElwY0xIWnpRdE5sR2FjeTdj?=
 =?utf-8?B?eG5KUXBwbTVzL0tlLzlTSXIzWWhwb1dBWjdMTkE2dGV6d0d5L05IK0UwODgy?=
 =?utf-8?B?TlRtTkNsSUxjaWJ2SXJvM0VvZHpVeHB5bTdZUUdxNWJqTUY1Qk5CK3hOaVls?=
 =?utf-8?B?cTFjNjU0cmUrNkhZT0lvVTNXaHVtRU4wMVc2ZWQ2dXBOVzNBUStTSzFiZ3JH?=
 =?utf-8?B?dEpQaU0rWDRSNjBsMkJMZkJrS1hva21OUEdEMTJacWdyWlRFSVF3cVNxb2Nn?=
 =?utf-8?B?S1pJRVN3emIyNnNManNFZXFwNjlJZVhxRFN4Z0sxZnVMMklmb3V6UW4xaXZQ?=
 =?utf-8?B?K1lqMGtQRlRXRW5Nb21wdks3RnlzZ3hhWGFjRTJ0ZU9kQjl4SldYS3FwR3ZU?=
 =?utf-8?B?NlVheUdFdDdpVkovNnZOMlRoQVdWYXA1dnlWdlNVQkVsQVpqaDBiRFJockNh?=
 =?utf-8?B?Vml0OEFjS2Q2Q3JSODFhOHdrZTNwVXp0OXNlQ0hNWUtSbkMydDdjR2FuaEdQ?=
 =?utf-8?B?VHJnL1lPVzluSWRMVC9kSWN4TkJIRFhwdEQrbm90TkdaK1Y4WERhKzlKdXA3?=
 =?utf-8?B?S2VxbWdKeWlIQ3ZuSHZIa1dnTzNqOWdLYkpXeDVCNUkzSEVFVXBlSVVXSThi?=
 =?utf-8?B?QVpCaEY3M0xaVVlKa05tS2RlbkdOV1lPcnROcnk4ek0zdlFORDBSYmQzY0Vr?=
 =?utf-8?B?c1c2emxvMmlJVmNoY1p3MDgvOG1BeVZJK2NpdWZXZUV2NjV5SC9ta1BOY0o4?=
 =?utf-8?B?YUpXWjhaQ3A3ZmY2MFhIM3d6cXdDMDZqVHBFVlpVbGNSeXhKWjFMQjNFZk9y?=
 =?utf-8?B?cTdnallXUkZyUmhmbWR5eVkwN1VVQThpQ2ozQnd1TGVsbnV4YjNXakt3T3lp?=
 =?utf-8?B?bG90RmpZa2N3ZjJhWFBGWDBoMlBXaklGVHBybThBZ1hGcTZnOThPNzNHQkJO?=
 =?utf-8?B?UURsSStHZmcrc0YwS280N2JZdkNSOUk3MW4yK3pTU2dBWlM5U3BlanovZnhL?=
 =?utf-8?B?amdmN29FMEh2WjBTWUE5UEtaRzRSZnZOUkhkTHNINkZheWpjMStYdVkxcEJJ?=
 =?utf-8?B?TkxCeTFuL0NGeVI2Q1NVQVdyT0EyQ2oxNU9SYm02dGk2LzYwdFhFUndQV3hQ?=
 =?utf-8?B?WUN2SFZoL3ZENGpQOFF6cXJ5K1FKOUI2NGxiOW95TU5oTmhEbkVCTklzRjBp?=
 =?utf-8?B?TkRaSE9jQzZTZnpzTitLc0dFb0pkb3BSNmNlVnFpWWFrdUc3YTRSbER2REp4?=
 =?utf-8?B?MStFS2ZldFkrRmwwZWxpb05PRGl3UDc5RjBLWGR5MnRTR1pkZHI2MmN5eEo4?=
 =?utf-8?B?OGhWbzJmNUtaRXZ1dGtHUmY5RmMrV2p1YVFSWE5MVkhXQXl2YjRSekxGNmFW?=
 =?utf-8?B?RkQvR1BMTCtoUW8zUWRNdXR0eVFKbHZRMjVSNWNFZHNzVHZxQkhZbTAzL1l6?=
 =?utf-8?B?cWN1VlJyUHZaRVVZUzd5MDN5NnRwbDVJUkJNRS91Z1hXSnFrQjBTS3d5S1Fn?=
 =?utf-8?B?Z0R5OTA5dzcyRTNmWFV2Vy9USWJ5OEZ2OWRBeW9VWGRDRXJLdUFZK1hET0sv?=
 =?utf-8?B?cjRFOVFsUVdBWG0vc3ZrU1hFTjVZemdRb2FmaWwrSm9BL1RsaXNMSzQ2S1Zr?=
 =?utf-8?B?RHpseXhiVUpzY0VEZjFqeHVQT2MvMDRSNCtBUC9pQ2xiODhEUy9Ick5WNmg0?=
 =?utf-8?B?RkYzbXQ2ODNJUmp0T2FsNytzM3dzTlBndVVYNUoreDh4dm05b1B3S2x1NFl2?=
 =?utf-8?B?bHBiTVhwSjM5TUVINmFqZkRURmN0eWV6R2xxYjdqMDN4bUdqZlAvRU5za0p0?=
 =?utf-8?B?WTlrOFM1Q241a0VBZWhBWkl3UmlxR0ZnL2RQYU5ncTBabUhpYjRkclZtL1hW?=
 =?utf-8?B?d2JXNUVudm5JZHNLYi9TZ1QxYXZxSUt4bm4xRTkyYVRKWjk5ZG56eTZ5MjhD?=
 =?utf-8?B?K040b1RoS2QzVDQrbUhCOVNDQ0wvWUU5RC81SEFHbVlSY09sbnhVR0pXejhQ?=
 =?utf-8?B?RmlwMjFjM3VocmtKeFNUbVUvOFdPVkh1dGEyMS9QU1FkakF2MVkxZ3lCSmZM?=
 =?utf-8?B?QWJabVJydld4ZWtCU1JQdTE2OW5XaWVNVmtQMzFVQXMxblYvVEQ0Y1orV2NM?=
 =?utf-8?B?RCtLeDlXWUVRcW9jSGpLa2xLVEV1ek9VdXBrVjE5V0J4QmxnZTBnOEJRU002?=
 =?utf-8?B?dTRoTjRNSE11cVpMMTVLSnVjRGlhL0ZuTjNxbFpFQyt0cHY0ZTNjQlhnUmZE?=
 =?utf-8?B?czkvTFJvWXlPS0MzVnhDRHdJdGdBT3hXei84NFh3VDVwY0pMZjVQQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E2954F7A83F4C4E8F33B0D3B2EBC5A4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HBEB26aDQSnR8adHR6RQlmcNqOQASLRUtGLrjpVtI+NfbcAxJLOuj2NceSzAe6H2kcfdCKBGiYOsW4oHuLoP9123UkFUMJIpZ1saeMEAz8BvW7On2YeuGVRduW8dBdzBLw3zWeJhkC8QIO1j54Q26f2RD0zerq1CqOP4QAfz7hBslciD8nqDweJoMUAVAnaVYuSYhqDmCkGnoZCBVJflOIdFfE2fAuYPlT2gJ9gXHVD79eacDIjb9pYxuosVzMHHM6gXKjVuiPJI6OlBXpPDTrEnXaHGYS80wFLkWfn6JFjBwIWwirFxeP6ICXO1eP2mmBuSQ/a3P3LyrJcKgr2MhA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PEipW1pbHP9DIEBQ6HiTcsRJWMNd1Z/4CcKnkLKTTLUscnqaiYJOHQMh6IAWcmLAWHLma//eRKDsolClDAjWermFrwwBbK1OT4lgF/uViWiQPX7fyVB5a9ffWmdUbUEpyLcNE8f7cB1RsTDxUA2TzPqLxg2/XiBPMdS/Q+E9M/D2BuIsaQJrH6BYXIVY2lyon0WLVuPzXAigTWF+Va1VXXfn3W9HKpzNaTmmEJ4dz6JuyQHV0wxMntaODllbFqc+xJO5K2zqv/C3bSaVQfS/yJwSt4BfM3JT/n2i/3wdDE8MbiPfLdcRdnvP6ZqFyO406VRWHBKy0Odv4PnAyV4prt9OJTEpDmFk4MQrDf9+SvoRMQAjGEdxxnj+OSdXoXFT4oACeZ6eeN/n3cUZDArFLK8ktKhutjNW80fy+vin9ZOrrI63iCh7oSYbHGlx8eHz2EgQAGPZgBU/K/8qWZsHlENdTadxw6Hks1g1iG9Z+mjal6od4yeIFz3A1RY78eRvbVIr19w8yod1sx1THuWYnvoRvS4axovQvIYmjGwP8IBMe6ZlNAisBXQOHd/46fBRnG8hqWF/ww9GKp6BmMlpNx4Lnj7z/a01MY2bhNRF6DBvBm4Pscjb/2TPj6KaEUpUiF0P2u9RDd8zA6VjU1nTtw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcb3611-5d32-4c60-5af5-08def4d8f6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 23:09:42.5734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0icNpqXfx31qj0CmJp7bX6VxfOZXtVjBwJOPlXuE/yWlSLtzOdse3qOgbOr7iKdkG86tPkvbngcQMUE9HB4Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
X-Proofpoint-GUID: 90VT72eOVA74VqWOmP246ZqmeplHIznn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE4MSBTYWx0ZWRfXyvMK7Vu5o9OT
 te55vum0Txry2RUp2RufBqoNJPsNQdfAZMdbzEaGY4/WqgZIko7swe8skJxTueW97uZkiS2daV0
 cnr8cOoKfZzDah0jiHlsw9WRjmmXbiQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE4MSBTYWx0ZWRfX1l0I7Er44Muo
 4JnhbwOj6m/Jll/nTZBd5NgdEqw1nSh/IUvipjQ5vmIm2tGXAsySXV3i5DWHr2iUjIGTLwTSrsg
 FGHT2Vettd03+cu4OLVhxN40/RelW+BlyFJc2hcWRQN0EnVhOC1BFI91t6l6fRzE8Qp8rRoPIhJ
 wJJUe4Qw2H0Mi+IiXRCyeoZNvDYIVLOvxRhFooZyEWqSU/HKhYGZ91z1miag/eMza2jm/ZF0kVX
 08tI86iWY4fLBHKnn1rP44W6xEo1sp1voHNDrGSqDiTyt/oapaOqqwobJpYGioaViixqwojvdP1
 U4WhKyTILDyIsrWrAB+aoEEhJFeEMkL0cbArLX7Wg4oVzx8EVQ+VhSh5T5YpAks3YORNPcbOmNQ
 RfcVeYtDwSz9tP4/UPueAepatK1ycsz8Vc401z1i+U5uvNYcsr0VqpL5DyP+bM9NwHIycEO68LH
 xLfpI2b21XLlygXr1Lg==
X-Authority-Analysis: v=2.4 cv=SbbHsPRu c=1 sm=1 tr=0 ts=6a7665c0 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=jIQo8A4GAAAA:8 a=0oINGzG2iPAbgJu1lIIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 90VT72eOVA74VqWOmP246ZqmeplHIznn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 impostorscore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608070181

SGkgTGl1IEppYXppLA0KDQpPbiBGcmksIEF1ZyAwNywgMjAyNiwgTGl1IEppYXppIHdyb3RlOg0K
PiBIaSBAVGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbQ0KPiANCj4gVGhhbmtzIGZvciB0aGUgcmV2
aWV3IHN1Z2dlc3Rpb25zLiBJJ3ZlIHVwZGF0ZWQgdGhlIHBhdGNoIGFjY29yZGluZ2x5Lg0KPiBP
biB0aGluZyBJJ2QgbGlrZSB0byBkaXNjdXNzOiBpbiBkd2MzX2Vycl9yZWNvdmVyeV93b3JrKCks
IGFmdGVyDQo+IHNvZnRfZGlzY29ubmVjdCBzdWNjZWVkcywgc2hvdWxkIHdlIGF0dGVtcHQgc29m
dF9jb25uZWN0IHRvDQo+IHJlY292ZXIgdGhlIGNvbnRyb2xsZXIsIG9yIGp1c3QgbGVhdmUgaXQg
ZGlzY29ubmVjdGVkIGFuZCBsZXQgdGhlDQo+IHVwcGVyIGxheWVyIChlLmcuIGZ1bmN0aW9uIGRy
aXZlciBsaWtlIEFEQikgaGFuZGxlIHJlY29ubmVjdGlvbg0KPiBvbiBpdHMgb3duPw0KDQpCdXQg
d2hhdCB3b3VsZCB0cmlnZ2VyIHRoZSB1c2IgY29yZSB0byByZWNvbm5lY3Q/DQoNCj4gDQo+IElu
IG15IHRlc3RpbmcsIGNhbGxpbmcgc29mdF9jb25uZWN0IGFmdGVyIHNvZnRfZGlzY29ubmVjdCB0
cmlnZ2VycyBhbg0KDQpDYW4geW91IGNvbmZpcm0gd2hlcmUgZXhhY3RseSB0aGUgUkNVIHN0YWxs
IGhhcHBlbnM/IERpZCB5b3UgYWRkDQpzeW5jaHJvbml6ZV9pcnEoKSBiZWZvcmUgdGhlIHNvZnRf
Y29ubmVjdD8NCg0KPiBSQ1Ugc3RhbGwuIFNpbXBseSBkb2luZyBzb2Z0X2Rpc2Nvbm5lY3QgYW5k
IG5vdGlmeWluZyB0aGUNCj4gZ2FkZ2V0IGRyaXZlciB2aWEgZHdjM19kaXNjb25uZWN0X2dhZGdl
dF9zbGVlcGFibGUoKSBpcyBzdWZmaWNpZW50IOKAlA0KPiBBREIgcmVjb3ZlcnMgb24gaXRzIG93
biBhZnRlciB0aGF0Lg0KPiBXaGF0J3MgeW91ciByZWNvbW1lbmRhdGlvbiBoZXJlPw0KPiANCj4g
QnJzDQo+IEppYXppDQo+IA0KDQpBbHNvLCB3ZSBtYXkgbmVlZCB0byBhZGQgYSByZXN1c2NpdGF0
ZSBjb3VudGVyIGFuZCBhICJkeWluZyIgc3RhdGUuDQpCZWZvcmUgc2NoZWR1bGluZyB0aGUgZHdj
M19lcnJfcmVjb3Zlcnlfd29yaygpLCBpbmNyZW1lbnQgdGhlIGNvdW50ZXINCmFuZCBzZXQgdGhl
IGR5aW5nIHN0YXRlLiBXaGlsZSBpbiB0aGlzIHN0YXRlLCB0aGUgY29udHJvbGxlciBzaG91bGQN
CnJlamVjdCBhbGwgZ2FkZ2V0IGRyaXZlcidzIHJlcXVlc3RzLg0KDQpJZiB3ZSBmYWlsIHRvIHJl
Y292ZXIgbW9yZSB0aGFuIDMgdGltZXMsIHN0b3AgZG9pbmcgc29mdF9jb25uZWN0Lg0KDQpCUiwN
ClRoaW5o
