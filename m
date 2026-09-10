Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808261F938;
	Thu, 10 Sep 2026 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022849; cv=none; b=Ecl7c2UpEuFuOfG02II8miTWis5I96hnE382H+Ne+/WkuGljs5XhyV0IN2zb20YEDrh5otx7aT0uIiAmRs+EAzBROVRfc8EM1Rot8xsatiN2AafOcK4nZhXsr4bHsvgKDuOiYvymnLIF/NVWTq+zlSqZhVm09RSxDhZ7wMZnR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022849; c=relaxed/simple;
	bh=YWyd4+aTptKxFnnudx/oNX86Rr5QbOE1dz+qPzB/P3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH04FIfxVaLqEUSKj2d7FKF13LrWTuDpoTj/v/9i8vXTJgX7dfun/+R+tlcJouCeF/d0GnY5DcfOQXXvgSJrTGTe8bkeXNgo13J6akXg8yV1wrw+su0Fslsd8JAd5qU/K5Wr9bKnpiPTi3rt5xE5dNUUGn6Y1IwcxqxyuGqZD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JEP2GRUh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JjuqFWsA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JEP2GRUh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JjuqFWsA"
Date: Thu, 10 Sep 2026 08:47:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789022845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TeCdhF7Yub4R/46hTdO2r+79dtJz2WzZGwh+bE6OaSE=;
	b=JEP2GRUhQsVhun7vbhk1q9LvyAQfQP6zlP59QQ16UqndaplL5J/G1L3Q+pLm/IA5W5OJku
	W/nUmdYFWR5TLyN15PGS1CMsPN8/0FNOpSGJHyvEzM7d6V0chIl/yzSOesYtohM4TDoNMo
	Uc6H+6gOWG9BpmB3KsKMez1osxj9vsavovGbs4Uj4GwHaHRnyCKJGm78K7YvoFbGtPmACJ
	JvA/ljnPgvtFoPvj54Tf0jnyxMy3E2ra3Ua3ZNnPPqrP6klllygp9kN3Mbl5lxV/sfyuU4
	ILvdjhY+ewOr6EWAX4JO6U1B56pXnwzeoKLjH1g5hgXrWDipe16LFxcsVsvnSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789022845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TeCdhF7Yub4R/46hTdO2r+79dtJz2WzZGwh+bE6OaSE=;
	b=JjuqFWsAOS0tHwzrdR0C9BlJ5ndwIJ8Ve/rzT3pLTGNtgF0OG43Wpyi8+mA/spQ3L/3McA
	Qo9UJmp7R8zCuyDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: vishnu.saini@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	Sravanthi Kollukuduru <skolluku@codeaurora.org>,
	Archit Taneja <architt@codeaurora.org>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Chandan Uddaraju <chandanu@codeaurora.org>,
	Rajesh Yadav <ryadav@codeaurora.org>, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	venkata.valluru@oss.qualcomm.com,
	Naman S Thaker <namathak@qti.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm: split DPU core IRQ handler under
 CONFIG_PREEMPT_RT
Message-ID: <20260910064723.pbZP3vic@linutronix.de>
References: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>

On 2026-09-09 14:22:16 [+0530], vishnu.saini@oss.qualcomm.com wrote:
> From: Naman S Thaker <namathak@qti.qualcomm.com>
> 
> On a PREEMPT_RT kernel, dpu_core_irq() runs as a true hardirq handler,

*why* is this the case. The code you replaces adds some ifdefs around
request_irq() with 0 as flags. This does not make it run has hardirq.

> but it dispatches per-encoder callbacks that take sleepable locks
> (spinlock_t becomes an rt_mutex on RT, and some DRM-core locks reached
> through vblank/CRC/writeback handling are sleepable as well). Sleeping
> inside a hardirq handler is not allowed and eventually crashes the
> display, which is what happens after running GLMark2 for a while.

That is correct. That is the irq handler are threaded by default and
only non-threaded if explicitly requested.

I suggest to stick with non-threaded by default.
There is only one request_threaded_irq() as far as I can tell and this
msm_dp_display_request_irq():

|         rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
|                                        msm_dp_display_irq_handler,
|                                        msm_dp_display_irq_thread,
|                                        IRQ_TYPE_LEVEL_HIGH,
|                                        "dp_display_isr", dp);

and its primary handler will be threaded on PREEMPT_RT, too. So you end
up with two threads here.

Sebastian
