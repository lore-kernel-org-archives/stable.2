Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D637B018
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790799; cv=none; b=PwzkZzaBiztcnWucXOKAOW5R1E8ki1NSC90EFOFMzWgYg4wSifSZsc+e4Y6OjjVbnlgzZATZ/G229WiEyQjLxQy3QkBtl/J/zU3jZQkoTn6w8eQoCfa4qhjP+H2OCLMjvWIrNfo9sLlSL0qsnryod/qKp4eZaMcIMW5aqgYrF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790799; c=relaxed/simple;
	bh=6DyIUnVw9gwGL4Y/j98FNT3Y7bToVHSuv2iDs4ynDbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHVsnUi+ASKgPDunWUlckakGyJHiRQ9sUw8eNKaWuklRh7AC+wIHsJkbuEopVPKiUsKLt4cuVkueH/jBfmQJ4ACgkjeN3oYlXHO6KwQhsfn3kHT4JjaDsv5ROhZizraDbhNM+FTWFOKGSlJHMuMJA7ZQcEm31pjmCTV4MLL+wSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaVapKxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaVapKxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBBE1F00A3A;
	Mon,  7 Sep 2026 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788790797;
	bh=v+Wn9QqZ+doMd1CQy44yX+Jf2Dnm4CgdUBQEqCO7Whw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GaVapKxCmt2FUYxBmUAPjzqnVOgSMONuYCuP8PAh/XRdIKuPgUEw5DuveWqevok8Q
	 1XPVFD/i1f8t7RlXRf5tKyH/pQwvTpkj/JNAo8MRWJkFFQPkzrbUYtXIiviqbB6CuA
	 7GqSqeZxDzHcHFlvgZafeJmfiEBX3vIej3lychxzyonRULFxGd8zZPOPxLuDdnxAZm
	 NIYbsbeOjFHvSxGib8jJxjYM8cy2QmCDUTcanwbF4QONh2DUCRIRxO0kZgsWaUseDC
	 /hwajWJ1pTdGqpg5FDY7xl5n/zJmjD3fz59QXrauiIY/N1icEhSQgSj9oS4kWmt8N4
	 RWHlsQG3AXaLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Shen Yongchao <grayhat@foxmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: fix OOB read/write from unvalidated DataOffset in coalesce_t2()
Date: Mon,  7 Sep 2026 10:19:54 -0400
Message-ID: <20260907141954.3223403-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090303-blush-nicotine-5856@gregkh>
References: <2026090303-blush-nicotine-5856@gregkh>
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
[ transplanted the bounds validation to coalesce_t2() in smb1ops.c due to code relocation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb1ops.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 1489b9d21b609..5c570cd238845 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -325,12 +325,31 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr)
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

