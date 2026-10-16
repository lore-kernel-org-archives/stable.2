Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF273AB47A;
	Fri, 16 Oct 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185678; cv=none; b=hh47gkBuPrjRsMG4+vnTYcBDBerd6IRA2qMcGUzjOYDrwasefTLxF8al5HzOHcTMKafis9TJVhBBaEFVd0VcmlWE9gii8sS5v2lxL2b+mQg0Wwq8hCaEIYrQV3f+zO5Aqcot6VbsuIhM4J5L3P+mvS+0ge9Hac0fK4ydBVY0Wbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185678; c=relaxed/simple;
	bh=VNFzsQucjROEmM8sqMJSi0+AW8nsSQAFbUVvfqMTBo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVHAVc73/jnHsX7cEYDv111uCaId1n/6M+ZVsMbZtR+OUfqdN4uuzFn+5Xzlnf5pLqEYzvI0KXCXFmH1zaxvVqWTc93e6KuBf20j7/Bs97Jy8JgeGVbupquQaO2T9qqMauA9NeJxIJvj8jUi6DD9JVXHUEZDRom8XLg+DBzoEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3v8LD3H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3v8LD3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30A81F000C4;
	Fri, 16 Oct 2026 21:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185676;
	bh=83UvaJHWn9SgCKKxEJYI+y3uxE9NOIxoNSGE/sao7Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c3v8LD3HrjHVw4DPbCBNUS2VBaCgz1aEIh/HfyQZHnGKFADzmOsSZwi1tGWW6i8dL
	 rkpoTdQs95kQIuT4iAc2TxL0115A/iCUFkfoqCd2G+j6ZiYt6l6zQ4ED21xCBrK+xY
	 oXl0SM2f3p+JHCyiLXPyNRz3PzNt2V1XIoFsNs6aN1qLTvZEGdKIrS1RF0qAf5SWon
	 GBM/64aKaAMWCZ6l0aGWXMMoyVoCVyY/4SXnD1RDem8Q0GUOtDhEA3A/8Gdlw4uG6W
	 9S2O/o0bVIYEPBU0Ri1OEa9XUcWpVnqHickvxJMIhlJsi+l/BE7417LjelD7+tT5Xn
	 jzMGHc0Ftbm8w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 02/21] perf python: Free the parse error entries when parsing fails
Date: Fri, 16 Oct 2026 18:20:43 -0300
Message-ID: <20261016212102.76550-3-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016212102.76550-1-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

pyrf__parse_events() prints the entries parse_events_error__print()
receives with the details of a failed parse, but returns without freeing
them, leaking whatever parse_events_error__handle() allocated, so call
parse_events_error__exit() on both paths, as the other parse_events()
callers do.

The perf test attr core PMU probe takes this failure path on machines
without a core PMU, where the leak then happens on every test run.

Fixes: f081defccd93 ("perf python: Add parse_events function")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-173525@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4eb17bdc5fd1231a..60dbe2dad5eb8073 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3824,10 +3824,12 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
 	if (parse_events(evlist, input, &err)) {
 		parse_events_error__print(&err, input);
+		parse_events_error__exit(&err);
 		PyErr_SetFromErrno(PyExc_OSError);
 		evlist__put(evlist);
 		return NULL;
 	}
+	parse_events_error__exit(&err);
 	result = pyrf_evlist__from_evlist(evlist);
 	evlist__put(evlist);
 	return result;
-- 
2.55.0

