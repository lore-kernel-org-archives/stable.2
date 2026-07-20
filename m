Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1324677F
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514958; cv=none; b=L331BwCHZJxwSRt/KlR7bo1xwwdQ7mhTQ/uYsb+j5UCli7ps2hsFADAq2GINRQW2EGUk2w8P5kWNrFr3egooSq/hzhzOsk4tJQSgk6VNFNuzQCzU+8/WOHAmVXsJV24agdLyjA7pPG0FiO5eiPnf27V713WlWeq5W9mXodNtknE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514958; c=relaxed/simple;
	bh=Wq45N5cLLGijiAlzkAtiBKmUXW2BNieT2+yQATNyUKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBUqWegzUgMerfCvmKB05fCNWbY3UaJicT2QiGusr1RpOMPVmYVmZBuWNZxXeF93+IRx85s5HpqqGqkZsfrtjo3RyBsZRoLhpSYKlS/hIk4Ml/sFSVkWGW548d4GOYl0uwh8OHu5WF2kS7fk+PxVKMK2MOQQ38uzWHAyQMVDKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKvp8oEt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKvp8oEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3AA1F00A3E;
	Mon, 20 Jul 2026 02:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514957;
	bh=gg2ojg3OhDE17PfVU4Fq/c8s28gm6k2335FUbmNuRLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lKvp8oEts/RLI14rgubxfnRdt7+dzmCjePSaz32ZRvEsHRJhCJ2WeJoK9snEALUFt
	 p+P6un2WDjHr94g/cnNFcN/DIZfaiWv+acMScdn2JAeIA6300oCaGJ79Jw08o9FtX2
	 HnQwlIe5F/1vn0hzieb0i9pNW/WRwaiH/7N/GfTxSdf+zqUF6rYNGcsRn3n+Ryowg2
	 3wsSa9y8WFDLHENiWF4RelDANiLmR1ybvyX0rHxedWlYn0SDgHYyHb//NNlR/S2Q6B
	 H8mJ98w2wNM31lqjm88N5jEngtlfL70uUQjEDAbIHPpQK4TPv4scLBLVCz1jfP5LTH
	 /i0R/QN7AxR2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/6] functionfs: don't bother with ffs->ref in ffs_data_{opened,closed}()
Date: Sun, 19 Jul 2026 22:25:48 -0400
Message-ID: <20260720023553.2928009-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720023553.2928009-1-sashal@kernel.org>
References: <2026071455-cultural-frenzy-db69@gregkh>
 <20260720023553.2928009-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit fe47466282a69499ae17a22f064e827badb77078 ]

A reference is held by the superblock (it's dropped in ffs_kill_sb())
and filesystem will not get to ->kill_sb() while there are any opened
files, TYVM...

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 3137b243c939 ("usb: gadget: f_fs: initialize reset_work at allocation time")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index d416ec8b8556a8..9fd06780f59923 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2143,7 +2143,6 @@ static void ffs_data_get(struct ffs_data *ffs)
 
 static void ffs_data_opened(struct ffs_data *ffs)
 {
-	refcount_inc(&ffs->ref);
 	if (atomic_add_return(1, &ffs->opened) == 1 &&
 			ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
@@ -2168,11 +2167,11 @@ static void ffs_data_put(struct ffs_data *ffs)
 
 static void ffs_data_closed(struct ffs_data *ffs)
 {
-	struct ffs_epfile *epfiles;
-	unsigned long flags;
-
 	if (atomic_dec_and_test(&ffs->opened)) {
 		if (ffs->no_disconnect) {
+			struct ffs_epfile *epfiles;
+			unsigned long flags;
+
 			ffs->state = FFS_DEACTIVATED;
 			spin_lock_irqsave(&ffs->eps_lock, flags);
 			epfiles = ffs->epfiles;
@@ -2191,7 +2190,6 @@ static void ffs_data_closed(struct ffs_data *ffs)
 			ffs_data_reset(ffs);
 		}
 	}
-	ffs_data_put(ffs);
 }
 
 static struct ffs_data *ffs_data_new(const char *dev_name)
-- 
2.53.0

