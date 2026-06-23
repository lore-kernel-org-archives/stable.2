Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6EB30BF69
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232166; cv=none; b=ib+AtQHgGGZpIZd+lfvASLckNEoOUtsuMAnIOjf0+x5X/ajNsJDmWwRXjzIQmldsT0XIL/xvz2Kptyorw9J62Ar2ICkpJMRJnaUryZTe6e8ePt/MFWLWPkY9ldYLnVPDLTnbf+n/la5qf5zdcxa7yMh2OmLvgrvjVYrgEdAdvqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232166; c=relaxed/simple;
	bh=sgRb9QrPcs9oS6CnpRhT2PvipgYjDvnpOalhc9QTUDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5x73Gfdamqye01YuGk9yEu6+Ak27OCNKy62zqLsUgG1UioO5eJw5l6T8aR5uR3Iyr40h28DSag1qGqCMUSzVfhnGizYlF78onAZFQE85SWt2zEUWC0DlzgBLCSTmX/Nd3XnSsBye7uUL4jRQ3T44HEfBCU1TNtLDjsVCxlA9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jri6Zncz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jri6Zncz"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so113101a91.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782232163; x=1782836963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=533kl146Q9+rB3ShsS7d/jyf2XCjy3Sxnhb3Dedl6lw=;
        b=jri6ZnczSI4UEmEvFxsURYgWDu7lHGossvYkpmJPelZC5VQgjmfUhO1tAo/ILwTfuj
         EqZa7OPo7NZiVtoccUgT+nGmxxgUQBQiiS/Uw9W9yph0807Nwiq56uCTJiqPSYTv7jFV
         Frg7S8Q1sGkhnDS0Be8OU2wvEsehfHiFxRcAyBOQ73CliPFdpME9jc7mHpTbvUX/X9Qo
         AmyZVOStIiCcu7BqMWiP5LAdOomn2ypuDXCw5P0Q5DAekcR4PBCg+fYsNWzHH6kpMeD+
         ctZEafFzuGs5WJtQKRfaAp8Qpxz/eBt6VMA+6FfDRlpl8iG1dFZ6HBOfngERF/LutEYk
         pq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232163; x=1782836963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=533kl146Q9+rB3ShsS7d/jyf2XCjy3Sxnhb3Dedl6lw=;
        b=rvcJkov5PHDKePEkLUtNq3bHjuzy2B81OjvxDVkadixerDVdXqSE4yiSEewYUuNtH2
         Cb0IsIJfL60VVg4tNGd9NN7vwRjuCMfFGpXpdZGzQUpxIiwmaDrsFlOO1yZPysbFI91e
         1x16ZDeYk17DkmWZvaqC3hVO9cmq5Zu17Vq5+iok/Bf6uUS3c6QoKYqT0NLZ3BcnfxyH
         1kVTVXYpPgLeEUmeJhqdxB0g4w1N07SNspLG8CtCXzoi/SNhWI9koR+Z1EoqyEanIi6v
         OvRYak+4hZuMH3QJs0piLmTeWJ6GQGk8+tvzDPZlqkM3lrBnkbfiLV2xL0P6m/aAvx+a
         cRfw==
X-Forwarded-Encrypted: i=1; AHgh+RrvVDgME4EZBLV8An9aKYhM9g4oIKU4WIolDf8g2x7+XrVbaTJvh+oLKveVGeOU5KSdx0oS5Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6rAcoosFfe5wRNRzzh6xg9wFwTemGPFnC20CC1ugITPhEc3m
	rM4OLImgl8NkokPDXQpOnD+TmMTKo7lB0KZb103ls2aT1+OpMh8uZJLc
X-Gm-Gg: AfdE7cnr9g7looenmeQ5eT10SIAwwnwS4i2nQT4a1rv33ZdGIRpn+DzYbi0wrcG5j3m
	AH4xJBBbYc5cGE8W7aiaAIGYMTuFqk1XZby/VfIDDi6VjqM3CzlHezy7s3neXdy0bYBqs/0BGwt
	kwrjss5FhUCuiW+b0ETsYpY9kIhqiSLIkaNhfiO4zGkXVZ+1xDCWRAkyTBSLUfSdESUXQ2/1zJl
	5FKYljkAc8DbSaFemXwmhmY1l7ARYGMr/ex8Ljw8/Da6pO746KcOUCKgwLMZKM4xTTyvxWHGPqj
	gE/UIbq07BbCqDGLVL0H2IGHBUpNubI4HXnZ0qlOQ/OH2J7TBqy8qwDdwNoH9ErUU7k5XTq2Ktg
	PTXUhEkB4wAzdRJkc0rfwDH8fWVD9OmIt8vBGN+WD5uc8Ie3yRfjMgZ3T8FfVsRXOaLhpRms7ph
	aGSVzLJqNhDIJmArBXmtN1Ssk8KqCD8tqzO3p8b7isI9c=
X-Received: by 2002:a17:903:32c8:b0:2bf:1e37:a2ff with SMTP id d9443c01a7336-2c74175fb03mr157565595ad.0.1782232163071;
        Tue, 23 Jun 2026 09:29:23 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfdc97sm135185485ad.65.2026.06.23.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:29:22 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	henrique.carvalho@suse.com,
	ematsumiya@suse.de
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 01/17] cifs: invalidate cfid on unlink/rename/rmdir
Date: Tue, 23 Jun 2026 21:58:54 +0530
Message-ID: <20260623162910.343930-1-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

Today we do not invalidate the cached_dirent or the entire
parent cfid when a dentry in a dir has been removed/moved.

This change invalidates the parent cfid so that we don't serve
directory contents from the cache.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/inode.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 6c22fc3267500..51fb7c418d52a 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -28,6 +28,23 @@
 #include "cached_dir.h"
 #include "reparse.h"
 
+static void cifs_invalidate_cached_dir(struct cifs_tcon *tcon,
+				       struct dentry *parent)
+{
+	struct cached_fid *parent_cfid = NULL;
+
+	if (!tcon || !parent)
+		return;
+
+	if (!open_cached_dir_by_dentry(tcon, parent, &parent_cfid)) {
+		mutex_lock(&parent_cfid->dirents.de_mutex);
+		parent_cfid->dirents.is_valid = false;
+		parent_cfid->dirents.is_failed = true;
+		mutex_unlock(&parent_cfid->dirents.de_mutex);
+		close_cached_dir(parent_cfid);
+	}
+}
+
 /*
  * Set parameters for the netfs library
  */
@@ -2067,6 +2084,9 @@ static int __cifs_unlink(struct inode *dir, struct dentry *dentry, bool sillyren
 		cifs_set_file_info(inode, attrs, xid, full_path, origattr);
 
 out_reval:
+	if (!rc && dentry->d_parent)
+		cifs_invalidate_cached_dir(tcon, dentry->d_parent);
+
 	if (inode) {
 		cifs_inode = CIFS_I(inode);
 		cifs_inode->time = 0;	/* will force revalidate to get info
@@ -2378,7 +2398,6 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 	}
 
 	rc = server->ops->rmdir(xid, tcon, full_path, cifs_sb);
-	cifs_put_tlink(tlink);
 
 	cifsInode = CIFS_I(d_inode(direntry));
 
@@ -2388,6 +2407,8 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 		i_size_write(d_inode(direntry), 0);
 		clear_nlink(d_inode(direntry));
 		spin_unlock(&d_inode(direntry)->i_lock);
+		if (direntry->d_parent)
+			cifs_invalidate_cached_dir(tcon, direntry->d_parent);
 	}
 
 	/* force revalidate to go get info when needed */
@@ -2402,6 +2423,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 
 	inode_set_ctime_current(d_inode(direntry));
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	cifs_put_tlink(tlink);
 
 rmdir_exit:
 	free_dentry_path(page);
@@ -2668,6 +2690,12 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	}
 
 	/* force revalidate to go get info when needed */
+	if (!rc) {
+		cifs_invalidate_cached_dir(tcon, source_dentry->d_parent);
+		if (target_dentry->d_parent != source_dentry->d_parent)
+			cifs_invalidate_cached_dir(tcon, target_dentry->d_parent);
+	}
+
 	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
 
 cifs_rename_exit:
-- 
2.43.0

