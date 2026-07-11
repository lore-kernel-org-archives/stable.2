Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E212D5A19
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782431; cv=none; b=BT6kPqBM9jigxD1A/e/U1kiu8SOFYhPOC0OHxasjeKuqSvM8uUZlqEThTl5WvpvW0QeDs4LzRfPdjA7Cc41ExJnvY9nDGDPjiXYCh0yxUEjz/gzRJYqUosnFXtI0918iosYlfy0sGNc5bhUyPN7SbWk2ulG8ckgfYofZHKgbC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782431; c=relaxed/simple;
	bh=5aUkxlSIulkhERNeZp4fHGXyOVMGdheq/O6gyd5lrIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HEAI+UkoClNatFPTJcMVxKttzaRAR6ZnC29GSskGnT1JYNmUamnMmFmigLLcHSgR+S79Mej3NVpWmHMKZ6rPqbGwYUsxVEnq0LGS3vafIjWXHZsLJlLPPpGjssFx/eEljjBNZEhyiauE7ZPLN0iy3JlwCwIf6osHulst/2eu1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtDJR1tI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtDJR1tI"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92efc443c61so20850785a.2
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782429; x=1784387229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lTWLgXlcQl8Cccs9msbh22ddO/TiG4mAqMFaTuD2LHY=;
        b=PtDJR1tIlWmKkiXkJgiHUpjK51g+vMdLJ4Oy59n87baZyHxXwPjZ6bS9n9AWnN6ZJq
         /9e//4H8NsDdig5cwLLJpX8qc6CsXm1VkfGck6l6BbjD6pZVBafceT06FuP3T6wHkW26
         Ts8UDBTyx+uV26uD/md4bmlnHcrT7FLR0kKCEFvH3aKZzuGApVqqGledE4A2bzqgd+jI
         v2xBiIxh8nBVsT0u1AwCB6FTB9ispW2DbLlBBwbewIRe9dihGB3DSlrCgKzxihHZxf3q
         z9FvXSTvOSsMcYdWJG8B0X+SLvz8XB9jXNzYfMV73OvbFURzbCqVbM20kFc7h7a9bIUQ
         uGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782429; x=1784387229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lTWLgXlcQl8Cccs9msbh22ddO/TiG4mAqMFaTuD2LHY=;
        b=sIaUiWpP/fhu8XHwygJBtcVmgpkWn/Lh7NdqeDH7zkyJm9GSU0SuB6qmcFBxgY5ghl
         yQfVyIcm90vqxZE1Gi2ZhS25HvNsnEYYNqrMY0UF1Pdy/rWuSNZv0/cen0Zh9sJU1Hxl
         OQNzCOp5PsXffbSSZcND/1AUMHmGxm7Uc8naCFTI09f0gZIPEOv40fVRiUefptusf33c
         UZfomnaFMk4SpywvmeJs7XTC0521yUpWXpppE377sp0hudn9OGGi2uwo+Qj9xJLro1Ll
         hgOdQViRvRJzFCXnUpG6QMfyXcl9Nt09OB8qeRcXApI98KVqEUsQBMozToAWYNM6+Swm
         FKPw==
X-Forwarded-Encrypted: i=1; AHgh+RoMvBPaMP7vUb8HZuF0/ojE3VqLJZUaL2wkRZSGIEfRoKc5iCcEanwII0iHYGQDlN/b62Pd1Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEcDKwBDqlF7aN9fC+JIv9Dv0aPPKX9+L7Qj5tiU1X96AjHeR
	RhEjEAHmkfoOV3JVsDOq1Rn0C7JgxYCBhuuzuH6lBl4EB8w50WXvfqoc
X-Gm-Gg: AfdE7cmJTbcI0LmPApbO68VwPj94+IDwNUjK+nQG7g0BtKR5kxKRdk21mH4AYaXjV8o
	cRPJwej8TvGIR1bBwBCQ7bSnidrtdIEZGvosghCyBWYDo5OZHk+h2ZzaHNjQtGCJbxwGepAeqOe
	0peY8jyr1/2idDmlI1kNFDHI87E5+QcC6Z2lacvxS81ZIQT0hcQ5t9nH+jXtcS694BMZcBQgUtj
	OhL5iK7goOYuTz53Q9EiZz5D8yu0OpD2cb9uYhY5bKyeMnbURJjy0d2X8P1JpazxOGmBWCRy+Xa
	YoXoUSI5LD0V5beIX3P0kNJlij0fvlZeXI6HQ1aHyGcpxMBeE0X8RAAzVQ3grPZUDbglK6pFiaZ
	DEHlBPQaF641of6dp0qJyefDHrcr3Yta3fMGGpiMVmnCYuD957fBw6a8tyshlcKO0Qiu1lvFgsq
	SOhwpyrk+1eocNDiRQKRni3kvlex4IJtFMlEMFSTGTShSUYvzI+mVb9F5ioSmibaM2bb4BzrtaB
	xv/5/5hWQ==
X-Received: by 2002:a05:620a:394b:b0:92e:e252:bb43 with SMTP id af79cd13be357-92ef2cd093amr367391985a.77.1783782428765;
        Sat, 11 Jul 2026 08:07:08 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b8b3f2sm471818485a.13.2026.07.11.08.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:07:08 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ceph: bound copied dentry name length in NFS export get_name
Date: Sat, 11 Jul 2026 11:07:05 -0400
Message-ID: <20260711150706.2915970-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

ceph_get_name() copies the MDS-supplied name into the caller's
NAME_MAX-sized buffer with memcpy(name, rinfo->dname, rinfo->dname_len)
and then writes name[rinfo->dname_len] = 0, without checking dname_len
against NAME_MAX. A malicious or buggy MDS that returns a LOOKUPNAME reply
with dname_len > NAME_MAX overflows the buffer. __get_snap_name() copies
rde->name / rde->name_len the same unchecked way.

Impact: a malicious or compromised Ceph MDS overflows the NAME_MAX name
buffer in a client's NFS-export get_name path, a slab out-of-bounds write
reported by KASAN. Reachable when a CephFS mount is re-exported over NFS.

Add ceph_export_copy_name(), which rejects lengths above NAME_MAX with
-ENAMETOOLONG before the copy, and use it in both ceph_get_name() and
__get_snap_name().

Fixes: 19913b4eac4a ("ceph: add get_name() NFS export callback")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/ceph/export.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index b2f2af1046791..debb9634b9e3d 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -442,6 +442,16 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 	return dentry;
 }
 
+static int ceph_export_copy_name(char *name, const char *src, u32 len)
+{
+	if (len > NAME_MAX)
+		return -ENAMETOOLONG;
+
+	memcpy(name, src, len);
+	name[len] = '\0';
+	return 0;
+}
+
 static int __get_snap_name(struct dentry *parent, char *name,
 			   struct dentry *child)
 {
@@ -513,9 +523,8 @@ static int __get_snap_name(struct dentry *parent, char *name,
 			BUG_ON(!rde->inode.in);
 			if (ceph_snap(inode) ==
 			    le64_to_cpu(rde->inode.in->snapid)) {
-				memcpy(name, rde->name, rde->name_len);
-				name[rde->name_len] = '\0';
-				err = 0;
+				err = ceph_export_copy_name(name, rde->name,
+							    rde->name_len);
 				goto out;
 			}
 		}
@@ -580,8 +589,8 @@ static int ceph_get_name(struct dentry *parent, char *name,
 
 	rinfo = &req->r_reply_info;
 	if (!IS_ENCRYPTED(dir)) {
-		memcpy(name, rinfo->dname, rinfo->dname_len);
-		name[rinfo->dname_len] = 0;
+		err = ceph_export_copy_name(name, rinfo->dname,
+					    rinfo->dname_len);
 	} else {
 		struct fscrypt_str oname = FSTR_INIT(NULL, 0);
 		struct ceph_fname fname = { .dir	= dir,
@@ -595,10 +604,9 @@ static int ceph_get_name(struct dentry *parent, char *name,
 			goto out;
 
 		err = ceph_fname_to_usr(&fname, NULL, &oname, NULL);
-		if (!err) {
-			memcpy(name, oname.name, oname.len);
-			name[oname.len] = 0;
-		}
+		if (!err)
+			err = ceph_export_copy_name(name, oname.name,
+						    oname.len);
 		ceph_fname_free_buffer(dir, &oname);
 	}
 out:
-- 
2.53.0

