Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783393;
	b=WFN3kQP5g0pfYioKQRFRtxSTHvbi/JREs+1LHy2Rt1nrjKqRHRTwcTE6YeGVwyypF7q0
	 HeRDjgEpresEHiqKcBU8zO7b53ORlVmgsWLmQ3uempAs9uToOnXFLIn6ZhinTg9avVKLh
	 LVCQ5IFpYj/GdtV4YmSjn4IqPJs4V1q+EmU01649EsyFdn5RlqHr90GVmabQgMsQryL+I
	 dqzUCx6+vDpazNpHKZTwS5hjhy1THY52kYe5tAkwyMQkb37CrV6i+agMwbkqMGW4FUAS6
	 mwBfYZj050LE079ZJhV03ESaWZSq3cqhezN8MOR5LS6xwSw1sYiPi5rIQfmM4fEH0Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783393;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PhJXxZjl8atL8PR+6e4yHQuvKFdTDoSNus6/fp0TAmI=;
	b=VOIJSnZy8W3newJKvJzOwnhiabl3aNUKv9YNJ31LpYyyAiFrIpofDhXQZsQI0QI3Om8/
	 Kx6ybbWLnJpehMHqFh+GZ9078uGheP1F55s39/ouu4ZYP5xoBWyLP5qQ0I+kqN69lRlMx
	 yEZ2wDbawvd4HEBz8eeFUt6LlG94tQ66fPdgIvbfnI/FafKYoCqT03TlYtUk0bVYtGTcw
	 NRdF4PAQb/+5buln3+JDrNZ88SmRxiJf9EKUKMf7TEZMYYACPrC0IHVNV9lbjyowDQK8K
	 kO0noRI0NX0UwsEGoWhEmcKKJMbKuEfinAhmQeJNj1BSh5EwPJsSqVEQI6VArKBtcAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ffQ9dJKs;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D35606A326;
	Wed,  4 Nov 2026 09:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02D35606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ffQ9dJKs
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793783384; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PhJXxZjl8atL8PR+6e4yHQuvKFdTDoSNus6/fp0TAmI=;
	b=ffQ9dJKscjx3sn4WNlsQhOCn6rHcmOXqO6zP1knncadcwBslOoTHs2snb3KHK0udW3nbTZIgJTliGOwzHAeS8wZU4rASjKi+7DZyjFYItezgZE+UXX2GeAaSOXr9naKMD7Cr45WO1Q7DTOJJrn4FV0ONKN5ARbbpC5pw6or2qs8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XE5PlFA_1793783383;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XE5PlFA_1793783383 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 17:09:43 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH] ufs: free cylinder group structures on late mount failure
Date: Wed,  4 Nov 2026 17:09:23 +0800
Message-Id: <20261104090923.540863-1-joseph.qi@linux.alibaba.com>
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

ufs_fill_super() reads the cylinder group structures before it creates
the root dentry, so that a failure there no longer publishes a
superblock whose s_fs_info has already been freed.  The two failures
that remain after the read, a failed ufs_iget() and a failed
d_make_root(), still jump to the label that only frees the in-core
superblock information.

Everything ufs_read_cylinder_structures() allocated is released by
ufs_put_super_internal(), which runs from ufs_put_super(), and
generic_shutdown_super() calls that only inside its if (sb->s_root)
block.  With s_root left NULL, the s_cssize allocation behind s_csp, the
s_ncg buffer heads behind s_ucg[] and the UFS_MAX_GROUP_LOADED s_ucpi[]
entries are leaked, once per mount attempt.

Neither failure needs an I/O error to happen: ufs_iget() rejects a root
inode number that falls outside the s_ncg * s_ipg range the image
claims, and s_ipg is not validated.

Give those two paths their own label, and move the unwind that
ufs_read_cylinder_structures() already performs on its own failure into
a helper that both call.  The helper also clears the pointers it
releases.

Fixes: 55a4c98abb96 ("ufs: create the root dentry after loading cylinder metadata")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ufs/super.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3569ac92b065b..50adfef5f2aa9 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -448,6 +448,32 @@ static void ufs_setup_cstotal(struct super_block *sb)
 	UFSD("EXIT\n");
 }
 
+/*
+ * Release everything ufs_read_cylinder_structures() allocated.  Besides its
+ * own error path this is needed when a mount fails after the cylinder groups
+ * have been read: s_root is still NULL then, so generic_shutdown_super() never
+ * calls put_super and ufs_put_super_internal() does not run.
+ */
+static void ufs_free_cylinder_structures(struct super_block *sb)
+{
+	struct ufs_sb_info *sbi = UFS_SB(sb);
+	struct ufs_sb_private_info *uspi = sbi->s_uspi;
+	unsigned int i;
+
+	if (sbi->s_ucg) {
+		for (i = 0; i < uspi->s_ncg; i++)
+			brelse(sbi->s_ucg[i]);
+		kfree(sbi->s_ucg);
+		sbi->s_ucg = NULL;
+		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++) {
+			kfree(sbi->s_ucpi[i]);
+			sbi->s_ucpi[i] = NULL;
+		}
+	}
+	kfree(sbi->s_csp);
+	sbi->s_csp = NULL;
+}
+
 /*
  * Read on-disk structures associated with cylinder groups
  */
@@ -511,15 +537,7 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 	return 1;
 
 failed:
-	kfree (base);
-	if (sbi->s_ucg) {
-		for (i = 0; i < uspi->s_ncg; i++)
-			if (sbi->s_ucg[i])
-				brelse (sbi->s_ucg[i]);
-		kfree (sbi->s_ucg);
-		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++)
-			kfree (sbi->s_ucpi[i]);
-	}
+	ufs_free_cylinder_structures(sb);
 	UFSD("EXIT (FAILED)\n");
 	return 0;
 }
@@ -1211,17 +1229,19 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ufs_iget(sb, UFS_ROOTINO);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-		goto failed;
+		goto failed_cg;
 	}
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root) {
 		ret = -ENOMEM;
-		goto failed;
+		goto failed_cg;
 	}
 
 	UFSD("EXIT\n");
 	return 0;
 
+failed_cg:
+	ufs_free_cylinder_structures(sb);
 failed:
 	if (ubh)
 		ubh_brelse_uspi (uspi);
-- 
2.39.3

