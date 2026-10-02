Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C66331EBD;
	Fri,  2 Oct 2026 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790907273; cv=fail; b=epMTmjyGrzmy88qQKBbiGFt1qfp7tz+vv0vam0PIjUug8B9UxFvWKxzMU9to0uV83I/ku1V6GSM+TTlv183ZzIRaoazY2dKsjPLD+EKnPpTFk2UIh4TNfC0JIOr0rNUUoTxqavD0e0DFhiIkVSMhfnQfVPaznEHfA+CF0kiGwtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790907273; c=relaxed/simple;
	bh=xa6P41lA75d78sIS8MbcJ7D8MbwgIYmUOHH9VY2qakk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dpxRVXJ6mGiIjHFBRUw33K83xkBTSM51m89C9I8V0NhDHQzcFH6SRcWmnS/kWlSpRQI5ImQxjMzoQNgQ2IV2iD0qRngHxBnZNgsjX3WfpEhI86nF6yRMzAyHJ7o4FX7XefjhtkopXA/ZW6H7RBvgTmu5IwPkWppbzA1Yu5FWKUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=R3eDcZFu; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VVzTCF0z; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hxt8lULP reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R3eDcZFu";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VVzTCF0z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hxt8lULP"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691NGFWt2407505;
	Thu, 1 Oct 2026 19:14:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=xa6P41lA75d78sIS8MbcJ7D8MbwgIYmUOHH9VY2qakk=; b=
	R3eDcZFuoOcIfeBLChGWU/GjFXAl5U4KIVzphKdpVmIsN6v2/EocL6yz8GG/yREg
	90zIL7wA4nF4oXoYUpJ8dAJdeWbhBGrLzQV34vPASV/C4+hS47CSnYcjHJheo9vv
	QtJkTYle7ZBwExg+KrKlYy8DXFkbE5eoCyZGsVkLbVhqZhEt52iWIPOuOuMuSE8t
	DL0I40gYXPTv0f515WmaxxFJpzeV/dR60/i7yVu/Z5pXxm4/HzJFJLWFqAdTysu/
	Zvkrd1CpEfDWVkO/GCgZkejJemsxZ8B0sslaBFXNwSwPwHsYU+UlFak/REshWVLJ
	1pp2Zr6iU/HBbEW4wvUn2g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4h1f3j8jww-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 19:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1790907262; bh=xa6P41lA75d78sIS8MbcJ7D8MbwgIYmUOHH9VY2qakk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=VVzTCF0ze4P7DSM0/vBrGLaHobpgQR6Dtnf24uJZO4AvYv4jBV4b/neLOnMqKoeoZ
	 qxMjBCBNgbUXvaPqdBPPkHHsxVXZcNQydBhu0J8Q+dN2VEhw+x4an4E8kbBv0gjqAj
	 Drz9uXhRcT0yYxbhI49wEYTc6VDi6eIcXkXllhlRkw0YCqakOr/1ueklCaM7ajaOpi
	 N/ss1WFomtfywxcbP9U5I0F70Ep1MCz9pqythIACMnMs73/5LNiNpAJTTUFjkWkl76
	 zfCCoTH3ebFUuiIBH9QEKT985/WhumLA/Wu2Mts6Fkwtxuv7gPkffEt4PssPlJ7qNv
	 0LJQ2AkIx04Ug==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D9FB840142;
	Fri,  2 Oct 2026 02:14:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5EEC0A09F8;
	Fri,  2 Oct 2026 02:14:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hxt8lULP;
	dkim-atps=neutral
Received: from CH4PR07CU001.outbound.protection.outlook.com (mail-ch4pr07cu00101.outbound.protection.outlook.com [40.93.20.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 033F6401D1;
	Fri,  2 Oct 2026 02:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chVEeqbOEVE3TVgIWOP5s8rKYb8XwwB8U9sFW08kXR2HckzdFwkaa/SXw8w+Tx9TCewsusK1W9zjvDK97+Bc0rNcGTmNo4SVz5cJhw1wwCwMIr7ixDbMz0g5rpFqbH0fgsWsUm1esaXHv5qAyMh4/NpWsslXzx+73QO+TApq8nIhHm3CHD5XGEKOKa94vPT9eYQNnri/HRM+eJkhgU/KgNY+4kOqCbeo16L1HhHNEZmCrRjCjikK31X0VPOcqEMzNAhXoEKnR1paPUH1dJBVzw09xbgibfbXWwLBq1snsoRXrV9dHIzKbL3lQtqtWXvgZ3GOgJDJFO9RtIpg7AkxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xa6P41lA75d78sIS8MbcJ7D8MbwgIYmUOHH9VY2qakk=;
 b=qy9WNIy5tJJnvSae3Ue4779kqagDCrHD8XxrnTdjv6chP/49ho8oUsydbW8XOMEF1GU9l9ZG1YLfoomNPCBB/+0qeCMtSA5AcE1ZrAL8RQ1PXsszzOrPPX3INgGPDLVuQeOFu1IdPLJ6ZlLODkXtq2zKQN0GBIXqK6vCm0DqlC50x205jz6krzRwn8desaI7yMQTDFq1jTtOtRYNEnQp22FQTwXh60e0F4k7a5lvc9JRBgr5WokW0Xcf/5PRwElPc6zy6tw8iX727oYr9T8xyZ49x4BDIcE/oH/8Tt3K7wnNRyQcRAe7TM3MOcp9FrguBayNA5COgDtAM4WkNDaj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa6P41lA75d78sIS8MbcJ7D8MbwgIYmUOHH9VY2qakk=;
 b=hxt8lULPOUXGN7QEJ9pvns/Q8MJ5Fytmf/JHEOkxS//eGlGwgBFPvWxA4Z7fufcpGKNS5f7BgJ0pqM3VzTrq9YJMn5AZq7lS9fnCucVvC120dw7iwCOh3LazTkFDfxc5bqSin7R46mahmj+ljArr70w5F64bsn2cHosZ1ftKsjc=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 02:14:15 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0451.026; Fri, 2 Oct 2026
 02:14:14 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] usb: dwc3: xilinx: re-assert resets on ZynqMP init
 error paths
Thread-Topic: [PATCH v2 2/3] usb: dwc3: xilinx: re-assert resets on ZynqMP
 init error paths
Thread-Index: AQHdSr9SlnRs+UQtiU65MtT3ZtClXLbpkcqA
Date: Fri, 2 Oct 2026 02:14:14 +0000
Message-ID: <ar8R-7wbcWpxmF5m@vbox>
References: <20260922182125.11067-1-radhey.shyam.pandey@amd.com>
 <20260922182125.11067-3-radhey.shyam.pandey@amd.com>
In-Reply-To: <20260922182125.11067-3-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DM4PR12MB8560:EE_
x-ms-office365-filtering-correlation-id: 2ba5c730-01a4-4529-4781-08df202adad0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|4143699003|6133799003|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 04hrB4c+JzTC4VOGCu7OeXV0qlyL8exyUt87CFUxlsBUlxlrO2cbp2g8GyPtXQ40TxOln6ij/0J0Ki1Gs787z6w6JhhslD4cEwH7yvl4VkNBoleAZkBsN5FjGWE7CH7KIRFgYKdlBXbnVrso8AWLpzX1hrI+q17dyAfoehv5J/Fuon4g73H+LP1CEl/4lGpesoKB86nYgxf+MGPbIuxMskanHjH2gS/AZutwh9a8Nkn4E46HRAB8wOkH++LWf8etnv8BykLfeWCOZBeg93fhjgzvFSi3XxTXa2NNPQ+8LasptCFH3KopknyhMrswHHoDHFVCRrwWID0h3O6CFLxHnq/AOR3cney2u8nRFpmXbdbfjOIWyC26IUlBwEXcltCg6WEYPnw/E9cYk95TkpASZKGQuEvIenCpxe0wdjUyyGD9Pd5cadQND8dzIaJ+FeXAO5O11pumocCffLNdB77LZixHUPPzZ1G6dEzME8GK/BcPWPG2+JiyGyNaskJQEOH+sbCJV3Ek4vyPXH8pq3Bz/QPMwF2A3qVmMdqItiWmQpUUnt+YA8VLAgqKPy3BTLfcO+1FpjEVu8JC0/dcfRU0nQprWL24EbHSur4vUTkCsbSqE2y7TYyFiG9FDzZk1x4Du/16b5jgcf3zVXijaZ8WXAJ2NhIskFck6dSuhWwVfE7xyz7REkfvJll1+DY2rTjOu0bPAN2QNWMdGW18uwM5TrjnWvcQGFGfXNond0wnYVE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3Ftczh6V2hSMmRyMkdRZTNGbUZoeTRrZjA2dUllcGErVWdTZURpWm4ydk1D?=
 =?utf-8?B?Nk9pcTdxUTNORjhnZEgzczFwcFZydVFKNmRiMkdHV2EydVZEOGpmaUtzNUtF?=
 =?utf-8?B?VWtGcnBWc1lzcjRJNWxLcVd4MWl4bVZWMXVDaUF2SkJLY0htL2NOR2tPZW5k?=
 =?utf-8?B?dlV5cDE1am9qMVpFaUp5bkxENTdvYWpoWDJYL2FmelhNc3JrUktZZ1pxeXRk?=
 =?utf-8?B?RFpLaEllS2lEY2tNa0N5aVRNc20yMENJQmwzT0pHSmIyTlJUUTFwOXVvVGFt?=
 =?utf-8?B?UWozaEU0NjEyQjJXUit1d2lteEJ1OEhHNGptRVh6NzExUjBhTjAyTTBUd0Jy?=
 =?utf-8?B?c1lXdGtYakx0RTVlV0RnUnhCTWorejVpaXJUMzNGaGYwdlVVdWdJUTJibVRq?=
 =?utf-8?B?OHo0Qkh4NWp1MEcrbWcwNU41YzkyT2pLNmNlWGJJSitOMHJiQ2tKK3FpS3dt?=
 =?utf-8?B?Nm5Ja0NQZ3JncVFpNTB3ejhqUzhhUG5VNDIyQ2dPR2prTlU4cjNJUVMrMDJW?=
 =?utf-8?B?SnVUcFlrbGpyeXFWMHBNOGNHMFh1eU5HclMwUmZSdzZ6QUF6b05EbENKTjlG?=
 =?utf-8?B?RlVNVGZkbExqdEdWdE9TWGlhcEpNUmw3b0pNT0RSWXZ4bmVKa05tZVphYnBq?=
 =?utf-8?B?VjlyNkdrS2xGVDdOTlAva3cvbG1qVVlpSjdhMnJMOFJ5RkhPdHA3WXFXNnlT?=
 =?utf-8?B?WGU3MXVnc2tzSHZZTkNxRVlac1F1VzlpV0JFbVpYUVhHYmxoTG5FN3FuRGEw?=
 =?utf-8?B?ZUEweVNjd0xYS2NLLzhxSVk4MlJGS3JhQ0t2ajA4aHFSOFEwTEhWaUpnWGVZ?=
 =?utf-8?B?SUR3VTh0b3p0U2U3b3A4NElZd0FuZzdSdGRZMDlPWG81Vnh4bVU0TkZIaGZL?=
 =?utf-8?B?ZSt5YWVwMDFib1RZbVNlNVAyQTc4Y3JVOExFajk0SjJWc1FPTlgvMTNnL2Vu?=
 =?utf-8?B?MW8wSDhqTFB0WkZqNlNpakpHclpReXpZdzQwVkRhd2dnTzdXaDc0cXJNajU5?=
 =?utf-8?B?MUNjRWJZa0JkUVo0OFpQVEJLKzRrTlg2blp4NUxMUjFpakV0TlVrdEJ3S3Y4?=
 =?utf-8?B?aENEckFIaGxZT2duTzBvYkg1Vmh4eWxNOHJFZDhYRENBbVQzVU01djEweFlW?=
 =?utf-8?B?bWhoUTNDRlhVYXRVdlhobkE0cXlqRkNwU05pTnJwcTU2S1pHc29TQVhnZ1pV?=
 =?utf-8?B?dXU4eDdMWkkxZHdPaWl3OWw4WlRjMStHYlpjY3JDU1dpZzdnUk9mdDJ6Nkhq?=
 =?utf-8?B?dGR3bmlNTHBQaU5pZWVtZURuQ0FDM2NQckFNK0NDNU11REduRVJmZHpiUjdq?=
 =?utf-8?B?bWNWa1JQMWxGNTNqRFdUSi9FdTB2ZkpKVWJOYW91S093bnIrdUxCWHRuNEJt?=
 =?utf-8?B?RERGK2pGdGFoZmFTd1oxaXduVkJBdjRmc1lOR3pZQ2FSNnpHKzdFN0hJaEd1?=
 =?utf-8?B?WGpDU05DSHcwT1ZUbUxFRG13TEhXTWMrVmtJd05XL0I1RUdTNlZCT2Q3d1Y4?=
 =?utf-8?B?a0VtSWc0TUtsMU1YVUJoNnh0V0tLN0xqRzZ3aXBkYSsvVXJ1Z3JSQUM4WGdD?=
 =?utf-8?B?KzgzZEgrb0swTS9ZK0R1UGd6VVlJc0hwZDMzOXF0bkwwcmdVQ1BRYXJ5RUIv?=
 =?utf-8?B?MitpSG1UMUIvY1FKMFFxUDRta0ZMNU10RTVCUWFJc0dib3E3Z0IwRzVwTzBt?=
 =?utf-8?B?Y05HVGNENkY3alExSXJ5c3UxNlp4NWhSanRTall4M0JQeUgrNVpRQzUrNDB5?=
 =?utf-8?B?TXB3cnNOWUNNRWk3VUNpc1NCaDJqUzRBck9OMWFVQzdZZ1V0cFJBNms5NHl1?=
 =?utf-8?B?eDVFdDVQZDV3UjZhQjZOSno1dmsycmsvUWZ4YTNLektEVDVFd293ZVU0aUI5?=
 =?utf-8?B?d3l5VW9JMGFvWFJmOWF5ZklsNUNHVUh3MzBDVkx3Zy9CYi9rbHBWT3JqYkpt?=
 =?utf-8?B?TnpQMDNTN2VLbS9OUnJQek9IMytkTEZZNTNJSS9BOC9VZGtsVDRWSTc5Q1Rw?=
 =?utf-8?B?L2hicjFtOVhxMUYvRDdXUmhyTjJxRGgwbVBrUDA4ZGIrSGE2a1BnUHRweTNH?=
 =?utf-8?B?NW5FM0FIZHZZcTdqeVpxNDcvcnZOVSs5VXpXL2RTaEZVRGlWNitVWGNGT00v?=
 =?utf-8?B?MjdINWN3R0tJNEdvUTRLZ3VxUDBkSEE5d1VhdDQ1TmFlSU8ySUQvVHZzaExo?=
 =?utf-8?B?TVdiVkNIZXNDWjVWaEw1Mzc1K29JRTYxWVRWWkk1Yjc5L2IvcGpRai9CZVQx?=
 =?utf-8?B?cEVUTjZ4cVV4Q2lxQ3NWTXRVL0pjTk5HYUdVdHQvcldIUTRQVUtTcUhYd2U0?=
 =?utf-8?B?OElWdmR0V0t3eWNMVER6SWxGb2dCYlA5Mmk4SC9zMDQ1UVZOWlVEdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA274777FDA851428313907C3693D368@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	h1teWO25Nnum7186ycaHfi5eelJ4+z9T6+ylkWoTra92v95bDGXbd0fAxXN7St5huHaKbcB3cmrHJJjvGUXtchv6yYo8dIqh2OSSZkpkT7GJG36bdCyIhVJV9kLqz7Rn8uRt/DrZUC9R7EI2hfRBgUnpQedD5zU6+QAxANoov2LWEMfV7ZTEHDXAn9vtk2j302Mi0nqpZs7OFUOY0IiiLWzDCmLME8FGglG9EX5sU4Svd/N6cdihoYgnNmUHW/CRtecKGeK/woInh6UDy9hs9mndfxYjAe4Q7InD2uXz/fnj2pYUbP3eDQzfY1dFScV47PMWSmMo5pP+0LKrw0JZnA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2UMSzX0uzBsQRs6cCMTTv8yp0Co2o/G8vNStnTQkIy4CH30TrdsUUYjXK7Z93UKA5PyIuA9zCAxUOM7rSPpAI4JYn5RXE8HNOZ1PCawoOdfz30BT+0JFUdfPeOSs8qFvzEwLt24E/6rMaH44EfByNCDJxvhwyg1ksS+ONby+57NvTAH9UoJjC6UJhDd+My4dO1HESqgEOCkCEWZUEJbecHoc+pKJzmw622SrRy2acZdnA9wPWOR9z1TWHdwxTdvXRFgqKTRGnBpgrc+FAKe6ssZ+YFjtqHUgRYYmXS1D1ZVlPeHBAojHQn0w5pi0nz3sLqfLrv1h8kzTneLyrFmo8VtfuSoI7L/7Q7FeT9d9x0gCiCHFEyVf5F9JOWTUBaVloG2mb6L8XLCEYa9AX/wHwSpeNcu2QpgBBUO/Tl590/GDUTwDxHgkHjmpcjCdTS69v8/I1FjKZgh0F9kqOrx52pZdfiYewMzRse4APWV1DccRhlBRfqlJohxhdVBJ108Eo8wdHe8QDYVCnN8QcsCkgxMl7iACJYeR1eEvGbYjYLS5EjtZrJipajRTg+6aH+ATYKu1n8N6a+Xq8+sRuiL/8+mpZxYoLI3WGbuUt71JrSobqvrANvR1Cjk9qOFqA4bZqBQ56o5i2t4Ql0nNKXdJog==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba5c730-01a4-4529-4781-08df202adad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 02:14:14.1321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /dpnoQ7bMO0wbrc1B+/nIlsJMuvmY0P0OAvlr5vHBq07xcYkdJSw9RhvxCkYJAlbSkgBcD+1m7VMXBSpOiRZ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
X-Proofpoint-ORIG-GUID: Sc00Ji7IiSq6yOUeQ06wV5G_16bBcGqo
X-Authority-Analysis: v=2.4 cv=AfkkjHXG c=1 sm=1 tr=0 ts=6abf137f cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=jIQo8A4GAAAA:8 a=uCULoaDQZkLlvRRKz9oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Sc00Ji7IiSq6yOUeQ06wV5G_16bBcGqo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAwOCBTYWx0ZWRfX9XSIrtaXCfEm
 CrN+pGffiydG8kOFyvaVR3ApaQ6DfB23SuFIgd9V523KkArHRjJrtLDsI+kj++EKCE+sAHypdBh
 7xl7B2ve3/s0f7VXtcKyE4caO98TzhLxlqrSWO34iXe2GH8VntaR+FhIUmZ886F9ENwhGDOhN9w
 5mW5kzOChABKdH74mnmNyo/Y1a5/NyWXqKKd+Ian0Cz2ZnnuNta74T0VN4aVBMSsBsUFN/u8jDs
 14G730avy8K7gb5hCPDegAOPq1ce1kDwBMXm33rDajV7PMEcI0efu/f0mzst/ihOyoZihmPvxVU
 ZLLOqSgrOTlYw+SyPZgdmHQuGmMtUcQJfBHRYchsxeJkpVOz2Bu3Bf8AbpLaZCuqqRrjSeJaB+b
 MIbQ8LKHSR5kKrxa5phz7GJcNh+b6EAN8wP6m1pWnVqzRod+R6Btwk7d/aFazc8Qzhe6kL/vZ9o
 WCIz5E2EyS7fsWjFmLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAwOCBTYWx0ZWRfX/eUlYk5iQuDr
 hXIUE/wRqOd5ijdnmP3mgt+Tpcc8PwwG9Op0vSxXelPVfHIOfbxivAmhlrgUazNH0iHS59rufob
 JtLXqoVWlH6K1knEZb/DSJ/9val4y94=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_05,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 priorityscore=1501 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2610020008

T24gVHVlLCBTZXAgMjIsIDIwMjYsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IElmIHJl
c2V0IGRlYXNzZXJ0IG9yIFBIWSBzZXR1cCBmYWlscyBwYXJ0d2F5IHRocm91Z2gNCj4gZHdjM194
bG54X2luaXRfenlucW1wKCksIHJlLWFzc2VydCBhbnkgcmVzZXRzIHRoYXQgd2VyZSBhbHJlYWR5
DQo+IHJlbGVhc2VkIGJlZm9yZSB1bndpbmRpbmcgdGhlIFBIWS4gVXNlIGZhbGwtdGhyb3VnaCBl
cnJvciBsYWJlbHMgc28NCj4gdW53aW5kIG1hdGNoZXMgaG93IGZhciBpbml0IHByb2dyZXNzZWQs
IGZvciBib3RoIFVTQjIgYW5kIFVTQjMgcGF0aHMuDQo+IA0KPiBTYXZlIHRoZSBaeW5xTVAgcmVz
ZXQgaGFuZGxlcyBpbiBkcml2ZXIgcHJpdmF0ZSBkYXRhIHNvIGxhdGVyIHByb2JlDQo+IHRlYXJk
b3duIGNhbiByZS1hc3NlcnQgcmVsZWFzZWQgcmVzZXRzLg0KPiANCj4gRml4ZXM6IDg0NzcwZjAy
OGZhYiAoInVzYjogZHdjMzogQWRkIGRyaXZlciBmb3IgWGlsaW54IHBsYXRmb3JtcyIpDQo+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9w
dXMtNQ0KPiBTaWduZWQtb2ZmLWJ5OiBSYWRoZXkgU2h5YW0gUGFuZGV5IDxyYWRoZXkuc2h5YW0u
cGFuZGV5QGFtZC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFNwbGl0IG91dCBv
ZiB0aGUgY29tYmluZWQgZml2ZSBwYXRjaCBzZXJpZXM7IHNlZSBwYXRjaCAxLg0KPiAtIFJlb3Jk
ZXJlZCBhaGVhZCBvZiB0aGUgcGxhdGZvcm0tZGF0YSBjbGVhbnVwcy4NCj4gLSBBZGRlZCBDYzog
c3RhYmxlLg0KPiAtIE5vIGZ1bmN0aW9uYWwgY2hhbmdlIHRvIHRoZSBwYXRjaCBpdHNlbGYuDQo+
IA0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIHwgNDkgKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyks
IDE5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdj
My14aWxpbnguYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiBpbmRleCA4YzYz
ZTAyNTc1ZjEuLmQxOGQzZTM2NDM4MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9k
d2MzLXhpbGlueC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiBA
QCAtNDgsNiArNDgsMTAgQEAgc3RydWN0IGR3YzNfeGxueCB7DQo+ICAJdm9pZCBfX2lvbWVtCQkJ
KnJlZ3M7DQo+ICAJaW50CQkJCSgqcGx0Zm1faW5pdCkoc3RydWN0IGR3YzNfeGxueCAqZGF0YSk7
DQo+ICAJc3RydWN0IHBoeQkJCSp1c2IzX3BoeTsNCj4gKwlzdHJ1Y3QgcmVzZXRfY29udHJvbAkJ
KnVzYl9jcnN0Ow0KPiArCXN0cnVjdCByZXNldF9jb250cm9sCQkqdXNiX2hpYnJzdDsNCj4gKwlz
dHJ1Y3QgcmVzZXRfY29udHJvbAkJKnVzYl9hcGJyc3Q7DQo+ICsJYm9vbAkJCQl1c2JfcmVzZXRz
X3JlbGVhc2VkOw0KDQpNaW5vciBuaXQ6DQoNClRoZSB1c2JfcmVzZXRzX3JlbGVhc2VkIHNlZW1z
IHRvIHJlcHJlc2VudCBtb3JlIHRoYW4ganVzdCB0aGUgcmVzZXQNCnN0YXRlLiBJdCdzIG9ubHkg
c2V0IGFmdGVyIHRoZSBlbnRpcmUgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2Ugc3VjY2VlZHMsDQp1
c2UgaXQgdG8gaW5kaWNhdGUgdGhhdCBpbml0aWFsaXphdGlvbiBjb21wbGV0ZWQgc3VjY2Vzc2Z1
bGx5Lg0KDQpQZXJoYXBzIHJlbmFtZSB0byAiaW5pdGlhbGl6ZWQiIG9yICJpbml0X2RvbmUiPw0K
DQpUaGlzIGlzIG9ubHkgYSBuYW1pbmcgc3VnZ2VzdGlvbiBhbmQgbm90IHNvbWV0aGluZyBJJ2Qg
YmxvY2sgdGhlIHBhdGNoDQpvbjoNCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1
eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiAgfTsNCj4gIA0KPiAgc3Rh
dGljIHZvaWQgZHdjM194bG54X21hc2tfcGh5X3JzdChzdHJ1Y3QgZHdjM194bG54ICpwcml2X2Rh
dGEsIGJvb2wgbWFzaykNCj4gQEAgLTExMiw3ICsxMTYsNiBAQCBzdGF0aWMgaW50IGR3YzNfeGxu
eF9pbml0X3ZlcnNhbChzdHJ1Y3QgZHdjM194bG54ICpwcml2X2RhdGEpDQo+ICBzdGF0aWMgaW50
IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1Y3QgZHdjM194bG54ICpwcml2X2RhdGEpDQo+ICB7
DQo+ICAJc3RydWN0IGRldmljZQkJKmRldiA9IHByaXZfZGF0YS0+ZGV2Ow0KPiAtCXN0cnVjdCBy
ZXNldF9jb250cm9sCSpjcnN0LCAqaGlicnN0LCAqYXBicnN0Ow0KPiAgCXN0cnVjdCBncGlvX2Rl
c2MJKnJlc2V0X2dwaW87DQo+ICAJaW50CQkJcmV0ID0gMDsNCj4gIA0KPiBAQCAtMTI0LDI1ICsx
MjcsMjUgQEAgc3RhdGljIGludCBkd2MzX3hsbnhfaW5pdF96eW5xbXAoc3RydWN0IGR3YzNfeGxu
eCAqcHJpdl9kYXRhKQ0KPiAgCQlnb3RvIGVycjsNCj4gIAl9DQo+ICANCj4gLQljcnN0ID0gZGV2
bV9yZXNldF9jb250cm9sX2dldF9leGNsdXNpdmUoZGV2LCAidXNiX2Nyc3QiKTsNCj4gLQlpZiAo
SVNfRVJSKGNyc3QpKSB7DQo+IC0JCXJldCA9IFBUUl9FUlIoY3JzdCk7DQo+ICsJcHJpdl9kYXRh
LT51c2JfY3JzdCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfZXhjbHVzaXZlKGRldiwgInVzYl9j
cnN0Iik7DQo+ICsJaWYgKElTX0VSUihwcml2X2RhdGEtPnVzYl9jcnN0KSkgew0KPiArCQlyZXQg
PSBQVFJfRVJSKHByaXZfZGF0YS0+dXNiX2Nyc3QpOw0KPiAgCQlkZXZfZXJyX3Byb2JlKGRldiwg
cmV0LA0KPiAgCQkJICAgICAgImZhaWxlZCB0byBnZXQgY29yZSByZXNldCBzaWduYWxcbiIpOw0K
PiAgCQlnb3RvIGVycjsNCj4gIAl9DQo+ICANCj4gLQloaWJyc3QgPSBkZXZtX3Jlc2V0X2NvbnRy
b2xfZ2V0X2V4Y2x1c2l2ZShkZXYsICJ1c2JfaGlicnN0Iik7DQo+IC0JaWYgKElTX0VSUihoaWJy
c3QpKSB7DQo+IC0JCXJldCA9IFBUUl9FUlIoaGlicnN0KTsNCj4gKwlwcml2X2RhdGEtPnVzYl9o
aWJyc3QgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X2V4Y2x1c2l2ZShkZXYsICJ1c2JfaGlicnN0
Iik7DQo+ICsJaWYgKElTX0VSUihwcml2X2RhdGEtPnVzYl9oaWJyc3QpKSB7DQo+ICsJCXJldCA9
IFBUUl9FUlIocHJpdl9kYXRhLT51c2JfaGlicnN0KTsNCj4gIAkJZGV2X2Vycl9wcm9iZShkZXYs
IHJldCwNCj4gIAkJCSAgICAgICJmYWlsZWQgdG8gZ2V0IGhpYmVybmF0aW9uIHJlc2V0IHNpZ25h
bFxuIik7DQo+ICAJCWdvdG8gZXJyOw0KPiAgCX0NCj4gIA0KPiAtCWFwYnJzdCA9IGRldm1fcmVz
ZXRfY29udHJvbF9nZXRfZXhjbHVzaXZlKGRldiwgInVzYl9hcGJyc3QiKTsNCj4gLQlpZiAoSVNf
RVJSKGFwYnJzdCkpIHsNCj4gLQkJcmV0ID0gUFRSX0VSUihhcGJyc3QpOw0KPiArCXByaXZfZGF0
YS0+dXNiX2FwYnJzdCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfZXhjbHVzaXZlKGRldiwgInVz
Yl9hcGJyc3QiKTsNCj4gKwlpZiAoSVNfRVJSKHByaXZfZGF0YS0+dXNiX2FwYnJzdCkpIHsNCj4g
KwkJcmV0ID0gUFRSX0VSUihwcml2X2RhdGEtPnVzYl9hcGJyc3QpOw0KPiAgCQlkZXZfZXJyX3By
b2JlKGRldiwgcmV0LA0KPiAgCQkJICAgICAgImZhaWxlZCB0byBnZXQgQVBCIHJlc2V0IHNpZ25h
bFxuIik7DQo+ICAJCWdvdG8gZXJyOw0KPiBAQCAtMTU2LDE5ICsxNTksMTkgQEAgc3RhdGljIGlu
dCBkd2MzX3hsbnhfaW5pdF96eW5xbXAoc3RydWN0IGR3YzNfeGxueCAqcHJpdl9kYXRhKQ0KPiAg
CSAqIGFic2VudC4NCj4gIAkgKi8NCj4gIAlpZiAocHJpdl9kYXRhLT51c2IzX3BoeSkgew0KPiAt
CQlyZXQgPSByZXNldF9jb250cm9sX2Fzc2VydChjcnN0KTsNCj4gKwkJcmV0ID0gcmVzZXRfY29u
dHJvbF9hc3NlcnQocHJpdl9kYXRhLT51c2JfY3JzdCk7DQo+ICAJCWlmIChyZXQgPCAwKSB7DQo+
ICAJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBhc3NlcnQgY29yZSByZXNldFxuIik7DQo+ICAJ
CQlnb3RvIGVycjsNCj4gIAkJfQ0KPiAgDQo+IC0JCXJldCA9IHJlc2V0X2NvbnRyb2xfYXNzZXJ0
KGhpYnJzdCk7DQo+ICsJCXJldCA9IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KHByaXZfZGF0YS0+dXNi
X2hpYnJzdCk7DQo+ICAJCWlmIChyZXQgPCAwKSB7DQo+ICAJCQlkZXZfZXJyKGRldiwgIkZhaWxl
ZCB0byBhc3NlcnQgaGliZXJuYXRpb24gcmVzZXRcbiIpOw0KPiAgCQkJZ290byBlcnI7DQo+ICAJ
CX0NCj4gIA0KPiAtCQlyZXQgPSByZXNldF9jb250cm9sX2Fzc2VydChhcGJyc3QpOw0KPiArCQly
ZXQgPSByZXNldF9jb250cm9sX2Fzc2VydChwcml2X2RhdGEtPnVzYl9hcGJyc3QpOw0KPiAgCQlp
ZiAocmV0IDwgMCkgew0KPiAgCQkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gYXNzZXJ0IEFQQiBy
ZXNldFxuIik7DQo+ICAJCQlnb3RvIGVycjsNCj4gQEAgLTE3OSw3ICsxODIsNyBAQCBzdGF0aWMg
aW50IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1Y3QgZHdjM194bG54ICpwcml2X2RhdGEpDQo+
ICAJaWYgKHJldCA8IDApDQo+ICAJCWdvdG8gZXJyOw0KPiAgDQo+IC0JcmV0ID0gcmVzZXRfY29u
dHJvbF9kZWFzc2VydChhcGJyc3QpOw0KPiArCXJldCA9IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQo
cHJpdl9kYXRhLT51c2JfYXBicnN0KTsNCj4gIAlpZiAocmV0IDwgMCkgew0KPiAgCQlkZXZfZXJy
KGRldiwgIkZhaWxlZCB0byByZWxlYXNlIEFQQiByZXNldFxuIik7DQo+ICAJCWdvdG8gZXJyX3Bo
eV9leGl0Ow0KPiBAQCAtMTk1LDIxICsxOTgsMjEgQEAgc3RhdGljIGludCBkd2MzX3hsbnhfaW5p
dF96eW5xbXAoc3RydWN0IGR3YzNfeGxueCAqcHJpdl9kYXRhKQ0KPiAgCQl3cml0ZWwoUElQRV9D
TEtfREVTRUxFQ1QsIHByaXZfZGF0YS0+cmVncyArIFhMTlhfVVNCX0ZQRF9QSVBFX0NMSyk7DQo+
ICAJfQ0KPiAgDQo+IC0JcmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2VydChjcnN0KTsNCj4gKwly
ZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KHByaXZfZGF0YS0+dXNiX2Nyc3QpOw0KPiAgCWlm
IChyZXQgPCAwKSB7DQo+ICAJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJlbGVhc2UgY29yZSBy
ZXNldFxuIik7DQo+IC0JCWdvdG8gZXJyX3BoeV9leGl0Ow0KPiArCQlnb3RvIGVycl9hcGJyc3Rf
YXNzZXJ0Ow0KPiAgCX0NCj4gIA0KPiAtCXJldCA9IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoaGli
cnN0KTsNCj4gKwlyZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KHByaXZfZGF0YS0+dXNiX2hp
YnJzdCk7DQo+ICAJaWYgKHJldCA8IDApIHsNCj4gIAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8g
cmVsZWFzZSBoaWJlcm5hdGlvbiByZXNldFxuIik7DQo+IC0JCWdvdG8gZXJyX3BoeV9leGl0Ow0K
PiArCQlnb3RvIGVycl9jcnN0X2Fzc2VydDsNCj4gIAl9DQo+ICANCj4gIAlyZXQgPSBwaHlfcG93
ZXJfb24ocHJpdl9kYXRhLT51c2IzX3BoeSk7DQo+ICAJaWYgKHJldCA8IDApDQo+IC0JCWdvdG8g
ZXJyX3BoeV9leGl0Ow0KPiArCQlnb3RvIGVycl9oaWJyc3RfYXNzZXJ0Ow0KPiAgDQo+ICAJLyog
dWxwaSByZXNldCB2aWEgZ3Bpby1tb2RlcGluIG9yIGdwaW8tZnJhbWV3b3JrIGRyaXZlciAqLw0K
PiAgCXJlc2V0X2dwaW8gPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbChkZXYsICJyZXNldCIsIEdQ
SU9EX09VVF9ISUdIKTsNCj4gQEAgLTIyNiwxMCArMjI5LDE4IEBAIHN0YXRpYyBpbnQgZHdjM194
bG54X2luaXRfenlucW1wKHN0cnVjdCBkd2MzX3hsbnggKnByaXZfZGF0YSkNCj4gIA0KPiAgCWR3
YzNfeGxueF9zZXRfY29oZXJlbmN5KHByaXZfZGF0YSwgWExOWF9VU0JfVFJBRkZJQ19ST1VURV9D
T05GSUcpOw0KPiAgDQo+ICsJcHJpdl9kYXRhLT51c2JfcmVzZXRzX3JlbGVhc2VkID0gdHJ1ZTsN
Cj4gKw0KPiAgCXJldHVybiAwOw0KPiAgDQo+ICBlcnJfcGh5X3Bvd2VyX29mZjoNCj4gIAlwaHlf
cG93ZXJfb2ZmKHByaXZfZGF0YS0+dXNiM19waHkpOw0KPiArZXJyX2hpYnJzdF9hc3NlcnQ6DQo+
ICsJcmVzZXRfY29udHJvbF9hc3NlcnQocHJpdl9kYXRhLT51c2JfaGlicnN0KTsNCj4gK2Vycl9j
cnN0X2Fzc2VydDoNCj4gKwlyZXNldF9jb250cm9sX2Fzc2VydChwcml2X2RhdGEtPnVzYl9jcnN0
KTsNCj4gK2Vycl9hcGJyc3RfYXNzZXJ0Og0KPiArCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KHByaXZf
ZGF0YS0+dXNiX2FwYnJzdCk7DQo+ICBlcnJfcGh5X2V4aXQ6DQo+ICAJcGh5X2V4aXQocHJpdl9k
YXRhLT51c2IzX3BoeSk7DQo+ICBlcnI6DQo+IC0tIA0KPiAyLjQzLjANCj4g
