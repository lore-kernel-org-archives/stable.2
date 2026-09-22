Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9853B325;
	Tue, 22 Sep 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075418; cv=fail; b=bvu+irTOgHI6z//+cCoCzzsOhurWunnFV5dcGYNY3/rXzNGkAP64SKhfVhRG9QO/pkbuLPPZ798Cc6lDMwbX1wESAIFoNSwIDjJi9q1qKKH2hApe7ig71hwRIjizwMf/YmaDSW8Rl+KClUDfsNClloVBTOCagTf4cqIgiFqut64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075418; c=relaxed/simple;
	bh=QjvJ5Hq0N2vsRlvRPt64jcK4kb92CqxCsl+6xg6S+dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QL1odPswhPDAMZkMA5MGd612ff9Z4LbHZ0oC79saSJDnodWA4EI/FZObcyo+69vKZ0TG46awFwoxI6v3Eb5xXATDnMJWGGEZkc/FDBx9WhKFAZ+qOkf4pq0TKhP8QQb6zOnP36HmQVbMsi/5ev+ie1/6SxEL5vgrzhAwaJOzDas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7+jH2Rs; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7+jH2Rs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790075414; x=1821611414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QjvJ5Hq0N2vsRlvRPt64jcK4kb92CqxCsl+6xg6S+dw=;
  b=k7+jH2RsVdjvMEbejjkgmkNwvHjXI1hgDpF8Lwkn9eP5Ie14ATYzc9r+
   PgODurXkgRfipCqWm7+YCvwKcj6wp3GaoxKomdVeBHFr8GDoKTs2afYHA
   cf5ax3q8nlGnLckXiWarycdfHSEMSDMtvBVQPsRD5OMSi+ZxOoa/BnrjV
   timWs37kMyWgX+ftdEcL0QTrzdZmhWpXbU9XiF1AzOCqGTpxIA1NuS5DJ
   b1SuL5erdNpFZqkqCamP6zhebAEia2tKAzhDmbhIiIUufx2YNiUac/hRu
   pAiow0CcrPQDi5bHdJopce58Jd4dUOMyUBbxiQoZ83uS/ils4sH9y5QFW
   w==;
X-CSE-ConnectionGUID: DtNtgwA2RP6drGvynImGkQ==
X-CSE-MsgGUID: WiHg0HA/TJmxMKF7nYpgBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="94499008"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="94499008"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:10:13 -0700
X-CSE-ConnectionGUID: EeoFPqGoQ721TzNaeCtuQQ==
X-CSE-MsgGUID: O2yC7fDeTnGywyAA6mR3JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="271645499"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:10:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 04:10:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 04:10:13 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.53)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 04:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDqNA6vEugpRp1hvq0YsYk41oPavCCOQbPUzSVlI5NlTAxtQXcj21Bf76gX+tcvQLo2IriS4VB+ryAB/F+F6Fy7a0hA9jgR+z3FRBylkSilSSR7TnrizjXdbtpI8IJ3KjEbefbG7+llDJo8rMoWpRQBvajrGmwTaOG/qPil5NSnPFvDKnOQhf2NAhalXce0n3dQb6w0v0d64bcu2SePgHD30YdDQV3dQz5m3R7dDDysW0Cvf1Eya06UEwxN11W9hhEsNs32OboD5rckeKP1WRlatJLs+qKz2PC6n4A2g2BPIVuh4Gto6Em6wNi3spcJ5PnSFpqV20rl4VaWLIVBYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcImw6TAtXdfcIvSLuvwtmiUI9xzabHp25+dBj8Dip8=;
 b=TcSTxGqa2fZVXpZ/yQD1k2KLooS/yIpufAFNeULra4QvnqeNUSBsCxf85mNnIe+tQR2AsTGY4ivnBnuZIVORip7OhwmopD7sAASz0rov5pfq9Px+i69jOrMwr5sI9T6LtAh2CJ+EURRv+dg8YG/9SjcuqD6tBRZSj08AW5H+dbO8s9e/yxOqQWheOHwmUF8Aftbks/TVsQEe4TicwmbMnRFnqygtga4dv5rOANcfEJqfqpbKdo95D7S26Fjj/JAx2NbE9l9mn5aMG2zl66zNmi+KbPwO1+DXvgd9jM0RxtBv0TqPX7l2qkdmm1cqmj43Tld8L/P3udCt/G+OZPCwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 11:10:08 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 11:10:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jiawenwu@trustnetic.com" <jiawenwu@trustnetic.com>,
	"mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"leitao@debian.org" <leitao@debian.org>, "weirongguang@kylinos.cn"
	<weirongguang@kylinos.cn>, "u.kleine-koenig@baylibre.com"
	<u.kleine-koenig@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v2 2/2] net: ngbe: clear DRV_LOAD bit when ngbe_open()
 fails
Thread-Topic: [PATCH net v2 2/2] net: ngbe: clear DRV_LOAD bit when
 ngbe_open() fails
Thread-Index: AQHdSnpnx+oSLtCkK0S+imE28XwZ87bacNyA
Date: Tue, 22 Sep 2026 11:10:08 +0000
Message-ID: <IA3PR11MB89862B76AF0C1214CE44DEB8E5832@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260922100836.1147718-1-zhangyunfei1@kylinos.cn>
 <20260922100836.1147718-3-zhangyunfei1@kylinos.cn>
In-Reply-To: <20260922100836.1147718-3-zhangyunfei1@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB7103:EE_
x-ms-office365-filtering-correlation-id: 21cccc4f-b21f-48c2-3fe0-08df189a1054
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Kfg1jY9ZJ+C1vCtJMPniJymJmGs1EQUWDRgx2HeUysyhG/OIY+/3x6g1dyvv+RHmhkT3//8mQhvkvp5JZZv7gpRqnmEfx8HK05XL/Fjkxt4UDQK2H4aIAOZtmS636CwQrBH8RsA/PSKDtTZhSuCwJjwmpCq1bXZWRG0DW3WWOMyemuwpB0KpsbTa+1w8OZLTPWOS2PwyIDk2sXVZhAhgK+MqpS+Xy5oxjHrkkyjj9QXijiiD4JpdAx+5EgKTR9bE3IwPiajvQuWRSbJTaOCexAxXe9ljzMkjF3cJP0Evu45/J9/Sxf0t0voCrZFoRmVx7YhGEUkk3W20AfcWwW8UEitPqUHCprmSiiUtLq06A+NOZI1DDOFRppO4GEJFsqtBz6Hpuq4agfTaThbuNSA+sLhhoUevQ4zcCdj8LjQXZzLJ8hpQkLmrdlms8/xm105kfsZXFl0u0CBDzkP6mTxqKaDw23lNBVbzyWuXFKkeOO2C8rmFOcMbLIbkPqjV7/iMk75dpL0g74k6cBVRYbsN7Gb9Q4PiyIS8n9e/1rw8Uq53Czl63jPaIDZj+qS3FUFf7Rold8nhYesUOrtFFkKlC/lLlbSFgPrXjMnPK1nhbeHaUavcGByR3uBCKfaLXxAR+PGcwAegm7TCH+d/11koKfJH8YRWrS22Qzf6epMiwznaG0FOCVUobMOeaUrEeKVWTOUMBG+xHoABDqlHHDGMvMGQyeEh1Lj6XwDBQ5bLJgU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DUQaH5NmLxhjETNIOCCh6uJRe5WhDYNXKt3GzphuWnK4rtAyCuPPqOAkl1Pr?=
 =?us-ascii?Q?+6HdJMWj4a9A06I/DOPT0HvIzh5uxykYYOFyAgi6BHtl6IDYS3IbQaSImcKs?=
 =?us-ascii?Q?PFC5xqiXtXFRsEzkxV6hYsjDAlc8kzKEP63lX9wEelrxGh0lS1ozlmFPoOvF?=
 =?us-ascii?Q?G5xeAeQsKTKrIftz0vY5X534y8wNPplFIxisACrAtGwkAMAckxXuzeBNFh1e?=
 =?us-ascii?Q?mdcox19NtLIrPrrSbzYGWWBVYBHTtiae66RZb3TkXE7GFd3TpD3oijTK3eiq?=
 =?us-ascii?Q?nKsxErE9VaBuBpRsWemwQkvnKDywTxF3rr/MM8+272C6lJn0l5sNIfyy5Ihj?=
 =?us-ascii?Q?JNk1JoegU0e58FPRmYzyNU8xdrvAYGyC+3+ZPA8vrB7KWZ5KKJ4w38CbNIwM?=
 =?us-ascii?Q?5gPDxsJc5YzM3cMWYAeyVg4DXPfNF4k6tjLrBQvy+6HcTfEpfCeuSGffRJWK?=
 =?us-ascii?Q?i4y0SjfXj0gJ6ffQHVI1KLn1L0JrwvaGWg8+jHbsDzkj1ZQ87jJrg4k178UI?=
 =?us-ascii?Q?tef2m41H4adRwncCokVKaVOOlckdKnbB9b4Sx2leSld8wKIrv+qvbKTJ62tO?=
 =?us-ascii?Q?U+ctvCBO/Z3TMAGmiLQ3okJk7M5SFF+v8Xe7Jbf4xMpYe1rsv2Ap42AyZHm5?=
 =?us-ascii?Q?2URVYx2djcd4q3VAaETFfxDJgWy5CuAmKC0Q4G9TELYteTAtHC0EB0VjrctI?=
 =?us-ascii?Q?qLZO44ExZXwKGG/XYCCJURPaApicoWAhZ7WCz7gt1tSTjUOq3LN4mtoy97yc?=
 =?us-ascii?Q?uSuHl2gK4VvUMMS6SfAjudXhPGLdflTuaV7vLmAmD8db2yJPsq0wD7UTxIT4?=
 =?us-ascii?Q?gvrsKNLidPV0wCPjsaIC3Qjc5Ksj0y9ozkj2H/VG+4GMSgakQG2vI+OPQmaO?=
 =?us-ascii?Q?tibK5gtIJASiobRnfX89EU9Rd/O3cR9uo076MupNYjPWgebIMQ/M2dh5Pc+Z?=
 =?us-ascii?Q?RtttH1IWByeBKwUcVpMjzMXl2+7uIBfEQA+nKsicu2y+4ibSNQNwYWoZxrz4?=
 =?us-ascii?Q?W8qlP5RTJ6X3w8k+lxjefJ851cjfZKT6NcwnA1P+LY4IvYfleniRBkbOC7L+?=
 =?us-ascii?Q?gJU4cGmbqv2TNv6l3yX52WVF2JxVpU+CY0ZziWNKeuXQS1350QQug713QSZ7?=
 =?us-ascii?Q?IyDghoZOmIAWROQ0ZpLnsp8eyVWVlRHs6LjVgDh5Pk+H4LFspA0XQlNbOdwL?=
 =?us-ascii?Q?p636GYKcRegu8xHCNHCkKfB+B2AR49bfDHp51V2jnkr6xYADK0ELQTFlkXRh?=
 =?us-ascii?Q?H+ErGvtxguODqOVBztWQlR3GY5uJ+i/SRWMZwp3XCKIsnZx/zkaeiYGnUO9+?=
 =?us-ascii?Q?zz1uWd00OGAQGZfyw2Syuz3F9TJp9CteO9FWvfVI4R//+hlq1gtdmxNQhQ9T?=
 =?us-ascii?Q?mXfjyH0KoIvJEedkf2om/PhPiks3Sech0W3Gj1soZFv5XHgT8sOjn0MNXlV6?=
 =?us-ascii?Q?xLpcfsqjyZlADChI8MYeSmXGwUv7Z4Xic7wlmAEzan3rTCbfEt3pm4A9Hl13?=
 =?us-ascii?Q?FDOQ1yGYnHgPoaHZGVFIaAhTZ0RTxGE/3v2LsDCVS2gamS836Eb56aqW8q1P?=
 =?us-ascii?Q?ZvyDg78Mu2ywBT0CKwPv8+eZzHFlds2JOOxKLad60fIAXd9k60oDyforL/IN?=
 =?us-ascii?Q?eTPjLHQaypq3rGAMup395gYBC0/3j0pWk5gq4u5JzjDnsQd11tij8GLYaxPH?=
 =?us-ascii?Q?D4xmxKlcO1QFQuf0/LpS4rOJ6xFagPTisO81w5jYTXhr7dMJCQmKvCZ4a3gp?=
 =?us-ascii?Q?/dgxa6IWG1LAGdCYuSP3Vi10C7xebs8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J17pubWYPPSQZM3o76K2ZcxTdIlFteogA0kVNkFkCgWGjkIfYlvZRx3YPysH0zeOvMWWZdzk7vvp3WgvyDJsnuQs2K437TWbCQKJQMnlKrmYhSgbcqTqQpWzgr2JmmNyVEKCCGzf1kAr3WTYlPx4+EaTeAIBXIWQf3J+8EIc+EvCnJ5igg+5wS3JHlRQ3KHc/BvmbUv66uEpHicvyRIQ534QaV1gbMTFzqPIpgo/8HzIA1eCQb5y83fXCTAXYiQezlCc+vlCOWmbKBcyQh4fwPE2llK+Yo4Jdr44V4xpX7EGj5VvsLSbY7nxbr5siPf5IAKrz3BQcnL4xJVfEDwtNw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cccc4f-b21f-48c2-3fe0-08df189a1054
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 11:10:08.7473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u88aoxKm7wmN8CBvZPxSsQpVw/+2eEM6QfzU1FsUpRpylp0mCv3j3cjxcRQU2Y1JBcHXOBKNrI2ryHdsuntUI8R7K0NRpyVmGX9YBNKLaYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> Sent: Tuesday, September 22, 2026 12:09 PM
> To: netdev@vger.kernel.org
> Cc: jiawenwu@trustnetic.com; mengyuanlou@net-swift.com;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; leitao@debian.org;
> weirongguang@kylinos.cn; u.kleine-koenig@baylibre.com; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [PATCH net v2 2/2] net: ngbe: clear DRV_LOAD bit when
> ngbe_open() fails
>=20
> ngbe_open() sets the WX_CFG_PORT_CTL_DRV_LOAD bit via
> wx_control_hw(wx, true) to tell the management firmware that the host
> driver has taken over the port (NCSI/OOB firmware stops using its
> management channel). Every error path of ngbe_open() returns without
> clearing it, leaving rings, IRQs and the PHY torn down while the
> firmware still believes the host owns the port, an inconsistent
> driver-firmware handshake state that persists until the next
> successful ifup.
>=20
> Roll the bit back on all open error paths, matching ngbe_close() and
> ngbe_dev_shutdown(), which already clear it.
>=20
> Fixes: e7956139a6cf ("net: ngbe: Add irqs request flow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> ---
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index e8cabcc84a41..7e2cc69fe8f8 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -494,7 +494,7 @@ static int ngbe_open(struct net_device *netdev)
>=20
>  	err =3D wx_setup_resources(wx);
>  	if (err)
> -		return err;
> +		goto err_control_hw;
>=20
>  	wx_configure(wx);
>=20
> @@ -526,6 +526,8 @@ static int ngbe_open(struct net_device *netdev)
>  err_free_resources:
>  	wx_free_isb_resources(wx);
>  	wx_free_resources(wx);
> +err_control_hw:
> +	wx_control_hw(wx, false);
>  	return err;
>  }
>=20
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
