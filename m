Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2837DE9F;
	Thu,  3 Sep 2026 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460442; cv=fail; b=uAmqTmmAa/aGHYmMKwhHwPlTAtV2zLx6T6x5djo0EVVIVaN9AWNpVPyWy8/YrEyNhgMEzpadR+Yre9zujsXj1YidFwHwy56nEDdPj0ndTECdQ7SLomqNGQGuQVvXJqSw2RJ7Q/Lg9DmAznW3DruORbcmYkb0ZARON/o/Qu6IK9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460442; c=relaxed/simple;
	bh=eVTHG/ft+QQRMc/4yJEx9oY6dTaBHLAKzXLC6ICV71Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XbK3wPrcN3r1CYOj6IN4TYG7TUtwFu8s8mRIkXUJwMMyLY04agyMl3MuzCOcWLXxKX0gQyKMO90gID+NHfuaKRyNeev5QmbJsKKYC8/Hzea1Lxv/eqU9FtpayAUj56VcrqBuFTuEksyguqgv753L4AkUFJAjjfxj7VEyDkkIIu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDfN/b5I; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDfN/b5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788460435; x=1819996435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eVTHG/ft+QQRMc/4yJEx9oY6dTaBHLAKzXLC6ICV71Y=;
  b=YDfN/b5I0CCeG+DGi0ocCxdHv3zqHB6KJHMRlUZ7gipZd+jXeGBDoXOn
   wshVnwyx9No+ZqvvFeaS0nyXdxD36Bvc1C55qaBgITAwjCvIno8LNsNfi
   QPCPl05BMsbWWBhrMIY9y8n8FPr+q8MxMRFnFRKegI9urWgyVT+9QG65O
   WjZ9vHmadWOhu5iOZ2av37DOHwySIcp809uIO+Ee3qeFs4R/dk/BT3+Zv
   0CA6YWj6uFvZe+FsOR1GQ1yhGCL2m0TVrxOZesr0CdkgFIQpoaMRHWmVp
   v+PvCplOKJU31JSoYyrlMtYs9RV/WoVS0eQZO8RPVb3LDYf19Rn/LeBiu
   g==;
X-CSE-ConnectionGUID: ra1cL8M3Qti72Z2WX2SaCQ==
X-CSE-MsgGUID: Dudt9muFRy+GsQRqNr1EnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88987426"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88987426"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 11:33:49 -0700
X-CSE-ConnectionGUID: 7vJEA8neR22P2LStQDou1Q==
X-CSE-MsgGUID: lJcDUZzmQXWMqz+X7up/uw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 11:33:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 11:33:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 11:33:48 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 11:33:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGaUXtOObLZn7t5mFI/7yEtC5Kbl8n1Kj7RWkRfKEm18U2iCR7Z49bYrCKeA9h4zLCAPiReUb1b0Vbx+Ql5isb72joAlonQC3E+3FGl0Jp48012anh0csMyWG6aDsrAr+5ed+rlSKtGfftyikVF8pHZZFuCeF+5ldZRik/svh+A/V732ukwZa8c1dtDI5jPEf8o5zn1EG1ktellcGzQbjmGslUGlypuSMS0cPjN8898L0nsWkMVLSSuBdNsoiXPPsXZpBRfoRU7ADP3m56hdGb53jFLjIbh3yGRYim0n4HtlWRF8ZisGSPRr8ofJ5Sm6RGsypzhrCW1UrbUe73dTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVTHG/ft+QQRMc/4yJEx9oY6dTaBHLAKzXLC6ICV71Y=;
 b=oNzc/SQhkI6D6klJTliPFfMtXTAbIwnwPhhrp4W3sSw+DhpzDi7oV14Jjac0nhxdI4ciXJ3zpnX8Po0O0hWSTDOv08tk46IX2xhCy4ERTTrad7PzjsYEPxQZ2xFzBVMQGNX+e9D5cbIzACYQccRfBoBdWEkJG1LUcg/knNl182TyrLSDf4SbNpCqIvV6e46gUeww8aRmqk4gMiy0yHVS6PHbIiEB5pvS4ULKGV335WeD69N4D39mO0zVLTPK4/AVH6xs9PZD/lAeaXRYDojiQEBabT7EBYAnbuAjKRQqbtwlWOmkvoKHW/EYKofSXZv90otVloW9NP6ukqv0G09tlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA3PR11MB452602.namprd11.prod.outlook.com (2603:10b6:208:54a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 18:33:41 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 18:33:41 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "vernon2gm@gmail.com" <vernon2gm@gmail.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>
CC: "andrew+kernel@donnellan.id.au" <andrew+kernel@donnellan.id.au>,
	"rppt@kernel.org" <rppt@kernel.org>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, "yanglincheng@kylinos.cn"
	<yanglincheng@kylinos.cn>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "david@kernel.org" <david@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"tj@kernel.org" <tj@kernel.org>, "orsonpeters@gmail.com"
	<orsonpeters@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "rmclure@linux.ibm.com" <rmclure@linux.ibm.com>,
	"bp@alien8.de" <bp@alien8.de>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm: Fix pmd_modify() dropping the dirty bit
Thread-Topic: [PATCH] x86/mm: Fix pmd_modify() dropping the dirty bit
Thread-Index: AQHdO1K4MHbba6oaQ0Cd7mC7VbQSrba8v1SAgAAoUwCAAD1wAIAAAKSAgAAJGgA=
Date: Thu, 3 Sep 2026 18:33:41 +0000
Message-ID: <e9c76dab579fbadb156410265d463828d54acfed.camel@intel.com>
References: <20260903031608.1194238-1-vernon2gm@gmail.com>
	 <aplfcTfjeQUgnrvH@thinkstation>
	 <314f11c1-ce5e-4b36-b296-0ab742550851@intel.com>
	 <c15c2b17e110782d966751dbf3c487a6db837a87.camel@intel.com>
	 <0b084321-0898-44fe-8c69-7aeb171eb8af@intel.com>
In-Reply-To: <0b084321-0898-44fe-8c69-7aeb171eb8af@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA3PR11MB452602:EE_
x-ms-office365-filtering-correlation-id: cadd87a2-a3c7-42ef-0c2d-08df09e9e0d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Lk6UctQ1OpSYY/CB9CmIH8S6VEuBQFGMurqnzWFXhPNo58YakGX9KdYFhb2U4P0T/0ZApbJwxP0Q9hTkHa+1/6dDvUx6mlGX0OPNHF1tLKkE8y76CSdP8T0fq9tf0sWz2BsDcxILxj1of+jBVkwfEY712RcNcZdWPMUEo0YRDWCbV3Gog10cXIKy7jblbsUTB0dTgSJv2ICulhghvPfbw9hRwxDNiFwmPb8aEC1WJeewidnGVoMUx/GIPyUJO8irpRhqRXQFxKuYbVp+F1Gln4S1UvSxyYVlOh5Yy29eMusKJyPnKN+EaaIfsJeJt/y4L63xX1s/knuvsMqorCDMYQB72Nrs091FLklBhasldkOiSqy9KGSuChCB07wmbDD5Hx7OpIbjy0iYvmO3AAVZVwBEm3M6CDycfV3bUKCKZ+DyI85dkntv3cEuFOz6Tcfno0QXoGQgSWO2Jxjonu/bjkiqJoCdyYIs51zjK8rb8l//jfKXma+YiCYtzuz94zLa7nQRrWavU6Y0PzcoBPAydtWV8HpQu4F2SzbBdU24XKGuMw7s4vvI991SWCJXKiMrkC5W9dMvrq5JDPxnSJ1mABv0K7XUKhVtlaz1uzD6pX5gsShpanPXXf7eF/4XEYTmnJTP/0WA2lpNpylIjw2+z4moemeFwA3+vpwX6JP5A9fy/buwhxG5kSOJoBcNNpFfTADNPtfcqElsYNoyV0h1aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXRmR2VtOFZvQVZqTmpHV25QRlBETlZZcnliK2lOZzBWbjlDcVVGYzkxNU51?=
 =?utf-8?B?WUtJSjBJTVU4SDA3QXM5MEZZT1JkQUdHeTk1QVdXdld4TlNVV1FRYVRrQ0RZ?=
 =?utf-8?B?TnV4eWdxYStvOVVxT0oxaUFjTzIxNzVKblMzcHdQT2tNaGM1Zk1LbkR1cFd3?=
 =?utf-8?B?SWhpWUh2ZlBJOVgyN1pxOU5nWXNUeUlFME1Kdm5vTUhqTGNOYnB2aUlsV2k2?=
 =?utf-8?B?S1N2NnFBNGRuYmNqcDM4aVFpZGVzMVZzdHhRdFpCREFyR1hYcHRNdEZaMy9L?=
 =?utf-8?B?RlAyOCs0Y0I1MldQUUMwcU1QV2xaTTV0S2hMalRpbmwwQ1EzaVpZNHVYeVZT?=
 =?utf-8?B?UkVlaHpTamJOQ0dWUUVZVEhPbk9QU3NiNi9mczBOVDV1dnZYa3MxRGVCLy8w?=
 =?utf-8?B?U0o5WDFPR1BvZi9pSlFkdmEvdVlPRWdRU2cyVUhJKzh0MkYyTXV1OVJDMVVw?=
 =?utf-8?B?bUxLeVFPalVqcjRCYVF3aTRsN2lIZ0x0OC9VUmcySHlhR2hiUmFDOTZlNlZu?=
 =?utf-8?B?WS9LcHd5TTRzVkcyb3gybEFiUHZpVS9CMWFOaDA3aEZ3YThsS1lTL1QvQ3ho?=
 =?utf-8?B?dlVKWWFPS3FaQVl0REVZR0dCNkRuOFlpNldSSitHZENrRmhXdXJwS2t6MUw2?=
 =?utf-8?B?NDdmMTBxVmtNM2U5QmJ1T29nTldzMXhKcndua3dlcE5QL2lMVG8rZEo1dGhV?=
 =?utf-8?B?SHZjV1MxMExLNTQ4R0c0anRjdzNhVnViNDVzelNDTVlUTXpDd0dRUzdIa3d2?=
 =?utf-8?B?YjlXTHp4dVhYbW9LRmR5SFIvZTZFMGp0cit0NUFFT042TjVnSWpLR3IyRDRE?=
 =?utf-8?B?cXgxd0p2TVNWRkVIaTFTL2h0bnZLNVlqa0FvMDl4ZVlxbDN4NlZsMmZnZlI5?=
 =?utf-8?B?SWwyd3dVSU5RenNBUnh5OVIyWXlXbmhmZElkaTBqZXAvVjBJTkM1cjkxUm1X?=
 =?utf-8?B?ZGs0Z2FReEZhNE1VRDRtamJXWW4xNG1SSEJSSFRmNVUxNWM1Z1I0V2ZUMFRL?=
 =?utf-8?B?cEtmZk1maEdMNXRKbnFNaFkxaVkrL1Qwc0gzSTd0eFNBUENZZzNiN0ttanJH?=
 =?utf-8?B?Q0xIZ2NhT2R4bDc1Qys5bEpudnlCaGZzWEV5TUZDUE5zc1Frc294bGlOMVha?=
 =?utf-8?B?MlBnRjV2MUtoWkpNODFyYkNIVlNTM2lYc0tubTM0VXRESXhtUDdxdll4aG9Y?=
 =?utf-8?B?enAvUzZUdmJvZi9EekhVSnNWT2VmNk5DMmZXNkVEdjVnTEszWVB6Y0VGZW1D?=
 =?utf-8?B?WEhuY1hRZmlSN3A4YldRTFprU1pqcUdsOGxuUkg1KzFjY0JMalpyekRON0pW?=
 =?utf-8?B?UzVRbTZXYnZNbHhOQk1zS3FINndUQWhVOUdWU2wwa2JiZCthZmt4RDBmcVpP?=
 =?utf-8?B?dnFzSlo2bm80bGxoTGtEYzV5UTZneWpGRWhHUjNFQjk4eXUrOVFvU3NKSGZz?=
 =?utf-8?B?Ti9uSVdlLzZjeGJTanpYaVgzU21qYXJRQ1RxT0J5enVHZ2VGSGpwRldSSUd2?=
 =?utf-8?B?KzhFREswcE94clZJL250TEFySVhtbHNUZmxXRjhzclI1R1Y1dU9Xc1FPT2FJ?=
 =?utf-8?B?N1V5bkdxWnZNT2FmZTVRak1CeXZ1UnMwYU5EbUtHWVlTWFpYRWlWd1N4eGt0?=
 =?utf-8?B?dUM0eXp5QWs1UUdydUpVVGxZVHBpMVptaUFSYXpZZkxjLzRXdEJKYWJrSjNi?=
 =?utf-8?B?ZkxHWU5ET0x4Zm1WckJnWXJnRXczOFVZZ01KeTNEc3JLaFgzKzlQMlZlSmU2?=
 =?utf-8?B?K0cwUkttZVNVV3J5Nk8wZkNFd0FBU0hUVncwWVFSZFVIczdMQ0wrZGFoWWRt?=
 =?utf-8?B?RzBIb1ZWY1ZzNFdYRDFrT3pnekZKdk42WDlPNUQxYzdFNnVIYityK3g1Y0ww?=
 =?utf-8?B?Z21QQUNFTHA0S0VLS2VsTU5XMXU4WCswbVBJMWhSSXZsZlBZaWJ5R3lxeFht?=
 =?utf-8?B?UGZ1ZGZpWlFNeUNDY3E0ellSWUdLQS91aDBiRmRzaUZOSEFYc1g2bnJpc3la?=
 =?utf-8?B?OUM0T2VRcFpvMzJyd2dLaEFqZHpYZWZidVI5b1ZEQnI1VWMvS2xKVVhVMldn?=
 =?utf-8?B?cnYwUXJodE10LzJvdEVXVVIrRlNhbm9xRVUwYndvb1hUdENack1MMDJYd2pz?=
 =?utf-8?B?b20wL0FNbks1a05YaXExSG01Y0JOZHNaU2gvVE9WR0t6cXpnTlFXVjF1U1k0?=
 =?utf-8?B?TmdvZFFPQURpUVhrV0lHaEExZS9KWXVMeWdtL0l3d0hVOXF4NUM2UWNpb2s1?=
 =?utf-8?B?T3VVSFAvRW1JVy9YVXkrbmFvRVI1dkI2cCtRdWxKSmxaS3VhTFB2dUZmMDlY?=
 =?utf-8?B?VVZRbXVoUFF0V0t3T0h0RGJFNFB1Q2FybFpzOFo1ZC9yc0luVkxOQmxubDNP?=
 =?utf-8?Q?g6ctP4vHseHqYqAY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3452C6F7D37EA439A9AFBD66BE4D89A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LBmbctGuA3q48ejcaUyCVYVQgrJn4HXUARdgNtYPk+SOfpw2TXb04Fu0g8uaDEx90eFkIWuruUGynb6zEwEgWL0ILE/dN9td60KqeHvi6OEwUoV8LU/J2EkAlTZYUb9UEdUDoZ7fyokLkdOo0bhHZnslBvz5Dq3eOk27Vwm8WWxBgMH3uMo+tSnahVTHWPxyqBEC666A9Gm5bTPbo/KbVp1LFxY3v0xvYjBWvA8FH9NL+KuyymhVTGKqTDBSjZ/+P5oO7bFhR1sHKzcZxQ6o3QojKADVwdPhnLOjpXwigh6zN/YBuaYOgaWbccBK9x1fBNzmkAZx55S+QHrL7LCPQQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadd87a2-a3c7-42ef-0c2d-08df09e9e0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 18:33:41.3454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voeHo1CxEKKHG59V5lqJm0vQfIphMLNrOJCM/3FYVFwsf4Nd6cWwMyBykd6sZm3MVO+1wT7d58NCQq1utggGd8wcXo6ugoCRSbc+GD7BuV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB452602
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTAzIGF0IDExOjAxIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8zLzI2IDEwOjU4LCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gPiBJIGNhbid0IGZp
bmQgYW55dGhpbmcgYmFjayB0aGVuIHRoYXQgd291bGQgaGF2ZSBwcmV2ZW50ZWQgaXQuIFRoZSBi
dWcgY2F1c2UgYW5kDQo+ID4gZml4IGxvb2tzIGNvcnJlY3QgdG8gbWUuDQo+IA0KPiBJcyB0aGF0
IGEgUmV2aWV3ZWQtYnk/IDspDQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5w
LmVkZ2Vjb21iZUBpbnRlbC5jb20+DQoNCg0K
