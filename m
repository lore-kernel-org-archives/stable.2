Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B92D8DC4;
	Wed, 23 Sep 2026 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123392; cv=fail; b=p1eAKSGG2vVpELJarkTHwWVbQcuQMbAalgCWhgx1u/Xwnqde4eCCJyXaArEpOB/lhS7mauhD9Z6UNRTk+iFCTfn9hbpV9LeLufQ/8f+KlQf7MpwGc9hhWxdvowBck1qDAT0Dpf+3xLD4jY6M3g+QGcBzV+TVIa1GmHaGL5xKMdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123392; c=relaxed/simple;
	bh=tFTCnnurr5Yu16dKXYP2jw0XqbapXEO6/mkOapChgA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OYTQuUoPcgnmEduB2fiH035a1TMKq+E5B3+Ra+XXBQGe9WMZCYwpOkVJ8ug4mrtmjfDOW04hGmd75mN1pTeQsVc0hYjaf0lCt3Ct6hD/1P98Hh7RN+VZGww36QJIDVJASIIOxYOT1E9Dm6XLj8OkDpsHu9O0SnaB1AWg4gCjbWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=oaoJAorp; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Bu1CVDkS; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=h0bSxmft reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="oaoJAorp";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Bu1CVDkS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="h0bSxmft"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MK8mhc404899;
	Tue, 22 Sep 2026 17:29:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=tFTCnnurr5Yu16dKXYP2jw0XqbapXEO6/mkOapChgA4=; b=
	oaoJAorptVToNxcKn+LwctwWJyHOo5kYc3/7gyIDPjcYzTxuSuspbGulydg1omjx
	fmw0ctWWlr6hLRPqG/mnOni8gFpKH9w0dH1b6y9Q8bRvc0/iJ2ycZAplFK9A8n2B
	O/enP6MCXwcVcImpfv3mPBVBgjnBcywgV9LuEk+U/tKHZ1hiJqHkbjL0CCocU7tb
	EFTYGi7jka1KnsLXz+Hens7wyK9wFc1X2H3mTo39GsLC+FqiZO/Q/3yR1bqkcXlS
	6k4xhFe1s4a1R9ac+VsDGfzdSQ4PPQi2Tn55RAbJP4ACdnwZMGKR22RdkHBWfTq9
	ng9TMrb1kftUn2opag6kHw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4guw563hv3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 17:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1790123385; bh=tFTCnnurr5Yu16dKXYP2jw0XqbapXEO6/mkOapChgA4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Bu1CVDkS7b5B8LJR+OGglcxQJAchJSz6DW1yhQuGJjPigxEXdNsEnOQNFSMxagR6h
	 O+lElSD4uMg6CIgdJPtewpvezcuA73M+I7VEQAo8zKg1wDVpFVMwpToO82GOppL5az
	 9/ZZ4GaiaIt4u6jlnmlUEKgzOJG330FB0f8KOS/xOx0vLx00ZctMvSVVTb3OXcqR5p
	 F8gnZpCvpi4SLmTqlHxYW3AFQxaVL0bky/6YwosKblLG5tqzksMYvLgk0XuHmKwMmS
	 xzf6645FbofVSgu0gkNpFtSBazc7FALAYGQibEzmSROx9S06U1686aGYKBk5ceKVDE
	 4ZsnsWdmzIF0A==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 55912401D1;
	Wed, 23 Sep 2026 00:29:45 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 20398A0079;
	Wed, 23 Sep 2026 00:29:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=h0bSxmft;
	dkim-atps=neutral
Received: from CO1PR07CU001.outbound.protection.outlook.com (mail-co1pr07cu00104.outbound.protection.outlook.com [40.93.10.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A75DF22028D;
	Wed, 23 Sep 2026 00:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wyry7/ilXIhUx8xYR6sINnrSV1NoeqEhmoX6jwCh4YyrULGaSiakVdrXCa5xMDZXzlIv/IEwDX7HOLyngUH/9Bjy1U8jE995aiQ8fl/4pVpMMhV/JUbgD7afeyVMIYUFJX5PQXMGQvBd8+FwKF2LUKgXB9QMZkiqxZSC5y+6Z+IRW4WUhV/o/+vpZvOc8o89KmJ3OMHazR+HgP6roOcVn5tBygo5eo/y0E/zJAaj1Kr5q/D2RPEzwsqtmjKLmo34qt5SG27ZZfckjaHLW+Ew+NGsgCTZQYpptfRzIG3aHigcPPF1FCuuPuaa3DXWi/1ZmHxv99ecqq0cJHVhYCJ5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFTCnnurr5Yu16dKXYP2jw0XqbapXEO6/mkOapChgA4=;
 b=HCH9DxgTF6bQG/gzCPDQhjA/Ad8ZvuKjzjClh91KmPGZPxLgVFh6YKNlj6sWZsLFLI/svbWsnVlMW9YAt40niB/e6Dzm+wwm0CN2oGJvBgP56ic9zIsb060rZLOzVW2yUPKHYD/8+751A1zbAeT9mxPblT/1zT9jE5BTHJVDYfmT+1FJ6Fv5dsq6b+lvoHxc/hPnkh5BzHuchP6g2hukWBmLEozKoE112g4i32FDeB+Z75GFyxo/N3qu57UcE56DMESFTKLnpFq5RV6Ecgs0lxYwFBCq2nrvP0uPCPceCPh30fClKlr3W5XjywAqlEz4WJGI648P5ntX3tVbAp7OQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFTCnnurr5Yu16dKXYP2jw0XqbapXEO6/mkOapChgA4=;
 b=h0bSxmftaNYZZDzJH67C4zkRiZC2y9pl9CkwMuPpySybUVlbUA+iSeQld4RexeOPSRH3xzmT+6HXoCOa+DwQxDViDqoKuZuzMnsLpCT59ZHvVcH5MWOCjF0+EzdI6UHUXsIRsHCioXlUbotlxyHVeFEhSAVWxe/965QlNYJRJbc=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 00:29:37 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 00:29:31 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Jiazi Liu <jiazi.liu1984@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "frode@meta.com" <frode@meta.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v5] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Thread-Topic: [PATCH v5] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Thread-Index: AQHdRQJWsuGHWNgHbEyD4qMhDe3k27bbWy0A
Date: Wed, 23 Sep 2026 00:29:31 +0000
Message-ID: <arMdRUdMN2hHC3LY@vbox>
References: <20260727092258.1121-1-liujiazi@amazon.com>
 <20260915110637.17658-1-jiazi.liu1984@gmail.com>
In-Reply-To: <20260915110637.17658-1-jiazi.liu1984@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|PH7PR12MB6610:EE_
x-ms-office365-filtering-correlation-id: 39115695-53f9-4eaf-8555-08df1909bc2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 jiUmMWVFC9E8t2QFMC0T5Kdg33fEu/se6hsdVCQrIgn1heKVdbBkQ7MfTvcTGhbP7jG1lHK1qWvk9UbdIr8phq94qubKMTdrQFkAcQ8QI96Ke6Kkxz1lrcW/5MmUxF99ljOVHX5WF/DmiWuW+tg6DoSFv6Psnak+u5Qy9We1qViNbe7DHSkRG9uV44BJd1DmxQ2DYMdT5xKObqlSuMH5zM89tgfou3/XvMDQOmtuxVpGCkko8Yp527Yf4Ql9zvHKRMDQosodf3pl0CfF/L3ujPcpe0cLiCn6AgIw85NYu+Pd8HA0lYlvi/VZP3BtCC0QH4Mtq4ZHpzvAEWpvhTecoHeX4PjjncOqch9UFKZT2nCrC0mhai+2y/7cs+TIxP+sLsg0KRrq2YEa9Grd7eOe3U2cyWvkhB/zeNQ7gP/FFuVexXpyKjJOQQL7N6A2efoMYjHoW3OHtyl88Xo9U9L/hKpZB157eFq1owmNJwlDfCQVk5Yr7f4qkqmt6+VBtEk9vjr8xqw99ejef2vs1+jSiq41t+Hp63NJ/QRIJVM86D+OT3mtPVgLDp3kXwimdws6lfEdVPdmE+uDxhnrUwOKdy8HuSGMwGE2hWYZEyvapnOux02maUuJ4uRfTOWfdXRs/hEt4aVXz8C80HXHGefIXxxj3zYyZlRSZNmp2iLIvSgu1fnQ8xxWZSJ06uRJQQwlXvw8/bRn+lPscyECdtt7KW5fWl0EE8wLzpoTfMwgk4Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXpvcnNyUi9nZ0h0WE9sdlJET2xKSWpDMm5YOHEraXRUc1o4aUtXRTh2VFJp?=
 =?utf-8?B?K0ZPcEgvVUVJa3FjTldTTWZJaTl1ZDhueFB3d2tOUmdDM2FSSXcxOGNMNVZY?=
 =?utf-8?B?TlMzZTVLclZuWG40WjN2ZDB6Q3l5NVBldXZCcDAzRXlOSUhtaTVuMkR0QUFs?=
 =?utf-8?B?VzVUY3BlL3dmVmF0Y3A1dnJ3cUVJbUIyQWFqQ0FCVkUyVnhSK0JiQWlyRXBU?=
 =?utf-8?B?QUJiUWdiTWxpbkkyL3dZM3RDQkhITVZnTi90YjlqWkxIdlZwSmRncFhlVmRp?=
 =?utf-8?B?OEh1aUN1N0NsN0Z4TS91TGhrYVl5d2NkR1U1OGo1a0tDakNXbVFaYWJEZG1O?=
 =?utf-8?B?a0ZEQnNmOVFZS1RpRUtwU05pc2ZEbnFPcVJoaVhpY3hKMldvZ2Q3NWFpbmVE?=
 =?utf-8?B?cGxDaFNiaE1XVE5qZTVXZG90M2laV2ZOellkY0JVaUFtbXpQNWVvT1I4VVYx?=
 =?utf-8?B?d1dyQnQ2SlNTd283OUdTSjh3RkdPalM3b3dFTnQyZ1N4VTNYS2lqK3VyTHdF?=
 =?utf-8?B?cTF6OUVVbHdvVDlNeGZFUy84d2g0MWpxM2ttSEpHMERxK0IvNzBMVXJKUS9C?=
 =?utf-8?B?bmk2ZUxqeHVORVdDaUMycG5aSGRWU3Arc2k0U3R4Q2VUL1R0Sk9lbUk0NDZH?=
 =?utf-8?B?VGYwaDRtRXI3WTZiY1RTM2tidVBDVUthcEZMTUI3MkZhQ0xQakFnVmo2SlYx?=
 =?utf-8?B?UkkzZ1Z3QndwOU9QQ0lVVHlzOHoxN0lDbnVWa0dWYlZXZHpkakcycmtLQmRH?=
 =?utf-8?B?MkRyVmJma3YrU01PV21XNEk3c2hMU2E4dEZiV0pXVjR1ZU5EMG1YWDZkWHVB?=
 =?utf-8?B?NGpWQkcvVnZoZWsrUTNzczZtaXhlYS9seSt5bVBCZERzNXRoQVVHRndwZkZD?=
 =?utf-8?B?b29lUUVoQmladlc5VFc1Rm1qd2VJa2ZZQytmN2tObHNmUDlTRUp4dWFpZUw3?=
 =?utf-8?B?cEdGTnIxT0ZENGNqaUMraG95eE41ZVdOL3NSRlRnZmtpd2RvT2R1NkFxMWk3?=
 =?utf-8?B?b0NvemNHU3hlL1gwQ0RoNjhhQ3AvZzlWNDBydWVvMzhwb0NuamhIenYvL1E3?=
 =?utf-8?B?ZU9aRHg3V2RrMVlpTlFzU2RGRzI0OWN3Ump5K0svanBnUU9NT2xOMksvVW9x?=
 =?utf-8?B?QjU0azZKcS8rRFVzOXNQdXNCT2ZVTmhSYVBHSE1wZENWVnBwOUJIOWlUNmRP?=
 =?utf-8?B?VDV6OWt5TlZ1YzByMWVhWmFWcDJrZ0JKak8vcjA5SlN5TFpZUEd5VnVsUTFp?=
 =?utf-8?B?blhJTzZNL3BaNHdRMGlJVUZ3aDhJMkJBRzNlNUVjM29CNXhwSXdOaFFLcDRn?=
 =?utf-8?B?TUQzRGR6WDJmOGdaeTJZVmxUbUFiVVd4cUVjOHVyb2pObzJQV3pGUHpiVzFH?=
 =?utf-8?B?WE1xaC96M0NvR3lQcUlpVS8vdU85THRjYVp1NzRaRVBxSWxnUlYzNnhsbFQ1?=
 =?utf-8?B?ZTV6di9XWm1BaytwYXFPMEt3SkpVZE1VTUVlSG84RXpIMllPNDlJNThyM3Jy?=
 =?utf-8?B?a3VlK1ZhVDlKSWRRUVNFYStMQXZOcVEzWVpWcjFab21TOGZSM0RLb3FYY0hi?=
 =?utf-8?B?d0MrZENZYkpibHo4M1R2SHRSUzRYVVZhTkVwQ1pGQUxJdkFNZndSZjg5S0tN?=
 =?utf-8?B?Nng5alJ2aDBIT09HTHBZa0tEUkdwZkNtQ2xDM3lySThreTRPS0N4YlhvM0lh?=
 =?utf-8?B?WjA1QVBsZlpyMDJRUDFiNFVtTjlNeXQ0SlpWaDJvd1B1Q3RXZjY2UzIrNDZ4?=
 =?utf-8?B?OVR4aVVSbURGSUdaRnRjTEkyT2gzNjdHbTdhcmxwaFc5a1gvVDRHOW4wZnha?=
 =?utf-8?B?bkhyN2JOa1NJWHl4dnloZExwRzEydkYwWi9qUDJXUkM5aE9ORTdoM2YrZlhN?=
 =?utf-8?B?WGVDejZFS014VkxMb0tRZk5ZNDJwYlZoTVZkMmMxSHFNUFU5b0k4OVlrdE5l?=
 =?utf-8?B?MmpSSlE2Unh4VklsVEtHNDJjL1JtRnc1UGpyTmFIMjErd1NwMHltMVl0a3Ay?=
 =?utf-8?B?NUFyTk9Yc1pvRUJnMFk4S29PSU45c0FrcjlyYk5xWm9jTHdZZmtEWGQrY1Bv?=
 =?utf-8?B?cUMxTmUzNlYrTm5GRFpUbTN0UmlhTklwUFJiNWN6ZmI0VHNZWXNFKzQxTUZy?=
 =?utf-8?B?STM1RG0zWHJxcVJVd3hHMlB4bVgyd2hGbWV2TnErRDY0bi9hVWVJaTdTTjl3?=
 =?utf-8?B?bG9rRFpnVnhRczNMT1BYejZUVm9DaC96TU01WDVkT3hVWXo1SVFwRGJFY2Z3?=
 =?utf-8?B?WjFMbFlkVVRCZ01SKzRYU29zcXR1L0ZadFBKOVF2ZXN3V2Z5SGpoS3FlRk8w?=
 =?utf-8?B?TDlEeGNFMERCRVNNb3ZhL2x1UTcvUWluYVVUT0RlcGhtSUV5SmlBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F09531D99604ED45B045997F9BFA4916@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	owe+yPRi2D8ETy2R5w9QwFeMkaMp0ZgHQV8sy5ercvok8p5i4N5Swn3vg5rYvnnQeznN1TzvvtLC4hnCHOyxPCHT+kzXflARqsvidijEN4fk/c1CwWHf7Wig6PyNehNR6948GjI10qUZlOroZR9jxgOXXYPkr6FalaDTQbiiCRrMtCWZwjNsmotF1Zv9R5JR1syosrABo9Kbk9QBz51xgViEk6XWDQvoYJjPvSP2x8EVhDs4SA7FZK3X2M27VAHWTJy1Lx60EqInbI21YoVoZNp24Ne1MGH+RSZKEmfCFXK8pOWHMvhUCkE+kM4wnFoOIPiTMv8hyDPiX3ea5IHz+A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YVvwN/zv5IuspRqIT3U3MbQ10qvP5H869XN5IbaPgkjimVBUgjFjaXUvSaKcu1XH7fmT0z8aYpu9qHxcv+MynGZIpf6As08TD9xzeDuBBlBRdC7OZWF3JLeITqtZ6vyFJUT+vhydBatVOhCep8Ae/AMZ29LQrAN7bXs+jZ+Mi8VkocvOzxLLisRNq9LsRZOzyCh2fK/3wtkWLcgbmBM95TlhoMzxQkE8LjXjh0MNkAbvHuuMnuZ8B+VOLnRJZZsEZkaTysGvCyIT7hV43z97rqZ3ZpYM0KDGFaX4eoj3rgamhktrbr5PQZMZ4Mv6b+Y6UJ08swBmbH+0IOeu10zGrvDNCwdHGAdDuCGaPSUp0T7GK2x06k2/bc749TFKZ1t5EEWfntXq9NjQt/BTsL83nSoKXdyjiCFl4GysIZatEQAvthZeVK0PqL/7rS2dKQD1pEbiOvIxM5kDetriR5Egbz0bpViLGQLXLRLx/l+OCy46PlDt0QnzmUFxYGRQBI5MvbehQTXwIDvl10xa/z390fmAyzaH61xPLsXjhNfGHqM9qC7OlxeGcjYX5l+FVwv5bloL7Pvkobc2nJIlv9tu1v4eVWkd6oShcubV1mS8UeYOLGMrj4usGhOB7i1pMhOy7Vuo6epk8Ejd2I7W6lCvzA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39115695-53f9-4eaf-8555-08df1909bc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 00:29:31.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUGnLXCPuNNiZ/gZcmaIRcssJ81RbBHlq02ihItRJd/ENMmI4DsDQzMCxK6eABBNMdhHRubF/TrxCywDgWTYVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610
X-Proofpoint-ORIG-GUID: yW9xn7z-gaBUKdQsaviLptB8eXBN8rbd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwMSBTYWx0ZWRfXw9qbjeNad/ug
 AROKMwK9J/6jva3acPP0Wmot3nmglvzo2BX3KRAGCHsLjtKAl4OoAuzk0/9JPU3ZJIdRMgR8IbP
 PilLrZ/2PAL/2ier/+zli4f1iLr1ihcEOmdAaJS3ePxPGDSkdNdiOJepqRhjJSQWLm4dwUol+wm
 hPUSG1pOoDulNtqqQodG6BQKhRcIWQKvAMEXj32SxfJ7+env39L2EqMd4FhWSIz3SFItuSGl5N8
 rk8oSH03MITCDJkZ9y4uKuIIecHvFn2v/V/u9yb/Bt1A+OwSRGRB7yzYFZI2WBviaizImqxJdlz
 yvPZdMkdTPRblYY30EFjqGnhrEtx9vwIEH2JvNFnG29OMmsDhHbyG90xJe/tUCf9hP/E1q2LjKG
 X5tDxICcb5NmvoQnNPr7v1iXouEATWDDHn4sVNjlLQsKb5W36SrqdxlN+UJ2z15Y9xZuGoDwcnF
 sgQ6zA/Yt86QXLwVbZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwMSBTYWx0ZWRfXwUjHQ7axeMJu
 dlKoyrLE7vV3ixnfQSz+UUSk5LtsVo+YHfqxvs6ZAseBMYwSCx9aY3qbCw6/GYWkzlKgClFnw1m
 0yqHEjZ4hvDfvrZ9yU7/zKPRWve2ao4=
X-Proofpoint-GUID: yW9xn7z-gaBUKdQsaviLptB8eXBN8rbd
X-Authority-Analysis: v=2.4 cv=Mb/5KJ/f c=1 sm=1 tr=0 ts=6ab31d7a cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=pGLkceISAAAA:8 a=MsRR6VuwV5z4AEtHqVsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609230001

T24gVHVlLCBTZXAgMTUsIDIwMjYsIEppYXppIExpdSB3cm90ZToNCj4gV2hlbiBkd2MzX2NoZWNr
X2V2ZW50X2J1ZigpIHJlYWRzIGEgR0VWTlRDT1VOVCB2YWx1ZSBleGNlZWRpbmcgdGhlDQo+IGV2
ZW50IGJ1ZmZlciBsZW5ndGgsIGNvbW1pdCA2M2NjZDI2Y2QxZjYgKCJ1c2I6IGR3YzM6IGdhZGdl
dDogY2hlY2sNCj4gdGhhdCBldmVudCBjb3VudCBkb2VzIG5vdCBleGNlZWQgZXZlbnQgYnVmZmVy
IGxlbmd0aCIpIHJldHVybnMgSVJRX05PTkUNCj4gd2l0aG91dCB3cml0aW5nIGJhY2sgR0VWTlRD
T1VOVC4gU2luY2UgdGhlIERXQzMgaW50ZXJydXB0IGlzDQo+IGxldmVsLXRyaWdnZXJlZCwgdGhl
IHVuY2xlYXJlZCBJUlEgc291cmNlIGtlZXBzIHRoZSBsaW5lIGFzc2VydGVkLA0KPiBjYXVzaW5n
IGEgdGlnaHQgSVJRIHN0b3JtIHRoYXQgYWNjdW11bGF0ZXMgOTksOTAwIHVuaGFuZGxlZCBpbnRl
cnJ1cHRzDQo+IGFuZCB0cmlnZ2VycyBzcHVyaW91cy5jOjE4NCBCVUcgLT4ga2VybmVsIHBhbmlj
Lg0KPiANCj4gVGhlIHJlc3VsdGluZyBjYWxsIHN0YWNrOg0KPiAgIF9fcmVwb3J0X2JhZF9pcnEr
MHhhYy8weGM4DQo+ICAgbm90ZV9pbnRlcnJ1cHQrMHgzNDAvMHg0NjgNCj4gICBoYW5kbGVfaXJx
X2V2ZW50KzB4YWMvMHhjMA0KPiAgIGhhbmRsZV9mYXN0ZW9pX2lycSsweDEyMC8weDIyOA0KPiAg
IGdpY19oYW5kbGVfaXJxKzB4NjgvMHgxMDgNCj4gICAuLi4NCj4gICBrZXJuZWwgQlVHIGF0IGtl
cm5lbC9pcnEvc3B1cmlvdXMuYzoxODQNCj4gDQo+IFRvIHJlcHJvZHVjZSwgd3JpdGUgYSBib2d1
cyB2YWx1ZSBleGNlZWRpbmcgdGhlIGV2ZW50IGJ1ZmZlciBsZW5ndGgNCj4gZGlyZWN0bHkgdG8g
dGhlIEdFVk5UQ09VTlQgcmVnaXN0ZXI6DQo+IA0KPiAgIGRldm1lbSA8RFdDM19CQVNFICsgMHhj
NDBjPiA0IDB4MTAwNA0KPiANCj4gV3JpdGUgdGhlIGJvZ3VzIGNvdW50IGJhY2sgdG8gR0VWTlRD
T1VOVCB0byBjbGVhciB0aGUgSVJRIHNvdXJjZSwNCj4gY29uc2lzdGVudCB3aXRoIHRoZSBzdGFs
ZSBldmVudCBjbGVhcmluZyBwYXR0ZXJuIGluDQo+IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cCgp
LCBhbmQgc2NoZWR1bGUgZXJyb3IgcmVjb3ZlcnkgdG8NCj4gcmVpbml0aWFsaXplIHRoZSBjb250
cm9sbGVyLg0KPiANCj4gRml4ZXM6IDYzY2NkMjZjZDFmNiAoInVzYjogZHdjMzogZ2FkZ2V0OiBj
aGVjayB0aGF0IGV2ZW50IGNvdW50IGRvZXMgbm90IGV4Y2VlZCBldmVudCBidWZmZXIgbGVuZ3Ro
IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3VnZ2VzdGVkLWJ5OiBUaGluaCBO
Z3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEppYXpp
IExpdSA8amlhemkubGl1MTk4NEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdj
My9jb3JlLmggICB8ICAxOSArKysrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2VwMC5jICAgIHwg
ICA5ICsrKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAxMDggKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTM0IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==
