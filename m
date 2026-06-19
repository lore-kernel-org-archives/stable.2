Received: from iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com [44.210.169.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93332E73E;
	Fri, 19 Jun 2026 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=44.210.169.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781909910; cv=fail; b=DLOiwAcoH345RbSzWEpNYgmh5HkUt13XH/5XGh6PVM09LNHnyiX65eoUmocZl1QfyhF966M5zj8oPJUmJQY2KT9JlhiSQgZLPXK7WJlDg4QtMK/otTblRo1DmvVB10SdOge4RG0J/8VyzyWqZ8xaSjuRvtGCUpBQATCpJy0Og7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781909910; c=relaxed/simple;
	bh=1cVHWXs06h27TBGdFZkBvoW4uBTeMQbQsMXVaySZWwU=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mn783hFml7izPAVdl7QnE9Tv584Jad2lGffPBUD2RW5X04KjG8kjUyh2hPmMc/STZ90o/ERZKkuD436/WD+rigWjHL+wicx4YM6aY1TwnS2goGs/4umn/+WcAGf8drxGTjHcbW/L0Qt4VWXuDHOUwiRBVVmbZn/gaGZJTBYU/lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UF6EUy4i; arc=fail smtp.client-ip=44.210.169.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UF6EUy4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781909909; x=1813445909;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=1cVHWXs06h27TBGdFZkBvoW4uBTeMQbQsMXVaySZWwU=;
  b=UF6EUy4i7P/02MhrnW3ULdHfzKT2Hq5hFo12mmbQwTdcf9lCOvTrVElg
   QqkcJfQ3De4ylPZhrjC7EulIuIMtDx83ezHCXJK2nTfBHe8Enj6u4n2N4
   BRNEonnRQ4l/zFUKD6qcoD19X6xwvEQHeq7KaKXpC/wP7SG2MDN+8IkGq
   g63m2LUKg6xGSnbpi4pzz2BdfhabIOvqT7KFHkncH6vXCkXgcRfhSYiRa
   2mzxuu8PwSxt73Mr2O3qSk6YkZEyOvBXAmGptMTW739qIHmdiagSTD+vN
   0jw1jrF6YqM2LGoLvvjt7VNwrq4mga0BmwmO/cpEyGDO8PZq2DwYnkOfo
   A==;
X-CSE-ConnectionGUID: fKiGJrKLQwSb6Qui+Emsqw==
X-CSE-MsgGUID: XB5IubZOQDSEbkxTyToyPw==
X-IronPort-AV: E=Sophos;i="6.24,214,1774310400"; 
   d="scan'208";a="20723793"
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing
 sockets with pending send data
Thread-Topic: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing sockets
 with pending send data
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 22:58:28 +0000
Received: from EX19MTAUEB001.ant.amazon.com [72.21.198.67:20921]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.18.185:2525] with esmtp (Farcaster)
 id decf7f20-2528-4f22-a046-6306eb931f5d; Fri, 19 Jun 2026 22:58:28 +0000 (UTC)
X-Farcaster-Flow-ID: decf7f20-2528-4f22-a046-6306eb931f5d
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 19 Jun 2026 22:58:28 +0000
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 19 Jun 2026 22:58:28 +0000
Received: from DS2PR08CU001.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Fri, 19 Jun 2026 22:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exYs5c4Dw94LsuJGjD495iTOfL3vAQ1nbsEWY+J/4Z2IzQyROvOko79LAPb0bFEiHvKZE8MjkkpdgVVeuZX+voYYpt61rBcildmekhRPfsZ3Gn1OKm8xrPjfgCRa5N8sm1hXT6iaAC2CljxU0FTrmITk4Dgs/Iiwl9egrDZga0TAN/Zp5ODs+QvAGbup5j46yEbk4Txve6bsZcSJeWU87vbNco0wvy+dTEKLB4CmKYMz3t4q0QOIyU+H4hLwiegDVO+Nsw32tw6z3SeuyL4mdviEtntr2ciISzwfF6Ct6foJZIra54w28bMl2jsTPY1VMtlLqy6ZytLKfSTmpNqonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cVHWXs06h27TBGdFZkBvoW4uBTeMQbQsMXVaySZWwU=;
 b=uRaWghOqSyW1n3X6ag4CP3xPVYvBS3Myz3KCo2mF/SvPy/T2Ngx5vgNODR41/acxxxHhvg8zydrc59L9WMhrNyisyNVIU4T0M/QzK8uMkxNg7884TBXcxKRv1F8lpmFZljWMtBM75qLxULFZgtyXmJ9DZeXT90G+j3HIgYY/aNw+Q/yemVZvKKifzE3mr7iY/H2ynchahtPzqa9mV3K+/1IvKbk/mMjM2JxrD5XxVlj+lBMAfoBSjT33ot8XSfE2fP4K5rwkh/LQJicYEtUM71sygrln3RBNXT/aQDvmBdeexCZRci0aA95EnHuC7nwFqqf0yhgEol0XUQkffs8BJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4728.namprd18.prod.outlook.com (2603:10b6:806:1db::15)
 by SJ4PPF2862F1335.namprd18.prod.outlook.com (2603:10b6:a0f:fc02::f11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 19 Jun
 2026 22:58:23 +0000
Received: from SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5]) by SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5%6]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 22:58:23 +0000
From: "Ahmed, Aaron" <aarnahmd@amazon.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "edumazet@google.com" <edumazet@google.com>
Thread-Index: AQHczskVAbHrfsqWm0ylDOIzc6Zy8LXj+36AgA8bggCAAJPFgIAtIPKAgAB9AQCAJSKfgA==
Date: Fri, 19 Jun 2026 22:58:23 +0000
Message-ID: <34F462A1-CEB9-4812-8E98-239E38585F14@amazon.com>
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
 <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com>
 <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
 <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com>
 <CAAVpQUBtKBzq36Wz9p3MaHR=G10-NFBtQXgGW3S3QV5THW2iCg@mail.gmail.com>
In-Reply-To: <CAAVpQUBtKBzq36Wz9p3MaHR=G10-NFBtQXgGW3S3QV5THW2iCg@mail.gmail.com>
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
x-ms-traffictypediagnostic: SA1PR18MB4728:EE_|SJ4PPF2862F1335:EE_
x-ms-office365-filtering-correlation-id: e56060b7-7ef1-460b-83c6-08dece5643ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|10070799003|1800799024|56012099006|4143699003|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: pS/TlLZZhUJKlF+94x8JWkCMsgvup3znt3tdRXDOomy/WRqkxDoNMNQvwa206TTqKTYj28xBBAls0LnPn+muLVNMOMHsZbscg5dexec6iMFgFSgyRl2+498IOnasvnHcGqjN4pnkrewaUERkoFNZGw5tpY51ZriFLpXtGBuTP2bawZTyWlGTKTdJdQ1D9xapjeDDqKtwPIQmOYV8u+lKXrv4jPvFNSior3I91vfugL6x8/+L7e6twCYujP7zM/i3x21tv94p6effkNUesvrPoVh4auG7hF1GffFpJ6/rdjzlx6Pd/LI80httG3lmgkT92AmTLd7sMutnHk2BYvrvnNRn4/iOyopxxJOPLR/u2WNJaaXS4fQRUkdBfwN4V2OgBI78HJK4cA7FeK0FUf3LwRXMZ3XHr4b01AMtGiNVtIMmFg45wOJXtMjaj6Pf1HwllFwUOp+bauOafjt113HzaCuhH5K+hDpd454OECCIVBLfyLhlrikbVkXW3umDO5k+WwBpRpKm1ANQavlb+ejgNYLyayhepoI3dWcbcHjeiCWzht5Wp9r3587T1Y+iR2iVFrHciOl/FENOMNGej4mCPa2qPKEtbDu/8a59fhnfwR0eXkM7GFLrHUg3Jt4TZTXwb+ZgLP5UXNEVEMhS/8iwGnRivExp0N6HyScOj3e9F8E25CFzTeK8O85m/9aFbYByRf9dqe+DbPQ8G4juWi5zV18AqLPla8n70Pi+w6xjxdY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4728.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(4143699003)(11063799006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU9HSTI5ZVRpcHo2aWdyWEhzZzVWbHJ5M3RROUo1OExEa3Z0akpERExwYnNn?=
 =?utf-8?B?SjdSZWk1Y3U0MTBpS25GSTdSSGIrRmZyTnJFRXowakJENmlPSlB5bFJvNWJv?=
 =?utf-8?B?ZzNyT2tnQnVHR2ZUSVJmUmdiUHZlQjc4dzNZTVA4clRWd0l2TEhpTlRxZnor?=
 =?utf-8?B?VE1kdFdjV1p3d3M2OGZKWnpMcmV6L3NEUGNqU1Q2T0lMM2VYWG5ZSmpNdEk2?=
 =?utf-8?B?TFhvMGE0dmpNMklRV2hqOWlIbDUvTFlZNDZOd2NNcDQwdEhRcVlJZzJ6YU1Y?=
 =?utf-8?B?KzJMVUxYM1lCWlhudHo0UmxGY1JkeldtU2haaHRLRnFLbndSRlgzUFE4cjNo?=
 =?utf-8?B?YTFwVjJNOGZrNVFDVWxNWjdwcG4wZ1h0amhIZjBEaU1SSStIaVpCdFlxSkN4?=
 =?utf-8?B?VHZTM3hoZGR3bDBuSGk1SU1BeFBoWjBKdUJRVXZubXhtK2tjK2g2bWVEZFZS?=
 =?utf-8?B?bkRVcGs5MGVUaU0rQWxaVjNFQWNpTHhMcTNOMTVIOFFxK0wvRGw1NUhreCtY?=
 =?utf-8?B?c0I0aTMvWUpDOUx5Mmx4c0ZaNjIvWEkxbG5CTnNYNG9iWmNBK3dWWFFGcHNh?=
 =?utf-8?B?N0lSNklNQmxlcmQvSENja0xPRXpHUDBnYTN5ZTd4ZEsvYmNxVGtkSGM1eWFk?=
 =?utf-8?B?bmM5V2tPSTJFL1c2SnJzSUo2OG5wd3pYQW9zSWhTTlZkUHZkUkRjTUlrbnhM?=
 =?utf-8?B?RlVpblByU08vUW1aYmMrb1AzLy85Q1BWcXdrb1NhSVczQ2JOTHZTWGVva1U2?=
 =?utf-8?B?ZTVNKzRUSEd0ZWd6M2EyL1Q1cG5Za1R3ZHRmZkdKTGxadDM5Y3RJT0hkcE9S?=
 =?utf-8?B?ckV5VFF5dUQ0WEViMEFDWmdkOUdiaXJPTnN1NmtmcXk5SFRpbCtQNVJya21r?=
 =?utf-8?B?cFFMM1BJc2ZXRnNVM0N6U0xZbWdpeWNPZFptemJYU29IU3MybWU3NE9uZGJm?=
 =?utf-8?B?bHNYSTlQMWVWMnR6a3lEaFk2Y0FxUW96YXgzaXlCWEhUSkNYSjEvVnBlRjlv?=
 =?utf-8?B?alUwaGpqN0NvMnF6M3VoL2gxc1JkUE8yckI3ODhaV1cyNmVkWHk5ZXFBT1VL?=
 =?utf-8?B?aWd1aUVPWFcwVkVrZndiQ2ZuZVJNdFVuTzJDVERTWnpOVzVYUUE4Z2FhZGp3?=
 =?utf-8?B?UEVtanhRWCtwWG9yVXdhRW9ZdC9uM1Y4ZitsVkdDWkJPR2FJdUlKaFUzb1ZK?=
 =?utf-8?B?SmxZR1NGWUZVaE5IUkdXL05sMTlZdjBJNitGTFJoam9BanZpcDF3VlZFenJr?=
 =?utf-8?B?MERET0ltZlNpRENhNjBzQkwvSG1HS0hEb0ErS2c1V3hMdWVSL08veEFseVE2?=
 =?utf-8?B?WEJvMU1VYXU1RE1TclJkRXBEekNWaGVBS1FOcFdlZU1nU2E1dEx1MHdSNkRE?=
 =?utf-8?B?TmhIeFBYdEIwTHRqNDRVVUlDWSswY24xdm1wcGVlNDNSdCtSNTdORlQ4TkRy?=
 =?utf-8?B?dWdhZGptaXppKzZkT1ljd3c1NEtZa1FkTVZ1OWdieGdobkNQL3dyMkdGWHZu?=
 =?utf-8?B?ak9vMXlxcjNTcy93QWVqa2c2cThWT1NnZ1hMRW9MaFFnUXUwR1lhSzF1bU9V?=
 =?utf-8?B?ZWhGUFVHZzFGVFlWSlliMHB6N2F5TnhkVWJheWRMdm0yQjlXMUJwci82NnhW?=
 =?utf-8?B?MllsVDFGTVE0R2lWMm5rQ2FYSjFGN1kyaHVsakRpd3dCcWFMVHdGMmdjOFFv?=
 =?utf-8?B?R0lvNnNIcFdyUjM2RUx0Ly9SUjhxRlpad2hxaXJudkVJUjljd2xTN2RMM3FX?=
 =?utf-8?B?OGpwbGs4amlVMHU0MXEvYmlzcFdIUHgvZnIxR25uU3lnVEl2cDN5WTdXRjdi?=
 =?utf-8?B?TmtUWHdRbkgrWlhMNFhacUpBYXQ1WXE3OFlFSnN0SVB2R0Z6S1FqS2pNZ2lp?=
 =?utf-8?B?b3NXN0J0ZG1NdWpUN21oUEx0bURPeGpXNnk5TUt3UWg0ektJamU4azA5MDBM?=
 =?utf-8?B?MzNkeUM0QXRhbHEzWUViQ2JTdkVaTk1OMGh2Y3hOaVQxKzdldHpFck5YTnFk?=
 =?utf-8?B?STZMeHI1emFJZnZrUlUyWWFqY1hHUTdxNHhmeUx4eUdjNjVCMDdsL2tpeE5B?=
 =?utf-8?B?cmgxeDYySGdiaGd3aHdidVFiNzk1L21SeENoTCtNUFIyVVN1eTJnOE0zUm5C?=
 =?utf-8?B?Y2pzcDNYc0paRXdJL3dpZXowandEQmNDZDdMRE55VUpvOTRJR0szd0pKM3NL?=
 =?utf-8?B?Z2d0ZnVjK0NLdzdsOXpNUnU3VjZuc09YZjIxZWFPOXlkUjVGc29BK2lUVHFH?=
 =?utf-8?B?b0d3VVZYcXMwWFRaUitoVkdDeVhqOWVCUi9Ic2VMdEFDZzZTZ3pOUlJCSklQ?=
 =?utf-8?B?d09hTENWUTdHZ3hVUFpPMmhNUU9obzJKVjkzcnN0Z1c2R3F0K2JSWXF6Mm52?=
 =?utf-8?Q?enrs2YXPlrh/qutNPWrLsMu2KSvmW9MiETvo9FABoNXXg?=
x-ms-exchange-antispam-messagedata-1: xlUAg0hxwC1+Kg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AC63AEDFDF2614DB94267FBEFA5EF39@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QzvF7r6eQh3rfXH4bZUf+hNPxKJKTh8pL3Lxg1UIHQMMm2fjdA95YsWr9enq1mAYhGZ6uUbnBeoJNDDE6RMLBEnxCrNfJNBiKGdm1A9cFvb8lw8a+nyfysNiKO3n/LvxtANNusurXdj7xrJW4wIN55lC2OFUenVXIHh049A8TNvMzh/hOqqvAJ1HmV3kP/P/jdXWgS0c5+mom+HREl2bEE8gPxy10R5RV8f7DyG/XLwDCdR/iyV4oETNo9HlRLyM7BlxsNSwgGX2QobLhldib5yMaQ9Jux+oTvk4JE/n6HH3WgkMLuh2IdGzpBptO12zTWE3Q/y6J+sFd4xo85DESA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4728.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56060b7-7ef1-460b-83c6-08dece5643ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 22:58:23.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yPm32dkSL7l/V+7VNT6cOfRFjWT5M/9UD6eWqZITTUTJGkirwlHDwzYntIJU7+H/zFRzjpj0T26ON+8+aPCaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF2862F1335
X-OriginatorOrg: amazon.com

DQoNCu+7v0hpIEt1bml5dWtpLA0KDQpTb3JyeSB0byBrZWVwIGFza2luZywgd2VyZSB5b3UgYWJs
ZSB0YWtlIGEgbG9vayBhdCB0aGUgdXBkYXRlZCByZXByb2R1Y2VyPyBJJ3ZlIHN0aWxsIGJlZW4g
YWJsZSB0byByZXBybyB3aXRoIHRoZSBsYXRlc3QgNi4xOCBMVFMuDQoNClRoYW5rcywNCkFhcm9u
IA0KDQoNCg==
