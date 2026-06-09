Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46F403E9D
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007230; cv=none; b=Nd1/R3gZVZJkxFHxb6CnWCqHxtn3Lr+M3/FzENSQ20cgrrzjkzLTzlfpk2J6bMkReJyPt/JGT0JacE1fzPDqUXvM0hvyG7MAx4D89YnjRfJI/KAkeVO0LaJXe5eRNhF+Kxn6k7sJU/kjvWXWuPi/DYTBtniZaD2ywW54ePlyQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007230; c=relaxed/simple;
	bh=CCCknRMucJa27YIj8zqKWb5yyna/lo4aYM4LXTZtUlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJ/w/mS1eQrSycX6tFPbb7GdINOYRbInNZofUNQ6uhDytjm1gQrNPMnK5R2uHJnQdqccDNYYXsm49idAeB/u0VtDXBkfAE1f7n211PrWJ2096JceQ8NWAnQiDc1RD7vxNo3n3xpC8B9kWiTYLAt6M/pq5zH/P0K7TTTZ1KuYBCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JL1FGsMX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JL1FGsMX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso41174385ad.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781007227; x=1781612027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=md0oLfExsjhQ5s9zgCStyVmZOOcuKHtb2pCgbVaO+NY=;
        b=JL1FGsMXbbC75moFt8w37Q32pVINddMCRpvyJsCB8g1TT6E5te3yOa+fXdYm8AigYj
         7mEyyd7qDiCUS3NXB+YgEWF6jcvLaAJUjn6+CEIH6C2gfKXzZ1ChQqu7/NBAju9VrjUK
         rOCRNqjt9cOSHXwh8SDAsFlBwAG3TN+XRCjUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781007227; x=1781612027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md0oLfExsjhQ5s9zgCStyVmZOOcuKHtb2pCgbVaO+NY=;
        b=HQr2uwH61nAv/pBm7mbEydF7+STItKZmLWgc5Zgn08RYWynkk64mlZKm4n4o1/uzbz
         I/HTALJoXEvpBVO8fhek1sA3xlGMSgx8NRr7IeBuxenvyYIwaKaQzFVHT1MtJYmTwyS/
         eGW7rA1L1v9wAJDyL5KpHptdQQZqL5aRZMlSmXaW0jn1Nl2QxSQWlvjDrMdMIbev6cHC
         as6wWgj8NfbODgj7YrXWHwAJrOiKbd2vFcE88UjcvRTIcll3WXL76SlClJcp4L70vBWj
         AAOOfD4WNSIdHhQyPsG/HTRExvQTmgRB23OPrpaJe3/c5d9XOxzrqRMfkD6nMkea3gmv
         KvUw==
X-Forwarded-Encrypted: i=1; AFNElJ8s6mb+Yb1Is0qxKxa/4Gt0SgAeUHMniVEZz33lgJi4jd6JtFsu2uLEFlthHYxKOib7YnPOiv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoF+wMYtn/UPsHctO6ZccRT8L4BTw2qll2yez9ikvwk+ZbTEEy
	cTmZ/V8KUQPfIpPCZdh9oQJhGf/1WEmptKv4A7NNEnCn+m7mOUGE4v5flT+/gPNZ4Q==
X-Gm-Gg: Acq92OE/fY6sJhnOSrAvL9oJ62ILH0vGHTuUvgerQKnCyEhVLRNUC3jJvvDcCVTiM+f
	RruIndkft6j1cTH+ogJWzAhBW7nOhyeCPgjG8HYfH0L15WTLIY4QoHr5q/SE2z8ab8QvajdcOOE
	4YPh9Zqj3uA3QdD38kcRlbKKxJ74TGBTcF/oO5WwWDVT8gnDV5ZburkDRMMpGDdeT8PyBwe+aAC
	ujCfnHHHoeeONKbAtOXP2WD7jbsv9nmwe9jGzRmNRsu02HBGrjBXSo+5346hcVKBQ0lroZf79H7
	5mxqN07ZNBnK/N5uwoCetFJzvMKf7mr0FgvJCCwpj3uXsqcLs93at3QdfLC3kY0+0OUM1puI5zm
	NBZpe5FT6X/2vFTAL6mRvNphCr5p5vPJ8LhMvzF1qblcFnoqyb30PrfSukrm5XmpOLT/OMk9RRL
	0LuVkFTC/OKz3Qm98vGVqt9i6yDtcQ967ynFwFr5nqROWcee2NAswZqi8ct/b8n308GY4v87aoz
	9iReV9xnrK1oEO/ogcpMRid
X-Received: by 2002:a17:903:fad:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2c1e7b13addmr221626095ad.13.1781007227564;
        Tue, 09 Jun 2026 05:13:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:62ce:f303:81a5:1cce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm279998175ad.9.2026.06.09.05.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:13:45 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mark-yw Chen <mark-yw.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()
Date: Tue,  9 Jun 2026 21:10:06 +0900
Message-ID: <20260609121329.1262170-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every once in a while we see a hung btmtksdio_flush() task:

 INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
 __cancel_work_timer+0x3f4/0x460
 cancel_work_sync+0x1c/0x2c
 btmtksdio_flush+0x2c/0x40
 hci_dev_open_sync+0x10c4/0x2190
 [..]

It all boils down to incorrect time_is_before_jiffies() usage in
btmtksdio_txrx_work().  The btmtksdio_txrx_work() loop is expected
to be terminated if running for longer than 5*HZ.  However the
timeout check is twisted:  time_is_before_jiffies(old_jiffies + 5*HZ)
evaluates to true when old_jiffies + 5*HZ is in the past i.e. when a
timeout has occurred.  Using OR with time_is_before_jiffies(txrx_timeout)
means that:
- before the 5-second timeout: the condition is `int_status || false`,
  so it loops as long as there are pending interrupts.
- after the 5-second timeout: the condition becomes `int_status || true`,
  which is always true.

When the loop becomes infinite btmtksdio_txrx_work() loop never
terminates and never releases the SDIO host.

Fix loop termination condition to actually enforce a 5*HZ timeout.

Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/bluetooth/btmtksdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 5b0fab7b89b5..c6f80c419e90 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 			if (btmtksdio_rx_packet(bdev, rx_size) < 0)
 				bdev->hdev->stat.err_rx++;
 		}
-	} while (int_status || time_is_before_jiffies(txrx_timeout));
+	} while (int_status && time_is_after_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
 	if (bdev->func->irq_handler)
-- 
2.54.0.1064.gd145956f57-goog

