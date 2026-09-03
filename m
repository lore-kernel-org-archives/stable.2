Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C354ADD8A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441530; cv=none; b=WI+bpEo+e552vRBsWIORhC5Di6x9wa6GtTyczJugi5iYUAghZnJnqv+scK6wzP7fWuQjQ/h5MCUwTvmgL423nd0fOryevti2y6oBsWbRSSRC51eZMgG6d+yAxKYqfMWXcGZxJdmUyg/myGM8gJS3Vu/aNvrEQ/6lTBp43HydvBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441530; c=relaxed/simple;
	bh=6jz97UaXnmL+qCWe6zR/i6BPmGxxljRglv4fMY8AjTw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hLfyxv7JlzbsBWttqJSIG/laLFmozFvYF+VZCuoxKPLmA74yNOjZ+qqsziivdI3LD0BtncuokjOOkilMWvIlIkyC+TthmVtjru9tEGbgvpzSMPRzw+7zBeLBV3TYZDBqJWf0mu/9tKxvHNjbE7iEDki+UGbeedO9G8n56ioJKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fj1BVxmw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fj1BVxmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30911F00AC4;
	Thu,  3 Sep 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788441517;
	bh=/BkcAdVwtVZenypdEsI+V75ODPLE38f35dqaYUGBHhQ=;
	h=Subject:To:Cc:From:Date;
	b=fj1BVxmwVeeiWRAXJDRfSJsOC3pV06bBsH6O4ALzk3DK2bctNGsbK+HK2wajMBZSG
	 IeSOmZk3Ot5eLF7hf8mq1eosIFkUJ9QjuQuAy9UCiCSD4EIx9t18JoTzHSVM/a9AeU
	 9aDjeusEe2UrRCwUvxAhfWskWcVuTk1RC8INb8RM=
Subject: FAILED: patch "[PATCH] nfsd: check nfsd4_acl_to_attr() return value in" failed to apply to 6.18-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:09:50 +0200
Message-ID: <2026090350-lizard-judo-a248@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2c7912732184773dbd371a411da87af1cc080b86
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090350-lizard-judo-a248@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c7912732184773dbd371a411da87af1cc080b86 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:48 -0400
Subject: [PATCH] nfsd: check nfsd4_acl_to_attr() return value in
 nfsd4_create()

nfsd4_create() stores the return value of nfsd4_acl_to_attr() in
status, but the switch(create->cr_type) block unconditionally
overwrites it in every branch. ACL translation errors are silently
discarded, and the CREATE proceeds without the requested ACL.

Add an early exit check after nfsd4_acl_to_attr(), matching the
pattern already used in nfsd4_setattr().

Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
[ cel: prefer NFS4ERR_BADTYPE over NFS4ERR_ATTRNOTSUPP ]
Link: https://patch.msgid.link/20260611-nfsd-testing-v2-5-5b90e276f2d9@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 623a89a1f34e..eb8a2a16839f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -848,6 +848,20 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out_aftermask;
 
+	/* Sanitize cr_type to avoid returning ATTRNOTSUPP. */
+	switch (create->cr_type) {
+	case NF4LNK:
+	case NF4BLK:
+	case NF4CHR:
+	case NF4SOCK:
+	case NF4FIFO:
+	case NF4DIR:
+		break;
+	default:
+		status = nfserr_badtype;
+		goto out_aftermask;
+	}
+
 	if (create->cr_acl) {
 		if (attrs.na_dpacl || attrs.na_pacl) {
 			status = nfserr_inval;
@@ -855,6 +869,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		}
 		status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl,
 								&attrs);
+		if (status != nfs_ok)
+			goto out_aftermask;
 	}
 	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {

