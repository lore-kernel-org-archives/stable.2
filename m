Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57041D205
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970613; cv=none; b=cTd601BJyv6OKOjTuXedk3yf690Wt2WDISVcNPRADjRq7sX30KNEtdhma/WUNnOOoQ3n7WX+g+xs39oayIlesr+AUUfDhbuSd1kmR9pccV2krDoJTosENKirhftVpfUu7Tb24QzfmhvEeikAVIZ7iGcBayd0GOApr+zhQil1lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970613; c=relaxed/simple;
	bh=CsXP2s1iZXE1+R4iprwIk89vphk+CfU/v08LymtODWE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sMubPYj3pTLhZvemKU0Bqc2dWTT/D9Geoi1T6lDqsYJbjWYBi50IhI1Dtkiy/gUPt6Puzn/IpYcF/gc/OW4JBxUAnknAnQ3Tp8RvZQMAszf98vul0SgSI9CHI7yPhc/DnEqFukaGBlBEvPgyu1Yl5EEAVB41DLs+Va//SB/ae7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NFrHV8TF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFrHV8TF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C2B1F000E9;
	Mon, 17 Aug 2026 12:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970612;
	bh=ODQZAkESdQL3C75yHdbxJXseUYKirl96MpH3+OfhU1E=;
	h=Subject:To:Cc:From:Date;
	b=NFrHV8TFI09/ZCd/laZTR9aHDEd+4fB2jwvkB3xDQ0i0n106NW3XGVW+puI+I5UrP
	 AhhS/MDfrdMqI7y9pgcUQ8JV+cfY0uFynexAIPfEQ2pkUeENFkuk5Drj9SmqqD184O
	 LGwdG9V+d8WloIluxbS5OH+K+DxVrbfckfve7zrI=
Subject: FAILED: patch "[PATCH] net: smc: fix splice entry lifetime imbalance in" failed to apply to 5.10-stable tree
To: d4n.for.sec@gmail.com,dust.li@linux.alibaba.com,enjou1224z@gmail.com,kuba@kernel.org,lx24@stu.ynu.edu.cn,sidraya@linux.ibm.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:41:11 +0200
Message-ID: <2026081711-stamina-rebuttal-bfcf@gregkh>
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
git cherry-pick -x 5d9686af2976741bbd79b150d1c9e60b81e7f12e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081711-stamina-rebuttal-bfcf@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d9686af2976741bbd79b150d1c9e60b81e7f12e Mon Sep 17 00:00:00 2001
From: Daming Li <d4n.for.sec@gmail.com>
Date: Thu, 30 Jul 2026 22:55:52 +0800
Subject: [PATCH] net: smc: fix splice entry lifetime imbalance in
 smc_rx_splice

smc_rx_splice() passes pages to splice_to_pipe() before taking the
references that cover the lifetime of each splice entry. In the
VM-backed RMB path, splice_to_pipe() may drop unqueued entries through
smc_rx_spd_release(), while queued entries are released later via the
pipe buffer callback.

The old post-splice accounting also derives the number of queued VM pages
from an offset mutated while building the descriptor, and a multi-page
splice pairs one sock_hold() with multiple sock_put() calls.

Take the page and socket references for every candidate entry before
splice_to_pipe(), and drop the matching private state, page reference,
and socket reference from smc_rx_spd_release() for entries that never
get queued. This fixes a refcount imbalance that can underflow page
refcounts and trigger a use-after-free.

Fixes: 9014db202cb7 ("smc: add support for splice()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Co-developed-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Daming Li <d4n.for.sec@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Link: https://patch.msgid.link/20260730145552.360287-2-enjou1224z@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index c1d9b923938d..5c9e4d8b57de 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -150,7 +150,12 @@ static const struct pipe_buf_operations smc_pipe_ops = {
 static void smc_rx_spd_release(struct splice_pipe_desc *spd,
 			       unsigned int i)
 {
+	struct smc_spd_priv *priv = (struct smc_spd_priv *)spd->partial[i].private;
+	struct sock *sk = &priv->smc->sk;
+
+	kfree(priv);
 	put_page(spd->pages[i]);
+	sock_put(sk);
 }
 
 static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
@@ -209,6 +214,10 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 			offset = 0;
 		}
 	}
+	for (i = 0; i < nr_pages; i++) {
+		get_page(pages[i]);
+		sock_hold(&smc->sk);
+	}
 	spd.nr_pages_max = nr_pages;
 	spd.nr_pages = nr_pages;
 	spd.pages = pages;
@@ -217,16 +226,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	spd.spd_release = smc_rx_spd_release;
 
 	bytes = splice_to_pipe(pipe, &spd);
-	if (bytes > 0) {
-		sock_hold(&smc->sk);
-		if (!lgr->is_smcd && smc->conn.rmb_desc->is_vm) {
-			for (i = 0; i < PAGE_ALIGN(bytes + offset) / PAGE_SIZE; i++)
-				get_page(pages[i]);
-		} else {
-			get_page(smc->conn.rmb_desc->pages);
-		}
+	if (bytes > 0)
 		atomic_add(bytes, &smc->conn.splice_pending);
-	}
 	kfree(priv);
 	kfree(partial);
 	kfree(pages);

