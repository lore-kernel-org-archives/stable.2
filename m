Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35044330B22;
	Thu, 18 Jun 2026 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779911; cv=none; b=UFMPk2q8Z0ikjPWLZph0lOfa5mnByU4+3HeZlzvrNl+TguMRAHTXI5Edr152W3sFbVnLbPFgp3xBG9nud5issa3y1B7/WgaoVo/vYgef5k1MEE5hsLLJuC/e24QlYCOLhZg62qX+Cjtf8DVcDeWpiRcf9GYNlgFWKd9DMb0no2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779911; c=relaxed/simple;
	bh=B40VaEU65JwSYa7gOXvsSdUFzIVvMvqwMZdEw1ZcIV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bjnd96a6/DhgQJZ8oYDza8vODtSG5lT4sABKzBcsxo9Td0UfhYZSq0kG4pdNpuz+jl1aN4FV1iC5fuAAK+pMnRUwoVlBD12eSGWoBNdLllZw0S1JgTXTmC+dhHq+yRof31YnSFi89C6kyfSZD9Tj1z/PKwNloK4Hs1n15l3iMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cmCMRFNd; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cmCMRFNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PK
	KpVdrDqnA2ZI2QQYb9QpGJK08L53pkl9uf3Eglr+E=; b=cmCMRFNd+IkDsfzEhs
	h+RIUGGnycRzk0cu4wibkNk9qammMeqETKS5uTgrVvoBuJeIx7jtxGlTrY7zv1JA
	qlszwOQFljZRksEDoqhdtg6AIi5m3J3IVj8jPZB1xGjhssG1vJSnMz/JEmEpNxnZ
	EzHBy6TQ/wLJIrHxWjbY4HV7Y=
Received: from ubuntu.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3mfCLzTNqYkSUCg--.3697S4;
	Thu, 18 Jun 2026 18:50:59 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@linaro.org,
	leo.yan@arm.com,
	alexander.shishkin@linux.intel.com,
	mathieu.poirier@linaro.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH v3] coresight: etm-perf: Fix reference count 
Date: Thu, 18 Jun 2026 18:50:49 +0800
Message-ID: <20260618105049.2495009-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3mfCLzTNqYkSUCg--.3697S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4UAr17uF43tr4kJF48Crg_yoW8ZFyrpF
	4jkws0yF98Gr40vws7Jr18Zay5uw4SvF4agFyfKw4DuF4YqFWfZFyjgryFyrn3urZ5Gas0
	g3WxtF48uFWUXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUhL8UUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC1BP+CmozzZO9YQAA3o

bus_find_device() returns a device with its reference count
incremented. When a user-selected sink is obtained through
coresight_get_sink_by_id(), etm_setup_aux() keeps using the returned
sink while building the path and allocating the sink buffer.

Therefore the lookup reference must remain valid while etm_setup_aux()
is still using the sink, otherwise the sink could be removed under the
caller. Drop the lookup reference on the common exit path, after
etm_setup_aux() no longer directly uses the user-selected sink.

The CoreSight path code takes the references it needs for built paths,
so the initial lookup reference from coresight_get_sink_by_id() is no
longer needed after setup_aux finishes.

Found by code review.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Cc: stable@vger.kernel.org
Fixes: 0e6c20517596 ("coresight: etm-perf: Allow an event to use different sinks")
---
Changes in v3:
- do not drop the lookup reference in coresight_get_sink_by_id(), as 
that would return a sink pointer without keeping the device reference 
while etm_setup_aux() is still using it.
- dropped the lookup reference in etm_setup_aux on the common exit path, 
as suggested by Suzuki.
- updated the commit message to describe why the reference is kept 
until etm_setup_aux() finishes using the sink.
Changes in v2:
- modified the patch as suggestions.
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f85dedf89a3f..d5116177c1b9 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -456,6 +456,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		goto err;
 
 out:
+	if (user_sink) {
+		put_device(&user_sink->dev);
+		user_sink = NULL;
+	}
+
 	return event_data;
 
 err:
-- 
2.43.0

