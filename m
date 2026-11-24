Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481981;
	b=xLgCxsr0XhOAb0zSWbsR7fqJrQH0SaUYPOwm0UWDNVPyqjy8vVGcUWE6E0aOlzzZ7JnV
	 uv98BsWuqF3dboPMZ3jvaDAwiFOWvLm7W24c0RcL9IameGNyQc/jTqZ0M0wj3n+chqH7P
	 zurbYg6T6pIqYxeJ946W5qQSoGbHl1mo117Rqx7CB/974yF2SqMChxe6rNXMl3SEEBodV
	 bLJZUyXs7tNSEISR8oH25A/HBnCrF7XDokJ5hBtXFtfOJ5O4LaGoogiOTtlFq4Qrw8qxS
	 SxMzF6wDuAkJUWNB7Hh2XaXEJb1YA/0inR3GI3kEKk5kI4Sr/6xBEL55msS6178l8Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CQ0ywlob12oatuyVpHVVygHWAZ6j+SXjJPArn5ZAhIw=;
	b=wbBPGqC4ytrMTjRh1V0DxDYlPd9rhzfh/X0EYlr0Q6F3703zObMSUMBrvnFyyvhPEVDK
	 kkNVXicbzPOluriHzG8oDxQPNSlE87ckQLt44O89/P5ZMfPTzxM+jbz0AFOy6hSsVYl4E
	 8MpjHt449e7T+8jSmw0nnmO/Bi0AyxfGbdTR8gplyT//t+JrKkz+2H6N5SQf0ve+iNVVO
	 dOu8opAJnw8NUpM2QshQTYYm7EexuBjktVWIWk/Agnjd7DVb3LdPB7X9boM/mPdTEMfeC
	 QxkfeB+ycGgahqkvKfZQ3Am7NTq8kJwIRFdYhwNSi79HwvpU7LieXHrzwiAQ8BbNjNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFP6Sxa2;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C2606A33A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 523C2606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFP6Sxa2
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b43d6c3485so428875a91.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795481981; x=1796086781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQ0ywlob12oatuyVpHVVygHWAZ6j+SXjJPArn5ZAhIw=;
        b=lFP6Sxa2S4wDs/9G4Nz63q0Hq87wYPI8Ig1MkrL+7mJVSLjn1KUnGyCeelX46auegl
         dwg7sjemuJPrNWnbSOHvyGdNrHKLFa4I7/liZR0AxURxgXuSdUARcPttMFIIUqY3sArr
         KXz4KMNkIdWKj9RnCzMQSrASKimjC7eQtWySDNXCGuGP7sfRNYu55noNgoNe7wLjM4sr
         dvEqMRnwK+/IS5HpDKfB7rdKjfy5r12nXTe5iv2PduDHxFpWOURPfgJDPEO4Yec3qx5d
         lbmY1GO08d8x1rzhD9/30rjmqqbsowwSbYlxNNhjLF798ZslrvuUFmfkIaptcafOUG8t
         ZdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795481981; x=1796086781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQ0ywlob12oatuyVpHVVygHWAZ6j+SXjJPArn5ZAhIw=;
        b=cxcyQjt93z4qgHNlCcq1s7xAmxfNHmFz0OIM9mpM23k2fvZZQQOUcW2ql8xvFb7Z89
         VVDPls/rCZupV47ROe0gmU3ZJX2g8Z1TSzcqn454jXlbACk4cZ0Zhu0DDQLKvRcroneW
         BCSGZYChCij1JrraAIpZfQuUEgKGOx4xC+sFhW5erMcFtu2jrBheNT928Cl3h+bGjjha
         8MowXhO83RTq/aWo3N8q2N5SNEZhIBloZGGZx0zjUvwljV9Xce4g0W9ulPiMmwLoLX/h
         jXgU3xG8h7xXRLTVD7aJfTboyYbt8YPOHcbQYBUAqjot9kTijZnrBwFPo+cA3Ui6+IIz
         Aafw==
X-Forwarded-Encrypted: i=1; AL+hErE4j+ND1MGfbOEfXJWDTx8lUWJCDV/p+sdIRZFlhcb1xOWeBJmHe/cZU2hdUn9h2fQbe9ijFrQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tKFBcefq2n7kl+qlS9lh3Ex1aYdzcgFK8oAQgM85Gku5xcPJE
	lDNOZ9ww1VeVa9as7tNrUjmR8UzsoSiO/Z1yWpTR5fjzK7R8epMjZAkI2d2pAbN2/js=
X-Gm-Gg: AZFdTZeZXdz4axaKtEeYEmT9llcbqT+oR0cl3XkyOeFl6AjIDobRIYeakGNebZgpfdZ
	8aaN8Ox7gPiXWQhVSvP95fNYGHYTL05Vp0qsSzyQTNl8CV/R7fEIpygQVA49wpvn+cKZ4c07NQD
	2wsbMn2DqIXQ087+Bq6/7S9cFwe4VyWwOPRhOVuzpdyO2zmkXKZLHhd6kxGqMRw6K02NG8WOB0C
	fTZmGY8kWFP4S5l+yJr60saug+i7AbOTmstwYAss9cGCi0DdeaQfwKu90lh4uYe6ogft5iQ5sYl
	lBKWNRc8/orUhdSBQjlvBXSexhKzAEeN0b8Ite/5/qsSSUdtAYF6Q+bq3aKrnXoq+mmcDm9WGAL
	J8aFRgdyDcL5evYRuPS4YansLYjmbLBol8KijPyksCY5RwfymxNYkwH8lwoBLQZNU0Bdk9yEgYE
	a7ojoN99TjIazsolB51qT/0Ft5Evk0uk7eTbpuUlTLs/R8JcmiWAD5UBcEaRgSO6pCqLo+/WwmJ
	wgPuFmDxjlbVY5i1CXCEEuPYVCLUrWUb5iXb2yutkqH7U9jBrO4ihoCFlUC4B5ZvYuYy2gUvKHQ
	8l2BmX14H6/0dK1Vd+VzdqtDnfzFKKcqwz3/uHcwml3MNxQDq4F2PRP8il5S34LBH3b2HDvdMjk
	cT4xJkBc9A4qXVD6XGivUmu/l66AKwlmFodscItFGCKHOLkXtsEDr8uM/RVbVbdMsU3zOb1cTk0
	+m5Q9F6y8NR9k=
X-Received: by 2002:a17:90b:442d:b0:3b0:d0be:f02c with SMTP id 98e67ed59e1d1-3b41c98a095mr19699757a91.6.1795481980585;
        Mon, 23 Nov 2026 16:59:40 -0800 (PST)
Received: from esteban.lan ([2001:f71:5160:2b00:ae2a:b9d5:71b7:3bb9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578d771sm22990964a91.1.2026.11.23.16.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 16:59:40 -0800 (PST)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Antoine Pichot <antoine.pichot@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>,
	stable@vger.kernel.org
Subject: [PATCH wireless 1/2] wifi: mwifiex: pcie: stop the card work before tearing down the adapter
Date: Tue, 24 Nov 2026 09:59:31 +0900
Message-ID: <20261124005935.290010-2-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124005935.290010-1-antoine.pichot@gmail.com>
References: <20261124005935.290010-1-antoine.pichot@gmail.com>
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

If the firmware does not answer the shutdown command sent by
mwifiex_pcie_remove(), mwifiex_cmd_timeout_func() queues a firmware dump
and a card reset on card->work. remove() continues into
mwifiex_remove_card(), which clears card->adapter and frees the
interfaces while the dump runs. When the dump ends, the work reads
card->adapter for the reset and dereferences NULL:

  mwifiex_pcie 0000:01:00.0: mwifiex_cmd_timeout_func: Timeout cmd id = 0xaa, act = 0x0
  mwifiex_pcie 0000:01:00.0: info: shutdown mwifiex...
  mwifiex_pcie 0000:01:00.0: == mwifiex firmware dump start ==
  BUG: kernel NULL pointer dereference, address: 0000000000000088
  Workqueue: events mwifiex_pcie_work [mwifiex_pcie]
  RIP: 0010:mwifiex_pcie_work+0x87/0xc0 [mwifiex_pcie]

This crashed a Surface Book 2 (88W8897) at shutdown four times in about
400 reboots; the three crashes with a full log went through
mwifiex_pcie_shutdown().

The teardown waits for the work in mwifiex_cleanup_pcie(), but only
after card->adapter is cleared. Commit b713bbf1471b ("mwifiex: cancel
pcie/sdio work in remove/shutdown handler") cancelled the work earlier
in remove() for this crash. Commit 7e34c0d2f631 ("Revert "mwifiex:
cancel pcie/sdio work in remove/shutdown handler"") reverted it, saying
that since commit b014e96d1abb ("PCI: Protect
pci_error_handlers->reset_notify() usage with device_lock()") a reset
cannot run during remove(), and that the work then waited in
pci_reset_function() for the device lock that remove() holds. The device
lock does not cover the dump, nor the read of card->adapter before the
reset. Since commit a64e7a79dd60 ("mwifiex: resolve reset vs.
remove()/shutdown() deadlocks"), the work only tries to take that lock,
so remove() can wait for it before the teardown again.

Use disable_work_sync() rather than cancel_work_sync(), so that a
timeout or a debugfs reset request during the teardown cannot queue the
work again. The card is allocated at probe, so a later bind starts with
a new work. When the firmware does not answer the shutdown command,
remove() already waited for the dump that the timeout starts (about 46 s
on the 88W8897), in mwifiex_cleanup_pcie(); it now waits before the
teardown instead. A dump still waiting in the queue is cancelled.

remove() also returns early when a failed reset or a failed probe left
no adapter. The work can still be queued then: a failed reset queues it
again from inside it, and the teardown of a failed probe stops the
command timer only after waiting for the work. Wait for it there too,
before the card is freed.

Tested on the Surface Book 2 with a debug change that queues the dump
and the reset in remove() right after the shutdown command. Without this
patch (kernel 7.2.15) the work found card->adapter NULL in 3 runs out of
3. With it (kernel 7.3.4, before the wait on the early return was added;
the main path is unchanged), and a 200 ms pause so that the dump was
already running when remove() reached the wait, remove() waited for the
dump (about 46 s) and the teardown completed cleanly in 5 runs out of 5.
With patch 2 also applied, a debug change that makes a reset fail (it
drops one command during firmware initialisation, so that the command
timeout queues the work again and the initialisation fails), and a 5 s
pause in the work when it finds no adapter, remove() took the early
return while that work was running, and returned only after it.

Found, written and tested with an AI coding assistant (Claude Code with
Claude Opus 5.5) under my direction; I reviewed the patch and the test
results.

Fixes: 7e34c0d2f631 ("Revert "mwifiex: cancel pcie/sdio work in remove/shutdown handler"")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index ecbe864b0797..b63e6ac6e582 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -437,8 +437,14 @@ static void mwifiex_pcie_remove(struct pci_dev *pdev)
 	wait_for_completion(&card->fw_done);
 
 	adapter = card->adapter;
-	if (!adapter || !adapter->priv_num)
+	if (!adapter || !adapter->priv_num) {
+		/* The adapter is gone, but a failed reset or probe can have
+		 * queued the work again, and the card it runs on is freed
+		 * when remove() returns.
+		 */
+		disable_work_sync(&card->work);
 		return;
+	}
 
 	reg = card->pcie.reg;
 	if (reg)
@@ -456,6 +462,13 @@ static void mwifiex_pcie_remove(struct pci_dev *pdev)
 		mwifiex_init_shutdown_fw(priv, MWIFIEX_FUNC_SHUTDOWN);
 	}
 
+	/* A timeout of the commands above queues a firmware dump and a card
+	 * reset on card->work. Wait for it and keep it from being queued
+	 * again before the teardown clears card->adapter and frees the
+	 * interfaces the dump reads.
+	 */
+	disable_work_sync(&card->work);
+
 	mwifiex_remove_card(adapter);
 }
 
-- 
2.56.1

