Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A23D812A
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366451; cv=none; b=k6KCGs+2bYP98+xGhAA2FlIn6Dxqo3y2uctSSGB6WuFzbLkccEVxp8NOkaa2lSX0rbXYjPJFGAsPFgHGN36OWTG2MZCdttvuIjaCox7hBhopo4n5UhT4BAvGMxFFc36UfvEBQaW++VD6BFtK7mTBPqkPUdLxFcdeA+i+YIABaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366451; c=relaxed/simple;
	bh=g80PFUph4ibDHloeyB+7t6p2oepxRcwNrKkYhWZ/D8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqWzhv1Rn5Cl2zu8FVdZeanA7JGnD9ioSRajmRXiVk6PrrITRAa6XgcfQo79i308FaHz6CemVB4/ofOusRukR9U8g7U13uQ+oRkC/DWwsefo3dFTykPP6stCu+F1vBcNH9NgUL9RqLCByE+3Lb6bExX9eL07GJ+O53oOCTCTKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSYSVjfO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSYSVjfO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a4d455ace3so1800235a91.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791366442; x=1791971242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SIXjivVbQJCgdZ82dSTwxSq9rPlm7KuY+QIYP6gq+2I=;
        b=lSYSVjfOJCKPjNVo7g4jFWFfTfqBgOyA5cOFuMsulSykSE3ROyqIrQxa9iw7iC3+nb
         m3whBSckMUuPJaPmJgAzFfAhwoFPX97ahHnxwq0XNbjINJq4cnrHdcq6Di6QZwdnDDXa
         4mVc5zfh0LejmVPUPlB+8xtzyrBu4wbVjituvu1zMuZ+Xcr9VPSMpjv4cu3rdQ9/Y/ZR
         P8reP4YrQxBgh6UJKRtcRyyQwpBswuc1iJG0pzRsrVAxPAjD3pMpaTFjpA2YHndkPeDz
         8mtXEnMroZrNJIu967rwMbU0flWVgxnV4AxSSUQ3P6mfqdLQ77H9JDCbIvaDxz+GUmZQ
         R2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791366442; x=1791971242;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SIXjivVbQJCgdZ82dSTwxSq9rPlm7KuY+QIYP6gq+2I=;
        b=JutLO6VcNIPIWuJHbuFj/fxpyJ/rU5rQihJKRzdEo3/EW05PRy8Kj7nljVQK9SVR59
         8AEaU84gizXd1p7astjNYeJbzD49vpjovC1EbGTxQWZQuqvU2R6tyW7Rd8Npi53ecCcX
         OkMQHFCt3jSvLxBi/IgKcahYj59BITXMSiTHs0lSMXvc4eMSr6e4QJU7RK3Qu4tk8p7U
         crSKwGfIwxVqnjEgTxQF7gYhofqJt/BiB+xTAovktF7nCNfzr7KflrOgW70TdVLBH9To
         qNK3kFmOdRhFKg7U1KuA2e9PgH+uuYxIP33rt8o/secKHYYobwP/Yd8QJnUyZs1PIwfa
         eFzA==
X-Forwarded-Encrypted: i=1; AKwUvBxar0G0WjKHtxbUHuJTqNc4FzNObA7nNdCBiFVTzlLC++aLHgFSXfAY56oaXWj5Y8ufqLuZ4D8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7Ijr4AnHA/8r04Th/avYAplrZeTZrzhcKpPmcy7sUAqfqizED
	arK4cZSzsZYUcVWyhNYV8pNColGsC7YS6G6V9a0kJ4c/BGumI85FKUD5
X-Gm-Gg: AYBFou10jkWUUTaml/eEIsY3InHP8zqR/V44+q+Hcp33Nit3EW3zbO6OMCK44uMrOrm
	pNc89FKDWCYPjyoj0AN4NSB5H4mGb2wBrdsuWcgMFJI+9vy5PQUAHSGcTw2Ish1rf3qHVthHbE1
	yHMNVK1WrxMP3TUHBmbTSweb5YWBvZkkOlMbBXcC67rZoKJy6AXzDSRry87+DdlQRs+yjCX+7CW
	eiuf2wL9mTZMEkngoNhYQEqdU/CkOCYqEdJbd4vOWzqyiNILeWdqK+C3M7JUYxPVRW4TWgrm710
	3OCpT+SrD3nxZJNRcQCvgan8qLskzOfpCxsdyyeOy1qg11LA+SXLgxNksCyEU0TP6se3TtV5XrF
	k3f3rs8W8eBprYQ3ZPUhQsuGUBO8nme00A6rlHc4TlHRa/b7ppwNw2V7zz51sq2af/Md9zQpLeK
	i2kZSvnRgZCwZ5HyAcJyxT5A8KbguJGPC9cMsOjf7ysO4PdFc68wHcav28C5pg8zG74+wP/2exX
	yqt82vdJlfFxWSLqsrgpZHgVfvBSnMq3HhyyHd3fIJDBSiEZv4bnYpW7Fi7ewy0CIRtrbHRxlP4
	S8Pk/YG/hns=
X-Received: by 2002:a17:90b:2e46:b0:39e:6c68:c77a with SMTP id 98e67ed59e1d1-3a8a12bf661mr1450443a91.48.1791366441970;
        Wed, 07 Oct 2026 02:47:21 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8c46a2f9bsm265866a91.2.2026.10.07.02.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 02:47:21 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hugo@hugovil.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v8 0/2] serial: core: fix baud rate fallback loop and baud_base overflow
Date: Wed,  7 Oct 2026 09:47:16 +0000
Message-ID: <20261007094719.1362769-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses two issues in serial core:
1. Division-by-zero WARN/Oops during baud rate fallback in uart_get_baud_rate().
2. 32-bit unsigned overflow in uart_set_info() when multiplying new_info->baud_base by 16.

All patches are ported to the latest tip of mainline (551c722f4080) and
dynamically verified in QEMU KVM with CONFIG_KASAN=y.

Changes in v8:
- 1/2: Rewrote commit description to detail the step-by-step loop iteration
  progression (try == 0, try == 1, try == 2) as requested by Ilpo Järvinen
  and Greg Kroah-Hartman.
- 2/2: Dropped secondary Fixes: 6eabce6608d6 tag per Hugo Villeneuve feedback.

Hui Peng (2):
  serial: core: fix baud rate fallback in uart_get_baud_rate()
  serial: core: reject baud_base values that overflow port->uartclk in
    uart_set_info()

 drivers/tty/serial/serial_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
-- 
2.47.3
