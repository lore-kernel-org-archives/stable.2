Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA644684C
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044214; cv=pass; b=kjDdluF18NVdFtfli38jTRNH3Fj/1nzWN/E/7/Voc/JSNO1DP/SepaX2cKnwA5/f02ztn8z2Rn8JXsFDAyvlY0YVFXwhDxEb5tZzOQxApVeiTE7vRuz6myUjiDSECFihPDDnyQkOz0qNC2v1gOQpesBM96gSLKHOUn3csOCZX0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044214; c=relaxed/simple;
	bh=KDqcjzae9nVDuuJDtCdtJz6dyoaOaU0BnHt9L+A9oO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZay57Jr3ujkfY2L8wYo2z+bNTJL+FQOFs8mJJuPo2JEUS+SbtMNXIv8kYYqTeah8Svkd5UWhjxGzfPF/CQxAyBU/OgfMzdkuT6Rn9ZPu/CRuUV2lANHmPNgYb32kmhQ2YBjbmaUAQWjFVckplwVjiEialV8Bdo1zjc+9YbLC8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPIZrkVV; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPIZrkVV"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cacef7d299so149615ad.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 08:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784044213; cv=none;
        d=google.com; s=arc-20260327;
        b=l9fPXXcy/EuOWt/YuXfHnHlIqHpugzk1QLI4Ch2C96zRqRG0f1NFaZtpVohf2eKU/6
         W2VhYQ7jxOJ+pCvideAO79+Hf+yApRA4TnIBTnRAVT8JzzI1fQUugNgnW+TDDLxpT7nF
         XrNby2FmAun+DrTw1grDfp8eowyP+TuzdoP+nXVn6eNpa0bTC0/rImwLv5+FzelbxCDh
         xS++p7O5Z2pKj9h4Q09g0RjT4Y7+PtVcbhzj/GxM54IUwZYhLEsuAiH9HLg8QASDGKrG
         IdUPJqjWgFUMMvFUZvZ4oBDO7JlGgtReXUQxGarFsMYAj3d1NXClia82SXE9qYdNDgQA
         Xj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/rWyxxEC2/b5ObWMmXsLIqh5IRJ8KXFgT7B0aamk7r4=;
        fh=ZM82UbFblT9i7cYoznJkvfQQOk4tCB8WxN8aiwoyh5E=;
        b=ZiVNF7+QmVhGkfa8loUZJ1EZ3bXlpQd/REnuKuXc68Jb7kqoM3AD5uxLPXKVhlXSXY
         WvBEGTdLt9oxuKRC7/Q500S+NUgjiW5HdrVOzllaq0CgTqTAKhowqO5z0I8V7MlDukzY
         t8v3zYMkSMUVAOeVY87q8rSkFF3ExryLFlp18zYTWyhX5dgi0wHyWHyKA7uQ28XVLNP6
         OSAXkNTCUTUg3OSFlpzqdTPSQSwTXLHqDXWi5fPpbURKnO0oPfWr4aGam9bOLSTnjpT7
         KpT4YD4JiUEFUmF2wZszRaiVNZwev1IGNjpYxpAzqjfdaGJCHluJB29HCyTu/hcpiDvn
         mP6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784044213; x=1784649013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/rWyxxEC2/b5ObWMmXsLIqh5IRJ8KXFgT7B0aamk7r4=;
        b=LPIZrkVVweitYHg5HQmV7YOR+KfRjabnk2I9pKHFSnOiVBdQlYeiOK+rq7sBEb8tH7
         yXOVqFmV9t7F2OFr+cgtSbQVmB1lQq7/mjhT53qlD05L3trlM6sWvnXYGlWzHQmO624e
         2jwMFub6hA7oc/1QgsKqp1HgsG7zZ3Nx1pQSYiCGQApyIVY7N+LwKbfHbW6ELzATpjLW
         w1p2/5yhVDbxMFyYGCoEiwWfLCDeT5IJ/hsTHhtJUy0gFjnz/VAT4H+KrrV/Y1MMgkfQ
         ZM6vgb1azl714J487tO8VM7U5S+hUPVxUFMk5KSWu0FApmnARpcBobIvHfoKb3FbGD/+
         V6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784044213; x=1784649013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rWyxxEC2/b5ObWMmXsLIqh5IRJ8KXFgT7B0aamk7r4=;
        b=MUUHAe7NkCZvfvkJMLjRZmuPFYjRiHI52E1p2+xYqfIsPpaVNzMjPqv8RioSIDE8A2
         5mVOFSCQW+wFy/HYdKlpyqeiqfXZjJEan5r+HBG+O39ELBrF2DU92w4T24nA6sLsXfWC
         VUFwh2QkQ2ZUz0+jCirNOYMcEwn2PyrAiWJ8XwB3Ub5/vHA5+zswalbl5M8uAEZr9Swz
         45wnWMci8t55LQavy7fZRWFHu1CiWwXxrWdseWiyOyTRFMMhUYBiMf5w3R1NckggT0/I
         ZtCGFam2pCI+WJPtqKDewGa28lGIiVyDZGUq12cfwkZUkuTOuxCLLb7YygCzwphNxLrS
         wimQ==
X-Forwarded-Encrypted: i=1; AHgh+RrqLBoUc0UshL6gxrxk/2Flwvq4c5Z8iySeEPZFAdD6tTGiHRNnP+17rcoZg4D+T2KHV9QilNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKAazDwS3pnuN5Rr6CJ/1lJxv1rBYh0o+jCgMmKbw/shoXuggC
	OGxNWWyYoe4GN7fBeKy1Jg445nw7oUkoVN+HVqWq2PRY1mnDh8QiP3zWVpHTAfJ788W95tKZ6M7
	ljothNGdTuo76s6WXlC7cXiVTkSA9+V8KDDNNBunD
X-Gm-Gg: AfdE7cmk3plGNBOYcSSVYSM7yu7wC2gEAO3olNKVuTyxaXARNOX/Lc8mt/gZmKpw4dr
	qKGz2e2R4f5xppx8M6VJ9inwD4ilumllEC91bIMRHxBFWZqEZN9Uk8Ya0fAA1cQcZu7XUo11L5c
	paF80OlA72BCMfx07JDrm3VJzRlyLYZ5zZ6umyvhWca1SCeLHMK5N5ZvGZTNuM2LSozrbovx1Me
	CHomQ2egP9CJRWVsGf3Sb4Dko1MjMPb4d+Yin6gYQ+AKzgHdSLtds67nvxGU00nwMiuE/1wEf1A
	juZTCoo+UNJitiBZD4PyL+Y7F70qotXkMEOFh1QsoSHkyqkYKW99FmBELtY=
X-Received: by 2002:a17:902:f650:b0:2c9:cb98:f4cf with SMTP id
 d9443c01a7336-2cee1c08775mr6155135ad.14.1784044212151; Tue, 14 Jul 2026
 08:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
In-Reply-To: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 14 Jul 2026 17:49:33 +0200
X-Gm-Features: AUfX_myr5_i2q90iqI7qsglK2LEPEh05NbsE2UCogYzQh_lLbQr-oQzJy0sheX0
Message-ID: <CAG48ez2hcn2L2uC8bu_3wqKuX35cpQhmVxuNNdpmdJ_tQvShPQ@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix cred UAF caused by begin_current_label_crit_section()
To: John Johansen <john.johansen@canonical.com>, John Johansen <john@apparmor.net>, 
	Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com, 
	Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: James Morris <jmorris@namei.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 5:39=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> I have a test case where I run aa-disable on a profile while a process
> using that profile is blocked on splice() from a FUSE passthrough file in=
to
> a full pipe; after the profile update, the pipe becomes empty, splice()
> resumes, the credentials go out of sync, and a subsequent getuid() syscal=
l
> results in a KASAN UAF splat.

To test this, you should run a kernel with KASAN.
CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy might also be necessary to trigger a
KASAN warning.

Open two terminals A and B. In terminal A, write the following policy
into /etc/apparmor.d/credbug-test:
```
abi <abi/4.0>,
include <tunables/global>

profile credbug /tmp/credbug {
  /** rwm,
  mount,
  umount,
  capability sys_admin setuid,
}
```
and enable it:
```
user@vm:~$ sudo aa-enforce /tmp/credbug
Setting /tmp/credbug to enforce mode.
Warning: profile credbug represents multiple programs
user@vm:~$
```

In terminal B, build the reproducer and launch it with root privileges:
```
user@vm:~/apparmor-replace-label$ cat > credbug.c
#define _GNU_SOURCE
#include <pthread.h>
#include <assert.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/fsuid.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <linux/fuse.h>

#define SYSCHK(x) ({          \
  typeof(x) __res =3D (x);      \
  if (__res =3D=3D (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

static int p[2];
static int fuse_fd;
static volatile int fuse_ready =3D 0;
static volatile int backing_id =3D -1;
static int last_credref_fd =3D -1;
static int drop_last_credref =3D 0;

static void *splice_thread_fn(void *dummy) {
  int backing_fd =3D SYSCHK(open("/tmp/credbug", O_RDONLY));

  // unshare creds
  setfsuid(1);
  setfsuid(0);

  last_credref_fd =3D SYSCHK(open("/", O_PATH));

  while (!fuse_ready) /*spin*/;
  struct fuse_backing_map backing_arg =3D { .fd =3D backing_fd  };
  backing_id =3D SYSCHK(ioctl(fuse_fd, FUSE_DEV_IOC_BACKING_OPEN, &backing_=
arg));

  int passthrough_fd =3D SYSCHK(open("/tmp/mntfile", O_RDONLY));
  off_t off0 =3D 0;
  // creds are changed in the middle of this
  splice(passthrough_fd, &off0, p[1], NULL, 1, 0);
  close(passthrough_fd);

  SYSCHK(ioctl(fuse_fd, FUSE_DEV_IOC_BACKING_CLOSE, &backing_id));
  drop_last_credref =3D 1;
  while (drop_last_credref) /*spin*/;
  sleep(1);
  getuid();
  return NULL;
}

#define READ(_obj) if (read(fuse_fd, &(_obj), sizeof(_obj)) !=3D
sizeof(_obj)) err(1, "failed to read " #_obj)
#define WRITE(_obj) if (write(fuse_fd, &(_obj), (_obj).h.len) !=3D
(_obj).h.len) err(1, "failed to write " #_obj)
static void *fuse_thread_fn(void *dummy) {
  while (1) {
    struct {
      struct fuse_in_header inh;
      union {
        struct fuse_init_in init_in;
        struct fuse_open_in open_in;
        struct fuse_read_in read_in;
        char pad[10000];
      };
    } buf;
    ssize_t read_res =3D read(fuse_fd, &buf, sizeof(buf));
    if (read_res =3D=3D -1) {
      if (errno =3D=3D ENODEV)
        return NULL;
    }
    assert(read_res >=3D sizeof(buf.inh));
    if (buf.inh.opcode =3D=3D FUSE_INIT) {
      printf("fuse: init\n");
      struct {
        struct fuse_out_header h;
        struct fuse_init_out b;
      } reply =3D {
        .h =3D { .len =3D sizeof(reply), .error =3D 0, .unique =3D buf.inh.=
unique },
        .b =3D {
          .major =3D buf.init_in.major, .minor =3D buf.init_in.minor,
          .max_stack_depth=3D1, .flags=3DFUSE_INIT_EXT, .flags2=3DFUSE_PASS=
THROUGH>>32
        }
      };
      WRITE(reply);
      fuse_ready =3D 1;
    } else if (buf.inh.opcode =3D=3D FUSE_GETATTR) {
      printf("fuse: getattr\n");
      struct {
        struct fuse_out_header h;
        struct fuse_attr_out b;
      } reply =3D {
        .h =3D { .len =3D sizeof(reply), .error =3D 0, .unique =3D buf.inh.=
unique },
        .b =3D {
          .attr_valid =3D FATTR_SIZE | FATTR_MODE,
          .attr =3D {
            .size =3D 0x1,
            .mode =3D 0100777
          }
        }
      };
      WRITE(reply);
    } else if (buf.inh.opcode =3D=3D FUSE_OPEN) {
      printf("fuse: open node 0x%lu\n", (unsigned long)buf.inh.nodeid);
      while (backing_id =3D=3D -1) /*spin*/;
      struct {
        struct fuse_out_header h;
        struct fuse_open_out b;
      } reply =3D {
        .h =3D { .len =3D sizeof(reply), .error =3D 0, .unique =3D buf.inh.=
unique },
        .b =3D { .open_flags =3D FOPEN_PASSTHROUGH, .backing_id =3D backing=
_id }
      };
      WRITE(reply);
    } else {
      printf("FUSE_<%d> unhandled\n", buf.inh.opcode);
      struct {
        struct fuse_out_header h;
      } reply =3D {
        .h =3D { .len =3D sizeof(reply), .error =3D -ENOSYS, .unique =3D
buf.inh.unique },
      };
      WRITE(reply);
    }
  }
}

int main(void) {
  // create a FUSE mount, and handle requests in a thread
  SYSCHK(close(SYSCHK(open("/tmp/mntfile", O_RDONLY|O_CREAT, 0666))));
  fuse_fd =3D SYSCHK(open("/dev/fuse", O_RDWR));
  char mount_data[4096];
  sprintf(mount_data, "fd=3D%d,rootmode=3D0100777,user_id=3D%d,group_id=3D%=
d",
fuse_fd, getuid(), getgid());
  SYSCHK(mount("blah", "/tmp/mntfile", "fuse", MS_NODEV|MS_NOSUID, mount_da=
ta));
  pthread_t fuse_thread;
  pthread_create(&fuse_thread, NULL, fuse_thread_fn, NULL);

  SYSCHK(pipe(p));
  SYSCHK(fcntl(p[1], F_SETPIPE_SZ, 0x1000));
  char buf[0x1000] =3D {};
  SYSCHK(write(p[1], buf, 0x1000));
  pthread_t splice_thread;
  pthread_create(&splice_thread, NULL, splice_thread_fn, NULL);
  getchar();
  read(p[0], buf, 0x1000);

  while (!drop_last_credref) /*spin*/;
  close(last_credref_fd);
  drop_last_credref =3D 0;

  pthread_join(splice_thread, NULL);
  SYSCHK(umount2("/tmp/mntfile", MNT_DETACH));
  pthread_join(fuse_thread, NULL);
}
user@vm:~/apparmor-replace-label$ gcc -o /tmp/credbug credbug.c
user@vm:~/apparmor-replace-label$ sudo /tmp/credbug
fuse: init
fuse: open node 0x1
```

While the reproducer is blocked, use terminal A to disable its profile:
```
user@vm:~$ sudo aa-disable /tmp/credbug
Disabling /tmp/credbug.
user@vm:~$
```

Then hit enter in terminal B to let the reproducer continue:
```

FUSE_<25> unhandled
FUSE_<18> unhandled
user@vm:~/apparmor-replace-label$
```

Now you should see a KASAN UAF splat in dmesg, when getuid() tries
accessing the creds:
```
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in __ia32_sys_getuid+0x3d/0x80
Read of size 8 at addr ffff8881269a8950 by task credbug/696

CPU: 2 UID: 0 PID: 696 Comm: credbug Not tainted
7.2.0-rc3-00038-g3b029c035b34 #55 PREEMPT
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.17.0-debian-1.17.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack+0x21/0x30
 dump_stack_lvl+0x76/0xa0
 print_address_description+0x7b/0x1f0
 print_report+0x5b/0x70
 kasan_report+0x16d/0x1a0
[...]
 __asan_load8+0x98/0xa0
 __ia32_sys_getuid+0x3d/0x80
 x64_sys_call+0x1cc1/0x3030
 do_syscall_64+0xd8/0x380
[...]
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
[...]
 </TASK>

Allocated by task 696:
 kasan_save_track+0x3a/0x70
 kasan_save_alloc_info+0x3c/0x50
 __kasan_slab_alloc+0x4e/0x60
 kmem_cache_alloc_noprof+0x25f/0x570
 prepare_creds+0x2b/0x4d0
 __sys_setfsuid+0x8b/0x190
 __x64_sys_setfsuid+0x1e/0x30
 x64_sys_call+0x955/0x3030
 do_syscall_64+0xd8/0x380
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 70:
 kasan_save_track+0x3a/0x70
 kasan_save_free_info+0x46/0x60
 __kasan_slab_free+0x43/0x70
 kmem_cache_free+0x182/0x500
 put_cred_rcu+0x19e/0x210
 rcu_core+0x877/0xfd0
 rcu_core_si+0x9/0x10
 handle_softirqs+0x19f/0x550
 __irq_exit_rcu+0xab/0x180
 irq_exit_rcu+0x9/0x20
 sysvec_call_function+0x73/0x80
 asm_sysvec_call_function+0x1b/0x20

Last potentially related work creation:
 kasan_save_stack+0x3a/0x60
 kasan_record_aux_stack+0x99/0xb0
 call_rcu+0x51/0x5c0
 __put_cred+0x9a/0xc0
 __fput+0x425/0x540
 fput_close_sync+0x8a/0x140
 __x64_sys_close+0x55/0xe0
 x64_sys_call+0x26ce/0x3030
 do_syscall_64+0xd8/0x380
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff8881269a88c0
 which belongs to the cache cred of size 184
The buggy address is located 144 bytes inside of
 freed 184-byte region [ffff8881269a88c0, ffff8881269a8978)
[...]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```
