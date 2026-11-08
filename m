Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177368;
	b=vo4qXMoPRH6AI2viUZx7aTB8UIzwBpOe70mXC7XvKKt7/sVt2FcwNSt2Eghv+ymUI4jk
	 D4uJO/jWyHRzHxwymX8WfOBi8GB9jiRaIF/sTEeY8sRQlMX1TZ8ZUaH1fMmdzMp0ufHXG
	 UDOCSYWWZ60xEmN9RrTAynFXcJCJE8pHZIINJsAhne6LR9V7jC9hBFCpwBRE7KhRG6u/J
	 qzGsC/kGQq39LObVXp346cNqnnN1Ta2NrOWgqRZHyYFMNoYjH5UmI00wMQ5IFzlW86NN4
	 AVKCfbmMeW4Tmfx4caawFW8BK+dMr+8G09GSMSJ8dLF3ZrJMtg9Ukupq5uI57cN2Xbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0B84fgUAvEG0Glyv3A7RkeExOVAqdU6JtDjEommuU5s=;
	b=TUJ1A0vKG/rIT9Wj2DPVrECJTHDvgZUG9CJKA+NQg0iiqNwxhYs0p7qxz0EPdJMVB2DT
	 TSl08WikP4ynxq/l5xZAcyGSuxX2Tecqn+tGpulRo/MfrwMDM35pwqhLixl63LmVHL8/e
	 4aCOsS63MK5Oid3O2rZpPZM5YhmfTyvGIfKbyPAa0BU6Od6ohdHr8Mbqm8HFxCH0Zv9fy
	 wRtrdrqVyJoxuqR5VXp1xv3ZejpJNzbUN4SX9Gdj+pja1qEZpQAhTCpZXEEkKKfFlktyx
	 y0aW1elBZd6fG/t1TwfY4jJptMSWEhgC6WlqGXVVpPcILP7VosA+YESgWoiA1JYAjBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0myVGUE;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304B606EE9A
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3304B606EE9A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0myVGUE
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so384471a12.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177366; x=1794782166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0B84fgUAvEG0Glyv3A7RkeExOVAqdU6JtDjEommuU5s=;
        b=o0myVGUETIrYhSDiGMzAzUwj64MUtklp2Y9qAfc1GvUrFIIhzzPaL7EoavTacrJgIP
         VtmRTdUUic1gqHV0eLCEOcvw+/ydUgxQW18x+xkiqXNQzYUmA6dxGyJCylpe8BLrTa/S
         UlFpRYM32XnHsAUc6ov6VZs5So2lE60b7ojcDwodbhMXN1EkDfcR4gDK85xZqlks0BDG
         ecq0Va+T6sHti1Mr8AmFbgkjw7IPD7uixvMzKwTIXVN4Afin3AS9rgTDK++vQx1Hukxb
         tcVlyXE9iKNw5Iem6qjV5zK864QtDmNSzIyzVbdd16z3YincCLylWneKTvNp2lFBaslg
         kG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177366; x=1794782166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0B84fgUAvEG0Glyv3A7RkeExOVAqdU6JtDjEommuU5s=;
        b=LUkqrbwTKIu7WoTCRLZNkN7vxZX/rxzh7f7kU97nRM4MO7Bi5Ib1Q/nFWD79HhSg3+
         mfOGgR+pMGtC+vwAddCWj9RSKT/+DytTrUdu1Ufync+uzNllV+CPWaMqpxTP//uYKjbg
         XLiWDTUlF2LpRe7iWwTkoulbnljVE/P0K3w70zMaWqgG+uZbTc4g3XUQ51Y5y64QSGMW
         s07g3qBOZj/qJxBE0NiSEvdcuSUq9+9dUy0HlJ2z8Qron2ltx8R6CnwUfM+vBJWsDcPR
         YOJMNxi6ej3OXaPU4bHRl++Mt+G7Bgt0bs/SG0TS8UZV0gaxkjBbV7RZaZo/B3MJy6Vs
         zpsw==
X-Forwarded-Encrypted: i=1; AL+hErFVv4y0B0pnL1DV0vcGNu/xZz5x6wc36qAHnc1Of6VtmB6VZDSQKpx3TIXdsZOQUoCCls6MyZM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fLKC5Dez6D57Nc9ubGv0TJDBVPDwevlQNzSmI4UJFpriq4DD5
	roxOtFPcmsi4qxHkdUD9o0DKIcsGg9bs+tvRFfeY0izrV6alupTJqVQI
X-Gm-Gg: AYBFou3BJHgo0M3hm4bszrBbQgGrDNucuXqDWSpX3Esgi+IhiJ5Ikiic6G333U38q9k
	IT7CMke6I04/7eBOdiefhqq0aHLcCJ3FVOLLth00d1q2yDzpd27dbMM6IDfzm5FK3xephT5FeaI
	OTImR0vIbkmSFDM7eMljY1mzawoRun6gjkaKssNrOl3RI8PDo+YCs9Sd6sgyUzb7kjZ33j78ISe
	mfu8UGBrVzZjR5PGCqxwogYvPq3lr4oPenOJ4nyEw5xktEJcrdoHD0wuPIROIdAoMT39Z6zd/6X
	vBt7nMOhMDKr7fv5Z/KbzoH/4vSe66nblhrF9li/0r+NHll+w5LZCT+Fn8fRXqTQzUR4d4JG7kU
	EcsrXiJcczFxz9OcKeIs70aV1+AyXacO3cE/osk3VSLdwmfkLp7g0PE4MhI1fCXXZycVpI8uVkT
	Q5My2ZKAsIyqL+8BJSZkUePEOQH7jsX+inykpD6jrLxdHGqzhPN3WEOqdbi8QcVodBLTY2JNTtC
	8sNHqHXo1HoOdv6AkMPk6tFPWBcWTRqW1cft4+XYV4sCvYrNhZSFPPIwgJ9vitLO8Y9gqP5d/N4
	XJUyA13zHBNy7Maz1Mr18wgKEOB0r5+I5FldG6I//7QwkViH00sj3TvE4OtW8FvpPCMrKdnsoVQ
	Wi1kmwrGrm2FOLmYz
X-Received: by 2002:a05:6402:1d55:b0:6b7:6f9:2ef7 with SMTP id 4fb4d7f45d1cf-6b722456828mr1336914a12.11.1794177366393;
        Sun, 08 Nov 2026 14:36:06 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:36:05 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 8/9] sparc32: retain mm_cpumask across TLB shootdowns
Date: Sun,  8 Nov 2026 23:34:18 +0100
Message-ID: <20261108223516.1125534-9-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108223516.1125534-1-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
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

smp_flush_tlb_mm() narrows mm_cpumask to the current CPU when mm_users is
one and current->active_mm matches. That snapshot does not exclude another
task obtaining a reference with mmget_not_zero() and using the address
space through kthread_use_mm(). Clearing its CPU bit can make subsequent
shootdowns miss translations on that CPU. Testing current->mm instead does
not serialize against that race.

Remove the narrowing. This follows the SPARC64 fix in commit bafb056ce279
("sparc64: remove mm_cpumask clearing to fix kthread_use_mm race"). Retain
the accumulated CPU mask until normal address-space teardown.

A single-threaded mm that has migrated can consequently need remote
shootdowns for the remainder of its lifetime; sun4m broadcasts them to
online peers. This trades extra cross-calls for correct coverage.

Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/srmmu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index aa53ec10cd8a..d3634bcb048d 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1624,12 +1624,8 @@ static void smp_flush_cache_mm(struct mm_struct *mm)
 static void smp_flush_tlb_mm(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
-		if (any_other_mm_cpus(mm)) {
+		if (any_other_mm_cpus(mm))
 			xc1(local_ops->tlb_mm, (unsigned long)mm);
-			if (atomic_read(&mm->mm_users) == 1 && current->active_mm == mm)
-				cpumask_copy(mm_cpumask(mm),
-					     cpumask_of(smp_processor_id()));
-		}
 		local_ops->tlb_mm(mm);
 	}
 }
-- 
2.43.0

