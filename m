Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075013;
	b=jX66Dumgo6OsNyWHucjSvGttPYayTZLsNtmG8FpYo3qw8B2v2edtmd/iOVcyyDvSURlZ
	 l8BWaZ2mXxBNi+5WDuo47LEm6xhZNzr1BNRXuR9//e8YL28PY4usL5nDl7CEjXvneu/BT
	 F7VpDY8opFGW24WLYA5jshTQUyJsZ63wvcAe7IwUmmy/ZWyaP8L8ZrBVv0ofNfa+w/hZ9
	 4hr4RWRnwu7djwcCFnPslc5Un72dhd0GFwMPsjm5IkfQG3mwe13Q3ygnYdA8Z47Jnxgqn
	 aSjtLwhJEdx9axfPsu5etYa1+e8Eui1oVVFPLeOZrx/yov9El3NTOPwxVNbTGGgQa1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xEoymSwj1gcF4QUAT7oBs9Zbj8EvbnCEDrEiMBfoV2Q=;
	b=sHS03L2nmW25fR9fxPW6Dp9ZUPH6CeQqBakSp6tgpoNGHrNbLG0KInmYGL6n8gqEQMs0
	 sLByJQGz0Ic0KtBy/yhF3xG4KRXIKKucTBWQOWKVzqun1RxNHwEhYFN9SFh+GB4U8z5Nq
	 gcakdIxNJ4We5jUWjIFl/r1ACWJVwH1Ij1lB5F+FEFZa8JErtLIqOOeBkFQ+5LwOtBGTn
	 MT6GmGoJgOISQ6WYsQ/jnRzQVgtBLgszD5OBRCb4G7rSQJHS1L1UQM0ubm4IYYmRmg92i
	 B4wu0kwvOigivq7IflUMFkS9Z2I16HwB3+njjdXvKqYIVmjVccEqY1ymifGYgeGXeiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MRgw5kVy;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDE606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49DDE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MRgw5kVy
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3acec6677so2877405c88.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795075012; x=1795679812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xEoymSwj1gcF4QUAT7oBs9Zbj8EvbnCEDrEiMBfoV2Q=;
        b=MRgw5kVyPUNazSm4uS4KTyeR/7mwxUHLlA0GOOXHBznIY7dMo3LbCKZAs427tPRDM8
         KxnsItMUzyWJTC9as/BSibq9zfCUK0yfnU4UU/MVPGjn3skJd5LTrNQTKYgTYfIoV0RV
         VCDdMl/WA6yF3Xo9FF0SL6cRrsn7LCEo5ulLcGu8GCXbSPT5jTyTCVw5dHepQA7ujgI5
         yFK9tkMFFSw7/lSoO3QaDejHUmTaXMjcjGfJnNk3BjOSqHl2WMFe5yhww3r3u9RyIyHD
         U2GPhy49W45ixBifHQqF1rBdY/Xlhm4IzO/9uNr1+MnX5RatCJ/uxjrMOSrnihi0us6+
         os1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795075012; x=1795679812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xEoymSwj1gcF4QUAT7oBs9Zbj8EvbnCEDrEiMBfoV2Q=;
        b=ACJoxYXQ4ArBdnQcJjf4qX/yyDL7B3PWmT3Rdg9rSODsuKIuKEa0a4zCLEcZBu8xYP
         3L4IiIjPLHhiHFHGCBUCxv7C89szk2avgBN536FgBfo1WBuMcvKb+CraZAgf1IIZMpX6
         t7Wj1351S/rXk0/HRH+HVh/p8Gcwm71AjILK0QfpAY+ON2gc2d7lTc7pntnukjB6++RD
         KqzOmxBV+OUHAOh1pbIuIyva6cB/M/hyrYSjRuN1XujKUpetq2MBvmzivaK26dReJbum
         bdeq0i8MOJkH+5k6TZlit4f8SaoMSBNpTZ0mE7PUSAt+0h4Lo5ofLS1xNQXu9cfNo6Iw
         /1Sw==
X-Forwarded-Encrypted: i=1; AL+hErEMoQ1SzOAZIiPUWSy04w+CyC7a2N1Oj+qr0LEPSbP8CWOFsqBHCLfIpP1cQm2pD/RSdYWCM3A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uluxEhGvnp2UoV0Rsk0UR2ks09kD/OCoRtDLWKh+E0iDEbPVK
	EfFD4NOA762xFtI8LFEPgoz5hBNZswR7gt24dCe57mxigEP5mXvO4oB1
X-Gm-Gg: AYBFou34lOFW2f1zJq3yKk7Zdb1/xq1OSSl3YPcTZ3WxLBA29b6vhtVvzr2Qh+uOxYk
	5H5UIkQhoYbLU55eZBND07kiOVop/qUZmIfB46RdjjCpSLajEvfNecVPadj5S0ZLV1G1T6Ci6Cn
	7wIuO3Eb90fA/ZlT0bahRwX8jqp8/3HcpaB65STSmGQDaoAFRVsSlSKhWOKjnUyaqRBIAbZBuKs
	eTjSAgdtUhCzjR4tqnSJ9aMjjxfH1u3kx5qLYdC3pIhg+0QYodOi2R27Lwbzj5kMVszdSEaGGjI
	r6cyDtVAhzsBfSYy+DLiqxefepXwH4GvoEDc07O6iixABJXbHVKmfgrqVTan7w5DGZUh26qUA01
	VDosePhY+ENxloSBh1EoRVoPwwnxKgxgF3UkongRi/qVokBnqsD5mBieVzSyLXtkYRV0N1MPYuO
	kXyJCIgv/6lr10KqYR1hgi7g6I090EjhJovnZAwHZPWp2ajR57nhp9gsDnE972a3DsCMv/gPdnM
	9WuIRs+i4nTuRPibrt3/Rp0nsMmSFUZPPUajUrQFV5oLTKhDXRdGh5kVJLPvSL9o43w0hKLN4kd
	ynp6AC1vSX8dOeJ/tmSqT0hbZtmBod2VFg8N8f3yV4NwAkRhfA==
X-Received: by 2002:a05:701b:2202:b0:188:e51:e86a with SMTP id a92af1059eb24-1b543c14aaamr3714450c88.2.1795075011818;
        Wed, 18 Nov 2026 23:56:51 -0800 (PST)
Received: from G7XWH7K1F3 ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5445eb29esm12778151c88.0.2026.11.18.23.56.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 23:56:51 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH ath-current] wifi: ath12k: fail the start when a service ready event fails
Date: Thu, 19 Nov 2026 15:56:28 +0800
Message-ID: <20261119075628.11096-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
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

ath12k_core_start() waits for the service ready handshake, in which the
firmware sends SERVICE_READY, SERVICE_READY_EXT and, if it supports it,
SERVICE_READY_EXT2. Only the last of these events completes the wait,
whenever its own TLVs parse, so the start goes on after an earlier event
failed (for example, on -ENOMEM or a malformed TLV), with capabilities
that were only partly extracted. An event that arrives again, even after
the start, is handled again and rewrites the capabilities under a
running driver.

Track the next service ready event that this start accepts. Each handler
takes only its own event in turn, closes the handshake before parsing
and opens it for the next event only on success. A failed event then
makes ath12k_wmi_wait_for_service_ready() time out, and any event out of
turn, including one after the handshake completed, is ignored.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org # needs adjustments for <= 6.12
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Found by code review. Tested in a QEMU guest with KASAN and a test hook
that feeds service ready events to a synthetic device: without this
change the start completed after a failed SERVICE_READY or
SERVICE_READY_EXT, and duplicate or out-of-turn events were parsed again
after the handshake; with it the failed start timed out and those events
were dropped before parsing.

No new W=1, sparse or smatch warnings.

AI assistance was used.

 drivers/net/wireless/ath/ath12k/wmi.c | 22 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h |  9 +++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 75b259990c79..89e4dec07534 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -732,6 +732,11 @@ static int ath12k_service_ready_event(struct ath12k_base *ab, struct sk_buff *sk
 	struct ath12k_wmi_svc_ready_parse svc_ready = { };
 	int ret;
 
+	if (ab->wmi_ab.svc_rdy_next != ATH12K_WMI_SVC_RDY)
+		return -EPROTO;
+
+	ab->wmi_ab.svc_rdy_next = ATH12K_WMI_SVC_RDY_NONE;
+
 	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
 				  ath12k_wmi_svc_rdy_parse,
 				  &svc_ready);
@@ -740,6 +745,8 @@ static int ath12k_service_ready_event(struct ath12k_base *ab, struct sk_buff *sk
 		return ret;
 	}
 
+	ab->wmi_ab.svc_rdy_next = ATH12K_WMI_SVC_RDY_EXT;
+
 	return 0;
 }
 
@@ -5148,6 +5155,11 @@ static int ath12k_service_ready_ext_event(struct ath12k_base *ab,
 	struct ath12k_wmi_svc_rdy_ext_parse svc_rdy_ext = { };
 	int ret;
 
+	if (ab->wmi_ab.svc_rdy_next != ATH12K_WMI_SVC_RDY_EXT)
+		return -EPROTO;
+
+	ab->wmi_ab.svc_rdy_next = ATH12K_WMI_SVC_RDY_NONE;
+
 	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
 				  ath12k_wmi_svc_rdy_ext_parse,
 				  &svc_rdy_ext);
@@ -5156,7 +5168,9 @@ static int ath12k_service_ready_ext_event(struct ath12k_base *ab,
 		goto err;
 	}
 
-	if (!test_bit(WMI_TLV_SERVICE_EXT2_MSG, ab->wmi_ab.svc_map))
+	if (test_bit(WMI_TLV_SERVICE_EXT2_MSG, ab->wmi_ab.svc_map))
+		ab->wmi_ab.svc_rdy_next = ATH12K_WMI_SVC_RDY_EXT2;
+	else
 		complete(&ab->wmi_ab.service_ready);
 
 	kfree(svc_rdy_ext.mac_phy_caps);
@@ -5871,6 +5885,11 @@ static int ath12k_service_ready_ext2_event(struct ath12k_base *ab,
 	struct ath12k_wmi_svc_rdy_ext2_parse svc_rdy_ext2 = { };
 	int ret;
 
+	if (ab->wmi_ab.svc_rdy_next != ATH12K_WMI_SVC_RDY_EXT2)
+		return -EPROTO;
+
+	ab->wmi_ab.svc_rdy_next = ATH12K_WMI_SVC_RDY_NONE;
+
 	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
 				  ath12k_wmi_svc_rdy_ext2_parse,
 				  &svc_rdy_ext2);
@@ -10788,6 +10807,7 @@ int ath12k_wmi_attach(struct ath12k_base *ab)
 	/* TODO: Init remaining wmi soc resources required */
 	init_completion(&ab->wmi_ab.service_ready);
 	init_completion(&ab->wmi_ab.unified_ready);
+	ab->wmi_ab.svc_rdy_next = ATH12K_WMI_SVC_RDY;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index b508aa759bd8..59bf691352bd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5397,6 +5397,13 @@ struct ath12k_hw_mode_info {
 							    [MAX_RADIOS];
 };
 
+enum ath12k_wmi_svc_rdy {
+	ATH12K_WMI_SVC_RDY_NONE,
+	ATH12K_WMI_SVC_RDY,
+	ATH12K_WMI_SVC_RDY_EXT,
+	ATH12K_WMI_SVC_RDY_EXT2,
+};
+
 struct ath12k_wmi_base {
 	struct ath12k_base *ab;
 	struct ath12k_wmi_pdev wmi[MAX_RADIOS];
@@ -5405,6 +5412,8 @@ struct ath12k_wmi_base {
 
 	struct completion service_ready;
 	struct completion unified_ready;
+	/* Next service ready event this start accepts */
+	enum ath12k_wmi_svc_rdy svc_rdy_next;
 	DECLARE_BITMAP(svc_map, WMI_MAX_EXT2_SERVICE);
 	wait_queue_head_t tx_credits_wq;
 	u32 num_mem_chunks;

base-commit: b1ed5a45b994a6473ca1cf34f35a1bf87f1d8e2a
-- 
2.56.1

