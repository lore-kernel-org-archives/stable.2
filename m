Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370376;
	b=JVg6bMap/lvKb8HSFNGq9MveBdlfBCK/IVIgqkxzh0SnE6xTqmSCx6XUYjuKBmcpaWdB
	 ahMreAtEsbtvnY1FDqWzLnbYrFvGZKYZtFNyneeAKhx2cJsnwJ/dm1+oXmUvDQDpsZmKM
	 ZbCsWzWD1sHtuTdON4lUH+YCs5trbwF9nhoi5y2bgxm8WUdSIe2ocwY2tXT/8BBah9zJL
	 c250m9ywDmRs6UaURuN2zsp9uviU9iiknvm0KeJ76PYzYb+davyXJGqfqHkwzg1KQU9W+
	 E5PkzoAYvoSA90JlYGV4Clw3QCUhGfYtv1L/ztLGWsljS+Sh+D7Irovia/ATxMJzGMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=kRG8CHsOFvzuA+tHkN4sv4XPLOr4+r/vBSrY1/yx2Nw=;
	b=dHC83PCsMi1QO9ZgjYX9xJ8b+NRLuaqB/ly4dDJPn4msflfZ6XyXszpMkzTc/lRdTeDe
	 qUzQtn0ORftoXBeuxL575g4XIvAtxtrJn67Ghmx3lGbWuxXEFAcTMJrB0rYgrh/WcZ3NB
	 2ni6qJ1ZSzL99DtcjwXZAhYHoGpstrH/Hz+QZQz0B2WTxPMBUwaUidtrDwvxI2pXMowl2
	 CUkgg8AD0MQOw5C7wjCJoAidMykMG5yfH7dbT1OZr5stWdibtsSWzjyUMUKhChepyHz+O
	 ND8ynGpMl8JiyXUX74YQEXrurUiOyzMQW9LBpmtel4AM/zn3rPISRNgxuG01zv46xyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qVJ5rxXq;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F958606A32C
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 17:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F958606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qVJ5rxXq
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5677294eec.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795370375; x=1795975175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kRG8CHsOFvzuA+tHkN4sv4XPLOr4+r/vBSrY1/yx2Nw=;
        b=qVJ5rxXqnS1fjgjpNp27xj5ZpmGhDJHHUxsU/JQcEVQwffiESTTdoknttaATciXmpe
         StsjSRH3B0sokcr5x5thT6B0cyQFRNIsqQ4h+w3N33c3ftRucp9X0N2bO7goWi0/4WY+
         7PEDc9NY0UPJtEuuCcLVIHzreMnMp4rI/vWQex3QjNmEPmMyZ0wWa+IyPQvd7hpDmJMw
         9HTOEdhufNe1uza7HWFBUC84H2A0iFjVIuqoogxkuQERLH8L3m/GDSsUE5Cr15MF2IZ6
         3RYF1x0p8TrhRb5dQXvVAVod2gzAfO2a/g7V2cK0qla5u/WwNOVWLsr6MS5oZ8NazMx+
         vNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795370375; x=1795975175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRG8CHsOFvzuA+tHkN4sv4XPLOr4+r/vBSrY1/yx2Nw=;
        b=HEMlaGTjo3FoaZu7qkpP8AtREmIwJRzBP+1M3WoCxV/fHwVpr4wAG6CfLlnQ3cWora
         5xz4LHqVwD53SYCSKI6E713A6qsHAvPFH1CjNRy+6x2S0nBxDEH57w1NEsf2Nup8wqcR
         imfzzo4M1KDlxCThsRHgdHLmO4eLYh7zX176ybhoUO7KGYMJtZuLKko1TXoH9kVpoGYY
         NP88D9dIqvqx5yP0n/YY9lKqHhVqxsOsegpldS/8VGtK0MmD7AQvWCkjSSk6WyRBHiwU
         fg7Hf96mYg4x8GQXw3hrqqVKFiwKRa6wfCYWQaN1i2goHYSLnH8zxzJ/Yq6xNgHBpMXh
         phvQ==
X-Forwarded-Encrypted: i=1; AL+hErEHuG5qVh1ZGI/zYcnxL0FGBAGENk7BAxejqaXyRr2i8xbf838ckw48z0DmfnPphwIByCgfcbE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+QtuUJ32E3r83Ock9uawEEFCAaME1hIodCPERGAKinSXGw5rB
	bSzjHH/g/RW43wLfU1bQYmS+fpkj5avCpnbOR0DNbjKywWjJ9yKGATvB
X-Gm-Gg: AZFdTZef6YNJm8rqy4RLLlfV6DbgZP+T01gy1bUqka2FIqn2PYTwSXV1/348JnvRpRI
	IPWWlq/YiEkqfa9g9CPzaAtmwm7srJQcqx9rf1PFGbFM7Zmc5wuUysuG467TU56RcQCA8gfayMn
	Lg6a7ptrzNaif5ZOnRvBNOF77d+Z9UphYCI2n8ZYDm8/AwSHIqgtZlN4ho/dDa+Ye6zwslMrvYX
	InWckq77tIdGmrfkq1AkhkEwu7CSk0Mof3d/Aj6x9T4KnRomQcDzoK6xZCFiuCPX1zsBU8aMfDK
	DTSfLM/tb0ICC36Bno5zHRq1pR7a4TtKT4owXOejO2nyndQxYUdO0I+39oEXkz9XC+m7fFHuxS+
	y6xmTsMuZnATr7hkogtT81t3hxMFn/+iTrt2JJPKKQHnHbBLwo1KuYg2nJMvA/HK4rXjtsVSKwf
	BcuKUMpy1h9zccxyqqnNOWSRukzXECigo3mcWUmSPp813wkRZwQkAHwP3huBLB3f4L0ON6LrHb4
	7lAMnlb0Wf+igwSVcT5sQ6FnFv8opfbKtpGYPpOUu4aCWuzH15h4ro6BBTr7FJQcBCLM8CPvU1Z
	zRjP39DXIrT+SROBimB7iayNPivtUr7fj2bxtJnDrHf/s+a73ewiNA/dKCdILXPCD4k6pXgcd13
	sEOOsWkKLlFpBAPXnJEcz2Q==
X-Received: by 2002:a05:7300:f68e:b0:369:f291:49da with SMTP id 5a478bee46e88-38571814b1dmr9847720eec.40.1795370374954;
        Sun, 22 Nov 2026 09:59:34 -0800 (PST)
Received: from archlinux ([2405:201:1b:2287:f57:f0d3:878f:6f93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm29194449eec.12.2026.11.22.09.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:59:34 -0800 (PST)
Date: Sun, 22 Nov 2026 23:29:12 +0530
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: David William Richmond Davies-Jones <david@exultantmonkey.co.uk>
Cc: platform-driver-x86@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp-wmi: Enable cTGP in performance mode on
 OMEN 15-en1xxx
Message-ID: <awMir9K1nuO772x4@archlinux>
References: <20261030005724.84507-1-david@exultantmonkey.co.uk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261030005724.84507-1-david@exultantmonkey.co.uk>

Hi David,

Thanks for sending the patch.

On Fri, Oct 30, 2026 at 12:57:24AM +0000, David William Richmond Davies-Jones wrote:
> On the OMEN 15-en1xxx (board 88D2) the GPU power limit stays at its
> 80 W default in every platform profile, including performance.
>
> The firmware's SET_PERFORMANCE_MODE handler (GM1A in the DSDT) stores
> the mode byte in EC register 0x95 (HPCM) and enables NVIDIA cTGP through
> the NPCF device only when that byte is 0x01:
>
> 	If ((HPCM == One)) { NPCF.CTGP = One ... }
> 	Else { NPCF.CTGP = Zero ... }
>
> 0x01 is the thermal policy v0 performance value. This board reports
> policy v1 (byte 3 of GET_SYSTEM_DESIGN_DATA is 1), so the driver sends
> 0x31 for performance and cTGP is never enabled. NPCF only reports the
> cTGP offset to nvidia-powerd (ACBT = 0xA0, i.e. +20 W) when CTGP is set.

This is interesting because the patch does not make any changes to the
HPWMI_SET_PERFORMANCE_MODE path. So, if I'm following correctly, the
call tree would roughly look like this:
platform_profile_omen_set()
   platform_profile_omen_set_ec()
     omen_get_thermal_policy_version()		(you say this returns 1)
       switch-case (performance) => tp = HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE
       omen_thermal_profile_set(0x31)

So perhaps policy v1 is not entirely wrong? The HPCM == 1 check in GM1A
only tells us how this particular method handles the performance mode
value. Have you checked the other consumers of HPCM, particularly GM22
and the NVIDIA-related SSDT methods? They may interpret the v1 value
(0x31) differently. Given that the firmware reports thermal policy v1,
I'd be hesitant to conclude that it is incorrect based solely on this
check.

> For boards in a new omen_ctgp_boards[] list, set cTGP explicitly with
> SET_GPU_THERMAL_MODES after setting the profile: enabled in performance,
> disabled otherwise, with Dynamic Boost (PPAB) left enabled. The Victus S
> code already uses this command. platform_profile_omen_set_ec() is also
> called at probe time and when AC power returns, so cTGP follows the
> profile in those cases too.

The diff follows Victus S code consistently. However, have you considered
adding an entry to hp_wmi_feature_boards[] and using the corresponding
omen_v1_legacy_thermal_params mapping instead? I'd prefer reusing
the existing feature-board handling rather than introducing another
board-specific list for functionality that already has an implementation.

If I'm not mistaken, board 88D2 should also support fan curves, right? By
keeping the board ID in omen_thermal_profile_boards[], wouldn't you also
be missing the manual PWM mode support?

> A report for the Victus 16 board 8934 shows the same HPCM check in its
> GM1A method, so other v1 boards may be affected. Only 88D2 has been
> tested, hence the list.
>
> Tested on an OMEN Laptop 15-en1xxx (board 88D2, BIOS F.20, RTX 3070
> Laptop GPU) on AC: nvidia-smi reports a 100 W power limit in
> performance and 80 W in balanced and cool. Without this change it
> reports 80 W in every profile.
>
> The firmware analysis and this patch were prepared with the help of an
> AI coding assistant (Claude Opus 5.5 in Claude Code). The result was
> reviewed and tested on the hardware by the submitter.
>
> Link: https://lore.kernel.org/platform-driver-x86/CA+LW3S2g4E971by7WhfFZGuyLT47141_Zn+eJ=wyqxB_+4G95A@mail.gmail.com/
> Fixes: 286e937efbc7 ("platform/x86: hp-wmi: support omen thermal profile policy v1")
> Cc: stable@vger.kernel.org
> Signed-off-by: David William Richmond Davies-Jones <david@exultantmonkey.co.uk>
> ---
> drivers/platform/x86/hp/hp-wmi.c | 34 ++++++++++++++++++++++++++++++++
> 1 file changed, 34 insertions(+)
>
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 52077833ac89..e09a6d261144 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -235,6 +235,14 @@ static const char * const omen_timed_thermal_profile_boards[] = {
> 	"8BAD",
> };
>
> +/* DMI board names of Omen laptops whose firmware only enables NVIDIA cTGP
> + * from SET_PERFORMANCE_MODE for the v0 performance value. With v1 values cTGP
> + * stays disabled, so it has to be set with SET_GPU_THERMAL_MODES instead.
> + */
> +static const char * const omen_ctgp_boards[] = {
> +	"88D2",
> +};
> +
> /* DMI Board names of Victus 16-d and 16-e laptops */
> static const char * const victus_thermal_profile_boards[] = {
> 	"88EE",
> @@ -2035,6 +2043,17 @@ static bool has_omen_thermal_profile_ec_timer(void)
> 			    board_name) >= 0;
> }
>
> +static bool has_omen_ctgp_control(void)
> +{
> +	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
> +
> +	if (!board_name)
> +		return false;
> +
> +	return match_string(omen_ctgp_boards, ARRAY_SIZE(omen_ctgp_boards),
> +			    board_name) >= 0;
> +}
> +
> inline int omen_thermal_profile_ec_flags_set(enum hp_thermal_profile_omen_flags flags)
> {
> 	return ec_write(HP_OMEN_EC_THERMAL_PROFILE_FLAGS_OFFSET, flags);
> @@ -2045,6 +2064,10 @@ inline int omen_thermal_profile_ec_timer_set(u8 value)
> 	return ec_write(HP_OMEN_EC_THERMAL_PROFILE_TIMER_OFFSET, value);
> }
>
> +static int victus_s_gpu_thermal_profile_set(bool ctgp_enable,
> +					    bool ppab_enable,
> +					    u8 dstate);
> +
> static int platform_profile_omen_set_ec(enum platform_profile_option profile)
> {
> 	int err, tp, tp_version;
> @@ -2096,6 +2119,17 @@ static int platform_profile_omen_set_ec(enum platform_profile_option profile)
> 			return err;
> 	}
>
> +	/*
> +	 * Enable cTGP only in performance mode and keep Dynamic Boost enabled.
> +	 * dstate 1 means 100%, as on Victus S.
> +	 */
> +	if (has_omen_ctgp_control()) {
> +		err = victus_s_gpu_thermal_profile_set(profile == PLATFORM_PROFILE_PERFORMANCE,
> +						       true, 1);

Why enable Dynamic Boost unconditionally when the firmware would almost
certainly disable it in case of low-power/equivalent modes? Wouldn't it
be better to make PPAB follow the selected platform profile instead?

> +		if (err)
> +			pr_warn("Failed to set GPU cTGP state: %d\n", err);
> +	}
> +
> 	return 0;
> }
>
>
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> -- 
> 2.56.0
>
