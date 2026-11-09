Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265510;
	b=RxRWgBtik2rZO3ce4KMmnaU2xgcgWFvKfEP9RD0uDwoTLBNFeYF71ZTWBp9ou9sKZ6pR
	 R3hyjUelsxkaK8wpccEQSVndILLx/GzeVl1JVDdh+GDDIUaYi4Ks5oiP3cvmZtzoJkrYS
	 CoTuyQCvbfJpPqcbWYc1daYsuLm/dNBSajwNSNeEQBfKrZ1qNaICyHQOJNTRyUCn4dkv7
	 K3tc5SA24wSV/V5T3xLlct1RxAVZdcS0nqu/eaqXZJD9a0lSOCtj0d6ML4TeZlUeGwlrn
	 pQRWNHwSYijL3MphmnT9O3aexm0U7Z41s9hZzOCMeZuAabkxKXOfxlJ9H5VlwIDb5hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P8PjP82o/EfTnqFYs8D8gKcmhgQE30cCvqMNx1IE1ck=;
	b=3/edabUZMm3bMvN4KEC80w/yUZ96tFFL1YXDETp+8thAopnfcTt+3KeCFUEviLQvO/U1
	 a3x27aMyyrTESSkcXeK7E7AP/c/z7gyNlp5yr/+W+ZONvmpQYsaCAbs0zaF0/jk4rVuIR
	 3r7L/1nxbSz1RMYlRQtc2prEAvEkswjkMNjUmPiu51jCz4NNhqXSb7Cr5WjkWzaBBZno7
	 PN0jcQZ2dkRnqecKif7/K3l5F9+KfVA9VlWdAGK5eEvzJ+Zj8+vDZIXYVbviqbbBAConv
	 t+7J63OuLGX516swYWt4XYNaBSoAiYyQxYY1hVPxPpBqG01ihbyk7I9rgq7gUSWIQpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DIj2VjLX;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A524606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 23:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A524606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DIj2VjLX
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so999847eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 15:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794265509; x=1794870309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8PjP82o/EfTnqFYs8D8gKcmhgQE30cCvqMNx1IE1ck=;
        b=DIj2VjLX4eAFVTOHI6Kqq6l4dSHUr7pFdsnTWediAx4c0ALGEPr9xd6nA40yAlM4t5
         ue61UyjI1THSMVJ6GcIK4xK+4wEjmasTgWACNJFLl/3jaX3GbDpWMCQUcpgld8EpIqNY
         n2xlRuFEkW0aC/WVX/SFqJeFFW3YUoB4AcdJJom/gbkSwtlRxAMSwMYqFwGH4IbWgynf
         atcZOH7LA41lJqAar+56HK4Qo/fCh3yKwKJDgbk+fFP5+JJR09j7jB6853FqUMe79alM
         RyFrGC1YEkNQF4bu4h+zNqBMli39rmwxmghxvAFYjktkK5ISLbRp6ix4rIgkDyXHHRuN
         Nk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794265509; x=1794870309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8PjP82o/EfTnqFYs8D8gKcmhgQE30cCvqMNx1IE1ck=;
        b=g6/NOLGl8WOHojZuLO8QhfPIOAQk8KN5d/D1nglgTfUBLR/Uo8qO6UmEnsKpieL7Zc
         v9WnWrUAMCUu8EpJ33DZOQsZArHvjCZt+xT+GA4QNESLif52VQeu3tVJc0lGD83XIBdf
         iwDXXBaC/5GNPZ3Zu+lbiiR5i2aJaIGFPs+J5nfu+zP4+JP5MORwLxMHSBs3wJSe4ixy
         GcKPONDrsq5GipggYQdM8rH231lZnKr3gvSQZkN+4/90FCrFtbPfmQAdqHTayuWZClM2
         BmVU8SLGQaL66k88/6RxEFvWOwSIpYYUH1FBlj4bakzJL4Ejid8Ti3mQJy4n/RhKsUSs
         lVrg==
X-Gm-Message-State: APuU4Z/UZ1RpYgJ32FIMPJ0FOQPl+b0HGSTA3ylSHx1BVy8J+nBvPSwW
	58xE/xcSDzFWlJp9fuNHl51OHDfHWYSDWPATx6JbHTDFO4gkohSyYUt/rr2O6Mvh8TW+Kw==
X-Gm-Gg: AYBFou3gA257mTHxfXqlZQmZ6PFMGMYakCVhWSAC/2So0RXoppz4e+EgY1lm9H60OSi
	5ptuBR0yLD9AqY8YQ++BmMjNRSjPU/wRerueUg1mbiCLOoT5e4/IIav0L2EcAqmApImK5FEJm+K
	qgGy9i4iyXfHjVbfxy30CtrcZ3nqx1YaFTH/OrKVcA0MVvA9GpI0AkuOhrKj1jBLZSiIEFpF3tn
	DFS/BDzhmTBOpu+m6FJKyl30Ux6ccJnuQ8lO3+QlfmD2y0MgZWMAoDtvo064yBI8eaJ60j8pwT1
	Qt9Ns4iQHnf6CRHsHNjdCtAQJgBD8+lJoSt1AvZxRLGk0LLhfTbrOBdvXMfZzgSngfhzquOnNBp
	i5xPThCv0ao6If8zfDwVmqSTJy1svgKBjoWcUe0sU/fOFMOuSSJdtMRppCfYUDHcFGx4qGImeaN
	miLLxokhSW/icvlEEQIVNRLqouojNesegJg4eg+zLkRmKrqAH4jx1NOjedR55AqEv1VpcBpUUZA
	haKsfBvWGRMj2NL6WVnLZo+Nn+H9Pok7W3Af+gjDuFzKJdPTU5TTDf9/iqIeQLTQeZ43H4TFjvV
	QTGApE8K9R3jqQ9IkMMUXyVZguwFaLOQWlUOWmfrfvak2f5/K8Mqim8bS2mKiedYP0943jwVa8N
	WW9h9n+RFO8Q4j0IuFWFyp/MWsA5pu0kVY2Du2A==
X-Received: by 2002:a05:7022:5f19:b0:144:eaa7:2763 with SMTP id a92af1059eb24-1b3b60001f1mr1136139c88.16.1794265508993;
        Mon, 09 Nov 2026 15:05:08 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512ec1sm1420888eec.12.2026.11.09.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:05:08 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	tglx@kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH 5.15.y] posix-timers: Accept NULL clock_getres() output in stubs
Date: Mon,  9 Nov 2026 23:05:00 +0000
Message-ID: <20261109230500.10899-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107061155-failed-5.15-5b819071e434@kernel.org>
References: <20261107061155-failed-5.15-5b819071e434@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 5b819071e4346256c4edbae5cc2095dff25694fc ]

With CONFIG_POSIX_TIMERS disabled, clock_getres() returns -EFAULT for a
supported clock when the result pointer is NULL. POSIX permits a NULL
result pointer to suppress returning the clock resolution.

Only copy the result when a destination is provided, in both the native
and time32 stubs. This matches the full POSIX timer implementation and
preserves clock ID validation.

Fixes: baa73d9e478f ("posix-timers: Make them configurable")
Fixes: d822cdcce43f ("posix-timers: Move compat versions of clock_gettime/settime/getres")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020161121.85042-1-dennylin0707@gmail.com
---
Applies cleanly to v5.15.225 (29c6cdaac04a) without changing the
upstream code diff. Built with GCC 13.3.0 and W=1.

QEMU, CONFIG_POSIX_TIMERS=n, uid=65534:
  x86_64 native + i386 time32/time64 syscalls
  Before: 159 passed, 9 failed (supported clocks with NULL output)
  After:  168 passed, 0 failed

 kernel/time/posix-stubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 3783d07d60ba..4eb4d7cb6179 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -116,7 +116,7 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct __kernel_time
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_timespec64(&rtn_tp, tp))
+		if (tp && put_timespec64(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
@@ -210,7 +210,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_old_timespec32(&rtn_tp, tp))
+		if (tp && put_old_timespec32(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:

base-commit: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
-- 
2.43.0

