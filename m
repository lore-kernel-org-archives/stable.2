Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C8372ED3
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344499; cv=none; b=l7rPRd8XT5HJZTJoCLb/YcM794bJixpf0+YGRFfRgRQjzNDIvlgFI5zDOftRr7K3GUcyDuO60BGtWC/V2DUZseIxMyYLjHjWSICp72ruJOS5P94pfxfhsZ+KUxpkCNQehtOpzA3o20aD+rweWufM+VWWU5zn1BW89pzEhFv83Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344499; c=relaxed/simple;
	bh=PN0SQykzwIuDfzW7cM7x9d6iOw/F95MiQoWSfYFmBhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tqDRFioyZpqO9LMA4AC1tA+gLs4INu6rs1cn5P4VCFajLPkMY8tIaxlpKudsIYcOx3CrstZd5T25OEmjIj2yadNZ7ho+KqYn0VxvceMwRjzqtPQvtfXobBffOexXNn+XBIuxLTX93bGqeC9t5N0lvjEbIxlejhGiAu2pB6e8Zb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8WNoy0u; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8WNoy0u"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482e257a23aso679742f8f.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788344494; x=1788949294; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RyNaTqC+dGU5WjZ4HH9rH2GXhsS16BNv7gX+HI8+RH4=;
        b=A8WNoy0uVJwnW3LaN8FnwQtPyz7kK6JVqgatnLc0ZgTFOgkHclSNGBZTT/MGaN5aBv
         jJXSYGc2qXijkt/RuZBGHeI0GH4STWo6em2+i6C6/hXLTxB5viub7YP7/kMYHbYG+9RA
         pjgqj9l+jXHSJ1q/A2WGi2WBATLrzYPvVobeyTnIag9dmktRCK5IQfNrG+NvFFaWhtiQ
         o7AIqAw9SwiovOp95ZMQl11I8zyqgdOBc+bvR17K9n4nBzWTwyRZ2tzvzXctc5KcNjT5
         3w3ckbC5dYPt5mWCozVZpZKSBdJlPad+qcGPvYyGMKrUgMVOc/GcpId4zXL8w6sGcm+M
         aVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788344494; x=1788949294;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RyNaTqC+dGU5WjZ4HH9rH2GXhsS16BNv7gX+HI8+RH4=;
        b=owhP2nTyuoz80JGDczWIZo5tyoZmqCNU8TrFAsxv293F++G5RmG3Kf39JR341U1nl3
         Alr2gEf6GfxzqpoW2NUmKivx7j7dHU/BP4v1jplAiPN8an1YL/MKrhN0xdR83iTatNEd
         CuxefXfnhJYz+P2Boq5Uw4J/TrWHfa9gCJK7oEHJmA+NizlB7isYySsn30ga4671XUGX
         TErjQlzWXRKXIVJIDww0P3s0d6s8nL51MmmTGprqAaYYe8/lf0zh6Vtnpr6B+GnsmIeC
         TuNLNFlJxyPnxQU+/GBwIgfj9/mUVgO/W6TMJVY3AAyuHdv+MI1EQCZqbah6OuM9+GN/
         EIlA==
X-Gm-Message-State: AFuF++mWJbzJrsqNrd34o0C6z9OJzzKGVkHRiJC9sYKZw23RFPe3dtKt
	ny/tN+rVALAr54BNgON9kCBh8/ZMqNGuYeDhkmXEQNIcFU+slaRDhRtmuWdCuhz+juo=
X-Gm-Gg: AYBFou1t5rN2nBL8VFt85dxRJrAzZJ2rwOfm4wolGw7XaF8URzZVux2fbhAZS5zowQ3
	4C/CDmuOOe3l1sW+XsdyS6IH4k5x/uYzAaj1gN679B/6bxItMneREwic1+jFH6e2CbaUNSQhHly
	qhGPMzT8SE1h3PtxstMJruTbM14sotWiTz4umzTks1FAyUFJGvTBrivLxS3kuu64dwxvWaH+auT
	hXZSii28peOOApXH2pgt8sfaoRpmqOY3b5GxytX4VbAUOJkO6tWrNzs3UXhjQIvJQ3AVqH/w85i
	tzY+DM2p2LbfJcIFIV9Tig0bRvyQssYYcTJHwNNHsK8eL2sxT8eFdE/vE9nr7T9sz/+eFGS3HNQ
	O7C6p0CvZXy4RkLxtDOvtsUyZGta9p7OK6PfF7w5N0y/WsCP0G5Mudb0IzlAsRhKb4Ke6EZmizJ
	8xK2sdkIfvPEMR1v3ItU3ibqg0rSEFHWkL25IEAYnpxpCSBu11+tDqSuaNfV2v9QInXiHgjMRW7
	s8OvwN4apjWsBoUUVgYIiOgVWfQyR7fvA==
X-Received: by 2002:a05:6000:4698:b0:485:4277:fbab with SMTP id ffacd0b85a97d-4854277fc83mr3594765f8f.27.1788344493846;
        Wed, 02 Sep 2026 03:21:33 -0700 (PDT)
Received: from valmpani.valmpani ([2a02:587:f24:b00:967a:9200:4108:5b68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdbfbsm5485625f8f.33.2026.09.02.03.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 03:21:33 -0700 (PDT)
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Date: Wed, 02 Sep 2026 12:21:19 +0200
Subject: [PATCH] ihex: Fix 16 bit truncation in ihex_binrec_size()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ihex-v1-1-67fdbf8d97ff@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJ74l2oC/yXMyw5AMBSE4VeRs9akzqIuryIWyuBYIC3SRLy7Y
 vkl/8xFHk7gqUoucjjFy7pEZGlC3dQuI5T00cSajS41K5kQlGFrCpuDbQuK6eYwSPhu6ua3P+y
 Mbn+3dN8PutCOp2gAAAA=
X-Change-ID: 20260902-ihex-62b68b7e2bae
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Vasileios Almpanis <vasilisalmpanis@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344492; l=1905;
 i=vasilisalmpanis@gmail.com; s=20260731; h=from:subject:message-id;
 bh=PN0SQykzwIuDfzW7cM7x9d6iOw/F95MiQoWSfYFmBhc=;
 b=7erELQ4frAoctqDjCU/gaAu4a4a4lUMXAJuFpt7OJYsRYu05Yi9tqSjwxwMVXn9UUIOrI+pMK
 bC9tpR4iQwjAoHvaXbK/7xE0aNNRFgQnb6qy6HlWuKngX9XfBtQxPCf
X-Developer-Key: i=vasilisalmpanis@gmail.com; a=ed25519;
 pk=gn5Uo6yL8Tlpq5uATxA3nqoq+U8eWLRbjD+bOk0qSpU=

ihex_binrec_size() returns uint16_t while computing be16_to_cpu(p->len) +
sizeof(struct ihex_binrec), so record lengths of 65530 and above wrap.
__ihex_next_binrec() uses the result as the offset to the next record. A
length of 65530 gives an advance of zero, so ihex_validate_fw() spins on
the same record forever. Lengths of 65531 to 65535 advance by 4 or 8
instead of 65544, so a 14 byte image passes validation while its first
record claims 65535 bytes of payload. emi26_load_firmware() passes it to
emi26_writememory(), which kmemdup()s 65535 bytes out of a 14 byte buffer
producing the following splat:

  BUG: KASAN: vmalloc-out-of-bounds in kmemdup_noprof+0x3b/0x50
  Read of size 65535 at addr ffffc90000075006 by task kworker/11:1/174
  Workqueue: usb_hub_wq hub_event
  Call Trace:
   <TASK>
   kasan_check_range+0x10f/0x1e0
   __asan_memcpy+0x23/0x60
   kmemdup_noprof+0x3b/0x50
   emi26_writememory+0x29/0xd0
   emi26_probe+0x2d1/0xb64

Return size_t so neither the addition nor the following ALIGN() can wrap.

Fixes: 9fb4ab4d3dd6 ("ihex: Simplify next record offset calculation")
Cc: stable@vger.kernel.org
Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
---
 include/linux/ihex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ihex.h b/include/linux/ihex.h
index b824877e6d1b..0da1c4e3e693 100644
--- a/include/linux/ihex.h
+++ b/include/linux/ihex.h
@@ -21,7 +21,7 @@ struct ihex_binrec {
 	uint8_t data[];
 } __attribute__((packed));
 
-static inline uint16_t ihex_binrec_size(const struct ihex_binrec *p)
+static inline size_t ihex_binrec_size(const struct ihex_binrec *p)
 {
 	return be16_to_cpu(p->len) + sizeof(*p);
 }

---
base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
change-id: 20260902-ihex-62b68b7e2bae

Best regards,
--  
Vasileios Almpanis <vasilisalmpanis@gmail.com>

