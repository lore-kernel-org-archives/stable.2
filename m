Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A56C47F779
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248724; cv=none; b=HtzxTMJYTmITCHDz5UzjAVmNkCFta5Id4GAXwGLGePcVe7XvpRKEMLOLQE8U4dBut2EmZz+hRwrY5fomvhhPUTRK/gHTdAmmIDqbNFt07AqcLaV6UghjDPhKbTAJkJ/srBjM2Fk7xtp9ntvz7FVG7efn+n4mUs3sE3dOXE3cjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248724; c=relaxed/simple;
	bh=rRQ+k45Rzu1T02qBpX5CzRl8hfRPtWG1qRV4GQ3dh8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=srnoHRUFGz/0Q4tYWJbtlvXEB7MOoZSQtw/YXD+Uszdnt6nFHXnJorkJC+6vjLFHsib7ZokLOTvUvES8D15oPY9cRvSowwao0HF739XGl33ZoCW27gmk5us5/B8rTUg6zafUQfx54Q8jhp37qXoPVcwcTUGNMCwQN9p89jaeKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXIMHYXK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXIMHYXK"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495590dde14so1555835e9.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787248721; x=1787853521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YYEsMKlE1hunKYKu1jEmmpknYRhAQx1ch1/5OXya0mo=;
        b=EXIMHYXKtcMYV7Ri4p2slns48PJSlkPt9sYp06GVbIEv7XQEADPtUj/3XddT1RbmVP
         Bw3kLCkgze5ufVH0tLZm80uCPnNO7zIQw0BjT6QdI8qiGG8oPIBhyeynfgqepXYk0rpi
         AJvu1g+pWxEI1fEE3kuXrWeOBAmSV/S1cs/phtJ1QBAwq12wGg//H3ndYR8pUq8kjo8k
         4dpAV8VvCuiaJYfAw/Ge/XENRiax6OTv5iw/zda7TQ8owXkRmwQbdlSFJzPWmp5jCAUu
         E3P87CFlAZvhB6HOTgOQipXvkXIlJ9vW9UosPLufYlPePe87NoQu9EjkruR3RzuFc/AM
         nVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248721; x=1787853521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YYEsMKlE1hunKYKu1jEmmpknYRhAQx1ch1/5OXya0mo=;
        b=mgZu+BdaguQRiSLROQ6pFsxG/8eSye95FxIQg1W9UKKkmsT7kZ4efSMZnB2GH5PQVN
         kKq08CxhNToekMChn+Zon2UNn/GeIZPO6YIIrHi+plndV04sgbDNQdorEnz6WfPFOIsH
         kzEMScmqUf2otBrTiXiDWGZ6XafiCDy6bYWbOK5OYCjvVTjeSVwqLfDGZrWiia3VEb9G
         CXEyT+CvBqoHIndBz8ydKp9UIJG4veRmG/TF7qQWY7XbDwQYkJDNnwUXsJW+0UNyKSzR
         WixNV2o62ko+iJxXG8mrmvUg7cAWuSmEj+GPRWFel7JS5SgIrj0cEs+0sk5Bf/Ed6aiT
         w+fg==
X-Forwarded-Encrypted: i=1; AHgh+Roz3zmU+umOynPmNcMxpjD2XZyhmamYewm1qtsr71k/5otuv8U5MwATeFgudE06zSWrlzV5qLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4DGtiGFVi/hycfXNPYRGmTV1FjLoIM33YAgYz2/hvwTToJUw5
	JvIOv/NJf0Pv7dWaKiIkht/41sCKdUrZnwWWrXeLAQPFAPue2++tmoSd
X-Gm-Gg: AR+sD10kdz8XGkZ9AqlFraNafpNOpZ+ui4Aj4ssv8jVNMlTRUBTztbDsHnDT1l3LUED
	q/BuqLhuxShXvVHE8Re2LR/LXVTHnW9Lhf/Lr4EfWuyVCZmGU7n/b73YIz0C1zrFN4SDY570zaH
	+YKJDCRD13YNhOKZci4BDZ87sRX25j3OaYHHetdNw4vaAXzHOaXR+VxhTbHhfklIIaTQPRW3rJ6
	cVmKFGVOA3R3EWIQUu9p0omoH/s5vQoMpVtqIYRbt8wNwFQPos/Zp0UspLX5g1u22uJKkVBixEf
	oUN+fZmF0zClVQpwqe5nr3PyMUHjeXWNn3rn+V1ACW7rTS0qF+5TWpMmVb4zGvkFKIVrk5f2kMo
	IJKQqundcYJYQ+kvOAR9OFMMIPo+L1YAljACoQ//Y63z9lh0gOzL7aT7lRil/UNnYdkzIr9MNOl
	uwpeiLk4WneRAnC/RUTjQBYKIM1y6ssuzMOhXiuowHymIbDZFdiWmvGo6tP9q+8rWc64Uksghu+
	5q05k8xBB6lbNgz5W+f4X1K8t60pjxMogWhrYh6S7jtO2ueOaCatFaHLMgAKNH/cbf0HsDi/Q/3
	mABDr5KXdzQPD3JuRczRu/2C9qhbP/YrQkLwtI69XkAnH9izM5psrOEVfpyFSYr2FNr9/mUVEA=
	=
X-Received: by 2002:a05:600c:c494:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-499b82f4d3bmr10160435e9.3.1787248720981;
        Thu, 20 Aug 2026 10:58:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a476-1a01-141e-2b69-987c-d72d.310.pool.telefonica.de. [2a02:3100:a476:1a01:141e:2b69:987c:d72d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa11f832sm152118355e9.7.2026.08.20.10.58.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 10:58:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] selinux: preserve user SID across nested backing files
Date: Thu, 20 Aug 2026 19:58:32 +0200
Message-Id: <20260820175832.44512-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SELinux saves the user file SID in a backing-file security blob so it
remains available after mmap() replaces vma->vm_file with a backing file.

For nested backing files (overlayfs over overlayfs, or FUSE passthrough
backed by overlayfs), user_file may itself be a backing file.  Its
fsec->sid is the SID of the mounter that opened it, rather than the user
that opened the top-level file.  mprotect() then checks fd { use } against
the mounter SID.  This can incorrectly deny access without a domain
transition, or check the wrong target SID after one.

Copy the saved user SID when user_file is a backing file.  Keep using the
regular file SID for the first backing layer.

With two nested overlayfs mounts and SELinux enforcing,
mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
mounter SID.  With this change, mprotect() succeeds.

Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
- Add selinux_file_user_sid() helper instead of open-coding the lookup
  (Amir).

Tested on arm64 QEMU at fd6e2388a3ea with SELinux enforcing and two
nested overlayfs mounts. The policy omitted only
base_t -> mounter_t:fd { use } among the relevant cross-domain allows:

  baseline: mprotect(PROT_READ) returned EACCES with that denial
  patched:  mprotect(PROT_READ) succeeded; test exited 0

This patch fixes SID propagation only. backing_file_user_path() still
resolves to the middle layer for a nested mapping, so the audit path and
inode do not correspond to uf_sid, and that layer's mounter is not
re-checked. Preserving the full user path likely needs a VFS-side change,
such as having backing_file_open() store file_user_path(user_file).

 security/selinux/hooks.c          | 9 ++++++++-
 security/selinux/include/objsec.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1ead2eee1944..171b90412ff1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(struct file *file)
 	return 0;
 }
 
+static inline u32 selinux_file_user_sid(const struct file *file)
+{
+	if (unlikely(file->f_mode & FMODE_BACKING))
+		return selinux_backing_file(file)->uf_sid;
+	return selinux_file(file)->sid;
+}
+
 static int selinux_backing_file_alloc(struct file *backing_file,
 				      const struct file *user_file)
 {
 	struct backing_file_security_struct *bfsec;
 
 	bfsec = selinux_backing_file(backing_file);
-	bfsec->uf_sid = selinux_file(user_file)->sid;
+	bfsec->uf_sid = selinux_file_user_sid(user_file);
 
 	return 0;
 }
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 3c0a16ec978b..853f7266ed18 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -87,7 +87,7 @@ struct file_security_struct {
 };
 
 struct backing_file_security_struct {
-	u32 uf_sid; /* associated user file fsec->sid */
+	u32 uf_sid; /* top-level user file fsec->sid */
 };
 
 struct superblock_security_struct {

base-commit: fd6e2388a3ea55e58cbbbef840c1d8aa2067dbb3
-- 
2.39.5 (Apple Git-154)

