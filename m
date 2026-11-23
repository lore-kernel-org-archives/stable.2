Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795430103;
	b=tWKCQroxctDL69KSgpMVLUl59r2blHC13kr1lLGFWX6kdshU2/+R1ELLjeDJz0CJ3RCu
	 Qu7lwMXKBZTcs3FnPzdnCgBhKl5qaFnnrT14Zclh73bnyMuBXBTwLaczO/GzKUvX8BRRH
	 S0JcwR2thYj7e15qyXUdJfAF1RDYeZ87lm9guzaXAMoPBbKGRSawkTIIOW/HYKhCSnZJZ
	 5n7DJ0Zb90lfrFMa8ypVnCSvRCqScDAm5cwsOXIe2MDa6/yJgz/wwtS0Gev6xyMjEYsvL
	 FEhTzN3CABPgzYtClgKkfGwpCym4FoAircOcYXK86q6BQ38r6CFuP5nJ1V9HEnQolOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=FkLm2QDvo0RLh/Me+j1f+/tll97oLAwEndJ2bmbVDp8=;
	b=PxAr8Y9zQGzB+PYMMglEi13C4VUdUsEtMMcvzf+2DMBvPv40L5ieS1e3YQJMlV3+4frK
	 +r/A4VAx+3g+mYf332dILOBNiH2v9KPhOIf92QEcdMaYJJiiBSRMl6aLjzaDoeWdgPAW8
	 xfQTMhypSy0hvj9r2NRxGhrXJq+S0mpixTcnKeym979oUpINg+SmqUPTBHmfPdrmjfi4h
	 GDZLlPzPaD94BUzELKMq28ZdF6fp69iICi9DjuOFP9DsZZcc09wEpAj2Z62bPiG7GAwdF
	 70DK+ZSqKuGI16dawZ4M1DPivLlvuqlktCVYhiURq266BOHV2WaZwelxmAvZ1WB6Dcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=txsdnX0h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96762606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96762606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=txsdnX0h
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6bab10842f8so1454456a12.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 02:35:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795430101; cv=none;
        d=google.com; s=arc-20260327;
        b=SjkEjISDOA7WwJU1yCmA89bBHBQW1YwV0NtZs38uLT68d8T78wt2l3Av7/NJlmWmnn
         mfYQ6gFLlok5aaBBhei2KB9YI+mSCe3TvdxvySCM2eclSv5gbeUnZ1N8XFfVDWbmvc23
         fkNyV0o2C083cbtRTMctJdO9hD5gooVHCJeYNpYEgTjsqlMfqfrm2Z91is4LpKJ6PHu9
         MurMaCyW58PTSMIyUvFz41KYagftaKlcEHb9/Qidju57vKjKnz5+6KqAM0I4ZAjfP6vI
         gmUxzPvPbsDSUIZYRShJMhyZ/use8TRVqevUmwQouolfMylYIDfGXV1HWGrtJF4GynrP
         Fuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FkLm2QDvo0RLh/Me+j1f+/tll97oLAwEndJ2bmbVDp8=;
        fh=glirQhh9c9WiVG8heTVivV2DY7BOAmjtcAC52DGBSpw=;
        b=YP49a/RR9JYBfQ9haIigarCi4QuyU18nhhSmP+viqSENrELoXKz8wcOGWaIe5behtr
         iCUyGmbtnMJ+AWvjthY48LZ49eeeZGgoYU+5zMHNzZe3BB2TND2lHnEFuE1vzUokxkwW
         JsTQ2ww/oGE6pvb70SLWWI4scyKk8vmQkIlK1/O6Sf5ETrDpN9hJvsWGzUHwnFptsy6B
         IMYJYd8g1fPZ8fbohPEw8Y4P5HsV2bN0DqAns+oY/zYVlzUx1SkskYrna/MtDe89eb6X
         5EhHC4as40jDwaA4XwAuujalwtkRRcE2CCe1TzmiEQX+bbkVIQiHfz6HR+NVoKMe2+AM
         pKlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795430101; x=1796034901; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkLm2QDvo0RLh/Me+j1f+/tll97oLAwEndJ2bmbVDp8=;
        b=txsdnX0hfzGgNixMYHE+ihZu7dkT3JrucEg0QinC6WjgH5wN/LOHJxJH6KugPzAkAa
         mKVBg78VzMNap4miyybduSRVIurJPFPXLLcom00Af6TMIZiLfwvlb7jJ2iSb6UvblCdA
         S2n5SioU9P0kYsYgY9Bfl+CzHL5zv2E4ZSe2MPklS/BV8sGxlzO/E+Je789hI2ws861g
         jlM+4dNXMLCK/W3h2mOxmC9w4y923FNKXJx1Aev/1wbB/RpYVvSHCbL+8E2yaUBCvbQH
         mBOfmoYdVy4zTYuYodUdKaFgKyzBEo1cGeszzSTaRHPH0D/v/+k3LLdDHbovRusdmilY
         zD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795430101; x=1796034901;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FkLm2QDvo0RLh/Me+j1f+/tll97oLAwEndJ2bmbVDp8=;
        b=IoRCmgNviSS4zIJTbfbz3iyoh8bsazZH9BPwTqeqzSA7FRv9ohzyY2k/PqtXDN4qPf
         2+Fe/e5i/WNRA3Ew2GLqm9ZaGMMiL7Gws+lea0NqWgwIedLnzvtk+UygmjRBM2RyXxDY
         RmSBth8ze+a/5C0Iu7y/HVGjB7fxXMEwpZVrqe/CN4QRwzz6mtU7C4rt6KzphzMg1lVT
         UMAbJg99CTVcpZTc05LAFJYRpJvnY3oJh76S+oyH7Y2xd6uTEBbkuZXlFR/Qce4RNwXz
         tut2Al2FmRi0mhAxfffrPtmulFmirIWctVTjCOSMWfhWeQlwEBRpMvZV3q8Xlqm6/fZW
         yX8Q==
X-Forwarded-Encrypted: i=1; AL+hErEv2qugUZP1chdiTS08A/PsAvJqAuOw2dGCxNhVu98cioUKZvB3xRh19Fqozj0/0QSJ8w6w+sY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HJtZoJAW3Fr81glKZyi/TDTGfUkHHZbC0w659P8/EYivsjt3D
	LLBYvkfAxXry1ju1QogZxSuJhKiC9ZK4Bl5KOxT/nm/3vVBPh78uenxjTH6+50sAIGKwSzCxvmE
	wenmRgA/yi3d/gs3PXtfyB6AfmsNVq084mSF/hUBGPw==
X-Gm-Gg: AZFdTZfP34OqsLtQfaGLzMo6i/qcllX3+OE2yZ96rIX9q7szpOtRJ7x8FaxVdqnGZtz
	X1nM4xsjmDcW9nC7feVN477R3q+cfkZDI/14zIHNfZSnDvfIkZ/SY7B8GlIB0pYcMob9YHbSZLQ
	qOKZjPqqxX4LSTVqe/UqkbrqOZtT4pxE9LKh5jfyCb5CDjKf5KeVUIUT8j7trDDB8rs2zLDJDl/
	4jVde7huS7L0C8/m0TzyGfdlBkPVuL9Nq1aOdPKX6dTZjsKM2D1pl+sMEpZLyjcIYAsvvr0zzUZ
	J5PPkzeIG6gKVfxS46ncr/G19cqLOvghkR8hOnPx5YziOcabXni83ic1TpnU349zlGxKJ92mksI
	VeTfFxIK7jpWMFG3UO5ayv45rDY+d/6fb1cu1xrbil8D+3gyVwX3f2GoRxSWR7WQV+48P2A==
X-Received: by 2002:aa7:db47:0:b0:6b7:aca7:2264 with SMTP id
 4fb4d7f45d1cf-6ba37e6980dmr5721448a12.9.1795430100790; Mon, 23 Nov 2026
 02:35:00 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
In-Reply-To: <20261122015729.2512645-1-penghuang@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 23 Nov 2026 11:34:48 +0100
X-Gm-Features: Aa3M54pS5nfq3tiUm_gWyIlrBynlKLIymvZi5sxhT7ewjNFDS4BdqeJJrs3PYqU
Message-ID: <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
To: Peng Huang <penghuang@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Nov 2026 at 02:57, Peng Huang <penghuang@google.com> wrote:
>
> When scx_switched_all() is enabled, all fair-class tasks move to
> sched_ext, scheduler_tick() skips sched_balance_trigger(), and fair_rq
> scheduling is bypassed. As a result, rq->cfs.avg.util_sum stops updating
> and retains whatever stale load was present prior to switching to SCX.

When all tasks are moved to sched_ext, fair utilization should be 0

>
> When a CPU later goes idle, update_idle_rq_clock_pelt() still adds this
> dormant rq->cfs.avg.util_sum. If stale cfs.avg.util_sum plus active RT
> and DL util_sum reaches divider, update_idle_rq_clock_pelt() treats the
> rq as overutilized, continuously increments rq->lost_idle_time, and
> stalls rq_clock_pelt(), which in turn freezes RT and DL PELT updates.
>
> Exclude rq->cfs.avg.util_sum in update_idle_rq_clock_pelt() while
> scx_switched_all() is active so dormant CFS load cannot stall idle
> rq_clock_pelt().

This is not the right solution but a bandaid to hide the issue. When
there is not fair task,  rq->cfs.avg.util_sum shoudl become null.
Please look at why it is not null.
It could be that the update stops before everything has been
propagated correctly in the task group tree

>
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Huang <penghuang@google.com>
> ---
>  kernel/sched/pelt.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index f921302dc40f..6d31e1fbd094 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -138,7 +138,12 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
>  static inline void update_idle_rq_clock_pelt(struct rq *rq)
>  {
>         u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT) - LOAD_AVG_MAX;
> -       u32 util_sum = rq->cfs.avg.util_sum;
> +       /*
> +        * Under scx_switched_all(), CFS PELT is dormant and may stay stale;
> +        * exclude it so idle CPUs do not trip lost_idle_time and freeze RT
> +        * PELT.
> +        */
> +       u32 util_sum = scx_switched_all() ? 0 : rq->cfs.avg.util_sum;
>         util_sum += rq->avg_rt.util_sum;
>         util_sum += rq->avg_dl.util_sum;
>
> --
> 2.56.1.750.gf70dc682cf-goog
>
