Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E1223DFF
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059165; cv=none; b=HbjZh6rGMWFxqydLg2rIlBwfH9UvJGN8M4GHdShJvdg6ZuLzWajLe8ogbVONuu1pgjaKsKsrj2LsWLQ3hrGN+4bp7+rBxK65EMH06gTY3sr9U0JbLLVN9oaODqaGfJSPyUeQoGbjnyCOk9HeEczs4vH0HbtZBBRn95G2Pi/766g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059165; c=relaxed/simple;
	bh=bHHYTKEvhy497h0vRpKlx+gnm0E4LBYa9PJg3HjQC0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fOaN2DLQYBE0Q2IRnXZ2bgRmExgqVirf7aRIeYeq37QP5/Gr5yp+uJ19chkhT/9uILV9Drq+HjOYjp7F2pWMx7/qcmAti6GU2LHc43nLg5AzIjvzlBE8HdTQiWIhx7QfC9En1A1YquJup2P7aHiEJlKetIgu1sZHP0eG/bmOOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdTWfu9r; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdTWfu9r"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3115c4451c8so373506eec.1
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791059164; x=1791663964; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0s5XHLtBaD6L82b8Uf8sUDVp1ZRpLMtNkprMH1cijPE=;
        b=kdTWfu9rkwVDLI+lMIZEXsAUjcugbS/nHc5o2eozf1y22P3gUUxtgZJcZaL1NivXbi
         1TJ+WsZ4AW8lh8ufxccWA5GJz5Ruxpedzx/DiCpTTxrTRawBtSKEcrv606k84cPsrU70
         hTo5cT2X/LNgWdxYZ6bai+y6jIfzsoUV6mL96nUSVWCnpp+qN8u50TDsaV9Q2KkdPE/p
         osBbN+EJC01qt0YNMW59tG8xFhs8k+rijYuMhlK/qg0RbN98muzoSHfAcnfvv3kPwKE2
         1GtddUDMh1ZaDEEaujO8OgAkxl8ufqHXvlZI3IhsOu86GvnCO8BqkWEP2dLu7i0ux++l
         Nu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791059164; x=1791663964;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0s5XHLtBaD6L82b8Uf8sUDVp1ZRpLMtNkprMH1cijPE=;
        b=21CC/bJ+HgDPkc0+h/qOXDZeHneZKvkxvjCVfXJDkfwLaDH7JOxSBHAaS9ruXWEz0e
         FMMqqMkISVlOMnoIMm1kVupMn296LDV/NmzkA+9ZAx++H03rqIhS5aZZhUMLXG1Fag1M
         3x0OdvZh16s02rk0K2gxbjPBD1qFjbFjHv5f9O8JZ7R8K8jRtYG/9wPjlpS4FXcWj4FH
         goZYJmt4XYUmmkwuxVPzWbQ4t9SmTkzXCLBTsxWoV5NnSsEODzMzmt6V99U1srNbptzU
         rTEg5gFSRos6TGOoqDPdAdZsNBI0VJOsLh4OasRWWkMS66UaCP8iocYTOXNspvpeflYf
         nGKw==
X-Gm-Message-State: AFq9FYLBCKC7vM+a+sqsU0vZ9Etk/NFZ+og+L8vHbG5EOCe+DuqV8YFe
	xWlYbca3bIdwSAIJ4g9xf13I0PgclictsibcECOlYhZw0t1DrLW3WTOSVGAIuyCV
X-Gm-Gg: AYBFou36B0tH1vhcCT4FwHNBrGWhrfx4GUjpNGnGa1OOknw/c0REIuswJiRdZo1v6rk
	9RPODBr5PyX1PZF3pYJzgPNduzb+hUZkb0KzrR900RXhZ56YZCWQMbN8E16MbTjD4sI3oe6TOJq
	w467jKvE+5kzSh1QfqiQLSk3wPDzY5HgQzUeFYCSwvzcoeGu3DvDR1U40Ae4rrRN77JcRi/oCcF
	GayJ8R/TfQkDROala11UPb7DUs90JewsYNF0FGgzbq1aXYs9RIK5zlvQrjn/B6srMTocHcy58Q9
	2EH8nX8MoQX2QRqAHzwObr9X9Bufl9zLlNcjFEcAVUySD6gwQi1bG9WPeF7y6WAgCRtTV6ml4H4
	vsSgHI0zR20M6q0YxW1JdxqQ867pdc5GK+BMqjFdVHnE6PdDGS++6uo7uUae5yxpQo3R6MIefGP
	0Qoy2G5XF/QY40kyBqtReut54QvLc2Jl3aeNz5mLx/E5cYOruePIx49qlWOVpFkwm8V/lrBReKQ
	pOXja/brL4=
X-Received: by 2002:a05:7300:c393:b0:351:2394:cb33 with SMTP id 5a478bee46e88-3512394ce9dmr449338eec.27.1791059163705;
        Sat, 03 Oct 2026 13:26:03 -0700 (PDT)
Received: from [127.0.1.1] ([2602:ffe4:407:363:fd57:5fed:bd71:7a74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c739sm19011641eec.3.2026.10.03.13.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 13:26:03 -0700 (PDT)
From: vineash <vineash30640@gmail.com>
To: stable@vger.kernel.org
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-perf-users@vger.kernel.org
Subject: Request to backport "perf/core: Fix WARN in perf_sigtrap()" to
 6.12.y, 6.6.y, 6.1.y and 5.15.y
Date: Sun, 04 Oct 2026 04:25:31 +0800
Message-ID: <179105913174.1859134.5466929391582828993@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Please consider backporting the following upstream commit to the 6.12.y,
6.6.y, 6.1.y and 5.15.y stable trees:

  3da6bb419750 ("perf/core: Fix WARN in perf_sigtrap()")

It was picked up by AUTOSEL for these trees on 2025-07-14 and nobody
objected, but it never got into any of them. As of 2026-10-03,
linux-6.12.y, linux-6.6.y, linux-6.1.y and linux-5.15.y still have the
old check order in perf_sigtrap(). linux-6.18.y already has the fix.

The WARN is still reachable on 6.12.110. A syzkaller C reproducer
triggers it from the exit path:

  WARNING: CPU: 1 PID: 1904 at kernel/events/core.c:6908 perf_pending_task+0x368/0x430
   task_work_run+0x14e/0x250
   do_exit+0xb5d/0x2ca0
   do_group_exit+0xd3/0x2a0
   get_signal+0x2791/0x2800

This is the scenario the commit describes: exit_task_work() runs after
perf_event_exit_task_context() has set ctx->task to TASK_TOMBSTONE.

Testing on 6.12.110 (QEMU/KVM, x86_64, same .config for both kernels):
  - unpatched: the reproducer triggered the WARN in 3 of 3 runs, each
    within about 30 s
  - with 3da6bb419750 cherry-picked (applies cleanly, offset only): no WARN
    in 3 of 3 runs of 240-300 s each

I only tested 6.12.y. For the other trees I only checked that the fix is
missing.

I found this while triaging syzkaller crashes. An LLM-based assistant
helped with the analysis and ran the tests described above.

Thanks,
vineash
