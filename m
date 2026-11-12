Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479718;
	b=0/e5TqnPmVIJg3XBsytHKljd2424MD4s7wFyHoInunL+c2XaIKFNU4eoQk7nig51krUB
	 E8aeGtzoYFZRG4w3LMqrCM4D5zRN51nZhTjqB6i1Ixny4DLHQzNKpshe8OOtxQyap++Yb
	 NhcqvMTTKVGcdIcIMefo+6PlBg5YGNonSndYi/MChKzFZzcIuLWaoWQJVX6m/1rdWNkc7
	 VPz3/IzugQDPjz5n2L0bxMs1lfM6NdAnXwl3CMVynPFwKhz8+OIyy7/O4I3D++GoG5dnt
	 WO3WkGrrtMrpKjMDVk5KxE/uIFcYXTcIe/7wXTskz5oacgW5pg0K6WcEzRPaAsRZYVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=WoymvwdfMBFoMyXW+9QTB+Y4rJogi+4Hn0MI83a+cw0=;
	b=y5nstijybk1YktO4hLoHsUZJx+0EgForywk0BiRzvWQO+xHwxcODuZBx2GZhU4NUZwaB
	 3xoWvEIZqaTdL9tjQIHfxCJP8jZvI7mo58uIn2vrsdXrCVBdW73MlAGLOz/IytR5NZGPQ
	 +/lMzad4rf2U7rVZ9ubT3A76H0tzZOWnXv9SZvoNxr8l6V5MeaIN/LZBUCz9v6nBWBSBc
	 lsjP7tiAVxmAmfi5zdgT26SHd6ejWyySTrLuzxgcyF1mVZO+VQo8PKoFZ6xxyVtI3M9n9
	 NVIfCn7bvvdw5z/ZH7Q4cMDikLaeCzVO3IRqRf+LBKtEHQCDfiaJ0TpfLuEYsWisNXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Py+GPyII;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D68606A888
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64D68606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Py+GPyII
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso2017403a91.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794479717; x=1795084517; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WoymvwdfMBFoMyXW+9QTB+Y4rJogi+4Hn0MI83a+cw0=;
        b=Py+GPyIIALmRfft6lVLJ+MEqCiRPwksRRsBO/G8oCeiY/WiQH26z95y2Dl+zHZULvI
         BBtTEPpOeT0CBZsAPsaBeVw4EaOqpmDyPdNYTKJkkSeoX22nKn/VHNCUwqEsCh4X/0hn
         37TJgDrokGzgm1eO9HbHjaV6NhG4uXiicEBwGt4nTO33IcF8jgFlil2gDTNFF6b9mxhY
         1SywYV5OvHvY3oLoqQ3Ciyf6Lch3BRoF/vTiaYNjKPWRdmXRNdVg7aPnQhE8DY1Ta27c
         j/iHTgrduzT2LevDePjXY20iO1embLyQMlm4Gfufu55QA1CVpAtK7Oz2XcoDve+4JMX+
         QkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794479717; x=1795084517;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WoymvwdfMBFoMyXW+9QTB+Y4rJogi+4Hn0MI83a+cw0=;
        b=tPqfYfRmj0WgNmKOxxQ8KscaOsWZ6pqlMsJitlw6dyZmNQKofG9XvNtmRZb5JwgzVp
         PW+JBSRFfk3WIbOq1tef1uu0ZNT5csgDoM7SVPcKjNam1d6jKsOKFBFyDvkR3mPp2UXP
         GmxByhtbl04tSiaDf9tnN9d3t9zrhWMrXz6DfesVHboQ1abAUY1y93OtQ0zJHESqyS+i
         lELQbzFiKnA1HE9VufBmSYtHOLlCxXxnQjESpYR1Dx1YG4buNnwLAeOd6TuQ4Ghi/yHk
         R9V5m+1fO84UhzPkLp7rljQkIE+cjoQlcc5TehHTQpul+TIAPneiUiEnNyYj8Sktr+6u
         jdPQ==
X-Forwarded-Encrypted: i=1; AL+hErGKWNPWuhZjh1mMniEEYt+OSNGQwFhG085UvLVcIzH4GVbGEVHGzE92eODCYPWCvXyIq4jr4LI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BKRLK4A2ViL/Y88gx9Ow5FOxMbpjahqyn7J5MNRcq7j22Hz3I
	6j9K0gpzF1yyj8eFi5sO7GSEgqeVa3fdxM6n59QsLrHwds5DUgMdeIj9
X-Gm-Gg: AYBFou35RoRY6gH8d3WJn41k9wlbdUhE8RE14v1Q8SxMX2VK1pQTg+jBMoK0/XFy16d
	bcys3ndjJEPKaImrSrEhPHLk1QX391r+dnrSUGxl53r6dvqYTDPG/naxLv+bC6ySv7qQa78xGuY
	82fRPGgJufPKD+X8jf3QnIR7VrMKk09gWI74BMTBQxSQBxqS8CcXDqdSJrksDV5T13qrBxmaype
	9A7oqdmmdbLovfJPRsM5k7GA1mScPg2Fqkx6QawugQ+n11t6Qvg7PYZ0gHxQqujqlpiopHPX6Ju
	bWHc09e+kU4BVmvXetbi09wJEb3zaUyzQnrr/07bs3eDaYX+PNi51NedQogPbelAB/1prDxvfeb
	ZNfGJog3zIuOJH40SmyrT0xa9cli2k6iajYWSFfUcbaWBjeTBA7Rs6zhIXwqHOqgYb+JSyXqhLV
	citMyALGuSZnTpj3CjAa8XDerwxXtV4Lm1AiAlQs2qgwp336YRGZklwSuMzaVcgf5bQLKdFImSW
	YOZlRHIIJZm5zOttiBJyo2xarspLs4QZJXqRLAd6B2CO4XUzRYGDBpw3lCBBNjmBm4UmXMvgIY4
	87ejVf/N+8BYTOel7VQwdtzMEW3JtczkvY9zrCCdqUxcTHJjLVMID4btcyszkt+LhFiKNR3UXn+
	Mf3nSpg==
X-Received: by 2002:a17:90b:4c4c:b0:3b0:e2a9:3466 with SMTP id 98e67ed59e1d1-3b182eebe65mr4740116a91.16.1794479716567;
        Thu, 12 Nov 2026 02:35:16 -0800 (PST)
Received: from smtpclient.apple (fs98a57cc9.tkyc008.ap.nuro.jp. [152.165.124.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce49d6sm4207584a91.4.2026.11.12.02.35.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 02:35:16 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v2] mm: memcontrol: Don't lose track of exiting OOM
 victims
From: elenchist <elenchist.dev@gmail.com>
In-Reply-To: <avA1wXhTMs9eY2NF@chrisdown.name>
Date: Thu, 12 Nov 2026 19:34:53 +0900
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Tejun Heo <tj@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Zhan Xusheng <zhanxusheng1024@gmail.com>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 kernel-team@meta.com,
 regressions@lists.linux.dev,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B8E9261-3FF8-441B-8F47-7D35834A8D35@gmail.com>
References: <avA1wXhTMs9eY2NF@chrisdown.name>
To: Chris Down <chris@chrisdown.name>
X-Mailer: Apple Mail (2.3864.700.51.1.1)

On Sun, Nov 08, 2026 at 12:41:37AM -0800, Chris Down wrote:
> memory.events showed oom_kill 2 in three runs. In one of them the =
first
> process hadn't submitted the read yet when it was killed. The slow =
read
> just makes the window easier to hit.

It doesn't need AIO at all.  A plain memcg OOM hits it most of the
time: the victim only spends 10-20ms in exit_mmap(), and if the
allocating task fails a charge again in that window, a second (and
sometimes a third) task gets killed.

Reproducer: memory.max=3D400M, no swap.  A holds 150M, B 100M, C 50M, =
and
T grows by 10M every 0.3s.  Only A should be killed.

---8<--- overkill.c
/* A holds 150M, B 100M, C 50M; T grows by 10M every 0.3s up to 200M.
 * Run inside a memcg with memory.max=3D400M. Only A should be killed. =
*/
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

static char *volatile sink;	/* keep the stores */

static void hold(size_t mb)
{
	sink =3D malloc(mb << 20);
	memset(sink, 1, mb << 20);
}

int main(void)
{
	const char *name[] =3D { "A", "B", "C", "T" };
	size_t mb[] =3D { 150, 100, 50, 0 };
	pid_t pid[4];

	for (int i =3D 0; i < 4; i++) {
		pid[i] =3D fork();
		if (pid[i])
			continue;
		if (mb[i]) {
			hold(mb[i]);
		} else {
			sleep(3);
			for (int j =3D 0; j < 20; j++, usleep(300000))
				hold(10);
		}
		pause();
	}
	sleep(10);
	for (int i =3D 0; i < 4; i++) {
		int st, dead =3D waitpid(pid[i], &st, WNOHANG) =3D=3D =
pid[i];

		printf("%s %s=C2=A5n", name[i],
		       dead && WIFSIGNALED(st) ? "killed" : "alive");
		if (!dead) {
			kill(pid[i], SIGKILL);
			waitpid(pid[i], NULL, 0);
		}
	}
	return 0;
}
---8<--- run.sh
#!/bin/sh
# cgroup v2, no swap, as root: gcc -O2 -o overkill overkill.c; ./run.sh
CG=3D/sys/fs/cgroup/overkill
mkdir $CG && echo 400M > $CG/memory.max || exit 1
sh -c "echo =C2=A5$=C2=A5$ > $CG/cgroup.procs && exec ./overkill"
grep '^oom_kill ' $CG/memory.events
rmdir $CG
---8<---

Over-kill (oom_kill >=3D 2) per 20 runs, ThinkPad X1 Carbon Gen3
(i5-5200U, 8 GB), x86_64.  "4a" is the same layout driven from a
systemd-run scope with Python tasks; "C" is the program above:

  kernel                                      4a      C
  6.8.0-149-generic (Ubuntu)                  0/20    -
  7.0.0-42-generic (Ubuntu)                  19/20   19/20
  v7.4-rc1                                   20/20    -
  v7.4-rc1 + this patch                       0/20    0/20 *
  v7.0 + 60f21a264930 + this patch            2/20    0/20

  * an earlier, longer version of the same program

v2 has the same code as v1, which is what I tested (identical tree
after git am).  On v7.0 the patch also needs CSS_TASK_ITER_WITH_DEAD
from 60f21a264930 ("cgroup, sched_ext: Include exiting tasks in cgroup
iter"); only its cgroup hunks apply there, so that's what I used.  The
2/20 left on that kernel look like a separate issue that mainline has
already fixed.  On v7.0, MGLRU's page table walk in T's reclaim can
hold an mm_users reference on A's mm (get_next_mm() used
mmget_not_zero() until d14514c66cb9 "mm/vmscan: prevent MGLRU reclaim
from pinning address space" in v7.1-rc1).  A's own mmput() is then
not the last one, so A finishes exiting and drops out of the scan
right away, and exit_mmap() runs later from mmput_async() in a
kworker.  The next OOM picks B.  I traced 2 such over-kills in 40
runs; with MGLRU page table walks turned off (lru_gen/enabled =3D
0x0005) I got 0/40.  So a 7.0.y backport probably wants d14514c66cb9
as well; it applies to v7.0 and v6.19 as is.  I haven't built v7.0
with all three.

Zhan's series [1] is a different problem (thread groups migrated after
their leader exited); v7.4-rc1 with it still gave 20/20 here.  The two
patches change the same css_task_iter_start() line, so they will
conflict.

Tested-by: elenchist <elenchist.dev@gmail.com>

Adding the regressions list: a72f73c4dd9b is in v7.0 and was also
backported to 6.19.9.

#regzbot introduced: a72f73c4dd9b
#regzbot title: memcg OOM kills more tasks while the first victim exits
#regzbot fix: mm: memcontrol: Don't lose track of exiting OOM victims

I used an AI coding assistant (Claude Code) to build the kernels, run
the tests, analyse the traces and draft this mail; I have checked the
results and the text.

[1] =
https://lore.kernel.org/linux-mm/20261027144016.2582880-1-zhanxusheng1024@=
gmail.com/

