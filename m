Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513247013D;
	Thu, 13 Aug 2026 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625239; cv=none; b=ApkSLrYIvF2CjCqGhXn+ejYEkRzCkhQnJMPEyYCNTgsjau7so+8gNW3WJ1Vk3YCNNKIP6YNtmJM2IYqC6bgZQTRP6O/jj3IeQRhr3mm4mgYUroAGc6HoLx86QZwM8ax5sZODNM0ZWmaP4Q/Va/3zQK6c5B4En1Gd1NbXNOqlhjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625239; c=relaxed/simple;
	bh=8kTH94Wcd0bVsOqfvvaM4yEZ3psYoK8Y+qCaQ46vfj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGjJjTdSbueNELhykB8ldLVuZnqs/kJcy5JoxEJtmwRpn0AL4FIUZXuEeBVUMcQNk3PDe6aRPReOh31zPsZRVhVT2OIfQ7GgGJmYz/NBYXuXuL7KcB9cnEMXPBNSO7ZHFFGWixOiww5cvepcp7clFj0nIvdKb6UAxXA3xEgzjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYM6GFxY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYM6GFxY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD72CC2BCF5;
	Thu, 13 Aug 2026 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786625238;
	bh=8kTH94Wcd0bVsOqfvvaM4yEZ3psYoK8Y+qCaQ46vfj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LYM6GFxYIcabDOggYt6z7uzARFMa2MLfF7clbLF/8Engsv7LwOolKd14PQ1s5FzRg
	 ZVFbn4Xnqx80VbQx8AnrsDgn7eo8sVoehfzg8WxUMZkBAL3doafHAEL6Y8zadY85qF
	 draxOaz0YVR2AXEBlrqWokxuDSdhJLgHuugCDacLEhOltdkoMcjc+rAKQMMfS8g42t
	 817xRURIbdnInrSQm5IWsR9+xVIBn0Tza0q0o2xc5RwcrQEtsgjdXygTCIDf/dcIpp
	 t0xVTV0uVEQ2mqbMes1wtGtcRgKSA3nIPny5Pom1YLmScmSilur/qv3PyZGDlXFNdT
	 J2uCuEEdHAJlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81C0C5CFCF;
	Thu, 13 Aug 2026 12:47:18 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Thu, 13 Aug 2026 20:47:16 +0800
Subject: [PATCH 1/2] coresight: etm-perf: don't leak the AUX handle on
 failed resume
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-coresight-fixes-v1-1-7411a73cd496@outlook.com>
References: <20260813-coresight-fixes-v1-0-7411a73cd496@outlook.com>
In-Reply-To: <20260813-coresight-fixes-v1-0-7411a73cd496@outlook.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=yzAo1y/oAIoZDkd9ZQ7K7NSoBvEh92PgMNscnk7BIUA=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrNo9V+NKtQ37yzf+WmV9qneb7rEYSe/27bWH6rlyn
 yRK6apfN+ooZWEQ42KQFVNkOV5w6ZuF7xbdLT5bkmHmsDKBDGHg4hSAiTAcYmS4MtHziTrfiqXJ
 ly/X6ufezZidyXvyp0Y1V+WLORfWMHlcYvin/6D4RNsBvon8Txn9bvx0Fl9S+nZidJHdL/OudTW
 8Ic3MAMzmS7I=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

etm_event_start() shares one error label between the initial start and
the PERF_EF_RESUME path. On the initial start, reaching 'fail' means
perf_aux_output_begin() has not succeeded, so marking the event
PERF_HES_STOPPED is correct. On resume, an AUX transaction opened by the
earlier successful start is still outstanding, and 'goto fail' jumps past
fail_end_stop, which would have ended it.

The following etm_event_stop() returns early on PERF_HES_STOPPED, ahead
of perf_aux_output_end(), coresight_disable_source() and
coresight_disable_path(). This leaks the AUX ring buffer reference and
leaves the sink, the remaining path elements and the trace ID held, so no
later session can use them. ctxt->event_data is cleared just above that
early return, so the leak is silent.

Make resume infallible as pt_event_start() does: leave hw.state alone so
the regular stop path still runs the full teardown. etm_event_resume()
already logs the failure.

Fixes: abffe22e93d7 ("coresight: perf: Support AUX trace pause and resume")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 09b21a711a87..af0295eab143 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -548,8 +548,13 @@ static void etm_event_start(struct perf_event *event, int flags)
 
 	if (flags & PERF_EF_RESUME) {
 		path = etm_event_get_ctxt_path(ctxt);
-		if (etm_event_resume(path) < 0)
-			goto fail;
+		/*
+		 * Don't mark the event stopped on failure: the AUX transaction
+		 * from the initial start is still live and etm_event_stop()
+		 * bails out early on PERF_HES_STOPPED, leaking it and the path.
+		 * etm_event_resume() already reports the error.
+		 */
+		etm_event_resume(path);
 		return;
 	}
 

-- 
2.51.2


