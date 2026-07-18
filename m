Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443D41225;
	Sat, 18 Jul 2026 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784379679; cv=none; b=Q1zXJEuJswkEIIRbGlBnbOiPB00q/JjbOSn7ZG2yyKT6b+8EgutoI4+rqhfsMUOjP/DDlDvaAOtzonolJzcSIeSRO6S/hOm4HE0c5YAAuV/bvCtDQh0GNToWwXrzn2KbP0V5Xa3OLzi7W5CZYrL/+882Lc2wRn0DUgaFxbj6T2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784379679; c=relaxed/simple;
	bh=wEjNiwNg2a3IcLuY7RTWYFPOpymvflpqyNorCnnG1VA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hk/k1kIahoUHurMLXktBQbm1Qj81jvnWnBdIM60J5o3/fXeWUYbbbQTlacCXfgla0z9ZxBRJr1Adr99wnk35De0CCevnEvL2WcaQZGc/zae2l1PDSAZknJbgpQjRYyfzH2CrZtt1pQANtu1HVosdaU2zsc16qEHdKr9ujzDIX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wl4fD-000000014u1-0qBN;
	Sat, 18 Jul 2026 15:01:07 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>,
	stable@vger.kernel.org
Subject: [PATCH v2] dmaengine: fsl-edma: tracing: no ptr dereference during log output
Date: Sat, 18 Jul 2026 14:58:48 +0200
Message-ID: <20260718130024.341243-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fsl edma events store a pointer to a struct fsl_edma_engine in the
ringbuffer and dereference it when a log entry is printed. At this time,
the pointer may no longer be valid.

Event injection can be used to trigger a crash:

$ cd /sys/kernel/tracing
$ echo 'value = 0' > events/fsl_edma/edma_writeb/inject
$ cat trace

The log output needs only edma->membase. Add a membase field at the end
of the event and use the new field for log output. Keep the existing
fields for backward compatibility.

Fixes: 11102d0c343b ("dmaengine: fsl-edma: add trace event support")
Cc: stable@vger.kernel.org
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - dmaengine prefix in the subject line
 - Cc stable
 - Steven's Reviewed tag

 drivers/dma/fsl-edma-trace.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
index d3541301a247..45d964a3726d 100644
--- a/drivers/dma/fsl-edma-trace.h
+++ b/drivers/dma/fsl-edma-trace.h
@@ -19,14 +19,16 @@ DECLARE_EVENT_CLASS(edma_log_io,
 		__field(struct fsl_edma_engine *, edma)
 		__field(void __iomem *, addr)
 		__field(u32, value)
+		__field(void __iomem *, membase)
 	),
 	TP_fast_assign(
 		__entry->edma = edma;
 		__entry->addr = addr;
 		__entry->value = value;
+		__entry->membase = edma->membase;
 	),
 	TP_printk("offset %08x: value %08x",
-		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
+		(u32)(__entry->addr - __entry->membase), __entry->value)
 );
 
 DEFINE_EVENT(edma_log_io, edma_readl,
-- 
2.43.7

