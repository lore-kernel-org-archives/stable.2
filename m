Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795432959;
	b=sNQpO6po76nTvBe+kCx6bkSR0dIkbEOb7rHVs2jhqXac8FD4xZTUxftxydaUmQI8sI2+
	 1Rh79EpC+ggS65IHaMOAb32BoNKPJFskMD2jqh5a4thlh/UUdlF88EI/oHOzg7k43Ywde
	 WrlODsaBRcPC4+h5S857aRz7N1lhwfB2d6BsygxVlfhjBQ9IuZmhVIR4gcwO5U5uRKrNn
	 3icp9hfZDTAk7aHOwV8l3am6MnaHpyppCoCczG4s5sDtTKtFi4FvFglDeAcOilfH65nLf
	 rizuoVwHUHPG71XY+faXgUxSjEU2Ql++luDUTA8IZsWl8TriDNoX1Wum+qGYfvE0D5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=B57sPxPIPVjsjDHQj6Icpe8hDfL+4AlWPDMZGCnEF9M=;
	b=2F84TUUK9xxEBtfyqnSgwfggEw8fojsDvze0rhp7dOUiLF79PpEeVUtRICd6tKfTC/D6
	 TtpyhhyQGPxCESyX4ln+X+xjVAgn5wE5e3vprzAqc+41G5o0xF9RyjzTzkRjc7xzHROgx
	 xVRW+RJp3TazL9oWgSLNXqXbq5LbnZS8/IhON5+Srdk2ussPgnsM/+VslXmZO1KXhX4ys
	 qY6tezalSdQoYAdHGvXKGW9w2ll746WpyW58sC4Hx9BIjxmgqkC+wN+2kBiDwOJ9wQcSH
	 69FqLRvYRzjQ9NoQgJmCLHHwbDXwuDSrHONwd82TeK/IGmgVNQH50YA26Vso0a7UZ8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eGiRVnww;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F27606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F27606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eGiRVnww
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67da3d03263so3075252d50.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:22:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795432958; cv=none;
        d=google.com; s=arc-20260327;
        b=FJwdVF88QliTEz8XKZahAJtarDnS3qAUIzaKtlYnXlWu33jYwGHmLv8xKEvHKPkfa3
         W8GNhK/CC6wMQ470DdrKFyKqYT6PiO/CeXNDsYebeTnX3zF6kDP23/MgHeu3j2zqngIA
         CE48/3mG3j641cJ+cfg32KjTsGdqzM9dFqaE76IoATDxmuDocFhsLwOcoaZ5wBgLmitR
         ZfoQvDBMBSL8WHktAfBnlJqFgBbQwAO/A4H0e7v0aQhWRxm9OzD4reCuGN9mnKUYdOU1
         bTNDqO50xoID936V8rR1n61FkU3/WY4ku9earNtuKhqxNz/BJOj3uYI+kdB0UELy+kuv
         1icQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=B57sPxPIPVjsjDHQj6Icpe8hDfL+4AlWPDMZGCnEF9M=;
        fh=EVyGG4fy8olnHlshsGieNOs2vgOZ9DSS2ZbIRcod3yY=;
        b=oM6rAgbefvyezPVwkThtxG0ptGDjiae+DpDr2LohyUvD+1AjvgW9MH7CxcaxkwlWOe
         7e25y/LoCvi/t02CRujZeTJXsttcdbGbEwMCfgXLTp4KMWXB42RyVEDA8g5x4xSzg8nv
         EPqKYptN1xmtD8Gh19S+lGgLogxR8TJpp/PukH7p/x0RYU5hxgZ7udokqfr3V1H7sFrn
         Q4lwOGUi5DijxtaeUrC/8YTiZzCw/PahTyzk0suD0KCOhzI6emJrtq22jB8Mtc+mF0A7
         WlD0YgNI13Vmuxieb7ulHwaks4vW8vIzm5V1yG5NFNKtO+jjcbnWsICEcAEdwaAC2dLn
         ZPAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432958; x=1796037758; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B57sPxPIPVjsjDHQj6Icpe8hDfL+4AlWPDMZGCnEF9M=;
        b=eGiRVnwwUI4V/OQrZ89MDRT/W1O0mp8RPrNpmSFT9FQYCCnLxBi7DrSCum3JyyFnZg
         oCgXknBrSr2p8iOizF/yG649SFYLXqlW10M/B9IDEvUntaCi9R9CLnyEkasCUYaEXEXt
         Ebt1g6RxM5LyzxJ4MbFXlrilHshPYWNmjEuuLJwU+LYQA9MrcGKJt5qmjUvFYKLkD6t8
         18VvM+Q53pukU8B2lgrfQUbuvr3878bzl9A6idCkeQKzOy5BG8SZsd74YKrMkBlA0tiw
         igzIiIYOEj8oMT9n7bM5zr8L/aeuwOQzP+qxXUMDmrgZuDAcjI2UmoZYiBDVwa+im6As
         NBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432958; x=1796037758;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B57sPxPIPVjsjDHQj6Icpe8hDfL+4AlWPDMZGCnEF9M=;
        b=Tp7gpsu+2r5yB7BKlT5fGuBQCLKnVH5waV85/y/GCqqDxKJah4KVYrRIiJzaeOI2lZ
         fE0FSB3iDKg4nOXYbqn/BW28Yh22gZpdmhw4RcmSBTpNioCVO4m5jfLCxaJ8sku8pJlq
         xf39t6UwgTNxXBcCFMUtas1EiT3FCtzJ68oaRkTvQ0hB5Vu/KX7V0fbDaDVL5lO6HucJ
         LCjVrqhf/YLhnrvAjOfa/5UA/NdOxSXYWuFumrGNMlLbTbkQrMhY0vLU74uE1oNoyhu6
         km3IN5wIZMftQS3u2j3z6GatyxHBa96gMZQvrvjxgYiwkhA/IavmrPys8p7OyGx+KUdu
         fLEg==
X-Forwarded-Encrypted: i=1; AL+hErGe6pZ86NmbjHmuTEGkc7QePFLd8y7ntltdx47ihA8wYrX5K5abMRAsyT6pNqWOEfsUSfn0WDw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/41toehBEQkuo4BMFCmJ2rHBSI8PcH2gZeaGD1Af/AJXBBeA3t
	u6HfwrJ4uh12CjlTeZFCLiLBoJUXLkcFfUMrWRm4n3sBNKXnHBTpuNyxejANBTFgaBoywGQwe0w
	W/E4O//SGehWOWRKxqaLyd5v1XESviwA=
X-Gm-Gg: AZFdTZdAWo7NsqPCkkEYmvpVByFhfEXjbbpmqw2Yd0POqluvGifls53Taeat8HsWo3m
	TAkLMyri7gVOlMyTXvbfYXZoqcipiEnzQVmvmH9wbSQdsCv9jtKjX99fwq6gMKIocK2nOd9ez7c
	mH6o+gDcMwcwRrtAZEQIPn6jlUKYs7Pw7xRpJQXYPdOdngubxscsI9AQWyOMBEY/VV5C6+WgVq/
	JbARvY6hs9gkCX1FMYLlQV5OM73MquxKICcdPGkdHO2XxGq6nwcbSNC3PyB0QAazFP3qYJcxcI2
	3sAZdg0AMXncChTUVYujhqC1iLDs+Lee9E6BMFDpKg3AlKTLFYs1PmCH2k9KQYj/fiZ2qnqxvY7
	cmICEQU8gfXWY41dsKzZolByZv3WOFaNlApiLfuydl0TVHweCwRsv/umW+g==
X-Received: by 2002:a05:690e:4394:b0:679:a8f4:afb8 with SMTP id
 956f58d0204a3-67df448279emr1711455d50.114.1795432958436; Mon, 23 Nov 2026
 03:22:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Topaz Tatiana <topaz.tatiana@gmail.com>
Date: Mon, 23 Nov 2026 14:22:27 +0300
X-Gm-Features: Aa3M54o8w0tlGEuwzbq5r6qDt_9jsqgzSy6I_faHZy8D8nkb5JpDzjojE0LeCjA
Message-ID: <CAOhmvYXVox0HKyvf4ypMXnojfSbMmiD43meSvVrhTpDqRjzfGg@mail.gmail.com>
Subject: [REGRESSION] 6.12.117: soft lockup in sched_balance_softirq /
 _nohz_idle_balance on KVM guest without NUMA
To: linux-kernel@vger.kernel.org
Cc: linux-sched@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	vincent.guittot@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all, after upgrading to kernel 6.12.117+deb12-amd64 (Debian), we
are observing
massive soft lockups in the scheduler on a KVM guest. The previous kernel
version worked without any issues.

Environment:
- Virtualization: kvm (QEMU Standard PC)
- NUMA: No NUMA configuration found (Faking a node)
- CPU: 200 vCPUs, 4 sockets, 1 thread per core (see lscpu below)
- uname: Linux dev-kulet2 6.12.117+deb12-amd64 #1 SMP PREEMPT_DYNAMIC
Debian 6.12.117-1~deb12u1 (2026-11-14) x86_64 GNU/Linux
- Cmdline: BOOT_IMAGE=/vmlinuz-6.12.117+deb12-amd64
root=/dev/mapper/vg1-lv--root ro ipv6.disable=1 quiet
- watchdog_thresh: 10
- nohz_full: (null) (NOHZ_FULL is not used)

Symptoms:
CPUs are 99% idle, memory is free (419 GiB free), and load average is low.
However, the kernel watchdog triggers on swapper/N and kworker/N with delays
of 60-97 seconds. The stack traces point directly to the scheduler functions:
sched_balance_softirq, sched_balance_update_blocked_averages, and
_nohz_idle_balance.

Trace 1 (_nohz_idle_balance):
[Mon Nov 23 11:48:17 2026]  _nohz_idle_balance.isra.0+0x31a/0x3c0
[Mon Nov 23 11:48:17 2026]  do_idle+0x31/0x2a0
[Mon Nov 23 11:48:17 2026]  cpu_startup_entry+0x29/0x30
[Mon Nov 23 11:48:17 2026]  start_secondary+0x11e/0x140
[Mon Nov 23 11:48:17 2026]  common_startup_64+0x13e/0x141
[Mon Nov 23 11:48:17 2026]  </TASK>
[Mon Nov 23 11:48:17 2026] watchdog: BUG: soft lockup - CPU#6 stuck
for 50s! [swapper/6:0]
[Mon Nov 23 11:48:17 2026] CPU: 6 UID: 0 PID: 0 Comm: swapper/6
Tainted: G             L     6.12.117+deb12-amd64 #1  Debian
6.12.117-1~deb12u1
[Mon Nov 23 11:48:17 2026] Tainted: [L]=SOFTLOCKUP
[Mon Nov 23 11:48:17 2026] Hardware name: QEMU Standard PC (i440FX +
PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org
04/01/2014
[Mon Nov 23 11:48:17 2026] RIP:
0010:sched_balance_update_blocked_averages+0x62b/0x7b0
[Mon Nov 23 11:48:17 2026] Code: 74 07 c7 41 20 00 00 00 00 45 84 f6
0f 85 b9 00 00 00 48 89 cf e8 65 3b ff ff 48 f7 04 24 00 02 00 00 74
06 fb 0f 1f 44 00 00 <48> 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d e9 7d
28 de 00 80 3d 6d
[Mon Nov 23 11:48:17 2026] RSP: 0018:ff7601b9c00f3df8 EFLAGS: 00000206
[Mon Nov 23 11:48:17 2026] RAX: 0000000000000001 RBX: 0000000000000000
RCX: ff26d7d979bb6040
[Mon Nov 23 11:48:17 2026] RDX: 0000000000000007 RSI: 0000000000000000
RDI: ff26d7d979bb6040
[Mon Nov 23 11:48:17 2026] RBP: ff7601b9c00f3e68 R08: 0000000000000434
R09: 0000000000000003
[Mon Nov 23 11:48:17 2026] R10: 000000000000000a R11: 0000000000000000
R12: 0000000000000000
[Mon Nov 23 11:48:17 2026] R13: ff26d7d979bb6950 R14: 0000000000000001
R15: ff26d7d979bb6a98
[Mon Nov 23 11:48:17 2026] FS:  0000000000000000(0000)
GS:ff26d7d979b00000(0000) knlGS:0000000000000000
[Mon Nov 23 11:48:17 2026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mon Nov 23 11:48:17 2026] CR2: 00007f32c305ce00 CR3: 0000000106884004
CR4: 0000000000771ef0
[Mon Nov 23 11:48:17 2026] PKRU: 55555554
[Mon Nov 23 11:48:17 2026] Call Trace:
[Mon Nov 23 11:48:17 2026]  <TASK>

Trace 2 (sched_balance_update_blocked_averages):
[Mon Nov 23 11:48:17 2026] RIP:
0010:sched_balance_update_blocked_averages+0x62b/0x7b0
[Mon Nov 23 11:48:17 2026] Code: 74 07 c7 41 20 00 00 00 00 45 84 f6
0f 85 b9 00 00 00 48 89 cf e8 65 3b ff ff 48 f7 04 24 00 02 00 00 74
06 fb 0f 1f 44 00 00 <48> 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d e9 7d
28 de 00 80 3d 6d
[Mon Nov 23 11:48:17 2026] RSP: 0018:ff7601b9c0663df8 EFLAGS: 00000206
[Mon Nov 23 11:48:17 2026] RAX: 0000000000000001 RBX: 0000000000000000
RCX: ff26d7d97f2b6040
[Mon Nov 23 11:48:17 2026] RDX: 00000000000000b5 RSI: 0000000000000000
RDI: ff26d7d97f2b6040
[Mon Nov 23 11:48:17 2026] RBP: ff7601b9c0663e68 R08: 0000000000000015
R09: 0000000000000001
[Mon Nov 23 11:48:17 2026] R10: 000000000000b944 R11: 000000000000cef5
R12: 0000000000000000
[Mon Nov 23 11:48:17 2026] R13: ff26d7d97f2b6950 R14: 0000000000000001
R15: ff26d7d97f2b6a98
[Mon Nov 23 11:48:17 2026] FS:  0000000000000000(0000)
GS:ff26d7d97f200000(0000) knlGS:0000000000000000
[Mon Nov 23 11:48:17 2026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mon Nov 23 11:48:17 2026] CR2: 00007f2fca0ccccc CR3: 00000001a8058002
CR4: 0000000000771ef0
[Mon Nov 23 11:48:17 2026] PKRU: 55555554
[Mon Nov 23 11:48:17 2026] Call Trace:
[Mon Nov 23 11:48:17 2026]  <TASK>
[Mon Nov 23 11:48:17 2026]  ? srso_alias_return_thunk+0x5/0xfbef5
[Mon Nov 23 11:48:17 2026]  ? srso_alias_return_thunk+0x5/0xfbef5
[Mon Nov 23 11:48:17 2026]  ? finish_task_switch.isra.0+0x97/0x2f0
[Mon Nov 23 11:48:17 2026]  _nohz_idle_balance.isra.0+0x31a/0x3c0
[Mon Nov 23 11:48:17 2026]  do_idle+0x31/0x2a0
[Mon Nov 23 11:48:17 2026]  cpu_startup_entry+0x29/0x30
[Mon Nov 23 11:48:17 2026]  start_secondary+0x11e/0x140
[Mon Nov 23 11:48:17 2026]  common_startup_64+0x13e/0x141
[Mon Nov 23 11:48:17 2026]  </TASK>
[Mon Nov 23 11:48:17 2026] watchdog: BUG: soft lockup - CPU#6 stuck
for 50s! [swapper/6:0]

CPU Topology (lscpu -e, first 30 lines out of 200):
CPU NODE SOCKET CORE L1d:L1i:L2:L3   ONLINE
  0    0      0    0 0:0:0:0            yes
  1    0      0    1 1:1:1:0            yes
  2    0      0    2 2:2:2:0            yes
  3    0      0    3 3:3:3:0            yes
  4    0      0    4 4:4:4:0            yes
  5    0      0    5 5:5:5:0            yes
  6    0      0    6 6:6:6:0            yes
  7    0      0    7 7:7:7:0            yes
  8    0      0    8 8:8:8:0            yes
  9    0      0    9 9:9:9:0            yes
 10    0      0   10 10:10:10:0         yes
...
149    0      2  149 177:177:177:128    yes
150    0      3  150 192:192:192:192    yes
...
199    0      3  199 241:241:241:192    yes

This looks like a regression in NOHZ idle balancing for large KVM systems
without NUMA. Are there any known fixes for this in the 6.12 stable branch
or mainline?

Best regards, Tatiana Topaz
