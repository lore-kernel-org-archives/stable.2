Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93BB4CEE7E
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473165; cv=none; b=Vb1vGBOmGhrjiZNTfzS4QxkxJebKG5j/UifVjNji1uiGj0tUy9olxClIm6Q3BkPbHOlw32stkYbMKvLQZons8WnOVFKxAx6lh9+Edbkcw+dkbPzLR66FiaX+I4JJLcV6idkEev3Ok6SHUMc6rg2TNhGFlU6DPn+bIEPrNG6u+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473165; c=relaxed/simple;
	bh=TrVcGHbj2TtSqdQJyHLxeKivTSFUEkce/cKcVLryNGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1qGg2RK3qiZW2lYYyuW6+lbcr3UVhbdoaMQlWF2sL6+ZttcOS15MYK/nAfEDO4lvS17LjVQ39Ag3oALkMnec9xYkalDHrw3ysRlTvbXmbDuGmd4wbfwzngO7O8KLSbKzNb454qONBHh6ty3P1wARf31NXkXLrlfBRhXbwkM+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EelizpaG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EelizpaG"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a857ea7754so192000a91.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473154; x=1792077954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n4w9bZBZ+hZ07uC6pPSV2O57YUginTevP0JitdrcPK8=;
        b=EelizpaG98H/6ol4S6fWhXNCASN6Spw/+xv46ntz72aluG5qpEKTM8KUOCHTj6l+Yy
         Y0dEEwHjgzIXrBOmwYuM/sv5q7rjpk+vDwTnlxG6XoDZXjfJEpsHzZXVbh1THh38X+I1
         AHAlT6MSgNxEl+2mQjOhVMbVeARKaLEF/EUL7pUMA9jAbFnezzx0RHJLXvc9oJe5jgUM
         64E/EY70jsnovJ8wSauteR6BUsT4QTaWkEeHN6VrrRl3iBBAuMAy342dzRrexn6vPGnu
         kqhXfPpKPeeqWH0FmRt7QvqREGZba326f1rrjsZFukzXdWe2IN9XLvbOq9Vf1NKdxObm
         r80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473154; x=1792077954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n4w9bZBZ+hZ07uC6pPSV2O57YUginTevP0JitdrcPK8=;
        b=sGP/UOR9nh4t1xcYQft5f4ey9WerGu3DQzf9PZiaAkAepIMTYkH8xXbySqrPw57UUi
         +z1gyvNmLl7CQMLY1H814APa1tn9wV0U2K05JUJUqkQgmvbeN1MID+GxOMT+DmIq+gU/
         CyIpGPGS7ZruB9waZ6vyiXYmMxCMgTuDRkbzB4su1hqGkbsXlEtqzm1yO3+68mIgzO8/
         Rsw/B8IbDQP46LnI5RtTLEiEjcE3tumxFdGZ+OJd+BzmiMPQq9PRrw8Mshj4CIa1h+JS
         cnMebS/pxrV9xPllNfPlRdy+0bZ+F203hMVByLaVWyclfQBY1e8TmVJ6D9k2OUKTUTS2
         LCQA==
X-Forwarded-Encrypted: i=1; AKwUvBw1UPUsoMPaPl7iU2NzOQzut5e14cr7skqYRkmTeG6U1J6HJ7OQdJrIp8omHO2qdxjCB+SrdkU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBPcN6j5UdHGhXISCtr1LHuBzdIARjjFMW/vzSJrwyAYdMDcCj
	No4CKw8DJ5OPBlm+j+VHj+Fb0MktrbcTJgaKxn3Gq/46rgE94vxLKGF3
X-Gm-Gg: AYBFou3HMjO0YWyaZ7H42hGiMk7H8693JuUqPWTSp6j+IUzrL3NQojdYCWa/37BGU42
	sJurOLUNb9doO/Dop7l9R4Ej6M+5syOC/rlEXrHmRX/MYF0JcThuL50cZHGTMduuHit+4z69l2e
	DylEVPHjFZj4Wk9NYuFA1gc5mWvjN3AgqadJ3k632mZ8isehAHuf8zFobskbCwIGGmuJozLzftG
	sfmf3dSfrVgusNUNGIdFRxI6Mk5j9wtzgZfc1TD0ZoKpvCA62N1wxgkaUrDTFGp3QOCLfd4b80H
	wWyeq/CDiBg9UrF3d43o6Rzy/79kedguKn3e3kCqR6D5B5drGddRABA+FDMIa2ZJPfWCQrFrgEE
	SIy28WSKHnqf3gbW1dVb6kmyDAPi+e2DTVFTsbf6VJWJnaZbMV1njgrZHeqHvXqjvfYyldJjXrI
	7dKsOB/hgQiir/kgNVJJ16FVN+mtQLoX8Qhg8y2omylxSrpcRz55bemulW542U8kPHjTEczCD2L
	z0=
X-Received: by 2002:a17:90b:3b46:b0:3a8:9db2:a59 with SMTP id 98e67ed59e1d1-3aa7c6c21f5mr4045344a91.0.1791473153896;
        Thu, 08 Oct 2026 08:25:53 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1c17b63sm5554792a91.12.2026.10.08.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:25:53 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ksmbd: return end of file for reads past a named stream's data
Date: Fri,  9 Oct 2026 00:25:35 +0900
Message-ID: <20261008152537.4147299-2-charsyam@gmail.com>
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

A READ on a non-empty named stream at or beyond its end fails with
STATUS_INVALID_PARAMETER. ksmbd_vfs_stream_read() returns -EINVAL when
the offset is not below the stream length, and smb2_read() maps -EINVAL
to that status.

smb2_read() already turns a zero-byte read into STATUS_END_OF_FILE, the
status a regular file returns at its end, and an empty stream already
takes that path. Return 0 instead of -EINVAL so that non-empty streams
do the same. Clients that read a stream until end of file otherwise get
an error once they have read all of its data.

The buffered copychunk path converts a zero-byte source read to -EIO,
as it does for a regular file that shrinks during copying.

Fixes: 2ae1a6cc4302 ("cifsd: fix potential read overflow in ksmbd_vfs_stream_read()")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/smb/server/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 74cd8007a..ae9f9a693 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -269,7 +269,7 @@ static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		return (int)v_len;
 
 	if (v_len <= *pos) {
-		count = -EINVAL;
+		count = 0;
 		goto free_buf;
 	}
 
-- 
2.43.0

