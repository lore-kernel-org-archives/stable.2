Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0346D0B6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519486; cv=none; b=uplTpNCE5iSSndaoWNPlzuGHiTGJ8W+zZkwiHQO41I7tUoNyoy2g7UvmDq6EXEHrOMrX5oxdDdlpn8dEcKc5TGui8PSzRhgfI2LVDVH3qBYYxY3QI+eB4ZdZO5LiVFbqwLQTZnpmkHHzt11vtW86jaVmvqJuVlnyB8kP8KBwtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519486; c=relaxed/simple;
	bh=VyW2ykj9ZSbRZsQBva5UnSiRQDPGAYdsViwT7RG+g7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ecE53KtR+k8jHTPLF3odyhNdzu8kp+CPz+4tuBs7b32eglmgQ3T2Cx+NxZN6//7NgFvSSCb7NAN+4vK/nJQwH/JMxDBZpGWpkB1in6XbV+4XnMRBpNvS9mTgg3uVI77ptht5aH0qdXNC1zWMyeW0Pk35m0GTJa0ePpV+Q7+3hl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9nDS3yF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9nDS3yF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso6767805e9.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519483; x=1789124283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CUmW5DxVfT5IVMC+lGWdgosH/c2kEie81AvMEOjhwIM=;
        b=W9nDS3yFuA54xrk14jzLPrCGsJad+5K9rtiOilvvWV4hFJU4Wd04y5nNZHVPdM6rcW
         LYgAiStgWQ4vWdSoTXiMlXRZfpBKaWYy/iGegCCxEdJfOJ6lqn/kDHg+ikzl8hKFQ/LX
         5IbSQziN76ogl7Z5i9ASzO39tKua5sAmTCKdrVaX39qSRIxw80pGMQXee9jzZxTDjvII
         akS+9CMAz5N+kvx36g65wdq+g8mGsks/F70gytrZx5n1LhK1BpdVZl6MG8wusHZaqZjr
         yu6ySe5tV5LQXa1OiVzJ3fVPdgPedhXYRLoPMS+KRxWEUMNksZ10TRV8N9o48gC9pngF
         K3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519483; x=1789124283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUmW5DxVfT5IVMC+lGWdgosH/c2kEie81AvMEOjhwIM=;
        b=LNdgQ4rL/r61PzAzg0ahEyyvNaI12+o6QRi3tyePpcWnu8tu0i/Clu03hymmxeQtXm
         loBBh4idtJ3j7BKdo6Y1E9mrbN/ISJP1mTxuNXdY/9w7qodw0ik7mVbcoXdHM6Hd5dfA
         hnO0s4QrT0rJFvzQyb11FEpyOBDZqVn+viRWQGM8dwhf38Yyd1rB3tSlIYrdFn3G8ZL9
         r1LdqHsMifK6takGtE3rAuzf+Me+oJbqtmE421vW3jBJw2G2fsvXwJE3m7QIJYXVYbcY
         wcHZzp1rfloMW2AK3sp87DqtzyXMhhgPlP+3MwMafGjv6jJuLXz/ItVESFMjgy0Uui1q
         3JJg==
X-Forwarded-Encrypted: i=1; AKwUvBxkgHZeot3A/ZAttPFUps8ci6pQML1r+g18BVCmmn31SaYvkyrFll8ahmF8E0lX/KF3qfeCe/k=@vger.kernel.org
X-Gm-Message-State: AFuF++kS2C1XEBezJ1FCTSL7S7/17LEK58J6JE+YsgSLzGvoxwAeW3Ln
	5efCfswdZ0kijB3ZT4oqImDKRaAp94tBh+rBprihuvQykklXKn40m1U=
X-Gm-Gg: AYBFou0OTAwQtvFpnilMT2IY//xybU5TH0c+U/LX8W43Y206jwBXKABj1Q0swUrLJh+
	ayA7JdbUrnxQUQk6PYJqa3ESf+zrsePYyilCCy4HZ28G/J9h1SqbB2/wVVxidBGCCfIpGolkh/F
	nFfi0BMigdZ0bhjsTDSxrg6o2XaufhXwUVa4u8t+CWJC/TsyH390n5baZt3skhX9Q9k0hMvQX6a
	Tu+fAcUIi/vK4YmLrbgX0swF8twYClWCiLxq9KKuoOEVgNFP2nSJpd0U79t9T5wId3MUtGdkf8Y
	aZHiks29tGGOynRkt4jcATVzb97ymbBz3vHHDoix9XYyGNBX9De7TQHzU0PmUtPHxkcaesEq/7j
	zDQOynLMheurbLtDzLCxZ1NFURTcuXmS86wCTASnOKQMIMKkXP3234jKQQJquUy35PhJtzpnyiH
	YRbS5htLuj4oxvhGSEk++U5dLGxkygRQ==
X-Received: by 2002:a05:600c:c173:b0:49c:fc6c:be18 with SMTP id 5b1f17b1804b1-49cfc6cc0b8mr24611455e9.30.1788519483362;
        Fri, 04 Sep 2026 03:58:03 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4761dd1sm134023135e9.0.2026.09.04.03.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:58:02 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: hid-oxp: use cancel_delayed_work_sync() in remove
Date: Fri,  4 Sep 2026 10:58:00 +0000
Message-ID: <20260904105800.3923987-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

oxp_hid_remove() uses cancel_delayed_work() for all three delayed work
items.  cancel_delayed_work() only dequeues a pending work item without
waiting for a currently executing callback to finish.  If any of the
work callbacks (oxp_rgb_queue_fn, oxp_btn_queue_fn, oxp_mcu_init_fn) is
running at the time of removal, the callback continues executing
concurrently with hid_hw_close() and hid_hw_stop(), accessing the HID
device after it has been closed and stopped.

Use cancel_delayed_work_sync() instead to ensure that any in-progress
work callback completes before device teardown proceeds.

Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-oxp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index d2ded6b08ce9e..1e691ebc1199e 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
 
 static void oxp_hid_remove(struct hid_device *hdev)
 {
-	cancel_delayed_work(&drvdata.oxp_rgb_queue);
-	cancel_delayed_work(&drvdata.oxp_btn_queue);
-	cancel_delayed_work(&drvdata.oxp_mcu_init);
+	cancel_delayed_work_sync(&drvdata.oxp_rgb_queue);
+	cancel_delayed_work_sync(&drvdata.oxp_btn_queue);
+	cancel_delayed_work_sync(&drvdata.oxp_mcu_init);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }
-- 
2.47.3

