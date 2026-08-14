Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0733DD84C
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786741972; cv=pass; b=gb8cI+860BrcaaDSJdigccY0kIkZwN3MZvjtBLFfhIcSvpDrDMukcUhg8RkL02Ry74Kg+axRDWjS0pgdkcLuVtre5xFWtIXtvNYZguP+43qoiU0B58FcpRxejjrreLxkjnJpxx0f5g6tzDWgNPOPhJpSDXAAI396IIs5LcrCt8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786741972; c=relaxed/simple;
	bh=DRei2+deSPVy+InZVMN1mkoYxthiUeHYLiILPMCQGwE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Zw/g/KArNNqYJtSyrbRE/EpwFeYiqNpNQQ9VaQrdVv1fTPaXk88SBeBfljGNEQMs23c7HiOKrYb/w0DX/8jyC9XDs+kAxDrFz0WhUr7L+WkPXt7q9I1Ps3eal1WtZ9kX+b4jWMb/PGuyKXstczjAaSkDnVBOVQCN3oc7+OXjykc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUW/Ynmh; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUW/Ynmh"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aea0fff535so1502862e87.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786741968; cv=none;
        d=google.com; s=arc-20260327;
        b=ZAAtQ1iDZVEkb2G3qWKTZ7lv0rQ5WdjT09yPsW6iPqJpe1t4Vr/+08INtzPSNoMkLT
         n5c8o+M8OWQq4FR4EQ3T5bi9AiHatOdgZA3XDjVXMpmnogQqRQbeSLH1BuvQ2gMyZtOp
         iWY3VC7lVk/MC80ksUmCGE+onVvljJ5K4yUkgdsMuzWQhXbke530XXQExFeBgRYHPAHR
         C77+ur5zlq/IfaT2DZuxaQcbVgPxphPYaMBc5lxKmy60hfVQJ7uTcgu1YqURdFtmfhO/
         pLMR5aJELVogpirtEFbAcfUAeIX1rmPcHdsLUOTrTKRq/ghM/3t9Xtiz9gsXsCG2GDFr
         7P1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=suChiBpI2zM7Kh/sweI6ufJ0V5/AtIy5NrlliylEVCA=;
        fh=ZiudQqZR2RGVSD6senEDIy8CSHR2f5hWdvN22RRbsvk=;
        b=KSlEPjxpuuBlqEfFzi3jNxsNi2ep9nEFc8f0beZtRxORPZuiWxkOt7xFKSKMyBoudG
         lnW3a8Xp9Nt2dSGbOOWzd58bWE9gD6GRuwaID4GrSL2iCra5V1W5sJn0Ja+9J6yWgLty
         ubyIZzYjeL1H/N5OxMUkS4PsXh/tjpQ6u6rFgbVbq94e9aT1/Pc9awXIyvmJurVSP7Jt
         fdqb52g7pSPr/aqW7j/ncaL21hJ6FB5moJeXwkZqs3EqmSZHRJbEghUKM5+F4k/joOzl
         qEvJ6JVBHea3zcRtzkN9zhZONO8DiZItTIYUqoWBnKu2VSreojuJpDh9IK7UHUIzsrJh
         wXpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786741968; x=1787346768; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=suChiBpI2zM7Kh/sweI6ufJ0V5/AtIy5NrlliylEVCA=;
        b=HUW/YnmheoEkrIDj2Y5pUFa3UI7EYOkGfcbBI3SJdCVN6nZgTujgMmReUdvSyLua3h
         L8qdGP7/1E7JuVrtlzMVgd94N68foYdY0CABkzBepI3TOwpLfhAchD0kxIQyRci7+3+6
         P2RIzZ2V8MP3iRGFgS6MBJdWdzeQjGDH0iBGB9XkEMp9+iPGia2tbrpy8Jl+elwkY8bT
         4YFJzsOGkJFrPrr3gG5Fgiuacxf0sPoOw+5YKp3jizOOLN7c3a71Tx1H+NiPnNa/ABa1
         yBcYE2cghuoVQZK+ANTX36lLdJP77e5Crhs9qYQs8OJzzjU/9+doDhaU/IOjSN4mwtW/
         hAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786741968; x=1787346768;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=suChiBpI2zM7Kh/sweI6ufJ0V5/AtIy5NrlliylEVCA=;
        b=DfxLaz6UBpwKic7hCfieDpm0/RxOATjGiCHKlOPGpgZG26vpTZHfssWkYb1owEONMv
         cQKuLupSOdD8AxXTZSGET2OTG1/d544H+Cog0Lbp8e92BpW8NqT/wFJC4Qo8c/UG47xL
         vX+WSlLUoceiKZq5sCgfELj9MlkQLa/4/9+Z/WbbTUsOjoykAuvoDzHNAvtbzXFhy+9D
         kPQkrTHMWKJF8cvwkhkHodykIYxWXNzL4cfM2WjmucjKyFSLOevQoUlwIXUJRCXgN52Y
         gCRbWDMADE1Z/c6SbUFROIr/JSKGyeMQVjt+gvyE64IFa6JUTBxiVXSwnZKmLQDvTtD4
         jyOA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2N7ZHjat7+bH5K6IGTBAxBGYw9ufz30O4j4vy1Ljm934v2+49P5UM9UsyCFGkClevNlqwjhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGv5AYE03L8UseUn/GeT2LzlmZ1guTTj9p54aMzuFQ70XyD4Eq
	kjKarbnLCBHYvwBya2CTbEz/TYjusgBcxXhmwFPhV6hcr3pOLn+OX+oXlA2coY67LyfJ3l5sQhF
	DxtKiPo1sxSqlHfrLgYWPnYWpHzCWb2uudWUO
X-Gm-Gg: AR+sD11xx5y9/6l1ksdRWykUWA+VREZBBup4v9IXSBbGqQLQdP1tQSOGJ0nPQ1cbXuH
	euJKgEr+ROR7huL8DUqci1RiryhxKQ2bCyouBygvGoPD2A35KW2yJazHJqdHb/rZhTuONUBHRVx
	OLoYQR6G0jts4WBE8jJf2nwEvyAHZ5TXlz6BShKz2+FyWU+vfgv0I00jnWU1CXRBrVLPeihosWy
	t2w0/7TwCQ9uQiAbDCPmkF9dVPL6v3NBmyrwnjtjW7RCjp9qNqMisvqtWz8yP32X56qbcM45iCQ
	HDkxXAb4kkmPoncBtnPVgCX5BjtB8e1U0r6mMRGqb8ST
X-Received: by 2002:a05:6512:6681:20b0:5b3:f69:fef7 with SMTP id
 2adb3069b0e04-5b459154ac0mr885241e87.4.1786741967554; Fri, 14 Aug 2026
 14:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin King <martin3kx@gmail.com>
Date: Fri, 14 Aug 2026 16:12:35 -0500
X-Gm-Features: AUfX_mwPwIqgYkjCpI0inF8DAyhP-Non2hPQrAzUm6egGv1-qM_6abxz0-6x9l8
Message-ID: <CAEB5A_91hob8ddOhW=PrO1=O7GrFmSxY3r1-_Ard6x8KHHuJGA@mail.gmail.com>
Subject: [REGRESSION] sched/rt: NO_RT_PUSH_IPI causes multi-second PI-boost
 starvation in pro-audio workloads (dd29c017aed6)
To: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit dd29c017aed6 ("sched/rt: Have RT_PUSH_IPI be default off for non
PREEMPT_RT") causes reproducible multi-second audio dropouts on an ordinary
non-PREEMPT_RT desktop running a DAW.

Symptom
-------
Audio cuts to silence for 0.2-3.5s at irregular intervals (roughly one per
2-3 minutes of use) while the machine is otherwise idle and responsive.

Mechanism (as measured, not inferred)
-------------------------------------
REAPER runs one SCHED_RR prio 20 audio thread plus ~15 SCHED_OTHER "livefx"
worker threads. During a stall:

  - the RT audio thread is blocked in rt_mutex_schedule() on a PI mutex
  - exactly ONE livefx worker holds that mutex, has been PI-boosted to RT,
    and is enqueued but never scheduled
  - its schedstat shows run_ns ~0 with wait_ns tracking the entire stall:

        reaper/livefx tid=43910  run=0.0ms  wait=3406.6ms  slices=2
        (during a 3403ms dropout)

  - meanwhile ~17 sibling threads run normally with wait_ns = 0, and no
    thread does meaningful work (largest run was 7.2ms across 3.4s)
  - the machine stays responsive throughout; unrelated SCHED_OTHER work
    proceeds at 84-94% of normal rate with 0-1ms runqueue wait
  - all 16 cores keep taking timer interrupts at normal rates

So a single PI-boosted RT task sits on a runqueue, unmigrated, while other
cores idle. With push disabled nothing hands it to an idle CPU.

Evidence
--------------------------------
  kernel  RT_PUSH_IPI  playing   dropouts >=25ms          xruns
  7.1.8   off (default)  19 min   8  (191ms - 3471ms)   bursts
23/265/434 per min
  7.1.3   on             39 min   0                     0
  7.1.8   on             42 min   0                     0

The third row differs from the first ONLY in the sched feature: Identical
kernel, toolchain, GPU driver, project and audio configuration. At the
observed broken rate ~13 dropouts were expected in that window; zero were
seen, at both 25ms and 10ms detection thresholds (10ms is ~2 missed audio
cycles at quantum 256 / 48kHz).

Workaround
----------
  echo RT_PUSH_IPI > /sys/kernel/debug/sched/features

Applied at boot via a systemd unit.

System
------
  AMD Ryzen 7 5800X (8c/16t), Arch Linux
  kernel 7.1.8-arch1-3 (and 7.1.5, 7.1.6 - all affected; 7.1.3 is clean)
  PipeWire 1.6.8 + pipewire-jack, Focusrite Scarlett 18i20, quantum 256 @ 48kHz
  CONFIG_PREEMPT_RT not set
