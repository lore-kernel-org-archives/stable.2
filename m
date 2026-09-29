Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C4386567;
	Tue, 29 Sep 2026 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709528; cv=none; b=oTHQHlrdQfVLuVR8A3x1z1psM8TJySade+rw7UaNhikLUQ9EMOr17bXGfQH6LAmkGWAYGisTGKtuWs1voHHQh+2L9i6jKNzNs/9DLUCCBOUBucl9bPy3j/mC/zSAyR0LLIAuItqesvGEys4+pvfVR1RHgRhLnhMVf9skwv0HfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709528; c=relaxed/simple;
	bh=TTMUz9KleTrnJHfh766lM29OOB7HIILlCIv6feiFjy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gixZe22oWGnu7Hv71L2XkP3+3KD+RKughumESqnNa5VB/Xz906QDpxYrkE2QqqdelZvGOuHFnrD45ojRX7Bnngtn4/+I32uUPzVuZJky88mMj/FezURiRDAMtllM45/IyTnXac1f1n7CoqJzD4rDxobCJGTisYIZ9618Ta+lfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X/vneUob; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X/vneUob"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 33D13C0000FF;
	Tue, 29 Sep 2026 12:18:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 33D13C0000FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790709520;
	bh=TTMUz9KleTrnJHfh766lM29OOB7HIILlCIv6feiFjy0=;
	h=From:To:Cc:Subject:Date:From;
	b=X/vneUobHd+zvow7cZ/xMNs8WyL/4eNKooBx4TSgYgLzBW0OH8CBJ+q0626gZKXzy
	 UpksG4hFqASSZAYBuDmb5WoyqlfazExvrXcxPQVyYjzBBGjp5XEpHwDA+NwmH0ZWa0
	 i9/C2yUrOKKHnBErLs0grJmnV/x39BOOj9ORR0og=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id D3F05AEA2;
	Tue, 29 Sep 2026 15:18:38 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH stable 6.1 0/2] perf build warnings fixes
Date: Tue, 29 Sep 2026 12:18:32 -0700
Message-Id: <20260929191834.266354-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

tests/bpf.c: In function 'epoll_pwait_loop':
tests/bpf.c:36:17: error: argument 2 null where non-null expected
[-Werror=nonnull]
   36 |                 epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
      |                 ^~~~~~~~~~~
In file included from tests/bpf.c:5:
../../../../per-package/linux-tools/host/arm-buildroot-linux-gnueabihf/sysroot/usr/include/sys/epoll.h:134:12:
note: in a call to function 'epoll_pwait' declared 'nonnull'
  134 | extern int epoll_pwait (int __epfd, struct epoll_event
*__events,
      |            ^~~~~~~~~~~
cc1: all warnings being treated as errors
In function 'parse_events_term__num',
    inlined from 'parse_events_multi_pmu_add' at
util/parse-events.c:1687:9:
util/parse-events.c:3100:64: error: array subscript 'YYLTYPE[0]' is
partly outside array bounds of 'char[4]' [-Werror=array-bounds]
 3100 |                 .err_term  = loc_term ? loc_term->first_column :
0,
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
util/parse-events.c: In function 'parse_events_multi_pmu_add':
util/parse-events.c:1678:39: note: object 'config' of size 4
 1678 |                                 char *config;
      |                                       ^~~~~~
cc1: all warnings being treated as errors

Arnaldo Carvalho de Melo (1):
  perf test bpf: Address error about non-null argument for epoll_pwait
    2nd arg

Namhyung Kim (1):
  perf tools: Fix a asan issue in parse_events_multi_pmu_add()

 tools/perf/tests/bpf.c         | 3 ++-
 tools/perf/util/parse-events.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1

