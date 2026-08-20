Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3E53AEB39
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206442; cv=none; b=jXHhgNE+pOk9f58cGsJzqua8nlGvgqbOngVMIRYuAlvOswQxG6tCEufFBNf12IETyI+UmvYQjHI/YYWWtSOjc3a79BA5Nx2d9jYjZ/NwR6HKzH8k9VviRBW2tZdhE9sNwoBrwfJpMW51ZKya4FOAgRPy8lTRzg3SCLYTOKRCrzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206442; c=relaxed/simple;
	bh=5idfiA36NczW41si+OWGL51HGRsYJBjnWxO7ogXCc8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bVjQSahS71mKv+V1oEpDuxUESmz8OeD3/fNjJDT3fRXQD2HvKlU8jUMe1XcN5H8CxFj7hql5l9TS+WbLzCSWJiFUy1pWJ53Emgd6ZcadlSSEoFGCXUULdoIi6E+nexCfdlBxmrnk51T3f7IWc5H85oBwOeqQaclGiDPyDVQ5yMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7AH9DAi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7AH9DAi"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f84023916so1743864f8f.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 23:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787206439; x=1787811239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+0zPOZ4cy1qU8zrYNcuVxcq7JUklUQqhNtrlV/MxG9w=;
        b=E7AH9DAi27mvWHXeWQF4pPTG34CIkQVMlXTwEpX059psgy3AeLgF1rtszHwT8LM6gF
         JpYRVv2kojq75qlK/voPyek23nZVE/GLYkm7tO567/s1a89KdohpXrWmqCfvkfQTnsjW
         P16plr8nwlfRaJL1wfxodV8RuiadRWSTqAkksPw8ENdlslmJmyAFiFXnEsh9Z+xDT9dJ
         dfUtl7khszq/iwm1UAqg5AgNa9vq82UWZ+me20UU41gotRzJ0TbvBrq249i62SFdzQ29
         Svvjs9lgODDmcYo9I0H/GcMrAG9QaX9ZrFJCzxPp3BeYGAXseJyDW/j1nts5ck6IVJ65
         cAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787206439; x=1787811239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0zPOZ4cy1qU8zrYNcuVxcq7JUklUQqhNtrlV/MxG9w=;
        b=nqp/bCHtyAxrei6e8cvJGpn1Ift8ru3lLV9lLvlao+lJMB6VdHHrWvDj3W5RWlYYjJ
         BaQL0EzHgNaCKliadvLBdBC2QVGq5t9HYe+IUb6avV+pDCXDTSZsAxnePD+4kDIOpbl5
         z/14H8f2vr6y77+jW0WpTz9KGULhh2rtMKXp90fgwY5DqW5kcpgXkOKYp8HIX/rcybAp
         j7OkEFZClhLEi4UXW1reNCoZcjJfls2BPSjwmzG+LC8P79gcPi5Ey1+YXv2Exq5AtIJS
         tQ++5+wwjLU0R4TIJbVt0Xi4vN5e7PT1eE7ZkQwIoxKUfke5NdHyJjz6VWjuPe5ffZ94
         YatA==
X-Forwarded-Encrypted: i=1; AHgh+Rq16aq8Z/mTNBgmWlJ1AqDKF6ekBnVZVcExAohDO/o6X1z33ylcZdPNmKaImUbJizwav58zj/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHFHD5j3Agyy3cu+L+P81V/XWleIjNdJ56o6+AMbCtn+bmZ1xk
	pRzMwDeJ4qDKzvWOE7pYnqvdAepe1IgzHEzCRwVB/rarMP0xImhRpRFi
X-Gm-Gg: AR+sD12EFH4CSYIC9xmmCUDhYAqxeT5gNMnq1F0cBnjcQqL7oQxQ7TESukkKthgGKvH
	Wh3J4gnkL+GAMBYWUlY5eteLSONkmhWuCDDGGO0OxULk5rSbUrMbHZsL4hS+d4LqdfoQ2ux+Ox3
	WNlW0Y1QCrzlklb90WwgUlnJn7/Gq1Eb1GNa48R6yB3mNP8k3kRFaNPyem8JsLFdbP+QzXOG+kS
	xwI+y40gctN2+tT0b8wvo1lVLPlO2TYpS+BykmH+wfLY9KapnJQpTwrZePp5tf5KHYaydH0+qoQ
	A6Nrfa1DphkJYkZw1Y/wt/RCvXOiDgYr2KuB3Ntow5iKH0HAyCVM4t6SXOV1nVFWHEhgj86JdGJ
	jaiaSSY69g1TKrqyFnwCA6FwSAMBALLpQrX52LqqSSiyrfqxgITgZIjZHNOGIW/QiTKqDjRc2q8
	0hIu1aDzp/Du7rm6r+rH5sSrjoozZ6hGTAtCLODAVyzkeszT6/nxYuz5S0HCS/V2B5gtMR9yra7
	8UbC7b/lYytkqLp6lsH+Cpq7JIfR0diMMQV2Nwtx1AZ5UEKsVggEa6jp3ggR9gdf/qwBA/uuj/v
	BD45SelN59ZxS0vTekpF9X2JUACOsnFoc2jY5UGnRa/RLN6sye7A58lUGR8Eglr19A+nMgrgVPY
	ByyU=
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499aa20c7b1mr165566735e9.15.1787206438796;
        Wed, 19 Aug 2026 23:13:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a476-1a01-141e-2b69-987c-d72d.310.pool.telefonica.de. [2a02:3100:a476:1a01:141e:2b69:987c:d72d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa17fc80sm129661355e9.14.2026.08.19.23.13.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 23:13:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] selinux: preserve user SID across nested backing files
Date: Thu, 20 Aug 2026 08:13:49 +0200
Message-Id: <20260820061349.10542-1-kmehltretter@gmail.com>
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

 security/selinux/hooks.c          | 4 +++-
 security/selinux/include/objsec.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1ead2eee1944..8b96934e9992 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3849,7 +3849,9 @@ static int selinux_backing_file_alloc(struct file *backing_file,
 	struct backing_file_security_struct *bfsec;
 
 	bfsec = selinux_backing_file(backing_file);
-	bfsec->uf_sid = selinux_file(user_file)->sid;
+	bfsec->uf_sid = (user_file->f_mode & FMODE_BACKING) ?
+				selinux_backing_file(user_file)->uf_sid :
+				selinux_file(user_file)->sid;
 
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

