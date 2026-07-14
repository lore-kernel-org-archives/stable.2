Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA551386443
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029835; cv=none; b=p9Fp+iMzgPY5rfujORmQbfED/BhYLceTm9D+O2E9rqfrbqWi2b0tPD5fEgE8o1L1wKbYO03psAD7BaCOQRj2ONWDZkWCkmM3Y9YXSf5mm3fRqYK2CcBBC7rp+1rrIXjRghNzYmi1x8+EoOKsCj4G6bMzBRtRx2RSA+uIbeHdan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029835; c=relaxed/simple;
	bh=XKxW2TQY+X13rVob3xUUT3lxqULNnyORDzPC22ICKMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cd6dXyLh0c+uHRvO2c9sXI7A93NIQX11cNUQQolLOFC84sPgPx+7y3Vq1xSzFX6PngV30fZW/roKm0WHAf6y51Qst+GqJ2CcFC5MA+6gMtfrB4YxuRiydgAnI0H7/IcI9uFRXPBwQRTXke9fRXxC9MYtKTgvi104nJ76COhKCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnI8Kc+F; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnI8Kc+F"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f29ec73064so36791516d6.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029832; x=1784634632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tfheTGlygVpDVxAIMsoMk40gZJxut02XkQ4/10VORUc=;
        b=lnI8Kc+FHIlU/SzUIjtKC35t3tpoYF0etvziPGwVeO6vp1/KJhOSn1/qQdGzm6mCZy
         cP9nojO1WzaGO7LD1+4guNzWoGnUC90M5DgizB0xEXhb80lcN5SCnUnmLm/BVpuFpoUT
         P9rW4UgwwDFZbtSPzq0YYYXAdzfy6cV9la6oE56DZcX6ifm+UekU+uJ/w4qvNFr/sgjA
         jX3UzzFz+xwm4xG9yhWTHOXLR884n+ULxVnRP+O0xuyvN8JxfpblpaAjQQ/rJS3GjynY
         sDojcbyiKszOQ7tCkSK3YkxdBGvnDPYoUR+SVK/3L5+dGv0sW7k8I/SYBc4cPW8hg14n
         XT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029832; x=1784634632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tfheTGlygVpDVxAIMsoMk40gZJxut02XkQ4/10VORUc=;
        b=kOrYI2ibLmF6yhl33YXgHXdrnxINvf/vzRiM47+4MzNyQg136pnFxsaIiEMhK2Tv/M
         a2902hMAnHBk/dozulb12etARNadLXYtInDueklUinF+1lF2Kr6e2XYyGuE0VrphKC6i
         OIZY2WlAjxhwcf53cYI/sy67A8Ft/DpWb5+hNmKBJIwQhrgQ2Q7tOdwb4knjDA3iMhiO
         Lb1NFg8MRvITFRhJmIDdmiPPoIbWmlJRp5FWXij57XCoIzCJgqeFqd/G0A0i0uRoPzs4
         4K7whBNuorloYJpvShNHd5oAdOtIcJKMs9Agl9NbV9xNHi9+ak8azjEh1z2e4NWiXs29
         CDvA==
X-Forwarded-Encrypted: i=1; AHgh+RpW2mLjGjxFKQJPMgJWOlBhltvvpqX51KfW8IfXGN+CawgiARm8vLuBXrh0FdRksTai5c5WErU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZT4yy2Au3UdZE6P4l9kHGeR+WpYdHXHQR/bPxxqR3A0ESkLN
	fFtp3jpO927qKobNvCgshbDqkbKOgzIAHkaCRftV+j+r9QTqxMwvQyIF
X-Gm-Gg: AfdE7cmtpJ9We9i8zrmHlX+Jtkuq3RlpnSsq6Masvmdd9Qp0EwTEvCBli2Bpx7qZcb5
	wNtQ9IlU8rnZeQq5eljCQUaDbC5OIxNhX64TTVYM0PVn5zN8jNrsz9/8Ov6qfIZFh6hmwCAT8AB
	RXmLy6Dw/6XB/Uu6zGQGEWLBgx1D61cnuVyIn1I3cr/Qk4wMWBjXXbDVUD/CX1cRrtDxWaq3Zha
	DrR2U+0J3lWTw5l3K62Xy15SVnphjpP0RZPxWkjhDBIaYPGogX5d5O97TmsvfA4Ha7w4bKg4Vp9
	0Ac3avo81ipDMsllY+hrVJvJ/BeyhWNvppQayFWe/fIIOLKP2wyHkPZ/1yMO+C/fnFgj9uKw4oa
	7pb42cZ3BLMssblzJG96pF2mH0m+TOZCrdKNkoUOZ5z2VMOa0S98xJIAeaZ2kzEaJAhxq544RGC
	QdyH/SIAiXGVHvITipmdgrx6tT76nObxMpIPvGISw5tAak0WcvvUr2QIWOW7u6TuPOkKBjc3XF2
	tuwjZFRTg==
X-Received: by 2002:a05:6214:238c:b0:8fd:7913:b345 with SMTP id 6a1803df08f44-9074c73cd81mr19960516d6.22.1784029832510;
        Tue, 14 Jul 2026 04:50:32 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea876sm168065016d6.40.2026.07.14.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:50:31 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Andrew Price <anprice@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] gfs2: reject an over-long directory entry name in gfs2_check_dirent
Date: Tue, 14 Jul 2026 07:50:27 -0400
Message-ID: <20260714115027.3765869-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

gfs2_check_dirent() validates a directory entry against the space in its
dirent record but never bounds de_name_len to GFS2_FNAMESIZE. A dirent
with a large de_rec_len can therefore carry a de_name_len far greater than
GFS2_FNAMESIZE and still pass the check. That length flows unclamped
through do_filldir_main() -> dir_emit() to the ctx->actor. In the
NFS-export get_name path get_name_filldir() copies the name into the
fixed NAME_MAX+1 byte buffer nbuf[] on the exportfs_decode_fh_raw() stack
with memcpy(gnfd->name, name, length), so a crafted or corrupted on-disk
directory overflows that buffer.

Impact: an out-of-bounds write past the NAME_MAX+1 byte name buffer
(KASAN), reachable when a gfs2 filesystem carrying a crafted directory
entry is re-exported over NFS and a file handle is resolved.

Reject dirents whose name length exceeds GFS2_FNAMESIZE at the read-path
check, so no over-long name reaches any dirent consumer.

Fixes: b3b94faa5fe5 ("[GFS2] The core of GFS2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: move the validation from get_name_filldir() into gfs2_check_dirent()
    on the dirent read path, per Andrew Price's review, so every dirent
    consumer is protected rather than only the NFS get_name path; and
    correct the buffer description (the destination is the NAME_MAX+1
    byte nbuf[] in exportfs_decode_fh_raw(), not a GFS2_FNAMESIZE buffer).
v1: https://lore.kernel.org/gfs2/20260711150845.gfs2-getname-v1@bommarito/

v1: https://lore.kernel.org/gfs2/20260711150808.2919076-1-michael.bommarito@gmail.com/

Evidence: a crafted gfs2 image with a directory dirent whose de_name_len
is 300 (record length left valid so the existing size check passes),
resolved with open_by_handle_at() on a KASAN + KASAN_STACK kernel.  Stock:
BUG: KASAN: stack-out-of-bounds in get_name_filldir, Write of size 300 into
the NAME_MAX+1 byte nbuf[] object of the exportfs_decode_fh_raw() stack
frame, via open_by_handle_at -> exportfs_decode_fh_raw -> reconnect_path ->
gfs2_get_name -> do_filldir_main -> get_name_filldir.  Patched:
gfs2_check_dirent() rejects the entry (name length exceeds GFS2_FNAMESIZE)
and the handle resolves to ESTALE; a valid name still reconnects.  Built
clean, no new warnings.

 fs/gfs2/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 0237b36b9eb16..905b658a05177 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -521,6 +521,10 @@ static int gfs2_check_dirent(struct gfs2_sbd *sdp,
 	    unlikely(sizeof(struct gfs2_dirent)+be16_to_cpu(dent->de_name_len) >
 		     size))
 		goto error;
+	msg = "name length exceeds GFS2_FNAMESIZE";
+	if (!gfs2_dirent_sentinel(dent) &&
+	    unlikely(be16_to_cpu(dent->de_name_len) > GFS2_FNAMESIZE))
+		goto error;
 	return 0;
 error:
 	fs_warn(sdp, "%s: %s (%s)\n",
-- 
2.53.0

