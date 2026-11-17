Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923529;
	b=bpBcKz4wgRqoDY+C93ANN1ouANNqaLUkzfgpdeyyZDlubnLczSg+FsbOQYH7Nlb7DYHD
	 zECa6nKnujpSFrMevyRaw2ybmzVEqbn5JVEdJU+QvSYLiK1kMf1Vj60dejOS6GaakTXJf
	 BbaIfj0jUjdOKqZW4TIKNqyLUDpHiNzmdRa5ATgWS80RQCYN78aVQy7dYfKgZXOH8XcUx
	 zN6WY/WUixMsEC1qvt0tKRiKUO0DnqaOOLmPgo5f6zdlct6FFgC3n4nVLT8QdK1FfEGwH
	 eehyY1OVMm62IrKziO401kk9tsSE1qYi01w4VUuRqLVHnJ8zhVfV3kHKggobnaYYyzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1CXHuD+7M4E0rte/HpFih0lklRzK6u8QUeFUsQ4kAjQ=;
	b=TDA9T7QVZV4uUOTl0WVfCkETTu4K4cgO11+eTxYo01vNCLdBC/gZX84IHfh6O/eO5I4+
	 q7Ek32ZEYUUR/X+uLVTidHpjqB8CykUm0jKUG5AOtpIBos+E0v2sox37cqL1YSMH2qgnV
	 2kRPDZtO9wgPy9+vTqZcfbpkbZh1vTBXXZC71U4FIfbIyhBcUV7P/ctC6l7+x/qkMlCeQ
	 LD7n0UkVkY5GbwFT3egmYFC4Le9Xx8t/XCX7kKFcGCfVi/ifiCg3DacrArxdkcUXrAsbp
	 oXG3AoLwEY+4CkgqmISvcNkRCY/u2e3/6C6npvMsz43YIj2f7VFhv+mVMLFjxURPJjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnPHt3le;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78DB606A330
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D78DB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnPHt3le
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed08b07213so22201365ad.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 05:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794923528; x=1795528328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CXHuD+7M4E0rte/HpFih0lklRzK6u8QUeFUsQ4kAjQ=;
        b=ZnPHt3leoE3b+zyVtoFqkH78raa5oo30XzURJHdxuTrZhm1A8S03JBHg4cA7pLp3vm
         go2dWcsQh2NfhfYlVKcD7ba08u0oFlN0PvE6NX4pIJmWe0pENj0S9o88FftCXjN6tSTb
         awrZ4QxC6HLt8OY51Upno5f3DuSdzCOfiA8PGyXQtwoFKELK8qAvjyrUVFRJqOTnkscJ
         9gihPWZTriH7M1kMMgS6njXBlBpMmqSomEJVKsXpEjaOGlr4znjiXPfLJkvL+mwDe5SY
         BLLTE+H+b1hPD795MLqStC25u/0iYPysQaCSVdZEI7PBDuqWjqpVWZSyHBmTnP7rzMw4
         l0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923528; x=1795528328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1CXHuD+7M4E0rte/HpFih0lklRzK6u8QUeFUsQ4kAjQ=;
        b=xMohnwb/UsNIZFZ86lFyrFYU/MmiHU3wG+YRfAE8Sp6NhmtSwRlpleX2QkHOPXt754
         WtgLKbIUJpeMiVhJKDWNp+OIhXrA7la7M//HIz7kEvv0bPBQsrjRxo2LCQW/vlaKH6Rn
         xVma9TKgdfmaPSrv4axT3Ktd28Wro/Wp7KET2/a2+aQ64f1C2bfuEI0U2H09anVnEP9D
         XiTRlfaXLyRA9fYrbG5GuIOrzBuSE0KGFVMZZsCpXDL87faOPhHvOmU6cMZ2/jl2pfmo
         tCDwr9fwWa7HaltP7yyYEfMJLkS5duf9LEVmIuzcThCJ+eFRdrVyjVmwk6wxgB/LUnvt
         VAAw==
X-Forwarded-Encrypted: i=1; AL+hErEscIa31IY+/MxzRXpc/oSJBEvH3hRxRPAJEBT3a1UWA3IxH2yWk6K80AzMzn0Ns39bo2F+2tI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jb6hEj9s6mGf0UsQHcRG/O08s8HYNQQAtMSYHv/noMzl5max1
	xMEvYZaGgjN6kiH3MS8mKdC8Yg5GlUMnnFXtRFqr6Cflj6ymnwdYJ5jj
X-Gm-Gg: AZFdTZfYGNhkGwWuXdB8F3a+4MeQYXOzWYOIUuV1L7q5biPMkxe5mdZaUVZDKFMniT8
	u4q5nfPM9Vgwk8c+8kHLZVg0HJaj2vBX6CbpH3iI37Ws8XC+Q0J/KA8embaigBqEw8lKWeVQ9pu
	YYQV3IHbK889kW/u/iQ5+kD5DfnzOMcxwfEUGHXe2h1TqM8Fjl0VfuqJcD4h7bMI8kFdO2yuSwI
	oGkuRlX5oKsnF2AgVckefI+IXYIiF98nr+zxYdIgZb1+y+DH+pu/vbdWRO365gTL4tDhJ5hRIKp
	YDIXJrGv7b/Yr+KEs/pdncxK3+GOj+1F7ab8eVcPUoE6mu6LEj4cdlt286kdRMvrBkBuDFlcR7F
	llHYhWEuUT/7YKbuzyLXf628eeAu22lS2MqOljZUL84xC5A9ACMEHsVo2e96MI7y8ma1oYtKjfi
	qQGTrWoyuOG6oG8RLNBnHmRx5G0jnfey1ZbWbP0Ofw6+Cgk6SOakNbcdeCARYBbg3ArP8Ugvvlq
	FlfO5A3bHUhoDIvFDk75mxk/c4XXJCac6rKrqERFLf4KTfo6tKxaBAx3xsnE0PqJxfd4A9+w4u/
	VE4Du1MV1Us4OldmHWF2pU/H0b1ROxYUi88LEGPEeJchsxfR4A==
X-Received: by 2002:a17:903:38c7:b0:2e7:ff72:203f with SMTP id d9443c01a7336-2ee0dd9cbfdmr134501055ad.61.1794923528140;
        Tue, 17 Nov 2026 05:52:08 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a586c1sm15937035ad.43.2026.11.17.05.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:52:07 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] fuse: skip dcache instantiation for readdirplus names with embedded NUL
Date: Tue, 17 Nov 2026 22:51:35 +0900
Message-ID: <20261117135146.3174252-2-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE READDIRPLUS can pass a length-bearing qstr with an embedded NUL to
d_splice_alias().  Unlike verify_dirent_name() in fs/readdir.c, this
path can create a dentry whose d_name.len extends past the NUL.

For such a name, strscpy() in inotify_handle_inode_event() and the
fanotify name-copy helpers stop early.  The kmalloc() and kvmalloc()
event-name buffers retain uninitialized bytes within the recorded name
length, which copy_event_to_user() and copy_fid_info_to_user() can expose.

Some FUSE servers include a terminating NUL in namelen.  Follow
nfs_prime_dcache() in commit 78d04af4995a1 ("NFS: nfs_prime_dcache must
validate the filename") by skipping dcache instantiation without
failing getdents().  Return -EIO from fuse_direntplus_link() so
parse_dirplusfile() sends FUSE_FORGET for the unused lookup reference
and continues readdir.

Fixes: 0b05b18381ee ("fuse: implement NFS-like readdirplus support")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
Changes in v2:
- Keep FUSE READDIR and READDIRPLUS getdents() behavior unchanged.
- Skip dcache instantiation only in fuse_direntplus_link(), following
  Amir Goldstein's NFS precedent; forget the unused lookup reference.

 fs/fuse/readdir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 1f6cf565477f..6b2468b575d9 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -191,6 +191,8 @@ static int fuse_direntplus_link(struct file *file,
 		return -EIO;
 	if (fuse_invalid_attr(&o->attr))
 		return -EIO;
+	if (memchr(name.name, '\0', name.len))
+		return -EIO;
 
 	fc = get_fuse_conn(dir);
 	epoch = atomic_read(&fc->epoch);
