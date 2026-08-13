Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E855478E5E;
	Thu, 13 Aug 2026 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630048; cv=none; b=QICO4mPOlSauqjlkLSGuXwQ++3f0YnxEX7xnAaB15Oq4ZpXBmd5u1YCyI4R8Cmpm6gkylB9y+N+pl9YfhoA7VamHtZOsbWids7DyrQOjix9HCKPsyreXzsm09IsOW4zq9KTMf0Uco2khEkJZieTNmvR8KEZ1BlRMJ1Dun5QeluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630048; c=relaxed/simple;
	bh=+AEo8N39EDDvaWpP4/MjO1uXRDwtkip/herijEEiZSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tvx1tH2I1OhGkhqKtYltf0TpZLn5Rka++lypKIFkOKn4miXphhZXZexx2K0TMOfU8ugMnM0L3yp48EhJkKod/wtYSRDKZiy/C20tKuz+SddAsUMZ8jxEZWGb68GSve1A4bYKQwyOzpm4xZ3doSbr+jgLHD8PvTvcAeegwQT9AsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbLsQlUn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IjvD1J0c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbLsQlUn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IjvD1J0c"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786630045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l7XMpUggOSCV4hXS/spRbmNkQjXiXUcsc1l2cnVtYUM=;
	b=JbLsQlUnqPw9ET9RUG7d/9/y6hhC09ATVuT1jrZ1uHDKLOdYdzduneGabNx73qG3nTHqle
	iXuHLC/deb2HhFArw5mZUM4Na04quy6FoGLN7snUbDt/9yFAgig7KanaltLOZIYVhxDhfy
	bhkZi21ydV9zDK91lnFVpBh1tvL2VVLHSWyExUOKEufC84gNAWiCbQs16LmMMicx5oNk8E
	M5d4CievZXFl0y+wo0FYOGueIjM8r+/pc6pU2uhQ+2BwSOZd13xBTrh4AveiutARHJss4R
	PsPAxsz7gczMCYetoe2vQ6jonIcFloVj1HekhOhgDYQHlFrZIDH8rP9QKwhIUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786630045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l7XMpUggOSCV4hXS/spRbmNkQjXiXUcsc1l2cnVtYUM=;
	b=IjvD1J0c9WkrK2yZVdtoa10H8YfiEoAH5rUajq9hlkS32PBnN/kALMpxB+T/qXzWavldct
	jO/aOg7sEd7uLTAw==
Subject: [PATCH RFC 0/7] tracing: Parse filter from event string
Date: Thu, 13 Aug 2026 16:07:13 +0200
Message-Id: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrB0wEdR2W/AAbouLEH/tgKRlE
 kJBvLvB5bd476AIFUR6VgcpskT5hgJTV+Q/LmxgWYrJNrZrBmM5qfMSNva7MDJC4lX2BOXePwz
 Qts72oJL/FKv87/WbpvFF83leGCcRVG8AAAA=
X-Change-ID: 20260812-tracing-cli-event-filter-7c91ee33a27e
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786630039; l=1443;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+AEo8N39EDDvaWpP4/MjO1uXRDwtkip/herijEEiZSM=;
 b=SYBHsaydwsBo4C4jWn2ObzVb9GrBANNwjS1pb5k3xp2WjCH3D33vSlF93sxHx0aD+QBNEryC4
 7xrLPtZdAgXCaKk4Kzj9OXN4KKVY6sLRFhIzjyy6f2fSj8Ao84F3sT3
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make it possible to specify a trace event filter from the
kernel command line.

As a preparation also add a KUnit test for the event string parsing.

(Non-RFC series will get docs)

Patch 1 is a bugfix which is already useful.
Patch 2 is a cleanup which is already useful.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (7):
      tracing: Restore :mod: trailer after parsing in ftrace_set_clr_event()
      tracing: Remove duplicate declaration of ftrace_set_clr_event()
      tracing: Stop modifying the input buffer in ftrace_set_clr_event()
      tracing: Split the event string parsing logic into a dedicated function
      tracing: Add a test for ftrace_parse_event_string()
      tracing: Add a filter argument to __ftrace_set_clr_event()
      tracing: Parse filter from event string

 include/linux/trace_events.h     |   2 +-
 kernel/trace/Kconfig             |   8 +++
 kernel/trace/Makefile            |   1 +
 kernel/trace/trace.h             |   6 +-
 kernel/trace/trace_events.c      | 113 +++++++++++++++++++++++---------------
 kernel/trace/trace_events_test.c | 115 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 200 insertions(+), 45 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260812-tracing-cli-event-filter-7c91ee33a27e

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

