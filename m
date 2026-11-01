Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793566695;
	b=zJviYd01fADSpyoNes2tMAIOTkR7lxD5mvZYANjFeYrymfZtB9ALVzBvroQ6C5W3/W0p
	 u/2Q7QPAVtA0aNX7tmVheHlwKvWIE8RT5gpmpy9DUtjzD9XNX8kij8E8kA1ZcXfp4jFqr
	 X0Uma61rmNuv2BFalR0wj8IZgVCctBT41KVWVPeC5vD6vj0XxQnElKcSE6JgsBF3Co4/j
	 PVJQmGEMSPHFnoAAXcMMGVoPSkh/Km3H9a6OuqAdwtFph0A2j0TOaG0Px/5BxwkV/Mh00
	 nsYPoZUArscBCREJ35HPKSHmmapxTO9Mfny8hsZVuVLD25t7zAxMqvOyAJAzct5U5CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793566695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5YZdVqt9El4/LjkqbBF/qbEkQUH1givqEV/QNHg9rPQ=;
	b=KqdszWJtxIzvhSHriBdkL2SXoDAQ02W8JSmD/5J/8E/hBo5JSWBqW77/R7C9ZuQaVT3D
	 Dm5MQzmqq3iGC2391+MW7KdKRqw5qczpbLunqa8Ih06wjOgaNaGUYGB7OKWZcAEriYiX/
	 inJpUy/pEdMCqiwQwE4KwOMxqvM+R4hn0hIFMlMr5gcyR8FNckBKc9axYTUur4vQJcdM/
	 k6Vm1nrFU58rPr0j5PRlEihntx3dEWDFUahJLtKPWOD1mfd7tnL6YJzcyR1RS0jYiMl6h
	 K8l4zGS0aKi/oJMJudNwJvf0UhjZTS4XuRozopNIZUQAlfx45Gg+DEkPJrjTqMNm27g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=li1hA54t;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D7606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 20:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F6D7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=li1hA54t
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso27404445e9.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 12:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793566694; x=1794171494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5YZdVqt9El4/LjkqbBF/qbEkQUH1givqEV/QNHg9rPQ=;
        b=li1hA54t772AfCwaUmbOU/09wYLHdi0laF1xPX2Cf+pZ6owDoSWL8fXAyK7GSzCfIS
         KM1Kx/xGGMOjw1tpJZVO7BkMSOtAECuuP9YzZHfUJEnR4lCVkD07wcL8FCMLYWByZhHe
         DS6l7C5ooZdFgSSOXMeP5dNuRXa0tmK+TDm6t2oWpr2JXdvDlJhMkUWN/AZZ6V2Rq2HU
         CzYgKxtIzAElmQoUCTk3wH24qRxVUzv6BVv37tPOfXmkKTeJnKPYN68aeyxQMePlFc9y
         FwbkVpH7Y8s7FWy6zCQVfczWn3RpQHYPktACx0XzD9NNfYCU+rnd2o23XAMokkQAzyeI
         5Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793566694; x=1794171494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5YZdVqt9El4/LjkqbBF/qbEkQUH1givqEV/QNHg9rPQ=;
        b=rvn51VMbKeBp1ExJtcOZ4EHrII3mNAD8J8BfWWeEDGxiNhmdrqHo/muJqVq8IWx8MH
         vAJiEd01BoY+2NPGOEqG3K3sJKJvQKL8R0TP1cEfClMSea1s5u2rXnqiTAeIRK9JR07T
         gV7I1t/Ri72nuBItTAtddjDK85/CsBp4ec+aGKmYSKhCQOD4b4Wow7nTQE+nNgUVmAzb
         ilndj/LXkcpVHKXiJ5KK63FoZ5AXhru5oUV4eX/cCGm8KEiU7IBD6QymMD0I6I6f7u1x
         PQ9iUg78tm8DISjSRpAx0Otuid2S43iq+R0+oZLeb9N9fJ42bryFWwgJY+/2pqMhyuyb
         7Hqw==
X-Forwarded-Encrypted: i=1; AKwUvByzeQ9LtqwcZjrY37uXI2iFtHoQA1wKgVQw1hO5VLdHclznWlrhfDw0Zy6eTk+WhqoACbf679k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKf3ADI/Xov8fQNlcABJG54XAS3HjSxUcYDKKsSsuIgSRQAtT4L
	zGAGfMUaDt/zqxq9WJiKVqm3INxyWJrgWUuLm27SuBaPI4KXrydWfDs=
X-Gm-Gg: AYBFou1iCw98cx3C5oibNhCkwpZFs6E1/zFgrPblfSOuJQHuQ2G8R82VlqfD2oDVWoo
	uNVzCJ1HTtQckH+6LqBXthwnYFGTYNFkaksks7J2Fopf71+DMAT/5K/bUMybayPJgNzZH0AOPiK
	eEgF8s7kqT3wr8dN3bBFRRlCRAdyD0dqNT2uLU3PZ4Uj0CcbCfjA8L3IsVYtDexK0kJVbLeN/bx
	JZFW6/scdDdMnSWvGBXPx8GVoiqUNfRgcbhrhavydKRq1L1T61wfnWN0P67Ia5obd0Eexg0oW3C
	d/9qb2H/rBwQBoh3RDlJk45iu3txbCpJIFQ+Oa3d/7tdhGGySEc/EXtqgAobjf/D0yxKBNqdEwf
	X9Pg+0Ck9t4UwQ15XwUNrqe8Q/ZbSvB8frTHsXAOx2J+Zf045K8r+vQce0NzP/JDA95Gr6B/Ixm
	3C+rAW2nRkQA0/mrq/GFaB+DehTTOuOLCCmBss+BgY4dLF8XdIv9U7/Zisj2Y317ARanUEkm7n1
	gi49MQG78dhPMvfRtds+7MWACm+3k4hc249m9Y4PBm2zcU9K5/nb319Z6GKC/0c5+0EZDjKgA==
X-Received: by 2002:a05:600c:a107:b0:4af:e04f:cbaa with SMTP id 5b1f17b1804b1-4afe04fcd89mr44737415e9.29.1793566693776;
        Sun, 01 Nov 2026 12:58:13 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9eaeesm16002280f8f.49.2026.11.01.12.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:58:11 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 2/3] wifi: mwifiex: validate intf_num in multichannel event handler
Date: Sun,  1 Nov 2026 20:58:01 +0000
Message-ID: <20261101205802.2909524-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101205802.2909524-1-tristmd@gmail.com>
References: <20261101205802.2909524-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

The intf_num field from the multichannel group info TLV indexes the
flexible array bss_type_numlist[] without checking whether it fits
the TLV data. An intf_num larger than the available data causes reads
past the TLV boundary.

Add a check that intf_num does not exceed the number of entries that
fit in the TLV data.

Fixes: 8d6b538a5eac ("mwifiex: handle multichannel event")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index fecd88967ceb84..1f746e8f6b3e18 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -450,6 +450,10 @@ void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
 
 		grp_info = (struct mwifiex_ie_types_mc_group_info *)tlv;
 		intf_num = grp_info->intf_num;
+		if (tlv_len < sizeof(*grp_info) - sizeof(grp_info->header) ||
+		    intf_num > tlv_len - (sizeof(*grp_info) - sizeof(grp_info->header)))
+			break;
+
 		for (i = 0; i < intf_num; i++) {
 			bss_type = grp_info->bss_type_numlist[i] >> 4;
 			bss_num = grp_info->bss_type_numlist[i] & BSS_NUM_MASK;
-- 
2.47.3

