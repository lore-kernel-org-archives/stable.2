Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807903DDDAF;
	Tue, 29 Sep 2026 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709363; cv=none; b=XSTsd8mkbML2WR8/s+1UPqBMh0lwKBR49ExkrPQJFC89rq/lWk9yKbBjAytCnm+77FEozkxbKaVgxfePfhJMVTUa+8rnWqvHoKZ/SWH122F4pGYBZJcKgrc7U9v1IuwYo2P1skKghh2lJ4tutgRyFoS06y1gBKKxqH0UZBEot9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709363; c=relaxed/simple;
	bh=95WSNh6v7gd037LG3UZCkmCnLzrvo5njLq8n+RwHBCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdtI34H3F0XP5qTDif+N2kkPJhTKM7GpfRPumFMrfJQFlRph7eI21qGqk47fjehv4DEZytibf9aWeo6dZ3f/mM7ouGWhGtDcwEAQVSzQ9bBTP51UQYbKtoAA09k3kLM78DwllFvDv0/+p0k/D0oz626+3gmPK/ZMQoZXooa3tUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=askjZ7wL; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="askjZ7wL"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 84302C0000F0;
	Tue, 29 Sep 2026 12:15:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 84302C0000F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790709355;
	bh=95WSNh6v7gd037LG3UZCkmCnLzrvo5njLq8n+RwHBCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=askjZ7wL0cQLrwLNldTeh7tCGyBwVeMVvemXsjHYqlF7dhKNo/U72ogkbneNNR4/n
	 LQyx5xr0hJB1obgvEd/jUUPzAaOwnmLYbR1fWj6FfMRyBLh5PEJMY953uRG//Q+ps1
	 /Na2kyTGNekKH+28Bk6rBdGe5nCG58V4fFE0fbqU=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id B2F5CAEA3;
	Tue, 29 Sep 2026 15:15:53 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH stable 5.15 1/2] perf tools: Fix a asan issue in parse_events_multi_pmu_add()
Date: Tue, 29 Sep 2026 12:15:40 -0700
Message-Id: <20260929191541.264038-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929191541.264038-1-florian.fainelli@broadcom.com>
References: <20260929191541.264038-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Namhyung Kim <namhyung@kernel.org>

commit 66c9598bd8916c6c1319d0100ac916cac89d4b0e upstream

In the parse_events_multi_pmu_add() it passes the 'config' variable
twice to parse_events_term__num() - one for config and another for
loc_term.  I'm not sure about the second one as it's converted to
YYLTYPE variable.  Asan reports it like below:

  In function ‘parse_events_term__num’,
      inlined from ‘parse_events_multi_pmu_add’ at util/parse-events.c:1602:6:
  util/parse-events.c:2653:64: error: array subscript ‘YYLTYPE[0]’ is partly outside
                                      array bounds of ‘char[8]’ [-Werror=array-bounds]
   2653 |                 .err_term  = loc_term ? loc_term->first_column : 0,
        |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
  util/parse-events.c: In function ‘parse_events_multi_pmu_add’:
  util/parse-events.c:1587:15: note: object ‘config’ of size 8
   1587 |         char *config;
        |               ^~~~~~
  cc1: all warnings being treated as errors

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230331202949.810326-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[florian: Resolve conflict in parse_events_multi_pmu_add() where term
 initialization is located inside the PMU scan loop in 5.15.y]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7e4939640196..f0750b8bf66c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1686,7 +1686,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 					return -1;
 				if (parse_events_term__num(&term,
 						   PARSE_EVENTS__TERM_TYPE_USER,
-						   config, 1, false, &config,
+						   config, 1, false, NULL,
 						   NULL) < 0) {
 					free(list);
 					free(config);
-- 
2.34.1

