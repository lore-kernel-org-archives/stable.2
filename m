Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228A36DA1D;
	Fri,  4 Sep 2026 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487038; cv=fail; b=hkkk+o0zwFn7UQu3QU4GvnSgSf/eW1FWAEmXBPK9DjREdhQMhOp9Suh8Puyw2hEei0JAwVGs4CVU5VqmdHy2WBoLUkRF7WMoIHxFfUCnlOSIfq/7g7GDK1eb9VLj5MAvAvg4ia3j0K8NaaYbMKEqmH72k14Qqv/+PJFANkmWW+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487038; c=relaxed/simple;
	bh=/fYy6uSfAJNMZ67hsndfFcDNRprhbNS1f5BnGo5NTeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YnM4tKSmb+J4WncmV9W6gjUkg11qfOhGIVkbl2CV9StT+I0fpMMsO2QwRvuVf0X1Au8X7NiYsepKyoM+hFz+nt5NMVlzHOfeziAUZZpw1uDIFS8WirO/90W1FqMM/xo/9QkQOZ6D88vNNqYXVkTNskFqLSLLgVTmFTMv/YK093s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jb0o9ul0; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ISX+yns2; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=h178bM2R reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jb0o9ul0";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ISX+yns2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="h178bM2R"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683Nes9k2396340;
	Thu, 3 Sep 2026 18:57:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=/fYy6uSfAJNMZ67hsndfFcDNRprhbNS1f5BnGo5NTeQ=; b=
	jb0o9ul0YOOsoFg8IJMltfLqppiZTDfAQfYN7xsglJRebAa3dWAhh0DnjmTre6lK
	chiNl2Yy1rDkS3uyYxI1yNvaw4eUiwuMsZ0AIIuXPYw3zy58EeooflmniRIoV70E
	lnw1IFydo7Cu2B55qmpbqyAZhHZ1Z2ettKyY47nnD24fkTxryEEGrdl3BEs2OVWG
	PVVQOGrheGAgkPOeDoV8ArJbzfpQxBMmqOqTczPK/4nqCF1myxFEFGm/QfdNQOfO
	udqYI5BkV2h3zAf9C8bUB/iM6mSZLx1V7igYlaY628aHeubCuL95Nvjvyn7N6ms1
	VDaeFbsJAOdfQHyUl87uLg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4gf7ctqk06-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 18:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1788487025; bh=/fYy6uSfAJNMZ67hsndfFcDNRprhbNS1f5BnGo5NTeQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ISX+yns2Pj5c0mAXkNjUCu2SrVEfp2IVenLO9CTgl30J/lwWXUAjExp8ycnWuN1tR
	 24ievTlWHv+a6jvHdfBkncZs7ZNCZLGv5VZyr15WTBEEEg9haB+GlFFBmuqPv6jmv/
	 gRnkJdXVF8PjRH//+Aurmka4QgGgdKrrhY2KGSM1C17njkpY+cMllNvoPadNaMexQd
	 pKDVtDTLJbBYf0VX4mlT8utaDqr7MVjpoJblp+oM6nopp6DsXh8yIt2yAsaZ1VB7L8
	 FpQxPcO1r/tiJnLF6vqsAGoBrXhlSqRdNaJNu/a0qZejnRQUJyrH5Bz0BVy9zz/VgU
	 2W9aIPCzJClqQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BED99401E1;
	Fri,  4 Sep 2026 01:57:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 586F8A0070;
	Fri,  4 Sep 2026 01:57:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=h178bM2R;
	dkim-atps=neutral
Received: from DM2PR04CU003.outbound.protection.outlook.com (mail-dm2pr04cu00304.outbound.protection.outlook.com [40.93.13.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3B6C04041B;
	Fri,  4 Sep 2026 01:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxHpIneDyoRtLkSxjprf0PAWn+hyZMqIL7ycgrXx2JjUihY8dmH3p5QGfJ3rnwskwozk6D6v6gXw9NybSDscsGaHLRs8Gr85b+FfatzEAtvmPyCsksUqTjdpJkWTrxaUNiazWZ08kNk7cCuyaj2LUzXtg8kOX4nOosTlSLc7UZybPaw6YnGa5TlXntD0CeQ0Xwf2Zsilw+Hv+pVlUqHYkeBjj9O82CQ85YIf24ycPPdsc28NarbUoDi8krWjHuYe0ef5w9iPJRVqJ+NocFci+oiKZ1f9QAoz5aDxr67MFzv3Z7MgQrThuGftU05Cki7WfJRLcjqf2FKph1zgduS5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fYy6uSfAJNMZ67hsndfFcDNRprhbNS1f5BnGo5NTeQ=;
 b=xaHxja02aw3HP+ujCMRR7ufJoltqcbWHaHchasmBmWeLjYeXJh0jJMQrtEYtohbZmYOP/al2AZFgA8hq7Y+MLP6WNP21nIiYcRcex9Bu8ISJmNExYK4XPl4noEoaqXPHOB2hfGFFSoXKwbTrgomGwu/RFl3v4EIq/ybjeqDM3detxaNYTX0DXX8D11JJCB7zCpIt+3mOP/6fbUwIslYC6+Wxhb8094+O7NorTUfPi1+6RcaqRx38SdpTsU9T25TY2pXceInQz+A9OdQ0wwp7N8inIZo72LFyevNmwKbV6WPhOjRdsnqVznvYcV4kBzYwe6HiEZLTMiS95QD7lXKDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fYy6uSfAJNMZ67hsndfFcDNRprhbNS1f5BnGo5NTeQ=;
 b=h178bM2RBku0qCZNYchwElqJ26j8aGsxkYfkTzhqk/VpH0lezfS8v3pqyc0hY9gWW6w6nkzkRK143hnSEDl4lAvwdw/93+6Stfuz3II4c7OnUEvL0vniv1c4l5RDhqiph5w1gy0saOG5sYZr/tXUBtEo1yX6pzqskYXkM56GhwM=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 01:56:58 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 01:56:58 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Liu Jiazi <jiazi.liu1984@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Jiazi Liu <liujiazi@amazon.com>
Subject: Re: [PATCH v2 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Thread-Topic: [PATCH v2 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Thread-Index: AQHdKjOlTDVfy6c9a0+Wp+ReE0f4oray17GAgAB4yICAAPaJAIAGh9CAgAL+GYA=
Date: Fri, 4 Sep 2026 01:56:58 +0000
Message-ID: <apokcUrFnd0kwSIx@vbox>
References: <20260727092258.1121-1-liujiazi@amazon.com>
 <20260812082127.79610-1-liujiazi@amazon.com> <apDmBeD8UQIvtfR4@vbox>
 <CAAcjFgh-f2=cK09BLGN-kPVu2usjN7pWOxCWb31hSePB2nLVEA@mail.gmail.com>
 <apIe9XE5_lFJWyg_@vbox>
 <CAAcjFgiCF0tC-REwzHmBTKew9LT9gmWsF==LUZ-htSTD2+s7+Q@mail.gmail.com>
In-Reply-To:
 <CAAcjFgiCF0tC-REwzHmBTKew9LT9gmWsF==LUZ-htSTD2+s7+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|PH7PR12MB5901:EE_
x-ms-office365-filtering-correlation-id: e1f9d304-c2ff-4f59-c53b-08df0a27cdc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|4143699003|6133799003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 InqtCf0T5wADx6uilP9UVitn2iRbG7TGROjlsGNftoxRpD5rHUhLZIFWd92BYFXNvV817UaIt5rabOuZDIVIwSj4CkFViOzrOe2cN/LgkZ7qRqGUPiDw8y0wUGdsnyHi+wtji4RGt0xLTl5Tq1zNNYrXmq5TBSlZD3x57A2WPZUMRSyqxfRpD3A/kGy4/78o0ZcVzhR0I27UoXz47M+DNjVKzoKj+21CGbNUx9aOX9/W0Ndmg04dTknnC8I54+G+HIic1YbtCVQZAxSkJTE2GtiQZAJwFLBwtECQIwU26tKsq892PNzxxf59ncUIB9YWYWww4AJft1Hf5NGJUVZrCWrp6WyEfo0C+jqVGmr+cDuazcdEd0FzKnTAisLDTk6JyLIWImdwYAbxshrYDcCwucPIRXRthRlqdozf9/T3ALR2+mVTdo2OwJC2OL37P4XjXNSOAjt9CUn7DXDTuEpTg+16+VSQeTP90llPJxwapreasPTXE03JXt1c6FluYSTKr77ZB2EI3qFaQaK+sxl77Vy2IQRGx/x2/T/VCYcfU8GpIIs/wL7eTQo+v3Y63Y2EXLvX7eOBBBRie2caj99FVpaorpRpDu10d4sAmrzi59EAqLF5DSI5njrfYMmA8uDweqjp14237O/scIQ3f0a+yPWtutqHh701bOkBGBMVQZGC3nKv56oMvK7So1xp/A4wYQbLIFgWkovH2ioxFVw915OpDaEiMQskYDTBtYXaBYw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mko4WnhvWUZCT3gybE1ReFc0RzFZY2ZycGZaRTdNY0s1eEkwenJjNkMvMCt1?=
 =?utf-8?B?YTZaTzVreWpkTlJtNTFnaEdaRnR6c1B6bjIydzhIempTNEJEdFgrNithSzk4?=
 =?utf-8?B?WTdyMTBkbUprakErUWV1Q0F2UXByNkF5TGk1eHBNY1A4M1ZqaG9MUDNJeXpt?=
 =?utf-8?B?RDZaZ0VNajlFL2U2T1Y4UHRNVUFRRDJRak1yM2luemF6SXJyY0crY1lYN0pL?=
 =?utf-8?B?RmFJa0tBekIvOEJkQkdQb3JnZERBUzRrVnBKdjNxcnJ6Vlp6RitjK3doNzh2?=
 =?utf-8?B?NWgwWWpjMTZFMDMxMm96SUUxdERFc1UwVmRzZkU5UWtlN2xsTE15Z0k0R2pD?=
 =?utf-8?B?bXdDS1BVbENtbXFvSTRaUlE3akc3T05FSW1qQmZCeTRnditrQk1SN3AzVytm?=
 =?utf-8?B?VkVXU0xNeFQxUms1VVpIbFZsZTdkUU5zeFZkemVWdDhrMmsyTjl5N3lFMEFD?=
 =?utf-8?B?aWJjSGRrN2xUVzNFSkxEbCs0VkZJR1ZnQTBpcEl3UmRHTWdndXZrQWJzY1Va?=
 =?utf-8?B?dDVlUkNMSEV0OHVJYWVhWWV6ZHNEbFcyTmt5aXVzMDhUMEU2MTZHL0V4VUo0?=
 =?utf-8?B?bGwzRnlHTmxQZUZCM2RnbXczM2oxRGJkTnZiQXhZNWlXQ0YrZjhhQTFpOE91?=
 =?utf-8?B?SWEwUCtoMUJ1UXBBdGp6UVlQNlI4Z0pzNXNkQm1SeWhzdUYrcDE2ZlAycjBp?=
 =?utf-8?B?U0xRQk9BWEhoaVNqVzlIY3NTcWpUU1FlSjdQVHdpMSszUW5ndHdab2UxMmRt?=
 =?utf-8?B?MFN0MXBQa21iZ1IvQnZER0dXOURMY3JJZHJnclpSeGg2ZzQreWtqVUJLMmo5?=
 =?utf-8?B?S3JEbzMyVFhHVDBzWWo1ZlkvMjBFMkpneXZiUmxOUHcyTGF5T1MrM1UzcnVa?=
 =?utf-8?B?N1k3THVnTkRlL0wxdWhCdkovZURvQkdVSTBENlB6V2hSN1VHdFVLQXJGZGJq?=
 =?utf-8?B?SnoyT3BQdGlvMjIxK3NXMnZXMjh4R0tPYnJ5cEVNbm1vRWh1bXZtV0NPdHdu?=
 =?utf-8?B?WlYwV0o2b0dlYWZXOEd6Sk1MTTVxQkNrcTBWYUtNUy9iRERzRkVGZFZmcmpx?=
 =?utf-8?B?OUhsNXhuRGViNjBYeks0UlpVcUxQRmNiNDZxV1Baa0tYa2JCOXkranVabnBx?=
 =?utf-8?B?Qkcvbkx2U3NPQTJGL21xUFlsdCtRdTY0SldwcmsvTkVUZWFQK21hY21yUzkx?=
 =?utf-8?B?L3RhazAzMER5OWN5UVhDNHYwMWY1NWZWakI4ZXdYN1dyNjNNNTJLcjJaTjkw?=
 =?utf-8?B?cmFOT2YrTWxQV3N1SFA2TGRzVzltdFpRRDVkaEZrY1U4UDg3WVJ0TUE1b05E?=
 =?utf-8?B?QzZtcmFIUDZSTXZvT0RaQnpsQmRuTlR2VFkrNU5GNjFEdGgyWDdXNFdudTdG?=
 =?utf-8?B?QnZjRWtyb3FtZXJjalZ5RzZGUGUvZkllZklEeWZBYXNmSWQ4R1JGM2h6K1Fn?=
 =?utf-8?B?aTFNSHRzRzJUOU9iR25aUVZtNm1kTHNhTzNEMDlLeDRUa2ZjWGl0NzQ3TGhx?=
 =?utf-8?B?eGs4TEN1eUVjeEMrak1PaVFySncwNWdjMHc1Sm5LMThOMUhyMVRHYXFDK0Nz?=
 =?utf-8?B?VFlHcVVhWURiYkltS1NLeWJNUGw4SXVYa1FZOFNBM3cxODV4VlpLUjVGTVlM?=
 =?utf-8?B?QnlGTjI4dU40bXNpaVRKS3VDN20ydnJUQmtkR1J0SDluY2ROM1dKeVAwMFlF?=
 =?utf-8?B?MS9MWEQxNlhDcHU3cTl2c0JJeCtjdVVzSkkxTTNLd1NuT2FyZVY0cjBvUlBt?=
 =?utf-8?B?cU9tYy93c3lTU0RhaTlKMzQ1eGFJMGtwdHNSQ0dzTUpPMUNzaGQraW15S1Mx?=
 =?utf-8?B?bC9jYlByQ0doblNTUTRhVUE2UWxHYXNOR1ZDR0pSL25KUC9SSmN4U1VKaW5B?=
 =?utf-8?B?UmY1bjBtZ25RME9CRHNMRXRDZ3RFR2l6V2p4UHN1QVFLeHI3RFhTVm1tUDZX?=
 =?utf-8?B?S3RNV0VLbUVQU1BGRFBSdUxYM2kyd1VSWUJGTDJkWWhWZjB3UW90Nk5RWUtn?=
 =?utf-8?B?TVM4LzJnMkJweWNaa2ZpVi8ya1RoNnUwNXo3SndyZ2VtNjRCNGtLc3FMSnBS?=
 =?utf-8?B?OFFoS2NUa2VIRW5ycjY2djFSc2RUUmdBQjlPa01vSjQzRzFVam1jN3JPZUNS?=
 =?utf-8?B?UDlrd2VOVlJ4WG0zKzkweFNpcTR6VkNGUWtCd25OcUZKcWdjWmRYb1FuZ0JK?=
 =?utf-8?B?WjdNQ2R3dG5FZjVkNHNKLytId2ZDNHp3WlovUFNEYWloK1NyTldGQmpPT3J2?=
 =?utf-8?B?VW5OQTNndGloZFIzdEpucWYzYU56VjU0U0Vpa0QzdzJSekNlSDVjVmtTWDh2?=
 =?utf-8?B?dXEzaDJCSnhERjlNZ25vWHQvOW42WXpzZStGWHlrZDkrQnRtbTFMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67E44ED9F7E8844BBBEDBCB72EB848CB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SvffSVn3hJVYRtRV5ez8jmVxbFArY2IlMn7dbXbHPT8buLfuz2049XuNymT/eHwduJscXaMykwRhf4RSLw4mTdBa9JhCFAtNw97IIjVWjHfrL0Ky8yvkTs2kid9rrxG3qLDZOKYMFoUxYrphxWgqCPKETbV/2JQ0cEYs08gDsgt2BEW694XfxT+b3LPYRS4onP+9+tPGW44/sn4iwlW/kH6vLhRtebmCp2rpKP7kkGkgUZfUjylKZ3GwdY5HBm8Uq6CA4IJRPe0+6Gw7XecUBE+ttSvbkBeW40bN+lPhfa3qus3KCkhdPwSr6loRk7TH2JPhjiPJGM7NZXTn3NRCDA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Clmv17J6ypswU8vd5zgIgNo+N4eQl2wpwG9KcANX9nWA+ljt/FCUs3vTZ4Dnnt7pRIyQwTo7fyomGaUwTOO//0NZ+lUtwuRvoLOhXBO1TQR//eM4FQU/c0Wb4aH3udQcwH4elpBbvqh2Eam3jCMnxLBRk0wrnDdzhuLFDRWh0kdVfiCsHZeRuAJx5Qj413JdUElGx3yzfQNnjHB3XF8F/tGgrdq/w+1oC/UtvyPiQzX8UGyUSFTpHuY33R5mDYkACB/bnfYkCwZHgIDjTkyAtCQx72zvUV3QXcKG0Uc8EKKt/3cYvbYUfLk7l5GnsfyQ15mJdY7QyDcG4TRTFmSGGRxMOE2e5d4BjKczw/dVySmwvQvU7NaT9oShC4n587tyGJKLGbRHX4IpAA90Kh9B42112noYpIxUsGLx36uM+33Vz2qvsD0g/torhsJYDSN1j+c0aFucxNFAaJzHAqZmB3SHlS5zHPDupKdki3IItazdWgUyOqzgDJUI0kTt5bGRjj1GpDstZf1lkfJZb0lkAZEpoHbWB4baKtSj+VueToSuATA28xGbvQipaf9I1vtfD10os5B4qUmUvcXFHgvWU909LpnLEoz8FEOBNno5xu1yguCpMB8/Xfg2MzYQG6NV1rpVF+daxp9SgR7A0ZK6iw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f9d304-c2ff-4f59-c53b-08df0a27cdc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 01:56:58.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JS0XWl03p2DyUMW8tI3k8KfRWGoYoD5eyGg6qH1S++5UH7aCkG0Rgp6wOSRvY1JRKIJcBNQinYwM74J/WHkPMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAxNSBTYWx0ZWRfXx8UHe+tbRP+Y
 c+rv2SiTfJb7SvIcsFePuYog/oiiEPP3u8D3MQMpq7es80xKwriXPtjDoNkfoLzFCswf9X0qzLs
 bBmAPFzJ4h5YAjaMygNMerKwq2SefAQrJp8+uAWbbjGUKinWYRMxIB12n2mwetFE/7pTQxdjquS
 Wj1x5nY8lNRdeFWyKvuGsky4I1bbm9hXiKtAhyha6eeuc5KM6vJt/p5pbBZkzwYPlCdyURVfpTV
 YGcbK7WoOF2/OeryHT4jfuQxlz47h1QxuxyNtHFNzmN7ouercD9oXW8WSih0UA8fKuCYAIxcBim
 89dcmMLrylyf+zKrHdrxbRlAf0aNmhmRZkkax2g0iN8StGDp0ysIfgFfMneAZAHsJYoxqZZGbO+
 ODjT5LVtTq/OoSpOlWQp7V5uquN6icJHZgKqwel3oiJy+ZnGhI+uM+dovyWjyPWEFCLpzMUE7wf
 tY04FWXzY8FZQWo7UdQ==
X-Proofpoint-GUID: eSu2Xna1B2Z-MvSwm3xoeaL0fBhs6w0J
X-Proofpoint-ORIG-GUID: eSu2Xna1B2Z-MvSwm3xoeaL0fBhs6w0J
X-Authority-Analysis: v=2.4 cv=PY3PQChd c=1 sm=1 tr=0 ts=6a9a2572 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=2h4P6vbiQFEtTV5y_IMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAxNSBTYWx0ZWRfX4cF/pOr4XdbM
 jJmxB62kP+j17krKsHl3uv/l6G2VGTH0z/zb945RQ32nHllGZwLpHS0sPysLV5KuOPpOEF4SaFI
 QTehrUIZ99N8gkzy52Iw4hWrequnnfw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609040015

T24gV2VkLCBTZXAgMDIsIDIwMjYsIExpdSBKaWF6aSB3cm90ZToNCj4gSGkgQFRoaW5oIE5ndXll
bg0KPiANCj4gVGVzdGVkIG9uIG91ciBkZXZpY2Ugd2l0aCB0aGUgcGF0Y2ggeW91IHByb3ZpZGVk
Lg0KPiBUcmlnZ2VyIHRoZSBlcnJvciBieSB3cml0aW5nIGEgYm9ndXMgdmFsdWUgdG8gR0VWTlRD
T1VOVCBhbmQgdGhlDQo+IGNvbnRyb2xsZXIgcmVjb3ZlcnMgc3VjY2Vzc2Z1bGx5DQo+IFVTQiBy
ZS1lbnVtcmF0ZXMgYW5kIEFEQiBjb21lcyBiYWNrLiBObyBrZXJuZWwgcGFuaWMgb2JzZXJ2ZWQu
DQo+IA0KPiB1YXJ0IHByaW50Og0KPiBbIDE4OTIuNzgxMjYxXVsgICAgQzBdIGR3YzMgYjE4MDAw
MDAudXNiOiBpbnZhbGlkIGNvdW50KDYxNDM2KSA+DQo+IGV2dC0+bGVuZ3RoKDQwOTYpDQo+IFsg
MTg5Mi44MzQzNDFdWyBUNjc5M10gZHdjMyBiMTgwMDAwMC51c2I6IHJlcXVlc3QgZmZmZmZmODE0
NzU4NTZjMCB3YXMNCj4gbm90IHF1ZXVlZCB0byBlcDBvdXQNCj4gWyAxODk1LjA0Mjc1Ml1bIFQ5
MTE0XSBmZnNfZGF0YV9wdXQoKTogZnJlZWluZw0KPiBbIDE4OTYuMjA2NjY5XVsgVDkxNDJdIHJl
YWQgZGVzY3JpcHRvcnMNCj4gWyAxODk2LjIwNzQ2NV1bIFQ5MTQyXSBiY2RWZXJzaW9uIG11c3Qg
YmUgMHgwMTAwLCBzdG9yZWQgaW4gTGl0dGxlDQo+IEVuZGlhbiBvcmRlci4gVXNlcnNwYWNlIGRy
aXZlciBzaG91bGQgYmUNCj4gZml4ZWQsIGFjY2VwdGluZyAweDAwMDEgZm9yIGNvbXBhdGliaWxp
dHkuDQo+IFsgMTg5Ni4yMDk2MzhdWyBUOTE0Ml0gYmNkVmVyc2lvbiBtdXN0IGJlIDB4MDEwMCwg
c3RvcmVkIGluIExpdHRsZQ0KPiBFbmRpYW4gb3JkZXIuIFVzZXJzcGFjZSBkcml2ZXIgc2hvdWxk
IGJlDQo+IGZpeGVkLCBhY2NlcHRpbmcgMHgwMDAxIGZvciBjb21wYXRpYmlsaXR5Lg0KPiBbIDE4
OTYuMjExNzU0XVsgVDkxNDJdIHJlYWQgc3RyaW5ncw0KPiBbIDE4OTcuMjQ0MTMwXVsgVDkxMjNd
IEZGUyBlbmRwb2ludHMgcmVhZHksIHByb2NlZWRpbmcgd2l0aCBVREMgYmluZA0KPiBbIDE4OTcu
MjU4NDkzXVsgVDkxMjNdIGJjZFZlcnNpb24gbXVzdCBiZSAweDAxMDAsIHN0b3JlZCBpbiBMaXR0
bGUNCj4gRW5kaWFuIG9yZGVyLiBVc2Vyc3BhY2UgZHJpdmVyIHNob3VsZCBiZQ0KPiBmaXhlZCwg
YWNjZXB0aW5nIDB4MDAwMSBmb3IgY29tcGF0aWJpbGl0eS4NCj4gWyAxODk3LjI2MDk3MF1bIFQ5
MTIzXSBiY2RWZXJzaW9uIG11c3QgYmUgMHgwMTAwLCBzdG9yZWQgaW4gTGl0dGxlDQo+IEVuZGlh
biBvcmRlci4gVXNlcnNwYWNlIGRyaXZlciBzaG91bGQgYmUNCj4gZml4ZWQsIGFjY2VwdGluZyAw
eDAwMDEgZm9yIGNvbXBhdGliaWxpdHkuDQo+IA0KDQpUaGFua3MgZm9yIHRlc3RpbmcgYW5kIGZv
ciB2ZXJpZnlpbmcgdGhlIGZpeC4NCg0KSWYgdGhlcmUgYXJlIG5vIHJlbWFpbmluZyBjb25jZXJu
cywgY291bGQgeW91IHBsZWFzZSBzdWJtaXQgdGhlIHBhdGNoPw0KT3RoZXJ3aXNlLCBsZXQgbWUg
a25vdyBpZiB5b3Ugbm90aWNlIGFueXRoaW5nIGVsc2UgdGhhdCBuZWVkcyB0byBiZQ0KYWRkcmVz
c2VkLg0KDQpUaGFua3MsDQpUaGluaA==
