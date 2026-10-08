Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562F446053
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473176; cv=none; b=hnqtAKRrMpzcGEkNs5hFS+v17hMUVIiw/CKmzzz9rBXbE8dbpaaMDLzAB/UHcNi6Rau2NnxTjAYSLs+vTBtBpYcwiuZJG0t7lYeSuT22XuTJ9geW9wmVZo7/o/xvzm2xFvz7g0E6Al88lnu1BXRz0Z/TXgqEnnXWOBwD4X2PT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473176; c=relaxed/simple;
	bh=BnX+tW917e2ep0AD06iDELoUpJb1f9PtjJfaF1/h/ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzbTq+QUKJvAhw86K6N+afp9Jqggbl3bsi9aXWf0cTNpVMuNz1mZsK0o8yAZHtB3A7SFPmsTnEbojbPwiCa3UnKJ/FH7jpdYVMEy2SYCKvkQiTB5hJ1ZnUfXe1Y5/y1Ra2fK04zEkp9IwnQgpx7uJqYtyTda3XRwhDWwwpmlrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqmY2+br; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqmY2+br"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a4c78ee4d6so151430a91.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473165; x=1792077965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6dQo+XOFZwjP4FilzjIvU+VBwZHW7Mw0WgQYDNHew8=;
        b=WqmY2+brN1lef9DS/JSSUOt6jXjx8RW5+1hr/1QZODlEKHcPVCPyzsuKivEI+o9e/u
         RHIBdDX96YSEhs0g6hrGaFAML8D5GJL2pCTWSjRngd0Qyps8PzF8LJmwEuen8TVVSAi8
         xT1ER/BgN2Iy8iYiq0DvqckXMNzQBKySaSDnjsVNVQ8wVEPycUwrazZyCl6/XhEDWzMJ
         uJboSsEpY6AoKlb1sZ4Y0RjwioOzv3FDy96KMj4dPjQiJTw+OKYN9CErcKuzKsJfVMaS
         xY7YNgaZBI/jwHZfNBn+kI4BXWmCVW41RjcQoEZ8V8lqPJPdR4AHBBtiHKnm5Er8+n7F
         X+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473165; x=1792077965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6dQo+XOFZwjP4FilzjIvU+VBwZHW7Mw0WgQYDNHew8=;
        b=vB8avX+pIdWyFaAcutislNNrUjMyAVv3NYQk4kMb1WDfcdSot1NKTogelD9Yj2Hje8
         TFad1Rpx1ESruxLxpV8va0bXZEoO7Dde4fQ1FjhO76Zck9rz+d6T5ZRtcxkstFgamu3O
         GiZaA2OqZQqLxL/S5E1Xews2MEYTeCWofaraR47wXOTYJPHXGfpEcjMLWVeKb39+xAoo
         fT2eKwFcPvDQ+3Y2XXgHQlZqhWZIp5w4BqNqXVeZmmkFJtB258tvbEHSl+/J1caruRjD
         rJiIzUDBqALu9RV+UKOU6+rJHDrbkbtdp5XqaXZtESqPv7mRCAM1dDvvCruARShw4Wyp
         fM9w==
X-Forwarded-Encrypted: i=1; AKwUvBxlKN2RdDQt7jGtjfDLxXj0zLDsoM4nCjBUbR9U7BrM0gvaqvQQOoqj0cQGXKTNuDCKSzSrg1I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6jdBeRiJPcUblxOTaiomyLq0OtKRN+Bhkh036tGu4lhmh3VjN
	e22IVswpEaWi7PZkycoUtAj38kfYx7jCwHrQaCXnw/GXslqhNZ4/CAnN
X-Gm-Gg: AYBFou2+9MAzDJ4DHPA7xjCvl9lJnZW2eIR7OEBh2WoSAj1pcJrs7p8e917sQt6D4WF
	vJRa6ZZuBf34GGO2+YciS05E+QopRp92dVbOe4ImBdvVR3dOrePfH7i4gX/7yqnRZlw0NSQCo2x
	jdmoS2gBTA6+cH0Mf2yMTah/Y+88/La10xmK1mNfxyYFPFUNfyUWdqBKft4cwJ1NBjpt2/XBOfP
	lFOHIssYqjOwVRbA9LETEySy/Tw7BIL5c2fAUVDGrQ+yZ0w7Y+gs+ILa4by/LmrjAoJCbGRIZQS
	fOiWLSQ02DCkeKNn8BiQYmrLrrsjCtJRbRLrCGEajbwQyTOVmk036d3DivX+4EoonxGWwEu79s2
	wu+EP74aOO0sdpG8c4gEj/gvf3r9sqZrBozu4kC1/k5A6ADcYQE8dtd/NW4vCzDhfwDaysHU52s
	N3OU8LyDPdhto4SUBm6oImnjhKVWuD2VPzKlRc5YqZvSJFgTj9WQX4nl+p/o/tCMw=
X-Received: by 2002:a17:90b:1809:b0:3a0:bcc8:1549 with SMTP id 98e67ed59e1d1-3aa9a437f1emr4109382a91.6.1791473165176;
        Thu, 08 Oct 2026 08:26:05 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1c17b63sm5554792a91.12.2026.10.08.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:26:04 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ksmbd: preserve unreadable named streams on open
Date: Fri,  9 Oct 2026 00:25:37 +0900
Message-ID: <20261008152537.4147299-4-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008152537.4147299-1-charsyam@gmail.com>
References: <20261008152537.4147299-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A write-only client can open an existing named stream with FILE_OPEN_IF
without permission to read the underlying file. The case-insensitive
lookup finds the xattr name, but querying its value length then fails
with -EACCES. smb2_set_stream_name_xattr() treats every negative result
as a missing stream and replaces the existing xattr with an empty value.

A failed xattr list is not proof that the stream is absent either:
for example, -ENOMEM can lead to the same empty replacement. Preserve
listing errors and create a stream only for -ENOENT or -ENODATA. The
latter can occur if the xattr is removed between listing its name and
querying its value. Return other lookup errors without changing the
stream.

A write-only FILE_OPEN now reports access denied instead of name not
found. FILE_OVERWRITE_IF and FILE_SUPERSEDE on an unreadable stream
also fail instead of appearing to replace it. Stream writes and EOF
changes already need to read the old value, so such handles cannot
update the stream after opening either.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/smb/server/smb2pdu.c | 2 ++
 fs/smb/server/vfs.c     | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 4d43de74f..52a19871d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3420,6 +3420,8 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 				     xattr_stream_size, xattr_stream_name);
 	if (rc >= 0)
 		return 0;
+	if (rc != -ENOENT && rc != -ENODATA)
+		return rc;
 
 	if (fp->cdoption == FILE_OPEN_LE) {
 		if (!strcmp(stream_name, "AFP_AfpInfo") &&
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 7020b7de3..3fa0e26e5 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1952,7 +1952,11 @@ ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 	ssize_t value_len = -ENOENT, xattr_list_len;
 
 	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
-	if (xattr_list_len <= 0)
+	if (xattr_list_len < 0) {
+		value_len = xattr_list_len;
+		goto out;
+	}
+	if (!xattr_list_len)
 		goto out;
 
 	for (name = xattr_list; name - xattr_list < xattr_list_len;
-- 
2.43.0

