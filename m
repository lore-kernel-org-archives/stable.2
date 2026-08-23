Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A226FDBF
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787527636; cv=none; b=PrFc8L05Zs61l/Fd61nBOxG4cQDB3hEorPHst2lCkJ0k+XDnyjljP3raH/NtDGFyZo4GdBVP/Ybl/lNY3sD7w4xR3RPr8IG5NFt/NGqXaP4ap/f1YT/D728K8jlPSXQWO23NN7kX/IsoyI/uOdgNcQWGYUg2IiBTDuGy3ywcO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787527636; c=relaxed/simple;
	bh=HrsyjT1Ek1X1mbUhCltTnuu1jNp5aT6vFuyQ+8cV1+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bHs7+LBCu4PjtiFwvF017raZLMWg3b4CENxaakxHXgpOaJ1pvvwo9JFaeXUlRwI+i3RnyWROAdJnHC2Z3oAczCWXeiFSTsMAUp7tyoXeeVxvqR4gq/WJ3GRXGLrZm4huzYOpTozXTF2fLyk8wXUqdLggwVvIjWpGQfjlCqZARmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ut4m+WTj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipKUIaFL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ut4m+WTj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipKUIaFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787527633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l+jSiflMXrTCTdSE4t4LfuleogagVvtvuwLtqzZj8u4=;
	b=Ut4m+WTjXvyZniXLdwBautwDm0BZOpbe2AhENSbo+U0i79wpZLWiDrAMsDCpb93qstdRK7
	eX6x9clEsJC34MMtkT8pQDk9KUx5Ev7VFrWJRl93yHVkGbdXVilPq1H8SrFADmZARJZre6
	r6PiagbX5PlYVHXjtnJL7AQTFhKm6RQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-6d2VkxjLPgqJNuojdvHYbA-1; Sun, 23 Aug 2026 19:27:11 -0400
X-MC-Unique: 6d2VkxjLPgqJNuojdvHYbA-1
X-Mimecast-MFC-AGG-ID: 6d2VkxjLPgqJNuojdvHYbA_1787527631
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-448bb8bcf38so8587851fac.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 16:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787527631; x=1788132431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+jSiflMXrTCTdSE4t4LfuleogagVvtvuwLtqzZj8u4=;
        b=ipKUIaFLkvliOLBEN1g3g/Xw/KdmNJp4Xg4aPYELb8n8btMmdKg3oBq39jzwM7N1sa
         DAMlmkn44dDRFTKI1wZ0S624ZBTj6SnwsmtFDZLUyUh3/mlW9Ogydz6hTd44ehpj/+u0
         4jZuclyhVW9j0Riw+vCqFu597ZMeoKZCSdqrIgNhijE6g9TyvSJMfjw6IiGxUvGNHwS3
         3cO9pogkxDddYxau30zkBtWUj6EfmAVz7GL/3QG3d93u9jpjErPKcZ/PKtLcVAtJSwxX
         1Brsej4fQrct0TZRigllXQFjZr4mNjk4WxLkkL5XJ0TPYYF3jHRIVTLh0xmzfLPhAW1b
         1pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787527631; x=1788132431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+jSiflMXrTCTdSE4t4LfuleogagVvtvuwLtqzZj8u4=;
        b=bMEyl6vmGx5inUku3YYxhKyFBu1XHYxIAJY3eHCRImLq6AkjjqSU1pykQVTB12eZqO
         QY06vg3DLm45sXJrOoYJ9ugC0lX2WmGA1aJEDvzbIWVdqw49yIiElMJP1cHdTCHYXHx1
         F4jzxQt+XMZxFNI9xN3LJGDKFwuua8h7VnzW22yI+hcQ8LqpLG47t/NIkJoiTcVcCDjv
         wYq6+79EoOgEKgCsBXL0fobSSmotWNhTLUFHBl6au+wB46H2fTRt9BqkVkVB2qdv3sUQ
         7dIHI9AORAU6/p0sKsIU2pjDN5NLxoV4bPIdauRUFwCzRZYce9VMSH3w67wGo8yU6IDu
         iznQ==
X-Forwarded-Encrypted: i=1; AHgh+RodQA7Hnh9lt7+wDN5eQW67KFtiRzXfX68q2wOXkbIhEYYEsiYodZnGOKMxx/nopemELGHpLKk=@vger.kernel.org
X-Gm-Message-State: AFuF++mROE0GmJ4Z5B6/lQCBIsUddsjEkw9zZ/4kw9tnkxIjoI/jE3yA
	8+kxd7g7Q07vfsQiOQuIRVG/09CpJgUDG/ArYqrfiieqA3ubQElfaiW746R/MzwZYthI8XvhaXT
	I7U46frP9am/+k8DQx1TqWTkhNdLRow2ubUucoHOMZAV2R5t3DtcDyR2HrQ==
X-Gm-Gg: AR+sD10CFXi3G8VuGXMS3laCtkJaKTcS/F+EILDgi3Iv/8Fe0oH6jzBWSIT6R3OgAP2
	k3DYxaTR2U9n6sMKBTY2qrEy9IGCzJWZXIG5BAgEmWdz9LF9WFn3xCAekDqGqjhAObGj82/OJA9
	oJVSb4OyO1ad82k1lamIdLJUiK8h9r1rJU7CSVR/K0+6CciJZRe53g/vW9/0uUmIA8x0YMPlxPr
	Yn4e1Yf74B+P4q9jyhPHLRloFJIvk2bsWI5tbvKX8XFCt/AN6q1OWrpxhDIuugYxUSO0PMr65WA
	4c79lZAZuZvH+INWB1ymKhLHJ6U7tWPTp6mjN5tQkRPBwoXIgh4pM1yS7B5NM1UneIDnJNT2lrn
	d94Vy/PHaVaHPndqym1BUFmGwPJC1zRT8agn+yXaq32XUKnodx/E35ZyRSOj0MQ1QFA==
X-Received: by 2002:a05:6808:1b0c:b0:48a:ddd4:d36f with SMTP id 5614622812f47-4b2ef33a8d5mr21956177b6e.8.1787527630975;
        Sun, 23 Aug 2026 16:27:10 -0700 (PDT)
X-Received: by 2002:a05:6808:1b0c:b0:48a:ddd4:d36f with SMTP id 5614622812f47-4b2ef33a8d5mr21956147b6e.8.1787527630487;
        Sun, 23 Aug 2026 16:27:10 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b32c835f6asm2039478b6e.9.2026.08.23.16.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 16:27:09 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()
Date: Sun, 23 Aug 2026 18:26:46 -0500
Message-ID: <20260823232646.3170915-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smb2_duplicate_extents() has no handling for
FSCTL_DUPLICATE_EXTENTS_TO_FILE failure: when the FSCTL fails, local
inode metadata may be stale from the pre-extension or from concurrent
remote writes, but is never refreshed.

Force revalidation on FSCTL failure and use i_size_read() for the
pre-extension check.

Fixes: cfc63fc8126a ("smb3: fix cached file size problems in duplicate extents (reflink)")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7d6738ffcb80..bea4876b58cb 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2218,7 +2218,7 @@ smb2_duplicate_extents(const unsigned int xid,
 			       trgtfile->fid.volatile_fid, tcon->tid,
 			       tcon->ses->Suid, src_off, dest_off, len);
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2235,7 +2235,10 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
-	if (rc == 0) {
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+		cifs_invalidate_cache(inode, 0);
+	} else {
 		qrc = SMB2_query_info(xid, tcon, trgtfile->fid.persistent_fid,
 				      trgtfile->fid.volatile_fid, &file_inf);
 		spin_lock(&inode->i_lock);
-- 
2.55.0

