Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D94376BEF
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488196; cv=none; b=K7TObA9YInCUCTnZuR4aJMFtoxPgIE6N+k4zQsa3AnVEkdSJEJkK4+GoW+5W305JA5Q7gk43wQa1tf/2E8eSzh3Mm+xjjR8qYfC/9fLCsoJgWt/Wk/F9TuyvlQ/YuMI4yCRJEzfx1t9Kz/3XuQGE0E9UIOfU0jgR8zSG4O/7kuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488196; c=relaxed/simple;
	bh=XpErQYep/sEYaSMh6bYN8xvmBlCShL1TZsxRcX0CzMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ce9y1hNLdr90P71kkTtt6DCkcaBPMV/HsWgVb7kGV6uUxuQ4CCo+RhzPip+rHpqZekSgh6avYRsaDbDgR1THbsHe8oUN5OrVNuiy90ndDOS0qzYwS2KmpzEDv62CgWMdEPTk8r07dtCSztvsJeyMv+UY9DX35aAbFy/qzRE4Mkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e16YmHLA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e16YmHLA"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46cbe01d4b6so622372f8f.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782488194; x=1783092994; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3wju1nuJQQNOozjS4LCACsNlNv1GsNdXvUWGNBenTE=;
        b=e16YmHLAWAnFZBnbC8jGevCEtqszVQqblCDqjau8MfOz7Ys6XiStx0Fuf89XIh+6hs
         HZVNj54D8E5bld4haWxdNW9RmiNLwmsX+JvwWITHzUlpXXFu0E/NiNQp8sn++Z8sj+ot
         L7O3rDV8Jb8En7MrC6CMrm8zZcB1NXEfABS59AwlNa0ko5ApJYxs+LXlvA1xocBFqNlU
         FtBwiY+reNBBDCLpxAOtyqK4bkbIAHNRdzRfyIFtvbcGNenoXUe79zE5kyBcI1UmlLiY
         b6QlcD8gdO8WCqdNnYE6g2QhMM+Tiy5FQS0PsrdpsG4vUuUaerW7m7Xj/JaFrvVl40Mg
         DBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782488194; x=1783092994;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3wju1nuJQQNOozjS4LCACsNlNv1GsNdXvUWGNBenTE=;
        b=iUKpNAFE3acraCL23amD0D2pai5LDbwV023MaAKZJzsGYfmT0o9ItQxrnFV1soUEDe
         b7eJplRcPulhKRsmABtcI1PrsDvbr7nQo38aj0IAVtZfCwCVMqFxIcsEygb/EvAGujFk
         aPBPlEshoCSx/J6Ii/Bz1h8T8ad+YEs6FYTRzSw0XtC1jW4yzod2msbraE5a/eindMuJ
         IDYoiqqNV65pE394VLimfVzRnb12nTZAfZ+xqVe9Azgp4kmK8i2c1WVtaVTj2uNNJwrE
         TlvK01MQBCzaEV4mVss4wa5lNjLByzKghLx8dwby4a+dlIeAUXZKwAfiiNnUIeaQIcgr
         HA2A==
X-Forwarded-Encrypted: i=1; AHgh+Rr6H+F1nWg++fOfQ0VpxiIPNUMlr3fAdT1ut5JKT8mah4Cm7o0tpJ+s/8renvSqTALsalgicBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2azZA8Rb6dsvI14f9p6MvPYUaFywyFRbsvLwYceHAVFDS4lPU
	iNGpfaOdkQ8qCyg6uNaj4B8l3sM580PJm7EP6FetkYP3r6BUJCHTZVQ=
X-Gm-Gg: AfdE7cmq5oLc6Yr+9vYktkf4rV6lMLVbMIsslhr590jhTvg2GOUDeTvHqQ3yICqkVnS
	ue63bSncRZgF9KJu/Re8Zv4mgTRW/O6mQBECqGLpcmx/1EWxT6jtcwVtl21K69VQiwzyhK43ZTF
	Uw1mVrCHje/W790oEtGch6gT5pWI+q1RQ8BrY4jniReQdDOhhXv5l14rwl9B0e+ewGMVpF+eMov
	WZfSrSxMiIGWeE/q2mwiJaTW7wnWkzDFqOEHLT7ZH/9OFo3Agimor4oTnSKJIxgQbFWQD0cF78h
	ew898TyuesUhlFO7Dya3EB0QZJA6AMU3EYvJKq3v/Lm2UIneNPNpfCT2iv0lJ6skDBImfXZP2ZX
	u6plu5fBzsSBeNUrJpzXmh9LMqadHCgz+uCBMSP++hBYbziY/MguOkhGbvlgyE0mZ4c262jFpnt
	yZ1bMZLL94EylFrM4sw9LKG/uz2VA=
X-Received: by 2002:a05:6000:41c9:b0:461:fefc:251 with SMTP id ffacd0b85a97d-46dc263b112mr12847506f8f.29.1782488193544;
        Fri, 26 Jun 2026 08:36:33 -0700 (PDT)
Received: from kali (88-170-213-78.subs.proxad.net. [88.170.213.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1b754471sm24974281f8f.0.2026.06.26.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 08:36:32 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2] profiling: don't free prof_cpu_mask on init failure
Date: Fri, 26 Jun 2026 15:36:31 -0000
Message-ID: <178248819183.3242446.8706480116416421586@gmail.com>
In-Reply-To: <20260624181113.8b2aacf9b1466205c8f2cf05@linux-foundation.org>
References: <20260621192324.2062795-1-tristmd@gmail.com>
 <20260622000022.3375262-1-tristmd@gmail.com>
 <20260624181113.8b2aacf9b1466205c8f2cf05@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 24 Jun 2026 18:11:13 -0700 Andrew Morton wrote:
> Confused.  Current mainline has no free_cpumask_var() here?

Correct -- Tetsuo's 7c51f7bbf057 ("profiling: remove prof_cpu_mask")
removed the variable and all its references in v6.11. This patch is
for 6.1.y and 6.6.y where the old error-path free is still present.

> If we're to deliberately leak the mask here then let's have a little
> comment explaining the reasoning, so we don't later receive "profiling:
> fix memory leak" patches.

Good point. I can send v3 with:
  - a comment above the return explaining the deliberate leak
  - corrected Fixes tag (c309b917cab5, per Tetsuo's review)
  - stable-only framing in the commit message

Alternatively, Cc stable on 7c51f7bbf057 would also fix this, though
that commit removes prof_cpu_mask entirely, adds mutex serialization
in ksysfs.c, and drops the hotplug online callback (2 files, +13/-40).

Happy to go either way.

Tristan
