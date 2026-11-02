Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793658308;
	b=EnMm9b4MY0vrOjdjZjYnv4Oj8XTTxUuPeyGmT9bR25cbnZClW455y7nWOMuf2t7yW6kc
	 zWtzJ3qTpeLPn/7U+1Q/kGxh78QqP9xDCp0pgoTEZdtTPolVX27vA+thxATd4rYhbG18Y
	 HUaBpVd0wSh7YK1jAZUl1o4JGBH/O2zH/Gxs0mZm0zKBuDlRx9X5PfBe/dn2UKb23hsIb
	 GWPrDl0IeGF0U1FqfCQgzQqJju3W4vSfk9LbM1lN0k8Y5cGccseNA3TVEl/zR0KBKZvq0
	 94Ac7/4ywpl3VqvnkI5sV8dxt2JXs7AI5C9A8uTG1ccPC3imWcLvYndFbxSO7vga18g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658308;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=PWwIj7noKH1Xxo7gvdMprlSFrHHHy7S97Ew6bmfXI5Q=;
	b=mSI7dMFPn4CbbnQK4q/kwmvSCc1BmouFIZdWpNEwOkUwyxg6sNS8GHkHJUj1c14gWE5E
	 KVlSCaGb08erL61OsGVAJ9eYXR+VI6QUljh4qFSKunL3mY4xkkFrDLGnsa9I7GuN1u6Wf
	 B61zdjXw2VsSF1wGzyaOvts88ChZQLQit4Ib/WJ3FFF2AcAdrPQfUeo1yYDx0l0bvl5st
	 Pu6vR1HAEFWEfXd7z8bb1s0aEz7hE6JSLPgpGOm1BL+b70woVEG4xPdIGr+OKQwmTtn+R
	 Tx1OLNW8SarJ1ARvqNuDoP5pcK6P/8WfrpmR5L90/D7gvK9IHu4PpyshED48+cZ/LuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hcTGHx0o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81F606A327;
	Mon,  2 Nov 2026 22:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF81F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hcTGHx0o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793658307; x=1825194307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PWwIj7noKH1Xxo7gvdMprlSFrHHHy7S97Ew6bmfXI5Q=;
  b=hcTGHx0oTafhzee5Kbt4v7uQSTGncUU9k2ak1R8q4WoGflxBMe6BL0ut
   vD4bHzcv/RVRVUdxWJaMJAMWjLU0iGHfooaB1KXxssLdLQLhoRTKaizRh
   0TWfmyyk18TAJUkZCkmjwHBxVZzspCrd/q30UGK/+9CSrvhmfl57bMH0d
   3remQRmPqfrIxYIt2xuH5N3QM+9OWj0U6oQoPmCagk3MfFJgxt0Qt5NuO
   N6eyerWaiIXnTISMRrM8S3xonZl8ECS2P6UBweyI3CMrIbX7yHIeIH0EZ
   vKHkP5ef97D3X9jDbS/kuIBMMIpzHF461xlplsAibSzuOVk+xySAW9U4M
   g==;
X-CSE-ConnectionGUID: i9v2aIriTJ+QxOLBND+NXw==
X-CSE-MsgGUID: R++jGCzJR1iXtnkBzhJ6Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2267565"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2267565"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:25:07 -0800
X-CSE-ConnectionGUID: 3QBZ9QiiT7qzjXS7yeZXDA==
X-CSE-MsgGUID: cw+E0HypSgqhWYp61+EXfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6333137"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:25:06 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 14:25:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 14:25:05 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 14:25:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei5h3wVDNd2wEuR3z1JL80t3jQHwBiAvHNyK9tqEgouHnrbxzyH/kdkXV+AixMLxptzsyH7M29TPX5C0SoeSep951cWgMobqUTuYmsfVGYjHSDW3ZqSuu8R6Uao6hI859SMq6fhF+7WivQnxQTo/+wBXCjngl5M0szJHgtgeaVhH49odubn3zxRq151vgrFtdXOjejRy0Cus7hcoIqlftEjr73ARHNctASZmaKBk28qYCxTZNmhxIP3Xbv967wbK+Tg0n2i9kNK7EDdj4JpmLcc/M5ZTeD4JE1qVB+5hEI3tfoF7ED78iaZgqasW2CsTnwSm3+2g/AYH+EJcJdD8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWwIj7noKH1Xxo7gvdMprlSFrHHHy7S97Ew6bmfXI5Q=;
 b=UE2dLBjxpWDgdGTb1QTQACI5m0OVcIlTXiZWOx8yFB2r8ZYgRNI2XYvWwSLjcPvkiwwyPtWYUlQAWGkJ6VaDddASfKcGlAJA/p5X0vcmL2vNCvvoagIqpPa2izYpS3DI9Eaw5r0ctZv6sJY4hqPTos5xUpoFJ+vZ9vpVbD84+aF8cF+jw4dXpbHUcmUB/TBC2YbV9ZQ8kmv43Bxwvz0BG9yKsdqF/MriuANn4She4yOSgulcqy7N7GJ6NAzhY9egcwy84afS6SJj7kaEqARcUQ/QJ3hP1wcZ7044Tyie1IW3pLyAtz5J6OwcYuegHrt2n0AeNM5ABdLHuc0ShmChKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22)
 by SJ0PR11MB6765.namprd11.prod.outlook.com (2603:10b6:a03:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 22:24:53 +0000
Received: from SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c]) by SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 22:24:53 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"challvy.tee@gmail.com" <challvy.tee@gmail.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "kai.huang@intel.com" <kai.huang@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] x86/virt/tdx: Skip TDH.SYS.DISABLE if the TDX module
 is not initialized
Thread-Topic: [PATCH v4] x86/virt/tdx: Skip TDH.SYS.DISABLE if the TDX module
 is not initialized
Thread-Index: AQHdapxv+7guorAVf0u8Spx0pWuuObcbXLuA
Date: Mon, 2 Nov 2026 22:24:53 +0000
Message-ID: <09c311c6aae214c04a9a55ff6456d7abfe82c319.camel@intel.com>
References: <07cfa95a-e766-411b-8765-33352a04c0be@intel.com>
	 <20261102073244.919864-1-challvy.tee@gmail.com>
In-Reply-To: <20261102073244.919864-1-challvy.tee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-2.fc44) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB5162:EE_|SJ0PR11MB6765:EE_
x-ms-office365-filtering-correlation-id: 32927adb-b9bd-4f60-b3ab-08df39301df3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|22082099003|18002099003|56012099006|261102123227099003|261009223027099003|261022105027099003|261021121427099003|38070700021|261022075727099003|4143699003|11063799006|5023799004|10067099003|261028144727099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info: lFZs4CgbK0hS1qNCaP+ORYNmwZss0alGZBUi/id8AWlHTylEfdJJgTmdhB6Qm7YUybh3XSId6SrF/p5dtE4qpnk/87mVvOeF+ielHuXubRO82rY3EGF0cN0mbNW62GO3B0e9eKtHH/VcC59zdszluKFrMlDQqMjGjKztlVmHCIEgxSjwSjdXEaLyz0CoPaoEn8D2uMBx5X/rCKI7O7sCGaeFvVZaGwHztbLm+E1mDV9epuSrMVrNh5AvmNk8sx04DMn7cHPqMFrkTTvPM22Wl2keJEas7tMqEx8pow3qBZLYi/ZAFeaCz8Z8HA/HpOtd0+cl8fcCvnHfRYo2lN+vMBriBZV9UAtLpaknio7EJ/c7F/mWnESA7D1xtjj8poVB2PJGTR0f+W4J2IwqU7fRxA9MyM2RC9ZXGkfNqUeo7SNHpqkH9mv3LN+ATZfRLln86lIZ+ex9CkYEo/E+UJyQWCWnQzcVBrrOA5AMZMxUg9prxW4uDmrswhPQQEUMzAxMpwz9qu2gnLTc1G0jMnYx8v7g11/+HbMjAoebMz2Vd9dYWrvhqlJEODtidq99kdpJGEwhk8mzrgU/1WETM4l3cBhiJa57UOWS2TXkmxwvMogMeIBQOByrsfiAQMTga6qg9PjBfRNvowoXfS8fGafEP6gGNFc3+3RKAxMN+L4IcSa9Pjq6iHE/ZL94aKr7cKnlV/TGMYlSBpJi4vWi3KnCx5bXII13EVClEBoOsh1d6n8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5162.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(261102123227099003)(261009223027099003)(261022105027099003)(261021121427099003)(38070700021)(261022075727099003)(4143699003)(11063799006)(5023799004)(10067099003)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1ZFVnRzWGlCTm1JdTQyaDRuNmxwRmhqS1ZwUm5vK1UzSHAya2VLWDN4ZTF4?=
 =?utf-8?B?SUV2a0g5dU1HTXFWMXJJTVV5c0NHNzVWbTFaUVI4anUyenBZbXJnc3BkSXp6?=
 =?utf-8?B?ZnNXL2MrUy8zaWhkNVRxMC9paUxKaEZ0U1NMdVV1Zit6a0t6N0VmNy96dFFI?=
 =?utf-8?B?dzNqMEVhd1NockdwOUV4ZXJxOWI2Z2I0eTFxV2VNUnkrM1VoQ2RiUXBXTnRn?=
 =?utf-8?B?RDZwM1hpdHArR2Jua2RIaVRYKzNIRU1adjljb24vVVZvTjJTam9FTURGYXZR?=
 =?utf-8?B?MHQ5Y1hnZWxhb1cwbEFlclZvT3dXKzFJYWZjYjlQTXMwY1VnODJ5N1JqYkdD?=
 =?utf-8?B?bkZ1REUrWlcxK1NTRElua0NHNjdrclBoYTdBVDZUR2xHL1JYekxWTzQ5Z05L?=
 =?utf-8?B?a1B1N0NkbS92NDJXVHIvbGRsQXdpV2ZPdVFNZVlqdUN5RWJHUDBhbWdtT0ZN?=
 =?utf-8?B?dEdUVnpTd0RLc09jL0xXRWk0LzRMbWREbStRY0I2NmNqYkdOT0Vkdy9tTTJT?=
 =?utf-8?B?TkNpTHlLTUZKbkEyY2VRWVVTR3dDNUlOZm9hM2wzV0lkdlZsS0hucmZRZHkz?=
 =?utf-8?B?U3N0WCt3ejcvY01vV1Q1aWFtTVRtejRBOFhXZ3dNYy9iZUFBeHo5aWJGQ3Bq?=
 =?utf-8?B?Y2c2MHZFSnI3ODh5WS9RN05YemRWTS9HYVpKMDQ1QkdkamNzd2lnZTNiRzdp?=
 =?utf-8?B?ZEJ4OTJIdjJBNjRSdzRuVmxURlZFRUxEZXU4ZnJocFFwQ2NHMmM3SjJ4eURT?=
 =?utf-8?B?ZXNTYVU5VHdnUEc2cSt1QTJiTVVRaUYwek1yREt5bXU5M2xmNDFhVGVydDcv?=
 =?utf-8?B?VnY2dVJST0xob1ZtVnRFQ2d6NjMyU3pEVlVJOUZhQWw3S3U0Q3hpQi94MnVQ?=
 =?utf-8?B?ZFBHWTUyZ0I0cjRpcndmNEhtejJKTGlDV25paW1LbndybTJ4OTlPQjB6V1l2?=
 =?utf-8?B?SGwwT0dFUHhnS1d3REFVb1o5ak5FTkNNa0ZjWDN3VFBkWGoyTktwYzdoRm84?=
 =?utf-8?B?MkVHWmNMc0M0S0FkU0pmQnoxcys3a0JoUkc1S0dHbmpDZmgrT1VJNkdBS2ZF?=
 =?utf-8?B?UXBnTlNIOVF6YWVkUU5QdEJwMjBjclhyL1cxdmZMdVNpdjJ2aWxxaUtHdkd6?=
 =?utf-8?B?U1R2OFBYdUliamtOM0Nqampic2g3Nm51by8wWTZYNHVVU04zdFY5dWxXcnpZ?=
 =?utf-8?B?NkFYVWg3TFlWQlIwcVIzWTlveGRHV0tjeTlzRElrajl1Z01WV2ExSFkxNzJB?=
 =?utf-8?B?ZnpMaVd0cTkwMnZtRmwvWkJmWXlhR0ZLcGl0RmpMVWdtZGJodWV2VS9pdHFV?=
 =?utf-8?B?M0p4WC9ZN2pzTlVmckVrbnBrQXZLL1pTV054Y2RqSm1kSU1obytvVzJldlpm?=
 =?utf-8?B?a01lbVgxZm1NYmdZN0tocUJRVXZpT2lmejRUU1lLc3NNSFdBcGZEd1FGMzFm?=
 =?utf-8?B?TzRrYVlmNFpZRllZN01MOS9YMHhqUHNPZEJjSGplUlBrL2Q2akN0WlI1NmU4?=
 =?utf-8?B?UnQrWHhEaENJTkd5WjBFeWNRY0hKSzhjK3V1OUlwL01iQlk1R3ZpOXcvUDl1?=
 =?utf-8?B?aE8rVnAwM1BPeGJhWkE1YysvdTZLempjSUtZOHpqOWZqb1pCeGNrWCtVNjdn?=
 =?utf-8?B?L0F2cllaTnlvM2gzOS8rSVI3MTlRWnRjOHQ0T2JCZzNPL0toUzJDdEhmU2tJ?=
 =?utf-8?B?MGJwWVlHaDluWVp4Y21meU5ocGlVeERPa244aGJQMnpyK25tRGxjeHpaME1l?=
 =?utf-8?B?MlRNelFZVW1nQzNycHBzcFlRZE9SK1NFMm1Dem5BMnRERDhqb1RCaXNFbllG?=
 =?utf-8?B?UHVDS0hZdmtGdmJITEMxUW1TWjFadE1XMDg4M1Z5QnZsS1ppM3RvY2pEaXlw?=
 =?utf-8?B?K0llYzg0TS9ndHFpbEpaVmNtbjlZTEJnZkxtTWxyZlhmdkhzcm5CNUx3c0JE?=
 =?utf-8?B?TEhsbkFwU1R0ejhydllGVVFBSEYzeXhvOEVkZjZYUU5nb2x2eEJxTk5xL29U?=
 =?utf-8?B?dFh5MC9oWWJrUTcvbm9jUitWMTlSQlB2NVhybTMwTGZiYWhzeU9jOEVFMUVF?=
 =?utf-8?B?b0lXWGM0SllKTzNFdXAyMHNYRmZERGpORWs2amR6NDUvMksydUVTZlJZcnFL?=
 =?utf-8?B?Sytick9EcTFSY2JkakZWRnpyM2l3OU95UU81ZkZaQ0sxUnRKY0tyVGEwbGwy?=
 =?utf-8?B?VCt0b1JoMm5xTjVkWjhzVkpMdnlSQllkcWZxTEN1bTkrM1ZqVmM0eWQzUE1L?=
 =?utf-8?B?K3JmNURiZG13emYwbjBleU9LekhwSzdicjcyZGlOQkNaTDFJalZyeVgrS2dB?=
 =?utf-8?B?eHZDbUd1NVR1SjdDV1V3bm5KQkxrMzlVcUF2ZnhWbXArSi9Fa1hYNEhOS29k?=
 =?utf-8?Q?lG7EkAZDFBcHd18Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <528472C1FC695D41BED9759EC9E27660@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kRn0W1GB1FC1MgV6XAZN+khuOk0iQNX3XT1sk+rUPDWWAWO2AbkeXND5svUuLuqp4wcxPmKQAM91zZHzg7q2DKQV6gp8rjf4ge4AkNAe1dQsMig5sIoR9OmT1SjdFdziEQ677iHuuRTHW+Qx5nNOX1nvpm+PJeZJJR6lgKCajpXVzfA/eFhOnD+HY85qBjSwEvZmIM6t4LJvpPnKzvLLcTr+ztUCWlN+0QYb19WBD4rMATuUjx3uzy7qor8rw1T9zQTDFUvHRbE0IG79UxUpm2pttSUgAy7w6OyaHIdZHRq7XhLde++MiqAEcd4mmaAYlivwUhuE+Ul74hPua5vJgg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5162.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32927adb-b9bd-4f60-b3ab-08df39301df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 22:24:53.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAgGHS80GNquQeV1PqmE2CP08LfGQZ1mOaJfAuiO/NOVpugw9KuHerxVsVMCyb0hE1cKEkJF7tUrY+M3SJCzdfwKRKGjyvyLSz1x7KLTAUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6765
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTExLTAyIGF0IDE1OjMyICswODAwLCBDaGFsbHZ5IFRlZSB3cm90ZToNCg0K
PiBTdWJqZWN0OiBbUEFUQ0hdIHg4Ni92aXJ0L3RkeDogU2tpcCBUREguU1lTLkRJU0FCTEUgaWYg
dGhlIFREWCBtb2R1bGUgaXMgbm90IGluaXRpYWxpemVkDQoNCkkgdGhpbmsgdGhlIHN1YmplY3Qg
c2hvdWxkIGJlIHVwZGF0ZWQgdG8gcmVmbGVjdCB0aGUgbmV3IGNoZWNrIC0NClg4Nl9GRUFUVVJF
X1REWF9IT1NUX1BMQVRGT1JNLCBhbmQgbm90IHRkeCBtb2R1bGUgaW5pdGlhbGl6ZWQ/DQoNCj4g
Q29tbWl0IDViMjVmMjQ5YmUzMiAoIng4Ni90ZHg6IERpc2FibGUgdGhlIFREWCBtb2R1bGUgZHVy
aW5nIGtleGVjIGFuZA0KPiBrZHVtcCIpIG1hZGUgbmF0aXZlX21hY2hpbmVfY3Jhc2hfc2h1dGRv
d24oKSBjYWxsIHRkeF9zeXNfZGlzYWJsZSgpLA0KPiB3aG9zZSBvbmx5IGdhdGUgaXMgY29tcGls
ZSB0aW1lIChDT05GSUdfSU5URUxfVERYX0hPU1QpLsKgIEEga2VybmVsIHRoYXQNCj4gbmV2ZXIg
aW5pdGlhbGl6ZWQgdGhlIFREWCBtb2R1bGUgdGhlcmVmb3JlIHN0aWxsIGlzc3Vlcw0KPiBUREgu
U1lTLkRJU0FCTEUuDQo+IA0KPiBJbiBWTVggbm9uLXJvb3Qgb3BlcmF0aW9uIG9uIGEgU0VBTS1j
YXBhYmxlIGhvc3QsIFNFQU1DQUxMIGNhdXNlcyBhIFZNDQo+IGV4aXQgaW5zdGVhZCBvZiBhIG5h
dGl2ZSAjVUQuwqAgS1ZNIGluamVjdHMgI1VEIG9ubHkgc2luY2UNCj4gY29tbWl0IDlkN2RmYjk1
ZGEyYyAoIktWTTogVk1YOiBJbmplY3QgI1VEIGlmIGd1ZXN0IHRyaWVzIHRvIGV4ZWN1dGUNCj4g
U0VBTUNBTEwgb3IgVERDQUxMIiksIGZpcnN0IHJlbGVhc2VkIGluIHY2LjE4LsKgIE9uIGFuIG9s
ZGVyIGhvc3QgdGhlDQo+IFZNTSBnZXRzIEtWTV9FWElUX0lOVEVSTkFMX0VSUk9SIGFuZCB0aGUg
dkNQVSBuZXZlciByZXN1bWVzLCBzbw0KPiBtYWNoaW5lX2tleGVjKCkgaXMgbmV2ZXIgcmVhY2hl
ZCBhbmQgbm8gdm1jb3JlIGlzIHdyaXR0ZW4uwqAgS2R1bXAgaXMNCj4gdGh1cyBicm9rZW4gb25s
eSBpbiBndWVzdHMgb24gU0VBTS1jYXBhYmxlIGhvc3RzIHdob3NlIGh5cGVydmlzb3IgZG9lcw0K
PiBub3QgaGFuZGxlIHRoZSBleGl0OyBwbGFpbiBrZXhlYyBpcyB1bmFmZmVjdGVkIGJlY2F1c2Ug
dGR4X3NodXRkb3duKCkNCj4gb25seSBydW5zIGFzIGEgc3lzY29yZSBvcCwgcmVnaXN0ZXJlZCBh
ZnRlciBpbml0X3RkeF9tb2R1bGUoKSBzdWNjZWVkcy4NCj4gDQo+IEdhdGUgdGhlIFNFQU1DQUxM
IG9uIFg4Nl9GRUFUVVJFX1REWF9IT1NUX1BMQVRGT1JNIGJlZm9yZSBpc3N1aW5nIGl0LA0KPiB0
aGUgd2F5IHBhZGRyX2lzX3RkeF9wcml2YXRlKCkgYWxyZWFkeSBndWFyZHMgaXRzIG93biBTRUFN
Q0FMTCBpbiB0aGlzDQo+IGZpbGUuwqAgV2l0aG91dCB0aGF0IGZlYXR1cmUgdGhlIG1vZHVsZSBp
cyBuZXZlciBpbml0aWFsaXplZCwgc28gdGhlcmUNCj4gaXMgbm90aGluZyB0byBkaXNhYmxlOyBv
biBhIFREWCBob3N0IHRoZSBnYXRlIGlzIGEgbm8tb3AuDQo+IA0KPiBJdCBhbHNvIGRlY291cGxl
cyBrZHVtcCBmcm9tIHRoZSBob3N0IEtWTSB2ZXJzaW9uIC0tIGEgZ3Vlc3QgY2Fubm90DQo+IHJl
cXVpcmUgaXRzIGhvc3QgdG8gaW5qZWN0IHRoZSAjVUQuDQo+IA0KPiBGaXhlczogNWIyNWYyNDli
ZTMyICgieDg2L3RkeDogRGlzYWJsZSB0aGUgVERYIG1vZHVsZSBkdXJpbmcga2V4ZWMgYW5kIGtk
dW1wIikNCj4gU3VnZ2VzdGVkLWJ5OiBLaXJ5bCBTaHV0c2VtYXUgPGthc0BrZXJuZWwub3JnPg0K
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFsbHZ5IFRl
ZSA8Y2hhbGx2eS50ZWVAZ21haWwuY29tPg0KPiAtLS0NCg0KT3RoZXIgdGhhbiB0aGF0LCBsb29r
cyBnb29kIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJt
YUBpbnRlbC5jb20+DQoNCg==
