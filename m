Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60B4DA535
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449084; cv=none; b=MBBLDTt1sCLyTPlwY1pHJEyiwoxfYRJ1ZQvgRovqNvnW0hXDEToMSX+tCiOx0A5tA0lTQe6CQD+1l0mQnkk3xIi+4yvdcPFuDrPbf0/LFQ7GB4Easup8enCebd/K3l2cYbrntpU1W+pXBXIUl+6z3OpuO/oFcMlKd2GNfTm9LjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449084; c=relaxed/simple;
	bh=hiRQlPpIGglFRXty3EYqUEUerglqeZb/X1JgjZonIb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWe3W/f334FCV5q30usbzXknLunHS2LZs+cZbnfN5wmwcAsxyVrB0KpJKUkKA1vAM6xZkhJ3EqvJVLHujQbESVQ/qyA7rnl+kqtzi0YO8NV+uUGSUznfbCxRD/uAMQd4lpHQ5h2GQSRdlimBDBxUJBTXjl8JuztJX2eiY8RLcFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6l6yhPy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6l6yhPy"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4995df974b3so965e9.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788449081; x=1789053881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKRvoFT0iXNtYocSHfeIp3eZzwJLnARoSnyrks3zVww=;
        b=r6l6yhPy/Q4/bGMqe+MadVsnNLRhlJsHIq6niHWZ5BQ/bC5L631myVLIPLFlarj5l5
         kMkpIpQJbVj8Qr7UCUWqDcjflKFzfaKyLy1Q0ibb3WATdOIXVeBKoHAQmoZyC8dTU+Sa
         sfD6DRTP01xYshXqccBgLNWmItIA0wCIoEbw6DmXoTYM6vNMFvx+O2ZPdLtY1Jg1UZ0e
         hnkYeGYw+tq2/2oV/ZD2yxX24lo8LPoqT86FWzwBMzRGEKq7DGYjNn8SWz4OKcfXH6jf
         xI8hdCcBly6EGtDkiS+1sZ48RpgPf6C3woWe0Ah0Ft7MDplYg82SFRKTgXSzZx8Fc1m1
         vI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788449081; x=1789053881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKRvoFT0iXNtYocSHfeIp3eZzwJLnARoSnyrks3zVww=;
        b=UGA1RT/WkHvFtmADGFImlnurl/SlDC9qaT49pqEE1SVA8fWZNei5lSMP5D29YJUqz6
         irJyNTdWzHrEuri01RrSc8vyMPccVJdXmnZjoKx86sq7Ghls5f60YEhlp7C/GzwIQRtH
         DdWyt7DYc4fbmgDnLdfYxZAm1Z7GktPBFY3966/wK9g3P9YOFpKeTihpBopumg9v1b/w
         6tKktC+rhjw218Nu333r1akf2LxRNtwaPCm+gnrHzPg+Eo8W7/pQK/OQ4pzP5W96Df+7
         EEd5U2kML/dT/Zwi8NDVHeZQWfKyxZBux85iycVlTlgw1hDiHFM+ptVCCatDFOsKhrkI
         hGHA==
X-Gm-Message-State: AFuF++l1tZQMOk1aY8By/EMTFXKVO3cmcZDLlUTOIUp2hSFBMdq/0Luv
	ugqUBJb3us9OzuuqHMshLomWh93JoZ3Ncr+84810TKiZ6Zo2ha1ueJKY8QbaotLt958=
X-Gm-Gg: AYBFou0W76wm+GQYLhZQ6+XDDV9dQk8ywdiqoT4FAVvoAVRlHQik1kCXC8HIMrUfyNJ
	kIjtkKkrBVJXvsN8ygQNqOGpoxJHDYg7AK3Wy1sxfXdoOLLVXx0secquYm/xT4uqiHC/KpA13tL
	NdpMBXDCkLT1nab+h8mU7331YRzWc+qVYpFQ5kExsPa2ls5ZOQ7En5Tdradv3O3zeHS+4exqNfr
	0LS1mUiB3pS6h5xkXRrINi+WspBUK56v8Df5/O3mt0Dc3PpHqzp31u5IYf4edPN4zrSbM6/VmgO
	03xCDJ5wTz8w/2L2c7WNg2zgk+6d/mgyCnXZvFhVRtnXhvFsiSWckwbMt0hwkYfxn/H8DY10/bJ
	/SypAbkyCgfPEXKfAyHq/rakyrW1dD5pA9YjD5H2TNCu0Ht0K+u6Ny+WepLx7uDyj2Y6lvUPt9M
	YQn4KDdNA8xOF5cwrOHQOa7JpWE75nuoa9d38Q98ypL8YVVseQndsITv3DS70T2Cgy+/jFdCf2Z
	sZFGYllJRL56tkUwVuxZ0vQhFdk0c+Zj7Pzwvg2sGLtCk7fpdR+vDL7S7BNGAF2wxMxYGKIYnKK
	Qcr5HlXhFysrgg==
X-Received: by 2002:a05:600c:a03:b0:492:4a7a:e415 with SMTP id 5b1f17b1804b1-49ce583e8d8mr109612635e9.2.1788449080400;
        Thu, 03 Sep 2026 08:24:40 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5563c6csm107207695e9.4.2026.09.03.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:24:39 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: pvmohammedanees2003@gmail.com,
	akpm@linux-foundation.org,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] ocfs2: fix deadlock in ocfs2_get_system_file_inode
Date: Thu,  3 Sep 2026 17:24:35 +0200
Message-ID: <20260903152435.1801594-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammed Anees <pvmohammedanees2003@gmail.com>

commit 7bf1823e010e8db2fb649c790bd1b449a75f52d8 upstream.

syzbot has found a possible deadlock in ocfs2_get_system_file_inode [1].

The scenario is depicted here,

	CPU0					CPU1
lock(&ocfs2_file_ip_alloc_sem_key);
                               lock(&osb->system_file_mutex);
                               lock(&ocfs2_file_ip_alloc_sem_key);
lock(&osb->system_file_mutex);

The function calls which could lead to this are:

CPU0
ocfs2_mknod - lock(&ocfs2_file_ip_alloc_sem_key);
.
.
.
ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);

CPU1 -
ocfs2_fill_super - lock(&osb->system_file_mutex);
.
.
.
ocfs2_read_virt_blocks - lock(&ocfs2_file_ip_alloc_sem_key);

This issue can be resolved by making the down_read -> down_read_try
in the ocfs2_read_virt_blocks.

[1] https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd

Link: https://lkml.kernel.org/r/20240924093257.7181-1-pvmohammedanees2003@gmail.com
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reported-by: <syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
Tested-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc:  <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
 fs/ocfs2/extent_map.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index bb3a56b7f9a7c..5e86c7e2c8212 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -981,7 +981,13 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
 	}
 
 	while (done < nr) {
-		down_read(&OCFS2_I(inode)->ip_alloc_sem);
+		if (!down_read_trylock(&OCFS2_I(inode)->ip_alloc_sem)) {
+			rc = -EAGAIN;
+			mlog(ML_ERROR,
+				 "Inode #%llu ip_alloc_sem is temporarily unavailable\n",
+				 (unsigned long long)OCFS2_I(inode)->ip_blkno);
+			break;
+		}
 		rc = ocfs2_extent_map_get_blocks(inode, v_block + done,
 						 &p_block, &p_count, NULL);
 		up_read(&OCFS2_I(inode)->ip_alloc_sem);
-- 
2.43.0

