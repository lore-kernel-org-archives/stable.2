Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B492BEC34
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 05:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791436691; cv=none; b=YiXnU9gpW3FQZB2/S5o55cf4a73aMkkWzwOY4Yu+LjkVgk5ZEjOnM1VFbsoOcp9DMFGK6kDuVxUH7A3MGtZRnIhMJQ3WmL7k8u0OKLLyNYzQPOs8Xhil9OL8v9Qqt1y++gAJ5huSFysWgfKdOuog3UduTAJuGtpYpMpdDoghPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791436691; c=relaxed/simple;
	bh=K25jnv2p4L1k4pPo64hCRP+kpLFkxyB8fVdBs7e2h8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4jA3D+AUIMM0ZsrLqtu7+gaPxOmijXkr+0DKNHDjzUpHutbUyLtDjmClIDHm9PfK+N2kTk0eTIXgV3gbM6lK1LNaBBHkdEtuXMkN+57h5FqP5c+hkHnsVQZarYhv6NHYsRtKs2JmR/BiCxoK1Jp4QCS5vcE2FVvvylbpn+vZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCtPmrYC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCtPmrYC"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so1110217a12.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 22:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791436689; x=1792041489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DpTgnww+452bruhm0n4E4Dy06w8HMJjZi8g9dGEf8PM=;
        b=LCtPmrYCTZlh9YURxerZZV8fLpdYqv14BdBefV8iyP5XH2sRjImFEFWZthVyTy7D2i
         J3B+ene6l9qlwP0V5cpeS5DD6dMjfZRPtQuXOXcCt7RuTvIPBI+6FiLfpDUlduYTB2Bk
         KB9j3KHUed2zlaGLIOYMoRADkqOsz3LvBoBob1w5vWA8Z6nyOnECOi+4JPNlsGuqxuCm
         08BRrmMyRqATeFd2yXj+GaoN3oKyrNcouOdSUaYBbu50iEwcr+NUCTvlPx8wkVKgla6a
         td8G5b1O7tYKVHh+OGz6Xn6mwMxaQkCp/AXWfrtQzcWjP9wAcS+kx+8GQNt31HTc0n7t
         fclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791436689; x=1792041489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DpTgnww+452bruhm0n4E4Dy06w8HMJjZi8g9dGEf8PM=;
        b=wRTCJLrQac8MaEC8kjr2MNrdTltHQTW0kjmAN2e+9IimS6lM092hcxQslgeB/cgRCp
         65usYIU/GS/2ITFAfD3pw8qGoJO/yUaxpoZ7tFL347z+pt0G5fZLQNlh4KlqajecXc3U
         bQySWF/cRMfOaVquryHJUo7zLX6Y3d2RPOgZqwb1ViLNnZ+Zgjg/MFLFUJET1ZPZh30K
         T2TLHSYDAaLNMzR1yNTmdDGrBi9P++6iaxbH1JiO+9cEyjwJNdxsD+cEarmrFOW6uDk0
         U7iJd7MIoe6LQrE7zZvhDts3PPR6v0s8KMZy6yL3G9rsdtwPORSfliY0W0dRb1Cg1mrz
         v4Rw==
X-Forwarded-Encrypted: i=1; AKwUvBw54NmIuVmGugcr6znlpBLVhzrJF+8mY6JPGjk+k0+X61Z6/PvmN3cEz2P3wqCVrJU44cLwvG8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1irGiED9yL0vGg2ZQpF7WPyF7nGb+3klyGQUA/+ANnMS/UwpM
	7Y6cTYhi+puOHQTfwbmvn1RlbPHX9d9H4iqNga9a8a6Ht881LFqyIaJd
X-Gm-Gg: AYBFou1F9eNl6ATn84330UnIh2oZxd2ucgIrWerP64Q9rC7ED3uo4H81d1NAS+iZU/9
	ItpcZT6/gc2qDKcCtF8fNc+iB9kC6Ws6RgIYpF2E6JZ1a7PDAfX03R2sjooRHrZBNhQQzjseJzW
	3d3xlTK9SSA+/rOxm0vJzLGu5gJRpyvjrVYWEQAcnsc6ERb0DiSYvWdDWOQVtcrIFSYQhmWry09
	S1Q/t6oTVMXlNqQKHjt29+zQHPg5VDqoE7Ty9oIO5OYAVw2hFPXl+gwGZSoP3SMrK4XO4Mqz5G7
	Mjis9M6NO0yAikZr7bgVHV65B1n+2OYEcNNm1fhDzfeEAGt6oBwDTWG8oIF47BjrA41kWtlLkpS
	3yCWJ+/44z/k/Z3oW3EmJoeGNxWt0aPqvdcu0Vp/conEjj27e4uUwkye5ypXDrpCgC4tqvUHGiN
	pMWWlRGapCnqBBRD61lbPwgSs6E/R2uSbJkiur+P66mBLSQjxXXJMxksMM63El2EelowU22twBy
	8zwhg==
X-Received: by 2002:a17:90b:164d:b0:3ab:413:49b6 with SMTP id 98e67ed59e1d1-3ab04135113mr533585a91.41.1791436689169;
        Wed, 07 Oct 2026 22:18:09 -0700 (PDT)
Received: from dungbv.. ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a92d6161sm2349155a12.16.2026.10.07.22.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:18:08 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>
Subject: [PATCH] Bluetooth: selftest: Pin module for selftest debugfs file operations
Date: Thu,  8 Oct 2026 12:18:03 +0700
Message-ID: <20261008051803.526248-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open debugfs file retains its file_operations pointer in the
debugfs proxy state. However, test_smp_fops in net/bluetooth/smp.c and
test_ecdh_fops in net/bluetooth/selftest.c have no .owner set to
THIS_MODULE.

As a result, full_proxy_open_regular() calls fops_get() which succeeds
without taking a reference to the bluetooth module. When CONFIG_BT=m
and selftests are enabled, a userspace process can open either
/sys/kernel/debug/bluetooth/selftest_smp or
/sys/kernel/debug/bluetooth/selftest_ecdh and keep the file descriptor
open while the module is unloaded (rmmod bluetooth).

When the userspace process subsequently closes the descriptor,
full_proxy_release() accesses the already unmapped file_operations
structure, triggering a kernel oops in full_proxy_release():

  BUG: unable to handle page fault for address: fffffbfff8056f03
  #PF: supervisor read access in kernel mode
  Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:full_proxy_release+0x8e/0x140
  Call Trace:
   <TASK>
   __fput+0x39f/0xa60
   fput_close_sync+0xff/0x200
   __x64_sys_close+0x8c/0xf0
   do_syscall_64+0x115/0x6a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

The issue was discovered via manual code audit of net/bluetooth/smp.c
and net/bluetooth/selftest.c.

Set .owner = THIS_MODULE on test_smp_fops and test_ecdh_fops so that
debugfs keeps the module pinned until the file descriptors are closed.

Fixes: 64dd374eac15 ("Bluetooth: Export SMP selftest result in debugfs")
Fixes: 6de50f9fdb60 ("Bluetooth: Export ECDH selftest result in debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
 net/bluetooth/selftest.c | 1 +
 net/bluetooth/smp.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index ae5b44bb9d3d..cdfc40e0016b 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -188,6 +188,7 @@ static ssize_t test_ecdh_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations test_ecdh_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= test_ecdh_read,
 	.llseek		= default_llseek,
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2df303f6a38f..81d255525fe0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3696,6 +3696,7 @@ static ssize_t test_smp_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations test_smp_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= test_smp_read,
 	.llseek		= default_llseek,
-- 
2.43.0

