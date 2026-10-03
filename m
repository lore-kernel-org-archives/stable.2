Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434DE372661
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791052371; cv=none; b=Ujojhi7gxRdcCVK65o1jhDAeBB4zjMCWr2Mwup4d1jmtUDCBJY9WvgRMbSA0JYOfVmSv/CUnQBm9RO9iVX187J3n2wYlUwte4ARoBWtmFbrRs4rXoQgdWMBDnjGkskMFikL6C/1Y/LUy9IjnNbRPhhkTJP70bSfDqXmbeQOwlpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791052371; c=relaxed/simple;
	bh=4O9b2fhqkP+W3xXPcxSroMY1Stl9Hf0z/8z2N+sFacI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WR8CDEwfWl5gyOg4wqBJqW6yPZaOd3q0YQwOr9C6MfpoZl/3RcgaszpSEXXMtu648Ta8O5WozNluvHsi4WgFllEMgy/eUouEkkr8Mm/1Gm3fkCyUfCDhTGW+1PHA8wgZ+Wl6EPuxYGNvG/fX6/xedHQTlnBA5cBdZpOPftu7X8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwcM4DdX; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwcM4DdX"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3510f8aef9eso46216eec.1
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791052369; x=1791657169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjhFw2Ze94b8Op4Wrc9mSVlEKmb9LEFTwAUiX7feoLw=;
        b=JwcM4DdX/Lyry8WJG1nMvsKFJZpTghI5xUrcoNF0rp7DfJeHIUl6XRe62jTGwgrTL/
         FhuvSlPospUK3tGyqISio+7pwGt8K51eiXiwdus5TixWBeZT4oJewImGCw4NXqaTT4s9
         NiuNKg6wTQ9YOGC6iL4NXIEqbBCxseoHG4DeLTUoUlL7F3D/57iayNFObP9jS3sUuDrO
         YVOOj12qTRDyutpDhF6w4nyfyA8/GFjGveyDvsYOLOzOGDLp3yiLcnwIHDXF9kKixVvP
         1V9sltluPd7gN61c0Yln9Ei/+LikpjaG//NUXX6vaUscV2z+WrfA1wKzb/67tFYWkmOx
         l7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791052369; x=1791657169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjhFw2Ze94b8Op4Wrc9mSVlEKmb9LEFTwAUiX7feoLw=;
        b=UzJUnaefCkYrt7+vNOKNWrCQZfx8SE3UYr67+uSayvYxoBYyM2VGitoYxqhzFU7l56
         k2DyIL+dhI8Kp0URkRngvZh2WFRB7pZcwqS/P9QwsrXPAz6ZFnZahrfI3EqWc846RHap
         31rtlbxpeoq+HqeESUXS9OWFxfsLrRSpZPx6MdsRFm2qngHAHkqNNlM4aQ7FDn9mgjrg
         mJC7S9CWuZKaapXqtoEaqAzFZ/9dsKBFr+/mfEL9tPsH8OiT9ak3nUuc/rIqjURI7BFa
         QGt6cqmXgcIqr5qPs3IqcBS15E0gLHcXRMVCalFqOIE0h4c3tGg9TgSXSwhnysHm0LUC
         1VMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzucMN+nURnR0OAVOXEqJHb5rMbHM0L1Owut08/fK7W3KES5SrrjIrcX2Skg+kpl+gvytsLcxQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2MqhHo2H7+QLVm1I0kaGHVyXJN8/eNQna4rkszOdnq2ow0AVW
	FDSJOYQLwvpD2qoWfVbhDBruRKQtb4bVtMF2EkLjPwoZxZmyw2RBEIdN
X-Gm-Gg: AYBFou38YxsUPvxYT1AG1SvNrIboPOQMnsmHGpHfXPoFAX2ByJTp12hYyBe3AVz88H/
	bjs3MvAmxjeDK3+dHPCquYR0XhQinMi1kLCRE2Vd2/3OMDyxtNcrDs2tS9zaV3h6PLB6DLuQV99
	9XWObghlNkVZAZygmS97+HGYK2Gp/JsXoc64FcZUrlnPtnTR3hFt+/bqV/ShSevOQULk18715dn
	fqn5lO/ervK0jNZT+c5WMbbTI8VZ+JnTtRUSwYy3U88pYzGqAS7xFRLOxJk7jwsJjb7w9MdNXhi
	81o5HVZRHc01+diC3713s1EXHtOMAgoexOfFXdMMAICuYXW+d/jlhnka1cnq1ynVfeX8WA0rp8M
	wGGnqODHTBPMPFmA0UgubYg8UFOlh4WTMvdhQo0Yl0DtRG9Sy48Bu7W40WVbMesnhjBNboCsJB9
	dUUDdZ8NiaEPIV9Uy/k6dVw/L7twK+jvtRucQnGgfWBR2R6Fci5TJFfq8juOCCSPBtv3bCQpoLh
	yb+nzG+ggQUl+P26jIaynIUpNmn8SlOHXdIYcLfbn474XsvkqfN9qksnucDQPCOiKXN3w==
X-Received: by 2002:a05:7300:24c9:b0:343:fdea:9a0 with SMTP id 5a478bee46e88-34f15028c8fmr12536988eec.2.1791052369159;
        Sat, 03 Oct 2026 11:32:49 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd9698sm17118191eec.23.2026.10.03.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:32:48 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	mjambigi@linux.ibm.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 0/2] net/smc: fix link group teardown races
Date: Sun,  4 Oct 2026 02:32:35 +0800
Message-ID: <20261003183237.2284245-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two fixes were posted separately, but both change the link group's
freeing protocol. Resend them together so scheduling and early cleanup
use the same locked teardown transition.

Patch 1 serializes the freeing check and delayed-work rearm with teardown.
It gives freeing its own storage and sets it under the list lock during
early cleanup, so another connection cannot rearm after cancellation.
It also corrects the cancellation comment: cancel_delayed_work() cancels
pending work but does not synchronize with an already-running callback.

Patch 2 excludes competing early teardown and pins both early-cleanup
callers through their ownership checks, including failed registration of
a new link group. Each patch retains its original KASAN evidence and
Fixes tag. The evidence comes from earlier instrumented runs.

The separate pre-existing race in which an already-running free_work
callback outlives the group is outside this series. The callback reference
and cancellation mechanisms are unchanged. The socket-lock versus
abort-work wait cycle also remains separate.

The series is based on net/main 71a77ab76e74. Local validation results are
recorded alongside the exported patches; no runtime test is claimed.

Chengfeng Ye (2):
  net/smc: serialize link group free work scheduling
  net/smc: serialize early link group cleanup with termination

 net/smc/af_smc.c   |  8 ++++++--
 net/smc/smc_core.c | 16 +++++++++++++++-
 net/smc/smc_core.h |  2 +-
 3 files changed, 22 insertions(+), 4 deletions(-)


base-commit: 71a77ab76e74131a101f4d2d2afb0dcbf81b4e3c
-- 
2.43.0
