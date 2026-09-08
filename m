Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73EB37F8CA;
	Tue,  8 Sep 2026 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848540; cv=none; b=AReqSsXLsmf4VUXBNTb6y8yFLwdzJQYkLPf5qn/VpW7s+BnXdpSockGkDMK7or/lDepzWOwgasMnDx1D7ivTedHt4Ri1UDwFA8QZHlYRSQmwBr4S2WqJHdONw6av7CvblIpLR9OGyRhd0Xp0Yo5SlQgw9XuZZVRMaoE6gBFCW60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848540; c=relaxed/simple;
	bh=BsE3w5FprehD8KyPfUD9ThZFJtkdMaJDUcMwNFyC/4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i+xe3/RGkyukfHdSHsHXb8TOVh/cltCxzGqmQJm9/+uNC++SfOkEjv/gxjsX/Z4w+J/VoNs8U7j4yYVp1ecGQPrCKfWEHt+6qWu74V9ALfs18FS3h/JSmx92Xoewh9B9SBV85UpeI0n/u4PN1gudV+WS5uXXezOEvRGdSpsz/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZrEeCh0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7oPc0+n1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZrEeCh0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7oPc0+n1"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788848537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6k1TQAscyciGriLYtNZRwXqcuqy8v/dZ5ksZ2zTH48w=;
	b=MZrEeCh0tJesxx3G04P4pgQKtfdfkpDP7k+vT2T1sA6Z6mbwvO1xJPXzmTTxY8cRsTcPnZ
	ympId3DUhqyiKL9MSCShgeVD+NUcU0Yg21kWYlTUznyjKUc7ZFb63Papgei/1+fcFHgrHn
	Z+HVHTn7wKpTLyequnBa15i7Wp5pyE/h8Ls7jTQLeEbNcJLqmkVfvFt3z1ttumD5i/F+lz
	fnT6BXczFwo/GxFG4trIbNhdHyhg6XFM2YHGTTa2EFEFBzPYqJQPlq8/IXQOFTJ2YFx8jg
	N5kU+XfadwfwBJws23sa8HP+lU5WbHZRH8GFfAa4aLgqa6VfYm5rqT6zN6RHvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788848537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6k1TQAscyciGriLYtNZRwXqcuqy8v/dZ5ksZ2zTH48w=;
	b=7oPc0+n1TGMbWLx9VQX3H3Gd1StIMHRYoqo/chfIFf6KfNYeuyIJvEoRbcDAWiNMP9HKzF
	Jkjo+lDA/k/bcgDg==
Subject: [PATCH v2 0/7] tracing: Parse filter from boot event string
Date: Tue, 08 Sep 2026 08:22:14 +0200
Message-Id: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNywqDMBBFf0Vm3SlJbH101f8oLkIcdUBimaTBI
 v57U6HLLs+Be+4GgYQpwK3YQChx4MVnMKcC3GT9SMh9ZjDKVKrRBqNYx35ENzNSIh9x4DmSYO1
 aTVSW1tQEef4UGng90o8u88QhLvI+npL+2l+0/B9NGhVea3ehRpnWNdV9Zv+Ksnhezz1Bt+/7B
 1Qqn9nEAAAA
X-Change-ID: 20260812-tracing-cli-event-filter-7c91ee33a27e
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848535; l=2176;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BsE3w5FprehD8KyPfUD9ThZFJtkdMaJDUcMwNFyC/4o=;
 b=MAG66dD9xxK2pQZ3gqlJCxZ/DuoVtnZ/OJW74GqhwSksq2P8Oei5bR1uJema7GM4eQdSYL7Yk
 n9EPLJAyi9nAKKgMC7hEyaWILRV/Zf8j6HxL4BxVIg7w5DWY1vgOmIi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make it possible to specify a trace event filter from the
kernel command line.

Example:

    trace_event=syscalls:sys_enter_clock_nanosleep:filter:which_clock==0

As a preparation also add a KUnit test for the event string parsing.

Patch 1 is a bugfix which is already useful.
Patch 2 is a cleanup which is already useful.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Require an explicit :filter: prefix.
- Drop RFC prefix.
- Add MODULE_DESCRIPTION() to test module.
- Avoid invalid __free(kfree).
- Add documentation.
- Only allow filters from the boot command line.
- Move the filter to the very end of the event string and add a :filter: keyword.
- Add an example.
- Link to v1: https://patch.msgid.link/20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de

---
Thomas Weißschuh (7):
      tracing: Restore :mod: trailer after parsing in ftrace_set_clr_event()
      tracing: Remove duplicate declaration of ftrace_set_clr_event()
      tracing: Stop modifying the input buffer in ftrace_set_clr_event()
      tracing: Split the event string parsing logic into a dedicated function
      tracing: Add a test for ftrace_parse_event_string()
      tracing: Add a filter argument to __ftrace_set_clr_event()
      tracing: Parse filter from boot event string

 Documentation/admin-guide/kernel-parameters.txt |   9 +-
 Documentation/trace/events.rst                  |   5 +
 include/linux/trace_events.h                    |   2 +-
 kernel/trace/Kconfig                            |   8 ++
 kernel/trace/Makefile                           |   1 +
 kernel/trace/trace.h                            |   6 +-
 kernel/trace/trace_boot.c                       |   2 +-
 kernel/trace/trace_events.c                     | 123 +++++++++++++++---------
 kernel/trace/trace_events_test.c                | 122 +++++++++++++++++++++++
 9 files changed, 228 insertions(+), 50 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260812-tracing-cli-event-filter-7c91ee33a27e

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

