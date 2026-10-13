Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5EA4AC176
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884338; cv=none; b=WZHtdp0qNvKLiaTfhygv7xj9rfmHJ1XWS0OBgrSWhxxZ8HmOAIxg9hLJemhv/GtDcsiQYyRFrg+o7bXt3i1ODcS4yLtUyijnFDp55qxgC70GENVIqCr8WxQuzmzaPErv+mlUa3JkNTb7y/nt8vYKcrWIFml8CZB8JIM/MDpswBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884338; c=relaxed/simple;
	bh=MEecJ1F5S0wC3w47D7D1kNOGcu+mt4loBZoChWWRuy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DdvveeccLGF5zLVMSFptR/fvr/xj6TSHG6Lo32Tr0RJtozb6DTivdd5/Hcvh7UggWwMMKjxt3o2TH7rMZLvs0umvnJpAugUMHoe5IJPp+eYYsqXHvJ/xm4nLYAyRnhX2VvRAGQVd953sVElz0JWFedL6Xt2rZldWmiHfS1GZcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPceKAS8; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPceKAS8"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so3282846a12.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791884337; x=1792489137; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKxGXX/GV3GLC3kVdFYhFHBYCi9SWzLxtXeZXEDG8+s=;
        b=gPceKAS8kgfMkdoR0xsFjPjefniTvzhMRA3JFsXKbcNwDleJKZdQwp4jesRTFzu/dP
         Cy142OgJMjwvPyXlBpp0mG6+40Be8TEknJ3Qjg8aFLYen0HypBacmRJJC8OeJ7dsOp1g
         hjjpYIg2IMvjMy2Ipf/7c0EebzThFg3saBs1aBjwdQZvXmyjtMh9BoPwhzIGmgvNUxbw
         yycqzqmihTr7APl/azqG3Pqk/R0wXPFxZb3xmkLK3yFRYOj2VCBGEmaWrcDc+JWGxVA+
         YaiDi8/UEOjpzmjhmr34xcwL0nBJws8hoEsL6j1o2cgD7tIxGhIA9Xn6Kk2AFGWHe2rB
         xVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791884337; x=1792489137;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKxGXX/GV3GLC3kVdFYhFHBYCi9SWzLxtXeZXEDG8+s=;
        b=h8Sr3UyYeoByx/KTCIJIEhsgOvw+FamlCk/rJPVhrAIjZvLVTVGZQxMGD5tOruwl/K
         LJIac8icdlHploFuo3TdBh1bJNoC0/jFJ5KHSUgHilU/tt3VFnW49TnWgX3bHafCtvNx
         d7fa8nY98XA1mvlzd2NA3bSMENtbslY/rJ4yONIizUCBezIg4T4pO1eErS+eL6cjN44i
         FFKajL8zNJgJgX3HLc8gSjMCRUmVLkNE+BejmPmxlQcqmnpf6ILOWFj/E/hloUEEs7fi
         5ph/MzJVlqnskKMkHpJCjI9N4LKh4nKuMJOAgGrJ5bXPbFoYKolmJnYHzo2IUNfPErSP
         wxJw==
X-Gm-Message-State: AFq9FYIy+3ELIDSL4ZJd6qx+WU1Bq663e6VIWPS24FcmQ/FFtPQfr5ub
	4hgku3oL6BY7afi3oHnuTyQfM4BtLQq86i9C7g+Bx0tiMqxHGHdu04GtSHHFsO3OCOsATbrCap5
	ldWZq6Cq1ZbW07ri31A==
X-Received: from pgbfm25.prod.google.com ([2002:a05:6a02:4999:b0:cca:9486:8b0b])
 (user=treapking job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9c9a:b0:3e1:af56:5121 with SMTP id adf61e73a8af0-3e1af565146mr3735769637.44.1791884336455;
 Tue, 13 Oct 2026 02:38:56 -0700 (PDT)
Date: Tue, 13 Oct 2026 02:38:36 -0700
In-Reply-To: <20261013093836.1269134-1-treapking@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013093836.1269134-1-treapking@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013093836.1269134-6-treapking@google.com>
Subject: [PATCH net v3 5/5] gve: Fix UAF due to stats report race with teardown
From: Pin-yen Lin <treapking@google.com>
To: treapking@google.com
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While stats_report_timer is deleted during queue stop and teardown, the
corresponding stats_report_task work item is not explicitly cancelled.

This issue was identified by static analysis and code review via Sashiko
during review of earlier revisions. The race condition is purely
theoretical and was not observed triggering a crash in practice.

This leads to the following issues:
1. During queue stop: stats_report_task can still be pending after
   stats_report_timer is deleted and run after queues are stopped.
2. During teardown/reset/suspend: if stats_report_task was queued by
   the timer, freeing priv->stats_report in
   gve_free_stats_report() without cancelling the work item can cause a
   NULL pointer dereference or UAF on priv->stats_report when
   gve_stats_report_task() runs.

Fix this by calling cancel_work_sync(&priv->stats_report_task) after
timer_delete_sync() in both gve_queues_stop() and gve_free_stats_report().

The change is theoretical and was not tested on real hardware.

Link: https://sashiko.dev/#/patchset/20260425002450.163421-1-hramamurthy%40google.com?part=1
Cc: stable@vger.kernel.org
Fixes: 24aeb56f2d38 ("gve: Add Gvnic stats AQ command and ethtool show/set-priv-flags.")
Signed-off-by: Pin-yen Lin <treapking@google.com>
---

Changes in v3:
- New in v3

 drivers/net/ethernet/google/gve/gve_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index f1eb0c6e1f9b..28624ded5f3b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -350,6 +350,7 @@ static void gve_free_stats_report(struct gve_priv *priv)
 		return;
 
 	timer_delete_sync(&priv->stats_report_timer);
+	cancel_work_sync(&priv->stats_report_task);
 	dma_free_coherent(&priv->pdev->dev, priv->stats_report_len,
 			  priv->stats_report, priv->stats_report_bus);
 	priv->stats_report = NULL;
@@ -1593,6 +1594,7 @@ static int gve_queues_stop(struct gve_priv *priv)
 		gve_clear_device_rings_ok(priv);
 	}
 	timer_delete_sync(&priv->stats_report_timer);
+	cancel_work_sync(&priv->stats_report_task);
 
 	gve_unreg_xdp_info(priv);
 
-- 
2.56.0.385.gd3acb90ef8-goog

