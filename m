Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312174;
	b=qILXotkH0aAiK/AZLIwxX6BXAY0ELNgLZNzh3TCw/hghvZono5zGz2dtFPBQODnVItoI
	 /NN/mz0cg1wa1ycn8blpKpUcedO/VlaznDl01cdZN+oHXY+ioDbHzhFGbX9Eve7f9I50g
	 7P0ZCtbtj8ZkEVaJKtG7qgao2PWINeARElg9R3tuiL6ibYj4Az3PWU6jHemBImFF+NiEP
	 2tocCv9fuM1X+MikJ1ylesFtV7ZodsOQO6Be67tZOb1UjMQtrfOT383rcpJ3oBOzJX5eZ
	 /te6oKYqECgaHviLYyE33zqb5hfLQ2iGSyZtTOiaKQ23t0/fEvfpuOwo58BkgC8SFVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0ZP0QwuWmQ0O/IufxQaXKe+ECU5VmX2aM2/ckpY7r/g=;
	b=lJNpRx/Khq7QMOyhttdk6xh+sxudSsOx27TNuszM9KkvhMIaibiYDpHJVTQXxGoLuVFJ
	 8xHtppT15LiWiIAYnM5e8UxTPQ38MjvVDJtEbrUjcWdPYQMRxwg/5XcYqxvRAdD+Ds6Ov
	 ejZkXQg0yl0ocQveCcGZICkZojKyYAYVlYpLeopeqs7aVd98TS4RrlIvTRQVJnfNDERuU
	 jld6CO5+lsqur3/8VDfamXK3WioOIVtkYVFLUpjIRp4k7sTFfHgBeUeS+E5GoT65qSFiK
	 cFr4CJrvslJfKXcognP0+IXiwG6gz8PXnEOM8AFCXjmzcfJiNBsTKgFzdjOrLNcoFng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSDlQbfx;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A82606A33C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A82606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSDlQbfx
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so3168254eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794312173; x=1794916973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZP0QwuWmQ0O/IufxQaXKe+ECU5VmX2aM2/ckpY7r/g=;
        b=jSDlQbfx3w+kTQrgktf6wDUFty1SLh6ECHjfH836acX0MKF0FcRwXmKfLDWc/YH6WU
         F+AyTHmN2bvbrDYANH2na7AdjtN6sFOtW+yORrVemO9+MLHtbzSUeWyClojBl0glCvK4
         nknss2LXWxE6eiiv4sOekf5Ht4/jPuhnTuhkUYisl8UZrU5q6INzIEvcl1Nns9SsrzQ3
         QKWuvHb8HvCPSEpyfdiyxoVTbKUubufh9fzyFVuyfmQQflgTCt1d9PqXD01UN0FUkkBS
         WbGFyO0mY6XBg/9feDU3URVoSCvRvna7kXi13CLZ0iLvAsiohrQT50zbt+WOGfmJ7Z4e
         6a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312173; x=1794916973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ZP0QwuWmQ0O/IufxQaXKe+ECU5VmX2aM2/ckpY7r/g=;
        b=NSYjcna/rAT9LQ3W5D9OGqPI/1cmpxFGoT/lQK1qIcaZSJLWcciZg3oMeIQ8kALHPJ
         X80JZBbhM26izZh37g7Gkc1evVu5m2DP6JBIKz2QY9CWdATnkv2Gr+Ih0dHmFWfdkZ2d
         xJWw2Ld1VTHLXIWWuOLMJDQ2pV3eEQ72+b89UHhmE4jBSK323clwlUdcqQ/DnWu+utYX
         l2e8qxEg6Ti1w91PtMstICRF9tpV2z3gAn4hAD5eu1LYm4tJf9Eln6ItR37fjglKIfJu
         ie1FRFgMhyNE/SNSqQglH8v/ITSxtZSeP5h9pp9JtKGgTgDpOXz2HyTdvfz0qFjYPwte
         NDJA==
X-Forwarded-Encrypted: i=1; AL+hErEum/DxKBZPPuEB6/8HICA/kk10PGb7xmBDpNlWsTfBiZKm0h2A1KN6twpqVbVCHUwk1BVxNrU=@vger.kernel.org
X-Gm-Message-State: APuU4Z82iPz3vWPG9iU1E2YsObsRMnI9CUP4+A2rB7nmjTyltZRnOKuv
	6VlAAVALVnEWhFLGYoLpMoLFQxMpeZnXvkZuvwyYQWOaidFkT4/kIUPX
X-Gm-Gg: AYBFou2evxFU0qWaEqZTTCVDniPGbgwX5x0dQIrL11jPkBXr7dIkotMK6DSGzuGwuzV
	kAiGVMxZ1rsn6RCHbXWvpkkO5XY5gyZF12p65CW2Amcm4lagv6QBa1mR1XeX/OQflNqjJxk5OPW
	cE2k0Y923INQqJoy1N+1QdjoKNCgXeeARHDeoO7tkjf9H1YPtywnDLtA0OXeaJroP0wvxXy9djs
	eLu5CXUJ3ZGzg8wLXp7Dq9AMac45M8aeDIobEatSDZ1VlkzIoVRI2bQInMyG+WH91rvsUs1g2EA
	VU5T8mFFqzhmitNFAmI5k2yCnY75zuXlDTapkSYQzQq9bX5yvSjUoEPZM8KPAfzV3AfiMJwK/SX
	4SHXfd1DxOEAz4EPt7gqKx5yBsZDqVA6bLmT6hTuxzxCHnL7D2AvazPg4fPrlB/pgWfu900PpWd
	IkWOBi1v5DEXhbqC6uVyHgVtFabMcrkkNHd9evyIA5/b4HZbKY6Zit0ENhveRdW2gRRpvXcWE5c
	1ArG8H222EpDYf82CuKrJkuZ7sYPX2UltkOZgaSY3fEZj6+dR8z9NzodEYfoJOtNCMGgi7D/6s1
	76DkpS4fTu188b7nI+0PL/8sQj1zbW45sTwwUpEtjVKm1k2+
X-Received: by 2002:a05:7301:fd03:b0:36f:f3b7:6dee with SMTP id 5a478bee46e88-3751ee7c2c9mr2880533eec.7.1794312172706;
        Tue, 10 Nov 2026 04:02:52 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm5931001eec.0.2026.11.10.04.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:02:52 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Roland Stigge <stigge@antcom.de>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] usb: gadget: lpc32xx_udc: drain the pullup work on removal
Date: Tue, 10 Nov 2026 21:02:43 +0900
Message-ID: <20261110120243.2540098-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110114351.2524921-1-hj351016@gmail.com>
References: <20261110114351.2524921-1-hj351016@gmail.com>
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

isp1301_pullup_enable() schedules udc->pullup_job to perform the slow
isp1301 i2c pull-up access from process context. The work handler
(pullup_work) dereferences udc and touches the isp1301 i2c client.

udc is allocated with devm_kmemdup(), so devres frees it after
lpc32xx_udc_remove() returns. remove() calls pullup(udc, 0) -- which
queues pullup_job to clear the D+ pull-up -- but never drains it, so the
work can run after udc has been freed (and the isp1301 client put),
dereferencing freed memory -- a use-after-free.

Flush pullup_job in lpc32xx_udc_remove() after the final pullup(udc, 0).
flush_work() (rather than cancel_work_sync()) lets the queued pull-up
disable actually complete before the udc and its isp1301 client are
released, so the transceiver is left with D+ deasserted.

Found by static analysis; not runtime-reproduced (needs LPC32xx USB
gadget hardware with the isp1301 transceiver).

Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v2: flush_work() instead of cancel_work_sync(), so the pull-up disable
    queued by pullup(udc, 0) completes rather than being dropped
    (OTG1_DP_PULLUP would otherwise stay asserted after unbind) -- per
    Sashiko review of v1.

 drivers/usb/gadget/udc/lpc32xx_udc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 94355d3d930f..b98faf5b71e5 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -3187,6 +3187,13 @@ static void lpc32xx_udc_remove(struct platform_device *pdev)
 	udc_disable(udc);
 	pullup(udc, 0);

+	/*
+	 * pullup(udc, 0) queues pullup_job to clear the D+ pull-up over i2c;
+	 * flush it so that disable completes and no work can run after the
+	 * devm-allocated udc (and its isp1301 i2c client) are released.
+	 */
+	flush_work(&udc->pullup_job);
+
 	device_init_wakeup(&pdev->dev, 0);
 	remove_debug_file(udc);

--
2.43.0
