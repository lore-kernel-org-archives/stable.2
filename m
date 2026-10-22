Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660136;
	b=x99VGTr2klHoYDJYQJ7sGh5z8ZJV9/oXH2Mdz+aP4chpvG4gF1fHifYrwIuaPSAuDUmP
	 jaP137ab/6oOHxfUH90zge7qWpmffw8YtDtKUECDRM/hvZzOFRmllBiA6gd/ZgVmJrzPt
	 hHT/Q4HApzs5u2MDflaJ0SOge2Lice/TaZOkg2UMc12hQQOc2Mu7eh5JPXRqQ4nEuOaRQ
	 bbZk7iuTzKnwQgOZZ1a4MuaTbV9+0A3SH/izMBNtlP6y+/h+UtZgeUJx5Tke2rt7yfNUw
	 IjzHnEtVa6/y8HTCGU33BO2sI/UoZTGtaAzrxH6q83DLzZpko7v5t8IXCs91pDk2zOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=djon3MaXCvkq7QGoVgGYTZVR9paDezDGky2Radk1/Ys=;
	b=SEpWlvCTOYWRZxchxmeTHL5K9ET9rSLfoDttas85QzNGWnMQvys+lMuvhE/NMx+0KbG/
	 g2dAFJFkrhGmDTPIWw7o/T/Nioy0QbtRpDljxIEViAdWe8vRbi9G6BFr2H0ZqEThiMQtr
	 l17dEkv8quiASrETHlzciXTzRPRrn8Ch8dgXZ6ehl2Uds0m8kqv18r4P1q3LRTWlP/HmX
	 8M0BOUAkwEDiCjuwwdCrGkp4EULRcqKOiqbiwaTl2gysrnhiQhTlIm37Bc2aYVLCvnK+7
	 DnM4ai2hPa1FDHJMWUua+8KLs/dy8WlZgM6UGN3BwjPQLIR5DiiPtubp6czCUpMkuvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QvJHn5pu;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28F606A32F
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C28F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QvJHn5pu
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so354315a12.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660136; x=1793264936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=djon3MaXCvkq7QGoVgGYTZVR9paDezDGky2Radk1/Ys=;
        b=QvJHn5puihBTZ8jQ+YngfDAgvsQEEMrRW5H6LGdGZooxSGEyHCi8RownA1labNtfrG
         ZLZuGfyoy5DKyuYKajCyXvBARd8aV370KBHtOklYle5NvpSVBT0KEO1uUZpEJu1H58Qi
         0er7ON55k2PcFo10DEyPe0FchOKhIIqwfH+7pyz9MHrRARXHmHk7hras/ZLVr3NgHf2S
         Vsp+RaR6qlk24hb8+AvF3hV5nco0WHlssxkn+6lD6FCQmNhj7Mkm4IPz2s8+1Bdk8fuD
         GLJAxieWUKGV6GCTSLUkXfb6aEV8oUPvu3J8pbzTFwf7CtevJSehQ2z3kzIMgcdDnSJD
         r67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660136; x=1793264936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=djon3MaXCvkq7QGoVgGYTZVR9paDezDGky2Radk1/Ys=;
        b=i8Il6TaU9Hb1amAIy0f9GuRwY6Gsv2yrVq1ibVn4X4pkO1rOXddh2GPF46OoQ1Q7wD
         7iAIPbVnbTBRNrzYQuEu1ITC5lrfOMfTnMtMmF5rM0CxY12otIDnl3xV0oanYI5tv5Ob
         pnnZY0lEFcXVDWMFjpZddfM6aVgMJuxaV5f6eYhCe3foMleBXOoTztHpfed/cX9WjLfm
         QCHKdT4R2v5DwOX5rd8UQwScM9Qcs0ufGP5B1JsTNJK7e5ZwBol10jqFOW5/wQQkd14d
         jZmcyo3gDyKUkzz10GY4Z/gqzF6gJDjshzo8qGD7sfMZ/7O7OLlyntHt5wQqsbW5L4lG
         t6Cg==
X-Forwarded-Encrypted: i=1; AKwUvByXunscw2XCkHF38NFMAYrtjGxGE+dgCFYxEv0R3HKB8YG5ImpKYfTJgCh94VD9UriqGBqlOJc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcYXyT3IHTahuh2jUJ9Fd8K+RM2rgial0hJRzOCImoTOo80JDM
	IYIVVU5WEoScYPV1XnryASEPK7j98gSyANnR3s3SijaaeS45eyDbJWc5
X-Gm-Gg: AYBFou0Dtk9tCNM23YlMrrSEYLJ/QscULAxym6fT6yisE/oLfTJtxNFkyYgudroLcHy
	veRFL0GgBnBqvxcl883kb2xGJREfBopfLbKzZw8D19VwZFSXAKD4u+YJIpc0PlQhpwiqTj2E8ch
	zvx3p8/wiYEwWtp35me3e99JcpS8dmIM1TuWyL8lErWz6sOKgNMZbM7Am8QPzxvLJxv5wUoi5Ss
	jA7JXW9xZ4PphM/MFG8EnzeAFfdy3ISDQY6GFczmgTYnpGLn2GU/yXXkuNd//203+wNWJ4qm0Qf
	Job44y8FurCwLXVSsmhpAj8iyIP7E55JByLZHTJsWdmGACkAlbOzqBAQiyrfrNjuZRBhE33zmBf
	NVBIpZM+vyCntW22gOf7kmtVG69tM5y6DNlPBeLEvzVvI+PwWN/IESRyofaioM5uFQgWI656swi
	O4T1mAuVX8PMAkUdzY+r3WXx1P9EdxvMl8uJwLFFsswl0Yl2MgpM3lMq/5TOJdzeLaQ1cdPS5QO
	+meDVi3AxSoByqMBaKrANBu33IJNcHXbnSkzpujXNhW4/t00dk=
X-Received: by 2002:a17:90b:5868:b0:3ab:330d:6e47 with SMTP id 98e67ed59e1d1-3ada6c6bb67mr998870a91.10.1792660135625;
        Thu, 22 Oct 2026 02:08:55 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490c096sm3325111a91.7.2026.10.22.02.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:08:55 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v4 2/2] ocfs2: snapshot the dentry name while tracing file release
Date: Thu, 22 Oct 2026 17:08:42 +0800
Message-Id: <pm-ocfs2-objects-candidate-0088-v7-6324344256f0c3b1c3d8-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-ocfs2-objects-candidate-0088-v7-6324344256f0c3b1c3d8-0@gmail.com>
References: <pm-ocfs2-objects-candidate-0088-v7-6324344256f0c3b1c3d8-0@gmail.com>
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

ocfs2_file_release() passes the live dentry name and length to a trace
event while holding oi->ip_lock. This lock protects the open count and
delays RCU reclamation of external names, but it does not serialize name
changes during rename. The dentry can switch between inline and external
names, and a separately loaded length can describe a different name.

The ocfs2__file_ops event sizes and copies its __string separately.
A concurrently rewritten inline name need not remain consistent between
those operations. External names can also be selected at this call site;
the existing spinlock critical section protects their allocation lifetime,
while a snapshot additionally pairs a stable name with its length.

Take a name snapshot before acquiring oi->ip_lock and release it after
dropping the lock. Keep the trace call and open-count argument inside
the original critical section. Cache the event-enabled check so the
snapshot stays paired even if tracing is toggled meanwhile.

Fixes: 468eedde23d6 ("ocfs2: Remove mlog(0) from fs/ocfs2/file.c")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/ocfs2/file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index c6e7606ff9e1..b3a37b9d259a 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -141,18 +141,26 @@ leave:
 static int ocfs2_file_release(struct inode *inode, struct file *file)
 {
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
+	struct dentry *dentry = file->f_path.dentry;
+	struct name_snapshot name;
+	bool trace_enabled = trace_ocfs2_file_release_enabled();
+
+	if (trace_enabled)
+		take_dentry_name_snapshot(&name, dentry);
 
 	spin_lock(&oi->ip_lock);
 	if (!--oi->ip_open_count)
 		oi->ip_flags &= ~OCFS2_INODE_OPEN_DIRECT;
 
-	trace_ocfs2_file_release(inode, file, file->f_path.dentry,
-				 oi->ip_blkno,
-				 file->f_path.dentry->d_name.len,
-				 file->f_path.dentry->d_name.name,
-				 oi->ip_open_count);
+	if (trace_enabled)
+		trace_ocfs2_file_release(inode, file, dentry,
+					 oi->ip_blkno, name.name.len,
+					 name.name.name, oi->ip_open_count);
 	spin_unlock(&oi->ip_lock);
 
+	if (trace_enabled)
+		release_dentry_name_snapshot(&name);
+
 	ocfs2_free_file_private(inode, file);
 
 	return 0;
