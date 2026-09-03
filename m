Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B24E56FC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450025; cv=none; b=mc2LGpCFy27ksvKd/em8pUVWBjqoRqbLP9MxpUrXP4QBbuzCEKfWOA3bAeLLCN0vAaF3+IHucycKRkDi8ZmYhwmjhIeDr9BgM0/dCWAwYtLyecp4uFOv9b8pqX+AejUcVRHsCvfPX9QRJKyHl2gu4seSeFDrxTyINxloiYoNzZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450025; c=relaxed/simple;
	bh=SaEkbOFkLSejS5mHflA6ZkFyaJsoC/Px0EVSdwjjNjs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Puw5DOb8wKoaraytI4DcrhOx7JOySF79yZZH+RAO6MzoYw5C9l90sGRJzuSw5FaAFwTWMxFeQlwi024oBna+8TeW6XzZOH3FRJgt/UypEWb5tjfN1NbtPGucIfx2VnOx6d9d6Z3lKoaaQdir/G/UQmDzM9LACURtsXZHMCsD2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXFZMKLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tXFZMKLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8413A1F000E9;
	Thu,  3 Sep 2026 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788450024;
	bh=sPltmOtPyoV+s3F4uekVR8RLnRyha5Dwqlf6A+tGzHc=;
	h=Subject:To:Cc:From:Date;
	b=tXFZMKLPaAmhUTVo5hIt0pDDMRkMr7s/wqGpMWuIpFia6ez7IKNPeBRzITk32wGUe
	 EwnHVifHHVayF3Fb9vXf9kK80NrTiGsryPyVjXrDVkDylRgljSBFzs+Qr0wdcQ1gyu
	 LBW2vTsDhbvGeC0bKRxMQThxtn02msP48TDHLV1o=
Subject: FAILED: patch "[PATCH] net/smc: fix use-after-free in smc_rx_pipe_buf_release()" failed to apply to 5.15-stable tree
To: hidayath@linux.ibm.com,horms@kernel.org,kuba@kernel.org,mjambigi@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:18:44 +0200
Message-ID: <2026090344-judgingly-mace-1efd@gregkh>
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
git cherry-pick -x c924884743e948e25625b7fbf3ee2a9325a204a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090344-judgingly-mace-1efd@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c924884743e948e25625b7fbf3ee2a9325a204a7 Mon Sep 17 00:00:00 2001
From: Hidayath Khan <hidayath@linux.ibm.com>
Date: Thu, 20 Aug 2026 09:46:42 +0200
Subject: [PATCH] net/smc: fix use-after-free in smc_rx_pipe_buf_release()

smc_rx_splice() hands RMB pages to a pipe and takes a socket reference
per entry so the smc_sock stays alive until the reader finishes. The
connection does not: a concurrent close runs smc_conn_free(), which
releases the receive buffer back to the link group pool.

smc_rx_pipe_buf_release() tests sk_state before taking the socket lock.
The state can change between the test and the lock, and
smc_rx_update_cons() then dereferences conn->rmb_desc and walks
conn->lgr, which smc_conn_free() has already released. On the
is_reg_err path smcr_buf_unuse() frees the descriptor outright, so
this is a use-after-free.

Take the socket lock first and test conn->freed instead.
smc_conn_free() sets that flag before releasing anything, and every
caller holds the socket lock. The two paths exclude each other: either
the pipe release runs first with everything valid, or it sees the flag
and skips the update.

Fixes: 9014db202cb7 ("smc: add support for splice()")
Cc: stable@vger.kernel.org
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260820074642.966856-3-hidayath@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 5c9e4d8b57de..197fddc6271f 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -115,16 +115,15 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
 				    struct pipe_buffer *buf)
 {
 	struct smc_spd_priv *priv = (struct smc_spd_priv *)buf->private;
+	struct smc_connection *conn = &priv->smc->conn;
 	struct smc_sock *smc = priv->smc;
-	struct smc_connection *conn;
 	struct sock *sk = &smc->sk;
 
-	if (sk->sk_state == SMC_CLOSED ||
-	    sk->sk_state == SMC_PEERFINCLOSEWAIT ||
-	    sk->sk_state == SMC_APPFINCLOSEWAIT)
-		goto out;
-	conn = &smc->conn;
 	lock_sock(sk);
+	if (conn->freed) {
+		release_sock(sk);
+		goto out;
+	}
 	smc_rx_update_cons(smc, priv->len);
 	release_sock(sk);
 	if (atomic_sub_and_test(priv->len, &conn->splice_pending))

