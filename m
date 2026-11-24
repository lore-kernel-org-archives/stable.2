Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521204;
	b=FzrZ0iShHoXEl/TpdDn8690lx1YfCLboLaaInVrUbi0J/rAXjWb3Q/ML+kv3S1S2ki4S
	 euqgfOAdIz0SjnI8a7vSUOTOQRXzp4brbXJNKQjX2FM7RQb9LVGWQ2bhsTIdhRZNqXkRp
	 kkhx6H1dMPE6/sZmYEG3jpNRcOP4UeA5bUXOw/rfpCRpI1/hxGvO6zvSAUyvO37bcWcFF
	 ngBClX+KdfWSnb2p11RamezHgQer4z2lRFVOEMQBik8MOE1NWcJGElFqT9CuLXYqSCYpA
	 Q89YTrjM7ewteSZpjvDKPKQNBwzB5BmDEu1p/qDkDW1eSI07jfeGE5sGmbqNlfr58Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521204;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:From:To:CC:X-Mailer:References:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=iSNadByuZEoqZHqOdcHb8De+1lb4xm9XobqIAfgUUNE=;
	b=K5A6xBXTlW5DvcisiADH4iKtSRdSmKkRxkDCzRoR+Xit5mKKrlUr6lu3t8oMNTWujlRF
	 HbgaMAmARvoVXXuC9Zv9bWPVAPlqyqR7Y+Cwh7YN/sLsfN86zz6x5KqvdDvBi//qR+7E4
	 msAg0t9qz40mcjSM//MPEUYuKM7XM2+34g2iZaDy+vnHY7BwkbFUFi6MINZDDGXJzdV0p
	 7IDM/7iCH5oQfg0R1Wf4l6IaTw5fMksCHLkJubLpuIuoXbjv/FYhlRfr+rSstN1xDKAPE
	 99mWXBFjaLb3R8UDc1V2dqdSuaQxlitFthdg54BqT6W83HmYUXKHV4BXXq1oGxuX29Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xh9uiDcm;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="dMnbAO/k";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F1606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C7F1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xh9uiDcm;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=dMnbAO/k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795521204; x=1827057204;
  h=content-transfer-encoding:date:message-id:subject:from:
   to:cc:references:in-reply-to:mime-version;
  bh=iSNadByuZEoqZHqOdcHb8De+1lb4xm9XobqIAfgUUNE=;
  b=Xh9uiDcmuraeWAvKNTnOa52MYAqsSZAMgKpTEiSWUoJtKvBPGzJnb/rf
   ZT8kWTnV+IQK/XhT41WSTUaexkkTwmhsR4wZkPvVWIbUgdX94G0rK4UQd
   /TT4XV0F3t1LMhbWOpucn4j95xLZMfVDlaT3+fvaRL5R/kmkPgG/hy9R8
   I0yVSvk2wKy3Ng/Degpqn+MCb8kcy5c8o+PasidTKqSO0KXhyYS0hduvQ
   oEGJf8+Vs7NNjRT8IKP++twsaSPBR+yvN/gTTbCYTR4udYdPppOU5D/Vp
   904w1yNGE5k2Hispo4o2AZXILviD+16P6fWPPHlXjDg/+g3EediPpphhS
   Q==;
X-CSE-ConnectionGUID: /b2V+orQSta4H9ioNDIcGA==
X-CSE-MsgGUID: epkMBYvDRW+a6lTBScckoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4249875"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4249875"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:53:24 -0800
X-CSE-ConnectionGUID: 9rjnTgXvSx2RcY1OiHDqbw==
X-CSE-MsgGUID: luzaqVvXSQilKkd2nS3uVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11458091"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:53:24 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:53:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 03:53:23 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:53:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyuMKIhmHXc4wp0YD8BTDw+WoYYUgs5e9yan6S/HP1f7uthnSlQ5WQi6Erjbwgm2tc+vX1vpchWN3n1vvUx6DcSXGy88j6CKERyBRlHci7KcjntiKsKNJsdQ9A9eKCkSvjs1zgTTbUjAzoQrYqoceFfhzENZKZs7A+qmAeyvLJ4PtUqisOq0zPaxEKwnIor1vniq5uownfWRQBqqI/1JENmASotuvOkDMdOjTspGCyRUt9MeFEbpWX5Iv/kTZCzulDYa3bjebM/z/nQcd208IDPD6h/MDobWwf5zdg41WzpJqWWBSoZuVaHFv46pZdv5TGkh49/VT8IfDvr2afAnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSNadByuZEoqZHqOdcHb8De+1lb4xm9XobqIAfgUUNE=;
 b=opRIYnpFdTEUr9yY/aJejtF502TlC2WXMLi3kaGeAG4clPebUDx/z23URBNGdt8VzH0hoDks4NRncu7g/R4blF0C1gannceMnQG03m6QoZopWOyV5/wa6jxg4GWfOkGBrq/6uLwfqkWfkWBO7bIE9BkEyb2Z51rUgtT+qmBJwwU9hpZdgaXkC6ZaCRj4RAPWW6IP+jZNTEuTFSFjSjbMnaRfGRDZwDNh0RLPeTCngcoALZoKklMVmdiJrkp/FNIswdRridv7korV2RWMgWv+RWxJgMT8v0oL8vcmEiOw4frJtKW4Y4IlsbjM37/IHadTpl3VAXi1C58wW/XYXvfirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSNadByuZEoqZHqOdcHb8De+1lb4xm9XobqIAfgUUNE=;
 b=dMnbAO/kz4OZNCI/6+0eqB0iu+hT4zrvGdIVYOWTGnkB4BgTKiI08r3WR07zX1xvpXUq/ZolPAiOBbYv+lq8HHsa0DPQ28Wsz6JNnZuLNFipo/uDFgiROBE+EhbBH2UaHdjomJXoJKSXIAU2Shu2KGQqPmNTtWIVDRsa5nCYELU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB134916.namprd11.prod.outlook.com (2603:10b6:8:4f0::21)
 by SJ2PR11MB8348.namprd11.prod.outlook.com (2603:10b6:a03:53a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 11:53:19 +0000
Received: from DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4]) by DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:53:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 12:53:21 +0100
Message-Id: <DN3F58JJS7SI.VLAGOS120M87@intel.com>
Subject: Re: [PATCH v8 3/6] drm/i915/gem: Free sg table on failure to
 acquire second folio
From: "Sebastian Brzezinka" <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?utf-8?q?Micha=C5=82_Grzelak?=
	<michal.grzelak@intel.com>, Janusz Krzysztofik
	<janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
	<sebastian.brzezinka@intel.com>, Krzysztof Niemiec
	<krzysztof.niemiec@intel.com>, <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
 <20261109113758.1491891-4-krzysztof.karas@intel.com>
In-Reply-To: <20261109113758.1491891-4-krzysztof.karas@intel.com>
X-ClientProxiedBy: VI1PR0902CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:1::43) To DS4PR11MB134916.namprd11.prod.outlook.com
 (2603:10b6:8:4f0::21)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB134916:EE_|SJ2PR11MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 203fe7f4-e5be-4c64-c4e2-08df4a2188b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|4143699003|56012099006|261022105027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7ufPzvDjghfdN9vKrmv9AGARzHF2C5D7IQO2EcPRSziNq6C6yWWe8R4fOXeSo+7jIkSBXScbENL8VFQfkAspOPRA5Q7XqO6W2kl8q247Q9NerbsB+gyfm74GNw6xhKrAk6aBZoPweZnrnoz7+hvrEFK0H4eFbA/KIKko1aM/VDmpMmG+2QAgttuZEqKWI1YIndLAMKmEATxQjt33SV5hrcwS2NPNEHB1+r7t7OHmJp3VOS2Ot3dtsypL85GDFHQ2/dhLvsPlaCVrdqxWt4nGGBlOcqkLnije+eFPsUCn6QpJy1JYFqjnJLbrbdnLta1eFjrxxL8D1oFijUu8epWsVs/BxXXMYYJUf3PXBeFprZ+SO5jY3acY+ln+IdXZTSHp0dZ41b2qMgCeBEzmRTBpl8PDQaECYr5cO4rRpIDJbv8dGg8Kes4XeNGvFVasDkw2zhNiHbEwt7Nt7rCH7PM2gruygGBdAd6hElb0aA40daCF+2gxrBhmDEWcJcobuvDtEKRQfxw7tTU3UUo2Z6LfACAc2bC5MGOhN/Lc7AcxAiqG28RkRjk/rgZJp9AhS0vqw6OnhObrtrzOc2Hkf8CTc97cTevtO9Ntj0gWeht68KOcVKTRm5A2irloW8D0Kz29UTG8WwLbsZjzKuehTFvg9LIIOKjNDTm3oVtb7mI66rU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR11MB134916.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnIvWGxRTDRNdS9VQStZQzRUdUt6L2NyanZZTnBNejJZYngrTmxEb1ExWGFX?=
 =?utf-8?B?aTlUUG1tQmVDdHlQOWtObzVaOWZ5ME0zbzh5Wkw2NStPa1JyTWZCdktTNHpS?=
 =?utf-8?B?T2RDWmozdTR4cWs4bHdhYTRDWEFPVi9GcXRJRXMwQ0U5ZDloZFBvd1FpSnhu?=
 =?utf-8?B?amh2RmJmNzM0ekZ5ZXFIWG56Ujl0VzJoUGtzOS9iVmw3bXZ5U1JNNzB6OW81?=
 =?utf-8?B?MC9jNy8reU5uWVVxcnU1SGpPUk5wTjlCQnoxclgyemtDRnRxY1dibGJCcEFy?=
 =?utf-8?B?VVRBQldGSVI4eU1jS3MyMHRVQ05lWVFzMWZ2R1JzUHJNdks3clIyMTA1U0xV?=
 =?utf-8?B?WUdvUDB2U1plWUxuL3lBQldCTmFLdDF4Z2VxWGo3eGVhVTF6SDcyOThVKy9H?=
 =?utf-8?B?NHVzRTYwK2xFS1B2ekVkSzRkRittMXEzVzJmQy9wY3pTYnZneXN6VGVRNGl1?=
 =?utf-8?B?cVQzcHZZOGhxR1g5SFg4QnRXaW43UlN6QTE2VGJ3YTJ6bFAvdWUxeDAzaitX?=
 =?utf-8?B?YUJSYU1zSDduaUZMMDVzMGdyZnluUmYwOG1aNXc2NVNDOHBLTm1aTjhRZ1Jo?=
 =?utf-8?B?eVk2T00zN3lFTHlPVCtZYWVqMGNlUHRwcDFEUlRHVFJBRUpZZmRsbUgxR1J3?=
 =?utf-8?B?c0tRLzVsQ0UrR1hNUW91TzU2cldqUE1EaVdzMTlOelZnNWVERVdIYXVlVUhv?=
 =?utf-8?B?N0M3ZlM1S3YrKzNLVk81ZWRjYlpBMWFLOXhaZUxTTm1jWFQvQWovVUkwU3BH?=
 =?utf-8?B?YnBPZjZlYU9pZHdrUnp0QXZ3dlE5NXRLcW1wQ1BjWFdkbVVSTXRkUUEyYzFi?=
 =?utf-8?B?eDdYWDNIR082QnVVaW85ODhBdHRUOEdSb2tuK2hMeHNVZ0Rvck9wNjJoMTlx?=
 =?utf-8?B?WlM3RWFadThVcCtRYXJHd3ZPeWRkSDNKYXVqYlM2bmJ3d0duN0VVc2d6aURy?=
 =?utf-8?B?dTBwL3pHUURQK3N1NTVTWlJNQ1dKTWtYL1pxK2dESGliZXVMTmNMUHRIQldT?=
 =?utf-8?B?QU9FaXI5ZlhWQU9tdGd4MVRBaStKRjJhTWVncHNUTldQUjArVzBTWXJoVWxE?=
 =?utf-8?B?N2daazdGRCtSYTBzM3VGS0VzT1V2aHRnV0JUOUI3TTE0dnNHUWNBM1FPV0Fk?=
 =?utf-8?B?SzNVU0Vtd1lzcTdrWVc0dWxCUDJJWEF1NlNIamNaQzRhMGVCblhJZmxDWmhV?=
 =?utf-8?B?K0krVjhkWUJ3TUJ5TitBUlRyV0lhLzlyd0toRSs3ZG1SRmlWMnp6dml6S2tj?=
 =?utf-8?B?c3FFak5sb01lY3ozcWtZaXZROFVlakdPV1h3NzBTMlpyRHJyckhNZGwydjF2?=
 =?utf-8?B?VUN0VGMvdmliU0NJVVBRRnpkV0lzMTd0bmkzcU9qRXdhM3RiQ2UyWnZmVVNw?=
 =?utf-8?B?Wkc0anRyUlNhOGw5eDZpOG80eGY2ZmVVV2k5SHZWeVlOSjNJRlRlTTJxbitK?=
 =?utf-8?B?c3gyelZjZnZuSWtLK0dpV1pxRlhKZk9SaFNCeHJKb0tva3NtV2drWlBqUzlh?=
 =?utf-8?B?NkowcTVTbnJ5aGhnaG8ybkhCSTNidTIwRlg4d3kzUmFNdTRnaDFETjF4THFV?=
 =?utf-8?B?Nm4wK0dJVTRMNFk1OHM4MHRBaXJKazFIY3ZueW53ZTRBMzE3V2dSaWxqN0Vk?=
 =?utf-8?B?T09rejRqNDJWWURncExZMWF0a1lVemJab3J0YWRxQWVuTmVzNzlGV2hnMVZy?=
 =?utf-8?B?citvWEhRcDJweDB1cUYrSTFGelREbGQ0WTNIenpoT1Z3b1V1akxxNGwrV2RR?=
 =?utf-8?B?MGx2c251emRYSC9XclZVK1Z2ZWhYcnNMNTIwQVNrdC9ESHBBYmlKZnN1am8z?=
 =?utf-8?B?bUt3eHRUa0ZIend4L3k5a3VwRUQyek96MDNpaEZjeVhjRXRRbWtjNXZWaXZB?=
 =?utf-8?B?Y2JNc2NmdFl0Vm1EZSs5VFN1UmE0Q0VjZno5QVpVNURtNDh4VjFZaDZIQnJB?=
 =?utf-8?B?T0RoQS9zdGFuS0ZnblVvbnRHQkpLaFdNSkRZTTJLOFE2c2IyNlU2bE5sRjQx?=
 =?utf-8?B?TWxPMzZVck4wZ0Vqbkk4OTVacGdlVmdNYy9KS1c5QUt5eGNUeHVRN0phS3Vo?=
 =?utf-8?B?M0tCbkc4bWphREJHMGlSTThlcG8xT3FjRFY0MEc5aVdMNXZ6VnByeE5FTUdB?=
 =?utf-8?B?a1NYN21yN1pPaExRd0ZkOURLY3JEckdieTZMTFlvV0hudjJlVXNxWVphZnhm?=
 =?utf-8?B?QjZoWTdQZ1RYS0lmMDFITUwvR2Z3QXlMTjArUzE1WWw0VW1qaWF1ZjkxNGl3?=
 =?utf-8?B?d0ZVUTUxRGlDTXpLZWhUNzRCcXdURERvbHpVUUlRUkd5VkJGdlVEMCtLQ2lC?=
 =?utf-8?B?YkxxY2hyeHQ4Q29NdkhISUtqU0pVdWtGeGI0OVB0aTRxOHl5VjhXaWZxT3Zk?=
 =?utf-8?Q?mo06vaMbK9pPhOlM=3D?=
X-Exchange-RoutingPolicyChecked: Ll9GIAbMMKQ7IGg7g3scCZeuYNm+oCkzlzFcfnjjcoEfeTNMH6H1udNoA18+87dYD3p6iu3zSs+eWdalMz1useLgXrXwxcsuLavcYa/BmYcVhzkAl45momKYiTPQFAe9FKB2GWJoo6MZMRW8UqHg+MbTzX20SW3E7WPJmypSmDJY660y+mC199vgsibxM1iQZgra0mtis2czmNOh4sW0QL4x0xff+dvfJi4wdpSPBIgz44DnqAkQXpAvHn4kD0LUjL94Tijq30MB/CB8Vdg2tt4T1JaEiPa+gcfSugP+/46ZKe/vwKOY/ywByCY9RjGO3K3KgU/g06IomQqeG2bsng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 203fe7f4-e5be-4c64-c4e2-08df4a2188b6
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB134916.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:53:19.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/pnmRceCsoKfcFQkYC9/Jg07p1dG86L8iTK79lo2YSAGY3isf/r+SUcDDZc1VPFGfHjvT6MCobynqbJ1Ybvd6J0CVp7fHg7OpMZLYhZ+Ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8348
X-OriginatorOrg: intel.com

On Mon Nov 9, 2026 at 12:37 PM CET, Krzysztof Karas wrote:
> We should release folios if the first entry was populated, but
> loop failed before sg advanced (st->nents =3D=3D 1 && sg =3D=3D st->sgl).
>
> Fixes: 957ad9a02be6 ("drm/i915/gem: Avoid iterating an empty list")
> Cc: stable@vger.kernel.org
Just a nit: only two patches are tagged Cc: stable, so please make sure
they apply cleanly on their own, without the other patches in the series.

> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

--=20
Best regards,
Sebastian

