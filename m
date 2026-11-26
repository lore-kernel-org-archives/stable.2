Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697293;
	b=RmHfLMgAoBkCyKaToESxs3jYMAJD9IvjKZRLrzFn6XoB1aoxeawbfnB30hj0ILK1dCo9
	 9qfbf4ytjkJAJ19y5RAWHWsR5HaY+BW6iAPEqj7Xp1HcQtBS7fgH6lUiSA2Aspq4XdWSt
	 LVTeQA+8SDMPlwkypk6uLwGX0XN+XqijpmMvLh7pXbGJw34CdzJKC5ohpe0ofNnhh7di2
	 SUWzAxtLc+LjQ7URzDK7mE7OBKwYO9Px0j/htl88a70FSymZYKSUp7tlPAGvflk9WOmvV
	 lM/tWnE6yI8ZSkz+FZXOXxDjYioKXdHJSDCYIbbXwKhaurmYMESNMWjwGL/DYXIlDiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8UXmhjzmrSz9c7UGZC3PvW2Va1zzLFwfvXp87xtgrDI=;
	b=cGf9SVZJdseka/LbcpXN6bTo2e8fiIeAwKerVmYIeX+nsyTKU1fB0130jMB/rsPVmBAU
	 /rCIInt3Zp9W4ot4WBEDPHw3xx+3vXom8hfXassNqcKV0PCtzh3m6Urh2FAA6CTsbmLS2
	 jJkgR6fR8NmETmki6mI/r+2RyX778AXbZ88EHCOM860F3gwUyir5sMcRhqaZ4m9Mt4B0d
	 puJHD+QSdXD+bIbRTR8nHhTSwmyvfdr9W5rrIyJTBD+SUrbadvIxKI3opxE7VIZrskriQ
	 gJhTSnVdtzkeyOvgoDDcDxZ8oO1vEBFVVvcO7oafLLxvsRFPEWhNng1u9ZNFvA6JU8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NRd6IM2n;
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB58606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB58606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NRd6IM2n
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3b497279c25so2038824a91.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795697292; x=1796302092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8UXmhjzmrSz9c7UGZC3PvW2Va1zzLFwfvXp87xtgrDI=;
        b=NRd6IM2nMKDbRQaG0Ara5j45MRa5HNcGGGOv9QmXi88i3V4kx9O1RUtaft1LqiJHKU
         oRzc7zM5wNS0f1gbek0tsZZu857dTzMgDfwsr9x99nsBtV5aZvZ2yZR3bM6mcy/S490z
         EgGm87JPBxho7Asm2iGgyZCcpq94GXlUnNbXcGqdXzxTj/VkouXfSbPdcPCTk6YkHvSy
         NDqDNMcI9GQfNqCl0PwwiD92MgpBkhlPav0oJbv3dVOf4WuW/NSctBO+YSYpD/TXqW72
         hk9qomN8IK5prBkHJWqNbdK9er0jKAMf4uJLmdJmFktcYM2qmVvPyy0yN92tw1PQFhP+
         BgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795697292; x=1796302092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8UXmhjzmrSz9c7UGZC3PvW2Va1zzLFwfvXp87xtgrDI=;
        b=wSxr1wZot1Jtex1AcxWY7AOlrSYJ/upAWoKHJoUNPeWVrSPpdWA8769P/sF0alEwYv
         bWwAB5qWp/WlT7I9Iw9Zrvvrqb5hb+9eElMQFjoSOWw6z5lJc5Lm6LyB9JU8rMi/4dqj
         sF6T4QzZRXuIALSvFCY3Oab8pbL6LWnc2FlKgd1AX7eHjyaxmr5i31gnfE/9LCA0llPm
         YhYIsemeAFMR7c/U34ZTe1F0gxEseyz5f9Um2b1LbDTRfK9E84uRch8BM1BpzmT9nsLy
         lNvXXmvcIUTa36fJRLsPxQJUeRkSzB7dB+/YgrnX6Wcp3sePYyBtuFHVYawUlmG+JAfc
         5gGg==
X-Forwarded-Encrypted: i=1; AL+hErHKLKFBrb/Or1phEgj08Hil5Qe0njLM+dDIEKPa4VyDJpiq/R4mHsucW5dLKjzvWA41wpYuoTo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TbPgU13gfWjtrmR3LeN6h9v30/IYtcflULKXqmvwxgrLAcpQD
	lrCqRNJRRprJORzbQDkxtP0yXsdr561BqLw3ufUnw+uiIs4OkZo37vh6
X-Gm-Gg: AZFdTZfCHDt68n0z0runhCBXTHVVBUGDW0TawU9D4FzzanpzuPy8gNrez24QlWuVtVW
	2A6jhbjKtGOpDu+JnYhOYibiIysKr1ygpd58EiwkgUUJ5TDtNq2S0lLnNfBnFb9mgJAOXXbdKjd
	md1fT4a/kxKmDhPNtIB/8Dp34sQnJn2j2MTJqVg8wTENOtYN2EMibJObTW6xtqsiFUsyhxrX9Cv
	KQYw8P6BbV80Nto3xjlMtjI5K2bZEIcqMq0EL+ue884k9p47IdwBZQtDLfCyRB7GD2u2ExWfqww
	72ZXmFkLJ3f3n3MYupWH7BrRc/ypqasWl4PigDswIKFULXVOHPcIDn8zLVEtP/aPvMJjGbRwIO/
	xVZwFnWACZDnmbAo2bStsgDNM0crlmGPdXEUNIsbZlrXMLGyIn2rAyi1hZsX2YhCfuthVwCfuUw
	HZVFECAXI8Nr/sEVz2w0rmSA5B2i99NZ0tNOw3RpvhOqelIq0qgiBbwmOnhIaVd4UM0tskULWDe
	kjQ++kzq8M5r25kxyV8I3HE9PP3sLiTusNtpP44n0hqyAtZGBR5YUazEcPv+y6nSGQ4rl6uNyYy
	iQEi3usU0uXt1dcZWKMzZ2621SMfq3cyQTtLRzgqhhUzeSHtKU8VB7rC7SY=
X-Received: by 2002:a17:90a:e705:b0:3ad:aa1a:312e with SMTP id 98e67ed59e1d1-3b41c7e127cmr20237965a91.3.1795697292077;
        Thu, 26 Nov 2026 04:48:12 -0800 (PST)
Received: from amax.cluster.local ([115.233.223.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm35201528a91.6.2026.11.26.04.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:48:11 -0800 (PST)
From: l1za0.sec@gmail.com
To: Bartosz Golaszewski <brgl@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linusw@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haocheng Yu <l1za0.sec@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpio: cdev: fix memory leak in lineinfo_changed_notify
Date: Thu, 26 Nov 2026 20:47:51 +0800
Message-Id: <20261126124751.3184158-1-l1za0.sec@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260922-gpio-cdev-stack-leak-fixes-v3-1-7a0c7a4299d5@oss.qualcomm.com>
References: <20260922-gpio-cdev-stack-leak-fixes-v3-1-7a0c7a4299d5@oss.qualcomm.com>
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

From: Haocheng Yu <l1za0.sec@gmail.com>

Commit 1feb5d39b05a ("gpio: cdev: fix kernel stack leak to
user-space in error path") made gpio_desc_to_lineinfo() return an error
when the GPIO chip guard cannot be acquired, introducing a new error
path in lineinfo_changed_notify().

This error path can be reached when a watched line changes state while
its GPIO chip is being removed. The state-change path may decide to
emit a notification while the chip is still present, but before
gpio_desc_to_lineinfo() enters its own SRCU read-side critical section,
gpiochip_remove() may clear gdev->chip. The newly acquired chip guard
then observes a NULL chip and gpio_desc_to_lineinfo() returns -ENODEV.
Driver unbind, hot-unplug, or device-tree overlay removal can create
this race with line request, release, or configuration changes.

At this point lineinfo_changed_notify() drops the file reference and
returns, but it neither frees the newly allocated notification context
nor queues the work that normally takes ownership of and frees it.

Free the context before returning to avoid leaking it whenever the race 
is hit.

Fixes: 1feb5d39b05a ("gpio: cdev: fix kernel stack leak to user-space in error path")
Cc: stable@vger.kernel.org
Signed-off-by: Haocheng Yu <l1za0.sec@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5d53bfcdf726..1146198415f8 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2535,6 +2535,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	ret = gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
 	if (ret) {
 		fput(fp);
+		kfree(ctx);
 		return NOTIFY_DONE;
 	}
 
-- 
2.43.0
