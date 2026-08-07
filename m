Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C53FB074;
	Fri,  7 Aug 2026 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140756; cv=fail; b=X2hfY3sN+9vfE2Rv+NNJZ3i5rUUOiewvVulIh6KC2SxzOIO7fSHX62deS0Y7s51gXzilqdCCCccrDPgl4fviXvo8EU69N+qse48kzYKM/NdXzFpkOMc30IEoTyIg4EoZUULhCel9YbQ0dRkQCmiB/5haip6Stij1wcgDdh/wmyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140756; c=relaxed/simple;
	bh=K0Tqlj26yw34kbUSprAfR6pge3PeIdmi0Ysq2blsT/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WTrOsApcm6bu1jAhy/QRo8PwUy4G3utapld0e9MfbeAQ3dB6gJzyd5TjUmMaiKOH76tCPuayhiNmKtOJF8hjwILW206MiS4ug6QCcJ51ZFUnUU89Z1SaXsGBWrnsMw0Siumhfjgo0otpiqJIyM+sRYww/asqj/9pTUqzJNBg6GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iIRCOI1T; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MgCZb5aG; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qgl/nTQw reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iIRCOI1T";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MgCZb5aG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qgl/nTQw"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677LctrI1635851;
	Fri, 7 Aug 2026 15:12:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=K0Tqlj26yw34kbUSprAfR6pge3PeIdmi0Ysq2blsT/0=; b=
	iIRCOI1TPTGO94/8ZGv5zqEi26sGm0SAMqVKIi4T3672u+NEgJ9Ki1TRhFB8To/9
	DoSiBSb9vAtNWQirEAsKnqYK1UBANsHCvZez3WZ/btauLwGAp4UgLrxW0Ud5Tjjf
	keYWyBbRlw8Gq6wFP5ulIUG9E3z+Dr8k5m2VMBMJvo4IaA4efuGh+QaQKCPkXxzN
	Oel5KRtsjEX/kyebWaiUaALd7fKlY1cp1wKZWfgw9iEgT8QU1lqayFw/se8Dmo2k
	pjKGwvZ8zIKfRAdlYsRZkAVGKbKuxteOypFyPawAPhwckHi4mB7NiqSIFgYxEAkA
	RW4ozY9YWizOB9/kSSmtYg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4fvy9xbtxg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1786140742; bh=K0Tqlj26yw34kbUSprAfR6pge3PeIdmi0Ysq2blsT/0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MgCZb5aGKgcJbNcEJKMUyVjwBag9pHgkYTClCDtOfkrWTbeuV+ipsuEIsphHMMEHz
	 SdIJzVofE+VTU2AkQIidX4hefH6pkXpNhLmZVGBhsWO7HZkQFOKIfT2SQBEkvPL97j
	 NsEB+lUU7oxoNPwljluIpzNU4gtQ5/19RUYPrE9FDyuRzClxk5y7oZp1TK+1meRtNM
	 xHz6Lf8uFzu1aoumLdeRZQ/er0PWX+fS/eDONbmZ8qn4Cnx4iZ3t7e2jhZ7AAbmAUj
	 9Gaw0nw0mkYYW+BKyhKlK6N/wH1qLD0wQNbSyJh8D8zPHIzwMsj1YUCCsJzg4/DcO/
	 17+K6f0pLsd6g==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BAC65401A7;
	Fri,  7 Aug 2026 22:12:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 885C1A006F;
	Fri,  7 Aug 2026 22:12:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=qgl/nTQw;
	dkim-atps=neutral
Received: from DM2PR04CU003.outbound.protection.outlook.com (mail-dm2pr04cu00302.outbound.protection.outlook.com [40.93.13.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A6373405BB;
	Fri,  7 Aug 2026 22:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j13q9yLqGMlKZ3K85cT768Zpf7Icb2CFiXIf3zFixE8cil4rX+Xg1QcyeYBLR8ZlRNcfK531ZAgyOEHrL3KmiHhwzx7szAc1crhQSDmYzypmDKiB5/MTdX9emhylNKJKlg525aq7Gm2t8jvg9yjtJvFtYGqRt1MakLP+jKing8b2X9xwoQyNRRZw1wOspapztmEQWF33Oyo3PBygyxeeMGxS2u8gLGZE1hT8cG7SIE7y4E8S/+n0ghhiyVusTMG5aELZXlzdEcFxTiQsS3B8+29fJ/1R9VEE1OiJ9VhMLYJdV3e6jE2a1EsTDUCojv/VN4RYVNJM5o3G5uekvsXM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0Tqlj26yw34kbUSprAfR6pge3PeIdmi0Ysq2blsT/0=;
 b=acE+Te0m+z0YXCAJdp1UuiwI/hjksmEM4OlOuR/htuTjaQc4Wiu/XgIO5BFllMBo3Chrzw4nrC2magz8oWzy8lgedSyQFnJ1Kdd7iQlNfOr8XBfdGjKgBdzIeMDSSBzhBigtiLNabAaKQMGFvbrrnxaVq8MLYJYd8FX0P+eAj4tv5x34O8KxsoKY0to6ZFbUdWXmGPeJxIEG53quSBq9oGFYEdYgja/OcCFRwIZtZKM3TJqHMgVPaAbbT81yDRwBkrOtx9EMQDtb29fcfL2fAcr/zFaLeVrZow5V8Q3Se01FXOVxl8Phiti7G7RcAjVa47uIy4lapDOCaGTqtlERaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0Tqlj26yw34kbUSprAfR6pge3PeIdmi0Ysq2blsT/0=;
 b=qgl/nTQwOZ6Rp9i1GhMhZdWOZyhaALdMTbOa5mgHWRAPgMdjFEX97xAOpaF1FRlTh+x0uZNPwbDSFPnhTWPWQErGWufWefiHotg60wmp4KPg7/A9F00dqDIKlZMUVdVAXhiQogAER1hJixtqxHckgZ7xVJ64ZEsgQYDAzAHLhZU=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 22:12:14 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 22:12:13 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: cancel NoStream work before endpoint
 teardown
Thread-Topic: [PATCH] usb: dwc3: gadget: cancel NoStream work before endpoint
 teardown
Thread-Index: AQHdJpnhohiV0m943ke/wymK+bkJn7aTJmMA
Date: Fri, 7 Aug 2026 22:12:13 +0000
Message-ID: <anZW8H1kQfwXW2Ix@vbox>
References: <20260807182318.3736662-1-radhey.shyam.pandey@amd.com>
In-Reply-To: <20260807182318.3736662-1-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CH3PR12MB8728:EE_
x-ms-office365-filtering-correlation-id: 4e369f1e-b1e8-4e13-0d5c-08def4d0ef45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 BVoz75YC2J5PxS3oWx/hA4EQrU43udE+B4F2nPonNVa6z9NZFEp4CcOSjweI8QSnlYItBMIKI6e2QEfdS+VqRuVIrR3+p0eBexLYw0592bFlTo4BCVFlOq5jMrijiAs9T75Rd4BzDKUPjUuHS/U1ppRht0K61ye/h8Ayq5p+mgwz9zuiz2vOxg6/Te3o1LH3Wm+4TlaEsmIYQY9hz1HGgc5qh/pbugL8zUOxkRO/j4ur6DzvGwvd0leHaaT+DcGpWiSkPp1llZtp8tE2ekydDuQfqtkJ62Rn6BjtFDSiANJxYrzWkmtH5LWQMbHZSRsIl94YgRESGegzqMOa2anp26Z/DRWIVPezv7qK7RzqFr79QzkwINJRO8QWQmHM1JNrWI8csKzDud1yMjszLmnUpfZeFwoLmVn+rpyXJ8jKtbs6buK+HBJUryIxKiUIuvLsVJvo40F66hWTh09GmKEnZf1DhSToexmtcMPtZBtilAbf5tTmY6ZKxlBoNig7xHqhprRpsaLAvBHpXKjY7vEEtl6MY+BdYE1ymblhFHEW+M2BxFJJwC6autfkSGGjwNazzuKkOLZptEnupxtpDgVTIkODta/ruxWumcsy3Ng1Zb7ntCbtoNEGvMt5zNxBRwMGYjMkH0SbnbuSgwP5vctcs2OtjN1swViJC+mkb2RFS/o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1FkQzdGRXNUV3pPRklOelRSUG9LcXB2RVFlYWRiZVY2R0hqNDRnbk16bmk1?=
 =?utf-8?B?WFlGeUVyYitxa0FSekR6QUh4bjZmd1gwaTFFTzdZWnhmODlmWkdURlUyS2tD?=
 =?utf-8?B?VmlOOWtEM3JDNzd3M05TMmtFM1FMeG01ek1aaWxhYmZHQityNHQySCtrSXZs?=
 =?utf-8?B?UWw1T3drQ0RLNE9XN0NoaFZpL2FFNzlVR1lxYjh2dC8ySFNsV0pDOW5wYkFn?=
 =?utf-8?B?NnZDOHNFSmtiTzl3ZEkrN1oraGpKKzB5ZUxES0l1VGpzZTNqSjRCbmJReU9Q?=
 =?utf-8?B?MmlJTThQMUozTVRXZlQyVzBaM2p4cmhZdUZMdDFsZ3V0ZDFpZVZGQmxPTzlS?=
 =?utf-8?B?eElqSC9JZGtpVjNGankwbjFrOVdndEtqUUl1cFpxdllvSFFOQnJiU1Z0enJ6?=
 =?utf-8?B?WkdENlNSZ2hKY1dQSDVCYkkvK1hkN2JwTmkyNGgzeGd1YWNCajlmdDJGeEtC?=
 =?utf-8?B?TkY5ZHI4b1R2UEhqZVFOejJOTUJkYXkwV1FzQ2dMS1VRbkxUcEJiMXpBRHJ5?=
 =?utf-8?B?N045UmtzSzdDT1lOLzJjakZDWDFPNm1INGF1eXhlanIzQVFuMWFaUm9lc2Yv?=
 =?utf-8?B?ekpmTDlIY2tXRU53ckpNbXllSkVJaHNORk9nenRJMkU2YVlzUy9LM3NMeUNH?=
 =?utf-8?B?VmFKNC8xekxhWE9udnRlMmVQRERhSFk2bE9nOHh2Y0xrekJaSVpEYjZUaUdh?=
 =?utf-8?B?aUgwYXZTOWFUSXdrTTZidFE3U21RZnNHOUNWVTNJNVV6c1FibFpDYkhrRHp4?=
 =?utf-8?B?U3RLeXcrbzBKMHR5WklBYVV3Mm56eW8rYVBlZ3p2Qmd2QkJJclJvOVpQOVR5?=
 =?utf-8?B?R094WFM3N2JLcFc2OWNxZ2hvRHRFdHJZcGpEN3JUVERzN2pmUTRQQXhWbVR0?=
 =?utf-8?B?T2l4SlhHWjBxUE1xbzNFWkJQSGh3NWd5d3ZuV1lZY3ZlcVdtUTlEazdMYm1Z?=
 =?utf-8?B?RkY0Q3BDNVR1RTh2V2ZhSXJIT1hUWnRhM0p1Qjh0b2NhT0ZnSlYrV2FzcWcz?=
 =?utf-8?B?b1l3SFpEOHMyM21HTkt4TTJUMnNZcVdRUy9jRTZkOXNhNUNOMGZmemRYODZj?=
 =?utf-8?B?aU5hSTdZRkNpT0tZbTZ6NDhnNXBPc1ZXZ2hDQ0t6d3ZxakcxZ1BoNDJibTNH?=
 =?utf-8?B?U0toSWkrL0tPT1ZDaGh6NnNub05lallWVDhtVjRTeFFyTU9saTZnSk9SOVUr?=
 =?utf-8?B?b1Y1U00vbVE2WlIwOXJqdjB1bS9uaFZPd2RHSkZrdEtnSkxFZFFuMHFkYWVR?=
 =?utf-8?B?eGxmeS9USmlPY01QYmxVUnF2N1UzcEZLeVNKVkpVU29vZ2xJTGw4SFBaZ2xK?=
 =?utf-8?B?ZnhKQ2lWLzFMaUVOa0h5elNMTW9sbFVmUy9wbWM2THdhcTI5VnNIYm9DelVo?=
 =?utf-8?B?Nk5GV2dsdlFBaTRucGdxWHRYYUwwdzhXdlpESnRHZDIrTHppb0RESkpCZkVO?=
 =?utf-8?B?b3pSczF4bTZWSktHUHVGeGg4ZlVNd05KOEUzRGRZZHNIYndYWEFiY1dxY3B6?=
 =?utf-8?B?SlBDZE5oRnN3QTFYVlJUWW5tVGV6T3NPL2t4aVdyZ1grd2wwZ2lWSVZsUnA1?=
 =?utf-8?B?NEEwN3MvMEJySUpxV0NuNHdWb3RSRWplSXp6ZHFNaVdwS0h4Wi9IYmJ3SXpt?=
 =?utf-8?B?Y0twY3BjVTFlQjFhTy8zWEdOZE9JaUNodjNSQ0Fnc0w2MGRTVFdzaCtTVlFC?=
 =?utf-8?B?djUyTE5pcWRGUVVidGxDYXJQWEVQM0ZxdHZ5RkI3TnQ3eTdGOWs2TUlHMUtS?=
 =?utf-8?B?em52eVdyakpZYlV2Um8rNDZrT0JFbXd1ZklUWGIrSTR5eWtDckNGSXFpNGg1?=
 =?utf-8?B?QjBuVnJDRS8rdGtyTk9naXZDeUdtM3FuRHFydEFra2xsaURnTDJobnZENHNT?=
 =?utf-8?B?RXVZdzRVUGRqYVBWT0pRcXBDYnZuYm1ZWUQwTTQxajZ4MW0yVE5iMnhLN0U0?=
 =?utf-8?B?cWNSMDVsQ05HRUhvSEFvaTV5elpaT2dlZTVubDdrdXVGYWR6dWxFU3ZPcW9X?=
 =?utf-8?B?VDRJbmNwZ0wwclI4eTBpN3huZHQ4RFdvMU5WbFF3cUZROG1XRXZXMWNFQzcz?=
 =?utf-8?B?WnlrS1d4TXBTQURpellpWFBycFNKQmkyTnlUeUlnTmIvMjRUQlhmWnV0YVkr?=
 =?utf-8?B?eEtPUHgrQ3hqTEFnN092ZWFGeC9NT1FYYkV0UWNJR0pBeTdEN3I4WnVtN2Mw?=
 =?utf-8?B?aXZZM3NWNnlvcy93WVZiVmlKTEJJUzd3dURCcTJuMTcrYVBIOUVVRmd3Vkdy?=
 =?utf-8?B?WmFYT3A1M3dCL3BUeEMwR20rRFJqY0g3Vk13Ynl5NktqUTdjZ01sOVpzU0g5?=
 =?utf-8?B?Z3FVa3N4Z3NCbUp1VlZZNnNaZ1pjNjFmSld2WEZFNE5qT0pZa3R3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8409C956733BC046A4F5654392F33D83@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pcXd2yx0kwGFuAnYP/ALcWhIELxf2JR80V7/HWiUP7DKjA8Iy+9nMk5oFsNo0e9iHByQZHV7xYIRz1ob8KUmJF9+4FHJ47svCMMQ9ERMewUZrwcqeG5LqW5M7rHmKh73b88LTk2miaIAHTavbrsTD9V73eYVBNw3twz9S8qtVnQuOOCvFq1G7X14TJJLmnhZZO9TVXCz7qu+2hVOjs+kcpNKI8CcI5ahid5uRGVw+rovbg+wH4gGLJJ2gqMpz65IW3t/H86ypfgN7SIKcOqjjLnREzRq2C7mTLmrEoXLyIoeHSrO2ywUFushU3+l0Hy+5hxZYCkl8mBiECxUZ7GJCQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PpApb8bIriBEAWrl31zwFh83HOOOpThClLjTv40/04CwC9Hh4yATydd+EFZru07Dp3zoBdwA4sNm56M/ZLFikVgWO80J8SaP4W0U+jjA9KixJKKmB+Kudhx+4HuqM14z5F7vhT3/JIzzzNAkxNOuZmi8oGz/QRhbln+L40hOAd9c+KGHAvsLO6n2FD9pvMg/wAqLn2amHv5YWeRbKlY32s7pdLrztgYjMoIetmHFw5Nlo4EcPaKhqRkz5zlGPZYaG5XYhVFDHfK7CVIT51fNAQXn7AnMRqK67ffXWnLkF46f7RNY3UeiZe7SSPIGl/nAz+QoyWcqgtVbNGfMC+L2exEPWY/fbfS7I/1d4Wup1TCpWlW0ma703F9Uz208Jy8/13h1jMa/1xlPzS4akQPOYG+x6lIPTWqWXa7EFHwpJJEYqMz77Blt7jRYcXaI5p5XnsJRmfsvApaf0JfO+utbH9CISkIaWTSI0q4oYC9G3m7WtUnqMYgVJ9iTbHrMO3ytpkOwYwN9ouy9fkZ3ILf7sXdFtm/eONiRWyUW3kUn8ibgYJWrfu/A9xHd/zAxm29op9iXcaUDT3CR7nxY6T8H1wMQz7nsDtDi+JFDH6ekI0Ij6gg6wE37/q6X56NsKeGmbV6Lvrp5sHeAYPP7vignRA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e369f1e-b1e8-4e13-0d5c-08def4d0ef45
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 22:12:13.7800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JaWDL9PcyLEtUG9HBmlb7znzmj4arJ55MJ/J6vV0PXHxTrTQ2zNDG0XCrzOseMwy+cmkkDlF5bAYvYP4GT8D+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
X-Proofpoint-GUID: HfCgAFGLb7WlhQpHhO38O7opw1tKyjOc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3MyBTYWx0ZWRfX6t+Q/qdV+Zii
 xqqmyfaR6ksznHmGT8g6CxJXoMGnHqHwKzObLs5qBm6L88izQw+JInvrhwLb+UF+hiV9p4aPs3e
 ukAjTDTiY0RW2gL7QSnQDodLHyywvZ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3MyBTYWx0ZWRfX2p0o6ZT7VQej
 UfRiCfaS358pJVQkKn0qEU2WXirqRBywwC21eo6qOgbsxPzw30rVuSacQ2fojoL5POwNp9W1Igl
 h38CW6kYwl7Gb+xbo7V95cnLJNDhdBRzoH/sqYm+hao3T6kQZY29VsEotS8B/3pUcsWAmr1nWqb
 rAQwzCZ21/7Xgv4umf+Bdiva+C6zdqRefwSomYlXuX5qJta4rCKP8qYYdEfEcDq3nMcg79Py49i
 i2oa25DelXIJpK5qKhjlGkj/8+TUil2lKHQfMI92VJOTVetoFmCWZQ6pA/ETYbI7ZLLXRJWdDmR
 PM43DWkxTgNI28FWsACkVkh8BT22l/o5OxXH+5h3QXz3Vim8q68rJUZKLRQh8H1iGmnRLAVzWh4
 tF+sdgb6htun1N/sUQImGnahtjQOMxi+v8djuHc8Dj7YN8ciBg1upd2ZQLjExDhIEKfser5RUxY
 1iGm/OLv/safbgWvZPw==
X-Authority-Analysis: v=2.4 cv=SbbHsPRu c=1 sm=1 tr=0 ts=6a765847 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=GYsaYXYKKxMhvo_b8lsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HfCgAFGLb7WlhQpHhO38O7opw1tKyjOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608070173

T24gRnJpLCBBdWcgMDcsIDIwMjYsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IERFUEVW
VF9TVFJFQU1fTk9TVFJFQU0gc2NoZWR1bGVzIGR3YzNfbm9zdHJlYW1fd29yaygpIHdpdGggYSAx
MDAgbXMgZGVsYXkuDQo+IE5laXRoZXIgZHdjM19nYWRnZXRfZXBfZGlzYWJsZSgpIG5vciBkd2Mz
X2dhZGdldF9mcmVlX2VuZHBvaW50cygpIGNhbmNlbA0KPiB0aGlzIHdvcmsgYmVmb3JlIGZyZWVp
bmcgc3RydWN0IGR3YzNfZXAsIHNvIHRoZSBoYW5kbGVyIG1heSBydW4gYWZ0ZXINCj4ga2ZyZWUo
ZGVwKSBkdXJpbmcgRFJEL09URyByb2xlIHN3aXRjaCB0ZWFyZG93bi4NCj4gDQo+IFRvIGZpeCBp
dCBjYW5jZWwgdGhlIGRlbGF5ZWQgd29yayBzeW5jaHJvbm91c2x5IGluIGJvdGggcGF0aHMgYmVm
b3JlDQo+IGRpc2FibGUgb3IgZnJlZSB0aGUgZW5kcG9pbnQuDQo+IA0KPiBBc3Npc3RlZC1ieTog
Y2xhdWRlLW15dGhvcy1wcmV2aWV3LWhpZ2gNCj4gRml4ZXM6IGRjZmU0Mzc0OTJlMiAoInVzYjog
ZHdjMzogZ2FkZ2V0OiBSZWluaXRpYXRlIHN0cmVhbSBmb3IgYWxsIGhvc3QgTm9TdHJlYW0gYmVo
YXZpb3IiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBS
YWRoZXkgU2h5YW0gUGFuZGV5IDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggZmEwZjE2ZmZhZmVmLi5k
ZGYxZTI2MmUyYWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMTE3NSw2ICsxMTc1LDggQEAg
c3RhdGljIGludCBkd2MzX2dhZGdldF9lcF9kaXNhYmxlKHN0cnVjdCB1c2JfZXAgKmVwKQ0KPiAg
CQkJCQlkZXAtPm5hbWUpKQ0KPiAgCQlyZXR1cm4gMDsNCj4gIA0KPiArCWNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmZGVwLT5ub3N0cmVhbV93b3JrKTsNCj4gKw0KDQpXZSBtYXkgbm90IHNsZWVw
IGR1cmluZyBkd2MzX2dhZGdldF9lcF9kaXNhYmxlKCkgYW5kIHdlIHNob3VsZG4ndCBjYWxsDQoq
X3N5bmMoKSBoZXJlLg0KDQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3Mp
Ow0KPiAgCXJldCA9IF9fZHdjM19nYWRnZXRfZXBfZGlzYWJsZShkZXApOw0KPiAgCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiBAQCAtMzUwOCw2ICszNTEwLDcg
QEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfZnJlZV9lbmRwb2ludHMoc3RydWN0IGR3YzMgKmR3
YykNCj4gIAkJfQ0KPiAgDQo+ICAJCWR3YzNfZGVidWdmc19yZW1vdmVfZW5kcG9pbnRfZGlyKGRl
cCk7DQo+ICsJCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmZGVwLT5ub3N0cmVhbV93b3JrKTsN
Cg0KSnVzdCB0aGlzIGhlcmUgaXMgc3VmZmljaWVudC4NCg0KPiAgCQlrZnJlZShkZXApOw0KPiAg
CX0NCj4gIH0NCj4gDQo+IGJhc2UtY29tbWl0OiA2YjhjOGFmNTE0ZDczOWQwMzM1ZjU1NzliNTg1
ZTAyYmFiZThhNzI3DQo+IC0tIA0KPiAyLjQ0LjQNCj4gDQoNClBlaSBYaWFvIGFscmVhZHkgc3Vi
bWl0dGVkIGEgcGF0Y2ggZm9yIHRoaXM6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11
c2IvMzMxZDFkNTEzMzQ5NmQyYjQxODRlMDVmODg0OGFkYjA2OTMwYTEzOC4xNzg1ODkzODY1Lmdp
dC54aWFvcGVpMDFAa3lsaW5vcy5jbi9ULyN1DQoNCkJSLA0KVGhpbmg=
