Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794450022;
	b=5alOU2hkunNk8TwPrK1ilRIO7Cd+BNJzLQ+dMVG2+oRWbPcg2E6RwXvU11d7pQXZM+21
	 ZdbBJdVtXApa+IbX00i4ee5I5Xzd2kCQHinWNn0NbDn/Fp2EY1+98eS/r2pPVPl3rHsL+
	 BfigQa9QxHHuV9zUVTSgpYntIaX5HOz9qdBT8nNPkLgvJuSl1/jxtUaFNYHqEgSKOf4OM
	 BRVOYPFDlTqq7Jv+wHlVVgbtEAQRTzj3N/Quc1xjJNXM0Z1RtH6jzI96/p44O5vSEwyKC
	 1+lSnMijC+I/nZLJmcrmzZwzf1Lfh2glxCxBawWq8wl9fYywqPu4J8FF7Ii4+NYTnzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450022;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=7nyBkKTQgHUEdIXNUHwZoguX44EzvzydplEaE92M6GI=;
	b=XHMan0ibSY1CyVi3tU89+Yj2RiYH9iao80muH1E8O3xati8zIMFfjVVq9WYOYgUui3z+
	 WJCnMtNVd1HT5mkFCO1+RAvJdE6i+oRa+79JnHy3cJiQYwZp0pLhGXVItv2kLihC9Kueb
	 xI7je0DtLz+lQIbQa40ozP/ysWSTe0brbjLzwdJuBHfZxj0xgp5BIuTwoxKEpIl0rK8zW
	 mlfyPpmpJJGYz2mykE9WuBAKlD9gAW8YgCXF7pz7CWPpu8QLDJuODnU6OSlowfkKgnKYH
	 a+PwcF8Zx1gON5Bink4GEu2WpK3gKprKe8iwK5MBWGiMd9SGfFTpJotfnpLCLMmhMsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PqvreZWG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F28606A324;
	Thu, 12 Nov 2026 02:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F28606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PqvreZWG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794450021; x=1825986021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZOeoGC/l/vJtpcPQtUMIwGUytY2UsZJ7b9ZV58xLoXA=;
  b=PqvreZWGMlcrI3pTFXz/oBhm65oXD6ZiQIWGXyhmKX/zywl1agDix6Gm
   bfOKIihy2dkFHOxql6hm59VVm/0/Jpw2DZUNREAf5ljF2Hfh7BS7ANolv
   dzQn0JB2ZHYsF/TOdZpkTdKlNBnSBwoFhbmF84zyVg0H6+R7wrFNOvlJL
   PL52Zk7hRaDtkiT25/8lwLKhf/RYH0XyojOk18/v5g+b5XHEhfs2D7Oo0
   0iMpEhcqlhN/TzIo1eSws2xg0pYz/lgVCy1IbwKgAll56KfsCbl9BayrG
   hm/gbgKBrwbUSHM8Kbjy5VXdJMi/mndfGrrNpjtPPzDOwQ/FJufWcfx/L
   w==;
X-CSE-ConnectionGUID: Ou49hz9TQ0qYfH04ewpcRA==
X-CSE-MsgGUID: /F8fCSiuQjSxZ3c6jeqzuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3124817"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3124817"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 18:20:21 -0800
X-CSE-ConnectionGUID: FMW8VIQ5SBWa4/AX4v6z2w==
X-CSE-MsgGUID: 1LM5+19tSZK23kPOkA1PzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8720268"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 18:20:20 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 18:20:20 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 18:20:20 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 18:20:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdIvexy/cr000Rd7UMI5FKNaEvL+6piUS9PbcZMiKOJvDIh5n9g2PamAWSAgStDu8UFtKExgBxpv90AaJZJ6izTgj2aDRr2IRX4Radlu+rToD1P6arJc/DBtDxEY40FhGKw/THmi8/UMsgek6dPirREa1l9qiz9S1ONXqKBso3nOwBqeh+q7vMdNDSFUlRS56My4h9Y+Y+MmSCQ4VvWd6J+oT99pne7rjZjL6fIYytEqvhx7HbQhmTnQciSsFIZ6fuqyGO9eEyIc5PM8N6qGVD632F9ofnet4AhvlV/hGp4Mh1c6BuZwK1ap34kDywHxdRI57DPDH60pklwmFTB39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nyBkKTQgHUEdIXNUHwZoguX44EzvzydplEaE92M6GI=;
 b=N9PfhxjAeaH9KGjFuHswBolUq0o8XAQj73Cj29HANaDN43HOwFvmqlKeRocVLMT+BS6G7yzLVYAYecpYaFQaZT5UKw4ehfWpZl8JZMQuZTWaZQ9DtjhD9eh/7xZJf6iVxwslkYFh/71grWsvxf8m9CXK4mcS2LROIFTFksWLhT1MWsp5Fsz1hdjFrso3c7+8SQsPcpSZJt8IKHYfotfv2ci6GpjlqCeynNs/c/yNSeoC0Z5YZNoqEPzeN+oUFOEZMAFMqKfq2BJvwS8oyS97J19TDrU2mv7r1Aiq+wI+Gi3HSQp9lp0WFR1/V0adN1tV/fdLSA152q2pTTA7v9e5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6982.namprd11.prod.outlook.com (2603:10b6:303:228::10)
 by SA2PR11MB4827.namprd11.prod.outlook.com (2603:10b6:806:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 02:20:18 +0000
Received: from MW4PR11MB6982.namprd11.prod.outlook.com
 ([fe80::b676:829:5412:4afd]) by MW4PR11MB6982.namprd11.prod.outlook.com
 ([fe80::b676:829:5412:4afd%3]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 02:20:18 +0000
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Vishal Badole <Vishal.Badole@amd.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "Liang, Dan"
	<dan.liang@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v7] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Topic: [PATCH v7] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Index: AQHdcTteOA7aR6Q5UkuusBDOPlyVILcps6sA
Date: Thu, 12 Nov 2026 02:20:17 +0000
Message-ID: <MW4PR11MB6982C90C849A81DBFEB95A7B92702@MW4PR11MB6982.namprd11.prod.outlook.com>
References: <20261110174513.461743-1-Vishal.Badole@amd.com>
In-Reply-To: <20261110174513.461743-1-Vishal.Badole@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6982:EE_|SA2PR11MB4827:EE_
x-ms-office365-filtering-correlation-id: 861b1e22-afce-420b-3c25-08df40637e9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|261009223027099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: UkjHAkj+BRghrEfQCokYIFVfAV7qcvTIBn3IQlIj6BRc4fp8q0LQBIrmYxrkyIgjDo6L0r/+sz0yQul3Uqw0Er5Foe+hOe9f6UAnNCZYy1F86Lx88LSrG9iz4O6/ZeH+As3FZmNj8y037QrkFEl9MosmuJUl2fAx8La17YLOV3OZjQ0QehQ7Uy217CNzRCMsPt83r920OAITW01gECTGO4eu3duZWkC+ZnAPezSDDjZeZhOAdEj2FZY4jvTtxdtv47Rbl5ghn1+1A821VkL4PeDKtvuqFOUmHEIqrPu3xG1c+oSNoClt4T1WAX1gv4smaSoDr06pttNW0hhylzfFko3E5Ks/KUOt3CPrr7Y2Dh3YD4TI2tw0rlY+Ko9+JvEl5q30BIyl6xpO95LqdRqLjrm5OtHXCUelxIwyYeFJu9RJF7l0YxeRMblnSk8ycMRSYSoST/cNTRGcKPiB1uhnb2N+mRqWvwluk4FuGVxbQnyFwjHRsO+DnjXlL7aZPRTBnXvv5Fe+zLcjEED6TJVc0IbKaITeYyGGUbkesp5FCe2fIKA5HGl2ZtAeIthoYCkuinsUsCu5pFgsrHm/E3FvBQBPpx0rRCvQycekVlF2pIJPgyVy+PzwLixmUxNNfypeZxb+08bIUZ+/JvwNHAGYU1CSAGYk7VUsWtv2tHvrg1It3WRkZhSb1THxmJlw2RPAZOn2z9C6rlYJxfChFi2zdwbXnHTjjjde9YOoZ45sxwo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6982.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(261009223027099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261021121427099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z13FvRGs6hnkHe+ZOPzwMBB7B7nD7tgvmqcDhFTw77qVPNW/dttBUQuCbBQq?=
 =?us-ascii?Q?lTvGm3TQfydd3Kqc40h+Nigzr3PqzZnFJGtK4rmDOnAXgBpjbyQ/Esg3OA34?=
 =?us-ascii?Q?OaleVqgMk90tPBLP5jnPKmZHnF/GjY9A97Uft7CELdtSeFyoYoMyInkr5QWY?=
 =?us-ascii?Q?Ec4A2hboM7mJMvkWMUZUCJp3KhsBbdx5OCleiMgz5Fm1oKY2EpsSqNIBeOt5?=
 =?us-ascii?Q?PM1WGCBYOVvrBb5reqNr79TwPGuk9KKZJJ7CvNL5pjWehxAWWBGSWUZIh7W/?=
 =?us-ascii?Q?/ZdKg3SMylKmiT95sQKYE2qyVqlqmm0tnihKVNPe/gjBF0PLe+nwugzMQStO?=
 =?us-ascii?Q?KEUPbvb/HnkdFTgB4ikrxRgXWd7HDjR46ETJWZBNa7IAKaVSJcZTH1XziSYV?=
 =?us-ascii?Q?W3ibx/13RiDFk8v4rzmiNF1MlVJaSfKQCPC04hJ5joKePwYIy3fk/yPjxmjC?=
 =?us-ascii?Q?O2gvfkHY6UY3E0PS0OAv6X3MtAV+l9bcHYcshv46bgsIZ/qhVDvU2KK1Zjjt?=
 =?us-ascii?Q?AJTxu78TFzIWpRIFse+nWT3IH3Fi0G1ph//h4175I/YifwSFvPJvF+q2Ba1X?=
 =?us-ascii?Q?g/igYHnC1Gxguse29oWEE9AG6N+bd7QnF56ktYjJVPndXSq3qr5ysbF8yTle?=
 =?us-ascii?Q?Vh9ol22Enjeg6MojqC1odWO6/3QZqPmYeQ8Ssl0Oz/fZoBaU02S/Q+R5sdbT?=
 =?us-ascii?Q?7ECV9LxnfDkhOSxwMROHXMKIQVEtNXR8uoIe4tJPO8YJhmoHa0kU8Y8c69YA?=
 =?us-ascii?Q?5IxcP0zlwJwBaQuHbneFSc+N7xqWcufy2T1Wy63pVHUWVrkYx4yYzxAKDB48?=
 =?us-ascii?Q?NJ06vN2VG19Li6lbbWfEpb4wmf2z5TMEbzqysdkYvB8tlQLXQL+3RO2ZT4Tt?=
 =?us-ascii?Q?Ns90jkI21qr23UnNnmr7fjfp8w4DIMxg74Hd7TtJfxXtqbqr+t0IJbaW/EbO?=
 =?us-ascii?Q?2J9l5ZYDy5n5z+04k5nJcrtJ6n1SZKH2cwgTGPOQsCq2WHWi13RNHQKM6eK9?=
 =?us-ascii?Q?YNXxgnCKWi/HCg0J4XzVpMre+dYe6QA3XWa5IeTSvYDEjP0Cb/5eBBAO1EG0?=
 =?us-ascii?Q?EU+z7t3Cy3NiXF3aEeOS5LECe3QCgF0Cfpgjfy48oAGyMVtItBuTDlIXquLc?=
 =?us-ascii?Q?JHP/mRmrE0msKY41Vi3PC28XLF3ev9kfyzmw/0Vvo7x15S+bvNLm1k/6XEAU?=
 =?us-ascii?Q?2h5pSCCoppizid/iGYX172inuFTUN2BXFfDPgpjNan/Q5Xs5QReuikooUEb7?=
 =?us-ascii?Q?eLiM7sIUFKLeVxy/R2SXn84RMb2BrulCM9JyXZMysuXN9dh4BgracDCUfSiZ?=
 =?us-ascii?Q?VwcAzyuOHJXpqKj0Vfm+xbPrdTuDfbtXd9tz8ZtN+NZU0ZM1J9BP9LDDhxtu?=
 =?us-ascii?Q?Y83yx3BwMFvmJQYtLubNBCJIYRj1CyXVnTokshF10SDLNOMrFowaC/9QtSBU?=
 =?us-ascii?Q?rcvfhzv6SQ73ufwKQF+q4hZNTx8MlEnXgw0LTREboQxt1U7PDgHeatoHR3DD?=
 =?us-ascii?Q?CFv5n3hC2EwOu2x1zXDuVEZNcE1A2ZNXw1jMt6Wyg32VYisejJWJZBPT+zHz?=
 =?us-ascii?Q?Dspeq0VSH/woiaX8vUIqAPCdCmzvhZmE1ZgCfdr8Xmeu44Pted84mFwNq3oC?=
 =?us-ascii?Q?ZpPxJZm6PUNPCYheh87O6xW2c0raV2NilVZx5rcl4rTQywkzkHdJQMbIEojh?=
 =?us-ascii?Q?Y6zUj/EWuUUCNzsoeUFaF4cjyPU6H5HEqhiLXPNga9uz/LomSg2Ha8/xSxYC?=
 =?us-ascii?Q?q0ia3xq0wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-Exchange-RoutingPolicyChecked: K9XRGou9bHmeyabB+4cN0WSvp6VUdY37O+TpYGi2WJvjH1pG3Yq1OLCjPatNptwLvF+6Y/iepA4Isw4xmMcTU1YuhOjolkTVNbUCS+QMvAJIhy8YaaBuW43hegSYY0SbTIk8GHmkb2AFIuPOQ7aH5YnRR+5lo3W35cQr36baUVLme9C11ku0LaItogHVGBFeL5cGS230EfLJBSnH+S34NmdBaAYl6ma8i08nSIVGB346wAuFHy2lfbr9G3WPfbyyq5Xl7Gl8hTfCesnER0OjXQz+NEpH2bd9hiVXRv/vK16Qpm/+FOGUKGqEDZV/9gbPzdmHN6wLMYRdFJtE/VC1Dw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6982.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861b1e22-afce-420b-3c25-08df40637e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 02:20:17.9916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InJRKIuJAZbFErD/9N5iNxD3uD4Uq18GWYB8KADTQAK19gzmhguf/Vaa7yOOMK48LtLChASY4Y1MDTqeR8e6MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4827
X-OriginatorOrg: intel.com

On Wed, 11 Nov 2026 01:46:11, Vishal Badole <Vishal.Badole@amd.com> wrote:
>  static int alloc_cluster_groups(unsigned int ncpus,
>  				unsigned int ngroups,
>  				struct cpumask *node_cpumask,
> @@ -299,6 +380,9 @@ static int alloc_cluster_groups(unsigned int ncpus,
>  	const struct cpumask **clusters;
>  	struct node_groups *cluster_groups;
>
> +	if (!cluster_snapshot)
> +		goto no_cluster;
> +
>  	cpumask_copy(msk, node_cpumask);
>
>  	/* Probe how many clusters in this node. */
> @@ -307,7 +391,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>  		if (cpu >=3D nr_cpu_ids)
>  			break;
>
> -		cluster_mask =3D topology_cluster_cpumask(cpu);
> +		cluster_mask =3D cluster_snapshot[cpu];
>  		if (!cpumask_weight(cluster_mask))
>  			goto no_cluster;
>  		/* Clean out CPUs on the same cluster. */
> @@ -322,7 +406,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>  	/* Allocate memory based on cluster number. */
>  	clusters =3D kzalloc_objs(*clusters, ncluster);
>  	if (!clusters)
> -		goto no_cluster;
> +		return -ENOMEM;
>  	cluster_groups =3D kzalloc_objs(struct node_groups, ncluster);
>  	if (!cluster_groups)
>  		goto fail_cluster_groups;
> @@ -331,7 +415,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>  	cpumask_copy(msk, node_cpumask);
>  	for (n =3D 0; n < ncluster; n++) {
>  		cpu =3D cpumask_first(msk);
> -		cluster_mask =3D topology_cluster_cpumask(cpu);
> +		cluster_mask =3D cluster_snapshot[cpu];
>  		nc =3D cpumask_weight_and(cluster_mask, node_cpumask);
>  		clusters[n] =3D cluster_mask;
>  		cluster_groups[n].id =3D n;
> @@ -347,6 +431,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>
>   fail_cluster_groups:
>  	kfree(clusters);
> +	return -ENOMEM;
>   no_cluster:
>  	return 0;
>  }
> @@ -354,9 +439,9 @@ static int alloc_cluster_groups(unsigned int ncpus,
>  /*
>   * Try group CPUs evenly for cluster locality within a NUMA node.
>   *
> - * Return: true if success, false otherwise.
> + * Return: cluster count on success, 0 if inapplicable, or -ENOMEM on fa=
ilure.
>   */
> -static bool __try_group_cluster_cpus(unsigned int ncpus,
> +static int __try_group_cluster_cpus(unsigned int ncpus,
>  				     unsigned int ngroups,
>  				     struct cpumask *node_cpumask,
>  				     struct cpumask *masks,
> @@ -365,18 +450,17 @@ static bool __try_group_cluster_cpus(unsigned int n=
cpus,
>  {
>  	struct node_groups *cluster_groups;
>  	const struct cpumask **clusters;
> -	unsigned int ncluster;
> -	bool ret =3D false;
> +	int ncluster;
>  	cpumask_var_t nmsk;
>  	unsigned int i, nc;

If we could move "if (!cluster_snapshot)" from alloc_cluster_groups() to
here, the unnecessary cpumask alloc/free could be avoid if snapshot if
unavailable.

>  	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
> -		goto fail_nmsk_alloc;
> +		return -ENOMEM;
>
>  	ncluster =3D alloc_cluster_groups(ncpus, ngroups, node_cpumask, nmsk,
>  					&clusters, &cluster_groups);
>
> -	if (ncluster =3D=3D 0)
> +	if (ncluster <=3D 0)
>  		goto fail_no_clusters;
>
>  	for (i =3D 0; i < ncluster; i++) {
> @@ -392,13 +476,11 @@ static bool __try_group_cluster_cpus(unsigned int n=
cpus,
>  		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
>  	}
>
> -	ret =3D true;
>  	kfree(cluster_groups);
>  	kfree(clusters);
>   fail_no_clusters:
>  	free_cpumask_var(nmsk);
> - fail_nmsk_alloc:
> -	return ret;
> +	return ncluster;
>  }
>
