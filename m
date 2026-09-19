Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D0282F34
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825684; cv=pass; b=mJxaVN2PlH4sLCMf2/Ur9m/Mq26tK8OZAfm/tBwk6Iood3Fmmy4F3DoIkAYpV6Gca/1cfzq6J9Q4Ao0QbPjoNS8AgplkGcaJM1dVr0eQiRK+GUzr6ueHnrTdNz8g9qRxWvG9dCpQ0Htajolsq3NSxP2TA469zPVL0eB+o2FVr48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825684; c=relaxed/simple;
	bh=uxDzFlXIhCWkpp4nn7OscT4I75j1F3IPZnT3erfb0Lk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kiAPWsrD46N7vNmTMrXmUD3TDgIQDnak3CVCua9VCrhJlodyVIIqcR7T3e4ZvZD181mwykHrunYu7oTpilBFV1D/jihKiUtdbH8cD1gRpQt/3k8kC5Aah6tzagSBd0fllyXjxCpxam3aSesJDJG/26Mqxmb5m/aMjwP0ocvp/eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqi5Xlsp; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqi5Xlsp"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso1512543a91.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 06:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789825682; cv=none;
        d=google.com; s=arc-20260327;
        b=PxNByrHMZhAc/5UbR5M7ZN+hSoIC8Pe9Rb9321pCZkG8S1xOOYWpHTGivlYLeWqF8k
         KASg8v74La92NpMEhgfUqxVu5XfdbzNIIlbtqTJMhxdLzWw+vkZKg1Tom3xPFJjN2EL1
         tgRsnrIb9zOZnHT8MDgTob5qPvnJEHBhAWIyXX2HvjBLIYJPM5UVQ+TkwldL/B+w93gp
         hpdBMAwsfIQ0aSRsVBQu/0fyBcYtofI82kVOz7y+o7590W5Nv64hjes1+1230TebUeZ6
         Y+TBKSYjRbp2rMOjgiwhjCm3bqR/MZ5pU4PxrDTMu5V11AsO4RFa4dv+R06JzAQk5x2u
         NC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=sIIVnS4jjgLWZUNl3bwsvpIjYgvoUL8a8FSJ4KXXWw4=;
        fh=2pE/42It8tic8AGwrcxgxGBcN1iJDMqjRUhuzOAYBfY=;
        b=ZsApA/47GCp6EcNkIo1+tEuWVM5bpAh+dMAYxJwWoYbwU5UwyCCFBpHQYxTrsI7PHA
         LKLldynspvAanfaIQp6KJXwTf2yKvjwMRuftIOSJsN/mfsMa2RjNdjSmdMr69v9pBsEZ
         pg9fKVxBfxqVdF9wQ/kDrseZEp7WG+s9bdbzUgo/e6sVaTYY6qHMT4f0YYwx8aRJE9mL
         rKZQRuXEy1JtYDRawh9LZUpM8kimroDs0j+sy2cqx9nUoiuL3G0UJWLx6HK4kpi68aaB
         BwHfzCDljByCU24wEEo3fNXjIFqt3YfaqxqykgCGaM3d/22CQUVwf/H1WEjGGSYLUbam
         wCRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825682; x=1790430482; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sIIVnS4jjgLWZUNl3bwsvpIjYgvoUL8a8FSJ4KXXWw4=;
        b=Kqi5XlspJA2t/INDZdP2hfeEhsJlKsHZ+CG6ZbjCBcdVg8WhjoOVDaXX9XeizRfCEx
         PKKCBPcv/BBz962YOk/43a1Y/sy40Vuvh2SG6xhJDVuN3mncGLBMqw71nYZ3YLi0I6aF
         zXXHUWp1tlPC2KqXjj/sPxmbNTX3q4R1WvprZ14SiE8Pfu6u4+904r6H/Mhpf550Ftq9
         /xkK2xPiasRBt0yoyozy37VJXScSFpyHI6H+URG5O70qTylbnKDhVL+EE36yC+E/fZi6
         qvPG5DLaIo7nO6OhFUfg9+/mwnJK1thn37dwbgOd17WPfUn3HPT9NQhMBPoZbDYxQxFt
         T7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825682; x=1790430482;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sIIVnS4jjgLWZUNl3bwsvpIjYgvoUL8a8FSJ4KXXWw4=;
        b=KC4zjUlppv12SVHvJ3Seazw3NrRu/EMbAPU7Qvt/QEDbrgQa3ISQzUvK2CnAuDX6De
         O5f8B2hfThVAz29ErJnBttfKQ1wZVeFGVRj7pk5Ygl9d23wbUZRApqhNWuY8SOj0kBrt
         o8vCxhyuNq+oGfaBF6BCbdBWTQWryvlU8Nf4WDbDmr4GhqI+zBM37uCX1U45h90VFj+5
         +RsIiQlfHHbR2TR6z7/LIXVH8VwYmLyP7fGBwgfN0gFMZ2kGQPQJ9QK5T4CRgQuGmHcx
         +9sshlB3YvJR9i49m+MhRu9priPWdDWYOkD13gv2FozdY19+2fKQsG6XiAL7KUFGhGFh
         IulQ==
X-Gm-Message-State: AFuF++mtsoIRBOD6+A/YJqnuER7D5wDsdYePwG1Ar/T6o2giOsP9nz1H
	k6HchPxupapmzkefXBaCjjNIp6USKgRGT3c9AvDAIzdzPgpQ0lhFCAqLEPP2r8r6Kjwol/1BGL4
	WoNMfQjpfCl/CdC94F9IGBVduwRfQbEk=
X-Gm-Gg: AYBFou22c3RE2hgnJ7f5b8x/6iocwoXhTngEMiv0ay8QsCYw44rBlsslYDlRx/zuy2C
	iYGoDqhJQzFH5w7iONGhAZlfh4k/1yhLK5T5tv+D4Sj4YwrG3g9uWiQvj1wJpzyHdAu36Y+Hfki
	5+ghGkHBWBzn56Uzmvu6yapHGTX5/xU67LBa7vP85Phq4kKTrr69suTpNn5S/f6a9IQWnZ3ioy4
	gxn+RNmbFP3Cawedt7ZyDtmdgShTLU8C76qS2Jw6qpgqWEZD+ZleD0kkfQhwM4iiaa54RY9VURw
	zUk21BwTyTZFnp2YIYrl6Q6wdgnbM1LahWERPp6AtAulCYmKC1bcMyYRCV6dQYs3WGnayf2QG8f
	fBJchMSsInO9hgFkt/pQ+8Fh1iJnkeCuqpHc5HYsi7zZicaIXK6taI79uLuLEMLo5+Ahr8jFC7Z
	pmVGNRW1g=
X-Received: by 2002:a17:90b:1dc9:b0:39e:6c69:7775 with SMTP id
 98e67ed59e1d1-39e6c697929mr4698625a91.30.1789825682239; Sat, 19 Sep 2026
 06:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Lomas <david.s.lomas@gmail.com>
Date: Sat, 19 Sep 2026 14:47:25 +0100
X-Gm-Features: AcwNN1WfyXVWtbUsXrdmQZGWXpS1W_8PSzgAYorOUUpF0oVLqT3c8afoCgKVMbs
Message-ID: <CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com>
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image()
 after freeze prepare
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, rafael.j.wysocki@intel.com, 
	matthew.leach@collabora.com, superm1@kernel.org, linux-pm@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Please note, I'm chasing a bug on this laptop using claude, and not
familiar at all with kernel development, so take what it's written
below with a pinch of whatever you prefer. But it seems pretty
convinced it has found the root cause of periodic freezes during
hibernation (whether from sleep on a timer, or direct via 'systemctl
hibernate').

Re: <20260917151556.616977299@linuxfoundation.org>
Upstream commit 783c8109844503bd1c35dab41b6d5fd074a9f131 deadlocks
hibernation entry on my machine (7.2.4, Dell XPS 13 9360, 8 GB, zswap
on) whenever the system has been in use for some hours: the hibernate
call never returns and the laptop sits warm with no image written,
seven times in ten days. Direct `systemctl hibernate` and
suspend-then-hibernate are the same. Never on 7.1.x or 6.18.49, and
never on a fresh boot.

Captured with SysRq (w) after ~8 minutes hung. The hibernating task is
in the direct-reclaim throttle waiting for kswapd, which was frozen 27
ms earlier by freeze_kernel_threads(), which this commit moved ahead
of hibernate_preallocate_memory():

  [ 8404.650787] Freezing remaining freezable tasks completed (elapsed
0.001 seconds)
  [ 8404.677608] PM: hibernation: Preallocating image memory
  (nothing further; SysRq at 8871)

  task:systemd-sleep   state:D pid:36677
   __schedule
   schedule
   throttle_direct_reclaim+0x358/0x3e0
   try_to_free_pages+0xbf/0x220
   __alloc_pages_slowpath.constprop.0+0x531/0x1510
   __alloc_frozen_pages_noprof+0x334/0x370
   alloc_pages_mpol+0xb2/0x160
   alloc_pages_noprof+0x49/0x90
   preallocate_image_memory+0x35/0x9b
   hibernate_preallocate_memory+0x25b/0x390
   hibernation_snapshot+0xc1/0x4e0
   hibernate.cold+0x117/0x4b5
   state_store+0xf2/0x100

  Node 0 Normal free:32044kB boost:119232kB min:172224kB low:185472kB
  high:198720kB ... inactive_anon:1601740kB zspages:362688kB
  377713 pages in swap cache

All four CPUs idle (SysRq l). Free memory is below the pfmemalloc
reserve (two thirds of which is watermark boost), so the GFP_KERNEL
allocations in preallocate_image_memory() go through
throttle_direct_reclaim(), which does wait_event_killable() on
pgdat->pfmemalloc_wait until kswapd raises free pages above the
reserve. kswapd is frozen, so nothing ever wakes it. The wait is
killable, so the hung-task detector does not report it either. With
hung_task_panic, softlockup_panic and hardlockup_panic all set,
nothing fired in eight minutes.

This is the concern Rafael raised on v3 (frozen kswapd); the reply
covered the I/O path but not the pfmemalloc throttle. Reverting the
order, or bypassing the throttle for the hibernation task (PF_KTHREAD
style), would avoid it. Setting vm.watermark_boost_factor=0 shrinks
the window but does not close it.

Full SysRq dump (l/m/w, via efi-pstore) available on request.

#regzbot introduced: 783c8109844503bd1c35dab41b6d5fd074a9f131

David Lomas
