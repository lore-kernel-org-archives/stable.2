Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794889433;
	b=2ZcZf9BO7CtBFgePtCFSXWqn5sJXDhUVGLw7zOigUFMpUWZgSMvYiBmpPsvO6RynTeT2
	 D2zX+WzlrQP/+lAIJqd6IBUPkrYfY2oGcYI8LwaO1v94K8YtjRoo6NziwU0uaOOlP+O/k
	 WGzGDR5FOtzjuDYdOHCEknevMSbEsNruevNRkIJMqaaftsZEAqFeV1svmRm2UjV/ZJf9t
	 auogudHFwGVk0V95VW1gmU2/eO6PTWTRhA5C3q9FjZ1mT0YmjhKJ/FMPrhxCDPHuJ6L8a
	 UL3gjuL7n7n69RBWyWgVGfpxFt9Cnx1xJIQ5yhHHjiIwVyBrrkJsrXzqX0nzsC+uSaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794889433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MJFJXL0qA7EgCzo1DXahTwcwkNU+5s7BLIy9HpDlOOY=;
	b=XfxpTuFD55LpnkdLRhbMgJH3ZstYT8YvFYQ1Qi5tfcvPuzTzYCgg/TZBzEOxKSwofHMf
	 qyu22IqkOXnhAqeIOOgq0JsppCkLMyh63xPKmML82SYrEDwcf2+7jcsg5WDrunCIiBARN
	 sFuiZtia4XRlZ6yTat4Ch5hHzHdk8RlbjTbbH6zJf6S3suCRBC9iHWNT4zV20J52LC4bw
	 gJloXnrifc85SDybjYMreKeZFDxVk1i/1qxWFNocODcl939y0H135/7sY8gSG4Jrv8hxS
	 x1Ki2kglbyFf9djnAWlz3amO4t+nNwAUkxmBBXLItbr47h2kyenCUU1Psg3P2rfbXmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBXCOm5p;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D33606A333
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17D33606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBXCOm5p
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so2678600a91.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 20:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794889432; x=1795494232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MJFJXL0qA7EgCzo1DXahTwcwkNU+5s7BLIy9HpDlOOY=;
        b=lBXCOm5pef64nqws0Ad4zRtr/Dzy8QWuZeXGQX7VDUF81eeF9+yeWLppPVAKQ8gmO3
         XVIQojYrU1z4+rTQV5vx4vmGcXwhtELC40Jq61sHsB5ZZnjy+DvL+T6rRnXTtd5tIY4I
         U1MF1QjzchHtOT/Xnnh03L4pQuPJASsNhKTyVR8UlfiTQycPzolKTP0lgV86RsqCfIBs
         ZGajV+uy4QBJmdMzqgafBs/8z6ts28HcRM4pr6pedLE9J858hqwlqZ7KlNgKzpV0mFgs
         s00MxfKcgya9ubqnXiPw2JQEjqxYZnlbp/AbpF9H0zvjmD9oIryIPCT8FwimLKFrtZSD
         hLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794889432; x=1795494232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MJFJXL0qA7EgCzo1DXahTwcwkNU+5s7BLIy9HpDlOOY=;
        b=nLtOZRhBsODwfEOfoZG04NgRzlFqK9+UohXKv8nN93Fwhco11HHClGVPdz4rOtpPYC
         FtgcwyW7u90H/nsWK/w+GQKiuaoXy2I/gMaEfQoEovK4krftVKHqerw/MMES0kKVKTjd
         DV+uSK9fzwZwUIu9GkXwqbG6LGqFNI8yv3epo4/mzPQ5/GdAuz/Y2ZvO9qhlAyyDdlB1
         rt6yiG0hu/Zmb11Q52DJCPTa6E3QsFBj5NegxXf+LdN/yGp/pxoHpAmVwqF+LdYFDcrN
         SzMervZU1fXbRVTL2D0udHO7I6yPuTqYxCimO/FkYJplzAfF+9us+jKIf5WbyykeEXgJ
         ZayA==
X-Forwarded-Encrypted: i=1; AL+hErHwkbXFIEGY96AkLIZ2S/rtjfJlsztymOWsYLkfxHBdPuUPFdaxR/cay59Fc72ZdqHVBDeM/2k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8U0Fz4UbVQzBqvfIk/ICK0B3UfQBzUagEiIjfz45Jh4Xu128eW
	Bigx+9729DQhMvwLJLA9ouZYaoLKVF13mL0t+g9a8mwcEnGkBMmfeBANtvL3FK47
X-Gm-Gg: AZFdTZeulJi7/b9/zIIJmi3H1uwt1ekbi7vbAn1OxuiclYrI2ZZSD4P2775fU7Jh4gw
	Wi6lKCj0rV2wQZmEUmwATMqCecYuMECWry1YEq4r7akiKNW4T2FZwq/WIVolwXpVp2gxQB/s0fA
	ZRppJuWtDT89y1a5fUYnEq9qaTHmjAYcz0r/KOsJ8kCZpwd1I0nKGJ2JWwDtpsgcYI4woyxZkXh
	gy2yhIF0YwYaKLrxu7YtFwpqHRBXYY1S0q/tF+AEiHibI0Qp4JeCTsCqtQDC/ZW/aFaS/GFVD87
	c7h1MA/hwD5Bw4IaKk3eY/Y2yGQFmFNvhSkDrJLra0LtrvpGAEvHIIFyyTwMuhsLE5ac7YtKhvt
	/hTkQKByCFnyFm2Y2ytgOMQhGmizrPDh2FUFcCWX+gCazpFbax05xRUaIzHoL9IDMYbO6Swx800
	Ey+nUpnA8kOP74CNUh5yHQlwwjDJOvongGHMMkCuO2iBnTzWeasFK+GM/rfilgELYLvoq4NzTzc
	kc448nD3ZgHCcpFhTDQtbU3O5v0Fs8GmzrxvXHf/vzhL5vPy1Uq8LzpHbc3Rkkar2MOP1Z7ZYk6
	z2GrngyvzS6LS/jmtlOQ48yKiyq12w6d75yxcOfA/caqC5+C
X-Received: by 2002:a17:90b:1f86:b0:3ac:4e18:237c with SMTP id 98e67ed59e1d1-3b1b05b4590mr12347836a91.0.1794889432387;
        Mon, 16 Nov 2026 20:23:52 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39d73c9sm10484995a91.2.2026.11.16.20.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 20:23:51 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] ksmbd: reject SMB2 read on a file opened without read access
Date: Tue, 17 Nov 2026 13:23:41 +0900
Message-ID: <20261117042341.4023597-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

smb2_create_open_flags() maps a DesiredAccess that has FILE_EXECUTE but no
FILE_READ_DATA (e.g. FILE_EXECUTE | FILE_WRITE_DATA) to O_WRONLY, since
FILE_READ_DESIRED_ACCESS_LE does not include FILE_EXECUTE_LE. The resulting
file is opened without FMODE_READ, yet fp->daccess still carries
FILE_EXECUTE_LE.

ksmbd_vfs_read() only checks fp->daccess & (FILE_READ_DATA_LE |
FILE_EXECUTE_LE), so such a handle passes the access check and reaches
kernel_read(), which hits WARN_ON_ONCE(!(file->f_mode & FMODE_READ)) in
__kernel_read(). A remote client can therefore trigger a kernel warning (and
a crash under panic_on_warn) by opening a file for execute+write and issuing
a read.

Reject the read when the underlying file was not opened for reading.

Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 fs/smb/server/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 1f2bc76f0d09..cb3f4f5fe9cf 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -367,6 +367,10 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 	if (ksmbd_stream_fd(fp))
 		return ksmbd_vfs_stream_read(fp, rbuf, pos, count);
 
+	/* The access granted on open can include FILE_EXECUTE for a write-only file */
+	if (!(filp->f_mode & FMODE_READ))
+		return -EACCES;
+
 	if (!fp->is_posix_ctxt) {
 		int ret;
 
-- 
2.43.0

