Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667333;
	b=sCzdl4kHotq3/9kedajjR8UObbKE6BztriChk3fUfmU2gbdfRm4U6stVPOrhhfBAC8W9
	 kaIFn3cUwwe4DAAxNrh12QGGZplWU7pTFM8eH3OaW7I/aXAk8UQr70QxnOWXF6Ggs1Mvm
	 SpjXAZ2GUYABct9B7LGEwa1Wfs85ne1HtMHYBG3I7FugQZQPATcUgva2YNcLjGhocs4kv
	 P07pAUU0X16GrElAv2Wv2btoJe47HR/u3N+qjZ8nIG3KnlSyqx+Vg7YeI5S+4zZRJgYJI
	 /iffD4DBCtpwvNyK9IyNMWMpAOtmsY5MsdJAjHc6wQ6nyhPQmht/+Zm0Tk+5WrclwEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667333;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N/gZCuT0nXkv0iX4X0Wl1jf7Brh8JIsN1d1omrcvZQ0=;
	b=NIwADUMDjZy2cPXiH+Fp/wbqvya3L0bEL3og4TuZkvMvu0hIg5BKSKOL/0A+U3i5Gxt+
	 UpxKcYfXfy4qIUuUGsZ6w0RpJKPlF5IKWVC+jOolpzHNZRzJD8i1uUpI0eTTm/cNzFHs5
	 6dbqGoY4UTj1HTVLQzjmLJxpRdZzNNHPAZX58UeJfECpnXl76Xh7n2Joc/CNQta6Eir2/
	 gOGkFyYfJRCGIKeiyXTRhhBtIIOyxvF0yO3PfWV5he3sbgruA2kJyL792rDtAzR+SQAhW
	 1hpygOxf47aTUsxujFLwC3dM6JaHY5Q6QToIGlloOSPWsSMpCzqKawQtwXhLWNfxqEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqySjyew;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D1606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqySjyew
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C1D1F000C0;
	Thu, 26 Nov 2026 04:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667332;
	bh=N/gZCuT0nXkv0iX4X0Wl1jf7Brh8JIsN1d1omrcvZQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqySjyewqYX+PvPQ7G/6wxNDuZaUmx3cKQjdhT21G20rpSj3+gn1msg3kgqb3Brm3
	 MWaPAF0LgV1mK6zQJ/2v4fsyyg9bwJ7PfcCGFtZ3xkMZK3yHGyAyW71IXpHYP5GUAu
	 V8DjdSYr4hhac4WuTAskmeEuCQNxzwHoA5aqpOf2PteYIUXPknBTD0CfKmQwEgjhwi
	 nWbDg+yLmIrwws/XIN7iqUF+W0nIky85edu6Sl8xHdjtXcuVe7gNK6OXDEHgcmhIMr
	 7Icgl1SOD/S54t7FjJ87LnzcQXG74uNaUJUS/XtIiINl4tC+txG0WXu0xG0YUReYJ+
	 vdfIJZ5wuyiGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: don't write back through O_DIRECT handles
Date: Wed, 25 Nov 2026 23:28:50 -0500
Message-ID: <20261126042831.1960193-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-snuff-emerald-e34c@gregkh>
References: <2026112511-snuff-emerald-e34c@gregkh>
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
[ sashal: Renamed FIND_* flags to this tree's FIND_WR_* names, used bit 3 for the new flag, and dropped the tmpfile hunk because that code is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index ea6533d057acf..2660a3a0f51cb 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1868,6 +1868,7 @@ enum cifs_writable_file_flags {
 	FIND_WR_FSUID_ONLY		= (1U << 0),
 	FIND_WR_WITH_DELETE		= (1U << 1),
 	FIND_WR_NO_PENDING_DELETE	= (1U << 2),
+	FIND_WR_NO_DIRECT		= (1U << 3),
 };
 
 #define   MID_FREE 0
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 652206fead33c..e11662f2a903c 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -282,9 +282,15 @@ static void cifs_begin_writeback(struct netfs_io_request *wreq)
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
 
@@ -2669,6 +2675,9 @@ cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, int flags,
 		if ((flags & FIND_WR_NO_PENDING_DELETE) &&
 		    open_file->status_file_deleted)
 			continue;
+		if ((flags & FIND_WR_NO_DIRECT) &&
+		    (open_file->f_flags & O_DIRECT))
+			continue;
 		if (OPEN_FMODE(open_file->f_flags) & FMODE_WRITE) {
 			if (!open_file->invalidHandle) {
 				/* found a good writable file */
-- 
2.53.0

