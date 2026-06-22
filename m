Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477C2281525
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126952; cv=none; b=r0o4k9XMbNl+whbWkj7bqwENMInjK0UcPu6N8/CHh2luz1Q1u50mrR31bKZ6npzAZNjJsldBLOrAzQT/L4oYm9DIamZVNGCrFKEK5D24azQ+ORMktalXOAxrLqSfFWMGlT4wm/wASWipyug5f4LvSwcKy8hGJPPTnaD+uuQ8/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126952; c=relaxed/simple;
	bh=Jkgk4shOsAHu3FJcHLOCKGEnKsvA6Wf5xxX7yDOU65U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/SmZvZ7iNQmjQmZ3DV9d1ev9UFSzPyQaMvLEQ6XN2P7LknCBh0xGCAkQraS1qgiBrn6K6K0hcGTDEt3pERgMe6joOTjTGDlYfjO4pFCRvm4xRpmSgZkgmiTnVlrKnf9Q1ZwlqXo72cxRpLM1gbNt7vVkUS14V2XCk7pj0J0R+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkIZronE; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkIZronE"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8612a0db3cso203757a12.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 04:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782126949; x=1782731749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cYgbEdwZR7lqKgYa1PJ/PeOcDozVzwruK2AcBU92FQQ=;
        b=YkIZronE/AGN/8S/BWk8nCNYB1CcrOyT6/sjoVnF1i8d7aJNqYd5snwxZidn/s+3ot
         XrrWRVMxW73vkUi9PB28gMX/8p5wxdGgTdADrYubGguygnZJ6UejXV741/tuMcZW1JAb
         EFmbFrFWy26qyWopXhwEm7s/nhR88QtpwOLdH2PX5BBNJQJgPj/zg1l1YZHy0DivLyze
         kiN7HOsKKRS5e0+EQE1F6bGkXVW9roYMFNYYBvqmLGXFVtuN+8ZMhj+u+uRLb7gDyqUj
         p4EvLut8gdIklnnGGX76f/2uhOO4B2K+W4bCLwO8dEEjgaxtyQR9OVpU9n/vjZJqY3Id
         9Y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782126949; x=1782731749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYgbEdwZR7lqKgYa1PJ/PeOcDozVzwruK2AcBU92FQQ=;
        b=XCRtHkRRbk8zSdbFmmtPFESx8YAQrTHwVCDuShDz6OqFqJFAsb1WkNDKoJA6UMgW//
         TgwwR6k8YVsQG4nTc0EnfjXmvVNm7//BEK7WB9Ic4f2+GiaWNfhH49ohKDZcftW0JZde
         1/nJu6Q+E+GCxQE61XLKSOsLSmSkIGh2ZUdLxqP/5d1o3AjCo2mTuqiXUIZjxrkSiepq
         OpIUh0+n73hPlgAtNmcO3FgjvUVRJKe2t2mVQmNMXy+SU9FNULUxvekOTvisk9yLYUxL
         HEzCN6Fnf/dzfyWutPrCdOyMoiQPN1//dYRP9XOdtjwplzS0ioDzJVummVwFCJ9AMRNh
         cuWw==
X-Forwarded-Encrypted: i=1; AHgh+RrJdrlz8jgx0t/GTEpKFfIunzINVQrx55jO79SsK1gaLS2lWKXzAAa3TZKnHFYASEFx/BUPwUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhxwt/6d8/Y2KlmeYPPNjoOx8jAqzNVpEdsxV8hw8FvdhexHRM
	UDwD4m+Ait4dUZ39mmHiN9m9wii04hSfQVQ4QwrrgvnIhtXO0Wc5+mSBqTkHV3Vo
X-Gm-Gg: AfdE7cmf0iwSe0XDD6fxmUejaI+mt2dnd0a/bNZSG5ejHUwrLJoIGv7VNDDZmtany1q
	1p5r0nUrilwSro1paHE0PpoR3/pe30D8GqvNUOL6pfvo/aGq50VHCoIS+ZIvVpfArCeF8ufpd54
	9Oxs4oukUrAFtg9heKVra77aMIObVOTnAMjgTkHaTEXp7QVh/0KTABjbQD6qDZGZz77sK85fuie
	ccn397Vx/zOwBjozETwxAh/2wHb4by1VHrzOhVvcSgTzYmDr+fEHtzK9H2OV28ROu4zPP1xacM8
	SE4gfVhDvnhl2e+xc8bs+zOBEo/B0ezP/ytmMQME21ipU9P4VdQzuTnj8fwOpBWOVBs6npf5Q7t
	kjaOxSlRM3b01W8O27V7f0ZfsPu2JW2exL34o9re/pXH6Hy+TRC+oGgZB8bUM7bhlRG/1+QdPEo
	FGBriKoQ==
X-Received: by 2002:a17:90b:2dcb:b0:36b:9323:c726 with SMTP id 98e67ed59e1d1-37dc9829e11mr34502a91.4.1782126949396;
        Mon, 22 Jun 2026 04:15:49 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f2d2615sm6773008a91.10.2026.06.22.04.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 04:15:49 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	jhapavitra98@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] gpib: fix use-after-free in iboffline() detach path
Date: Mon, 22 Jun 2026 07:14:37 -0400
Message-ID: <20260622111437.852082-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iboffline() calls board->interface->detach() without holding
board->big_gpib_mutex. Every userspace-reachable I/O path (read,
write, command, and all ioctls that call them) acquires this mutex
before entering the driver callbacks. The mutex therefore creates an
apparent serialization guarantee that does not extend to the detach
teardown path.

The race window is wide and practically exploitable. Board driver
read callbacks (cb7210, ines_gpib, tnt4882) all delegate to
nec7210_read() -> pio_read(), which blocks in
wait_event_interruptible() for up to board->usec_timeout microseconds
(default 3,000,000 us = 3 seconds) while holding a cached pointer to
board->private_data on the stack:

  Thread A (I/O path, holds big_gpib_mutex):
    cb7210_read()
      priv = board->private_data        <- cached on stack
      nec7210_read(board, priv, ...)
        pio_read()
          wait_event_interruptible(board->wait, ..., usec_timeout)
          /* BLOCKS HERE UP TO 3 SECONDS */
          priv->state ...               <- UAF if detach fires

  Thread B (detach path, no mutex):
    gpib_unregister_driver()
      iboffline()
        board->interface->detach()
          kfree(board->private_data)    <- frees what A still holds

The bug is in the core framework (iboffline() in iblib.c), not in any
individual board driver. The three affected drivers (cb7210, ines_gpib,
tnt4882) are all vulnerable by the same mechanism because they share
the nec7210_read()/pio_read() path.

The iboffline() comment already flagged this gap:

'XXX need to make sure board is generally not in use (grab board lock?)'

Fix by acquiring board->big_gpib_mutex before calling detach() and
releasing it afterward, serializing teardown against in-flight I/O.
mutex_lock() (non-interruptible) is used rather than
mutex_lock_interruptible() because iboffline() is called from module
unload context where signal delivery is not meaningful.

A prior attempt (Thomas Andreatta, May 2025) used user_mutex +
use_count to guard iboffline(). That approach was NAK'd: user_mutex
is not held consistently across ibopen()/ibclose(), making it racy
(Dan Carpenter), and use_count is never zero for an initialized board
so the check would always return -EBUSY, preventing any offline
transition (Dave Penkler). This patch instead serializes on
big_gpib_mutex, which is exactly the lock the ioctl dispatch path
uses and is therefore the correct exclusion boundary.

KASAN report (kernel 7.1.0+, QEMU/x86_64, KASLR disabled,
reproducer: kprobe on read callback + concurrent kfree from detach
kthread):

  gpib_common: GPIB core driver
  gpib_race_harness: loading out-of-tree module taints kernel.
  gpib_race: attach priv=ffff88800331e7e8 canary=0xdeadbeef
  gpib_race: kprobe on dummy_read installed
  gpib_race: detach_fn waiting for read_entered
  gpib_race: reader_fn calling dummy_read
  gpib_race: kprobe fired -- dummy_read entered
  gpib_race: dummy_read priv=ffff88800331e7e8 canary=0xdeadbeef
  gpib_race: detach_fn firing detach on fake_board
  gpib_race: detach kfree priv=ffff88800331e7e8
  gpib_race: detach_fn done -- priv is now freed
  ==================================================================
  BUG: KASAN: slab-use-after-free in dummy_read+0xb0/0x120 [gpib_race_harness]
  Read of size 4 at addr ffff88800331e7e8 by task gpib_reader/25

  CPU: 0 UID: 0 PID: 25 Comm: gpib_reader Tainted: G           O        7.1.0+ #26 PREEMPTLAZY
  Tainted: [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x2b/0x40
   print_report+0x14f/0x4d0
   ? timer_delete_sync+0x68/0x90
   ? dummy_disable_eos+0x10/0x10 [gpib_race_harness]
   kasan_report+0xd4/0x100
   ? dummy_read+0xb0/0x120 [gpib_race_harness]
   ? dummy_read+0xb0/0x120 [gpib_race_harness]
   dummy_read+0xb0/0x120 [gpib_race_harness]
   reader_fn+0xbf/0xf0 [gpib_race_harness]
   ? dummy_disable_eos+0x10/0x10 [gpib_race_harness]
   ? __kthread_parkme+0x56/0x1a0
   kthread+0x32a/0x470
   ? kthread_affine_node+0x280/0x280
   ret_from_fork+0x32d/0x5a0
   ? exit_thread+0x70/0x70
   ? __switch_to+0x83f/0xc30
   ? kthread_affine_node+0x280/0x280
   ret_from_fork_asm+0x11/0x20
   </TASK>

  Allocated by task 23:
   kasan_save_stack+0x2c/0x50
   kasan_save_track+0x10/0x30
   __kasan_kmalloc+0x77/0x90
   dummy_attach+0x39/0x90 [gpib_race_harness]
   0xffffffffa000d073
   do_one_initcall+0xb0/0x230
   do_init_module+0x263/0x810
   load_module+0x3e12/0x51e0
   init_module_from_file+0x136/0x150
   __x64_sys_finit_module+0x39f/0x7a0
   do_syscall_64+0x56/0x3f0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

  Freed by task 24:
   kasan_save_stack+0x2c/0x50
   kasan_save_track+0x10/0x30
   kasan_save_free_info+0x37/0x50
   __kasan_slab_free+0x3f/0x60
   kfree+0xf1/0x390
   detach_fn+0x105/0x130 [gpib_race_harness]
   kthread+0x32a/0x470
   ret_from_fork+0x32d/0x5a0
   ret_from_fork_asm+0x11/0x20

  The buggy address belongs to the object at ffff88800331e7e8
   which belongs to the cache kmalloc-8 of size 8
  The buggy address is located 0 bytes inside of
   freed 8-byte region [ffff88800331e7e8, ffff88800331e7f0)

  Memory state around the buggy address:
   ffff88800331e680: fc fc fc fc fc fc fc fc fc 00 fc fc fc fc fc fc
   ffff88800331e700: fc fc fc fc fc fc fc fc fc fc fc 00 fc fc fc fc
  >ffff88800331e780: fc fc fc fc fc fc fc fc fc fc fc fc fc fa fc fc
                                                            ^
   ffff88800331e800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffff88800331e880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ==================================================================
  gpib_race: UAF dereference priv=ffff88800331e7e8 canary=0xdeadbeef
  gpib_race: reader_fn returned

Note: CVE-2026-31769 (Adam Crosser) fixed a separate UAF between
IBRD/IBWRT/IBCMD/IBWAIT ioctl handlers and concurrent IBCLOSEDEV
via descriptor refcounting. This patch addresses an independent race
between the I/O callback path and iboffline()/detach() teardown,
which is not covered by that fix.

Fixes: e6ab504633e4 ("staging: gpib: Destage gpib")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/gpib/common/iblib.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpib/common/iblib.c b/drivers/gpib/common/iblib.c
index b672dd6aa..07a30d520 100644
--- a/drivers/gpib/common/iblib.c
+++ b/drivers/gpib/common/iblib.c
@@ -256,9 +256,23 @@ int iboffline(struct gpib_board *board)
 		board->autospoll_task = NULL;
 	}
 
+	/*
+	 * Acquire big_gpib_mutex before calling detach() to prevent a
+	 * use-after-free race. I/O callbacks (read/write/command) hold
+	 * big_gpib_mutex while caching board->private_data on their stack.
+	 * Without this lock, iboffline() can kfree(board->private_data)
+	 * inside detach() while an I/O callback is still running and holds
+	 * a stale pointer to the freed memory.
+	 *
+	 * Affected board drivers: cb7210, ines_gpib, tnt4882 (all delegate
+	 * to nec7210_read/pio_read which blocks in wait_event_interruptible
+	 * for up to board->usec_timeout microseconds while holding priv).
+	 */
+	mutex_lock(&board->big_gpib_mutex);
 	board->interface->detach(board);
 	gpib_deallocate_board(board);
 	board->online = 0;
+	mutex_unlock(&board->big_gpib_mutex);
 	dev_dbg(board->gpib_dev, "board offline\n");
 
 	return 0;
-- 
2.53.0

