Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1583B27E7;
	Tue,  6 Oct 2026 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281245; cv=none; b=BXkMdtRA72ksOC/bgWzuvP6EwiO1AHz5octJgSTCJ8QGsYwbo49QyjM+x7ZbXYtcA606kmcDb/s9/OvGawGCQ3BTwJiRRS0LZz/Ep5waq0RGVGPMQs3Inx0IoGG6fKf/yZnw2VrFNhBiI8K+WIORP1q7IqQo3sqjwUTSRCqAoew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281245; c=relaxed/simple;
	bh=pxeVVIHNnlWwD6xFFtuu1+vHeopqEeuP1HyhH2p1Mh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1vV0vEpo+CChATjTLa25xrcf8D4R0zdVMHmKiYnQ1YJ9nywHH1jcQGda4EU/IweoHbKggxcAsF9k5BOJy3qbklehbxxTikOtX7kvs86otFa30oklNzUQfWs5Pt/UlN/4pe1zepUt5TrBfdS8Xc/SJbhKpYyQMTxLxCWtP61ly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nszWfxxU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nszWfxxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE2E1F000FF;
	Tue,  6 Oct 2026 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791281241;
	bh=qUF+033+/7SK+YgWY0SC+6O8QQFqvbHIyTFHI7FQAlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nszWfxxUcE/Q9Namhuvv2MlvaE6iPZcX4IhoQbECsAtThGqIjZUT0W8v1HAkIr3TH
	 P2UVdEG/+GOGJbfPkEuAsqqBiZfDaW/AKi/dZdVgO+wiDgu7zFwr1KYYzyCxerZbtK
	 m3I77Kf7aukC/PW0eRvHZyUUzxCoWjJ8CuYlqtTm3qzJW1rHfDaiEgeFHW52ziMKP3
	 huQ+BHtdpvIudNaiYNfmQnSr6OFIRezvSK9AVGW14dCnlgKGpptKak8Hg9Dzn8iguq
	 mQA4c2TD/3W28CHzwSQXtXrjdNC3HWwGLA6ID2rRnQxJaS37G63P/e6k8PKIaD0DtV
	 oKaEynT4xl1gg==
Date: Tue, 6 Oct 2026 11:07:16 +0100
From: Daniel Thompson <danielt@kernel.org>
To: david@ixit.cz
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Kiran Gunda <quic_kgunda@quicinc.com>,
	Marco Mattiolo <marco.mattiolo@hotmail.it>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Joel Selvaraj <foss@joelselvaraj.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 3/4] backlight: qcom-wled: Fix unbalanced OVP IRQ
 enable at probe
Message-ID: <asTIVMnldeyS4T9p@aspen.lan>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <20260921-qcom-wled-backlight-v4-3-bab8c7ef73cb@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-qcom-wled-backlight-v4-3-bab8c7ef73cb@ixit.cz>

On Mon, Sep 21, 2026 at 12:46:24PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
>
> wled_configure_ovp_irq() derives the initial state of the OVP interrupt
> from the hardware:
>
>         /* Keep OVP irq disabled until module is enabled */
>         if (!(val & WLED3_CTRL_REG_MOD_EN_MASK))
>                 disable_irq(wled->ovp_irq);
>
> but wled->brightness, which is what the rest of the driver uses to tell
> whether the module is on, is left at zero.
>
> On boards where the bootloader hands the kernel a lit backlight the two
> disagree. MOD_EN is already set, so the interrupt is left enabled, while
> wled_update_status() still believes the backlight is off and takes
>
>         if (!!brightness != !!wled->brightness)
>                 rc = wled_module_enable(wled, !!brightness);
>
> on the first backlight update. wled_module_enable() then schedules
> wled_ovp_work(), which calls enable_irq() on the already enabled
> interrupt:
>
>   Unbalanced enable for IRQ 176
>   WARNING: CPU: 0 PID: 160 at kernel/irq/manage.c:774 __enable_irq+0x50/0x80
>   Hardware name: Xiaomi Pocophone F1 (DT)
>   Workqueue: events wled_ovp_work
>   Call trace:
>    __enable_irq+0x50/0x80
>    enable_irq+0x48/0xa0
>    wled_ovp_work+0x18/0x24
>    process_one_work+0x1d0/0x350
>    worker_thread+0x13c/0x460
>    kthread+0x110/0x114
>    ret_from_fork+0x10/0x20
>
> The bootloader is not the only way to get there. The readback runs after
> wledN_setup(), and wled4_setup() sets MOD_EN itself on the path where the
> sink configuration does not already match, as does the tail of
> wled_auto_string_detection(), which all three setup paths can reach
> through wled_auto_detection_at_init(). A cold-booted board with a dark
> panel can therefore reach the same disagreement.
>
> Move the MOD_EN readback into wled_probe() and use it to seed
> wled->brightness, so the driver starts out agreeing with the hardware,
> and key the OVP interrupt off wled->brightness instead. The first
> backlight update then only reprograms the brightness registers and
> leaves both the module and the interrupt alone. The OVP interrupt also
> stays armed from probe whenever the module is already enabled, rather
> than being disabled at probe and only enabled once something writes
> brightness.
>
> Note that a backlight update requesting brightness 0 before any non-zero
> one now really does turn the module off wherever MOD_EN was already set,
> where before it was silently ignored.
>
> wled->brightness is seeded with default-brightness rather than the level
> the bootloader actually programmed, so the first update can still step
> the brightness. Reading that level back is version specific and is done
> in a follow-up, to keep this fix small enough to backport.
>
> Assisted-by: LLM
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
