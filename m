Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E849EC71
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464883; cv=none; b=J9ylgmbr0XbZsWfWVTuWeBwH/ab/qk43Gx3LI2U8GDUopRgG26JzIspw6CAEDfGhWOAiyAGfTtRQAAVWEQRkhNQsmX1Y4eSvL6v3jqtKpllwRQo/r9QyLf4b1uuq7pGb0C9T2cCqNsZw+wWzV5fwwI7E5HCg6JrTqQSGDVgtnyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464883; c=relaxed/simple;
	bh=56WtSLmyXgOWqkE8uHq9stmyvAJgS6HKIATqylz3mXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDItiKoZUUelPp1ItfN7ioPOWYFeZ64VLD+j3MCN9y8l9OvkpojITv+9I3iXvmlA4osKkbQQ0Ey90r5Sf6HS0Bgo2e6WdCpawcMUtsP5QdXpfDgKCDOvXCzQh69ow8cdYrKmegM3I34umMpPPkgT0UQaFCuByrfRC9qp7cZZlco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeGT9Uc8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeGT9Uc8"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-873a4edb243so3698805b3a.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791464881; x=1792069681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vl7sRwfmLB48VwhLwaxygRLXnDOF27+xyMS2vapngz4=;
        b=IeGT9Uc8Pd0rDueuIkAoJzZ3cMIlW2YNGgwreiPZbYIDUCp0mSqUVnBj/1aIVe+LYJ
         2FusEa27WvR3V/S/omD9qiJCSESQel0z4JNQ2sGcF+sxT+PWylNeQuwThKEsuk1cUGRC
         BGeWXi8tgvhZQGf2T56kbgbdq2aaZvckZX1Muhp5KDOKYIaMWf+9qm8l1b3Ujeqaaupt
         sbV6JPekmqPfSkQYDLI67bF+3rp01q0KAO/ojgyX2BkFhw8a7WtDwTOydPdP1LxhnvSD
         jSZ0jnF3lSQEc0piWo4rYECuz7BELvVuSvQYDxDmJTQecs0/MUM3GrEKnmmH6ATaZOi4
         RSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791464881; x=1792069681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vl7sRwfmLB48VwhLwaxygRLXnDOF27+xyMS2vapngz4=;
        b=bxCGcyU6k+p3ebRWZUI7Jl+6/Evlwvzxb3M7qU53BipzNitAe4dsuPQpdjlfEHtjIZ
         DqYVDyWZl+WE+FZH/a7ggK7hF4l77mDObV0OacGwCXZpFzTzw3FheOPicg2mVw58DYOA
         C8ps8UPLrVQE8ZS4uE/l5H2IxVbFSGdt2aozpjIjpYWoibHX7MnrEwKjbnnQYLkgt+zc
         Ds1ubcXAXEwqGqUZIMlCYx4X/maxA4k4DO6id+JFPTp8RXNL5UVOBB1Yq3dvzhwsZbuL
         GsDb27RniYVkxvR0VDyPxjxzisCrdvUJ/FcvEgJ5lawM4UXpXjmxitVhr/89J2bVoveh
         n1DA==
X-Forwarded-Encrypted: i=1; AKwUvBwKp15aoRTOM52FX8Rbl/6jCm9BOiIfAx4BEGuj1ydxU04zoMyTBEh/vb078/QqSUqll8kkH5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nMaYkH0wBZ4lxQzhKd+s30/9YALLbxzH/jxtWXZlrWePs2EiOI
	q/gFCsEI/LZnL9Gxyz58wIXcG9L7aeDfM5qUZb1NFDNDpljVEMwagGcr
X-Gm-Gg: AYBFou1F7nGAXseo0XncbdlTQ60D47wBiJ0MuXNjUbiOXx5Gihab15HxMN9DmT7RA8Q
	w8vJaH/BakdxFeoq++bjx9OUF2GdvouwEYjn/UH3ETWy9S2Sowk5cYntIwKQaY+pnFWKY8ItGx2
	6/3HzczZIHFZ3Gd/bamly62909Ty0WNH7IrTMBf0sMr2weCYbpauqP9afhy7nQuK4HHx1d/8hkG
	a94WwxvYy9kXPjQBW1CN2C9osF/Dx7o5TOYLrebuz+TTkXUPwtLQhy05YI7cbAx/msGAye3c6yB
	DAVsZF5Q8BNuaRXZrGAk6adN272SM9lY3bNuuQ6xicx2Fg5YFuevtHzP5RFu1zkud80wdBNj6uu
	YETD6W8cYvKdFGeUuqEp4JFnh2qqQczqTubeIzTP/qrxH6CClksyghJSv9tNNyN6TS9qviJzBmJ
	P3O0qv8LnOP1UeTvD73vVk7x00b9CmlyiEGL/pJkV54MDTDLFT1RFueS/MYVixn/iVAZD5r8u1Q
	mdP
X-Received: by 2002:a05:6a21:7111:b0:3d3:ae50:97ce with SMTP id adf61e73a8af0-3e1340420bfmr4724948637.27.1791464881362;
        Thu, 08 Oct 2026 06:08:01 -0700 (PDT)
Received: from dungbv.. ([58.186.69.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd1640b6e67sm2201621a12.1.2026.10.08.06.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:08:00 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>
Subject: [PATCH] wwan: wwan_hwsim: Pin module for debugfs file operations
Date: Thu,  8 Oct 2026 20:07:53 +0700
Message-ID: <20261008130753.313875-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open debugfs file retains its file_operations pointer in the
debugfs proxy state. However, wwan_hwsim_debugfs_portdestroy_fops,
wwan_hwsim_debugfs_portcreate_fops, wwan_hwsim_debugfs_devdestroy_fops,
and wwan_hwsim_debugfs_devcreate_fops in wwan_hwsim.c have no
.owner set to THIS_MODULE.

As a result, full_proxy_open_regular() calls fops_get() which succeeds
without taking a reference to the wwan_hwsim module. When a userspace
process opens any of these debugfs files, a subsequent module unload
(rmmod wwan_hwsim) can succeed while the file descriptor remains open.

When the userspace process subsequently closes the descriptor,
full_proxy_release() accesses the already unmapped file_operations
structure, triggering a kernel oops in full_proxy_release():

  BUG: unable to handle page fault for address: fffffbfff84f90ef
  Oops: 0000 [#2] SMP KASAN NOPTI
  RIP: 0010:full_proxy_release+0x8e/0x140
  Call Trace:
   <TASK>
   __fput+0x357/0xaa0
   fput_close_sync+0xe6/0x1a0
   file_close_fd_locked+0x17e/0x2f0
   do_close+0x33/0x70
   __x64_sys_close+0x44/0x80
   do_syscall_64+0xc3/0x590
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

The issue was discovered via manual code audit of wwan_hwsim.c and
reproduced on a Linux 7.3-rc6 test VM with CONFIG_WWAN_HWSIM=m.

Set .owner = THIS_MODULE on all four debugfs file_operations structures
in wwan_hwsim.c so that debugfs pins the module until close has
completed.

Fixes: 9ee23f48f670 ("wwan_hwsim: add debugfs management interface")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
 drivers/net/wwan/wwan_hwsim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index c3c2d2a68767..34eea3edc824 100644
--- a/drivers/net/wwan/wwan_hwsim.c
+++ b/drivers/net/wwan/wwan_hwsim.c
@@ -500,6 +500,7 @@ static ssize_t wwan_hwsim_debugfs_portdestroy_write(struct file *file,
 }
 
 static const struct file_operations wwan_hwsim_debugfs_portdestroy_fops = {
+	.owner = THIS_MODULE,
 	.write = wwan_hwsim_debugfs_portdestroy_write,
 	.open = simple_open,
 	.llseek = noop_llseek,
@@ -524,6 +525,7 @@ static ssize_t wwan_hwsim_debugfs_portcreate_write(struct file *file,
 }
 
 static const struct file_operations wwan_hwsim_debugfs_portcreate_fops = {
+	.owner = THIS_MODULE,
 	.write = wwan_hwsim_debugfs_portcreate_write,
 	.open = simple_open,
 	.llseek = noop_llseek,
@@ -545,6 +547,7 @@ static ssize_t wwan_hwsim_debugfs_devdestroy_write(struct file *file,
 }
 
 static const struct file_operations wwan_hwsim_debugfs_devdestroy_fops = {
+	.owner = THIS_MODULE,
 	.write = wwan_hwsim_debugfs_devdestroy_write,
 	.open = simple_open,
 	.llseek = noop_llseek,
@@ -568,6 +571,7 @@ static ssize_t wwan_hwsim_debugfs_devcreate_write(struct file *file,
 }
 
 static const struct file_operations wwan_hwsim_debugfs_devcreate_fops = {
+	.owner = THIS_MODULE,
 	.write = wwan_hwsim_debugfs_devcreate_write,
 	.open = simple_open,
 	.llseek = noop_llseek,
-- 
2.43.0

