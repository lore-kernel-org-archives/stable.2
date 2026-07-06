Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D4436BEB
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362172; cv=none; b=Ioqq0H0pW/aDKS6tWSuK9+E+KA7Zz7R8AvrYNOplpdGrny4FdrUD2+98mP2q1U3ATKrXisOuitWtdjipgXcJhV2LSD8MQHHaehw0kPMDeK8FF9jmp4YENksf7iluEhYQjERe70wMS9uYr5j+TX6QjQzstzZ1plgelUDH3K1sUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362172; c=relaxed/simple;
	bh=f8A8HSnnoJfx2V2FXn4Rkd737vzAC7KNR5OAkSuZgzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hQVmZHY5OcYESCkVrpIW7Qb/VYs0lQnY6O3g3rkrJJSvR6BfmU+0viNwV06bw5BXB6bdL+USTapQORDCFppEkdpWZHPBqJDNWuWBD5Fmb0t/ETsYtW5c8arqkYuQG3m8okmEOXnrxC1D9i4rWo1zQawbDIrgc1jxvwk/chlKQuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oSNRrmEZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSNRrmEZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso155e9.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783362169; x=1783966969; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2n0bB53EEy+f4O05YVB7+hzJUrWYRhdG8q1UZt65t50=;
        b=oSNRrmEZe4qsdYPbqJOJzQHDmwtJBpstiTxC/+z3bKuzik8JiswdbIN/dbkH9FAQtw
         Dh8JsJIT1u2Jg1KXje3wfk12537MuED65Npk9gd7d7PkYmBo6euC/L8soQqahXTU6tB5
         Fz8Qw63Z0sGdYSYGkmZkbKbSh7QnT3ng5D7WM8eiQ4GlDI1WWRGAFiQT1vVEPSjSFa0m
         vVJRw/wmpUB59D3EQos7hsZIjv0P4pCSp1xpk4a3/c33u287kZ2Nm1nSnhi5JHEOrsCU
         4wRQdqYl3es26QeFwMprhCj3iMRO78xeVQpRa47XtxIugCmSuCGGbNIeMP/49CW2FeGs
         1m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362169; x=1783966969;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2n0bB53EEy+f4O05YVB7+hzJUrWYRhdG8q1UZt65t50=;
        b=HXiN/2IGlLxxCRLUjUkeXB1h2BZQoFyOsSXVVshc40WWmMg+aJq9n9uda93PYWiExv
         s+d4PZaeK1b4ABlM6dzVelu/soIBBxQ4vxwfNm+LvQ8rvOPlhHwVjK2ago4xIoMsiiN+
         qzErX9jVEik4B5eRuf6rpWEodLLJSMzyvexyxcejaGUxASqr8C9nfpKUePtO13NBtco7
         FxXsqcOh0+BxaQgxeeHXH172NbgVSXJQN2L6cgPYUZwN2ShZNEs3Nfd9/bJZGo0XK6Ax
         HWRi1YwhXZX7r42+RrO9oUsOYP64rdFmJ7qhbQozw1ZnqZN/OWf0lU9Ux3ylXkRg9eMK
         tW3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqVk9y129sLxCJBmc1T7m7weXwHkLRITiGDMAj8gIUjIs/hsrrCEC8NNoEIgHEfMPGx1hK4pfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1TKKN+LhznjBDyeskjWPAm1U/by45xgbRzJLNt5/JXpJdyRx
	IEY27ODaVQtePtNWp3kRy5zjHEfqC7Y+K8nRZwc7lrAXsg1AwC7P6bSozjACVIDcLA==
X-Gm-Gg: AfdE7cn7LzGn5+Y1bbmIUWMbM35YnQSJ0oMSxstItAMkeohuiQFkWufZXFo8YEsglce
	pzgU/m/qrZKtU4D9Th2JKHWRYW1Gd2+XHzY8KmQiEQVXbcvNujxQ8wHKHjZAbSiS4oyiaG2YHey
	GC24uDFurkkQQtdlJwc9XQkKa0AJMiBu5yNCQlbuV1pKhDmrjwiopibQVh4gsiRQ1XyILsDVpSx
	ZhUzzPDp3hkr0m5q0aNVJmAQURqf1NAnf4yl4jotZPDa9steMHXt/rhCco9FizWSW3vmqhLlbtW
	F/zwznQTAK5mKuW8ZqT/6m3onJPvHTdgMeij6ki3caeAPWeLByhXo1BFcXC7B0De0gXPebHx0Jn
	YCsuzqQCU2zNizImIoU2v7jq2f7UpdVJFuevG/Qs1rsAWpztzUp5Z4hYhuAqiA93LRyIEr7hk5W
	v8rZcdnkkI6Ahffd2CsiXrQujnBNIntXzpF7IUEnYV3kZsq7VV1nckCc8XiMn7XoF3s0WoeOI=
X-Received: by 2002:a05:600c:621b:b0:493:b47f:a24 with SMTP id 5b1f17b1804b1-493dfb5d91fmr282775e9.6.1783362168372;
        Mon, 06 Jul 2026 11:22:48 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c536:dee:89b4:9c3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e006b6besm3278025e9.2.2026.07.06.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:22:47 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 06 Jul 2026 20:22:42 +0200
Subject: [PATCH] proc: Fix broken error paths for namespace links
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com>
X-B4-Tracking: v=1; b=H4sIAHHyS2oC/yXMwQqDMBCE4VeRPXchNRC1r1J6iOtY10OUbFsK4
 rs32uM3MP9GhqwwulUbZXzUdEkF10tFMsX0BOtQTLWrg2tc4DUvMhonY0QRGI/6ZR/7oYV3Tec
 DleuaUeYze3/8be9+hryOFu37D/uSikl4AAAA
X-Change-ID: 20260706-procfs-ns-eacces-fix-3abd8e307936
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Magnus Lindholm <linmag7@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783362164; l=1618;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=f8A8HSnnoJfx2V2FXn4Rkd737vzAC7KNR5OAkSuZgzE=;
 b=OsAeK+y2dAYcnAgPmrdLreaRNOSG0UawNxTe4j2PcNHlHFHOZFs34fUDS8CdejScfxGGlkuaD
 t8eWdFjIxwSC4ynU0Sq0ag/8RJubwsYxh6DDIVNg2hwFvhlaZGbbeqP
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Don't return the return value of down_read_killable() (0) when a ptrace
access check fails, return -EACCES as intended.

Reported-by: Magnus Lindholm <linmag7@gmail.com>
Closes: https://lore.kernel.org/r/20260706170735.2941493-1-linmag7@gmail.com
Fixes: 6650527444da ("proc: protect ptrace_may_access() with exec_update_lock (part 1)")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/namespaces.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 2f46f1396744..ea6ec61a0430 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -46,7 +46,7 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	const struct proc_ns_operations *ns_ops = PROC_I(inode)->ns_ops;
 	struct task_struct *task;
 	struct path ns_path;
-	int error = -EACCES;
+	int error;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
@@ -59,6 +59,7 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	if (error)
 		goto out_put_task;
 
+	error = -EACCES;
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto out;
 
@@ -90,6 +91,7 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 	if (res)
 		goto out_put_task;
 
+	res = -EACCES;
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		res = ns_get_name(name, sizeof(name), task, ns_ops);
 		if (res >= 0)

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260706-procfs-ns-eacces-fix-3abd8e307936

Best regards,
--  
Jann Horn <jannh@google.com>

