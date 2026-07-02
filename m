Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858A1A6835
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958917; cv=none; b=iVRKguPEP4yT9yFDyQqXu8CHQgfnzeXOabUF4J7PdY187y/uHZ1MXfgS6H0arW3cOLh3PETQWmMNjqtDC1wgr0wIV0Tin6BIEPC4aYgEVGLpB6aMvY1qO9SL6T37N33bXE5RIkxWqZJuqKNnWSgIXNkk9g/yvVz4qV6HPNEzBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958917; c=relaxed/simple;
	bh=EjQk56qETNDqrOUc5vHuuh4ZF0GG1GJjxTmkPsqX2zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TMrbImkaZotAKHa8vY8gp+1hF8zzaZnXimDbaKMjZUCwnhJNIYhpQtiYGglapbcmTHiRBokFupyML/0oAFNMQ32ArNyZ8S/vJbD2MnnBwwMfMjVNbdlmD48h8JXTRPwLzRYiqbbLm1JczLaYthjfPGXyO4EBDg8woIySHng+4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsJLrljB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsJLrljB"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e7391839cso562116a12.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 19:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782958916; x=1783563716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rk4f9pe08Y0Xymq/tiB3v7hgDPpfmTVL9D64rhPQKA=;
        b=jsJLrljBjxHaOZdiq8oi2sUpaoiTv6m+I+M68g0RtIuHNqlJgC0VngVt4pAd2V/as6
         sGwRVTgjw9hoJBMUO4DeRqArqTEi/Mx4En5sedzxv+RTZccnKhGz2tFQjSJKToc7rajj
         qLUv4QxK9UudjfgI/SJUJeeXw0ExDteaStMcaP5XYPpFM+zbxL4Kv45a+G07rBcQhixV
         LHdV7icH5OENu4DUFbqkejjRgEDkAd7q7W3XtGehhny1F6SJHK3TE4W0bLaCNkjYFhOC
         UBHQytbzR3DVDtPBOdPaDUC1/6BIhngEpDIPx9HsXaEdSelz1Oyq6yhut8dwrQS7sRSt
         RKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782958916; x=1783563716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2rk4f9pe08Y0Xymq/tiB3v7hgDPpfmTVL9D64rhPQKA=;
        b=R3v2537exjv9WG5its/SMct3Yuyi52HfDmoyn4qFgqY3IiEaJPDTXSQHeSsJfBF7mM
         hBe4GZWdU3DMV1YL3wnkKzCS44G0H+Nknf3hHCKj8YDBOiplWWzs0u3TM0qO/P2CQGhK
         mqSjrt8qoXtokhJh4ok2mKNP6Ei3izCAEajlZUFIEj3LukgukHmUmiLb0+BvYOZd7xvk
         9LV5JKZ90s8wr6GwbwRGe0U+mYQaVWcMlgDmcCHAGNlpFTRrQ1uA3rE0+Er3A2HZQZYZ
         PrkZMCAEo9XhqRE1Iq/WidWhL8qf9F96OGyu/TUeH48cEAacuNNdL7LAEiTBDiNaJcUl
         8AnA==
X-Gm-Message-State: AOJu0YyAwm3x31vZ/iD25vHwB9illzxZ/h6KqoJmwiItASyErTZZj82Q
	hyfFcooCrThCLdtYa+2wOrAS9z9rHu1DPm7pxT5w1e1yp9iDLa9c1wgB
X-Gm-Gg: AfdE7ckoCKQ9ciLtln2wdxoBd9pAdP57bH/ztEreagl3UnRW+c8l3su08YvobLT1vH8
	MQ1a9q3TY7Y+C5IMy1Fja2bzl+wIRtCTS3GutgNnl5EiuRG0Rud9UyLNuqsV6Sa4YQ9VH9TNHaw
	xPXl5+Ebf7+E3S4JvNPsxWNNcO7OqDno9DehqmzKAfGsXY62liJ0V04cvyyWj7gk3zzkYfmswhW
	q5TsoFnkoCLswFY6AhiY5g4DOS8qJwFDshkgs0bHtekeYdMIsZRuLTHMFZ4rYujr+9VAaOC11zB
	LZBBcMZ8UD+MyFOq5gcQR6yzOF6yjALR+9sgOBGQw/U87LXdsCqkDiZpY8VmJY5NDPGWJKL+fHH
	VYznyEkxeGkTV14QgNyFjH4hMoLPucOlbx6CalbLV0N+aYDKQl60dUTd4tVf5jx001bUoy3ZF2O
	lf0EGOd4bu7sXlT7aH9lBYs/U0ZHciEQXkTA8=
X-Received: by 2002:a05:6a20:a11b:b0:3b2:924c:567d with SMTP id adf61e73a8af0-3bff42bedd3mr3849179637.46.1782958915817;
        Wed, 01 Jul 2026 19:21:55 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb10645sm587918a12.4.2026.07.01.19.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 19:21:55 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (unknown [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id EACF44168D45;
	Thu,  2 Jul 2026 10:21:52 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: stable@vger.kernel.org
Cc: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 6.6.y v2 2/2] mtd: spi-nor: macronix: add support for mx66{l2, u1}g45g
Date: Thu,  2 Jul 2026 10:18:42 +0800
Message-Id: <20260702021842.2771498-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260702021842.2771498-1-linchengming884@gmail.com>
References: <20260702021842.2771498-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

commit 797bbaa7531f75985b199e484451fa3f954382b3 upstream.

Due to incorrect values in the 4-BAIT table for these two flash IDs,
it is necessary to add these two flash IDs with fixups.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Link: https://lore.kernel.org/r/20250211063028.382169-3-linchengming884@gmail.com
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/macronix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index b676a71822a3..fc43e0ffa3d9 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -116,10 +116,14 @@ static const struct flash_info macronix_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &macronix_qpp4b_fixups },
+	{ "mx66u1g45g", INFO(0xc2253b, 0, 0, 0)
+		.fixups = &macronix_qpp4b_fixups },
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ)
 		.fixups = &macronix_qpp4b_fixups },
+	{ "mx66l2g45g", INFO(0xc2201c, 0, 0, 0)
+		.fixups = &macronix_qpp4b_fixups },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
-- 
2.25.1

