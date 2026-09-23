Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B135E958
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127624; cv=none; b=dolYbvKxTFGbKanndvJ3vnbR/FIeMW8Rf3qskPTmSivHU8ExclVwzdwa9cGCKsI0U6OQpHeLhiua975asbCKBGeV2715qaX5CEd8Zu9v79H+HCcqYXY5tv0y6xcVeDW7DrbZcGw1FahN2xauqLU+toDJN5fVVxtl4NUUkLITfKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127624; c=relaxed/simple;
	bh=f/BHCGbu47y+M4w7uVnnHFDdwIgYSlXcDbLM3Dg7T0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fV0WU16ojm4Sl2P7oOrYPLN0tRxZdvINFcR80oM8xLtqih2smf7XRobzF8fkTuOvmVD0xVFQLW5l0qkXLZFfovCqUO+y2hvKz3iSFzCqLCdIhnBKNOZLqYg29THhiv7ixARicViMpZL6W1kHITseF14HSlc0l/0H9A5w1E/LKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XViFit6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XViFit6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4AF1F00899;
	Wed, 23 Sep 2026 01:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127623;
	bh=dZ423c7ciZcdIjz40S3/+SXzFMAD3i6GVhrgrX6He6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XViFit6ZIuLASzTkz84d3lcjH0ok4kSCwr1MvB2NjfOvOFJHd3X8WPqgPN/ywlCpy
	 Tn2et9DLY5Ly3ph9WkNvFU/HpJLnYSFoXjNHRtyfiET5ztGlp9FvvIOcDJtJ72rCN+
	 NmFjYFdpXRSM9/As3zKMe8CN/bRM9cVodHqCCDxWapgnTZs54ULSK0ok1ERD3VfZtn
	 2x8eUpeuYdXtndws91TWWssZnEN9MyAzwqM4qp+pFzkAGq4yLAG4BVlaZmOwRBW0xr
	 7tBLRYSWRATrzNzuLg1WCAN7JkuaXNA53oTzWSfMenLzKbSASMjw65bub+Tj7gBKKA
	 KSwfuNdWpINlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix next_buffer UAF and NextCommand bounds in compound PDUs
Date: Tue, 22 Sep 2026 21:40:21 -0400
Message-ID: <20260923014021.880327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092210-mango-cacti-413b@gregkh>
References: <2026092210-mango-cacti-413b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 05762c5bc1cfdcac36747994fde2c04387a457f1 ]

Fix several related bounds checking and pointer lifecycle issues in
receive_encrypted_standard()'s handling of compound encrypted frames:

- Clear next_buffer after assigning it to server->bigbuf. A stale
  next_buffer pointer can lead to a use-after-free on subsequent
  error paths.
- Update pdu_length to the decrypted plaintext size (buf_size). Using
  the pre-decryption length allows NextCommand to point into stale
  ciphertext residue.
- Reject next_cmd values smaller than MID_HEADER_SIZE(server).
- Fix an integer overflow in the upper bound check by verifying
  pdu_length - next_cmd < MID_HEADER_SIZE(server), ensuring the
  trailing slice is large enough for a header.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Replaced unavailable MID_HEADER_SIZE(server) with (HEADER_SIZE(server) - 1). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 51f8ea0c89065..ff03023b02976 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4967,6 +4967,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	length = decrypt_raw_data(server, buf, buf_size, NULL, 0, 0, false);
 	if (length)
 		return length;
+	pdu_length = buf_size;
 
 	next_is_large = server->large_buf;
 one_more:
@@ -4979,8 +4980,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	}
 
 	if (next_cmd) {
-		if (WARN_ON_ONCE(next_cmd > pdu_length))
+		if (next_cmd < (HEADER_SIZE(server) - 1) ||
+		    next_cmd > pdu_length ||
+		    pdu_length - next_cmd < (HEADER_SIZE(server) - 1)) {
+			unsigned int max_next = pdu_length > (unsigned int)(HEADER_SIZE(server) - 1) ?
+					pdu_length - (unsigned int)(HEADER_SIZE(server) - 1) : 0;
+			cifs_server_dbg(VFS, "invalid NextCommand offset %u out of range [%zu, %u]\n",
+					next_cmd, (HEADER_SIZE(server) - 1), max_next);
 			return -1;
+		}
 		if (next_is_large)
 			next_buffer = (char *)cifs_buf_get();
 		else
@@ -5016,6 +5024,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 			server->bigbuf = buf = next_buffer;
 		else
 			server->smallbuf = buf = next_buffer;
+		next_buffer = NULL;
 		goto one_more;
 	} else if (ret != 0) {
 		/*
-- 
2.53.0

