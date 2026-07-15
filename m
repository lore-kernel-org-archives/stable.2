Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875F429008;
	Wed, 15 Jul 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107728; cv=fail; b=WdsIEKIl3LIgT5jBYZrWNH/OXcLz1znQ/EoCIqKBAXsppMdu8yx3d/09Vg0Oe0htIxi+F/DmxzRLhFwKR65E2knUwIGEeTYseAw3FXrycPyt9mlsMQQSh4vkRTPSMwZ8U5zmm0vKIi6Iv0XG7+MTNd5y/74rN9pLuBJ81ittBhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107728; c=relaxed/simple;
	bh=wxD7O4OkXnlg7ytDKv/1+A74dE5lKG4/TRc5WOpUkQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RoRv+77Accp8z3KpjbcmWK1C6HqhdP6EqvA7WE1G704YCBpu9QUI/km+GIRKQIz9fqzUv2bdyDpmDDsVct9fAJY00HFBexMdN+m9TY+V9FZmydyXPFsBK+vK+ntZisT2J/xlKOaqDYkJrS9AdThyqQOMdHSednAk/LUhtZemmYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J20XoyPp; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J20XoyPp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784107725; x=1815643725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wxD7O4OkXnlg7ytDKv/1+A74dE5lKG4/TRc5WOpUkQk=;
  b=J20XoyPpZylWpp9LDoSlyQ4MtVDrh1hb8gY6x1j8KQX8y4jPXopYQlqh
   +5o2nlCSL/KNXuSrZQbRXwEyb8KtNqAaqwRQwiyjGFuYTbV9U2N7pBYrI
   t7FAqiLXOOmuPM/vxVBoFu1vnsCsPKdGc3/oOboKEwFTe964J0xAFkvAv
   WvpJtJIWLxuM1mJ32zkeQbzJf3sTV+gmoJzB9nlhsrk9R5Kg7fkbYuR1m
   4O1+0zIONTrnH3uI5z25W4QOwd2Rel19GjDXq/jw6cLUGeQEPDVmq5Le3
   rnP0FtWLiXlzyJbfj32+2k8rq4Yq+wkXR/1HRbxNNzxzyISqJzmoxW1bW
   A==;
X-CSE-ConnectionGUID: sdYu4VdyQHi26D6IXgsO9w==
X-CSE-MsgGUID: d/upefUDRHWOMkPRF35vfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96107192"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="96107192"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:28:43 -0700
X-CSE-ConnectionGUID: 3GXrnDUfQGCvuv1ibjmJlA==
X-CSE-MsgGUID: ExYQE6jqTEaOH/MkdmmBPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="255622013"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:28:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 02:28:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 02:28:42 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 02:28:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUVID13fANg+1T41pcGOBQ322SlMH7MLp9HqGxjzSZCHmc8/G+t5JtL6QOryzYzS/uTQYpNukbwf2D9PQHF8k9n36gx1EVFWBsF0HW9dHqZeuLcSUW6mJLAcuRUWPxLmNvXmprAUOZNhx1Y3iyyURJy1iSIvFWyBwMcWerYEfrOnpwc2sSZ3xru3GrWZkWYyiT7tkmAVX6D5awG+MyXTUNh4/78doqdGvWtiWrhzTex6wU7iqizaXbwMTO87kCA0GysOdvoRvRb4aWar+9SA7hCVXb9NZcyfNkREU/8d+6eC6R+Y3SkBYVL4Dn17Us8uJRB9wLScqX0OtxqSgjSbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmC4CCp33+US4zjmTC7mYd5rLRK9jWkWDAZeUpRw2Iw=;
 b=RD39LN9p5gg+s/y9dYdrPRi1ALyuOplzW9LVnNIwUFsFyo0PwaNUyqmD7s48+96Xqi1kWOTwBEqHh74Zr+swFwCq3Xz/GtUMzqX5nxkePYUza/9D4AXQ42F49pTQR7AxxAEfTdleZ8ABGNuoIH5jWjxK/N+0NWeeUekNGzF+dbA39MnfO2KkWXbyvNs7RegGzpPCuRF4k+ImVn511Hjr0KDcgEeD6qC8j1vtZ0noVDgwgKikc/iYmVH+QihFLlmXVGwAKXxr4gFfCP7P5IXt9FaDNAmDLH+1NEJhR/yaNgM3GLEflrsg9t+r/J1XpFSRBKv8zEFVClQP7NCEGUX7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18)
 by CHAPR11MB9631.namprd11.prod.outlook.com (2603:10b6:610:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 09:28:40 +0000
Received: from MW4PR11MB5890.namprd11.prod.outlook.com
 ([fe80::b3b8:941:41d9:9d77]) by MW4PR11MB5890.namprd11.prod.outlook.com
 ([fe80::b3b8:941:41d9:9d77%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:28:40 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Mitch Williams
	<mitch.a.williams@intel.com>, Greg Rose <gregory.v.rose@intel.com>, "Sudheer
 Mogilappagari" <sudheer.mogilappagari@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2 1/2] iavf: fix ASQ command buffer leak on init
 failure
Thread-Topic: [PATCH iwl-net v2 1/2] iavf: fix ASQ command buffer leak on init
 failure
Thread-Index: AQHdFDPO7fLtZlU2X0iV2bSXFTz5M7ZuT+7Q
Date: Wed, 15 Jul 2026 09:28:39 +0000
Message-ID: <MW4PR11MB5890DCEED74E887ACBC9161AF0F82@MW4PR11MB5890.namprd11.prod.outlook.com>
References: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
 <20260715082548.56687-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715082548.56687-2-xuanqiang.luo@linux.dev>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5890:EE_|CHAPR11MB9631:EE_
x-ms-office365-filtering-correlation-id: 446afa22-607f-48e6-bc76-08dee25374ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|4143699003|38070700021|56012099006|6133799003;
x-microsoft-antispam-message-info: 9y5vgG6sP7vEoJFmtpvcM2V+CSaC3hfduNZykDneU8fBHEpL91sBye9nt58K29ZuELnjxvcc8+HmCnqqS9CJ1TbfcZ3myq+GIHOfBQJNlHHhGZkgF7rkVOTrKkChhH0miPTurFTYKmgzLdInIPIDLRBssy+utY7Fuhq9wDImy4u0qUmLOI0wPXyR/ieksvXG/a1HePA1t5gd7PXn6FRJ4dYJs7ZNR34JfPv1fErfFKlZuO2C7kZEotvSe4RZztayiFqc75vZA+7GfmVrMUYuvdupWKnVF2GnqTQP+x0t0aVOCnUemC5y7bHqcTX1y8hnDMDIKFi7C5HtE/fwZfRMLBTXqsI3NcnGe0C8dRqLBrHJwsIdmlgOZt3AnS6aYPOWIfqMBUj2bmd5CCGxWS5a+YCMznTL0gQ4YOj6bwp7ddb3SYmZOa6iAGmTCXAnyjOUu+TzZveTYN1HRsinHVkHHU6JHLSjXGjQhrhzacs5Lv3yggjg9gL99FgPAu6NQ1J6nHsOGQBiIFmkGRfWABDIgvm6CDtJaPfqVqrKSfBf8d24HwsJZIYVdBygoX7U8H8c8bNEPSCL6yLVHuV6i9tqPDZ+Gea96Vr3a5J0trSco5OKgwVRlaXORoHqKiL65Dpfzlf59yKN0+3UCcAKmA80juP1pRPpU+oFEKkrYY5w+3YkcxeTdtxCDZz238/zHq9mx9RBVWRJtu+Okd3gRnraY4iW4Y6ONb5b4UgRltvrfVY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5890.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eLOQzVP3HotWdNhkm5zc3nQnLM0jmyLWYw5XZz+W4sdKRB/1Cnb86cKN8ttK?=
 =?us-ascii?Q?8AgBOTG+C7f1ocpYujfb5Slqyu6w1H8fzVIGqxzZk8qOyu6t/lNfOjb75H3u?=
 =?us-ascii?Q?80pfOQHN5mshiJBYdCO5HcTStdudkaqLGGUsKY6Q6A3DcYAax7k+VdnUTdam?=
 =?us-ascii?Q?cH8+D+1FJEKOMC88hfkz2UYuQak8jm89mRYkxjZXvD7T7AwEDP3s9WFJ1jxV?=
 =?us-ascii?Q?5EF+VLqvPGb2aFwRkc2i2F0ecqIhW09EfNsua5eaWqbRs7gqGzgUcuy38emi?=
 =?us-ascii?Q?uEEL+8s2TYF0zWpzOHXN27vxhUA7xDusBNDbSvLSdv4lDeTj+XrGCwxrRp8K?=
 =?us-ascii?Q?OFi78xw/0mlWVWZqn20mYeb3YII9lGMXaMldms5/meaDriMqImpDJAz3BnNy?=
 =?us-ascii?Q?PyyB+DDWYChHkP1VcNC/GOXiVCzixFt2A0s3LfyjFnc2K++7JhKNBRJFgZ7j?=
 =?us-ascii?Q?m2jxq4/YbMMp1qoCCfKHVz2C9vUZusbXEiuPxjnHkoXY+nuw4rjxtxt4P+fH?=
 =?us-ascii?Q?dz0DchJDH6DOpA6SCTirQUTm2gq0WltHq12e9BtzsHYbj9fDiaTSm8elWfS9?=
 =?us-ascii?Q?VPq/AKN2itFxtS79RPygaLG58VD2LN3/lg8WTwprilEqjPiu3xNMGO3mYf0H?=
 =?us-ascii?Q?96MiHN7vDby8MbVjZBRDbxveL8E8XP2qi4sxtBEfB7oAMf9+Gdc+L5IMwEcK?=
 =?us-ascii?Q?gJcKkS6gkHl2GQRbYhk6bxR18wGsr0Zmkzd2nM3HHktxG4RwJ59GAvg8FZGj?=
 =?us-ascii?Q?Jl1VAN3OikBdodaeVuZcB3/m6cr57J80ouFHzOWBocoCS5Cl4whrFoxNS1sh?=
 =?us-ascii?Q?RrPYv1bN25FmAIrafgW1rFySWShgRmVckhXqLuLjw3IcCSeXuMUtQpLOXi3l?=
 =?us-ascii?Q?FsKwpGXPgzUpCjo9gmI6uM7Ze00jcKKOs3uRNieDOFToD0pZeWBSMJTmeTMP?=
 =?us-ascii?Q?mmyNw9D2DJMFNH957uHs2fSd3Za4bBv8Zl8Pdgq2yvy8t3yOj3EpuGFFpQm2?=
 =?us-ascii?Q?FSP9+lGzlaZExTPwk1FTH5m3yKi4Cr94CuNFZGYtfEiRYIIp9Us54yY0fpse?=
 =?us-ascii?Q?AW4GWTPD40yvYHjIWL0axRM01FkbbOGj+927JXMvhduBGeLa0cILlYzzlIaF?=
 =?us-ascii?Q?2qSPpIhHT5EV88RU7hFbpOIzXgdFUzWi0CYBi7qVESxOETouJKN86vvMWmXs?=
 =?us-ascii?Q?yevWsH0F8Cb0G0gDNqex1CQQscu6JWDb4Q7B9LupZr2iofcjgsIWVRE5NIL+?=
 =?us-ascii?Q?jRowsoVzvbibiVbM5e+m90TyPZcj0K93waNITnI+JIrXSenUpN0QNZ9frOGe?=
 =?us-ascii?Q?DnqiU16iSpmA6ds2N9QUkBeJqKQHlE2R0b9SpIsAwHijKl5oOy9uL6yI+MBz?=
 =?us-ascii?Q?c6vXIYjZJjQY4BQiV/oPLSrJPYjWe+fktMfvtgx0koWldIDW1nIzZ2ERtv5W?=
 =?us-ascii?Q?7QrIBzlGk20mBTITc1d3E3yNYvBHqwbkdcnwz1364pmitLug1jSTKCTz59tq?=
 =?us-ascii?Q?Wa9YZU4pshAijYN+RFr/y926k8ytBq2l700YWySZVmct5QO/uqGsc7SeIqoV?=
 =?us-ascii?Q?EQsdOQghFdTYcFjy1mR+YIEofX41eVv5laxoEf41MWqdVWmWtLL+EdxIwz/v?=
 =?us-ascii?Q?LFDMJkA9gqtjpzz+D2j0mfIV5/vXOVZus9Hw+BNLruMD5+YTMV/ISu/hK9wI?=
 =?us-ascii?Q?xaiD0tgF8hztRLid2mtLbVnNNX0M2ltrmwJJdNj9O6ogdoYvke9EZeFfdrxj?=
 =?us-ascii?Q?Y+jz5qYeng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kdfLYnQxq+rtsJbAapFvKF1IK4b2+ZIIYuvEhd/GmuNIg8LAVJ7018eooChDLxc5mKeov8kF0B12tR3gezCIpMF6Z9J3HJERwtuBSVnJckoSx9JycVHpGXd1Iev055xFqcz83mLenbj16HSUWbIPYrjCc39H2jna1e3Px8sbpGGNSU3m2vyv2cEgdIOzxUg9xQ0BKfF7v+fLDV3hiz+B44w2cFjTcWfVTtUOroKvOG6zDXkb1Xw1HvmHV08mZT+va/MwhNidWRLE9Nu+psCJ3hFwTMbbhT0Mm/okQNrDN5ydRTpKVxZcNSz8rmN2CMiJ6aCD9T7UbAYWnD6WPybjzA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5890.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446afa22-607f-48e6-bc76-08dee25374ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 09:28:39.3262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3dL73AgZ89p5ubNq/opCYubTH3g4XgDmYOrewRKOemb25r9vjcJ7jv+X2ztCvIhAQgN5CwKoGWx4oPsLTM8LHGpNhI2dzIeMXy+ujkfT5TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9631
X-OriginatorOrg: intel.com

From: xuanqiang.luo@linux.dev <xuanqiang.luo@linux.dev>=20
Sent: Wednesday, July 15, 2026 10:26 AM

>From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
>iavf_alloc_adminq_asq_ring() allocates cmd_buf before the remaining ASQ
>resources. If iavf_alloc_asq_bufs() or iavf_config_asq_regs() fails, the
>unwind path elides cmd_buf while freeing the other allocations.
>
>The ASQ count is not set until initialization succeeds, so the shutdown
>path cannot reclaim the buffer. Free cmd_buf in the common unwind path.
>
>Fixes: d358aa9a7a2d ("i40evf: init code and hardware support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>---
> drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/e=
thernet/intel/iavf/iavf_adminq.c
>index 6937b7dd44cbb..40f76f9507f4b 100644
>--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
>+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
>@@ -60,6 +60,7 @@ static enum iavf_status iavf_alloc_adminq_arq_ring(struc=
t iavf_hw *hw)
>  **/
> static void iavf_free_adminq_asq(struct iavf_hw *hw)
> {
>+	iavf_free_virt_mem(hw, &hw->aq.asq.cmd_buf);
> 	iavf_free_dma_mem(hw, &hw->aq.asq.desc_buf);
> }
>=20
>--=20
>2.43.0

Looks fine, thanks!

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

One note for the future - please be aware that there is minimal time period=
 to be
waited before resubmitting new patch revision, which is at least 24h for ne=
tdev/IWL
mailing lists
