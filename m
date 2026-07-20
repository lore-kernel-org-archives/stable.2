Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D0332EBC
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546262; cv=fail; b=bFaaeKxPf7f6bE1/ILTIr90DDn1tNBVl8IYhjVmZ7VfgAmc8UnLRH5tA0CnVYApInJeoUR9l8SGhsjDrgrim7Z84XcRWeegycjSWIPedZwzMjcA8p+9UvPfIvYANvj8qtgVsIGlrZ8XScOWc5Bn0Gnbl4pDZ3wajuhzGDWAvgDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546262; c=relaxed/simple;
	bh=ymzv55Uvqn/8K01D+8RwTuzSxSFgKzH966soHXS7DVk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dBLngnEi0ItSr/GeqbYVbQxs5Vf+G65tdWqb7Eo9PtazyhXpoTtEbC5fNfIO4EA013oEjZByJz9u3nWi3T68ilkPxz5L2O6NstodOszDClOQuLrAe1MuGOEo83IdYbQhl9t9Pe+TOpR9A7+YbEKracnjWx30Ss/LwDXHn5fBtSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUrD8WN2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUrD8WN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784546261; x=1816082261;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ymzv55Uvqn/8K01D+8RwTuzSxSFgKzH966soHXS7DVk=;
  b=EUrD8WN2t+y4dHZ9ZO16K7kvQPk+DnA6UkeTbK5qb3G88WaTa3btpHO4
   tbqAcK5GbRAM+Np2zNgpAIE7ixfGmeYeCZqirAd2lrCXgd1y4MbBkaNp8
   e//zR/73Zku0Ovl3+drEKGJHIzXp5j9lW6uyysrUdBWF6sq1pZI5c3Do6
   RMqkmzGK3GRPMFp7TDLqTC5qza1EgEl62EenCI2FctvUm72xqCF5ILuxW
   lO1i5UF9DFO40Y0pDK2M7NC/tTqyd93o8YhkuBfBX/X8x6pQm/bodeH6v
   3K2k6Z/jGqSYh20gRl7PPaqdDEsJVpbYlZDKVerYaUa1DmF9j5y9j25wM
   A==;
X-CSE-ConnectionGUID: UA9IGUnnRRGqDR/bBALgaA==
X-CSE-MsgGUID: 3WLcPse1Qc27+Yu5MkuEqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85219280"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85219280"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:17:40 -0700
X-CSE-ConnectionGUID: 6Mq5rEdLTsKBkFhjERD9vA==
X-CSE-MsgGUID: pTnXvWQoT86T9i4wmSZYHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="260995563"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:17:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 04:17:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 04:17:39 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 04:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgBmlhVLy+HcfyI/z/LY89uImaAvfkSab+lN452a/KpGiIjulked6m9yIjm+IO6VO/eiRv0QBFCRwhYI99kUqmDHmo6/VdA6gE2FOYwQC/bKKef/bsSgkmxmiPeIUTgqF9xcOqUgS7fdD3KL/Crdkg2wEKBHtLk4sPEOi76U8LDpXyWgi3M2pwN8gmlSIQmZYb37mcRSwXLAeEV7JLyN2qIVMXQ8GbFMEdu53OSrEh3IXo+LVenquxDqRz9oIXJGAgwIl4u75HkZ85mEvTyeViGgWp6vpUoqwXHd0JuXc4GPHKHmkJ0jEx9LmGvUTsPPC6uM3MUUSiEcZcbcNgcxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVFs6+Ap2gZMKXE+8kYWyWoY3eW3tOcFG/4wR5po2s4=;
 b=eBSgswgAXpHwRaZk+ZK0QKjDj0Oda6SybQnbqiWseA89yK9sAQImasd6e6z1+t01lzAZZ6LhXWIPrubZveoG7Hf+yfKq6TAdmoS/MBWi8NvX8SZ1tI/g5zdbGGnRfoFS43F1llntmkC1Mqbpq6+bxd4cfFZASaAkivrPq3tqSqZRptpMaog/MJRg2zoUU0SJcl6vlwYtM28gCvWhQkm5N/UAmiqeHplFg3JWakadOjbZUaYtbvjAgUia0vzw0I4JDhNsySpPFI7YSN8v0qEGa+BMwGxCeJg+3Z6av4qdIIStysUMm7Ce8OpE8OXP/c1kKAtfj+QVWY+TwRGGWdiMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by SA3PR11MB7463.namprd11.prod.outlook.com (2603:10b6:806:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 11:17:36 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 11:17:36 +0000
Date: Mon, 20 Jul 2026 07:17:32 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, "Joonas
 Lahtinen" <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
	<tursulin@ursulin.net>
Subject: Re: [PATCH 1/2] drm/i915/cdclk: Avoid spurious cdclk sanitization on
 PTL+
Message-ID: <al4DzP08EqoW8enK@intel.com>
References: <20260717155107.17801-1-ville.syrjala@linux.intel.com>
 <alpSxjjmv34zKW2p@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpSxjjmv34zKW2p@intel.com>
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|SA3PR11MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 072838e1-2eb6-49b3-5714-08dee6508075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GPxd3OQIJbkzDWAJ3jcSRO4bcIx4MR6piqb/qEMwIjfNciidqEVRjnzNs6ceL1X97SUaSbZQKGF4HDROxbOzHuHP7kLDbX526Rk2r5+sn34CZ1xiqNijoQOpPXyo0koufJW6eXgR0/QnzDeo6HjZy0JPSS+PjONcsmiN46AFPdvjgB6fospiAhxuV60oarqR4UogPLW9PhWFwYLPepdPs6++Qm2dAz0rEcq4L25cxRx3bCLVK6wTmICs79i7bBpDvN296o97zgDTu7WfCfFDwdM4bhGeiUg5fPRxm2bcF+nSLE6A4EcnGY07ELVFASHa9cCVZYVDZBtGTNI8QcLmyiAtZN7XntVPmsqjR8s2KDPeBt++jTx1du80w4IgDLyp0pBqGvxdYYsyusQIWd8CkFJ6rZnehVHOrvaY2o1m3IKsAxpVqwijrxasBsm1thdMjcMhIdKIkKeyxRGYeW9uJDmIh1Nar28qmzRoFWBKa5kPXhK9rU9oAg4ZjOhlUdv0VY3hZluphusR/MfQRmIEcK7ei0oR8iq7DJGjKVUHRvFMoTqxoEiEM3uY5HZc8oK30bYUEbAYzH1GBM4NDN4pXxwGg0W+v1QL4FbR88/oHKbgwACQ/0J2ord+lw8r8PSD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5073.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?x4jjyR5sRi3cNqoxFtlYZ0CqpPC5xznVI64j4+CGW3ThCGJ/9tW2BICrxx?=
 =?iso-8859-1?Q?zca4WV0DcaztI+XUKUonzchlwjHl3pxasaSrSemNOxmVOCckpF2iZ5uaSk?=
 =?iso-8859-1?Q?IQfWc6MeKcTQtUGgY6njfErxD6wsqfJjdVn1y4XLOo7vFr0/u4FmVujvdv?=
 =?iso-8859-1?Q?Aldfo8XJQB03P8bE5fY4vt1vg5MX/jbuHzFvWyKjl8dRMtdjIY/XBubAeu?=
 =?iso-8859-1?Q?3ZAR4+u5qZTyMo+7OLtm44WuTSqucyQB3j6EpU6gCDNyj7lpzmksa/OXce?=
 =?iso-8859-1?Q?7MBXOkn+2jJCV/lQGx4wVzGsRjcS4DR/OBrgVvo1Opg/Nxsuuc9fgmK/Z3?=
 =?iso-8859-1?Q?YXGM42JTdueSfOo0lqlVs1ZAGsf40eISCRHl1DeITMLJ0W/5p92ZBLVXKN?=
 =?iso-8859-1?Q?XbPScrJhZh8gMBs0f65uRuyFCIotlcYrD5BDFYconqE2yuXg5SzYgvlSof?=
 =?iso-8859-1?Q?XtHbYrGv4eWfMtFxpSfPagYm+aPaGJsh6UhgUVgkTgCTClfIjeM7OPqcWp?=
 =?iso-8859-1?Q?AKNOwDIYKyh+0PG0V4a6HUAyE7HSB8ewcKAIFl0qXQrgIeyeymE2C8O1nm?=
 =?iso-8859-1?Q?FqRzDmDiDyWwuTT+2ClshtZF0xQ+XQj0Kqwsmv+aa/JCByjsNCFUREnxsS?=
 =?iso-8859-1?Q?yRAAdju5vJ7qWW0BsM5V3oXS4MYrPE257gv+s0vokN9+AqhmILlmsDjrGD?=
 =?iso-8859-1?Q?GbY/JcASTENeCmVqhV3knGpdjd+pscTha99HRl3h+9+r3HtZOPBnvzlXQu?=
 =?iso-8859-1?Q?wU3nZMnohW6G3w+ADTa2573kKgcmMVwYjCehIOxwaayqa5F0kGUeDPp58u?=
 =?iso-8859-1?Q?UuvxENYyR/dJ2vS7GWRI2z/8Eb64Y5aNsuvhgjBvWvB0C0cWOw0GQA8oc/?=
 =?iso-8859-1?Q?+lxIT1dnEeyytFZf5EYc+pqUKiCdnVa5FLHr2HXjhwajGoTkQF296DS1rm?=
 =?iso-8859-1?Q?tAtLUKz0qbOXsznZWUSETcT8loHzRHck58DDWcgDG7uNft9IiYsO2B5F73?=
 =?iso-8859-1?Q?qJr1ZJWMO6YUMY7LVceYG6qqSsCCtJxm88uQcSP6hKQmw5g9qbHeD9bJ2b?=
 =?iso-8859-1?Q?UOR99OFA7YP4bdf/NQdEPi8IB7OOike0mISVZ6l8o7HcIKJxjSiLB9oMmb?=
 =?iso-8859-1?Q?HDQwZcS+4fJsTNvxrrI8m6ArLH3FxfVk4df/MU46ExVSI8JfC3/L6g8uf5?=
 =?iso-8859-1?Q?8qiXB6ARAMr0o0C0rd7DG4argSOsw2FAUOt8j82ahYNkeXUuUUYysBTzfY?=
 =?iso-8859-1?Q?6upV627rJHTOXgqzCDnavQDPvv5092Hk3Ak+Vq6FEXH68vPa2So/ue5eAK?=
 =?iso-8859-1?Q?OscolXbSeOHKZGBFIl2q3SdF1eNDQhycES7E/L2P/zB88i0IkgE4+Kx5Lq?=
 =?iso-8859-1?Q?seXeAkT+vjcEWETgeZs+7frrf40q4Mx9lU3P/vDgzPzxIjAiyVVsoIVNXz?=
 =?iso-8859-1?Q?v0WS705qgmEdVUkmVq/j+jVhdDr3JIR47bdSjIbdLiwHYtbblp3+Hcyhnv?=
 =?iso-8859-1?Q?9gGbf6/XnqyJbVdhoWQxavTW7Am4VFux9k+RaqlSQ1DVdI6m48N4xG6eCR?=
 =?iso-8859-1?Q?25lYg+ArNtQOLErXY2EPkEFvKQ206rBtPbzVd3pKJyy/2dFtHZRamo8TMu?=
 =?iso-8859-1?Q?pvTG6ayCvjP5Wa9cj5O3QiQlsm0WfKW57QYZg1/4BdAIg+BNgQrpQYfjyz?=
 =?iso-8859-1?Q?0DEEDv6Mxwb7bbTpVzAd7i/SlpUxlTzr8pYiLeVh4Y/gvwGmHXnUk+U/ik?=
 =?iso-8859-1?Q?g0FFTRwVJD/sS+Fb4MspU9njNq9GILrBpZwSkbkHulDZC13qH+9Fz2OW8p?=
 =?iso-8859-1?Q?MQebZLdWtw=3D=3D?=
X-Exchange-RoutingPolicyChecked: aNH9yeyycxuN5cbZQQJKa+IF2vrZc3p4BQbKqIbB5RZ+7gbnhk0c2myXihaD7xbYpOFzF+YM37TEWD8SMJaW6SEjBSsTx590QZiyvSRg5FoA4GuaTgmv22T2ZfdmbyJBbVypItOGU3sMRFN0qPxefSjihiZ8Er1OYBC+bVZvb4FhDajmoQcLuEAFfBErf5/enOGbcJjwZw/zsQsZoD+V2gtfgWIl9q6SDOqGU/siRhcBstOnFI7OJbfiGLfx9iKjb5hdPC4ZeOpSIpbwQIJphkEC4Kg99HmFsPuFEkWAO6MvRijCWStXU6uPQyWKsMaGRw0bg+8dpNzl1T0GGI765w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 072838e1-2eb6-49b3-5714-08dee6508075
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 11:17:36.4575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUGIWx2Nq9U2agkbQDd85blCHv1QumenwjXqSmWY0Rn6fV1hLCcqPjs44Dn5n3yVSkp8ZGEEhzkNAAIndXLYDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7463
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 07:05:26PM +0300, Ville Syrjälä wrote:
> On Fri, Jul 17, 2026 at 06:51:06PM +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > Apparently PTL+ no longer has the cd2x pipe select field in
> > CDCLK_CTL. Take that into account during CDCLK sanitization.
> > 
> > This currently triggers a spurious CDCLK sanitization during
> > driver load on PTL+ which will causes a visible glitch on all
> > active displays.
> > 
> > Cc: stable@vger.kernel.org
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
> > Fixes: 3f9de66f8acb ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> 
> Unfortunately the regression itself has a cc:stable on it, so we'll

it has a fixes tag, not a cc:stable itself, but yeah, that is enough to
reach the stable backports indeed...

> need to backport this fix as well.
> 
> To do that cleanly we need to pick up these as well:
> commit cd16e794aead ("drm/i915/cdclk: Clean up CDCLK_CTL defines")

you meant
commit aa8faabadc59 ("drm/i915/cdclk: Clean up CDCLK_CTL defines")
right?

> commit 67d77d9472c6 ("drm/i915/cdclk: Introduce bxt_cdclk_cd2x_pipe_mask() and use it")

I can pick these for the -fixes round, but for the stable we need to remember
to tell Greg and Sasha whenever we get their automated email saying that the
patch has failed to apply...

> 
> >  drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
> > index a53d88727177..9e5e15b0c4d1 100644
> > --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
> > +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
> > @@ -2381,8 +2381,10 @@ static void bxt_sanitize_cdclk(struct intel_display *display)
> >  	 * dividers both syncing to an active pipe, or asynchronously
> >  	 * (PIPE_NONE).
> >  	 */
> > -	cdctl &= ~bxt_cdclk_cd2x_pipe_mask(display);
> > -	cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> > +	if (DISPLAY_VER(display) < 30) {
> > +		cdctl &= ~bxt_cdclk_cd2x_pipe_mask(display);
> > +		cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> > +	}
> >  
> >  	if (cdctl != expected) {
> >  		if (DISPLAY_VER(display) < 20) {
> > -- 
> > 2.54.0
> 
> -- 
> Ville Syrjälä
> Intel
