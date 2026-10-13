Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17443A80C
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791856746; cv=none; b=X7tHmoLq4LYmUBxn3GDjW0++NZBSz/5UYAmipyPd89JvtBMVOEl8EFFSCcUv7rgIUpVz2NPB41x2aF/67diQ8n3MKqvGIgQpaLxP87tQzKZTYTp6hkDWNrUhmuHlLaK3W60nXUuEw14ofEtMa/b1e+onBz4iXWtEJK2BYw2OaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791856746; c=relaxed/simple;
	bh=gdrhrrhojiYmNOqh2JvMQwXyKcDnKZ5DGo+JK3pZzbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IaNWMeJ5+WFjrbG3XEr95jeNgr2yEjcZSsEP5V+EHCQ+kylK4iSNLYHGq0yANQXYNdApeqos1/k6QjwAvevO4drtMJunf6d2Ngz5Ckmvh2pak6ozEh5C+qf9c9FI4OQG5LoKk/U5iISvlo5CuqwL75Qqmcd6TCVjWhUnARHfYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjP94FxT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjP94FxT"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so2671220a91.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791856745; x=1792461545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VulKwxghGCCa25Yap2OP81AUAKiRy4s4zXpBxbouW5A=;
        b=CjP94FxTyMtSuqAlDGaKklMK/IWfJFFjzcGwBGe/QLVbcexszJjnVZ+PMknVtEo/uI
         BMHDC48hkUyoKEKAO2DsspE4NxpV9EaV68FiImo1yohtc5WN6HbZec3BGXobJXboPaB8
         AC5nH/KfzcupUwqjT9tpXnbXf9Ef/Cdqf4MmvzJKw/Z/EStV2rT/aelBhkdPOlJPEz+y
         6paONU96Khdvw+HV3K6k8fsndT4L+Dss5F2mBNQlcnQmh1XCP/P3TjzPhTOeP2rbEsDy
         grfVakYjVaXD8Bw+6Vfm7+NNq8Rn8Glxx/YXRGqIotJ5Wf8on2VF45yx5tMSUnPcF8UW
         UOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791856745; x=1792461545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VulKwxghGCCa25Yap2OP81AUAKiRy4s4zXpBxbouW5A=;
        b=FiIy3tih/UwPzYx4tFEY0bQbpPnynNUYsD28tmxnmXRFrjTw8GClk7TwDP3MnUWI1y
         3+hpVtwHZXCAMHhFjJppqXoZSFvF82QzYLxKgWRwm54VlCfrCIlPVYYvfUfczUwjny36
         1JesgMcfFzxBSxHRSiJO8Z+eberxfVgeLg8hPTZr9RRb/ARdRkdy0u5ITsBAj/H2Qq4s
         TgYlXlY91VquuQ2yv1cH/Dq8sG57cYp4wrqTGy2UXUdvnz07hRoHIqEXSJMruioOVT+p
         i2DdmmNf/wuw35utFsmrPfMglVIWx3CR3uRMa15zOIPL66ctwtljKeFwJ5WYKuAK3hSf
         0XOQ==
X-Forwarded-Encrypted: i=1; AKwUvByihYLS613zldXIzd78po5Ga/CBejfjiVfknKfNqQpIP8y2qi0mA5aqMaWtJpYQKnXoZ44HOas=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9FNYVEFARhXjKoV8YDX3JoQqjqhr+86g5x0ynKXWZR3QC3gUt
	F55ZzIpJ1wAqNUIapA1iSSirnoh648NEWa9r5pvC/hQESpPrTWEjKoIY
X-Gm-Gg: AYBFou0ZediX8DW4zrChsot+obCDGaPY+hkF7WjLBjr2I083DEGQOFplgqAbggUZybl
	Ukg6TbFrxxotG4WRUCzPtOka7hoivTwsnjdN4HJ2boAxIxw08sqWA79WLVxG+EupqQL83px78Al
	X/77PZ+DOj9R+nObYHvpUFfZSmj+7is6EuzHjT5QwhQhAnvnWx5iYEdrlODFNYYLHJRJp5juPGp
	QEVYo8ZP2e0Z2Um/Yk/4W7gLbBDySoVTpldgPv+CS+aVPPblOtD2O1MMBBvFvzlydU5yamhhZII
	0h/5IXK/S4XQASeMSZ8j9G61lTeyz5CgmeEnMunqPh9+wp+S4+kK1mB3fMoPdnxwGwpOH2Oo7HO
	VUoI2Wjc75VRNmLhMk43q+iaymUyXGSRfj3i5lrATYJ2RNoduUP0mSX9H25U0tyelyZu7Nq876g
	9Qp8zQO5L8xDBZEnj64GX/AacxaE/nr943ZzP5Q0seHZjh6uVpNuR9f3ioPyniob9OgA==
X-Received: by 2002:a17:90a:5185:b0:3a0:bf71:eccf with SMTP id 98e67ed59e1d1-3ab3a9533ecmr4229118a91.14.1791856744976;
        Mon, 12 Oct 2026 18:59:04 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38ff0ce7sm19784735a91.15.2026.10.12.18.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 18:59:04 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com,
	ghe@suse.com,
	akpm@linux-foundation.org
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] ocfs2: Publish the filecheck owner before adding sysfs attributes
Date: Tue, 13 Oct 2026 09:58:58 +0800
Message-Id: <pm-ocfs2-objects-candidate-0086-v4-1b3a3c5fd05c1fb41df9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocfs2_filecheck_create_sysfs() initializes the filecheck allocation
before calling kobject_init_and_add(), but assigns entry->fs_fcheck
only after that call returns. The default attribute group can already
be visible while registration is in progress. A concurrent read can
therefore enter ocfs2_filecheck_attr_show() with a NULL fs_fcheck and
try to lock its fc_lock.

Assign the initialized owner before adding the kobject, so every
activated attribute has valid state. Clear the pointer when addition
fails, preserving the existing teardown guard and error cleanup.

A controlled probe-instrumented test kernel with the original OCFS2
registration ordering produced this Oops during a concurrent sysfs read:

  KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
  RIP: 0010:kasan_byte_accessible+0x15/0x30
  Call Trace:
   <TASK>
   __kasan_check_byte+0x13/0x50
   lock_acquire+0x113/0x300
   _raw_spin_lock+0x31/0x40
   ocfs2_filecheck_attr_show+0x138/0x5f0
   ocfs2_filecheck_show+0x5d/0x90
   sysfs_kf_seq_show+0x1d3/0x360
   seq_read_iter+0x480/0x1110
   kernfs_fop_read_iter+0x419/0x5a0
   vfs_read+0x7d2/0xc20
   ksys_read+0x111/0x200
   do_syscall_64+0x114/0x620
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  Modules linked in:

Fixes: 5f483c4abb50 ("ocfs2: add kobject for online file check")
Assisted-by: LLM
Cc: <stable@vger.kernel.org>
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

---
Changes in v2:
- Explain why fs_fcheck must be cleared on registration failure.
- Retain that cleanup guard and add an inline error-unwind comment.
- Rebase on 35eb6a2f; keep the original diagnostic unchanged.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0086-v2-646731c4254a02823b4d@gmail.com

 fs/ocfs2/filecheck.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
index be713d7d24a76b9aa8fcded3d83b3d91d124eb6e..75334e4bd0823fd8154717290bfe57d2e5198176 100644
--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -179,17 +179,20 @@ int ocfs2_filecheck_create_sysfs(struct ocfs2_super *osb)
 	fcheck->fc_size = 0;
 	fcheck->fc_done = 0;
 
+	/* Publish the initialized owner before activating its sysfs callbacks. */
+	entry->fs_fcheck = fcheck;
 	entry->fs_kobj.kset = osb->osb_dev_kset;
 	init_completion(&entry->fs_kobj_unregister);
 	ret = kobject_init_and_add(&entry->fs_kobj, &ocfs2_ktype_filecheck,
 					NULL, "filecheck");
 	if (ret) {
+		/* Mount failure still calls ocfs2_filecheck_remove_sysfs(). */
+		entry->fs_fcheck = NULL;
 		kobject_put(&entry->fs_kobj);
 		kfree(fcheck);
 		return ret;
 	}
 
-	entry->fs_fcheck = fcheck;
 	return 0;
 }

Fixes: a860f6eb4c6a ("ocfs2: sysfile interfaces for online file check")
 
