Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195512116F4;
	Sat,  5 Sep 2026 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567681; cv=fail; b=rWdC7w7Ae0CAreFIuvMwOdamHJxAtzKvEslaEUuZ3Mphrk1sFwI7XkB1l0uAGoCwPFXRM8eVFI8Qvxo7U/kPu/qGSFIIBebD0WiqjeorVUPlpKD9sVj0uIgJoGDteEkaQb8a/wIBsUqQdHVaHkpPrZ55bkKtpbd+zWDF+xpVA4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567681; c=relaxed/simple;
	bh=wrY4gAXR0NtYNNv/pRPxvoAdFu52xuJwqGcwMhKrIzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QA759OPuLFj9IA8UGmjuZh0FSnouyfebnM2dwDAJbIJ2V6JFUOs1v/sb5iT5T/ymjQCyCFmV2UVhE7XA3C6FASKCvEw7S5+jb0rydqW8BTL6nPE00/h4cba02ujmO2c/5m6M550o+CVOXLwJ0Bt3+wzsKeDnaUCEdoa6ZZcOHvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=l0lwzzi1; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=K5YCPOj2; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kdYGWiyw reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="l0lwzzi1";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K5YCPOj2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kdYGWiyw"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Kd0453795027;
	Fri, 4 Sep 2026 17:21:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=wrY4gAXR0NtYNNv/pRPxvoAdFu52xuJwqGcwMhKrIzM=; b=
	l0lwzzi1ZqKv+ei4ngxdzVR/kONg1C+ZO1RQjuKoMxdv5VKpYdLwrAoB55hW0EG1
	/bj9iE0yvvcO9mjQSJScirsAQzb9CzPc+A7UgF+FT/qywBXUIO45fhICOgfNFu5d
	R1MEF9sYkVybhYbo6r82jZBaeMUl0+q9/uc/qQhAYxVCZfrqF03PTrGGMBYoYExE
	ZnSMmHjfLfui6edw+TvX42QxVbYhA0lDlfmphBQ7sc2JU9HqmorR8enC0e8GB3uG
	UtoND9mPZ8h0MrbFFEUdEWfQfKPPntERrJWLGWRg26e17qLV8fxKj5TPpQTo4ZHG
	czXtF3vW9imAzTZP0dBUUQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4gg076c94s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 17:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1788567670; bh=wrY4gAXR0NtYNNv/pRPxvoAdFu52xuJwqGcwMhKrIzM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=K5YCPOj2mN69JwrgmRdw2UnXtSUlLGV3bIdoBPPdf6U2qZZ+NYSy1fUpTn6wYuD8d
	 jh8WY0PDY93k0wTiJjdawp3MOo7MNm98XIHE0P0cK2nKTKfBhWt7vHNdk8C8ySWdAI
	 Lc9kxqk47AqI1Gd0+zFGHiOwhmEmeQx7sNPBxj/EMLZFTrf8s1qOX8aIOZw9sC0aQQ
	 yv+gSX46kllnjHIk6vz7hrpHZi/elRjiIEPG9ur8I0D/I7SneSaMR3NNbrgcJaq+z6
	 V4EFjJvewXRJWI0jsNduEHoB9hPEpQzsbCuzuZ/IE8yFeLXWXqyqIMOaFhkvicWmin
	 youXwXun8FYdg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8299C401B7;
	Sat,  5 Sep 2026 00:21:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 346B2A007A;
	Sat,  5 Sep 2026 00:21:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kdYGWiyw;
	dkim-atps=neutral
Received: from CH4PR07CU001.outbound.protection.outlook.com (mail-ch4pr07cu00106.outbound.protection.outlook.com [40.93.20.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B12ED4011E;
	Sat,  5 Sep 2026 00:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2buv/PaXKi5EYzH9RCLwbGIgpRoAAKJILFy/LVq+ryEzBV82Nze+ngUPhMotP/cKrf56YMTCkpyZBIdrQPbZ+atiZdFKa6GR/IOOd6X3NaaGilRFoQesG+D5S3bgwWjgWGEuVdBsDEklVRpq2I7TT6G/vzGanPXS96Tn29y2YKeO6gKxKWxzj6WtXIiUaRmeMW5ukuCohNS7pax0GlL59HHuDIbvLV6h5ddUsKlByTAwsJVwC7S1ATODNbW+pbbNIx7XYmYwFgGcXMLejkk1Pm7fKX8dH7bhK3JTDs2Ixjm6pr+wfuhFtcJvaKgYcoOfiRh5p00P/MEAR1nTcTLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrY4gAXR0NtYNNv/pRPxvoAdFu52xuJwqGcwMhKrIzM=;
 b=ym9otv0sy128Gu+C1FYM+PZNUDFnpnGH7KNUWTsLNRW4Xk+V4gjJtIM0C+TU2oqJYblPyNPDtIPtJG9Zo5n9CWnuzc+IZANdaVGqK/d1SsNOX5LGfsWBw9HoUsm8ZbXgYGCvSGq3jmIdX16iKUIHprMqWahskeaPAXfVIvc/pYAZ/MeSYV2WUFrP7WJ/rhz50FYolgbjPrfWbBNLK6APvd2AeL+sfJyOyc12Hz93ow3OQolPOmD7zry9HbkAmQZW79dY3ApU0KXgZoXEyPBc2A5N/fmlqzQUlkV2vrz3LR+Wzjzro/+KWEKiD5X4xCMxKH1cA+fSzscqZMZz2j9gOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrY4gAXR0NtYNNv/pRPxvoAdFu52xuJwqGcwMhKrIzM=;
 b=kdYGWiywybzPudfZGhldQnPolalckyNFx8UP9/yPhT8IVrTaZlPdTZlAstKXUbDkdncMj5hEs/SBzYiKpCDzw+Igj1vlN83/3Qz0FVA/L1i5mpAyxym476GkUlfk5ejYfjbjpEpOphrW1uTeCYu1vFwAyvaZNVeSroEycWHBNC0=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 00:21:02 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0360.008; Sat, 5 Sep 2026
 00:21:02 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: am62: Fix runtime PM usage count leak on probe
 error path
Thread-Topic: [PATCH] usb: dwc3: am62: Fix runtime PM usage count leak on
 probe error path
Thread-Index: AQHdOur6hMHa7E9YNkK5Bxxu0RvTcra/IwaA
Date: Sat, 5 Sep 2026 00:21:02 +0000
Message-ID: <aptgYY7QUc79z4rC@vbox>
References: <20260902-dwc3-am62-rpm-fix-v1-1-7a2807e33307@amd.com>
In-Reply-To: <20260902-dwc3-am62-rpm-fix-v1-1-7a2807e33307@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|BL3PR12MB6378:EE_
x-ms-office365-filtering-correlation-id: 71953699-7283-44da-4fe4-08df0ae39153
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 TpplKPZzXn8w2Hzuu/efGvz0bS357h+PGJVlLwZ8ezSWespib+UcjW9PVaj4Y9EIpJHGA+/vxxGpRWw2ApAKHXKQsKE0IJp1xJ8Z5h0HWTsHL3Yw+/zpsNzNeZ1NKULzlLN2WYCQXPMQslwK9xs0FAXaYv7wBisZkXwFFTbfD6eHKW6k69uA+TJEbStG6scxLX8cmsR6huSM1hD72NUVXpuXOcDNcffuTWFgADL0ESpKrceaHsF8rF0qhPG64nFvSJxgTRoqmFAoH7Gra5S2eWNg6Z7WXIBt0MJGGt7U4UgTfzTeigkxPeIFTyLcvEZP50WHpMZSl59q6nAmPhqGRDTesrTVJNXiN6B3KqX/N3CwyMy07KUWcU7DNpjuSGkJa0n0NwTSP5fF7ZyC9lIEMz3te6dT8qWx5VjETLxoLfikZ7DYVn3au3ua8uxvu3iAYvPlOKbzpSVirDfX2qsr68IwX6JsqfldiP7MsKfN3IXQiNiuCTZ5iIa4j6tiXQxneROxJE2BO0gKuIOMq1X/1c9HBRln2xLgzCMLI1gvNgs5KuXtqQO1YKH6F2lnDKtuIALtJC/QMnTo2O1o0UwQ7TS4rv/x7D0+HpxR5MrD4QrSQ5lZseWdpja7s+BQrUOTefGZMoRVA5vr0XVseIHmkOxLDTiAqY1up5TVMefsCvXaVIvBZ4Xec5hxiQaaT44mZCnt3ms88nhM62HsZtnh5zlUAKnzHVC/jN1nrSI1X9o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEZIZXNrSmJjUk1Ldm9JTUNwWDZIcHdLTSs1Sm1CSkU4TkF5T3hPaFdCMHQv?=
 =?utf-8?B?bWdjNGI3TUo4MzJkeTRNMzcwdzFZU0pVSmc5OGpuNUlWdkJMVVBCNHN2eWRQ?=
 =?utf-8?B?VjhDejNkeDNaS25mQjQ0T2UwR2FMU1JUTk9ZSkJ4L0U5aXhZQjZPSEpvZ0VY?=
 =?utf-8?B?K0NVUDZ4OWNxNkZOZ1JUTjhieTF0K2FMQjI1MzBvTHVKSGd1cEt4SGVyWUww?=
 =?utf-8?B?Q1o5QUxTSWhrWnNvQzI1TlVlWTdaN3V3eThWTDVDczlJK2tKb3BhOWdpelJn?=
 =?utf-8?B?d3lOOWdVNElFR2o0YW42Vk0vWGpEY3oyYnVvVS9nMkNPeWFRNkswdnZXc1Ba?=
 =?utf-8?B?K1h5aEJBNjJpQWtONTBJK2hMYjR0c0FHRXdOZTc0NzNuRjZpMGlHc2RNdi8z?=
 =?utf-8?B?ekFaM2J6Q3ZucnhaT2Fub3FkajhiSXdLL2JjWW9zenZIWGlJTGE5Mks5MHdH?=
 =?utf-8?B?bUNkd1R4ODUvWXlDMkJEQW56cmtDQk5YTENOa1RwR0k2ZEV2K0NmcmVrZ0Yv?=
 =?utf-8?B?c2VxTmc4K2pOQ0g3OGk4RGlPeUJhZ3R2djBqbXpxajh0VVk5TE9nQnRjQXVK?=
 =?utf-8?B?aUJQSDdzczhtWE4vYU4zazc3ODVGRXlxckFWRG0yWks5Q0lOT25aQklhZjBU?=
 =?utf-8?B?bThwaGhYZFVqZ25LOGxqOFUwZjVWUmxCbHZvWUhVVHI3N2V3OFNEYjVMblNK?=
 =?utf-8?B?WlNVY0tudVh0VVh1T0twalVrbUJ3QXJ5aGZiYkVYUk1FQmJrcm9Ua2cwMXZ6?=
 =?utf-8?B?dUhaaTBZMXk0dGkvOHdZeWdkNnJ6c2JwSlAwUmJzb0xLZ3J3WUhzdU1USGt0?=
 =?utf-8?B?MmZDK0pUQzZoQ0VDTGVIbFhpRnBsenBKSy9yZ3YyUGptV2c5K3dZWDBDcyt2?=
 =?utf-8?B?b3JLTlg1enY3Qkg3MmEyNGdPeWVYQ3preDZSSDJENDNFL1hjVGNjUXp1b3Zn?=
 =?utf-8?B?STREbUJpUGllQmFsZ2J4Vjkra3A0eW5Ic2JtNG9GQlBnMFBHUUtBeFBzekVv?=
 =?utf-8?B?ajhOc0lhanUvdmlkSTk4ZTAvRG1TLzNPVEI3R1hiNHZ6cFFwd1BjeXQ0em9O?=
 =?utf-8?B?VXhMRG1nR0lydEtlYXdKNVg1dXduZktFQlVvR3dhczdacUh1dVpGSDFTQkVj?=
 =?utf-8?B?ZW1mQ056UjZwZEF2MHJHYTdMQ2JXV3BLd2l0dU5wby9nNmZvNTJ2MThlQjBO?=
 =?utf-8?B?WE5MRUxNL1FKM3RCU1FvS0lQNE9iU3FlZEFWSE1ZUll1dVJLVVF4YkRpMzRD?=
 =?utf-8?B?TzRIMEhyQkZIQXRyNitnbEt6WWg3cGFlR1VCYW0yMFZZbndqUzZzM2ZVZmxy?=
 =?utf-8?B?ZE1xclFPdC93SnRWSkZQaEwxdjZjd3FLZUpqanhuRlFXMnJ3ekhucnBzY3Nm?=
 =?utf-8?B?OUxLWnJRTjR3czhTeGZDaUxYbXJXelRjOU1BcXY4VGRjelVNeDZjWmR3blV0?=
 =?utf-8?B?bk4ya3hjaStMRnZyZ1o3MDlBVGU1Mk8raFBvTzRBNG9xVWluazdoMTZ1dkE4?=
 =?utf-8?B?dkRmbklIT2J1M1MvRFdacjA3d2gzaG5xKzNQcHh2YXFNcGlvNjZETFF6eVRI?=
 =?utf-8?B?c25WMVF3WmxsdEVjK0liZmQ3SXRoYTdmd0pIZ1NxVGN4a1kwQ2JFNUZLa0NL?=
 =?utf-8?B?UTk5dXBQd0g2dFNheCs1YUkwQmp6U2tJVllCcEtYbk1GdE9vREduMEh2NHdD?=
 =?utf-8?B?dCtKN2laY1p0eWprc0NaaXhaWnlUTTltUzN5bHF6Rm1KT1lzQzVqSU9qUnVx?=
 =?utf-8?B?T1BiaE9FR3NBaUQ1SzFPQjlheGtEMGRsdDdCT1YzMHR3WitsQ2lLZnNNNWVa?=
 =?utf-8?B?NG0vZEtyZjRWd1VsL1lOMTZGTk1BQkZlZHo0cHkxRWdZenFGZUprMTRTNHhr?=
 =?utf-8?B?TUt6dENSdWNrU0ZidVF4RVk4cDNRYnVtWmNleEJrQTRiNU1vek1aeEJ3VFY2?=
 =?utf-8?B?ZndrZkoyNlppWDNZaTV2akp5WGVEVnFVMVNRVkdxbXlFQ3YzMnNqM2c4ZGZU?=
 =?utf-8?B?YzZYaEhSaWt1R3BxRGk1RzkyamxGRXo5bFVQME1jK1ljM3JPcDA2ak92ZVJt?=
 =?utf-8?B?SUY4aXVDSlduWGZkbXcxT0tTQWdScXhGYlR6OWpJT3JuQkNWWEJkYWdBckVT?=
 =?utf-8?B?VWNCTDFIYmRGeVgyWVh1L3l4YUYrMUhlbmVUSHZrTDdGUnN2OUIzZktKS2Fa?=
 =?utf-8?B?MDlYM3cxREZ1M04rSnhzS3ZZaHhPdm9wWTBFcTdHT25LcCtQOUFvRHhzSElG?=
 =?utf-8?B?UUJBaHJab0VUUUVnbDl5MERsUFVrZHpvSDFyWHFWVjI5VCtiekpIWG5kVjRT?=
 =?utf-8?B?MEdkc0l3TXE3MmpNNytIRmdLNEVDL2k5UWNsWGg0L2lwM21lNEpTQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19BAB569CB297E4F95FA1E4E6F21FC5F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vRe89jMolEaZ0qk6qwzhb52cDRASNgIAEaYhbOuP8s6dV3TTeMgeOsV6Y8rV0QuKoIlZuM4QqXPPxNMQPhJrQTR2Vd9LhKtWUeW99m/EgKbVYLKw2pySvT7wKjODw9kiOx9SAcaou4RunoA4L1rNqUVUu77naP8oIxGjcocxGwUvsXtijVqofzTfRoJnagxCeVzyHw88vMebItIQDvkS7hnYd9c+wH4aZrkOjR67p/pIew4vWvVbzhmMqyYsQh9BW4yWc+JnxU5xr/TW1jD+l0geks58pkr4DZUkWbNo+k8hNqSXAi4A7H0BCUs2F3a/GHanGNWgWB6dKuV0dSl81Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1AD0ghym33IXNRVreLMiu0C/M9TtMEv5IAjIyxpo0/6eMNYzLToWpKEi1j3mZy24z1l6cWGRSdzPlr3M4RWLrBuHbqht1XEavc0wcpEwsBtUN6iqgMbIZ1zf7GcLZlUrtUjx/XubMHwXXItghxv5oaXANq/a+Z1kpUR1zz8WSRP9VAo7S2wpAJQUR3OB3/qdOwn+p9YtAVtvIJ+cXVWa0E0maxuxBm40E4Wa0okX1vXA4BBYcbwWuP6ekvfcEtAmyB5edPiDMfE5w3lgNW8OCsJdmIejDFpNTexumRISr9aYbtKvAPPoGHL/pieykBbuligxxebUuheCYSvRgcWL9SLbQASWlisaNZMFaVCdrEMoKn7kOaTCyF3bNzjk8YpK+27PEiKdRKHxRagof08EEZxYFbHKu9cDbOsnk7zPjzdrDnqD7YXhA+vKHfdYe+GM8nlIyXEQlPSjn99RYFVyeDISs1hqgdetq1Wg7VssX7UTrNBrF6MlXuq8L/mhlAqdE7GVVeZ83Sm164watYDBpg1fgVEVbl3unsXGmcRaa35VAJeXNHby/Uf7Qssp2NdpMZ01Hes5PQ2KJM1F71j+5jbdcag8VIOb/rgj+tV+TyEKEJf2A2lENDdDAHFdPY2TuqtUtH7KEZt5IsRnIbeOZg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71953699-7283-44da-4fe4-08df0ae39153
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2026 00:21:02.1497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdagoY2s6KVZV3mcyM7vLAOMPfVyofP+BryY7O7xLYSJj9wQWVa6foxJqo6kogMmtJlBlkZJaB//StTVYR2omw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
X-Authority-Analysis: v=2.4 cv=P+cKQCAu c=1 sm=1 tr=0 ts=6a9b6077 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=jIQo8A4GAAAA:8 a=J04EAW_zHTnR-zU34fwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDAwMSBTYWx0ZWRfX8x1qcdmBl4SC
 X2AltpVnDnTUS4ZT03U1jQCcpUkosGVjjR6qx+w0tWEeM4aW9kVhrik76F6yIACTT3WQ9f4spWo
 ME9bzHKUhP5+wOm1Eim9n+ykZ/wky3IqEI9oDg6BNmFjbuYoW9/J2frKe46xwEr9WjF0/TOZIhC
 qKJ5XVD1FxM+Urk/1aaqfWtthnFXnVVMgr99gaEtNSm5tal7tGHYAfcGmyWH4GO8+lboE9FcTn8
 hSPgZdL889dxDAZCdqlJt6CVl9goXGtkCV1e6RA5NsaQN8fJESi6yAScYulI1sIxweRj9UnwWTw
 WCLCxoUEZ9g+ziKMbDNDgfmqlqoLRCnwcyhN9m2CaKx7p7oWsKzKinbZWMhlX/iOL5GCWbrs8WK
 JBRikMpfismOkFFGpaUwZ898j7X0sGctcTs260PLol43pftFyMzZJGPVbtOyqFLoLPi4c58pcpB
 WTFXNJD0IdlQ/eapb4g==
X-Proofpoint-GUID: SCjiNJzvXufeHe-RObc3oaHLQ1jVeuqX
X-Proofpoint-ORIG-GUID: SCjiNJzvXufeHe-RObc3oaHLQ1jVeuqX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDAwMSBTYWx0ZWRfX20vh9eyHNNuu
 10oh97qDUicXxUhqZoiZuDUxqKun+vKll0MHM7AkuMG7H5bNlqq/qXX1oTrAXcl7TD0P1x97SuI
 aYLmBIcfMO+OsDDfttUZNlhW2XKpnUw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609050001

T24gV2VkLCBTZXAgMDIsIDIwMjYsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IGR3YzNf
dGlfcHJvYmUoKSB0YWtlcyBhIHJ1bnRpbWUgUE0gcmVmZXJlbmNlIHdpdGggcG1fcnVudGltZV9n
ZXRfbm9yZXN1bWUoKQ0KPiBiZWZvcmUgY3JlYXRpbmcgdGhlIGR3YzMgY29yZSBjaGlsZCBkZXZp
Y2UsIGFuZCByZWxlYXNlcyBpdCB3aXRoDQo+IHBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKCkg
b25jZSBwcm9iZSBoYXMgc3VjY2VlZGVkLiBUaGUgZXJyX3BtX2Rpc2FibGUNCj4gZXJyb3IgcGF0
aCBvbmx5IGRpc2FibGVzIHJ1bnRpbWUgUE0sIHNvIHRoZSByZWZlcmVuY2UgdGFrZW4gYSBmZXcg
bGluZXMNCj4gZWFybGllciBpcyBuZXZlciBkcm9wcGVkLg0KPiANCj4gVGhlIHVzYWdlIGNvdW50
ZXIgbGl2ZXMgaW4gc3RydWN0IGRldmljZSBhbmQgaXMgbm90IHJlc2V0IHdoZW4gdGhlIGRyaXZl
cg0KPiBpcyB1bmJvdW5kLCBzbyB0aGUgbGVha2VkIHJlZmVyZW5jZSBvdXRsaXZlcyB0aGUgZmFp
bGVkIHByb2JlLiBJZiB0aGUNCj4gZGV2aWNlIGlzIHByb2JlZCBhZ2FpbiwgdGhyb3VnaCBhIG1h
bnVhbCByZWJpbmQgb3IgYSBtb2R1bGUgcmVsb2FkLCB0aGUNCj4gY291bnRlciBzdGFydHMgYXQg
b25lIGluc3RlYWQgb2YgemVybyBhbmQgdGhlIHBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKCkN
Cj4gb24gdGhlIHN1Y2Nlc3MgcGF0aCBjYW4gbm8gbG9uZ2VyIGJyaW5nIGl0IGJhY2sgZG93bi4g
VGhlIHdyYXBwZXIgdGhlbg0KPiBzdGF5cyBydW50aW1lIHJlc3VtZWQgZm9yIGdvb2QgYW5kIGF1
dG9zdXNwZW5kIG5ldmVyIGtpY2tzIGluLg0KPiANCj4gRHJvcCB0aGUgcmVmZXJlbmNlIGJlZm9y
ZSBkaXNhYmxpbmcgcnVudGltZSBQTSwgbWF0Y2hpbmcgdGhlIG9yZGVyaW5nDQo+IGFscmVhZHkg
dXNlZCBpbiBkd2MzX3RpX3JlbW92ZSgpLg0KPiANCj4gRml4ZXM6IGU4Nzg0YzBhZWMwMyAoImRy
aXZlcnM6IHVzYjogZHdjMzogQWRkIEFNNjIgVVNCIHdyYXBwZXIgZHJpdmVyIikNCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy01
DQo+IFNpZ25lZC1vZmYtYnk6IFJhZGhleSBTaHlhbSBQYW5kZXkgPHJhZGhleS5zaHlhbS5wYW5k
ZXlAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jIHwgMSAr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIu
Yw0KPiBpbmRleCA2MzI2MzRkNmU4MWUuLmQwM2IzOTUwY2UwNCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMt
YW02Mi5jDQo+IEBAIC0yOTksNiArMjk5LDcgQEAgc3RhdGljIGludCBkd2MzX3RpX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIGVycl9wbV9kaXNhYmxlOg0KPiAg
CWNsa19kaXNhYmxlX3VucHJlcGFyZShhbTYyLT51c2IyX3JlZmNsayk7DQo+ICsJcG1fcnVudGlt
ZV9wdXRfbm9pZGxlKGRldik7DQo+ICAJcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+ICAJcG1f
cnVudGltZV9zZXRfc3VzcGVuZGVkKGRldik7DQo+ICAJcmV0dXJuIHJldDsNCj4gDQo+IC0tLQ0K
PiBiYXNlLWNvbW1pdDogOGI3MmY2NjI2ZGMzOWI5ZTdlODJiMjcyMWQ0ZjdjM2I4NjI4NjAxMg0K
PiBjaGFuZ2UtaWQ6IDIwMjYwOTAyLWR3YzMtYW02Mi1ycG0tZml4LTUxNGNjZjA2OTZhMw0KPiAN
Cg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0K
QlIsDQpUaGluaA==
