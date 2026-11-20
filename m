Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196557;
	b=IZyYDr/hszhJr1rZyICmfp/95BfY6zd6EWAjiqxNVE/eOkd391Y4X4B+qdhvK6hQLNSL
	 2aWO8cRST2WcBD7K0b3OcTbBWlyrWFwcDMiHx9PFSbUu0CEZ0FLGjSdVHDPWDaar2juqN
	 jkWu/OcVdmO7b8SdJYvIDblPEyMzEixyWpNtLA6eJQKLCpHup2Oqkm2r5pFdL4+ePSOUw
	 J2xQFIOkv4QtEQQpehRR17ctZ8mL/HHXSPrjh8EHXfNPlv7LYTAlOEDi/CsE99F7a2lTG
	 EPbPvSidY40NEaiL6R4sldNIJ8ZZXBsTPv9F20cokWC4tEmt0ddw2kxzNeqaKwIw2gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZcQXLHhR20hCfvjpVa526iaWuFLXqsFmhOokAK+WFKc=;
	b=SxYXkDtyRvy6aGu8ZrGhdTttBB2KPnvvDSshgKQu5ZxeMy20A01Cy0boR8laqDd19WLp
	 +GYurfGvm5FsqdhQl5P2+ufEOHYYI/qaoANtsK1FFsEYMLDJhazIg15PxIUiPVmQg1aAn
	 zXEY7b4EeSlWd06ChWjr0MTqP33ntyISBE+tQrv6vBtJSXFmGj0Wg19c64pCLEEefwPeq
	 e1aoP73/6VZtI07OTQacnZG0XIQnkO/q4SzyOcbfZHt3NU1xgOqh7djooHLUQmmALdheE
	 Sjp5MnQcTfzGKWvsUFc6HuryjMYwRpLXeC/aWqh80IhLebuFLYMGHhaGgLRgg62Jn7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=dothBp3r;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E8606B064
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 442E8606B064
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=dothBp3r
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so1014317f8f.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795196556; x=1795801356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZcQXLHhR20hCfvjpVa526iaWuFLXqsFmhOokAK+WFKc=;
        b=dothBp3r0726IrSCWAX08EYvioo4cffqghvF5G6GmLQS8uKw+MYIbm2jUHYsXYhI/n
         BUZt9IaV54Y0YRulxSYeKILxEaipbNywSvkDJzcGDUsnXRzz4nbQE4LMBgmHjV6WFzBG
         /+a+0n61eiSMsxetVWrYdBCQ9Q97mMLwUvMao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196556; x=1795801356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZcQXLHhR20hCfvjpVa526iaWuFLXqsFmhOokAK+WFKc=;
        b=BTH2ufdsyQSzMA+HRR1gNyioBxfoOJ2QPLAEIRCjI2N+Zf5V2p7KYxHV+rPQpR0oHy
         9mL6K7kb/YvDbC5ExHMgTLtRfP8bAYmlU2LLLrki83nHrI2ydvhom32vQ7Jjnlit494E
         f+itiMs0801H0Ck/1EzmyQ8knXz/xrTVNwkUV9Qv66S5dvBvPBjDzQE/3VMTOdGYXFMK
         k8yF1oVKmeSbQo6/wHJ2ixJf23dBG048wJgtj0/xsU8ZUipa5bOlfXS+3KIfhaRWMaQI
         FHsKdIFRrWO3AtXkB/NptyY8ntEUAp7Ums7jA5uqEvJmfAMw5RW4uOTfpoiBX7xNx3cl
         DlHA==
X-Forwarded-Encrypted: i=1; AL+hErH/q9ihRK0VDl7dkJVJhaH9eg8ZYUtpTQfqCbn/yY49gWOv1YlSk7piSNe4dj/x8rjMFEpgj+A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wzMzPmcPqCOZcfcJNKn3ZtRvRB9GLxEx9rjQdSRbNx7IfCVXf
	l16rCzmUe3eMWxzPMg9Pk1ptecQcUO04jbJ/am4xxY6LwPrHe9Zpg8QbCCh48DcBx5k=
X-Gm-Gg: AZFdTZfrp2kxdtH/1/qikBQYZav1e6ypYU+wYgqZffQW7Deiz/2LdkKlQLSsE4KtCRI
	l+dJFLaIj0qJGMlRBETkgJMFeE5eDghSWwdhBRe6B+MRvHB4tG6QRp1nCV4hDpuyu7PNBDDD3ph
	8vdOOzAs864SsIFYGNQ8VptXVOWfUs8OatviG0geaUbXVZs5Elu0eRCBIBJAB++HNXk8EhP4Km1
	WvkW7s6SAjJRSLzEDT2uIwWSYl0/DPqWdZAZU/tEwKLX5LNJXOedFgKraxkwfai4KWO0lRmCQrg
	lunFM6UUyayRSnMA1aQ2VYgALQcqpNKcyJfP1KprznhrtbtKPAZz2G2lw8lTgTcBXcBPVfYKTeQ
	IfOLuDdCd2Wj378LIVt3neLYi3de1nB/yO0m4uNH5Ywwa1hIlU2mgAMh9mVTvNRlLFY/bIkekNs
	gr9jHQXUe3HOcBcW5e/9xmcpE7w5yZZdiq4/oLgbdH1J3/xjWQ0v7BfEzHMwWmk+Sw2NXsYDWvs
	ocVBIRAELzGMF1prHraVJvCLIaGjGxtK8y2qW1/ucPEaXlVubke1iueY6i7oeXbyamhXwXL36R0
	LwjyPNA1Gsyoc5ERRsigfitvPNC9ZNLcnr2x7A0Pb/525oMXlzdPAAkNGqbOzfmc/USHTzBxoMS
	FpQOgNLVW3UiRt7lQSFFvx3J+JGsMrx50vQIBs66xmDNq/r//u9AVbVeOAw7oW45cCIWeke0=
X-Received: by 2002:a05:6000:470e:b0:4aa:323a:d7b7 with SMTP id ffacd0b85a97d-4abb16e310bmr8421955f8f.23.1795196555630;
        Fri, 20 Nov 2026 09:42:35 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.41.246])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2050f1sm6597356f8f.38.2026.11.20.09.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:42:35 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	stable@vger.kernel.org,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Benjamin Drung <benjamin.drung@canonical.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	linux-wireless@vger.kernel.org
Subject: [PATCH wireless] wifi: brcmfmac: fix use-after-free of the watchdog task_struct
Date: Fri, 20 Nov 2026 18:42:27 +0100
Message-ID: <20261120174231.2024897-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The watchdog thread exits as soon as it receives a SIGTERM, also from
userspace, e.g. when init kills all the processes at reboot. If the
driver is removed afterwards, the reference taken right before sending
the signal by commit c623b6358088 ("wifi: brcmfmac: Fix potential
use-after-free issue when stopping watchdog task") comes too late, and
kthread_stop() runs on a task_struct already freed.

  WARNING: kernel/kthread.c:84 at kthread_stop+0xd8/0x190
  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Call trace:
   kthread_stop+0x148/0x190 (P)
   kthread_stop_put+0x14/0xb0
   brcmf_sdio_remove+0x58/0x1d0
   brcmf_sdiod_remove+0x20/0xa0
   brcmf_ops_sdio_remove+0x5c/0x90

Take the reference before the thread is started and drop it with
kthread_stop_put() when it is stopped.

Fixes: c623b6358088 ("wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task")
Cc: stable@vger.kernel.org
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.c  | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index cea52d408817..67b2291f8ee5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -2478,7 +2478,6 @@ static void brcmf_sdio_bus_stop(struct device *dev)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	if (bus->watchdog_tsk) {
-		get_task_struct(bus->watchdog_tsk);
 		send_sig(SIGTERM, bus->watchdog_tsk, 1);
 		kthread_stop_put(bus->watchdog_tsk);
 		bus->watchdog_tsk = NULL;
@@ -4500,12 +4499,16 @@ int brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	timer_setup(&bus->timer, brcmf_sdio_watchdog, 0);
 	/* Initialize watchdog thread */
 	init_completion(&bus->watchdog_wait);
-	bus->watchdog_tsk = kthread_run(brcmf_sdio_watchdog_thread,
-					bus, "brcmf_wdog/%s",
-					dev_name(&sdiodev->func1->dev));
+	bus->watchdog_tsk = kthread_create(brcmf_sdio_watchdog_thread,
+					   bus, "brcmf_wdog/%s",
+					   dev_name(&sdiodev->func1->dev));
 	if (IS_ERR(bus->watchdog_tsk)) {
 		pr_warn("brcmf_watchdog thread failed to start\n");
 		bus->watchdog_tsk = NULL;
+	} else {
+		/* The thread may exit on a SIGTERM before it is stopped */
+		get_task_struct(bus->watchdog_tsk);
+		wake_up_process(bus->watchdog_tsk);
 	}
 	/* Initialize DPC thread */
 	bus->dpc_triggered = false;
@@ -4576,7 +4579,6 @@ void brcmf_sdio_remove(struct brcmf_sdio *bus)
 	if (bus) {
 		/* Stop watchdog task */
 		if (bus->watchdog_tsk) {
-			get_task_struct(bus->watchdog_tsk);
 			send_sig(SIGTERM, bus->watchdog_tsk, 1);
 			kthread_stop_put(bus->watchdog_tsk);
 			bus->watchdog_tsk = NULL;
---
base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
branch: brcmfmac-wdog-uaf

-- 
2.43.0

