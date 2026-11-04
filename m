Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776155;
	b=k/v61v1g1Kj7mKjpxH/5IFDCVQVUlbIsJzEsXc6Tj7gROuSrs2rvAzXvjPYVDLrEg+zt
	 HXtbfT/+ZmyvskPPy7NFtU+O+XsKXEH0xL/x+jGKeNtrJU9szDqvP7G/OptzmdUYumNmc
	 dR57oMwzpnOXyTFFZGgLCozcBGEVboTKMUy9nK7mXDgUqvzU6ZOTcRvaSDQhnTJEAzVQK
	 5PdvRmwlJolrYkxoGxg39ZBmbSKNlIHWgmRRdDuSfnPRtkx1PwfP8y2EojMfCofSboZ1V
	 PjozFN9KuaSqfP3o4jcdULNQDsO70ZylpNq6pmnjVDHs818STRxcAV9ZWDess56ialA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776155;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B+/q+3jqNq8N+fdXWKPQNteaKIvpaUaMzh/T5wohdh0=;
	b=XSPOP32Q5rrXlBbwGODLHEgfYdMoZJcTi/lA494IELyYLEmKheuT1b4zHitlyWJv4GJ4
	 8r0LLkbKHBaUSHGwTjBAVuJcDDfD3GYeK+1lT0JkXwBguvxX1n5pufuErH5RjQWfWhdHA
	 07bQLTI7EDF5tREhkFBzu5D2jr6djow2uJU3pUq8aP1Z31WvbcunL1giHs1RLHfnqlCK2
	 pBVG8yRkJzd4dXztYiw1M9BUnDXQ8Sz1pW1B68H9AOmVmJfdauil6V31qDlr5L+09QbIH
	 0WSI1ThyX8StLXXo3Cc7u4FOUOicicRtnvlNP7CgJsR8jY5gFzybBtCKNnNWaygGVuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tM8DYMkh;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A6606A333
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C9A6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tM8DYMkh
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793776151; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=B+/q+3jqNq8N+fdXWKPQNteaKIvpaUaMzh/T5wohdh0=;
	b=tM8DYMkh5YnvRB6BlncXVSj0Uaym6cmi9tf/R0gdavB7lvGLlEKJ1RfzrjkgxII3D4gyWONfCpBdUBtNzabo82P4LBOmpy95T4i+txrKDr4Ozr7e51yV64Nifvkb/241Sz4HDy0liBtCSSIi5o+6YJ9JHaX8PzR3mGbVg1NPcmQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0XE5.ISp_1793776150;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XE5.ISp_1793776150 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 15:09:11 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] ufs: fix ufs_read_cylinder() failure handling
Date: Wed,  4 Nov 2026 15:09:10 +0800
Message-Id: <20261104070910.272012-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit 0bfd3e1078c537cd66a8addb1c01835de4234a4c upstream.

1) ufs_load_cylinder() should return NULL on ufs_read_cylinder() failures.
ufs_error() is not enough.  As it is, IO failure on attempt to read a part
of cylinder group metadata is likely to end up with an oops.

2) we drop the wrong buffer heads when undoing sb_bread() on IO failure
halfway through the read - we need to brelse() what we've got from
sb_bread(), TYVM...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
This is a prerequisite for commit 58c0c414b2b8 ("ufs: validate cylinder
group metadata before caching it"). Otherwise the NULL check in caller
is meaningless and will still use invalid ucpi.

 fs/ufs/cylinder.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/ufs/cylinder.c b/fs/ufs/cylinder.c
index 5781c7db97276..b930ee1cf8530 100644
--- a/fs/ufs/cylinder.c
+++ b/fs/ufs/cylinder.c
@@ -26,7 +26,7 @@
  * Read cylinder group into cache. The memory space for ufs_cg_private_info
  * structure is already allocated during ufs_read_super.
  */
-static void ufs_read_cylinder (struct super_block * sb,
+static bool ufs_read_cylinder(struct super_block *sb,
 	unsigned cgno, unsigned bitmap_nr)
 {
 	struct ufs_sb_info * sbi = UFS_SB(sb);
@@ -46,9 +46,11 @@ static void ufs_read_cylinder (struct super_block * sb,
 	 * We have already the first fragment of cylinder group block in buffer
 	 */
 	UCPI_UBH(ucpi)->bh[0] = sbi->s_ucg[cgno];
-	for (i = 1; i < UCPI_UBH(ucpi)->count; i++)
-		if (!(UCPI_UBH(ucpi)->bh[i] = sb_bread(sb, UCPI_UBH(ucpi)->fragment + i)))
+	for (i = 1; i < UCPI_UBH(ucpi)->count; i++) {
+		UCPI_UBH(ucpi)->bh[i] = sb_bread(sb, UCPI_UBH(ucpi)->fragment + i);
+		if (!UCPI_UBH(ucpi)->bh[i])
 			goto failed;
+	}
 	sbi->s_cgno[bitmap_nr] = cgno;
 			
 	ucpi->c_cgx	= fs32_to_cpu(sb, ucg->cg_cgx);
@@ -77,13 +79,14 @@ static void ufs_read_cylinder (struct super_block * sb,
 		goto failed;
 	}
 	UFSD("EXIT\n");
-	return;	
+	return true;
 	
 failed:
 	for (j = 1; j < i; j++)
-		brelse (sbi->s_ucg[j]);
+		brelse(UCPI_UBH(ucpi)->bh[j]);
 	sbi->s_cgno[bitmap_nr] = UFS_CGNO_EMPTY;
 	ufs_error (sb, "ufs_read_cylinder", "can't read cylinder group block %u", cgno);
+	return false;
 }
 
 /*
@@ -166,15 +169,14 @@ struct ufs_cg_private_info * ufs_load_cylinder (
 				UFSD("EXIT (FAILED)\n");
 				return NULL;
 			}
-			else {
-				UFSD("EXIT\n");
-				return sbi->s_ucpi[cgno];
-			}
 		} else {
-			ufs_read_cylinder (sb, cgno, cgno);
-			UFSD("EXIT\n");
-			return sbi->s_ucpi[cgno];
+			if (unlikely(!ufs_read_cylinder (sb, cgno, cgno))) {
+				UFSD("EXIT (FAILED)\n");
+				return NULL;
+			}
 		}
+		UFSD("EXIT\n");
+		return sbi->s_ucpi[cgno];
 	}
 	/*
 	 * Cylinder group number cg is in cache but it was not last used, 
@@ -205,7 +207,10 @@ struct ufs_cg_private_info * ufs_load_cylinder (
 			sbi->s_ucpi[j] = sbi->s_ucpi[j-1];
 		}
 		sbi->s_ucpi[0] = ucpi;
-		ufs_read_cylinder (sb, cgno, 0);
+		if (unlikely(!ufs_read_cylinder (sb, cgno, 0))) {
+			UFSD("EXIT (FAILED)\n");
+			return NULL;
+		}
 	}
 	UFSD("EXIT\n");
 	return sbi->s_ucpi[0];
-- 
2.39.3

