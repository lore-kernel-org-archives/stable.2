Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0947ECF1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442839; cv=none; b=Kk6RoRyEP2ZbM3OpxX5PSsiBr4M4S6ua04CvzzXPfp9OHzjnXRf+LBVj8aXEI0mhQWPa2OIX4M+j4ud4wFnrKQGwJCL6LMSaqEh4jmsg+PW5Hmf1KE1u0c4POB8W6Xqr2Ma7HSviOX7Ba6AgLsumokp0jU01wCGj+7Y1ThxA4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442839; c=relaxed/simple;
	bh=WACmSNmmVAXPQROLMxGL7GfKfyV3pn0fwUEHPFx+fZw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MrnaKdgLkMlB4H+st/2H3VyX239u4X5SN7H6B2dCF0B+9mfE6lrF63gTGsvcbZ4DdqQ2TQmtYa8d9gPyDK9awJO0+WJs9XmQJGBYcIPGEz0Iu6nMtlWfXFhfONyHD4FynJPcmEcCSF3gKpJFmJoZGmy9xH8B6nSkOjNTdQVAtRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vUV1m5CA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vUV1m5CA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E7E1F00A3A;
	Thu,  3 Sep 2026 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442825;
	bh=AsSdcC53uNykpBrXcy0rifFzTeL16HLjDpd2o6iFuho=;
	h=Subject:To:Cc:From:Date;
	b=vUV1m5CAJDMMrcd1vgCui8cPyjhMxcNuRRebQpqy5qdf2h3zwS6e9UaCQo2CS4Dat
	 G+Cb/uiWxBDUSo9eaU1DLSC+gf1bMruNI9Ws59zS467rS2guUfQouYvk0kGMWYoGbL
	 koaPbe3prblmlfMLphKuikr4+zw9oztxYK92wmmA=
Subject: FAILED: patch "[PATCH] nfsd: fix nfsd_file leak on inter-server COPY setup failure" failed to apply to 5.10-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:14:42 +0200
Message-ID: <2026090342-mute-statistic-4761@gregkh>
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
git cherry-pick -x 88a76145451d703eedd867b5989bf73d17340399
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090342-mute-statistic-4761@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

