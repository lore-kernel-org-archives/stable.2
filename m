Received: from mail-pz2-f25.google.com (mail-pz2-f25.google.com [74.125.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A61F1513
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349043; cv=none; b=vD+jPHoxOzSclmtEeb7EO7sVWCZ/Cehr9o0jEutWjfESBLlWOaeVDpXNHz/M5ake/le9J+Q7GxuMQF0u6SVG+FyZJgsIwe+VCV0R1BPGRuFfygMIV64Ry3gHZ5vc5Z+8dnfoqqLbNL97tvrRzEl9PnLZwDwKXoRXJLH5lcNd+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349043; c=relaxed/simple;
	bh=jFM/DwXHjkKXAHQoUXYqUXKTlLXJhLvu/J7v6hlyZnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn5txNYmQ1IxFno1jDOB9KeoE4oE2VY6bx08xiNYPdRO9Z/ny2dr057g/MBUgiIl6ytcXMdUtQTfwzOqKymo0E5vxks3A3bupVcXkx2qggKEs2hTRCjtr4J5D44qrYBtZX9tCRsJkV9zw5HgVWgTJUrfCNOgAQsAf5PMm+XDtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0BWg6mJ; arc=none smtp.client-ip=74.125.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0BWg6mJ"
Received: by mail-pz2-f25.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso1370187a12.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789349041; x=1789953841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hnFkbktqoVqh7KvfNL372TtJBe46jI4r1nKfWafzrAI=;
        b=I0BWg6mJKTHFG3nGKLsrqQ8/73BBIFltQA8KnZ2K1B8YSyy5hpzd8CA0pb5kiL5gyD
         fRSLfKuJfTGIu/Eb5OPAqFMaAYPQ5nryUdskcZTfMyn/0/2so48vXFc8+0czd2gfyTRm
         FA9IFsOL5C11iBIpxxvAA9DWv0Dw+uv75OyGXHaVTPA9BJxiIebM3rswBXFB5V7O+TkP
         m6d3cTX+chg2io9KG3kkGe70QW2iRCmwe/0kWObYe29sRK6aoxn6d6DdHxjgzlxICGYi
         YU6N/AE2H9e5S10Asypw/9SZ0ZfGJmQhN9AXwyUXRnFJ8sD45cGvktgnI7kz2Lx07zab
         QJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789349041; x=1789953841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnFkbktqoVqh7KvfNL372TtJBe46jI4r1nKfWafzrAI=;
        b=qeIy/e9qrdAWq7VR7yZpz6rPwKn/V9bxwHpenRCzbTdkJ3tOhekB+0bo2z244omVox
         TB5x9tDkc/36apQUlYTvuh0KD4dUAzgydvOugHoY9Dpas5rspO/Ah2Yjo4ihBqQNnWkv
         kwuqyLgHuwtL0Bi+GBFfZc6gaADEZ0DtBnNa2o7yt5LVWvCd/J/wQFAJlqgctcYnQe0f
         j/Ne98SR/2WXN2eQno2u4mY3eHoVpWSqN4244JwjJeO2SxvuZwtlWiPZ9Wq8gpihlASE
         ueyKMQb1JeUI59ch6X/VUZvBhD/NhxBhd3B1M4BcO6mXtw9xvFEN/62kHdQXvJHu4yvU
         ub6A==
X-Forwarded-Encrypted: i=1; AKwUvBxjMtbSK/OdN77P5LMIijdf1oToHgsdmKwtlh/39GGvdjXdliTOFkq6ko36ZqIWf64v4nVhCLU=@vger.kernel.org
X-Gm-Message-State: AFuF++mo+MCep997VonYx6TG5ax+PmMQoiGytof2htoFgw1got/l8XqD
	7oAY7S/n9OdkZ656A9opS9wCzM3Nnid1kyXdPaT71eVJ81Gig/v7HBtT
X-Gm-Gg: AYBFou2wszSTmSA2Sy+NCiHtAm7SQJcGaz+kWxkbyWvRgwvdRX78XutsUXm4Q6vyAqV
	teYLHxs7nwwwFIsK8JG0pxtpBvqpB8X4wl3KdEpdIoI6rf++Rp+81F2hmiXA7WpQl0Gg7/MrAlO
	Yi01MEE7qy2a5BBYmnvhR3irPXQXm3PDCLg/tsUkWz78X+5IdtRPZmpUqiKJGW4ku+mg2QLmHWB
	x0eOXaZLOCMxxlYI/dREDv6e8TMw1ldv1wDOTIGZ7UvLgfUSZjazaVOOv8xfhflz6oRaDpylRLd
	TA5jWVZCOIhiVCqgcFBMKDcGRD9jbbebX8PNgqiMwNsZz8UBZneVzruZCVKHtgJZrav7r0QWiId
	slyDVqAG2DfnQhkFKzdnEN9bbm/kVWLTmsiOfTiKRR2XUodFWmwLz5pQ/+alryOz72c801xfcLO
	PoLKts9s0/GL18JZIJHRHycHiMQNyzOtZiI+WNiGPdLEduSHN+MufnWdZ3TDwfRv/YKOS+ZqNts
	I8/n/QBuSVVSpFcV0XKY8QPuDif5F3B7LWSSyC64VojCCX5ZoI=
X-Received: by 2002:a17:90b:39cc:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-39debf547abmr1067411a91.5.1789349040552;
        Sun, 13 Sep 2026 18:24:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fb3ddasm20363582eec.30.2026.09.13.18.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 18:23:59 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:23:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] Input: hp_sdc: shut down kicker timer on module exit
Message-ID: <aqdMplrLuOrSU08z@google.com>
References: <20260902154004.3595416-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902154004.3595416-1-runyu.xiao@seu.edu.cn>

On Wed, Sep 02, 2026 at 11:40:04PM +0800, Runyu Xiao wrote:
> hp_sdc_kicker() rearms hp_sdc.kicker with mod_timer() after scheduling the
> tasklet.  The module exit path uses timer_delete_sync().  That waits for a
> callback already running but can still leave the timer rearmed.
> 
> A callback can therefore leave the timer pending while hp_sdc_exit() tears
> down the driver, allowing timer activity to access dismantled driver state.
> 
> Use timer_shutdown_sync() for final teardown.  It waits for a running
> callback and prevents rearming after module exit begins.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied, thank you.

-- 
Dmitry
