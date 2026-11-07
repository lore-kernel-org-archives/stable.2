Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046885;
	b=OsbsGAe/il6e6DeTuRLnRtPxy63YT/8fRRmWtF6yqxpKHeXw/On5KqrBAxno8Hfks0Z5
	 lVFQoktIRNk/QFrsP+RrAYrAzD9+ma7VBAkgCtln08hABpfrp1ZehdP/NR2FVGT60OAC0
	 kE3uRt+lnmp5bddeXvyXb8EO84vGLk8LfEv62D/9GXz2r57oMt81CPcirPqfI3rI2MHKg
	 ++N+7qYnE/FCaViMlv5X2cFYxdHCO6ulXMG9cLEE659LSYhoMTRb//ienU93QuyZwqt1+
	 dIUxhdT6SaCsX11oJJLLtOU3cMkAvYuvPWqdQfy1Dyem3BPccv6tZz+NOqc2EKk8hzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046885;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0GFOkU8xMNQoFRerq8tWDfUy9+43dvF/bqWQqzqcHXA=;
	b=BFdYYSP1nbgPfugN8+/PcynMojUVT2/+kfxkEU5sPXCr+hfo5p5/dsB7elRt33uP8wAM
	 NjIORfGkAMVyGZw14qjnHHYLwQVFVlbv+s9X42XknS+NcqdaYmijagpqjmXP/eVUVARDH
	 XAfzuraTw9qhoLbwcJzKGdYdeA3qnLe9d2N+Hyuu46B3CP6Bik91joGDfDveODZ03y4l3
	 yRYWI19kApTrvd2BWbssjvKyRJd2AsT2O2xsO/48d7gD+fp1gjgZwod0Hgo5vmmXPt5gI
	 7pdz9cJ3OX+Jad5A6stDpMIa6DzkdO5bZXqZOnt4YxCtjWZICFJINNwgUisYJvoGXVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VM6yoUvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3B606A33A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VM6yoUvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2CA1F008A2;
	Sat,  7 Nov 2026 10:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046885;
	bh=0GFOkU8xMNQoFRerq8tWDfUy9+43dvF/bqWQqzqcHXA=;
	h=From:To:Cc:Subject:Date;
	b=VM6yoUvSxCA+xyV5hb30V7On++011w553J8mjTCDom6/ZYsaUVG6/u41hW/RUgmVB
	 69bSH/wMg6rH9T6O0WzCXDijzEpZTlu7snMa8tTwF9SxsmSyt/3A/mDxstVwR2ukqp
	 42lROJhD9ejRN+dwxDngDn0KAVQ0bQVQ6K5sh7zssb6yeNeCV6qaE6oyw+9yHBDlyf
	 /VawoK1MkpuJd9hjWrx2vFXtqM5ba7UTXyx07AcSYk5pZETs63cm/bU9ot49mK97Sl
	 FLJ8ky9SLWGuM4BPgMtLVQGHZdF6QjLbYbCwj9OdTYRkmjbLV6KiYt5E3qjpLWuPfO
	 t0SZqtkpP45Eg==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	kunwu.chan@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: return an error from damos_commit_filter_arg()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:23 -0500
Message-ID: <20261107052123-failed-6.12-6f276422aded@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6f276422aded370174edea69549ebe6b1683ffcc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052123-failed-6.12-6f276422aded@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6f276422aded370174edea69549ebe6b1683ffcc Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:20 -0700
Subject: [PATCH] mm/damon/core: return an error from damos_commit_filter_arg()

damos_commit_filter_arg() is supposed to always succeed.  It may not in
future, for example, if the given filter is invalid.  Prepare the case by
modifying its signature to return an error when it failed.  Also pipe the
return value to its callers and let them handle the error.

Link: https://lore.kernel.org/20260914142327.92510-4-sj@kernel.org
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/core.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 38383ced3dd6c..1932a50252079 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1317,7 +1317,7 @@ static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
 	return NULL;
 }
 
-static void damos_commit_filter_arg(
+static int damos_commit_filter_arg(
 		struct damos_filter *dst, struct damos_filter *src)
 {
 	switch (dst->type) {
@@ -1340,28 +1340,32 @@ static void damos_commit_filter_arg(
 	default:
 		break;
 	}
+	return 0;
 }
 
-static void damos_commit_filter(
+static int damos_commit_filter(
 		struct damos_filter *dst, struct damos_filter *src)
 {
 	dst->type = src->type;
 	dst->matching = src->matching;
 	dst->allow = src->allow;
-	damos_commit_filter_arg(dst, src);
+	return damos_commit_filter_arg(dst, src);
 }
 
 static int damos_commit_core_filters(struct damos *dst, struct damos *src)
 {
 	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
-	int i = 0, j = 0;
+	int i = 0, j = 0, err;
 
 	damos_for_each_core_filter_safe(dst_filter, next, dst) {
 		src_filter = damos_nth_core_filter(i++, src);
-		if (src_filter)
-			damos_commit_filter(dst_filter, src_filter);
-		else
+		if (src_filter) {
+			err = damos_commit_filter(dst_filter, src_filter);
+			if (err)
+				return err;
+		} else {
 			damos_destroy_filter(dst_filter);
+		}
 	}
 
 	damos_for_each_core_filter_safe(src_filter, next, src) {
@@ -1373,7 +1377,11 @@ static int damos_commit_core_filters(struct damos *dst, struct damos *src)
 				src_filter->allow);
 		if (!new_filter)
 			return -ENOMEM;
-		damos_commit_filter_arg(new_filter, src_filter);
+		err = damos_commit_filter_arg(new_filter, src_filter);
+		if (err) {
+			damos_destroy_filter(new_filter);
+			return err;
+		}
 		damos_add_filter(dst, new_filter);
 	}
 	return 0;
@@ -1382,14 +1390,17 @@ static int damos_commit_core_filters(struct damos *dst, struct damos *src)
 static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 {
 	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
-	int i = 0, j = 0;
+	int i = 0, j = 0, err;
 
 	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
 		src_filter = damos_nth_ops_filter(i++, src);
-		if (src_filter)
-			damos_commit_filter(dst_filter, src_filter);
-		else
+		if (src_filter) {
+			err = damos_commit_filter(dst_filter, src_filter);
+			if (err)
+				return err;
+		} else {
 			damos_destroy_filter(dst_filter);
+		}
 	}
 
 	damos_for_each_ops_filter_safe(src_filter, next, src) {
@@ -1401,7 +1412,11 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 				src_filter->allow);
 		if (!new_filter)
 			return -ENOMEM;
-		damos_commit_filter_arg(new_filter, src_filter);
+		err = damos_commit_filter_arg(new_filter, src_filter);
+		if (err) {
+			damos_destroy_filter(new_filter);
+			return err;
+		}
 		damos_add_filter(dst, new_filter);
 	}
 	return 0;
-- 
2.53.0




