Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759163515CA
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969865; cv=none; b=QXgeiyQnJ+gk+WnS7kKLE1mrY6RtOGrN8E7cdQZS2vsh+bjly92kxkCpqby2WPZuBLViKAkr2Q7HItKR+ITe8qithhk8POV0G7WK2FOwy/+0J8QFAHccEy4KF29wsRsbBXepHGjNJmBxkJ7vCZmuVw7sf4mE2kH+tBrrAoAmVL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969865; c=relaxed/simple;
	bh=nMxe3KqNy6cBJXpe5/DJOiATE3K4gD063WfrOmaLrCg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=swiDvP9FAXGu7jl6jiqh8d4nN3Sk1jnOuyNWvbUTzwsL5dg2QsFgQkrsErz5PcMqQYoLkZUyGR7CeSKEVpDENLQj5A7ymKZbEnQHOntnjLsK2xOz3K3oxiKWA7wkPRcROBozGfyik6KytpFkego0sKOGsDlp+0RdQuYZOKgdTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SadjrbfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SadjrbfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50D21F000E9;
	Mon, 17 Aug 2026 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786969864;
	bh=uXRn/wAIpV2V730q+19VbT+OrZ8+jf73eWz4AoeLfwE=;
	h=Subject:To:Cc:From:Date;
	b=SadjrbfOOw6YVAOfEOyodAh1SHTXb9x/jsrFG+uhw+XySIJDQ1gXgSFDhem/C4e3z
	 JlIwvb7JljuviUXzQC/zIv37hl0lumxIZtxIm2XCjc40CmXHQyOgpTxoqs2qUfdAsY
	 G7EpLJuDFqWrkl7x5+i/ryVyosOrSKsRLcoQkskM=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Fix initial memory allocation for Audio PD" failed to apply to 6.6-stable tree
To: ekansh.gupta@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,jianping.li@oss.qualcomm.com,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:30:51 +0200
Message-ID: <2026081751-trash-shortcake-b40e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ab99eaafb0c4b412cfeb895a8cf091626e2bbd86
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081751-trash-shortcake-b40e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab99eaafb0c4b412cfeb895a8cf091626e2bbd86 Mon Sep 17 00:00:00 2001
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 23:33:37 +0100
Subject: [PATCH] misc: fastrpc: Fix initial memory allocation for Audio PD
 memory pool

The initial buffer allocated for the Audio PD memory pool is never added
to the pool because pageslen is set to 0. As a result, the buffer is not
registered with Audio PD and is never used, causing a memory leak. Audio
PD immediately falls back to allocating memory from the remote heap since
the pool starts out empty.

Fix this by setting pageslen to 1 so that the initially allocated buffer
is correctly registered and becomes part of the Audio PD memory pool.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260724223342.629168-2-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a49384586d..4f01ebfa6f95 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1370,7 +1370,9 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		err = PTR_ERR(name);
 		goto err;
 	}
-
+	inbuf.client_id = fl->client_id;
+	inbuf.namelen = init.namelen;
+	inbuf.pageslen = 0;
 	if (!fl->cctx->remote_heap) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
@@ -1393,12 +1395,10 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 				goto err_map;
 			}
 			scm_done = true;
+			inbuf.pageslen = 1;
 		}
 	}
 
-	inbuf.client_id = fl->client_id;
-	inbuf.namelen = init.namelen;
-	inbuf.pageslen = 0;
 	fl->pd = USER_PD;
 
 	args[0].ptr = (u64)(uintptr_t)&inbuf;

