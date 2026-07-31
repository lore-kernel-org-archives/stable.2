Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EA442B1E
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512722; cv=none; b=D5iNw+8Qxnyv8P2O08AVjivmlM2W74Blthmd7QWr9H172D96j0I+NTwMZSmFZsAFmLZJn8BuEOrrXNq36tvCmdpqsG4dZuvBgDgur1eZRRIE6UUVDvri3VP5JnHt9Eo6BOYrVcBfnm/08zFaf9wupDVm6J4vpIB/kqcY56rbHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512722; c=relaxed/simple;
	bh=/CbrWqg6ytS0QnftlxvoANq4DTGTHY7nSDt+TOFNSjo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sDS5r4Qha/J0bPOiPfgPzv3LypyfcTUcGSLkByp9uBI1LN0K19sEdO9sV6dcUHZpy0jwHghmivS9/rJHH47IeJll3SOcLCIAa8gHVr/dULAjPN4Avb6PM9YhPBM8Sm+uOrwGs4OxP1rY0ED/R6CmEyqJwEMQZ/TVpnAqbi10deQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZvOvAcF; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZvOvAcF"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84859a64079so2199537b3a.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785512719; x=1786117519; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2OdXeVdEKrvdHNlNkPiajCNX4IwJ1YUzZxO/OL+ra4=;
        b=cZvOvAcFoGZlUgBBgIgaukYVtxL1JUWh9gywqmtW9538EQIFEFTdbik+ueB0e+X7EC
         Txu+AjpGjLZ/KDe9nO7LpzAti5T135pjcafVwhU1GRuWibDOPBZ7etlz1Y6/2ENodJJC
         FNxQ+0zLp3koU7MxJtyV0OK+LMYnLj/2bxC3HMYd5rY+hauhEb4G0siz1Bb8ez1FAds2
         8mYH6ELNVZk4VTXlxnBOQERONTIlupGbjIeUwAzxZadLtrQNQU5UpkKk990WifViXlQR
         OCwnArsNgxc//9owixJh1ls7BSEUzRdWid8gv8FAySqNPCUhPvQiA18yCgj9vD2+BUCR
         xghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512719; x=1786117519;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g2OdXeVdEKrvdHNlNkPiajCNX4IwJ1YUzZxO/OL+ra4=;
        b=jXlmKulVlZYc3JBsBL7X/3Ga33zK2pf+7ItDLo8M+juKAa8QYRkiI1ZxqneLU/58F/
         vdIr0Q4RyGb/8i/uQcuNJRnSWmjbn97GbNuoKEdHHrLDogmEeEPqmJTnMK3JfHQPwYPp
         2AtKTP3/XN903yVLlhaCnvHgA+7zz7EWUOa52ksZTBlHa4VVsKMIPy0aBnxh5n59GL+t
         d3r6M9+sW71pneIq4bRUsyjoD8XRPK9m6nxCxQ4zXZGdQHp3uGcvz0eJBsmataZUrALR
         udy7lvS3gznKxfDAKlFmEq6TA+wKm8MDLfSHVJyQg84t8i6MI2XbE/Fx0ojfz3sy1x2P
         kFFQ==
X-Gm-Message-State: AOJu0YzVUPP7k9GSF58S+HyIfM+PyzzS4zxxhdNElVPrFhe8A6x+3Hfo
	Yh1vaBqR301t+zObrdGi4rVS0DETwkqeQjirMRJJ2MBfLvI57JL2NFp1FX4tLTJg1oEEsmQ5D+d
	uV9He2kFlthQhQMZaQ3bkSbh+mgXcJvEDtzg+6TxAftzbRgtlbIR7HUJzifHXD/Cci95z4EtZ5C
	BKyvQVAeGuo3Ud2yHiSV4dIey/5P2ZUXQypv3P20oHNESaDHvCLIy5vRmhi1/jHGZznnwgF97Qf
	A==
X-Received: from pgl1.prod.google.com ([2002:a63:b01:0:b0:c99:7baf:125f])
 (user=eddiephillips job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1911:b0:84a:2fff:ceed with SMTP id d2e1a72fcca58-84ee47be6a4mr146967b3a.3.1785512719002;
 Fri, 31 Jul 2026 08:45:19 -0700 (PDT)
Date: Fri, 31 Jul 2026 08:44:49 -0700
In-Reply-To: <2026072934-rule-library-9954@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026072934-rule-library-9954@gregkh>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731154449.2755799-1-eddiephillips@google.com>
Subject: [PATCH 6.1.y] gve: fix Rx queue stall on alloc failure
From: Eddie Phillips <eddiephillips@google.com>
To: stable@vger.kernel.org
Cc: Eddie Phillips <eddiephillips@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When the system is under extreme memory pressure, page allocations can
fail during the Rx buffer refill loop. If the number of buffers posted
to hardware falls below a critical low threshold and the refill loop
exits due to allocation failures, the queue can stall:

1. The device drops incoming packets because there are no descriptors.
2. Since no packets are processed, no Rx completions are generated.
3. Because no completions occur, NAPI is never scheduled, preventing
   the refill loop from running again even after memory is freed.

This results in a permanent queue stall.

Resolve this by introducing a starvation recovery timer for each Rx queue.
If the number of buffers posted to hardware falls below a critical low
threshold, start a timer to periodically reschedule NAPI. Once NAPI runs
and successfully refills the queue above the threshold, the timer is
not rescheduled.

The threshold is set to 32 because a single maximum-sized Receive Segment
Coalescing (RSC) packet can consume up to 19 descriptors in the Rx path.
Lower thresholds (such as 8 or 16) would be insufficient to process a
complete maximum-sized RSC packet, risking packet drops or unexpected
hardware behavior under memory pressure. Setting the threshold to 32
guarantees a safe margin to handle at least one full RSC packet.

Cc: stable@vger.kernel.org
Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Eddie Phillips <eddiephillips@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://patch.msgid.link/20260709211906.3322883-1-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit b65352a1bac64442ad95e64f385b40ccb9f1b0db)
---
 drivers/net/ethernet/google/gve/gve.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index c5e1312b9283..056f57166362 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/timer.h>
 #include <linux/u64_stats_sync.h>
 
 #include "gve_desc.h"
@@ -226,6 +227,7 @@ struct gve_rx_ring {
 	struct u64_stats_sync statss; /* sync stats for 32bit archs */
 
 	struct gve_rx_ctx ctx; /* Info for packet currently being processed in this ring. */
+  struct timer_list starvation_timer; /* for queue starvation recovery */
 };
 
 /* A TX desc ring entry */
-- 
2.55.0.571.g244d577d93-goog

