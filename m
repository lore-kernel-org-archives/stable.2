Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BA3B42F7;
	Sun, 11 Oct 2026 05:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791694931; cv=fail; b=AEE3cbQzamQAX59wTABCyZru6tYAKPuT1nsI7puGythrp1KhU3dHdGbmbtkgApWBWHXresqPcKxpPnEoecK3wpBHbotsIwO2UrDoKOTjkNatdbbgy1Me41aVjLRAAeWD7nK2QPV7IHCDDPWLHvc19N1AGnrDTb+AKzxrU8urP/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791694931; c=relaxed/simple;
	bh=6pyZk6MfJYCHUSQjo3HypY/zRaO7BPy3CcQbm5sgtDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=llRxNeHPtuN/Y0M3SaH6zTsQqWXmBTtE34sCIauiIfXjBf+l2gB2KienzUSoQtH+1PDNeaUDL8bSI8NlAgeimNiNNJKY8YprGIqX628uGXZZ4fsHWrn1XIrzJ/r35tMGLiu3ADDwoSKHJS3vSwoRMHKDjUp5wIE1NTG++z8IAdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8P/omFc; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8P/omFc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791694930; x=1823230930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6pyZk6MfJYCHUSQjo3HypY/zRaO7BPy3CcQbm5sgtDM=;
  b=i8P/omFcqHe/DZoF8U5+6xuxeYKouZBN9Cxi9VTd8dJOSNfZaapnfQ1o
   s91hSyg6AGvrIG4OZwzwdVWz3v+1rGwS7rKisBuX62hJn6SspVLRQ7erZ
   xa2XG8egqBeGRFWkn1qkxMluUlCo38DHmAcN/Nu8b2/FAmpdQrtHDePMV
   KGMqLyK8l6B/NMJeIxstVTuPTUi6GEcuIFzkRRFQJh6m2FQi+LkzijUKg
   B8o2M9L0dHjnJQomhePjlcMS/loF+ESpNOE6CvesDikbLrg1sgVyPgmZ0
   anhbOWlMeWqeUeQcmFDkWSvfiteFd1zaaQ6OpwGMc8mT5TV+6u0R/69mP
   g==;
X-CSE-ConnectionGUID: j+oxxWIhRYqiQTUsWArF4A==
X-CSE-MsgGUID: wbrXWSVJQs+wL+PiPPXfXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="336962"
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="336962"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 22:02:09 -0700
X-CSE-ConnectionGUID: j9sUce0ZSvSPbVbuZJY5CQ==
X-CSE-MsgGUID: EKeVxCInQwq5k1v4PLS2Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="948963"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 22:02:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 22:02:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 22:02:07 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 22:02:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NecfexZQnzZkr4n1icLzI+6lSgp4fvj3Geu5Wm0AKZD3ezLKtwLAglmoTOq/Q8tDlak73sbcwl9+zZM9P8a2FS3NcdM1vimq3stxKxejQm9O9FwIVL8HW1cQ5wBBIzftfFZJaab1Zo0HJ9bEB4APl9SwtRl0QRq4G7HjpN/gq5PN21zqDTPimcXtdwZQrXrDKVGpi3IsHqsnqmfh0H2vCzOTsWRxedkZVeMKTqykY+msiDKPHuzhryQyPeN74YsDO1pxQeor65cSMtoZKi2a5mjFyzwcSiky8YXaYffSx20R5gR4yuyZ3Y/6nw+6BPCyyRJFtz1vfFR4TzXqQaj+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pyZk6MfJYCHUSQjo3HypY/zRaO7BPy3CcQbm5sgtDM=;
 b=Lyvr7vVCiJsVi+9fXkdabT1AXC+LlPs80z0JBvPSvL2Onkk8fClGF0h1FK6s6z34D+LvcJ7xgAmWR21D8Hw39pIWYGSJ7SrOl2IVd22DHytMGy77Un7gQkPB0noPFwZwo7PoPFBIgaujW6JrBzFBtyJx8fKVS4A5T6yNBGcl5p4MrSjbLIugpugmRO4DRqX+p+UsYp4A90lXa+TVk/T16wc++9Ya6t12+vXRJcyEOQPTBUJaQ6307Ohq5mSUv0+MdtquWmBpR/Qw4K1nmDT6EszXnQ7ICtsk58oa0dqyvrC1hxbgTMpzEcVXsx0BGJzWybH7oQFB2YcZaH9wzo+kPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPFE241D7F14.namprd11.prod.outlook.com
 (2603:10b6:518:1::d57) by EAYPR11MB9969.namprd11.prod.outlook.com
 (2603:10b6:303:2d7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 05:02:05 +0000
Received: from PH3PPFE241D7F14.namprd11.prod.outlook.com
 ([fe80::4ea1:23b2:56c4:3c54]) by PH3PPFE241D7F14.namprd11.prod.outlook.com
 ([fe80::4ea1:23b2:56c4:3c54%7]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 05:02:05 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: "joe@sudmix.de" <joe@sudmix.de>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Usyskin, Alexander"
	<alexander.usyskin@intel.com>
Subject: RE: [PATCH] mei: me: do not bind the 700 series PCH-S xHCI controller
Thread-Topic: [PATCH] mei: me: do not bind the 700 series PCH-S xHCI
 controller
Thread-Index: AQHdWQ1rU3Lep2nbxkKgzGlDRTmqprb3wCnQ
Date: Sun, 11 Oct 2026 05:02:05 +0000
Message-ID: <PH3PPFE241D7F14547C40AC43A8E68ACB96ED902@PH3PPFE241D7F14.namprd11.prod.outlook.com>
References: <20261011-mei-xhci-v1-1-38c28b5f3f99@sudmix.de>
In-Reply-To: <20261011-mei-xhci-v1-1-38c28b5f3f99@sudmix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPFE241D7F14:EE_|EAYPR11MB9969:EE_
x-ms-office365-filtering-correlation-id: 52b40965-f1fe-4fd3-6432-08df2754cb6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|23010399003|11063799006|38070700021|56012099006|18002099003|22082099003|6133799003|261009223027099003|10067099003;
x-microsoft-antispam-message-info: IbB+/nKqSYj5gIS3YTuoGkm2t7HvhsnIiutSDl9o565ecIQtwlJyR+DFOHXlEEHhEXKcEoLTDW8UnzVfmQL57L3lyBzn05fmtA93MJk4ljpckT6btiAVhhPf27UwALNzGjJrx1vz4IpciJiPKYNwrmSQHsbppCLCcyi9ADkZOcK8o8EkmM1ol9880JBIog5BqSJSb8Gws7opuTbY5toUOBE+4f9kC1GY7ZKA69M1EYh53aiyv5p+gna+NBuSAzYm8zhdoQTg8J8nNaCqniE45VZPIdPmR4b524/t1HyVoPEUDIWoZRVBgzqRBp70k+TtR4L+3GnYWcufLghGFjYPDoubSOcxnaMu3CGnP4mtRJMGF/b1Bd3enpiBSgJc9yO/k5p1Axf0547lo+4m6N4K8/1M6BQGCrDx071NYOcO5k6ezrQXOJa09gg6jQK0nPluJDZtLFs4rjSz6iamvoDe/anBWzQoU+8CrAooRRXspRPvr/D5HCbnC7uLLif3P/5nRAUzCig76YLwMFb1jqYfUvKAyXvLX/my3pTzq5X+T4h/rGbZVzPW833DIkJy42ZNXEI+aPmGz3jan0o9QcpdEwEDQfQ44MgeUKRQLm5CX3n+vyMctvNcRGVLMjNa5G3X6j+cvYxe6H5fVxOq5b7k0XzLn+zvgPLlKzRVTG5YGwEUagcBh7Hp2YOx3SRpLD4kj5ut0YcM9BeKAgKt5ObKKvSB/HsQgnrCrIzdjFlK90o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFE241D7F14.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(23010399003)(11063799006)(38070700021)(56012099006)(18002099003)(22082099003)(6133799003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUtTeHpObHcvbHJISWJLTUo3a1ZnMkx0ajd1eFFTbVJBaDFBZEJSR2RaZE1p?=
 =?utf-8?B?ZkdNVi9ZSXQwaHhjOS9XcmtpMnJ6Y3pCZ2JYdkVzYk54UUFjRmhZMUdZTmlx?=
 =?utf-8?B?ZkxiQTlsN0hkT3RGRzI2ZElkRjB0SVR1L01ISDdyZmN6ZUh5VkF0ME5xcTN0?=
 =?utf-8?B?ZkVzMVNnR1ZrTXFhT3NGRGx5bXNDdnVpbE10RTRyeGpVdG5FRm5kSnJ1WldH?=
 =?utf-8?B?N0FVZDAyN0pzMWZKQjAyUW9FSkpocFJBdGViWENhS2gvWkFDamdjeE9vTFpm?=
 =?utf-8?B?eEFlKzM1QWNyM1d3cjN4Zjk3aGdWQm5xVmtnT1M3eWZEVkE0Sm9ieFBhbFND?=
 =?utf-8?B?RWFibTFXNHQ5elNiUzVoSlVKSEc2Tk1MeXVhdnovWGdUbXZSdDY0aVk2WWJL?=
 =?utf-8?B?ejlSd09wTjBGVi8wdXBNeXBCL2s3TEpBMEc0cysvYjlXM1A2MzV1V0N2WFp6?=
 =?utf-8?B?TWpOVjh6eVBGOUtyaWNWdlBScmFmYXpoSlVnTHFCdlk4aVRibG9pdjhSRll3?=
 =?utf-8?B?VHczSUZJWnBIK1hNOGk2aGgwMGErbkJTakNTTDZaQWpMZXg2NzRvSkMvbE9F?=
 =?utf-8?B?N3pzVG1aWUtwRHNJWGJ5b05NOFF5T1JGREsvc0xWckRPdGpEYlp1UVoyZW4w?=
 =?utf-8?B?SWFDczg3ZW1qQmhCTEZBeWtLYllOdGVBejBtYlJmbldWbTRrWTgvTmVOazBy?=
 =?utf-8?B?ZERSYklxS3V1TVFLYldaNHJESHB5dGhyb1M1T2wwNG1kV1VPN0N0MmxnNXo3?=
 =?utf-8?B?MDViTXVvdUZFVDdxS3hVUjN3MzdGMW1UZHk4d04wTFNVQ2JVY2NvZWV1c1ph?=
 =?utf-8?B?T2dsbDZkTFFRV29xRTJORjluVjIraEZiaXdrcldLeUZKQjJLZ2U3R1d4cUh1?=
 =?utf-8?B?ZHhhblJuaEpWdllBSStSWE8rdUpmWnY3SUw3Y3pTaTlWSFBCZFFYbGdiL1dN?=
 =?utf-8?B?Tjc3eGlpZTBWdm1yeXZscmRhc1h5cU5TZDkyRzc3TDlna2NzWTd1NXd4b3hx?=
 =?utf-8?B?bjVpT2tYb3FvVE1aTk91L3hKUUdTUmJSMmtFeE1ZZGJyN1gwbFU0UkhidTRO?=
 =?utf-8?B?SXpoeThaVUV4RFFWdUIyK3Nva1FwcFFlaVRUclNBM1ZmMll5UHQrZ1ppNW0y?=
 =?utf-8?B?U1FRdXBqY2dhU0t4MThWREE2clRVd003ZkZVZmJDbUlJMVFNWVJQMmZmcjJG?=
 =?utf-8?B?SG80VDYwaU1OSHlsSWY5RjdQN1R0dFJZUzNpQ3dFTmRvdjRkTmJtSDhIQy9z?=
 =?utf-8?B?U3VGZVc4ZTdFZnJaVTFHWFBPRUVreDhaMXgrb0wzVGpiOHhHNnFVOG1jdjMv?=
 =?utf-8?B?em44NzBQSXhkVzBZaS9KNHhPTkpqcUNOcTZWSlIxQytqNzZOVGkwY01iUVBj?=
 =?utf-8?B?Ymt5UmVCNHBvb3E3YnowMk9UTEJBWDY0cVg4VFJPL3Y4ZHdzQWEyUGZYOVRm?=
 =?utf-8?B?V3pEaUc0Q1QzbDlRaFF4cmRnY0dVNk0wcVNFV2JYbGd3RHRmblNkamI5eEtB?=
 =?utf-8?B?cmJxRTNpTHpGSUw3Mnp6QjgyUFVvMzZ3Z2hqOWV1RXZRYXhLcERqRmpkczVB?=
 =?utf-8?B?alIyclNXYVdIeW5iTm9YWVdSaW9TcnB6Mjk3NGdBS3J0eTlBRGlPei9EeGVT?=
 =?utf-8?B?dk1PNGZkTjNMVlAvNU1hTzRtczU3bVMwL0JXSG1vblNwRDdrbnFXSklBZUFu?=
 =?utf-8?B?bnR2dEN6MFoxdGNWM1dVUlJ0STUwQ0wxaXlaVlErcjhnV3kzeXQ5N2l1Ui81?=
 =?utf-8?B?Zi80aWY1alFsbnJvcGV2bzcvOWRFWXhScy8yMzRMTFVHTUdWZHNJeDNYUWJB?=
 =?utf-8?B?ekhvbjdVYVlFektTYmFZMVZRVnd1VmxJT2MwQzJSRFZqTCtPc09HbUgyWFlX?=
 =?utf-8?B?ZFJTZTlSSTMrS1VSSERSVFZQNm5ScEpBVnN6dGJZaUllSzR5U09CRkVOdlRy?=
 =?utf-8?B?ak5XYXl4cmxhYTRmdjU1RVNGcURRRnl2a0Q3cHFXOU0xOE5sY2VpTDRoYjk0?=
 =?utf-8?B?TDNQa0FJZXlYMEpBMkl4NFp0SW1wRTV0OE1mMDhVNitKMzlwd09UeFU1bDQ0?=
 =?utf-8?B?QWh1K3dieDB3cHpXcTFaaVFhOGdXTy9VYW1DbjJGY3l5SHdOQlFFZGFzc1pw?=
 =?utf-8?B?b3pQQ0Q3cVFxa3JqRTh4d2JRT1VPbnhBbzlYTlQrSS8xOGRzZG90Q1hBdmJo?=
 =?utf-8?B?YUtncWNPanJTVjlVckFoMmtXUU13ZlA2ZjJtbVRBZGRudlp5VGFSOGdlMmN3?=
 =?utf-8?B?SDFFSUpKd0RoZytYbkF1VVp6MExhSFNZaTg4RVBzV1FiVGZ0UWpzSTBnVW43?=
 =?utf-8?B?THd6K2lYb3ZqQisxaGcvTnBMMFAyOE9yTDBTSkRlV0g3dithcnVqOVR1aG83?=
 =?utf-8?Q?FqRnFuMOZ2Ln2p73H0MqDFJIjrZeBGieyjz3ngbkuUjpr?=
x-ms-exchange-antispam-messagedata-1: KxbEC3b19gdc8w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wkF2rylmUN5QGAjZ1k9BK081QLZWBNO0JFCTx5ILV54/E9aAKZ7JQ4uQXSwX7C65lT6T4kr1YJyP0WUmIVpQvmC27g6yYvki56aUFhru+DvtQ7GBJ/OvB3FMUtOM5Wj0Ke4vpxTkmTu+cRpWBYiJpV/QWpJV54mr+y583BQOMtjXy2yL7V2nJcNCuL6T/0WcLW0y1rXQx5BpTJwjpdBGLsLkIrSnXyABozx5aoESbTm4DKoEI+uA6GlaTRdCt5EBAYkvqerRRQ1x028tqpB6m5huadP7JRG57bt0b76tXjUXbZGJOcwbTFTzjdHirtCNBsB7tOU9H8b1vieDtp+KoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE241D7F14.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b40965-f1fe-4fd3-6432-08df2754cb6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 05:02:05.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/0HoNzewPVP/1he5rydAiz86nJDfEGQmeU/F6oWdzLK1jRh7XKbxBx6RGLHl9PkL2OxHYyY+JZ7fo+/06UnMaCQmGKwJFUiVk3phJsijxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9969
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0hdIG1laTogbWU6IGRvIG5vdCBiaW5kIHRoZSA3MDAgc2VyaWVzIFBD
SC1TIHhIQ0kgY29udHJvbGxlcg0KPiANCj4gRnJvbTogSm9lIEZpbnplbCA8am9lQHN1ZG1peC5k
ZT4NCj4gDQo+IFBDSSBJRCA4MDg2OjdhNjAgaXMgbGlzdGVkIGFzIHRoZSAiQWxkZXIgTGFrZSBQ
b2ludCBMUCIgSEVDSSBkZXZpY2UsIGJ1dA0KPiBvbiB0aGUgNzAwIHNlcmllcyBQQ0gtUyAoUmFw
dG9yIExha2UtUykgdGhlIHNhbWUgSUQgYmVsb25ncyB0byB0aGUgVVNCIDMuMg0KPiB4SENJIGNv
bnRyb2xsZXIgKGNsYXNzIDB4MGMwMzMwKS4gVGhlIEhFQ0kgZGV2aWNlIHRoZXJlIGlzIDgwODY6
N2E2OC4NCj4gDQo+IFdpdGggQ09ORklHX0lOVEVMX01FSV9NRT15LCBkcml2ZXJzL21pc2MgaXMg
bGlua2VkIGJlZm9yZSBkcml2ZXJzL3VzYiwgc28NCj4gbWVpX21lIHByb2JlcyB0aGUgeEhDSSBj
b250cm9sbGVyIGJlZm9yZSB4aGNpX3BjaSBjYW4gY2xhaW0gaXQuIFRoZSBwcm9iZQ0KPiB3cml0
ZXMgdGhlIEhFQ0kgaG9zdCBDU1IgaW50byB0aGUgeEhDSSBNTUlPIHNwYWNlLCB3YWl0cyBvdXQg
dGhyZWUNCj4gaHdfc3RhcnQgdGltZW91dHMgYW5kIGdpdmVzIHVwLCBibG9ja2luZyBib290IGZv
ciBhYm91dCA1LjUgczoNCj4gDQo+ICAgbWVpIG1laTE6IEhfUlNUIGlzIG5vdCBzZXQgPSAweDE4
MDAwODQwDQo+ICAgbWVpIG1laTE6IHdhaXQgaHcgcmVhZHkgZmFpbGVkDQo+ICAgbWVpIG1laTE6
IGh3X3N0YXJ0IGZhaWxlZCByZXQgPSAtNjIgZncgc3RhdHVzID0gODAzNDAxRkQgMDAwMDAwMDAN
Cj4gMDAwMDYwMzIgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCj4gICAuLi4NCj4gICBtZWkg
bWVpMTogcmVzZXQ6IHJlYWNoZWQgbWF4aW1hbCBjb25zZWN1dGl2ZSByZXNldHM6IGRpc2FibGlu
ZyB0aGUgZGV2aWNlDQo+ICAgbWVpX21lIDAwMDA6MDA6MTQuMDogaW5pdCBodyBmYWlsdXJlLg0K
PiAgIG1laV9tZSAwMDAwOjAwOjE0LjA6IGluaXRpYWxpemF0aW9uIGZhaWxlZC4NCj4gICB4aGNp
X2hjZCAwMDAwOjAwOjE0LjA6IHhIQ0kgSG9zdCBDb250cm9sbGVyDQo+IA0KPiBXaGVuIG1laV9t
ZSBpcyBhIG1vZHVsZSwgeGhjaV9wY2kgaXMgdXN1YWxseSBib3VuZCBmaXJzdCwgd2hpY2ggaXMg
d2h5DQo+IHRoaXMgaGFzIGdvbmUgdW5ub3RpY2VkIHNpbmNlIHRoZSBJRCB3YXMgYWRkZWQuDQo+
IA0KPiBNYXRjaCB0aGUgZW50cnkgb24gdGhlIGNvbW11bmljYXRpb24gY29udHJvbGxlciBjbGFz
cyBhcyB3ZWxsLCBzbyBpdCBjYW4NCj4gbmV2ZXIgYmluZCBhIGRldmljZSBvZiBhbm90aGVyIGNs
YXNzLg0KPiANCj4gU2VlbiBvbiBhbiBBU1VTIFJPRyBTVFJJWCBaNzkwLUYgR0FNSU5HIFdJRkkg
KEJJT1MgMzIwMSksIGk3LTEzNzAwSy4NCj4gDQo+IEZpeGVzOiA5MzBjOTIyYTk4N2EgKCJtZWk6
IG1lOiBhZGQgYWRsZXIgbGFrZSBwb2ludCBMUCBESUQiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBKb2UgRmluemVsIDxqb2VAc3VkbWl4LmRlPg0KPiAt
LS0NCj4gU2VlbiBvbiBhbiBBU1VTIFJPRyBTVFJJWCBaNzkwLUYgd2l0aCBDT05GSUdfSU5URUxf
TUVJX01FPXkgKHRoZSBsb2cNCj4gaW4NCj4gdGhlIGNvbW1pdCBtZXNzYWdlIGlzIGZyb20gdGhh
dCBib2FyZCkuIFdpdGggbWVpX21lIGJ1aWx0IGFzIGEgbW9kdWxlLA0KPiB4aGNpX3BjaSBiaW5k
cyBmaXJzdCBhbmQgdGhlIHN0YWxsIGlzIGdvbmUsIHdoaWNoIGhpZCB0aGUgcHJvYmxlbSBzbyBm
YXIuDQo+IFRoZSBwYXRjaCBpcyBjb21waWxlLXRlc3RlZCBvbiA3LjIuOSBhbmQgYXBwbGllcyB0
byBjaGFyLW1pc2MtbmV4dDsgSQ0KPiBjYW4gdGVzdCBpdCBvbiB0aGUgYm9hcmQgd2l0aCBtZWlf
bWUgYnVpbHQgaW4gaWYgdGhhdCBoZWxwcy4NCj4gLS0tDQo+ICBkcml2ZXJzL21pc2MvbWVpL3Bj
aS1tZS5jIHwgNSArKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvcGNpLW1lLmMg
Yi9kcml2ZXJzL21pc2MvbWVpL3BjaS1tZS5jDQo+IGluZGV4IDc5MGE0NjQ3OC4uMjZlODkxNDBm
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2MvbWVpL3BjaS1tZS5jDQo+ICsrKyBiL2RyaXZl
cnMvbWlzYy9tZWkvcGNpLW1lLmMNCj4gQEAgLTExMyw3ICsxMTMsMTAgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBwY2lfZGV2aWNlX2lkIG1laV9tZV9wY2lfdGJsW10gPQ0KPiB7DQo+ICAJeyBQQ0lf
REVWSUNFX0RBVEEoSU5URUwsIE1FSV9FQkcsIE1FSV9NRV9QQ0gxNV9TUFNfQ0ZHKSB9LA0KPiAN
Cj4gIAl7IFBDSV9ERVZJQ0VfREFUQShJTlRFTCwgTUVJX0FEUF9TLCBNRUlfTUVfUENIMTVfQ0ZH
KSB9LA0KPiAtCXsgUENJX0RFVklDRV9EQVRBKElOVEVMLCBNRUlfQURQX0xQLCBNRUlfTUVfUENI
MTVfQ0ZHKSB9LA0KPiArCS8qIDgwODY6N2E2MCBpcyBhbHNvIHRoZSB4SENJIGNvbnRyb2xsZXIg
b2YgdGhlIDcwMCBzZXJpZXMgUENILVMgKi8NCj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9J
RF9JTlRFTCwNCj4gUENJX0RFVklDRV9JRF9JTlRFTF9NRUlfQURQX0xQKSwNCj4gKwkgIC5jbGFz
cyA9IFBDSV9DTEFTU19DT01NVU5JQ0FUSU9OX09USEVSIDw8IDgsIC5jbGFzc19tYXNrID0NCj4g
MHhmZmZmMDAsDQo+ICsJICAuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpTUVJX01FX1BD
SDE1X0NGRyB9LA0KDQpUaGlzIERldmljZUlEIGlzIG5vdCBhIEhFQ0kgb25lIGF0IGFsbCwgYWRk
ZWQgYnkgbWlzdGFrZSwgaXQgc2VlbXMuDQpOZWVkIHRvIHJldmVydCBwYXRjaCB0aGF0IGhhdmUg
YWRkZWQgdGhpcyBJRCwgSSdsbCBzZW5kIHRoaXMgcmV2ZXJ0Lg0KDQotIC0gDQpUaGFua3MsDQpT
YXNoYQ0KDQoNCj4gIAl7IFBDSV9ERVZJQ0VfREFUQShJTlRFTCwgTUVJX0FEUF9QLCBNRUlfTUVf
UENIMTVfQ0ZHKSB9LA0KPiAgCXsgUENJX0RFVklDRV9EQVRBKElOVEVMLCBNRUlfQURQX04sIE1F
SV9NRV9QQ0gxNV9DRkcpIH0sDQo+IA0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBjMjZjYzk3
OWUyOGY1MTkzMzEwZTQzNzllMTRhYTY0MTczNzVjNTY1DQo+IGNoYW5nZS1pZDogMjAyNjEwMTEt
bWVpLXhoY2ktMDI3NzJkMDUwNmUzDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IEpvZSBG
aW56ZWwgPGpvZUBzdWRtaXguZGU+DQo+IA0KDQo=
