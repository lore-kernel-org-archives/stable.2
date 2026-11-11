Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392189;
	b=Z8+z+3Von9n7lEV+dOqiEFvvr1fDfDqemhB581Wes0bnra3NzMmN8DvRCtxUF89N2T7y
	 ao4d0YmKcmcYO2xtimBqjn7mc3GnSN7UkSADlsTY5LrlhMMgq2Wwbu1Ip+tyFn0xyw1jZ
	 h/rKPgcZvXGitHdsyGXGEZtysOGS2FBjAQf6Rrnhdf1d70u/gJhxLItQGXrktf1IAR2lO
	 xqb7QoPkTo71vo7uQ5rDrktlYp2MLlmBGo0wB65FVPyBnIq82pH3EE1edDxne+3W1kh8h
	 dtIQFypo+DYEjkZ/FfJ3B4bEHkYlSE2NMPPnctBpNVCb+XBbEDdld98eknavzfKCpSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d/IvGYdSU0x2hRQxBE1JjbZsWM2RLe7/sTpyhUbllAo=;
	b=bxXHy0hlD0vfanXS2uv56/NkJlHaS4lnaAghV+Lnoexka1yQ8b6pWSfFUPThYnLuQ57H
	 JOAHgQD5v/L7qaZcPXqq+taXkSkHOAp7tsYCqCnyu0FobT22+/Qic3qDH8l1AKgvzTKHV
	 o3XWJraULqoFsv7ggeVpXzLDhKT45eBqI/MYz5HUl/pJYyQkAdEGAfkKdSdwJiaICtOfH
	 GIblL6nBmer7O++EWBRX9Vzaw7GHVQYIEg4GK8LiNiSOEmlfHvlcozSoMU6bD3m32gg5D
	 Cfm7EsojYKiAyiP0rDbOo1eI2E+WdS6zK56zfppjKqzyzeqfh/qXYXS54D1EKLFLO6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zu6x9jvf;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355ED606A881
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 355ED606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zu6x9jvf
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14394530ec6so3844356c88.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794392188; x=1794996988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d/IvGYdSU0x2hRQxBE1JjbZsWM2RLe7/sTpyhUbllAo=;
        b=zu6x9jvf/Y3EYKErT5IhySBfSvma7bgcPl3N8bj7rO1deIOsdjwDsOzNRTj7JUAVRw
         n3pJKYeNcD7xkEej0G+uil1L/QZZS7fW/8pCweCtJlfM6AwhR0WGB1GQnlNPrCjhDZG6
         TopgFcf2SwZyMir0eFewYeUjTgZGxmbxCKnVB4y9/SDyW/KAzC0yiD2fd8CrM1+y6NIt
         ezQnXbTySqtaWSCtYf8EnHmqNse/A20j3OBaOw6OJ50ayWpw0VpUJMlUdRUFSBEnaasH
         AHCyiIr+8ZK+vb2xKhs/PUrZXDc1l6FJqIBOg62Qe4QJfX1LVrIHoKFTNiOrahtEaHzx
         9Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794392188; x=1794996988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d/IvGYdSU0x2hRQxBE1JjbZsWM2RLe7/sTpyhUbllAo=;
        b=NCtYS+Zg6mKONVZ+GFeaf6fcuaUGon0xN5psD95CCccVfg/sX2A6HsCQRkihOp5r0E
         Wprv1LwgZJH5YeD0y6HSo6CNhE1k4fwUJsed87tz6wEm9NoVXZuIu5Jf1Riir4W0RFpg
         Ba7VddBIGz1k/05CXKUxKi8/UFKvw/MRk678cfo5/MhpCxcB1A+9ul12o4NzrK1mnADK
         /93Yi4JKMH+UHdAjSbZVDB1TpqtxkDEoLy9ddhIHXj3xAogsY6tSdzDYoV4JG/czaLIW
         XIjEteghMKoX9GmqRchVLgvGXG3rxg1+k8XVfpX49ShB7H3uucbgf30Ov3Z0s5cS2IaC
         pKlA==
X-Forwarded-Encrypted: i=1; AL+hErHBo7njrHy7XY2vitv6Nk08bHpD02VJL1uKn+EN/zpMf/TdE937MmafJ2judu0FJ65Zasod5U8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+kajzIINxRkA1dkmH1RHmj73UL8d6wUl5EbiDsARoYtDCM/i9
	tCe67feFZ1wGufcgbdmBYLg3V+7V1zNDbt2Y+tTL1KJblLcA5YquWBMN
X-Gm-Gg: AYBFou1MhkbR7pMIf9EzU3KGvLAavMR0yU91f/287TatluPvzP1jztcoQng01lkfWaN
	fdgMlQ/tDC4lo8exTOY4XbWsKGXcjfR8macvwzK35EjEAL7QEGZQTqo2Ydnj0VZy5vUjjLit4gJ
	ntOqZ8Al9JoIQW7ST4nEo8+QYbOYXBq9wZ+aV7RtAaWw1rtwOBLt8n3dMGX+eV6faTp3B5WKEsS
	A0N2b7zR+SZdD42mei1Ve1hO58Jfh2skhM6zJk6gmZfhjg4vZkrae56zbWaRr3pL+mHnEiYKxMa
	oY81z6YGdUmWIv8pw50e4zARYowkC3UsF39rRAaQYsbVyKjcdrXld1QpubI0lAQpyopABAnhGfV
	FNokxhufyHt88rJX3W8FgsunONVbTbbk55/bLROLXQPmi1KWh0NgFwyG/xsqlikcugrFe6AtcmN
	ekRSrloiKn6Tgnhd1lbVerCesnI58/zfFmBqjo3ll0vWZrHBLpzARAp7WvIGL32lkOen7QuKzW5
	igPdrkz4A3M4klw+O9qf9zp92piCXXSqi66eY1RP8oefC6Yisduh0KglZQaU/oO1zzRlEb5hFK2
	Q5NCwDHukIKj5C69ksDq
X-Received: by 2002:a05:701b:2219:b0:18d:9eec:e0be with SMTP id a92af1059eb24-1b3c023e33cmr1755383c88.2.1794392188110;
        Wed, 11 Nov 2026 02:16:28 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc14sm14134634c88.12.2026.11.11.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:16:27 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2] libperf: Handle an evsel without an fd array in enable/disable
Date: Wed, 11 Nov 2026 10:16:24 +0000
Message-ID: <20261111101625.2204836-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023085629.1694941-1-takano32@gmail.com>
References: <20261023085629.1694941-1-takano32@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A group led by a tool PMU event is opened with the members' group_fd set
to the leader's file descriptor.  For a tool event that descriptor comes
from open("/proc/stat"), not from perf_event_open(), so a member the
kernel refuses is marked unsupported; perf stat then releases the fd
array of that member while the evsel stays in the group.

Enabling the group goes through evsel__enable_cpu(), which enables the
members of a mixed PMU group from userspace because the kernel does not
do it along with the leader.  The member has no fd array left, so
perf_evsel__run_ioctl() reads its loop bound through xyarray__max_y()
and dereferences a NULL pointer:

  $ perf stat -a -e '{user_time,cycles}' -- sleep 0.05
  Segmentation fault

Guard the array in both places: FD() returns NULL when it is absent,
which perf_evsel__ioctl() and perf_evsel__read() already test for, and
xyarray__max_x()/max_y() return 0, so the enable and disable paths that
walk the array become no-ops; perf_evsel__ioctl() returns -1 for such an
evsel, as it already does for a closed fd.  The FD() guard alone is not
enough because that loop bound is read first; measured on the same tree,
rc=139 with the FD() change only and rc=0 with both.

Verified on an arm64 KVM guest (Neoverse-N1) with a perf built from this
tree.  '{user_time,cycles}' and '{system_time,cycles}' segfault on the
unpatched tree (rc=139) and exit 0 here, reporting user_time (resp.
system_time) and a '<not supported> cycles:u' line.  Real-PMU groups
such as '{cycles,instructions}', 'perf stat' with no event and '-r 2'
print identical output on both trees, and 'perf test -v 10' passes the
same 78 subtests.  The libperf tests report the same five test-evlist
failures on both trees: the events cannot be opened by this user
(perf_event_paranoid=4), and two cases cannot read the syscall tracepoint
id because /sys/kernel/debug is mounted root-only.

The events are still not counted: a member the kernel refused stays
unsupported.  Hang Zhengyang's follow-up opens these members with
group_fd = -1 so that they are counted.

Written with Hermes Agent, an LLM assistant, which made the change and
wrote this changelog.  I built perf with it, reproduced the segfault on
the unpatched tree and confirmed it is gone with the patch, and ran
'perf test' and the libperf tests on this box.

Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect enable/disable")
Link: https://lore.kernel.org/avQIOtt7Y67oXQem@z2
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: follow Namhyung's suggestion and fix it in libperf instead of
    skipping the members in tools/perf/util/evsel.c. The FD() guard
    alone leaves the crash in place, because the loop bound is read
    from the same NULL array through xyarray__max_y(), so the
    xyarray accessors get a NULL check as well. Measured on the same
    box with the FD() guard only: rc=139, with both: rc=0.

 tools/lib/perf/evsel.c                    | 3 ++-
 tools/lib/perf/include/internal/xyarray.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index f747c0bc692d..e23df3b2c1f1 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -57,7 +57,8 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 }
 
 #define FD(_evsel, _cpu_map_idx, _thread)				\
-	((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread))
+	(_evsel->fd ? (int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread) \
+		     : NULL)
 #define MMAP(_evsel, _cpu_map_idx, _thread)				\
 	(_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evsel->mmap, _cpu_map_idx, _thread)) \
 		      : NULL)
diff --git a/tools/lib/perf/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
index f10af3da7b21..8bf76c12984e 100644
--- a/tools/lib/perf/include/internal/xyarray.h
+++ b/tools/lib/perf/include/internal/xyarray.h
@@ -32,12 +32,12 @@ static inline void *xyarray__entry(struct xyarray *xy, size_t x, size_t y)
 
 static inline int xyarray__max_y(struct xyarray *xy)
 {
-	return xy->max_y;
+	return xy ? xy->max_y : 0;
 }
 
 static inline int xyarray__max_x(struct xyarray *xy)
 {
-	return xy->max_x;
+	return xy ? xy->max_x : 0;
 }
 
 #endif /* __LIBPERF_INTERNAL_XYARRAY_H */

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

