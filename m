Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4444B0C84
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443345; cv=none; b=DqLe1JmVLnvV2HgaCxpSEYKXvV0bz4i5CxLVlmsYPN/A8yEulKNNvd4QnD6P3sHebY4lGDHXHq00OhVc272mqGSHBB0hH7IpLygtB4h3IPgm8ejL0K9sqlcUfeClzXBPi/OAsA6sEb4vftuu/J4GRGZy1CXHh1AuPpOLtaMkyTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443345; c=relaxed/simple;
	bh=hY6nccoeJN6wTnfNxJrphto35GQvKNh39DAdXvxjTW8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fhq9xZ9xKm2QY5pvSH132aacMDLW3W+ouqzm5cFt7W+4YEavXhHQTYshUsSqMw3x9LytNMDtK5INxuO64xGBfDz2j5mU/8bagrU3rayjaHybgRpbqJl+SBzB0TGe+L9RTy4ww81Wh9rZ5pTk9V09XWm0tlRNSMbrBESbRwhim14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GiHJBrep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GiHJBrep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCA91F00A3A;
	Thu,  3 Sep 2026 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443324;
	bh=jFvuGV3X6yklvUMU5gvdJHJCoQgBZL79uCobwxvlXRI=;
	h=Subject:To:Cc:From:Date;
	b=GiHJBrepolp5Dy2Wdh40WrEhhxh7XC5uLsxtGfrxB42IVSlMebP57GM9VGp9F2vFi
	 ByFTGCqRBD7xcBbEFkQf3b0nSex+N2JoW4EQAFF89Z5KKxtP1b3IE8lPwiRBWNVD5C
	 Rgi9j8AFWwp9z3fsGTdvtW46bz6OqCBz2N1wV9Z8=
Subject: FAILED: patch "[PATCH] smb: client: clear ce->tgthint in free_tgts()" failed to apply to 5.15-stable tree
To: fredric.cover.lkernel@gmail.com,chenxiaosong@kylinos.cn,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:26:17 +0200
Message-ID: <2026090317-frostily-collide-4c2d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b1b741cf8e7ce1b91d937e23decd3d3358748700
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090317-frostily-collide-4c2d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1b741cf8e7ce1b91d937e23decd3d3358748700 Mon Sep 17 00:00:00 2001
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
Date: Fri, 24 Jul 2026 15:01:46 -0700
Subject: [PATCH] smb: client: clear ce->tgthint in free_tgts()

When free_tgts() frees all structures in ce->tlist, ce->tgthint
is left pointing to one of the freed cache_dfs_tgt structures.

If ce->tgthint is not reset before it is used later, it results
in a use-after-free.

Set ce->tgthint to NULL in free_tgts() after the elements are
freed to reflect that no elements remain.

Fixes: 54be1f6c1c37 ("cifs: Add DFS cache routines")
Cc: stable@vger.kernel.org # depends on: smb: client: harden DFS cache against invalid target hints
Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
index c9ace4326a35..86dba25b7a5a 100644
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -122,6 +122,8 @@ static inline void free_tgts(struct cache_entry *ce)
 		kfree(t->name);
 		kfree(t);
 	}
+
+	WRITE_ONCE(ce->tgthint, NULL);
 }
 
 static inline void flush_cache_ent(struct cache_entry *ce)

