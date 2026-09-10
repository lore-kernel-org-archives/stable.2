Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A14D328B7F;
	Thu, 10 Sep 2026 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079467; cv=fail; b=bGM/fodywoveAKU8no7iRAQ27+yYnt3MATmE5TE0xn/dE3JhKQ4FiVF6jP77duQAyBKO6ei/ZHOuwCZ/s/ky6sTqodLgRCDV2AJBXlM7LiO6q80OpuNMNX0WQeLP/XD1w8ZUJcZAsRpcFQq6ikAcO81JtmpLs4Bfzn0u+KLjetM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079467; c=relaxed/simple;
	bh=UFQax/5ZMIOp9OaBh2xE7raTacUfAmBiBWfDek/yP0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R5EljfRlEX95eNykNRXb/eLHk/fAJXSk2sEqrD/BLZcIvonI5l6699lXOemMoaeZ37vFqNKtCYWO9jVr9STR/PsPOZ+FdAVl6wRSa4LUdwbUUEuN1EEPSCCtxSVbme8s2viMOyGa3aVD1idhw6wIGrjzLeKOhEodINxnnCvLn6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ql7SZhve; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iJr9c8OD; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Ovp5s3ay reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ql7SZhve";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iJr9c8OD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ovp5s3ay"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AMHqij1172119;
	Thu, 10 Sep 2026 15:30:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=UFQax/5ZMIOp9OaBh2xE7raTacUfAmBiBWfDek/yP0k=; b=
	ql7SZhve+Gvnrv5PR7HGJDxElLqBcfO/q3YVharxPMsVz1TarEOqbVeA2ePHM7+y
	LmOnU22lXZ0M6/hwUSR8KjJTTPC9rkjTk9422B0/NY296qcb7xbX4UBKGnX4qChG
	KZyr62apaWPAz70j54sCsNtoeqQ46SeQpd58DHhRX8kapYoTFvBSs2eT7sVhm+Kp
	nbd7hXGtpJfLDgvgQal1Mxx0ZA1jyRJwNKyxRKqAPxH3hPHOH+2jY9kCxIGY+gHW
	3CMR2Xfz9R3hIOBQjCLME9zhJkCttLjw/emKSTYEmYNoSd4z+TAR+0UiwqKNjGfC
	aEWi+oV8AhRCgldgfSbtSg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4gm00wty58-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1789079454; bh=UFQax/5ZMIOp9OaBh2xE7raTacUfAmBiBWfDek/yP0k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=iJr9c8ODbDKRQvdECqxNTtBITCc3jBsmaAaIN+58ppU5bhOZtXPbKd0pQk0tM3sc4
	 LQlevCYL8VZzps6BAwUov1nk3NhWD913tT6s7d6gzvigUTWEF/uDMTiZNZ5HbaXr88
	 eEtcE5evMREdsJiOQiAVW4mdvBaIJnAPYJhzSRVetBaS/2xY+b6NjO55lIyACLJqzE
	 feF+/O4CM1q+xvBORAPkwGWrIAsA9mZ0W/qWo/4oD8zAV6jnDFIfgjwCztqHobxetW
	 08VACSTLBkSrBQqHN4pIFQKiCR/afARSIqi4sAEJpRRdKHst0BRYQSrspDGyhj0JL0
	 XDAaD/lCaiBEw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 623BB4014A;
	Thu, 10 Sep 2026 22:30:54 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 17B9AA0070;
	Thu, 10 Sep 2026 22:30:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Ovp5s3ay;
	dkim-atps=neutral
Received: from CO1PR07CU001.outbound.protection.outlook.com (mail-co1pr07cu00101.outbound.protection.outlook.com [40.93.10.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8E72940133;
	Thu, 10 Sep 2026 22:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWEO9dPG6KXgvNk9mwRtYCFi0Q5kAfkDZ27d0zFBZMIImqBAgOVsPDzlq5CwqugMeFH/d97FtVAqAQqeXB1bquKBp9ZXxeJCeL2hGv7tqHUeZeVUUXqt2hCZKZcOLwmsxhWogoVH6dnTkgPW4ApK0ENFSbJbE0b+u7uvOVh4XDbD8JlO7gpeJmlLKhwFmZWR7dOSCLqGSXswOI7ry0JWPDtDw64SS4cHLh8IJuTMgJ44DKlioI9wF+r+/J6nN3sewd5ZHe8atTR3PNoi1gsnPGLUcjOAoEASRvu4WgavwETqmCr+6Tp/DR8j0lp9RrJ/G8CStUi3Q4GhQuORxzOXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFQax/5ZMIOp9OaBh2xE7raTacUfAmBiBWfDek/yP0k=;
 b=M0QsHCJPzb/QZA00sZQp/jymKc1FDeHiCgR8S83P4y696sDzBnkd5U/Ck5qqQaqA/v81cuT/buLJsMNYNyKfpM6QW4Y6Ye0oD82fW39ZTzZk11JZTg2sww7Ypyqy50nIYqv5rXPVwEjR0sXctsCHoVPvDyAV9TY0/CAAmoLM7PvchkzH69+mLF5kZrD+Y28Z+uB3F8xPimttfgg0IHqjtInIeFi7Wmp4VYMZAvGreYn8LPaord/IkZzKtqxs8poQ/eNYPBM9Vd10zfwoHJGzc91qqOs+v0zmzV5ZqungQNuU1CwueGKrhh9KBf8S5jgDre4ACxYPexhFYKBuoBa2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFQax/5ZMIOp9OaBh2xE7raTacUfAmBiBWfDek/yP0k=;
 b=Ovp5s3ayd/UhsstL39qYFD+/IHkrM+zEJ2tkMaPL8ia+wCa+5cMPGUR2oEsD4iiHRfShhmEegMqomG6Tt+Bz7d+2hdAsM5mEgHPz417xUYq6RDF+9KLvlt1YD73yp043zglJgCT1AGtvuJ2XvClzeAtetD9rgYMZIILFF7ZwHmI=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 10 Sep
 2026 22:30:46 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 22:30:40 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Jiazi Liu <jiazi.liu1984@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "frode@meta.com" <frode@meta.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Thread-Topic: [PATCH v4] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Thread-Index: AQHdPpvaWCP+o21w+0y9hCXTaD9MPLbIasGA
Date: Thu, 10 Sep 2026 22:30:40 +0000
Message-ID: <aqMp2exlhixwOVxW@vbox>
References: <20260727092258.1121-1-liujiazi@amazon.com>
 <20260907073756.22329-1-jiazi.liu1984@gmail.com>
In-Reply-To: <20260907073756.22329-1-jiazi.liu1984@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CYYPR12MB8749:EE_
x-ms-office365-filtering-correlation-id: 6cfd5a81-3012-40b0-2d59-08df0f8b24f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 iTVJ5ceLVKxxtn8/Nsfzw4wvU0kFZzIRKS8AafXKPNsO9kAxhk1l6GLExxxzCFcF8DpqAXNO6LcIJK0NAiwxqw1Leb4pba/x0INKQYxCBLIQZ0Z55lXGxXtYVB09QtUAo+CmlhVGeiP/5/u+YM+hzWm75Hz/jTFZMbl8RyamUNrM4WtQKWO4kpehwD7VZwdQNf4AFil1N9W6aKL8jSfW9cJXeUOdfU73zRrXF2iAfyvKtt+wRUIanlfx34bfw1jHKRBYQ/To6Xmtm6UoktOR5pRLluht+Dzh+lAz9/4tWh0TmHOj3bMSWq8x7CYro9mvOY7prG14S44/Zn0Bg9oU/1qHTOt16/1sbpMB9m1vaD1KPnAJCGIPFQyiAuxy/2gXaNkh52dXbJc1M/lt5tSVzn6U7HVr2i/qiqWSdx584BEtnsQwlrK7/8h2iV+KLFDAfIufBRv9j42mALlMeoYZtSZX00CA1cJDaPtOiG5hb6RhZGubnSyjbDqTTCN0KIj/OnzRPtJ38QS8z2St00/aAdZqUb3uk2etgFUwBxXy6pjaqUUcaR3QYNpZiBWki8ax1NLoD+CrbtpsJ/z1DyUfamEUArAv61LB+ECD0Df0kN+7/Sup56/dazR88XGGUhFHI1rDSQyD+4rCYQl+HmZzGVmOyVn960EESpX/qb6RUl9fEzdSRQzZyQk5NzUPexT4gKa8wfpOdAxvCLY96+Qywwt4e3p3pw7W5nTz21uuPgU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2thTU01N0JwZE41V01QR01IdTk5K2M2YjZSOGh6czRJbnJIMEh0TmhEekx0?=
 =?utf-8?B?L2w0V0plY2cyNEJhdEVybS9OWkVlMEhuSjRBSlcwWTl2dnF1TmQrd1QrUnJB?=
 =?utf-8?B?Vm5xYXhnWXUrWFhWNDJ3bHVPQ0hhSDJXZHZ2RTQwbmhwNUR4d0grTW9LeDc0?=
 =?utf-8?B?d2RvMWNoWVdQeEE0Nm4zK2ZmaFNmam9BZFdsTkdvemZkcDQrbkY1eUR4c2VE?=
 =?utf-8?B?NGxKK3p0bkJBaDRadit1L3R4d2pwRG01N0xaUnZ5eEJ2VzRVSXlTbTlUcU4z?=
 =?utf-8?B?NS9aMlRkeXNuOWRTbHBKdHprNjVBZ05ZeXkrVDZyeS9pMEJUSjZBMUlCSSta?=
 =?utf-8?B?ZmRlOWtGZmEzU3NpK2FmcHNZMHpwWDNQdFhsQ3d4VWJ5M3p2My9QOCtmd0gv?=
 =?utf-8?B?MnA1bFovTUQxbUZYajJSMzRsbjl2c0JMK3UvTzBWOG5oOFdid1JTdE55SHhS?=
 =?utf-8?B?U2p0RzJLQ1Q4Q2ZhYjJ0d0JVWm40K1VpZlQ4NnA3N091MG45a2w5WjBER2hn?=
 =?utf-8?B?WWZzSW9MbDh1Q1FkSVV5akUrR3dqZW4xOUl5V1c2KzdOZHFwekxveGNnZWxa?=
 =?utf-8?B?anRQZ2ozQ21mRWdyaXRlT3R5dGtKVmR4R3FZWkpMWlV3a0xYNzlYMHd1ZjBV?=
 =?utf-8?B?QS9vU21jZ04rdy9JZDNqZUpreUxjLzRtbStPMzd5azhmSmFNSXBBY3ZOeVR0?=
 =?utf-8?B?VVJSbTAzVHBsRmtyeVpHYlZ6VjIvL2hnL1B2ZDVaRWVHR0hLVzdJaEhsT25k?=
 =?utf-8?B?eHFOK1B3Ry84cFM0MzY5eHU4S3d1ZnhCNXdZVUpkQm5VSHhKeTdOTTlocE9r?=
 =?utf-8?B?TCtuM0NLUUZoMHJnb0d2S0xjWFFvTXg4SXMrTXNjdjZ4YnYxZ3FNS1FxUDJM?=
 =?utf-8?B?ZDg1MmgwSklHNFU5M0M1aXNVUmMrZnpSOVZuWWNpMW1Scm5McHljTDREdzdw?=
 =?utf-8?B?M3BIaE16aHljMG00SWcwUGJOb2JDUFMwanVacmhMUiszbkdCTG13aTA1ZEJV?=
 =?utf-8?B?ZVhqam8xTmtMREdacnRQT2k5dld5RnRvTWZId0h3WHh2ZGJVUkZUV0MydmI1?=
 =?utf-8?B?REZuVlkvL011TlROREdYY1BWbGQzQ2xoZ1FZNm0vTWN5QW40aFA3bzUvNUVV?=
 =?utf-8?B?alpGRkJXVndWSVlLK2g2clVBejl3RFJXdElLcndROGsxVHN5eGxSQWFNZDUx?=
 =?utf-8?B?RExXVkRSS0hheGVsTENwY0ZGc3VtWjJuNzRoOG9JTFB4ajk5RENudytheERW?=
 =?utf-8?B?dkM2N0ZOV0EwRUo1MnZkZzN1Q3Bic2ZpelV6WE1tRzFGN1Npb3kyZDc2SHdh?=
 =?utf-8?B?NCtETHJodUlxWUJETVEyWFNSYi9VSVZ2VGRUR1lRaFhyQTNmdmVJZ2VJUlRl?=
 =?utf-8?B?N090Q09xUFU3SzRlZEo1enJaWFgyYjU0ck9CTjdjcWVhSDNJWjdSRVJ4Tk05?=
 =?utf-8?B?RUN3N0Rub1VVaTNxWUZ3UFpveC9DQW9pUFFNUFJTMVNnUzFRQUJhbFVIQ1J4?=
 =?utf-8?B?WUlZRXFFTk1IbXZyUWNFSjVoRExYWnlRWTVCMEs1dktFTmRkcS9aMjVYMEV1?=
 =?utf-8?B?QVN4K09BanJFc2tBUGxUdTBTY2R6b2NCams3dlliU3lQY2F6WG9QMDFwZDRh?=
 =?utf-8?B?bDNaV2FDRjBKUTZnbGJOVmZtQWQ2OWxtYjZsUGY3c2VudkVCdERER3FYOU1W?=
 =?utf-8?B?MVRXQXFnUHJITkpmbk9ZbVBpdnltNFpPR3FlcU5mLzVIcGswMzNpODdMenJm?=
 =?utf-8?B?SkRnc3RYdWltRHhRMmoweUpNTkZtTXlUbXNpS1lOekI3V3R3YU1HVG13RGxw?=
 =?utf-8?B?R05UTUlxS1UzM24wdFNBWXdOSlVVeWwxcHRYOW91UzJRNncrY3pwLzhpNVF1?=
 =?utf-8?B?WkROWEFid1orNEs1b0hNOTlGWTRBR2hHZm4wUVJqZC9STmJpbWpQQ3luQ0dq?=
 =?utf-8?B?TVppL1c4U3lhQjE2dmhjdmNKenpXUXczRjVBdFpmcjBaK3gybHBDY1Y2Y1FR?=
 =?utf-8?B?TlBaVjFGQTZsVERiWGFPTVpPTHNKWG1PZjkva1BhVXBweGd1aC9sTTlDUlVp?=
 =?utf-8?B?NzRFZHl4QUU4eFduT0QyTkNWVks1eS9FcGRLVDNBaGtuL3VwUFpoZ3A2dzd0?=
 =?utf-8?B?aTIxTWpkOUVnT0VFOTRCUTNGbmpzZ09Rb240SVVnMmhGWmFMMjBPSmF0a0Rs?=
 =?utf-8?B?ODlxOEdnUElvcTRjZVNSaDVFZnFEd21SbnBqR2wvRmVlSHhLTkdGTXBJaW55?=
 =?utf-8?B?akNtK2luWGZuMmVGeXlETy9uQnM3NEJWZVdNejdVZ3RpKzJKbFIwTUZHcnhE?=
 =?utf-8?B?bTZycVJWcjJueTBBQngvRVgxUzlxTHNNVWJCZk8yMlp5OTR5ZzlhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDA3E37C14D3DA4F905D71633E8FDBE1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UO2r6cPhgFjGdWa4ph9CmuD6QEpa49I2JTB6DFg3LDS46JE7lqTr/aqhN37pKHYWUZRb7z2ykWdIg2Y/qBS3Ee1frETuIPyjCQzoDnnWV9ffhj+DRTMtBgJxc/T0Zs7KZsfH8DDVxHKujT4ogabda/5kv5gE5N7SlxE8SWKk/y+Mtvr1tlLqnn74djOv9KOa5Gf7GKpRmnAHeXIWOh+K3qIGinC0EOfK2q9XNh6735IgZijPOtppKJ2dvG+qy57/Jg9sN7/bYdJClcl2n2CDMicJ8GNmg580Ob7r7NgOyA5nbTtIQnDDeLd5GVlVcMACD+TSULfta1k69k6aj7BhQw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kGQl+ojpESb4AsxLId360cUs4va8xCKxd2wS8AO/AWE6mpyjpq1yUPQr2koV7M5kzwQ0e+UsVwQlT0gy1pw72wv24hnFYZcgGSIf/6adfGGmfXhP1FNVlLeXhYj4xf/7h+QW2XcyZo1bzD2AdYfWXFiRhO/wNy0RQ4zH4jtbVN7zP8794mz6ZL36Dqh6LvLnHohR2CLKtcScgTaXIJIbO1whzkJc756R5cDltvJy9NNtbT04P9yAVsSI6riM0iTiNc6+kfrWLApwhmeh1eKQum0uc1apwOJQKcsjUBP4/oPCk/ZW5SwHbds194bOK/FSIpZ2eeY8/+9l4Mw0oBtTQDdqmGs6GeBcketVE3cqPyRjktfm4R6+UVPPFUW/3vLfCUfNrhgeiBAiMpmTsv+ValBhSPnoJvc4E+TQ6xHDGvZrn9EOzrHWPW/JAajwtQxM2yAWt8dyDKwophJwODj7pb6W73CD5F32vO5AmfAphOiAXnDx/tAC5CVp6XLhNwWiYK6pf0F44aVoFdBGHnrX1ToSHJHvQN/jxTQzdPJ286Y+W5unhGL/Ziue3p3ij4IbtUW0wkt9k7zwQN9uXY8ULnoXgeKyibHbUT7gX4VunKrsqOc+hqZVIFOmHmt9dV06C7jMJyMb8l+bVfoeND66LQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfd5a81-3012-40b0-2d59-08df0f8b24f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 22:30:40.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIINuXTP/O2qz1iOjex6EZGo6fegvKue1A8cZxA0eIJY09OFIjBmoSD7mCnRY/0Os9N3YjCd8SxnmkMiYT8jLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749
X-Proofpoint-GUID: JvGHDKCN_D26tUkWQug4c7uqlMl_A9uW
X-Authority-Analysis: v=2.4 cv=aOVlOr9m c=1 sm=1 tr=0 ts=6aa32f9f cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=aQoCeZkFEbhAbVYd3x8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JvGHDKCN_D26tUkWQug4c7uqlMl_A9uW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI4MiBTYWx0ZWRfX+dbKR895h6t3
 l/AA4KAFp2lh6NJ/Y4kKR41aiG5nhbYQEnRjAwfQlP6WdtKG/CgFlnM54XF5G6/F+Py61Wat7gv
 sd3azMORzr2eryprwyOKzEW2FsKPin5moCjlpPfuBKihckrqANCwqSQ1jr1Evteyym5YDcNvJ6+
 Sa9Fv9D2c00TC7qfNaing8NV1PWSy1K0OA21Uyae6GFG1oGc/zjVDyZO2KEXAMBuc4AB2sk309c
 onnYt7P3PdKm4aNAHXXf6+XdTvgA5lY1fq+RWUjmYc7pcB9s9VV6NL2CSjF9DIPRJqTHeibkwAd
 mdT6E/2DRopprZG8xFaF/QwyJKsE++T4lDKwLg2YPo7/iMftK7u51YK1jy3jCE6DmgPb4Bex5Mk
 5EEBl4ACvpTxiHY270scIzLIbvatp2FJwo3544m0tvy8wKjI2eS8vqYgPgeYdGie9xUKtHxjVTe
 PymH6Lr7uU5PsebBSGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI4MiBTYWx0ZWRfXzrJDrbGm57Bx
 2toVaGB6OGEFdZJgijWky9Vi6NpPQZcPnhlksmGqeRLZFYK/h8wew0X7Qs7NIHdLGWh15Cv5eK8
 +E/97iPz/u7Xr/wFmO1r4bgsXXcwh7s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609100282

SGksDQoNCk9uIE1vbiwgU2VwIDA3LCAyMDI2LCBKaWF6aSBMaXUgd3JvdGU6DQo+IFdoZW4gZHdj
M19jaGVja19ldmVudF9idWYoKSByZWFkcyBhIEdFVk5UQ09VTlQgdmFsdWUgZXhjZWVkaW5nIHRo
ZQ0KPiBldmVudCBidWZmZXIgbGVuZ3RoLCBjb21taXQgNjNjY2QyNmNkMWY2ICgidXNiOiBkd2Mz
OiBnYWRnZXQ6IGNoZWNrDQo+IHRoYXQgZXZlbnQgY291bnQgZG9lcyBub3QgZXhjZWVkIGV2ZW50
IGJ1ZmZlciBsZW5ndGgiKSByZXR1cm5zIElSUV9OT05FDQo+IHdpdGhvdXQgd3JpdGluZyBiYWNr
IEdFVk5UQ09VTlQuIFNpbmNlIHRoZSBEV0MzIGludGVycnVwdCBpcw0KPiBsZXZlbC10cmlnZ2Vy
ZWQsIHRoZSB1bmNsZWFyZWQgSVJRIHNvdXJjZSBrZWVwcyB0aGUgbGluZSBhc3NlcnRlZCwNCj4g
Y2F1c2luZyBhIHRpZ2h0IElSUSBzdG9ybSB0aGF0IGFjY3VtdWxhdGVzIDk5LDkwMCB1bmhhbmRs
ZWQgaW50ZXJydXB0cw0KPiBhbmQgdHJpZ2dlcnMgc3B1cmlvdXMuYzoxODQgQlVHIC0+IGtlcm5l
bCBwYW5pYy4NCj4gDQo+IFRoZSByZXN1bHRpbmcgY2FsbCBzdGFjazoNCj4gICBfX3JlcG9ydF9i
YWRfaXJxKzB4YWMvMHhjOA0KPiAgIG5vdGVfaW50ZXJydXB0KzB4MzQwLzB4NDY4DQo+ICAgaGFu
ZGxlX2lycV9ldmVudCsweGFjLzB4YzANCj4gICBoYW5kbGVfZmFzdGVvaV9pcnErMHgxMjAvMHgy
MjgNCj4gICBnaWNfaGFuZGxlX2lycSsweDY4LzB4MTA4DQo+ICAgLi4uDQo+ICAga2VybmVsIEJV
RyBhdCBrZXJuZWwvaXJxL3NwdXJpb3VzLmM6MTg0DQo+IA0KPiBUbyByZXByb2R1Y2UsIHdyaXRl
IGEgYm9ndXMgdmFsdWUgZXhjZWVkaW5nIHRoZSBldmVudCBidWZmZXIgbGVuZ3RoDQo+IGRpcmVj
dGx5IHRvIHRoZSBHRVZOVENPVU5UIHJlZ2lzdGVyOg0KPiANCj4gICBkZXZtZW0gPERXQzNfQkFT
RSArIDB4YzQwYz4gNCAweDEwMDQNCj4gDQo+IFdyaXRlIHRoZSBib2d1cyBjb3VudCBiYWNrIHRv
IEdFVk5UQ09VTlQgdG8gY2xlYXIgdGhlIElSUSBzb3VyY2UsDQo+IGNvbnNpc3RlbnQgd2l0aCB0
aGUgc3RhbGUgZXZlbnQgY2xlYXJpbmcgcGF0dGVybiBpbg0KPiBkd2MzX2V2ZW50X2J1ZmZlcnNf
c2V0dXAoKSwgYW5kIHNjaGVkdWxlIGVycm9yIHJlY292ZXJ5IHRvDQo+IHJlaW5pdGlhbGl6ZSB0
aGUgY29udHJvbGxlci4NCj4gDQo+IEZpeGVzOiA2M2NjZDI2Y2QxZjYgKCJ1c2I6IGR3YzM6IGdh
ZGdldDogY2hlY2sgdGhhdCBldmVudCBjb3VudCBkb2VzIG5vdCBleGNlZWQgZXZlbnQgYnVmZmVy
IGxlbmd0aCIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IENvLWRldmVsb3BlZC1i
eTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClBsZWFzZSBy
ZW1vdmUgbXkgQ28tZGV2ZWxvcGVkLWJ5IG9yIFNpZ25lZC1vZmYtYnkgdGFncy4NCg0KWW91IGNh
biBhZGQgdGhpczoNCg0KU3VnZ2VzdGVkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBz
eW5vcHN5cy5jb20+DQoNCg0KWy4uLl0NCg0KT25lIG9mIG15IHRlc3QgYm90cyByZXBvcnRlZCBh
IHBvdGVudGlhbCByYWNlIGludm9sdmluZw0KZXJyX3JlY292ZXJ5X2NvdW50IHVwZGF0ZXMgYmV0
d2VlbiBkd2MzX2Vycl9yZWNvdmVyeV93b3JrKCkNCmFuZCB0aGUgcmVzZXQgaW50ZXJydXB0IGhh
bmRsZXIuDQoNCkNhbiB3ZSBhZGp1c3QgaXQgYXMgZm9sbG93cz8NCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQppbmRl
eCAxMzA5NmVlNDc1ZDMuLmVlODM3MjM1NjMwYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCkBAIC00NzkwLDgg
KzQ3OTAsNiBAQCBzdGF0aWMgdm9pZCBkd2MzX2Vycl9yZWNvdmVyeV93b3JrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykNCiAJdW5zaWduZWQgbG9uZyBmbGFnczsNCiAJaW50IHJldDsNCiANCi0J
ZHdjLT5lcnJfcmVjb3ZlcnlfY291bnQrKzsNCi0NCiAJLyogc2VyaWFsaXplcyBhZ2FpbnN0IGR3
YzNfZ2FkZ2V0X3B1bGx1cCgpICovDQogCW11dGV4X2xvY2soJmR3Yy0+Y29ubmVjdF9tdXRleCk7
DQogDQpAQCAtNDgwMiwxMCArNDgwMCw4IEBAIHN0YXRpYyB2b2lkIGR3YzNfZXJyX3JlY292ZXJ5
X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KIAlpZiAocmV0KQ0KIAkJZ290byBlcnJf
dW5yZWNvdmVyYWJsZTsNCiANCi0JaWYgKGR3Yy0+ZXJyX3JlY292ZXJ5X2NvdW50ID4gRFdDM19F
UlJfUkVDT1ZFUllfTUFYKQ0KLQkJZ290byBlcnJfdW5yZWNvdmVyYWJsZTsNCi0NCiAJaWYgKGR3
Yy0+c29mdGNvbm5lY3QpIHsNCisJCXUzMiBjb3VudDsNCiAJCS8qDQogCQkgKiBXYWl0IGlycSB0
byBmaW5pc2ggYmVmb3JlIHNvZnRfY29ubmVjdCByZXNldHMgZXZ0LT5scG9zIGFuZA0KIAkJICog
dGhlIGV2ZW50IGJ1ZmZlciByZWdpc3RlcnMgdG8gYXZvaWQgcmFjaW5nIHdpdGgNCkBAIC00ODEz
LDYgKzQ4MDksMTMgQEAgc3RhdGljIHZvaWQgZHdjM19lcnJfcmVjb3Zlcnlfd29yayhzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspDQogCQkgKi8NCiAJCXN5bmNocm9uaXplX2lycShkd2MtPmlycV9n
YWRnZXQpOw0KIA0KKwkJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KKwkJ
Y291bnQgPSArK2R3Yy0+ZXJyX3JlY292ZXJ5X2NvdW50Ow0KKwkJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQorDQorCQlpZiAoY291bnQgPiBEV0MzX0VSUl9SRUNP
VkVSWV9NQVgpDQorCQkJZ290byBlcnJfdW5yZWNvdmVyYWJsZTsNCisNCiAJCXJldCA9IGR3YzNf
Z2FkZ2V0X3NvZnRfY29ubmVjdChkd2MpOw0KIAkJaWYgKHJldCkNCiAJCQlnb3RvIGVycl91bnJl
Y292ZXJhYmxlOw0KDQotLS0NCg0KVGhhbmtzLA0KVGhpbmg=
