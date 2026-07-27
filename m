Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5E3112C1
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161461; cv=none; b=QO4Hsji+K5AHv9wq3Lrgcftokzld07DjBo/ei+MCgS+RRkXmf08DywJ5iW3gsBlH86aJ9nDuo/0PHZRtnGlORlIxrriGAS3SAFPhEizcASqURa2KVAxseeOgUiBgxPBendS8NnNKRp49hfmaOFLmJhjuQJpgMp2jnXQnYrkSKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161461; c=relaxed/simple;
	bh=w0biXA0HLMaE0DezgU366+Ns1p9XHjVtdkHdkg0WOKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZPdhQWnS1vKWeKaZYUxNtJT/k6IVCqNzjxc7I62wxu03OXySgZ4LAnLFAhOIkc35FholUQhQQ7BQAeizRXoph7oVM171dcu0+GTI78zZnXsbEpF91TI/WVQ+cQgICVQMGkFaQQNjPDZY3qY51sj7zETsAJlo3ZK1PnoFGZo9EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMZSZ9ID; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMZSZ9ID"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848479c9bd5so2028681b3a.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785161459; x=1785766259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GR/NPYCKdy92MVRtCFe0uP6S+YfIAja5g4snz52YFsw=;
        b=nMZSZ9IDwIwLlfifhPRqrAZB+ziS0FMaY2oMEEiZJC3Ul/u6+KBRoKdwqVgA0/RDoY
         94fDcEVe7A65fRA6Hp9MWj4hWkUVAoEAtIz2FATNQ2k6kpvIK2DttJ6lLeLVgc9JvpNo
         DnV1Lso0A2fyQmiTgfjP2f+WLCODYaKIDS0eE1eRKsS3tCwMGhuD7UF3sJ3TtuFdTysR
         z0JrTGvfi5F6gc3v2c3n0Nx52+Wa3q6Hc8qBE2j2hdmIMEyZF/VNGz9tLp6+kVxBbObx
         C8t/u5kE+chrfbxaYYCHVl5NbWd0dTgjmxoz+MW0d6Ot1g0YDL4hUqTp4Us7RtyLVa7E
         aZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161459; x=1785766259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GR/NPYCKdy92MVRtCFe0uP6S+YfIAja5g4snz52YFsw=;
        b=g8kXBH0mfwv7/660/ru3gbuhu+PYl3t4yLExkNiAADSRfvdcKsKoBgMl6g4NPVXz0V
         TpEu6b6w0byejQDGzd3naNS1m+qZkT/ca6H0ItVTng0H40NkCelFCHUrordK5GtiYwnc
         wAQQ03zhFJZPlRyCAVZHBIJ1tsoAcNt26zjwK0BLgZY7M+YAXaJbo92F08tMFphmjgT/
         UTZiNNFbCoHteRhWmxrP22UEW0S1cp23fBSjwQzHKuZndQ/1F6gYbFa1onticON6Ihyq
         /j06ODuK9ljlB3MFKg2kFKQPIuFwg/Z9OGW7SyWWJUpWnCM9Hkrk9xiJdg/hv/x1NrXK
         MFLg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0sEoDeIr/x61Tfpj0hjeo4j2gU86hTBeNe8KArKu1ZjFilhyFtqgX+Kklq05rnLKATiiPCUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNYM7deEvqg98Z/q6DoND0FRjsEPGGNXZOyd/JSA/791UwWZH
	t5DE6OVmFrbMPo4d4JK7ov3oNJ1mSrndlah2BoF7tYhbZvqrKI5ezDw=
X-Gm-Gg: AR+sD12xzzRxZ1qReMPwMPPOj1mV/Xm5FqYpOUksph7HOLmLYAc8gBktSn26s8XWC/B
	Qkyy3COVmJgUsmxd81iijkES9+mBDT9BdkIS3i5Y26WbyiFeDgV8i/adFSMqb7vo1HHLd6ld/wP
	C2pwEqVf9ISGMoUGCbylEP+cwAGLDO806h364f2SSahqC4/pwGeUtlnhwlonQmvXr5C8fTBz8G2
	TdQ3Ieu0QfgF/629EPA13arQau7DEzWNS7Aqegfd4s5AH7UqIjlSgFVkPhwt8oE7OcBSdCqgmBx
	T0HS/LFJLDW1VDvTkqiYHqYusXnhU9L4z3G45pBHBKv85I6SY+WkqT4pFgcBX+n3kKNz4ntm1+i
	fIB8YM5GDbYCcJxfIn0xqeqw5CtoEelKfyB7AXFjqGVybR8k3xL7L0HvnCZ7BvKJZadXtgUkgDi
	nENI2uIW7KtnGSQX4ct/jXG3OvHPjnQAKGf5WsbiN0QmB1HlOys9fAsfVV0MAbsqdQ7T35KK11O
	c6cYk8GUqPA9zBeFnGWs9kSAJ8CHZCtnDEi/9amfPzl
X-Received: by 2002:a05:6a00:2e13:b0:845:2ff5:b66d with SMTP id d2e1a72fcca58-84e59564874mr6851758b3a.35.1785161458958;
        Mon, 27 Jul 2026 07:10:58 -0700 (PDT)
Received: from localhost.localdomain ([121.147.145.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660dedfsm3430475a12.4.2026.07.27.07.10.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 07:10:56 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ijae Kim <ae878000@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] mmc: sdhci: unmap the bounce buffer before device release
Date: Mon, 27 Jul 2026 23:03:22 +0900
Message-ID: <20260727140322.41306-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sdhci_allocate_bounce_buffer() allocates its buffer with devm_kmalloc()
but maps it with dma_map_single(). The buffer is therefore released by
devres without the streaming DMA mapping being unmapped.

Register a managed action after dma_map_single() succeeds so the mapping
is removed before devres releases the buffer. The action is registered
only for buffers allocated and mapped by the SDHCI core, leaving buffers
provided by host drivers under their existing ownership.

Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buffer")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/mmc/host/sdhci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e3bf901b10aa..efb4c7742fe2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4187,6 +4187,14 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
+static void sdhci_unmap_bounce_buffer(void *data)
+{
+	struct sdhci_host *host = data;
+
+	dma_unmap_single(mmc_dev(host->mmc), host->bounce_addr,
+			 host->bounce_buffer_size, DMA_BIDIRECTIONAL);
+}
+
 static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -4247,6 +4255,14 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	}
 
 	host->bounce_buffer_size = bounce_size;
+	ret = devm_add_action_or_reset(mmc_dev(mmc),
+				       sdhci_unmap_bounce_buffer, host);
+	if (ret) {
+		devm_kfree(mmc_dev(mmc), host->bounce_buffer);
+		host->bounce_buffer = NULL;
+		host->bounce_buffer_size = 0;
+		return;
+	}
 
 out:
 	/* Lie about this since we're bouncing */
-- 
2.47.1

