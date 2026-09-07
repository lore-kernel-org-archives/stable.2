Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CB3955C6
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790998; cv=none; b=SlI204ltRlUZUu5K9E/5RH0R7OnY3kS4ftocO1FK+mHwdrgnrlh35h3TNVKvDwLvPvNhsjha57nrvmOj8c5qLexn1VLxzc1ia04aDwrCJB6P2yZsBeVT1WELfz/fTGjR4WGTxelwG5papUKiYsXR5eMCUeyfioDQCiWzFzAfXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790998; c=relaxed/simple;
	bh=D51GsCm1yEakUUqr0hgTR440DSJlnCRbHDk32hGudb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U27RBsDxdUduJRQcJiQFQfjZyuy68x88qMLzShOViSV3MLsC7Tj3cH70U+B/eBZKeu0BkWBKjqbOjwP4XRKxx7yu+B6VceYlJz7i6gPCUsvedzmJU81WC5DzGKL7uGiWF+w0FX2yuSziSA82nE5XrBDr8LAp34UTwoUHL0pBFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzATL4q8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzATL4q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E6D1F00A3A;
	Mon,  7 Sep 2026 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788790997;
	bh=0eVLP9A0ctD+KTzMbk+HCzHMcSaylenUUMZjF4IMikY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KzATL4q8lEfcl49j2EKPuKRPHd/t1W3MotPJeIG3aA/4StSxcKqaNeDlzBQDjO5qp
	 9e+fVbJ18/34Ygw6WkqTC4iDkoXG1QtvnKRLD8ZHkxGR7fhfE7DJNm9iGZvN7FJ0/V
	 mFvb2d8zBWWdCKO6/XHHL+Z4vcXtzsRfray1PXuxPZzmCq8zkUAC82VXnfaVEhFTi0
	 Gx1BwFglyWL/AHepTzt82P0HjsRqdc1Ks2XADuYu/pvav3fZIvQkz0f66sG9uhaCC+
	 lA30ArfM/pBAnhtOYIAzxMgB4EF3io1Ab6mLVTqkdNOxwGBB0twJfm34N2wEPGHdPc
	 3IY4hjR7ef20g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Shen Yongchao <grayhat@foxmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix OOB read/write from unvalidated DataOffset in coalesce_t2()
Date: Mon,  7 Sep 2026 10:23:14 -0400
Message-ID: <20260907142314.3231866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090304-transform-headgear-e784@gregkh>
References: <2026090304-transform-headgear-e784@gregkh>
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
 fs/cifs/smb1ops.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index 41e468d06b5b0..55aa58460dff8 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -319,12 +319,31 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr)
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

