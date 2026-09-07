Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921514908B4
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781656; cv=none; b=O+IKjKev0KWvwFEUSZP86v0vgDPaCW/ppYRgy1TcxK2aXWqSNXKHnU8Jap5Ox2qZKydwei52n0b+omwVQqXYGaefO0XFdpzGb70PHbOCVxnew62vogVuKEWAk3dg+fi8oMu2rAxaO24CvS9rkd9hYFMxiX0Op+dhrxouDrcQo6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781656; c=relaxed/simple;
	bh=89FbpDDSnrnWlrqtIScPgYWrt3b0XEQj1ucdfj2tfFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqwD3csA2CX0N1sTVfm7h6BWIqa5IK8DXXt96JSZ2X87oTvP6TH/akOWcpAM+xSSzwZoogir6st283UuloSnKXXEU5Q4Amq1jpyJwTeBJPOmuyicPl195qS4YMltT99ffgmIkYI6QVg0L+iIiaCYkXezhDb1XQR4fDJIhKbe3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAxLpBYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAxLpBYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77F71F00AC4;
	Mon,  7 Sep 2026 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781654;
	bh=Dgx0Ds8bE8GcasxKPUIl9olK5mTOYciWHFQ8I+oTfSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QAxLpBYSDxaT1wXnQWlNJfa2P2Mmn8BG70edSZ9Y4UfWXJ/NAlukxFtOss3lRlTy1
	 AKHhrh5Gjr9bISCZRpMUPtUdBLGT660gnnYsZIaMVY32c+axzkzXoxGJhviYOa6m2p
	 1Vn6QJSguU+poEnzE8CjY+aXPuLM7My7PC6hbyM7eh2obrOgUzWmZjQsnzn7zj9pUV
	 ZrfM/ZV6AauIQPsSHF8IXpfnC6MRkBIKPCTB/etSxn5T90gKR6ytK2slmG6KWT+oH2
	 rCGo0By8Y0imxB0raFn4duSXfW1CJ8Jn7Y3nV5RSIUrurp3ZcropA0W/5zj3c8EAa9
	 UXtlRO11M4prg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Shen Yongchao <grayhat@foxmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] smb: client: fix OOB read/write from unvalidated DataOffset in coalesce_t2()
Date: Mon,  7 Sep 2026 07:47:27 -0400
Message-ID: <20260907114727.2870618-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907114727.2870618-1-sashal@kernel.org>
References: <2026090302-bronco-shame-0d3f@gregkh>
 <20260907114727.2870618-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 6343c1da561962688f203362d80d6a3bfa39fa1b ]

coalesce_t2() computes data pointers directly from server-supplied
DataOffset fields with no validation against buffer bounds:

  data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
                     get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
  data_area_of_src = (char *)&pSMBs->hdr.Protocol +
                     get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
  data_area_of_tgt += total_in_tgt;
  ...
  memcpy(data_area_of_tgt, data_area_of_src, total_in_src);

A small DataOffset can push a pointer below the actual byte area,
overwriting header fields; a large one can push it past the buffer
end, causing out-of-bounds heap reads (source) or writes (target).
The BCC overflow guard does not prevent this: BCC reflects how much
data is present, while DataOffset controls where in the buffer it
starts.

The "validate target area" comment present since the function was
first written in 2005 was a placeholder that was never implemented.

Add lower- and upper-bound checks for both data pointers before the
memcpy, and before any target header fields are modified.

Fixes: e4eb295d38b5 ("[PATCH] cifs: Handle multiple response transact2 part 1 of 2")
Cc: stable@vger.kernel.org
Reported-by: Shen Yongchao <grayhat@foxmail.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb1transport.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index f7b00bcb9df1a..cd98e48fbd11e 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -655,12 +655,31 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr)
 	data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
 				get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
 
-	/* validate target area */
 	data_area_of_src = (char *)&pSMBs->hdr.Protocol +
 				get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
 
 	data_area_of_tgt += total_in_tgt;
 
+	/*
+	 * DataOffset fields are server-supplied and not validated against
+	 * buffer bounds; check both data pointers before mutating the
+	 * target header.
+	 */
+	if (data_area_of_tgt < (char *)target_hdr +
+				sizeof(struct smb_t2_rsp) + sizeof(__le16) ||
+	    data_area_of_tgt + total_in_src >
+	    (char *)target_hdr + CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
+		cifs_dbg(VFS, "%s: target data area out of bounds\n", __func__);
+		return -EPROTO;
+	}
+	if (data_area_of_src < second_buf +
+				sizeof(struct smb_t2_rsp) + sizeof(__le16) ||
+	    data_area_of_src + total_in_src >
+	    second_buf + smbCalcSize((struct smb_hdr *)second_buf)) {
+		cifs_dbg(VFS, "%s: secondary data area out of bounds\n", __func__);
+		return -EPROTO;
+	}
+
 	total_in_tgt += total_in_src;
 	/* is the result too big for the field? */
 	if (total_in_tgt > USHRT_MAX) {
-- 
2.53.0

