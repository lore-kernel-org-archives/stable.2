Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463784AF174
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442847; cv=none; b=mWYrKSYPVdIQofk9T7WWwA9w45Cep0Y+0NJ+sf678RM7l8qdIij4yWGN3IDOG8HIHkClcgLIa2urSsC6M10qmDfWjxhFpesZEaV6jRbI5QjvcctBalYLHGbGzgCGclznaxIjzxL2TSwri6Apg0rc3VgenLjZkyatl/DaaVkI2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442847; c=relaxed/simple;
	bh=BjzLNGSDlLbYYYZoXeco89jAUveyjN9kOJ/X7Uwrqu4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pe5cxmnsywwFgLpsDd8M9tPoK+rxyfVzGgL5RVeDlP8wdyd++GRNYAbD5JUb5qEOm0yS1mF3T0BtvVd8NZoxjdmYByQTKfzlC1jm66JUi+ujGWmUBUG/QL3VD0aABUeV3zs84hviLwekRAEatFKFAlgHHwS97yZhnLJBgKzSulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXmnouaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXmnouaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980E51F00AC4;
	Thu,  3 Sep 2026 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442831;
	bh=P8W04UgsmUWkF3v6q1zPJd0sj8it73gyZMaIPktIZ3Y=;
	h=Subject:To:Cc:From:Date;
	b=FXmnouaXO3n6jI2W4h9RomS/cl1j8rhU+w6GYuDy7URKYXvD+2vD1ohdh45qUmBOJ
	 jkFYHxe3XqJxw/hKYS+G3SZoYRJ2NZ0JwYLh12FV41UCiIQo0hpUZhuxesDBYP1995
	 K7zGLC7PjbJnqByRTFQ+vVIGCEipyrm1YPmTtf/E=
Subject: FAILED: patch "[PATCH] nfsd: fix stale s2s_cp_stateids IDR entry for async COPY" failed to apply to 6.6-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:15:20 +0200
Message-ID: <2026090320-unvocal-subtitle-0ff5@gregkh>
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
git cherry-pick -x d0beaee498e11880e72826026db0e9c9890fc114
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090320-unvocal-subtitle-0ff5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0beaee498e11880e72826026db0e9c9890fc114 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Jul 2026 10:00:07 -0400
Subject: [PATCH] nfsd: fix stale s2s_cp_stateids IDR entry for async COPY

For an async COPY, nfsd4_copy() called nfs4_init_copy_state() before
dup_copy_fields(), so the s2s_cp_stateids IDR was pointed at
&u->copy->cp_stateid -- memory in the per-rqstp COMPOUND buffer that is
reused by the next request. dup_copy_fields() copies only the value into
async_copy, so the IDR slot dangled at the transient buffer for the whole
background copy. Any IDR walker then dereferences reused request memory:
the laundromat reads cs_type from it and, if the bytes look like an
expired NFS4_COPYNOTIFY_STID, follows into
refcount_dec()/idr_remove()/kfree() on garbage; manage_cpntf_state() has
the same exposure via idr_find().

Duplicate the fields first, then register the stateid on the stable
async_copy. result->cb_stateid is unchanged.

Fixes: e0639dc5805a ("NFSD introduce async copy feature")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260710-nfsd-testing-v3-3-a0ff7db6aa3e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b2f1a9bc9202..b9049a3d7c07 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2237,11 +2237,12 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy->cp_src = kmalloc_obj(*async_copy->cp_src);
 		if (!async_copy->cp_src)
 			goto out_dec_async_copy_err;
-		if (!nfs4_init_copy_state(nn, copy))
-			goto out_dec_async_copy_err;
-		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
-			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
+
+		if (!nfs4_init_copy_state(nn, async_copy))
+			goto out_dec_async_copy_err;
+		memcpy(&result->cb_stateid, &async_copy->cp_stateid.cs_stid,
+			sizeof(result->cb_stateid));
 		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
 			       FMODE_NOCMTIME) != 0)
 			async_copy->attr_update = true;

