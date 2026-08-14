Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BDE3B71AC
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749177; cv=none; b=s9keINtYE5EDwE+VCZv6Jhth3XCFQ3L5FmkpQpNtmMNQOuKYwhIeFyV0SZtlmEqZTowN4hcmc1VN7L63UqCWU5cZ1SWIvg+ZWZ7RlY0aNuHNi0tIadoDTPjQ5tIoLWkh2XChlIEO9gbfJhm9tsjw2D3H/imQ/OE40SFcn3rsNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749177; c=relaxed/simple;
	bh=/2viJdQpryEE7rdr5VoupLH1jBOoJzjsw3SbX+zKLYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nk7VTh1GqJZ3Z2RP4ZOVnCea0Lx1FaIGD1k/8gZVEy7M+iMsyfSWsHpAi1rp+vUfdH59+lbjl0rU4vRQBkFmQFLhdUn3b3LI+E2iMrET7acB8ebITw1LR6P85jucwyzBR7iEr3J90FY/VQ7n3CNToHSF3vBqn3piO4+ukqbc6/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxlkTAcF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxlkTAcF"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1405098f8f.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786749174; x=1787353974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKB+Iwkbk4H49tmH4QXa0HUCzoP7pEEfG4W0BPo05F8=;
        b=GxlkTAcF0DJmKRrKpT/NU+6m5+Q7IGVdXEk0qijln5ahXkqEI7/ilAOUJPl19k9HdA
         5KsgFMCFRKuA3VWbcoyx+nKx2qxf5oJuqlGn7jMEZdqwqtkIDyYZx6VgfccDWAJR6fn6
         8QvoL7OdlAyDbpW2wk7KHDn1X3n427mziNzWcuAt4k6Bctbv86fGFeJSbkbyEcu5/hJl
         CLUNOuW3biXwsSDnUjkFbGux1V4yzmiPw4oixVDEF3xXuq2u6tRYO5Js0HJk0bF2ZZ4+
         6hM4IYxo8xTHie6clHWTNAAUUhFxTLH0683gAl/Ie+Aj58BoOJVdZt5/e+L6BpQdpcRu
         swCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786749174; x=1787353974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKB+Iwkbk4H49tmH4QXa0HUCzoP7pEEfG4W0BPo05F8=;
        b=CbWzf9JYVE6Jg4UsZm2VBKJvTe1pQGUw2WuEisLWqi64Y2w+SUkLdEx951j93vJjuq
         roQVSohQo+FOrBWeTvimNal6uk0Adqnu75No4MPuFzyaz5cZ0q7+/hc4bf3e9sp5LSu8
         NyDyIj8Ou9M0gpKP1hidHPHOeqimmy16IbB0gwzOZ1YXe+jit5CDJDxvN1y4yqss1MZs
         eT4DdUpQAhu6xPY+D9F5P+PZdTs4H6H/tsJIgbzyi6bMUJhM4hHBkM7yQ8CXRdo5n7gC
         uNeQhd/CUNPTmP+FRe8wRGCrM8kAZeKPioa8b5llFdxg9SWm2+J+XeMnZJeNjLj+054U
         Nlgg==
X-Forwarded-Encrypted: i=1; AHgh+RqMZSACHvh6Yu1qnjgfvYhQYRM1OiSwcECmX5MBFQTlE9YaPgVC20rP9Yq9yBsJ1Gy66H0sP1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4trn4G5HQ0HOH+KdGM9l3VMxpL4yY3IV2zeBMX/xsN3xE/Oq
	rAovf/aCR41J0I9gjjaKCIO24OHFmQPesXVVysFuOIft1OU5D1Z58Rw=
X-Gm-Gg: AR+sD12jtgfYklj1tBuqZNJacJ+jbAanbe/W9omgMqv7GwAQuAmoIBkX5bIw6QcxWx2
	b8lJGKaE8Z3As1aEmFjpYryS8eAa6/Luw1vNGiLMgGvaa6q4aDePR20NmJncWzD9PkCXVvbkbz8
	SRGlRXGeErBotJRr8e6rAZhUmDIOd6pNs0TjMzRFOKupPNFF373GM3JpadX4OVtsI2pYPEIdmwJ
	1pNaa+x+ck/kT9uHapy62E+D4Tt+2VhZ/wiYplA82S2jEsJq+kboeAtYF0dJfEyKDnf0BHzeWZk
	qZE8DwHxqjai0oKe8A4JpjCrtpPVU7DOuzMnQj3ebD72Y/nKr/tBmlvh0PY3wTeR3nkYJmAP95e
	87baREeP5be7QzKzDo3qg1vufNUPm3PTMcUe2sLrhy5ccDJBXkYbJBuLzQGZT0+vTNUW2MACtRH
	OkR+p+2yyeQXG4XKZaSyjMZHC8YwqulA==
X-Received: by 2002:a05:6000:470d:b0:481:5167:d526 with SMTP id ffacd0b85a97d-481606f4665mr13917452f8f.6.1786749174148;
        Fri, 14 Aug 2026 16:12:54 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f219f7bsm11739429f8f.13.2026.08.14.16.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 16:12:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Manish Mandlik <mmandlik@google.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH bluetooth] Bluetooth: cancel devcoredump work during device teardown
Date: Fri, 14 Aug 2026 23:12:48 +0000
Message-ID: <20260814231248.3096377-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

hci_devcd_setup() initializes dump_timeout and dump_rx work items
during device allocation, but hci_unregister_dev() does not cancel
them before the device is freed. If a devcoredump is in progress
when the device is unregistered, the dump_timeout delayed work timer
remains active. When it fires after hci_release_dev() frees the
hci_dev struct, it accesses freed memory.

Add hci_devcd_destroy() to disable dump work items and purge the
dump queue, called from hci_unregister_dev() alongside the existing
disable_work_sync() calls.

Fixes: 9695ef876fd1 ("Bluetooth: Add support for hci devcoredump")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 include/net/bluetooth/hci_core.h | 9 +++++++++
 net/bluetooth/hci_core.c         | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3df59849dcbea..5a60c3f94a462 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1800,6 +1800,15 @@ static inline void hci_devcd_setup(struct hci_dev *hdev)
 #endif
 }
 
+static inline void hci_devcd_destroy(struct hci_dev *hdev)
+{
+#ifdef CONFIG_DEV_COREDUMP
+	disable_delayed_work_sync(&hdev->dump.dump_timeout);
+	disable_work_sync(&hdev->dump.dump_rx);
+	skb_queue_purge(&hdev->dump.dump_q);
+#endif
+}
+
 int hci_dev_open(__u16 dev);
 int hci_dev_close(__u16 dev);
 int hci_dev_do_close(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5ba9fe8261ec8..d4d559dabf422 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2671,6 +2671,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_delayed_work_sync(&hdev->cmd_timer);
 	disable_delayed_work_sync(&hdev->ncmd_timer);
 
+	hci_devcd_destroy(hdev);
+
 	hci_cmd_sync_clear(hdev);
 
 	hci_unregister_suspend_notifier(hdev);
-- 
2.47.3

