Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818485;
	b=TuDnQWcoEFf1jYlDHosM37FEJ+YkvvVOEBUipjrCzsBgycvr/QkBDoNR6XcdIJLU4yYe
	 2VMTjjhIdgqN6uzB5A5x7TNMZxV8el6tHKRjx6FWLTcfEsbmityqN36H+OOuKiPLuh2K4
	 tguOJDHbflEO5tZ7JE+bKhET3+UNK+TTF6yqCh7a4aePKysRBaUNz6ApQiMrpobWeEzZO
	 Pf+d1hf4XwypcOlQc5xgdH5LCfb8lhyc0xxMQEzIcjpu5OBIkP/5nNwS2cUdn0K/K3u/U
	 BnwNMRPbw99I1rEL14q8PrgdaXAGTOyc+7mXa7csKjA0WXeC1WnqsOkMA1QcOppnL+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818485;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0FHlLanex4AyxuxF4NJOqTsZWXR44ecBQT610nRV9Bs=;
	b=3nKJTiuYKilDYb8SF1pndAY+2rFMM+gvuCgR5LzW4s5AC3O6IIXw35EXG6Q/P2PqYexb
	 RCxkZ1l1kA6qIOb/V9mctNZMBqsroWMkDgwNpbJMLTaJM9mBYZ/IQ4qn7Op5+6oAUd6Ba
	 xBtx1xNLlFkv5E14aGwOr9yN/OfrymlJ/5V9+GV1T08sdGGAAjYAX4wC89B+6S9vy76ZT
	 1FgeI+gRuXK05u+wsUCE0BJQAbhEZNiYs6Gydtap1Q5VN7OpX25hZbbCvDuC/TXTyEQWV
	 NabGG920StwZtfsL1m4iw0d+Ev7QspbfjpihfWSX29XXcysHVeonOZTYrD/I3CwqpsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2NLHQtH1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317A606D801
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2NLHQtH1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4C41F00919;
	Wed,  4 Nov 2026 18:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818485;
	bh=0FHlLanex4AyxuxF4NJOqTsZWXR44ecBQT610nRV9Bs=;
	h=Subject:To:Cc:From:Date;
	b=2NLHQtH1tQ6NsKFuoRt8agpihw8Pvhfyt8pijQ30O5e1q5jOeV9J6YRjMs60kBIsP
	 fYbSgyDawOpA5zS/E9l8UH/fVUQGNWl86G44bM9ntGbq+kXn/bBRNewQ/SLdD/kChK
	 bLqcZpWTGXnYkWfqPwBRuFFJyF8BeoowMjDZkdPY=
Subject: FAILED: patch "[PATCH] NFSD: return NFS4ERR_EXIST for a guarded OPEN of a" failed to apply to 5.10-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:54:32 -0500
Message-ID: <2026110432-unthread-unfreeze-0d65@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 89318a02fe1c19aac6d85a17c45800544bd3cbe0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110432-unthread-unfreeze-0d65@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89318a02fe1c19aac6d85a17c45800544bd3cbe0 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Sun, 6 Sep 2026 14:41:41 -0400
Subject: [PATCH] NFSD: return NFS4ERR_EXIST for a guarded OPEN of a
 non-regular object

Commit db8b567ffa98 ("nfsd: (almost) always open file in
nfsd4_create_file()") moved the regular-file type check ahead of the
createmode logic. A GUARDED4, EXCLUSIVE4, or EXCLUSIVE4_1 OPEN that
finds a directory or symbolic link under the requested name now fails
with NFS4ERR_ISDIR or NFS4ERR_SYMLINK instead of NFS4ERR_EXIST.

RFC 8881 Section 18.16.3 requires NFS4ERR_EXIST when a guarded create
finds any object under that name, or when an exclusive create's
verifier does not match. The type-specific errors in Section 18.16.4
apply to opening an existing file, which only UNCHECKED4 does.

Fixes: db8b567ffa98 ("nfsd: (almost) always open file in nfsd4_create_file()")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260906184141.3453309-1-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bb74eef43938..3a82af381a8d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -430,7 +430,17 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				       oflags,
 				       open->op_iattr.ia_mode);
 	if (IS_ERR(open->op_filp)) {
-		status = nfserrno(PTR_ERR(open->op_filp));
+		int hosterr = PTR_ERR(open->op_filp);
+
+		if (open->op_createmode != NFS4_CREATE_UNCHECKED) {
+			switch (hosterr) {
+			case -EISDIR:
+			case -ELOOP:
+			case -EFTYPE:
+				hosterr = -EEXIST;
+			}
+		}
+		status = nfserrno(hosterr);
 		open->op_filp = NULL;
 		if (status == nfserr_noent && create_status)
 			status = create_status;

