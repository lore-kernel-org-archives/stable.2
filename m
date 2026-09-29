Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE263471431;
	Tue, 29 Sep 2026 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709526; cv=none; b=oy3HMJcSx71T8dnTEXklLUsODf7gupt32r8XPO5h/HsqsWzpS0Ptaqg+xnNjqNn4/zUAGEHY24FxZL7e+2jWg/tvL0Bnsj9socl3S0aKEDTcBKRuyO3GBdj8t1q5IbrpqHacB3ceQrHsXPd50YkM7hmjd15/XYMBopk6VEM+EvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709526; c=relaxed/simple;
	bh=og+6EnPPyF7D38dUiFNs3LBY0XDjbRr3SwkpPJeWm0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuanTf1e0juq1/pXy5p1lX7mDXm3b3IkU1bdX9YiC1g0k9R6To3RCULd/xxtVyOG7z3UxXjkVwBj+nq938PeOEGjE7Mh1H4but4HWLwGiSXSIIvQwj3oCpF1GrJGsgUfxfc2pJlY21egxE9NAbwz2sGt9a/zuz/nC/3imc3KDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=v+XX+Ulv; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="v+XX+Ulv"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 78E35C0003D7;
	Tue, 29 Sep 2026 12:18:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 78E35C0003D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790709523;
	bh=og+6EnPPyF7D38dUiFNs3LBY0XDjbRr3SwkpPJeWm0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v+XX+UlvzCafmdvseNVokJqJ0SZdyMQSpXh33eHb1hrMC63p3KQkCnCUSrYfR+u/v
	 LhuCY0U47qUs55lLuyi0bGjS+EZcvsEbuido3eNNM43BmHh/zeOKL9liMERgd0oJ/5
	 DqHU+rTqjVYww4MAxvzxJaOvP+v9/uWcovwKvS9M=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 16A00AEA2;
	Tue, 29 Sep 2026 15:18:42 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH stable 6.1 2/2] perf test bpf: Address error about non-null argument for epoll_pwait 2nd arg
Date: Tue, 29 Sep 2026 12:18:34 -0700
Message-Id: <20260929191834.266354-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929191834.266354-1-florian.fainelli@broadcom.com>
References: <20260929191834.266354-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit ed847e30f001b207013b6136c264454d7560557f upstream

First noticed on Fedora Rawhide:

  tests/bpf.c: In function ‘epoll_pwait_loop’:
  tests/bpf.c:36:17: error: argument 2 null where non-null expected [-Werror=nonnull]
     36 |                 epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
        |                 ^~~~~~~~~~~
  In file included from tests/bpf.c:5:
  /usr/include/sys/epoll.h:134:12: note: in a call to function ‘epoll_pwait’ declared ‘nonnull’
    134 | extern int epoll_pwait (int __epfd, struct epoll_event *__events,
        |            ^~~~~~~~~~~

  [perfbuilder@27cfe44d67ed perf-6.5.0-rc2]$ gcc -v
  Using built-in specs.
  COLLECT_GCC=gcc
  COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/13/lto-wrapper
  OFFLOAD_TARGET_NAMES=nvptx-none
  OFFLOAD_TARGET_DEFAULT=1
  Target: x86_64-redhat-linux
  Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,m2,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-libstdcxx-zoneinfo=/usr/share/zoneinfo --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl=/builddir/build/BUILD/gcc-13.2.1-20230728/obj-x86_64-redhat-linux/isl-install --enable-offload-targets=nvptx-none --without-cuda-driver --enable-offload-defaulted --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux --with-build-config=bootstrap-lto --enable-link-serialization=1
  Thread model: posix
  Supported LTO compression algorithms: zlib zstd
  gcc version 13.2.1 20230728 (Red Hat 13.2.1-1) (GCC)
  [perfbuilder@27cfe44d67ed perf-6.5.0-rc2]$

Just add that argument to address this compiler warning.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/ZMj8+bvN86D0ZKiB@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/perf/tests/bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 6a4235a9cf57..d5bf0e47a48a 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -29,11 +29,12 @@
 
 static int epoll_pwait_loop(void)
 {
+	struct epoll_event events;
 	int i;
 
 	/* Should fail NR_ITERS times */
 	for (i = 0; i < NR_ITERS; i++)
-		epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
+		epoll_pwait(-(i + 1), &events, 0, 0, NULL);
 	return 0;
 }
 
-- 
2.34.1

