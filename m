Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D73161AD
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164512; cv=pass; b=hFnQ5adWUxKB3l1UBheAutCVh575EnLCCEEuBZwGlM+VIv/VhqsD5YU2V0063vf5t5ajWhmXvttuipF7tjpP6GI4gqxbJ+CSyrwRjrOL5zh7424xNcNFMgEp/TU+NvFJFpGKVFDPT2WMX48XBeHmldixMNB9Ms2RSaAoipYGBWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164512; c=relaxed/simple;
	bh=/w08hq3SNrl5unkntTUYaNNGFp//52vley7NTAQwYl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HF7Gth/VrRq5rIKxhXMxCnSHCMlrMaPYEV8j3Afc/pkGYkR9HOXoVTxTVQS0I5zKoCu8Lkdkkxp765tv8sT8AlWTar3oI8L5+GN3VOU82bpPLAYQG4n6Z01Hno6KVqQtw5/O8eI2Ob7Iqs0Bs1wI3jWebSV1MbUo/UASYAYayKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxyM3mjy; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxyM3mjy"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15f47e6297so297371166b.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 18:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784164509; cv=none;
        d=google.com; s=arc-20260327;
        b=gkOCuft5llhCVxSSLBqYdP20aVy3/a5oL14cUrK8rhbB/gS0sk25/WHhbup2f7bM+p
         NSyBVU1CSUcvMKc6t97mY74Y37oB5PGN/TtJllvf6OlX8YkfVD1hjCVFA7RPDb2YbyDl
         JoCzT0NQsTcwm6kDx+SwElbPpqddWDov84lapSD83r68NzwDnDiEiyNXdnvK7efKieME
         8nNk55iY+XmAbY6KlcIQCk6VDl1yP1zN8jrR221ZBSVvVZfZs3OQXqez1ft3mVlBOkLw
         TbU44Hb+HNtZn5RQDDHSoYD3NI0p6BrR72su7gVEnaPbtnWdY+kAZ4ITZZTSzwnXfz5t
         3edw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nmijb/FoQac3oqNaTElP2vCQkmzRzb8oAIAbdOn+42E=;
        fh=qP184vHHHUGIh8S1K8C/Zq+nmFrs5xXbU7pfcFB68Sc=;
        b=QZu8BQJJCVyOupmhMrg/1mbMrGdQvyyZZh1C07Ic5GGPcENsnMqsvTi3SOlY7MpUbv
         xPpOtPiuf7DIqiipjGaOyISIZX8Mv8hJRlLhMYzOf2hgYgQOeMIK8I44aoSSVpsn/1GG
         50Dh+3T1920eIiQwSZmeOISUTKsCpyUZOZOllcT1u6qVB5mV5vaEY//txEU5TdD5m1Ys
         cXoeTnVg78AY/j/eOvKoDA50hNY6fbBrqn1hOGZsI3fdwysY6Vt3yFCxaGUC8+Ws/Q6q
         iyc/DERZbTSmbqxFKJLd6cN0bg7zvLV/mk5mhBPQ+I3iyPegx8XhBWL1aA8QpfeJt+zh
         1kbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784164509; x=1784769309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nmijb/FoQac3oqNaTElP2vCQkmzRzb8oAIAbdOn+42E=;
        b=nxyM3mjyq1i21s4fZoxA/h9KYK77reNxhfeuLuYekTzolymLm8CHEVOqgU1cMpz+NB
         o2c2p2KyI35Hj80PXEpLNl7UpThRCnL6dM2L4QUKTDn/NLBP6EsPwJYDnUF8mOE5jc93
         cZ9D+X9liH596xkavDV2d9ZW4MO7vfyrVOX6r+YWb0D27eBw/AE96rmvPPe4IVFfhw9P
         QAsTNfsQdRaGxgVikEIQVV5mUc8Sq16wCaLwFpNMu/pSxdAqjo8TiioKcaMqXuScW66z
         utjhJreyJaHg6SDjm7ywW1PqO8r7TZLAWCqZDtwhsVScYGzLjlI4IPryKrlv0Vdb3Teo
         nWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784164509; x=1784769309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmijb/FoQac3oqNaTElP2vCQkmzRzb8oAIAbdOn+42E=;
        b=RydIHYezErv3irov41IoLK2qDk+GYFQbBdd0AOOWaN7z/yt74joLRe2BkbfLqhhPGy
         b07IvECyO4YLysxWR9b5Rwlq1Q5VRsLJeavSH+FLS9en4Qk6vnkJjA4JwhervivAqNv2
         2ETPxsa8iQuFzkKIFxlxXcwMyjlyZD1evQ/5lSu4QE1qquDnuwp+q9ecD0bwg6XaINBZ
         5FB1wcH+OYRTMHmNCx3a5Z50bZIbcWH/pXgvvuxjs50AVHpl2kzHJyfBYnlMF+ohfiH3
         QbPpR24QrskkBFwA424Q5LRS7DmZd3BhExg+xDcezK14DDAfVM13GR2TPZQcBSSN856+
         PaFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJK+Jgm4bVumrtu0gOnSEDnywF5+cKwNtXVdmdY329yWDHcizMtIqNvxrrXxEuzMP91Fu/ELk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3TIJHDeDLfwkejz7tVbatmZglcDA4CxOKku/nBv0EVJZkwv3
	ujzEFXa8X0Aa9iFyvxJkXv7nsjrvLDGWg/nXVKiulMvaCYtOj6Ul/YMmj0Z6dYWXjDTvVKLqDjW
	J/30rAMCxs73mzaFRUaadI7CLI/XEo2yyVN3dmomi
X-Gm-Gg: AfdE7cluMEhFk+S459Mg0yZLpQCH6fIHTpYfycc8Nc6V0wgHdk0SnD9I4WDHkVS4UQq
	i33yTt+V9mAcNdRPHJjP//1QJQVYJhZSKBwHDGo39rg5EIqw4MWQyL09FUKNrRX3Jnv9jxh6/qh
	3ZzVEm33T+IqQjKJRiDGXs5L9f6cEt9GPCCb2+GJsCtp5YPAVaaeU+ydfG80hxApuvjXU6JRPH2
	GnIfL/QV5fkKce6Dqvp8CFhJjemwM1cby3m/dqYuWIBfYs70/sBaRGOcJ83bnTKu1TB4hekfzj3
	eUYKTI48sRl+l1Y7WsqtUWcM9T+YwHj/gDiIZxUXiUMZXKS2
X-Received: by 2002:a17:907:6d20:b0:c12:34f0:f7b8 with SMTP id
 a640c23a62f3a-c161ea6be7dmr962592766b.55.1784164508299; Wed, 15 Jul 2026
 18:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715234234.15382-2-venkateshs@chromium.org>
In-Reply-To: <20260715234234.15382-2-venkateshs@chromium.org>
From: James Houghton <jthoughton@google.com>
Date: Wed, 15 Jul 2026 18:14:30 -0700
X-Gm-Features: AUfX_mxZPkookJAlOtrSYHlulzoxjnu5C4iZKL0oTqb1lOaPZctrjx0v-nWFr7I
Message-ID: <CADrL8HX-wfbjF=huA_kopNEbq63E3yhO6_9WfrcfH5EgJYAk1w@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Only reset TSC Deadline Timer in
 apic_timer_expired on KVM_RUN
To: Venkatesh Srinivas <venkateshs@chromium.org>
Cc: kvm@vger.kernel.org, stable@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Sean Christopherson <seanjc@google.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Venkatesh,

On Wed, Jul 15, 2026 at 4:42=E2=80=AFPM Venkatesh Srinivas
<venkateshs@chromium.org> wrote:
>
> Fixes a lost timer interrupt issue if:
> 1) We are on an Intel platform w/ a VMX preemption timer && APICv
> 2) A VMM calls KVM_GET_LAPIC before KVM_GET_MSRS to save vCPU state
> 3) The thread executing the two calls migrates CPUs between the two calls

I think the paragraph above should be rephrased, something like this:

"On Intel platforms with a VMX preemption timer and APICv, if a VMM
calls KVM_GET_LAPIC before KVM_GET_MSRS to save the vCPU state, it is
possible to lose a pending timer interrupt.

If the thread running these ioctls is migrated to another core after
calling KVM_GET_LAPIC but before KVM_GET_MSRS and the guest is using
their LAPIC timer in TSC-deadline mode, not only does the save LAPIC
state not carry the pending interrupt, the TSCDEADLINE MSR will be
zeroed."

Sean doesn't like pronouns (like "we"); he'll probably have similar
style feedback.

>
> After migration across CPUs, KVM_GET_MSRS calls vcpu_load, posting the
> interrupt and clearing the MSR:
> vcpu_load() ->
>   kvm_arch_vcpu_load() ->
>     kvm_lapic_restart_hv_timer() ->
>       start_hv_timer() ->
>         apic_timer_expired() ->
>           kvm_apic_inject_pending_timer_irqs()
>             . post interrupt into the LAPIC state
>             . clear IA32_TSCDEADLINE
>
> The saved LAPIC state will be missing the pending interrupt and the saved
> MSR will be zero. Oops.
>
> Fix by only posting an interrupt when we're attempting to enter the guest
> (vcpu->wants_to_run =3D=3D true), not for vcpu_load from other paths.
>
> Assisted-by: gemini:gemini-3.1-pro-preview
> Debugged-by: David Matlack <dmatlack@google.com>
> Debugged-by: Sean Christopherson <seanjc@google.com>
> Debugged-by: Jim Mattson <jmattson@google.com>
> Debugged-by: James Houghton <jthoughton@google.com>
> Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>

You have included cc:stable (on the CC line in this email); could you
include it here in the patch as well?

Also, what is the appropriate Fixes?

> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 6f30bbdddb5a..74dfdbab4ab9 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2052,7 +2052,7 @@ static void apic_timer_expired(struct kvm_lapic *ap=
ic, bool from_timer_fn)
>         if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
>                 ktimer->expired_tscdeadline =3D ktimer->tscdeadline;
>
> -       if (!from_timer_fn && apic->apicv_active) {
> +       if (!from_timer_fn && apic->apicv_active && vcpu->wants_to_run) {
>                 WARN_ON(kvm_get_running_vcpu() !=3D vcpu);
>                 kvm_apic_inject_pending_timer_irqs(apic);
>                 return;
> --

As far as this change goes, it makes sense to me.

Reviewed-by: James Houghton <jthoughton@google.com>

Thanks!
