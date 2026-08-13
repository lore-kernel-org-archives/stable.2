Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DE4779BB;
	Thu, 13 Aug 2026 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625239; cv=none; b=QpgrdfItOz86j/1ckZFJ7ejfzPWmkVTZxu5MYMRg4u+DLbR7Ilk71QV25YQVkMdjC6kQtOS78UzHi303FqDJzizSzU5IXW22/xwDZF+GM4sMtBLJR+O2OO5w8F5iy4tCwQbPXodbTZ8rXR7TFBP+2FQnWmSe04yb1cbWE4W/wqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625239; c=relaxed/simple;
	bh=VpG4nwidpgDqllXzLatya6ZM559BrQia13sMRj/SAJg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S7oaCrPXMU1f5OEVFaoGA4cxLLwbV+6rTI4B22dj56eQY4pkAVKpNRNnAZLU25cFwbPqVLsVme4aKpUastrFeVNujFcpiplyy5C+XYTXoJkeTVXX3hYI1UHuf/PHiMfzIA4+msrNPmD7D8yQifCVX4Lr8atBBZ1Wcl5sP95sSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej7xMUSk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej7xMUSk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D320FC19425;
	Thu, 13 Aug 2026 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786625238;
	bh=VpG4nwidpgDqllXzLatya6ZM559BrQia13sMRj/SAJg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Ej7xMUSkdsrv3rN1FW/I1G1+LpYjrMyJOoM4LJtNrrgIhuehsWLxYS2C5GLKM1pdD
	 GCDpY0v8AYj5XEgwuowg129R9QveG8hHi2K5SI0iecFseQfYJsyU2GXoj8i+8Sdx41
	 +Ki5hWJsieAbD3xBWue3wZCGpUMHjMNhO7trrjO7BRwMOg5e7urIKlnsuCRSD28OoR
	 OMto5MA01w97hcSQhK6yjDLgrej63hQT+GES6xFZwWMZOiMd2I1etqDFqdl5uswr6G
	 NZ5VdvQqezpBIM6/PLqZZ30tqvuhJ4hCmmc43h+u57w902i5g+4S7Sv0LosTUFXsyf
	 SKIkIKNyW4t3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD3EC5CFEB;
	Thu, 13 Aug 2026 12:47:18 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/2] coresight: etm-perf: fix resume AUX leak and
 exclude_kernel bypass
Date: Thu, 13 Aug 2026 20:47:15 +0800
Message-Id: <20260813-coresight-fixes-v1-0-7411a73cd496@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANO8fWoC/x3LSwqAMAwA0atI1hZiFX9XERfSxDabKo2IULy7x
 eVjmAzKSVhhrjIkvkXliAVNXYELW/RshIrBou1xbFrjjsQqPlxml4fVDDQhoe2QaINynYn/UKZ
 lfd8PGvv9s2EAAAA=
X-Change-ID: 20260813-coresight-fixes-7d90d0240dda
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=VpG4nwidpgDqllXzLatya6ZM559BrQia13sMRj/SAJg=;
 b=kA0DAAoWceg4UIuO8EAByyZiAGp9vNSjHQlEcb9EjdLpv+Fnx2ZHfkz4l9Q3T+XGlV9mSIcAh
 Yh1BAAWCgAdFiEEx3DS9jhNtC20TLRjceg4UIuO8EAFAmp9vNQACgkQceg4UIuO8EDvZwEAnaw5
 wS8HmZVvjl7Z/YhUflgIhG8lLALa73Cq983JJgIA/2r6v15+IanMe3rftVpzLwidlGuVhwgCozh
 ut7ZF6/kO
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

Two independent fixes for coresight-etm-perf.c, both tagged for stable.

Patch 1: etm_event_start() shares one error label between the initial
start and the PERF_EF_RESUME path. Taking it on resume skips
fail_end_stop, leaving the AUX transaction from the earlier successful
start outstanding while the event is marked PERF_HES_STOPPED.
etm_event_stop() then returns early, so the AUX handle, the sink, the
remaining path elements and the trace ID are all leaked.

Patch 2: etm_event_init() accepts events with both attr.exclude_kernel
and attr.exclude_user set. Neither config parser ORs the mode bits, so
ETM_MODE_EXCL_KERN is overwritten by ETM_MODE_EXCL_USER and the tracer
is programmed to trace the kernel instead. perf_event_open() skips
perf_allow_kernel() when attr.exclude_kernel is set, so an unprivileged
caller can reach this.

Build tested for arm64. I have no CoreSight hardware, so neither fix has
been exercised at runtime.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (2):
      coresight: etm-perf: don't leak the AUX handle on failed resume
      coresight: etm-perf: reject events that exclude both kernel and user space

 drivers/hwtracing/coresight/coresight-etm-perf.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
---
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260813-coresight-fixes-7d90d0240dda

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


