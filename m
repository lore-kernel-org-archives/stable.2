Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCE47AF42;
	Thu, 13 Aug 2026 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630048; cv=none; b=llKjdKUznlDSkuo1tKmqj7fF9wQ/o3V63zcFgtIdvJkQYFIIPINNfvV7HzMmF6KlLpml2BH5gKI7z4+I1KB30ig/hwZ2CLgoMEJ2Xra7X5sIb4xmvb6ErlEk/BJ8PLBzAW5S6qq/dBSzkSTAg3MKZjwI3iv99Ef3I0d7la5rzZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630048; c=relaxed/simple;
	bh=Fqn7isJpEy0tNbhyXRMm4QBjNlNd33jIQfGv6bPhvm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fn+C7i8yGsIViWRuwURcp4Uycfvlzw3fbeJ28zdfcv+h0zrg28Ff9r98Kkauno3HG8OGFBggKBsZZGX4o3bKlD+usp1KpYPPZkp12iheVYyK5Nvfa6EdPWxlM5/PIVqQ4kphXGSFcPqFPQ8WfcCDzWl599S0sSk4DX2GkStLKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4vIVPM7y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=23F0YiM+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4vIVPM7y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="23F0YiM+"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786630045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYsiGRJ5VRa0CWly24xrYp0uLMoS4M867617Q5RPOd8=;
	b=4vIVPM7y+jTmy+v5FdOb9VUTZD3X9/rQHQTDm+YaDc0Bn6iUGZ6dGqZo7EmTkSbU06y9w5
	bFverpNxVgzPA6Gdk5jxFsIhUVSqkvEt/ijLOYazmej4K+zoIyhmtLbHDBwEzw4qBnjdpl
	R/mYaCSm4l0S/vhaOqaORZu9BcG7CP0Ko0cBrhKxY3pTYQb5M9fJOtvXZvFYVGMeD0gNUK
	fmyVjNkruxN/O04/76sjwHvqtOhFxKitMJfJY7HMNZg8I0Nb5NeO9Ehq8t86j5FJiR7Kyb
	mB0WRkDd6l1gkVVQlNOhViBD49X5nnpzX/g8Pi6qYHkg/MBWmb7m7AT+Wtolsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786630045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYsiGRJ5VRa0CWly24xrYp0uLMoS4M867617Q5RPOd8=;
	b=23F0YiM+UFGTWMqvDts1olu8gPZXmm76ToYd7IU9GBV/qIEZyd0K0pXhuGrLcljsvItmSQ
	308RHgJJle0f1SAg==
Date: Thu, 13 Aug 2026 16:07:14 +0200
Subject: [PATCH RFC 1/7] tracing: Restore :mod: trailer after parsing in
 ftrace_set_clr_event()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-tracing-cli-event-filter-v1-1-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
In-Reply-To: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786630039; l=1066;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Fqn7isJpEy0tNbhyXRMm4QBjNlNd33jIQfGv6bPhvm0=;
 b=ocotHqo+/4aGWH5NW3+sM15QLvSJ+cCd81EjxJ8OoNYbtGGedksbIlce2OljiWY/kf3tFF2TZ
 TQJ/3nzfg3VAMqOoHxY7WgWQhGiYBFdRLZ5Z06n93+Q41HEOjGATQut
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

While ftrace_set_clr_event() modifies its input buffer during parsing,
before returning to the caller the buffer is supposed to be restored
to its original state.

This works correctly for the colon between the subsystem and event
but not the colon at the beginning of :mod:.

Restore the colon, so the :mod: trailer is not stripped after
ftrace_set_clr_event().

Fixes: 4c86bc531e60 ("tracing: Add :mod: command to enabled module events")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..6aa32c492280 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1460,6 +1460,8 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 	/* Put back the colon to allow this to be called again */
 	if (buf)
 		*(buf - 1) = ':';
+	if (mod)
+		*(mod - 5) = ':';
 
 	return ret;
 }

-- 
2.55.0

