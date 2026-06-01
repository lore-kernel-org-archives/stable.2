Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC13A48D5
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321292; cv=none; b=DJuu8XkpuY8Z9gGpaeoYmFfO4g8S9OFNoXHFKzIa4fAHTmjmNSgZHrxHnZtsYD/PeNp9Q4oHxleXhjFqyO3ksZoJe/hUJAYjRK+/8UNqalVvC6uf0I7D/G1k4OevDbub1y/6HMcJ46Nz8l21sglBjbhNgogoU4ZvsVToEZEUI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321292; c=relaxed/simple;
	bh=0YLDz12FA6XVOzJeLn1d/oNTWjkdfsbZbtXn3imJwLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzdyoA4M6lnPPUbrk298GXnpDp6w3eOfymQNzv2cz1hx1A3KPbfhtgBUvTwT/Kf55NQsHQA0RUZh2z+t4sSNmtxZZk9y0bydTUK/Vm3zy+qxDTyNJtFkmSIZw72cr8ND14jMPcW3lw8Eo/xGCVOtQMM9Za5tUdh9LZ6h8UzK2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMk+YF7f; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMk+YF7f"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b8d414666so2564938a91.3
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321290; x=1780926090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE1QCAtAhg6sEZEseBz/loTBnTwntzM+QrWDys0rps4=;
        b=IMk+YF7fg3SVGEGzPHELBq/jc2sutMZbqHo9SMaly9ZZCbX99gwmAxXjbHvZfvTnC3
         NMShzFGg7tI+l0hSKzd4E1K3iwwEr+270tIEWsRR+XJfYn5IFi8zKxieRTItYV9TPlk0
         xwAW2IdfyAtWMIMwOQXNHC8EMy3j35fHDg4ZMg8yIp/CMBq6ptUlJaiKxzfHfvNKw6ra
         lJEptbVFGDI3mr7sR+mj+UBgiVn5W7q5jYyAu+HaeBvMnqeUAd8p2sARjNWjcyERXqMt
         zOAZ+Cgs8PuGgb66Uzjh0ql46oQXGoZGHVYTthA8OoYvJs9RyVdLrQG0OtQpmDJDhrsd
         Gvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321290; x=1780926090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BE1QCAtAhg6sEZEseBz/loTBnTwntzM+QrWDys0rps4=;
        b=mfm4gUuJ8x7PYwYnvgmUPi7VL8Cz8QrzGLeT2rM8NxCclKz/Eu10cQSZ5Jt3aGRYaL
         iOxgbHMDDMjAZfzDADZC9nfxRw0cpE+HKL8WhTO0mZvIc6nrnamqC4KpM3+lQpzV5IlF
         kKbK9Vz8EFkyo79FBwDgDBKcF69sI2D15TbDTdOn1psHMqb1KLvPrsLaeQ7PirVeUeCV
         a0QubDWGbJfhCJz3fLnRT9gpBh717oHbTezVSbjH2f1cAtn9SFXwMGt0J3fEhETxxvDO
         Cmb1njtbu1eYOre0TssY/AqiUYeLOP5hmo4Vzp30py/elYbgxSMdCTkEItRjsDCgMUzj
         O7qw==
X-Forwarded-Encrypted: i=1; AFNElJ/RmJd1U2fwxqnSJQRWcqcQsR1r0pkR3BwxL0zZME3ZJlOub3l2jqcrt2RelvXq3LKhkOJJhOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbyULPm6cRc74DnWjNOW/bjKWklj7RdHuOltU7m7FP/e37tIpV
	3slg7D6R1vb74mO0Y9bIvKTTr5dnTmXmQafv17btFz40HbMnoU+VOeAQ
X-Gm-Gg: Acq92OEluS2P5qhR0yb73Sxm63D9L51d4mZ6dor277GAU+zTRyIvB0VAbMYXJRrHzDD
	zZPsqzChjTJLO3zGpi7MOkeUwZuRDFkLrW/T/vJ6kziJx+hYwV/Fr8BrE0kaRSuuCK/kkqIxtaW
	VCWe1dtsXDTqb9Xp7+kupeLtMK655bfqGYXbXa7LNe0Tg1pTuSejiw8y/ojC4x+ScEI954Zb6o9
	1xsx1JeWzCxMpj3OtMuP/5b2nGPkZ0uFy8tlxw7Ko9jaIyuJ5YN4mr32QPuOYwRXr5lP2MdJeFH
	QNthyz6KUqIH1uFfB3l2XCZMYs0t2FBij1aCUh+BDWHnwYHbzf77DuGyUn3RGN5AHKqUv+TJoXE
	ved3U104YhDlgFoDWHI9n5ewB/m3RkwWM84yK6TDOO27jkX4z7f0JAtODmsl4dxcjwP198UMKM+
	D709KnUiklum8E4cMtgFCsOJFmawhhkoab6jby/nGL5qJZEVZGCW2zabMwtgQ=
X-Received: by 2002:a17:90b:4a91:b0:36c:689c:a4c9 with SMTP id 98e67ed59e1d1-36c689cb2efmr10479463a91.21.1780321288984;
        Mon, 01 Jun 2026 06:41:28 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc65e8490sm11496959a91.3.2026.06.01.06.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:41:28 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com,
	Sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH v2 1/2] HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()
Date: Mon,  1 Jun 2026 22:41:23 +0900
Message-ID: <20260601134124.1560886-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601134124.1560886-1-jinmo44.yang@gmail.com>
References: <ahu2oxLwkgMlwXu7@google.com>
 <20260601134124.1560886-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

wacom_wac_queue_flush() is called via the .raw_event callback
(wacom_raw_event → wacom_wac_pen_serial_enforce → wacom_wac_queue_flush).
For USB HID devices, this callback is invoked from hid_irq_in(), which
is a URB completion handler running in atomic context. Using GFP_KERNEL
in this path can sleep, leading to a "scheduling while atomic" bug.

Use GFP_ATOMIC instead. The existing code already handles allocation
failure by skipping the fifo entry and continuing.

Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b35..2e237bdd2 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -74,7 +74,7 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 		unsigned int count;
 		int err;
 
-		buf = kzalloc(size, GFP_KERNEL);
+		buf = kzalloc(size, GFP_ATOMIC);
 		if (!buf) {
 			kfifo_skip(fifo);
 			continue;
-- 
2.53.0

