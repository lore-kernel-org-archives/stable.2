Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792948313;
	b=i6TBZZFT2zQlWfz6zhOTE8FXdT4dsoddlFF7uWSpbe+2ex/DoGvXuL0cprpSPK8UelKU
	 +vK//UCvrR6mf+IoBQpl1qsF2WAhc8nHq2G6iVvIevLeVm8nI4BmddUKV6on0PH3235jY
	 LVJCfUDRVpTeCbKtSeZaRj7ODmT+I8VLa8hWd8KztN2bQyInRoZZJix8o1EHC6g+2TpPP
	 JcIkDyD8P4YeuoUnws8RdLun5IWRcqXEnRebXvQ9tjolv6F4Vj7mGedkw1bdIFRHD8exB
	 H+VcG6uiWgXbxaN/IC9r1rhwHKrkHfGG+fgSY4NX9Az4jyTfJTiKve5oJxighnNgIsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792948313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kaazuBYoFlNi01fHJWSjX0ZrC024FOWcAqZVtF/rwIM=;
	b=HRV1k8FOTln587KIk7IohHaRLoqCR8b5Yz94FhVMVQvL4bFB0AmJdR4Ot0NnmAGhYjVJ
	 h9SeuqkGhBLaKSIvtZKpVcdViRMAJrR7lwg2znidqdcXa3VM7Q2uDHHAekonzQEZfhnGE
	 zUgxMOrlJ5wdJYOi/Rq1MC/yx1K+Awnhv01eQoUL4WX/dAM82OcWxqJmlgcuNL/Zgo2Zm
	 2KK/ZbXOcUrEm6tQm4rF9IyqJ1WtAikB6waIWpaaRb3kD2++edBDRpXqaSpcr8Q3g0rGz
	 5wMrmtiB+CLdqdMXFSTiRheTC7ytpTq0ybvo2X6taFl3UneTEdoOYELhlQ5KCqoKnHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d1crgSwR;
	arc=none smtp.remote-ip=74.125.82.194
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBA606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EBA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d1crgSwR
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-35943f55c06so3132843eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792948311; x=1793553111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kaazuBYoFlNi01fHJWSjX0ZrC024FOWcAqZVtF/rwIM=;
        b=d1crgSwRNAX8pcAiY9hJctAMXtQlVms7wbaULTZ21mEbK4effAqJ0lIajzsC9XpvQt
         Fr7ujXbZ9AyfVmQQRCObEMTHTLQ/Gj3VvN80mGyjsahf5b1lgQ5Jdlmq8Rddh4rqCdN+
         ATsStbP9vZCv/Y+zm73kbrEvXmn/7SA99GWNkcs7lf5stwtkU+wLrfNu6zGIxdNclhJi
         hn685tJayEUUAl57b3vKbtNiRocD63gBcpZvD424L22laZ1FOQb0Flq+wK98ZRo/YHVU
         nyys2UNgMCmT/j+uz1mWoN0tByIjFNCx6UxzNGGH64uB/FqzKEgW7RxlvpiVPvzUXG3I
         pQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792948311; x=1793553111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kaazuBYoFlNi01fHJWSjX0ZrC024FOWcAqZVtF/rwIM=;
        b=Sem5xboR1CGSjDahcUBrn1AA/5g5gKgRC1/FIxnm3yNPcG9gwGbknW1A34qzmUxu+E
         irx9H5WoY8DWWnLzc9IYIDEbRYOk7MOS3qmQxEjTJ9O1vBObOaspuBo2VOZHT0XHpuXL
         6EZeV2+qSrpUsFUCF4xRAee1yGXE0FOVML/tkO3yRmii2mrIwkSsMQD3Xj3WXolzo0zA
         03ViMUpfcyrJOG/vraTbR4LxU1PvXRRNGXW86oqVXJ99qv5aeRQyL+Y2DF+Fv7qz0WuT
         83el03XGyX6lt8+3lu6jRdGWj8nlBTQnP37F5SJZiCHiBmmp/FIAohWQ36G0xo7Ub/sl
         Lc3w==
X-Forwarded-Encrypted: i=1; AKwUvBxnv2CTikkkdNHW3KYzSAgS1/SeHVe342doVw0CzU+axq2CnNCdH/uN5wWWblH7euXNpyyd2gY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvMAhtV1FXQN+p9HmnFRWsGERgs9NLFPGqMYZ8L4q9EQ7Kw4Ha
	C3GysUtl0Mr9Mf1+ZJ32/pd23ICTVUvBdhfZgE8OPHgwp24qMOuhNyso
X-Gm-Gg: AYBFou39BfjB0DLmqJ5xbeHBIj5WPZ1Rd/1LK68YOgaxjK+wTH3E6aPFxljxpeL1sBH
	E3FLBhIKd4LhUkby/vpJiTEcGbqA9n2zOvPIsWZl8X5qFELAFyrqOVALkHh+D/2/Ztb1+P4v6nH
	NOJMybz7XqZxnwi4Z56PHZZGojVdE2g4w9xiVBXllx3SMqyRI1U/3mV1hMueJCqryDEx7mR6JTY
	9R2eVkdQKnGCS+LrDHRuF4z/26Oo8HOZT/x+h2WhQrIUMijUa7KooZ9eorjyaPuNyuoxtR3JZwx
	dMK8ZbKr4TNH//nvasYK7sRGStjGcL8XVdRdhT1lgKIlU54B9GmoADt5lVM3lRmTwqk78RPplf7
	NPEMJMxp104h727o3gAGkt4SPb264uRvOmgUNEyvBnlSWA+altaDMBgeMUnr+S3I6WUtxVQZuuO
	rs3DGJWAHMdu8y28gzqXOmkwPv+tkPKYhRmVhd8XNwuM4StJzvC7TwLqj56UO+PfXjGNZUnh/j3
	1g1muYzSgtDUr6f6nC5MPfntE6eBaQlqgRESvxzDWcX/VqZWkiZ7sfoDPbhXU+PyotAi7a1zprt
	QXSPx53VGVpNShzhWQvTKIbpY0NYeQ==
X-Received: by 2002:a05:693c:88ca:b0:366:6c79:212b with SMTP id 5a478bee46e88-369e85043a7mr5516718eec.25.1792948311310;
        Sun, 25 Oct 2026 10:11:51 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm17670582eec.3.2026.10.25.10.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:11:46 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	akpm@linux-foundation.org,
	dave.hansen@linux.intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] libfs: do not extend i_size when no data was copied
Date: Sun, 25 Oct 2026 17:11:30 +0000
Message-ID: <20261025171130.16115-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

simple_write_end() updates i_size to pos + copied even when copied is
zero. A failed buffered write past EOF can therefore extend a ramfs file
without writing any data.

Since prefaulting was moved to the slow write path, this is reproducible
with a one-byte pwrite() at offset 4096 into an empty ramfs file using an
unreadable source buffer. The call fails with EFAULT but leaves the file
size at 4096. generic_perform_write() calls ->write_end() with copied == 0
before trying to fault in the source buffer.

Only extend i_size when data was copied. Keep the existing folio handling
so that zero-progress retries and successful writes retain their current
behavior.

Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/libfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 8e2cc627bc7f..d889a4a14f41 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1007,7 +1007,7 @@ static int simple_write_end(const struct kiocb *iocb,
 	 * No need to use i_size_read() here, the i_size
 	 * cannot change under us because we hold the i_rwsem.
 	 */
-	if (last_pos > inode->i_size)
+	if (copied && last_pos > inode->i_size)
 		i_size_write(inode, last_pos);
 
 	folio_mark_dirty(folio);
-- 
2.43.0

