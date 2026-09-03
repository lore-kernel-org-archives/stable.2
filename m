Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB7201278
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445938; cv=none; b=TuC8xENg9YHcqfx6hwxvnTT89ZvWLdvmPNTvlBypV26bYer9BY9udp+GUXtf7+vtEHDpRwIMc51AvDuXCYVXN/tZXypqtLkOB2qfXaU/jur9quWbzO6+CMilKEG+jM73FITuOvvClMez61a77Rc7Hfi3AHED2x+HIB3B5Kcjnys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445938; c=relaxed/simple;
	bh=V8Ot/CLlw9CmGZl2c1iNVcp/sSE/N/G/TNe0U2BJdZE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t/T6BT/jkomhoFEHHaKTdmKiucjEMi2DOYiIgoEGzOMjTNArN9t3jcJhJ6/VqW56GzOEVeu2Ty0mglxfY8lv7UphPIgzhtO+6qZC4FTexsGQbNdhMvYT6pgsUo3/eJETT4220DkOAoOwuY2nqkm1BuMcCKufKRApbrbvAUanF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jhong8e5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jhong8e5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5975B1F000E9;
	Thu,  3 Sep 2026 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445928;
	bh=eR7TmySFggOagkilimsJVi9XoOrwSAGYomwFunqlsSw=;
	h=Subject:To:Cc:From:Date;
	b=jhong8e5zQHKoJTlOLMUYzccdH10qLa/kdgr7x5XuEzhWhsmoFTtSlE/m0Xad9+My
	 Q6/Z4NhoNPI0Yxi8x5qRg06jAk3rJBMd7DkDD5iTFa3lTkKk8kunQqwKt/6roiYWMW
	 Uz4y1VMkcT2X69TxYlnFkAcYWJiOqfHc9qluBSL8=
Subject: FAILED: patch "[PATCH] svcrdma: Use svc_xprt_put to free listener on create failure" failed to apply to 5.15-stable tree
To: cel@kernel.org,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:10:56 +0200
Message-ID: <2026090356-skimpily-grape-6667@gregkh>
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
git cherry-pick -x e346ef7bcb137f50c49f969330ab7dcf64ea1654
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090356-skimpily-grape-6667@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e346ef7bcb137f50c49f969330ab7dcf64ea1654 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Wed, 27 May 2026 11:00:13 -0400
Subject: [PATCH] svcrdma: Use svc_xprt_put to free listener on create failure

svc_rdma_create() calls kfree(cma_xprt) when
svc_rdma_create_listen_id() fails. svc_xprt_init() has already
acquired a net namespace reference via get_net_track(); kfree
bypasses svc_xprt_free() which releases it.

Replace the kfree() with svc_xprt_put() so the kref_init birth
reference drops to zero and svc_xprt_free() dispatches
svc_rdma_free() to clean up properly. sc_cm_id is still NULL
at that point; the preceding patch added the necessary NULL
guard in svc_rdma_free().

svc_xprt_free() also drops the module reference via
module_put(), but the caller _svc_xprt_create() does the same
on xpo_create failure, double-putting the single
try_module_get() it acquired. Take a compensating
__module_get() before the svc_xprt_put() to keep the count
balanced, matching the convention in svc_rdma_accept()'s error
path.

Fixes: 4fb8518bdac8 ("sunrpc: Tag svc_xprt with net")
Cc: stable@vger.kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260527-rdma-follow-on-v1-3-1b09bd87b6cd@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 55e2ca036584..63dbf16dbe7f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -388,7 +388,13 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 
 	listen_id = svc_rdma_create_listen_id(net, sa, cma_xprt);
 	if (IS_ERR(listen_id)) {
-		kfree(cma_xprt);
+		/* _svc_xprt_create() acquired one module reference and
+		 * puts it on xpo_create failure.  svc_xprt_free() puts
+		 * a second one when the kref drops to zero.  Take a
+		 * compensating reference so both puts are balanced.
+		 */
+		__module_get(cma_xprt->sc_xprt.xpt_class->xcl_owner);
+		svc_xprt_put(&cma_xprt->sc_xprt);
 		return ERR_CAST(listen_id);
 	}
 	cma_xprt->sc_cm_id = listen_id;

