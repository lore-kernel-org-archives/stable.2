Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F895437DC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872198; cv=none; b=gy4moc47Ks2fx6BGD76BqO4QHln4TDxFsrz5N4U+oHul24pscymFsc6t0gdQu5vdQUJKwh3PlTtsGiQsZE6nA5ZKVI5x5FR2OFHvO7ujJ8YyFFarNNe9IeuiZ2EtHKItNmHHsFtBeL6W8js55kS3QFvSqmGWZkvNX2B0J00eAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872198; c=relaxed/simple;
	bh=gVw2pdTfV8bjWnm589VfwUD+il5INIE7vbAZh/epK4s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jUNpDPyHO0miTvixM9i68bJe6kzvvU6Tsj4p1W/gsaqlNurTFO5dBaMbGFNl7YuKyDoskmjpgvEwcjCmFLbKSj5EkrJUM1ZmHMvLYlyiK51bkipPrkFDtDSpLZ/OHI/59KMiHtKROa7Y8EVfZEhE+aXbnkr3aA86yC0kvuvj3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YGMUA8Ni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YGMUA8Ni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EC11F00A3A;
	Tue,  8 Sep 2026 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872196;
	bh=R3x3B6xhXj0i17t92KbGcCLKU/Fun/NJfIp//5uIGCU=;
	h=Subject:To:Cc:From:Date;
	b=YGMUA8NibcUjGV+160F6gyD0pfTzo6L2qw2jHEC1xhgIL+99Id7rg4GEM5O9l5rKw
	 sxUYgZwSdsh/jhuXCdPS0MWLsVCUc91iJ7mbnvTh/KKyT7/28ihy4Y7zLD7vgw6nU5
	 ZOuVx1rLuHACYkpUgHsxCzNf/tR+QeZ5FJ9Bqht4=
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: kobject_del() scheme dirs" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:50:17 +0200
Message-ID: <2026090817-livable-sturdily-4c48@gregkh>
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
git cherry-pick -x 05fb6ac98c49be870c5f9ccdfdf95f0107e564ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090817-livable-sturdily-4c48@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05fb6ac98c49be870c5f9ccdfdf95f0107e564ae Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Sun, 28 Jun 2026 15:01:12 -0700
Subject: [PATCH] mm/damon/sysfs-schemes: kobject_del() scheme dirs

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts.  Fix
those issues for scheme directories by adding kobject_del() calls.

Link: https://lore.kernel.org/20260628220121.97360-4-sj@kernel.org
Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3cbeccd436e4..db496d2e493a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2681,6 +2681,7 @@ void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes)
 
 	for (i = 0; i < schemes->nr; i++) {
 		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
+		kobject_del(&schemes_arr[i]->kobj);
 		kobject_put(&schemes_arr[i]->kobj);
 	}
 	schemes->nr = 0;
@@ -2722,13 +2723,15 @@ static int damon_sysfs_schemes_add_dirs(struct damon_sysfs_schemes *schemes,
 			goto out;
 		err = damon_sysfs_scheme_add_dirs(scheme);
 		if (err)
-			goto out;
+			goto del_out;
 
 		schemes_arr[i] = scheme;
 		schemes->nr++;
 	}
 	return 0;
 
+del_out:
+	kobject_del(&scheme->kobj);
 out:
 	damon_sysfs_schemes_rm_dirs(schemes);
 	kobject_put(&scheme->kobj);

