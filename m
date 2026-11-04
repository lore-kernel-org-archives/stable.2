Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811288;
	b=H/2A420doZbIB5Qv1RtRdrkpnHm97eMIxi9NEIoLggxF+48hnn5Lh5uPu3/Qoc1d+/mr
	 slVsurTEoTYFPaaPY33iW3zpv7z5NvJLlFOlqSBL5+Tl1ZVaoY1iKJ2I+E/trJJZgDwjS
	 ygWifqiU0DWpluhnV5ttf48e6LLKLXd7b0S5WBqelmFevll+e1a693cG+01BJVQxVg3lZ
	 SG2Yn191eaDmvLuemliDp0t+sMXOhPEKxmc8EuzXPZe0/WPqLTgFlz+58zdm+3gCmYZh8
	 q82aQL4E7lE28y9DfA+VvfFCOMCyDr4kbNY1x0liPEbpxsgZctYqCcFu897+elvuU9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811288;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pP0G/vYS1TM/2HchOOlBcWYxTH5w939xlkvbqP0SKwA=;
	b=Fs+57yCT1F/a1amoOSy5fYlRC7RKPMiNo6xbZIAY7VXxaouOqF4uzVECpVLrmrefXXCP
	 MvXVX7w2uDCkUcvurf7PgzlEdQqjGpIUf21trMGPIW+nVEfFedee8y4hxsFdU5hv+VpeQ
	 mO3Wdnv35eG79qFHKSCBNWllkjTrtS4Rtia/KyyyeRKHF9ERdEaBGE3IUPx7mMtCS3eja
	 Mt0sFmd22/Kf2Y3wrbqVik3XPCWCisNe2V6GrQPJRzMZQPbFJpatgB5vkAekc+HSwpviN
	 mXInOTV9nADYhLBdB5902mJVVIoC86CGQmpvYY7LN30vHmd0tot9A7hyzCZtUKLcVrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bz4wmy2A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318B606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bz4wmy2A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4731F000C1;
	Wed,  4 Nov 2026 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793811287;
	bh=pP0G/vYS1TM/2HchOOlBcWYxTH5w939xlkvbqP0SKwA=;
	h=Subject:To:Cc:From:Date;
	b=bz4wmy2AZ/ORdDVHOFqbInNU7uD5xWUhk1/Bp+hE8h7iGsPzlDkFYGG9deiYw9ftV
	 FrkE2VaTRbvsFHmuoiNyaNggsWPf1stjA1eCzN+Ul415jVovDufVhC+Ne8fBOg8e55
	 K4kh9xDG0xwdipr3fl4Zp1EmBjtX3BPrmcBE1V+g=
Subject: FAILED: patch "[PATCH] xfs: always report scrub errors in tracepoints" failed to apply to 6.1-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:54:08 -0500
Message-ID: <2026110408-clay-heroics-73a0@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1ccc8f553d885d49c1bfe141ea1f331511940b3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110408-clay-heroics-73a0@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

