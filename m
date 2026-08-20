Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B13BB11F
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226532; cv=none; b=jvumc9f3QhkDqvdpr7JoL8D/7UMeRSryt6wFAuVSvecmMmZUreqGEptcKyLB48VNroLpZnDT3CckXp8rwTUr/AaC0lsoMoU9xWDYXkvR/JuLYVwBAMooFofCPLyAksS8KtjOBVefW2J5geGnEpKpek009mO8eAbwBBQeV5D5WZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226532; c=relaxed/simple;
	bh=4Yt+UYsrJn+GZLWCQXl1J6nk0wQMITu91fFYn5e8dz4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MLwemQ5aJIt49ISVNv0yBW7RFIYprLyFwgotGyG0euDkn3eeWw7FIWtNtEGiyKwSVWsqUuZVD8lifbD3R+f3+2tGEsbxEsLpPZqCbst8yVZV/ufrV8LOJGEXlRRCYxdxcxvIyXubqNMwIttpMhnUMfPmvvwdp7lTA8LrG//o2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wu8xACHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wu8xACHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068071F000E9;
	Thu, 20 Aug 2026 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787226530;
	bh=zdHh0GbPu3Oq7gqb80BsaiUKrjoMlRV+pNXpkViLnaE=;
	h=Subject:To:Cc:From:Date;
	b=Wu8xACHXN0HDr+rlI9Fylg61PeIuDol7c1/CueR4eiWFcdI3JxaEpxm5daw4gUyqV
	 HP4/wfkEFZAs5zRTSBPWiWBpFMoP1VfmdFpa1Fc7uOtJHGmgcs1xA20myoPrR8Xa75
	 jaaN8bnuHhDmrL2khPBQRrxU15d1QVOH95WGAn5Y=
Subject: FAILED: patch "[PATCH] xfs: fix ilock leak on error in xfs_dq_get_next_id" failed to apply to 5.10-stable tree
To: leo.lilong@huawei.com,cem@kernel.org,djwong@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:34:58 +0200
Message-ID: <2026082058-bust-worst-3564@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 63320a0f70f66f311f4bccff3af0719c2119f46c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082058-bust-worst-3564@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63320a0f70f66f311f4bccff3af0719c2119f46c Mon Sep 17 00:00:00 2001
From: Long Li <leo.lilong@huawei.com>
Date: Mon, 27 Jul 2026 10:38:48 +0800
Subject: [PATCH] xfs: fix ilock leak on error in xfs_dq_get_next_id

xfs_dq_get_next_id() takes the quota inode ILOCK before calling
xfs_iread_extents().  If xfs_iread_extents() fails, the function returns
immediately without releasing the lock, leaking the quota inode ILOCK.
This can leave the quota inode locked and cause subsequent quota
operations to hang.

Fix this by jumping to a common unlock path on error instead of returning
directly.

Fixes: bda250dbaf39f ("xfs: rewrite xfs_dq_get_next_id using xfs_iext_lookup_extent")
Cc: stable@vger.kernel.org # v4.12
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index c311f61d9554..b4f6c594808c 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -778,7 +778,7 @@ xfs_dq_get_next_id(
 	lock_flags = xfs_ilock_data_map_shared(quotip);
 	error = xfs_iread_extents(NULL, quotip, XFS_DATA_FORK);
 	if (error)
-		return error;
+		goto out_unlock;
 
 	if (xfs_iext_lookup_extent(quotip, &quotip->i_df, start, &cur, &got)) {
 		/* contiguous chunk, bump startoff for the id calculation */
@@ -789,6 +789,7 @@ xfs_dq_get_next_id(
 		error = -ENOENT;
 	}
 
+out_unlock:
 	xfs_iunlock(quotip, lock_flags);
 
 	return error;

