Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046349;
	b=nspX7TdeEfzUaAvgRbPejR6Cl/c2vBp90d09amGJOfl6p7nc6CU/OMWYyOxCFooPiQK1
	 VtP4C3bETza0iTUZyGMrp1g6+cffMg4pX5JI0AXaKFA/XzbZ3ukCr3ZVmw56vypjMi/E6
	 eCiMBs+kIjUxw+aMlGIe+bepK3eQ1ZRXXXOzW8jjgjwxWq5pvvAsSV3ZZHuF1mb9EG3uT
	 As6Jd/nme8UM91F+FuEp79cFwbbymUtsw6UmF2ncqZ45B3t3hmldzECV4tzviUb+5rLeS
	 ztjHVt2jJ65EyLPSRq0YDInSn3lQzxHW7gNjE+NdD9rb00KWKkLWiFvM7BHRy+aIy1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046349;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m9yXNcxBiUlaCiVb1sND3cBRzbHBmxXfcuSEdNNP3Uw=;
	b=NjhNyYW8EVikh26/nEas45HL1ZQ536NhSrc2cpUz+JH6tygupBvoFSkfQriUOjCNWQ1d
	 JwpAi1Rj+0hXwTAnJ8pfQrCT2DQFcGFGCEQISqKgCvvbdGqKV2BVkB9aE68nsi3QWRzlh
	 Czr6YWNVKay5nW/+8g0BPrnMJjBr+6o2pOBIl/U2nyD/9KlbRnh8PNYNXSi/bVQhH+axu
	 UV7iuz70LgqGfEHBcNnDR4usYlwuwTB+erNWaZ8IQFc0k6re4iMImNwrgvRbA9n9JgghO
	 QtMB2NpWrVgdeZdtFVizQOniNXYxBSeWAWq9v0RxxPN4D4V21XY86gPPVn351NVBb2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLrGhNBf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLrGhNBf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91351F008A1;
	Sat,  7 Nov 2026 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046349;
	bh=m9yXNcxBiUlaCiVb1sND3cBRzbHBmxXfcuSEdNNP3Uw=;
	h=From:To:Cc:Subject:Date;
	b=GLrGhNBfhYiqtEnWTXJi04FkYaGv0jtWTe24rQtRSoJx1WGFifig+It2sd9waBSUu
	 VtzKk05iOSHycEg75t4XBbPlp8dj/XxyfygakvA9eViTkaHJWvd/aA6pt2lsbiaS9/
	 SqoHE4soCuXe+GnDnUZ6LhvwrQnNAiTLAwWsHeIU2zVU6ze6hLFtCwKdxJ8ySP2UyJ
	 e9mnczXjKud1vKRoC5ThDqH6kqVKCad6FNUE9bcp1WaqZJ2V1IDw2J9Qc61eVedB3z
	 Axe/f9BpNwmuED3yf6G3QugThADKXD1sk0CFC9f/Xr4hug8DA43c64MIw2heUA0D7S
	 3PC+xbZ8EcQGw==
From: Sasha Levin <sashal@kernel.org>
To: acme@redhat.com,
	sashiko-bot@kernel.org,
	irogers@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] perf python: Free the parse error entries when parsing fails" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:12:27 -0500
Message-ID: <20261107051227-failed-6.18-39e0022c89ab@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 39e0022c89abcdc1a811dfc0aeec2a2b9010b660
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051227-failed-6.18-39e0022c89ab@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 39e0022c89abcdc1a811dfc0aeec2a2b9010b660 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 15 Oct 2026 22:06:19 -0300
Subject: [PATCH] perf python: Free the parse error entries when parsing fails

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
Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4eb17bdc5fd12..60dbe2dad5eb8 100644
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
2.53.0




