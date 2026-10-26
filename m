Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976539;
	b=UEr6w81fJh7Vvx9Jdf6NRJ9MXwui9s64r9RhtQulN8GEgeg5Mh6bCmnXgQVqghViAt53
	 L5NdKghbQp4Dt5d8505eSjtkCXZDdcceSkpsp9UCaeDfkmo5EMtmk3M6sEu8523k+Dhlk
	 Xu6dFKMEUm8D9SRCkZLln2fo8iu5S+AyFHS1PEzRtDAMNxQiDX8L2dv5fyatakSq0NM8O
	 +4vkX+d9uEbdfOx0sEBydhcQhWfFfk+Tt00PzzeQxLJr7fDmqqA9Fxt2mc6VlZzGWEPX6
	 Sb7ASqdbs2XRLqImnuwsJAG+thUA1dGsHk9+Ai6zgodIj4m49BaDVPFXJAxCoQtNwFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VjjpT/WS6GzMNNn96hvzrrjqoEJgWtlxD5KPXsnUWGQ=;
	b=2kl4OT/SSMAjZruW+YWWR7QVAwilHUTJUMjHUHm0rS8l0MY+Hpfq0CX4h3+HUjB5vWI8
	 6YlPihvAixZu03l0kmr412st1eBAUBxwC5tmxa4a2DUD3awrVr/IV0Eo2sxjo9LZ2sNeC
	 wEGp3dzo3s9regRFlf3O/siZ7fRpPy1nV3Fx/fSxQKOAyQ8pzSPiW7140GNEPQNAl73JF
	 cotrNLOzmciWQYCr/wufm/tCNCi+ZmyJFhS8ul0TpotFVhbvNZ5gcupi76kK/jWu9A7aA
	 hTZ57j1I2yqz9CgFg9zjyzSL8bJHbif6Gtec0A1xDgQ/8QmLugTlmDsnNCNlhRzBCNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=syKs5b2q;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823F606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 01:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B823F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=syKs5b2q
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so4222635e9.2
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792976537; x=1793581337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjjpT/WS6GzMNNn96hvzrrjqoEJgWtlxD5KPXsnUWGQ=;
        b=syKs5b2q4e1IzBryiRFLwcyDll86H3tx7Dktu/J6IpyrTDrxTtiPItnGkSA5E108f/
         VGkV6VFQwkLG1pyvv+xHxjs4hpNivcKL1UOFK89Zno9yBNHFmZa69WZeEOZu9sZX/gIl
         S9adAuTKaqwKT+FSxfHNw1ttbx+tAhp99grNniEa9vzRVmEsZEziTjdCrQVn9GaCxHc7
         x30UQVKAwhGXeAyP/vZyr577/YYIlzctXSntmBeQg1CJe2yj/doYXVvEtf4lMVVQi2zA
         s7kfyI/N8vxtghNzDxvHLMeQHMfwST+nkh0UDLe8suv+OpgcXYOA4D8fVXpfeH8Xhksx
         sBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792976537; x=1793581337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VjjpT/WS6GzMNNn96hvzrrjqoEJgWtlxD5KPXsnUWGQ=;
        b=nSqnTWc+HvjKwZkX67qxcdnkha5VS6qLMKl3U7TOWFrn+ogAPKac/VppoBw8XZ2wtJ
         sSGx0LaDsfFPZPAF0yy/8H4PJJRrmSO7Sz9ljAIxo+3J5lL2sinPl5p2hVmt9K/gvYqW
         x7PQwckhRSRP8mXeMwpYJBWca8+nfgRsErygTpQPpAUIL5Z3hRenhVLrNbSf68RRkTmI
         hiyWEORbUXWYwZ/055ZPBkyA7EX4vmyMpS43I8aq0PrgJ9ac11cZNktoq+DRpLP0PLWP
         mvbHlox4wYAGcBKFrda0/CqIguxuGcpFkSXtGLFUW89jTfU8Iuf+aonUyWw63trpQ3KW
         tdlg==
X-Forwarded-Encrypted: i=1; AKwUvBy1zvfws804dHRNEO9fdS20nr1gWgFtZFQmjzpLYhE0NoKqykE0W6R0BDVQ8XOvGz9Qcn/7ppI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJuamcVqVKRDHEBVoYzx4pFW055byMM/4ex2IHFgKqiZyt+Fmz
	glsUI+VKicIezN5oitq+jps70zKDGF5lMtMaNo3MkX7sW2nTB2tB9plP
X-Gm-Gg: AYBFou0qnAnA/qd1usfOzfxAXOQuXcT1SVtfVAsl+avOEtQ8sz9SMCtVYmWtJdikyHY
	2nMjkw+p0ycuEvt15B3J9GfDxkaQZIAsoa7XZ31GsOxBj+MItoSek1lawIizwKxFaSBfwNNRrtc
	g0rUQFkY09i7c2hcfffXLG3z/o8m+JGwjnIytsCEUugQ9MJH+IWWjvuuCK9Pahm5dRRyKpPVgIq
	Gz2/lEHfO4di7bZ0k1/T1ee8eXxAKq3Jl59ahgrFKOXy0OHdficn44H1z5VJoojB0qs8o2IvPZm
	gvzlg74ymj8FCPtbCavqIGl5CkU/MUpPjUCS8XGZJkk4SHbjuM92Q0NUYlIvCWP+8W3bMDGFn/J
	6cv91TsLuyObzsAQ6lNfbZS876fep0scHmlnduj5L38nzSmR/Ur+YtkU4sMPWUG0la7fVN0xQVE
	MJfW9fnblHHRkz4XICkDX0gFlQv4XdncA8XDX9CXj2CIe9xviflLHpIy1KV03zG/GynBaHPjoc+
	+zYKteQ5ss+LzQ3jG9ShYY8SVHyN+hTWnAA6FLPCiMmTMVxjbTbddKyruat21d1kPXhtfLEHV79
	eb4G+ByH1yzXXsendfCaZ8nJjamOW6wVfhb+g9CXHQ8D4NclmvGCbuat5Evcbh72PYnZuWnzCnE
	vNRV1+rBD1EcI08Sml51dQNrf5kE3S10faYYzAHwHKx4+QRKwsUXDSZB7+Q==
X-Received: by 2002:a05:600c:3148:b0:4a0:1efa:c74a with SMTP id 5b1f17b1804b1-4a35ac96da9mr81454535e9.20.1792976537008;
        Sun, 25 Oct 2026 18:02:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a9cc-4401-09c3-9199-30c4-c6a3.310.pool.telefonica.de. [2a02:3100:a9cc:4401:9c3:9199:30c4:c6a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd354asm12325195f8f.43.2026.10.25.18.02.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 18:02:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Jiri Wiesner <jwiesner@suse.de>,
	Daniel J Blueman <daniel@quora.org>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] clocksource: Prevent immediate watchdog rerun after a delay
Date: Mon, 26 Oct 2026 02:02:00 +0100
Message-Id: <20261026010200.96371-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <874ie9zc3g.ffs@fw13>
References: <20261010065509.72916-1-kmehltretter@gmail.com> <87a4oeerwm.ffs@fw13> <atmhdRzqx5t8PYrc@gmail.com> <874ie9zc3g.ffs@fw13>
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

The watchdog rewrite made the clocksource check handle long intervals
between two measurements, but missed that the timer expiry needs to be
rebased after such a delay.

When a watchdog invocation is delayed by more than one interval, adding
WATCHDOG_INTERVAL to the previous expiry leaves the timer expiry in the
past. That causes an immediate second invocation. The resulting short
measurement interval can mark a clocksource unstable.

Cure this by rearming the timer based on jiffies, which places the next
expiry one full watchdog interval into the future.

Fixes: 763aacf86f1b ("clocksource: Rewrite watchdog code completely")
Closes: https://lore.kernel.org/r/20261010065509.72916-1-kmehltretter@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The baseline and patched builds used identical configs and initramfs
images. Tested on v7.3-rc5 (72d3fcf802c4) with four QEMU 8.2.2 TCG
vCPUs. PTRACE_ATTACH stopped only the vCPU 0 TCG thread for 800 ms,
six times 12 seconds apart per boot.

                              baseline   patched
TSC marked unstable           2/3 boots  0/3 boots
boots with gaps below 250 ms  3/3        0/3
minimum watchdog gap          0.231 ms   505.484 ms

All 18 injected stalls completed for each kernel.

 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f1253f5795c6e..58c0ca11cdc5a 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -673,7 +673,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 	/* Could have been rearmed by a stop/start cycle */
 	if (!timer_pending(&watchdog_timer)) {
-		watchdog_timer.expires += WATCHDOG_INTERVAL;
+		watchdog_timer.expires = jiffies + WATCHDOG_INTERVAL;
 		add_timer_local(&watchdog_timer);
 	}
 }

base-commit: 5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f
-- 
2.39.5 (Apple Git-154)

