Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765925B092;
	Fri,  2 Oct 2026 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790906789; cv=fail; b=J5z6HWVm82xtoaBua+RB5VKywRtE8oYV3Xcs40gLQX8UZPTdpyk0aCn/bw/zKOx6J1/gBZ4yra/QuNLDly6zFHRhnStfzpUNqbqMOMgo+IkGlWk+sNZ4F6npAeEuh+jbJovqmFXMIg3Oh54PfN25KF7sg3S/j3ThQjlkTgkjLZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790906789; c=relaxed/simple;
	bh=6BwqFiQsdDkcbFNbdv0CJUJXuROjrfvIUghJe/L4u/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeDskzXPX8y5HJNc+DiNqzBoj57iFHUffg2gCoTMPbPsrxaLB4KN0rS1VCyxC/PaKfYYwVe9yfbNw2P9RFucA9Gy8XFhZVE5lvFkPOuHvb+zWqcGgQ+O7o3D6ftfzGOxIzQGtT6AAfmg7tsQezMTOQgpZRxwgWj8OA31vB+KVK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hsZvn4JV; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UGhBb4Pi; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RX++0BJ8 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hsZvn4JV";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UGhBb4Pi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RX++0BJ8"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691NGO1Y351830;
	Thu, 1 Oct 2026 19:06:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=6BwqFiQsdDkcbFNbdv0CJUJXuROjrfvIUghJe/L4u/4=; b=
	hsZvn4JVDwItDWQM1vkjDrls/kfS0aremQWz6dfMcyfqcSU9BuOB6rKD4k3t1WqD
	t4pEynqsHa7gBJ6kY8fC9l3EJnWCBKbdV2fRUqZp5/a36JqbeLi2v3JnDVzVH7Ka
	7tXyFhuH545aasb53GfCpzaN8mphycQvdErUZngP7OkGeJoUoRUWxywB8ZBq+9+V
	oIDl8UJWvaQWSB0rRo/GBrMIwewRChYOcgNh6l5Ig88CDKToSZu+AM0X8g/1AU0q
	M5/0Z2lHd1hrdBrsTIr6oGJjbu3vt08Fx88osNW4aA0YynbppjSAlt8bdUkOkxhD
	22VSkoO/Nijxtp/ltAb+eA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4h1dfy134m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 19:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1790906778; bh=6BwqFiQsdDkcbFNbdv0CJUJXuROjrfvIUghJe/L4u/4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=UGhBb4PiocycSrN8vLph24XJv7HP07Ua7V51n5D/RKxdCck6kkq+/G3xT5+AoSBo9
	 YJhOxYOOOG4vuHcFQhhMlDTerkbG+oGXYVcYIfB+gvCeKEn4gt8j7LhAFwj1ghsNKw
	 WPz+VQXohce4W+Y1C7shDk5XLmpU1C4LOAxO3xiNX+sRuz/CY4mr0gpvcWyBeDCjJ9
	 FWBN22vxBtMEirMToeXJoYlsbsfs7bAN6pt8Wkn7FXObnHz5Sip51bKy61j9TmGuHM
	 haGJBFb8bUC6Se3RNm3O9c/T/wkkxaaaM+OPBuTf0aW2jpmyXa+tMl/bRCBbRr3CUi
	 XvR8i52gfAd7w==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1D28F4013E;
	Fri,  2 Oct 2026 02:06:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B5DFBA005D;
	Fri,  2 Oct 2026 02:06:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RX++0BJ8;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00101.outbound.protection.outlook.com [40.93.13.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id AE946220524;
	Fri,  2 Oct 2026 02:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXjevPXtmY9i5e6YrxfutBhguGMrTwJrsK/6VEQXYivJZyv7jJvU7hhK9rz3i9OiHG/FMZ44h0db/8EcLPlD94kGghO7qrawVmtATnWvz58W/PWrgZ52+pnVnuaobb2GCo/UPo48USEBDI5AQTzfTId7cxMmfBm3N29L++zdAIwX4+x0dgq5qaXvIIyJMUTuzKSbGPSSBOMgG+mfJ/2DQj14ozntSqncsFw8yh5NmEjJ5YrB9v5sbTkBa3gJhl8LhQjbV+M7/dif7pB8LacT+2Afh6MnKt/fqSJ0hom6Wq0bihz08JzIp/uweNGT7CxvoX/YO1TPrO0LO0o0cLcVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BwqFiQsdDkcbFNbdv0CJUJXuROjrfvIUghJe/L4u/4=;
 b=qZEmsoZTJu1PKsFEDxpxsuiN1J2FZapgBP3SdnNkcGvTVtqaxl2Frhro9OnErm422ExYHS0acCb7VkFy59b0aB1AFCRL/gEJs1+wkLaR6W3r2IziKEO18Z+bcIx1Xc6BJ+E1QMXUqjjQFC2aTYGoroZ+YHRy/SkN5hLHZmbJF6Ax3OYJOeUo/dGDnE6bUWX/GqjIqeFnd8Kgbn8ABWV36QUSd/1IlSe8UTaCL8D+GH/NRPtgb03YM6uKJ1hgeYX2Q495ojL7IHanqQ4303tQSMksjw7GvR/1ZsXSHfOlEFcR5AfVaknJVu4wILtTt5Pj/xPJchyoYSVvOLDHCgBrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BwqFiQsdDkcbFNbdv0CJUJXuROjrfvIUghJe/L4u/4=;
 b=RX++0BJ8/8hQDGMsSVoAK4Enq8i3cKDNJwr7tf1NoDC2ly1XQERmzDpZSy2MCxkTEk2KLRmHSqHT3zEco6JLp/F03IXzZTPtJUSQu4Kx+OHmAjppUa2AiUWw2gVfC7/uQkYvx84+BAN4yxA3p6Es59isBHucj/eMn554QwTl/gY=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 02:06:05 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0451.026; Fri, 2 Oct 2026
 02:06:05 +0000
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
Subject: Re: [PATCH v2 1/3] usb: dwc3: xilinx: fix system suspend and resume
 PHY handling
Thread-Topic: [PATCH v2 1/3] usb: dwc3: xilinx: fix system suspend and resume
 PHY handling
Thread-Index: AQHdSr9HmpNE2NCYBkacT3CiHTr8K7bpj4KA
Date: Fri, 2 Oct 2026 02:06:05 +0000
Message-ID: <ar8RTQ5zmTuV48C0@vbox>
References: <20260922182125.11067-1-radhey.shyam.pandey@amd.com>
 <20260922182125.11067-2-radhey.shyam.pandey@amd.com>
In-Reply-To: <20260922182125.11067-2-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DM4PR12MB8497:EE_
x-ms-office365-filtering-correlation-id: b7a2ce30-97ff-4da1-de9a-08df2029b758
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|11063799006|6133799003|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 s+aQPKXmqWNdEhbhJFQCCiL1zsFcy7VZ2i/mS+baS13OptXIprfKnBTgELUbxBJ6vul91wC14XWo8RUrsXJj3CKv8rAlOPhRzntxLnm6rmvFI30rRVqi19LuCkhyudjoG5IJ8SUoRYEWWYCrJtzUxSPVSJiPbyycX7raxOLixFo1hMv8D0lzKfvV5eIOgosfqxZEQEP4NTq3YLmvSUz4dbMWd9/3ZMqcxlSfgM21kNfqutAn0+U49dUKus6Lf/UnHB6MZ59hud5SuJYIi41r2cQPIPQE1gafmNjpRvpWHYaFB796gghcQvHJl+fhJPqSX8j82D0LrDsjrRs3bjAqACmF254BPbianQbJLQfLBnbivJuvHlNBCS/rSxLppr8bcA0PUnIoNpnzpMrf795cnC7zBzSO7CKtfAv/10FKECSj+zm7IbNt2b1JWLKNtC0B3R1A0766DuUleWDFSXr2An3nipwKEQv/G05s2NTmwDBJ3dVvCDmn6YXz8N7czMtVKROvUQnEFqwO00cFdFrGIpRhmYR+F9Y4Q4CT+FsVXbqxOcdpBNjAs/nVAZKNvPx4z0ippYEjUJlV9ETrdIgJl2qayJWcZX72HtuCUMWMkU8rdgID0gkck6un/SBm9zShkaYRAvNcrPazJFqRxEkhPOx258eGkk8iSG0adGmJCGTL+k6RnEmxhwh31pnCjGEka3RAUnLxwUf25V6Jpb/87LuNClIhDFY6XJ8T+cbbDe8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzAySld0RWVyUCtQajNoOTJ0T3JEdER1dEdkK0VSbDJuZXpQSnFUNTF0M2N0?=
 =?utf-8?B?Zkk2ZVZ0cUFvQ1NIMmt2NzBwRVJSQ2pPOUNyMlpEU1NoR2E4ditKK0JHVzhF?=
 =?utf-8?B?YzV3RmxaM1VFR21zWDl0SVJIbTZ0dWI3Tk15ankxbnVITFRtWU5MTjVuMDIv?=
 =?utf-8?B?eGg0K21pbjB5N21nMXdwYnJlRm5QWnBqbDRLYkNXcGFPZW5TWEM5Ujltc21x?=
 =?utf-8?B?dXR0OGFhVklmRDl6cFVPUWJpNm9iOU9wOTBBL3Rzb25nTXA2YVo1UjRmeUM4?=
 =?utf-8?B?WnhPdndzc1NaUktDT2UyeXUzK0N1dTF1amQvNEU3RDFEVlo5bDhocExoSlRz?=
 =?utf-8?B?ek1nQWhBV3Bjak1SM1ptLzVuU2F3eFUwY0psUFBTdVdBZXlHdU5qb1hVTkVn?=
 =?utf-8?B?RVIyRitBb090RXN2M2poL2l1VEg1OXpIQ3kxRVpMUzRPNFgyclloNFU3VTBB?=
 =?utf-8?B?Q1BmdUxabU45WmE1MWEyQVVYSGYrUkZNdHJZeXg4anFyMVhMTDVFS3Q2Vkk4?=
 =?utf-8?B?T1Q4WFZRYWFaV2l3NTZzbG8rZ1B0akIwSEJMeVNpWTZIN0wvQUdoNUFUTklC?=
 =?utf-8?B?cG1KNm9RbGtocGcxVHRQcWM1dVpMdDY5V2xUY0VzaGIzT21LTnc1OXFMckhC?=
 =?utf-8?B?NldENGszUmhiVEd0Z3pORlhJcHpjQm1RTUtOZXpVMTFnR05xVTJVZEttZ1Bx?=
 =?utf-8?B?bC8yL05Cc3NxY3N0LzFySjlGSkg1Z0lyZGRnanRhN1NxLzB2b0pPbXh6OGNB?=
 =?utf-8?B?OEJRZjhQK2VhdWE1WUlySmpqUUY3dWJYN3FZZi9mSXM5bW43MkU0SGxEdW8v?=
 =?utf-8?B?RHFzTG4zS1h0NU1qcm5rV0NsVFRJdU9zZERnQjBiQ09aRVMrL29Nd3hvY1Ba?=
 =?utf-8?B?am9OZE8xSkc2SzJwYnNwTU90ZjRoV2EvV09nMDB4QkowY3UxcDdUV0t1N3FW?=
 =?utf-8?B?QzhtaCtUTWNYTmxya1pRd2ZmWEkvcFVLZ09QTVo3ZlZjVUdhRTZZZTU3TzFj?=
 =?utf-8?B?VkwvdStBYTFtUERiRWhNUlBHVEhCZzQ5SFVUbjN2UDcyVzArSzRIaUgyK0tV?=
 =?utf-8?B?WVNreGlQNjhSWEMwZU04djcydmV1cFRQc3RCanF6SU5zSnB4a0huMVkwdDE3?=
 =?utf-8?B?cFluMElXcGdCUVdNRjJxWFpwNHVaVzhoSmRKalY3a2RLRGc2bkd0SVlGcEFN?=
 =?utf-8?B?THlDRDBSazBaVXFsZHpLY1h4bGR5cmZPcW1wVDFvZmN5YjQyMEZMdzJsMmdE?=
 =?utf-8?B?NVFGRlpFSDgyTkt2ZFRTUmI3TXlRUVluNCt3RjBVaEVjOXNFZDRCNjhJQUt0?=
 =?utf-8?B?UWp6L2Fzc3V0QjFxZTRZeiswZXQ2QWZ4bnRRZUEyaEs3UFp5ek5oVUE2TXpi?=
 =?utf-8?B?Y1dXSDZ5bFowQmloUHYzdkRUc2tQWWJjYytUVE14TnpmY3dZVm93UFV6N2xX?=
 =?utf-8?B?VmxwZzVseGl6OE5VbnBybXV6b1hFOXBPMk9rL1RlODFNVmk0SVhvbGNMNkcv?=
 =?utf-8?B?WjMyL1VLaW9rLzdFSklESFo3SkN5MmQ0MkpBekVveGZzVXJ2NnY3QWJmb0Yr?=
 =?utf-8?B?SldjU0ZWdnVkZUpGajF5aUlwWVlIZ1VWQ0ZYcWY5Y2lSMXB4YkpKLzAyOG5l?=
 =?utf-8?B?U2dpT3BmcDBoWlNXWlRlQTd1Ync0SlgrT3JTcXR5cTdnTFRHaGI4SXFJOEwz?=
 =?utf-8?B?enhYT1VxTnk2SWN2T1B1aXdDbGJpTVByN003U2E0cHZxVzFUajFsbXFZaFpz?=
 =?utf-8?B?OFMzRUwyNDlWbEJOM2dob3VldFJzbmxPWFhtTzdITFIyRGpDdjIvelI1Sndj?=
 =?utf-8?B?V1l1eXZ1WUMvMmxZWWx5UzRwUzlMeDN1emlLTFBxV0lST2JaQTRqbUNNVEsw?=
 =?utf-8?B?aVkxNmNiRmxBSGNpa01MWWVTRGc0VW0wU1NyaUIxUmxuU1B3bmtBUndlenpj?=
 =?utf-8?B?Vnh0c2d0dEZnbTR5bThaOEV5cnhXVkhEMEhtMUNONXZ1eFdpTWxtcUVaMVla?=
 =?utf-8?B?akU1a3dlcjlwclhZVThUM1RCME8zRlNLNFBhdnhldm5xaTJINHRka2ZkKzRq?=
 =?utf-8?B?aGt1L2RLREl0bEUxUE8xbGhTZWlrVmJwcWVReFNqZHp3Vm5HY1dYampyQ2sw?=
 =?utf-8?B?dkVnMW94YVRjSkhWZkxyOW9CMzl0Rk5GOU9nak50MGhISW42MjFWSnJ2SnZ3?=
 =?utf-8?B?NUpMUEF6QVU2T3poOHJMei95K1FocXhFOWViL3JyU2VkUW80a2d2ZlZJUVlP?=
 =?utf-8?B?amVKOHBoYXg4K0g0L00xMlhiQ2tnQi9OekNTd3FkL1pmdVJiT0FmaHo1L29t?=
 =?utf-8?B?dDk3NThZY0h6cTlHWmxhTTg2amp4UmphUWs2US9wQllFWEthYnhXQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C986D1115B7133428332A69B5BDF8EE8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	O7djOOagAFYMz8kKSZcZcJlu+YUGy1mLYgugxHsO+y1Xjylc8BpF2pN/L0f2oc/aU7kJ6mmZvQ6mStLx1YRnuRsTBRe7pQGEkIzs5vGL7pPN/gNpS9e/2v7Ba900M9a96/vc38NJz05gThpscceUxWrPSCWwD7FC9ol22tU2QZ5PYFkvUbTlfEE9Q5yx+8GIeqSBAuPphO2IN6RD6ntYWuwtSvzuuyRZyWr76PmaZwcyhi4p2qvVPmNbdDZfisLE+CkkSg7bTorfbCkdYYlOzhO2HaYJGlIGy/W85Hfa0kE4vmMWTlg69WsAQthE2WmRXJw7rExPiW2qoSH/sOLHpg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3YG86BPec8WJSWZ9jasFLozZO/yF4hObr8LonKNmOUgDONoDHi0pOuVcWFbE7me2oabvU8B4/v+hLorTOKXNZdP13S7ZkdJ4A5YGxzE1Kn48Ej1K6QAQoxqBTqrsDX2YP462dPaqeb1yFY72CiCb4DbCH3K9vLgOSJlLk5EsICbvSzi50ESAAvG06CtDPy7qQAMh13FFmBvQcWGy8x1nZlAr6OATnHaCJiku+uzaaksdneqh94U6lo9HNvpGIFtfjU/hcuoz5vzPTlARDXPrexQb9jIHCkw5KtTrDewaPGiV1plzmDwXGT+DoeTrEqgnsquIXNgPBXMPSfSYqoWpCPRF92owbsUUMuNMeBBceSZpr5mPcJsktqyf+ld+0HiWVT2UZqT+e4YslU3DuJ4X7ihOZ3yQBLreesrkV1T+N0y+dbDPu+v9tM0D9Y8u21NlUYWt6QPU3PwqJM0CMwLZXoRvPZlg6SD5RJ/Sx409IxAA+BOeCOUHnsUIHI2U3xzv9ZPdvp0CHGTfYgHKNqKtbtyltRHVrL1a81ntn8FAVYinWbEAB1XaliXTe7wBgiIdtvQL7LZ3zq5sQkDxi6XRZHHXD+VAl0Nf/zXBFVC8vJRXgv3UpmseS8ypVJI6xB/SzeYh+eA2FqWe0l8/JaPx+g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a2ce30-97ff-4da1-de9a-08df2029b758
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 02:06:05.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kea7wnvRhtduvDiQxV6MHFj3C6c1L9qUKazcyeUhN1BCtZySYHOQObhFhvT/efVx8bqc+CwMFKLweq5K7yToZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497
X-Authority-Analysis: v=2.4 cv=T5oZ3PKQ c=1 sm=1 tr=0 ts=6abf119b cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=jIQo8A4GAAAA:8 a=LCXRTY2cuyGu7DlhGkIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAwOCBTYWx0ZWRfX+QDWURrSeu/h
 Ib8LQACW4hF6SJPQobg/u9jTHg2BTGyxxc09+L2WaAW91F2JQ+e+PfcebdIpl8zDXs2iIfs4pmI
 1csX5WPnrrtp2J3ap0Vq6aU2eBE355U=
X-Proofpoint-GUID: gJKlDXWLms8IQrGigo4fdl-Qzvq0gwCP
X-Proofpoint-ORIG-GUID: gJKlDXWLms8IQrGigo4fdl-Qzvq0gwCP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAwOCBTYWx0ZWRfX51X46jSBpPh+
 4by8Nxx8DMJ0uPPkcvPv5J5l2NVBIhXWm3bWM+mpIQH2iuIcpdqyyDEHkFW6jdWrJf5LK4+SU1S
 tvOhRaVS8SynpYA0ZySiVW8yqWUsfNae5rN8dMOjL15Tq6RwG6t7FEkppCe1d5l+w3i4nDlCZ4D
 2U6To1zrXOeFXlLK8koKNDTRAQzeI93ZvCKNTX8O1c5W/rye4kkU+jhKOnRsVZ2R7VPlE5+g+0m
 RpGggvjk7Sbay+x4BpDbu1Ot03bnVdFSOgkLntmaL8Vca/Husm47+D9FmmkfeoRRPkpWBs8QKtW
 3hnT74AdqZ2f30+c6DHQRGjLmfKft0r+3euxx/YOIOjI3bEjL2v6g36B+xe1GulNnOe2cQkUtPR
 7s9Xz8rhBOVpKfcbpGp3ylwNflK27tnoDJiATeV+sKugQKqgFEKmLPXoSwQUfPaLj92urcUsasB
 qExUkWzR0g44Dm5d+Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_05,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2610020008

T24gVHVlLCBTZXAgMjIsIDIwMjYsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IFN5c3Rl
bSBzdXNwZW5kIGFuZCByZXN1bWUgZXJyb3IgcGF0aHMgZG8gbm90IGhhbmRsZSBQSFkgYW5kIGNs
b2NrDQo+IHJlc291cmNlcyBjb3JyZWN0bHkuIFN1c3BlbmQgY2FsbHMgcGh5X2V4aXQoKSB3aXRo
b3V0IGZpcnN0IHBvd2VyaW5nDQo+IG9mZiB0aGUgUEhZIGFuZCBpZ25vcmVzIGZhaWx1cmVzLCB3
aGlsZSByZXN1bWUgY2FuIGxlYXZlIGNsb2Nrcw0KPiBlbmFibGVkIGlmIFBIWSByZWluaXRpYWxp
emF0aW9uIGZhaWxzLg0KPiANCj4gUHJvcGFnYXRlIGVycm9ycyB0byB0aGUgUE0gY29yZSBhbmQg
dW53aW5kIHJlc291cmNlcyB0byBlbnN1cmUgYQ0KPiBjb25zaXN0ZW50IHN0YXRlIG9uIHN1c3Bl
bmQgYW5kIHJlc3VtZSBmYWlsdXJlcy4NCj4gDQo+IEZpeGVzOiBkNmVkY2RjMWVmMDYgKCJ1c2I6
IGR3YzM6IHhpbGlueDogZml4IHVzYjMgbm9uLXdha2V1cCBzb3VyY2UgcmVzdW1lIGZhaWx1cmUi
KQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNs
YXVkZS1vcHVzLTUNCj4gU2lnbmVkLW9mZi1ieTogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5
LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBTcGxp
dCBvdXQgb2YgdGhlIGNvbWJpbmVkIGZpdmUgcGF0Y2ggc2VyaWVzIHNvIHRoZSBmaXhlcyBjYW4g
YmUgc2VudA0KPiAgIGFuZCBiYWNrcG9ydGVkIG9uIHRoZWlyIG93biwgcGVyIHJldmlldyBmZWVk
YmFjay4NCj4gLSBSZW9yZGVyZWQgYWhlYWQgb2YgdGhlIHBsYXRmb3JtLWRhdGEgY2xlYW51cHMu
DQo+IC0gTG9nIGEgZmFpbHVyZSBvZiB0aGUgcGh5X3Bvd2VyX29uKCkgcm9sbGJhY2suICBwaHlf
ZXhpdCgpIGxlYXZlcw0KPiAgIGluaXRfY291bnQgdW50b3VjaGVkIHdoZW4gaXQgZmFpbHMsIHNv
IGlmIHRoZSByb2xsYmFjayBhbHNvIGZhaWxzIHRoZQ0KPiAgIFBIWSBpcyBsZWZ0IHdpdGggcG93
ZXJfY291bnQgYW5kIGluaXRfY291bnQgb3V0IG9mIHN0ZXA7IHRoYXQgaXMgbm93DQo+ICAgYXQg
bGVhc3QgdmlzaWJsZSBpbiB0aGUgbG9nLg0KPiAtIEFkZGVkIENjOiBzdGFibGUuDQo+IA0KPiAg
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysr
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gaW5kZXggYjgzMjUwNWUxYjA0Li44YzYzZTAy
NTc1ZjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gQEAgLTM4MywxMyArMzgzLDI2
IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgZHdjM194bG54X3J1bnRpbWVfaWRsZShzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ICBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGR3YzNfeGxueF9z
dXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjM194bG54ICpw
cml2X2RhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwlpbnQgcmV0Ow0KPiAgDQo+IC0J
cGh5X2V4aXQocHJpdl9kYXRhLT51c2IzX3BoeSk7DQo+ICsJcmV0ID0gcGh5X3Bvd2VyX29mZihw
cml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsN
Cj4gKw0KPiArCXJldCA9IHBoeV9leGl0KHByaXZfZGF0YS0+dXNiM19waHkpOw0KPiArCWlmIChy
ZXQgPCAwKQ0KPiArCQlnb3RvIGVycl9waHlfcG93ZXJfb247DQo+ICANCj4gIAkvKiBEaXNhYmxl
IHRoZSBjbG9ja3MgKi8NCj4gIAljbGtfYnVsa19kaXNhYmxlKHByaXZfZGF0YS0+bnVtX2Nsb2Nr
cywgcHJpdl9kYXRhLT5jbGtzKTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiArDQo+ICtlcnJfcGh5
X3Bvd2VyX29uOg0KPiArCWlmIChwaHlfcG93ZXJfb24ocHJpdl9kYXRhLT51c2IzX3BoeSkpDQo+
ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHJlc3RvcmUgUEhZIHBvd2VyIGFmdGVyIHN1c3Bl
bmQgZXJyb3JcbiIpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiAgc3RhdGlj
IGludCBfX21heWJlX3VudXNlZCBkd2MzX3hsbnhfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gQEAgLTQwMywxNSArNDE2LDIwIEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgZHdjM194
bG54X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICANCj4gIAlyZXQgPSBwaHlfaW5pdChw
cml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gIAlpZiAocmV0IDwgMCkNCj4gLQkJcmV0dXJuIHJldDsN
Cj4gKwkJZ290byBlcnJfY2xrX2Rpc2FibGU7DQo+ICANCj4gIAlyZXQgPSBwaHlfcG93ZXJfb24o
cHJpdl9kYXRhLT51c2IzX3BoeSk7DQo+ICAJaWYgKHJldCA8IDApIHsNCj4gIAkJcGh5X2V4aXQo
cHJpdl9kYXRhLT51c2IzX3BoeSk7DQo+IC0JCXJldHVybiByZXQ7DQo+ICsJCWdvdG8gZXJyX2Ns
a19kaXNhYmxlOw0KPiAgCX0NCj4gIA0KPiAgCXJldHVybiAwOw0KPiArDQo+ICtlcnJfY2xrX2Rp
c2FibGU6DQo+ICsJY2xrX2J1bGtfZGlzYWJsZShwcml2X2RhdGEtPm51bV9jbG9ja3MsIHByaXZf
ZGF0YS0+Y2xrcyk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IGRldl9wbV9vcHMgZHdjM194bG54X2Rldl9wbV9vcHMgPSB7DQo+IC0tIA0K
PiAyLjQzLjANCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
