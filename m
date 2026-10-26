Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026129;
	b=qJK4SNEDzTFJUTkTmURNLHx0RzD6aczUpUHeJ2YwV0tAQBS2RmXcQYpCs6xu/rZsX88k
	 RArgbWjIB7+L0cVlzc7UKAyIsLYXqS5Ro0TRdz5c8DZn/G/gLYUn2rzw7s1UszSyfvDb2
	 W5qpmmfQGe2CFDVbdev0C2WgN3uPSeFu6noif/KvTJhqeqSynD6TFyr6SeKw92jDdik4n
	 c+sav8w2+VFyDe1yAkBw+OUfOebwloq6amMDSmzVTulPXsMOfBln77ccAwDCVMIkJOh0n
	 kjSJpe4vmrghW7p1Ga5PJeQSEllfTrDvJ1/H8vbtxCpD697etqnHahEuTGvekqO0jWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026129;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=9miV1nubylsMwRnZKYXYzy2lkCWAGHgmbPrTBCKz+Kk=;
	b=Vf+DLFFO5e5Vm7QI35mEbJrznooCH1JKI0tpWhGiWqrlTxWeOGeRTe6b1HsFPtbF1Opv
	 5PcOKM975otPu/o05dq8ujO5zoj0rEDkxgJSkiyGshvfWsWpiWMAiTxFv0vArIUa2avd6
	 3Kc4npChBmQU9hK5uDdEirhBU2XeGCwEMMPM4fZf7h8RXHP02eCxy7shsgXsLDQL7iDe7
	 rOZDziKySYlvULd+trspxlXfLNF0GB2b/rMbGoynBLavZvkyO/tgaUqkKb24bv5Lc5ze9
	 bI6N5BRFnkIDbJhrZs3YQHquj8/XswCx46JV/7WrpnRHBGjcQhevL5S3j1tkJauLs5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EBNmbG+q;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1146606A321;
	Mon, 26 Oct 2026 14:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1146606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EBNmbG+q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9m
	iV1nubylsMwRnZKYXYzy2lkCWAGHgmbPrTBCKz+Kk=; b=EBNmbG+qIjrjnMCm69
	fwWOlP2TdBg2kw3o99ZUGL5FPBA++pdhPpcrboasof/77uZM+Zf0W7MixU06W/Z5
	IrUaWz7JxjAqPSXYPnROi5cDrCuPJ1o31ToWxssSWPvFKdteViu3W/dH0NUZvnX6
	13PAf5foGvROQJnZ329BzJNsg=
Received: from SYPC (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3v15BaN9qgQzCCw--.42660S2;
	Mon, 26 Oct 2026 22:48:33 +0800 (CST)
From: hsyysy@163.com
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Yang Siyuan <hsyysy@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] reset: core: honour optional resets when the GPIO fallback is unusable
Date: Mon, 26 Oct 2026 22:48:09 +0800
Message-ID: <20261026144809.1392806-1-hsyysy@163.com>
X-Mailer: git-send-email 2.56.0
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
X-CM-TRANSID:_____wD3v15BaN9qgQzCCw--.42660S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4xury5GF45Jw18GryrtFb_yoW8CFyxpF
	s5Jr4rAr95Ga1fCr4Fqr4FvFyrZw4rKFWxGFWfG3yxuw43Zryavw1UKF1Yqr4UAry8ZFWY
	vF47tFn7uFyvy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piK9a-UUUUU=
X-CM-SenderInfo: 5kv152r16rljoofrz/xtbC7QG88GrfaEH45AAA3g

From: Yang Siyuan <hsyysy@163.com>

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

