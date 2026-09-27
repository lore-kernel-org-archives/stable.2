Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D618D62A
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790490825; cv=none; b=riX0kFQBvO/NGEmNS0VqlB6CPAEewYPuXWVfOmjvgCERUpQPHbnAbHlCET79UblFturSeCUL800k8hsU+SqdckIoSyq+FyvCXFhOCOd0oM3rT8rHGNOQ2QB7WMv5of4xogyy/7JbJ3tVpS0U0IMImMmvBD+qDUyay6odJ06WrLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790490825; c=relaxed/simple;
	bh=yKYsbQaSNbfxpL9AXn+Dk6w0376LevsziE0CM3vXnRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dn/q5xzlmANwJge4n3lIHD1LHPCKmzkPkxhk0obEsaRHFNmf1B9sCWnaFnieY2DoOGj1sGnXK5eduEw4/Kp2ZQ4guV5SgqwvDVazyFOvBQCZs9VtHCHwLr2IumkRG8Ocp9l756mTuW7fVdnTZGTDPUEdS42s2Rp9AzwWWnghaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iicfrTKc; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iicfrTKc"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so1353719a91.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 23:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790490824; x=1791095624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x5E4VrjMKmWAeZuEbOPf8+lhLbvIn9eYFgM5VNzNGZ4=;
        b=iicfrTKc1PAxp8WsHiF3LMwU5EowI+39ZBCp3xjDwgxk9MpZ0P58raaCXjzmhPkohs
         UD4iNN9KPhE2o9epeIYkFDWtQEvMNyMq7jkM5DLqf/qUT15FLZUGGH5Mk35N+bPdQal/
         fK3h2d6+FW3/n6mchLLrulwMo+FJt4tbpQe82UaIzXE9+K5lJQANUb+k6EztFvAau0yv
         X3HKVMt/XlkMNWLyPGT5545Nxqg3ywZ/woBW8gQv4at+fbFSZhbEIWDrqKoK+xOZuLfs
         0SFcEX+99vsgMLsL5exCzCk90S8YkSQEPW2lgy/K/g/K+Mm9duObf6RCGPvjvAF6Vru4
         4sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790490824; x=1791095624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x5E4VrjMKmWAeZuEbOPf8+lhLbvIn9eYFgM5VNzNGZ4=;
        b=bRDm3GVaE6L7rgpBsZGwwFirBX5DChgdmZsNfo86epJ/3NQemlhEIDFdgQl4PBzI3U
         eKbXRiY0L+J/5c2jUWlW0USyfnm74YKUCo8SFq3JNMpET+elA/U15YOJpdAyEV0Bjy8w
         vaXZELKRaI+4I/MRf25XxVuG7fwAfKNM7Hh0EW9e359HpAExlWMG7Jof5KCyCmwZIY2+
         wFIhwZCuvScFe20f/rTz0TFIgBKOrWCefTn7L8DZIT2v1lcV8YSTbBKcCrg1x7l0Kkit
         OZ60nm4RTqht5EgHNn6PAOBOnXv7s3t5IjGvq7Uhcnh0vi+LfvGCZtnx4ns4He2wDX40
         c5mQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQ6xIXXEupacP2gIYVe4/JsSQrEjgX4sTdlp10olJKR91xQqwbU1C226asVJ5HEfo6Gck7m4s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIO6jMcraGsc3LgfbDBRwDvLtTjRb2wYTuU+jYm/gnExRHl1OGi
	xJB2qnUTJ2jD3mizUWDlxpX3b1a42G9CLigtKHTLWJREl6URxzrtZzEU
X-Gm-Gg: AYBFou009LGOfFXrYhlzVPmN19xPchgWPc1oczzW/9ogig07qmbcKcAq04ZJPT00Y89
	6KMUR7yjQNVI0bkNHI7BkI2g3XR7qPtgBFfq0S+IWh2A/emuUlw7PmJ0McvY/8HWW8jf4TZTshp
	pJXCHYyM/dLVLL/E5wxQAiRKRx3Wsh9DwGTtVwRPn21F9+HsyBjYSBTJTe63n+UMD348CYHv2qR
	fShmPl/tqIogMNNp78bp+aDZwxU8s7wSNwD5j3h94D+/3yc0MfhrLPMGIeDG77opy4O1D8vFN5R
	tXEKJlHIjZisLhSh30XD0Fm5L78MCGad3sjmz6fVlN2E7TiY8/hOXKjZNeEe/JpwfgTPWA0Odh9
	M2fG8YV9QpMGdxWoF/NiRg6Pic30FF+zYijKvfWCzldbcJDI2HIm3uVjb34f+0meoB7wVDVaTR4
	PKPZ0ooQj+UkCNZ60I8fFf9QR6X+WisprSrgwdAFo5txeSpqq4QJaJMj25QUW1L5cBfNcfAomht
	dCr
X-Received: by 2002:a17:90a:ec83:b0:39e:6c6a:4b77 with SMTP id 98e67ed59e1d1-3a098e43948mr7363556a91.65.1790490823764;
        Sat, 26 Sep 2026 23:33:43 -0700 (PDT)
Received: from localhost ([8.219.239.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773e7c3sm19804747a91.17.2026.09.26.23.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 23:33:43 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: linux-cifs@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Dairui Zhang <zhangdairui@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix OOB read in ksmbd_validate_name_reconnect()
Date: Sun, 27 Sep 2026 14:33:39 +0800
Message-ID: <20260927063339.1731061-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ksmbd_validate_name_reconnect() indexes
ab_pathname[share->path_sz + 1] without checking that the path is
longer than share->path_sz + 1 (d_path() fills the buffer from the
end). A durable fp is not bound to its original share, so a client
can preserve a file from a short-path share and reconnect it on a
long-path share, making strcmp() read past the PATH_MAX buffer -
with a long enough share path this oopses the kernel, and on a
mapped page it also gives a byte-equality oracle on adjacent heap
(the reconnect succeeds exactly when the out-of-bounds string
equals the requested name). A same-share variant with the durable
fp at the share root reads 1 byte past the buffer
(strlen(ab_pathname) == share->path_sz).

Check the prefix before indexing: the path must be longer than
share->path_sz and the next character must be '/'. The comparison
for the valid case is unchanged.

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Reported-by: Dairui Zhang <zhangdairui@gmail.com>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
 fs/smb/server/vfs_cache.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 293dab9..52e83cf 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -1714,9 +1714,13 @@ int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
 		return -EACCES;
 	}
 
-	if (name && strcmp(&ab_pathname[share->path_sz + 1], name)) {
-		ksmbd_debug(SMB, "invalid name reconnect %s\n", name);
-		ret = -EINVAL;
+	if (name) {
+		if (strlen(ab_pathname) <= share->path_sz ||
+		    ab_pathname[share->path_sz] != '/' ||
+		    strcmp(&ab_pathname[share->path_sz + 1], name)) {
+			ksmbd_debug(SMB, "invalid name reconnect %s\n", name);
+			ret = -EINVAL;
+		}
 	}
 
 	kfree(pathname);
-- 
2.53.0

