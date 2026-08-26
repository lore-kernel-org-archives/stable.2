Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780233B71C7
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732092; cv=pass; b=BIaOc/dHM0a8FLjorw11oHpL4t3lG/aKB0YGg9qd6nPQAIU+7Gq3UgckZvVDPwfcTaK1PtqANYPp0bQ9X4BDZV3F5nFtSK7S+UZYzMjNg9Tm7sX0WtIs2uDSyUVzSoeeWpz8NwhDJSRyJhTLBmP7nxEN8Z0qiQXUTKdteUEiIdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732092; c=relaxed/simple;
	bh=xIxBYCYXrUwbfUVAMqtAFWJ5BtNBzO9WfalZVCTYmfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jV27SuLw6j6bdsFxel8eXbnYHzrmOSJ28Irk69k5uwjW7DQeMiod7j/PcGBcejH8zWroURD8pZ4olAMzVCSRdoPYcBehNK7Gzx66F+oD2Lk9h/Xda7TN2pTiy0qLlpEMKRX0NBj03qkuiDhm1Ebamd9h1nj39GVHOy49VC+b5iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjyRTVKp; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjyRTVKp"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66d25d77713so562137d50.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787732090; cv=none;
        d=google.com; s=arc-20260327;
        b=OuRKSHQKBueJ4O2kHQwimaNm+3sbXTa+8MixD6Q77DXs3ASxOaJk0U2pAzvBq4nYDK
         /N871hfwecG0Z+gcucj/6bNjQ0aj5CLLLkqqzDH1rkun2g4Gt38QEOojEJgQtEBTVbWk
         XYX0AsuJeZwCyLFlcIXDeq0sVXtrucIY626X/AyKFK2+Cpfp/BHIPSAdSO/C5e8pVauv
         eXL9SsxyE/QEEOusRksMHuIY0MJJCrpmgDoMX+rUw0Yo+Iuyeb0t6wcWzzZRP5bWoBFJ
         r29yM+Dil0xHrPvkOh2/Cd6kem2oTx4j86u8M/ubSCG2GHb5UF5DjYG9wYzb2GwZWqqJ
         OTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7HLmr/bZmXhN1LnAoM7xxjQ55vZGNiBeJumbqyRK5ko=;
        fh=I7Pu6lIJON3B61rGbnTsAv4U3x0dlFjSrlTBd8WrTVg=;
        b=hHnlALD9WfDb60ugEf+hDCY2fs2VZTElMWS86TkbtR7KL6Iy+EVisAeYiNK/USYXUX
         479QAE8OsgUpDqC5njldHI98SsraVc5dpnDlN6X7+QpPPR0xYGJ9gHNtRV9pfo8TGKqF
         g1q1WINiDm5eAdnZ/nFc5TgLYS1jgNrIlxmljyA6qWZUW9vHcFUzTvb9upXCM7qqx2Ii
         6SpeRl1nZJ2rKcrafNLRzr/vzZetmts9tjkgZtAjKg7kmt82VtSrZw5q186WTYqL2J2F
         8fA2MthvI32sc7v7bRrW+cUsOwC1RlSuZ/TRFI2/oX24E8ce8ujLBu8SYbcYtU5VHV43
         cxJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787732090; x=1788336890; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HLmr/bZmXhN1LnAoM7xxjQ55vZGNiBeJumbqyRK5ko=;
        b=cjyRTVKpK74FOlWr3ezfpkkMqTuX2lOhlZS1S/o/wPy/kx6WNu4fGoIb+CJVeJbY8/
         nZ/l9274WnyHVakBQR93E/OAYhhs7ioeP3Hs57FFXUzCqnyCiVJ7M1RQhzs3CQoJ89oL
         yKRadYCzyOmpZZvcdIf50V9hOSV99g0vQNuy1VqMSpl/fpgFA0YiF+ZeHHI8Zuv6gXJ6
         9H3TU2RsCOPbmp5KVpgjM7V6IHhKrNNPWtBuoRidamV+yY4CB69xprnrYfLMcw282k+y
         FjbJjYGnLF+J95NLgFDO8vvRQLcM7KJcHUhbdA+kxm8YdeTicuy0XoPRVBkqO8BFXOJX
         ip3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787732090; x=1788336890;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7HLmr/bZmXhN1LnAoM7xxjQ55vZGNiBeJumbqyRK5ko=;
        b=GFHqQGTYMv540QF8nZXlI5GrysUgI14t1sTN2v1IZ8b5O/ht+rsi2e27hEssP7tX/S
         5sFiVa54vbGPo0n3ovXVll0NRws1x9a2Y3GiGx8dAoKl4FjdOvqtsp3ZvF29bvyBEdtU
         1d8tW6Xnp8M5vBt5z7zc9R8hqKGZESI+ObDduVnUnnA3gqfdO/hAx6veM5mWp+d65mpY
         a5ZwfSR2gnrI0uAAqQ82aqYVnFCrx5/mmX1pFX2YEwi+rSqOPIpeMVE58LTXYqW6dFov
         aYyT+vmRRm7gImouSejLKffisaT8yKSPWLo7zTubu/DdOSpLcrKBe2Zp2Y4RwvcYXUQn
         lRiw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2+Ce/w/EtIGm/ced+OuE7R4EGxfp8xZhVfIU3RyxlOJon3ujxrN+ekDP4I7lGV0G5a32FYvA=@vger.kernel.org
X-Gm-Message-State: AFuF++n81IBzliSDjow8S6vnFO0nC6uAPwqibBOgiyHgnMbIRbC3h5J1
	/ARhPyLDdEAGVpnFOf8gLCPqvYcUg2woDW18VHXHByLng42HVDhXx54XH+iPZ4LevUIZpMsYr1y
	/RP03OR7rhkC9iJp68oOSUD80SGc42gA=
X-Gm-Gg: AR+sD12BVMcyKPLIIDWdTXhW2kKvYMfRE0HTHPWJlOrBRJhekcoHIqZWXgo9kx9ItHl
	8JzHCVpIu6XauF+vISxa/uayAEp/fuR1kpibgEMCyd4uQZm9u+wSeW3sBfsBab+q0uBZwMOZ4+Z
	EDosCuUdHvt6eI71Kk2SJwSwr1gQBevsV3b53xPiuYx5fjlewJUF3YaBVDfvZxDNrPCO49198Rn
	xOTHzkMVDfb9XUcVOc3bMKrtVrTYPb0FJ9I8+mTlB7skMGeOlcu9w/qoB5O9wjdYo1Si6XrlZs2
	DL6A6HPdcDYx/RRDoMNed7wuZD0X2eXmZETFPKdbtnZlT8A=
X-Received: by 2002:a05:690e:4550:10b0:66d:2b87:67d2 with SMTP id
 956f58d0204a3-66d2b8768c1mr231426d50.14.1787732090507; Wed, 26 Aug 2026
 01:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812085808.3313948-1-lgs201920130244@gmail.com> <0d9ba848-bef1-4171-ba1d-edc73e65ac51@kernel.org>
In-Reply-To: <0d9ba848-bef1-4171-ba1d-edc73e65ac51@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:14:38 +0800
X-Gm-Features: AcwNN1VMPCDnOAPyOQoQk5KlVx2oQz-exFCd0E6V9cddulgot8PqE_pvbCSMj3M
Message-ID: <CANUHTR9Sd6rQ-6GyWMu_q5ZzHW6uMYLrOFVRmZ2Qu7f4oXWwpw@mail.gmail.com>
Subject: Re: [PATCH] i2c: mv64xxx: fix autosuspend cleanup
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/08/2026 10:58, Guangshuo Li wrote:
> > mv64xxx_i2c_probe() calls pm_runtime_use_autosuspend(), but the probe
> > failure and remove paths do not call the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without undoing the autosuspend setting during
> > teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Call pm_runtime_dont_use_autosuspend() in both the probe failure and
> > remove paths before disabling runtime PM to properly undo the
> > autosuspend setting.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: e5c02cf54154 ("i2c: mv64xxx: Add runtime PM support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/i2c/busses/i2c-mv64xxx.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Srsly, one more separate I2C posting, just like you did for dma, crypto,
> drm and everywhere else. You seriously waste our time.
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
