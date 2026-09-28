Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3923783C5;
	Mon, 28 Sep 2026 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581659; cv=fail; b=RC9rhljPTx3enVvX8w8Z4djBw5BdHfxFePeMq4M1l8gSJK0s7ov8IWAxsLpXsb2/nDP5X0xVohcweeA42+KpDl4AbpsRTuizGoOdWrvDnVfRqevD3PIRmuH8PdRIA77JT0OeCZX6NeW5oXtpK3xm5TLrkaCrU3djeAZo/AGxlH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581659; c=relaxed/simple;
	bh=m/V0z6Gp1JAw7NIZpAfz7ADsgGs5v1N9Y7rQVzvXLo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=npVemakGdVaciFchYxO8aEybiCXRtX64IahsQk0Ccj5rboPQO1eOPTunWN/Ma/U8s1gFU03bKCKvr/+TNzst1dh45jf9ymdO2u9E845ADEDFd6EpWgI7Ih4Gb4DZnIxGEp7Yf15+bPShGmcz6jPlOmVOa6UE1iK4BInt9i6CO8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pxryfmqa; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pxryfmqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581656; x=1822117656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m/V0z6Gp1JAw7NIZpAfz7ADsgGs5v1N9Y7rQVzvXLo0=;
  b=Pxryfmqar2+XI7hFzgq8fkSqGIJ3mnPFEWPFNjNZRyU2aQzq4pRxW/0b
   PSERUxE2Epaa0MQS1IXTh9fN/1Ht8UKsTZiJC4i33ToBCoD39zplsrx1C
   wW51Z+bh7GyVQksGJZSohbvjuoKGPoKXTBDLuU0OoUjHOW/GcI5mbrTds
   A/tvDYWDxtp4h2cKYS10IcISKeJwSlW9Z2NRndgcJmrssKmXiFwiQMdDp
   ctVmra8169sTebK2xPZF/bf4D5K6vf9S9i6dB0FR61M/+/RmsiCOSF6NC
   oJ5XuEE6w/MzZq4o9kiPQ+oz8+c/w+qXHGSKIFnrF2+hYUrb6FhOigw+3
   g==;
X-CSE-ConnectionGUID: i+4DvE8uRR2mKV3TkvlV8g==
X-CSE-MsgGUID: 71BvMcKSTUu/GJm2LPkk7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90315342"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90315342"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:47:35 -0700
X-CSE-ConnectionGUID: JJKJSLIoQTCcNhBBpSgoWQ==
X-CSE-MsgGUID: /bpVNwhJQaCUFHMzidPmtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275097306"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:47:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 00:47:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 00:47:34 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 00:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhB3lgQIxIjTsJDfTnLZ0hEQfgAFXo5ThHZZFeCFgATD3rIaLTYHSCvCkQsMy/2p+woGbwRW6NcmH+Z4I6KrmxiphBFRWEuPbWcSPvqmt442Xd3MlSv9sxdRbO9PDggYli7mgxuSlbhKViLLSn9n2h2hRWwTH/GBn18xC/JNdurZRgBtYUzW3kWedsTY+ZRhd41izidCyTWTjKOlQWnJ+do+pDfFfEKi8xegRrjhxmvTZbBqINGCe6G/4SaSf/6fCo2b775PknTkseWYr6PfA3mnImhoqHuhMkNhXun68C9eCvv+DB34c99O7UbWsx+hTB04cSY3z2sj9eSqoreQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/V0z6Gp1JAw7NIZpAfz7ADsgGs5v1N9Y7rQVzvXLo0=;
 b=lX8DaT0rWt9ykekg7RnujqZymDKXckCb4f8HYbpGApd+MVba/fjmQbrxg3N0e5VBNE9oszvt1XF9pdhhMXbMobcOnzxLi3KCqAjTUlJhnEp68WKKpC4YmkKcBM4wIiQWtM/q5MNjxy/XWHW+spwnBpQszzBcZwHbIsmI9wPXH9Cr9RqNrEFs4q0LAopbuQndL4kaUiOfmSXtyLonmHeWn0ULeK/uiEtQ23h0GKqrllAQ3ldUkcH6Ovlti3QzK81ZTLw91zB79yvcfgjqRIxyK9CumO08Vaa/WRmf8sRvuvXeNGHB+v23fc7tOsDP+yKsF9CwYdpIM+55tJMNdqp8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by IA3PR11MB9182.namprd11.prod.outlook.com (2603:10b6:208:579::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 07:47:31 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 07:47:31 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: luoxuanqiang <xuanqiang.luo@linux.dev>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>, "piotr.raczynski@intel.com"
	<piotr.raczynski@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix use-after-free in
 dynamic port cleanup
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix use-after-free in
 dynamic port cleanup
Thread-Index: AQHdE1vUr6Gm9bN9/UC4M6bFTJcRd7ZtD2KAgADVigCAdi96gA==
Date: Mon, 28 Sep 2026 07:47:31 +0000
Message-ID: <IA3PR11MB930172BD4BE20DA5B1C9CF818A8D2@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
 <36c68c94-0382-4d31-b114-fde2a5ad35cf@linux.intel.com>
 <2a1e5d38-1035-4f09-b4af-5a63ec04f1d1@linux.dev>
In-Reply-To: <2a1e5d38-1035-4f09-b4af-5a63ec04f1d1@linux.dev>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|IA3PR11MB9182:EE_
x-ms-office365-filtering-correlation-id: 0d705f82-a714-4b56-a193-08df1d34c068
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|5023799004|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 4FqGR4l/n6n6QB62Bm0Ytxerx4YDEHc0+JF+aMyYtcuMQKOrkN0lK6Dd4kZzqJIbNJObuvsxJymj2GkMOEalCfPzp8pWVTthhx9k9TTa+mLsgg4LExSJO12Mqoogsi22a6q7vYuSQW8L/cQjqs8mPcVo694476e6ZE/4bjCP5mDJSc2oK8n0NX1Idoo+5TbROn/db+3Uz+3LafF5MQG3lUE9sJ5sS/iCnjiPZj3GAECycd6JD3HxwAqeBBjgHLRSuv/nwizk1hqH89aF4+hrli0GXM2yf6+OP1j6WS8O9XKbWHDLQmL/PU4G51/ckUou2Lq6SPnwq5I1pIt+g56knT8AXjdReqo/tiYBoXOGjvs30bodGKFYxI/aPPFR3TWdRXH/xYGmNkfZygYlnosKCsYqt7jLyqcNF/YXlqaNTR6+Hwv93CCAbWxdXn86Abqjhg/3p+fMhGHYXxKFZ3zyNgb5OOS1BnIrkzQZeuVO5fEL7cBZoKhPmSAeYBldSiIXln6BFkqqzir0jS0MZiGPi15lg03eXIIDP31KWZscW+m6PT/fv/8rD0VqRfBM2I/04nnHYneOxlYn2u8GNdfaVrfx2grLTLPjIMoeOvADgB8KqFOtWnJFkG4Wc9NtpEDE9rnoHJrEEXuF5OP1Bu/1P0na2CAgxFEtsV/Mowa3n8Sh5UL8tICKY6XwH8J8RE2XY82gzJbmNAA872XcmYeKGynu8SVQa6raoYzeMThKUDk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkJxZHdiU2lTdEJjdjhCaUEyY2J5TzV0U2xqNkRlcTRyQlRGaENieWdCU2Ju?=
 =?utf-8?B?aUc4eXBpQnJRTHNOeXZwUi9CWFJIVG1xc0Rob01zZzJRczY5TUgvOWNyYmxZ?=
 =?utf-8?B?TXhjbHZ3ZjFjZlNLdTBHMG5XbnZOSjhpbFNteXhOR2tYZjc5UlBaRnJsQ0sx?=
 =?utf-8?B?RjNjWHFsMW05QUNvczl0OVlqaHZ5d2JoUlVReTZCSTQ3a050WDQ4U05YOXht?=
 =?utf-8?B?M3JQNXIwMUM3elMzNktNOUR1TzVQRUpDekR2anVWMVdlQUZrRjN4RzF6K0Rh?=
 =?utf-8?B?OThPQWt0VXJuSDQ0dGY0dUUxendyZk9rdklDam8wTmxHdjdlQW85UGlzak51?=
 =?utf-8?B?QUxwbE9rdVhUVm5zVkdmWkFiSkhTdDViR2dTNjd6ZWxkRFAwWkEzc2ZKV2Rl?=
 =?utf-8?B?cGRONFR2Z1RJb09ucGFQd1VJajB5d2FjblR4MUJZKzNlMGdEYjF2eHdDeHUy?=
 =?utf-8?B?Y2pXMkt3bHNWWUg5SWJwNnVJd1JRK2JEQnB4QzhJUHdLMzdmOFA1VUt2RkZJ?=
 =?utf-8?B?bUE4UFlZazVFaitNRkc0cktzTGVSQmEzTW9XNDQxcjNPQmFhYnJFbDBiQWRv?=
 =?utf-8?B?ZjRoWHpXQWVPSFNXVXJuRVJCRzR2dU5HL3lIa0NpaDFjc1J2NExnaWY3M25M?=
 =?utf-8?B?Mkl0RkNkUVFIQ2xsZEh3M0RWUTRSaHk2TWRQQ3NKZmRCaVRDaWQvQnY2OE40?=
 =?utf-8?B?VmRsdC9ycWpBQU5wemozYUY1ZWVkT2plK0lyYjBpMEQzVGFMYkg5d2JCZTRK?=
 =?utf-8?B?NDl0M0tlWXRaVWFYMFdBcE4vOUN1OS8xQlFkN28wTWxnVkk4WDFzc2xQOEta?=
 =?utf-8?B?dGRiT2VzaHdEWURZVTZVeGo5OHA5eEZ6L25hV2pxaUVXaitPMTNqRStPY0Yw?=
 =?utf-8?B?KytVNThWU2JwbzY1eSs1U2o2Z0lUYk5FMDVHTGYwU1ZrckR4MTlhRjFwSEEr?=
 =?utf-8?B?TkUyb2NUSVJXaUpHSERkcVRDM0ZkMnVFNlRuSlFzV3FkWkpsMmpGLzg3TWdw?=
 =?utf-8?B?eU5vcGM5bVQ2dFlWSDlRVkdnVjdKeU5LZFU1cHN3NjdiZHl1aU1CcDRQdXRs?=
 =?utf-8?B?UElWYVc2UCtCT0tJdGhqWi9MMzBQei91dmp5ZVhuaS9yWk9yWWQweS9RV1A0?=
 =?utf-8?B?eWdFYUFlVm51NEx4VTI5eXNGdTd2S0tYQXhwL1FoTzNCTXpzQVZQYmZaSDBC?=
 =?utf-8?B?WGlWZnJybDJ0MVFBTTRsM2wyTVpsVi9HRDdqeXJpT1JFV2p1K0xlK0tWWnZN?=
 =?utf-8?B?bU0yNEkyYVJtbWxDQmFrM0tsRkhsS2wzWXZlUStnekdtV0tqQVBjbTFTOWRS?=
 =?utf-8?B?MmNBWHN0V080Z2ZocEtvTktDZ3ZzK2ljeVJCalZBU3RGUzU5WVZPL1FjR1Bm?=
 =?utf-8?B?Z1VUR2dSbFJ3VEFsWVR4MW9ua2ljazM2U3hSSkUwd3U5bStqUXRORzBKUFht?=
 =?utf-8?B?MERWMTZWVnFXL2gvQUVwNWQ2MTFtazJsZHl0eHJEcnJZWTd2U2JsSGc3SGpG?=
 =?utf-8?B?WHNxN09Cajc5enlSS2lHcUNVQ3NFaGZGT253ZVFIODlpZDByaGdUUittVVpi?=
 =?utf-8?B?Yko5aTRHMFFBSlZXV3hqY2lxRk9SZ2d5UmUxb2dFVnBqWkxRN281RVZYUjB2?=
 =?utf-8?B?VDJwRkVYNW9FaVZ3YWJWeGRyMGpnVzREeWFOeCtpYlowdE1qUlBnc296YnNr?=
 =?utf-8?B?L001emNYUDBLZXpoaU8xWkNkVnI1T0txU0VSZGZmMUsyVGhpV3FTVG5PcUNp?=
 =?utf-8?B?NWJBY3VTcm5DMk5BVzJkZHpranlEZ1pURG1jbld1bzZyMHQ2aGNpbG5xMlBu?=
 =?utf-8?B?U0gvQ0oyVWhSalczT0xPTE9IU1l0RE5vODBYN0F2TEx1eDlOR1JSMjZNZ3Ux?=
 =?utf-8?B?ZDFyMnBRUE9VdTlmRmFOWi9pSVF3VVpkb2V6WVlsajlKOUVUT0pmTTdTZ3lL?=
 =?utf-8?B?K1JYY3hoQlQvb2pQUTl6K3JkSzduWWx2UjJ4WnlKa2l1VmRhSWtJSWg0TmhN?=
 =?utf-8?B?M0l6NHNXNDZ3aTdGKzRxWnMrM1VoT21uZUlIbmFaeFFhQnhqcXBlRk9KRW1v?=
 =?utf-8?B?YTg3d3VXcStVd20zK0ZtTDE4M1Q4UWhJeWVtd2Z2a2hjRmZ4Z1hJaXdVT2dz?=
 =?utf-8?B?WXJiRDNJYzlCaE1XN3dadjBEeHZ4YXQvNHpCUUEwT0l1SHhlajlTZ3FRaHV4?=
 =?utf-8?B?K0RVa01VNFdkaDhxWkdQOEk5eVN6QzluSDFWYy9yOThUS05mWlpVMkJqeWc4?=
 =?utf-8?B?VDlEU3BHQXh4YUprWEVrYkdGaUk3dzFwQUxtREZFb2tXTkpWWjhidGV3SGsx?=
 =?utf-8?B?NkNTbGVmN2VXZXBVcjlrWFErVG1SWDRYNmhoV2FiaDhwTWxHY3lJdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3joI74LigFRGPUl57PpqGnYaDGC7JKWAYJVSxJA7bCecOmTb+5pRLq018ZMq7QrsYB88xfma3v2i1XubG6va1N5hrm9cRSkREGLCxggoTk1d+bDt+jnJqw6+DYtlbRQTbEa6srVJnsHl4j0g3LCBlz8Ama1p7/pBwVf/9h+mGdIwzX/juXEGhFmhhquSvZfmPZIr/kNYMJRzxSlgHmqz6iSEMMr4oBulVwZEEv+PdrUJ0HlceP87FnzSjjxBxvKtt60jhxGu6fSQzbemhE1jz6gnE34RwgKNL19JRnXe176l0EaBOQ0Wb1rhey/n593Qvr+5ccU1WH2H8UhAkIzdgQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d705f82-a714-4b56-a193-08df1d34c068
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 07:47:31.3242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChU2mlXmqwtXmJ3tfTcd3SV1sShkldg6jOzgE+zcECM6bDhCzKiBep63iJWbjdCqzCFdTrKBCn8Bmtv74BYCgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9182
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEludGVsLXdpcmVkLWxhbiA8
aW50ZWwtd2lyZWQtbGFuLWJvdW5jZXNAb3N1b3NsLm9yZz4gT24gQmVoYWxmIE9mDQo+IGx1b3h1
YW5xaWFuZw0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTUsIDIwMjYgNDo1OSBBTQ0KPiBUbzog
TWFyY2luIFN6eWNpayA8bWFyY2luLnN6eWNpa0BsaW51eC5pbnRlbC5jb20+OyBpbnRlbC13aXJl
ZC0NCj4gbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IE5ndXllbiwgQW50aG9ueSBMIDxhbnRo
b255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNs
YXcua2l0c3plbEBpbnRlbC5jb20+OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IFNhbXVkcmFsYSwN
Cj4gU3JpZGhhciA8c3JpZGhhci5zYW11ZHJhbGFAaW50ZWwuY29tPjsgRHJld2VrLCBXb2pjaWVj
aA0KPiA8d29qY2llY2guZHJld2VrQGludGVsLmNvbT47IHBpb3RyLnJhY3p5bnNraUBpbnRlbC5j
b207DQo+IG1pY2hhbC5zd2lhdGtvd3NraUBsaW51eC5pbnRlbC5jb207IEtlbGxlciwgSmFjb2Ig
RQ0KPiA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
WHVhbnFpYW5nIEx1bw0KPiA8bHVveHVhbnFpYW5nQGt5bGlub3MuY24+OyBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5l
dCB2MV0gaWNlOiBmaXggdXNlLWFmdGVyLWZyZWUgaW4NCj4gZHluYW1pYyBwb3J0IGNsZWFudXAN
Cj4gDQo+IA0KPiDlnKggMjAyNi83LzE0IDIyOjE0LCBNYXJjaW4gU3p5Y2lrIOWGmemBkzoNCj4g
PiBPbiAxNC4wNy4yMDI2IDA4OjM5LHh1YW5xaWFuZy5sdW9AbGludXguZGV2IHdyb3RlOg0KPiA+
PiBGcm9tOiBYdWFucWlhbmcgTHVvPGx1b3h1YW5xaWFuZ0BreWxpbm9zLmNuPg0KPiA+Pg0KPiA+
PiBpY2VfZGVhbGxvY19keW5hbWljX3BvcnQoKSB1c2VzIGR5bl9wb3J0LT52c2ktPmlkeCB0byBl
cmFzZSB0aGUNCj4gPj4gZHluYW1pYyBwb3J0IGZyb20gcGYtPmR5bl9wb3J0cy4gSG93ZXZlciwg
aXQgZnJlZXMgdGhlIFZTSSBiZWZvcmUNCj4gPj4gcmVhZGluZyB0aGUgaW5kZXggZm9yIHRoZSBl
cmFzZSwgcmVzdWx0aW5nIGluIGEgdXNlLWFmdGVyLWZyZWUuDQo+ID4+DQo+ID4+IEZvbGxvdyB0
aGUgcmV2ZXJzZSBvZiB0aGUgYWxsb2NhdGlvbiBvcmRlciBpbg0KPiA+PiBpY2VfYWxsb2NfZHlu
YW1pY19wb3J0KCkgYnkgZXJhc2luZyB0aGUgeGFycmF5IGVudHJ5IGJlZm9yZSBmcmVlaW5nIHRo
ZSBWU0kuDQo+ID4+DQo+ID4+IEZpeGVzOiBlZGE2OWQ2NTRjN2UgKCJpY2U6IGFkZCBiYXNpYyBk
ZXZsaW5rIHN1YmZ1bmN0aW9ucyBzdXBwb3J0IikNCj4gPj4gQ2M6c3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBYdWFucWlhbmcgTHVvPGx1b3h1YW5xaWFuZ0BreWxp
bm9zLmNuPg0KPiA+IFJldmlld2VkLWJ5OiBNYXJjaW4gU3p5Y2lrPG1hcmNpbi5zenljaWtAbGlu
dXguaW50ZWwuY29tPg0KPiA+DQo+ID4gVGhhbmsgeW91IQ0KPiA+IEkgd29uZGVyIGhvdyBzdWNo
IGEgZ2xhcmluZyBpc3N1ZSBzdXJ2aXZlZCBpbiB0aGUgY29kZWJhc2UgZm9yIHNvIGxvbmcuDQo+
ID4gUGVyaGFwcyBpY2VfdnNpX2ZyZWUoKSBleGl0ZWQgZWFybHkgZm9yIHNvbWUgcmVhc29uLg0K
PiANCj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KPiANCj4gSGFyZCB0byBzYXnigJRtYXliZSB0
aGUgd2luZG93IGlzIHF1aXRlIHNtYWxsIGFuZCB0aGUgZnJlZWQgc2xhYiBzdGlsbCBob2xkcw0K
PiB0aGUgb2xkIGlkeCBtb3N0IG9mIHRoZSB0aW1lLCBzbyBub3RoaW5nIG9idmlvdXMgc2hvd3Mg
dXAuDQo+IA0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
ZGV2bGluay9wb3J0LmMgfCAyICstDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pY2UvZGV2bGluay9wb3J0LmMNCj4gPj4gYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvZGV2bGluay9wb3J0LmMNCj4gPj4gaW5kZXggMmEyZTU2Nzc3ZjlmNy4u
M2VkZTI0NjQ5MDAyNyAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWNlL2RldmxpbmsvcG9ydC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2ljZS9kZXZsaW5rL3BvcnQuYw0KPiA+PiBAQCAtNTkwLDggKzU5MCw4IEBAIHN0YXRpYyB2
b2lkIGljZV9kZWFsbG9jX2R5bmFtaWNfcG9ydChzdHJ1Y3QNCj4gPj4gaWNlX2R5bmFtaWNfcG9y
dCAqZHluX3BvcnQpDQo+ID4+DQo+ID4+ICAgCXhhX2VyYXNlKCZwZi0+c2ZfbnVtcywgZGV2bGlu
a19wb3J0LT5hdHRycy5wY2lfc2Yuc2YpOw0KPiA+PiAgIAlpY2VfZXN3aXRjaF9kZXRhY2hfc2Yo
cGYsIGR5bl9wb3J0KTsNCj4gPj4gLQlpY2VfdnNpX2ZyZWUoZHluX3BvcnQtPnZzaSk7DQo+ID4+
ICAgCXhhX2VyYXNlKCZwZi0+ZHluX3BvcnRzLCBkeW5fcG9ydC0+dnNpLT5pZHgpOw0KPiA+PiAr
CWljZV92c2lfZnJlZShkeW5fcG9ydC0+dnNpKTsNCj4gPj4gICAJa2ZyZWUoZHluX3BvcnQpOw0K
PiA+PiAgIH0NCj4gPj4NCg0KVGVzdGVkLWJ5OiBQYXRyeWsgSG9sZGEgPHBhdHJ5ay5ob2xkYUBp
bnRlbC5jb20+wqANCg0KDQo=
