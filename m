Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5142125A;
	Fri, 31 Jul 2026 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494261; cv=none; b=bMORoB1h7sDsomLAet14MtSI73YLZXVHNV4NgkAMbOsYQFA1m1BENZfe7jnm8jcKGbQD4YfCsT26wFEeMzF6fWUGuWapn3kjreOeZdnJjwABavTlYlq/UnpyBicmGysE8CAUoDqP/9nFHrq7SiCfk54CNM5kt5I3tVnpT5Ri7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494261; c=relaxed/simple;
	bh=1ENRNZqPXTi+Zd9+e8E9Q4ptr68mQpW6vTXswLen7pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yrly0iYCoxIlLqT12XpCxAkDwR4xUUE8iP+t2GrYTatM8w7ew/9SGYF+NmBcB0+4fkY70aXQg4/Xl2EbYJ51fcbjkbBSEcMmgHX6EfbwJpQzN1azbYJwryseVIWwBIcLveNc43SvYoeC5sikeGqNbxC/t1vWG+HUT0G2kRRqMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bupt.cn; spf=pass smtp.mailfrom=bupt.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bupt.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.cn
X-QQ-mid: zesmtpsz5t1785494171t497212cc
X-QQ-Originating-IP: UNpmxZsAsOd0d37BzO6EmqRJvr6hTvD9x06sUwlu0HA=
Received: from localhost.localdomain ( [59.110.124.154])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 18:36:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3242020096134969728
EX-QQ-RecipientCnt: 10
From: Weisson <hanxiaobupt@bupt.cn>
To: josef@toxicpanda.com,
	axboe@kernel.dk,
	ming.lei@redhat.com
Cc: peiyang_he@smail.nju.edu.cn,
	kwolf@redhat.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Weisson <hanxiaobupt@bupt.cn>
Subject: [PATCH] nbd: fix race between nbd_pending_cmd_work and socket teardown
Date: Fri, 31 Jul 2026 18:35:45 +0800
Message-ID: <AB3B062B219F1F0D+20260731103544.678665-2-hanxiaobupt@bupt.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3B61C69B231FBBB5+d21e6eaa-7979-45e0-b378-d60adaff7295@s
    mail.nju.edu.cn>
References: <3B61C69B231FBBB5+d21e6eaa-7979-45e0-b378-d60adaff7295@s
    mail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bupt.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MOfz9TzWtqad1Pu236abip3ku4UqN1dT+uRr+Rj5IZM7FQ9MkKM2Bgvs
	EnafgfMngZbf4QOgr/oEsOVKH4JuUmt954lUJ7/my3F1kKU9qHRVKTOvAxmurFlZB8rHD8A
	maCfyV6EDm+bBMJq/CqTstUgJD2M5NyIZdJFkYA9jhweHqptT45muWf54ZyWricTSUHak+R
	eJ1fAVB+brPPPeuS3yG04KYMBoocFtZOxtCdnnrrCFcxpMrWiBlfinKn8fZWDJ3qr45ut8b
	9fGyGoNmTh6wDn5jivim0xbow/ZkHyJswOb2j7u7Kjy0JwhhTc4cwGan2Q19bdp449cE4aW
	g4xmm6K8TAfOjVas2VuopMhGEbNPvGrJVIVSSYuEPPBLBswxExxKFfuqjIuAAEw0y1U0mEe
	GK3l4JIJFdZI/WSNSIEZHV24w/13cZvhSg3oEhSMKzFx1k6TagRmVbJo9NNBJ3lTDM0Qmqv
	bwRFOPJfmbeVb3IglV3kCA42q111qpD4ngQ02BWNXR5mRABO3uyuHYNrs9mDbnQSJNFzLx0
	oYhnQyneBF5W98cjehOMo0S7aBxhVHQvNU87gHAHC34IjcEmVoOAakuQ4lU3rM3jvAQJYJw
	+jNOPE0kvIsgOAuMOxKCVEUngoMx3xWHPyobN8OTQ01dnpO3Zp+hS5JI10sA8ojKcikGRCb
	adpuyFuqAHVDaAsJg6M5TItPpbysZyZD+9fjeTCCOlbGACmtbQ/FZmWJ4Sc/GqjS8eSHjUK
	rYZiBNEVz0DVV2pHO3PKvabc57w4ntIpx8VEkf49XdpeWpbvHwXaDxaVRo0zs+UeMu0E6iT
	oa73AlaBbZLYNDD5eJ9/6SYXSxAPGV8mgIeQ12E3phVtWbg69mOIX6ktFfQJsw4zL+JbtrW
	Gfxqzs21GnOD3I7lpmQxm9DCuv+BV4gEY71rAWHdj85pKliUFyjmss8E0Wz9kNxwSMHapPA
	Vv5Od+CFwCWtAc1DjacU5MdRZjiKmIspqKBSyEDz1QDb0oaHMlvoBr52dxwUtikfC+U3Y9v
	xSEdeaZfMS3x52/hpfyOEtvKIbrsUTEaRtfiB5kbHKaB94P3s0jKcRgwPcnfZb/U2iTDXUl
	L9a0aCzy/0Q
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

