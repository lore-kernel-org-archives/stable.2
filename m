Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06520539764
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075096; cv=none; b=hMj8q5Ar2NHGpM5vjzOIWY6c26qd0/8LtX5fmHaUg4PhilClJogGKDme/xzv1aFoklJoa6L9E7W0Wmb7P4Ce0pYMKhhseK7mQqYyDQTyKEVvUWjlvlfA97LpYExEaK2mlTWGiJal71NrrbMiXzZp1A5I08UU96Jo0ruDJa3KRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075096; c=relaxed/simple;
	bh=t/flOyC9ZDRH8HC2rg7pu8TkwW7GxH9aj1ctyalgCJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnCVrJJqFouCVAKKMoEOloZWPzqFh0sgCvEQuRm5JjaYeCd6lRyBxVZG6c1vNBGYaw0xc3cEagk97LuZPYW6uMfLRvX9Q8BvMFGGhgA4/Au86TNWGni9pdIUx9g+qeT10AA9UqGwcvGCjBZyDCGnIm3wDD/lnLOmUkc7F7pM4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WouYVhny; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WouYVhny"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso27777475e9.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075093; x=1790679893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQ9ZzfSNp3bC4JkXTrbkqSx/tvC+Auttjq3SDzXrp04=;
        b=WouYVhnyLYD4vuvD+P3tRH1Nv1Ix42wAeGV6Ht2fw5kFcJiAnL9nXYTGQdrAJp99tf
         xBc78BnUuDqtlHBgEQecnOjo1V6Fuv2A6wzhqN9e3b6pZxvsAfa9wwZCFQIckI6/fD0S
         JPeT8k0hqYEVYHV37wYhgMKCfUNSFf1XugwxDy94JGQ0rUvDj197g8yeSqHdMxfkzPpN
         tCr4QnmgTjg9HO5UPDQ17r/po6Zlbwfx/8ng2/Lc42UoaqBjG2PGq0jfgpFbD0gQMG++
         1bm6iwESW9JyP6o6+6f6sPM2ANFpHyND2PSuuFD1EirIQMoOYA3nVmogVOjqNBsByW8/
         BeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075093; x=1790679893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQ9ZzfSNp3bC4JkXTrbkqSx/tvC+Auttjq3SDzXrp04=;
        b=JNqcGROxQGyOcLOGNwCgc7TU8DuqfUghIS3LOeqMieh7v3/jRawvmewq00UqXoYoIT
         yiAj0dYpfj4Tu09D80V+auyK0ALjhp7tqZNSAPOPKm9bjuf0pj5D8Dkw/tPbc9fohLkt
         xEiofRIQsG5zgudhHE3SqNgjOBBZgfnPCqltGSBkBomfTKQ8z5TCgtCFFlZ9NiMudaQa
         orWUOHFBYP0YaSA4y0VY8sRpHK/425SQSPcB1s0dhUvOMtp1+dTHXFsb1GV6//PbpksX
         etgsfKh+/dNeT2qJ4iGOxg1twlPU/fo0chiLV+y0ZadRaeV+url9/7jq49baYdtgvfYF
         0xRg==
X-Forwarded-Encrypted: i=1; AKwUvBwz9DoiFQ9u7oYbJV97T+bC4RRgkJAKeoOl72XKorNWq0mM44Vg+PDQIjlseWZy62LotyovItw=@vger.kernel.org
X-Gm-Message-State: AFuF++lWj0LFU3wSQZzPD6BWkfiNHQMY/0H5+kNaOVgbR+tWI3OEWxcd
	KFdAkS1aRlY2ZoR7mCGApYHf6bgKex74LvV5VwMWR2L3sz5yVqnZ7Kyk
X-Gm-Gg: AYBFou2SM2AN5Cl6G6pWKNcWhnYerLBV0d36eJo7c1JB/kLIePxCv8jemZuu/WO4Zhc
	Py2nawhBJEe4j6k+C/1ScgYhMfmbIVIk50EInVMvpmmBPyant1hDj7h0piahVayy65331JW+sNm
	rNaxKwKLOsTUJXX2czgx8W0N74Yx2yleFnrRod2BqDov6vArQ6NMWiRkM+dXP1puzDivel4NU8B
	YMVUFr5PmGXMADoMHN9San7OVYU9cDLDuDIR28jkCX10r+iyTC8oUBbYjWbm80xOQ13hzNwPJ35
	/Wrp9yUPtLusFTdPZwgqYuHfV3lXvs8QW7S4DpWH2rl8/0H3ZpDlskIkJ+JlLlHY9iHL+vOp3cO
	NITl4mXll1ovLaFHD3vs9c+yuupMzpzPxwu5T2c0fV9hcrhBp6IcIAO3LWT34+GbtK5hgMa2Yx5
	4B8dCLtb8axQ62SpSc3Nj8ZLipndp/h2+j+vpWCuxYWjsJzhk3sGZO0fzYl3Kogw300aE/CWG+6
	4NzXab3eus=
X-Received: by 2002:a05:600d:6443:20b0:49f:ce73:4b with SMTP id 5b1f17b1804b1-49fce730095mr94272395e9.35.1790075093063;
        Tue, 22 Sep 2026 04:04:53 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:52 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 23/26] xfs: fix cursor and pointer handling when recovering iunlink buckets
Date: Tue, 22 Sep 2026 13:02:18 +0200
Message-ID: <20260922110221.1431-23-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

LOLLM pointed out a bug in xlog_recover_iunlink_bucket:

1. We don't null out prev_ip after releasing it, which can lead to UAF
   problems if the inodegc flush call in the loop fails.

at which point I noticed even more bugs:

2. If the inodegc flush inside the loop fails, we also leak @ip.

3. We set prev_agino to agino having already advanced agino, which
   results in inodes with i_prev_unlinked set to itself.

4. If we exit the bottom of the loop with prev_ip set, then prev_ip
   aliases ip and we also set its i_prev_unlinked to itself.

Bugs 3 and 4 introduce loops into the unlinked list, though these loops
don't surface because we immediately flush each unlinked inode after
loading it.

Fix all of these issues.

Cc: stable@vger.kernel.org # v6.0
Fixes: 04755d2e5821b3 ("xfs: refactor xlog_recover_process_iunlinks()")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_log_recover.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index e7e49529658b..cf0d610265fe 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2736,12 +2736,13 @@ xlog_recover_iunlink_bucket(
 {
 	struct xfs_mount	*mp = pag_mount(pag);
 	struct xfs_inode	*prev_ip = NULL;
-	struct xfs_inode	*ip;
 	xfs_agino_t		prev_agino, agino;
 	int			error = 0;
 
 	agino = be32_to_cpu(agi->agi_unlinked[bucket]);
 	while (agino != NULLAGINO) {
+		struct xfs_inode	*ip;
+
 		error = xfs_iget(mp, NULL, xfs_agino_to_ino(pag, agino), 0, 0,
 				&ip);
 		if (error)
@@ -2750,11 +2751,11 @@ xlog_recover_iunlink_bucket(
 		ASSERT(VFS_I(ip)->i_nlink == 0);
 		ASSERT(VFS_I(ip)->i_mode != 0);
 		xfs_iflags_clear(ip, XFS_IRECOVERY);
-		agino = ip->i_next_unlinked;
 
 		if (prev_ip) {
 			ip->i_prev_unlinked = prev_agino;
 			xfs_irele(prev_ip);
+			prev_ip = NULL;
 
 			/*
 			 * Ensure the inode is removed from the unlinked list
@@ -2766,18 +2767,20 @@ xlog_recover_iunlink_bucket(
 			 * complete.
 			 */
 			error = xfs_inodegc_flush(mp);
-			if (error)
-				break;
+			if (error) {
+				xfs_irele(ip);
+				return error;
+			}
 		}
 
 		prev_agino = agino;
+		agino = ip->i_next_unlinked;
 		prev_ip = ip;
 	}
 
 	if (prev_ip) {
 		int	error2;
 
-		ip->i_prev_unlinked = prev_agino;
 		xfs_irele(prev_ip);
 
 		error2 = xfs_inodegc_flush(mp);
-- 
2.55.0

