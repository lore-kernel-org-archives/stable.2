Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494F32720C;
	Thu, 20 Aug 2026 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787204217; cv=fail; b=RpxDmiceaI2TOy4NeUtxz0RRWTp3SqvvPO02cmhm2Yl1VjMb/BYblv/HeYpLZMrd7mWReUvS7Ef+mRNmsvk9Icsk6FAuhupMdTOpX+LNqMlDP1SfPGHj6u0/5d30WtCx2GQoX6t6QVqdRv9sD9xL+lheJHGS6CCjSUAdLUzlhUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787204217; c=relaxed/simple;
	bh=mB/vz1HfiP43GuCEAeYSYDchrdI8+8gkhggle2LPp94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SxxSkXHN7z2jB6EtjOlYsIOfBZo26nL1Z2gVjWNK59BEOQCDAOSOPEq5ZLMsdA5jB6fHNL18LuuuVxiVHgu4j+9HFIO8dS4OVHvme1nhMY1VbITw99yeTXz37TIhivCAmmA04MW5jn3tMWSHkPW4njw0l/77vgx+ZY1gdlSQBr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHft4sk1; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHft4sk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787204216; x=1818740216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mB/vz1HfiP43GuCEAeYSYDchrdI8+8gkhggle2LPp94=;
  b=ZHft4sk1KXo2TpdZgFj47hk8lMjWWY2AhY+3dru30N1dXAuSByWd529I
   xtFVYlIoHyOSkGMg3snX3a2zmba2JUhpKjmLApeGQNs8WjodXHQ2ftPF+
   J8xZwznCEBIy0KeH21z+H9Oh8Aord38p819phSJxBkDSl+4VKpcf/A2aT
   5FBgTT4xUzEzP3/8/QaWCgbyjTw5yCuPndIpPQVmPG2pe3FBrgkP1q2RR
   tFeRY9yoU+4scVDg/Hkli6mrz+41UK83hDLItsO8yZYVYXB2BNL8dU0As
   Fre274kB9t9l6trrUqwzCIKC6Ekw+EiwvW6/FbFz59r11y7sMmLOywd3T
   w==;
X-CSE-ConnectionGUID: 4Olv9tTtTm2+3xQKjNPdfQ==
X-CSE-MsgGUID: bCSltGUfS/WUZzpDdhy/Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87587280"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="87587280"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 22:36:55 -0700
X-CSE-ConnectionGUID: fTGTzQ3qSiqU/Uo4OM+4iQ==
X-CSE-MsgGUID: qqw8AbtKQoKpIjABKbo26g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="289339727"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 22:36:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 22:36:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 22:36:53 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 22:36:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vV7hMxrKkIMatda2b5nVkJs1WMe3+aU15sdLrJKTUt5bp3be4eEBKUAa/ZFoiBvCLzkemnr1tuD1FxKY71ofHIkhbL8w9pVVofm1XO5c0gzkGbwkGcD4ej0s4W6brHR9EZ1TfbkX5vAFATubgHiheOLhU+3b5uYFZQmkEhMy3iq3BMnmj04WTUwOqSMOWFpU5cQCmBGX0WNk/v4niFEZFVj13WzWd7JXsW2Ne8fDK+yVUia04K6v73Dptnn5ghwk3bURKxAEPtsAZmHX5kg4uHWjNC+YCRS4qAEJaKtUWSwZiSbWYppavQw/BGc7DoB4TMNnbpu+wKUpr0ZWtdnDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+kRDHMKU9u+Ct+dtmDow+ld7Ld4p0OcZWf3MC1E5AI=;
 b=r7HQpYoyYk+gUyYT8iElT6N5zxRk6IffZ66+msksJCQfhQUKwdKnqAi+eFFaMQSafJE0Xxbl5DbB2H3VxDRnoh3AweyBs1yD0D4M4r4QIRhDmV8b1womXWElpZlt0gg1nfS2larRAB+3WsHoL6/vM2lhgMC4Y97i7qOycLLlu+TbD4riMI7m96jWZ/QOdJNRtCVsUEB8WtBJwlQdHvF3prHE3h0UHS2Mk8RIF8CxFOkXDvB8xnga8fF5ToMYRuw4ZYFbgu/OpuTPkWlksC7YSAEj0VQ8gU1Tl45ze39jKJQxqY7ui7WTyGSvtOXL5SX0ui9Nw+RN/CT/ufkH/TLYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12)
 by DS4PR11MB088494.namprd11.prod.outlook.com (2603:10b6:8:509::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 05:36:46 +0000
Received: from DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c]) by DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 05:36:46 +0000
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vishal Badole
	<Vishal.Badole@amd.com>
CC: "tglx@kernel.org" <tglx@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou"
	<tianyou.li@intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "Liang, Dan" <dan.liang@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] lib/group_cpus: Snapshot cluster masks to keep grouping
 hotplug invariant
Thread-Topic: [PATCH] lib/group_cpus: Snapshot cluster masks to keep grouping
 hotplug invariant
Thread-Index: AQHdJj+Ee1DbtlQrWUq8ruRr0C84obaTDPYAgBNuo+A=
Date: Thu, 20 Aug 2026 05:36:45 +0000
Message-ID: <DS0PR11MB8018BEAF560F202A1DFCD36992A42@DS0PR11MB8018.namprd11.prod.outlook.com>
References: <20260807073612.3711269-1-Vishal.Badole@amd.com>
 <20260807133840.31a194a9cd04d4a2b6d817c1@linux-foundation.org>
In-Reply-To: <20260807133840.31a194a9cd04d4a2b6d817c1@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8018:EE_|DS4PR11MB088494:EE_
x-ms-office365-filtering-correlation-id: 66a66625-c7a2-4601-db0a-08defe7d0616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|38070700021|10067099003|11063799006|4143699003;
x-microsoft-antispam-message-info: aT1WdIkEGgJFGhCVOJC0FKOZLIDcEJeffM9GdibTkQB8Zs6H0YBKfJArwFvq628UYi0B8CaYtVaaO+u5H7BNqTHhIwaWU/UZbRNLsn+wVOMzvZcKPCeFVhbY3S6zjIxIycnqXL/6XOH6CJArAVTyeOs2hdwy+9RtZvsKcLztS3Aknbqr/urfd7I62fpi91UY48lzdU4Wba3JuGtMa+wnZfQVrkzEc8+B+JKw7n4qutPh30gU5WJz/hP0Ui40Z/YQ2yc6zWdW2RpGDIipKcbUhX4IihCX8BkOyNWUZ8a0mEqPHGnkoDO1PzFMY+F0ozTka3Br83UxU7uB7KkAxcxO1rpalQJ3P2Tw80jAFjaLZbZF5+sYqobxJy+a/LXGvidm68WbVKJvr6gdpBhQefFkORhiPnCjxLmaeqo+w7BQNmtsXN9B3GpzosjPI8rXGI0meYlWDohaC5m+elWyXLnjCB43lJ2l8P9xXm0ldV+wahPux5c7TSpv+Raa9mdbVtLKSszuuTTrTrDl/4/87c2+iSP6MLqBVA+2ysJG+eOfYhKPcZtuwqs0BavlKKvqRa90IPV6Q7KI3pDwoUgirb6gd18o35v8D0j9PX/p80+yZ1smtGUgB9JmYqmb1QYMXgJU1UtEIUQMJpgZbVCPI+J6Ae5qeVpfGbreC0xyt7ukRhOApq1sDlkZQfYp4uxMYT0DqO6buQwtdcTULBGa19C8jiepFT48jIngrXJwqLMQo6w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2qgeWGVRRhsJIPVEJVln/jzYKaoX895wZ1gBKUyA3AEVXHhn8Y7ir0cv5co1?=
 =?us-ascii?Q?Um0/7hBgHfczeWFMhav5dGeDRbsvZJj5B4UzUXpDfOC2nJ9/CmuAkCoWlRwZ?=
 =?us-ascii?Q?0xVO+pe4iC7DYDHjfeCKhLUTxoj1QEgf8AbUIo/LwiTSkeJSVqEdJYBPg5Zh?=
 =?us-ascii?Q?Omy8i0w+hhdiZjj0nNXaJYMdIXye7IVVACi2bmC5UxZH3sPzSNKWTTwM5o3x?=
 =?us-ascii?Q?bU6P0REHupP/emy2TquaoBoB/c8SUVTRcAgTK2JzyUYd7TFS40XfJHQdxdG5?=
 =?us-ascii?Q?anzPTnMv1hkWSwfQXMOADgPHXSBHSsQdDw9I0FEHCU6lyM6S4BxXY/TNWSsI?=
 =?us-ascii?Q?9y0UuxidUAMCYkllSHzCURYIqe4psfUORcNBIqh/BRsD/XZB3nZFS2MXlhU5?=
 =?us-ascii?Q?OjIK24yvulj33AnV85+p6SECO6iXfhSsWrAociT9lcQXuroeNc+0UqdZywAj?=
 =?us-ascii?Q?xo9iu6vpcYaS7R9YJFilt1gko9dPJBQvQVczS1IagKwkoYAN185P9Bn306Tc?=
 =?us-ascii?Q?faNSJz4069ViNcuwzGWWOdUnmNu/ay876Fxt1oYglVmBUPPWAbsFxUIbPV+q?=
 =?us-ascii?Q?ZWdSKOU43hc0+WKkX24hTsSYJDDk65Exph+Abd0KfWRtOaeX3nXwyLPU1HAW?=
 =?us-ascii?Q?SuwxWhViTaOv+pRY8J1q8UFeg6pLLPpWsD/6lHLlXMWxnbMGf0XN7FbNqDh+?=
 =?us-ascii?Q?tIKz3NhSz8TxTSSw4DN5nffRupYhRqL+2raNXhDL10JifIH/TMOx99/sAp5R?=
 =?us-ascii?Q?AgzV+LMOmIA5c8vE+7+UBrYTs166WRpm2dsv2mTGvNW+pcK5s0tFRw0VgQ7m?=
 =?us-ascii?Q?6oQmbOH64GaRQaYZElREdU7Sey3t87+M1ASzNLxTECqevyMRFSSX4chFQdVc?=
 =?us-ascii?Q?IbIeSF1NUY+D0ZRS3c6XRO+A9aq9S773eToGY3MznQQRQzhQfwOYm1jIj0Ze?=
 =?us-ascii?Q?CmzYnmJiH27XHrPJLPPd2Ot+MX5sZ8voy9mbVEzSA2uz/h85MTB59lR5AIXA?=
 =?us-ascii?Q?mtuzAfEvGe3vlM6J51ve34CXlij5/sXBKGQJNRbG2vldCfpS0hcyGQ4EPjM1?=
 =?us-ascii?Q?aA0yryOBoRtvz5hUzBeF5OzLHk/+2E6WMmUunYq1ww8EfOI28qrzKu47LWBr?=
 =?us-ascii?Q?Vy0vvHf8JCuPxmlNKXijwd4t1AkToOjHtwcdAMWcIpxoPu+fgG62QCT9LQjI?=
 =?us-ascii?Q?jJibrs+nNdhRJG+B55NgCTSsAJZ026q+jWequxPA281oXxSaT9LfOiDTMIhy?=
 =?us-ascii?Q?biRRpk2XK5sdH57ZpoKfd0jPsRpA+ErlANAJZQWROfS2kaN/KwNNbqo4R562?=
 =?us-ascii?Q?mrS97xVVsCYENFoX7HCwyLvr29/Qg//Fe/Qg0Q7xHUW7S3GpQDv5wj+iuXud?=
 =?us-ascii?Q?l8G+mguhq8hxnxA5QEtt/6eV1gqJhr9Oz75rMKRnvpyw+1o0eopWWqysfy8u?=
 =?us-ascii?Q?0HGYQQ2yL/9/DvAfRpmeYEHEaBsA2bxclNJjPohfkC2ZVMgUkZDcodCapQt8?=
 =?us-ascii?Q?u7DoT+2EVrkQ19aD8tKLuwOrJbnKjYI/HIuv6gBbLUlqhqOjZhw6azvF6wmG?=
 =?us-ascii?Q?DR1Zh6IIqnOeFEhii6bJpgvcD6Y0kyanQgIvET1dSxav5fRSGknIxK4ts7zJ?=
 =?us-ascii?Q?6l/+0zJhHli4J0NMlJ1fyOi6Iiv1SbSPFyCyUtAcVZjIQtrcZFpT2hpnnOyv?=
 =?us-ascii?Q?5KkZksia/T+CCmd0439q5UTUHH7DBGal3Hk6PPgT9hF3Z0cZoWjrHJxGtD/b?=
 =?us-ascii?Q?gUkMiTRh0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: si1DATgvNe7M4YFCPbdWn2jPgUXECuoJdzju3GifJPPG6pJkvdl7u6nkZPzDuQ/OPCqzLj6/8SQuX+Yl8UJGBPiLv6sMo1CEMdVq7abBZLllfZGKzB4jNcbQE8u9onrqyiStibAi55Jc54YxmaYIAndQmKqPo7QQjTCqDhE/BMe6gTsYOaYsCn9iYEGNqnBd1qUl7axLUnTNBzaartI+zzGito3sL6BKb6aA6+ZsBZwK2vEq+fP/c8zAWPhJBrYOwuTc+bjAVpqFgh/Mo3sGa/uot4oKrRvO+i0e34INTkOljm3+8lwVsSYIX1vi03z8CD6gy2QVYb0EaKVLbMUIFA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a66625-c7a2-4601-db0a-08defe7d0616
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 05:36:45.9437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9ix5zRVv/0tr2lzJri/m+zSrty60kJEMRkP7j0o3bB0MyjYuDE7YcTxX9qqC9MfgGph4Tql377mZ+JDjHWL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB088494
X-OriginatorOrg: intel.com

> Thanks for the careful description of what is wrong.  It helps.
> And things do sounds very wrong.  Could people@intel please prioritize th=
eir review and testing of this fix?

Thanks for highlighting this issue and for the detailed analysis from Visha=
l.
I will help review and validate this patch and will follow up on the thread=
 with any findings or feedback.
