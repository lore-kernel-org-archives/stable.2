Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509881;
	b=BFA2DuJ78NE43609wqYhrKTkyZEExby+smCzehC+HsgzY4CKOu6S3iRrY9JrnIwEf0E8
	 cWow/ZA0jussl9F8hrmtRG7PFvrqF6yva6AXkj0IbtBBmKCxpPeyr/kPPpTL7tK8Gg9VY
	 qrCYkQegEh36jifU8J9e5hkBFYSCsKWkcKvZI6riQo9B/KsxByupQxfNgFC0qwz7Ith5H
	 xSuFofpL9q6jVyGbfQoA2wopMstdhSwiMgGBHuEvdmvJJoVsWVig7QjdWWarP8u332FNR
	 YLEgy+dWeRxNWnn/EUcoK67SbsSv7+KyIalmc2ZwRxSk2KElHma+zsZhJoXBlQU8i0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G5tN8cFWYKKQdXdrFLYLB4O03z7PGyAtAV81+AhWuws=;
	b=3ttzrwuMHsUWiWoLPHo11z4HEIxnl9DdUZxtrb45Oa6YDzIdKRYlcaygKD68LEyQ+1pM
	 +1IMU6P2ksZVPex82O3p65Q47Y97/iGQpP8R5B1BR2sajheh4X5oH7ZLA8G+lAxnSUxhp
	 bBS9NpTRwo310xRNG4AgtyHX39RGzE+LObCjeYKl3ePoWL3DzimDNi1wogzQoyf1p3smQ
	 aVqb7D8kpkAnlyirO7wnoDnOqKGaEs0L8FStW2SDg1keugHb/ls0tRcYN3LK1Gy9x3Ri1
	 ew2HY6rkKwRAeqHmgZti7lGDTIIHn6iZxIF57B4sgS7J1ptd5xLniMtoqy4FJQWzVoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cX+NB3CG;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F8606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 926F8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cX+NB3CG
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c43fbcb4393so332855966b.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509880; x=1793114680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5tN8cFWYKKQdXdrFLYLB4O03z7PGyAtAV81+AhWuws=;
        b=cX+NB3CG/dJQtaBpiupEdRyIh1uUSNZHmLzJ6mAkshlYKC0Bm6RPkBC71+QgjExV14
         HMtI5uR7Mg7mKwwkeKRtU2aQ2vCRnhhVdc0n8/2+Nf8RFFVWuBxlg4xFCzhKfla1qkXc
         q3lahx2LzV/gj4ynwbnOICeqD0kMLbtkdoXJhs8jeJubXNSEUVKpC3oJGHKKImOkCu5V
         IkdFjg2hVUDbRUlXPBVsV19P+/RXSfAQw4p3jTSZ5bbXT+u21emOa58ZnUdB7Xta4OQy
         4oPajs7sxNh7kJ2k55IQKWGV9ZJOEorie8EuH9wPX3AmW3p3oBuhY58qW7tIFP2wI9md
         YFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509880; x=1793114680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G5tN8cFWYKKQdXdrFLYLB4O03z7PGyAtAV81+AhWuws=;
        b=XgRNI0j5x9Ukx1uqmhDD5keLTsndIeq+IV7o8hGFgbocqE/jV0nTaVytMMJf0B4QN4
         1rQ99YFtucdEI3XFpWcLAG9rWnMZu5//AvmURcFMLPozjhOCKq6hq3GHQjSo3sgzuIvv
         ENppcbKnmkrcvN457mTIz3Vdwm+NqLkzIX9bZ6ovEyktadAaWWbKT3+T9fQrr2riyrlT
         scppY8snhqir+/kHNCx7fYW9JP5WTQLYxGikvOZvUxSyxCGckCzINe8pTd3CVRU04Z6R
         M56xKfs1t+88RN/FkVZPpAolje3ibMETuYXeAJWxZ5LSFfUuzNhUFtGAbrOq9hL+Y2iu
         2MKQ==
X-Forwarded-Encrypted: i=1; AKwUvByZbgIFV6zgnISQl/C4ZAw/3Ju3dG3Lh4z4nrdCrrU6EG0zIMUHQY1KSHzK+w75hwTsfuTOVAk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoZUouh+8lJ+k1f7wUv46+ORe5II8JRHe/7jDjD+kjyV9TPrxP
	l5LsQzBCJfhJEU4LIXCw7zyURxeYTyXGT82jSY3UZcBoGATSj2EQg1Km
X-Gm-Gg: AYBFou3AH0psgUXmz8NEJA3UdkGEgLMsVicd6LA0s+FYrMQCD82OTMbzoH8mZXNOVa7
	yyJNvV/Yb90z2ZP8nAXUBAbNYUasvOzRDLTNg49W5ZQhJl1LB8axzUAhUyidMsjTlu554kJfnTK
	MYQVNr22Sm0//BYnF201pLYM6IC/rQLPVg3ItmZ3/2NVlUnI6kX4ulb9FKq24G53m7GwjJDJdRW
	iP1P3xtR9gu+ZPCCufdcAEewaya1nWdC9fmoHTMq9z1DrqaZmmYsymM+MNmqnfHSrdEZlPuQwmD
	gayXn9485hDKOUqHDQBpQyd7YNOqy4oJ/ewE2TjpeM+M0TRouwi6TBfXZ12PWYYbN6tCeQwcgOb
	+jF41NLnhGxmg+qM7SYcZenBA0EWib1NAXc3QRsS94i6oFsiC6bdhpJHTA4rlbi8jaTt0bZqmd7
	+dlfl45sDPBFS19n139MFv7uepzgadfufS0ojQ21MnySic90JsQFRGjDnmTZAVgA1CI2vv2hK2x
	ckJztKS2G24Pum9iZ+uYTtm1YJExcJ+GZien7RDzZ0hyRNhgpy+qMMxgXSGs8W/IRRzwy+t+06u
	hmDWmqcDM5hCvSUAuB6B2ImGyRJXviF1
X-Received: by 2002:a17:907:9693:b0:c2b:898e:24fd with SMTP id a640c23a62f3a-c419f90824amr855300766b.33.1792509879566;
        Tue, 20 Oct 2026 08:24:39 -0700 (PDT)
Received: from Martyna-s-A34.localdomain (ip-80-113-116-3.ip.prioritytelecom.net. [80.113.116.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919bcfc5sm488110466b.59.2026.10.20.08.24.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 08:24:39 -0700 (PDT)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Mehmet Fide <mehmet.fide@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: ath9k: drop WMI command responses when no command is pending
Date: Tue, 20 Oct 2026 17:24:12 +0200
Message-ID: <20261020152412.95560-3-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020152412.95560-1-mike.michalo@gmail.com>
References: <20261020152412.95560-1-mike.michalo@gmail.com>
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

ath9k_wmi_ctrl_rx() accepts a command response whose sequence number
matches wmi->last_seq_id and copies it to wmi->cmd_rsp_buf, which
usually points into the stack frame of the ath9k_wmi_cmd() caller.
Only the timeout path clears last_seq_id, since
commit 8a2f35b98306 ("wifi: ath9k: Fix potential stack-out-of-bounds
write in ath9k_wmi_rsp_callback()"). After a normal completion or a
failed send the receive path stays armed, so a duplicate response from
a buggy or malicious device is written into a stack frame that is gone,
and its extra complete() makes the next command return before its own
response arrives. Sequence number 0, which means "nothing pending", is
also used for a command once tx_seq_id wraps.

Keep the receive path armed only while a command is pending: disarm it
once a response has been handled, on timeout and when sending fails,
drop responses while nothing is pending, never use sequence number 0,
and reinitialise the completion before each command is issued.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 drivers/net/wireless/ath/ath9k/wmi.c | 33 +++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 76c8dfcc53..5fd20923ad 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -202,6 +202,16 @@ void ath9k_fatal_work(struct work_struct *work)
 	ath9k_htc_reset(priv);
 }
 
+/* No command is pending: drop all responses until the next one is issued. */
+static void ath9k_wmi_cmd_disarm(struct wmi *wmi)
+{
+	lockdep_assert_held(&wmi->wmi_lock);
+
+	wmi->last_seq_id = 0;
+	wmi->cmd_rsp_buf = NULL;
+	wmi->cmd_rsp_len = 0;
+}
+
 static void ath9k_wmi_rsp_callback(struct wmi *wmi, struct sk_buff *skb)
 {
 	u32 len;
@@ -219,6 +229,9 @@ static void ath9k_wmi_rsp_callback(struct wmi *wmi, struct sk_buff *skb)
 		memset(wmi->cmd_rsp_buf + len, 0, wmi->cmd_rsp_len - len);
 	}
 
+	/* The command is done; drop any further (duplicate) response. */
+	ath9k_wmi_cmd_disarm(wmi);
+
 	complete(&wmi->cmd_wait);
 }
 
@@ -248,9 +261,10 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 		return;
 	}
 
-	/* Check if there has been a timeout. */
+	/* Only accept the response to the pending command, if any. */
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
-	if (be16_to_cpu(hdr->seq_no) != wmi->last_seq_id) {
+	if (!wmi->last_seq_id ||
+	    be16_to_cpu(hdr->seq_no) != wmi->last_seq_id) {
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		goto free_skb;
 	}
@@ -303,7 +317,10 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 
 	hdr = skb_push(skb, sizeof(struct wmi_cmd_hdr));
 	hdr->command_id = cpu_to_be16(cmd);
-	hdr->seq_no = cpu_to_be16(++wmi->tx_seq_id);
+	/* Sequence number 0 means "no command pending", so never send it. */
+	if (++wmi->tx_seq_id == 0)
+		wmi->tx_seq_id = 1;
+	hdr->seq_no = cpu_to_be16(wmi->tx_seq_id);
 
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
 
@@ -311,6 +328,8 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 	wmi->cmd_rsp_buf = rsp_buf;
 	wmi->cmd_rsp_len = rsp_len;
 
+	/* Drop any completion left over from an earlier response. */
+	reinit_completion(&wmi->cmd_wait);
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
@@ -352,15 +371,19 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	}
 
 	ret = ath9k_wmi_cmd_issue(wmi, skb, cmd_id, cmd_len, rsp_buf, rsp_len);
-	if (ret)
+	if (ret) {
+		spin_lock_irqsave(&wmi->wmi_lock, flags);
+		ath9k_wmi_cmd_disarm(wmi);
+		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		goto out;
+	}
 
 	time_left = wait_for_completion_timeout(&wmi->cmd_wait, timeout);
 	if (!time_left) {
 		ath_dbg(common, WMI, "Timeout waiting for WMI command: %s\n",
 			wmi_cmd_to_name(cmd_id));
 		spin_lock_irqsave(&wmi->wmi_lock, flags);
-		wmi->last_seq_id = 0;
+		ath9k_wmi_cmd_disarm(wmi);
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		mutex_unlock(&wmi->op_mutex);
 		return -ETIMEDOUT;
-- 
2.43.0

