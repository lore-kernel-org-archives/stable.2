Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84046D551
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494888; cv=pass; b=ga+fADwGFSdI4IcOAe66WjOLzkG2UybfyBEzoR1L/vOStL72lA1fTec2CT1F1gyt+Kp43RuOkcGq5ap6lMDS1i8u8YD36c9MQSDckStOOddCcIpvUJoidoS79+NwTIj4+HIodgxUuf/kWfYcgqTFne21O4VQpq3h4vRSkpSBNx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494888; c=relaxed/simple;
	bh=VuYIQRRuB94W7Kox+M3XIrBI3vc27TwoZHp/3bqtfhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GN1GglyzljNiUevHcIN6xVimQzTiwIZ9iE2aRr72YzSHlft/tWdjualJKnGiS99sy58XHEX5UwA/a5vceYCmbuRNCy9MNLWZMhfnhpJZSgckhAhALkJ5u+kRwMVezwY7m6itLriF7C1NODmksxtwauljrjKLevLaWyU5h8L20j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1FQBep5; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1FQBep5"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9178aabd30dso34564536d6.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 14:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791494884; cv=none;
        d=google.com; s=arc-20260327;
        b=bXNR9tYixxdiDxw9FGI2tm3kLrWsmMkWUKAiJj527FsO2zJhMt4NX1Jr0xMeMgjqO6
         O2o3zlD8ktjFphBadB5+HNN4P3rIO+kRDCRrVtH5qHWW6Y9zbU9uQYYTyI5JWYj3QNbf
         bBvV2Z7iv0+O9YTPbIaSptTjiEI2zRoF/ZrbbSbwTjuVMsWGDT9QbXRum4r4AfuS13pH
         d3wgzAUqRno75G6cFCqWsOp5N49vCoJd4x+1nYuXvYCKuO0c84F/agAxYJBBGqwkHkPi
         IvEcdQx6AFDs6dR+RBT0FIkGFCwXy8EI81v5z8fs24rdz7JQTcSH1yXYoFmzx4z59uIb
         QSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VuYIQRRuB94W7Kox+M3XIrBI3vc27TwoZHp/3bqtfhY=;
        fh=6sSMKlBWI2KxMPelbslWxe4pkmzdcahCCKFAIlUW1vg=;
        b=gEbFZO0aUqlTZgiCIgDQqpGVSdAZa51FaTbkhYgCxqGE7TT3CG6AxRnPD+ABRTd/AU
         AgAywsfofJIZJ88NsR7lukYyp6XN2uclH/fyjLS+DWFjH1cdNgKdpUtAplhAfuN2sPDu
         ALQs0AGwOptm3Fb4XGG2uV6F9H5NjnAZme4+M5D13dBXPAmf+ctU8hB0ezd0a7VJx70Q
         suPcxTbgQaUHiD/YyvZDeMMPkIeKnPpoAhLN4uRP90gFQs4jN1luApgrPkelnbnYWDnV
         rYmEId1Ic7avrV4XZ9cp4v5sQcTCo7Q9f+/K3bEQfOlC0DXEOX8E3re40XoykIvKim81
         pF9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791494884; x=1792099684; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VuYIQRRuB94W7Kox+M3XIrBI3vc27TwoZHp/3bqtfhY=;
        b=S1FQBep5rIbS2NRVh2ZkoFax+01UnH4BJIAUdJmdGIbuzORGGgeykIUXKd5p8S7RFW
         JA3x4H9ENgldTPyXa2IHWIiMMj8HdVV+7Ykxt73jdQTB0ATTdzNmnqJ9sEUVqAAzt5ZT
         GUEN48xs5ueGurG2aH2+4fd3kuWMA0tH5EJI0Uw4D++AJgl6fZR7vqwIQ5FwOCPuBSLS
         5oFH9GsHDa3sVxx+c0G64HQ0qGZfnqZ3N9BBOHz5UObudBauhfw7VQpdh04H1nF9t0fe
         H7phWVWs5W/OEo3p7229+ec/95ITwExDtxli6Va/SSrIXFlWVkPpw33iyVoIPirL4ue1
         WC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791494884; x=1792099684;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VuYIQRRuB94W7Kox+M3XIrBI3vc27TwoZHp/3bqtfhY=;
        b=M+ctMg1761U+cEWb7XHOllKvfZCzC+IvtOwbUYMRGeSUiYzcBO9+ylcap+RNbvXWuR
         2AQRhC26WaOHwMFjGv8Did0CEY+xibzgukWEGJxk0ECYftpzv0Fnxux94mcjQU9RrX2t
         ZiMqp0D+y69R41htQgtVwCeXpOkwJ7r58gpqRgDRtJqDOM//Hl3rCV8ndaaJBUOoLVHA
         q2rVkeZ6gpHdfB82m93csl+m9DcgBseGXUnxfIFcXk4Vlsi+UDHKt4CTE066vc+yQZLc
         tQI/sGYgREJSw9Tb7mgZh3EOU4qBsB8vL7KMq6Jiz2KpBfEag+0TiDBbfHpP8CL50aeI
         sGjA==
X-Forwarded-Encrypted: i=1; AKwUvBxGS7vmfYLWlo23sCpSDAFVdZ30dYVggaklXrSsHv9PYnGquwMUTQbXPwIUWf8IepVXfb8qMy4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfF1NlxHdRgidBoaJNzet9fkprFhUc7Ca0pD/fbfLM0wQ7724N
	xGKtsq5QXqWYoqqiENEvrtDviRPZBRgo8kN5X0QiN8+FtKlFZ2ESu8f5ueZP/niE/U1VqAz5nWk
	ncw03yEc3mTq0EY5B4CMOIL1AkrGPOKc=
X-Gm-Gg: AYBFou2UQ8jAMgr8kvYI3e6Tw62xsAaLKDqMpkXG2fxvoXCVPVjCaeMXXSyo//osfvp
	Su2V70Z5E7tTHxpeBt50u+nahKcvGWkcl8sd850l9jNv9VvPZfki7etA/HE3Ft2A9PMGYZnAxqc
	qSvddStMcM0J10TIxugfx9UTuE9PccLI+Fd5qSfl8MKFa0zoLSUgu9VXHeIqzHqnSQ/+6sAPN4y
	Ms/4hMXxalbA7NdyxHcBufhRKzG8mrfGhYW3wMP5ngEphsyzXSFsPDyEFgoquCRC3b1G6+wZ5Xi
	D7q9WgaCmKCWPc411Nzk9djjlwHXsj6hN66aAeJN/sf0I64VE8W7J1ypGBLP9Ud6dfKbSf4WVCK
	WdDaz2k/ULouABw==
X-Received: by 2002:ad4:5c6f:0:b0:914:501c:6d08 with SMTP id
 6a1803df08f44-91b554f0389mr257436d6.14.1791494884320; Thu, 08 Oct 2026
 14:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923074903.862898-1-linmag7@gmail.com> <20260923074903.862898-2-linmag7@gmail.com>
In-Reply-To: <20260923074903.862898-2-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 8 Oct 2026 17:27:48 -0400
X-Gm-Features: AclHuK92Eilo9AIrsmVEgSCURzevr5CYUX7NRSheSjbh494ve_VZ5MYQZo-3BMI
Message-ID: <CAEdQ38E6pTdnfzU4tTvoJOFVGv6jSQ2HrhLTFet+2qMiYU4kZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] alpha: run check_mmu_context() from finish_arch_post_lock_switch()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 23, 2026 at 09:47:44AM +0200, Magnus Lindholm wrote:
> so testing preemptible() expresses the required condition directly
> rather than naming particular callers. alpha selects ARCH_NO_PREEMPT,
> so unless something else turns on PREEMPT_COUNT the test is a
> compile-time 0 and the hook runs everywhere, including at the end of
> kthread_use_mm(); it only takes effect in PREEMPT_COUNT builds.

The only way I can find to get PREEMPT_COUNT on alpha is
RCU_STRICT_GRACE_PERIOD. DEBUG_ATOMIC_SLEEP depends on !ARCH_NO_PREEMPT
and PROVE_LOCKING only selects it if !ARCH_NO_PREEMPT.

In that config preemptible() is true at the end of kthread_use_mm(), but
the task still cannot migrate there: there is no kernel preemption and
nothing sleeps between switch_mm_irqs_off() and the hook. So the test
never prevents anything, and its only effect is that one debug config
leaves asn_lock set where every other config clears it. I would drop it.

> A shootdown IPI taken in
> that window either finds asn_lock still set and defers, or finds it
> already cleared and flushes directly and by then PAL_swpctx has
> installed the incoming context, so the direct flush acts on the right
> one. need_new_asn is only ever set while asn_lock is 1.

The deferred case has two halves. If ev5_switch_mm() reused the ASN,
need_new_asn is set and check_mmu_context() reloads. If it allocated a
new one, need_new_asn is 0, the IPI zeroes mm->context[cpu], and the
task runs on with a zero slot. Nothing is stale at that point, but the
follow-up series reads a zero slot as "not running here". More in my
reply to v2 3/3 there.
