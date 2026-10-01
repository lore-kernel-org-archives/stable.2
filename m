Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21323C585A;
	Thu,  1 Oct 2026 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870832; cv=none; b=u/80CVRvM0XHZDHAFwejNrT2e1NkHglmDh6hN3LbThVj4QQ37l3LWPLnPPwtDgEDNDzuvumc+tcDFP2qj7Ta2E3NrqF8xbUT6ktUjQs8u3F0Iv+mcr2r4q2TFd+dp8CT0kdB3V0jeedeNiUXpmbktkkG9Wm84KwBPJI95DW60ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870832; c=relaxed/simple;
	bh=JHXmEBPC91NqS7XnaNPZKJB6Bn5njdxpOgsI+Ku/JEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qlw/Sx/tsrosjAaLOxWFJFq9pQIcjAhb1Vkux4A+gocRqOLTEQ0UgIs51Jctn27KqTRqbbRWRpzda9yFFFSubeD12wcpRtLSiLTq0KgrXjQjCgWFpDUcy+g5Se8M5NXy2VPEFP9kp4SHArYdoiHKZX7UVu3oqcfTsJjsRm2SBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HDpSTHgh; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HDpSTHgh"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C4E75C0000ED;
	Thu,  1 Oct 2026 09:01:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C4E75C0000ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790870480;
	bh=JHXmEBPC91NqS7XnaNPZKJB6Bn5njdxpOgsI+Ku/JEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDpSTHghRgzbiaBueJUNh8wyze67GxZpsvSz0KY2oVJCLE4sn1a3oW0g6A49pTVtu
	 ypFy2UTs+XDVw6D7uC4KLIBrRKjAq52z6Nct3s3vt/OCkVWN6LUfwpDonZbCeyItCV
	 ooS4m3FgvF2ggtu32mdJ1GpseQbEWomJL3FbS0mo=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id F3842AEA3;
	Thu,  1 Oct 2026 12:01:18 -0400 (EDT)
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
	Jan Polensky <japo@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH stable 5.10 1/2] perf tools: Fix a asan issue in parse_events_multi_pmu_add()
Date: Thu,  1 Oct 2026 09:01:13 -0700
Message-Id: <20261001160114.801948-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001160114.801948-1-florian.fainelli@broadcom.com>
References: <20261001160114.801948-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Namhyung Kim <namhyung@kernel.org>

commit 66c9598bd8916c6c1319d0100ac916cac89d4b0e upstream.

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
 initialization is located inside the PMU scan loop in 5.10.y]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c56a4d9c3be9..28a4588c1808 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1593,7 +1593,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
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

