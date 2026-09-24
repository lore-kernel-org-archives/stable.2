Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89C414DFA
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271530; cv=none; b=jd4QBB9DItyD4efzaFfehfRlxDfJcd1B8An834uRFRUq9PsxGiMmYPnJ7oqUFXjDH6GtLb1ZShNFes1kNOJ/dQCFaDHT8gxe2KWFpA/MKuyZSmmVX85NgH/Q4y9gQxv4nC5lIWur75ViCjPdOFJhtizdJhFwegr+kfdlQciFmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271530; c=relaxed/simple;
	bh=NyMX52JyA02kh4pbyRNFP3C5O6xMYXgI19hTNHr/ZZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfJQiRlYp3wJr8galN2C2RWuu+uTJVNazhALH5fMZq3QXlF07xZWhPa/1PMbT27eLc1w79gHDv47ZhLdD7QyiPX8s+6OdyiwwuvImx7B+x8PNVBIwsL98v+FJkWuT1unzIs1ghqjSag/4xlhNVUt+a8DJUhrvkfmiQ2gBq4LlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=EPvxEQRT; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="EPvxEQRT"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so113523b3a.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790271527; x=1790876327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1c2EGZGxAzDBsgLy2P99YqOfGYlohir92D2nOhn61A=;
        b=EPvxEQRTSgZt6jrh2tFA6pxcsr9zDuQhE2fdQpKs8Ydq70s6TOwlHJiDAicFxvsIKY
         mC5D3O2JqXFjtzCLJybp4Vo8ydUxk6oXRbmyA5KLuaaQJgL2KTo4u5o2zKZ2j9HNmfCH
         94DFvCHFH6oqnsmI9Dsq6atwO7bQtzFToYTf73kjLkUU07kutyPIRSJeBery5tm69OF1
         5MIyKT+mLd6IPaJN8x3jAapcnCtysv2M4STSmiKBg08YmX4JHRR8WnYHX/LeH+XGonOE
         Uh3Oeu64d3dtG6wB1VDwjxjY6R7N2byobLKBs7lUw5QBEQOeXJA9GYK/ZREy9fikMfkW
         7lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271527; x=1790876327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1c2EGZGxAzDBsgLy2P99YqOfGYlohir92D2nOhn61A=;
        b=gDoXYsHmkJvbmMBeqS50qjwhSt4sFpOEKR7nuhxokqrS7GAYqtOTyHyX5cgOOwVt1x
         5ia4H47i88A0hGMJMXHlmRA2splkInb94I7CycRCgm1aBxL8lk2QCV5zssiz73UxJ2k8
         8Hg2Yp2A56uT5DXAfoaSMgZEY/JCoMIduGrGoYujrcIngNFA22WG5rPmNfZRaIOxii9L
         wVlOk1KCuYQ3vw1BG0JjkJbUiYXifW4Z0Q2VI8xmGQIb5JDVxehED7j2jdKu2QAkBEkF
         3V4og+UXbc2+epfKlU97Bss3vaPxJmbVXi26NMDmOBxvU92xNHRm3tTetef+MI1Nqua7
         6erQ==
X-Gm-Message-State: AFuF++n1f3J9PmHZ0XvvzD1lm/mZ8n5yKsdXQY6cmaBfad1ruExvqjFs
	t84B5Y9B3/q5qK3xHf454MA7WTwjb101CdJvle4nYdbcpFdRcjd/Oig/JTVTeitpzENRuetdJVj
	3pHN4DrI=
X-Gm-Gg: AYBFou2LJ9kw6JTuSWnzehONR0CRW060UxLR2ONEC3tYF+jpza39y07jBqRWjK18AaG
	JyCexg/NY53R2jxb1+P97rixTjztP6Kaap2quX0F4R7+xl+Y4zi1Q82goUmZ2IKLm1OpBR5KSTc
	PJ4El/UR7OKlX2Bajcf/VV1i1fO+mwXmtYTcqveG4TDSrc0QGyqgiX+Xv6NPf9FVLw+R0yQ8EZD
	MPd4uAtWwxoagDVdGMw2jDGT3y799cpQaDAnaWnbzV5ju+ErBJirXsHlrfVWeOTSdcJsv80QHBF
	K95H0SJdGm+i9W6cVvtOrQwjKq4IBE47Flo2rT7J0h+maNvq2agz/shlViW2+jK5VzUjIkkE3y/
	84tObnIs0UQYXEt8B68hWvLLjq/X+KPlIlFtCAryhwzEnOYnHtG9pxbhqBg0y60MTZ6EyF3veEl
	rnCHJiybcc+pR04fCTUsLOKq4UdP5ElLr6eBhbYr5nY/Ejez89y8eL6sbcEhAosHi4QK9JLvwHA
	g80jH6b13aLr8iMww4//2RIs4N+C94R6PbxEsDDzjcoaL+dY/xi9dFTYfMLuirqFU3ALqQ5fgyW
	WXw59A==
X-Received: by 2002:a05:6a00:1d82:b0:86a:141e:2a8d with SMTP id d2e1a72fcca58-87e989951famr2807752b3a.11.1790271526738;
        Thu, 24 Sep 2026 10:38:46 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:f875:3165:4649:e818])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feb57e56csm37517b3a.48.2026.09.24.10.38.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 10:38:46 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH 6.1.y] sh: push-switch: Reorder cleanup operations to avoid use-after-free bug
Date: Thu, 24 Sep 2026 13:38:41 -0400
Message-ID: <20260924173842.88036-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 246f80a0b17f8f582b2c0996db02998239057c65 ]

The original code puts flush_work() before timer_shutdown_sync()
in switch_drv_remove(). Although we use flush_work() to stop
the worker, it could be rescheduled in switch_timer(). As a result,
a use-after-free bug can occur. The details are shown below:

      (cpu 0)                    |      (cpu 1)
switch_drv_remove()              |
 flush_work()                    |
  ...                            |  switch_timer // timer
                                 |   schedule_work(&psw->work)
 timer_shutdown_sync()           |
 ...                             |  switch_work_handler // worker
 kfree(psw) // free              |
                                 |   psw->state = 0 // use

This patch puts timer_shutdown_sync() before flush_work() to
mitigate the bugs. As a result, the worker and timer will be
stopped safely before the deallocate operations.

Fixes: 9f5e8eee5cfe ("sh: generic push-switch framework.")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/20230802033737.9738-1-duoming@zju.edu.cn
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

[ Backport to 6.1.y: use timer_shutdown_sync(), already available here,
  so the timer cannot rearm before the queued work is flushed. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and SH maintainers,

I am continuing with CVE backports still missing from 6.1.y.
This fix is inherited by v6.6 and every later mainline release, but 6.1.y
still has the affected code. The target-specific adjustment is described
in the bracketed note above.

Could you please queue it for 6.1.y?

Thanks,
Artem Dinaburg

CVE: CVE-2023-52629

Build validation: SH r7785rp_defconfig with CONFIG_PUSH_SWITCH=y and
CONFIG_WERROR=y built push-switch.o with no new warnings or errors.

AI assistance: An LLM helped find, adapt, and validate this
backport; I reviewed the patch and test output.

 arch/sh/drivers/push-switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.c
index 2813140fd92bb2..6ecba5f521eb6c 100644
--- a/arch/sh/drivers/push-switch.c
+++ b/arch/sh/drivers/push-switch.c
@@ -101,8 +101,8 @@ static int switch_drv_remove(struct platform_device *pdev)
 		device_remove_file(&pdev->dev, &dev_attr_switch);
 
 	platform_set_drvdata(pdev, NULL);
+	timer_shutdown_sync(&psw->debounce);
 	flush_work(&psw->work);
-	del_timer_sync(&psw->debounce);
 	free_irq(irq, pdev);
 
 	kfree(psw);
-- 
2.39.5

