Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541132;
	b=QuyEZO9npZeoqUE8moei5WqtogMdXUKPiDcId3HuqxenXWA0TBHCznheKtxcRmBxym5I
	 ycsU4keYnuUt3Hxw+4YAiDD3TdkUMOpHZc2jaGmCRAUj/absY58jjFXduSMMOoOLNUu68
	 GXVpkLGueHcL/GOSPKwO5hwN0zOCLgIQCdn/LQEDbqqK58E15suylhS55riZuHTHD+lRp
	 MTyClVqSXkAbpJAD6tT5ZImTxfOt/4w+x76fntFnjeSqqQfZku8pgoXn2Sfy34TeRIczS
	 LidZd2yOatB29swhcWXeriguThiAyVEewjetelpoo1Xw7YXYzsusvq9p9p++hdDoH0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eJED9RvAZ4gBzrtrvfpCnmjx/MMKsZ4K/q+3GDdJTPY=;
	b=3wSJHBOVg+OprvoYfmXS2qR7KY4fCFma+owVvso1M9nCIxZgfewE38qaXEyjnT+Btetd
	 rMnXe8SLCBqpsQ17pN/AZiaX3x06KD19tjjRiLJgYIQJ+vcbxbgNfUB58Bn77Gj8Etpjg
	 E/YLRCATghQh7VmIAjKM5ZYpG32+ZxfiKu2SZcm1awVCRolVu8L1m1e/VfC5e3EGspJKo
	 PcJ3UneV4fkzC4mvjL0J+UCTWkIueEE6l3Qj6AOtuZ7LQ/86SIxAJ/5egr0e6C3vrEY5w
	 tFZFiWqSNX1TGURjnM2LmTvkqY1fG6YUdZCCMnA1/6BkMX/kob5mAmyGxBC4n6qmeCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=k-tech.co.jp;
	spf=pass smtp.mailfrom=k-tech.co.jp;
	dkim=pass header.d=k-tech.co.jp header.i=@k-tech.co.jp header.a=rsa-sha256 header.s=google header.b=iryKG6mY;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DDB606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00DDB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=k-tech.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=k-tech.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=k-tech.co.jp header.i=@k-tech.co.jp header.a=rsa-sha256 header.s=google header.b=iryKG6mY
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ed06b725fdso11588265ad.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=k-tech.co.jp; s=google; t=1794541130; x=1795145930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJED9RvAZ4gBzrtrvfpCnmjx/MMKsZ4K/q+3GDdJTPY=;
        b=iryKG6mYs73xjEAyu3dBySoYUm1Vh9I4P6vYEYqiCw1bwVWOXJoOeLz2J2dXh5tahT
         flzDQH1WeBD/jt2rORMVABHLxDlg13OiZnefFtTSDIWwiij0AZTNgOX9UYlgDV0Ipm/o
         ebOcK6ykpQen24SnJQ7pEGRoV3+y+6DelDOe420hb1noWE7yFCwR9XrUz6Bl6i6LlrSx
         kpZHtJbCu3t68EUQ/9wI6NN76umY1543ZzHxbWo2GDJ3TKDucsuoErN+TG5idBxYvNX7
         S7re5D0Fe8n2Lh5yFGUVSIK+1DQ4ESJRKSpIIwJD/vlhPK0fUTU7sQhrDiPowiUDwQrz
         ac2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794541130; x=1795145930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJED9RvAZ4gBzrtrvfpCnmjx/MMKsZ4K/q+3GDdJTPY=;
        b=ckykNLWtca5+C6Ips0hgpiVF8ahD3VB3FX7RkJl2kPIqHjr7Bs5R8Zb8KRRGUWRaE/
         S9Rter2C+4IOHGC/fqHD+3IUFwuG9lM21aneHLQIKMWXFpFADFdlp7gNQIrOH8Dsm09M
         IG3wHXpvMIzPutAYEX5kc1RC/pI8UlEh21gWfcgd0rwavD4IJLGNw84RnEd+cn2gYJml
         1XspfkUpP9Pd66mv/TbghJzthlJYQgE3cPptV9g5Dgxo3MvHly5SH6ZWh0QOmM/85B0I
         +SIHhd3Ps/Ca0dom/xnLq5Q4/j2ZTek58iqwbD/P9bMKpB3Di4H8tI2CH4HGUU0ra9Xe
         A+sQ==
X-Forwarded-Encrypted: i=1; AL+hErE3UMP5yXv/PjSLgKvDlqk256IRwG8/VpwhR9e8n7p5DmXpv0pjr8FXlyTPqRV7rH7rg+02BS0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aDbbs3IHJTpBWA9pQ6SuNxW6YR9p8FKgj4ntcjD49KecPBo8Q
	bgbgmyj2f8zz+9UsX2QUAeRuL7uymjS4Wtg7CYLUefzQNFXldFWKX/RZZc7wFMwiUM8=
X-Gm-Gg: AYBFou2WSm3xwjRjZqwg1+5bfGkk2byRq61LfKFGUlojJpfouEIVByMn8KNyN6pRgr7
	ggTOSNpzPlgSr1e9UeFi1z2E2dR4cnklG9BP+VPnvarnNO213aubuyHej6Qqj5/osQ2fn/+OYpz
	HHnmKGdlc+avzRA9UOlxYTAW+Curp691b5DjOWM9aAOcB4QoPTAFQPHCW2i9dXXRTbpWcnmZfBr
	Lrq/gz9mZZqZ2Z+YS0qWw8mZT/oRKN4iKMei65/i2Cy1X3NVURYMFeDq2Z+9p8lDpR/Wdnf1u0n
	Xd2Llf3q/yDY1llujNEsXhUKtgtojN45aRR4XeqzzzyPJW5Dxa8EWLNDLTdSw5uw7e9zPgcZ6AJ
	VmISsqwS1AXXDrnrrqlfQ2RWJxWVqRpyHjcSay9UPBdSG1Zv5xgfXg0r9dOQgJyKdlnSSDejZ7s
	aCpxNQxzYzXQNjCjGK/EapwZu/A7+VtJqXoM+nZpeolr/F1HD8kxtxzX5I5HJGOozmyhyI5kVvs
	7IbmJjqvWfkYGio1EWnCSBUSV4mqQuZZ0uz88mVncXVKen+KYEgD9jqWhwbvHpWNrg6ZtkOAJPM
	IcnA3c1NiT/P7pP13wqVdk2inhNaanocEMPzaDsyqOEFU6ZJMKid4cY4QLG6G7i+T2H7tNEt0fq
	kJTiKXV/vRJR2x1ahSS3B7keCDYJ3JMbmNbrAfw==
X-Received: by 2002:a17:90b:3806:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3b1b0ca57damr556451a91.25.1794541129791;
        Thu, 12 Nov 2026 19:38:49 -0800 (PST)
Received: from localhost.localdomain (g74.115-65-36.ppp.wakwak.ne.jp. [115.65.36.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec43699sm2059374a91.10.2026.11.12.19.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:38:49 -0800 (PST)
From: Yuichiro Goto <goto@k-tech.co.jp>
To: a.hindborg@kernel.org
Cc: leitao@debian.org,
	viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	Yuichiro Goto <goto@k-tech.co.jp>,
	stable@vger.kernel.org
Subject: [PATCH] configfs: wait for pending RCU callbacks on module exit
Date: Fri, 13 Nov 2026 12:38:33 +0900
Message-ID: <20261113033833.124797-1-goto@k-tech.co.jp>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

configfs inodes are freed from an RCU callback: destroy_inode() queues
i_callback() with call_rcu(), and i_callback() then calls the
->free_inode() of the super block, configfs_free_inode(). Nothing in
configfs_exit() waits for these callbacks, so the module can go away
while some of them are still pending, and they later jump into freed
module text.

USB gadget hits this easily. libcomposite pins configfs with
simple_pin_fs() when it registers its subsystem and drops the internal
mount on unregister, which frees the root inode. Unloading the modules
right after that, e.g.

  modprobe usb_f_rndis
  modprobe -r usb_f_rndis

oopses a few seconds later with CONFIG_RCU_LAZY=y, which batches
call_rcu() callbacks for up to 10 seconds:

  Unable to handle kernel paging request at virtual address bf17e810 when execute
  Internal error: Oops: 80000007 [#1] SMP ARM
  Modules linked in: ... [last unloaded: configfs]
  CPU: 0 UID: 0 PID: 16 Comm: rcuos/0 Not tainted 6.18.63 #4 VOLUNTARY
  Hardware name: Freescale i.MX6 Ultralite (Device Tree)
  PC is at 0xbf17e810
  LR is at rcu_do_batch+0x190/0x510
  ...
  Call trace:
   rcu_do_batch from rcu_nocb_cb_kthread+0xc8/0x310
   rcu_nocb_cb_kthread from kthread+0xe8/0x248
   kthread from ret_from_fork+0x14/0x28

RCU_LAZY only widens the window. The same oops also happens on a
v5.4-based kernel, which has no RCU_LAZY, with the same two commands.

Call rcu_barrier() in configfs_exit() once the file system is
unregistered, so that no new inodes can be created and all pending
configfs_free_inode() calls have finished before the module is freed.

Fixes: e9c03af21cc7 ("configfs: calculate the symlink target only once")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yuichiro Goto <goto@k-tech.co.jp>
---
 fs/configfs/mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d8cac1cbf3bd..c65d8ff419b2 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -164,6 +164,8 @@ static void __exit configfs_exit(void)
 {
 	unregister_filesystem(&configfs_fs_type);
 	sysfs_remove_mount_point(kernel_kobj, "config");
+	/* Pending RCU callbacks may still call configfs_free_inode() */
+	rcu_barrier();
 	kmem_cache_destroy(configfs_dir_cachep);
 	configfs_dir_cachep = NULL;
 }
-- 
2.47.3

