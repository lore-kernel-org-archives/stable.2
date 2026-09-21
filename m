Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729C43E08D
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976532; cv=none; b=SCjshpDihG8DzKJtmPp8mDrtfEkBmL+t/pcEg5+5PLEAg0NxX7Yk/pCYnT272F0ucDx7PkulqcnkcckkBlVU+3oFCz/j/CTBodxVLCsN74Q8SSdZwEdhLfXgpYbTf5G+qVtZwDW+ABWsf8NDynPGRjEGmeTwxBhxzcZarjIQdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976532; c=relaxed/simple;
	bh=+PxWiJGd3qQeg3qY9tqhXy5GvpqL3o3G+lizbAofHcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgT8A3ttYMp4LrecqliVRkhb23V3YWaRCzeHA8fs6fH1V0LeP2vnloiiBO3UFUFpH+APVm+4uEK5YWesax24iWzfwd/NUMMO6gAYDwJNkl3nhblIq2dEOijSkKZZa8n7mEUtFbVpwXXK9yK5W9M8+aka+ewxahs9KeZ0WoXu+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtIfeI5A; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtIfeI5A"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b355ffso1558769b3a.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976529; x=1790581329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHgcYtuYemojMdrCO9G6C1IAVKzr+T0NM2HjgpZp/nc=;
        b=qtIfeI5An/RpD16yzxCT1Sak7grlDcQirLRhUl+uXA4hCdgX1i7mKrpnzOFy5GE9NJ
         RktAx2RAXnQqqzMZCbNQ+T0yTTce9MmmGrp60VIcqKKflKepAHm3D3TiuvvAFhl+b9XN
         /eNaY0ZfsR2aff/1vDG0Ylq3eEQ/5jnKdHH8LZ+vFuQoz4Q3pQetRAvL8AyBj09vS9VV
         kCDtsbeO7ikh3JqnZ/i88YkrZzkVMDLMRGoMUw6eK2e70QjbKh54Mlg7XbPfbQQdoHPE
         h/xkA7YDYNMe4MkuaONiJgKpXX+136teBj2PAcNbVkglT2TWilmFb4TSivmvVuAKPtnT
         Jzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976529; x=1790581329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EHgcYtuYemojMdrCO9G6C1IAVKzr+T0NM2HjgpZp/nc=;
        b=sVcDA+AA6wcy61GAUVOSa4mjwlhuIL2GDmgDu7oXszOTkFa3FtNyVftga4aoypy0X2
         6JaRK1NBXF9GaVst5dh12haUDxB+AbGIaYLI2tGKWAXOdrKmVjIlrxLklHCOvURO4dr1
         iPcWP/SfOLmMJJVxx+JS62n7nyAUq3/QVHZ09jxM4+fDtDzaC/kRW1WWo6X2FN0JmA9s
         dv2Lpcz4qIXld12lb5wiNXmBwtT17AubPRLd8FjZz2G3g0+Bb+yHg6iw6lZxJ9n9MmyN
         DMqZoqbIJ303D4/oPoihwTdXk01popuckFPEZZ0+26aJxai64op4tNx1FK8sNbNTwjhd
         X3sQ==
X-Forwarded-Encrypted: i=1; AKwUvBywsPo6N6ySCwoM+CtxPlwm10FZz7X/wENQa3Ye0noeAkWTHqAciwvUcLGbWZltpJyxkJPlPwI=@vger.kernel.org
X-Gm-Message-State: AFuF++mY0/yvBMn+r73Ma4jtquTnZbZ5IEIXOCLp0hNLREyO1PP1RUV/
	QQTrT4mgfIarHrXn9cgwFqXaO5BbHLrYDCK1+ww5Rm8wAVCGD67NgIGD
X-Gm-Gg: AYBFou1EXemgQxy817tXyAVO1+rBCtu++7ASOHTJoU9ceIxsuZ6BoJzUaO6GmUmHHzt
	hbNcBaF7/LfnYgsnJF9vVMvKG69maAWJytCLuwdFFDfWGnFGzMRu8fwfBELReFh+zyiYAAqzASd
	u/D8uPeum1J6lXUgfcrnkM+0edw76Iqz5dtK7dqCSSn8jL4q9BZXovhHG8kZS1/UlPNK+0VC5Ai
	5tifzHSlBEFGYTSe2oRN4UcH5abT/WaD5Ycumoyo0goyC+1AE8j8QcOayHaigxUa6XCZwMqtueM
	w/oQve68aA5yjeYtEhMThbj7ge9numXlSaT+JRQf1pLl61orGz/NjAy3eOyDXAy/kasJ37NLSQY
	6IjSWt0CfoCM3vKwNQhLI+1LMEWgvUNs587gH9XWfNt/it86sENSPpu5udP8kJW+JNa2SQhuSGW
	FshpZBrI1aeUMN8i15QijQxMwH3+uRAOuQlbB3kSS54CoYfilP0U6/2GDCH9XsqI9PPwGeOOasK
	yEx2TIrWBgfeoIHanAGom18vDgR2GLk9s3pwT/50BZTRH/mypAnN2JCiYO+3FvL9+fTnq/p7n+K
	ZPc5adIYIQ==
X-Received: by 2002:a05:6a20:9c8c:b0:3dd:85a9:559d with SMTP id adf61e73a8af0-3dd8c57fe0emr17599249637.31.1789976529153;
        Mon, 21 Sep 2026 00:42:09 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm3048650a12.6.2026.09.21.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:08 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/4] ieee802154: mcr20a: drop corrupted RX frames instead of reading 125 stale bytes
Date: Mon, 21 Sep 2026 07:42:06 +0000
Message-ID: <20260921074207.2289391-3-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213639.3316625-1-benquike@gmail.com>
References: <20260919213639.3316625-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mcr20a_handle_rx_read_buf_complete(), when
!ieee802154_is_valid_psdu_len(len) is true, the driver overwrites len
with IEEE802154_MTU (127) and copies 125 bytes from lp->rx_buf into a new
skb even though only the original len bytes were transferred over SPI,
reading past the valid RX data and leaking up to 125 bytes of stale heap
memory to the network stack:

  BUG: KASAN: slab-out-of-bounds in mcr20a_handle_rx_read_buf_complete.constprop.0+0x91/0xc0
  Read of size 125 at addr ffff888002853f40 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x23/0x60
   mcr20a_handle_rx_read_buf_complete.constprop.0+0x91/0xc0
  ...
  The buggy address belongs to the object at ffff888002853f40
   which belongs to the cache kmalloc-8 of size 8
  The buggy address is located 0 bytes inside of
   allocated 4-byte region [ffff888002853f40, ffff888002853f44)

Drop the corrupted frame, re-arm reception via mcr20a_request_rx(lp), and
return early.

Tested in QEMU with KASAN enabled by passing a corrupted 4-byte RX frame
length to mcr20a_handle_rx_read_buf_complete().

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 3/4 covering only the mcr20a RX corrupted frame
  handling as requested by Miquel Raynal.

 drivers/net/ieee802154/mcr20a.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 020d392a98b6..d01b277d33d2 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -790,7 +790,8 @@ mcr20a_handle_rx_read_buf_complete(void *context)
 
 	if (!ieee802154_is_valid_psdu_len(len)) {
 		dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
-		len = IEEE802154_MTU;
+		mcr20a_request_rx(lp);
+		return;
 	}
 
 	len = len - 2;  /* get rid of frame check field */
-- 
2.47.3
