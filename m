Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4CB33F582;
	Thu, 18 Jun 2026 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798580; cv=fail; b=X6Oj9yrFnYrKwrl7UXrE3y/sUixVkBe2fiH3xOBYEEjkjhgt/Si2MCkzv4Q6Jh3S2uVO5Kom6o6bkLV6ZZYOofwSPpskV/l3Q4i0s+ebKj4V2ovE0Yc2lhPW34xHq4mE428oCp5npJ4LXQSgLzb+Iu36bzUtni3skViP0cPxvDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798580; c=relaxed/simple;
	bh=K9s9DV+cDRYbypQ4/nIGKnLxdU8bY3684hH6li2X9Fw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FEimbKdlcK9MFng7MEWzxtivstL5Zntl8G63SRETZ7riZgvlov8A364HU2XlbAmRk2Y3z40CZ89Y/M2CRR6qCJZ9XQMpv3oi0oA7mVgZSYAyNCO3Mt0Qh3moUIIhoToD3kkWfnKc4yC/YYrCtMuhDsMD+ScputmXh6HGbOSl4CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRAg/bPf; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRAg/bPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781798578; x=1813334578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K9s9DV+cDRYbypQ4/nIGKnLxdU8bY3684hH6li2X9Fw=;
  b=PRAg/bPf1o7hdrKpom07VaM7C3Tdt7tfdiZ2JduQRkkaFLB2wqQ2Pq/u
   cWJpx4nQqijH73gCPpG0OzkQKIz7rhN/uikjNd/aGkvIT9v9uRSrWqT5x
   eVcwoISZ4Volj6k+utE1RIX7XUYYuG7E/759p7JVgMQAxEphdphVFNmik
   SvNOmFu0k9rNlc+4jghDaeiXc9ZPlj+wZFUlkS8YViLJZXuNpAGgSiiaH
   W4sMTiVpr4/fhtKhoafzPA13iOkozg/5kTIC47UjyV0CUKe3TT52VGhgi
   K2hSBZUUNJU0Ui4BZ3YplPWtdUVC4g5P3un3frFx0W3CmvohAIHslrLeb
   g==;
X-CSE-ConnectionGUID: M+Q37qcBStmFUo/sf7dCig==
X-CSE-MsgGUID: 4fvhNuxTSQSyar1w90TGew==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="70154966"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="70154966"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 09:02:57 -0700
X-CSE-ConnectionGUID: sK6m6rSgS/+MUw+YR8MvSA==
X-CSE-MsgGUID: gD8YvRSTStqIXw2gNVJ0Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="272477996"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 09:02:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 09:02:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 09:02:56 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 09:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqQs2/ddmkgwfgXDA0i51bDTVFyd5Q41g7PyG4+BhR4MERpzm5qfhXMe7fU1HB1gwolZWIvgr5H8J690t1T+n2tbQdIRHTUhBBXGRsJK/1Zu1zEOTEi1RMC3cNnmpBjFclghB72Uvbjfxsmkvb+F8aYym8DHCFQTNoskU4eWKlvaLIpdFSl2vGn58RIT5238xJcZlCsFFLewqCdURBLnGyW1oD5riQjHIPHKOCZ1YQvqDhNaQgxXJg2xK9G2jKRdErQbN5f6kILGBYBlx4La9ylhl3br5mm+QGA45/K4p85q1pv27g53IprPHJ+fa8Y8cB4BEibdjonGpagUztgBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTyQsOqAXmnK1eOhWxkFrYDOaTddTrc9DQI5dEeSPLI=;
 b=yMXFubvIhKlTeRcqsB4c7E82II+Ba+96Ije4sbPV/ZEApZSake70c45KcXCufpdfE2vwZVZYGtUjncnHDARd43bFaVROuuHtcAcSRXP5vRp6iRp0qRqaZvEnmV4MTPtYnJajfp8UlOJ9yfYQ5TkrC3ysghHH0Nw/ALFjFTK/2wUudr0Dj9n0Mn2LxRUwXIqeok1QWOxuXIY5wwRk6jeubgScljL3O1aUKvnMKHLYJzg8yhcff8eJEaCfi8aK/bCB8h0xSQGzm082HUI7qh0K5NUVb0vh2Dttgtpydpl3gcZ05DX6ttXHrImPeSo2BXBBJtcJJDUAJJYNoZgApdbhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 16:02:52 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 16:02:52 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ice: eswitch: fix use-after-free
 of metadata_dst in repr release
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ice: eswitch: fix
 use-after-free of metadata_dst in repr release
Thread-Index: AQHc/zHSZDpWL9qtBECxAr4mx0WoLbZEeWJw
Date: Thu, 18 Jun 2026 16:02:52 +0000
Message-ID: <IA3PR11MB8986C4C227BFA15D0055EF15E5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260618145003.47471-1-doruk@0sec.ai>
In-Reply-To: <20260618145003.47471-1-doruk@0sec.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA3PR11MB9273:EE_
x-ms-office365-filtering-correlation-id: f512f562-d6fb-4603-11f9-08decd530d94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|22082099003|18002099003|921020|11063799006|56012099006;
x-microsoft-antispam-message-info: 1sweMjTRWsDznaQUiW0exsZpysIA7qoPxce9zj+UbPhZjvkjqjkwJ0wfODIWqrG7/exw0O8cOFyqT5N7nqxPI7oP446zUBmE1wNhGMZMyPwH/47O0RZOQbheZL2yiBTzAJ9d412jC4E0B7xQTyIiQEWtY79NwsEG9WW4hzcvIvIsSF4YqzjbAi5gZn9pzN75S3PE2Goxj7aEL2QXtJ0GN4dQsWdkPdXFFhBKmNfLtjX6pos9J7DzfDRKIdf3EvXhqIrX9PGpCU54KKIeacSkhyr9e5hxqBH4mH+o/wY07+ca9Tvo1ndIreevQrtQ2XXcKC/loUeo5ktoObYG3HZK+v7I22ne8pHDNj4Hk/nZfGbusr/eU2dFdVugraBWeLb6QMnRGWcosfwzwAAVjRcfv3Idjtyc1nla7iFBnCd7VOpWZTVkGVbP7sekfTjMzCLE0xVd7BW4zlLQBCAPrNvQWiOcFI675fDh/GPoxV4YOMSgInLWA3eMU2prC248R3U6JbKmRPKWK4psS0uwIlD1/+B523IgeXVgsJ3TZ7JBk6eQpYim2sYLTKR660QyIuXMNPEqA5zuyeeMXFOTHfRp5Iyc9o8MsYfTm5y/A/j13oVuEbp9URCC8l5OWul8GegQDThzrbQ+0MxgxsIVLmiBZAktYaKmCjkMfq/cdM5OzxsxRyZrziW63bFaH9SHSrUkwI1BUCzkmpe8QOJcrmGyHgly9RID5jN4Wn/hlNJvErLJ0JmwddIJffHQDzaMDBCYQm/vMSLKvD3ZQ7kBjgqgjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wsx9LrBMhVinhEePriCmnu0vIZeYF4m8YxcL0+SI+SNolkoluWDnpvdxo0E+?=
 =?us-ascii?Q?GZGnu2+ri9B6snHaZYQQtz4bupX7aBmxiZ4zLyA0ht7OX9P43AOkyNuv6ZgE?=
 =?us-ascii?Q?re04868TLHHPyb3tLCyepmeoHPXbwW2A2S+3pZCObwIpvvfTUXYyrk+iOtvS?=
 =?us-ascii?Q?BMX5XpvkgX7psy6ZBdkiGGiLH9XT6HkuBDhNt76uC6y5wu73Vl2gFYG63/Ue?=
 =?us-ascii?Q?xg9AOk+XPHYaRLVlBLdo0Qi7b/2VMsBf+swjS8JrEzjQ4xfeKaTO79GhFpHT?=
 =?us-ascii?Q?gyZtbcjR+RbEhr9rmnIq0pWM8GWEb9D2zaFGlQdRFE7L2C9el3T9TItVogBo?=
 =?us-ascii?Q?yyZw49taP0a4SsiEwOFffZqann8H3UqkeNyJQmXmUIe8ohLRy4UABM9QYsLB?=
 =?us-ascii?Q?586n0UzsD6lOEXy8WBcQyf+fpqtjRLX4lbMQPX6VL1qGRbKo0vUZ/v88vnpd?=
 =?us-ascii?Q?/73Mtf9+QWgZp+V7OIxiPCh6qhn5XIrftDa0Eug6WCx6hevb8nXXSsylMKe/?=
 =?us-ascii?Q?4uSLF+pOIcnQrSGhMT4f0NwQNBTnag3IZhfNNPaYnk5xv1cNcT5nEOdQjXQi?=
 =?us-ascii?Q?goNsDDvN2xbHaSjPUfplFWZeonx7j/hatFelA/bF88aHDtLjXdjuNaIKZy7y?=
 =?us-ascii?Q?eO3WMZye+xMwvz7tKJvEd6k+X+G4iT6g5eVTNrl53lws3DmafPRR9ULbEMmJ?=
 =?us-ascii?Q?83hId+t++GnWPrrPE50lXt8szmL7wt+gd/ZtSHd4olLs3s9guZ84riV16LFq?=
 =?us-ascii?Q?EjEy3EzNp5ot/s8uJuCEQzuUonXU4zncvil/4FVvEBxmEk5lNgUtUQfc2yYi?=
 =?us-ascii?Q?3xJolt/MbBs/eIYKDs1w3U+DGZFTEC07WCRY6wC61ch9bZwpSao7rBWKLyjC?=
 =?us-ascii?Q?lBL1tHEA3Fn4wyzsA7OOJ2d5rLw7N3+qPuhr7oDFSubROnzvPCvCSD6X1R/v?=
 =?us-ascii?Q?gnuGRlFPEHQYPp80o2vCiFtXgSPiwnwhStQ38qqHa4sC9L5kKjsgdIbb1QWR?=
 =?us-ascii?Q?X4cG2ZT54oUEdjgoyC2n8/7FkVw+UmeI6IuEeu98EysJzKNbkqe3EIV7Iv3h?=
 =?us-ascii?Q?VJp8xLCaT8ioNEZyM6WqsK+0aUmNu1ekMjM1mLgTfgrbCMiYl2APfD4QPcjk?=
 =?us-ascii?Q?m0lRPD2MSD1y4nnu7c7FLIT86WXT46jNe1RwqQ3GGgGtxtg1pSCdiDiFkzuN?=
 =?us-ascii?Q?wQHByi1fPoxuStxLVaSIzVzeVD5YkJkcC7zZZb37pV3DuvtoJNuTNMj8y+oO?=
 =?us-ascii?Q?QpIMNJxllHKiumQYRjhBqEondk3eyWiHkuUEp1/ozQNScHVdH3zncjGFxHVa?=
 =?us-ascii?Q?Ef6wU2hnum4GitRMYaTSDOmbjBzi3E/kyTOVCAReanPioKH86jNdDXZMWwin?=
 =?us-ascii?Q?9D5zoxE2TNUcNuOS6AX8dMOisifUXol9Me95cyK54/mI9zUHN5jVfgR7BzGS?=
 =?us-ascii?Q?tZqQmEptJwMA0C7y1PqH5qIBGnxk6qpHxGxzi+5YOIMzyPQaxkss1kmTZJRk?=
 =?us-ascii?Q?bCDmQXReoF7XbZEUbpKHMk4MnM5677l+x/4FPjgU2ZFnMCCeXT65hja4syhn?=
 =?us-ascii?Q?e40hVS7NOSGJqG6PNWLP3dQdIWX7UeZExpP00dg/hlAN6++8VRCYfoSonb9o?=
 =?us-ascii?Q?BpSiy/0FwsZHvKD3JNYQNXzBHvf7/8mLNYxh/tvDeRvHucYOvI5iR0uasu+d?=
 =?us-ascii?Q?2cc/ghhYYnYTt1x09T4KS2m8vrA5kWKFMrF60KUtw9dTIlcn1D5ZUAsjx91l?=
 =?us-ascii?Q?+jQlIXrnQ2OGewQ7tpQcLv0gwXMnPqo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fzLRB1ABIEFVgFY/rAYbA3sujWzG2RLH+/PZJApedJZ23GL283w14XqGi6l+ETUhHljSo4k1b6W3D8oQE4OrNm2kNV6/RlCqJHK0e3jQ5jAFbqY+eqKj1uee4UCWn7fPlT2GUzki76Vla/Pvt16HJWA88zbvj2M49BEejRKDptGl3aE+5HpebPwXVDXiBHruhp8vwQM+7DYaS2GOn914LiJ3kz+QKckOG75BsPQfrap5mmHoA4xa4ty7pE2tsX0Uf0/s/GWQtBoIsuqBQ/yQJCUQ7C+OBbW3a8TG2y3uVpIQZ6RXxRRsAcheFmxXy5KZnOzpeQpthCB/Ke/HTkJayQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f512f562-d6fb-4603-11f9-08decd530d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 16:02:52.6923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTHmn9W9qz0EZCnL4eXeCiT8FAzG6QIKDA1/BjCQzPHtcT2Pt5Cml44YVrYiFgYPwF0Pq6BFH9qpvRaDJbn5DVH5NowlZuF5fU38S36Au/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9273
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Doruk Tan Ozturk
> Sent: Thursday, June 18, 2026 4:50 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: michal.swiatkowski@linux.intel.com; Drewek, Wojciech
> <wojciech.drewek@intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org; horms@kernel.org
> Subject: [Intel-wired-lan] [PATCH net v2] ice: eswitch: fix use-after-
> free of metadata_dst in repr release
>=20
> ice_eswitch_release_repr() frees the port representor metadata_dst via
> metadata_dst_free(), which directly kfree()s the object and ignores
> the dst_entry refcount. The eswitch slow-path TX routine
> ice_eswitch_port_start_xmit() takes a reference on this dst with
> dst_hold() and attaches it to the skb via skb_dst_set(). If such an
> skb is still in flight (e.g. queued in a qdisc) when the representor
> is torn down, the metadata_dst is freed while the skb still points at
> it. When the skb is later freed, dst_release() operates on already-
> freed memory.
>=20
> Replace metadata_dst_free() with dst_release() so the metadata_dst is
> freed only after the last reference is dropped. The dst subsystem
> frees metadata_dst objects from dst_destroy() once the refcount
> reaches zero (DST_METADATA is set by metadata_dst_alloc()).
>=20
> Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
> nft_tunnel: fix use-after-free on object destroy").
>=20
> Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2:
>  - Correct the Fixes: tag to 1a1c40df2e80 ("ice: set and release
>    switchdev environment"); the previously cited fff292b47ac1 only
> moved
>    the affected code rather than introducing the unbalanced free, and
> the
>    bug dates back to when switchdev support was added (Simon Horman).
>  - Add Simon Horman's Reviewed-by. No functional change.
>=20
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f0969035f..41b30a7ca4a9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -95,7 +95,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct
> ice_repr *repr)
>  		return;
>=20
>  	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
> -	metadata_dst_free(repr->dst);
> +	dst_release(&repr->dst->dst);
>  	repr->dst =3D NULL;
>  	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
>  				       ICE_FWD_TO_VSI);
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
