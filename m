Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=173.37.142.90
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795789296;
	b=Qe1oNDFhaeHggFplccNmc8V1Gt34h3IsnBLci3hBJ9BaD6O9K6ZURNzPCRz3zthD01so
	 SL5cLCpJhatBs0/gIcDmZ4OVK56IfpVUzx5wZLr6slmvvv5TvDENufAFFjzxzHFUwLwxw
	 n5BwlRair3XmKC1KrwigE/CZKmiVmUhQ/RL6wjwYVWzJsuYsH+c6GbijN/WBa9WsJBmQC
	 LXQKuGSPs2gxKtkotO6tS+S84A/pQFaXLFgcD9M4HtakX+MTZGwKzinWkTZFOKf60O0DM
	 t+6jT2qZWKEDV4Av3hynnL3ZbkNBnRxvEBkompu6U5/d+c9poP6Bc6Xrz/aRQLUVLGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789296;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-PHdr:IronPort-Data:IronPort-HdrOrdr:
	 X-Talos-CUID:X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:Received:
	 Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:msip_labels:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=axk26ViRj6pmK1qYbkTMdIxRppjqd9pjytkByLqb0hg=;
	b=W/9DLy9MErPoJb6+XSfsi9BR+kF9Fqa5valya/vc+3865T4r+cvMc3IVhSocum6z1hgU
	 m4GFXjgq+Th1HKVYOwTQzYlqfiJ7Q2FYebdAoaEJak5bOCmQsGWFe0IujvDFvC/Oku/VC
	 lSCgP2nNBE8mUwfaLyLR5ZWPlLAHflfS+ST7v8F0TZ/RPh/rdw926cKF6RcavNjQwxtdf
	 DyUn+mYqfMLqlmnFzbHo5hvngcYWJ6ZXNv+FdhNeMH9jL9/iO3KJ0zpma3fWwIfZtiaSY
	 Yo+sqFtjyLvu4m0IOg4bxvZrI2pqe9havsUaWEJ2L1usgQ0QwCzAfjrKgyorlh+41Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=d9k+evq3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=173.37.142.90
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15D606A31C;
	Fri, 27 Nov 2026 14:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB15D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=d9k+evq3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1039; q=dns/txt;
  s=iport01; t=1795789295; x=1796998895;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=axk26ViRj6pmK1qYbkTMdIxRppjqd9pjytkByLqb0hg=;
  b=d9k+evq3GjrIsRMW0Ge3PthB6b3lQ3NLHoFDqKX8nO0EwyJnfv1ZGZvJ
   24m4Y9CT8nfHbI1YFi4+zct7aYN8OGmZtZchne9NameduaekMixmCIhzp
   8qHH2B05Ye/1nbu+ZZDPF/JSe2Ma+zW16Uuf/0eV7ibmqZpCOjvWzno6q
   fRSRAEXqHEzC9rOjKARn1xQjFvjyXB+Fq9mWIKjSesAtg7YcSlv2gGq6h
   Ghj78SS7b3QAFkSQRQ8fYJpGtLb5xKbbZmASFbZW84uIizRMUMYx0G0/8
   3iuAIM7/rcYI4QTE8by/JL3urGxQcxr0PTaUd18TY5r7XgTVC1IY6b4Qa
   Q==;
X-CSE-ConnectionGUID: Zh3PZPpqTa+M3IHwRVappg==
X-CSE-MsgGUID: v32Kl+SRTQ6hxfEtv5gOig==
X-IPAS-Result: =?us-ascii?q?A0BtBwBRkAlr/5MQJK1aHgEBCxIMZYMZU4EJgRMSiGwDh?=
 =?us-ascii?q?SuIeqAqDwEBAQ0CUQQBAYUFAo4jAiY4EwECBAMCAwEBAQEBAQEBAQEBAQoBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThlAMkBMCAQMSZxIBCHcnBA4NGoVVAwECrhpzAoodeIE0g?=
 =?us-ascii?q?QHgPRWBOIUIg1oBhXo4hEYnG4FJRIFXgmo+hEMChBSCMASDLpkGUngcA1ksA?=
 =?us-ascii?q?VUTFwsHBYElQwMqLy0jDzwFLR2BIzsXER5YGwYFEiAqQENbgRKBA1uBKyZdA?=
 =?us-ascii?q?QIfRC0VgXYCglGBI10CAUZBDgdFUwklPgUSRyQiCBIJARMaLAqBGjU8CSY/F?=
 =?us-ascii?q?QxbDAsaBRpHCAILAgxyKBEQEx0cJC8FFyY8GweBDCcdGxcOAigGFSELQ209N?=
 =?us-ascii?q?xUZAwSBNQWXHQcBglEtCBFfPZJDJYMujiWhfQqEIaIUF6pzmQgjox00hSYCB?=
 =?us-ascii?q?AIEBQIRAQEGgX8lgVlwFYMjUhkP4F6BNgEBBwIHDgMLgWiRfgEB?=
IronPort-PHdr: A9a23:Ki1IqRPTHcuE9eGia6sl6nc2WUAX0o4cdiYc7p4hzrVWfbvmpNLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:5g6w5KJbU6i3ATJ9FE+Rs5QlxSXFcZb7ZxGr2PjKsXjdYENS0DwCn
 2IfXGnTPamKZmCneth2bdu/8B8D68OBnYVnTgAd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea9k3wWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH8gmQrajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1cDBoOD7UA49p+QkQV1
 NwHEg4EdgiM0rfeLLKTEoGAh+wqKM3teYdasXZ6wHSAVbAtQIvIROPB4towMDUY358VW62AI
 ZNHL2MzM3wsYDUXUrsTIJE5gOGlnVH0ciZTrxSeoq9fD237nVYujuiyaIWOEjCMbdsOxGWc5
 Vn8w12nAgEUGcCBlDWi833504cjmgu+Aur+DoaQ8v9snU3WxWEJDhASfUW0rOP/iUOkXd9bb
 UsO9UIGtrQ7/kimZsfyUgf+o3OeuBMYHd1KHIUHBBqlw67Q5UOdQ2MDVDMEMYRgv84tTjts3
 ViM9z/0OQFSXHSuYSv13p+frCi5Pm4eKmpqWMPOZVJtDwXLyG3rsi/ycw==
IronPort-HdrOrdr: A9a23:uOgjkap69yU8jqG5hoCNGE4aV5shLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6H9BEDhex/hHZ4c2/h2AV7QZniYhILOFvAv0WKC+UysJ8SQzJ8m6U
 4NSdkbNDSSNyk0sS+Z2njELz9I+rDum87Y55a6854Hd3ASV0gU1XYDNu/tKDwPeOApP+tfKL
 OsouB8i36Lf3MRYs6nBn8DcdTiirTw/q7OUFotPTJizBOBow+JxdfBfiSw71MzQjlPybAt/S
 z/lRDl5qKsive/yhXN/W7e5ZZblbLau5V+7cq35fQ9G3HJsEKFdY5hU7qNsHQeu+e08msnl9
 HKvlMJI9lzw2m5RBD0nTLdny3blBo+4X7rzlGVxVH5p9bieT48A81dwapEbxri7VY6tt0U6t
 MJ44vZjesUMfrzplW42zH6bWAsqqNymwtlrQcntQ0bbWLZUs4JkWVQxjIMLH5KJlOF1GluKp
 geMCib3ocWTXqqK1bEo2Jo3NugGl43HhuAXww+n/b96UkMoJi8pHFomfD2WRw7hcgAo5Uo3Z
 W1Do140L5JVcMYdqR7GaMIRta2EHXERVbWPHuVOkmPLtBOB5vhke+A3FwO3pDiRLUYiJ8p3J
 jRWlJRsmA/P0roFM2VxZVOthTAWn+0UzjhwtxXo8ERgMy3eJP7dSmYDFw+mcqppPsSRsXdRv
 aoIZpTR/vuN3HnF4pF1xD3H5NSNX4dWssIvctTYSPEnuvbbonx8uDLevfaI7TgVT4iR2PkG3
 MGGCP+Ic1Rh3rbLUMQQCKhL08FVnaPiK6YSpKqjNT74LJ9RLFxjg==
X-Talos-CUID: 9a23:+Cz3M2416iQcv5L9xNssxk5PIvIdamThxTT1eG6YFlxXQaWNRgrF
X-Talos-MUID: 9a23:Om6e9Am41aaa3+lZbqjIdnp8b51L5+eVMnw0z5UWteSYK3F/HDaS2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-10.cisco.com ([173.36.16.147])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Nov 2026 14:21:28 +0000
Received: from alln-opgw-3.cisco.com (alln-opgw-3.cisco.com [173.37.147.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-10.cisco.com (Postfix) with ESMTPS id C442D1800017A;
	Fri, 27 Nov 2026 14:21:28 +0000 (GMT)
X-CSE-ConnectionGUID: c/gGKWvFSjOyzyy0z7V80A==
X-CSE-MsgGUID: IAujRs3kR+iLaF2hnHdT2g==
Authentication-Results: alln-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.27,237,1787011200"; 
   d="scan'208";a="72423892"
Received: from mail-northcentralusazon11012044.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.44])
  by alln-opgw-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Nov 2026 14:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHJOhHzIElzXb29zwYiiY0qfsDBduFsmUe2uOMw4DFIu2vLXQGytzJ6w2cqH6CVattOjeagvcAfEtt82Kx9BPj5eEUNxLBSohtiF1aM5zJSM7sosJdhi4TAygRGTDDdFxhOAWPyoUUYXfmN7DO9qI1J3cHrSv0gwiSiSH3jt/NC+iTclHAIOJave0tlRkm8XwCEiualmAC05RXegL3DGB84S7WCZS/FwdhDU2w5YpqLB6CyVxCWV5m0DUeypWrUfMCNA+kixqOeBfoOhH0D7u9bueYyGAFTVvCFsuBDwpsvVQB+85mpDbLoRyzvOucLAcbwstWyZpT7EY5LCYOB4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axk26ViRj6pmK1qYbkTMdIxRppjqd9pjytkByLqb0hg=;
 b=Fy+oSb0PdcTZNeoCNo5qhSbLg3m6c3ujPMxYUDYh9kFzoKHrYuPVpU/ASPbuXMuWXXW2t5A6+h5p7hWhfuCRFRzby5pJwAGijEx4jKkALKTdgzNoAaKNoDyvSqasiX23nIP/MZdgk4Jve16rABgg/9Mb7nywcA7EHlIGQ3DWe8Cf6NksPPrPQRWe2IT1e7oZlLjO6jUI6MKkUsaFrpDfjro+GMgJ3bQg+tnoIH+nilC6AhbtbESVwnMDJTJD2oVXMrJSk8PbF3F81xGvlAt4sAcdZsfRx8OFeP0rSZudZeWAFQX8s2xImXvx3zvSKo7npsID4JiBv/Z6iEaAhopaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from PH0PR11MB5807.namprd11.prod.outlook.com (2603:10b6:510:140::14)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 14:21:26 +0000
Received: from PH0PR11MB5807.namprd11.prod.outlook.com
 ([fe80::a304:1de4:8e58:b160]) by PH0PR11MB5807.namprd11.prod.outlook.com
 ([fe80::a304:1de4:8e58:b160%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 14:21:26 +0000
From: "Kristian Otnes (kotnes)" <kotnes@cisco.com>
To: "brgl@kernel.org" <brgl@kernel.org>
CC: "bibby.hsieh@mediatek.com" <bibby.hsieh@mediatek.com>, "das@emlogic.no"
	<das@emlogic.no>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "srini@kernel.org" <srini@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "das@emlogic.no"
	<das@emlogic.no>
Subject: Re: [PATCH] eeprom: at24: wait for write cycle before releasing
 runtime PM
Thread-Topic: [PATCH] eeprom: at24: wait for write cycle before releasing
 runtime PM
Thread-Index: AQHdfnm0m+B/Fb0hoUKdkgpjeAaWDA==
Date: Fri, 27 Nov 2026 14:21:26 +0000
Message-ID:
 <PH0PR11MB5807A1944E52A7E9DA0732E8C8412@PH0PR11MB5807.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5807:EE_|PH0PR11MB5783:EE_
x-ms-office365-filtering-correlation-id: c80acea3-f19e-4428-7c53-08df4c91b8ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|23010399003|366016|38070700021|10067099003|56012099006|11063799006|261022105027099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|18002099003;
x-microsoft-antispam-message-info:
 2GP5QMSMBD1OaKAqVTamebRA84tNFg7mYPblQqSBdhR+W2LVFExIUFOkF/+cvhCSiWaT4yqewiFIKefdEFR6f3VcQ4my2iqmlcVh4KKHpFkVbjluCqFezdwz/l49tsj8YIUWYuP43JQzObu6ri8RgHWyidV20fgnDOakH9ZiRPL3rnqbtEbQ7XeoLTf/xgMsrKGqHsAF1pwC3/ES21bQSrBWeGBGyMPmpNzb+7Qtq73+XWTnK8YnllFF+6F5F+6ya/BNq/JeyPwEKyZydZuhHEbRalQuhj3P8dm+0S+DOfQEDpp5X2uqiuydzrNxItqLu8C6Nds0/p7ahro0XiCkXUpPS4X+emKzW/QLTo1AlKg/WlupSQG/dl8VWsZIk+gi0p8dO2X8kPoLuKPKhhb7ShX20740YLVVIh/mOPYB0J5NXTt21UQtDNFzZf+OSpBay1VJCwYIhSatPjq2ygCXUaXFwbaNKO/n+zp7OivG66gMRHUvlM8/MR5mrlcZth3REvBe7WLHcV+M+snGhtyRhV1QklN25snFIwQHvSwG/mjXWhJKwCV1lLszlnO89Z5TXIDXYY+slFI0HgkSHwXpw+vejgoDHI+w0+mX2LdSUVN4wFLBX3SHsCXXiAsj4BQ5T5K0y4JjdtzZpmm/HFY7Y9DCGCN1deqvUG2+y5ZRevrRqDiGnALjWRr09dgUYgvBS614FLCIyxBD8gsnshIW2sg91ORVdcOm+kuAbANY4SQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5807.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?d2ICSLYqFB6iVH+5bt6RjzXzsKVRQDuqdhsYFjepd8IVemupZ6UyMAhdmH?=
 =?iso-8859-1?Q?S4gtM75ODS1koFG2GRD1sAMMcFuaJGq/Yl/FxmVMRibXS03mmaM31Raa28?=
 =?iso-8859-1?Q?ls+Qizn76iKmQjqYmdAuhLjSPMePdVfIk5OB0eraPMDnr1nI5RzkATaOLC?=
 =?iso-8859-1?Q?UVmUC3BLz9uGGouh4N7XMQzf35XpWFdnNqvRx0NPKynEew7Z4+tpB1gXwv?=
 =?iso-8859-1?Q?4+rKOTM2QzHqxQT90jNUvWPdJv+6UuLaK6fEQ8AdHFbfkP11YY4JB2VdIY?=
 =?iso-8859-1?Q?0JmaA0brNll+DWlMeVFxvJCepL5t/pIDcqdDRsrO8OVUqDbYg0SPQGOXGj?=
 =?iso-8859-1?Q?P/75fqOPe8uWtDUqbMW4mua1r1+tcE4q+ifOOG/ZyilTJ1SfUWRHeMJmAs?=
 =?iso-8859-1?Q?Y0t5qrRFVC5eTpiwqAFOqXk2Psk1Cf7hsSRQIn1tLHimW+JeS5PSBhvhhc?=
 =?iso-8859-1?Q?JOtQidK3E6gziQi5q+UDs34/fNqqV3maLEyK9yk3Llhfbwvrm5hai6d2PS?=
 =?iso-8859-1?Q?/fxgbmXqZruiUJSKskSyH8nfSlstwtbM/NEFxe4baGRZ4DWm4nWF0hpnkr?=
 =?iso-8859-1?Q?9fgPud+zeMeDdh9+fJrfTblCublVN7GjryH2H98Pn3TlI7N6Zt3lRX4YNv?=
 =?iso-8859-1?Q?yOt074Ki7Td/pD+hBlOt4oszJYg+1Qi8f4reed8WD8tIDt4CORm24paAQS?=
 =?iso-8859-1?Q?nIIMnja7z51w4C+V3KZ4i+d8Q/d7lsJDiGCX3MwZxZY2pSqgP1rddjKfiH?=
 =?iso-8859-1?Q?DoKPB6sNTeZlJnt66+bUx6viBr32Ik9HCpUb4Z7qb9yAJWY76DsbJ9wXKD?=
 =?iso-8859-1?Q?PJ/g1dEj2GRbTB6/azHaeXxRZzACBLqZc+oRNzZN13B8iFxCF7w0VP0/2G?=
 =?iso-8859-1?Q?CIKWYvICrsBbTZgverLIJWUFrJtDsMkKhrssbTX4PjXpgH1B60y3wVSYCy?=
 =?iso-8859-1?Q?mtjMOLpcQn+MMAOAoa/WeNgXaxTnmkQsZTpDdIMAvqFa8Tala/9d/ID1uT?=
 =?iso-8859-1?Q?wr4JROMB8xVOzzBLeRyPDBAlRsB4OEDL8sxr6ztoPnnsYqufgep8TEIQRr?=
 =?iso-8859-1?Q?fPfANkn2mi5mw5/K4AF1fK9i+JEx1IlCZYqjvtn2QY3LF0nIucxWSMTK1M?=
 =?iso-8859-1?Q?Tq0sXznEjYJA4gkSKEpIoiuapYupUQMmumv89avvMdaf2AXY9HKj5oDSJf?=
 =?iso-8859-1?Q?gkXuZ4PHYh0mLgVLQwWmnzMYCBC8yxa37xX9c+ukW4lX2nWOz3zDALulV5?=
 =?iso-8859-1?Q?gAOR2K8fH59JtbCbcKaH3hAmMDFu90uNSKCNw22btrA5zD4aB5cwvNBiMG?=
 =?iso-8859-1?Q?tsnhXOq0ewdT0goBMW94BSupv6p7yfkBDTOR7ZdLZ5t1PkPA7j2TFSXOW1?=
 =?iso-8859-1?Q?S69lNiiCFYWakkv7q4YdARSbgnsqAgAImjk/0+q6rhjQc92zP9wb9GUL1x?=
 =?iso-8859-1?Q?omjcJXaJhprm7BJrqzduzTCqHS0sqvx1atmZZfc/lLos3jHF1lhK5Yqq+P?=
 =?iso-8859-1?Q?cQdNskvxuRO8zJ7aTRmNV2c4wimcTC0lekvy1JEe397bjjgs2M7uDSHo4J?=
 =?iso-8859-1?Q?WVQXl8fP1kxy8LmosXujrfvKoE/a5M+ykq0F8hq2HvQsiblGkEn9E2do57?=
 =?iso-8859-1?Q?RwDDCWtj2cmEwW8daXQNyZufrpcr9F/B2iX0nhkLkM8tGUf8BfN9q+PmHZ?=
 =?iso-8859-1?Q?obsu4kUKTyPgyFduOqG2biSKS4dEmagr03WIXN9X33o+dUB9Zbg7YRrr3C?=
 =?iso-8859-1?Q?QUmqvK3Pq6i29IrU9bRuiWWwT0our55nP4jvBtn3YvD5Ffd6WTlUZBUVJt?=
 =?iso-8859-1?Q?td8sQmVd1IsKn5cQOCoVLyHrc16bGKqOgBntP9Sf71YGoa0fAC1e?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fRH7D42S9a8/RCgI+lyhopVigWq3lf1/RplVyb2hEPK2vJZvBYM3IGjvp3KnjVVQYisnQ/B1JUfccQu8+Tm20N5eFCdII1uaqImOckzbQsoIf9eq93Iu5FMs6FpxeCQILZ09s8iThzXTeu4K9oyHxfaZgpdE+Csbql5m3bcP/4EHzee30nvNh/hKpw1Bb6a0hQ2xrBdeku3E6obA6JIk6AFea2kFGTyBpFJcDuqgAiFjwixkf0FP0SgVRuSuHBheBKe0V50Y7ZZ5eKS5+KM5sxN3iXNjOW+bSs6gef45oV5nSvFByOLi4xHkhys54KAylI84oXtf5Q7m/rhyZmeFDQ==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5807.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80acea3-f19e-4428-7c53-08df4c91b8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 14:21:26.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NltC0/FMneBrTlYbM2lyTgL0LowoY1yX+pzRE9w0r8M8nvVtu52Qukpo1lAwS9xT08h7vNx4g8UVtjJ8T6Wk3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-3.cisco.com [173.37.147.251];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.251, alln-opgw-3.cisco.com
X-Outbound-Node: alln-l-core-10.cisco.com

This is ONLY a check for a detail on this patch, in case it has not been co=
nsidered. It is not intended as a vote against the patch:=0A=
=0A=
The at24 driver is presumably very old and was designed in a way with check=
ing if eeprom is accessible BEFORE reading or writing. That takes care of t=
he delayed internal write process. One can speculate why this approach was =
used, but it does avoid delays on occasional writes, since no wait added af=
ter final byte/page write, and potentially completed on next later access. =
The question is, should that concept be changed by now always adding a wait=
 after a write?=0A=
=0A=
The subtle problem documented for causing this patch was caused by the PM s=
upport added much later. If one wants to keep the original at24 design beha=
vior, maybe one should look into how PM support to driver is handled. Eithe=
r look into if PM autosuspend can be used or possibly only add a delay/poll=
ing if the device is under PM management (ie consumer registered or somethi=
ng).=
