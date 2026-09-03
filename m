Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139334B04AF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443342; cv=none; b=lMrYvVyg9aCj/9ZpKLAR1iMOaZmNaCDdbQtVIWmrRG1DNmoiBBTpsolJydgdZkTzhQSw/ay0uh/nQ23xHHMsJZP/+uwnbxfT7hgQrLWBtuzIXZN2eJ/lzJk4Bb5x3RLZa2fpjlmruptdygbULHzYUPm2IXs58+MDZRJNx6rLjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443342; c=relaxed/simple;
	bh=eqS8VSCwrFvKZGU7F/9ulC+/vLygh+XDzoX7exujuWE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ly8jK1S+tQ3uJJBlByH61LOo0IN9koXvTsGQ7e7u8EvIIbxN2NF5ag/4Y/fUbSTHE03hukXuoJ7qEbVx9D+sXhodwov2mhgMeQi/N/6rUdzWkB8eicD0MHa13tEarkMIr2eF/DzELqsCkAkRajr2jxOZQSsgeeC1zE5e58caUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rg956bxU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rg956bxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669991F00A3E;
	Thu,  3 Sep 2026 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443326;
	bh=1vIYz5AnBPObDjB+BjO26hdECcgrfSSLFCjMMpAWTi8=;
	h=Subject:To:Cc:From:Date;
	b=rg956bxUMaH5ayNNxweYY9PUC6Ya8lju1XdmMqxAqD83Nr96e2P57ZSEBk2sk2l+M
	 OhlTVeAZCFVktJ91MsDJxoz9bHDX4mU7w9/M/W1BNoPusZZLSAApBy5fgMblcSXbM3
	 W03+LUO9S7fVXGuhuaMwnTmQP0kH/gV7AUL6GtH4=
Subject: FAILED: patch "[PATCH] smb: client: clear ce->tgthint in free_tgts()" failed to apply to 5.10-stable tree
To: fredric.cover.lkernel@gmail.com,chenxiaosong@kylinos.cn,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:26:18 +0200
Message-ID: <2026090318-driven-showgirl-ba4f@gregkh>
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
git cherry-pick -x b1b741cf8e7ce1b91d937e23decd3d3358748700
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090318-driven-showgirl-ba4f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

