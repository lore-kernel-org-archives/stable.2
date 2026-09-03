Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D194A5C5C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442838; cv=none; b=jVk33zqiEWESpizr3TynDPdQH0NdmPdROC0YMj9JKrfxoS7BybtcJAc09IJ7LfJ+DyHYcSKnfa/qrpnXJ4yR3rLg09W1j1Ad3hbPAG4zieOQ8UHcYPNeAVj26UlUBUqOIVwaxkm9OXMFxHWjiFmiQ4hW8RTfqH/cfuZJNF0gPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442838; c=relaxed/simple;
	bh=4w3WhNJMBhKoN6CWOs2Zemm6O9bRxwrN3OQ/8Am2e+0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ay2fkEr8xkaCuI7Cxvvx+YaoSn0USfObfSM0Idg7IIhT/KZ3BocAP2Yzht1zdOfbAM8f/tXY5q+L37ql/7j/YLwz7yTg1LzTdVhpoyd3gxywns3Js2wzhqJXy7ddVAlPHBY1krjvy7zytjp73n9TRsLCrewcRYOFKwpHSiAAVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sHAKyTi4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sHAKyTi4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBE51F00ACA;
	Thu,  3 Sep 2026 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442819;
	bh=gUUA38Kd5tIr0sk9LNngOw1lkyQiXTcRktuQDvCNiLQ=;
	h=Subject:To:Cc:From:Date;
	b=sHAKyTi4N8ctQ+IxN8cjy5U7xyKXziwxUvOwxXB/paoratxtakpPV9I9UcUVlm3vT
	 gAxrXgZT9P3Q4tVWM3R9+tDSTj8bT0UmC5Usq9DutWxQ381MAoIwP+3xHNdJSbq7Hx
	 t6AUBZKEB4cFcuBcMaHlEGxhGBPsWmydD2lLfBO4=
Subject: FAILED: patch "[PATCH] nfsd: fix nfsd_file leak on inter-server COPY setup failure" failed to apply to 6.6-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:14:41 +0200
Message-ID: <2026090341-pasty-taste-d5c3@gregkh>
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
git cherry-pick -x 88a76145451d703eedd867b5989bf73d17340399
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090341-pasty-taste-d5c3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 88a76145451d703eedd867b5989bf73d17340399 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 31 May 2026 08:07:00 -0400
Subject: [PATCH] nfsd: fix nfsd_file leak on inter-server COPY setup failure

When nfsd4_setup_inter_ssc() fails, nfsd4_copy() returns
nfserr_offload_denied directly, bypassing the out: label where
release_copy_files() would drop the nf_dst reference taken by
nfs4_preprocess_stateid_op(). Each failed inter-server COPY
leaks one nfsd_file, pinning file/inode/dentry/vfsmount.

Fix by setting status and jumping to out: instead of returning
directly.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260531-nfsd-testing-v1-3-7bfa481b0540@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 505c96c14d9e..4df4ad03db10 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2159,16 +2159,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		}
 		status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
 		if (status) {
-			trace_nfsd_copy_done(copy, status);
-			return nfserr_offload_denied;
+			status = nfserr_offload_denied;
+			goto out;
 		}
 	} else {
 		trace_nfsd_copy_intra(copy);
 		status = nfsd4_setup_intra_ssc(rqstp, cstate, copy);
-		if (status) {
-			trace_nfsd_copy_done(copy, status);
-			return status;
-		}
+		if (status)
+			goto out;
 	}
 
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,

