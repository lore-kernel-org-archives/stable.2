Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1786C1A6803;
	Wed, 14 Oct 2026 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941241; cv=none; b=iaGAXF0ZjGHqdOOe/0zwrjw/1afepg5hzzM5tMdddxvyn/kRDmVK9L9tUsL/O1NZvnYWg8vc+HsO7TEsy2jui4iORwCKz9wOZgOvBHKaoNs83owhf0A8pP2br62Stnx3bUD4FA1NJN+Kp7dde5PP0iE73N/WrOm9Dqrd9cfbLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941241; c=relaxed/simple;
	bh=9kyd9TG66jEb5Vsz4TbVGNRzpSj284I6I9Cl7pf+Lg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qC6tpITVZ4n6Oo07nK2rLVxXn93V7c7Hij0ovQPcu05w2cXzY7eV4tTUPwwZIT++r6WjNWMhjHHybGgAde33LZvy4m+qOsQ5Qtk/CWtmmLHm4YejT3bYfZaCfJ+H+wyiHBkB7gqkZ0uYAbYg2thnNT/iw5yK3Nv3yhV2CPWEOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJ2/iOou; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJ2/iOou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791941240; x=1823477240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9kyd9TG66jEb5Vsz4TbVGNRzpSj284I6I9Cl7pf+Lg4=;
  b=ZJ2/iOouLfYL5gUVU3vOwBJCaqfrYj+APc4qqNVGz0bnW1XaYPR3zRYi
   +1QmfpfHw/Ajzy2bdaIn/cbQbks2UNz/2xzbFCd/Y72YYONbv8BISpE0c
   YGJwEJupe6Zq5hi+LVKsl8qJx5dHyiTStK4BzdT1ghduttdUMJOep/xfr
   tbzMUxA6sCs3xWzopH9ynKKQEw5OxbsGxoVyjhYj1ZdpoBty2rvdXHpPf
   SpE0anSteM/kQ8/ZOzS4Gs+9zVv6OKa2yDZqKwRnVg8DZmcuKlfH5aIi5
   tyRYdttGj9qHDxqyCdk7Y6ZAhgm9ozcLt8UebzcDood3jBJCoV6uHW5C1
   A==;
X-CSE-ConnectionGUID: m6Co8WyaTViAzs8LpE4WRg==
X-CSE-MsgGUID: 3imaHwiQTOqMtbCUY00M/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="685490"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="685490"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 18:27:19 -0700
X-CSE-ConnectionGUID: wUjCBKQ0SJ+ra83MoISo5g==
X-CSE-MsgGUID: KXw7C3VFSDOqhM9Aqt9UgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1268054"
Received: from unknown (HELO [10.238.4.83]) ([10.238.4.83])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 18:27:15 -0700
Message-ID: <56ce8365-0a31-4496-be5d-fc867cbe15da@linux.intel.com>
Date: Wed, 14 Oct 2026 09:27:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Add Granite Rapids CMS PMU support
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 stable@vger.kernel.org
References: <20261013194005.96615-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261013194005.96615-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 10/14/2026 3:40 AM, Zide Chen wrote:
> Add support for the CMS (Common Mesh Stop) uncore PMON unit, shared by
> GNR, SRF, GRR, and CWF. One CMS box exists per CHA box, at a fixed MSR
> address: 0x3400 + 0x10 * unit_no + <reg offset>.
>
> CMS is not enumerated in the discovery table, so it is added as an
> extra MSR uncore type instead of going through the normal gnr_uncores[]
> array. Since the CMS unit numbering matches the CHA unit numbering,
> build the CMS box rb-tree by mirroring the discovered CHA (die, id)
> pairs, ensuring CMS boxes only appear where a corresponding CHA exists.
>
> Make generic_uncore_msr_ops global so the CMS type can reuse it.
> Opportunistically add the intel_ prefix to match the naming convention.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore_discovery.c |  4 +-
>  arch/x86/events/intel/uncore_discovery.h |  1 +
>  arch/x86/events/intel/uncore_snbep.c     | 81 +++++++++++++++++++++++-
>  3 files changed, 82 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 0a22edf4d509..170f299385a0 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -532,7 +532,7 @@ static void intel_generic_uncore_msr_disable_event(struct intel_uncore_box *box,
>  	wrmsrq(hwc->config_base, 0);
>  }
>  
> -static struct intel_uncore_ops generic_uncore_msr_ops = {
> +struct intel_uncore_ops intel_generic_uncore_msr_ops = {
>  	.init_box		= intel_generic_uncore_msr_init_box,
>  	.disable_box		= intel_generic_uncore_msr_disable_box,
>  	.enable_box		= intel_generic_uncore_msr_enable_box,
> @@ -743,7 +743,7 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
>  
>  	switch (type_id) {
>  	case UNCORE_ACCESS_MSR:
> -		uncore->ops = &generic_uncore_msr_ops;
> +		uncore->ops = &intel_generic_uncore_msr_ops;
>  		break;
>  	case UNCORE_ACCESS_PCI:
>  		uncore->ops = &generic_uncore_pci_ops;
> diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
> index 142e1b56cfc2..cececf6ecdc5 100644
> --- a/arch/x86/events/intel/uncore_discovery.h
> +++ b/arch/x86/events/intel/uncore_discovery.h
> @@ -151,6 +151,7 @@ void intel_uncore_generic_uncore_mmio_init(void);
>  int intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
>  void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box);
>  void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box);
> +extern struct intel_uncore_ops intel_generic_uncore_msr_ops;
>  
>  int intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box);
>  void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box);
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index a97cd029db36..3abbc1bbf577 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6492,6 +6492,32 @@ int gnr_uncore_units_ignore[] = {
>  	UNCORE_IGNORE_END
>  };
>  
> +/*
> + * One CMS box exists per CHA box, at a fixed MSR address:
> + * 0x3400 + 0x10 * unit_no + <reg offset>.
> + */
> +#define GNR_CMS_MSR_PMON_BOX_CTL	0x3400
> +#define GNR_CMS_MSR_PMON_CTL0		0x02
> +#define GNR_CMS_MSR_PMON_CTR0		0x08
> +#define GNR_CMS_MSR_OFFSET		0x10
> +/* Type ID for CMS */
> +#define UNCORE_GNR_CMS			50
> +
> +static struct intel_uncore_type gnr_uncore_cms = {
> +	/* Keep the PMU name aligned with the published CHACMS event list. */
> +	.name			= "chacms",
> +	.type_id		= UNCORE_GNR_CMS,
> +	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
> +	.num_counters		= 4,
> +	.perf_ctr_bits		= 48,
> +	.event_ctl		= GNR_CMS_MSR_PMON_CTL0,
> +	.perf_ctr		= GNR_CMS_MSR_PMON_CTR0,
> +	.ops			= &intel_generic_uncore_msr_ops,
> +	.format_group		= &snbep_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +	.cleanup_extra_boxes	= spr_extra_boxes_cleanup,
> +};
> +
>  static struct intel_uncore_type gnr_uncore_ubox = {
>  	.name			= "ubox",
>  	.attr_update		= uncore_alias_groups,
> @@ -6595,15 +6621,66 @@ static struct freerunning_counters gnr_iio_freerunning[] = {
>  	[SPR_IIO_MSR_BW_OUT]	= { 0x2e0e, 0x10, 0x80, 8, 48 },
>  };
>  
> +/*
> + * Neither the free-running IIO counters nor CMS are covered by the
> + * discovery table, so both are added as "extra" MSR uncore types, in
> + * addition to the ones enumerated in gnr_uncores[].
> + */
> +#define UNCORE_GNR_MSR_EXTRA_UNCORES	2
> +
> +static struct intel_uncore_type *gnr_msr_uncores[UNCORE_GNR_MSR_EXTRA_UNCORES] = {
> +	&spr_uncore_iio_free_running,
> +	&gnr_uncore_cms,
> +};
> +
> +/* Build the CMS boxes rb-tree by mirroring CHA's discovered boxes. */
> +static void gnr_uncore_cms_init_boxes(struct intel_uncore_type **uncores)
> +{
> +	struct intel_uncore_discovery_unit *cha_unit, *cms_unit;
> +	struct intel_uncore_type *cha;
> +	struct rb_root *root;
> +	struct rb_node *node;
> +	u16 num_units = 0;
> +
> +	cha = uncore_find_type_by_id(uncores, UNCORE_SPR_CHA);
> +	if (!cha || !cha->boxes)
> +		return;
> +
> +	root = kzalloc_obj(*root);
> +	if (!root)
> +		return;
> +	*root = RB_ROOT;
> +
> +	for (node = rb_first(cha->boxes); node; node = rb_next(node)) {
> +		cha_unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
> +
> +		cms_unit = kzalloc_obj(*cms_unit);
> +		if (!cms_unit)
> +			break;
> +
> +		cms_unit->id   = cha_unit->id;
> +		cms_unit->die  = cha_unit->die;
> +		cms_unit->addr = GNR_CMS_MSR_PMON_BOX_CTL +
> +				 cha_unit->id * GNR_CMS_MSR_OFFSET;
> +
> +		uncore_find_add_unit(cms_unit, root, &num_units);
> +	}
> +
> +	gnr_uncore_cms.boxes = root;
> +	gnr_uncore_cms.num_boxes = num_units;
> +}
> +
>  void gnr_uncore_cpu_init(void)
>  {
>  	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
> -						UNCORE_SPR_MSR_EXTRA_UNCORES,
> -						spr_msr_uncores,
> +						UNCORE_GNR_MSR_EXTRA_UNCORES,
> +						gnr_msr_uncores,
>  						UNCORE_GNR_NUM_UNCORE_TYPES,
>  						gnr_uncores);
>  	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
>  	spr_uncore_iio_free_running.freerunning = gnr_iio_freerunning;
> +
> +	gnr_uncore_cms_init_boxes(uncore_msr_uncores);
>  }
>  
>  int gnr_uncore_pci_init(void)
