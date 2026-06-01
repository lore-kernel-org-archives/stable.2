Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9D3BF685
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328342; cv=none; b=fPXMw8irlGFt+34+xMk4k6iC6AItZIvnWPCM5hHoq8f0cCtyJS0KC9SxS11/2a4iZElFFHmu1ZKaA+twmPrgS8SzH+mtEEcp5EaRFVGwMGiQTv48q/x3CS2CrHj9C7T9bNhLQM8wX/baN/zfR90wAllMl/vL/NIzqdeAz8WOuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328342; c=relaxed/simple;
	bh=WbFGxdg8pRAiP0PRsmIIP8kQxut9lC2Tuq1OEeDZX9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMpOe/teALd89MaIXabsCFsAU/L4xkz91nOWrwFamYh9AF3ASrgTvGFpacfeLHQW7oetG0GG87miGSk/smlATObL2b6J5LgvAkuDfIui7djZq88L3aU8jhj9TdaQHYQulSBrH4J5OBA3Bn+NOq03Ol26N9AmLhKKL8Mduf1iSv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JX3nmeeq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX3nmeeq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSg8i2czizW8RFFdY7nRaHerqQpNGmRLCju6bAU4vgw=;
	b=JX3nmeeqaPYuF736jZ1g87yQCfo1EdRqTAabayUDD3I7GXELNGtlz162BOii7qS3rCGHLe
	noqBGeUm5cXRVYdKQkRkZ9fJmUnJuaw2hbDAfHkY/aOjXA3Kl0KjMZVkywsEB0itv8cTDD
	JRYKnGrDsvCkQAdoTA9uixPrxGJ9Xxg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-b6Lyb7ILPEWvLiBa1kOdTQ-1; Mon,
 01 Jun 2026 11:38:56 -0400
X-MC-Unique: b6Lyb7ILPEWvLiBa1kOdTQ-1
X-Mimecast-MFC-AGG-ID: b6Lyb7ILPEWvLiBa1kOdTQ_1780328335
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 098C318005B8;
	Mon,  1 Jun 2026 15:38:55 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC5B718004A3;
	Mon,  1 Jun 2026 15:38:52 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 02/13] rv: Reset per-task DA monitors before releasing the slot
Date: Mon,  1 Jun 2026 17:38:29 +0200
Message-ID: <20260601153840.124372-3-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Per-task monitors use task_mon_slot to determine which slot in the array
to use for the monitor. During destruction, this slot is returned but
this is done before resetting the monitor. As a result, the monitor's
reset is in fact resetting a slot that is outside of the array
(RV_PER_TASK_MONITOR_INIT).

Release the slot only after the reset to avoid out-of-bound memory
access.

Fixes: f5587d1b6ec93 ("rv: Add Hybrid Automata monitor type")
Cc: stable@vger.kernel.org
Suggested-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 39765ff6f..1459fb3df 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -309,10 +309,11 @@ static inline void da_monitor_destroy(void)
 		WARN_ONCE(1, "Disabling a disabled monitor: " __stringify(MONITOR_NAME));
 		return;
 	}
-	rv_put_task_monitor_slot(task_mon_slot);
-	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
 
 	da_monitor_reset_all();
+
+	rv_put_task_monitor_slot(task_mon_slot);
+	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
 }
 
 #elif RV_MON_TYPE == RV_MON_PER_OBJ
-- 
2.54.0

