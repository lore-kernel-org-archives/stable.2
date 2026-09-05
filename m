Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E077175A84;
	Sat,  5 Sep 2026 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788568674; cv=fail; b=u734l28L5SeRFT25gWPzASDL9XWQ10IsdVI3U+mJBh/nSrG6oCsIcNGNBxPHVmdM5PCLOli3S9kuesS7hmtOV2LlvZPm9qejoeswDElR/SkA1n5S4P83JC/95I8qQmQyaPk9wZpG6gCU2SKD+NP9yuhUr6lQ+JScK7Dg7uNMBDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788568674; c=relaxed/simple;
	bh=qEo1CpmStD0L/7tD4Kwv9aUYh11Du1IxGdy+W1Hri68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AuVIXIJA0W6OwKcHR5ZHKpPzdrQQhER5rd+fws8QBY2FcqdyID0Dsikb013EYM9tcJ66b+GDxyo20SQ5hTtsTjx9zzUZgkOsUBBcyBE0D05+VYtGAbHSL24YMbXYU/sZoJulztDBCrKyPQGpWTctInIEt3TG/z44ri9R475EWyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=q3lhUsuB; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Lu03j4aU; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BJwk43eO reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="q3lhUsuB";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Lu03j4aU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BJwk43eO"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Kclv21143295;
	Fri, 4 Sep 2026 17:37:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=qEo1CpmStD0L/7tD4Kwv9aUYh11Du1IxGdy+W1Hri68=; b=
	q3lhUsuBEuf+x+KZgex4yl3UdU3Gj+icQQT7LL8bKdXWC3l9yMEVGRfYglVqfNOE
	QAapLPYV1NFDu/Z+zVLTGNUx4p0JrYmPaFlCEhSddHN1kLDyHaZOvqdLd/vo6BLm
	yuYfezeD13/tysAtBYFbfFFXCPqzV+GpEB+SnJqu4XegmO2dIRhqnHtABMIepLW+
	1ZTMSIAoD5Ao6HVXXmq9G1UhZZ0TTVkcSXfa8FbqqsWWi4Qedu9FoR1d/IfLp71u
	WnGQRxkZVI9QzzYaNbyXGZY730zxGh38oq9QEw/xtSjqMcd4XnjRzBU0TDNq09co
	bxodGyZq6dTAC58ViAbSRg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4gfrm1b517-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 17:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1788568664; bh=qEo1CpmStD0L/7tD4Kwv9aUYh11Du1IxGdy+W1Hri68=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Lu03j4aU+QpoiHRkY6J4kh8C4a1i2L5Fjl51rjWHGnI/4GwXS4AuKfgRsCuApDzx4
	 8136IRNf3K1ZMqNXsNjXDOxpqN8r25kOVaAiGWTKmcQ09R7KEca/uwqXGf9ilIzF60
	 RDzrMEpr5MMvsLRXPt5EVmTit7q+UFOhOaVwchCqSlO2fzb0MUf5YXmyzX+ZzVT3hS
	 jkLXl0lrNSHgWUAFqAsRBH4Bvv87Wk1pVUE2zkbRTlJ/026b54L7zBgRqmQxhwWo5q
	 A9mtDADuf3y++hVsWzx82bkUTnWIwAzM4MBEG0ZiFuVAT3meY0+Pv+AeiDtEGv/u2y
	 i/2gOTTBVifYA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 67D8A4014A;
	Sat,  5 Sep 2026 00:37:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 438F0A0EC0;
	Sat,  5 Sep 2026 00:37:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BJwk43eO;
	dkim-atps=neutral
Received: from CO1PR07CU001.outbound.protection.outlook.com (mail-co1pr07cu00102.outbound.protection.outlook.com [40.93.10.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id EE50B2201FC;
	Sat,  5 Sep 2026 00:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhTrtYjF4SrHD37MzA2j7dURgcpVS4Jn/tGluDMgw+fhPEyIF7/xOGMl/+ypjUzhNbz82C22IYq8IhzEZjRK+849xF2a8gUF6C39qrNj/kjEmmJ++rgEIznlekZiH/McXJyEZ1o+8Nx4EXaOVY6l/V2y2ODplMUuDbM+aDYgLePki1w0KIe35G+1XyDjRrMsetSXrSGfh1rLh31YWzL7eZBQRZvTIP1AJjq0+t31B1rdVUGiGDbrISa9Wdo9/PGd6XYU7oBwbs/ABfGFEM6R4p/XSckyFFeZxekcwrtvFCImaIy2IXLT8STOtd+5QJZTftTkkcEQio/gjsT6FtWcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEo1CpmStD0L/7tD4Kwv9aUYh11Du1IxGdy+W1Hri68=;
 b=mFZdHcSPbKIHI5/wKFC+2uYAgZal/pr7hV0xvuD6Sajwgfd9yxdV6n0L12I3PEQrheMMEU4BqFBQ7dvkKX17FGBzQiqbh6lb21TAyM+yV2WDJKdqhHraNOrczmLr3+uFY2r160VXxApVpPlrb87Rg5ZmSs9n328ousakY69xMdHUlb4M9iE1Gs829czgnlp3XgYRdaExbb48w54jhBrK6z6C45E7rgfxVMsNngyY9PuqhxWdfnl/bhptTm71qV21EpfwUhJt+Yuy/qudabCVDOjwKobqRwy1m/jl/BhE8xvaZpcwfWLJ1oAyapqa/792QKxCKSmkqlymUe2ha1iLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEo1CpmStD0L/7tD4Kwv9aUYh11Du1IxGdy+W1Hri68=;
 b=BJwk43eOUL3ADIa84Qhci4bsVgDO0FzGqQNG9CwAP+Q22f70Ik/yB+2eak6iA++73g72Xj/7liVGiahzIleSGED5ugJxlfmsjxj/Tx+fEVMF6BDAKYIRWzBkx2eKAx3MXl1alLV8ofYKN0qWHeuRxpbek8M78AuRJ7bkv4OccSU=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 00:37:34 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0360.008; Sat, 5 Sep 2026
 00:37:34 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
CC: Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] USB: dwc2: shut down wakeup timer before freeing HCD
 state
Thread-Topic: [PATCH] USB: dwc2: shut down wakeup timer before freeing HCD
 state
Thread-Index: AQHdPDtvJoNzau5Kg02JJmpmpUznbba/JQUA
Date: Sat, 5 Sep 2026 00:37:34 +0000
Message-ID: <aptkQP7nu93Z761L@vbox>
References: <20260904065323.4047026-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260904065323.4047026-1-runyu.xiao@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DS0PR12MB7511:EE_
x-ms-office365-filtering-correlation-id: 3d948748-552f-49b6-aa5b-08df0ae5e0ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|11063799006|10067099003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 E/naZBGUuNt5oxK9A0jAryvCI1lSfHhYxpWIzpqQdnv1KEvtXWr3VmUnyw3J6w8KT2DWqza4N/qNIloBCx2q0kjOh+nyC7gk2LoE8T8YDTf/EFDK2mpC5da9PFChA+2dcm+ciLvYl9eknek+oyiYsce0rqhq+xRj7fmlJQIF7JGs21dNfiZwF9tozDyJGUXnHk8eB083HBaPSU1qVpJpaKlaBfAFIgFsxDvnmckBMQ61jhHp3row8ng4rSx0hCPNPilwRhIPEPNwEbC0VgQZGVCQ1mSoKfPoCD0VnHhieowqlmYbICiVV/SyT3SrHlUdFcFH1cGJONIOnXLffYXE/M6wu5WST1U6dTXqrO6IUBR9O4t7Ok3t+7bcBaWaKa+aH48oV+B7/am++natCJUkHMzkVSrPJp0MH4/3UesowQnWToMdfwSTpHxhar2FouzGkV/WQZk61q1ST8YtBM4eg6o9jBta5xdR3TAcdJwqqB2w04aUI4j0ciGj9kqJ4lGZXhbSUa6pBsTjt6jLNl1kNE+IozFj7iY3fKNWYTerKqzY5UD6NRMZ7oiok/gppTsFSEm1NJdZcUlFUpLy4YTgt8SieKwnivzJybGAwFgPYW6dGX0rhCidSK5w59TyPc/3fVweEsxUCHetrhXVhixhlA7UQUDobLa7gnxMOHXbz+zqSpWfjoc7VqVe+YedbNxsmzUYqETC0vaoobOElgYSs/Mdz6eqYmVeRV1LccndlpY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnlGQ3ZUVG5IbWVyaGljaU8ySUFnbEJMdGVSeTBkU0VTbTNPY2dac3pFSnkr?=
 =?utf-8?B?Q3JJNmJyeVBoMkVwTThCZGMwWTd6S0xSSTRzaUJDMUYrM0dhWUMvdDJZVTV6?=
 =?utf-8?B?SFprNWdKREQ5ZGp0NE1ZZHZhOE42cWZBd2Y5U2xoWk9hZmkyUGwrOExicjB0?=
 =?utf-8?B?M3lhdG5IR0tjTW9IYTZoOXlVcDRUOHpNOGlndzI0Vy9rSk1haW1aNit3VWNq?=
 =?utf-8?B?anhWYnE5bjA1OXdaMmROUzNSUkxONW44dGJIRWhYckNYWVJ5cEo5NVh3THF0?=
 =?utf-8?B?OHVudXhVMHB4Y04yM3dpMzB3Ukp6bE5US1ZjMitVL25TMUxqdjZUN3ZMUE9B?=
 =?utf-8?B?YTVBNEQvRmMvSFM5VGMvd0JZb2s2NDRBKy8wVmJHNXJFcGpDamI2QUtxelM5?=
 =?utf-8?B?ZFAzeERQTEJ3ZHRmNG50STVnWlNHQWJDRnNDbGtYajZKdGc3ZGdJOWg2eVpR?=
 =?utf-8?B?dVczWHdpT0JnejNONlZ2OWd4TGpNMU9sNFJTYnBkQ251YzE0dDB3WS9NQ3Nh?=
 =?utf-8?B?RlRnN3lXMGlqbThOQld0ck90T0JjTHFZNjBZNEtYa1N5bC8yMUVtSHJ5N3lQ?=
 =?utf-8?B?cmpNZHR3NkNrNThybkM1akl5eis4a1hPU1IzeXBTV0FoaGF3Q0M1M1dzckdL?=
 =?utf-8?B?T0w5K3JxQWNjak1nKzhqb0VUamhyS0RqVXltUjdsM2o5VTZNeHE1alN4QVow?=
 =?utf-8?B?WFFQRUlTVzIvMUlHSTNnYmVZSlVhUGQ4RVNJOGlEMXJPSGhKaGlXVysrajV0?=
 =?utf-8?B?NGlJVjJHN0tIbm9xRWxBcVd3MWV6aW42OFR5YjNlcStnTUY2R2VYMlZUTlhP?=
 =?utf-8?B?ZGZEeHZuTkxmS2V2aGJqeVhGOEo4VHRxODNzdEdFaXJhUGRDdkpPcWZwZUg1?=
 =?utf-8?B?aTd3UWVQcjVBaTU2WFpVRXRYMzBIL1BxTFBlNERJeTdhYWtiNEEvRmxWYWtp?=
 =?utf-8?B?YUhHYUdwaXlRVWNBaUxWNWhTTlQ5VlZ2OVdTaVpwNGF2YzViVXo2Vy9ldVVr?=
 =?utf-8?B?Z0txMXZuR2NSeDBqN0xjUXdkRlljVDdQVS9xZG9qL0N6SlJRNFF5cnplYkh2?=
 =?utf-8?B?dTI3NXV1V2JrRDZYK3ppaTlhZW5QTUNPZU1ObVU4SWVZYXdHbFZkdG9EZEhM?=
 =?utf-8?B?NlBQU3RlZ1VQOFFsVUw4UXExMS8zTkJ6d3diZnZaQ3NTNHhzUjB5R0NtQ3U4?=
 =?utf-8?B?Vjh4NkwrTzlBSnIyNWV0cDU0QWkrUmdXelg0bFBMS0VQNEZaSGQxU013U3J1?=
 =?utf-8?B?NmtxY0tDOFE1M1p1QktGM2VUTEtxZVNXa1JROFZOQmhrM2owWHZZbmdHYlZh?=
 =?utf-8?B?TklEd3E2WWU1Z3lIcktoUy9QRkEwTit2aU1LV1JTVEFBNjBuY09NWENtdFRk?=
 =?utf-8?B?U0YzMVFLcUIwTW44OUFFRVNIeTVsWXhxSHhib1RYRzlSRFVKT2haRGJqTzFH?=
 =?utf-8?B?UVB5eTg5ZlNKdXE3UFFwZGVFVEc2UmFtU01VeXk2cTF4dGpMMTgwb0ZQR0lM?=
 =?utf-8?B?SXhXU3FLUUxrVHBmYnZjVzdWT2hSc0dwTTMrNjBleDhuRVJkcW92ZzdVb2pk?=
 =?utf-8?B?b2M2am9CSjl1cDZZRk8wQ0dMWEFMRGRpeis0N0VNakhTSWhGQzVxT01vdWNS?=
 =?utf-8?B?TFFHYnVtblY1TUZlWlB3ZWd5ZlZTYzg5NGJRT3Y5THNYRXQ4VTQ4OHV6alRG?=
 =?utf-8?B?cTM5eTJld3c0Y1BBRWdIK1dUazEzMGpsbnZ4cEdEWUJWRWFyZllwTFNxK0ZM?=
 =?utf-8?B?NVE4QVdkQVRzRGhPTlZUcnVaSmx6NzBSUlcrRGRPUWVEVHFYbVoyRGlqUmc2?=
 =?utf-8?B?dnk2ck5nUEpHeUQrVVZVNmVMTUJXUEZha3FLZTBZRFJIbE81bEszWUhjUmFw?=
 =?utf-8?B?WU54RXRpR1ljZzVjUW5UZXRGUWRCMXBSaDRTbi8xbzQ1K0NIWThUbldrNnRa?=
 =?utf-8?B?OTJvTkVISFdhZzQxNWJzQVA3S2dTbFZKSm0zSXdFZ1lQei9rb1RIYjdHOXNH?=
 =?utf-8?B?R0VQRkxhVVZpV0JWbU8vREVjTURvbDJ3enMycjl4b2dPcWZhOG5TMXN0WFdt?=
 =?utf-8?B?VlMyRFdLUTZObFFvNGY1R0RXNjZ2OGVkZUpMZ2VYWi9nQ1IxN0M4dEp0MWFy?=
 =?utf-8?B?V21KNkRTR1FTZndQSWdKSEp6eDZUdmZjOG1pWlZLdks5ZWdkejZ2UlRFTG11?=
 =?utf-8?B?RFEyQjh2czl1bmpoMGQyb01zWTlrN2kyaFNVdFQ3aVZWWGF3aldza3RpZ0Zn?=
 =?utf-8?B?VW91SFBWaTNZbkV4SVliUzhkMHNXdEE3bGNReDg0L3RWM1M0TlJLQWtVckdX?=
 =?utf-8?B?MldUcTZpUTdiZWNJeHVscjNXdmQ2ckFHUWMzYStxR2FodVcvTHhuUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E442B5350C73574FBAA0B842D7B60A2F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WvHLcQwAo0CqX0mkjlLl32c8M4wlzdkpMBU1dKd4C2nvwq505SuU7C4MNZF6DrAs8WarX9N45i2S07g8IGi/mcKjHQ4aW38zXXyke5Yfgvvah7fZmQQzSxwDR0XhYwhcVfW1AEJVFfRUxtvSkpRTDb30cfDhL+SwWB24QMFkkw2GJd2bQpHOFPpS7sCeVEQ8mUWwApkINsz7neYrxjlcl8EiHiif1HvCbPTfDEWPSp6weis4HbjOkpqNdggMqtaApxuqzZQ2rJyx25CEPNznW6Lua7vgFqY4u9ZDYwPExMH7gh4S2LaqNXaF3Rk6E0sQhlYQ+zOxZJ4AkcMK54Kr9w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oUayI0eMffDqaJJRrTYsISZ1Mox6FAGz3LlCoDlOWst/Wwvj/BWExM1Y1rKv+LFVd4rhu8FH6HrcZLoJHbZq4DD2Ts5KyHOic4N+Cw1DPp72B+yGQvZ5WatLiInyrXgpOo3XBSvxPfknXBcQgjDRAxzOBjnKpU4tSvAeRqvtsb+XvuF5x6Z7OC4NVh9S7mprmf5cs9pK3+bjWnvi6po7sJsRHvu1gG3U0BlDeNeVStZK0SSXvmCVGKG+i60tj9QLP9PtF1t3NU4lIywgJ4d04WU3NhqTnZu7LDzgtZtccKDpvm1rAkDbzZh315ElE/55Kk4aFoDLPOzzne8BiwyStbL0hrs25q1GYka+lsKbVw8gMvXC5MxsAQkFT7PJnXJP6q6eFVR3zNcMMVspjEBe3P08rOF3FIW5H8FqLmI93P7dNkvdvDnjSMlj81IJTxzEASD0ReqQIdIUJbNlPDBuQO0yrBrISr3G9W1/4gGKS2LdktkGZdvxVkaZH9vYm4sRXPdv9/1xAonhxOa/x9o3w+9YWLOeYD8twQ0hcl/tuAhmwBGIDT/DgdSeiHebJH+QqvcJZf3QOlDjgod8jCg0530mM/B/kDW/yKV2ZjOcoZgOeoVC7bv3Xvw84y2Hme1ZULOhbLHST5F0FYKPJoHRwg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d948748-552f-49b6-aa5b-08df0ae5e0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2026 00:37:34.7160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcusrb6K+7jdpw/yyXmCvv2y0f3n4OZuzHuMLR9IFYnXRY9ghbabEQQ5dmX+EpsGhTaEka2ZHuV54OqvhcDNJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
X-Proofpoint-ORIG-GUID: K7twoFprdZw34ReR53WUn0_5BlbbzY7E
X-Authority-Analysis: v=2.4 cv=L88theT8 c=1 sm=1 tr=0 ts=6a9b6459 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=r0VFGq5Cj2UrnoT8-HwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: K7twoFprdZw34ReR53WUn0_5BlbbzY7E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDAwMyBTYWx0ZWRfX8voQDIaCXfXi
 7ycRWS40uklQ3nkQWxQJrovwy/R80e828Wg3otNvo2NHxQRn5C6uZKayS2RGpfaH7Ah+pJAVLPj
 BfwKPlvXgVZ0x3cwMMrmoDSTSKR1JpA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDAwMyBTYWx0ZWRfX4WXn0mTDKMIE
 jgyqzPWtFIYMw5vdOYSzeseYlq6jlB4puKXm2tj7OH/7Vq71IEJW1myOOXa5QgX+Ndx+2xA2rbG
 Dgt6H8v/CcNehWCIn7or3Mgkw1iMs9ITffzo/ApySGUQEc/KvgzZo8ArMNbDM2Vp8XPCjbaglA5
 mT7vCJN7HgZD6SlBPTmraI1zAh3AAZzPWB6Ix587fP8nc7TvLPqquEO4kdXGQTZl+9TCFga1pX9
 qojWajxLSXYiuYCFrxp1dMtMUN3CKZPzK39iUEZHZv7FBHWJTX3McC1h+xhe3ajnz4/t/qxA5SX
 Wh5jpJXY12OKUkda1RcXOyaluH0g5FwCs9AQKt1oq4WuUIh1hJmlus/vZi9OfNWfIyntRasWdYm
 siWKb+VWaDE8WiQ7xa9l0/rTCZtqkACqaPClc0m9flMQI0I2h9BPYFa8AuzYxQEvBUOCG+rrX0a
 LWN4jSv7frEd5rn01gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609050003

T24gRnJpLCBTZXAgMDQsIDIwMjYsIFJ1bnl1IFhpYW8gd3JvdGU6DQo+IGR3YzJfd2FrZXVwX2Rl
dGVjdGVkKCkgYWNjZXNzZXMgdGhlIERXQzIgaG9zdCBzdGF0ZSBhbmQgY2FuIHJlYXJtIHRoZQ0K
PiB3YWtldXAgdGltZXIuICBkd2MyX2hjZF9mcmVlKCkgY3VycmVudGx5IGRlbGV0ZXMgdGhlIHRp
bWVyIG9ubHkgYWZ0ZXINCj4gZnJlZWluZyBob3N0LW93bmVkIHN0YXRlLCBhbmQgdGltZXJfZGVs
ZXRlKCkgZG9lcyBub3Qgc3luY2hyb25pemUgYQ0KPiBjYWxsYmFjayBvciBwcmV2ZW50IGl0IGZy
b20gYmVpbmcgcXVldWVkIGFnYWluLg0KPiANCj4gU3RvcCBhbmQgc2h1dCBkb3duIHRoZSB0aW1l
ciBpbiBkd2MyX2hjZF9yZWxlYXNlKCksIGJlZm9yZSB0aGUgSENEDQo+IHJlc291cmNlcyBhcmUg
ZnJlZWQuICBUaGlzIGNvdmVycyBib3RoIHRoZSBIQ0QgaW5pdGlhbGl6YXRpb24gZXJyb3IgcGF0
aA0KPiBhbmQgbm9ybWFsIEhDRCByZW1vdmFsLg0KPiANCj4gRml4ZXM6IDczNTlkNDgyZWI0ZCAo
InN0YWdpbmc6IEhDRCBmaWxlcyBmb3IgdGhlIERXQzIgZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcNCj4gQXNzaXN0ZWQtYnk6IENvZGV4OkdQVC01DQo+IFNpZ25lZC1vZmYt
Ynk6IFJ1bnl1IFhpYW8gPHJ1bnl1LnhpYW9Ac2V1LmVkdS5jbj4NCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBpbmRl
eCAyNDE0MjkxYWEuLmNkMGRjODc2YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9o
Y2QuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+IEBAIC01MDgyLDE0ICs1MDgy
LDEzIEBAIHN0YXRpYyB2b2lkIGR3YzJfaGNkX2ZyZWUoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3Rn
KQ0KPiAgCX0NCj4gIA0KPiAgCWNhbmNlbF93b3JrX3N5bmMoJmhzb3RnLT5waHlfcmVzZXRfd29y
ayk7DQo+IC0NCj4gLQl0aW1lcl9kZWxldGUoJmhzb3RnLT53a3BfdGltZXIpOw0KPiAgfQ0KPiAg
DQo+ICBzdGF0aWMgdm9pZCBkd2MyX2hjZF9yZWxlYXNlKHN0cnVjdCBkd2MyX2hzb3RnICpoc290
ZykNCj4gIHsNCj4gIAkvKiBUdXJuIG9mZiBhbGwgaG9zdC1zcGVjaWZpYyBpbnRlcnJ1cHRzICov
DQo+ICAJZHdjMl9kaXNhYmxlX2hvc3RfaW50ZXJydXB0cyhoc290Zyk7DQo+ICsJdGltZXJfc2h1
dGRvd25fc3luYygmaHNvdGctPndrcF90aW1lcik7DQo+ICANCj4gIAlkd2MyX2hjZF9mcmVlKGhz
b3RnKTsNCj4gIH0NCj4gLS0gDQo+IDIuMzQuMQ0KPiANCj4gDQoNClJldmlld2VkLWJ5OiBUaGlu
aCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNCkJSLA0KVGhpbmg=
