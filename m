Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242D3A380A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557745; cv=none; b=szrQW9F4BtZ86p+Z7ZV5+CeAO2/tLOHC8DDju3d5qh0j+vd+2zDcKElwcMtjLe964BLZ8W+ta4jzCu4s99gWkjhrwxs6XZhkBFnR7PvBU7sDzTQHzpQbB1AkBG1CnSAI//rZKz1MiTxnvMR0SeLcMyq15S4JLdtbw640K9m780I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557745; c=relaxed/simple;
	bh=RWrppgNvtU6ZBKIvIO3+GPQyN/Ki7GdSxA3loLg4InM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h31RflS+YR+HDYMHlo5m4BU70YtqyFb5h7ZX+vz7cEs/OrIbij1ah2zI8kXVse66Eczoozzn3+fZmI6faNAmZ3Tavis7BPjEUke6chiLJ2hvtcYINXJdTyTWfOwdZBxUEs+gUdzn/BlvcWlN+DvB73LJpVNK4xH/MHrZfdvGHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bT654izs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bT654izs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FDA1F00A3A;
	Mon, 20 Jul 2026 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557743;
	bh=akix6vvXtnlClfzE+Qta6UUBUSgn4TLE7e9CMJ/UxYk=;
	h=Subject:To:Cc:From:Date;
	b=bT654izsNnMVNJN+SC8/MBPvANo6U4qeWF/bOsLwnt0i0TYlWKUZM0TdBhV8MjZXk
	 tt6nAhxeWV3lNlLTSjnf49BlVl2SijbG5W7htx9UmY7YaBS0GY+gNiFw0d9uklxSlq
	 JkvscYWxoJ6dGPfJSu5/ig3SN0/XAB2/dGzGruTM=
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: fix dir put orders in" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:28:54 +0200
Message-ID: <2026072054-throwing-myth-2a13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d58fdbe37a829fd2e5803dd4e5a72992dd8c5368
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072054-throwing-myth-2a13@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d58fdbe37a829fd2e5803dd4e5a72992dd8c5368 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 17 Jun 2026 17:56:47 -0700
Subject: [PATCH] mm/damon/sysfs-schemes: fix dir put orders in
 access_pattern_add_dirs()

Patch series "mm/damon/sysfs-schemes: fix wrong directories put orders in
error paths".

Error paths of damon_sysfs_access_pattern_add_dirs() and
damon_sysfs_scheme_add_dirs() functions put references to directories in
wrong orders.  As a result, uninitialized memory dereference and/or
memory leak can happen.  Fix those.


This patch (of 2):

In access_pattern_add_dirs(), error handling path puts references starting
from setup failed directories.  If the failure happpened from the initial
allication in the setup functions, uninitialized memory dereference
happen.  The allocation failures will not commonly happen, but the
consequence is quite bad.  Fix the wrong reference put orders.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260618005650.83868-2-sj@kernel.org
Link: https://lore.kernel.org/20260617060005.86852-1-sj@kernel.org [1]
Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 329cfd0bbe9f..7c00aa78b2f5 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1993,22 +1993,19 @@ static int damon_sysfs_access_pattern_add_dirs(
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->sz, "sz");
 	if (err)
-		goto put_sz_out;
+		return err;
 
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->nr_accesses, "nr_accesses");
 	if (err)
-		goto put_nr_accesses_sz_out;
+		goto put_sz_out;
 
 	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
 			&access_pattern->age, "age");
 	if (err)
-		goto put_age_nr_accesses_sz_out;
+		goto put_nr_accesses_sz_out;
 	return 0;
 
-put_age_nr_accesses_sz_out:
-	kobject_put(&access_pattern->age->kobj);
-	access_pattern->age = NULL;
 put_nr_accesses_sz_out:
 	kobject_put(&access_pattern->nr_accesses->kobj);
 	access_pattern->nr_accesses = NULL;

