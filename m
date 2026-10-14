Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3853A89D;
	Wed, 14 Oct 2026 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990845; cv=none; b=mW84aG+2MGoSzRMrlT0uP2xEQC4Mad6urcvXdbN1kNG00EyJjd61DnYBnXMNwkIoR9KcUZ7klUzctgtkqDZbgeHM+AjOZhH1BwHack0bhQcDVrnhsMpkUg7Vzr/U49G/jrqJ66J2oGSMLM5+qaFsMFj2KLL2RKY0JHiEZL89Lq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990845; c=relaxed/simple;
	bh=mdC+AI4xc6v7qVKDVekmAbHa8khtyfjg/Ml/cCNxURY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBjjx4ozNc998fr1gXOSfLYRiozN73AcnSi3mHS5/ItWoZDDpJyevu7OsgUwm4/EurEYrXECbSXvsXEjYDHETFsVh88WuhkiONxNt4FeAlNJZvQWCHzGYBCiP+/BeMaaWwa844cMM37VQrqD/RQ7Yu/vYGr+5KXP81blAdjMM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmFGk/Pd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmFGk/Pd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791990844; x=1823526844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mdC+AI4xc6v7qVKDVekmAbHa8khtyfjg/Ml/cCNxURY=;
  b=nmFGk/PdtwBXMIOCJusDEYxl2tTK6x9qk/VEMBni9WdO0EZhSp1uI0z4
   9e4zgkCxUrSKt7LBv/y/lZjIk9P61M22LDh2q6bx4YO7LYESDe6n2q64L
   r7+R32j956RydD56JT36TYdMK+of7ug+jcHTEO40yIN4kSsooKJ4r4k0V
   5BfGV1oUSbQ8LTF7gnaAlE7bY3hGz9ZkpOfecwbmsIAj0EpYs1/ZXjRpr
   KSE0g7jkAwblUUnQnB+xsVYmVXfDWY9djsPIqfOZQYvgxph8D6GC7UgCK
   4i/kF+QJRBu9WBizYz/toj0ye84fIjIQRWoAHV4cGBNtYoZU3lCIl87g5
   g==;
X-CSE-ConnectionGUID: vSNWBxAeS+meY/p5H9N6Ag==
X-CSE-MsgGUID: CFGKMGitTFy2exmojLSHiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="627911"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="627911"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 08:14:01 -0700
X-CSE-ConnectionGUID: waKF2GCKSE2ePofjgszMSQ==
X-CSE-MsgGUID: jGGt3m76S9KrwmaUKFzbaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1896868"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 08:13:59 -0700
Message-ID: <1d730421-e94f-43b0-8de5-1f875d11b8b8@intel.com>
Date: Wed, 14 Oct 2026 10:13:58 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Add Granite Rapids CMS PMU support
To: Stephane Eranian <eranian@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, stable@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20261013194005.96615-1-zide.chen@intel.com>
 <CABPqkBSn57PLhdZj1syvMTF_LG7NgitKC3xbLMF7vqyK-vyA4w@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CABPqkBSn57PLhdZj1syvMTF_LG7NgitKC3xbLMF7vqyK-vyA4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/13/2026 6:47 PM, Stephane Eranian wrote:
> On Tue, Oct 13, 2026 at 12:50 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> Add support for the CMS (Common Mesh Stop) uncore PMON unit, shared by
>> GNR, SRF, GRR, and CWF. One CMS box exists per CHA box, at a fixed MSR
>> address: 0x3400 + 0x10 * unit_no + <reg offset>.
>>
>> CMS is not enumerated in the discovery table, so it is added as an
>> extra MSR uncore type instead of going through the normal gnr_uncores[]
>> array. Since the CMS unit numbering matches the CHA unit numbering,
>> build the CMS box rb-tree by mirroring the discovered CHA (die, id)
>> pairs, ensuring CMS boxes only appear where a corresponding CHA exists.
>>
>> Make generic_uncore_msr_ops global so the CMS type can reuse it.
>> Opportunistically add the intel_ prefix to match the naming convention.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/events/intel/uncore_discovery.c |  4 +-
>>  arch/x86/events/intel/uncore_discovery.h |  1 +
>>  arch/x86/events/intel/uncore_snbep.c     | 81 +++++++++++++++++++++++-
>>  3 files changed, 82 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>> index 0a22edf4d509..170f299385a0 100644
>> --- a/arch/x86/events/intel/uncore_discovery.c
>> +++ b/arch/x86/events/intel/uncore_discovery.c
>> @@ -532,7 +532,7 @@ static void intel_generic_uncore_msr_disable_event(struct intel_uncore_box *box,
>>         wrmsrq(hwc->config_base, 0);
>>  }
>>
>> -static struct intel_uncore_ops generic_uncore_msr_ops = {
>> +struct intel_uncore_ops intel_generic_uncore_msr_ops = {
>>         .init_box               = intel_generic_uncore_msr_init_box,
>>         .disable_box            = intel_generic_uncore_msr_disable_box,
>>         .enable_box             = intel_generic_uncore_msr_enable_box,
>> @@ -743,7 +743,7 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
>>
>>         switch (type_id) {
>>         case UNCORE_ACCESS_MSR:
>> -               uncore->ops = &generic_uncore_msr_ops;
>> +               uncore->ops = &intel_generic_uncore_msr_ops;
>>                 break;
>>         case UNCORE_ACCESS_PCI:
>>                 uncore->ops = &generic_uncore_pci_ops;
>> diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
>> index 142e1b56cfc2..cececf6ecdc5 100644
>> --- a/arch/x86/events/intel/uncore_discovery.h
>> +++ b/arch/x86/events/intel/uncore_discovery.h
>> @@ -151,6 +151,7 @@ void intel_uncore_generic_uncore_mmio_init(void);
>>  int intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
>>  void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box);
>>  void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box);
>> +extern struct intel_uncore_ops intel_generic_uncore_msr_ops;
>>
>>  int intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box);
>>  void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box);
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index a97cd029db36..3abbc1bbf577 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -6492,6 +6492,32 @@ int gnr_uncore_units_ignore[] = {
>>         UNCORE_IGNORE_END
>>  };
>>
>> +/*
>> + * One CMS box exists per CHA box, at a fixed MSR address:
>> + * 0x3400 + 0x10 * unit_no + <reg offset>.
>> + */
>> +#define GNR_CMS_MSR_PMON_BOX_CTL       0x3400
>> +#define GNR_CMS_MSR_PMON_CTL0          0x02
>> +#define GNR_CMS_MSR_PMON_CTR0          0x08
>> +#define GNR_CMS_MSR_OFFSET             0x10
>> +/* Type ID for CMS */
>> +#define UNCORE_GNR_CMS                 50
>> +
>> +static struct intel_uncore_type gnr_uncore_cms = {
>> +       /* Keep the PMU name aligned with the published CHACMS event list. */
>> +       .name                   = "chacms",
>> +       .type_id                = UNCORE_GNR_CMS,
>> +       .event_mask             = SNBEP_PMON_RAW_EVENT_MASK,
>> +       .num_counters           = 4,
>> +       .perf_ctr_bits          = 48,
>> +       .event_ctl              = GNR_CMS_MSR_PMON_CTL0,
>> +       .perf_ctr               = GNR_CMS_MSR_PMON_CTR0,
>> +       .ops                    = &intel_generic_uncore_msr_ops,
>> +       .format_group           = &snbep_uncore_format_group,
>> +       .attr_update            = uncore_alias_groups,
>> +       .cleanup_extra_boxes    = spr_extra_boxes_cleanup,
>> +};
>> +
>>  static struct intel_uncore_type gnr_uncore_ubox = {
>>         .name                   = "ubox",
>>         .attr_update            = uncore_alias_groups,
>> @@ -6595,15 +6621,66 @@ static struct freerunning_counters gnr_iio_freerunning[] = {
>>         [SPR_IIO_MSR_BW_OUT]    = { 0x2e0e, 0x10, 0x80, 8, 48 },
>>  };
>>
>> +/*
>> + * Neither the free-running IIO counters nor CMS are covered by the
>> + * discovery table, so both are added as "extra" MSR uncore types, in
>> + * addition to the ones enumerated in gnr_uncores[].
>> + */
>> +#define UNCORE_GNR_MSR_EXTRA_UNCORES   2
>> +
>> +static struct intel_uncore_type *gnr_msr_uncores[UNCORE_GNR_MSR_EXTRA_UNCORES] = {
>> +       &spr_uncore_iio_free_running,
> 
> I think this SPR uncore IIO is not relvalent to the patch here. It
> should be split.
> Thanks.

spr_msr_uncores[] currently contains only one PMON unit,
spr_uncore_iio_free_running, which is not enumerated by the discovery
tables and is shared by SPR, GNR, etc.

This patch adds a new non-discovery MSR uncore PMON unit, CMS, for
GNR/SRF/CWF/GRR. As a result, both non-discovery MSR types need to be
grouped in the new gnr_msr_uncores[] array to ensure they are registered
properly.

This does not change any existing SPR uncore behavior, and I don't see a
practical way to split out spr_uncore_iio_free_running from this patch.

> 
>>
>> +       &gnr_uncore_cms,
>> +};
>> +
>> +/* Build the CMS boxes rb-tree by mirroring CHA's discovered boxes. */
>> +static void gnr_uncore_cms_init_boxes(struct intel_uncore_type **uncores)
>> +{
>> +       struct intel_uncore_discovery_unit *cha_unit, *cms_unit;
>> +       struct intel_uncore_type *cha;
>> +       struct rb_root *root;
>> +       struct rb_node *node;
>> +       u16 num_units = 0;
>> +
>> +       cha = uncore_find_type_by_id(uncores, UNCORE_SPR_CHA);
>> +       if (!cha || !cha->boxes)
>> +               return;
>> +
>> +       root = kzalloc_obj(*root);
>> +       if (!root)
>> +               return;
>> +       *root = RB_ROOT;
>> +
>> +       for (node = rb_first(cha->boxes); node; node = rb_next(node)) {
>> +               cha_unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
>> +
>> +               cms_unit = kzalloc_obj(*cms_unit);
>> +               if (!cms_unit)
>> +                       break;
>> +
>> +               cms_unit->id   = cha_unit->id;
>> +               cms_unit->die  = cha_unit->die;
>> +               cms_unit->addr = GNR_CMS_MSR_PMON_BOX_CTL +
>> +                                cha_unit->id * GNR_CMS_MSR_OFFSET;
>> +
>> +               uncore_find_add_unit(cms_unit, root, &num_units);
>> +       }
>> +
>> +       gnr_uncore_cms.boxes = root;
>> +       gnr_uncore_cms.num_boxes = num_units;
>> +}
>> +
>>  void gnr_uncore_cpu_init(void)
>>  {
>>         uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
>> -                                               UNCORE_SPR_MSR_EXTRA_UNCORES,
>> -                                               spr_msr_uncores,
>> +                                               UNCORE_GNR_MSR_EXTRA_UNCORES,
>> +                                               gnr_msr_uncores,
>>                                                 UNCORE_GNR_NUM_UNCORE_TYPES,
>>                                                 gnr_uncores);
>>         spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
>>         spr_uncore_iio_free_running.freerunning = gnr_iio_freerunning;
>> +
>> +       gnr_uncore_cms_init_boxes(uncore_msr_uncores);
>>  }
>>
>>  int gnr_uncore_pci_init(void)
>> --
>> 2.55.0
>>

