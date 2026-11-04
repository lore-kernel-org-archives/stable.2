Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811291;
	b=0WUGivSNY20M2vDBtzLbSGQvx4H511Cddat9RpmzsWvuwx/P6T/dSIUOZzwqh07mYAIo
	 ke+bq219888pWJtg3OyIIrZErvFv9ZcVO3kDbeJ31coNN/vdKtxoXAjJXA5oJFBwEe2BJ
	 mdpNP1wgotIm0Yt8z5tJuWoWJ61hVZ68bdlpS6KJ9DxWphKefCMXwGM6p8+dw3RmHwX88
	 dV7wVdSoomRRA1Rf7oCu4wYJ6s9ASfqBw182QH7HyOjxTqije1i+AKD9AgrEdWHURNDah
	 iKmP/wZrWYTwclT+CAv+QsixyPC/H6mpobK3HBeh5WqHy2p11hykOZ0d08CYlJcpWsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811291;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=20LWj3ge3cmy5TppoaNVpvR8V8HrWgYDFbJjEGxV/xg=;
	b=mi2gUfQTbuQlWOvdY1Wfu1NjXgTcw0fnW5OUR9sRJ402c07vCkUirtm0jKhTYI/AwBRo
	 rlUQcWZdZHVsbZvF6/cJXAIr8qc+oJnh6wylwkLKiylpEDvQR3lJtn2aF3mnzAc4oeD2P
	 hTudY9FiY9X1I2yjigSDff918IQ2Wx/6oOST8W0UQembgFBvsXCCIHzBVj6NjciHXJoaj
	 eXbPQzOCAlbs21XUbjvGlnnKjqoxstxATLy2oL5172nAu4uDH45OPhnLNb4vZfi2d9KGz
	 I9V8YoO2VoB3RQXooDRFTJ2EEx0DPP+sgCIMPowcs/JzDkPvAgl1lz17wishNF5iSJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="tV9i/Fv5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708F606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tV9i/Fv5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AFB1F000C1;
	Wed,  4 Nov 2026 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793811291;
	bh=20LWj3ge3cmy5TppoaNVpvR8V8HrWgYDFbJjEGxV/xg=;
	h=Subject:To:Cc:From:Date;
	b=tV9i/Fv5CTc1PPbETaeARs8fP3Iq6Z20dFE+4PHIfUhlxzUxvP2zO9OeiwYQRUBY/
	 kRXEv6gCPKhL99Q6bZ8ngFVM9YHFVOHi0jWEFV8I21VDqBWrcsiHk+VgmRhrvz2DBW
	 0vIlg3kmWpDU+88YUwJ2jktMgGXUPNoQgqmT1DlY=
Subject: FAILED: patch "[PATCH] xfs: always report scrub errors in tracepoints" failed to apply to 5.15-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:54:10 -0500
Message-ID: <2026110410-unstopped-oncoming-1919@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 1ccc8f553d885d49c1bfe141ea1f331511940b3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110410-unstopped-oncoming-1919@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ccc8f553d885d49c1bfe141ea1f331511940b3a Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 23:08:04 -0700
Subject: [PATCH] xfs: always report scrub errors in tracepoints

LOLLM complains that the error processing functions in scrub will
sometimes zero out *error before recording a tracepoint.  This makes
diagnosing problems harder, so let's fix that.

Cc: stable@vger.kernel.org # v4.15
Fixes: 4700d22980d459 ("xfs: create helpers to record and deal with scrub problems")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/btree.c b/fs/xfs/scrub/btree.c
index 17bd8505be04..43a7ea7308ee 100644
--- a/fs/xfs/scrub/btree.c
+++ b/fs/xfs/scrub/btree.c
@@ -46,8 +46,14 @@ __xchk_btree_process_error(
 	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
+		if (cur->bc_ops->type == XFS_BTREE_TYPE_INODE)
+			trace_xchk_ifork_btree_op_error(sc, cur, level,
+					*error, ret_ip);
+		else
+			trace_xchk_btree_op_error(sc, cur, level,
+					*error, ret_ip);
 		*error = 0;
-		fallthrough;
+		break;
 	default:
 		if (cur->bc_ops->type == XFS_BTREE_TYPE_INODE)
 			trace_xchk_ifork_btree_op_error(sc, cur, level,
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index e5233e31abb7..a61895872072 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -107,8 +107,9 @@ __xchk_process_error(
 	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
+		trace_xchk_op_error(sc, agno, bno, *error, ret_ip);
 		*error = 0;
-		fallthrough;
+		break;
 	default:
 		trace_xchk_op_error(sc, agno, bno, *error, ret_ip);
 		break;
@@ -183,8 +184,10 @@ __xchk_fblock_process_error(
 	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
+		trace_xchk_file_op_error(sc, whichfork, offset, *error,
+				ret_ip);
 		*error = 0;
-		fallthrough;
+		break;
 	default:
 		trace_xchk_file_op_error(sc, whichfork, offset, *error,
 				ret_ip);
diff --git a/fs/xfs/scrub/dabtree.c b/fs/xfs/scrub/dabtree.c
index bbf6ece58828..02c8544d8918 100644
--- a/fs/xfs/scrub/dabtree.c
+++ b/fs/xfs/scrub/dabtree.c
@@ -49,8 +49,12 @@ xchk_da_process_error(
 	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= XFS_SCRUB_OFLAG_CORRUPT;
+		trace_xchk_file_op_error(sc, ds->dargs.whichfork,
+				xfs_dir2_da_to_db(ds->dargs.geo,
+					ds->state->path.blk[level].blkno),
+				*error, __return_address);
 		*error = 0;
-		fallthrough;
+		break;
 	default:
 		trace_xchk_file_op_error(sc, ds->dargs.whichfork,
 				xfs_dir2_da_to_db(ds->dargs.geo,

