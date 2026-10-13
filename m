Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0504BD34F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935271; cv=pass; b=YRPWBfiZsAQL3S2wzJoTgKWHqDYCf5RiRMHueCLOcGrIM+ioabyhfT7l6DUNkHtFEBC/m6KvBhVilkM3QTxZNdTM23Cb5QaTXxl4vz0Ub88fD+Rig38gpKq8IBnYW7Q/o+p9CE5thI09Y/P1SW/mAh16BKQeltpMOiB6Cdkdcd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935271; c=relaxed/simple;
	bh=RpVj60Np2QeJsiDicQft4LScnare6AIB8StmTWAUalo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhEdaaMo+gok2fFu0rRL2VJtI6yk3faa5diZ6RbgE9ytX78pYOwYKUr/IixR+VnT067q6kWQpkyv/vGzDk6czP3d4622PU8q8ISUltjbdCLGXR96hTjCODTOHjTLVw5CrLYpQiCbSXgctG5EzvkdBRGgu+ZKlDXQpRfQF8da6Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gme4XrJW; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gme4XrJW"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bcf03d95b8so23814e87.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791935268; cv=none;
        d=google.com; s=arc-20260327;
        b=gsesGJTecmOUkTm38eVj5kGxsQE+BMy1YUmdoEC7yIzWmb8OvQF47GMfUJnrkp4G1G
         iu4MYA6TnwXZFQ475cur4Tikpf9AFMORigWuvG7hLXnea3iovDpp6Mq7/Nl3s5g3dYxl
         fjgLSF3aN1ohwcThNE/dvXWlcCjMg0LJKYz0KRO9MNBtlGpQarRfRSjOKfTIIZjS/Tlu
         CYxvGUvL1f98e7eMpUzLvgeB/CDFJzUmmz7cRsA0/F7ipsKlhoonGH0uAcBk3cdL1g70
         dbZ3GwRdpQP5F51erml12R7PBUNMVyDSnRMpfj8YvcZYqc0G422K6u+E0bv+QzOCr81A
         BLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gWlBab7B3jJux3vwKeZxIpLl3dDCHc4QEgeA5gXUrZ8=;
        fh=RGXojNl5As5sbzRHa90YHozyksLPC8YtFAKiy3dV9z4=;
        b=rDKgkFsK14Kh2GmpXTmJrGDSgvwNC61W6bj1N4dYAlbazQeRN3+KISEepqfI1vVNkI
         nzoQBqjSQ2qH+UYUNRQbVDqOEodfeVimIuye/XDGsUrTft2Ft26jW6ZPZjXzTw5s+JA7
         TBKo/lqWfJdbPU5ts+NfrXi4H5j5/yL6H1DWXV41ZpAkZj9rTy0/HNvlAliYwLnBk+9v
         EdNIehtege9lkkw40HYMwhXKjGP6SWbYcIcpWq29uE0Wo/66xcFrv0Nzl4ES9T8xXhzc
         rpu1FTNCpreIAyN6q+gaF74yTHnxFtzu3hVQourS0jmhmSyBqUcXB2GLRXoCYkCcfyFE
         9gBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791935268; x=1792540068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gWlBab7B3jJux3vwKeZxIpLl3dDCHc4QEgeA5gXUrZ8=;
        b=Gme4XrJWfSPCRvMteZMCfU+qvW9QMA5XjDeOA4Y0NFJtBr3sbJyn87aQPy/oW30/SU
         zXtWbpIr/6dj5WHV9JSj02tRGcPESFuUdDPgUvfTOy2JGpJywn/J0apar/mDfHoDXk1/
         3ufHcYZS6vWI/mVZZ8lhaKgfSGX6tGPLozt/1Qz4dKtwKu2MOEaULrgEtzUJNA5kNIlo
         yiPkbQuLH0nSjJ9Aud+XnjLL0YTVeje/IVG2BRMgRFHXcBnqAVu2e9mU0yXydgWK6lG3
         mtGyVOA+g3++UvG827eo2sKMG3YW9/BRmzf2PHC2ksgAp9Kobre2igdnamFCIkla5DTC
         /r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935268; x=1792540068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWlBab7B3jJux3vwKeZxIpLl3dDCHc4QEgeA5gXUrZ8=;
        b=JD06KoL7fXpnJNnFI2jeKOMcQOQ9kXzwKSd1ZmU6KtzL+/TyLmqkvkIMNMgJzBX96K
         W1hrV7CKmOmadJnF6gOkWZfvmQMMDBQB/KcqBtPduD98RtOMkQqRrxp2i7rtTM7eHzwx
         E4SrB9a/o1UYNQpfSbB+JHjdi+nqQHX7hW2baajF4IGz827IJbeY865nfHkeHc1wwpK1
         +2AnW4TeHMgIEh29nDTCQM2KLNMqnaOxSsJ7GgTScPKVukjpYZ8E2dfAI+kz3ixK40Ux
         RI8kd80QhueBkU+ApToLNXgHLmjQp49LyQwI1fSd0fVeDzFMy9FvRrYa6tpuc11XbWPc
         DAkw==
X-Forwarded-Encrypted: i=1; AKwUvBymkgFxYcgMJV80nL7lB2LnX4xnXU/SwS/6+3zEyzlX8Fc2SYgTgMIZ3v1vJIAL7dtq81WKQ/c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrhB4tUc4LqdGVInF7XKgOntOQAVsZbCw4I6hiMsukFclovq9J
	hdXR4X/r99FbahViLrjR76kwJNMxbZULkiAivgyrR14MU4mcZkM45Lpu6R6uMWccsnLB42+V+tz
	G910VdbRuEyGQde6v3vLdlFAb9CQKm4Tb7xLh9B2W
X-Gm-Gg: AYBFou3o4fDXWJFzESnuZbFae8hnsL85I5nPE++izG5NSHdDnAwRTNtNJfS2tgmvKEe
	j6Y7qnRji78gOeKWBEsQQuCrC/udkelcBR32lJG0T3KLbNyq+MYgS8C2Nq4qHG1G5ZJYOl27M4J
	zFANLcdgzTnbE5Etc8VUbNGV7L3HYIFcbXtnNnKlfbziPZBf7NZ1thVilKxatPQuewPAEOQ70v1
	yZbH8POu5dittRGWYxE3z8U7UgpJp7e+/FRAsTIdp9AeKj7sOkXdAas9ceUDA65X4/OZbvwlv5T
	1eck5jFQAnAjDEgPZmEeZolNBwuM8xBTglrhLKZ1Po7vJvA17qhuP2QBEVUGMcuteT4LJe+Kr5P
	5NtBEmVaRutXMog==
X-Received: by 2002:a05:6512:3513:b0:5b7:6707:e44c with SMTP id
 2adb3069b0e04-5be35cbee5emr1117e87.12.1791935267421; Tue, 13 Oct 2026
 16:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013194005.96615-1-zide.chen@intel.com>
In-Reply-To: <20261013194005.96615-1-zide.chen@intel.com>
From: Stephane Eranian <eranian@google.com>
Date: Tue, 13 Oct 2026 16:47:35 -0700
X-Gm-Features: AclHuK8uZdYqRb8wR6f2pJnkv0TIuw0zO4fvvfTQZQwDMYoL43cTs3jEd7Uem24
Message-ID: <CABPqkBSn57PLhdZj1syvMTF_LG7NgitKC3xbLMF7vqyK-vyA4w@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: Add Granite Rapids CMS PMU support
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	stable@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:50=E2=80=AFPM Zide Chen <zide.chen@intel.com> wr=
ote:
>
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
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/i=
ntel/uncore_discovery.c
> index 0a22edf4d509..170f299385a0 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -532,7 +532,7 @@ static void intel_generic_uncore_msr_disable_event(st=
ruct intel_uncore_box *box,
>         wrmsrq(hwc->config_base, 0);
>  }
>
> -static struct intel_uncore_ops generic_uncore_msr_ops =3D {
> +struct intel_uncore_ops intel_generic_uncore_msr_ops =3D {
>         .init_box               =3D intel_generic_uncore_msr_init_box,
>         .disable_box            =3D intel_generic_uncore_msr_disable_box,
>         .enable_box             =3D intel_generic_uncore_msr_enable_box,
> @@ -743,7 +743,7 @@ static bool uncore_update_uncore_type(enum uncore_acc=
ess_type type_id,
>
>         switch (type_id) {
>         case UNCORE_ACCESS_MSR:
> -               uncore->ops =3D &generic_uncore_msr_ops;
> +               uncore->ops =3D &intel_generic_uncore_msr_ops;
>                 break;
>         case UNCORE_ACCESS_PCI:
>                 uncore->ops =3D &generic_uncore_pci_ops;
> diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/i=
ntel/uncore_discovery.h
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
>  void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)=
;
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index a97cd029db36..3abbc1bbf577 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6492,6 +6492,32 @@ int gnr_uncore_units_ignore[] =3D {
>         UNCORE_IGNORE_END
>  };
>
> +/*
> + * One CMS box exists per CHA box, at a fixed MSR address:
> + * 0x3400 + 0x10 * unit_no + <reg offset>.
> + */
> +#define GNR_CMS_MSR_PMON_BOX_CTL       0x3400
> +#define GNR_CMS_MSR_PMON_CTL0          0x02
> +#define GNR_CMS_MSR_PMON_CTR0          0x08
> +#define GNR_CMS_MSR_OFFSET             0x10
> +/* Type ID for CMS */
> +#define UNCORE_GNR_CMS                 50
> +
> +static struct intel_uncore_type gnr_uncore_cms =3D {
> +       /* Keep the PMU name aligned with the published CHACMS event list=
. */
> +       .name                   =3D "chacms",
> +       .type_id                =3D UNCORE_GNR_CMS,
> +       .event_mask             =3D SNBEP_PMON_RAW_EVENT_MASK,
> +       .num_counters           =3D 4,
> +       .perf_ctr_bits          =3D 48,
> +       .event_ctl              =3D GNR_CMS_MSR_PMON_CTL0,
> +       .perf_ctr               =3D GNR_CMS_MSR_PMON_CTR0,
> +       .ops                    =3D &intel_generic_uncore_msr_ops,
> +       .format_group           =3D &snbep_uncore_format_group,
> +       .attr_update            =3D uncore_alias_groups,
> +       .cleanup_extra_boxes    =3D spr_extra_boxes_cleanup,
> +};
> +
>  static struct intel_uncore_type gnr_uncore_ubox =3D {
>         .name                   =3D "ubox",
>         .attr_update            =3D uncore_alias_groups,
> @@ -6595,15 +6621,66 @@ static struct freerunning_counters gnr_iio_freeru=
nning[] =3D {
>         [SPR_IIO_MSR_BW_OUT]    =3D { 0x2e0e, 0x10, 0x80, 8, 48 },
>  };
>
> +/*
> + * Neither the free-running IIO counters nor CMS are covered by the
> + * discovery table, so both are added as "extra" MSR uncore types, in
> + * addition to the ones enumerated in gnr_uncores[].
> + */
> +#define UNCORE_GNR_MSR_EXTRA_UNCORES   2
> +
> +static struct intel_uncore_type *gnr_msr_uncores[UNCORE_GNR_MSR_EXTRA_UN=
CORES] =3D {
> +       &spr_uncore_iio_free_running,

I think this SPR uncore IIO is not relvalent to the patch here. It
should be split.
Thanks.

>
> +       &gnr_uncore_cms,
> +};
> +
> +/* Build the CMS boxes rb-tree by mirroring CHA's discovered boxes. */
> +static void gnr_uncore_cms_init_boxes(struct intel_uncore_type **uncores=
)
> +{
> +       struct intel_uncore_discovery_unit *cha_unit, *cms_unit;
> +       struct intel_uncore_type *cha;
> +       struct rb_root *root;
> +       struct rb_node *node;
> +       u16 num_units =3D 0;
> +
> +       cha =3D uncore_find_type_by_id(uncores, UNCORE_SPR_CHA);
> +       if (!cha || !cha->boxes)
> +               return;
> +
> +       root =3D kzalloc_obj(*root);
> +       if (!root)
> +               return;
> +       *root =3D RB_ROOT;
> +
> +       for (node =3D rb_first(cha->boxes); node; node =3D rb_next(node))=
 {
> +               cha_unit =3D rb_entry(node, struct intel_uncore_discovery=
_unit, node);
> +
> +               cms_unit =3D kzalloc_obj(*cms_unit);
> +               if (!cms_unit)
> +                       break;
> +
> +               cms_unit->id   =3D cha_unit->id;
> +               cms_unit->die  =3D cha_unit->die;
> +               cms_unit->addr =3D GNR_CMS_MSR_PMON_BOX_CTL +
> +                                cha_unit->id * GNR_CMS_MSR_OFFSET;
> +
> +               uncore_find_add_unit(cms_unit, root, &num_units);
> +       }
> +
> +       gnr_uncore_cms.boxes =3D root;
> +       gnr_uncore_cms.num_boxes =3D num_units;
> +}
> +
>  void gnr_uncore_cpu_init(void)
>  {
>         uncore_msr_uncores =3D uncore_get_uncores(UNCORE_ACCESS_MSR,
> -                                               UNCORE_SPR_MSR_EXTRA_UNCO=
RES,
> -                                               spr_msr_uncores,
> +                                               UNCORE_GNR_MSR_EXTRA_UNCO=
RES,
> +                                               gnr_msr_uncores,
>                                                 UNCORE_GNR_NUM_UNCORE_TYP=
ES,
>                                                 gnr_uncores);
>         spr_uncore_iio_free_running.num_boxes =3D uncore_type_max_boxes(u=
ncore_msr_uncores, UNCORE_SPR_IIO);
>         spr_uncore_iio_free_running.freerunning =3D gnr_iio_freerunning;
> +
> +       gnr_uncore_cms_init_boxes(uncore_msr_uncores);
>  }
>
>  int gnr_uncore_pci_init(void)
> --
> 2.55.0
>
