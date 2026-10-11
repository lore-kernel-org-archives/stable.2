Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186C36654F
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791701327; cv=none; b=l7aafcSce5OSpnfLnBWq2Bo4SDwjbb1KpJNBB7zuSU++fss7hzfw9MBGi2tsXM7RxucsZjaRZ5IeW5DPw3EeWy4L8A+0nFlxagsRCtBVWP6d6/NIp0DTaG5XiiYT+flU4auM0BftjhkECrI4pgxUeAaw9SnFRGkezrosAsS5I24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791701327; c=relaxed/simple;
	bh=12x4Fjiyi/4PbSLt4bmLyJ/B6akX95r8sgWYZNezRSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbMEVKNu2A68W/vdruPnmHOLbQ0xJKVnI7JyEZv5anuju/fIK7gMs40/XLPfACW8apTIRfc0NOuWBjd4Klcz15dNl79ewtmZuNAZYZ40gIBLVxN1zXd1D8pUNH1da/QLTVS4vLtk6EMGUiJOZgI846wzbrs6puGLGoBUWGYb78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na2XRAmj; arc=none smtp.client-ip=74.125.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na2XRAmj"
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-3538045633fso899576eec.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791701325; x=1792306125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=koNO8fBOwK5rhKY5/q8SE/NGFcISiEzKzkHra3TeJ/M=;
        b=Na2XRAmjD/IGf3kac+xsO54ghH+42NuPAocWr/RLWTVdkXfv/KpQj23IZ1ShHAQ9ma
         UAI4uwy7zd2XXyX1hup98h/TMmNUtHNWToQVk6zuiqNQujT6KstLge8QGE5k6tu+h73t
         yrVaSK0L7CvF51Rid7GNm4aLpv/o3i0QTTd2fAYTWAIlP1xb7/pE5zIAP+yy6CbHn3XG
         1EooESLRi97X3ay1HI4IxzXJBgujP4/RW2ZZeJHhG6m66R0869xYdph5ZB9Z5UeCeL0J
         QYzc1LehW4v+2RibgXrQIrYMLM8/8RkycUInEEYr8kaai9qeQ5h2ZRQpinYhTHypizOr
         TKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791701325; x=1792306125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koNO8fBOwK5rhKY5/q8SE/NGFcISiEzKzkHra3TeJ/M=;
        b=wBEoKgmxSG23e2XUcWAUtM/8o8971tAns2cOaYFplP48Ek4tAnaoHdXAzlHELhCkZE
         +nFpelub39SnFV2xKbDxtHSoYpHtMaHFF9xE4QcTvWwCFIN6UjN8L36Z6gX/b4i9RTC8
         hZZcHjxg7E1Vd456ADy77KleHzc9CJJQ+8MmIwN0j6OlgUFHnStrLdhAlZsJOy41bwBy
         nCpZNAQzJPsbvEN3g9VIiC9xFt6vTQQdcQ6K0XUk8XDK7F5rhb1qyGj/Cfm+NvP5kaSH
         7CmBvFcq9rQS7ZXnfmhQ66EnCS9yqzyrwL+DiLHP8l80imF+2HAuCsycXqoCmGTaXkmL
         D4tQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3Hd1Zf1S3A+M2CD3eWje3FaVrKWd9bsFmujmNsWrqQKWket+8MnRNNLuR5LDVy4T4nxb+7fs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRm1QToL4Jj/2ZxWWFaj/7h1/A+DY3Q9ZbA5q4dY9AzOQ9Tpu0
	j4Tm9vt5IxWZ2NrwA24axOCUE1zhYQWElVUDGhbJqsLJgow+O4v+y5zV
X-Gm-Gg: AYBFou2kn0mgg3uIfqPZl7LGgkt6MvKrmN9qT2FUuMaMHSPoYabTEPjjVnQV9cuBXfM
	gpEDBublhPkPFEcUhseMK77/YsZOUDXNDQZqBrxfZjasFLazgWPqBbNFCC60ntDmG4mU3Xshedg
	bW5r6FA2zj/Hl3ZIST1Xrc4+JwAc2j/PP5FE6MR0FilHdFXvVoE7zPpB+TVuZ0tFgPVuMy1xj52
	gVoOpA0SWsSfTys7M/Psqjn6PyZBr1OyBsiwpqTSlg2P6KNO8GBZ++ktF2OUSujdy0uuGlpn4cU
	8eC/JAvl/qj+nTZ1MBQWFCdc/sPRphFYXrUrHkY2/2yKAhJkthLzFW6oXb6K8iMeUYlvh1+g6LB
	5h8n/iDJX5qgGMCsDItaa+P05mJX8TTVYjkJREaG4FhAE6HVVQhGj/3xP4BXaK1YV3DjyhkMHns
	/jnbbQBpfUil0BW3N5q2HGfdVIjm2+pIonSclnm8lIClUNvAq4K7DliTanS3Und507CEL3aJ4Y+
	sa1nMbriB0hgdlNkIpfZWw16h+70W6ibo5pwgbj5Q8iw7IjfQgsVC2+l/8=
X-Received: by 2002:a05:7300:2216:b0:351:28d9:4908 with SMTP id 5a478bee46e88-3537db99e8amr12245241eec.0.1791701325373;
        Sat, 10 Oct 2026 23:48:45 -0700 (PDT)
Received: from localhost (ec2-18-143-158-86.ap-southeast-1.compute.amazonaws.com. [18.143.158.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-359789fde97sm4534786eec.20.2026.10.10.23.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:48:44 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Shiyang Ruan <ruansy.fnst@fujitsu.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	nvdimm@lists.linux.dev (open list:FILESYSTEM DIRECT ACCESS (DAX))
Subject: [PATCH v2] dax: fix dax_range_compare_iter() to use correct size and address offset
Date: Sun, 11 Oct 2026 14:48:39 +0800
Message-Id: <20261011064840.1296-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

dax_range_compare_iter() has two bugs in how it calls
dax_iomap_direct_access() and uses the returned addresses:

1. The size argument passed to dax_iomap_direct_access() is
   ALIGN(pos + len, PAGE_SIZE), which is an absolute file offset
   rather than a length. This causes the underlying dax_direct_access()
   to request a massively inflated nr_pages via PHYS_PFN(size).

2. The addresses returned by dax_iomap_direct_access() are page-aligned
   starting addresses, but memcmp() compares from saddr/daddr directly
   without adding the page-in-page offset of pos1/pos2. When pos1/pos2
   are not page-aligned, this compares the wrong data.

Fix the size by computing ALIGN(len + offset_in_page(pos), PAGE_SIZE),
matching the pattern used in dax_iomap_copy_around(). Fix the address
by adding offset_in_page(pos1)/offset_in_page(pos2) to saddr/daddr in
the memcmp() call.

Fixes: 6f7db3894ae2 ("fsdax: dedup file range to use a compare function")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---

Changes in v2:
- Add offset_in_page(pos1)/offset_in_page(pos2) to the saddr/daddr
  arguments in memcmp() to fix the page-in-page offset issue pointed
  out in the v1 review.
- Use offset_in_page() macro instead of (pos & ~PAGE_MASK) for
  consistency with the rest of the codebase.

v1: https://lore.kernel.org/lkml/20261010071453.6028-1-jianyungao89@gmail.com/

 fs/dax.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6ba50142eeb2..b08d408418bd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2197,6 +2197,7 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
 	const struct iomap *dmap = &it_dest->iomap;
 	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
 	void *saddr, *daddr;
+	size_t size1, size2;
 	int id, ret;
 
 	len = min(len, min(smap->length, dmap->length));
@@ -2212,17 +2213,18 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
 	}
 
 	id = dax_read_lock();
-	ret = dax_iomap_direct_access(smap, pos1, ALIGN(pos1 + len, PAGE_SIZE),
-				      &saddr, NULL);
+	size1 = ALIGN(len + offset_in_page(pos1), PAGE_SIZE);
+	ret = dax_iomap_direct_access(smap, pos1, size1, &saddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
-				      &daddr, NULL);
+	size2 = ALIGN(len + offset_in_page(pos2), PAGE_SIZE);
+	ret = dax_iomap_direct_access(dmap, pos2, size2, &daddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	*same = !memcmp(saddr, daddr, len);
+	*same = !memcmp(saddr + offset_in_page(pos1),
+			daddr + offset_in_page(pos2), len);
 	if (!*same)
 		len = 0;
 	dax_read_unlock(id);
-- 
2.34.1

