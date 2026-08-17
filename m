Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC04B048C
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 02:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933673; cv=none; b=B0nvl2c3URIlg4YG9ACDJC0dQIVRs+9JwPYwd4FUubTZ21aDclI5g2P/jUifog8q+wZVJ8R7ZTqN9qIBiTrn6pTXOKBFnhSVTRzQJNYGm6HX2AdqxBE6tPw5pRpCI1/FfMV8kHXunyurTHaj2DIGcnD58w+IDf7m0wLK8RGLpJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933673; c=relaxed/simple;
	bh=JwThhU1Y/8TuMKzm1pftmxoYovem0EEICtN7g9/v/98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WraFZDhAG3QyDPcCd/J+HdqO61DP0gnWpDjdg0GQi9IsIHuJUG6kwihgC8WmusOavGD2tdC21fS+J1jd7WTN5LFQ1AcXaJtqRBiaErziWv7RIgQfU9rJUQQjMwSp8FE+DKZDvqmvh55S6fdMqnV87g4btE4hfnNEKa+doKlYWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luklI7+g; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luklI7+g"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso2016815a91.1
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 19:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786933672; x=1787538472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ul2vM3JfxSlWJCZNaogOWLN+q61AuBwPdjD6s+9mX7s=;
        b=luklI7+gvSxRt6ZtGiUaW2VrthWGBQrfqRKwX9Y84mcFKlGWBRBNPYjBVv88tPnqlg
         8h4HVnv2lna4nANZY3MS2Ve0ik/PeYqEltKhQeBOKTj37Vl2qG7mSRuG10zU364pIISU
         FnQOUDaTsR0ds2LoqEvMpWn6Ma6R0rs8tWQAzAom9kfylKw8dAxr0AWWILloku+Mn6RZ
         G30XW3+dFwNKP35o7EBvWgLOhmtNURRQgzW7RkLvkqDOLNs4KXMSxjXNlMj0jMgelpnm
         +PcLpPGJ9F7xsUavCis7QG9haMzz46U0Qc6q5nZTe+uiqNSoixTfxOwtE3zsrFiIFuOE
         0uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786933672; x=1787538472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ul2vM3JfxSlWJCZNaogOWLN+q61AuBwPdjD6s+9mX7s=;
        b=kH3irY0L8SmaDVC9GoQHiTx+QI9Ab5bA2kT8pCWenfh2o9v6nXN8Nji4sjj5gF5lYH
         9NRyG2A5MolIxtd0BNJypE/N55e8at7ZmbF2k+KS+gHrXQpB26j5CxBKMD9hnSouo7HQ
         nW8dcsbRRHZn4erF0kcHs0jpFs+2x/mkXnHrrmlXhGjcI1aUnwFs7gDdaNWkrxqN4AVK
         /vntoV6C9Uwq8S2y58WmWsX3lKRYTNP7rO5M6cEgWn+zn6huWF6uQDyry7dCuXNb8BMN
         CQvbhHB04V94GccyTov/4Mg30LhQ1W7DzwMNCo+jFK/Rk513MRGjnEkDkFa4hkxvQgsF
         LRWw==
X-Forwarded-Encrypted: i=1; AHgh+Rozire/AGd4tgesaPiVA9F83/ryOtZlbs9l/ZZNdYZn+eMqZeOXzbo/PCsSPqSID8WsBW2nBwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5MmgC1gPWZTnRic/8M6nEuCGzJVFAR0hVzLjPZezoMrhjXV3p
	nbWatVKTltiz/pwF9VGyqmSkYLPyZyoHOZM+fQHDP9NBJ1FVFSWoH+97nROopDh5
X-Gm-Gg: AR+sD10lxNf56KO44CdOPZ7NIqPK8qTRbhUXJ8xyr4TdMpXMq8IIGUUeoQ1clpGw9F1
	fQODGm8kRZ/iAbM0yP+TtBYEw+pywvZcFHvx8erYQlkZXY8RgGgpVCo4yTPCy/YQkWP3K+0n2IX
	3zV9T8UFBxm9AK1scdTDiC2FyOAJUcSSwzsYGFfkWgkTZYsBhdVtkFXKTrpA8Yj5p9nPrFBmEfZ
	eQmBQOeZDx4ygG+8JIZEMhPRkqkFCEDtEkyXUo+uOWS4okhpk6ALzmNxK4RcSHOta0JwTlHlRvd
	FHF4gVMq44bTSVZcuMwEPZm3bnyhaU2V+kOKHZ2uLTMj1Tui6fVnLT9UScBPVMpxaKTTsIaV8KV
	T/in5lDRVc/OfI9qYAWbO+agRptaB9bD5iQg/qtP3kBJrHBnjuL8nDUXRD71aZRnfhgyvmYRsyF
	dIsJUyGXlN4zVs2P3Bhah+V3zLhkz9gg/lFOz6u7WRPOE904YCBSd0YTHFa9gjZdLPsmxm1AHm9
	aSfeJjp7B0=
X-Received: by 2002:a17:90b:1850:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-3933b751fecmr22700949a91.5.1786933671569;
        Sun, 16 Aug 2026 19:27:51 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d2b8080sm324315a91.4.2026.08.16.19.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 19:27:51 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sunmin Jeong <s_min.jeong@samsung.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>,
	Yeongjin Gil <youngjin.gil@samsung.com>,
	Yunji Kang <yunji0.kang@samsung.com>,
	zhanxusheng@xiaomi.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix i_size when pinned fallocate partially fails
Date: Mon, 17 Aug 2026 10:27:23 +0800
Message-ID: <20260817022723.3324123-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Commit 4275b59673eb ("f2fs: fix to round down start offset of fallocate
for pin file") moved the allocation loop's start down to a section
boundary, but the error path still converts @expanded against @pg_start,
which holds the unrounded start.

@pg_start exists for that conversion: commit 88f2cfc5fa90 ("f2fs: fix to
update last i_size if fallocate partially succeeds") added it as an
immutable base because map.m_lblk moves every round.  Each round now maps
exactly sec_blks blocks starting from rounddown(pg_start, sec_blks), so
pg_start + expanded overshoots the last allocated block by
pg_start % sec_blks, and a partial failure leaves i_size covering a tail
that was never allocated.  Nothing corrects that afterwards either, since
file_dont_truncate() has already cleared FADVISE_TRUNC_BIT.

Keep @pg_start pointing at where allocation actually begins.

Fixes: 4275b59673eb ("f2fs: fix to round down start offset of fallocate for pin file")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/f2fs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..cc0d2b8c4684 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1919,8 +1919,9 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 		block_t sec_len;
 
 		if (map.m_lblk % sec_blks) {
-			map.m_lblk = rounddown(map.m_lblk, sec_blks);
-			map.m_len = pg_end - map.m_lblk;
+			pg_start = rounddown(map.m_lblk, sec_blks);
+			map.m_lblk = pg_start;
+			map.m_len = pg_end - pg_start;
 			if (off_end)
 				map.m_len++;
 		}
-- 
2.43.0

