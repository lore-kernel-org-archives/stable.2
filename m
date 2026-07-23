Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C524336D
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827112; cv=none; b=hEUUVUpjp/AWSsxXtHgmR4jJzj9yKFB8cu3OA9s5gb0HFTK1QW/rHHRrz2WZbh69KgiOaaGtsyHTVPEE2UwpqXT886OsgKH5YUgV1Kh+bR7TtDRPOO5JaUhdaJBwlu+Upjg4hvDNEgSez0M0sPlC+/lTsArnue1QkwkEEkiNqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827112; c=relaxed/simple;
	bh=zGPimF1oO6azFhOM/7DTDQwrY7SB+YOS9F6PLxUOcug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz5JJeP0ohZYUKSchHzKMqH2oY+pzT4LO7AFjYVAlfeE//cPM2ruSuTJ/E3dMBoqY9lfscDPyFw2z7JlGYREmJlptX1I8fQTrKN83awB7LcDlHFzXgSuUacXw0VlekaFMXD0KC3KkBYmMBKmYDpbCFRKrab5E0fOtDV8YlJL5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGowPFzt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGowPFzt"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so574889a12.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784827110; x=1785431910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QKYiYC0rCiJb7QH4dTCNiWIbkF1YTyo2tbQ4SRrmFHM=;
        b=CGowPFztOftxTiw5LwKmxVAMcdf5VYz0eUuAP7JZI8V+ydJ+gMDJSyOOtDcFOrWLkB
         gp+WxmFLzLIYr5y4GeM3TqUwk3Y9MtO9DhO/WTS49DJ3YeCwhszxx3aW/ryHCNUL/4fN
         dvofqko4GJl2y6JdZyfyDOg3XAEUtAKB5FTACMNOpEVVQVPoJFTky4w7Iv8gLXyGqMYK
         Q/0ujPs/2680Ek8ZGtBOPyWcR7bebX5FsmtsOci8gvqpZ/U9G0N8wpsJ2+8XFvLUQO3v
         veIoX9tTHdMgkZlbKjzzFWUve+3EtvoVT86npKzd41F++nlQTV5UY72F1tcQqGDJeeIX
         Ex1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827110; x=1785431910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKYiYC0rCiJb7QH4dTCNiWIbkF1YTyo2tbQ4SRrmFHM=;
        b=XKRjaL/C+WKXzma82yDioClt/ZmWcxI2SpjG1nU2O402FWC5qhliW5gS7ZPAKTSfQO
         /8VqqDsQOtUVqC3/5IZR3ijmSzlhoAjDUedGeN+Oj5rV04sqUmu9QbHN9aMwoCGm7Wcr
         OXgocLGGLRvu2Wjfj8Cao0wTG2XGTAIAcOF4UhygVrC03Z1lDTgk7uKdaGN40qcI+nqo
         9q9GTPkIoTXaKpwZs586iaGTK77zNx75abagrJJmf3I26JX+4T/+eIl8zVrniqR49mH4
         q5cETmuuaaqMSbQGwbrzmZTK7JPlUrxqtdMATE8+JoiaJAbSyzvujyhZDcOBY74aVxyr
         6JrA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2QA96ku9aE6hZ1J/lkO3gVR2RdkhOUr53tzg54ANLBVffxPtggXAk2vv2BsDkztN6+ELwwx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4rd0LoItxuOeluRodsVx0X/qQTtZpz81QxU+9Ed6emAymyGbf
	F3PVw3QhxatTEhz2OVL/FMHkOAXnL1zkUZRWYzPDvTiPZUbC6anO51Uo
X-Gm-Gg: AR+sD12m6o4X1/MelaVo5V9/+RVMjZk1T8cPvODNpACqihU7nUhgIouKXqrGra3U0IK
	0kvqwODlbM7lACFZWb9C+8LlP/aGHBF8qfVt13WKm2s6rYca5iH5/ASGS3pZgo2gckgZcjLxJdA
	ZHkXqaFmRK8iO0xPllXG9KvrMFlZtmT56WG+MEqXR2tbl/vTxor8skDmS+FdxsaWdEGgv0Kcfm3
	IVAhQcaUFvjOf64BKo6p30hV2+w8bgETeyvQERZnPJNa7Q5KTFf9eiB/029YtcGbW9EmZ+p1tac
	ouYP8THu8Dsmv12fLf3ku0Ogl26wFTkwUS04ST8zfkL/vgxZzM1y2Gv8gNo3CTOJqQ38il+TMkl
	YrMCWk9/XkdD9O/vZna2b/zYJlwgYJQmljY/ToxKB3Zf+kpf9v0DZsx/FlxK0Tt9cUNkqJCDZkG
	+XfZYYi1WC289DchU=
X-Received: by 2002:a05:6a20:734a:b0:3c4:2cd3:f0ba with SMTP id adf61e73a8af0-3c44cb902f5mr3756644637.31.1784827110288;
        Thu, 23 Jul 2026 10:18:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1b6a45sm21544589eec.28.2026.07.23.10.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:18:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 23 Jul 2026 10:18:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vincent Jardin <vjardin@free.fr>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/core) notify on the hwmon device, not the
 i2c client
Message-ID: <bb3dcc2d-1751-48b9-b9d9-2bc04137a5d3@roeck-us.net>
References: <20260723-fix_hwmon_notify_v1-v1-1-5a24c528686d@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-fix_hwmon_notify_v1-v1-1-5a24c528686d@free.fr>

On Thu, Jul 23, 2026 at 05:44:56PM +0200, Vincent Jardin wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> pmbus_notify() calls sysfs_notify() and kobject_uevent() on the i2c
> client's kobject, but the alarm attributes live on the hwmon class
> device registered by pmbus_do_probe(). Notifying the parent i2c device
> is a no-op for both poll(POLLPRI) waiters and udev listeners: the named
> attribute does not exist on that kobject.
> 
> Notify the hwmon device instead, so poll() wakes up and "change"
> uevents fire on the inX_alarm/tempX_alarm attributes when SMBALERT#
> reports a fault.
> 
> Fixes: f469bde9afd1 ("hwmon: (pmbus/core) Notify hwmon events")
> Cc: stable@vger.kernel.org # v6.4+
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Applied.

Thanks,
Guenter
