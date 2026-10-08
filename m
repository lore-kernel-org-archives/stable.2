Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6C125AA
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791435262; cv=none; b=Bm7QSrCFYx09oMKsjujn0/ck4neGn2tdIQJOcxIyIjo8bTTgzCyR6XHwVrCVyiP0eB1OUZAMaLkDNA4l2YAWEaUp7cnQk3nGZinzyTxpDS4wO4BgOlLK3X2mRXKe6HXcS70gZ8hyy9VnPqw2QI92N6ReNdXV6Pv8ZavTZ29CHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791435262; c=relaxed/simple;
	bh=svPYm/ErGNSTUaXVXCQZ7z4u10kek6ZBfJnn8TTMf1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PIdvqQY5nn9+cI+Z/UdVQ5WhDMkp+9llNGfx5dlRwX+kk9OSli7mYpQldFcxkrbOKl+R26etnZXxtGzRRa8t3u/vuP8H8ewSIdy5qHTtMqyRGZ9zAAcICuVSA8owVWVkkzp9evlOqbADYfVo9AA5rypDXEBWj2ZNFgGu4g84fIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKKRRhhO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKKRRhhO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a865731ee4so2329496a91.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 21:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791435261; x=1792040061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmV84PAhQf1rP81PzhsTjjy7MoGjA1NeT69P9fECqzs=;
        b=rKKRRhhO6fZVsHPrqUcBzKJXt4eHovRSHxyQ1JkecnmVda27ljUJJ1UZub6cvPO3q1
         el7GYpIN1pswjbuoWomYXCxMThqY0/M+nFtYUVlGjWu/atg3aoKh6JOo82hzJXCNiYSn
         yhOZ01/RRjEEAB13WUP/PlLsqiXGL4gK3b6gScXxXDy0KzsGot2SBPW308sZxJQfHMw1
         pDj0YchjpfXTm8Fz6N9n7YFd/nbRE4p9wB2/3e887pcICVv8THoAgtE9kGsl86QHSPJ3
         So2IktKxGW1Tnta9Dde94/ij0lpAGLn7ymJFkiWTCzvdd8ae09Xd3apXZfbsMSkq4izO
         FYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791435261; x=1792040061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmV84PAhQf1rP81PzhsTjjy7MoGjA1NeT69P9fECqzs=;
        b=VBkPoZJjzmrxs+m5wwyMsrPvIzFtDrqJuQ2LVsqQRVrQdtDUmF6qaAZyYzNPHXcmEy
         coA96IDLpOSJszPHeNWnEtT/B8+bKekQUWSM8CnvFjKuXalYMFgMv8KRoJWMBavhAWWZ
         G7VC8b/miItS120oOZGaSekeI8ZFK7+OaFTJBPIJxFTMdHoYkmJS2T2r/JreTjN6M76L
         mlXCoIl+XmS2ubvGf7cBpVQNSOXCQCcL+R5LH+zyS1+7urZg9t1quil5w2ZzIVtYxKpR
         zeSytBIanoivbfKMDel04OJVE+wPed2x8BpEApMO4HkWxaHVI+XiTuUFmj+ivQyDHLn9
         7O9w==
X-Forwarded-Encrypted: i=1; AKwUvByceYJiZ9TTHJyPJXT8/9K/EajralotiJQxkDEN6iB2p5K51vWyigT6S0bMjxTUgKl2Xymbkfw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbc3GLFa93dH0gh6yWDhNsX5GgSU/Yae9LLWlbTS72abZwC1yV
	jiO6lxlcJx8+4hIMcBFJcSRpl19lD0BbCoeXF0/G0suuy50+jKQrkpvC
X-Gm-Gg: AYBFou0H9VEEBoCXDE09hFisWLj4Nh7gc/0h5hx7oCrT6JXVtFwkwbQRJIpRgBUoxBG
	hBZQqeEZsDUvtnWetXYxuwP4tJQ70zO/QFtQZcTWuHPGaKqg931f66XaJLXooyCdKBHCODRVz7T
	d8PyS8N72PdbKjqOrDxN5KjAh9gqOX5+0IKa9iuQ/KDQf0NfBo+yAJ10LDCu2l9IbNhlBKHSPMK
	ePQpVrpwoAntJGhatLkxWfijsQ/Sm4Y9xoffE9T6sXlOyUAiejPOJPG/4ZYO7hZs5D//YQcVb9N
	hmtzqHq0jPToBNS8RAH01o1V0T9pIt2j1gWbrr2j2V+SkkFFnlmypBorEWUnchWmvIFh/dl+WQL
	6kozfiU+x3oERCU6Kxyg7sqOI9IaHMjjkVmEfAAz7/N9+tavzl7tuaUglO0MfnJP10P1WIHWqrd
	RSd0qEJQTnEuURTfeXAOZ76tVtTE6fhfMXmeeb2JDsg1xiz+tsXPR3mIbD7Xfi2NvShPoCtWe1L
	wt9lw==
X-Received: by 2002:a17:90b:5887:b0:3a7:cd7b:134 with SMTP id 98e67ed59e1d1-3a8a1974f13mr3974405a91.24.1791435261030;
        Wed, 07 Oct 2026 21:54:21 -0700 (PDT)
Received: from dungbv.. ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aa0cbea8d3sm2407809a91.16.2026.10.07.21.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 21:54:20 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ivan Pravdin <ipravdin.official@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>
Subject: [PATCH] Bluetooth: hci_vhci: Pin module for debugfs file operations
Date: Thu,  8 Oct 2026 11:54:13 +0700
Message-ID: <20261008045413.465999-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open debugfs file retains its file_operations pointer in the
debugfs proxy state. However, force_suspend_fops, force_wakeup_fops,
aosp_capable_fops, and force_devcoredump_fops have no .owner set to
THIS_MODULE. As a result, full_proxy_open_regular() calls fops_get()
which succeeds without taking a reference to the hci_vhci module.

When userspace opens any of these debugfs files and later closes
the /dev/vhci file descriptor (triggering vhci_release() and
debugfs file removal), the open debugfs file descriptor remains valid
in userspace. Because the module refcount was not incremented,
the hci_vhci module can be unloaded via delete_module (rmmod hci_vhci).

When the userspace process subsequently closes the debugfs file
descriptor, full_proxy_release() accesses the already unmapped
file_operations structure, resulting in a kernel page fault / oops:

  BUG: unable to handle page fault for address: fffffbfff846f18b
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:full_proxy_release+0x8e/0x140
  Call Trace:
   <TASK>
   __fput+0x39f/0xa60
   fput_close_sync+0xff/0x200
   __x64_sys_close+0x8c/0xf0
   do_syscall_64+0xc3/0x590
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>
  Modules linked in: ... [last unloaded: hci_vhci(E)]

The issue was discovered via manual code audit of
drivers/bluetooth/hci_vhci.c and verified on a Linux 7.3-rc6 test VM
with CONFIG_BT_VHCI=m by keeping a debugfs file open across controller
teardown and module unload.

Set .owner = THIS_MODULE on all four file_operations structures so that
debugfs pins the module until all file descriptors are closed.

Fixes: 28010791193a ("Bluetooth: vhci: Prevent use-after-free by removing debugfs files early")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
 drivers/bluetooth/hci_vhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index eddb32b30539..8f7db0102b25 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -155,6 +155,7 @@ static ssize_t force_suspend_write(struct file *file,
 }
 
 static const struct file_operations force_suspend_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_suspend_read,
 	.write		= force_suspend_write,
@@ -194,6 +195,7 @@ static ssize_t force_wakeup_write(struct file *file,
 }
 
 static const struct file_operations force_wakeup_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_wakeup_read,
 	.write		= force_wakeup_write,
@@ -263,6 +265,7 @@ static ssize_t aosp_capable_write(struct file *file,
 }
 
 static const struct file_operations aosp_capable_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= aosp_capable_read,
 	.write		= aosp_capable_write,
@@ -386,6 +389,7 @@ static ssize_t force_devcd_write(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations force_devcoredump_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.write		= force_devcd_write,
 };
-- 
2.43.0

