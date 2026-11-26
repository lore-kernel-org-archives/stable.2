Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667647;
	b=Bqcg0rFcouEqPnXpyjwZJfEiJtmxhyhARyL6Q+mhII7/1Jw7GZanGeDwVve+xGi8u7M6
	 KHgwA3g716fWUQQJi4vN0Eq1w24fToPoNddMgqMSoR4Eae3l42a7yWuaMhDtt8S2hHy0C
	 OVulbdYAgFnVx3BOgS+W6+atZtmPsu8BE3bOZr+iy6i3ySXvSaw55m3Q3CWUubIKcKXmF
	 WzNp5YglRQWtlUlcMWBgbxNlqBROtMRJueXRrgQqtmQuf67ASyCr9JmmDlwlBFlHFM60T
	 zGOCSaij8NR1+ZBsFqQyFvSZVMO4IIXY8TOwE1eBctydMVv+oYPrXRfQfKXzHi3lN1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667647;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QP4kslkWRdriiAz+zbRv+9MMWM54K23UyeH77Ufj3KY=;
	b=p5ogD7tYTikYrPNlOFTUIQLAh1n05T4ORPq/YxK9J3vxXT1AOi4cbvMA5co2bv7PTPK7
	 wK4oaOffyzJf73oFupABn4/DmKz1lYJzGtKT2flh/VcW4bUWTxB4hr2xBVRUEXMxhoDui
	 V2ebaBFxdjq29s4I8go2gUF0VM3B1ZTq3KOJydXqAnc+9oAo5Q2WbFEevVbpqa0Iig/aD
	 LR+rewGKrsm3ikR8xDTcYWJARpcfFhVWfulaylqtTCaBvSLs8iF5G9+I8XQg6hoExA6Ps
	 XSoYQBLeoBEIu8JojEnR70JWT4HYi93E2EuZOe3kGD7pgfo7WczsANLcw8lvmE0oRVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B73lU1EO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9137606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B73lU1EO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942691F000D0;
	Thu, 26 Nov 2026 04:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667646;
	bh=QP4kslkWRdriiAz+zbRv+9MMWM54K23UyeH77Ufj3KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B73lU1EOalUh0P2UiFHUFW7k8I52G7MvSpOicXlkGxdhrIcRt4KTkW9vw5GeKEnut
	 SHhoLnoNZZISYV8nN45OS3dLkQ1fH78OQd7SYy4+TZqeK1eW+ZkpUbtBw8Sqxzw/Qn
	 pyinGKYaHxPA7mwXwf3LHs8yG40sH9mF0BMbqnemLRqrUpStNsXGAQhc7c4BKBuhyX
	 kj7nC4fqcnoJpmXd2TY1BS3UuaqbHpgQuHeNFDWAWL6cf+2y5dE5dGpsr5zlDCaqEl
	 /MaYZruO0xlvdqQNFKcK5g4pbZr4YAjJgYE86fveanPNCwdKRuVmEShKRSEeq09fog
	 vxw1mrCSOOY/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: don't write back through O_DIRECT handles
Date: Wed, 25 Nov 2026 23:34:04 -0500
Message-ID: <20261126043253.1980638-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112512-blazer-polish-8b61@gregkh>
References: <2026112512-blazer-polish-8b61@gregkh>
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

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 0e85145af984f7cae2aadaa694cb8612009027ac ]

Writeback uses the first writable handle of the inode, which may have
been opened with O_DIRECT.  Such handles are opened with
FILE_NO_INTERMEDIATE_BUFFERING, for which Windows rejects any unaligned
I/O with STATUS_INVALID_PARAMETER.  Writeback of partly dirty pages and
of the unaligned tail of a file through one of them fails, so netfs ends
it with the folios clean and the data never reaches the server.

xfstests generic/051, where fsstress mixes both kinds of opens, loses
about 1% of its writes this way:

  smb3_write_err: ... offset=0xde90d7 len=0xbd0b rc=-22

All the rejected writes in a network capture were unaligned writes on a
no-buffering handle; none of the aligned ones, and none of the unaligned
ones on regular handles, were.

Prefer a handle that was not opened with O_DIRECT, and use one that was
only if there is no other.

Fixes: 1013e760d10e ("SMB3: Don't ignore O_SYNC/O_DSYNC and O_DIRECT flags")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org
[ sashal: Renamed the FIND_ANY flag to FIND_WR_ANY and added FIND_WR_NO_DIRECT as a #define instead of an enum entry, and dropped the tmpfile hunk since this tree has no tmpfile handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 27bdb50751852..3fe2144b00d2e 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1815,6 +1815,7 @@ static inline bool is_replayable_error(int error)
 #define FIND_WR_ANY         0
 #define FIND_WR_FSUID_ONLY  1
 #define FIND_WR_WITH_DELETE 2
+#define FIND_WR_NO_DIRECT   4
 
 #define   MID_FREE 0
 #define   MID_REQUEST_ALLOCATED 1
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 4a62787891292..5aaa77ef527ab 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -267,9 +267,15 @@ static void cifs_begin_writeback(struct netfs_io_request *wreq)
 	struct cifs_io_request *req = container_of(wreq, struct cifs_io_request, rreq);
 	int ret;
 
-	ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_WR_ANY, &req->cfile);
+	ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_WR_NO_DIRECT,
+				     &req->cfile);
 	if (ret) {
-		cifs_dbg(VFS, "No writable handle in writepages ret=%d\n", ret);
+		ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_WR_ANY,
+					     &req->cfile);
+	}
+	if (ret) {
+		cifs_dbg(VFS, "%s: couldn't find writable handle: %d\n",
+			 __func__, ret);
 		return;
 	}
 
@@ -2554,6 +2560,9 @@ cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, int flags,
 			continue;
 		if (with_delete && !(open_file->fid.access & DELETE))
 			continue;
+		if ((flags & FIND_WR_NO_DIRECT) &&
+		    (open_file->f_flags & O_DIRECT))
+			continue;
 		if (OPEN_FMODE(open_file->f_flags) & FMODE_WRITE) {
 			if (!open_file->invalidHandle) {
 				/* found a good writable file */
-- 
2.53.0

