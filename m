Received: from mail-vs2-f21.google.com (mail-vs2-f21.google.com [74.125.227.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26333CDBB1
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445514; cv=none; b=N55dvaHG3DpZto/H9+RdFzgq+8K4DZbfVEGwU3lGB8NTrGPABX2/ZIAVaYNqd6WiMdERyHEAw6Cbe3/e5P/Q+Z68+r2PwEqbyqnJHbQ+hGTv5Yr1B5oftRPfQUslwAFI+U69fcB/4P3AQ3uJFYNpAEPPK1EF0GCzLhqLtIsrzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445514; c=relaxed/simple;
	bh=jJQXdjO2V/cOvEj3uj557Xb3P7Xy4TEg36nRpimZhLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/ZepgFt8vD214nakiJ+hwv0LmEScP+atge7o/Cm9rnnhEAKaTAxY8+K8agaZr82dHRL5dXY4zvyLkS2s9PgipRmDFOCzNE+edm2ZoU5aMo1yYvINdpIrGzz+2fN2tTD5a+bNepVnelB837FqiSO6FYzu9rxKjDHwMGifL/QMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLSouhVe; arc=none smtp.client-ip=74.125.227.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLSouhVe"
Received: by mail-vs2-f21.google.com with SMTP id 71dfb90a1353d-5c83397eeeeso1784636e0c.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789445511; x=1790050311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLhmRzqAjQTbZa0DbB/6iNv5vi/I13aI5oDHnsU4F2I=;
        b=bLSouhVeR13I0U0U8FIlCnMpSdCMciAZwQmMfhw2v6kzUoTDhDqvkmGZP1aEfJI+nZ
         AikERlsdo0bNgEq3qybhmTLQJBIqDoPEuS+qya/6W+cvn8S4etXCDjeAOtiLIfp5rshJ
         71OD1oZrWh7yrYMxzO4AJ5j8b5q2bxXY5JGrG6BPxHhZffJhN/8AlM+P4IPGrleD7nWA
         WHNMJ7CzKamNE2NO6zVU/km9NtpvQOLq9cbjYES75PR6qGjAJu1cI4gOqWj/DqMfaFp3
         /ndCTChGGUXtjEbWGndN1V1h6/3EK5QTfnp7HH2DqraElheM7tOd+jYp0kTEHLeOdflS
         XFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789445511; x=1790050311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLhmRzqAjQTbZa0DbB/6iNv5vi/I13aI5oDHnsU4F2I=;
        b=ssf2lOHTzKCEOgxLc/+k1yjvZT6br/mXKl2DB9wQ5MKy8JqW/WKEnackGp82sp8cHM
         VXmtVQRL/BGgBREfI8mGpfxOQkQR7jSYXYOqV25cPAwow95zdNuskhOqK5EjElZAx3t7
         KfnXzzJvIMdffWqtVdUspW8Wu/Bi9biYS0p30Nj7KXkwPLVvvlsMFkcmBaEGL2vDCEfo
         fYokawX789vNMOp6L5kQ9tnjh/4UfZmvUnepUxAiCflV+YzuC8E68RnONtKPSjyidISq
         uZ8cTDhH+DvSELEdyvcusJSR/OXvMIgUlczIIGpj5S/efjIXkJzCh6TwfSH2S/areVM2
         acsw==
X-Forwarded-Encrypted: i=1; AKwUvBwbolmisou1PqGfF4rJnTYsYw+Zf+7b5iNsYrV3YCnTo491g5X1Je5j0h1dTYlce/6PRiTE/2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nF2FEuyuSML7sJtdbWzwkJLqcemKwMjVkBflJ7L3awslgixYZb
	mA/2E/yHMFJLqBdzejHPgDnmaimNMbNZBqSxIS1Ei2/KnrZ15rmy2mj+
X-Gm-Gg: AYBFou1MpoDR879ZS/Ul05DsHAoOtEvwjkIqYXPFH1NayWgZ2/6zh0PKXCCO41ZUtsG
	6nF4QX3tJPX0pFXL6rd7NvcJst+4dnI3bmfdgpY0dOydy4gDV6ePwFg7p4qU0R8zPgMEea1aCw8
	W3hAFfgGwoEAJqoAedTPA9yZSOEmR15d/gQnT3MvBllUOtiBOTso1doGLPH7HU0Onayw/PymVSO
	TRe7Z9S4EFUncY4n6smxDSvPzrqZrZR+l3gAhne0TLx8ov1wZ86pCQ9AYyDpLL+a9NB5qVraBlo
	4EwxKK94CqfkY1ZTVSpJ3OWSux2CdROsyPWK6cft3DuzwQu4D8yeriQ27d0+ivgskdXBnjcA+fh
	5shs9pgE1kB+R23U5/tYXSKUTovpgTnwSBn2UW/A049XMMDLl6YxH1CAsH6dryykhobi8ad8irj
	nyNjCVcco5u7ZdXe0ZD8j+WLI6AcVXSLYJ8DghMu2VNoSotpwK5SzRGlVeNeBpfEi5
X-Received: by 2002:a05:6122:1d08:b0:5bf:9461:91d with SMTP id 71dfb90a1353d-5c981d7b2f9mr5611703e0c.5.1789445511584;
        Mon, 14 Sep 2026 21:11:51 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c8470add08sm13857915e0c.3.2026.09.14.21.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 21:11:51 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] usb: gadget: ncm: validate NDP length against the NTB
Date: Tue, 15 Sep 2026 01:11:42 -0300
Message-ID: <20260915041142.2430163-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NDP length is validated for its minimum size and alignment, but
not against the containing NTB.  A host can provide an NDP near the
end of the block with an oversized length, causing the datagram parser
to read beyond the block.

The NDP index has already been checked against block_len, so compare
the length with the remaining bytes using an overflow-safe
subtraction.

Fixes: 9f6ce4240a2b ("usb: gadget: f_ncm.c added")
Reported-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://lore.kernel.org/r/20260708123048.760209-1-lgs201920130244@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/usb/gadget/function/f_ncm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 64eabda2f..1ff05eb0f 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1262,7 +1262,8 @@ static int ncm_unwrap_ntb(struct gether *port,
 		 */
 		if ((ndp_len < opts->ndp_size
 				+ 2 * 2 * (opts->dgram_item_len * 2)) ||
-				(ndp_len % opts->ndplen_align != 0)) {
+				(ndp_len % opts->ndplen_align != 0) ||
+				(ndp_len > block_len - ndp_index)) {
 			INFO(port->func.config->cdev, "Bad NDP length: %#X\n",
 			     ndp_len);
 			goto err;
-- 
2.43.0

