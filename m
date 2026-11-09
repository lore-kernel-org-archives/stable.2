Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264678;
	b=IfxvXLfk3Uh5YyAcw3mA9IRzKqRAOdehv5kbiFDLE0yXTJ/mwjYeWw2zvoeaKTd4i/Lc
	 4udVN0OK3u+kaDYz3BfgrOiydgeoi27/ulXNZFuonrGD5cIh42LNvO7kzKRaglm2Ibji4
	 cY8ti5nBb5DhNjNL12rtCPDeEhkNxp9xnJZgssuOnUudaC2CsMObUG0hqkTUey84ZrIXY
	 DtKevnOZH86gpv1tyOY57eDkidyxorGZ90iQpieMtEvvgWkLKKrYCiZQo9qxlszkkPq0W
	 zo0D8gxNUJtGT9YnSeGATKwWBod4hgDPyHby3P8nK+P4obK4Y+2c/li63IxInDAr4Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GWUozN1sqytVtZWyljEOiokdUvJaFMksU3vpzWBMOnY=;
	b=a39IFnZtsKd75257/ibq5l6I2Tm4EQAC+uf27pQu0Mc6AUDnHtKXrcs5mkCYT4Ga9/Tr
	 bWaz2OKZgELY8oeNvJ2iZoSgOaPC5/slDuhNSawwOEKQZYn3PmmUa8hyQuI2HVo5TNUcb
	 /RLZ/T1znXX+E0CvmnRHQzdKWqwkmGy6oUTTvdRS78SZ+vTFlTlegmyA4rVslucXoBHuF
	 oAjnQTafRr/yiQtLEaaTp27TVwls4Tb6AsHj3Kg1YMKD/iSCmpFoDDH0XXso/IZe8UZOe
	 5xGya2bsg2/sCIVQn8IRoU86w/xTLMyqK1XcnL9alOqV0rOam2O9S/Cn3VG7ba/qSqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ed5gRpR8;
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E5606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 22:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC7E5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ed5gRpR8
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-370ebdde89eso1456576eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 14:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794264677; x=1794869477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWUozN1sqytVtZWyljEOiokdUvJaFMksU3vpzWBMOnY=;
        b=Ed5gRpR8JZpQ3mjdaF+2D/ZXejb9c+tRJNLh20bGJtL5OTl+ggIN1/o3LmGLANEmTt
         FQ5dODG6EM16SFHhBkIi3B8bmlQE+wotstIcHb3X0BID2P+TP7LtVSJj5jHSL30VIhc1
         sZKniufqsUS3gn7us/9OJfVu+DVZfL1ZebwKEFvNT4uKT2d0GvHpg2zJ9TjCwxvDyDow
         zcZC6X124xiyz1dG9I5w9nUJMi74KPkQSFC85Qq4hkwS9nd0q5LK9exFhWYSdv+4w/Qh
         4bjY3TmKuqDzBMive9jhIPbDvjPHH95v30tDLQzXqYUoSomvIVD4XTvyLHdG6L+uXO9O
         uCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794264677; x=1794869477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWUozN1sqytVtZWyljEOiokdUvJaFMksU3vpzWBMOnY=;
        b=q7E6ZvAHvAvoTnAYy5DYm4GCfAr/0+VzXYPOUYUnjXat27HM2e3AjhjZTPsEWi2QCg
         rk/JSRTKfDntniX5VVKEUtTWs2/bPQ+efugb8CQimqzTeXhDsqDWIKAPlVygjS+J079b
         TE4OyMPmwDisIiW0ndHxH4G9atsI+HPiNNFibmrnFZmF0WAkrUhQoF0/7SFjU8Qr6Dbx
         24ZAsUGU+E2MW2GjTMZQ78WAZZaEUgeVe73fKHVrDOB6C3TD2S4Fj7/CivXIZs1nDi/Y
         REyoQlB4/GTHdC9Pg8s293YAgsW3zZ4Ig8Eqa1baUBswa4g5F61zpJl78bUiL8dbHyvD
         5W8w==
X-Gm-Message-State: APuU4Z+w/yOJs+lu/HycaH862XE70QU22ykBW4QVYNe8RLMTmJWfcLyY
	dt/5QZFR5TejklO589t0uZMdxrN4+ZsnUv4Iw2+k5RHUy8eEQNEAUnFnjZlCmBZjSw8vzg==
X-Gm-Gg: AYBFou2YCmrjQcUxPYvxaScIWcOVNiTZRVqM5Ok1dpHUsCuG3guVRxk5KRILaJHy7/X
	9ukhUn7xv+pQayhhrdhy0GqG19ss03Pd6JbnKFm42Kp1ccOxs0KmwOAfGA0P+2NO4SDIBe5v4Gj
	RlWNQYaA/pjSx386bg3D5TyZUnOamNopQboBlCUzwlCTWkzzTZV8Z15cQxaqbZEdreQoMFMFulq
	yQopAuTNXrYZiNk+6qiVLDY0wu1CFYUquPfyMxwQFl8GZXvHIkFFofJpFfX9S3TRI2ObCzzGQQ8
	P4qpjrXqKoIvjmXEvttiCGKRX2wpX7G7PSRg6deILuPgs4m43kzjx6pI59wWoZmI07XgwIlZ9hd
	ECYzg27l8HdFH2+8UkSLgt9Dbc0AOl0AltxceOSvlCItNVQep1VgbnUa0PJGglBa7SFUh0gNRQN
	/VXykPpkkMXtjBs0TgDwKDdRpTZovSUPkJ7XUZXAlxqWhBXrH8CfJVLttlBjjBYqSn5icxzfTSt
	cpFWepDMR3Mbw01Do5FRWHttxXoPJ0VnLg7AHuBlaYRXeHnOdjEwK8z7DmzkkIoHtKkA05lZPxG
	+H/I8TK5LgT/zFb7WhW4XhocTFIpOsL07He7OM4/MYRmNAJMY2ChEIDgP+FWABp26+s9bJXTlcg
	bV6MFTZHeaetECzpjnqCrxgONYtvAwxfU7rvohCDCpgHIG57YNByuuYn9NrU=
X-Received: by 2002:a05:7022:7e8a:b0:1a9:c52f:655c with SMTP id a92af1059eb24-1b3b618c8cemr1139938c88.36.1794264676405;
        Mon, 09 Nov 2026 14:51:16 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm1990127c88.9.2026.11.09.14.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:51:15 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	tglx@kernel.org
Subject: [PATCH 5.10.y] posix-timers: Accept NULL clock_getres() output in stubs
Date: Mon,  9 Nov 2026 22:51:05 +0000
Message-ID: <20261109225105.88440-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107062853-failed-5.10-5b819071e434@kernel.org>
References: <20261107062853-failed-5.10-5b819071e434@kernel.org>
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

base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf
-- 
2.43.0

