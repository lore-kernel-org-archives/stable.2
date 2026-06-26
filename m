Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90311684BE;
	Fri, 26 Jun 2026 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=44.246.1.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505605; cv=fail; b=T3O3PF/jJ+5IjIXLo01IWDscIKks91LX7jOpJWOHszQeTwXAJ9h6FYLDI+xYKxglv20rDxoFmGVnzyriRQaruzxfM111hdD+zxBcCwDd6KH/AjG+WMF+7/X+dDz9Tdj4EN7B/bAxPae4MDclHYX9MeOwmh6z5rwffuo0Xiq9eqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505605; c=relaxed/simple;
	bh=OeLpf3owf6b4m7XTu4mG5NvDNawAKzNCGvWk82r8zIA=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OkRT6UEDuO9mMH3wvq1N7GpfXUYwuIQ6kpV/bIdqWkCg7LfFyuBG46qciylGQIag6bKYs6EwheMt2qhQWLXhCBBg+riE05xMIC/mUs5esBF6e0KHh76eICg7pZ8hMk/zmj+ChPCzKTK+6W/qGnsCYjpeAyzv5R14RYFOXEHor7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=K29RIxYU; arc=fail smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="K29RIxYU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782505604; x=1814041604;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=OeLpf3owf6b4m7XTu4mG5NvDNawAKzNCGvWk82r8zIA=;
  b=K29RIxYUoEjXO/uXWjMVN0Wr/4V1IPKz5DwMNwIUQrGJlMmsGrwMjXdB
   jvkhpBqXGNhdvYY7gI5OBTOqOwm0iAQSV52RQUZnsFHk81ArNn9lWEeuU
   UYIbu4XrnjPQqnbzcfPfmdTraY5XgeRekW4PH5Wqz4tdsitXnF/r0I7+b
   TIWQRDRwC2o4N6dTTEeZUbneWcjCSc0LYS7A78DWA1/meJxVcpGtJnIMz
   UqLutDoAjGaJkOxWiQy6RkcuBM7ZTdKVsmWnAGd+Sg27NXQN3W58deVAt
   LvbG0JNiC9OPXnVDHfjC/zIMr1eDbIDDW6P5HOXPC9wmywTBSSzlZMYVZ
   A==;
X-CSE-ConnectionGUID: HdDATvn4QuWqj0VXWEWKiQ==
X-CSE-MsgGUID: elavlT0bRySd6rUbd8xTjQ==
X-IronPort-AV: E=Sophos;i="6.24,227,1774310400"; 
   d="scan'208";a="22598990"
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing
 sockets with pending send data
Thread-Topic: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing sockets
 with pending send data
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 20:26:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:29679]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.110:2525] with esmtp (Farcaster)
 id 5c7f9ca3-8a79-4269-ac54-bfcfad78360c; Fri, 26 Jun 2026 20:26:43 +0000 (UTC)
X-Farcaster-Flow-ID: 5c7f9ca3-8a79-4269-ac54-bfcfad78360c
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 26 Jun 2026 20:26:43 +0000
Received: from EX19EXOUWB002.ant.amazon.com (10.250.64.247) by
 EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 26 Jun 2026 20:26:43 +0000
Received: from PH0PR07CU006.outbound.protection.outlook.com (10.250.64.168) by
 EX19EXOUWB002.ant.amazon.com (10.250.64.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Fri, 26 Jun 2026 20:26:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpbJiugYTvvrUtfk+ShxzZ1hJWavRWe1jYGUTy9xLMPpzeCgA9F8+FArEuKIfv2gzRlIUeIZ+MusOT0uqVLjC6vQJ+YBGDD8KKMvhTN9bAN9+o6wey3aQ05qpvbaOPcntyxjSJ0AxFJeAJ9i42fCGloDRdnVbOqF4ICylrQ1H7udzSAwte0Iil31omwUdj5Crw8RfWyIAw0vn4vnOh2cw0qvV68onOdWKHd9W8yciY7fnLdCyMLRfFDX+Vno4H2aKKfij2fUng3VQFW+QRChCWlN7eNkYJGgYY2u3R7JYRl9UhwJumZxA7667r+jqm8IPmOYd9VfJfpHdLh3bA+WLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeLpf3owf6b4m7XTu4mG5NvDNawAKzNCGvWk82r8zIA=;
 b=XqLexe7ACRrLRYdXvWG8CJdPei4LDKPp3CYUG5cFuMbIyPNOoU60e8rGW7UHEeRV9BufEG9aPVYa1FgWyaa91rxEWmOKvVjawTiJBT7hjdy9+vzCk+UuJXZa9pc1oPkvN6lHmB94js94LAnfgt/wZy1+iEmW3dVo41ro/0mahvlu1YhAMqpWMU1gLaUkvdeqFSdVGDXgmD2litsj0w3FjLE+Mu1j2TEsxMtfrz5iJFWIdKyumV3Q21jGiCYeZX20NuiIN5RY8uJlj2CMuqsi4RKDlsRjc8uvxVLHdM5ej9WmS7py8Q3lKKIjzKX22VoeF8mISbtBcjS0kTZjrCl3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4728.namprd18.prod.outlook.com (2603:10b6:806:1db::15)
 by DS0PR18MB5339.namprd18.prod.outlook.com (2603:10b6:8:115::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 20:26:39 +0000
Received: from SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5]) by SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5%6]) with mapi id 15.21.0159.018; Fri, 26 Jun 2026
 20:26:39 +0000
From: "Ahmed, Aaron" <aarnahmd@amazon.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "edumazet@google.com" <edumazet@google.com>,
	aws-binance-tam <aws-binance-tam@amazon.com>
Thread-Index: AQHczskVAbHrfsqWm0ylDOIzc6Zy8LXj+36AgA8bggCAAJPFgIAtIPKAgAB9AQCAJSKfgIAK1ewA
Date: Fri, 26 Jun 2026 20:26:38 +0000
Message-ID: <7CA56AA9-49FD-4FD7-A132-D9D4930CCF58@amazon.com>
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
 <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com>
 <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
 <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com>
 <CAAVpQUBtKBzq36Wz9p3MaHR=G10-NFBtQXgGW3S3QV5THW2iCg@mail.gmail.com>
 <34F462A1-CEB9-4812-8E98-239E38585F14@amazon.com>
In-Reply-To: <34F462A1-CEB9-4812-8E98-239E38585F14@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-06-19T22:56:04Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=4c115a83-ccee-44f4-a87a-b6b536cf5017;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
user-agent: Microsoft-MacOutlook/16.109.26051019
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4728:EE_|DS0PR18MB5339:EE_
x-ms-office365-filtering-correlation-id: 8a7ca263-cd07-4d50-1117-08ded3c13a0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: yNynwToN1VzEHEhpDOlh9KEzF8qxz14yNu0vNJvuuNnHfzn/W091REWIxXUFD9Ng972OmEF0xm5fjmZKbkdZozN056lcEnbsZqdYfnRNjKmtaUfoAX8uWBlxjrJP/+DBLc/hG5aTyKiRO2PDfvuxNb1FWW+/ydXIMtQm6q1J6f7YvpvgUlIdX9bNpxnTZwlcLZqi7tjOVttE6ni6bazuPWk6GP7KMXTC73nXFLV2cc3K7dHulqH7oYTRm1bGb1DV9K969m/TfpbigyAYicq7d5bVEF2JfeGWHbHVk97iuPXEVKNk2wzod0d/eeWeSPs9fURTPOnPztfwIUONK2vFei6p/il2l8Aycm1Zyl3ZasfH8CwJ/21xwSh6D6yJHARYEw1gh3eBnmT+m30J8CUGaGmb16SXaQG8cLryhXL6kYCq5EtbUp2/Q7cwCMTUXi4EZYqpGWUSGRYT8CaMmv1ta+/x5YLeIrOvSB2fEDsaWgEiOp/4GaOkNca4zykTD6PK4StG1t27vBZmQ8pwhU3/rYKh0B8ry8Uu4tF/zEedap25zX0IOeZcUpkfpoOZJhWHJ0hqAr9a7CGZg7RhoAfe0u8DZTLgjhHJZz5/7BI6nRP2xrsrugHrgr3/6Ab0c+SqDa1KxgRue5fauZs/+SSqyWsuFTvagbvixv5AFgP9JKz8lmrl4c1eB/she3ICwGI3oXpfZPu4z5cqyPwqB0n86u7XXDcGpOvdBkvlOkG9SNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4728.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXhTdzJZRnZIQ0R0R2NVbHZDS0ZsNU90L20wMnVkNWFFVXBoZ2hCRlBVZ0No?=
 =?utf-8?B?a1VVZWtrWTNUbUlBeFZWNzEyUEp6a254MFMrQWVYVllWeitLeTBuMHh4elBC?=
 =?utf-8?B?U1ZjeWpEdDRLTzUyMDl3NWErS09sUDM1MmVRUk1mVS9RN1dEK0hxMXkwaHdE?=
 =?utf-8?B?bnNrQm1DZkM3aXpUd3FTemtnUExNdzlydWpFQ2dNSW52TnRjdmlCcldoOXV5?=
 =?utf-8?B?cVA2ZUFqZTZjZEVKL05DZEM4UWxkMEFtdWhIVnFTNndZMmxta2xnbWpoWHQ2?=
 =?utf-8?B?NjM2aVoyOHZZRCtKSlNYeHV2K1VmKzl5SCtYNE5VQ0pEc0FYbGRBSDROLzI3?=
 =?utf-8?B?NFQ1OGdJWXhtalNodmNKNVQvQ05jdFU2dzl5T2NacVh0Q1IxWXc1YjZrSXFO?=
 =?utf-8?B?Nk5WNmplNkNadFZ4MlBzZmNrN25mZWhzQlJLZ01iNFE0TnpoT2tDVjc1STdF?=
 =?utf-8?B?MEZ4SmJCVHkrNEkveDNwS2loTERyVFYyaWF5RkdDcVdsVGQ4T0FsRDFpaEEy?=
 =?utf-8?B?VU9EY25SK0orV2hnSEhhMTRWSEI5L1ZSdk00QXFrbUltT1lKdFp0SjZhWm1U?=
 =?utf-8?B?WXUwNDNQMlJJdXVOUGxnaDhhRGRZd1ZXODJMcS91SWNRZGJ4K1pZc3o0TkI2?=
 =?utf-8?B?QzZuaUxzK09Ud0pvb29nU0U3aGpPT3d5cmovcVhOUjZDTUFkQzNtclVXVmJm?=
 =?utf-8?B?TmVMd3VKV0FnMW9qKzY0VFJBUWdTVy9KUXFWaEtqL0MxUkRySWxpRDh1Ukdk?=
 =?utf-8?B?dFF5VXFHdVhxWHp3YUkyL2lseUV2ODNmclFkOWdBWjFHLzlYNnNONEFSMGQw?=
 =?utf-8?B?cmVXRFljbnhHS1VGVCsxd044ZTd6eEQ1MEYxMTlMK3VLRjhCaHZYL1pzUVhp?=
 =?utf-8?B?cE1vWEtJSDVmRHpXSGZvNllNNHI0SEl5eFRpQmpkN1dCSjlvOE9NRVQ3YnFy?=
 =?utf-8?B?M0ZpZVEzYkhqMDJvdjNTZkxMZDdCakVJQjRucGNmWks4QzhBOGZnczlVY1A1?=
 =?utf-8?B?anZhRzJscDFMM0ZnQ053ekJJQmh1c016UUxtMlgrUEU5dlZ3WHRWSVV6Y2RX?=
 =?utf-8?B?dFNkb3RhaUljRHZZMWRUYTMrTFROWE1td0RGWVRkTHpTWUYrSmZ1YUtNcyts?=
 =?utf-8?B?Y3FjM1dVbmdHdGFoZDllR292NXRoMlpFT3pTWmhheEZVbWNiMkE0eU1RSDlx?=
 =?utf-8?B?VHVSdjZtSVEvUE40RE9DNUFDbk9RRUdZaThwQTdsb0x0R3NJTjhCZzJMakU3?=
 =?utf-8?B?RFRRS2NJWWdCNlF1bnVKaXg3NERpNWRNU3JRVHZObXlWcnRMUUhnTm5rb2dC?=
 =?utf-8?B?N2NtRElQYTNsMTJiaElmSFVVSSt1WGoySzdndEpXa3ZxOGY1ZGhFMG5hdHpI?=
 =?utf-8?B?cDdUMkNNN3d1VFFmR1k0SFZMSVlrWnFHM2NkenJXNDM4TEJrcFYya0J2aUVY?=
 =?utf-8?B?dGorYlZWTTBscGVIU2JpL1pCTkJNY0lvR3FXOXZocmdjbHZtMy8wVVRoNGs2?=
 =?utf-8?B?R3JCQ2YyUk5Ieko4UG56SnJnZm9kQXlKczBJVWQxU2RLZXcwN3A5QlE2dysy?=
 =?utf-8?B?aDE1ZUcrQ1VLcnl0UjZlbjkwMEJibkdUMVBMaHh4Q0wrUVQvL0tRaCtWajhZ?=
 =?utf-8?B?MVgxOGNTK1NlcTlDanpVT2pFTEh4c0JBT1czU29PZlVuYnpNZTUxSE94YTJI?=
 =?utf-8?B?UjcxNDhqVUUvNU5XeFpmejc0NS9hTVllV2VZNHQvZGtDYklRSTgweHhKMmxp?=
 =?utf-8?B?N0tGUVZxRVRXVGxHYk40bCs2cnpUQlNIaVd1aGM0ckZzalFqMHFBVEVMaHU1?=
 =?utf-8?B?cTdVNWNDRUJJZUJDL1A0TFBVQ1E4NnQ2TitTd3JSMFprN0V6aEgwNFNaVHJq?=
 =?utf-8?B?OE90cldnRGYvRVQwanNLTDh4MnA1bzRic2dyM2RIWWxmamNINUNvNXlhV1p6?=
 =?utf-8?B?MWJTTzE3TjhmS0QzQUhKRjF5WFptUTNCajJiRmZOZlB0bmI5T3dJNXk3Ykw3?=
 =?utf-8?B?VkVWZlQ3cEdJOHN1K0pqcjNFVzlVNGVlRzlkV09yRUdjcEs4WmJBWmFEeVVS?=
 =?utf-8?B?ZU1aZ3RxMk9WKzJ4SHZwOStPK3VBMlJkU1VmYWgxWUl3bjZ0eWE1cElpbDJP?=
 =?utf-8?B?dnFPOEpRWmtFbld2VnBEaVpIU2VKL29iZDhnY1BKUVRZSmpqaW9RbFYxaTkw?=
 =?utf-8?B?TlFhMURzWE8yTCtCTkZ1MmNjZXY4M3Zud2lObFlsN3Yrcy9IVk5KRlZDWVFW?=
 =?utf-8?B?WVBZamtxVjE2MGQ0dVpYM2hwQlEvMEZxWitNSnpkbmNjQk5xbWlyOGZNTVRX?=
 =?utf-8?B?ZGczSUlTRVhxczBsRWtsMmg3ODVMVWg2M2hMK1dTaCtoeXNBUjNOUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5D6A471377CFC468B1A41299D474147@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FsN4mm5wqvdl4Yx4kmnl0Gu3YScHy9F3TbbmVcC3qiwFTJaVS4PEp3Wfj+Sy32/Jgz+0QlaUIbCuHMDcKuzJAGO4Xkd6Yb17dPRokC305hGL66RhGTt5jj9B4ALKv4+MM/d0Qe36T6t4D+/lBq/GjkYtgtPGRqjk7kOuANaDXDrt6Dtr4hMUJWQ8lvh5W/+AQ5aMC+JOZnzex1OVeMoO6thgkOdJ+Sskrv+E6d0US0XZVcARyVITXZKReWt1g/fUFukf3R5NFjuZ1pT5eZJsqPZlzez0cBcvt52Ggh6c9Et3mMOSUFcdS6dTDxUZIlYFFBqis8LBbHzFUAwlixtSgg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4728.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7ca263-cd07-4d50-1117-08ded3c13a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 20:26:38.8087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hdh6wfyOKDLBEfsWrtExrZHCh6g+Ptpq6S1mrPl54L8R0Caknuoqs6xrMgxeMNWIoMeB8uPmiS1VGg7NR5dHXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5339
X-OriginatorOrg: amazon.com

K0NDOiBhd3MtYmluYW5jZS10YW1AYW1hem9uLmNvbQ0KDQrvu79PbiA2LzE5LzI2LCAzOjU4IFBN
LCAiQWhtZWQsIEFhcm9uIiA8YWFybmFobWRAYW1hem9uLmNvbSA8bWFpbHRvOmFhcm5haG1kQGFt
YXpvbi5jb20+PiB3cm90ZToNCg0KPkhpIEt1bml5dWtpLA0KPg0KPlNvcnJ5IHRvIGtlZXAgYXNr
aW5nLCB3ZXJlIHlvdSBhYmxlIHRvIHRha2UgYSBsb29rIGF0IHRoZSB1cGRhdGVkIHJlcHJvZHVj
ZXI/IEkndmUgc3RpbGwgYmVlbiBhYmxlIHRvIHJlcHJvIHdpdGggdGhlIGxhdGVzdCA2LjE4IExU
Uy4NCj4NCj4gVGhhbmtzLA0KPiBBYXJvbiANCg0KDQoNCg0KDQoNCg0K
