Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792946820;
	b=Tk6NICtdeClDm6b/+nspL/i3nM6T3B6Lfc2d7HZIh+CYw36TVrAEwtjAcIh3aq27RHxl
	 qE/4BG8VBAojJITFLMLltcn64yQlY5Oj63KK3GaEXCSmGCrqKl3R/GZ0SszxVtnFLVwZm
	 mYzD92DYTrcA5qc0uzSoxM2v4Kbb3Zyx4GB6m0Uq59sLjE5QgF9+DjCpA1EwM1i5BTtQW
	 QNYab8pKHdvGYhsDZN6dv4GyfQ17KaK7Ddi5lfg9j1pHuYwvTAsYLKEJzI7tvS8Dgiz8y
	 qawpSkRjgUmRsSVuhjalkg5Ay4L8vmfjiwlFiNE8eL+BX2+KKAHSmHu1r1cHOrKutFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OfgFlzGjw1v4HVRSf59nbvbgqbjgCU9X1s1eTDVI2XE=;
	b=LO7/37KwjoyKWjVP3zybpeIgDHujZ0pihuerNvOe0CbE/lV1rAfN7YEeQQjSkXEBxaV3
	 EZCnebhbOfq4JaXdWnecFk4j3AKru2aXchPZwsCBxMOgQjY3WnMiST+bV7kId93LWQWyY
	 EP2SK9fnPan5egCT/UHasxbyM2AYMMco5uEsJOqHiAvmNMNCV53vS9AfWJjF7iQjRJWvr
	 /WQtXbvJQXfm675YWr9WDfOniT92B1/WgREAMrFmx6OHYFDA3tocQMd5zCi/mpONYOJNw
	 T6JPhhp3iEN0NNmVhwCb2qeRk950n+JhsHaLup+fnxk0sD+iS3RXIyL/u7RvM+eWmpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VCv791va;
	arc=none smtp.remote-ip=74.125.82.193
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B84606A323
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 16:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4B84606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VCv791va
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-35d0be18c71so3945445eec.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792946819; x=1793551619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OfgFlzGjw1v4HVRSf59nbvbgqbjgCU9X1s1eTDVI2XE=;
        b=VCv791va/DDx6T+0REGuHSoMALzbLBPo/HVx/Vrqkf7FavqhzQVkwz8+nFbWw36Tuf
         wbxmpvQNqrAcylPxj5mODVndmgHb6OejeUqgQIsCfR/Co2uNij4Hy4dWhrCCgzU0uaBN
         j+zLwqFzgAB/A74IVd7Kluoc+1/KT9SkaIMkAFhvc+wpIm7uNhLZXkSU1+iybMFgI+fD
         DGAdV9InLzXxDFiOOY1zJeB5rCjMTIU0UGi0ORRyidPIeMxyTS5qGDqfFAb5uDHqb2Zh
         gPjY8fwspN4TWKgEphlzFigXt2nsme8tjW3MtI3IKNAeKpdhMqJ2uAYtkKlbTSkKwc7W
         aE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792946819; x=1793551619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfgFlzGjw1v4HVRSf59nbvbgqbjgCU9X1s1eTDVI2XE=;
        b=MYVrjtbN6aQ8qYRoFs3jSaIRtyQ50npka51YzRkoJZcZT/lRjXQfSOf99MVYulflxw
         9xGHbIrX9iFaMH949GUONgGAK76+mdUhlt/ikzEU/a/Nnjl0eUwTWjX1hClTNTi9c8oc
         RLDx2w1eW/NBTB2ca6TIm32P1ffcEy1/OLWSO243UTct5tDmtEdSkNoFQyjGIZjgMTdR
         CehgwXUbD/Xqms+k0BmromKApss05D3qVkUjTrKR5QNUmxI7cBLN08gzeVF/kLOF69BO
         AX3v/4GEuvITthVwsLLK3ZRPvo7ow+N18//QZBh0JYrQConNiLbh73Ra8Hi9ZD5HQQCn
         JwAQ==
X-Forwarded-Encrypted: i=1; AKwUvByFNxfbVAK7wvyhUKMJcbkTpJTn0FkesCYIm+s4LU5ol7G5kjLJdgATqH5lfxPzzWgAbRnrSrs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIt+3ylB639thokyNJYc6/NNEpehMrffVtoaILKB4tkqzqWfxZa
	qDzih3iiGy6slJuD4gMkRzVa/2akz2aP2VUIiGDSHvwT1kK5bpVMkh5X
X-Gm-Gg: AYBFou0lTD1FesFKdF5mtmdLXO+e4qo4R/uShQHo+iZ9jRBZf+0m8yyN1aC9zVXBko/
	r+ba80RXOBNShTDdI1PLLcrn97WDj1QS/BXSG+ns1RJqyz8kF+5hu+etJn/q0oymT7Wcng6vgl1
	aQaFBVH/1IeDHGlxgLFGcQbSbBdUqpjGsBiJ61AAupQB0gawInJSJxN8L4gzJv+PNE0VLe6tOC+
	24QS2iTAOLBdhNUDhCh3oGnkd5G1yjizr5h3cfolXhpYGle0QvlSt3eLdQz2rerfomb9fyKTFl6
	8Me1oun44yn055L/sffj0j8WUPWej7A5g+Zn8d2JUbCQONADbvLVKpEuOoZX3qIBYZoEw+zpEG1
	oWeTDGoQTuR0N8z4TXsyivyIiVnI7D5ahy8E2MkQ2oIvqubK4fampbu4LyOFHAdOK/DNR+qzUP2
	98n55q3PJ9SGlTbnxhVoZ8LmmXFONuWm1k6RyWng0dXJMNxvnUd+ib1MAzDrvMKqOtkFpa2l4OR
	p65kGng1sqpLZcB7KovcIHRCdamOGVxIzpJNg24T13m7wxHw1BjOqijDTjwPGEfzC3aZfse5qsH
	2+iAHFY=
X-Received: by 2002:a05:7022:439f:b0:155:734:9cc9 with SMTP id a92af1059eb24-19935be7f99mr9441348c88.16.1792946818717;
        Sun, 25 Oct 2026 09:46:58 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0d98660sm18320531c88.9.2026.10.25.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:46:58 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: hughd@google.com
Cc: baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org,
	dave.hansen@linux.intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] shmem: do not extend i_size when no data was copied
Date: Sun, 25 Oct 2026 16:46:19 +0000
Message-ID: <20261025164619.89992-1-dennylin0707@gmail.com>
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

shmem_write_end() advances i_size to pos + copied even when copied is
zero. A buffered write past EOF can therefore extend a tmpfs file
without writing any data.

Moving prefaulting to the slow write path makes this easy to reproduce:
a one-byte pwrite() at offset 4096 into an empty memfd, with an unreadable
source buffer, fails with EFAULT but leaves the file size at 4096.
generic_perform_write() calls ->write_end() with copied == 0 before
trying to fault in the source buffer.

Only extend i_size when data was copied. Leave the existing folio
handling unchanged so successful writes, retries and preallocated
pages retain their current behavior.

Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d97fc32e7c94..55287c370c73 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3487,7 +3487,7 @@ shmem_write_end(const struct kiocb *iocb, struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 
-	if (pos + copied > inode->i_size)
+	if (copied && pos + copied > inode->i_size)
 		i_size_write(inode, pos + copied);
 
 	if (!folio_test_uptodate(folio)) {
-- 
2.43.0

