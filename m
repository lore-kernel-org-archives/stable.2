Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835759;
	b=qtRHUvjsi5IR0ckkjlqTx6Y9Hg53aPp3LN0BG2gR3bkCzJdIFL5p1nq2WcVpFKhAZgac
	 hn5KgJh8GP1XFhh+jYdvMsI0rlzoKlXjeVeUDohyTPZwyjl2cCZqaa5RIuMEroaVTXIYZ
	 NIyEjo1JRwdAfS5IHdSGSY98zO1oZX5oeEHUgamAp+nssaUJpvoWzhpzDuUMOXUK4X9oX
	 0ufp/v2jRmUBD6hXgsRMeql5N1JRorIPvsPSvHtCL3pF8deGNRG64up2vQC4AJUfgFfiN
	 SMUHa3ryH182DkEmDUx8mEby3FS/nZXseDreJ5f4aeVmRrGBiA2IrWKu/igSL7FsfXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835759;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=r6p38j9xRjMManoVdnF8YwH9MjnXCYmBpcHmeo4ut8c=;
	b=iDdWSwiDzTH1J8H1CNJiuJT/G4fYcIvVYWY4r8YFPBMg5tN6iYN8G+p4iSjnkbju5kH7
	 byOEQ1AeR+FCxA/aZ4xseicpFbmdAxcb/Gnm9B1PPShqs/KtFXLNC7X6MvOU/ZZF70u0h
	 bX56GF8JChcwfgRXz/eCBjwcQLrGhDQUIrJvK2Ath4DUCLvY8IErjfWOruFfBgOpVnpso
	 EyZ39LDtReBLnKLyvqFQr7I4xjq7y7AedGscGVdVukxqQGGJSIZgBZ7Dyvv+zi9S9jQyt
	 R7BvsWu1SJ/wziDRxOoERJf7uij44bQmOT4mVr9OsmSojBS66l4BazmeBwyrUdXwo5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dVSkh3VE;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E717F606A31C;
	Mon, 16 Nov 2026 13:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E717F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dVSkh3VE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794835759; x=1826371759;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gtlLcuQj+VY6YfI8SxwEeWvbX0eUjlvE3Ra5rv33yzw=;
  b=dVSkh3VE88HVTvz+3qSeNQAC4Sqq+Uc9xP6WMSGJ6gWj8k1F6ZrzadyM
   9qa1zZq3uzagud/qg0ep2RYr7YvGRJwBwHKqpa/z/xgj7JfFeDy9nNhv8
   QGHXyIIKhCqrFJ8xHe7PSniJ3HrW+c6/C/U6AIJyodudSeTmWJOFTJ0II
   kR5AmjBEJOd2gotYJmJcg/Yc5l+tH6RYZp29ajpdAni8IgT7hihW4oT8w
   dD7iSWM3Kwe5wF0hycrJfdtjRyxigSkzsFhr8OoL3cdk0VLRDDpfEOECe
   JFkynsnNIxOF4/hC4mGZ2r1zkKg/22/Xg0fpYK2cvLUX880w8IhNuA5Lw
   Q==;
X-CSE-ConnectionGUID: Lku89+FARR61nU8z26abyA==
X-CSE-MsgGUID: WzzAehKWT6SSI5vH8fIPxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3601986"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3601986"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 05:29:18 -0800
X-CSE-ConnectionGUID: yW+9YAz2R7qdwxRXUvfrLA==
X-CSE-MsgGUID: 8Me38cOQQ6235N0LRYWYHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9955020"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 05:29:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Nov 2026 15:29:10 +0200 (EET)
To: Rong Zhang <i@rong.moe>
cc: Hongyan Xu <getshell@seu.edu.cn>, Hans de Goede <hansg@kernel.org>, 
    Zehao Gao <gaozehao@iie.ac.cn>, Hyunjung Ko <hj351016@gmail.com>, 
    MyungJoo Ham <myungjoo.ham@samsung.com>, 
    Chanwoo Choi <cw00.choi@samsung.com>, 
    "Derek J.Clark" <derekjohn.clark@gmail.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/x86: lenovo: cancel fastcharger work on
 detach
In-Reply-To: <ab88da4911164925279b071519825fc344e998fc.camel@rong.moe>
Message-ID: <91e97984-fab7-f86b-c9d6-affd4ca117d4@linux.intel.com>
References: <179474326098.103840.15531040789536968458@seu.edu.cn>  <179474326460.103840.3845211906644469212@seu.edu.cn> <ab88da4911164925279b071519825fc344e998fc.camel@rong.moe>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 16 Nov 2026, Rong Zhang wrote:

> Hi Hongyan,
> 
> On Sun, 2026-11-15 at 19:47 +0800, Hongyan Xu wrote:
> > The extcon callback schedules a worker which uses managed serdev,
> > pinctrl and GPIO resources. Releasing those resources while the
> > worker remains pending or running can access invalid state.
> > 
> > Install managed work cancellation after the UART is opened and
> > before registering the managed notifier. Reverse devres order
> > then unregisters and waits for notifier callbacks, drains the
> > worker and only afterwards closes the UART and frees its pin
> > resources. This depends on the preceding all-connector notifier
> > synchronization patch; resource order alone is insufficient.
> > 
> > The actual lc824206xa supplier notifies from work context, and
> > this consumer callback only schedules work. The callback must not
> > outlive synchronized unregister or republish after cancellation.
> > 
> > Found by the author's in-house static analysis tool.
> > 
> > Fixes: b2ed33e8d486 ("platform/x86: Add lenovo-yoga-tab2-pro-1380-fastcharger driver")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/all/20260806060526.1189-1-getshell@seu.edu.cn/
> > Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> > Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
> 
> The submitter's S-o-b should be placed at last.
> 
> (+CC Zehao)
> 
> And how did Zehao contribute to the series? You didn't even CC them!
> 
> (+CC Hyunjung)
> 
> Hyunjung is also working on this. See
> https://msgid.link/20261116122001.3096223-1-hj351016@gmail.com

Yeah, and I'll prioritize that work over this because otherwise LLM users 
could just steal other people's patches before I can process them.

The extcon part was reported by sashiko as a response to Hyunjung's patch 
so I suspect this submitter's LLM got that idea from there (of course 
without attributing it to sashiko).

The extcon fix might not have been submitted before AFAIK but that's not 
pdx86 material anyway.

--
 i.

> Thanks,
> Rong
> 
> > ---
> > 
> > Discovery: found by the author's in-house static analysis tool.
> > 
> >  .../platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> > index 9e2ac80..51ff383 100644
> > --- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> > +++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> > @@ -8,6 +8,7 @@
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> >  #include <linux/delay.h>
> > +#include <linux/devm-helpers.h>
> >  #include <linux/err.h>
> >  #include <linux/errno.h>
> >  #include <linux/extcon.h>
> > @@ -160,7 +161,6 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
> >  
> >  	fc->dev = dev;
> >  	fc->nb.notifier_call = yt2_1380_fc_extcon_evt;
> > -	INIT_WORK(&fc->work, yt2_1380_fc_worker);
> >  
> >  	/*
> >  	 * Do this first since it may return -EPROBE_DEFER.
> > @@ -209,6 +209,10 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
> >  	serdev_device_set_baudrate(serdev, 600);
> >  	serdev_device_set_flow_control(serdev, false);
> >  
> > +	ret = devm_work_autocancel(dev, &fc->work, yt2_1380_fc_worker);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = devm_extcon_register_notifier_all(dev, fc->extcon, &fc->nb);
> >  	if (ret)
> >  		return dev_err_probe(dev, ret, "registering extcon notifier\n");
> 

-- 
 i.

