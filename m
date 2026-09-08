Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837284B0C99
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870023; cv=none; b=N+3jnUWppSL9IoGP46AE/MkVp4u54EjYqIYoW22nlm5qdOtFc05X5ybgqDvt4mWXxuyam81fZoI54nmArA7jd1FnSDHPfyB5EtJkdTKwu0Tt1LjpR+Pqx6DejXD1idD0FFnQTI2Yp3QC6DNyZSVUI9vLpq4QTbCwmbbqcMX4sIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870023; c=relaxed/simple;
	bh=quQFJfFEzsV7Jqu/UYjeC+XuUV/e9Dwst+9Ja2pWsoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kO9qefwDorRmtRGaq5FvkI7ZaKHFhMFAW/xxrCqVi5oAlfFvjz3I+k7PVVsvGh46Oza6FeJZP+XsiwZ/v4QAOL4K5mfZrdhLWlB1aVWcvUBFH0oc9uOtiaIaqefgYbnXkpWaTTXQ+R598mjToQpviKTftqpbj9rx6DLBTdVYrus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQQqU6OT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQQqU6OT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15091F00A3D;
	Tue,  8 Sep 2026 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870019;
	bh=rnDyEofxd/6NSRNxRqUeZ0+B5LbY9ylVVtb2OXJSKLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQQqU6OTMnIdkW+UHlXp+SX4Nz02cSvoY1BYicvgQkhi6IfyPE7PCFl74ubOPlwtP
	 vjtsuzpXHlrsCXz7hxMYtM1r8hAZBGY8mOaogm5+nqACcLrqZkXuFTpKJrVmAkwTuX
	 dvVlPOZ6oUKnRuXHjera97sjRmkZXG2lqkZVUxuwdFBYC4lP8uMA3RpWM9bmA3U66A
	 fkVC7yLNVKOsVG9/q2xZgIo1lp/BnAPFqh6nIqs1eLoHDp2Kd7ksTAp4Ouy7GGtu5R
	 qc0uLnyX1qVXqI0BjazSTiHYbaO/RLCZgNGbNMwpAsYFIMhvGPNPs2ETaeviiKG5Z1
	 CainhAxWwhiRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] smb: client: reject a tree connect response whose byte count is too small
Date: Tue,  8 Sep 2026 08:20:15 -0400
Message-ID: <20260908122015.2050174-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908122015.2050174-1-sashal@kernel.org>
References: <2026090337-crease-stuffing-cff2@gregkh>
 <20260908122015.2050174-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 65deb18359341141d37dc86fc7853511be3c87a7 ]

CIFSTCon() bounds its strnlen() over the byte area with the server's
ByteCount minus two, which for ByteCount 0 or 1 goes negative as an int
and converts to a huge size_t.  The later subtraction wraps the __u16
bytes_left, and that is what bounds cifs_strndup_from_utf16(): a bound of
up to 65535 against a ~16 KB cifs_req_poolp object runs off the end of the
slab object, and the bytes reach userspace through tcon->nativeFileSystem
in /proc/fs/cifs/DebugData.

Reject a byte area too small for what the parser consumes.  Two bytes is
the least it can consume, and no conformant response carries fewer.  The
new trace point is the 129th smb_eio_trace entry, which __mode(byte)
cannot represent, so the attribute goes with it.

Fixes: cc20c031bb06 ("cifs: convert CIFSTCon to use new unicode helper functions")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Adapted the fs/smb/client bounds check to fs/cifs using direct -EIO handling and the existing cleanup label. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index e69ab38a648d2..3649549ef5aa5 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -814,6 +814,10 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 		tcon->tid = smb_buffer_response->Tid;
 		bcc_ptr = pByteArea(smb_buffer_response);
 		bytes_left = get_bcc(smb_buffer_response);
+		if (bytes_left < 2) {
+			rc = -EIO;
+			goto out;
+		}
 		length = strnlen(bcc_ptr, bytes_left - 2);
 		if (smb_buffer->Flags2 & SMBFLG2_UNICODE)
 			is_unicode = true;
-- 
2.53.0

