Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196480;
	b=Ul1M+zFO/nuUyn9IsPvJAEpffem5OQXp3n7dlCSVFPOCcFaGbKtJGoLSihpu2be/ktc/
	 W3Mug+7C5hDNRa3YssD5+JZ+gul73OuPcE/rmKqulq99H4xKz6FpTJBptq9iPJMHTB7If
	 zOu1Pk+twE8oLEVsPVJuqldkl0UO72RTshrmrgXJwX+7VnV/hS1DKOHEuy0Z2g7+D8UPL
	 l5IxvJjjOOMgodNCujmUHyKX++54CnDinE3G32Rw6SrgLFzaTFh+c4RDObruvOcvr2EuH
	 RHtTIB5jgexnK/2Q2uKia1Ai0QEZXGX04h3joNVsLMy4GprbkfZk18dJlfPyxd/n7WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196480;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=4E2HOnqMkUFmgt0BqTtnsXULcDX6EdhJc6Ozj9DjDOw=;
	b=tvDdiXzzJrKUhg3bM8JRuJlyNFd3aHaSe88OUAmsF0641F49NVjG2a/MUQh6alhYDYUy
	 QUzine0s1rL82jiUpQpJtjXy9Bb283QEBEtFc8tVhA/16QhFYMoQ00M4MexFWz0meDuKW
	 6VuoOD4T9NUVBjAJ55gS89ZRUCa/Ez8uaWFqodlgV6EAwfpWmCjyds6jdPqJZpRMjDsIP
	 scb2HxndP05HI+0lAZHCJB59NHN8bd17W+JfNbxiId2nhkiPX8Fus5HI3T4Ktgmm6rpL4
	 2pBt+MOPQUoTXNjyNZ6OKEOS39nNgVqRk5ymuDLf6VVMIVFuaHsfx0s5Pb3+MQeA9iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDsiKGAb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF260A6F77;
	Fri, 20 Nov 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDsiKGAb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C98E1F01816;
	Fri, 20 Nov 2026 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196480;
	bh=4E2HOnqMkUFmgt0BqTtnsXULcDX6EdhJc6Ozj9DjDOw=;
	h=Date:From:To:Cc:Subject:References;
	b=dDsiKGAbpZ6tMv3RS6FHLzHUhUsfDsF2dKY789gxDBgAP9J5CS7iXr18ARzjjnqp0
	 OHNka1Pl7548VTle96L0V/7X5EzTn9vzH8PINeOWUy1tGoZeHfAri7X9bn/lpLbmnY
	 hDARi5kNcLubznqGkhsUFBvf8RDmrPbG90fsQ4E9pB2/w0T9v8Ck+VRyH+z7tUAIYf
	 qun7Gvpyy4faoZWX/EsUhZFjpzLeA5Tg1GSlxNAgQhgTPaMWfG+7ErIEsC8x2QRWqR
	 DpGXVKNdxRB0mXGMb8JXJ37LSEM6uGIOtb9YfMPsn5Up4pn3jY9id8ZLFS2gQdL7zI
	 Hkfmuv2p5M0UQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbv-00000004aUY-2ed8;
	Fri, 20 Nov 2026 12:41:19 -0500
Message-ID: <20261120174119.461616223@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:21 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 29/32] tracing: Do not allow user events to add a system name
References: <20261120173852.687189370@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

User events currently do not support the addition of a system name, but
the parsing does not check to see if one is specified.

A kprobe can add its own system name with the following command:

 ~# echo 'p:mysystem/kprobe_event schedule a=%ax' >> dynamic_events
 ~# ls events/mysystem
 enable  filter  kprobe_event

But if one tries to do the same with user events:

 ~# echo 'u:user_events/test u32 a' >> dynamic_events
 ~# ls events/user_events
 ls: reading directory 'events/user_events/': Invalid argument
 enable  filter

It corrupts the file system as the event added had a '/' in the name.

Until user events support specifying system names, just return -EINVAL to
prevent the corrupted file system from happening:

 ~# echo 'u:user_events/test u32 a' >> dynamic_events
 -bash: echo: write error: Invalid argument

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261118122520.4a689710@gandalf.local.home
Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Fixes: 7f5a08c79df35 ("user_events: Add minimal support for trace_event into ftrace")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ea6a20a30cf5..e29e1c772aa7 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1040,6 +1040,9 @@ static int user_event_parse_cmd(struct user_event_group *group,
 	if (flags)
 		*flags++ = '\0';
 
+	if (strstr(name, "/") != NULL)
+		return -EINVAL;
+
 	return user_event_parse(group, name, args, flags, newuser, reg_flags);
 }
 
-- 
2.53.0
