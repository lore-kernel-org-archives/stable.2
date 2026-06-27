Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338D3A59BC
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782566000; cv=none; b=A/MrH8NK5e4uiGtcuzZI2C7LM66fmI2wy+vsOUE5nbHXA3thOVUdgb5R2YwzeFjviFwVqZvvBP47LTrL6CinTIPkU+gBCmOzjL2PBQc/4trW55eZHFaeDRZymYVe4G7PUiw6g7mcDLc0/lkkrYJsIZybN7Pazbowp6KZiaRZkTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782566000; c=relaxed/simple;
	bh=f2ywcAbauLIdDjioz7BzOI400RSnqiFwtqHAuTE1ASM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WYGLITjuMY7rKQqEQQ2sznhc/x7o6uRwhYTE729ZdH2Y3H9PCIAaK4IkhipyMuci+DTSVWz3RM0erLcKn992wNOt40duFFJ5jBpjADY3X/HPsteDt4uHeUT63Fy6vRpQ3QxNTs4aDXBL90mM+CDhYXLMO3cFjKrg97n2bhUTJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr3weZJr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr3weZJr"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37e0a189b0bso926379a91.1
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782565999; x=1783170799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffzVDWTdghBqGnNg+yPYLtmRZ4dadK7EfCKOcmYolsQ=;
        b=Cr3weZJrMKarV5gFKU/2wS7rVvRN4rBYWtaDggoTVx/0xzmEO7ljZppfS0yM8JwQ+v
         5L3zZmuKC1/T0G/owBlXzek5Q+pm7et33uwibrGc8XwS9jOUoGd5y5Fmt88R9tU9WDrQ
         Zd/ZdX9RM/HI1M05XV73mdupsLJdiSEGP5IErFzd19QaHtFjJidwdOCYWOvHGUUR1PZp
         a63txWNAtZE9BXfTKHlkFaOqJQcpebOWLLKiDBwa6KFxzz4eWoXQ8F8ptyYxS/jeH83d
         e8ITR31eQ5Q9XHjCKVujnuTf6BBXpQqY25hTwsb48ldpv2yFevt6+FmmlJGLF9h5z7Hn
         2FJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782565999; x=1783170799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffzVDWTdghBqGnNg+yPYLtmRZ4dadK7EfCKOcmYolsQ=;
        b=AsROgxrZMTNVkcZ9ODXGsoWa0sBuxT2LN3pbEhOKN8+pu05nEMt9/QulfdKPjlS/4L
         zQ3Y4KW7HmH+Ly6lB2iGdcP/TDqnzAVaoM0S1eISiBv9H6+lv80bH/M3rxEkIJsfSXfh
         g962JYVS7RdpRq3TWKBi6EYmlVFTaMYaNzixD/TI9x9I7GTLTr1Zi0gghP+UQT/na7WD
         4c72AsuCYfRL0WZ8wi85MW4AA0DfYgoLmSwg4X85mGQG0AO1QVzW2nWqgXg1pptdVrW2
         MzbToz4lPLnLoSC9eqMDyT/YzGzOYo8XngVFcyEA8H9JCWIpupy99Bu5T+SaVLdVVqQw
         yiHg==
X-Forwarded-Encrypted: i=1; AHgh+Roag0Iz6xGrI1YKyxROv2H972+3jrTyXy67w5WMNrayUFqbuXREgMlJvUSdS1hMIQyv+/nwnBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrw+2z3vJ1lv+PiB/mpUQ+cd0TPDnPaFokTBRz91Soev8b58dF
	nWpiDqinAQZalAvjK7vvxYcg3YxdNPeI2F7zOA8+PyryrlZtw99kQWdn
X-Gm-Gg: AfdE7cmYDaLR6ggMculgQ2aTenxOhbvk4wdBDMa+GEPX3vf4rSs3H0gtMy5wnC5IZdq
	mK0U0IaKZPX+kjxoRkSlelcQcZPIM1BMgPr8FLY6oqSlu154lkfCQShyQLskTwZAodq9U6VLs82
	AgG+KSG0G2geA9HtFK6eV0IIfLpOOJfxqJZE3Wo/L021BszhSp69fTCDyE58cVNY85pc7i99nig
	4Xr8EujygIzbliyXqwBD6OaPA5e05naJXLoDr4Lz1MnM8+zH58W/GOBusILGHcbSBazUg+MYMnh
	jjAS/QjM+X6Y37obKBMEWSt9E9a5Ho69Dy4gcmJGHR3yvc0uNIte//BzVQuJx1l+dypNh82ZjqK
	DxOlQ35h0Xe5WQE4qJTYL1R/NP5daWvL/T1WKNVwMBrIFFJEW/J6vGH7GhFPXQBN9U+tHH+YF5F
	BMIWFRMf3TxiG/FbHU1nXR/Y6Wm7HzMzi09RY7V506c+J40cTY
X-Received: by 2002:a17:90b:2244:b0:37f:df85:272f with SMTP id 98e67ed59e1d1-37fdf853de2mr240302a91.19.1782565998696;
        Sat, 27 Jun 2026 06:13:18 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e1c93272fsm2598840a91.14.2026.06.27.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 06:13:17 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Kaixuan Li <kaixuan.li@ntu.edu.sg>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: cyw: fix heap overflow on a short auth frame
Date: Sat, 27 Jun 2026 21:13:13 +0800
Message-Id: <20260627131313.3878893-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brcmf_notify_auth_frame_rx() takes the frame length from the firmware
event and copies the frame body with the management header offset
subtracted:

	u32 mgmt_frame_len = e->datalen - sizeof(struct brcmf_rx_mgmt_data);
	...
	memcpy(&mgmt_frame->u, frame,
	       mgmt_frame_len - offsetof(struct ieee80211_mgmt, u));

The only length check is e->datalen >= sizeof(*rxframe), so mgmt_frame_len
can be anything from 0 up. offsetof(struct ieee80211_mgmt, u) is 24. When
mgmt_frame_len is below that, the subtraction wraps as an unsigned value to
a huge length. The memcpy then runs far past the kzalloc'd buffer. A
malicious or malfunctioning AP can make the frame short during the
external SAE auth exchange, so this is a remotely triggered heap overflow.

Reject frames shorter than the management header offset before the copy.

Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
Link: https://lore.kernel.org/r/178214417708.2368577.16740907093694208834@maoyixie.com
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index ce09d44fa73cf..873754be5174b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -293,6 +293,12 @@ brcmf_notify_auth_frame_rx(struct brcmf_if *ifp,
 		return -EINVAL;
 	}

+	if (mgmt_frame_len < offsetof(struct ieee80211_mgmt, u)) {
+		bphy_err(drvr, "Event %s (%d) frame too small. Ignore\n",
+			 brcmf_fweh_event_name(e->event_code), e->event_code);
+		return -EINVAL;
+	}
+
 	wdev = &ifp->vif->wdev;
 	WARN_ON(!wdev);

