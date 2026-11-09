Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268318;
	b=ompU/83OgeYzqf1rb6SfHdUb4dUWTxCi5jIsqx6ghkT+TluYBJwmRoV/YylhNrpybaQl
	 xbxG1BQJgGGygOzJXwtnWqrCIAJk7J3qUJMMby+5nhRtCuqTE4vLeYtpx5C4JjUenpyq1
	 yOT6Bl3lDRLEbasS3/cARmaqXuWx8ftHj9KvuAVuvOq2XgUdP9WxrsJHx33BM8vs5smtJ
	 ROL1L9L608mM9eEiSMYJelCiP/P9u5kX0vriVHNmU8yBduDW7XFOMMJAjnw1zNFXGYTRM
	 pHe2qIrM70x55nkzwwJzclDtPa2aw8/5Plf0MHN3FIGuZlkyiA6HAvLzTIG6S5fpE6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7KjsTDBP9RcEdAqDEWczYRKvLM/EUWKmbXRYHg9X7TA=;
	b=aL/lRDcQsiB1iOSWbwKDbSspDg4Loor8kit1Rasyh/q6e3OBC89e7YoFiyEzvPFpeTXk
	 JqlASjVAWPH+BpVz4m1JWBCyg4UzdoO1rd8tmHgsywUqb3xRzTnK06n7NbgSX/Vr90gMz
	 n40lfsCN/GwbGCAf798I73SpUTEo2OMBiXTFGd/VC9K8MvHlB1nz26d9GfEMzYCZzA1aa
	 HsTCetLLWYnIuN1mukUyVKQVWRw0mxVdjei8NEvJVb/ZH9LP1REizErpQC136wKftwIm0
	 gZUxucq2lit4lJMTDYvZPGU+/IQLlnBpfdscrrZwcom1r9EMbe/DniFGu/I98keWHZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEYIy773;
	arc=none smtp.remote-ip=74.125.229.136
Received: from mail-dl2-f8.google.com (mail-dl2-f8.google.com [74.125.229.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020D606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 23:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3020D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEYIy773
Received: by mail-dl2-f8.google.com with SMTP id a92af1059eb24-170b3a08758so140935c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 15:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268317; x=1794873117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7KjsTDBP9RcEdAqDEWczYRKvLM/EUWKmbXRYHg9X7TA=;
        b=YEYIy773+KKNfXK289cfGoaCNclwQ4YaO/V5yUKgGjzv3UOcuSbYh5ol7PFMHbdSDo
         HlO0Sjoq+7H6hD5eivbaLZzZ0LvZfgh8ZaaJKSrBy+1XVYL0kWc/kuRA0lPIySn9S6tX
         GzsSjd3+/8wohmKmWQLxlMKtttyA3kvEUt25TREAUGUl8E1yMJnnmbe8bcB9m+ChA9OW
         fmY7/ionUMZmGNmvz5YvHNsMYD9Be5xziis6V7NllkSMwvnQP6iDctCBmRp7ihN0TPwF
         GENPXGg1hwqSQL3j1jicXpLwXGgDOsz/LMovLzUT1YaYKdCNxQ5bJSl7H6GMmU2bH1SL
         BpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268317; x=1794873117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7KjsTDBP9RcEdAqDEWczYRKvLM/EUWKmbXRYHg9X7TA=;
        b=hvPo8HzaERP1I7mUYrclq9PnH9NjrKPASEKxfyx0E6d3aEcrgcJazYjH24QFHfTT+i
         TGyibc4MvoiCGNfX3tLjCRjei9uxyiC385Ohj6lnn7W1WWECFU9+7sr0fPaFsbcVZyTw
         JfSJRVQijNCB9Du8lyiEBaqKZB7s9x6RIu/EuEy3oB0hfjIK0o66eEDFgR6yqCjTO+ZA
         zZGHOv4HgYbYNOZiP3oJGdF5xnop9Su8hrKSfFprFIGnZPh1F03Q3EyuHwhBpzV9iPqv
         mOozEqX1NYtpgxhZHmcrnK7XUJbsAvoAyquSuELhuEXzSj/qTtcKxo29YWoIA8RqsVTb
         L4vg==
X-Gm-Message-State: APuU4Z9kOBH1U9zE3MhNriWwhApWu0y7IUCcUNtbWPWFWClGL9TRbJ7X
	H9Us96Lsa3ddWufxI5KvVkWsmbPI6Z0i4RNzbCJI0PTxLBwLWmAvU3mi1So8mOYoQa9k3g==
X-Gm-Gg: AYBFou3AHGLb7X9cydHfqRDeT9Qq8F/vHIV1T99wTKhlQiW6vsUX/nQSZGqWlsm3C+5
	l+n9C15eP2sdjMeELYixxlGKG0UBS1hlpjEtpIcqpQpuf4jUtxokFXdcfmofCv3Sgjl7dP7K0ds
	9ps1c2iEE1Ho3YIrISsALt1Sa3ghCrCJM21dA8LrhbXzBZlz0vbIy6zFWzPsWUbtKul9owYW6sH
	RL/QLKO+cnuuwR7kVf8b6I1jMdea7NfXymT8jvjjLl/pqAG+Jpf+u/F4dwFNRXRjAzJPmKR/wlX
	rJ4/3egwgqxZ+lWH3aurjGXvhINcmv6oU0CLeWrZ2gpqcPAlX80jPlTTzchOMt9yLsgp58N9+Bh
	v+f1t1WhE+fgHOHNhJnt2wfZT4rTS/G2pEtP/oPSU9d1WtUxBtlhoNa7kzgSp4RSnGoVgz7xJPN
	MY5VX8LW/YSj69FQe1Fe1+REyeoWf1enzB45jjqohXykgPgC0TX/c/fGvnw/e+d1WedgNSgztK5
	mtjynd/UAJWlqFc9bdbb1xMwZI+v8ZSuSUDRYY9WlPgHUTD65ygeSqDevMsweAYBmjqE9s1YEfr
	37B+HS3t+BiQ0t/xEFNAEOmg5Ank7iqMyg/Yi/rBA+1fbRfyYtRD3yWEQVQogwJJGDAhP+OnJsx
	zSUZwd7zR84/aUAe26vnee2oCz5OG2IFimA212Q==
X-Received: by 2002:a05:7022:3a85:b0:1b3:aceb:b8dd with SMTP id a92af1059eb24-1b3b6023f4cmr1260908c88.38.1794268317164;
        Mon, 09 Nov 2026 15:51:57 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc09sm3802316c88.10.2026.11.09.15.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:51:56 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	tglx@kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH 6.18.y] posix-timers: Accept NULL clock_getres() output in stubs
Date: Mon,  9 Nov 2026 23:51:48 +0000
Message-ID: <20261109235148.96015-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107051443-failed-6.18-5b819071e434@kernel.org>
References: <20261107051443-failed-6.18-5b819071e434@kernel.org>
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

base-commit: c3f63d70f236bb7685e6d11d1d9b5b351552e600
-- 
2.43.0
