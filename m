Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995B480345;
	Fri,  2 Oct 2026 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936029; cv=none; b=QEsKD5szPeBVX04k+84deMNkkRDj4Mr3t/YiZZn8dz5snJAYlGkTVwggCiMhYr485oe9oQNm67fQYwqftr96R4143BcUJjio6CHTYO1bcRJMXNvxM+ytuFzMQKImYlg1MRdK8b4xPH/DbhUd9nOhAc2m3t79s/eVdR91i47IC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936029; c=relaxed/simple;
	bh=9oQOHEEQs44AVDkX9W3BG52gi8QWoKIjIFtojGSjlg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiMoONGF69KMKG6V1GhWRh/ycOmAQTGmC9tGtLgmK0r+VzQvTU5wuzrEa0TX4EGyTyB+kUDSevIf+1IaxtLPqpBhZ1k/fRE+WMWeyr24rZLhNqvxjrtCR4d96MuXnqJadXjHi5tQJ/UgIltM8k8y1rX9mfabMiKwd4h83eVHOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deAyxFf8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deAyxFf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932871F00898;
	Fri,  2 Oct 2026 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936026;
	bh=Tj9hZe/Y6hdPfr1LjfVKYWgy8fDZ8Fg+IPF84Z1+tyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=deAyxFf8qJbVcAWKwunMXdKDZO1F8hXv9CfGgVo9A/n58F1PujJIVP+L1E0E3TDzH
	 8+NG4Wl0iTNGw+pYoUElo5lAbQlT+wIyKwArCXwWN//JuTL3Hk7cmHrt1OhRjwr4JJ
	 1aXS5MliZlfgEBdYhdfchbDEMnlRc59Dzy9+e+pvPU/7MUFPdTUGQ2IvJ+/AB5d1zp
	 D35w3U1pTUOiqiyzYpjuPJzdo4bc4uj8BXX0PwdgjaqbLmaaWMqx8manHnfDUg9kUc
	 0yJLl2gxO9Nft81IAMNJ5YFbu+XXyEgNzvxEukMCpcJwd2UvUWEl75g5ZArTFajSiL
	 UpD6on9JOdADg==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Janne Grunau <j@jannau.net>,
	stable@vger.kernel.org,
	Dmitry Sinyavin <sinyavin@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 4/4] nvmem: core: Fix OOB read for bit offsets of more than one byte
Date: Fri,  2 Oct 2026 11:13:29 +0100
Message-ID: <20261002101329.1084348-5-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002101329.1084348-1-srini@kernel.org>
References: <20261002101329.1084348-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Janne Grunau <j@jannau.net>

When the bit offset is BITS_PER_BYTE or larger the read position is
advanced by `bytes_offset`. This is not taken into account in the
per-byte read loop which still reads `cell->bytes` resulting in an out of
bounds read of `bytes_offset` bytes. The information read OOB does not
leak directly as the erroneously read bits are cleared.

Detected by KASAN while looking for a use-after-free in simplefb.c.

Cc: stable@vger.kernel.org
Fixes: 7a06ef751077 ("nvmem: core: fix bit offsets of more than one byte")
Tested-by: Dmitry Sinyavin <sinyavin@gmail.com>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0556d140170a..b4e5069d9e38 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1598,12 +1598,14 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void
 		*p = *b++ >> bit_offset;
 
 		/* setup rest of the bytes if any */
-		for (i = 1; i < cell->bytes; i++) {
+		for (i = 1; i < (cell->bytes - bytes_offset); i++) {
 			/* Get bits from next byte and shift them towards msb */
 			*p++ |= *b << (BITS_PER_BYTE - bit_offset);
 
 			*p = *b++ >> bit_offset;
 		}
+		/* point to end of the buffer unused bits will be cleared */
+		p = buf + cell->bytes - 1;
 	} else if (p != b) {
 		memmove(p, b, cell->bytes - bytes_offset);
 		p += cell->bytes - 1;
-- 
2.53.0

