Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1093DDAFB;
	Fri, 11 Sep 2026 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168380; cv=fail; b=FYO77G1xghQ5DVoyoV47ttS0mNz3v/sTqOOBGP+mI4t3U4J5UH1p9nbG2vHBd2JXtE9FzMqKg/k/ooclxW9VrtIzlDyiClpPAxQ6w71FpBP+a4qfWxik7qw/2wmjhAZy4sOel2URfUSuC2tXjbSTQoeAxJGf+Uu4kggHnOZKrqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168380; c=relaxed/simple;
	bh=BxADsb/b5Q1fz2UNQLoUIyA/oAJx4KLk6f4ln60scX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i1VKZi+uxeHlYhQ5xIfeO17aEH6PsrPT3C2peqP9u5ZHzGkCGQFoucu4KAvrbrEu0JtmiTlxJxxymAW6bJCyTR4MAn9o1aKmlHtLiZLJw7e8O1J8scG63iLqxNO8a2I6BS6I2hJzEEw5oC44w75rzLvXJUkmgXtVMGWmkG3B/tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KO5NIPHF; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PlCemVV4; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LWx4UPJ/ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KO5NIPHF";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PlCemVV4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LWx4UPJ/"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BMiaBT4047646;
	Fri, 11 Sep 2026 16:12:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=BxADsb/b5Q1fz2UNQLoUIyA/oAJx4KLk6f4ln60scX4=; b=
	KO5NIPHFukmfVniyyxjlWfxRfQi/CjDkI87dvm4tWLVFR8U5+Ctozoh88Vgm2kHQ
	jTTc1xR/SWOwaGHPfDIpiPOG7iyxyBmKi5LxZx3+3AbBrKk4L9maAoZ33cas4APE
	CLuhP2ILOERPl6mbuWQHnP+ZIiO3EmAFqIh6Skpjqyt4jvbSykCWd10SbkeYZRUL
	AdWqq25j443+6vYqWOQH/uflE0Y8jc3s47914SDotVzRnNv2h10nvwKsCS4/Lo3b
	kEkHZIZJgmGzljmfiYbPvRv1QkzBjvkHqDypft7kS8mtdIHbHUKrZ/TLfP+HXarQ
	cnpmx4Gbc9ZcPluQHczbLw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4gmqu0h7qy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1789168375; bh=BxADsb/b5Q1fz2UNQLoUIyA/oAJx4KLk6f4ln60scX4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=PlCemVV4WMVAj5h1feIDNJyNMfub7B0+RmHz1HOzMUlrEJiuEkZbhNF6Glu5JX+II
	 QCg+tP9IH7Ps5xU8s3afYio6wvnXfmgAmDU/n50kSfeabcoKEN7PX8cdGjiw3Ym0AM
	 6IltPhqai7yqvr0bioTkj8g13GC26pdpSbwtRyyGVpD2f8ihfRAVyA35RS3vHDYHLy
	 /ZOUQMAYH7wTANmINjIQvZcPXZ3TOju4IOeyqC/UISD/eO4PP6EERabpe4cNL420jg
	 3Z168glqzQjh0o5L2z+VJ7XE/dVsfH82OPnadUj11E4SoLy8fwvRckN+CpOGScHI9M
	 HqQmZg5JFfVrg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2D403401F6;
	Fri, 11 Sep 2026 23:12:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 0F89BA0070;
	Fri, 11 Sep 2026 23:12:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=LWx4UPJ/;
	dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com (mail-dm5pr08cu00405.outbound.protection.outlook.com [40.93.13.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 452C840544;
	Fri, 11 Sep 2026 23:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0cpjtyGl0q5vIVwHKP7u+OxR2rR3LSMdOCwuIvZO2SJAhcBzxgUyMRZ8vy1lMocrwbVEcW7kjzcW6STjUOkOApK9M9cnM0G53szxi0TWyfCQsAx/UmkRUUZUfs8D/JJ9o7gW5SYhQmakcDX3VIb+7o3nT3yXDHRkUnuS8yT8MOJDqEMm8tAdCs/3go4417b/vUzIqpFyXRNsgrcWQkEPYdixqgH0hiEGj1EMFxaFY2JemftbMon9/RgvNWGvjPfsyZulogxW6fx9IqprQdUa5maGYY2swqD1uGOEEfC23n+MC5L/0lq9LJFr9IHtbg0RR/GzbPnctlh7yQCWPMpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxADsb/b5Q1fz2UNQLoUIyA/oAJx4KLk6f4ln60scX4=;
 b=fwAuART1uJG/+StFDPXxb0so7nJzdAACYNRKtcErBexmXIcHbmUVb64Y7lPCFcuX3DTTBmcKyiqBU0Gb1hbibKZxQrxFM0RnlRcRFtqQx8ffFaYe/Vg3iaKFxrzlmEaRbOhZAzvMXd8KAhJiEIXeLCKyUXIxul6SOlKWthNJaysnWybHHRGep47DIsHAIoQx06fYVJtPC/aWBA/EvKKMGMa595Drbz/UVLpduPpsuYHuJqnoVwCLXoqvh5FVuuG4ha6yeCbYpUaJX3zfne8HRBmWVL5Et+qBsJlGyKxh4U+6Vhcd3UwV3o7V5FCR9wDwBjVMiGb3+51Eg74LQiNLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxADsb/b5Q1fz2UNQLoUIyA/oAJx4KLk6f4ln60scX4=;
 b=LWx4UPJ/uhqRr65IMV/SIpUJUnWC4ztmFLijf0AFkEJKb6InSc+ISDfoNjtjCf+hpYr8HvWyKSN7tU7JCpeOxJyomQOJOsGcn8XL9sVI8ZwxjhOk6dNCiNG0CKyd0dQBlocy2OhWlVw+/YRHvIkT9F3kibJP/M9EL8fiOBFtnC4=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 23:12:42 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 23:12:42 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: David Collin <davidcollin899@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] usb: dwc3: host: fix props[] overflow when all
 quirks are enabled
Thread-Topic: [PATCH v2 2/2] usb: dwc3: host: fix props[] overflow when all
 quirks are enabled
Thread-Index: AQHdPVXxUhT2xKpXmEqg1Z3TbX+6UrbKC2qA
Date: Fri, 11 Sep 2026 23:12:42 +0000
Message-ID: <aqSK2FNxv-jfDmd0@vbox>
References: <aptV-QHKGbMqw1uP@vbox>
 <20260905164448.209348-1-davidcollin899@gmail.com>
 <20260905164448.209348-2-davidcollin899@gmail.com>
In-Reply-To: <20260905164448.209348-2-davidcollin899@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|IA0PR12MB8905:EE_
x-ms-office365-filtering-correlation-id: cb5bd514-111c-4e56-d700-08df105a2e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|11063799006|5023799004|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 qeZtdKyU6v3kgMCEW4qFWr0ZqQs/y+lJI4xM0tOk1rDXe+J+oXLc2GN4IVTq+ohOsfV5jyBSjSWu7FeTHMaHSyoMqqUqe0E3u+ahxdz8CHypxMukgettTqnbz4azjLBbisv7MMieafaM3to6DCQTLoxg03zES1BkcjdQSQjmfnNaS5jP3ws8l1qtcs4GngdySXLVSDHWi0KsWMK6MpsOt6RBtiNZVQ7vVz+8uBQMWCUArsMCh6DZTb0tsj1qCF51EWtjSzpOFVoA3+XOoEDAckUMhra62xmdmbx7dkwNs5qSuEsu6bGjyCYHqmj5lJ6b90fCz/RzSOr5ooejfOr7KnKGC220Ck6gvODL5DDZFMEgMerYalh2vWcBVk8SI0xr0uNI6zlB9i7wiZ2IsKq0oNEhcx8a9H2TnB7WpyQr92ntdInX9Y2rXctpX4ynzX4OlYP+62pgBr5NyHWi2v+p0dK0o4BGUJeFdXKxAQOlwnRA6JGdPpa8175AFqvmlw1jtHmz6DXZsZTlB+T24qprQF/i/GMWjhM19bUmqEVJFNUSwdtxRXnk9s+yEtMHGWTTO4nAGw74IkIM640DsjhVhNp4+1hkqkZh99bkBBQ4ssGB7XNwT3Q+4pL1CNVC4MoZV8C4WC8xQLKYUHi+B6mzLhppF+ZGF69s6ASWVFXhec7R9ehI37W2orFnT6N5pqSGxJs9ozHLt59Z2nlQv2Mp9IEEKyXiqX5fksinw4sE4bs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzdZb01tVWNXZkNiUmR4UFdnd01jYXJBRk5DamhMcWlEbXhvRmpEWlJzM05n?=
 =?utf-8?B?VkFQcW4wYlVZalY2NWM1WTVrSUI4Z1hvNGwyb25TemFhUDJMQmdZL2E3ZVZF?=
 =?utf-8?B?NHNDVzV3andZTUl3ek1QWXVEMXZqU0xiVHZONzZvbTRUa1JVMlIveDZkNFpn?=
 =?utf-8?B?T0J2Rk9EaUNMaG12Q1loL1pEM0JpbzJMSWpkWE9HZ2kyYlM1RXlTaGxOdmNT?=
 =?utf-8?B?ZEEzSlhYbWo3Q1N4YURtdWg1MUoyY2UzN29zTENFc2pDd016NkpnbDNZM01N?=
 =?utf-8?B?WFlLclI5bDRxSGtmeDdqL1AzUi90elhGTXg5L1M4aC9tK1ZBV0hBTG9CakZS?=
 =?utf-8?B?Uk9TaUdUOVR0eXBFTDRZU1RsVUF3ZnVjeXFpRXp4Y2d0bzl1SDJuVUgybGly?=
 =?utf-8?B?NDFlUDJnblZ4WWFKZnM5dStkenZ6eGQwd01xT005RFBBbFZ6OEhtbzdPTlZW?=
 =?utf-8?B?aEp2Zjh0dm5QUHIzS1VEWTRsb28wcUNXRjFPVm9FdG1qOXhDZytVdTBOd2JG?=
 =?utf-8?B?MlJKcWlpb2gzSjErWnVBbDRPVkEwV0xIQWxINUQwOTBHelJ2dHZ3MHhyRWtt?=
 =?utf-8?B?RFh4VENXeHJLSVZLc01zcHVkZDdHQWpvTDlxVXVYZDRya2xISCtmRFBVcGEr?=
 =?utf-8?B?T0pMZG80R2lHNmxhWlRSZzV3M3FIb2FvYnp5UGE5R2xqcFh4ZmJhVVg2dnBL?=
 =?utf-8?B?S2U4QjhNL0lWT2hHV3k3bVhoOC82RmxIYkdOQkpaa0U1eDZTSGRPZThoOVdr?=
 =?utf-8?B?VmtSZElDakxoRkFtZHg5UUhQbEEzaWZFNitsMHRiM2ZzNlN5UGttLzhQYXRn?=
 =?utf-8?B?Ynp3QUNCYXFlR0tmbS9wWWo5aU8rZzRwRWtxZkc1dTR3RURnT2p4MFQ4Wktr?=
 =?utf-8?B?VHhrZlhDZHJ6N0RKRmhod2JkQjNQaFIrczFkZzdmMG8rdXp6Y0treUcxemh0?=
 =?utf-8?B?NE5XTXFVYjd6cG90OXN1QjIwdisydGlKV3BzZ0FDQWJVTUwvemtBMGxEckdn?=
 =?utf-8?B?bFFoazgxcGFaUDZhYVprTVVISXFEbFBkNHRpZTdlWmJkaGwvYlJoU1hpRHdm?=
 =?utf-8?B?SXVWdDFmQ3ppbkMwcmFsT3N0OUJIV25xdzd0U0VSWDN4YmpIU0VkajMvRFo4?=
 =?utf-8?B?VzdFSnBPUG1BM3UxajM4Vno2SEwzK29FeHk5THl0Z2RnRUJ5bkR5NXJrS3pl?=
 =?utf-8?B?SE5DVWtOK0JqcnVLZmVhaGNPY0xVSEVXSEI1S2hUNkxNdDlqRTRGZERzN0J5?=
 =?utf-8?B?c1hIUmRKcmFFeUIwRGFKMzFkVHV2TkVMblJtamJtc3NxTkxNcENYNS9CUEVy?=
 =?utf-8?B?aXdJWGZWL1VUMVNQdVpSY0xOY0F3VU5DQm5aSjBQQW5vM1k4T0dHQ201dURu?=
 =?utf-8?B?TlFTNmFVdjNFV2lrVmNNc2c4Qm9rR1Y5V2hNWE9SV0lVTVE1ZGc1K3o0djJm?=
 =?utf-8?B?SmVNc1hwem9DUXNPeG1DcFNTeVJnbUR6eFhvQkp4cVhINHdCL3A5L0Fvdy9p?=
 =?utf-8?B?U1hnWGkzUHBWbkVhSzNQU0VVZ1FVVnUxaFI5VC9abVBPb1lQbW14bENwaVRU?=
 =?utf-8?B?V0lzU2x3cmRaOHdFRnc5TjNmQ0NHZnpMTmVWUlRBbUdmYWMzSDhON24rb3ZY?=
 =?utf-8?B?bXJCZ25sVTB4T3V4RUJWVzhCVmE5UEpZY3c0Z3FnUVVlUldzcXJmNElLYmhz?=
 =?utf-8?B?bitNa0Z6bUREakYvbUp3bGVnZkkxSGpGTXhpeTdSV3EraGx4ZzZqZldsZjhp?=
 =?utf-8?B?Wk9Hb1ZncTYxZlgvMXpHMEsxdmNDWTVWR1RjVDlCRW55eThIT3AvbDBzTGpx?=
 =?utf-8?B?ZXZ5bU9Ib2UxWS9IYjNlNHVMbGVHaWJNeDhYWVpnTURwT1JBQTZPeWs4c3B4?=
 =?utf-8?B?ZW9WTVJ1TVdwSFdxelkrWmdrS0VrR3YwQU1qUHFVbXR5aUpGZFpnVCsxeThN?=
 =?utf-8?B?QWp4YkV2eUxJYXpvYWFLS211aVFndEoxaWlJSXJHR2JDdVp5aUJKMTh6Qi9i?=
 =?utf-8?B?OVk0U3htU0hvbFdhYUs2RnhFdGh5V3NQRUk5a3pJZlpPcjEwd1Nlejh2Zi9a?=
 =?utf-8?B?QWFYcUp3MkMxUWg1TXBSOCtqRnJ3T2p1VkFxb1lGSk1HV2VGeFNEcFpZUmow?=
 =?utf-8?B?MFFaNUx1YW54MmFER3d4QTRPdXBQZGwvRUY5N0NSM1VrZVdrUmRZY0RGU2xQ?=
 =?utf-8?B?ZFkvSDFqWHhSck5FbDYraEtWN1BZelNjSjBaSEFSeFlEMGxXaVFxOC9xb0dl?=
 =?utf-8?B?TEpqd1BUdEcrQXhvVkthTWUweTdUVjFPTjZuekdtNWFuSDU4dXgzV2Fya0dE?=
 =?utf-8?B?NlcrTXh0WmRYU2NiMVNqYjcrTDRiUWZ1aFBaY1FtZ05wcjJ2V082UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D164D8592679A478489BCEE7261E923@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HUCJO6FtJsF6xiusSclWpOHYgLePyGNO+iTNcshqrTMOPBDExlJNwZiOlxPB71547hjdGtWAMStKGKidOM/OIKjhupLRe62ID+kdJ6Yjq0bd2loo3VaL519Kn2pdUqE0E03Tny5sUBn8yP2fZLn+uoSWtMUQi9RRLDmFHbRQ8ou9difH6G0jxnwx7R+rTzUApX6C703x8R6tXHfG2KCqLamBlqdLPeuClFbXVlIoFdcCuVfgBrUkNhEokrxXo7gWjl+HM7kQKnlB+BTJl0CZNdecArl2TWxbfKi7jbXf5X/ENsNLGZuRf8FLsbqiQQr4GqtzqM7985M/sAjFPlCHfw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fDf933ch04EIto8ZcyvkO5S6+bnt1IspzeaiPclTmhg9fveWx4t4iqKoioarvYW85D/ReepmXuHQ+1N+AH9BDf2ABmSwvtifKmdRqYEoId7HR1IR/V0MVejrhUir3eiOQgXpmNJ183/4pMM7UvJ+yDfmtJ7FTr++NkrH4obfhsxU5N/0slDx7rr4YLo+zCxAqHzA9iWWnmtgmxWmXD2K/6hyx+ZJ9Y/gb6sD7twywRkPfPAuOzMQHK7TEytBLXkPyODwr3txK6WyPj8me0NLTeMdfrMfN5xDnBrhBG0aKQOObpi3TM1Kn85aqk82BejDzm5LmErvBdvuo7+Hy4gcNhB5XeNESpU2w/4VSg0j2fh949T/as+v/X1VqNNkbB1J0V7ngW+ppcV9T/zlrbgvjnKcGA8V5wBCTiuchx4d0wrUlAoKYcq7HfSQl7gb8PTy85XQsCsDAxbI05W4tmIW2tkQ8BEnrbSE5vz0eXvS7q+HwI1jezvvTSHIOulXbuEo0H24S5TReOwNQDF7iNIJVwtlv7pZGJ0arTHFd4nLC0yDLNcR4Peb2LwgmlNjQfb4AUTSXIB5qTNP4gJq/DY/85PwHljw3+TnMKQvWp5kqNPvFqOXvggxnyUuQn+BAGznzFP8C0uJsjzR+VGkFvth3A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5bd514-111c-4e56-d700-08df105a2e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 23:12:42.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7ZUdw1LI1OTxcjX3B2clwiQ/VZAMRId7jQzy9y4aSLs8bUjzpvXqpItg0WnqcDYKzEBmGtQboD1Q32YYrm2bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
X-Authority-Analysis: v=2.4 cv=CYudd7rl c=1 sm=1 tr=0 ts=6aa48af8 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=jIQo8A4GAAAA:8 a=Y8MoTruSFgbcX95Ib3UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDMyOSBTYWx0ZWRfX5+WDfni/66O1
 8LUiI1AJAVVJGQgXE5YMdH/VW6ZUV9aWTEXLO0BqIvClDoSzCN0DmGfy/MD4D7W8/a8SWFbjacV
 E2+scFwKr4XA1sO+Ona3xHZ4lOJaZhY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDMyOSBTYWx0ZWRfX/3GFNyMufXGO
 xEBWQqbnFQ1C5B3NGHw4rGkUTS8XibTi6IpJmx8ViuwhiCKb0+sRQPULTfXu3DuD5xVXrBwilYM
 gEbWzhgvqslTwE7EfkAxAGPhOe12npoNlnlNVvxeIykFUoZ01CCZt7pI1siFLpOtLzR+RCANHKh
 KM+qGxHAdnynA3KrpQx0rXfZNnIcmBaa9Bk0W1wuCzJhB82hZvduLruMpVc5EqEzdavmPeYs1o9
 92hA2J4XCTN/JGJXw7Q7tH57nGRbWiz+kEKWgiRqkSMpz42NQ1qbFb61p4kQtkdLYONNR04iIvb
 WUI8hCHkRSAhjyx7uChOMObaCZNDy594sAsDFs+u3TUYO+QEpDJj0P+bFYmpoaw2boQrF1r9hZ2
 9ZPv5fsap/nsHFcOEyN0zN1d/NVnYRLQ8nGVsuG7/rihXUG9NW0FtJC8HWAf5MjNefTTt3DwuaW
 id0bNLChPSp3WX8CWCA==
X-Proofpoint-GUID: xBX4CwFfv6XxTuDaUlDo1gWF0uIVbiXP
X-Proofpoint-ORIG-GUID: xBX4CwFfv6XxTuDaUlDo1gWF0uIVbiXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609110329

T24gU2F0LCBTZXAgMDUsIDIwMjYsIERhdmlkIENvbGxpbiB3cm90ZToNCj4gcHJvcHNbXSBpcyBz
aXplZCBmb3IgZXhhY3RseSB0aGUgbnVtYmVyIG9mIHByb3BlcnRpZXMNCj4gZHdjM19ob3N0X2lu
aXQoKSBjYW4gcG9wdWxhdGUsIGxlYXZpbmcgbm8gc2xvdCBmb3IgdGhlIE5VTEwNCj4gdGVybWlu
YXRvciBwcm9wZXJ0eV9lbnRyaWVzX2R1cCgpIHJlcXVpcmVzIHdoZW4gdXNiM19scG1fY2FwYWJs
ZSwNCj4gdXNiMl9scG1fZGlzYWJsZSwgYW5kIHRoZSA8PTMuMDBhIFBFRCBxdWlyayBhcmUgYWxs
IHRydWUuIFNpemUNCj4gcHJvcHNbXSBmb3Igb25lIG1vcmUgc2xvdC4NCj4gDQo+IEZpeGVzOiA4
ZGE3NjQ0NDkzYjQgKCJ1c2I6IGR3YzM6IFNwZWNpZnkgbWF4aW11bSBudW1iZXIgb2YgWEhDSSBp
bnRlcnJ1cHRlcnMiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2Zm
LWJ5OiBEYXZpZCBDb2xsaW4gPGRhdmlkY29sbGluODk5QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL3VzYi9kd2MzL2hvc3QuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3
YzMvaG9zdC5jIGIvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4gaW5kZXggNzQxMTdjYmIyZjQy
Li5jZDFlNTIwNGFjM2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jDQo+
ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jDQo+IEBAIC0xMzAsNyArMTMwLDcgQEAgc3Rh
dGljIGludCBkd2MzX2hvc3RfZ2V0X2lycShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICBpbnQg
ZHdjM19ob3N0X2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gLQlzdHJ1Y3QgcHJvcGVy
dHlfZW50cnkJcHJvcHNbNl07DQo+ICsJc3RydWN0IHByb3BlcnR5X2VudHJ5CXByb3BzWzddOw0K
PiAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UJKnhoY2k7DQo+ICAJaW50CQkJcmV0LCBpcnE7DQo+
ICAJaW50CQkJcHJvcF9pZHggPSAwOw0KPiAtLSANCj4gMi41NS4wDQo+IA0KDQpBY2tlZC1ieTog
VGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGlu
aA==
