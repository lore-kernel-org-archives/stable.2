Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350707;
	b=s9NveToKZ+3ZvGbBL1pUrrb22gwm2jxxnti92ZyNUeQgyx8jx8iRWC+DGJvCjS7/yBdA
	 wD3HBKG8mgp9YtN9kNX9oFSI1XyXIaK2qKmFAiyvdgIg1q9sCEPwUKtPHAGBkbVWSpA/K
	 cI9Gj3DYJJ1wNzQiNtDW9z6VU36m1TP5JDZ+8zGw9ZWip4WLt0CeerC2iah8/XShgLF01
	 zFMQD15uRMeEA9w2bvtlqy9eZZU8daT/SD2D0KLpc0xfKAAgvavx4N8aI5f1l5y7phdCS
	 VTm+DV4wRv418jIxwRcghLomJe1hwdW5MBogJYX7az1BnCT/qCPPKc0mKuy1ZdPdCfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350707;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mzyd4tNe3rkcrTWyyl10Ktx4P97+g/Hj1xHVu73L9Jg=;
	b=qtU8aUt+XA1ap1N2IicTvPYgl9fj/3DqYOBGLepBS1zkvKHKoKZnPmvwNjjCAtMgcGt3
	 zfQ5r3o/W40WWxnhHbfJ6Yvd4uojEYugNxBa7L2sgXCismvvbbbZ7OeneUjQDb9yCRrik
	 SaGvSxsAmG/no3ej63OTJdQj+48ml1QKy/zviH8vGquld33hE5bRvRbOKuKwcn3OLFumw
	 6tjqsoFvPQZPULJ0v+2xTr2KCQNsECfLJ854KeSXLbSP0fg+C1IDM3nc8eh/WoE26aNiH
	 f+JNsVI5pnwWX5kngaCp8lgStJlnNcLe3fS7qab8NqCeloL3isSUe+Nj41WBm6CNQ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IyRwPc8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30B606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IyRwPc8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03371F008A2;
	Tue, 10 Nov 2026 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350706;
	bh=mzyd4tNe3rkcrTWyyl10Ktx4P97+g/Hj1xHVu73L9Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IyRwPc8K8KUSB2KP3nrPAEvuidySpGNQjstJFsSMz7Tvy1zTAVtA/Q6YqwujlD0/Q
	 QE2uXi3izAbFcN1DCE+8If8vnwpvae6o0+cide9mIz7rdkxzG2RZ25d4ohUTM1B5nh
	 MPKToqP/uBeVE+KdDt4YPX0ppoeNTZxLKFfHwqOpe/JJXNhFT+K0TtyXgEn10Lo4bT
	 1T/tAY4y1Y0q1kKxgZq3fWU0VMHjtFgOURGVduUOVEJlv24GMZ8Tfih8S/GUpD5Rrc
	 U+I1L5HR4ScBMnaYmCulh4DDaYExLn3OJusUeBLMYfWG+qOjPFDbzXAMUL9WQc5yon
	 BsAzt9gklLNKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] perf python: Free the parse error entries when parsing fails
Date: Tue, 10 Nov 2026 17:45:04 -0500
Message-ID: <20261110224322.4064226-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051227-failed-6.18-39e0022c89ab@kernel.org>
References: <20261107051227-failed-6.18-39e0022c89ab@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 39e0022c89abcdc1a811dfc0aeec2a2b9010b660 ]

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
[ sashal: adjusted context for a stack-allocated event list using evlist__exit() instead of evlist__put() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/python.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index a65a4d9f8cc83..2fa9670bc51f0 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2075,9 +2075,11 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 	evlist__init(&evlist, cpus, threads);
 	if (parse_events(&evlist, input, &err)) {
 		parse_events_error__print(&err, input);
+		parse_events_error__exit(&err);
 		PyErr_SetFromErrno(PyExc_OSError);
 		return NULL;
 	}
+	parse_events_error__exit(&err);
 	result = pyrf_evlist__from_evlist(&evlist);
 	evlist__exit(&evlist);
 	return result;
-- 
2.53.0

