Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794431420;
	b=5n/omuJMG+8wtuNyNgbRO41FW8JP/6IucxTVf3KvsfyJk6jdpaqAvF1BhjkLvoR4ewHI
	 qeoCHCK97TEkb4Xzs748TLPhaBAHcCuaZEtR22os9qPS5aoFRjXneSd9JaOTCZWG9XUiX
	 QUqfFCkQd6sltc/06qs/3wb6eJzkhAxddqsh3F7s5mweXTXaMoLe9h2hhoiYEcrzAVgfk
	 llcZh+LtgeeIxSqZp5yBNGTqq/dYGYRfto3z/p0n/Zh77I2PD60mG4VvKUNa4LRHXz8AF
	 FeS5DiE1Wn0pE9ary/sVLp+0ppuCFZWEf3zIKW/m1UPn9XKukjf0Xjn0fKSPpvxl2ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431420;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R0l2g1VzA2+y2dr/PMBAOnhDTsNQZBQYybpf5pAA+ZY=;
	b=3QcTCSJsNyamONaHMzbVlcKiz9BgcGfvHtccvG0e2fZZ2UJHGkPbxfbdv+ViPMJRmZXk
	 V5NECDOeq/HJKcfjHxYuo7BeeYoR4KAHK1zZXvLQuQFMmhQageWTgY3NhAgKunhJ6y5I+
	 YRO43RRE0Ecn7BRZc9m0quuzSFvqYYOpUEggMF4g/wLJ4uX5UsVi8zLo1xVQgmIRSkv7B
	 eb662hKbndGbXymq3GlIyUWBAVPr8/m4rloZAOpqHIMXZaRw97nwRJA0R7RsRiBoUbDau
	 7yqyRjDRROjqI5hv0mDBcYmfZ/xJEv05vBkz2Ev9GKis7UusaYfgudWOoiip1IHvAUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mePDC2Hq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB85606A31C;
	Wed, 11 Nov 2026 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mePDC2Hq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794431420;
	b=oz2D0smNcSykICs8oy8JVcrvZsMX34S8+PbtvecaS2iAPRylMOHNquWqhVhWuNOzkjbc
	 WIY9Uk6y2aCkDTDwMPAasXe30VzFly1v7BaMY0YMP0YMlY7xK17l9cRK+zIqyk6Sls2vf
	 O469eTsig8mmFrl2gIj37ETp7/cNlbk1oU9FQfuTdPEHxoO5qud5uPFsJdqO+nPypiiMX
	 SaZntDVvLiiS1BPr0Sd+dY8acyzvwU7IitwdBmKtpKCzl0z8M7pAPwuhDje3NsxtBZQJl
	 zL/WLONu28RgFi/BcRBDqv37AzkD+f2xE02MKYokWPO9uPcycwjeDozhLdHJm71WpsA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794431420;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R0l2g1VzA2+y2dr/PMBAOnhDTsNQZBQYybpf5pAA+ZY=;
	b=VBxfNz07TtBT4RwZszCG6n++N0H6vyph9PhJQaB42+eTmyyx83BWVvXNjd7C6dvQxDay
	 mbhI/ddLYqQ8FiTqzhC3OMMx5TpcPlCpoBbyCuoKF3L32Ok9QstRFJGoLIj7lhs02izQi
	 0MqXeQNBJnghADUanMTshQrPgBtJ05DrEPF2CZa2nJfoEqqqnEB8skvl/UvtXqSupd2QN
	 IKv0AXdbcFNpAp6744gYXqOl+0FAVtvdyVYGp393j9Ar8h2mzTFks9zdOvPbtOH1pDx1N
	 zpJTZnQoxHSvh9BfPcB9vUy5W0O6pSXWVvtVoah4gy4e3ifFAxNguiYHOv5Y6k5RHGw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 806921F00A05;
	Wed, 11 Nov 2026 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794431420;
	bh=R0l2g1VzA2+y2dr/PMBAOnhDTsNQZBQYybpf5pAA+ZY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=mePDC2HqUkGvPM0EEJg0dZeAUfBnFlNw/0HM+DBmakdAc4myUpY+sp7oKYlsS9thK
	 EMo3+rOtrIKWxJVIv14LHceeeO04GQAEWLnNxDyfpc4Lvp6RCaMjd60IkmmpqqxySR
	 lKZIQ9ztAcllEEb7el8EP1odPZGS3YBqP4kG6PJyb1tNOBZt1Gc8TodchR/0DwlZfy
	 ictBoMiP+9G74y/bPmkqfiJDZSru5c1tYKISwhbnzR2QyLAnXIdUC8IKXO06Hd4X35
	 IFKReM4vtzr+chfzYX5soWeCvc7PTyREdFkgSpApRzQmN5OYLvxzGwzIVVVeu9xPD1
	 U7NCo1kyGWgAA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D005749119;
	Wed, 11 Nov 2026 21:10:18 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Wed, 11 Nov 2026 16:10:18 -0500
Subject: [PATCH] sched/wait: Queue non-exclusive waiters at the head in
 do_wait_intr*()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-b4-sched-wait-intr-head-v1-1-17cf2af5b964@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMOw7CMBCE4atEW7NSHDkIcRVE4ccYL4VBXvOQo
 twdh0z3FfMvpKgCpfOwUMVbVB6lwxwGCtmVG1hiN03jdDR97C1ryIj8cdJYSquc4SKHGac0+tm
 aZKm/nxVJvv/y5bpbX/6O0LYcresPfOz7DXsAAAA=
X-Change-ID: 20261111-b4-sched-wait-intr-head-c5e8f0b541f4
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794431418; l=3328;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=aBf1tiVmoERImLGkIeTudmuMhxlNlGR/QO90qjNZf4c=;
 b=0J3ROETF5fxEF0iC8HWrpHh6eAV/x7d2MVrYq/bu3LA5m0ULolawd1s+PMuZ1vwHvoj/C/nNo
 yyNhK7kPb+7APywjUL4k3ZtYbz2cKxN49bGso7QvmFHlvHiQSFv8STj
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

A task blocked in read() on an eventfd or timerfd can sleep forever
while the file is readable, if an epoll(EPOLLEXCLUSIVE) watcher of the
same file was added before it.

eventfd and timerfd wait with wait_event_interruptible_locked_irq().
do_wait_intr_irq() adds the reader at the tail, behind the exclusive
epoll entry, and __wake_up_common() stops after waking that entry.  If
the woken epoll task is killed or leaves without reading, nothing wakes
the reader:

  Task E                   Task A                 Task C
  epoll_wait(ep, -1)
    /* EPOLLEXCLUSIVE */
                           read(efd)
                             /* queued after E */
                                                  write(efd, 1)
                                                    /* wakes E, stops */
                                                  kill(E, SIGKILL)
                           /* still asleep, efd is readable */

A periodic timerfd doesn't wake A either, since the timer is restarted
only by a read.

prepare_to_wait_event() and add_wait_queue() add non-exclusive waiters
at the head, which is what __wake_up_common() relies on.  eventfd did
the same itself before it switched to these helpers.

Do the same in do_wait_intr() and do_wait_intr_irq().  This only changes
the order in which non-exclusive waiters are woken.  Each of them still
gets every wakeup.  With the fix, A is woken by the write.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 2s.

Fixes: 22c43c81a51e ("wait_event_interruptible_locked() interface")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/evexcl.c

gpiolib-cdev and cros_ec_chardev use the same helpers and can be
polled too, so this fixes them as well.
---
 kernel/sched/wait.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index f8d6d8b9d03e..342dec5fd937 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -319,8 +319,12 @@ EXPORT_SYMBOL(prepare_to_wait_event);
  */
 int do_wait_intr(wait_queue_head_t *wq, wait_queue_entry_t *wait)
 {
-	if (likely(list_empty(&wait->entry)))
-		__add_wait_queue_entry_tail(wq, wait);
+	if (likely(list_empty(&wait->entry))) {
+		if (wait->flags & WQ_FLAG_EXCLUSIVE)
+			__add_wait_queue_entry_tail(wq, wait);
+		else
+			__add_wait_queue(wq, wait);
+	}
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	if (signal_pending(current))
@@ -336,8 +340,12 @@ EXPORT_SYMBOL(do_wait_intr);
 
 int do_wait_intr_irq(wait_queue_head_t *wq, wait_queue_entry_t *wait)
 {
-	if (likely(list_empty(&wait->entry)))
-		__add_wait_queue_entry_tail(wq, wait);
+	if (likely(list_empty(&wait->entry))) {
+		if (wait->flags & WQ_FLAG_EXCLUSIVE)
+			__add_wait_queue_entry_tail(wq, wait);
+		else
+			__add_wait_queue(wq, wait);
+	}
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	if (signal_pending(current))

---
base-commit: d7e670601af6c564ccf6d3b2ddf70ee4f41a6d1c
change-id: 20261111-b4-sched-wait-intr-head-c5e8f0b541f4

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


