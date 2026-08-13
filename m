Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508646F4AE;
	Thu, 13 Aug 2026 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625239; cv=none; b=psCIAPDFV07A2zEiSWq/Lrln80ZY4OqbmbAJz+FAXkYus30Ccc8eoKr4heYdz0028cTEybzPe0OCWyihg0p+YhZKXuZyhXKYMdy+NaVOH/tKI3kzTa1or/cAzkRBTDTnx1MpivNSZU7UuijPtSohQhvBghTVUZeLENdHuYzMA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625239; c=relaxed/simple;
	bh=n7IVb6P0SS6aP6osC/nBykNSX6nP62U+SXlK9oPNqXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DklOOfPp1CeEiEvdJSwnwdd6Gx/PhLNcz1Dc5SUoxtsmAmUYWTk+eUC4IKU2Y/OKeIH1StDXs2YHK3MB9pQC1zLe/6OBG2bG5OrPp62McyPA2lQGMC1FX608BUBkLO+/GGS0kVy/uSv8byYaPGksUnuCEoQJDyT3L1D8M+pAvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkIJT07G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkIJT07G"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3CF9C2BCF7;
	Thu, 13 Aug 2026 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786625238;
	bh=n7IVb6P0SS6aP6osC/nBykNSX6nP62U+SXlK9oPNqXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YkIJT07Gng0CI7nmRkmGQZuDRu4wHmBhshprD3U8G5gtdniuae4HLQGPDoU7Gm5gw
	 N5auJIU7ASJ/fJd8jkmnH9SmDPJO67Pd0onSe5qmb2ETWwKO51axE0ZI3Isma3xiHx
	 AvJUrdczqxetXHNPvlArn4R+XCRUX1i0/vkAffgAhPx5cv74HR88U3Nd3NepQr9/I8
	 WXcXxrsvd5gBJhb5/HhgvRYXiQziIHwhrAsO4mQKXQMeO8VZi3Yvhs0ud/YDZsmxRO
	 QwDeGMcRC7uvLMMiC0F9VjLvUMwXpTCJhBo7cpKLA2MCSK88NVXlvX45aTRfV1nH2W
	 c0V12JSyYir/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B40C5DF66;
	Thu, 13 Aug 2026 12:47:18 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Thu, 13 Aug 2026 20:47:17 +0800
Subject: [PATCH 2/2] coresight: etm-perf: reject events that exclude both
 kernel and user space
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-coresight-fixes-v1-2-7411a73cd496@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2362;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=+tTlNVRe/rbkdxYJBnqH+Npz+BDYLaVAW6dG0DYxOHA=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrNo9V/8qvdfao3WvtOtYdOAkb6uwnkvsZyatrJ4vd
 rCYbatm74yOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmIhJECPDgc9vbmQpNtmJ
 XTD+v6jq2sPba0Imm7hN2/zNkvN825NyVoZ/RjNW9jxpMdl84rbL75Dmz9v09B4ufSz9eJNcXlz
 q3EcmTAC2ok/O
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

etm_event_init() validates only attr.type, so a cs_etm event can be
opened with both attr.exclude_kernel and attr.exclude_user set. Both
config parsers assign rather than OR the mode bits, so
ETM_MODE_EXCL_KERN is discarded and only ETM_MODE_EXCL_USER survives.
A request to exclude the kernel therefore programs the tracer to
exclude user space and trace the kernel instead.

config->mode has several downstream consumers -- on ETMv4 the TRCVICTLR
ViewInst filter and the FEAT_TRF controls that exist to backstop it, on
ETMv3 the address comparator access type -- and they all derive that
same configuration from it. Since perf_event_open() skips
perf_allow_kernel() when attr.exclude_kernel is set, this potentially
lets an unprivileged user collect an instruction trace of kernel
execution in a per-task event's AUX buffer. The existing guards do not
catch it: etm4_config_trace_mode() warns on the combination but is
reachable only from sysfs, and the early return in
etm_config_trace_mode() can never fire because mode never holds both
bits.

Reject the combination in etm_event_init(), covering both tracer
generations at the single perf entry point.

Fixes: 882d5e112491 ("coresight: etm3x: implementing perf_enable/disable() API")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index af0295eab143..9cc93d48e970 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -185,6 +185,17 @@ static int etm_event_init(struct perf_event *event)
 		goto out;
 	}
 
+	/*
+	 * Excluding both kernel and user space is not a configuration the
+	 * tracers can express: etm_parse_event_config() and
+	 * etm4_parse_event_config() overwrite ETM_MODE_EXCL_KERN with
+	 * ETM_MODE_EXCL_USER, which ends up tracing the kernel instead.
+	 */
+	if (event->attr.exclude_kernel && event->attr.exclude_user) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = etm_addr_filters_alloc(event);
 	if (ret)
 		goto out;

-- 
2.51.2


