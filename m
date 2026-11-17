Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909325;
	b=qHJjE+/6b/48SzsF2einbUdREP21qc4ioF0uNoq6dvlmW8Yoz3BehT9P38S1GmY3Vn7o
	 DfnjQQHNm4+A0hnIW04dRdWEIXrf5N34nEEE4zv10wTQTAf2UIDewICTRdUG740kghD7B
	 YNfLqdczHCTSdLSH49b4pMgOcF7JAGtaozr5ok6diYi7bK4T4/LvZQfXw0XyyaZV3wuff
	 Ly9MFwDxBjqhLYqnDcCHnVsKquYznAX0B/W2ZKa/wLXYm907n8sGgs1GyVyQHOgi3z+rR
	 SA72G/3LlfPVhWmsoINc8p2VaEN3dB+lY696MO4vy7k8aLzB3gd/BJ4hfaOF+RTsMJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909325;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=bXNkFpD2NUsrHrbv/N7nzoRy/xe9OnnNDu3rK4yNZro=;
	b=CFKBMGLCQb1vC/PAWf8eJH7rWAamTbbUkxY6IIS8PMjO64PqYv8io19HPZbSr9Gr8VzT
	 akGzAoeul1v60QBfKG+kX+yWaqXO24AI9VQLY7i6zls+DCZq8YETvZNKo3foq7nPtLg3D
	 uVBPskMgd3igRuuhSU5s5sF6u/uaXg0Prdmlwo/rmn04mnRxf+OW5/ZYl7fbsOtpsmQM6
	 WzdPt2BMQYgEfQZlBSzG+eFhNNqzT0wjDCdxbM/pkOT0Lv2CdUWoQ2m1K7ggDo3m58dk4
	 5a4JLyOS9Qju7va/SkjlAieSvwKAK82WkdwUBe/yzuInb5cMcuq2SK7pU3BnALZX9HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qUvlmDTw;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD491606A31C;
	Tue, 17 Nov 2026 09:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD491606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qUvlmDTw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bX
	NkFpD2NUsrHrbv/N7nzoRy/xe9OnnNDu3rK4yNZro=; b=qUvlmDTwEfLmWF3j6O
	h6QRk4mtEk8lLXgpXjlV/i1NMAe0WHlpvTF9jLPPRWKnk3/HsjjPon+vjq7zO/T0
	jNdg2DzVxzymCduZYCeu4AbEhr9GPfEjfysOU5EKHRgH+B3IMb2lzcUsYie0DPv1
	6W8RMR04CUwbNgojsuCdGd0V8=
Received: from SYPC (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3_y6CJPxqHF9JGA--.44786S2;
	Tue, 17 Nov 2026 17:55:15 +0800 (CST)
From: Yang Siyuan <hsyysy@163.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] reset: core: honour optional resets when the GPIO fallback returns -ENOENT
Date: Tue, 17 Nov 2026 17:55:03 +0800
Message-ID: <20261117095503.14115-1-hsyysy@163.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117092008.12130-1-hsyysy@163.com>
References: <20261117092008.12130-1-hsyysy@163.com>
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
X-CM-TRANSID:PSgvCgD3_y6CJPxqHF9JGA--.44786S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyfJF1UXFy3Zw4ruw4DArb_yoW8Aw4fpF
	s5Jr4rArs0gr4rCr48ZrWSvF1Fv3WfKFW8GFW8G393uw4Yqry3JrWag3Waqr4UArW8ua4Y
	yF47JFnrZa4qkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6mhwUUUUU=
X-CM-SenderInfo: 5kv152r16rljoofrz/xtbC7gMDN2r8JIP1kgAA3P

__fwnode_reset_control_get() honours RESET_CONTROL_FLAGS_BIT_OPTIONAL by
returning NULL when the requested reset is not described in the device
tree.  The reset-gpio fallback breaks this: when
__reset_add_reset_gpio_device() fails with -ENOENT, the error is returned
even for an optional reset.

This is reachable on Allwinner SoCs, whose pinctrl uses three-cell GPIO
specifiers.  The reset-gpio fallback only supports two cells, so it
returns -ENOENT and a consumer asking for an optional reset fails to
probe instead of falling back to its own GPIO handling.  mmc-pwrseq-simple
on the Anbernic RG35XX family hits this: its wifi_pwrseq node has
reset-gpios but no resets, so the SDIO WiFi adapter never probes.

Return NULL only for -ENOENT when the reset was requested as optional.
A reset that is described but cannot be used is still an error, so
-EPROBE_DEFER and all other failures are propagated.

Fixes: c721f189e89c ("reset: Instantiate reset GPIO controller for shared reset-gpios")
Cc: stable@vger.kernel.org
Signed-off-by: Yang Siyuan <hsyysy@163.com>
---
Changes in v2:
- Only translate -ENOENT to NULL for an optional reset; propagate all
  other errors, as suggested by Philipp Zabel.

 drivers/reset/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 38e189d..daa4038 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1181,6 +1181,8 @@ __fwnode_reset_control_get(struct fwnode_handle *fwnode, const char *id, int ind
 		ret = __reset_add_reset_gpio_device(fwnode, &args);
 		if (ret) {
 			fwnode_handle_put(args.fwnode);
+			if (ret == -ENOENT && optional)
+				return NULL;
 			return ERR_PTR(ret);
 		}
 	}

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.1

