Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431943935C;
	Wed,  8 Jul 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527651; cv=fail; b=nJHZMYEo//aOJF+esDpZpCaOG2qYCeOre2epQrKEUYoe0u9lzCyurIIBgMZLfJ0bRBYC70VjmyzfeiNYoSnZ9+2FwR+wcWWn7FINJDbX41RLtE0vCyJdXkQVry/fHX2t3C1C6ELMcMwlNER08Moov31ahWYBBY4WCyEewJx0Wpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527651; c=relaxed/simple;
	bh=1t/54Dobbq1gTvjFODQ5E2fu6oVgEMMERkeouI2TMqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YbiNd6Z7AKyFr8JbgLuMVl8n2QC0BKkHPrNXHBE0CHIK/eE6zgLP+GJhRCz8CgXpH1E3yXxfiDKdYZXMrPudHVrobUPEcenmAH8fRNgnYK6tyg9FSie9SdlwOX9X7quKgtEiOoPI96gCmQv79s0KtR9Tc7JEBRfjQtUbTwiVR18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYl+5l+H; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYl+5l+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783527650; x=1815063650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1t/54Dobbq1gTvjFODQ5E2fu6oVgEMMERkeouI2TMqI=;
  b=YYl+5l+HopVvDvm+HV/FriLNx0JnmjixhjwzPTwh3qPfd4+LGfYNk4TU
   emIPuqYA9pd88CAkgJBCqw7R7s6eWc1RCna3pDXqs84wKjWnQ7rTktBq2
   +VaD6A0i05vUcSOTUrB3XOA/+pZjIe4Zw7ESE7BVpUN407elV6ApFN9T4
   LrmIknKmcKh68uIeaSlHMUHCfCXhshAXo6XVu1dM5meuCUYQ14BvTorU+
   FQXnv7ghWWQH3ww0BK60j7fgx0pmV1vw/ySmWbV0MKPiPhJIjY0+8gZt0
   feAkRmSU6RaZWhCPnmhG0Y+Z/a06+yHD8kJk4xd6/nlUye8yCtR9oU/Z/
   Q==;
X-CSE-ConnectionGUID: qauPZg5MSI2Bij95UOyPzQ==
X-CSE-MsgGUID: hrIglDulSiCO2M5tVta0FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94841695"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94841695"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 09:20:49 -0700
X-CSE-ConnectionGUID: 21lK44pnTLazefbnPCEHUw==
X-CSE-MsgGUID: koKb54YsQ4eZQdF3Hog5aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258193484"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 09:20:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 09:20:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 09:20:49 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.26)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 09:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1YUUrhM+0el/aibBkIC00fwqHUOBDwiVJWbJSI5IAVDd0OZWiTGAfxoZiPLGiBPIHvZ6ba22YRWQSwj1vSi2inXAEAhpH1V0Qz5TfOcxcrJpB3cw0uaHW/MShcU61ugvBNGl4qbTHg802grOhvIJ0L/ioG+nqmTiLf0EetZX65Hda3mT0IWaoi90Y63mk3IjAbyWk/M57nKM8c8+EkAssw3Gi/YSJlWQgpn1FdQEIugWsDc8i702nntlNQsYratKaP1x86Mh122hKwLZ8DA4yngfG2On4L7HbNS5r9+G7/Vp7toBVxk8Rd7u/EG+lGKHV1UsoCRWGfFkTbYNEvdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t/54Dobbq1gTvjFODQ5E2fu6oVgEMMERkeouI2TMqI=;
 b=QBoPT3j6p0an1D/cYQaCd2P61cAxSWqI3irqViiw3TQISQyHHUJbd8vYwTX85mlglM23f/ttgW0Pi+zF1x+v5FbqArl0ZPVs8EfYddmHZIU2t+nUlkaRe3h/xC6OCe76wZwzevoPwhHEIfEotkPJ1o/bc3mtdCOS4KA4tsS+3RmgpFWNy/pXZNYdJQxw4X5yjB5UWG4z2+qtlC4ql3QG+Pxin2LOXcXLNp8OK6hSUMeeRMMoYdkVief91LSbZKpYllkzwwKavTMMiViqMUsWD+JUUhje+rKiy4T1Te2b/Vat8TczQ21oE0omD26A4T1nLss7ROXUtHqJoPXUea7ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY5PR11MB6308.namprd11.prod.outlook.com (2603:10b6:930:20::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 16:20:40 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 16:20:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "kas@kernel.org" <kas@kernel.org>
Subject: Re: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD
 init
Thread-Topic: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD
 init
Thread-Index: AQHdDoECpG/7GC86lEK0LBaDqaaddrZjTmgAgAAGK4CAAHnXAA==
Date: Wed, 8 Jul 2026 16:20:40 +0000
Message-ID: <28ec0a5ac5c46448df5983cc7f9cbc71f6014e8a.camel@intel.com>
References: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
	 <ak4NdJSK60zKD8Uy@linux.dev>
	 <315e969a-4ab1-433e-91c5-2308f1975281@linux.intel.com>
In-Reply-To: <315e969a-4ab1-433e-91c5-2308f1975281@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY5PR11MB6308:EE_
x-ms-office365-filtering-correlation-id: a5991981-b469-4e69-5c4f-08dedd0cda1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: ZTCsYB8dOEJe2iVo42iafHYP16cgSCrJF0wTs7FHx5907VmsJzZr9pg0rEmWblqkyVMVFtlepHyq9MgA6AAgFTt/7tdPZiH0todPGS7c05XQRUGWCVblVEmVI67uDqkFwn70YGfIwvgaRMWcmGs6vkWzlHqTRn3K5GGs20pyINaC1cTQNbTvlWXisYkVrt/DcJwCinjD4xDgRtpvRVlwGSz12IjYw9zUEzRYpjBad7SJuHbEh+qtqn+82AtkUMr1CsPgRk64Symx/k1xVI/vbHrLedu0DiehDYk+CVh9rCNfRER+Og25XtNUaoZjCF0fb4TLUMHf2AnHi1IzBb2PAZ1K0EB/dH1nlzcwjD47CwdEHSBg82h4oAxtSheFeHvQBs/2RFf1q8fj8cqk8a4cChsYiQ7e0JQjMo3cq3R+FNrZCo1fzYnEMgdtSp91FYG/pTFJDvyDl62APJ7cIEuC7KRAybRojdpropUmUQVuUoX1ZoZnM5v7rWCbX/PdWLK2GuKGHezmPJ2oVVp477khOybGB/UiIx7XU4+dKmGeO/mTfO4Vvz/GHPZ9/poVXUvR2/jhxTtbJkGKXrmtDsIXLO7DHCgtU2IE0sxAqWDCH7QSNgZPfLsirP7nKfWJ5huZPVAX9cj/niVB90OYf4Z4ODsAhKMkdeCh3VdoL93Es04Dhon02A11WBvqyPV1lXLNMofyKneCUpoF5igNCXw+Fym7NCQV/a8tuaSWOwqyNMQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1FhOWh1UHRnWXRYV3QvSGl4eEhsUzEwOGRBWGk1Q3YzVURpbk8vVVhyeDh1?=
 =?utf-8?B?QlpuZG5OY0VVTVZlUWQyK0YrOElpUklnTmNvdHkrTnk5UVpyM294SmhsV3A4?=
 =?utf-8?B?VVpVYmtHYllhZDJENEZwU2lUemQ3cUFDVVAzZFZQM0F2WERsUkFuaFV3NUNx?=
 =?utf-8?B?a3R0MitNaUNJTFBacmlHbld5WjRvcmZmdkN3RmxKRlcrTFlnaE9zb2RuMjQz?=
 =?utf-8?B?KytkWnAwaWVlTEREQ3czTDFyL1dyUE1SaGc5RGVMaFRFY29rUHdYTXVzbHU1?=
 =?utf-8?B?SGgxOHdCaDFET0pQZjNBMjVMMUJNNjZHdlhjd2hjZkZGWGw1Z1lxbFh6MjNO?=
 =?utf-8?B?d0dscGdURmV6SVZlZmE2Q0R3dFp0Q3BISHRaZlV6Rzh1ZkVwTjZ4QnhYeHVZ?=
 =?utf-8?B?clVXam9QMlZTRDBHYmNNSE9Sa3gveFVKTUNUZ014bUhkUkZWTnhneDNVbm5j?=
 =?utf-8?B?Nnhia0ZJSDBuQ3M2VW9uenZaU2xhYmtFL0JzNGcvWkJITU1LbmFFT1JnbTdh?=
 =?utf-8?B?NFN2c1pVdVZCZ1o4Z09UWmp3NkwzSSt0MWpSZ3VrTWpPTHF4ejRvUnBKUW1v?=
 =?utf-8?B?QnlYU1JzT3BocTFCVWhqU2pTcFhlR3JPd3ozTnFrQUtEK3pBUzFqTWw3cUpt?=
 =?utf-8?B?N24wSTFUdjhyemZTdFltR1NqTDhLRlVEWjlGWXM4VmJjeTNVMTN5OFJxa3A0?=
 =?utf-8?B?aXRqd2orU0UvZEF0YU5waHdIQlVHMTJwcVc1akNiOUdDQlliUWEzTjVwNTdk?=
 =?utf-8?B?c3VOOXlWeUkxQUlkRTV4SEtsM0QvRFVzRXBQOEpRSHFTY3dQSWl0TDlzVzdZ?=
 =?utf-8?B?LzRnanducGtpVkVZaG5MWjZrakMrVmp5blZFRUh1Z2Fpckh4MHJvb3NralZm?=
 =?utf-8?B?YXNGYThaK09aTk5qOHNpQTFQdWZDRXlrdXFHSlNId1dQdHhXRlVkdzN4TSt0?=
 =?utf-8?B?SjhwVXBsY2I1VitJMUFvdmRkRDduWlNKOGlHRmJ6ZXJMQ3dXaCtGWUNUNTZ3?=
 =?utf-8?B?NnV3aUl3TGJZNUVhUnVNWU1FWitHUk11bnV2dXdjalMwdzgzMVA1TWRkTFpU?=
 =?utf-8?B?cWhkSGJpNDJZdlFZS2N3QTZBanRjcHBsVldaM0hyZ1Y5dmZKaW5keEFFWHRN?=
 =?utf-8?B?YzRWZlFDVEpKTWVYL1psQTVvZ0JHSzhlTmh3NWNsaWluempIK2J5QklUYUx4?=
 =?utf-8?B?eXphTmc4SWRNQXF4THFvcFhjaFl0Z1VhVlBzeFZvQTgzMFRRV3NiRGpWTWpE?=
 =?utf-8?B?aXRrY1czbklXU05vZWpDUEJZcUFvTmhFSDMvc29aeWhkUnNnZjg5THplbDht?=
 =?utf-8?B?d0MyMkNhaytRSUFvRW51dzl6RU15dWcvVGpGVzNrdVQvWWRIN3dXMXRYQXd4?=
 =?utf-8?B?ZUNHQUp6d215TDRSK015YlpIbmxOZ0VFb2RwNVMxQ3VjdUgrUEtVTmlmRlg5?=
 =?utf-8?B?RVVtRkRyMXE5VlVlNnB2MXRYbzd2TTlScWhNMjFSakNkY202Mm9YUkowWU9S?=
 =?utf-8?B?WnpsNm9GbnBUWjU5Y0lBRHVnUTFIcUpmSEJGdlFMTU9hUHFlMXpTWFBiY1Z4?=
 =?utf-8?B?ZmFudTJ3RDd2Ymp2TWQxUU5kY3d1RGpkeW1xV0pEQWdIbytUYTNSczdSdHUx?=
 =?utf-8?B?Z2EwQjRYbnlvRURXbHEvUEJDelFjNXV2M2ZTM0tXWnhtVUM3THlpZDV5UktE?=
 =?utf-8?B?OUN0VHZmSGdISUozT0VibFVMQVQ5UEdhUGphT3B5VTJ0aGkyQUtvTTJwVjdD?=
 =?utf-8?B?cU9MeXVEWEtySWNiRkgwZmNBbW5XekdhK0I4RzNTRkw4Tk5rQm9UWnNwVmxv?=
 =?utf-8?B?QmRFdndyRk1oa1doK1hJeXN6cmxQSk55cWdVOUJJNnpiS1N0Ym8yUG84aWdX?=
 =?utf-8?B?YS9sOUFIRVpTaUlzR2tUZkVzM0E5RFRSS3krNkxRNXVzeDRLa0FvTEVPaENO?=
 =?utf-8?B?bW5MQlRFY1gwcTVUSzdnbzZmMEhCZFo5QWkxT0FsT25DQVMwV05iV0NJenFv?=
 =?utf-8?B?ajJqVDArcGE3bUg0S0ZVTWZFUVF3bzBYc3FzM2hFUGxzcFZSK0tRU1VqSEM2?=
 =?utf-8?B?dXd1c3hrNTVsUHd5akVyMXlWa3ZyQWlRU3BGeU50b3pXYk43ejhuaDJCL0lR?=
 =?utf-8?B?QlR0L1NQR09JS0VJazNNeTl0cTNsVHlvdjg2MjJyNzYvV09lNmYwNkhCMUtJ?=
 =?utf-8?B?RHNiSTJCYTJ1cGVrb2l0YU45ZXkrWXJLcVRNcCtNdGVkL0t1R0N4VXNXcmw2?=
 =?utf-8?B?b1RnY1dCc3RVWlhqNkVTYSs3YnZLYWJFcGZSWUsxcEhtVnlrU3hjMnpHZHB3?=
 =?utf-8?B?NDFFNkpyTUJCUm1ka1JwV05WMVMvZ2MzWDYvUW1CSDlBYlViVkNoUVBSRE92?=
 =?utf-8?Q?4wnwNGFF5E1+0gi8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C9E1CE4859422489EBAA0583BC1DF4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GOH25EUtA3RSfBvoONFr1GVaoetlKhmigih1B/SYvGsbhqtKYA08QO/OuFgcb6ItPBzj+rmdyISz0lo+fHJ7wOXGdeAx+PZrQKZCVu3JyilLzuDpERBuaZ3urruGhPKtwCHZk2NvEQXepZ2D0tn8uHMy5SpnpyqH7nv3UQ4KvHEhrxDGeR+sU36Qxe9Jd35NHbPSVG2ynLj5hXlyeDvbGT3pTVPssEk8x5vbOxM+TSUJNYpfMnALQE+psRzNx5w/xNEI0Ayl5w0mfCbVq4Vg0/75f4ww7g0+u5ksQEaaW11ngI8DmMoMcJz2aOAD/S+ZdQiF9q9MC2ukh61wFxei3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5991981-b469-4e69-5c4f-08dedd0cda1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 16:20:40.1150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTFL39w7Qt+8bhZQllf82c22VDHHnlaCaL5vF2z4Rczy5YWPNP23N3cBOn2ny2gZySMoZuekwiUJ4BTBmeZGKy8Hnhoqes/ovuG4U2H+jFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6308
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTA4IGF0IDE3OjA0ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
TWF5YmUgaXQgd291bGQgYmUgYmV0dGVyIHRvIGNoZWNrIGZvciBhIG1pc21hdGNoIGFuZCByZXR1
cm4gLUVJTlZBTD8NCj4gPiANCj4gPiDCoAlpZiAoaW5pdF92bS0+Y3B1aWQubmVudCAhPSBucl91
c2VyX2VudHJpZXMpIHsNCj4gPiDCoAkJcmV0ID0gLUVJTlZBTDsNCj4gPiDCoAkJZ290byBvdXQ7
DQo+ID4gwqAJfQ0KPiA+IA0KPiA+IFRoYXQgd291bGQgbWFrZSB0aGUgbWlzbWF0Y2ggZXhwbGlj
aXQgaW5zdGVhZCBvZiBzaWxlbnRseSBhY2NlcHRpbmcgYW4NCj4gPiBpbmNvbnNpc3RlbnQgdXNl
cnNwYWNlIHNuYXBzaG90Lg0KPiANCj4gSSBjaG9zZSB0byB1c2UgdGhlIHNuYXBzaG90IHZhbHVl
IHRvIGZvbGxvdyBLVk1fU0VUX0NQVUlEMidzIHN0eWxlLg0KPiBLVk1fU0VUX0NQVUlEMiBraW5k
IG9mIHVzZXMgdGhlIHNuYXBzaG90IHZhbHVlIG9mIGVudHJ5IGNvdW50Lg0KPiANCj4gQnV0IHJl
dHVybmluZyBhIGVycm9yIGNvZGUgaXMgT0sgZm9yIG1lLg0KPiBMZXQncyB3YWl0IGFuZCBzZWUg
d2hhdCBvdGhlcnMgcHJlZmVyLg0KDQpJdCBkb2VzIHNlZW0gc2FmZXIgdG8gcmVqZWN0IGlucHV0
IHRoYW4gaGF2ZSBzb21lIGltcGxpY2l0IGJlaGF2aW9yLg0K
