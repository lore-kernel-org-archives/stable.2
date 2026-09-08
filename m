Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F611380FC4;
	Tue,  8 Sep 2026 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848541; cv=none; b=Y57PLwQa3w8H9Yv7tI7dLPVeppVLwhGYWU0FQCWob1FM5vjZm9Z+0Ow0afKVHbiShD+HyNwShMIPNacWah/iD8ZLfZPCP7xH2C4B/Od7fuMUaEGUOBwORGyTMzCFTKHBUnt94eZfeKpNXvSKvbtXARZAKjjojsYhxJsxLCcYvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848541; c=relaxed/simple;
	bh=vGSo4rgCHvujEd/avZtZt+hZGhZ1NSkjuonFug/7/iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0nugW4kHhdb2zw2y3K7JDwFmy4OGFWy9vMHIlfKsT1zteF3GCZ/Wnpaxgsiv9xBkJcnjP7gkyz93Pqa6Njw0VUIlAOzbkPGSJ+puxmDJqJ8HO48MuMwUcEu4ijNEl9fzAnh9RkhxBG6pXw2VSwYfikX0xiy8fgbrMyDf5pdIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0vZuNQoG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WyQ67PrH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0vZuNQoG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WyQ67PrH"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788848537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+di0ouvNWAnbViwKCuPDa4ryAiesqddSgYVkDMYu7D0=;
	b=0vZuNQoGk8RiwqT4uAabP268dEOWvJsagSOSMMCeOYwMymJ1RiGwOR/tK8H5+2dbBo3RRz
	HPtk9ulQahaxc3+unXpCaHPnyCvLcKuXWT5DDW3xQPIYmBf23JlQAkTGPHALrn7p2ghehM
	Zh0sqAoP4L9dZQVijk7AYK0HzPoGugTZcmxCyUcXn63vGOyta+W9KQyjfGbznoHxgY5C6+
	80GdwZ/csy8/08g5Z7vAvncX5DlZRAoLt/YKgvZZjxL5r492OpWK5AwKFD7RVeRLuWGY9m
	eRK/AJwqR+SHhexjN2QYZbYDZL0hOpoZmIFHNJ6FPrQ8i/5TxUaxenq7b7BIwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788848537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+di0ouvNWAnbViwKCuPDa4ryAiesqddSgYVkDMYu7D0=;
	b=WyQ67PrH0X8f+QPFihJ94Owuz2RYegBmXxA9cTqQljgTizESaBvfUkGvtzj8mrdAQ98xeS
	mgKD/KfCeaM+y5BA==
Date: Tue, 08 Sep 2026 08:22:15 +0200
Subject: [PATCH v2 1/7] tracing: Restore :mod: trailer after parsing in
 ftrace_set_clr_event()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-tracing-cli-event-filter-v2-1-05396a3fb663@linutronix.de>
References: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
In-Reply-To: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848535; l=1066;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vGSo4rgCHvujEd/avZtZt+hZGhZ1NSkjuonFug/7/iI=;
 b=qukLrjVKaixpHmMaHhPbATFtaVZi+XrojLdyjrFTn9QGq4BtAe+2FBtCw2Fqs71ItAhxeeHvJ
 Kxy7HdrQmMBCnjlu8aw9YeL2RPihfTlykQ1abHOmf2csJtV+iP4tEgh
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
index 1d39eaf6a0f7..eab653cb3540 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1489,6 +1489,8 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 	/* Put back the colon to allow this to be called again */
 	if (buf)
 		*(buf - 1) = ':';
+	if (mod)
+		*(mod - 5) = ':';
 
 	return ret;
 }

-- 
2.55.0

