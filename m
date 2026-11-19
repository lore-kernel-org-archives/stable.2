Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101186;
	b=kuzvHVNpbjiaIaocSBEo7pMg4ARA1jcDOKOnawjpydqK+DfD9T+bUR+MP8u1Ae/vgzBa
	 jqoxxOrW3VI2fasIvQOslCTHkjQGZDu3/VB2/0aEBR9lZl/zeDdWupEZHl+L44dq4nk8e
	 FhL6vtCxwW8fvuDNO9/ouh8+Mlz9w9OFo6omV0nfnpADQNkiJX25e/hjU9hBPXXH9mh9g
	 j0ORyGfrYD+Xf/ecPUbdbJsLItD4HmQctrpJ8WRYrZFMvOBNHgG+Jm+NnyI79dmwAjuqr
	 9Umuzw5bL29lDDtVPHx/DUkv8FeObuuynSBniK82JNavl0SCowOHsl3DeqUKP6QDrrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JpxIvevc+k3PDqIuz3tCAw053u2XWq+vX93HZah6pos=;
	b=zT3l7G3ynbO31VZmPLGOIXfEiZtIUf5KavzI36O3dkvPOa+PZ7jaEHIPl4Rgi5wQJZ60
	 VdSJrGziUE7iSWTN0i/FSt6hU4nJ9cjVtsOB63sey2Gs60r0zJZWUNHa2OB8bDcNFQQKf
	 HUrP6UQXXO2h+4vtCC3+rHRJkBfRRcvwsii39pZtz8a39+fZUKTSYGrHDXJbWfVcCKGA7
	 4WbVKUtATd3BOmXvd3ZJEpj3mK8sISVrGrm5QZ5BPH2gDaJ+VrR39ptvg/AioHzisTVWJ
	 1Groi2QAtPY8e6uFhQWWWqDVVfyhV0aD5AGB9xGA+j6qZ1u/t79PVLfNgR/my6MKEGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=heYsYuub;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB8E606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB8E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=heYsYuub
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2eff722a480so5812065ad.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795101185; x=1795705985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JpxIvevc+k3PDqIuz3tCAw053u2XWq+vX93HZah6pos=;
        b=heYsYuubAj88xnLDnGgzj33y+P1bBnOQgnMwpeSoNMQBvdFMY9nGds0yIZ4w9VXDc/
         3pNXMT8IaGtnKgrk4iIyma+lBML4cs2BSD2HRKhs/BqR6ekgYn5aPgCkjgGxgRPV8GyD
         KGqQUD8+SiJaRYV9iVJa6aLafMCfNI32HqlnrOUxKz4UOiDXzjL1uSfWTC6P3A2HtLPt
         x/FgSYLhO+SamhZiZAo6h4TS8LvmCP5cxDJngN+6UCSI+HYIrR1MD9xcBdfPmmRh5HVX
         DOrXAtrzaMzYBjTVmdQg5ELPpH+OMtQ1HMUI09+AT/2lfsd8GpKmquTA3YZJHDw9IGUc
         1u1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101185; x=1795705985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JpxIvevc+k3PDqIuz3tCAw053u2XWq+vX93HZah6pos=;
        b=aPuzgzB5Y/kmONDMdZ8XmvRRiGGOKdO4XQY42JYNGTBjhtRl1ToUdA4Jl8Vq/ANWC6
         mUL9peo13qeiaGiOM0Ig3kNj+uWbwz7KwkyUk/W8YVz8c6Q+g60Szq1flm6fZpacy/Ba
         hdZJLBOUuEJL9gVMYCqz4ydPEkZQmHQyTxQBDQfbkQeC5GB84d9Xxedlf1TgQs6DXJiz
         VzHhuYL9BqlLPeUVdsFvIKT3LJuoJiQZT/csN4T5qMz0w0IyQoyAYq0P0dMj2Ah8bo8A
         9CRQe8tZECrMo9u5RSwamLqn3fhDyDbJb44qxzYRrv/bRZdp9YAOCmQkFUeq0/kC8Zr9
         57qA==
X-Forwarded-Encrypted: i=1; AL+hErEOWYR2WRHy0ihH5kpXLLmvBtuCeN1PwfezSKk3Ccn5LrUxt7ExactADFDTTCz0ftsSL0+KtxA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y97put/jhQCBzwUMiqgGqxkXPLWPjTfr9UPkJET5hguqmq2j4
	fdPu1w94njUjdD4fH4CAAbX2iz/L70/rmVxPHvxsesLl7wyyEHe4yM2N
X-Gm-Gg: AYBFou3Eljcz9ZDFy4YNJzOChyC84FTtsr9LwCDfv/fz0qLAfa2Qd+D2XpTqps4a1/q
	14dNJAHrLVqNYpYE8cLdmgxzygpsWmnGUT1O7pRQNEXso4r7pIu6uqcm2u40wskdY4bPK6tq7I6
	DWBHI5+J8GP4oZkB5F4pvfZyNSOhc3bg5OxFMMiGO476WYC0Spp/zZDWaM/J/JHZn7IQWDLZEor
	ElppAihunyPpctf2T4SSigRHQD+neTqU/72ttzCHVk0Hyglr1IyPIgILCX3t1ErLKGLouNLef4n
	Zz5uaW4l9ix4yCohINWfjRIje8cWk9ndeYahd5/t3b9ewbVafNa28qU2mufixMrG2v6Z5xeQs/Q
	iBEdO3sncezKEqq2e2P2qXdpCHCqOPhkQ6ELBoLart6/68G8cNsHZIETe/VbnZU1XRrzkGPRQid
	whjYqXrS/xheJw94P3bndIThbCYngaXo9w7EW6gGXfzd+en75ptX0+aY7cV0sqZjYr/ZngkOSur
	DGagaSOayixZ77cyb4KKHPKu3Dr8eaj+eJdKX+hj+RdVsZgG9Iqym0dkF1gLWdWq+kQjsuP7vX6
	7j89GDGO20EgG7spDmbsWlsL2cc02lb0amUqkBQWxpRJ+Q==
X-Received: by 2002:a17:903:198b:b0:2e8:95d8:6423 with SMTP id d9443c01a7336-2f0320782aemr12269375ad.38.1795101184871;
        Thu, 19 Nov 2026 07:13:04 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1276c5sm1157095ad.67.2026.11.19.07.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:13:04 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH] fs/ntfs3: don't prepare private mappings for writing
Date: Thu, 19 Nov 2026 23:12:59 +0800
Message-ID: <20261119151259.3965463-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

ntfs_file_mmap_prepare() allocates the clusters of a sparse file and
zeroes the file up to the end of the mapping when the mapping has
VMA_WRITE.  A MAP_PRIVATE mapping never writes the file, but it gets
the same treatment, so any user who can read a file can make ntfs3
write to the volume, also when it is mounted read-only.

With -o ro, a MAP_PRIVATE mapping with PROT_WRITE by uid 1000 of a
4 MiB sparse file zeroes 4 MiB on the device and marks 1024 clusters
used in the bitmap.  The runlist is not updated, so the clusters are
lost.  The same mapping of a 4 MiB file with 4096 initialized bytes
writes 4190208 bytes of zeroes.  On a writable mount, it allocates all
clusters of a sparse file that the user cannot write.

Only prepare shared writable mappings.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Tested in a VM on 7.4-rc3 (20eef29b7c84): with the patch, both read-only
cases leave the device unchanged and the sparse file is not allocated.
fsx with mmap on 4K and 64K cluster volumes and on sparse and compressed
files gives the same results as before.

 fs/ntfs3/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 6c84a3e1c7fe..3da8b65793e1 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -388,6 +388,8 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
 	const bool rw = vma_desc_test(desc, VMA_WRITE_BIT);
+	/* A private mapping never writes the file. */
+	const bool shared_rw = rw && vma_desc_test(desc, VMA_SHARED_BIT);
 	int err;
 
 	/* Avoid any operation if inode is bad. */
@@ -417,7 +419,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 		file->f_ra.ra_pages = 0;
 	}
 
-	if (rw) {
+	if (shared_rw) {
 		u64 from = (u64)desc->pgoff << PAGE_SHIFT;
 		u64 to = min_t(u64, i_size_read(inode),
 			       from + vma_desc_size(desc));
@@ -452,7 +454,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 	}
 
 	err = generic_file_mmap_prepare(desc);
-	if (!err && rw)
+	if (!err && shared_rw)
 		desc->vm_ops = &ntfs_file_vm_ops;
 out:
 	return err;

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
-- 
2.43.0

