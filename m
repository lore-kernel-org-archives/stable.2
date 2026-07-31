Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960242DFEA;
	Fri, 31 Jul 2026 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494155; cv=none; b=rIGcirfI7af5i7e/twbfoftZnzmuPWuSUkrFYVgJr/JSGzBm2fJwUyjVRFobf4+7kcQRwImTspRVQcqlb+yNeoGAExbhAjL2WBumfMYCmXJ+3YKY9lxBzXh77vvgxzlYp25jCbF2mY0AsZj4HzfOVfWZnHnXvVUDkGX80t/BWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494155; c=relaxed/simple;
	bh=1ENRNZqPXTi+Zd9+e8E9Q4ptr68mQpW6vTXswLen7pE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HHAmWBvYOWs1YAw1zqsDCSJ6G22OLTedJkXcooEb5prL7DCfnmlTtVz51TXK+2rtxVVHbV3LymvHLpIzGA7dzaqfoLmu5hzEkvceHWsPcJkSbgQgrQCi5deKqh/ym4hT/KXxoptFab7g8YNKA8HMjPlDNeLRE9ilomMqaqC8/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bupt.cn; spf=pass smtp.mailfrom=bupt.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bupt.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.cn
X-QQ-mid: zesmtpsz3t1785494000t0d4a4c8c
X-QQ-Originating-IP: eF7BR1GArchL5a7/+wetr5womz3GXQWhaUCOmdo5fLU=
Received: from localhost.localdomain ( [59.110.124.154])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 18:33:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13876591824679904484
EX-QQ-RecipientCnt: 11
From: Weisson <hanxiaobupt@bupt.cn>
To: cooldownlengque@163.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Kevin Wolf <kwolf@redhat.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Weisson <hanxiaobupt@bupt.cn>
Subject: [PATCH] nbd: fix race between nbd_pending_cmd_work and socket teardown
Date: Fri, 31 Jul 2026 18:30:51 +0800
Message-ID: <0722F9F24C333B29+20260731103050.678344-2-hanxiaobupt@bupt.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bupt.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OZuCtzQljvyFKJEcw+pVA46l35c8ArMpulec0RHVpW72fGgrddu8XP6v
	bXDccw6PyqRCXs13/fWaES71ZALcgE4lq/QQmdaNoy+n9XzPpeiFk5FvvE9//Wn0f6FGt29
	s574etHaxcomJ/5in+dB6nVeHEcJS5YmoV1LbVkEOwdvAyoLTR0WsR3XG1GK4dNswl6injt
	/KHJrAk9u3wLFbhS/jLRR126/xTkmkqzXtjlrAjKN9ohMudOL03Ghe1QfkQsO8ngzuBihqB
	dWBqij3Be7ThyS+v1a6/GF1iLttXpiJIGPAl9FnxmuM9Z7vPSWMdCq4tNKQaaLu4e3ZAx0n
	lqJJno29fBkBwhNl7tiyHY5Dmq+MsO7c4ri6GX3DjmOga+jwUaTc94oHopjsvo+d8dIc0H6
	k26Pu3YePqn5wm/dhHCO6fEEmfo2PxcSUnPdEFMvKTFZhNAb7el28BAnW0t6CiCIz7dOk1F
	QbOml3pJeUkiuhxYw0LBIaj8WCTJMlddpTZ1tFIC2sbq6j7XyapE5ouvFWW4pyuJ6mCq0iE
	m7rpTlio/0JUNz00HCZPYa/3hn72kKbm0q/mScesZTGzgWZYdsZZMloR8fBtSMsm44QI3hb
	1IuhUoNmRwL87uHUqxEgakHoOcuR+1Iq2vmnYYjkW8+FURa+1sKOrEoTsF/owiANNiFqNBS
	7X1eOjYF95ANJb5SzjTfMaTcsMmKeKknevchB1pByr2l+/y8laHVEH9iF9vURHJler+ncfr
	+3Zm6sep7VumuSF0vFGJWmbRnjngh8/PYhq0H4OxSsOGJYiFddmBTONna1opSy3k0n1fzqC
	bnlmlXq0L8l4LciJ7uyGJW5pw+//LGAQ80lVzJPfzoCYLh+FcZNWNXjBjCn5cwHBnBhQtow
	LPsuuki9s9RY3jyO/fOXiGsGCKjbZUwchVUXJmuCJDEVqA1tg/2esGhsO3EHHZj0xBdgt4H
	qTCJbT7aX3Ijd8t9CQdc34V7WKII3BVGUTrOE1IsRd+onOOEaPb8nat03eCs9ptY1jQYIYJ
	z079zOCujzUo8mFy1c3IcHlJrGzoa/X0LINGpZ+g==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Hi,

This patch fixes a NULL pointer dereference in nbd_pending_cmd_work()
that occurs when socket teardown races with the partial-send worker.

The bug was reported by Peiyang He via syzkaller fuzzing and exists
since commit 8337b029f788 ("nbd: fix partial sending") introduced the
partial-send worker mechanism.

The race sequence:

  CPU 0 (submit path)              CPU 1 (disconnect path)
  ─────────────────────            ─────────────────────────
  nbd_send_cmd() interrupted
    was_interrupted() && sent > 0
    nbd_sched_pending_work():
      nsock->pending = req
      schedule_work(&nsock->work)
    return BLK_STS_OK
                                   nbd-client -d
                                     sock_shutdown()
    ┌──────────────────────┐         mutex_lock(&nsock->tx_lock)
    │ async gap: work is   │         nbd_mark_nsock_dead():
    │ queued but kworker   │           nsock->dead = true
    │ hasn't run yet       │           nsock->pending = NULL  ← cleared
    └──────────────────────┘         mutex_unlock(&nsock->tx_lock)

  kworker scheduled
    nbd_pending_cmd_work():
      req = nsock->pending         ← NULL
      blk_mq_rq_to_pdu(NULL)      ← accesses 0 + 0xf8
      *** NULL pointer dereference ***

The root cause is that schedule_work() only enqueues the work item;
actual execution depends on kworker scheduling.  Between enqueue and
execution, disconnect can synchronously clear nsock->pending.

The fix establishes single ownership: once nbd_sched_pending_work()
schedules the worker, only the worker may clear nsock->pending and
terminate the request.  Socket teardown (nbd_mark_nsock_dead) only
sets nsock->dead without touching the pending request.  The worker
checks nsock->dead after each send attempt and completes the request
with BLK_STS_IOERR.

Reproduction:

The natural race window is microseconds wide, so a kprobe is used to
inject a busy-wait at nbd_pending_cmd_work() entry to widen it.

1. Build the kprobe delay module (must use mdelay, not msleep --
   kprobe pre-handlers run with preemption disabled):

  /* nbd-delay-repro.c */
  #include <linux/module.h>
  #include <linux/kprobes.h>
  #include <linux/delay.h>

  static int delay_ms = 30;
  module_param(delay_ms, int, 0644);
  static struct kprobe kp;

  static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
  {
      if (delay_ms > 0)
          mdelay(delay_ms);
      return 0;
  }

  static int __init init(void)
  {
      kp.symbol_name = "nbd_pending_cmd_work";
      kp.pre_handler = handler_pre;
      return register_kprobe(&kp);
  }

  static void __exit exit(void)
  {
      unregister_kprobe(&kp);
  }

  module_init(init);
  module_exit(exit);
  MODULE_LICENSE("GPL");

  Build with:
    make -C /lib/modules/$(uname -r)/build M=$PWD modules

2. Setup environment (forces partial send by filling TCP buffer):

  modprobe nbd
  insmod nbd-delay-repro.ko delay_ms=30
  sysctl -w kernel.panic_on_oops=0
  sysctl -w net.ipv4.tcp_wmem='1024 2048 4096'
  tc qdisc add dev lo root netem delay 20ms
  dd if=/dev/zero of=/tmp/nbd.img bs=1M count=512 status=none
  nbd-server 10823 /tmp/nbd.img &
  sleep 2

3. Trigger (repeat until crash, typically 1-5 iterations):

  nbd-client 127.0.0.1 10823 /dev/nbd1
  echo none > /sys/block/nbd1/queue/scheduler
  # Writer: 1MB O_DIRECT writes with SIGALRM every 500us
  /tmp/nbd-repro-writer 1048576 500 /dev/nbd1 &
  WP=$!
  sleep 0.05
  dmesg -C
  nbd-client -d /dev/nbd1
  sleep 0.2
  kill -9 $WP 2>/dev/null; wait $WP 2>/dev/null
  dmesg | grep 'null pointer'

  The writer source (compile with gcc -O2 -o /tmp/nbd-repro-writer):

  #define _GNU_SOURCE
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <unistd.h>
  #include <signal.h>
  #include <fcntl.h>
  #include <errno.h>
  void h(int s) {}
  int main(int ac, char **av) {
      int bs = ac>1 ? atoi(av[1]) : 1048576;
      int us = ac>2 ? atoi(av[2]) : 500;
      char *buf; posix_memalign((void**)&buf, 4096, bs);
      memset(buf, 0xab, bs); signal(SIGALRM, h);
      int fd = -1;
      while (1) {
          if (fd<0) { fd=open(av[3]?av[3]:"/dev/nbd1",
                              O_WRONLY|O_DIRECT);
                      if (fd<0) { usleep(100000); continue; } }
          ualarm(us, 0);
          ssize_t n = write(fd, buf, bs);
          if (n<0 && errno!=EINTR && errno!=EAGAIN)
              { close(fd); fd=-1; }
      }
  }

  Key parameters explained:
  - "none" scheduler: ensures nbd_queue_rq runs in process context
    via __blk_mq_issue_directly, making SIGALRM visible to
    sk_stream_wait_memory (kworker threads mask all signals)
  - tcp_wmem='1024 2048 4096': tiny send buffer fills immediately
  - netem delay 20ms: delays ACKs, keeps buffer full
  - mdelay(30) kprobe: widens the async gap to 30ms so disconnect
    reliably clears nsock->pending before the worker reads it

4. Expected oops (without fix):

  BUG: kernel NULL pointer dereference, address: 00000000000000f8
  Oops: Oops: 0000 [#1] SMP NOPTI
  Workqueue: events nbd_pending_cmd_work [nbd]
  RIP: 0010:nbd_pending_cmd_work+0x22/0x110 [nbd]
  CR2: 00000000000000f8

5. With fix applied: 300 iterations, zero crashes, zero
   lockdep/WARNING/scheduling-while-atomic reports.

Please review.

Thanks,
Weisson


From 6d985e412da840d5fdf6e64d9a544f2a5f271ec2 Mon Sep 17 00:00:00 2001
From: Weisson <hanxiaobupt@bupt.cn>
Date: Fri, 31 Jul 2026 16:30:00 +0800
Subject: [PATCH] nbd: fix race between nbd_pending_cmd_work and socket
 teardown

nbd_pending_cmd_work() dereferences nsock->pending without any
synchronization.  If nbd_mark_nsock_dead() clears nsock->pending
concurrently, the worker hits a NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 00000000000000f8
  Workqueue: events nbd_pending_cmd_work [nbd]
  RIP: 0010:nbd_pending_cmd_work+0x22/0x110 [nbd]

The worker reads nsock->pending (NULL) and immediately passes it to
blk_mq_rq_to_pdu(), which computes (req + 1).  With req == NULL this
accesses address 0 + sizeof(struct request) = 0xf8, triggering the
page fault.

The race sequence is:

  1. nbd_send_cmd() is interrupted with sent > 0, calls
     nbd_sched_pending_work() which sets nsock->pending = req and
     calls schedule_work().  The originating thread returns
     BLK_STS_OK immediately -- it no longer owns the request.

  2. Before the kworker picks up the work item, userspace issues a
     disconnect (nbd-client -d).  sock_shutdown() takes tx_lock and
     calls nbd_mark_nsock_dead() which sets nsock->pending = NULL.

  3. The kworker finally runs nbd_pending_cmd_work(), reads the now-
     NULL nsock->pending, and passes it to blk_mq_rq_to_pdu() which
     dereferences NULL + 0xf8.

Fix this by establishing single ownership: once nbd_sched_pending_work()
schedules the worker, only the worker may clear nsock->pending, release
the config_refs, and terminate the request.  Socket teardown
(nbd_mark_nsock_dead) only marks the connection dead but does not touch
the pending request owned by the worker.

The worker checks nsock->dead after each send attempt, and if set,
completes the request with BLK_STS_IOERR.  On deadline expiry, the
worker also marks the socket dead since the TCP stream contains an
incomplete NBD message and cannot be reused.

Additionally, nbd_reconnect_socket() now skips nsock slots that still
have a pending request, preventing a new TCP connection from inheriting
stale partial-send state.

Signed-off-by: Weisson <hanxiaobupt@bupt.cn>
---
 drivers/block/nbd.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8f10762e90ef..7a462a626306 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -327,8 +327,8 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 		}
 	}
 	nsock->dead = true;
-	nsock->pending = NULL;
-	nsock->sent = 0;
+	if (!nsock->pending)
+		nsock->sent = 0;
 }
 
 static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
@@ -793,8 +793,10 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 	 *
 	 * We must run from pending work function.
 	 * */
-	if (test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
+	if (test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags)) {
+		nbd_mark_nsock_dead(nbd, nsock, 1);
 		return BLK_STS_OK;
+	}
 
 	/* retry on a different socket */
 	dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -826,8 +828,18 @@ static void nbd_pending_cmd_work(struct work_struct *work)
 		if (!nsock->pending)
 			break;
 
+		if (nsock->dead)
+			goto dead;
+
 		/* don't bother timeout handler for partial sending */
 		if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline) {
+			/*
+			 * The socket contains a partially transmitted request
+			 * and cannot be reused for another NBD request.
+			 */
+			nbd_mark_nsock_dead(nbd, nsock, 1);
+			nsock->pending = NULL;
+			nsock->sent = 0;
 			cmd->status = BLK_STS_IOERR;
 			blk_mq_complete_request(req);
 			break;
@@ -840,6 +852,18 @@ static void nbd_pending_cmd_work(struct work_struct *work)
 out:
 	mutex_unlock(&cmd->lock);
 	nbd_config_put(nbd);
+	return;
+
+	/* Complete the request here; nbd_clear_req() will not handle it. */
+dead:
+	nsock->pending = NULL;
+	nsock->sent = 0;
+	mutex_unlock(&nsock->tx_lock);
+	clear_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
+	cmd->status = BLK_STS_IOERR;
+	mutex_unlock(&cmd->lock);
+	blk_mq_complete_request(req);
+	nbd_config_put(nbd);
 }
 
 static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
@@ -1376,6 +1400,10 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 			mutex_unlock(&nsock->tx_lock);
 			continue;
 		}
+		if (nsock->pending) {
+			mutex_unlock(&nsock->tx_lock);
+			continue;
+		}
 		sk_set_memalloc(sock->sk);
 		if (nbd->tag_set.timeout)
 			sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
-- 
2.47.3

