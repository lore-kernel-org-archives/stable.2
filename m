Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0C4BE450;
	Fri, 18 Sep 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726050; cv=none; b=Pg1sBKyBdfiyobfEayPy/PT2NOKooqrT/v9ikJPrQR+Sh/eeq6sunnrMBzQvmWUYAfu/oURuvVeb9VXWRFyRCV+qS16r0tXu+3KGbE4Zbt5xhzvd09Dmw4msFlvQXhsVa771WYYHZv4p0Ct3FvmMsEIdlco0kVfbXaAJQOI76TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726050; c=relaxed/simple;
	bh=qQAXMpl6kaEpRcN4/tOcZYMxGs17v3oKNSI/FOISC9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r2Pyn6bmY7nmk/1PDYJMm9fmt8VJ0LE58hE+qfBM3kMRzJRPsHpL90rydNuLaSfZUFuqTzqtAW+YazzJ61+1kMwsnXs1A4geNqiypLmLAcja5E/gDsCzVlMDstgo/P9/Qu+BW1yQpq6qwAwkxNKLhSdOMkD1g28VcsCio1eucx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABXXDpTDa1qEnAICA--.4167S2;
	Fri, 18 Sep 2026 18:07:15 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: Petr Pavlu <petr.pavlu@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH v2] params: serialize lookup_or_create_module_kobject()
Date: Fri, 18 Sep 2026 10:07:12 +0000
Message-Id: <20260918100712.3124994-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXXDpTDa1qEnAICA--.4167S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr13uF4UWr1ruF43Aw15CFg_yoWxGFW3pr
	WYqrZ0k3y8XFs7Ca97A3WkZ34fX3WkZrW7WFZ3Kw1avF1Yyr1vvFnrKrySvF1UA340yay2
	qF1UArs0kFWDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F
	4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbMKZJUUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

lookup_or_create_module_kobject() first looks up the module kobject with
kset_find_obj() and, if not found, creates a new one with
kobject_init_and_add().  The function is called at runtime from
module_add_driver() since commit f95bbfe18512 ("drivers: base: handle
module_kobject creation"), which means two concurrent driver
registrations for the same built-in module name can both miss the
lookup and race to create the same kobject.

The loser of the race gets -EEXIST from kobject_init_and_add() and its
kobject is removed from module_kset by kobject_add_internal() before
the failure is reported.  The error path then calls kobject_put(),
which invokes module_kobj_release(), but that only completes
->kobj_completion and never frees the dynamically allocated
module_kobject, leaking it (96 bytes) along with the object having been
detached from the kset.

This is triggerable by unprivileged users, e.g. by concurrently issuing
the RAW_IOCTL_INIT ioctl of the raw-gadget driver, which registers the
"raw_gadget" driver on the gadget bus:

  sysfs: cannot create duplicate filename '/module/raw_gadget'
  ...
  Adding module 'raw_gadget' to sysfs failed (-17), the system may be
  unstable.
  ...
  unreferenced object 0xffff8880188dacc0 (size 96):
    backtrace:
      lookup_or_create_module_kobject+0x47/0x100
      module_add_driver+0x73/0x1b0
      bus_add_driver+0x1d9/0x340
      driver_register+0xde/0x170

Fix it by serializing the lookup and the creation with a mutex, so that
the second caller finds the kobject created by the first one instead of
racing with it.

Fixes: f95bbfe18512 ("drivers: base: handle module_kobject creation")
Fixes: 7c76c813cfc4 ("kernel: globalize lookup_or_create_module_kobject()")
Cc: stable@vger.kernel.org   # v6.15+
Assisted-by: OpenCode:DeepSeek-V4-Flash
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
V1 -> V2:
- Use guard(mutex) to hold mod_kobject_mutex instead of the explicit
  mutex_lock()/mutex_unlock() pair with the goto out unwinding, as
  suggested by Greg Kroah-Hartman.
- Fix the multi-line comment style at the mod_kobject_mutex
  declaration ("/*" on its own line).
- Add the missing "Cc: stable@vger.kernel.org" tag, as both Fixes
  commits are in v6.15.
- Add the "Assisted-by: OpenCode:DeepSeek-V4-Flash" tag per
  Documentation/process/coding-assistants.rst.

V1: https://lore.kernel.org/all/20260918013445.1849655-1-xujiakai24@mails.ucas.ac.cn/
---

 kernel/params.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/params.c b/kernel/params.c
index 8b25133fed242..a45a0201cb4fb 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -3,6 +3,7 @@
  * Helpers for initial module or kernel cmdline parsing
  * Copyright (C) 2001 Rusty Russell.
  */
+#include <linux/cleanup.h>
 #include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -20,6 +21,12 @@
 /* Protects all built-in parameters, modules use their own param_lock */
 static DEFINE_MUTEX(param_lock);
 
+/*
+ * Serializes module kobject lookup and creation in
+ * lookup_or_create_module_kobject()
+ */
+static DEFINE_MUTEX(mod_kobject_mutex);
+
 /* Use the module's mutex, or if built-in use the built-in mutex */
 #ifdef CONFIG_MODULES
 #define KPARAM_MUTEX(mod)	((mod) ? &(mod)->param_lock : &param_lock)
@@ -754,6 +761,13 @@ lookup_or_create_module_kobject(const char *name)
 	struct kobject *kobj;
 	int err;
 
+	/*
+	 * The lookup and the creation must be done atomically, otherwise
+	 * concurrent callers may race to create the same kobject, and the
+	 * loser of the race gets -EEXIST from kobject_init_and_add().
+	 */
+	guard(mutex)(&mod_kobject_mutex);
+
 	kobj = kset_find_obj(module_kset, name);
 	if (kobj)
 		return to_module_kobject(kobj);
-- 
2.34.1


-- 
Crash report (raw_report0) of the syzkaller crash this patch fixes:
---
BUG: memory leak
unreferenced object 0xffff8880188dacc0 (size 96):
  comm "syz.3.569", pid 12998, jiffies 4294992047
  hex dump (first 32 bytes):
    12 4e fe 86 ff ff ff ff c8 ac 8d 18 80 88 ff ff  .N..............
    c8 ac 8d 18 80 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8dccd85e):
    kmemleak_alloc_recursive home/zzzrrll/tmp/kf_src/linux-7.3-rc2/include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:4696 [inline]
    slab_alloc_node home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:4996 [inline]
    __kmalloc_cache_noprof+0x1bf/0x420 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:5559
    _kmalloc_noprof home/zzzrrll/tmp/kf_src/linux-7.3-rc2/include/linux/slab.h:991 [inline]
    _kzalloc_noprof home/zzzrrll/tmp/kf_src/linux-7.3-rc2/include/linux/slab.h:1312 [inline]
    lookup_or_create_module_kobject+0x47/0x100 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/kernel/params.c:761
    module_add_driver+0x73/0x1b0 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/base/module.c:46
    bus_add_driver+0x1d9/0x340 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/base/bus.c:767
    driver_register+0xde/0x170 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/base/driver.c:174
    usb_gadget_register_driver_owner+0x50/0x140 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/usb/gadget/udc/core.c:1752
    raw_ioctl_run home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/usb/gadget/legacy/raw_gadget.c:596 [inline]
    raw_ioctl+0xa26/0x1830 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/usb/gadget/legacy/raw_gadget.c:1307
    vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:51 [inline]
    __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:597 [inline]
    __se_sys_ioctl+0xbc/0x130 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:583
    do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0x12b/0x350 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f


<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

---

