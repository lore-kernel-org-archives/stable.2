Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637D46C847
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591572; cv=fail; b=Qp1GcTXOBFrrSAgLKiwYGApzX5O5jT7JmEcyJPxylrQsCzOeCe7e2JW/WdTKBoJkj4lNbzEQiirGOmAmX0mn6cdHZ9pKqoRCvz6Oluyx7PeKB/8mnvGSjNTKDoj2qgGQc56Q67gs4iBnX7fPUK/0GRL/3NX1xSmExxY0umda4/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591572; c=relaxed/simple;
	bh=vAw80x/gx8CHCGTGx11hUXvFaigS7l8hNdUT8zEn128=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JlAKzgacLjDppIe6xnf3NvmQdR0d4yDNdVHmY3DRGszIf5olz+P1Iy/vBwkxT70fauSBCAs/QE72EZrANehMYowwxYn17Mlv2pdusN8uR6O9kCATbpEFQOTfU6PWqSJn8/r+p1e1AS3Y9BL6GfDpLd5XZN9CaeLKJy1qSaPuuR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zp3kNiC+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zp3kNiC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787591568; x=1819127568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vAw80x/gx8CHCGTGx11hUXvFaigS7l8hNdUT8zEn128=;
  b=Zp3kNiC+Luz6Llq6U4vBjA/5GXSSJI4zCTxaJUw1w8ewA8rSvnoauftD
   nhf8RJXO/cjr4PZx/oHGT5i6Sd55W/yXSVaClqEkn/GzJLKZAEyV9q26P
   g8ht/vYpPaY8XdfoT5n7y/c6MmdC4LrKSGPjIt3ZT38LhHQddLDr+mb+E
   oVWEXssA6MHyxkVvuahoKtvSYMPFxYnLlIuppOOankibLEtOZhMKIOCpw
   qJNq36ISb0sLFUgOC3navybwvAQk3GHvljLfGv3yDSqZW5YhgHSjs9a4M
   t5LSteR6NMvCpzDrrxu8O+MEPR5R+8nz/xiwIN5qAb9Fui9NWLQQ4hKmY
   w==;
X-CSE-ConnectionGUID: kO7GA2qcSh65foKlpDxpYQ==
X-CSE-MsgGUID: nbmw/nOcRB+phEaL/uOnnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88109049"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88109049"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 10:12:47 -0700
X-CSE-ConnectionGUID: 5qEi11eVTSWIYzlNKXWvOQ==
X-CSE-MsgGUID: /6voPbA8Qkm4vDxx0xSONA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="260915219"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 10:12:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 10:12:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 10:12:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 10:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hg4uEu9og5JjfVAp0zYqa9rXVYu3fST1QNlg3TaB5Ku4DOZKUny3eQ0OsbUI9YHyvudNqNqwtx8aoFL6OzLZ8sDXIniu+0DE0dc2K42i+jRT7rFsbw0Mhp/qWXlXchBcBig+pHw5v1lMTwGiSEP2YZd2t4EvhkoJMz97ud1CyJbP7XvFqrKmaH42aAVd4hK6ugndByOLjjIifXJgjYyGZwPwLeHkA+qDUp9gc51kx3QvVUsT3l/5VMieaJ0QvgXA53PKBYWpWVzkac4ssRgdb9BBk70eA8L7/xeZXCJ39MHjn7JdQ8o/YQgRgwU+bkvNJxu5Rj3QRto0wOvGUJ75oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjavaWpE/+iNYJeHU9GtyjCOehjQZ7btX89nZ2k828k=;
 b=xXKHbuP4XCuC96Ib8hNrqoVlELO238q2ouLbe70HpuhEX/K0tTZHZlH6OVG5cQmvoPybbZCxQsb0+9r4ArJ+Gg/GuFFuJbO0uMZHf8ITDW/i2rPK/E+1CxMR0QJAwVSo2vHR7qmHDGitZT6BI8Tv/iNQsmpNRkKvWYZoBfSuWJS3v4nlDpclnaO3jB+e4pAdJQFv0XpIdCy8fc0CsP1PI+u1mGEL/eG/28hgsE0z1cUchkE2+RSjKnjuyXSrY8089ZQlZc1k+VB3/EIQucczlKvAdSYwRowZ68b1cmrmfKyQKg2Jwz7dXQfZOYfLMWaMSY61K67g/3bGjeAoEQelXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by LVUPR11MB9788.namprd11.prod.outlook.com (2603:10b6:408:39b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:12:42 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:12:42 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Mun, Gwan-gyeong"
	<gwan-gyeong.mun@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>,
	=?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: RE: [PATCH 1/3] drm/xe/guc_ads: allocate UM queues in a separate BO
Thread-Topic: [PATCH 1/3] drm/xe/guc_ads: allocate UM queues in a separate BO
Thread-Index: AQHdM+jyPaU0dlF810C399fyt0BMC7atbQEAgAACRfA=
Date: Mon, 24 Aug 2026 17:12:42 +0000
Message-ID: <PH8PR11MB80403BD1E790D1130A21BC9AF4A02@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260824165208.498797-1-jia.yao@intel.com>
 <2026082417-detonate-glacial-6417@gregkh>
In-Reply-To: <2026082417-detonate-glacial-6417@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|LVUPR11MB9788:EE_
x-ms-office365-filtering-correlation-id: 190d1b90-2f01-4a26-1312-08df0202e898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|42112799006|1800799024|23010399003|366016|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: idn6CEkBNbNrLzhEmJ9516m9UlYqAGC1ERu/ChG7CY3YxXJWg6E4g+4apIG/xVj1NjaBdPi4SGBsiXqRyw9YcFR2FyMutThzo7Dn+ReK4dtCFGWDcE9ko+UuVoFFOaE2jeOrp1+2KHoH9hVqecxoxLTj1rXr3v+lYB4UNF7N5t5Y4hpVivXbe7O1zOZdcXjBNgyJb9ymA9wL8V+eXJSh7WiAjwzHEYOioRTqRUS1AOK/o5Ka9++wVoqlNPooZroWA95oKG73ST/+nigE7CqpUFxOn7RiUCf4n6banT70MVZ0qJ+oYzrlpfjV4+55NqhMVYYgWBgBEcWjfKro6IVv269vl0Ss0MkVs6jQ451FFfAUbGqYDV0EXfjSN4hifDy/B8icj+XF7pklMbiEp317OyxrT/4QsfNXNZvFb0EDHBTE+89eHswg1Kk5dYRNJKT90BBNX2EABTJkVlXxUsyjakSkq5C7Riqau4Sq/FIhLGRpsyDEFbmzdi7tlZdLlNAPQcD1xwLMLYgLSlHmO2HfykCwJgGKbocBebM5Q/hVUChhs5n6tuRAkg2KVaq+q6ekcXOy8dm7FIK31H8alxGcOsnG5/IA2l2wfj+tosb0IPhLJGaBpRPhk05PhyZ3O54MkvUS10VW2ZG6udpXXawtuDtfJZgpE3017tCAzCwZ/+n14kz3BxEnifAV8xQ2ebqE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CkI9LyHVvoJ76EvbXXRKeidrZnh/D/PEyWaH2X4DhggMLma/x0pyGeQn6O?=
 =?iso-8859-1?Q?46rppIdO/qgQFz7tTHW3rxQHx8H+3FDLvZ41O1U5/iKPUE0BElDZXJ4rtX?=
 =?iso-8859-1?Q?+gzmRku42JvGOJI1bkVE+c08IAY0PBWNw9N0k5TdpU5qRHaTjQWhuu/4Xd?=
 =?iso-8859-1?Q?yZ+efoIU44AawKThGrXPS0kYBxpYWP8zw5ThHNoEC6ITa+fucICB5d7AwO?=
 =?iso-8859-1?Q?VGyJjLjd6WddX3PneyDMkrPMmu7BrFbqLqIXBjBrMtHCZJz24jPV4vVf/l?=
 =?iso-8859-1?Q?2EBdDd7qZeI9MX1YkKnX3ygwdqYOJ9apFgPn1zqCW5qsS3fUWzflPW9l66?=
 =?iso-8859-1?Q?PrGXbQ5W/4lyQek/qPre/KQujkfKyDKpKsSNopn8HLxs+8PRVRzsNoUkHe?=
 =?iso-8859-1?Q?AhTvfdzp4wK14q9is5LCUl5JyW+Qw+UGiQXSLxd/3DVDErCm/bWAcZXcuI?=
 =?iso-8859-1?Q?74EQH9HdE5eAB3u6eF8AGLsOgv5gN2g8BHE/LXr17RIPbWG2BS96yD0035?=
 =?iso-8859-1?Q?WuC6g2G3zWS37QSCoPR9O64TNGnMruAJrE4CsBJc+dvva2jIbrH4+baf9B?=
 =?iso-8859-1?Q?NXsbEZ87MeZnyRfr+BHqAuQ1Igt4ptA4pDg+WfyyTnghVez5W/cojWqVoF?=
 =?iso-8859-1?Q?kosrV5c2jzlUCzSQ1wj+q1s1QX4MQnnQonExaHBh38Fo41XT2pVlghbBCs?=
 =?iso-8859-1?Q?HAOmVpYIOxLFUMr5b2qFHxjURr8QzsrvijTmHY0h8fCVdfs8wgkCImqG5w?=
 =?iso-8859-1?Q?56RPrxkb6ZXBF7WUNKeNVVikYpNT4bVGYinMx03GVkI0QkapZVU6wZbPM3?=
 =?iso-8859-1?Q?U8eOeDsXshrXSzR1CvK4BO+kqSICm0IYpEtkH1yNIIrQgfIzWQu05fV5TQ?=
 =?iso-8859-1?Q?QmmeL5l0DW2KBXsM/qJc95X0SnG2+CjWsve4wT5EZHaQHUZlDcpD+Za7TG?=
 =?iso-8859-1?Q?KABOfv86eaHE/0yn8O6kEVfgpQxvbuQZpAxr6SGRgBeeRe8xoEdGsz49vG?=
 =?iso-8859-1?Q?NK9rjZQA7eR+m1Etuc2yEY+cX051Ge7+rOoOq9mfnNtcRORnxGXMYi83FG?=
 =?iso-8859-1?Q?UvxDnl+uIYR/j2S+ud5E7CYNpc4fbKqQjBgvrz+vQy524C7SessrWVm0jz?=
 =?iso-8859-1?Q?sFwAKfMV2qWGUvP4Q+3/a8QFmuXb4+UNqvu3xl4A/WMHF5w4XwcqPhkNr7?=
 =?iso-8859-1?Q?Nq+La9fyS/0GOvEsAXMZVLOu62o0dZdmytGLI7iTTOy5FIVwgpyXmnkS+f?=
 =?iso-8859-1?Q?SiVXcIzZw7K6jPC3jZPes8XPSedo3XUr2QxYiqhAYMI+K+bPZT09yozgRX?=
 =?iso-8859-1?Q?eS3IOR40TELzsjo+f63ie+eLtn0wryTS+qArOKKvCapYOhmVw7vtp20jfh?=
 =?iso-8859-1?Q?3mlS1K8Sf1bLetH4vX5/bTgvf8OzaPSs29CvtjqdLtivE6E+WVvvHRCdQQ?=
 =?iso-8859-1?Q?fU1hY2QVMwc9RiFaXT3Pb1gKQREpm2m/zBocoackE0GlEGdAF3jM+erb5e?=
 =?iso-8859-1?Q?MwZkNF+qVKrDi61xJ5SvbfnTdkeZw7+ONZGXpz3b9i8hE9jnuYQ/r+RgUu?=
 =?iso-8859-1?Q?bJWi76afBzlDoo1NiSAYZ1tUsU6XywPcsoMW/SrYFMjHHwsHGWKOU4KZd7?=
 =?iso-8859-1?Q?1IVsw/hb4NdDJqd+a7K+rf/MSSt7sTBu3mB+RBmyT08gIf/s5OVXmSvd+M?=
 =?iso-8859-1?Q?Ljc1Y/p6De/7dCOx1pgQfnxr0Ogprgx77b7NfZJMcZdY48waiFsQbb2Imo?=
 =?iso-8859-1?Q?n8GS0nl5WYiLilBgw8a200VZN1ex6ssk12b/UPg2bbKnkm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nn7KV/LLUBzRqrJXkA0V5vq3Rk5AGzXFq4CzU2yllzce54+9HTDMNDrlFGsnbnwB0kBpXNlf38Kl5FAnrkViqaRp+DCSFvhq83NhLZS6JSUEV3gBOPO29mAbvc3x+N4QwW0mdpEwMMN60TYW2tlMGzHsxCk3Dg0rpdOwhxYXsGv32StRYzmHFk11rxJKDOxpbGEeoXIMQ3mAeJABTj15LcMv7RgiZ4OfDQJiLvpaE6MfKaQvzY29H42JjezlhUCT/Srvq/i9q7ev97nvcSIv8fPSP+ANLqo8aODchJsxftQIMVw3zAyhzhkVDiPYO79LrRoTj2vy9FeonTTFSMiIEQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190d1b90-2f01-4a26-1312-08df0202e898
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 17:12:42.5167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juV0PbkGroBgSjuPf6zdBmqOaWVBhd6MMVB2wOc0UKUfrYcc9qvK/xOpyn7gzOp3o4oX55/h6/hu9w3Uf6A0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9788
X-OriginatorOrg: intel.com

This fix is intended for all stable trees containing commit
9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement").

Regarding the duplicate cherry-pick annotations, 99b01815957b
was itself cherry-picked from 6af05de0dc19 and the extra
annotation was carried over inadvertently. One of the
cherry-picked lines can be dropped.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, August 24, 2026 10:03 AM
> To: Yao, Jia <jia.yao@intel.com>
> Cc: stable@vger.kernel.org; Mun, Gwan-gyeong <gwan-
> gyeong.mun@intel.com>; Auld, Matthew <matthew.auld@intel.com>;
> Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> Subject: Re: [PATCH 1/3] drm/xe/guc_ads: allocate UM queues in a separate
> BO
>=20
> On Mon, Aug 24, 2026 at 04:52:06PM +0000, Jia Yao wrote:
> > Move the UM queues into a dedicated BO (ads->um_queue_bo) and avoid
> > CPU memset operations on it, which eliminates the CPU as a potential
> > cacheline-polluting agent and helps maintain consistency between GAM
> > writes and GuC reads.
> >
> > We also need to ensure the base_dpa for the queue is contiguous on hw
> > where this is used instead of a GGTT address. Another good reason to
> > split this out to a separate BO.
> >
> > Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.12+
> > Signed-off-by: Jia Yao <jia.yao@intel.com>
> > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Link:
> > https://patch.msgid.link/20260804165057.129529-2-jia.yao@intel.com
> > (cherry picked from commit
> 6af05de0dc19bbf3aaeec2020fe48b37c834b811)
> > Signed-off-by: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> > (cherry picked from commit
> 99b01815957bd7d848420cb697f79ed11f7f215c)
> > ---
> >  drivers/gpu/drm/xe/xe_bo.h            | 14 +++++
> >  drivers/gpu/drm/xe/xe_guc.c           |  6 ++
> >  drivers/gpu/drm/xe/xe_guc_ads.c       | 90 +++++++++++++++++----------
> >  drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
> >  4 files changed, 83 insertions(+), 32 deletions(-)
>=20
> What stable tree(s) are these patches for?
>=20
> And what's with the crazy 2 cherry picked lines?  You all know better tha=
n to
> attempt to mess this up even more...
