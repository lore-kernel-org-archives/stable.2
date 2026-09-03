Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73FC4AF9D3
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442856; cv=none; b=B/qrZazmeSrmeGEGOyKWBRZbxeM7ysA5i1HOaKzq645QUkQAKjeDHpv7pLFNgfJOctoGOiMIZZhIeRkQHF9bCWgmbBvLJRAHlCDpg/zDA3kxKm7Pj4UAuYa4FD4YKrOqmW5NDvuM3qp7NV85812vgzzUSorqP8wG8sqz43RhxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442856; c=relaxed/simple;
	bh=qMFp3X5MJs0qAwdd5Hqgw3NnPoIR2Bmb5vYk3ux3J1w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IQ9xf204AH0+OKXGsCv90w18fWAuAlfr3hFdOoKwn+HLgJMUVd37TTTI+R12fnoUe6YbtKRbojCb4J6grN1P5i3zAY2COnzHVoX+QBDA1rckx6mzgobarW5cKpWWNFEbdNQaA3K3SN+P38apShIzi7etHrUmldsZfWbh2i6ziHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2uB926p2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2uB926p2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D0D1F00A3D;
	Thu,  3 Sep 2026 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442839;
	bh=nFvOdq/SXM5cLPOq/RFY9o7DAbyhbagP0kl6FrMLVos=;
	h=Subject:To:Cc:From:Date;
	b=2uB926p22SGP7UJRtmFW7IGCLu5+KPaONwM+wjWs5/YlI7fiMlh37wEUMiWwlSH3D
	 rH6sE/fbRtZuH0lqUdLW1wdUmonBJbyzLcqKNAs5z41yTx9kcxoNjbETNHmNhY+QnI
	 5F9OeZFOFZXP7dTpWJTtOHsQxQrUsIWjQo2t4Mn8=
Subject: FAILED: patch "[PATCH] nfsd: fix stale s2s_cp_stateids IDR entry for async COPY" failed to apply to 6.1-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:15:21 +0200
Message-ID: <2026090321-immorally-carried-7c28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x d0beaee498e11880e72826026db0e9c9890fc114
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090321-immorally-carried-7c28@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

