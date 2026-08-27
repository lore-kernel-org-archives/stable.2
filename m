Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328B12B143
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843075; cv=fail; b=SZP0wpoJSASnCRq24I2Zr8VxX7ha2sGzKyq5uu3d+phyLt/qw8NhycMbbGP1MF24mkR8U9VjnLEoLw70mdbUR9ehRnGbJPmKsNVkpzoUL+vv+sr5LZ/pBbNoUeSk4iepMNzDmzNbTX97nyYkliTZGRZb87vqwL7vSE/vx3K+lI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843075; c=relaxed/simple;
	bh=5KeD0RlsMfXUVgdTuwDE370H2LC8Pq1tGBSVz6XBhPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bCShZLzFstzptZCjnFQponnc+fI0pU+wteIWJdj+bucK++QQTCfD4VpLNUt106w4dj3eO/qou5Hy90Yvp6sFsj7KdfRg2WUlZXwioijpobO28imXSMX2W+W5YPR0Eh4Qv9d7N2y/az+FSOu54LoBdPvgFatRH6UfpPljUXPN50I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZfZ6qGB; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZfZ6qGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787843073; x=1819379073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5KeD0RlsMfXUVgdTuwDE370H2LC8Pq1tGBSVz6XBhPQ=;
  b=OZfZ6qGBveUGBnHET3Oq37qFOkITYl2DMaKPfNmrJ5uBM7DJlvP/hW1O
   0WRPz6Hx7FCL38f95bus+RXvnjht0N1NN7EdFHIazJmvJm/Y8ueFvB4Mi
   m3kQ2F6nYrxQxJq49Cdf0JpT63jktuYegWQ/1Tem/8of5zP/3QKYDWfy/
   UMzauv9/dpPKf9mQ6QGBBxSQQWhTYY6qt4a2qWc8IFdLdWtyex3NB2lD+
   E2w8cLKLbApm4ZLSflbPuXjwnYuazf1upQE8dOrpNN22C/J6YxiaP3izv
   VH3lwkN6w0ovoTrNbV/U72j2pGUQW+022QJOJrt7XCPF8MPR+rqkolgEW
   Q==;
X-CSE-ConnectionGUID: AesIw6jSTW6uRW3WQHuRmA==
X-CSE-MsgGUID: 2Nbr/lnnR32/kGbw+QNPzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="90854152"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="90854152"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 08:04:32 -0700
X-CSE-ConnectionGUID: +3lxDPC+Qt2sa3VH5mC+7g==
X-CSE-MsgGUID: dHXjzCXIRRukHDWkZwQ7Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="273151501"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 08:04:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 08:04:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 08:04:31 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 08:04:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyX1GxiTcBwDI6PrFbHHdFDpYyDt2SFCLDCrtqy0jygkSAHM60o+Ky2dbYvR/vmvXG/GRmp2aPZnDnlt2l6zulNPd5FVFVqvs39s0AiJyUi6WGx97l8nWmj+idWspO58ETl8Q/exeR8N4ZqBcmU4Iiw+UWXbqeOmebbug/Vt3RtUtqVawZLffzF+jiFRCCcOzmVxPda7BwoiYMzYx8ii3wP9FwhsVlW71v2PGRzd68yYWyBJKaeQzsZDOvksVkB7hWfyvaSJYvZniuFdgiDmIvCnrZ9I0NBvD1ApG8ZubZTcPHUGXqZu1vjcvyBNu1PfXAACDGPxWBL7fA1f4sE/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wvoG/Cuju5I5Qkty7knfq/IhfQhtPiyHL7fJIzk+p8=;
 b=NQGw8Z8mN0hr8vGno2sJhZ40rWyE45GgJmsRMP9ZDD/CDrIxgIxcyiNhmbN3IsQAn96sBtbabXg9flD6QMphj9uVxUgVUoiCeokFaBMTPDvwb8lUrrwm3KnpKntQCIuwLNR+228CGBDaCorXyAgJ/U/Qx5Fs6VQ5AQaI+OCtLoVroa1jEzme/kMe9+73sO9H7+dLBvzJhLdx9ga2WpNFYQ09YkxpTsogrd0lPf/AN7FRyWM3oir+ZRIh4bMFbJPsMIDzyAQ4DH2+2bZvhHGUIQHoqaPAlBKuloqL4UN+SjYaZwEUxJom/NSJLMXtHSHiOfG0q12sYMlD2/zXN+08Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Thu, 27 Aug
 2026 15:04:21 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 15:04:20 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "Mun, Gwan-gyeong" <gwan-gyeong.mun@intel.com>, "Auld, Matthew"
	<matthew.auld@intel.com>, =?iso-8859-1?Q?Thomas_Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>
Subject: RE: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
 separate BO
Thread-Topic: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
 separate BO
Thread-Index: AQHdNEOsiSEBcNzQHky6KoIO5zqwNraxXlEAgACibUA=
Date: Thu, 27 Aug 2026 15:04:20 +0000
Message-ID: <PH8PR11MB8040873E3763B18A18D7C81FF4AD2@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <20260825034113.642528-1-jia.yao@intel.com>
 <20260827050834.10008.stable-daily@kernel.org>
In-Reply-To: <20260827050834.10008.stable-daily@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|CH3PR11MB8187:EE_
x-ms-office365-filtering-correlation-id: 26f1ce48-ef5b-41dc-15e2-08df044c7939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|42112799006|376014|23010399003|366016|1800799024|10070799003|56012099006|10067099003|18002099003|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: B06mY2thxPISTpLWoD6TZpthZZn7o2gCoqKIXfh5d1L1T+qCPmufeDuGrUl0I40dsO6hJBzElMyQPCtDgdCOtRGao1F5Iq5WEw7UMdZuJ45ZbnYaElO6tsiy/moBFkaZVgbj+AgznOs+l1d8ooXz85j7mnfB4m1RGjMCCFoOKxKbKeAfFezJnByY3Z3T9ZuaA1KUlN0GpruT39SYr9/y0VfoVRujDM1QrtBNn1+Z3Nq74R5l6LZcZZAqMkn3FZJsVx8Zfav1pNQVLZ7phpMCR3eJAI9zxGKMfN/1LRmJ0uKx1hujE3RQ79lw9YD4WrBWQllvpwoImbewWWI+TZWYu+WAxWM9bfBm82/s2gQwH6xE9ZscuWvS0dtb2JOBqSiZ13rq3+BA0QypLYPZJzVijIc37IrOOYNo4cr7hlRFMahxjCWlpGk9LsNWRVFQd6ExmnkF1BgcPYskK7ex0ERvuPJ0ogagCpqLj3grVVfsVQvBo/EqT1O8al1bpclnj2XhTT7JcrR7e8M/BTVD3L0vr/g8Q26wHCuRaHZxWchxU0r0o0pPcURlfgiYQh9ba7vzFf7ENUz5RPh8cU6mNaAnz3PhfnvWjV+VETcq6Lc0AVux7Qvo5MBeaqkGi3PIQ7S7Jl70Wb1TZ6kauiuy3CEfrc8aPZtgnH7E09bK8EUIiV2r2LPNTs8ePl0dUSLzDTYOhS9h+MNLX+5RFo35x/MwJgTiomhgCclPHHYkGb9NWUI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(376014)(23010399003)(366016)(1800799024)(10070799003)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Jh/fircSNihdq7reC8y5RrmOxh0Whc5ZrXary8DhQeMTy9DSPEQoD+PQtp?=
 =?iso-8859-1?Q?7dQrFcZAFZvCrbgaMTcvu4Mr3GK261dg83GJyQAsB33B1mkkM9fkkUqE4r?=
 =?iso-8859-1?Q?HcAwGyA5TC23iU1QwmN72HKx3wJUZpKMsDc65f/tr5wWJvGEpxFfOsKYdR?=
 =?iso-8859-1?Q?ljnUueFXf4i4hsE0xbtyIiu13A8mVPaA7AnRojlpEBws8j4CV0xNjjKeh0?=
 =?iso-8859-1?Q?RoIhQcVERsqRiZOtxBnpRpsPVNZ6NtZ6QlXDTb9nnmsFG+vP/awps5ix3Z?=
 =?iso-8859-1?Q?/HNxMAELIz0WJ+6nwT6lX5Zk69siPI8nJja/ariaRX/7wLO3+mEMy0IAvs?=
 =?iso-8859-1?Q?auoMRhklz+AjudkhWh2e4OtOGtpJQoUUW1tlG64t5zrof0AF9+JEwwTSxv?=
 =?iso-8859-1?Q?1tcQkfO7zLp7XiMi53QErX6TaMXIB5ip8hm7HBhmfDjdYNyB+OBFkmUaEF?=
 =?iso-8859-1?Q?iPSa+eH/7QUFXeTSo6rSOtT9Yo1ZYW2am93eS6HV9+Jd3Dn62bWK77CxWX?=
 =?iso-8859-1?Q?I7F2ECJMYNtUxq+tEyXOHQU8hY+CAuCVccPnIPG9MRNRVGd7Tx+FrptZNZ?=
 =?iso-8859-1?Q?OXhcXWzjTELeHlKwum4mZw4iCr69ypHDLyJQpYVhdefgSQj4NXWRIalD08?=
 =?iso-8859-1?Q?0e+JDWiK3x9sBMu5uQdEuWH3bRG0sj4SbGZ/TfFlumHdZ8uyB8T1dioSb/?=
 =?iso-8859-1?Q?Fa1MHVmG8+YHwleZ2bNzg+G3lxV/GDH+u+T/kBuZP4jo367pNmvWPZs1El?=
 =?iso-8859-1?Q?9rt38XlsHaNjmydxiFUYc2PKcKa8Dekbif0QIzKwKbO5XIT7XwSarcRJ3K?=
 =?iso-8859-1?Q?o/OU3pwuk4eV+NJ13kIiW9vJSikIJdnl41GEvzqdFT+mVwRlAAQkYl3ffa?=
 =?iso-8859-1?Q?JHXB/yWDK0lp9e+I5Jjei0pDk/UpFyGayG3IGHtcbtu/0t69t1abivuWFh?=
 =?iso-8859-1?Q?+x+7P+K21eYfh49fi30EDJRprRUQC4Z4+TWo1xrlGfZSbpNBtofG4oKwHY?=
 =?iso-8859-1?Q?fj98iXUlnC87rtRHlit1zcPwCh3Ca1xP6za/xBCcnXel52gVtdjtniWb09?=
 =?iso-8859-1?Q?H18g0mCXk36Z/z8QWtJ25LuoRFRCiQ7ZfsXYs3ygHQcY1dt5iGWHaLT5pV?=
 =?iso-8859-1?Q?/lCHVIaQb1gysARPhHANCuJlVtjCrjrZl/2dmJh8AV2zuQWgLybLGsVkj9?=
 =?iso-8859-1?Q?qR5WeRsDXcFFlTXCuwJCzCVpHGvuj+XEWyjppXMp/02FwM9pS+7zK6B9NP?=
 =?iso-8859-1?Q?53SWUee3Js9yayiMZL7hCHRARTbadOQ36YUAFdS/jesBqQAk004DR3Qd4u?=
 =?iso-8859-1?Q?AaU/2iPrSB81JmIHwxAYXSpPS4UZ9KQRUUzAYbyKcSlOvHb5LlmWp9ltBB?=
 =?iso-8859-1?Q?IQhWFJKIbjd9S4BE4HkFOmoOiUtLhA7e+HcbwQmx4m9wDuGuSbJg+tmzLT?=
 =?iso-8859-1?Q?N4D5Qnj9V0Xf7EVm+mdLu7QsjoFAcvmOO9OH9xIvjRK7hPdCl0CQrUno2D?=
 =?iso-8859-1?Q?dKJw4qHrlsLts7o1HFLv/YCWeANXGnDEYga6YNHdap/j3wWIprkOs5C6mY?=
 =?iso-8859-1?Q?9Qy14Ierdos2XqZJxyvCOWi5/bAEGLFzbacaM+qKuP7dHN4TVC/PE9wIxy?=
 =?iso-8859-1?Q?b66cXh/TYSQ+tbd6s+S4NcF+a9Lv/kTUTAf9JA5/BcG4fGa65nUDZjqoNs?=
 =?iso-8859-1?Q?KARtzxZJdD1NYPSmkAZMVm5uwOGiCmoNSKiXKVkQr9wsTqRUuIa+C7siLc?=
 =?iso-8859-1?Q?2L5vyFTU+hJUxnaTTYJ8E8EsGktiesW9fnl4bfBeiga1Ai1SCC3Bq+UlAZ?=
 =?iso-8859-1?Q?fY7z1V351wNib7vpfd1tTk49V2Rd/4FeTRTHpQrhWjgFkmdtfRl/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LI3hcaE5withN6wSr66xu6QLjcDSPLXOeWWOOCat2+EnYuzsNGxdCtjMlIJk9vCaeRSW9rtcHpkXSL13J89x/eEMHgruxrWs7JAZXRcRuZNVP/d7CA+TnPB+2M1tl5RQSQLUGiaQBhjEjqFjVtj/WS2a1EtFkIo4QpqKKYuV3F4iY3Uk80izWOpFOcH9FZj3J/yvV6xsfC0TGGXawvZMf61dokORe5FE3eIwaXx0wlclKAz1TIaqhNggBaQhByjQ0GAKQDKTwPKeGqNaCmdEOEynGZ3K0hMZM9sKbBYX/PMwJSdicK6HCsvRCz8Af6pEI5DImB8o0xVX1SrZFAs5Zw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f1ce48-ef5b-41dc-15e2-08df044c7939
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 15:04:20.7422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7BfDjs/7hOyK1Q3bC+qA6DkvV5YUyohtKKdcJoG1sOL6i7FI/DQU5rNF8YXUhvwEsE++mWO0pepMBLnJKy+L5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
X-OriginatorOrg: intel.com

Thanks, the original test case is not applicable to Linux 6.12. A new test =
case is being developed to verify the effectiveness of this fix on 6.12, an=
d testing is still in progress.
Will provide v2 once it is done.

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Wednesday, August 26, 2026 10:18 PM
> To: stable@vger.kernel.org
> Cc: Sasha Levin <sashal@kernel.org>; Yao, Jia <jia.yao@intel.com>; Mun,
> Gwan-gyeong <gwan-gyeong.mun@intel.com>; Auld, Matthew
> <matthew.auld@intel.com>; Thomas Hellstr=F6m
> <thomas.hellstrom@linux.intel.com>
> Subject: Re: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
> separate BO
>=20
> > (cherry picked from commit 6af05de0dc19bbf3aaeec2020fe48b37c834b811)
>=20
> This series needs a v2 before we can take it...
>=20
> The cherry-pick lines name drm-xe-next commits that are not in Linus' tre=
e.
>=20
> The series also does not build on 6.12, and 2/3 is not safe there:
>=20
>  - XE_BO_FLAG_PINNED_NORESTORE does not exist on 6.12; it arrives with
>    045448da87bf ("drm/xe: Add XE_BO_FLAG_PINNED_NORESTORE") in v6.16.
>  - xe_guc_using_main_gamctrl_queues() does not exist either. It comes fro=
m
>    94edd6518613 ("drm/xe/xe3p_lpm: Configure
> MAIN_GAMCTRL_QUEUE_SELECT").
>    You dropped it from guc_um_init_params(), but the second call site in
>    xe_guc_ads_init() is still there.
>  - On 6.12, xe_guc_ads_init() runs before xe_vram_probe(), so 2/3's
>    XE_BO_FLAG_VRAM_IF_DGFX reaches add_vram() with no VRAM manager
> yet: a
>    NULL deref at probe on Battlemage. 2/3 also removes the
>    xe_managed_bo_reinit_in_vram() call, which is 6.12's only working VRAM
>    path.
>=20
> --
> Thanks,
> Sasha
