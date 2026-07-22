Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B6443E3B
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784759829; cv=none; b=RXY8hIn2jF4UsPES218npTPVTEjoyv7t+88BPUKUl7TYFuQ47N/CQVQUeGZ14C5s5GM3J3c0uHFIaT5aUl6IHkVHDWEx2fOxOTSPCBOYmjB3oR0xotMXMzpDcg6OkixGVVzoRsofB8UzU+jrtAYjbgY40WTKlQEmiLLLuPK7ygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784759829; c=relaxed/simple;
	bh=piRa8OfNgMtrDUV6Y7isFBrcHY0qW7v0MCB8bIdptfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOc43g9wI5QPww1ONs9Nr553eG5AL8TWtnc7e3X7bImgxoOEui4Cc20gkQZdGpq+bD1s34L+xprjMMdSkalhjq6MdvySqluzKWygHZ11vNfva803y8wcINVnLMA0uJywjB00isHwR36J+9zk6pF0581kLO3ZCSkt4uROHkwQDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAq7hYoq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E++tWSJ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAq7hYoq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E++tWSJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784759825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Loj+7QGaP2pG+2iDSDYmo0A5gqz1B81cOBNV7o0aKYo=;
	b=NAq7hYoqkjRkMyuMgVX8Wq5hjUxWygSl4QukH0FGCpdGoY85Zp8uP6u/QKMwPzRUVVDtyC
	8Awo4Q658rdDPgXDecL89qD1OXuBpcf5rrPGn2D8uljUDDk2ruFCjMtMb2uCW/hOUF8bUn
	QVXqoms1+qrmClOngbcH1k+yaUm3S2k=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-MljVErPgO1Gtp2dJZcrQIA-1; Wed, 22 Jul 2026 18:37:04 -0400
X-MC-Unique: MljVErPgO1Gtp2dJZcrQIA-1
X-Mimecast-MFC-AGG-ID: MljVErPgO1Gtp2dJZcrQIA_1784759823
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-49ab6a82cd5so19014461b6e.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 15:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784759823; x=1785364623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Loj+7QGaP2pG+2iDSDYmo0A5gqz1B81cOBNV7o0aKYo=;
        b=E++tWSJ2jBXh7+Ng6h0uAn/6JbhuVN/lW5OfK3NxKKb8za9vJaW8Em1u3gbcA6TMLh
         ThTKpVGygaufbSocnOlZl9RIfZM8lSKOTsrt7oriYqcQc50VZnaiVXL7X5RihKAXat0H
         xIjLLp+1ULKayorY+15czqa4roIZ31rv7+IaJ/0DSn2bKo0B6jc2Z8g7MSbuhNvijzbY
         3T728AZtwCdzIip68jcbmvS+xR1UzBatNKkZB4jmNQKRo2BMFeEayK2ooMDygJqYeRiq
         6Qg8jJ67KROV6qul8P5sAH6nGZv3p6Q/zP95MnadABDJKIe+RQ6HnYTOlzUij33Dfpvj
         xePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784759823; x=1785364623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Loj+7QGaP2pG+2iDSDYmo0A5gqz1B81cOBNV7o0aKYo=;
        b=rok3xQ0gNZmo7yx4u9J3gCSnBSTJDdRks37H/V2CQUjzB+vyAdlzNfl34j9KcXsNDz
         AERmRd897ULkDPnkBUwGVWnPl1wdtL4CVcUy3FOL0MoA27pUDw3ct0P4gkraEdqGkTly
         q6M+cpjQSlDlkKtKErBKnlIJSweHo9uRyD3qCPjDDZQK8+4CO7ZrU4W2YPmMWjBYpjmT
         SxlYlahVCqP8bnDmc6laGG2cIK5wcXPKs95m9RxIjTPtJGjD5vU3S0oXkcYh1Ow1dTIs
         +mubQp58i/cy2zlizQXR+DLDSdbL+7r2k5/F59uVVPPCx8q3fxjLWfjVxob46c9AesZT
         B8aw==
X-Gm-Message-State: AOJu0Yxzj4qwDojCflKhbCQboNiQQsBWKn6DXjRnb1dPEktvIp++wJwQ
	NFo29S9c3vhhQNbGRcvHvqlsSlcmQbPuPlIpDI+rw8wGChAeuOQJgBmZvX5urbgsH91pjrIhnkR
	IZABdNEkERwFqVXrx55rbv85TX2zp0FGCFPbDdcTgbALLALcX8dlrnZ5kXw==
X-Gm-Gg: AR+sD13o/HUvQZW9lhKSmHQOIERjhpB85Jg6S52LFA+nG7+sLWd/Am7oDvLRSgwfcCW
	ez+9A/L+1lUCGRC54pD/R5JlPZPQbmjKq3gQN7jVRNyup3hkkrCQ6ruV4MtFUSMS9uj7b8Pwf9l
	405ppb+uP31JZhd5cZc4JJJs9389hrDXexbbN1+7FyYH/PNyxAHNAcc9cDPKh5nZOzJhPl00xFX
	vqL8yiCz5dAGWbWgLIz9ykN3CVGsqPJpc7VcXxIp8oc0d3b0nm/NL/+HGEbhKtEHgru8SKR8QU/
	dwTCVb2jza8z0wBblIlQVVK0wiSWUpvBz/Wa5e165HcSws91teVIK1CFasMbBv10osh4UoDeqAQ
	o49dhXe40bTygU93MbteSlZiGK0HNwt+gl4aAoFekVyaRLFqOTTj9RkgNARjV
X-Received: by 2002:a05:6808:238a:b0:495:d7ec:b6ae with SMTP id 5614622812f47-4ab3532e31emr365630b6e.16.1784759823328;
        Wed, 22 Jul 2026 15:37:03 -0700 (PDT)
X-Received: by 2002:a05:6808:238a:b0:495:d7ec:b6ae with SMTP id 5614622812f47-4ab3532e31emr365621b6e.16.1784759822916;
        Wed, 22 Jul 2026 15:37:02 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab2cd31929sm1158445b6e.4.2026.07.22.15.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 15:37:01 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: paalcant@redhat.com
Cc: stable@vger.kernel.org
Subject: [PATCH v5 2/2] cifs: fix cifsFileInfo leak on kmalloc failure in deferred close drain paths
Date: Wed, 22 Jul 2026 17:36:54 -0500
Message-ID: <20260722223654.2160437-3-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722223654.2160437-1-sorenson@redhat.com>
References: <20260722223654.2160437-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cifs_close_deferred_file(), cifs_close_all_deferred_files(), and
cifs_close_deferred_file_under_dentry(), when a pending deferred close
is cancelled via cancel_delayed_work(), the subsequent kmalloc_obj() to
add the file to the local processing list may fail under memory pressure.
The loop breaks immediately, but the cancelled work is no longer pending
(it would have called _cifsFileInfo_put()), and the cfile is never added
to file_head for processing.  The cifsFileInfo reference and the open
server handle both leak.

Fix by saving the cfile that failed allocation in a local variable,
breaking as before, and calling _cifsFileInfo_put() on it after
releasing the lock.  Any files later in the iteration are unaffected
since their deferred work is still pending and will fire normally.

Fixes: e3fc065682eb ("cifs: Deferred close performance improvements")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/misc.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index e4bac2a0b85d..a252e481cd06 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -497,7 +497,7 @@ cifs_del_deferred_close(struct cifsFileInfo *cfile)
 void
 cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode)
 {
-	struct cifsFileInfo *cfile = NULL;
+	struct cifsFileInfo *cfile = NULL, *failed_cfile = NULL;
 	struct file_list *tmp_list, *tmp_next_list;
 	LIST_HEAD(file_head);
 
@@ -514,8 +514,10 @@ cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode)
 
 				tmp_list = kmalloc_obj(struct file_list,
 						       GFP_ATOMIC);
-				if (tmp_list == NULL)
+				if (tmp_list == NULL) {
+					failed_cfile = cfile;
 					break;
+				}
 				tmp_list->cfile = cfile;
 				list_add_tail(&tmp_list->list, &file_head);
 			}
@@ -523,6 +525,9 @@ cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode)
 	}
 	spin_unlock(&cifs_inode->open_file_lock);
 
+	if (failed_cfile)
+		_cifsFileInfo_put(failed_cfile, false, false);
+
 	list_for_each_entry_safe(tmp_list, tmp_next_list, &file_head, list) {
 		_cifsFileInfo_put(tmp_list->cfile, false, false);
 		list_del(&tmp_list->list);
@@ -533,7 +538,7 @@ cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode)
 void
 cifs_close_all_deferred_files(struct cifs_tcon *tcon)
 {
-	struct cifsFileInfo *cfile;
+	struct cifsFileInfo *cfile, *failed_cfile = NULL;
 	struct file_list *tmp_list, *tmp_next_list;
 	LIST_HEAD(file_head);
 
@@ -547,8 +552,10 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
 
 				tmp_list = kmalloc_obj(struct file_list,
 						       GFP_ATOMIC);
-				if (tmp_list == NULL)
+				if (tmp_list == NULL) {
+					failed_cfile = cfile;
 					break;
+				}
 				tmp_list->cfile = cfile;
 				list_add_tail(&tmp_list->list, &file_head);
 			}
@@ -556,6 +563,9 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
 	}
 	spin_unlock(&tcon->open_file_lock);
 
+	if (failed_cfile)
+		_cifsFileInfo_put(failed_cfile, true, false);
+
 	list_for_each_entry_safe(tmp_list, tmp_next_list, &file_head, list) {
 		_cifsFileInfo_put(tmp_list->cfile, true, false);
 		list_del(&tmp_list->list);
@@ -604,7 +614,7 @@ void cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon,
 					   struct dentry *dentry)
 {
 	struct file_list *tmp_list, *tmp_next_list;
-	struct cifsFileInfo *cfile;
+	struct cifsFileInfo *cfile, *failed_cfile = NULL;
 	LIST_HEAD(file_head);
 
 	spin_lock(&tcon->open_file_lock);
@@ -617,14 +627,19 @@ void cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon,
 			spin_unlock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 
 			tmp_list = kmalloc_obj(struct file_list, GFP_ATOMIC);
-			if (tmp_list == NULL)
+			if (tmp_list == NULL) {
+				failed_cfile = cfile;
 				break;
+			}
 			tmp_list->cfile = cfile;
 			list_add_tail(&tmp_list->list, &file_head);
 		}
 	}
 	spin_unlock(&tcon->open_file_lock);
 
+	if (failed_cfile)
+		_cifsFileInfo_put(failed_cfile, true, false);
+
 	list_for_each_entry_safe(tmp_list, tmp_next_list, &file_head, list) {
 		_cifsFileInfo_put(tmp_list->cfile, true, false);
 		list_del(&tmp_list->list);
-- 
2.55.0

