Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581002D2381
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403693; cv=fail; b=rw+ugQA5z29dbY2+zYxiOKLq896sIWS0GG3xLIui588rsWLuw4lap0ADod6mxZZcMxjly8UqSY1f8fngbtcj9FSLxuBy828QwejhXJjP11Ird7jgSpi7iwiY1+0I3KC1HMDtdGjGrYO4ddX6rOAtINLLBPA6xAJkTlhB9XJNls4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403693; c=relaxed/simple;
	bh=UytSSC7WqjZa7z5mAe2gyaUgaRWwAHQ8mctH6rDRh68=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=o10u1fiavZocGynj2fUVYb6ZIXJdj044o5g2asEeuQz/806vzmCBTR+8qO0MWw3P9CzLzzhlKExyabs7VSE46EP6m4sagYCJxLV8kxiRU8KCUcGQ3a62hrjBW/W+6aqfhcfVLO1ktcfMJvuNNHXxTjvu8X0zipO+SjemTPyI5Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msAk7Vlp; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msAk7Vlp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791403691; x=1822939691;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UytSSC7WqjZa7z5mAe2gyaUgaRWwAHQ8mctH6rDRh68=;
  b=msAk7Vlpitc0+YLUE4OtUBzB7Twi0nRNF69Y+EAKMv3Bc2IPi3Lde6HA
   ZaxwE6SHoZCef+kKn9V3Zjd7BYvU/7kD96rPLDHQQQnAv2Jx18AjNhthF
   ZbZFeuekywUu8OD2+tstFqVozkLhiIzmXiXOTi0KBR+FtRkO7tIhtuppZ
   B+ICeETG1bC0YxGR62o6pJu4EC8a1pBJXBaQa9Jvdc5WPB7IO0iV/Hh2T
   QLM8l++e9eClaEzAXY0fYA9166ni5jfoh+MKWrwqb1TH7UHLk2tegNcjO
   K1ydl4oYgiSnbTuIcq74kMGRlDDTOLX5MTfYwnUKWCU5tNNMEbGnBSCJ/
   Q==;
X-CSE-ConnectionGUID: vzlN7bWwRm+BSpK/0ZjVvQ==
X-CSE-MsgGUID: 2IqqsSs6S4m0VL4qoqka8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="183650"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="183650"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 13:08:11 -0700
X-CSE-ConnectionGUID: 41+tnA5QRCid3Coxjuhlhg==
X-CSE-MsgGUID: /rEl//4rQRqBtA9GwTgJZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="285623495"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 13:08:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 13:08:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 13:08:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 13:08:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTp+3v5m0D2gE3iNd8rwzjNfIWUkm19TSIxxp6yYX9yrgMwv9e+wvLKcDhHCUiStUaVgwdhnkZQ0wP2eUTA6t9ySvcOwUujaECSgprgjYW6sCpAU3qo6jbuUaNC/FIcRftAOKM7uFcGqQz5niXvqeUE6NgOQSOe96ZL/AookIlQW3/2GJxuui68IdEDs4aFrKot+w3AhWwvwsELVlki3GusSBZyM+5rgURLRjc64xDTKuC8X27o4GbJFLdqZw7OzTSLSwvvmNC4Ol7714cDQaWnSUVIILA4ZwGJg/bVWaqtLqf7SzcM7UhRMrcECLBGIrcRsaNyP1m6U9unBDid2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22ykL1TuZN2a90ac6/djkkVdkMlDhovYkTOytN22Ew8=;
 b=TJkigdYJKoCjVsuClGA5Q6HBJaT75+xY15kt7p8d3OJEYVm3g33cl7+ZWOG8iCrb0FZM1GcYZAudE1AlYWWTly3xYAjhK9n5NbCNy14XlsDoGyBtLqESBfCd5X3GoNe4SVwlc+km6tcDzsZPsY3pdmwpPiRkuf8wsrU5pfXeQEQorQuK1pBiv+JKwbqqXtUJDeZRY0ebw656vern4z5GvNHLlqDrme7m1KQl5mmN0hHjHCUZUteuwOvLejLCXRhoqbxCnfWdHYVMmHjEqQW+QWzA69qUev3X/7uQyJ+cTocOHd0efAh2LfDhVkmPk06S6Q28/Ft4MfX8+lB7jsmwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS8SPR01MB75130.namprd11.prod.outlook.com (2603:10b6:8:447::6)
 by SJ2PR11MB7646.namprd11.prod.outlook.com (2603:10b6:a03:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 20:08:06 +0000
Received: from DS8SPR01MB75130.namprd11.prod.outlook.com
 ([fe80::20cf:2704:5868:5a54]) by DS8SPR01MB75130.namprd11.prod.outlook.com
 ([fe80::20cf:2704:5868:5a54%4]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 20:08:04 +0000
From: Gustavo Sousa <gustavo.sousa@intel.com>
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/xe3p_lpd: Reduce lowest CDCLK PLL ratio to 18
In-Reply-To: <DS4PPFE901A304FDA0B1EDB07E8603ECD24E3942@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261005-xe3p-cdclk-pll-18-v1-1-6f1652c224b4@intel.com>
 <DS4PPFE901A304FDA0B1EDB07E8603ECD24E3942@DS4PPFE901A304F.namprd11.prod.outlook.com>
Date: Wed, 7 Oct 2026 17:08:00 -0300
Message-ID: <87cxtl9sv3.fsf@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To DS8SPR01MB75130.namprd11.prod.outlook.com
 (2603:10b6:8:447::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8SPR01MB75130:EE_|SJ2PR11MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: e32c6857-0f72-4b7e-c540-08df24aeb252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 9UFoZa7cYhxXXw+NYHRTCjTkzAazPJxS3O4qOizFs1Ep/QBlfkuA0eH0vsens/UvWSN/p5lS1K2JAP78LtEV8p+EmzvBUMjIjEfUzDx7W3aHp+J/nw9mVxRd4yjC4KkRjUrlnXryTem50ujLErLar+XbdnhZnxv3r+ffjVnf+gwjRBfAvjhntFLmRBSAVMATSEBxp1JrN1MgWAF3HgINtNsVk4hZtZ9oMPnD25DLgQJd9kQr0EEePDi+lnC0LqnfCy9GCckBbXct9mGVIr9ZscoymN5Jde3k37OxBiUJvaaczstqGFC/9Z/A8YCN8jUFqzQOxDCHDml9sYNKMY3/hO6sqgqaKsacrYxFz+fpGhsDVBy1eA4VZ728u3otIGC0OIvNEwS8qdxvmLZ4rFIbnpBFvTRKmhGmA/RIDSfMs8Oas+G3UItnxDOJBOzjko3pQZPVlrv4TVwVWvV/VKl5mtLF/+shSzE3Yb9MFcpo5HbWs25h53V648LznAOsWzmxpQg/2LcmTrRLtCzDexsHTJOP2B9zMc6/lsKuqk4XfoLYlMnJThh/jLrcEcrKvR6XIRaVxsyVsenlrhSJtWuqpvuEeWI/qDLwE59CQNp0+Vde4X3yPi5aMmwNZ9d6oPMxW88QyC51WnwvNeZxv9UwKAYeCvLMc5wIN+IBzGKvJpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS8SPR01MB75130.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/LIEgAyElNLUUE4LnSC18deXUOFwvwXyZUjypxdc5NcBHy/QsYiOOxxtMq/?=
 =?us-ascii?Q?u/w7NqeuerddfDU1wqu2TEt3/rkhiFoEpDsvfShv3+iPkLTNPUznc5mREIgT?=
 =?us-ascii?Q?eRYiw4lHUI9ZsnUWKulk8rAiTFqcyoSaHpqXJD9TdrXc59rCbxWumlbCeb8c?=
 =?us-ascii?Q?3fzOpopsHIU7xssEMmyBJ6E3a6QcYQw+pXR0JDa0JoNk7tMvwjsDoqDHuglc?=
 =?us-ascii?Q?KQ8VzuaPipBhE49AHXeyQPeS8AaaKesXLx+DMoQ3HXrJNLNTlEu6Ln3IrZ2N?=
 =?us-ascii?Q?wL7aR8JE4G8lnL54oKkeBH/yuA2hJXC1pcupNSYiAZI/PC8UwCww0SJRG3/G?=
 =?us-ascii?Q?WqQPnBwui53omemCwL2xCEaaaSDcAhtAvJ041foOpvDnbJiipU3ZGTLBpNSU?=
 =?us-ascii?Q?OYQCoYuOn/TrtTZI19ptD64cOFt6cUiP/tDbML6elN3Kiug16+aD30MTLyOf?=
 =?us-ascii?Q?RWe/ScC9mnAL9B5K79e4opmLyYFczXHiUg4wyP6mcHVkhQDfTLs5kEurF4Es?=
 =?us-ascii?Q?ckoJxgqhzcDef220iWDrtHw36F0jYwfH/7XGir9MNBxY0zbpeUDvkHxmz6At?=
 =?us-ascii?Q?XdFrBDczbZoZaAag03vNavLq4zFDTpvcj4O8Pe9Xm7XgUw/IDe1PSSnTgILM?=
 =?us-ascii?Q?77oeJyt4MqQEPdC4WHcD82kGj2Zl+xLL/3EWZ2/jsNe//SkGzLknmVDDPPsN?=
 =?us-ascii?Q?h58dX4gfh5YcaWrWEWWn+8JSRB93K0SUWnx3JItwR9Dy/KbsCK5g8miunXaw?=
 =?us-ascii?Q?xQO/fUfgycNZkz1nSiBwKds6xC5C34+MjoFVsWLZJoXPp9DPubbFqhKgfjn6?=
 =?us-ascii?Q?PlGtaYS+xGuFRuPzh3Zu92blmioEj7+14pdFjI9JtWA9uXxmLYjmqHFFdhy5?=
 =?us-ascii?Q?ip0m9IIaYD4qRKmcwU/obGW89jS9EzycHevY7OAw91Dx4bJlyr4XNlcpzg70?=
 =?us-ascii?Q?r6mqstukATix9VWkK0Vrym+7THjfTC5U5QHr5zoJc3mYGkfU17GcWa7FxLpB?=
 =?us-ascii?Q?LrP2qkEKNGk8baPDBnFSqBkRITpIfnJ5B8jktaEeUKzU+GWUgqLATyWi1M9g?=
 =?us-ascii?Q?+gILlfk5L+whvDmNSdkdAbrt9UJYARjc2/kv9WNHsCNfX7e9kdMFaZc0Nt/K?=
 =?us-ascii?Q?1BMqq5BxAjwRVyEhRgiI7VpK8ecQXuLciCCV+lLDG1faPqqCC0Az4Uaj5l3T?=
 =?us-ascii?Q?qtQ3y0goaRZvHWxom86z8WIiVFehhLHGrTOtfbDyuy5GV5Tqfl0cFvx1oEmM?=
 =?us-ascii?Q?VtysomhwwfXTDNss+54fb08BmvqXu7f3UzZqWg1AXFfa3tzP6DmnVhlWeWYH?=
 =?us-ascii?Q?RU0KM6QlIgBBdTVcdlqRQwvTIJ78LRa1r/29qvKSxT9rU8/37/zeWPqvUF5f?=
 =?us-ascii?Q?8xmCEbqLkb51UtR3toWsr7ih6B1vk+W5W/ar6hcSKWV89oJoqcL5L8Xx8/UK?=
 =?us-ascii?Q?dZFQ5A8hbn+2gz/uVpu+lsOnRFvyHX2eNXx4LNFP2yHHG2QtbdVMzuBkApj6?=
 =?us-ascii?Q?evVCzW6oHrT/yZoxrjfVDZ3CFcVs33FJmXwrDPIiVqmqQ7102xUtU7W/HdqZ?=
 =?us-ascii?Q?qIKLZ2Ekgdj9YaQjbHQewjBb/BJZKu390+eIRYXOVb1JC/xvHK3DNdRnPvaD?=
 =?us-ascii?Q?IB6XaFrDm7CWd80Hk9rmjln199504hBSAGP9YzA6pwh3p13LVyhTKhnU/4f1?=
 =?us-ascii?Q?5v+TkC4/2X4xKgH+0HLJOt78xMH9JCJ/O0LIYxuZ/inmadByztX1fw6m6W/K?=
 =?us-ascii?Q?9F57POomwQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: xmQEFB7sRUCFYDVzdMvGEz5+Nh4cTnXtYdd3c8gFA9WCCHoJAoOPv8lTZ8k/XFHSABvq9/26EFxumBUPa8CYLVRjVSqrK82QbvQqJYQkfR66pdbJpr4MoNFAjLt7+N2id5GvtuG1uVc2DFshMp2nSErSGqexpqYGK1v9RMNnTUMd7IV5ucJuiQWS0+iIpqGh1ZZIQIhRo8HHiMGang3djpPRijLETrOWXGVVRGF5esMQDGBKxqWBnNSUHzFP0f2LTfgYCNEw06XbnCwVe7mhuokwSxzZ/m88viwxvc1yc9AP11df3KZOMBc+5kopwXs3E/lq9qGR4FWg0VStZ8qfnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e32c6857-0f72-4b7e-c540-08df24aeb252
X-MS-Exchange-CrossTenant-AuthSource: DS8SPR01MB75130.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 20:08:04.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nxavtlje1OVXkc64Ek7kNTKZCiZ/b5C26wtiGEMEF1IvwiT4GzLj0tKokerfBokLd7yRrZ8fgoFGbE3AkbWxOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
X-OriginatorOrg: intel.com

"Kandpal, Suraj" <suraj.kandpal@intel.com> writes:

>> Subject: [PATCH] drm/i915/xe3p_lpd: Reduce lowest CDCLK PLL ratio to 18
>> 
>> The CDCLK table has been updated on Bspec to reduce the lowest PLL ratio to
>> 18 and improve voltage selection in some SKUs.  Update the driver to match
>> the new table.
>> 
>> Bspec: 68861
>> Fixes: af28e607fc75 ("drm/i915/xe3p_lpd: Add CDCLK table")
>> Cc: stable@vger.kernel.org # v6.19+
>> Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
>
> LGTM,
> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

Thanks for the review, Suraj!

I saw a FIFO underrun on a NVL-P machine with this change, so I'm
holding off applying this for now.

The reduction of the PLL ratio implies in reduction of the MDCLK ratio,
which impacts DBUF fill times. So the FIFO underrun could be related here.

I'll check with the HW team.

--
Gustavo Sousa

>
>> ---
>>  drivers/gpu/drm/i915/display/intel_cdclk.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c
>> b/drivers/gpu/drm/i915/display/intel_cdclk.c
>> index 92e6fca861f6..dad5fbeaa1bd 100644
>> --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
>> +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
>> @@ -1593,16 +1593,18 @@ static const struct intel_cdclk_vals
>> xe3lpd_cdclk_table[] = {  };
>> 
>>  static const struct intel_cdclk_vals xe3p_lpd_cdclk_table[] = {
>> -	{ .refclk = 38400, .cdclk = 151200, .ratio = 21, .waveform = 0xa4a4 },
>> -	{ .refclk = 38400, .cdclk = 176400, .ratio = 21, .waveform = 0xaa54 },
>> -	{ .refclk = 38400, .cdclk = 201600, .ratio = 21, .waveform = 0xaaaa },
>> -	{ .refclk = 38400, .cdclk = 226800, .ratio = 21, .waveform = 0xad5a },
>> -	{ .refclk = 38400, .cdclk = 252000, .ratio = 21, .waveform = 0xb6b6 },
>> -	{ .refclk = 38400, .cdclk = 277200, .ratio = 21, .waveform = 0xdbb6 },
>> -	{ .refclk = 38400, .cdclk = 302400, .ratio = 21, .waveform = 0xeeee },
>> -	{ .refclk = 38400, .cdclk = 327600, .ratio = 21, .waveform = 0xf7de },
>> -	{ .refclk = 38400, .cdclk = 352800, .ratio = 21, .waveform = 0xfefe },
>> -	{ .refclk = 38400, .cdclk = 378000, .ratio = 21, .waveform = 0xfffe },
>> +	{ .refclk = 38400, .cdclk = 151200, .ratio = 18, .waveform = 0xa54a },
>> +	{ .refclk = 38400, .cdclk = 172800, .ratio = 18, .waveform = 0xaaaa },
>> +	{ .refclk = 38400, .cdclk = 194400, .ratio = 18, .waveform = 0xad5a },
>> +	{ .refclk = 38400, .cdclk = 216000, .ratio = 18, .waveform = 0xb6b6 },
>> +	{ .refclk = 38400, .cdclk = 237600, .ratio = 18, .waveform = 0xdbb6 },
>> +	{ .refclk = 38400, .cdclk = 259200, .ratio = 18, .waveform = 0xeeee },
>> +	{ .refclk = 38400, .cdclk = 280800, .ratio = 18, .waveform = 0xf7de },
>> +	{ .refclk = 38400, .cdclk = 302400, .ratio = 18, .waveform = 0xfefe },
>> +	{ .refclk = 38400, .cdclk = 324000, .ratio = 18, .waveform = 0xfffe },
>> +	{ .refclk = 38400, .cdclk = 345600, .ratio = 18, .waveform = 0xffff },
>> +	{ .refclk = 38400, .cdclk = 364800, .ratio = 19, .waveform = 0xffff },
>> +	{ .refclk = 38400, .cdclk = 384000, .ratio = 20, .waveform = 0xffff },
>>  	{ .refclk = 38400, .cdclk = 403200, .ratio = 21, .waveform = 0xffff },
>>  	{ .refclk = 38400, .cdclk = 422400, .ratio = 22, .waveform = 0xffff },
>>  	{ .refclk = 38400, .cdclk = 441600, .ratio = 23, .waveform = 0xffff },
>> 
>> ---
>> base-commit: 28a2edb89a25a41d2a45e27d74dfd946872d0faf
>> change-id: 20261002-xe3p-cdclk-pll-18-59bd79cb5b4b
>> 
>> Best regards,
>> --
>> Gustavo Sousa <gustavo.sousa@intel.com>
