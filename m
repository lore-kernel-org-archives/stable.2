Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795666185;
	b=ho/n4I3KlAbq2tHlCT1b5Chlza+dzkCrzo3yv3js+a1TdnhBPHoNPYiM/GAsjtUBS4zz
	 AVO+wCud7U+QwCI+F++LJlK2afRvNPQzBs8SpDtVkOpEMqu/4PlhTjeeplhHbPN0u8pXI
	 Kh0Qdv+yMamrsAEnuG8MrqCDS874M+N2EOklDqHL+gX9jdi7AaSpVY/zU7BbeTUGbrgMv
	 wZOYG1qUgRv3QV9m31jSJUa9vCPmnZbgWEBgTATElpVbp5ngRpXJFzwPLJtbnGKeYf18j
	 3PyEf8VTuy6/s4tFZkeyzTb/gccle7sZH7vtbkPSvTA7zQqiRqHvcdDonnm2u40XZIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666185;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jx9vGRPFral1t/OQD9NeQGyRYCBsRS2X5NWMkasc/Vs=;
	b=hHlsSu2mfDEZSFqq9DAYUwO8E1yYHr5AYMPq4oFFwWOSa4giVjtG8++NJL6uldZbxqEM
	 n08o3Z9GxifS9Z68NoBLbViguBgprKWVCSxvr4F2b254gQ/fuad2FO6i7UVapgYGyGBCT
	 LLNzx3v8UGggVUAVKSqapV9A5JJpTjp3fcIS9xdiClXlytQAGbJjvh5wAw36VHO7uXvMF
	 NWvFrpZhrFmc5crhlCvIcSa4BFLzBl//vbYIHMV1BKgBKfTwQ/+n9UMIJ50boE52mQ0zH
	 gArdP8dQRhIqHh+Ty/DGeUEDS57JnC6sPnE+5TSjlKo5wQS7YHg15P+JOtpp1E8UX9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOluzYA6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F4606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOluzYA6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC5D1F000C6;
	Thu, 26 Nov 2026 04:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795666185;
	bh=Jx9vGRPFral1t/OQD9NeQGyRYCBsRS2X5NWMkasc/Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AOluzYA6CQFiTtogtycKDkuCm2ZwLSKbDyxjTXwuLHCoxNEUbE1WzeFemdwfeSWla
	 BkWTsecU2AWBvTP0VgyXRtunh/o26aAtwSlUVPnU//WO/TgU5pF21gktZC+HaVsbn6
	 EJk94p8HZKp5RxYtHfAxqGUgYr7ykBo2p950WNgspV9YZivN6T+vYSI8D7AkA60QSy
	 bpMGLI0vT95G4Nh6D7RZAWPY0i6IY6oyWWGELBNRK+IrwE4vdgmaLsuDIBVW+tPkAs
	 qKobbOj+mamM6Cuzfk2YckCKnULvAu+prGRu/duGj1nwireC5LQp8WGnWUbNmgzaHw
	 ilCur08kSh7Yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: hold the inode across cifs_oplock_break()
Date: Wed, 25 Nov 2026 23:09:43 -0500
Message-ID: <20261126040920.1914238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112558-twirl-immobile-1b3e@gregkh>
References: <2026112558-twirl-immobile-1b3e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit fce78321f1b59531cf6fc94860550db1db8dec55 ]

cifs_oplock_break() drops the handle reference in the middle of the
handler and keeps using cinode afterwards, to send the break
acknowledgment and again in cifs_done_oplock_break().  The reference
cifs_queue_oplock_break() takes is the only pin: the handle holds the
dentry and the dentry is what keeps the inode alive.

When that put is the last reference, the dput() in
cifsFileInfo_put_final() kills an unhashed dentry, drops the last
i_count and evicts the inode, so the rest of the handler runs on an
object whose free is only RCU-deferred.  An unhashed dentry that a
handle still references is an ordinary state: unlinking an open file
leaves the dentry that way, and so does the dcache teardown at unmount.

Take a reference on the inode for the lifetime of the handler and drop
it once the break has been reported.  This also covers the
cifs_get_tlink() failure path, where the put is followed directly by
the out label.

Fixes: b98749cac4a6 ("CIFS: keep FileInfo handle live during oplock break")
Fixes: 23b26f4408ac ("smb: client: avoid leaking refcount when cifs_sb_tlink() fails")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: Replaced the upstream cifs_put_tlink(); out: tail with the older _cifsFileInfo_put() call, since there is no tlink failure path or out: label, and adjusted the hunk context to the local variable declarations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 0da9c11cae278..396c2b0824018 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4769,6 +4769,14 @@ void cifs_oplock_break(struct work_struct *work)
 	int rc = 0;
 	bool purge_cache = false;
 
+	/*
+	 * Dropping the handle reference below also drops the dentry
+	 * reference that pins this inode, and cinode is still needed to
+	 * acknowledge the break and to report it as complete.  Hold the inode
+	 * until that is done.
+	 */
+	ihold(inode);
+
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
 
@@ -4816,6 +4824,7 @@ void cifs_oplock_break(struct work_struct *work)
 	}
 	_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 	cifs_done_oplock_break(cinode);
+	iput(inode);
 }
 
 /*
-- 
2.53.0

