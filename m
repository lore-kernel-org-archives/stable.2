Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E03C2795
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723058; cv=none; b=d7KuUI/he275/9sTqFJLYMftR6bKuosx2qbf6fYDAC2Wvev/dL/49+3bn+cvEHLMlkEJ3hJwWU2E4MiCV+ZxHShHjjocm2//5W+T5JXhBLSPr6PtVAtBgCTHGWx5ME/B0Vt89/d6SRieNPfSCS24Z70O9jkzHGCIhr4DoIToy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723058; c=relaxed/simple;
	bh=iux/2ctX1y+UsF2wDxrdM1pMA94PYiFK/Sk/zp34y7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIIqlR9YvHXvC/qE4tONJEPaM2uwxyBqCrRxDeJGlrVs7GybxiOB3K7e4H6T4hNAqRdbP/4XI9C/ALit69H/BrbSuyAGmX1SUyOkfT7QB0Sle2xRDNG7aDRWY2/+ra3aGDWlzbLtoT/cFVbxvCP2s+chEwyALt4JdIVer3JErP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBgJ6GmH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBgJ6GmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076A31F00ACA;
	Sun,  6 Sep 2026 19:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723055;
	bh=j0LEe4CEbUAMr2k6FBe+NgUsqbXfnkMcsdtrXuJ0uHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DBgJ6GmH3VHtMTjB2Yu+oRdJvmWGaHsDtRlY5SxK37NJ1TocFyl85GVp5YDKKSzk5
	 bKIWuRD8fbycqaPuaEA5Ey9hncalLedOl1LzHNoQUXp7OJEyGR2xzByvPjUA7lT8y+
	 Iy74sicn+zL7E7HpsUUBe4HZUPMjRWRfJQgpr9atjOaEkKURDjbja122zq0MEhwV0L
	 bLSZfeRKRJ4ajC1Cl0WYZnx43LNX9g+cwfRuMFbP3heFYp9i736DwLO0Jafl+isJRQ
	 GSIXR2EA2kwhYNu5HeyM8rdT41YDQIOUllw++gKmCdM7qNLzxlTIQiYIzliXh9Az8L
	 HdK9HWjIx9cAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huiwen He <hehuiwen@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] smb/client: reduce fallocate zero buffer allocation
Date: Sun,  6 Sep 2026 15:30:50 -0400
Message-ID: <20260906193052.1791917-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906193052.1791917-1-sashal@kernel.org>
References: <2026090358-afar-boss-f2c3@gregkh>
 <20260906193052.1791917-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Huiwen He <hehuiwen@kylinos.cn>

[ Upstream commit 9e4ec3be67af41ab859302d7109b34976efd9258 ]

The fallocate emulation allocates a 1 MiB zero-filled buffer even
though each SMB2_write request is limited to SMB2_MAX_BUFFER_SIZE,
which is 64 KiB. A high-order 1 MiB allocation is more likely to
fail on a fragmented system.

Allocate only the smaller of the requested range and SMB2_MAX_BUFFER_SIZE,
and reuse that zero-filled buffer for every write request. Also reject
a successful write that makes no progress to avoid looping indefinitely.

This reduces the contiguous allocation required by fallocate emulation
without changing the written data or range semantics.

Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 32a7af68df73 ("cifs: add cifs_resize_file_locked() to guard fscache_resize_cookie() under i_rwsem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 9d5272e7013d5..3a833a55491d3 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3508,7 +3508,7 @@ static int smb3_simple_fallocate_write_range(unsigned int xid,
 					     char *buf)
 {
 	struct cifs_io_parms io_parms = {0};
-	int nbytes;
+	unsigned int nbytes;
 	int rc = 0;
 	struct kvec iov[2];
 
@@ -3529,9 +3529,10 @@ static int smb3_simple_fallocate_write_range(unsigned int xid,
 		rc = SMB2_write(xid, &io_parms, &nbytes, iov, 1);
 		if (rc)
 			break;
+		if (!nbytes)
+			return -EIO;
 		if (nbytes > len)
 			return -EINVAL;
-		buf += nbytes;
 		off += nbytes;
 		len -= nbytes;
 	}
@@ -3551,7 +3552,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	loff_t l;
 	int rc;
 
-	buf = kvzalloc(1024 * 1024, GFP_KERNEL);
+	buf = kvzalloc(min_t(loff_t, len, SMB2_MAX_BUFFER_SIZE), GFP_KERNEL);
 	if (buf == NULL) {
 		rc = -ENOMEM;
 		goto out;
-- 
2.53.0

