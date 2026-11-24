Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481983;
	b=ma+VmXR17gNDjl/OJ8VdFEj5wBMHEDR9jUgVIHv2AZIQ66AKkHmRs+gDu9rnkEFLLeFr
	 80Q7LUsuOXKKhNor2UKhPweDBeGSVu0YV5aaQSkUxOiurEQoPyiCnz6YuxPOiuc2R4LCk
	 +KGlbeMSxh2WLlyYwmWA7LRPySImvfO35JvHNpclginawgM9y7WBo91wZdX1wXwy5dm39
	 IjUxNyNOgTRdik7bvKuvbXERPb1FC6IV1DnIpES+HBtVD0eT4ziM1cFqhf0LlC/ne3Ltt
	 kUTCdOWxoDaEOOgiDQry51TAo02GZ+kr6xCxYNAoFfGlbau8sMrDGfm8a29uCqCWdkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tb+J4grrziNRGAo5T7DYul9U5wujwe9VyddWPwEAkYY=;
	b=wOCZNvh9Wz/DX/BVaiVBUGt4YyspilucvkzR1VEAsDg+R87Jr7vaEcR9DRLeImDESmaF
	 i9ot8SgWy4zX5p89GTkkQZijYyDxVs27x1tx07JBVH57qpzFfx9yORAcSdMLIBtHpHHKO
	 DqiVuSR+jura03+PqS9quvCVlpaQO02iDk0o/dBq0VvX6eu7UTV4OB+JHueKeKIgbZTnd
	 61SQDuZ7nfj/1vGh3pZxRxyGB4K88ECC0Aa05oGIU1Dk4IySwqJg+Mev0AUVIPSRTAmEk
	 4mF7ContWG8uuCp6H3VBqV7lZ3Bd3EtiAmUtCjpYaspXd80h2NgtEqXUMQg5tzVLMtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wek8TN7k;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AB606A32E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E2AB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wek8TN7k
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ee20b82356so4246925ad.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795481982; x=1796086782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tb+J4grrziNRGAo5T7DYul9U5wujwe9VyddWPwEAkYY=;
        b=Wek8TN7k5mzTTV1daBakIMoT6MI2Kiu4AGlfuzfehdioXNylj9hkrVTsl2I+KQ1u56
         wRS7P6IEcExGQxa0lXr2D4tGxM9ATqOUVaNrD3aB09lH8zyP5p/oxqzOyO12S+tMnp2E
         aI6iv8FvgkNWDdHzSr5BQenJg03x2Vk4rygPy9gRdJQTWH87ziEAgf/hiI6NtnPq7yKX
         q+wKskvSy5EO/mOomofYM7ms75ewbnBLJkdZ+rliqX1EFwOjJeW83h38/7wvumewBFjA
         hfVCepPElvo+9Ws0UgQTyV2kox2aotuwDdzweCQyLpS0WcJfaoOCFTUPXfGM5cL/sgRr
         YWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795481982; x=1796086782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tb+J4grrziNRGAo5T7DYul9U5wujwe9VyddWPwEAkYY=;
        b=YqsNZ++DqsI7J7BPROUQAqOgNXknJfOdrt1AQBAkgXe39kVnv6gNREQs28NRQy/6pk
         xOxVm1wTpB2E6Kqn8xX7vjx+6tx1m8pmLURxFqHqdYIuIRVKgpC9U45H0NZTjid9mKH1
         oPOreIM+OfaaljlCNNcjrNpj8t50q7rUM3CgcKQmyPTIoNHZbmyyj7n7P1GHQ2YBbXzA
         RKr1fExj7qvd+llm/l6U0l3WCBNA/0zVWS5eXwbDyqLNB6fE/T4KJGqw+iZINDVRzV+d
         6HEhIfdzP7IKJ6uFT6u6RFi4VYN5XIvhwpNKtLUneGyxv7EkPZDYhWyTUY+beppOaC+j
         ENUQ==
X-Forwarded-Encrypted: i=1; AL+hErEHWrIrERQjbXJxRZ9Hu88//tm8k0NP6CQibK8OB22GIeiWNBgXCGfeAivpzbdo9yjXFKjn+us=@vger.kernel.org
X-Gm-Message-State: APuU4Z99VaYohlpsxLcwk0NRrS0zOLDF/8/9CjKiyRsCYrkI19PRw+8n
	JoPobm9Xfb6djh4FdsWl5J23FhtjDtzk55/p8GCedbS6xgkJyCRSh7dD
X-Gm-Gg: AZFdTZdCq12nrTk61k+evIq8RpIOtqZ+B+UUcViL9xPqfgyadXaLEG+WAuB3I+PTP91
	AWQyX5juJcPQ0VzZvdz/pPw/+bySonJHEosqCd7+XgnlMCvztS2/vaRq6jhBDuOri3nMXieS/6N
	bkQCpX14bh+NPvla968pemLLKzBgv9Y3Lz/BMAChjA6gAe1zrvNPcKVSdAegTHYJXMrcS/jUN9/
	gUkdr7c5b9i5WRf8EJ2ALtdJIvE55tHnjNTFNYEQjGSYFujAOi2xP/83nNro1N0+McVIXo3ncqE
	hKXUKbnFV9VPdJ3pCvpRrV0Y6QASq1uO2vaM6Tat16E/JJx1dwKoP8S506qwll7ZaUyTFqlukDG
	sTZNpAQMnEQXQ2IC5yPlryERA18GmTJCEYj+nLSRBSHL6L+9JiCtVm6NGG6QjqBD/aEy46Y6WXy
	8L0nVODXi80Vkq0YNDhJosUAC321CoxBWdva8Zu+fefmDq6RFRoGDD/ZOofIiy3vrPzkOBXBYNO
	P7sr0yq687DrKRRK/QJ91X1/YqzV7vbxlxVUKuXget4HYb5ESAR5iizXTK99P5El7ZbtWpa0+5k
	Im26hkd86dr5+4uL95NIij3QTVMMYDDp4eE/3hEXnkGPZdPs4hxIElC8z1FgerEMxwdj2YxRc/x
	3XVDmlQY7fpwMdvWggbDgdHWZQ7LjeqdgXRyUHU7386Z9F6vYVoHLgFzRwBoUddaEO2vrMm87y7
	/REdNOkFxXFl0=
X-Received: by 2002:a17:90b:180b:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3b41c7d0dcdmr20444551a91.1.1795481982478;
        Mon, 23 Nov 2026 16:59:42 -0800 (PST)
Received: from esteban.lan ([2001:f71:5160:2b00:ae2a:b9d5:71b7:3bb9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578d771sm22990964a91.1.2026.11.23.16.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 16:59:42 -0800 (PST)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Antoine Pichot <antoine.pichot@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>,
	stable@vger.kernel.org
Subject: [PATCH wireless 2/2] wifi: mwifiex: pcie: skip the card work once the adapter is gone
Date: Tue, 24 Nov 2026 09:59:32 +0900
Message-ID: <20261124005935.290010-3-antoine.pichot@gmail.com>
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

The work can also find card->adapter NULL without remove(), when
firmware initialisation fails at probe or after a reset. Both paths end
in the failure path of _mwifiex_fw_dpc(), which clears card->adapter and
frees the adapter:

- At probe, a command timeout during the initialisation queues a dump
  and a reset. The failure path clears card->adapter during the dump and
  waits for the work in mwifiex_cleanup_pcie(). The work then reads NULL
  for the reset.

- After a reset started by the work, the failure path runs inside the
  work, and it skips cancel_work_sync() while a PCI reset is ongoing
  since commit 4add4d988f95 ("mwifiex: pcie: skip cancel_work_sync() on
  reset failure path"). A timeout during the failed initialisation
  queues the work again, and it runs after the adapter is freed, with
  card->adapter NULL.

[1] reports four crashes in the card work on a Surface Pro 3 after the
driver's recovery from a firmware failure. In the reporter's kernel
build, all four are the work dereferencing a NULL card->adapter: three
in the reset branch and one at the start of the dump. This patch was not
tested on that machine. On a Surface Book 2 the unpatched driver crashed
on the probe path.

Read card->adapter when the work starts and return if it is NULL.
When remove() or the probe failure path tears the driver down, the
pointer stays valid while the work runs, since both wait for the work
before freeing the adapter. Skip the reset if card->adapter was cleared
during the dump: a teardown is then in progress. Pair it with
WRITE_ONCE() where card->adapter is set and cleared.

Tested on the Surface Book 2 (kernel 7.3.4) with a debug change that
drops one command during firmware initialisation, so that the command
timeout queues a dump and a reset and the initialisation fails. After a
failed runtime reset, the work queued again by the timeout found
card->adapter NULL and returned. At probe, the failure path cleared
card->adapter during the dump and the work skipped the reset. No crash
or warning in either case.

Found, written and tested with an AI coding assistant (Claude Code with
Claude Opus 5.5) under my direction; I reviewed the patch and the test
results.

Link: https://github.com/linux-surface/linux-surface/issues/2350 [1]
Fixes: 3860e5e39532 ("mwifiex: move pcie_work and related variables inside card")
Cc: stable@vger.kernel.org
Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index b63e6ac6e582..c4837102f0cd 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2842,13 +2842,24 @@ static void mwifiex_pcie_work(struct work_struct *work)
 {
 	struct pcie_service_card *card =
 		container_of(work, struct pcie_service_card, work);
+	struct mwifiex_adapter *adapter = READ_ONCE(card->adapter);
+
+	/* The adapter is gone if a failed reset or probe has torn it
+	 * down.
+	 */
+	if (!adapter)
+		return;
 
 	if (test_and_clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP,
 			       &card->work_flags))
-		mwifiex_pcie_device_dump_work(card->adapter);
+		mwifiex_pcie_device_dump_work(adapter);
+	/* A teardown that started during the dump has cleared
+	 * card->adapter. Skip the reset, which would run into that
+	 * teardown.
+	 */
 	if (test_and_clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET,
-			       &card->work_flags))
-		mwifiex_pcie_card_reset_work(card->adapter);
+			       &card->work_flags) && READ_ONCE(card->adapter))
+		mwifiex_pcie_card_reset_work(adapter);
 }
 
 /* This function dumps FW information */
@@ -3171,7 +3182,7 @@ static int mwifiex_register_dev(struct mwifiex_adapter *adapter)
 	struct pcie_service_card *card = adapter->card;
 
 	/* save adapter pointer in card */
-	card->adapter = adapter;
+	WRITE_ONCE(card->adapter, adapter);
 
 	if (mwifiex_pcie_request_irq(adapter))
 		return -1;
@@ -3215,7 +3226,7 @@ static void mwifiex_unregister_dev(struct mwifiex_adapter *adapter)
 		if (card->msi_enable)
 			pci_disable_msi(pdev);
 	}
-	card->adapter = NULL;
+	WRITE_ONCE(card->adapter, NULL);
 }
 
 /*
-- 
2.56.1

