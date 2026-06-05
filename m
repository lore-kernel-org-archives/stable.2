Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9A386568;
	Fri,  5 Jun 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679053; cv=fail; b=O2SpU2YwaJ5HQm1DkiNV/jb/C2Lzg0jNyLzHhP5b4eTRrvJq9s0+BHsOCQWZzwAB9dxMwt+Z0QSVzS4bURvLG9NHshCFv9YS204CLJIQYcF0rO3pTPM3TjM703V5VX7Z8ojnSCDBYLjWx6LH3U+Q192piKUOjSvRGAAi3s+gPFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679053; c=relaxed/simple;
	bh=bdMiORfXbjViSH7+L95ohZ6RYAkIfUDW9iJba1qcIbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B+8jdJKyz/lsZ/XAXS60GYO92aIX9+vlZ6Rb/OapdZuJ5LdSi6NrNpyNKL+94FqYNVRpNphvuXvlpKvD0E+FlDMEEsz0/YuJL8ny1jQ6qxdJMW9V0uKQMUTniQtPqbRISHbMGZFuxrELeEGntpCwN9Gm8DOrE+PylTXq5V607/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1AolMfP; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1AolMfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780679052; x=1812215052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bdMiORfXbjViSH7+L95ohZ6RYAkIfUDW9iJba1qcIbw=;
  b=H1AolMfPixUvX4Pdx0larYmjOyI8/vx+vf55Oc19P9fMe+ADS07e6TXj
   LN8Qc/9Lg/ThJ4lN/Jyg4rNh0qyJ0opjm5RAyocYh1nJOgWDsBE4OZ/jQ
   5QoNYhPLNXgWkl7/bOaWmzN3xRliADn2dp309ycd0SlXxMlXHxSZmNQyN
   1/sbNUYxebkN947kHdir/tsmD1Rg7Fysa1L4TDaI/t2ITtumuVLw9lhJa
   XcHe4C/Qf76mW+Fi3HFKLttQ0gTvVn5MAfgM4sbHGmUjrEoCa4mItfR4w
   wTwDbhvw3tlL754hpCy6Nx4p7naHxAo4nA2hp0BnC0nCO6q0wpzZ5HlOF
   g==;
X-CSE-ConnectionGUID: XSTewXpjRTms70DPdDoCXg==
X-CSE-MsgGUID: bi74SlgASQCWwvM2PGEX/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="98935926"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="98935926"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:04:10 -0700
X-CSE-ConnectionGUID: U+y56OiFTLe161lB5NecWg==
X-CSE-MsgGUID: p1MY8b9sSnep+3HOD3T0JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="245015527"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:04:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 10:04:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 10:04:07 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 10:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+rcLjtN2g6nRyNo1shLj3CJ3sklaZdXJBxywEue5nc23ANfLonQybc/kdv+bAiJ5qYpNsiwvreFGDI4KSM+8nvB8DwoZdoT4Bwue6+B6xftOQSF1Rp/vuhSIJYtQCG5t7yUOmU4TvWMrlgZJDZcx99bYBs8oBpNPwF+SS78DgRbGnQdxbxOOS9VOoS28a4q0drZETB/dbbikUUuAH7SgIUsLfbRjI5olKT19aunczXPD7e++5+hyAy5SgbgpLR8gaHz59ghUutrmTkyXpD+pM57aU27jOuhT8bZvhbaImHU2uw+j0DjGXkA/tTcTSLZ/EbytgMMYhPBw9DdDzH5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdMiORfXbjViSH7+L95ohZ6RYAkIfUDW9iJba1qcIbw=;
 b=VtUEFtb1jdBGJ423c6CBNrhBqQy4qwGPVt1e/tFdtBbZUD6aiYVmQWYnDLCNGd3MjRBr8JfKoHeVj6rzIsmJHA8mKYe9fUvSEuKolHOYtf38pMzqH/v+6JOCGhghC/ckFqhuuyhI5Kk+R7eCoEknnPcfoZNHOzkJB7Y8nUWvGNRzmUzH8EGY2Sq0x3L3KfKBZVwL+d79vIAwHLnB3kgVnIHhC2rA+AQhWsQiqOcHygq+HGjO2vplt3r2LYDiAKdNQoinEZTA11ra+TALXVLUqwA8wRv5ffhS13nFOWUwG1854owjy8wTHL1UEzDN12ho5flfz83O9IzqYEc/XAdCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DM3PPF49E43CAC1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 17:04:04 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 17:04:04 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
	<irogers@google.com>, "Eranian, Stephane" <eranian@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Chen, Zide"
	<zide.chen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>,
	"Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [PATCH 1/8] perf/x86/intel: Remove anythread_deprecated bit from
 perf_capabilities
Thread-Topic: [PATCH 1/8] perf/x86/intel: Remove anythread_deprecated bit from
 perf_capabilities
Thread-Index: AQHc9IkJex/rNcd47UmM/q7+u89ps7YwMYyA
Date: Fri, 5 Jun 2026 17:04:04 +0000
Message-ID: <7fdb17e042719f77c382cbc47be2def2cda1bf51.camel@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
	 <20260605011136.2043393-2-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260605011136.2043393-2-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DM3PPF49E43CAC1:EE_
x-ms-office365-filtering-correlation-id: 201e03a4-6765-4309-0ccd-08dec32472cd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700021|3023799007|921020|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: eewpiN+LRr77beMbWokXWcjgQSD0dFusckKRgzs7e1EiYlSS8XmPR9fz3cXyzMFAsjQJDhg6e4rGfITxCnm4q6LitKhFiVc8grqcvt2tYlthwbpH7OBzTiWssojLJd0L4oA/ocwgJMeF7J0NwAzeCQtki4bV0sFF//ElTzkGI9nIGlEKA71Hr5u774EonY8R5aWiiVMwtymmQE/QU3J2U5GbRxlpndcr4p0cP1lBvQ2uOdw4bugZY6mCJdCHAR8RwfNClJ9b8f23DaY7p8yVkbnIzrx4MYe/3e7GohBu8tkMOxnfshXmUHt2/p3ChCZ6CdrIBL9jiAK7QlaoOzw6I1UE7LU/6IfWvP2duOsWWEejwmqqK2g91Yeig3IwLqYZ5mUXoPiDwS2nOpK077o796szlKKEVjIxCNdljspxs/VV16s6xZPk69w3z9RkzOpvDwd/eWyhRwPzJnGX/0qlsU+z8CFkvkQaQpdL+KPdma83BucNu1E2mYQzVCu1HHkKKFhWjNAFBR63zaDmPgsfRoIQF8c2HDkMk0t8O7zPyWpHZEZUEj9LAUe7UqjOlcJHyBWXsoNLJgrTD3FfACWMCa81r4BcoW/elq9Cuyvr6Q+jNv85d5y6uuVIC1uN2PKZkH3PJQiS4uujPtmYf4hWJX13SCEcXgbCdwfb+fMKQdL2t+XfvatKMiVv9bAk/pM+GKW6SxKkT2MYp0Wiy5x5krvmk7qufIna7+sQK9gKW/fwTcoME0gFwQplT67rsJtCeUUO2kIaJs/LMumA3ohyKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700021)(3023799007)(921020)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3RFZnNKeDk2bDlmSkVjR1ZLYUd3Ty90Q3ZiYkVLaHZnZjZZVVRqcEc0V3Za?=
 =?utf-8?B?U3hGbldGRGl3ZUZ2b0NzU0hCc0FTWFRseCtiWnB4bldWcE94OHQ0ZXdhTTFt?=
 =?utf-8?B?VVhUeEhYTjlTSy9odU91alJIeHNWUGpzUlVSam8yd0pDV0ppWXQ1b2h4WURp?=
 =?utf-8?B?bTVrWVY0Y09UYlJ4UTBHU2hwM1AweDl1ZUdXMnphcGV2ZDhwTERlVS9BQzl3?=
 =?utf-8?B?K3ZTSm5sbEx4OU5OL3ZYOHRTR0ZoRzFxWG93VktJSlhQWmJmOU1STXhxVndN?=
 =?utf-8?B?TmwxUFZHNnJYQ05tQ2ZXMTFtWWhnRnJBSTR2NG13Q2cxclRLN0s4bDF2UUhl?=
 =?utf-8?B?b29UdmVIYWJJNjZLeEVDR2lKTGYvSVdRTlNFMnk5V1d1aE9Kc2dmZWFFUm5t?=
 =?utf-8?B?NUpXRnhhUTZPNHlleTVQUlJMMmw0V3N2dklKU3FTcWx2S2puZkhBTmJ5ckFU?=
 =?utf-8?B?RXNDUGJTbVdQL3dMZEtQbWIzNWVCVnJ3cmZXUHBIN3NaQ0xkdEY2ZWk5aktr?=
 =?utf-8?B?ZURaRjQzU1FyVHR2TW1NTjZqbHBUOWFLdFRDN3RTQk8yaHkyZ1gwcDNZUmVz?=
 =?utf-8?B?SjJoZzNUOFg4V2JTd1pKWWRxOGJGZDN3Y0hLSlc2bzgwVlMxUExMMklscGI5?=
 =?utf-8?B?YTdRdEpvYnY4cG4yUStNdHNzT1YvN21BU21jN0pGRkxKeUJJS2JQVUR6UW4x?=
 =?utf-8?B?STZTRVpuOC93aXl1cTAxSTVlQWtDQ3l1ZXExalR0V3NzV0w2WWE5RlhYaDNY?=
 =?utf-8?B?WkhZM0JlcGZIMGIzUHpUZEN5Tm5WNzV3bDJTMzVha0VWeG1LWVZTb2lxdlZk?=
 =?utf-8?B?ekNXL05hNlhNb1J3MW1CdVRDeGNsTU5HUkh6KzltZWRuOFErLytNaVVHbDZW?=
 =?utf-8?B?dWVmekRhVHVLTWt5RlozZnhRSkdHVmFnaFBCSElPeTBEZ3ZPdHl2eHg3TzdT?=
 =?utf-8?B?SWh1QWdYdmlOVmVRcGcxU0dZK2l1Uk9MSXBBaTUvY2l4VTR3Q2JQMTZ2Qit4?=
 =?utf-8?B?QnkrYjdSTzlBMXNwK2lFM0hocHZhVUpJblJOSk1aMU5XOEwvQW93WHFYRFl4?=
 =?utf-8?B?cm01K1kvbXZYQTRSOGpXdzJCWTNmQTM4dmNuemFSUlRBZE1xR3paaVRVdlFO?=
 =?utf-8?B?emJzeFNzc2ZweE5Nd2luejFmWUkwRzhiU1A2NDV4SkZ6R1BPYVh0UjNxdDNz?=
 =?utf-8?B?Mk9qeXdLbE1TdWRHOEQvM3ZZUlVlbllLZnJUVzNsK3lKR2l1NERiRjE4a20r?=
 =?utf-8?B?WG4rNnRKU1lvVW1hSHRySE5tcGx1Q3FWenhSVUs1bm5KMHpKMG8wQ0dYd3Ns?=
 =?utf-8?B?OEYxb2RCdGFmeW9vYWFta0JGaC9RdFR4d1dzZGttVEhtMWQxR0pZbnBXUEtK?=
 =?utf-8?B?ME9MTUZybnNPZTJJcEJYL25UdXhvWGczTzJPK09TVk5RdGQ2bEsxaHJ5Q1dt?=
 =?utf-8?B?UDltcTVqeHRSbXVPY3ZXZ2s4YlpwUzM0ckhVcmkwY1djQk0rV0dlU0x1OUdX?=
 =?utf-8?B?K3Y4enZMZXBBd3MwVmFpU1FxOWk0MzlUVkwzV2hLeGM4K1Jxd25ENm45ZStV?=
 =?utf-8?B?UG5MS2V0SEoxSDlvNGx0UWR5d2VzbG02Wm53dlEycU91MHJjN21vb1kzdmhT?=
 =?utf-8?B?REhTTFZRU1RzNWpRdjRXWHZPd1BMcHVocnNLZExLQ1NHazZON1Q4TzQ4czM2?=
 =?utf-8?B?ZWN1ZzRtSVpYKzczVTRwaHVBUXVXc08xQlhKQzdvb3VjeHRaVG9velVpK1Zt?=
 =?utf-8?B?elg5R1ZTSEl4T0o5VTVQWG50MURjbEJ3VVd1aDNTS2RCSlIybGhXZHQvYkFw?=
 =?utf-8?B?ZHptc1lTTE8wK0NvMEs1c3hHYnRvS2l3aTkwS0prd2UrQTZLK1MzN090UVBG?=
 =?utf-8?B?SnM3MDVvTE5acFJiZStPRmoweGJLWmFqVHl6UEhWcEdMeTRScUNNQ2FFWHBD?=
 =?utf-8?B?cnY1RHJOQ2FydzhJbTRWWUhyOXlyMm5PTUptOGFpSkM5RVJQUURsSVZ5Q2Ny?=
 =?utf-8?B?UTlqZkVtaWJiN3dJM01YYmg5aURVb2NWTm05SGlMZjFHUmRieGZialpJOHgw?=
 =?utf-8?B?MEZ5Uy92Vk80UVZmbHVuMUF4WlNzM1RWYVRnYTl2eEIxTWpkTGJrUWJDZ3R0?=
 =?utf-8?B?NXV6bVJydTdTdTIwK2dhOFR4cGU2eDVUa0ZmRm1BTmZTZDd4VGliRWFQVk5Q?=
 =?utf-8?B?YnhsaDc0NCt2Mk5ON1d3UUFjbDJ1ZW9nb3hoaTVlRjRRSjRDaTQ1c2tEY0xj?=
 =?utf-8?B?Si9CUWh5R3lZQzEyTzNyYXVMcUI0VFRoOGwra0FKZHR4akFPNDNjalQ0Z1Zy?=
 =?utf-8?B?eG5MV1JtRDVCV2tyWDNHOWZiYUx0OEViWUlPeXp3dENHTlU5aVlodDdaS3c1?=
 =?utf-8?Q?MNLyzUIq1nL4RmfobNlocAqjDYtyQQuDa2SU7UFi23BoG?=
x-ms-exchange-antispam-messagedata-1: Y146+qlhSxyfDsfmntG0xiT/VL3umnF1vjc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF016F4A85397D4BB5C2C0CCEE4FAB73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eFs4v9jnkx4pOWpift7AgVDQYMyp7NB86BnEwD9QotXiVTPX7fRZsUtZoD5NduJoYUVzdW+xZviF0TOMdxieOysnaeQAXygLSnwWzMPf13oM5DvcX5IRIPls+eE4Vkr8FP+Ndx2DZweTR5CSRY8GPKISbOqD360S9FGjjTN6fv9t/iUtxEPGiV3HmsepyJ/NdTw7j7yaTP9OLsxP5hoFjnyc2NstTTn15BJLTyjeHfuERsgBY3s6zjL7N8uuF1iawmXQyxdLFTW7hmJ3EJWvpm4Tg2BRAhn8SbaQlRVJ6o/GJCdsWTaWpCBwD/40/hMXa7FAJ5UoJ8UTZXSOEKa4cA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201e03a4-6765-4309-0ccd-08dec32472cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 17:04:04.5208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I55FhcEzxTwvYlK8x7hfp3KfG/4cjFlaXkaEzFF45e0G66Kvm5KztPjq1F7XzL0TVVltmCGdciIKlup2JhSgXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF49E43CAC1
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDA5OjExICswODAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IEFu
eVRocmVhZCBtb2RlIGRlcHJlY2F0aW9uIGlzIGVudW1lcmF0ZWQgYnkgQ1BVSUQuMEFIOkVEWFsx
NV0gaW5zdGVhZA0KPiBvZg0KPiBQRVJGX0NBUEFCSUxJVElFUyBNU1IuIEl0J3Mgbm90IGEgZ29v
ZCBwcmFjdGljZSB0byBkZWZpbmUgYSBiaXQgdG8NCj4gcmVwcmVzZW50ICJhbnl0aHJlYWQgZGVw
cmVjYXRpb24iIGluIHBlcmZfY2FwYWJpbGl0aWVzLiBJdCBsZWFkcyB0bw0KPiB0aGUNCj4gYW55
dGhyZWFkX2RlcHJlY2F0ZWQgYml0IGNvdWxkIGJlIG92ZXJ3cml0dGVuIGJ5IHRoZSByZWFsIHZh
bHVlIG9mDQo+IFBFUkZfQ0FQQUJJTElUSUVTIE1TUiwganVzdCBsaWtlIHRoZSBiZWxvdyBjb2Rl
IGluIHVwZGF0ZV9wbXVfY2FwKCkNCj4gZG9lcy4NCj4gDQo+IGBgYA0KPiBpZiAoIWludGVsX3Bt
dV9icm9rZW5fcGVyZl9jYXAoKSkgew0KPiAJLyogUGVyZiBNZXRyaWMgKEJpdCAxNSkgYW5kIFBF
QlMgdmlhIFBUIChCaXQgMTYpIGFyZSBoeWJyaWQNCj4gZW51bWVyYXRpb24gKi8NCj4gCXJkbXNy
cShNU1JfSUEzMl9QRVJGX0NBUEFCSUxJVElFUywgaHlicmlkKHBtdSwNCj4gaW50ZWxfY2FwKS5j
YXBhYmlsaXRpZXMpOw0KPiB9DQo+IGBgYA0KPiANCj4gSXQgbGVhZHMgdG8gdGhlIGFueXRocmVh
ZF9kZXByZWNhdGVkIGJpdCBpcyBjbGVhcmVkIHRvIDAgYW5kIHRoZQ0KPiAiYW55Ig0KPiBhdHRy
aWJ1dGUgaXMgaW5jb3JyZWN0bHkgc2hvd24gaW4gdGhlIC9zeXMvZGV2aWNlcy9jcHUvZm9ybWF0
LyBmb2xkZXINCj4gb24NCj4gdGhlc2Ugc3VwcG9ydCBQZXJmbW9uIHY2IHBsYXRmb3JtcywgbGlr
ZSBDbGVhcndhdGVyIEZvcmVzdC4NCj4gDQo+IGBgYA0KPiAkZ3JlcCAuIC9zeXMvZGV2aWNlcy9j
cHUvZm9ybWF0LyoNCj4gL3N5cy9kZXZpY2VzL2NwdS9mb3JtYXQvYWNyX21hc2s6Y29uZmlnMjow
LTYzDQo+IC9zeXMvZGV2aWNlcy9jcHUvZm9ybWF0L2FueTpjb25maWc6MjENCj4gL3N5cy9kZXZp
Y2VzL2NwdS9mb3JtYXQvY21hc2s6Y29uZmlnOjI0LTMxDQo+IGBgYA0KPiANCj4gU28gcmVtb3Zl
IHRoZSBhbnl0aHJlYWRfZGVwcmVjYXRlZCBiaXQgZnJvbSBwZXJmX2NhcGFiaWxpdGllcw0KPiBz
dHJ1Y3R1cmUNCj4gYW5kIGRpcmVjdGx5IGRlcGVuZHMgb24gQ1BVSUQuMEFIOkVEWFsxNV0gdG8g
anVkZ2UgaWYgYW55dGhyZWFkIGlzDQo+IGRlcHJlY2F0ZWQuDQo+IA0KPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBSZXBvcnRlZC1ieTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJu
ZWwub3JnPg0KPiBGaXhlczogY2FkYmFhMDM5Yjk5ICgicGVyZi94ODYvaW50ZWw6IE1ha2UgYW55
dGhyZWFkIGZpbHRlciBzdXBwb3J0DQo+IGNvbmRpdGlvbmFsIikNCj4gQWNrZWQtYnk6IE5hbWh5
dW5nIEtpbSA8bmFtaHl1bmdAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogRGFwZW5nIE1p
IDxkYXBlbmcxLm1pQGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFppZGUgQ2hlbiA8
emlkZS5jaGVuQGludGVsLmNvbT4NCj4gLS0tDQo+IA0KPiBPcmlnaW5hbCBwYXRjaCBsaW5rOg0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA0MjMwNTMzMDYuMzAzMzMzMS0xLWRh
cGVuZzEubWlAbGludXguaW50ZWwuY29tLw0KPiANCj4gwqBhcmNoL3g4Ni9ldmVudHMvaW50ZWwv
Y29yZS5jIHwgMTAgKysrLS0tLS0tLQ0KPiDCoGFyY2gveDg2L2V2ZW50cy9wZXJmX2V2ZW50Lmgg
fMKgIDIgKy0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvY29yZS5jDQo+
IGIvYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYw0KPiBpbmRleCAwMjE3ZTcwMWFlZWIuLmVh
M2FiMzA1MGEzYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYw0K
PiArKysgYi9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvY29yZS5jDQo+IEBAIC03OTQ2LDEyICs3OTQ2
LDYgQEAgX19pbml0IGludCBpbnRlbF9wbXVfaW5pdCh2b2lkKQ0KPiDCoA0KPiDCoAl4ODZfYWRk
X3F1aXJrKGludGVsX2FyY2hfZXZlbnRzX3F1aXJrKTsgLyogSW5zdGFsbCBmaXJzdCwgc28NCj4g
aXQgcnVucyBsYXN0ICovDQo+IMKgDQo+IC0JaWYgKHZlcnNpb24gPj0gNSkgew0KPiAtCQl4ODZf
cG11LmludGVsX2NhcC5hbnl0aHJlYWRfZGVwcmVjYXRlZCA9DQo+IGVkeC5zcGxpdC5hbnl0aHJl
YWRfZGVwcmVjYXRlZDsNCj4gLQkJaWYgKHg4Nl9wbXUuaW50ZWxfY2FwLmFueXRocmVhZF9kZXBy
ZWNhdGVkKQ0KPiAtCQkJcHJfY29udCgiIEFueVRocmVhZCBkZXByZWNhdGVkLCAiKTsNCj4gLQl9
DQo+IC0NCj4gwqAJLyogVGhlIHBlcmYgc2lkZSBvZiBjb3JlIFBNVSBpcyByZWFkeSB0byBzdXBw
b3J0IHRoZQ0KPiBtZWRpYXRlZCB2UE1VLiAqLw0KPiDCoAl4ODZfZ2V0X3BtdShzbXBfcHJvY2Vz
c29yX2lkKCkpLT5jYXBhYmlsaXRpZXMgfD0NCj4gUEVSRl9QTVVfQ0FQX01FRElBVEVEX1ZQTVU7
DQo+IMKgDQo+IEBAIC04ODI4LDggKzg4MjIsMTAgQEAgX19pbml0IGludCBpbnRlbF9wbXVfaW5p
dCh2b2lkKQ0KPiDCoAkJCQnCoMKgwqDCoMKgICZ4ODZfcG11LmludGVsX2N0cmwpOw0KPiDCoA0K
PiDCoAkvKiBBbnlUaHJlYWQgbWF5IGJlIGRlcHJlY2F0ZWQgb24gYXJjaCBwZXJmbW9uIHY1IG9y
IGxhdGVyDQo+ICovDQo+IC0JaWYgKHg4Nl9wbXUuaW50ZWxfY2FwLmFueXRocmVhZF9kZXByZWNh
dGVkKQ0KPiArCWlmICh2ZXJzaW9uID49IDUgJiYgZWR4LnNwbGl0LmFueXRocmVhZF9kZXByZWNh
dGVkKSB7DQo+IMKgCQl4ODZfcG11LmZvcm1hdF9hdHRycyA9IGludGVsX2FyY2hfZm9ybWF0c19h
dHRyOw0KPiArCQlwcl9jb250KCJBbnlUaHJlYWQgZGVwcmVjYXRlZCwgIik7DQoNCklzIHRoZXJl
IGEgcmVhc29uIHRoZSBsZWFkaW5nIHNwYWNlIGlzIG1pc3NpbmcgaGVyZT8gT3RoZXIgdGhhbiB0
aGF0LA0KTEdUTS4NCg0KUmV2aWV3ZWQtYnk6IFRob21hcyBGYWxjb24gPHRob21hcy5mYWxjb25A
aW50ZWwuY29tPg0KDQo+ICsJfQ0KPiDCoA0KPiDCoAlpbnRlbF9wbXVfY2hlY2tfZXZlbnRfY29u
c3RyYWludHNfYWxsKE5VTEwpOw0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZXZlbnRz
L3BlcmZfZXZlbnQuaA0KPiBiL2FyY2gveDg2L2V2ZW50cy9wZXJmX2V2ZW50LmgNCj4gaW5kZXgg
ZWFlMjRiYjM1ZGMxLi41OTAyYTI5N2RhYTEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2V2ZW50
cy9wZXJmX2V2ZW50LmgNCj4gKysrIGIvYXJjaC94ODYvZXZlbnRzL3BlcmZfZXZlbnQuaA0KPiBA
QCAtNjY4LDcgKzY2OCw3IEBAIHVuaW9uIHBlcmZfY2FwYWJpbGl0aWVzIHsNCj4gwqAJCXU2NAlw
ZXJmX21ldHJpY3M6MTsNCj4gwqAJCXU2NAlwZWJzX291dHB1dF9wdF9hdmFpbGFibGU6MTsNCj4g
wqAJCXU2NAlwZWJzX3RpbWluZ19pbmZvOjE7DQo+IC0JCXU2NAlhbnl0aHJlYWRfZGVwcmVjYXRl
ZDoxOw0KPiArCQl1NjQJX19yZXNlcnZlZDoxOw0KPiDCoAkJdTY0CXJkcG1jX21ldHJpY3NfY2xl
YXI6MTsNCj4gwqAJfTsNCj4gwqAJdTY0CWNhcGFiaWxpdGllczsNCg0K
