Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509880;
	b=XKNyXfKDoeaglzRtSWZCgShPnk+PJYqjsN76zQY9UmCotVPcqWaQS6DcN5+v+pcMKruI
	 5yXn9IURt9i+XSUBiROAp5jBfj584V2ivtJXXGnBxEmYWNH0QcnpDbJq9mTglYN99n4w2
	 WUy3Wu9sUroCuTSXS7DEkPGDh+ebgl3qr+ATYhkGVHtJKnWVAZlCsquivGgLZBQg6yhn4
	 sSbqOsTNv7f4gZhXApmCzitb8RFlmqUOCj9TKZOTy0FMMXFSOI39WJUk4WzmaKFgmH+eF
	 juNO3d4x0Qnr2+XJFCIXl+HDvU3FQ0JRjOKBbY7wmO3IH/In8n0NoSH3wZ2xTJ4scAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FFKFYTGpTq110qX3OBusAjjcUsko+0b14MxACIod3aE=;
	b=hsfe0ab0Doo/LFrPUDuLXztmv9Zu9+6KZIaMFNiqwpQHLirsDbgGBPOv8XZ5IPNUaxy0
	 nYra04hVVNwLDdgB3FqaV+yahZKrcUD/5UA3omGApLCoRMwPcWqbnjivpnnzFZyIBY+Bx
	 Hh9otMFwsfJOgyxK1YOZQYGniZALqpeMduCCuqnfBs733c8Xzksgj1GSIyuwcXkbE2prw
	 pO7SI6MrvBGEghXLH8J1YtegNTV7Ez/XC4XRIimH/XChZdlXRcj3gsQEycsYORFWsu9Gz
	 qYNj2Z5Ge5AkxSLl8UGIsV/UgfPkU1uiG+cf30USqGregi1HDiWrejniEqoNL+/YGbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VlqAK4+O;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A0606A334
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D31A0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VlqAK4+O
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c40e30c26a4so130817566b.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509878; x=1793114678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FFKFYTGpTq110qX3OBusAjjcUsko+0b14MxACIod3aE=;
        b=VlqAK4+O4fAoKvoSRcPhhIDlfI6ZETlAY1GhZGMpDgijp3VIjQBeYdZuvyteCw8E4O
         853q8UMeEao9ukn5oQwcsp3eowxyyzyoErFlCdXzlxweUWWBDJxJgFT9id2as/FHfuPs
         /dqRQLeo/+nY7v0F1DW8Y2HJA8B81gjWdXN6TNBYQi4kVT8cYSGTddJok78G18DXME3i
         fMqXM0C9yFsx2O0PbdeNgsvtyqwJjvLLGmjMaDAzeYqJM2KvYWT4e2qEdzW8ZEXFOX7y
         hU5r5JUNqRH9lQT4pfeEfvZVVCYrDOd7vdrTNwL7bSRcwEVeTNtof7rzFxu/LfOxVLRQ
         8/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509878; x=1793114678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FFKFYTGpTq110qX3OBusAjjcUsko+0b14MxACIod3aE=;
        b=ZuJ1FxtnUzyo84JXHyzhwTxla4NazPdecoP4rAZjKLuMypgrv30NtcWkaCvuNaIGDQ
         vruPludFFIDn5TXQgh9a5vWpcFoWu88ODKvPARq8VbBiVNNo2rZTE/wDuHaMYRForMXS
         Unjof7ZivtD7wPjUKlXJJ1yhIwheJ7GrpeB8bG08OiMXpqWh4phR9byj206A8sEkLBA8
         JRa3rADfst4B1VoYu6iaPVEkYyMNcPHdfJCQjhsiMNIwzquyxn34p92E8aUbAphWJ9Ud
         NzQ4hK/LSPbYQ/67laeXjUtim5r7zRmYtcmdiFpTJeapbK0D6urjs2XMlyd4VVXQQDYY
         9UUw==
X-Forwarded-Encrypted: i=1; AKwUvBy+lfLgpzm9MKer8NvMz9m+natxnlauL+DAu7BcOYOD34uwsyUS47f1VTRuEXVdiw+VQlkKSbE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiF1Ti2sCmGMV+gPYVkKJZjQrQGsyTu9nzFvR1o93BKV7HRmnA
	h0pm9R8bYtIHR339Bf8YxSL6jh5PTtNzMq36oxUQII2pzsJd0ZGDNJIh
X-Gm-Gg: AYBFou20kTgiZl5gjmyrq9yf0vOc5dETUSmoBL1F/uKUtWM/NHZZ1s48fzujGDPoenA
	tEj0gnnKCTbb7THkIW5xbscVQlvosP2F3hUaHfirIMeIr16qUNCiTKuiQQf01NgYGZj0lcPYi1T
	wLj5diynBSka23kUovYykD2yiSQ3TP5Yu8BYlnpjZLzc3IUrmEkmwSrCulvvS8oH7l6mAZCBWB/
	XdhHbzgONnwoknLJW6BDWZDtj9RcLhE0cjnbNGPs+rM/435sDwznc7BBOkIsbsZ+9VuJLMkROZw
	SY9FGZRxXwb2Z0Xf6tHmRiOArHmKtBqss5TD/bMdqqeKcNIMNcdVHVbaAuJr/BRuqif3hV+f/lL
	bj7panDsJ2b3L/jX94XyRCc9aEDG2Zg476QfjsR8WTSrbVgy3NyUnlAfwsLv7YvbRyuzfxdTwlq
	FJmvnctnsCfr+r3Pp0stHvRmo1VGbuIjx09ekI7UNx5MI+2rWYBK9vQZOhiIDdziHnZBUaWCl4F
	OIBNKd6RMGHHU/v7E70ExUJFXaVgxrUyILhtd3hjWYaRMQ/kEMPTUB8FKojmvL6l7oUqBZ96Yut
	99495W5NkUfqIFGdYLrU1j4PWgFhSKnssw==
X-Received: by 2002:a17:907:60d6:b0:c2e:616b:6763 with SMTP id a640c23a62f3a-c4600c87ff6mr231572266b.3.1792509877921;
        Tue, 20 Oct 2026 08:24:37 -0700 (PDT)
Received: from Martyna-s-A34.localdomain (ip-80-113-116-3.ip.prioritytelecom.net. [80.113.116.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919bcfc5sm488110466b.59.2026.10.20.08.24.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 08:24:37 -0700 (PDT)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Mehmet Fide <mehmet.fide@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: ath9k: don't read past short WMI command responses
Date: Tue, 20 Oct 2026 17:24:11 +0200
Message-ID: <20261020152412.95560-2-mike.michalo@gmail.com>
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

ath9k_wmi_rsp_callback() copies cmd_rsp_len bytes from the response
without checking how many bytes the device sent. A short or empty
response makes it copy stale bytes from the uninitialised USB REG_IN
buffer into the caller's buffer, e.g. into the value returned by
ath9k_regread().

Commit 93ce8ea70451 ("wifi: ath9k: reject short WMI command responses")
failed such responses with -EMSGSIZE, but AR9271 firmware answers
commands that return nothing with an empty response, so that broke
normal operation and was reverted by commit 90201351a862 ("wifi: atk9k:
Revert "wifi: ath9k: reject short WMI command responses"").

Copy only the bytes that were received and zero the rest of the
caller's buffer instead. Empty responses keep completing successfully,
and callers no longer see bytes the device never sent.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 drivers/net/wireless/ath/ath9k/wmi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 44e91815a1..76c8dfcc53 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -204,10 +204,20 @@ void ath9k_fatal_work(struct work_struct *work)
 
 static void ath9k_wmi_rsp_callback(struct wmi *wmi, struct sk_buff *skb)
 {
+	u32 len;
+
 	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
 
-	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0)
-		memcpy(wmi->cmd_rsp_buf, skb->data, wmi->cmd_rsp_len);
+	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0) {
+		/*
+		 * The firmware may send a shorter (even empty) response than
+		 * the caller's buffer, e.g. for commands that return nothing.
+		 * Copy only what was received and zero the rest.
+		 */
+		len = min(skb->len, wmi->cmd_rsp_len);
+		memcpy(wmi->cmd_rsp_buf, skb->data, len);
+		memset(wmi->cmd_rsp_buf + len, 0, wmi->cmd_rsp_len - len);
+	}
 
 	complete(&wmi->cmd_wait);
 }
-- 
2.43.0

