Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88802931D5
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354180; cv=none; b=pB/izrollySebedqJ5L3LLb6CiZTcqjRE4jJsN8OBQXaXO93gsxgvM4E6LshR5qfcwqei4xtCaUqdr8QMjyxd+xHVfk3Jp1M1aQmAGmh7MdWjSFEgr0OyWoiAnnIezUyFYZMsi5jtiMz5K7YK/skdIdEktajfRdzPex0wvKHBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354180; c=relaxed/simple;
	bh=y9AohAJh6UYhWh+QkaBvFMWU72yRbknM8o3sZLwtpTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuO45Qxtp5u+PvrlABBvIbY11NaSJGb/PanTqTfRTfw1PLX2Gx0k1V4Aqfpq/HCwuGzAv8rc7ICMxYcpJl2vf6Iwk+R6QVIPJWnttvWSac6IjXvpJYhCT++Cw30Rm3Il1S1W+HweAJ+NRMhNm5P8KscRjI3W/plwBHe3Bt3gJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqQoZE1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqQoZE1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4DA1F0089B;
	Wed,  7 Oct 2026 06:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791354179;
	bh=pgyvMRbHTLjscuXcfXxD+ZdPH4Hi+V/qKgof5myejng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bqQoZE1jJ5qnj2ij7zc4q5lYXsYJEPO0B3BIhwhkJH4xqHmbhc8QMpdQvZ1I0YmtW
	 /fWVoLt1yS/1UaUxlUcqq97uvQPKW0GEYg5Hbamg62k5zbeXnNnjZQef7UZeu9nqkM
	 1zAeYp0F8Kjesk6mi8R53tk8WFWk58BZJXbHpJzX/k5VkHderm5HAhw0Gj4GCMkEWn
	 9Q7tL7ZImbpdOdrcm4kR1P19R+rezeIn2ZAlFj1fPDKz2w85mDLGCx2/vA9IwSgMCu
	 TD7Y3XXLXBrm8xuw94S75pRYd9MWSS4IUXZ23lkWVuBZOyCKVUAt+R7AuOdr+swXIp
	 zq/suT96fobEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: distinguish real EOF from a stale remote_i_size on read
Date: Wed,  7 Oct 2026 02:22:54 -0400
Message-ID: <20261007060910.1481554-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100542-pouncing-depose-d945@gregkh>
References: <2026100542-pouncing-depose-d945@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 75aa4b4d557114276bb72e19a9bce5cb27b5e4b8 ]

smb2_readv_callback() sets NETFS_SREQ_HIT_EOF whenever a short read
lines up with netfs_read_remote_i_size(inode), the server's EOF as the
client currently believes it. That belief can be stale: after a lease
downgrade and handle reopen, the tracked remote_i_size can sit below
the client's own i_size while an extending write hasn't reached the
server yet. A read in that gap comes back short for a reason that has
nothing to do with the file's real size, but was still marked HIT_EOF,
and netfs reports a short read for it as-is.

Only treat it as real EOF when the position is also at or past the
client's own i_size; otherwise mark it NETFS_SREQ_CLEAR_TAIL instead,
which tells netfs the shortfall is safe to zero-fill rather than
report as a short read.

This is what fsx (generic/363) sees as "short read: 0x0 bytes instead
of 0x<n>" against a Windows server.

Fixes: 1da29f2c39b6 ("netfs, cifs: Fix handling of short DIO read")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
[ sashal: adapted i_size_read() calls to use &ictx->inode instead of inode ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 1dbf8d28bdf76..175f511649088 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4676,14 +4676,20 @@ smb2_readv_callback(struct mid_q_entry *mid)
 				     rdata->got_bytes);
 
 	if (rdata->result == -ENODATA) {
-		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 		rdata->result = 0;
+		if (rdata->subreq.start + rdata->subreq.transferred >= i_size_read(&ictx->inode))
+			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+		else
+			__set_bit(NETFS_SREQ_CLEAR_TAIL, &rdata->subreq.flags);
 	} else {
 		size_t trans = rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
 		    rdata->subreq.start + trans >= ictx->remote_i_size) {
-			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result = 0;
+			if (rdata->subreq.start + trans >= i_size_read(&ictx->inode))
+				__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+			else
+				__set_bit(NETFS_SREQ_CLEAR_TAIL, &rdata->subreq.flags);
 		}
 	}
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
-- 
2.53.0

