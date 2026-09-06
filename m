Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880C3CF942
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701698; cv=none; b=RSWu4KrH3pP401dbc8ODcV5AwjN9d7/1JcZOXhBw4vTnA6LdnhgHPr78PLozE090kmH3xTKrnS07jtF1AnVpO0ducAnHJTWtTPvf7TKAhm2LZjFMN41Q1Ei+owpzP4ngV6T6wxgGa+cOLApg0ZXnTwuW5JKNXWu0q58vU1uKPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701698; c=relaxed/simple;
	bh=U+EgqV7lsWcOfI6ORZEM4hfPb6ESHwqo8z2/IcapdzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBvUL/hbM64KBo17Pv421moN3bwsc0Hd9/Z2PzHNkjWNiNxaQVfsrzKNpq1IK/uuobfmnEgN/5p2YseLDW577Xf8LWQ5b8sM+NISzgrZmuCSkbNyiZhXZ//npDzLtSKAEqpEqLKF2TZFz493Yeto2PhgP1Zo1MyI9nXx8HoJKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOjM8Lzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOjM8Lzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9B81F00A3D;
	Sun,  6 Sep 2026 13:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701697;
	bh=30nND69hmPNaD+qlUjTVj7FKwbGT6mDmRe7i1QgrRfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TOjM8LzfZx1+zpL6BgUbFm94Sgxvq8z5iN5FcllR9Vu8IobUh2rOaSxiffwR3K1Gy
	 iI27e275ZIFb/5DNF+4hZqUAThavh556ESQI4YOT3ywMdRxL6op3m+QK3PBWDY/G0o
	 oQsApIXUvKMJflDxTw11vIElvBz7mIrlksJ3Iep6+UbKHyGWNSIBQe4AfsaKofS/P3
	 w0akRqlW+YEsFx+Ve8X8ZSgPoz50V2PgedT4Q8bhNqO0KaJM0dkFV5QgzSLPyOpIVd
	 8OkdMystkymJsU2e5epYFCPbrCCANvXxVo2X8+QSWGQCoSjGaA7y/Ra94YF2OnVFsV
	 c9abJWyqRujHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
Date: Sun,  6 Sep 2026 09:34:54 -0400
Message-ID: <20260906133454.899083-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906133454.899083-1-sashal@kernel.org>
References: <2026090322-excavate-aside-0c00@gregkh>
 <20260906133454.899083-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit d0beaee498e11880e72826026db0e9c9890fc114 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 63a4825dd15f3..2652e60f0f5a7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1800,11 +1800,12 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
 			goto out_dec_async_copy_err;
-		if (!nfs4_init_copy_state(nn, copy))
+		dup_copy_fields(copy, async_copy);
+
+		if (!nfs4_init_copy_state(nn, async_copy))
 			goto out_dec_async_copy_err;
-		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
+		memcpy(&result->cb_stateid, &async_copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
-		dup_copy_fields(copy, async_copy);
 		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
 			       FMODE_NOCMTIME) != 0)
 			async_copy->attr_update = true;
-- 
2.53.0

