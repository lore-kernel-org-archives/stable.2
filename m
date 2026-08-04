Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA232379C32;
	Tue,  4 Aug 2026 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884708; cv=fail; b=sZYZvgUhOVhLjVuLfvlNkxlj3WPgm5399E9HEZtS/dgqUuiSrWuTOnO7M7TffGxAFrE1GJrhQczGb8p6wCxqgAUrOVFDBGiXfRvlVLnqC0PATxb3HdCR4bA8nZyMNWu4eBqAg/JFGJqDBGjC/atpJW4Rt/irgM6dIeargzHaVEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884708; c=relaxed/simple;
	bh=pVgi88OwIkOHPNdb5YFCoHyT/yoaH8sG/QqqXkFQEEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SdkJEtbtWUEsA4Didpzuc1ToTuY0Wzcpgr1hnAYCMen/Hrg2RMYk/bG4uozeB77nDrgGCUXHSL0gpnAhNrHdFS77Z2m+DZlTcLTvTAjRMuWLipX3KXEo0kJKAfH/q7HSVpq2g/E0zu+uOSYQ8C6WciJjLQbmmYF+eqGmWCPdcUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=B8lorXF+; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BF1MGGeg; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mYirCVR5 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="B8lorXF+";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BF1MGGeg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mYirCVR5"
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JpdLS844452;
	Tue, 4 Aug 2026 16:05:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=pVgi88OwIkOHPNdb5YFCoHyT/yoaH8sG/QqqXkFQEEk=; b=
	B8lorXF+o1cqO4ExtRXteSU+yaGumsgRJYaqtOJXq8kCKE8qqatrKPJq0uuUVbYD
	i3g/oGXdAf1WdJ9vob7lb8U2OZ+SOmC3OyyNfEVLVITE4uLYSGBRe+nrks5QeH78
	nEdxVjWOq0TtlUsbXWzlrSUP3gXa/k2C3N7X2Uj+ePo6A7Y/GbKrQTC2H3UweJLw
	hJQOX/dKNtZ0IRbpeAbW6sZ8dJg5ipt9392O4SaHwlKxD5SYO2jhWqCNLwOPxt4C
	+2Euuhr03RF3eLDXRKPkVDsmzXvmO06SgncgplPlYI4jnzppNeEnmfdnz3OnpNez
	HIYfEPJ29GAsw9QbgT7trg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4fufyjdphj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1785884700; bh=pVgi88OwIkOHPNdb5YFCoHyT/yoaH8sG/QqqXkFQEEk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BF1MGGeg/zsgxu76MQ3pJv/ZZzg6yI+9VEMTdWrOA9Twd7umwMkrPf84pGJNuVRsN
	 Q32ReQyI6fZRhaAsf6oWIKTDorhB79k/x176hH4lQs2XdfCEExk18Drtyn8nd0WsMY
	 TAiljhyKKXxSpmSWN/t2JssXM+JyJ7k3SkV37j9En2naMA1Ni2mZDead0dusuaRAm6
	 S03IDWszljrUJabkJfz10KfOe+xAc0kfrSUnuuhJgmFmusieHZVo8maS61sKTMB0GP
	 wWTfVNOuu1NhNxusHEjjHDxokKFe4yHYQSIdzwrVX/OMKtg83/CkIwIvGoKdR0oFs+
	 xMNfj9eeI/JCA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2616E404CF;
	Tue,  4 Aug 2026 23:05:00 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DB935A00B1;
	Tue,  4 Aug 2026 23:04:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mYirCVR5;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00102.outbound.protection.outlook.com [40.93.14.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1031440580;
	Tue,  4 Aug 2026 23:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jILc85t4ghpe6j1GjRGqPXmWZc5Wf+jYw7LWYY945lqEiyXnhO6VFfX/rOr/YVG3W43pHfRy94C2O7B0+e7R4sUSAt6/McQIwK1W3qzKdaWVpHQIDWFAGNxRIXuh80OUB4HNZqBuvV5m4k2uBzpWqVi9KL50xx+nUY5tgmQ0QpvsS5Fbj3sO/Fwtg0QbwHAlvcBhcf7+P8O7niJxSdy0FO5Hy7yWcRErCjezHqrGuxROkebLfCj2lBJjepfZ5FLbqbZaCC0PisxVoqPJtIhXC+tqf5c8H5NeF+TqEDuZ7878FoA0/OcLfARSkgu82nAm1XMAjbRpf4Z3Ac/1aPLlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVgi88OwIkOHPNdb5YFCoHyT/yoaH8sG/QqqXkFQEEk=;
 b=EaZBYuVdGi11rtHa5U9YHzr7OVDOE/wnvZPPq/5dmH79+r3b4A+Bg2VwycoynR3xv74Zd1ss/lWdX/HkC/daWbCcVCmiZTRhxzduLmbbpnsNUFDrCBEyKFon2aMDAB3joTMEYoDBGG+neZfp+SKoNxNsTptDVn2gPu2xcWaWE2/7mzeSt7SS89I8Tv3vX+grvcVsoHY+pKKlUcSOqaBuswHQR9BZ/eBMByPBJjW3EgzvHS6UJTLF5vtZ6SyJgzRzX3QAE+aW3uqTc5zs/v0b+wxPFlKfjpidc3D6AKpbr4T+eslcQ/NYr0WSkOqeRyDZcUYvoVlU+ZFJANoqkqlpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVgi88OwIkOHPNdb5YFCoHyT/yoaH8sG/QqqXkFQEEk=;
 b=mYirCVR5BGgPQjFR/uBidAdwwxkN5M2oSnmJluvkmr7bDD9XTC0dY7AF+1CwmmvWVWyPFzXrJNED4V9wbZPHS89kDVa7+CzyFIxlqYBeEdkyJs+sZhZHKUy1HHg1IiGrIdvrVXs1XI/NyLnBIaPXb6+6Q+JvaJqkoQzWCbQ5Ipk=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 23:04:52 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 23:04:52 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Jiazi Liu <jiazi.liu1984@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jiazi Liu <liujiazi@amazon.com>
Subject: Re: [PATCH 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Thread-Topic: [PATCH 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Thread-Index: AQHdHawGuYxuzFPO6kGdHse9sTxJSLaOj/aA
Date: Tue, 4 Aug 2026 23:04:52 +0000
Message-ID: <anJqxCgXNF4WN1Qe@vbox>
References: <20260727094015.5101-1-liujiazi@amazon.com>
In-Reply-To: <20260727094015.5101-1-liujiazi@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|MW4PR12MB5602:EE_
x-ms-office365-filtering-correlation-id: 0da4949c-9f8f-4fd2-67fe-08def27ccad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 HK2swolgo5MwlHrvmULzAk0d6vxnF9T7AxGGOJec8nKdxSimUdP1myldM8zGPsDCMPmrYqmBdWRx418zk7S3A1tzpvV9qZvim2cP01OMZhlMCt6EetXZRvTwJ+kZireENoMkBQPQSWJORZVQQI9/VYisTfLdQvVd00OaEpBwUCYIekt8vy0nCDCdfJqVg3K0kaSr3rugrIrh8/xbBsegxqnLlhyM1qCX/GnyDfFBnwoLXj1Cnz4qyEjelB3N/LcCHELLRrExEi8d0iqLmQugYDHJWS34IOu+YspQYxFowdxkMksCCi6cdRWRZ37czNC2hLqzTl43goqKnM0AxmQxDYZM2bqjkQ0tUBHwuGQeOJmWHCCK3neNo6GpgM8NIL7Fylxohv13Ba5HjRajTnrePJ+7lrhnsyVRuw4jOZG4P7tJhS9HZUGtH85ccJX7icgXdcSZbrfmLeljQPYQMeal+HME5yIjEaelBII/5mcXcQ3ga6d9TDbbfVfr61zjapmGtsNtkT7GaoOYegpcSwMFOsbLja1NtRfrnW5qA6ckSkPovOH9K7APyIl83T6aYtr5rB3IbrPsdxGrYtSmibglSRiCeAF8M6s9yd9HbcJCjp80kvi8pL8RzortqEG0zqvn2GzTjyEtI9+4h/sJgnY+1ch2D+9VWdR0M1NsPHJLW62z0dROVQgD66E26pHmDABz1/2cCY8feiLLgsQ4a7BtJ4K7m0k+y6PbxOuGU0o8w5A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmxjempyczJyWERvLy9sUXNkTTZobU5kcDk4TjhFVDNjVFVBN1poS0ZvejR3?=
 =?utf-8?B?dlBMWDloMVFRU0pWUlVyWmNBaENKSDVvM29UK01FbmhKQUZhUE5uZFNhSDNK?=
 =?utf-8?B?QzF6elNKNlFsSVh2SlZwN1QrT0FtUlhLb0dVejE0WFBCOTZwRXcvOXlCUDVM?=
 =?utf-8?B?aEhVQXU1OFhjMHFrV2F4b3NsMDNsYWROdXZyV3dBYndwWVp3MUFlRE9wSjVR?=
 =?utf-8?B?Vno3akJwYzJ2c1NpZWxCbTRtQkhYOXRpVzRuaGhYMy84bWtJK2xFejVlenY3?=
 =?utf-8?B?ek1sNkJWZmRXbDVtTExsT0xuaWdXa3RtS0VkYkQvWmptL0l5SnV1OCtzeVJt?=
 =?utf-8?B?Yld3b1RaeW1hNHpKeVArdEdmL3dGWTZCTGQ0WmxoYituTWpnQ0RTYVZLL2li?=
 =?utf-8?B?em1rNlhmdUJQSEpDbWpzNFhMVW9NYWpkL0ZvT3I1R3p1UHh0NGRXVWhCd1FS?=
 =?utf-8?B?M2t3QStmT0NpK2JuQ3U3VGFoMmhxVTlLcUxLclpyQXIxRzY1ZHZ5QnF3N3kr?=
 =?utf-8?B?TFIwVVBWbWplZThwZlowOENRbnl4S1Y1UkdHanV6am0rMUVnRytHVWRHSjQ3?=
 =?utf-8?B?Y2w1QnNCb09VVFVPeWlsbFdJLzV4MS8ySmhQTHFUVlZyVm5GL3pzTEpTclNW?=
 =?utf-8?B?UFJHL05pc3pta01NalpBZHllMnYwQkcybytMSzg3bWxTbnpQeTdHbko0c2Jz?=
 =?utf-8?B?bXBrNk9GUDI0cmMrRy81cWdwTU5Ob3lBMUdRS1JkVmJwK2lWUVdkTDNoa0hI?=
 =?utf-8?B?UjI1eUs0Q3Y4YWt0N1YrNVdLOUdEWEM0cGIwb09GL2xMVFArenRnVzlqTnNr?=
 =?utf-8?B?K2U2dEhDSTNWdVpqYkxMWlNHa0t3Y0JxSWh3TzZseDNwQzhBNWdXQlluUEdO?=
 =?utf-8?B?VmlSV1NhdGdVTkVRc3FRYU1PZHF4QllqR1R2OGpNYng1SGE5ODkwL21SU1ZR?=
 =?utf-8?B?SDlhYXU3OXpNRHowblRFaEROSTJBT2NkWE5jR245b2VnMTFVb0tIRW5zOXpu?=
 =?utf-8?B?Z1NuL3Y2UERYK0IwVGkrbzYrZHkrT0lObUVuTHVCY1pIL0c2a0dWaHlQZU80?=
 =?utf-8?B?Z2J4a1dyVDN0ZDJIRTlJZmpLRExxR3NHVlhLTC8wd2ZQU0U1Mk1IRHd1N1Rx?=
 =?utf-8?B?U2xadytaZFJBYTltdWRidDdTakFXb2ZaV0VsQytuTU5qYysyazYyOCszVzFF?=
 =?utf-8?B?QXhkUEtnRmsvZVZLK1BFc2dESHA1M0JiY0hMMDFwL2srUG5nQ1c2TWJ2VWtj?=
 =?utf-8?B?NDUwNXBYMnRjdkZocDZmN1V2KzBKYVo2bVNacHpWYUZvSlFNYUN5b1M1TkVV?=
 =?utf-8?B?S2w2MEZyVENudTh6TnVNT1IvMG5BakFUbXVwZGMwZk1uaVJsV3hoampuYjhG?=
 =?utf-8?B?THZJT0RUQmM1Z0YyUWUzcjRoL1l2Snp4TEdtUTRYanBlSWVWZTR0a0hYZ3ZR?=
 =?utf-8?B?SGkvN1R3dFpCZm5FTHdJdGkvTkU1MGZISFIzcW5wYnRacEdGR05qekJpVHhM?=
 =?utf-8?B?d1FaUVl4cTFxYUVucjU5MDhjQWVzcmtwWXJlRWcwakFhV0oxV2s5RTFuL3dU?=
 =?utf-8?B?NFhBc0JuUklVZmdQdlVXQ3VsSWw4U1IzRnBSZEx5OU9RUVNSb296Q1h0ZWli?=
 =?utf-8?B?WFlRU2I4OFpnU05zMHFKeGVMV3VQOXJQMzJLKzNDZUpSbUdFVi9zS3NFajdS?=
 =?utf-8?B?SEdlL2k5RVYwL3dPMGh4emxMazJza0xJa2VjK3pvVU4rOTdUSXNNaDRrZXhP?=
 =?utf-8?B?WmljTmNSdlhxNG9xTlZVak04QXlOSi93Y0wzVmhkUXBlMEE4WkV3bWd4RmFG?=
 =?utf-8?B?RlBnRWdHc3k5aUVwTzJqM29icmRTMDhVeWVKVFE1Z0Zxenh5S1Roa1k5eDNC?=
 =?utf-8?B?RTlnMnp2Nlg3THpra3dRZmExUG9sNUFKT3ZvZEhSclZhZCs4dCt2aTRPZnRB?=
 =?utf-8?B?ZlNHYnUyNGZ0UVVhU3BUempMTXozR2FUcUJiaDNqTGdxM0RvRTVranRYWFlW?=
 =?utf-8?B?L1JDMTlyTjBZZ1B6M1QrTG92VWV5U1ZNTklxNkdXb091d21lNGM4ZHc5UGtM?=
 =?utf-8?B?M1o4UldaNzBoRzhzQjkydkNMZGlMUDU0cUR6NlIxUWg5NUxjNUJNaldpRUY0?=
 =?utf-8?B?a3o0eVF2b0ZNS2tQZEtlN0tvWEUwdmJyazNuME9PeGhzNUdyU3hVUlJJOGZH?=
 =?utf-8?B?aHh1VzlNbmZaWmVickVuYXI2NzNyVjN6cGdKRDgxNlBFenM5WVNCREtXaHpZ?=
 =?utf-8?B?K0NoWkU0RE9zQTJCS1cyRU9LZWxhb0Q3Mkl1bGZwUG5UQ3VDNy9jb09jQ25V?=
 =?utf-8?B?UWN1RG9SRnlJcmtLbDRMS1YwL1ZQZk5BQVY0aHVaaklTVksxbGZUUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C33CD389DA8CBC48BD7EDC261AB442AB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NK71nSvqvjSr7kG+XBVmxNUzuaUzkyrd/12hcmhXwdfn5CTv8GI7ePSO+/qAry5bzOp+I4TT7YJh+z+744Hk4OGqrnvHohD5AFah9ODoPXh1iCwA13eggfcJ6vYyi/u6DwUbmzbTRBXdQjLIu22+YJjxKFnEqUk/lFpwLlkXRA32Rd61P4TgBP0Qq+gOjjffAuyREeTcW8LJJ1z54Nv/f5XKL6vlA+3sdnCmMqzeBDQWjH2TJji7uCBkRs2uw2818buKWWWDwyyUGA6wtWce8nz9dbd/T4nB3K0uLB+YKfuR/J8qwT+SW0SYcMqg0lKC6Lddmq+824Fmzp8Jqpmi/Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UtyWFsY5BZq+lYF1LnsojCfJP3XVRihr65jPJGwj7UBrhBbu+IJx0q+L7llkrfGeUFWJZq+YnNUvNfNz3adi4P2GKJVfF7ybAbYq1FuTP4rEZ7IC25DPH9YOY3R7R0Rpj4G+xBelt51mzLjrSCeijOT56yho2+aPNd7kZBzdW7l7IBOxYldBwbwafkoTDeHRIJi5RIGtYT/h1iiQ24AX15gWQ0jhAzGQTi6LQsKcT4NGT3TizBfLZoqeQI643b/5uzDnstwHLhQE8+QPXX5kILUwCrVVs1bIDRMaE+h/KmSgEv6ejL4FsUsDaPGLUB957O9kw37s0tEt21DW267Bqce2BwxRMrZ+m5yR5hLGCm72M0Jw5156j3R6x87BEBcWycUuIgQUtDGrKwfLfXA5Tl6Xun3rCi/Dy64qOoGLgylJGC+JwRi/n2l0qRSgYO6NWrXQNr157BaRDzgjWhvHmgMqaWAdlUxhlebH+MCB9zpqTcHDLGFnZ6n1pLEwAW3ePS1kOtPYB1hNCQe6K/2x3Ca+t2+BEmCxWfwyuw+4+Od6T8qPv5IBtC7aq+XFBBZXiOSqXWpVnWEmtM3SXVmXzdpmXfTPkQN7rsKJULl99I4ceabLJI6x+/4/kJWWInQ5q7lyG6DDtnkQzF7KTwyb6Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da4949c-9f8f-4fd2-67fe-08def27ccad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 23:04:52.5410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2mka+vV6uZxxCu1TjPAxRhUPVy5eg2R4yTxXB+NvJiuM6bVEe6jkTXpmpN4vdSqPqtMwmtsM7/AHbGDvo2ULw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE4OCBTYWx0ZWRfX8Y3md+W3agDZ
 E57Qhu0U1tHwktxd3oUvA6Ynwmvf0CiuQbXflpQWN0td8noohXuUauhm7lMb4BJs/d1Q877wlnO
 SARpRgH/gaF6xXMMqOOjX1l0xpDxWlE=
X-Proofpoint-GUID: NDMrOrZZh6hvq171kLur8r4ItGYYoWYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE4OCBTYWx0ZWRfX6CjaVk58dalr
 99XZBpkhwKSRFWxRRtW4a0P1jn1fPt8meS+GGxC39ACJ7AU8Vghs6KuL0ShB8MDvm/grfwrp9je
 oBRAm7S42SWRjcfQWPs+VW6dg/UU/EFJItdiCkZ8f2k5ArZjL22uzNn7uVHguvK1u+UVLdezOqh
 6UFlM8L4pEkQPKaZ1Dwfxx+VefXK/wZdWqE19epJqCZhcNLQ1bJSC0zR24MU2EMWvJiaua/2QAu
 IeAaHUvy3qTZVG4hM+iZSP0MwXykrDI3eEzft+iDA7H9ffQwL8fpoTV9v4H+fyOycZT5dV9kCRL
 pLiQXPW1hylaKBHQh+jFqpzIiOg8D1WcXsA8v+ewP93yFbq4gv0/8Kyvpz6WbQeOUEKYyaRa0Un
 jb3qrAj+nHNWYv49mBXR4RvA1Yhtz3WtgzUlJR51YXzeADmhpBGZiAaqleh69h+PLKaHfB+TSdL
 1HmfYAlf32JcXvRC8CA==
X-Authority-Analysis: v=2.4 cv=CaU4Irrl c=1 sm=1 tr=0 ts=6a72701c cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=xKlp24NoqlmsZ8y70KjX:22
 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=idEhfRjCnCdKCipPVucA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NDMrOrZZh6hvq171kLur8r4ItGYYoWYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608040188

T24gTW9uLCBKdWwgMjcsIDIwMjYsIEppYXppIExpdSB3cm90ZToNCj4gV2hlbiBkd2MzX2NoZWNr
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
LCBhbmQgc2NoZWR1bGUgYSBzb2Z0IGRpc2Nvbm5lY3QgdmlhDQo+IHNvZnRjb25fd29yayB0byBy
ZWNvdmVyIHRoZSBjb250cm9sbGVyIHN0YXRlLg0KPiANCj4gRml4ZXM6IDYzY2NkMjZjZDFmNiAo
InVzYjogZHdjMzogZ2FkZ2V0OiBjaGVjayB0aGF0IGV2ZW50IGNvdW50IGRvZXMgbm90IGV4Y2Vl
ZCBldmVudCBidWZmZXIgbGVuZ3RoIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U2lnbmVkLW9mZi1ieTogSmlhemkgTGl1IDxsaXVqaWF6aUBhbWF6b24uY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oICAgfCAgMiArKw0KPiAgZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKystDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IDYw
OGRhZWI3ZWYxMC4uMDg4MWVkN2U5NTZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtMTAwNCw2ICsx
MDA0LDcgQEAgc3RydWN0IGR3YzNfZ2x1ZV9vcHMgew0KPiAgLyoqDQo+ICAgKiBzdHJ1Y3QgZHdj
MyAtIHJlcHJlc2VudGF0aW9uIG9mIG91ciBjb250cm9sbGVyDQo+ICAgKiBAZHJkX3dvcms6IHdv
cmtxdWV1ZSB1c2VkIGZvciByb2xlIHN3YXBwaW5nDQo+ICsgKiBAc29mdGNvbl93b3JrOiB3b3Jr
cXVldWUgdXNlZCBmb3Igc29mdCBjb25uZWN0L2Rpc2Nvbm5lY3QgcmVjb3ZlcnkNCg0KUmVuYW1l
IHRoaXMgdG8gZXJyX3JlY292ZXJ5X3dvcmsgYW5kIHVwZGF0ZSB0aGUgZGVzY3JpcHRpb24uDQoN
Cj4gICAqIEBlcDBfdHJiOiB0cmIgd2hpY2ggaXMgdXNlZCBmb3IgdGhlIGN0cmxfcmVxDQo+ICAg
KiBAYm91bmNlOiBhZGRyZXNzIG9mIGJvdW5jZSBidWZmZXINCj4gICAqIEBzZXR1cF9idWY6IHVz
ZWQgd2hpbGUgcHJlY2Vzc2luZyBTVEQgVVNCIHJlcXVlc3RzDQo+IEBAIC0xMTg5LDYgKzExOTAs
NyBAQCBzdHJ1Y3QgZHdjM19nbHVlX29wcyB7DQo+ICAgKi8NCj4gIHN0cnVjdCBkd2MzIHsNCj4g
IAlzdHJ1Y3Qgd29ya19zdHJ1Y3QJZHJkX3dvcms7DQo+ICsJc3RydWN0IHdvcmtfc3RydWN0CXNv
ZnRjb25fd29yazsNCj4gIAlzdHJ1Y3QgZHdjM190cmIJCSplcDBfdHJiOw0KPiAgCXZvaWQJCQkq
Ym91bmNlOw0KPiAgCXU4CQkJKnNldHVwX2J1ZjsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IGZhMGYx
NmZmYWZlZi4uOWIyNDI1OTI3MmE0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTQ2NjksNyAr
NDY2OSwxOCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZHdjM19jaGVja19ldmVudF9idWYoc3RydWN0
IGR3YzNfZXZlbnRfYnVmZmVyICpldnQpDQo+ICAJaWYgKGNvdW50ID4gZXZ0LT5sZW5ndGgpIHsN
Cj4gIAkJZGV2X2Vycl9yYXRlbGltaXRlZChkd2MtPmRldiwgImludmFsaWQgY291bnQoJXUpID4g
ZXZ0LT5sZW5ndGgoJXUpXG4iLA0KPiAgCQkJY291bnQsIGV2dC0+bGVuZ3RoKTsNCg0KV2UgcHJv
YmFibHkgbm8gbG9uZ2VyIG5lZWQgdGhlIGRldl9lcnIgdG8gYmUgcmF0ZWxpbWl0ZWQuDQoNCj4g
LQkJcmV0dXJuIElSUV9OT05FOw0KPiArCQkvKg0KPiArCQkgKiBUaGUgRFdDMyBpbnRlcnJ1cHQg
aXMgbGV2ZWwtdHJpZ2dlcmVkLiBSZXR1cm5pbmcgSVJRX05PTkUNCg0KVGhpcyBjb21tZW50IGlz
IG91dCBvZiBjb250ZXh0IG5vdyB0aGF0IGl0J3Mgbm8gbG9uZ2VyIElSUV9OT05FLiBNb3N0IG9m
DQp0aGUgZGV0YWlscyBoZXJlIGFyZSBvbmx5IHJlbGV2YW50IGlmIHdlIHJldHVybiBJUlFfTk9O
RS4gV2hhdCB3ZSBuZWVkDQp0byBkb2N1bWVudCBoZXJlIHdoeSB0aGlzIGlzIGEgZmF0YWwgZXJy
b3IgYW5kIHJlcXVpcmUgcmVpbml0aWFsaXppbmcNCnRoZSBjb250cm9sbGVyLiBEb2N1bWVudCB0
aGF0IHRoZSBkcml2ZXIgYW5kIHRoZSBjb250cm9sbGVyIGFyZSBvdXQgb2YNCnN5bmMgdG8gd2hp
Y2ggZXZlbnQgaXMgY29uc3VtZWQuDQoNCj4gKwkJICogd2l0aG91dCBjbGVhcmluZyB0aGUgSVJR
IHNvdXJjZSBsZWF2ZXMgdGhlIGxpbmUgYXNzZXJ0ZWQsDQo+ICsJCSAqIGNhdXNpbmcgYSB0aWdo
dCBJUlEgc3Rvcm0gdGhhdCB0cmlnZ2VycyBzcHVyaW91cy5jOjE4NCBCVUcuDQo+ICsJCSAqIFdy
aXRlIHRoZSBib2d1cyBjb3VudCBiYWNrIHRvIEdFVk5UQ09VTlQgdG8gY2xlYXIgdGhlIHNvdXJj
ZSwNCj4gKwkJICogY29uc2lzdGVudCB3aXRoIHRoZSBzdGFsZSBldmVudCBjbGVhcmluZyBpbg0K
PiArCQkgKiBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoKSwgdGhlbiBzY2hlZHVsZSBhIHNvZnQg
ZGlzY29ubmVjdA0KPiArCQkgKiB0byByZWNvdmVyIHRoZSBjb250cm9sbGVyIHN0YXRlLg0KPiAr
CQkgKi8NCj4gKwkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCksIGNv
dW50KTsNCj4gKwkJc2NoZWR1bGVfd29yaygmZHdjLT5zb2Z0Y29uX3dvcmspOw0KPiArCQlyZXR1
cm4gSVJRX0hBTkRMRUQ7DQo+ICAJfQ0KPiAgDQo+ICAJZXZ0LT5jb3VudCA9IGNvdW50Ow0KPiBA
QCAtNDcyOSw2ICs0NzQwLDE0IEBAIHN0YXRpYyB2b2lkIGR3Y19nYWRnZXRfcmVsZWFzZShzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ICAJa2ZyZWUoZ2FkZ2V0KTsNCj4gIH0NCj4gIA0KPiArc3RhdGlj
IHZvaWQgZHdjM19zb2Z0Y29uX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiArew0K
PiArCXN0cnVjdCBkd2MzICpkd2MgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGR3YzMsIHNv
ZnRjb25fd29yayk7DQo+ICsNCj4gKwlkZXZfZXJyKGR3Yy0+ZGV2LCAiZXZlbnQgYnVmZmVyIGVy
cm9yOiBwZXJmb3JtaW5nIHNvZnQgZGlzY29ubmVjdFxuIik7DQoNClJlbW92ZSB0aGlzIGRldl9l
cnIoKS4gVGhlIGVycm9yIG1lc3NhZ2Ugc2hvdWxkIGJlIGF0IHRoZSBjYWxsZXIgd2hlcmUNCnRo
ZSBzcGVjaWZpYyBmYWlsdXJlIGNvbmRpdGlvbiBpcyBrbm93biwgbm90IHRoZSBnZW5lcmljIHdv
cmsgaGFuZGxlci4NCg0KPiArCWR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChkd2MpOw0KDQpD
aGVjayBhbmQgZm9sbG93IHRoZSBkd2MzX2dhZGdldF9zdXNwZW5kKCkgYW5kIGR3YzNfZ2FkZ2V0
X3Jlc3VtZSgpDQpsb2dpYyBmb3Igc29mdC1kaXNjb25uZWN0IGFuZCBzb2Z0LWNvbm5lY3QgdG8g
bWFrZSBzdXJlIHRoZSBpbnRlcm5hbA0Kc3RhdGVzIGFyZSB1cGRhdGVkIGFuZCBub3RpZnkgdGhl
IGdhZGdldCBkcml2ZXJzIGNvcnJlY3RseS4NCg0KUGVyaGFwcyB5b3UgY2FuIGFsc28gcmVjb3Zl
ciB3aXRoIHNvZnQtY29ubmVjdCBhZnRlciBzb2Z0LWRpc2Nvbm5lY3QuDQoNCj4gK30NCj4gKw0K
PiAgLyoqDQo+ICAgKiBkd2MzX2dhZGdldF9pbml0IC0gaW5pdGlhbGl6ZXMgZ2FkZ2V0IHJlbGF0
ZWQgcmVnaXN0ZXJzDQo+ICAgKiBAZHdjOiBwb2ludGVyIHRvIG91ciBjb250cm9sbGVyIGNvbnRl
eHQgc3RydWN0dXJlDQo+IEBAIC00NzcyLDYgKzQ3OTEsNyBAQCBpbnQgZHdjM19nYWRnZXRfaW5p
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCX0NCj4gIA0KPiAgCWluaXRfY29tcGxldGlvbigmZHdj
LT5lcDBfaW5fc2V0dXApOw0KPiArCUlOSVRfV09SSygmZHdjLT5zb2Z0Y29uX3dvcmssIGR3YzNf
c29mdGNvbl93b3JrKTsNCj4gIAlkd2MtPmdhZGdldCA9IGt6YWxsb2Nfb2JqKHN0cnVjdCB1c2Jf
Z2FkZ2V0KTsNCj4gIAlpZiAoIWR3Yy0+Z2FkZ2V0KSB7DQo+ICAJCXJldCA9IC1FTk9NRU07DQo+
IEBAIC00ODY4LDYgKzQ4ODgsNyBAQCB2b2lkIGR3YzNfZ2FkZ2V0X2V4aXQoc3RydWN0IGR3YzMg
KmR3YykNCj4gIAlpZiAoIWR3Yy0+Z2FkZ2V0KQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gKwljYW5j
ZWxfd29ya19zeW5jKCZkd2MtPnNvZnRjb25fd29yayk7DQo+ICAJZHdjM19lbmFibGVfc3VzcGh5
KGR3YywgdHJ1ZSk7DQo+ICAJdXNiX2RlbF9nYWRnZXQoZHdjLT5nYWRnZXQpOw0KPiAgCWR3YzNf
Z2FkZ2V0X2ZyZWVfZW5kcG9pbnRzKGR3Yyk7DQo+IC0tIA0KPiAyLjUwLjEgKEFwcGxlIEdpdC0x
NTUpDQo+IA0KDQpUaGFua3MsDQpUaGluaA==
