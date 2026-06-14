Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B626F2AF
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781449250; cv=none; b=DRv6XEXf7q8QkGqg2ZjSIkzZaLME+cAn3FlCLW7J8qnTI7/rKFCPt4TfYsyOX5y81kkeQ2dskm1RM/LJlo93uZ7unWNvnSRF1lboP3uOjkkmdz06a06sOGmHInLAgb2o5igR5iehaGwCGPcdbaIYoT9xgptdEKKFbl/k0V7bR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781449250; c=relaxed/simple;
	bh=2npXpHQkXqKbu9W/ajkzv5o/gKk6GeI+UO27XdxLb8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnJw4l/GC2W66TgKQHdyuRSrG2BOkhOUAP6k+xssRqoX3JlhlhdkpzaVteut2iT9/L2dvM2m72RN8SJvv13L/vZmJEUi3TR4En+EzsScCaHcmVUMLYRCdWxXn+FZHpz8sYZEc9rQBQPcuVljOhEzlu8DDStfCy32rcZUysPgOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyNMNTb4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyNMNTb4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a76757e5so17419645e9.2
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781449247; x=1782054047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IK+mjRbLPH8mzNxWadw+RKrJrBeJDqrl1whghjB/rRU=;
        b=HyNMNTb4JGX/CxJwc/0aheo0/NzEnu/M8ngz3H9G5mRhBUdAEL4uoCL0Suk+Edu2yN
         d5ZF+WKOLnzwUq+BsajzmqHZ4Q525SBelsZ0FyRK+JfXmSePiYPzFkWIaZYLVeYoXu1m
         cRa6RQR1dXzpDDAC16tNSyZ7g7HCyfQSTjvckfrXY9T/76E9S4Ekk8O/lO8lC9gOQRR+
         ouMNpXZjYVmKi9DLZkUdcHu/hzqI0dHFbwztGx70SJBIAC2KNgbzGWjWKxSR1Le5gJmE
         sgdZRBrPmXeyk8YN6Mmvm8c1ykQmHdPvM121SiaK4FBeP/QL4DKZCekyA+onuMg0rolh
         Cr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781449247; x=1782054047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK+mjRbLPH8mzNxWadw+RKrJrBeJDqrl1whghjB/rRU=;
        b=oYmMcHGF0hHXlJgd4ask96PpbBd1uvOHJfobXs4mykkUhfqiShJFtZRMk7vFSuKIUK
         v7/QmFywn0y3JrE+tmLnlOJyko/mxGRexJRaGeOtPij4ew3j0j7tWBu2spoTj5MINgzT
         Z12jC0U5dLVzjRZfRedGgOgoQnFE/gGVe+YlVXixQoaWW8OehUMkipmvbz6zdGt7Aas+
         NV4M8OGV2fWZmBB+I41kEx1b5bOag+ABJjH/+HkAB7gocwepZZhINMkXggO0WD6DukCT
         4WXLg7TPujNSRWKNHwNZfgcQRc32Z9ztp1VHwrD0wZJ0omSms+UP27xonXm5WFpBYQ4N
         kbcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BNU1rWxh2IA4HnA0nc3Yyike49Y8A//DneFCC+J49cAuMZCRHwZ4Aw3ggLFPN8OjOPhkIcl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYDdFrkkFOeKGw5unzByOl+m2hMFkRmiTxUrR0Q+DTyfo+lnI
	93nZvumURYJLTvm8tqXfQXFxASD9shAGTYDM4nL4nmIS5ZvGfa9yu/w=
X-Gm-Gg: Acq92OFbBfUktqH53fjV+SMwAV88kuaHcsgyW3a8paUj5Aw8T3usXhWepy0dzWbb/EB
	Ba5MpZH3NDAgyyHFM+xnz4sl6QVmksHrvKYVDhUwwnktoxwd3rlPtUdwwoa3ghh0uKRBKdeIf8g
	5FaS1s0n4jQz8z7+b6h058qDM737/+G8WljKm7jF7LuDQZelEDFppaoXmiz6gLEYz+kK+nFxMnK
	65/225YD+t64YOFs+P3mZm68JqsukYULtfGwd+HwW7MXo++uIGbegGAExXf6V1UgIForXjevgPe
	ZupqIk9nGNg7bfRQjmQW+fAhhIqzKDTUF2eg8O9FDaPFFKc2bvBVtiGF/IhfK6d2YPk7uPifSJd
	95hVVdTUdes3za5JtH90kGJJXXPIbmyd4cFvtJsewJW8znABL9xovXmkPVYCQa5ok4Mml2p80ii
	vF21u3MQ0EWc2S9A6VAWgNgu9jr+Ivat3QVW/VTchSBq6ZeT9DnayVubEQDJ1o7FjrLLJsf4pTM
	ZNJJvNxi3DdmuTkA55pKi6Nk+J+Q6TgD+8T4YREKA==
X-Received: by 2002:a05:600c:6542:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-4922006283cmr59149455e9.14.1781449246441;
        Sun, 14 Jun 2026 08:00:46 -0700 (PDT)
Received: from hp-ubuntu.. ([41.249.127.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922032ae56sm165261205e9.7.2026.06.14.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 08:00:45 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com
Cc: jmorris@namei.org,
	serge@hallyn.com,
	ebiggers@google.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com
Subject: [PATCH] KEYS: avoid filesystem reclaim while holding keyring->sem
Date: Sun, 14 Jun 2026 16:00:41 +0100
Message-ID: <20260614150041.21172-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__key_link_begin() runs with keyring->sem held and calls
assoc_array_insert(), which does GFP_KERNEL allocations.  Those
allocations may enter filesystem reclaim, evict an fscrypt-protected
inode, and reach keyring_clear() via fscrypt_put_master_key() --
taking a keyring semaphore of the same lockdep class and closing a
keyring->sem -> fs_reclaim -> keyring->sem cycle reported by syzbot.

Wrap the assoc_array_insert() call with memalloc_nofs_save() /
memalloc_nofs_restore() so reclaim cannot recurse into the keys
subsystem while keyring->sem is held.

Reported-by: syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f55b043dacf43776b50c
Fixes: d7e7b9af104c ("fscrypt: stop using keyrings subsystem for fscrypt_master_key")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/keyring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5a9887d6b7be..21bb2e7e7cca 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
+#include <linux/sched/mm.h>
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
 #include <keys/keyring-type.h>
@@ -1298,6 +1299,7 @@ int __key_link_begin(struct key *keyring,
 		     struct assoc_array_edit **_edit)
 {
 	struct assoc_array_edit *edit;
+	unsigned int nofs_flags;
 	int ret;
 
 	kenter("%d,%s,%s,",
@@ -1315,10 +1317,12 @@ int __key_link_begin(struct key *keyring,
 	/* Create an edit script that will insert/replace the key in the
 	 * keyring tree.
 	 */
+	nofs_flags = memalloc_nofs_save();
 	edit = assoc_array_insert(&keyring->keys,
 				  &keyring_assoc_array_ops,
 				  index_key,
 				  NULL);
+	memalloc_nofs_restore(nofs_flags);
 	if (IS_ERR(edit)) {
 		ret = PTR_ERR(edit);
 		goto error;
-- 
2.43.0

