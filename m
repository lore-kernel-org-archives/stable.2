Received: from iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.197.10.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31237E5F2;
	Sat,  8 Aug 2026 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=34.197.10.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160568; cv=fail; b=t3O/TYytnUg8LV+FLAWO1qiYEt/mSD+LnmFCZ/qu2BwK2s6/vw4TMGvLr2WdGZmemVt3tFAtt0j4LcQtmcepcgH+vbj1Un0ABv9NIXyCyVJxrKyH3QSrlHRl8sjKtZfkUxOOCiE5noKe4qeKpidQixUGYR4I/sYzQqnqy89zLXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160568; c=relaxed/simple;
	bh=G+Gl9MI3fZ/cJEESgkiyzGBuqMr38SXVh4DtqGYZsuM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H0RvluFZ6/j3+PiU8Um8kMQcMMk5H+WYoQfVLcDQWI0DoZVfekgcCRcWlJBM1WZWO9Ra9G2oQj6fXF53GAL6E+Nn/9LBVa1BHhGHjaPkBT5UNxrRsh7FxkohkgA0YaudTDZ6AJo+7uyU44R8hw80mdR06GW1vzS4llmA279t2gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=U+ag0oOC; arc=fail smtp.client-ip=34.197.10.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="U+ag0oOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786160567; x=1817696567;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=G+Gl9MI3fZ/cJEESgkiyzGBuqMr38SXVh4DtqGYZsuM=;
  b=U+ag0oOC5NT+RwOOYPyRBcu6YQ89hxS5nzjyMMebPLcI1e6rpMg6DtbX
   Rp64318OFNJ4StYiWO4l4XcAPxCc3WG+E71yzZUigF6otthCd63L14K9d
   kYsXd3Zg6S13ctFZcnwrU8hlOX6jco+UfwFqwBvQyQo42DWCbhCwAGRv6
   4gCaBRK5RWq8Adu4v2CqeeGj5z8geppbThkNhMJD3l5qE8uxvCtcyRVli
   /F4JxpaDPzVJ2KD70a4g3F6mTwCrDrHqRucy8F2FLdrqbXj7REi2D2h2I
   GzARHPRlHkjlm/ytG+RwLiekvc7CPAX6aU230khG01YlqOKuUqSDkaiRK
   Q==;
X-CSE-ConnectionGUID: rG38lMFYSLeyhVM4Bv4q/A==
X-CSE-MsgGUID: qWkZbR5BS0KehaHyDz7NfQ==
X-IronPort-AV: E=Sophos;i="6.25,211,1779148800"; 
   d="scan'208";a="24251317"
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing
 sockets with pending send data
Thread-Topic: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing sockets
 with pending send data
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 03:42:46 +0000
Received: from EX19MTAUEB002.ant.amazon.com [72.21.198.67:23163]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.19.159:2525] with esmtp (Farcaster)
 id 994d15dd-196b-4c66-b434-6839854715b5; Sat, 8 Aug 2026 03:42:46 +0000 (UTC)
X-Farcaster-Flow-ID: 994d15dd-196b-4c66-b434-6839854715b5
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sat, 8 Aug 2026 03:42:45 +0000
Received: from SN1PR07CU001.outbound.protection.outlook.com (10.252.134.239)
 by EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Sat, 8 Aug 2026 03:42:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJ4Vzkez8CA9kAaiy6qz0olggfdKRdkwK27Awy1JPKtdeSo4qJtONsFh97Rj0pjfEcFL2LBvkgtOMBPPogBx6iHM2m5+ucJRgC9DvMwFqBjy6O0gF1QE/Sk/8dLLNwdsMZlOTnKtyjUUNwjnaY/Dny3TOK2bDdsIcBKTqIzOug6qe8xINrPjLNlw/13FH8ymsru4yQvv7UvrmBDhRZJo9f9GkfLRr6zRBxYpGthVpst6XWMZAEdEnh7hLnwaqTa96frvCJSTkMQOXXDk68ALsWNA7edp9sbdcTMdHW7fZnAUiNlKqoyyPc0MzhXOnFVei/bRRIS281a0PVLxXjP/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+Gl9MI3fZ/cJEESgkiyzGBuqMr38SXVh4DtqGYZsuM=;
 b=vTwHm01ZyBcjhx91sJNepMMf7vXc5eX/8DHtkfDuLouP++ZaDUlN8KzlNVbmsLYbElNL+F0cKl+2zwV7pTsCOoeKzP/FJa9f6oP3k2cmBpJ59XehJ3bn0T7ahPzYkiYOBED6Xh3yJrOYPhExg59ycrF9TZ0GW5EuFEQ0Xcv8PF41Srk+/BdgkXGFIkb/9FX2q1u8eSXal4rAdg2woaERHkxT9m3EBxCRlYUh4N3kZSqTIl38ey80STh1Jig2PwJx5kANSFL9l5XdcvAv1EYNz28j3U/WtlW3ClQCn63yoVbKD2PoOMH5rsA0BfvdRwHsdzuYXUdp1oY6Q4jWv2AmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4728.namprd18.prod.outlook.com (2603:10b6:806:1db::15)
 by SA0PR18MB3520.namprd18.prod.outlook.com (2603:10b6:806:96::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 03:42:39 +0000
Received: from SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5]) by SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5%6]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 03:42:39 +0000
From: "Ahmed, Aaron" <aarnahmd@amazon.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, "edumazet@google.com"
	<edumazet@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, aws-binance-tam <aws-binance-tam@amazon.com>
Thread-Index: AQHczskVAbHrfsqWm0ylDOIzc6Zy8LXj+36AgA8bggCAAJPFgIAtIPKAgAB9AQCAcnRHAA==
Date: Sat, 8 Aug 2026 03:42:38 +0000
Message-ID: <0A7EC161-4EE6-42D4-A10B-7B4C609C7B32@amazon.com>
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
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-08-08T03:40:15Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=083caff9-58b4-4a4f-baf0-51a17d90e390;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
user-agent: Microsoft-MacOutlook/16.111.26071325
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4728:EE_|SA0PR18MB3520:EE_
x-ms-office365-filtering-correlation-id: c4098a57-74b7-446c-34ee-08def4ff1806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|18002099003|22082099003|4143699003|38070700021|10067099003|11063799006;
x-microsoft-antispam-message-info: iqnHF2zk0UuaewGfBuwCAVB3iyaGZ9rv9tT0up4iUWMIINo9nE0wl6qADQMiubHOd4p6Eda0JcUHJhfLh2/YHr+Q++tQ0pWoNBKWTcswpbp8rElN3ibrefKCDawrn1uGBZrpZezo1Golr8nIXq4rVK5/aKOMyD08Si5yOyXvUjImueJuCwH3EuNZ1ZLOyUqaVTfVCQZdT7eXFSOTC4Kop7ndxT+wmjgubaQZu00nZJWxz6N8qkngEax1vFKJsLKjbscwMcdbmRXU3BQfM5833G2M4OWxiAvFRdZaJmfxBBJjevWcAedgvBXaz6Khk3btkIuqCNCeTkHrnzxExAabJwSQEMkBrwbjdiSjhbR1LG0QNW7fprhAUA/9j8m4S/OSXX4cwBPR39+BEpideaaGYIUwL2UVdRXihG8umS0f6PTrwLGHnhnPA9mK7dkS6+/VOr/ZwBkHaZVvJo37JVzA/4LLe5rXWMxSzkfJ6jQiJnyfF60nj4qXezl+5bq2bULYqiGx4UvB7lpmoE3o6hcFq53RfTb4+cJ1Etdj9ARKTz3dNyxUP5+iBqUR9osUzUC9yPBnyrCeIfKda5kDA6ceJzsN360SnSvuLzNf+d/pjh0a2Rs95gROxxJ5su9MH3DbFCWkBAqHjvGCYRvYfagAG6/qLP9VU4LT2O/Nq2cARtNRuDpDvBQGeBtMwoT6ISIIqCMWgnf587a3GcWe7ifkgW8BE4B6Myp1HF1UrBOBcuI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4728.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(18002099003)(22082099003)(4143699003)(38070700021)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWR5YmFnbDJsYmxCdzQzL08rSnNZQVZVeGRjQ1BHRmJRVTBKUC9YRWc4QWtZ?=
 =?utf-8?B?L2ptakllbTk0WmFta3FQam1WT0hmOXVwalBKeVBDclI0eUxnMjMxT0pKM2Vx?=
 =?utf-8?B?N1ZUNzMxOWgwZEt1ZVpvbS9qVXFwek5ETkV1TENWcFZWbG16MjhxUGtRNUZ6?=
 =?utf-8?B?YUVHd2FvZXowRWg2Tlc2Y29MemVMNHFXMG5DVTl4UCtudWRjbS9oZHBQeVpC?=
 =?utf-8?B?ZmhreitxOVlQbjNDaUpQRFhOMmxpM2J2VCtpYjFxWWV2SHBlQTZnRU1HTTN3?=
 =?utf-8?B?ZGVpL2dtNmozQnVPWXpyWTZDenNBZXoyRTB4N2t4OHloZlA3MDZ4VkNheUtM?=
 =?utf-8?B?d0JaWjJzcXNtRU1rMGxSaVZjN1BjaUE2a3BxUGo2WHJEV0pvVUVjVUVEd0p4?=
 =?utf-8?B?RmNsZmhmWERHMnEzL1VqRW16cXlnUmhVN29HcTFWZ2l2RXFlRk9SQjViNzdI?=
 =?utf-8?B?eVdrVGZ0TmMvVU1xT2dwaGllVUttMVNkd2ZVRnlvOVVYQUJ5WWxMdHNVMS80?=
 =?utf-8?B?RERON2ZVQURVbnZiRS93YldqRHFjZXFoanNPa29Nbk91a0M2V2JqY1pQTGtp?=
 =?utf-8?B?eXF0M1FNQWVkOWpCbzVTMGVZZGQwc2RTN1lhbFc2alJuZXZUeHBKVCt4RTYw?=
 =?utf-8?B?dlNQWHVwTWlpdmZuZkhMWTErdDZTNFdySHIrOTEvbnZmVGRhWjNUaHA2cXpo?=
 =?utf-8?B?SnYwZEtjY2lLSnI3NHFES01vdjNFY2E0aTVnWTQvTUhVZUh2bEc0VVBQemR0?=
 =?utf-8?B?YU0xa2tkUlJTeXRITkF0M2NtY1VrVGg2bUNQTGdYUk9TZVU0RExSeVJzb2Er?=
 =?utf-8?B?YThVTnQ5bmFaS21nTU0vd2pQZXM4b1p4UGhQeENHcWdkVStVcVZqa3hWNkh1?=
 =?utf-8?B?b0ZzTnUzQXJxZ29YRU9YNUFqWlV4WXVmS1ZzTytGVXIrOUpLeGEvNmJRdE1l?=
 =?utf-8?B?VWhPU0Z6UFlvMHc5akl0WEVRcnhLcXV6eUtxQmxjQXZxcGtCRGZ3bldvUzE1?=
 =?utf-8?B?MGNlR251bnF6dWhwdFJFY0N6Ly9OSG51REFBbEFMcmJSSDlVYk93UnBtaTNN?=
 =?utf-8?B?V3M2aDBnQ1Y3VkNOdFNwK216djFFR0drQk5vNW1oMWxsaUxTd3hZUlhFN1Rq?=
 =?utf-8?B?ZlJmVURoSE9nU2JyZWhmemtaQzc2Mkw4QWxBYzFUVEZOQ1FJODAvZFQ0NGF1?=
 =?utf-8?B?SXN1dlYvNzc2cHNSUkIxbm1sVm1yWW5JWnp5Mm82OUZFdGxVejZ0blFrK3Zi?=
 =?utf-8?B?YXpkSktaYUZ6N1NVN0ZudVJSdVVtVU9DM0ZPeEMzWjFEM09YOWR4cTU3SkJ5?=
 =?utf-8?B?TDVLZ2JrVWVDTVBEQlVQZ0NzYXduampJL1l4MHd4U1krWE1MMXh2VjFRV1ZV?=
 =?utf-8?B?MzNwN05Ka3BQeWMyK0JVeGR2aksrdURHZ0lONzZlMlRodlBUdzVWbzNIV3NT?=
 =?utf-8?B?eWltSU1sQ0t5S3V4dmRiY3l2emZXZkpPTzB6VlAxd3dhOTl2SnRIZW5QWUd4?=
 =?utf-8?B?K0RMOVlaTWw4R2JhK2daekNaTFhFUFRNb1R5SFpCeVZFenZtUFg3MnNzRDYr?=
 =?utf-8?B?THd0V2VsUHhOZ2ZCd1c1WW9QMEJFSEdlcXJPWEJ4cWR5SUNXdFpLbnorVitw?=
 =?utf-8?B?V0ZPUGxOREkxK0wwcmJYelVZK2V0MFRWVHdpQ2ZZTGFJek9nanRnNkZMRStw?=
 =?utf-8?B?UW1MMGRXeHZpeU1xUHYvRG9YYk1OSktBUTZOWk1YVzV0UmpXOHZiWFU3UHIy?=
 =?utf-8?B?bkVsSm1QdkxuRU9XSzhlZkFkaC9ZRmcrZlZiQWU2TGgvZHJReHcvY2hjZkQv?=
 =?utf-8?B?TWhSTWE1RWxpMzgwWHF1TE1FLzRKUm8xS2plUjNOK1FhSFo2SDZnamI3Y3pk?=
 =?utf-8?B?V2NFQUhWeFNGMVY1eXd3RnQ3VThOTnA2TGk4Ym5Xa2J4RFkxVGRFaGV5ZU8x?=
 =?utf-8?B?ZFA4cGhObCtna2JML211YW41bVgveU16ak1icjRhY2RRbXkxLy81M0NWc092?=
 =?utf-8?B?OFd3MmczRkZ3TmxDMzgzTXhGOTNzeUc2OVlDMmZIZlQwRmh3cGhqK2g2bGJy?=
 =?utf-8?B?WmN1RGJ1OUVMb2gvZVNHaEJ1SVVWNGlJbTFNSWlYN2R6SFlBYlllcTBub3Vn?=
 =?utf-8?B?QmlwemY2NFhPbThGa0NNVGZMeVB6citlYkRVem5HT0VIT09LdzFRbi9oTVhL?=
 =?utf-8?B?N3JvQUJ2RWxpRG44T0cwMG1nV21Hb3BwTHNHVTd5N0crUlk1T29IRkdSWjBJ?=
 =?utf-8?B?OFlFaVZjUDl0azl6eGttcC84T2o2NFpZSzJ5S1kycEovMHMzUUlYZWxZeTdH?=
 =?utf-8?B?KzhTSDdramdMRXRSMWVEVmZJdkJ3T0JPTXdEMXZTZkxEREgwSVErQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EE40DAFEBD4934298F0CD95865AE013@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d087ukKp7VX0oF22/H6d2mJj8DGcI3EB4ADCMT88QsYLgJAXRfnBvpIJuJ1U6O3lPc8cJ7o/R3EXeTLmY1otYWpIZ5NibeMBmwTUH1siYBwlffMhU0CJCDrOCEY73o0CKwNg22jKBnVtAHsrEO9N/tbwjz3eJGuqCMOc4abYZN/ujx2NsewqZUzg+cew+B2StNIlovIriZcGjKBjHSDYGRMhYXr9nQKK23O1h5ZcN6rWFf/rq1vatwTSqzvoNecpeIsyqG43Z+6XDobqN/XJYgAr394xWYr73Euniw2n3S+rSFzdfQ2Sn4hJABfTJ8mPkR6ERRzF0fo95rLHIEwWvw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4728.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4098a57-74b7-446c-34ee-08def4ff1806
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2026 03:42:38.9950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Z+pue9x+fRsJJoS6u0XlJRE8hutHu6MXg5W+39VF94hQwrW7etZFG0UU5mUAUKhiIvbCRtAuJ60GN+IX2c91A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3520
X-OriginatorOrg: amazon.com

SGksDQoNCkZvbGxvd2luZyB1cCBzaW5jZSBpdCdzIGJlZW4gYSB3aGlsZS4gSSd2ZSB0ZXN0ZWQg
b24gNi4xOC4zOSAobGF0ZXN0DQo2LjE4LnkgTFRTKSBhbmQgdGhlIGlzc3VlIGlzIHN0aWxsIHBy
ZXNlbnQuDQoNCkJhc2VsaW5lICg1NSw1NDIgY29ubmVjdGlvbnMsIG9uZSBjbGllbnQgU0lHU1RP
UCdkKToNCiAgVENQOiBpbnVzZSA1NTU0MiBvcnBoYW4gMCB0dyAxIGFsbG9jIDU1NTQzIG1lbSA4
MjM2DQogIE1lbTogOTQ1MDQgdG90YWwsIDY5MyB1c2VkDQoNCkFmdGVyIH4xIG1pbnV0ZToNCiAg
VENQOiBpbnVzZSA0NzM5NCBvcnBoYW4gMSB0dyAyIGFsbG9jIDQ3Mzk1IG1lbSAxNDA0NTQ2DQog
IE1lbTogOTQ1MDQgdG90YWwsIDkwMjMgdXNlZA0KDQpVcGRhdGVkIHJlcG8gd2l0aCBuZXcgcmVz
dWx0cyBhbmQgLmNvbmZpZzoNCiAgaHR0cHM6Ly9naXRodWIuY29tL2FhaG1lZDcxL3RjcC1saW5n
ZXItbWVtbGVhay1yZXByb2R1Y2VyDQoNCkxldCBtZSBrbm93IGlmIHRoZXJlJ3MgYW55dGhpbmcg
ZWxzZSBJIGNhbiBwcm92aWRlLg0KDQpUaGFua3MsDQpBYXJvbg0KDQo=
