Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907230;
	b=mB95BufBIT2TOHnhUVm2TGhPY5xVbFnOwTkwsI2HmQXCmGB43kS0onpI97BVJJRulQ60
	 Few72NL468VCpPMEoEIFs0yCR5d1U5HlO385CYcAr64C9AQL3ejjPOiq2bUhUm+M6wxen
	 jdybqhkYLGa00dIv/5+jO2STqRGipyc8+zUAa4tIxn1PY2xqvJLYm6JYMmYAYbZBLYKTm
	 edbxPTCtsHJ7L/4Hl0aauA+B9jLt6OCRfqSEgCsRX0aV/Obt4B5NxeMgGI44xgg9w31C9
	 23Jm4FTZ0P7wdUV2KDO2amHJXI2I0tNE5RuDBANO+5Hpxkq8GfSObDO30FjqTTvEzpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907230;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=ZeS4Ihakqhd5Qx6qdIoXtPXoSLqZWsuW/neHa8NNoeg=;
	b=TYg+Vyzgaj1OlAiIFlPupcyiSOmombOlRekp9RKYLGGLkibGYjPNyDsw18iwJ2xDkCVa
	 gqu0R28plUyll2/HUli+IhstCDljXQAU1BYAp8MZd9IOf8LShB9fGv41mcQuWy4D/i/Q9
	 2lNCeieBjM3OkOq0qi2+5kKUBTZsNxKJKCWHQnda1qEJH4QGIa4dW0SUqyOtjNXJb+U0F
	 DV+Zc0zVG3fLfFypXbS4ypQpM6oprOqYgLBi9wzVr+xNxl0shCCXCeDcdXWqDYKIRpfLn
	 SJPKT4BdvKI77MiZutHvdkWZK/pKswhhtAbl8HdJDrHEFhKPiHQlmIJW1kE2sP+WpyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bikVzdcG;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C7606A31C;
	Tue, 17 Nov 2026 09:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 161C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bikVzdcG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ze
	S4Ihakqhd5Qx6qdIoXtPXoSLqZWsuW/neHa8NNoeg=; b=bikVzdcGBgDvVdopZV
	xeM6Z6LHbs4h9qiaMorlxabiRDuRid+VgswNaljRaeSIMh1lCFg/Bp2cd+hqmQJ+
	f/otNhOQ8kFgZdH8F46gT71euwsvIJLQvYHKjcJhlGbvtWr7nejNJsCeN/zymWQK
	fFR/zcLZo8LcSgXf9jT3+bcK8=
Received: from SYPC (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAnFTdTHPxq96NHIQ--.57100S2;
	Tue, 17 Nov 2026 17:20:20 +0800 (CST)
From: Yang Siyuan <hsyysy@163.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] reset: core: honour optional resets when the GPIO fallback is unusable
Date: Tue, 17 Nov 2026 17:20:08 +0800
Message-ID: <20261117092008.12130-1-hsyysy@163.com>
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
X-CM-TRANSID:_____wAnFTdTHPxq96NHIQ--.57100S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDCF1kuw1kWrW7tw13Arb_yoW8CrW7pF
	s5Jr4rAr95Ka1fCr4Fqr4FvFyrZw4rKFWxJFWfG3yxuw43Xryavw15KF1Yqr4UAry8ZFyY
	vF47tFn7uFyvy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6mhwUUUUU=
X-CM-SenderInfo: 5kv152r16rljoofrz/xtbC7RT1Kmr8HFRo5AAA30

__fwnode_reset_control_get() honours RESET_CONTROL_FLAGS_BIT_OPTIONAL for
every failure source except the reset-gpio fallback: when
__reset_add_reset_gpio_device() fails, the error is returned even for an
optional reset.

This is reachable on Allwinner SoCs, whose pinctrl uses three-cell GPIO
specifiers. The reset-gpio fallback only supports two cells, so it
returns -ENOENT and a consumer asking for an optional reset fails to
probe instead of falling back to its own GPIO handling. mmc-pwrseq-simple
on the Anbernic RG35XX family hits this: its wifi_pwrseq node has
reset-gpios but no resets, so the SDIO WiFi adapter never probes.

Keep propagating -EPROBE_DEFER, since the GPIO provider may be available
later, but treat any other failure as "no reset" when the request is
optional.

Fixes: c721f189e89c ("reset: Instantiate reset GPIO controller for shared reset-gpios")
Cc: stable@vger.kernel.org
Signed-off-by: Yang Siyuan <hsyysy@163.com>
---
 drivers/reset/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 38e189d04..f2375dd17 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1181,7 +1181,17 @@ __fwnode_reset_control_get(struct fwnode_handle *fwnode, const char *id, int ind
 		ret = __reset_add_reset_gpio_device(fwnode, &args);
 		if (ret) {
 			fwnode_handle_put(args.fwnode);
-			return ERR_PTR(ret);
+
+			/*
+			 * The GPIO provider may just not be available yet, so
+			 * EPROBE_DEFER must always be propagated. Any other
+			 * failure means that the fallback cannot be used,
+			 * which is not an error for an optional reset.
+			 */
+			if (ret == -EPROBE_DEFER || !optional)
+				return ERR_PTR(ret);
+
+			return NULL;
 		}
 	}
 
base-commit: 091b06388b117fefdcb63336ac09956a4914b961
-- 
2.56.0

