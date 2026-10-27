Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119016;
	b=l0DZA9+iNiXkDAPN2ZOra7mU+yvYPYJnnqUsTrA9EVjHAu4fb8/TbI6hu4U39XItHJRc
	 guswvxkwMB9/IwbjPHRzdcbTeRsKGtzyFa+CQmLrsz5ub7y6TPl0hOfOJTBVmmP8YRroa
	 +6uV4fY6c8BBKIyLYzsgvgX3DCJyVMQmSh4cMXQo4MxfQxyZ6cZeQicNqAt46YIRzVTrD
	 uKmFHbYgz9jfiIXPKd1ZHBqV3AEzaV84O2WwzcUiqFqjFTZ6sT7rjxQxdM85pwucTAJyq
	 25NnKjoK/hfzl8gIQBDD6wHeLjD1XlSg6+Wsb1pncRZxvBecedmylAFdYhh/Lsw4N7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 Content-Language:Thread-Index;
	bh=DgyxaXcpCEgbpB6+0qEWI5ndWEratI/KZGAOF1/cwnc=;
	b=oXq5BqF23c0UuyaeUCwpOHWscABDRNo1PYYAknsOjv47jks4daCORuBI8/CT6CpzrGFW
	 YPqFbOCJ19UMTvJDXeFCJcuVd1K5btXZL+HNyuP0jE+PVJn6dH4qY9H4ylHVHuundpbGG
	 jU4bvztfM8CT2+Sqrai45fToA7OrVUHwvKotf9tvmImBufr0J2zcXWWfsL5PSptpYmGcX
	 2Il9L3AWABIBu6HmnAUWefeI6anJOwpT0UKIk0ED/EesZiWjebHL+SwqDxPeWwuMfOfUk
	 G2Hv3qILIR/UpB7SLihMTcsrHZpIH7HXVZDjWMEe7WO7ohkDKsQ2C+h2XZxxF1JkwKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=telus.net;
	spf=pass smtp.mailfrom=telus.net;
	dkim=pass header.d=telus.net header.i=@telus.net header.a=rsa-sha256 header.s=google header.b=dXf3FYtH;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B626606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B626606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=telus.net header.i=@telus.net header.a=rsa-sha256 header.s=google header.b=dXf3FYtH
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so632728a91.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1793119016; x=1793723816; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DgyxaXcpCEgbpB6+0qEWI5ndWEratI/KZGAOF1/cwnc=;
        b=dXf3FYtHi6EApSS+succvYZUloGyMtcGm4itBNRUej+p2wUz1PdvJWyWBnHlS7IXyW
         Wvwc+7ohJcYWd7giLzyglW+KZ8S+dVpgaikh7JwqEQS9g3EF/eYF3mWEp89abTEdlQIT
         55iceKE5kDWXGvUrjlfoFiFN1aCibgH9B5n3IIqpxZ4f5t6nnq+OfOlK5UzK4GQ82KFv
         htE1xuXoMEYndJO5bmTbKpUTfY/6vCeF7IQsGi9sN6UOjSVxVAMTcwzseyF3yLhVEevY
         UTH19XCQvW+efQsT+IH822A968wBB8gp1u6h8vMAuqyZaOFNMTNQOn9tVIt9Ry3lvHIJ
         V2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119016; x=1793723816;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DgyxaXcpCEgbpB6+0qEWI5ndWEratI/KZGAOF1/cwnc=;
        b=opZG+iyr9xu1NNKdwP4DMO0jMOJwElDRbNK9quHQ44VtsuUSBYazsF1sZVp/LMFrxI
         kH/j6JNU/zc9XiPyjD7X65Z+pA7lS39iZoRFNujMUUNITeEcw9Ubt0VqUjxCIhdYSJhC
         IJsVrko2AwLobswba0vT9H7u/LZdmU9rLsiN7Mwn4PF3chlMFPJ847PQhXXIEPtcmt9c
         lW9aU9RaAUd8F6mf4h4HFTtAStvwVGEd1vBKVofZ2xopDdYHoCbVA9HkVtmDUxDuwQ+l
         D6wC6rvzHIVsYYth1F5zty7AczySjDW+p9GGhYIS8OePq/jqY0qK1q5I3nVbTeWB6BjM
         fDzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJYIuoXhGmAmMjxhFJpEZjZu7Y/+TtE7Iai9Cni3V/q5cblByLCjM0oGS31Ofh64AcDYh9aQs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6qtjbEPGh25lgsbzL6d/cG1rCGdH+lvQVNEKjiJ+/XSAij8dM
	WSn+MZYb78CfyGnwKvtPArXNRWLyisNSZcV6niA/24yZ2DaBGpuOheJdRMselRtOtNo=
X-Gm-Gg: AYBFou3DQgVLPIauxetGy1m+OMeNrtsoOrwSp572DELtKwcVmUciwYsb4tfhmEoRTx5
	yxR8i2Lat4FTEMA7O9zZ+DvrHBRgS0ruRBrOsabCeICGUV1uvzy2bpivMJX1H6pZOGsm/n31bQv
	fYEm/FxVS+YKcE+o1hmpVPKcZkIuuxeOvHyxwqM2ajc6/LmyOrOpGhWOjt5yIzseH1rT4mDGRSG
	IERb0ev41DdpwAds8aUqlrRU/3Sc7M/OBQFEFj/MkBgtYDYuGyyFc4urqSPw7o2y16ic7pWmCq4
	8KsaKagBKIL546Fna4WyDztfZnGAyydWgxfBLw6WfuBO4NVdEjGFyX41H1peJCkuR5yAZ6u+IGA
	oYm2tbCUvHc0+X3FF362FUq2IOWKrBEPBa0Aq24WGJad9xK6mTDUCCZYQ5qCPN4TqbJQPF8O4dI
	s035yrvwnc4veqKTxHjBclTHskBPvAyV2Tq366mBNOnwWeIyH0TZR8F0cogGE26yfo1jz2BzidC
	rWry+c8kHOYjzP/1modMw0Gf1i+d/XcjB6qYwdsKquvYFFC2yZ5LiJRIlSi9CQ=
X-Received: by 2002:a17:90b:582f:b0:3a6:e159:a229 with SMTP id 98e67ed59e1d1-3ae40443725mr1880815a91.49.1793119015745;
        Tue, 27 Oct 2026 09:36:55 -0700 (PDT)
Received: from DougS18 ([66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc90d74sm3015675a12.20.2026.10.27.09.36.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:36:55 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Zak'" <zakbrightonknight@gmail.com>,
	<linux-pm@vger.kernel.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc: "'Len Brown'" <lenb@kernel.org>,
	"'Viresh Kumar'" <viresh.kumar@linaro.org>,
	<linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
In-Reply-To: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
Subject: RE: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume without HWP
Date: Tue, 27 Oct 2026 09:36:55 -0700
Message-ID: <001101dd6631$6167dbd0$24379370$@telus.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG+ka4iSAouj32QbdBtcmCOlo9WerdPO5KA

On 2026.10.27 07:37 Zak Brighton Knight wrote:

> From: Zak Brighton Knight <zakbrightonknight@gmail.com>
>
> On a ThinkPad T520 with an i7-3840QM (Ivy Bridge) running coreboot,
> the CPUs stop using turbo after every suspend to RAM when intel_pstate
> is in passive mode with the performance governor: they stay at the
> 2.8 GHz base frequency instead of boosting up to 3.8 GHz, until the
> policy limits change or the system is rebooted.
> 
> During resume, the firmware sets each CPU's P-state request register,
> MSR_IA32_PERF_CTL, to the base ratio (28), and the kernel never writes
> the requested turbo ratio (38) again.  Without hardware-managed
> P-states (HWP), intel_pstate caches the last P-state it wrote and
> skips writes that would not change it.  In passive mode the cpufreq
> core also skips requests for the frequency it believes is already set
> (policy->cur), because intel_cpufreq sets CPUFREQ_NEED_UPDATE_LIMITS
> only with HWP.  Neither cached value is updated across suspend and
> resume, so as long as the governor keeps requesting the same P-state,
> as the performance governor always does, the register is never
> rewritten.  Governors that change the request often, such as
> schedutil, mostly hide the problem.
>
> Fix this by writing the cached P-state back to the register in
> intel_pstate_resume() when HWP is not used, as is already done for
> the HWP request when it is.
>
> The problem was found and root-caused, and this patch was drafted, with
> the help of an AI coding assistant (Claude, by Anthropic) during a
> performance review of the machine described above.
>
> Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
> ---
> Tested on the T520 (i7-3840QM, no HWP, coreboot 24.08 with SeaBIOS)
> with v7.3 plus this patch and a temporary module parameter, not part
> of this patch, to turn the fix off.  intel_pstate.c is the same in
> v7.3 and in the base commit below.
>
> Each row is one suspend to RAM and resume (rtcwake -m mem -s 25).
> "Request" is the P-state read back from PERF_CTL on all eight CPUs
> 5 and 17 seconds after resume; "clock" is the measured speed of a
> single-threaded busy loop.  Before every suspend, all CPUs requested
> 38 and the clock was about 3.8 GHz.
>
>  mode     governor     fix  request after resume  clock
>  passive  performance  on   38 on all CPUs        3.8 GHz
>  passive  performance  off  28 on all CPUs        2.8 GHz
>  active   performance  off  38 on all CPUs        3.8 GHz
>  active   performance  on   38 on all CPUs        3.8 GHz
>
> The passive-mode failure was also reproduced twice on Fedora's 7.2.11
> kernel.  In active mode the request was back at 38 after resume even
> without the fix, so on this machine the fix only makes a difference in
> passive mode, the default without HWP.
>
> Not tested: systems with HWP (their code path is unchanged, only
> restructured), other machines and firmware, and suspend-to-idle.  The
> patch adds no warnings with W=1; sparse was not run.  The tests were
> scripted and run by the same AI assistant.
>
> drivers/cpufreq/intel_pstate.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 17158cb..53db91a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1371,6 +1371,7 @@ static void set_power_ctl_ee_state(bool input)
>  }
> 
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata);
> +static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate);
> 
>  static void intel_pstate_hwp_reenable(struct cpudata *cpu)
>  {
> @@ -1404,11 +1405,20 @@ static int intel_pstate_resume(struct cpufreq_policy *policy)
>  	else if (power_ctl_ee_state == POWER_CTL_EE_DISABLE)
>  		set_power_ctl_ee_state(false);
> 
> -	if (cpu->suspended && hwp_active) {
> +	if (cpu->suspended) {
> 		mutex_lock(&intel_pstate_limits_lock);
> 
> -		/* Re-enable HWP, because "online" has not done that. */
> -		intel_pstate_hwp_reenable(cpu);
> +		if (hwp_active) {
> +			/* Re-enable HWP, because "online" has not done that. */
> +			intel_pstate_hwp_reenable(cpu);
> +		} else {
> +			/*
> +			 * PERF_CTL may have been changed by the platform
> +			 * firmware, but it is only written when the requested
> +			 * P-state changes, so restore it explicitly.
> +			 */
> +			intel_pstate_set_pstate(cpu, cpu->pstate.current_pstate);
> +		}
> 
> 		mutex_unlock(&intel_pstate_limits_lock);
> 	}
>
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> -- 
> 2.56.0

I confirm your findings and tested your proposed patch. It all worked fine.
I had not seen Rafaels's reply about a possible race condition until now.

Test computer: i5-10600K, 6 cores, 12 CPUs, HWP disabled.

... Doug


