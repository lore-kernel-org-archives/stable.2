Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FC351C34
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964716; cv=none; b=Cr+hCA6uilzpt8YxljCe9xZxlXdXfVHqlZxr65nt2PEMiTlAbrsCIhVQCG9eXGLaSHMg4s5YucHJgNETyRlJmHtlTSy7Tdkgf5DqEvSQjqC/0IG0Jwgmpj1oWGqT87Sjdw7G8jQsB/uDOFZ/K8RuiMbxcEiU59obLABa5zJBMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964716; c=relaxed/simple;
	bh=edPMpW5yt0f3Pp1wWdYZRCncoquv6QtazaRW2PBcM0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wloy/iQY8vCVT/b7z596PZPZZXL4wCzL6wA4IuTyv1w0L9zVJ3ufQDOfwBL44mONG9Y2p+Y2YGEP9je2zX4XYAo/BDziEVOklltzjEWWJG8zfSvGwk49efXxV0+JG2ePn+2DxCe8UwTOCwhdgF1u5eaBIYxWGqDWNU3uzin8EPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDHcmhjO; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDHcmhjO"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so1534570a12.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 21:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789964714; x=1790569514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rvbp9qGSwfhr03W/yIMn0HJVEki14kXp792hr6doGSA=;
        b=IDHcmhjOeqA9LKZxupt1+EHFaEQ4VPavHtcwvuONJb4v1W3DNbtYmOjFXqpY4lnqVK
         lKaCktqKye179+5TAgi4/qSdl5dj88Oht4V4mWciYepytjmhDX5kz1c8kAYybjjMERxs
         HboaE1zOgnNDH1ulHITGiXrUIVxV6XsUm/HnLFcdV1Po6GWaovIjmg81W+c4vpqAWdOS
         NiSANm4Poyww0uGA87Gm5X8POg2ZY2wsRJ2Vn+ThMmRgmYtW9hM540M1MGTadjRWatry
         YWc10Pqmg9JrjA1OV3gjQywwCTqgw36iK9PwpLZANHwXKattLKcA9fpdhNTou4jEFBFi
         iPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964714; x=1790569514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rvbp9qGSwfhr03W/yIMn0HJVEki14kXp792hr6doGSA=;
        b=GFboMuMuIq9dWFVicefIEZsg/6Vz0d552673OfIm9Trdg8ElOai9Kv8TApCHZMfKh+
         tnV25jw4tAD9epqcHhb61BSOsbXbFXDj7cGMk/P9fD+swOUIy1hz64bdsrh4YDjUMaXp
         XgZzZQYp/RSGPD18xUszngJtSgFq2N2r+pbR7UQTVQrW0PZ+rcEX6DWStXX3emUqi1rP
         ZWglOvt2wLGjLsiMEwlomefRTJff6nc+YpQl5lHXHf9oziIf55yF582rIZhPFxLzpQix
         uvVb/AJ25ZbLRXiJYEzMnI3bdfg6ag255DUxANGq3KmXjqVIzdbIplMalISHSppkoYYw
         kzEw==
X-Forwarded-Encrypted: i=1; AKwUvBwB7pAM3mVu28fvDYSrZSdFMjgDEVgyGLlVC7nPUxSW00lh2sMiSRBvD6NFDbMIVEMCdtTuH6E=@vger.kernel.org
X-Gm-Message-State: AFuF++lygQ38QL1IAKZwiqNc2BI3AVj+hdHCL9Nhxt6oQexprwzi7aH1
	OlH439yM4oE9ZJoJ+hRY88cK6i3zPqjn8iLDqCr2ozqAn+weEYB/QUuh
X-Gm-Gg: AYBFou3cOwlXW1yC9GHPrSxxbM63OsZNG46pC2IvSfQKRM1nsNhrCGSrsi4PjehQZK+
	Qo/a8vIPbH9tdQy0l6ASX3VgOBvJrMiyi//b0G6BAXrmI6EMjfkkXBy7s1B0Lq5+Jqq+fokdZpR
	fOmeRev7zOT6bkuh7ee7KZb3HLXJ7PEN91QStl+82TBfgYxIn2DtgQsmzD1wYG5C1HzskyPMcCK
	DcZWZzQZFT8C6JNXhCzqdhCJf6zzwEGcUuBP0aS56Du8ax1iDaJIn8EBq/s+E1NhvJ1WyFF/RAR
	VFXHtV4YFk219Pct+tHllJ2NpQsJZCUwd0viKNEWak8UN+LRJLL4MAoRx0ZP1PKUxSZ3o6Appby
	41azZllZ6NPmIKhPEykIM4re4LSh+lEPBJcHkKu4eF8WvL/O4jmV5wSrPSVAZiazT9exD6UtTVH
	8NK6WERC0Yri6tyk2u7lME3aPE+CuiDRUcfbqAKsh/ym4ELo9hWXEB6mGm2rjL4TIZ7bzVjF/f1
	AvqdbuG1ySRLV8G3SE45kg9ew/o+7HUKdM5KIM5/bg4YvSzGoswOxobmmz83seXc4zjXGhoAube
	zsiUKQ0lsg==
X-Received: by 2002:a17:90b:58ef:b0:39e:194b:fb2b with SMTP id 98e67ed59e1d1-39e54d11af8mr15982682a91.22.1789964713657;
        Sun, 20 Sep 2026 21:25:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c5b3932sm11742139a91.13.2026.09.20.21.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:25:13 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 2/6] qnx6: release buffer_head on error in qnx6_block_map()
Date: Mon, 21 Sep 2026 04:25:07 +0000
Message-ID: <20260921042511.1473629-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921042511.1473629-1-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org>
 <20260921042511.1473629-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_block_map(), when qnx6_check_blockptr(ptr) fails ("qnx6: hit
unused blockpointer.") inside the indirect block traversal loop, the
buffer_head bh read by sb_bread() is not released before returning 0,
leaving bh->b_count elevated and pinning the backing blockdev folio in
memory. Call brelse(bh) on that error path before returning 0.

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted QNX6 image on
/dev/loop0 with a file (di_filelevels = 1) whose indirect block (block 5)
contains an unused block pointer (~0U), reading the file to trigger
"qnx6: hit unused blockpointer.", and then flushing per-CPU bh_lrus and
pagecache via /proc/sys/vm/drop_caches and POSIX_FADV_DONTNEED: on the
unfixed kernel indirect block 5 remains pinned in bd_mapping
(indirect_page5_leaked = 1), whereas on the fixed kernel indirect block 5
is released and evicted cleanly (indirect_page5_leaked = 0).

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the qnx6_block_map() buffer_head leak fix into its own patch (2/6)
  and remove Markdown formatting from the commit message, as requested by
  Damien Le Moal.

 fs/qnx6/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 13972c086673..9b624829520e 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -144,8 +144,10 @@ static unsigned qnx6_block_map(struct inode *inode, unsigned no)
 		levelptr = (no >> bitdelta) & mask;
 		ptr = ((__fs32 *)bh->b_data)[levelptr];
 
-		if (!qnx6_check_blockptr(ptr))
+		if (!qnx6_check_blockptr(ptr)) {
+			brelse(bh);
 			return 0;
+		}
 
 		block = qnx6_get_devblock(s, ptr);
 		brelse(bh);
-- 
2.49.0
