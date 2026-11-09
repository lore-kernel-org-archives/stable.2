Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267076;
	b=SOD3kFx2aF5vCONPquaQIHSzIIhW2BUACJ1SHscs+7nOcHIiQtwyiu9sZgdIHxxhRmY1
	 livbf76luxmYAJ5jtaGOOzCzm+T/4FZpx10FSfTpSsN+f8MPnWslnIthw+MtC1c4yg6Q2
	 gm+TFS834PiNS8Enjss7SX23J6gk1H+/aTSE/ONQvpU/890RyR7qCqHSR8hSt2hGT4yAX
	 dUHLiBYJMutr1mJYM+WNSRjfKR4fqRxJ7jXhnAbWUvmHq2up5ef3eub00uvw3u/cSOdZ7
	 sQ5b2MVs1WDj65lsOdOLFQDl65HlJ0jFPI47/PbvTYyF0K02t6QEnjz0hRtvcwwG40g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9A+riRpNVQjJl6veFEupozIlqUK4M9FiY8IOzpN2iZc=;
	b=NNvKUCskttaTJ1xAZZ7eGjriDnv4AAbx5C40t84dv0RdJrcQXvF8cU/jAtRVCRhS9nHK
	 Mt0quOCIvq5yfrzgTF96mTDbZAIsJ+S4TWMqi15VJVGbalBir+WbVoxamr1f3RAPZjZnc
	 9CHYti3NYtigHs5KFJzMQQ5eYHl8mRDTzx//NPD16pN1OkKsm1ahfi/Gt1uk0y1TXzoYl
	 uzbMFt4Mmf36rr5rsWWDoBs9YiPF5UTkOdR8nwaiVcfyYgs/Ng8m+JO4SunM/jZlMYAMQ
	 XPJpRSFWV06iNL7V46xj7VbFvJvrUZ1D0bxyLgBsiLDTCHWBZI82Oorwb74c6cFIi3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMRpAaPJ;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8460A380C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 23:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75D8460A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMRpAaPJ
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso1973463eec.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 15:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267075; x=1794871875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9A+riRpNVQjJl6veFEupozIlqUK4M9FiY8IOzpN2iZc=;
        b=eMRpAaPJmiuHx6pVm0TFc70sjwhGhXiYffzIKSnWtHNWoD5t6POQHufo93M5Ej4KG+
         MLQkMl6KTybHsqfsgbTbpgF1b+kX+CN03uR+SIU43ExgrCaGqE5di+oxHLawkJrdr2xP
         OR8Tqj5PRaGPUqKOe2nTy3p//Pje1fd4tAb6N+Htkgha/a0F+Uns7Cz2e+QrKJBAwDJb
         jGiNz9uic256rPKQbe6NqVjkP1EBIGxNz9HZd0PIq7INI+bOoLlIKzMUjQySzNfuxDL9
         UQxzAQpkfElm3SRLTusD6pcAVSFsUrTX2NBDwgEdXUlKHXIRQbWv6TWYJhVKgKN8ZutQ
         7NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267075; x=1794871875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9A+riRpNVQjJl6veFEupozIlqUK4M9FiY8IOzpN2iZc=;
        b=EAQrKiaGK9GIvWSG6nSiA3tRVDC+BUe8sUJYSWEdid0t61p/oUW/CgE/1sgzPZ7+04
         83Wqc5WOAwhHGlx1QaRwgxcrnPP8/gPu8mRUfyGHPwI4p5AKNg8beVFmXlsurfxiCKgb
         e3/qM4jvyRBuofHZLmlZQ39DOpnG41wK4VlDJSLOZXM2KxlwZpQRAFcpm0VfBYMRRmgU
         3ai8mUaqDjWeWyuvzNwBRMTP8KoexIbNBxAh5zVICFjDs0MXvrR3lCcarMbN/9dSHZlO
         +Tbf7OM7bjSJbMBYGCCPL+gUBvAGQNKJmIxWx6WUa7Mnt00X5nyHhoYXDLnNwyCcbCm1
         H5zQ==
X-Gm-Message-State: APuU4Z9A1Jr+BYCYykVVRdhw7wE46NHqSyJN6tIqFtBWpHrBwpE2iqzK
	QqJmPwz5BSeNB7T84RxexCzq9SPCrdLsQb4pokXx3BJIyTWDVJ6leBjl3Z1hvcaV0faqkQ==
X-Gm-Gg: AYBFou2Nxy05/bPblWBKSu8cRaX5RqtGAXkf9J4+RJrBkHorwaj2LdQuJbYMFeM0SQ8
	4hHH5BTpgybn52C68q2zbP+LWeiSeHedciRGWT/3ytU047+kO0JUVrmVmMrzacGcA0Kf1HQu9/X
	pxg1WLWIhtKvCB1EuZCG3e8b+7iGBKipRYiOWoFDNmKG6mYR+ilwH0LqxzXGTot6RXFPNX0s0BE
	VO2kJZD7sl06dc4NkhPYyyotLULpoiRwcXeDTq3BkEnuCLWiWYnNHoQO0FEpHSIacywhxsOb18a
	ehOup29SQORBKYST2fAQQEXH3+IKDAKYNya6ymB6tsbxMk7F1ZZ6iS/ANBaSKK0PeFszeppVyIq
	ExAvl3ov5gUNGXjFUDMzEHRH8xCr7GKXg5zXUOSuCA2yUHzMAc5q0t6Hfcwf/UAIfYRQa1DNLrU
	pK0NIuHRat4WgC4vX/98MOgppKfhKmCSKvu3ltp5JuQnuYn61RpfZpgPqOzUT+2bwRv+kaLMOhF
	XYGF+fh8+jhbIrV6JS2MTM595g6xtO7HhyoCS9cQ14cTK7p/VhbWuB/IquuDS4VG8KDQqmQOJAm
	QtpNDrNNqqbxaFpD7rOcnccof2Rxc6HAoPeoxJB9Ru4Ela6ig24GknJPN3ndMY8gc1r0f49i8Vy
	Joy4AT03JCkXj4uy3e4kmnRMTfbBXBfe/fyQrnAQp+wH0LD0eJ4DNa2Oo6RA=
X-Received: by 2002:a05:693c:8209:b0:36c:a281:1bc with SMTP id 5a478bee46e88-3751ef77a42mr1127299eec.16.1794267075405;
        Mon, 09 Nov 2026 15:31:15 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe32276sm1611038eec.8.2026.11.09.15.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:31:14 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	tglx@kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH 6.6.y] posix-timers: Accept NULL clock_getres() output in stubs
Date: Mon,  9 Nov 2026 23:31:05 +0000
Message-ID: <20261109233105.56689-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107053920-failed-6.6-5b819071e434@kernel.org>
References: <20261107053920-failed-6.6-5b819071e434@kernel.org>
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
 kernel/time/posix-stubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 9b6fcb8d85e7..5a27335a917e 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -83,7 +83,7 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct __kernel_time
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_timespec64(&rtn_tp, tp))
+		if (tp && put_timespec64(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
@@ -166,7 +166,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_old_timespec32(&rtn_tp, tp))
+		if (tp && put_old_timespec32(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.43.0
