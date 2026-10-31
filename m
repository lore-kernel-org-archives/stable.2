Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481899;
	b=SG3K36Rmym4moJTyVELdzh7Z2sQVzU4cIXbXg3QhI6NhmhzKJnGCRRC9HdQclw64mgpl
	 y+R2Bwcb04F9f2pJIunpJaLFm5K9nMlstYnmQppi4YhKMCh28+GlqEl/O49Z4VO3HND/v
	 bP4klEcU6CiMVqxiABkb4sNjm2dHSpxIKm9lg8NcISf3QhCxIX7deU5rKTB6YqiST2Axq
	 jveZ4zmaDS57H6hJ+9MSSHpV8g0JwsyfiQWCJzEXtbY6+mqASgppqLsj0Zh+DCbbRrN25
	 dLqfqDhA9AST5XEpOFQYjwEwc49bsDgocR2uta9HCt1WZO3/OFIx1RXhdsCs4JCDhoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1Vk1hJfR0u61Fe9qHt5Nn3FgFhmPztbFsxazzVHlKZY=;
	b=jXPioZZJYfO+IuWQ3wPWfOHEfvvLopvU/Tx+Yn9TDvNuTXMMSkBD0Ww7H+du32NyqLWp
	 K6Mfd1Q9lNOYXWIeIJoskNuQO8nps80QSoXhdC4Uq7H6pg8V13S7d1ULOdFzqD2wIo9k4
	 LLmMvG7/402qJ+8PWIThVhVn3T3z4t6u0uQvZsWtv+dGb9OxEuXqUR9+S0ufpwCjPZ2Oa
	 c0hMQLgIcnGjCBVkmdtkcXmF1VDAhJ02wby7fzaVOKN2ZxIuPVzoVbJjX4Lmco/ANlfKB
	 mHWpj1qVPgR3KKlU9Co7EAiKnttWBgZkuMpsouviBJONnUybdZvexdvIKcXkUIv7XJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fRulVzh3;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577F606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 21:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E577F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fRulVzh3
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b060ec084so1000426f8f.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793481897; x=1794086697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Vk1hJfR0u61Fe9qHt5Nn3FgFhmPztbFsxazzVHlKZY=;
        b=fRulVzh31Bhqv4/NY0qSOKuAao7KoNFrPQExsVBxY7qusbFaVTWyHO4RWrHIdAtg07
         vFUPO5eJXntEXjdfR1QLkzpfOsUJKagNOTK8XkC/c0eOnia4NkMKvJI/Nk3VrVFoxsOh
         i3oPWiPPU2rtDbWV4kOkc6izndYKP4KXuDEkGhXYsoeRWL/kH2x1YXIiD+1hnaPPH9HG
         9EzMsLOiHjBNpJGxgjQQzJ7ekqcK37vxtBU4edxk2DSn5o2ErNIoJFaP/+AoToO0aF3U
         MxjsXR6/F34luSr3gv8m2/9Ro5kDnFDCdNXHMzKkM8aUGzvbYkTbhDMjdSXCvtxNlOXL
         N7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793481897; x=1794086697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Vk1hJfR0u61Fe9qHt5Nn3FgFhmPztbFsxazzVHlKZY=;
        b=JC9VTqbiy4M4BwYk6ufRu9+URIFZdK30v2602vC0YO71+Frj5KaMvlR1MCzgyd2otj
         BO21xXJ7+6+1amxa3c6kXP+TCbsgGzJZoiCeI5S9EtT3Q0heXBE8E3TImO+S1cFuQK6y
         aqOe0TQ+Fevi08j+xUF2uHV9dmBR9OtS9K/I9OjJYIFcfqprvGhEgEg/lKJyw2seufhg
         N4sOA1PqAfUebllw+NgJE5uXxDKpjM4sXs0RhXGQgoGKgqOT6uScwEMNElC2+SIVQ1VX
         4I/hgzhiGIQwwzyDSrzOq6efiuvllLDajS6k9iZdVokN5HxPtX8PcQA1FF3ZHqpqjR9K
         draQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuyGbSVC+Vi/2NLRIxvkDZVnyuuMarHXjWg2xLv+zcPYAGpt35ZSN9W8Gvc8JfFCv3U0AooMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0pB+11/qe5Ii8nDkNSI73nN7Q8y6vJS2TNeK+Ej1G1R6x86g6
	CLhbr9cr+iIYFXcOAxP/HsqMnOYDN9a6mJtpu3VzMwvCC8FX5TmUAz2P
X-Gm-Gg: AYBFou0ukePeTPjaIl4E869P8s7bTaKJ76EwECVHrUmvjVJseCmQEQGCZMctXwtAFHl
	zEvau5V1FFTXNsBO3ALvMCbAQ7uce5rrk4bp7ZiZp3o9hCU0V955LTXlNPkccpSqVPvFf9eIzZL
	kjJzC86GSHFGRTsL2U7sKuItHYupwomvnxlWPOUWOEyzwlQFFsQ5fXFRsUMPVjqbkz8vIz37M54
	gTBXArR4BnERxByTBg0qPkQ0SEiYSBtfyRp7y+6Oxh0cbAD5ZDuGAhdf/1D8qDiSIHYhnwgtxlp
	YzUoGi5M5J4EX0bLfxXJafjGrHj92Mk2ecoxTn4bgTV9u85gHp9AWHWUuzAVnAgQhDflByVPeIi
	DUipRRYvIJml1OVZtcMDJ0zYDs/ZOryWJAsS+gez2/lvV6MYTW3R/hgjn/oBuaLa2aP7L2trBil
	KwlvtO3StNGMT++99KMvcgI5Wk5FNwgqqTwVozsd4uvvoJYCdm5OCmPXZ+NGr3g545q0XI8+Y/c
	FrYTfYBnS2vN87TU3WqkC3HhDJ9Bb6LsCG7UOXUnvFTwoVKxOkWV5ivTA1i5I46GCaiYqMDzh9y
	zpkKrjlhzdYiyjC3WKv5wmF6gb5FlhbXqnCd5M49rXFxPRXwDvk1k02kUvetu0CW3GOKdHO/n05
	qbv3d05KM296TXIcqTP3tB9iv84S5zWrXRT8=
X-Received: by 2002:a5d:4982:0:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-48e6e307204mr9624281f8f.43.1793481897073;
        Sat, 31 Oct 2026 14:24:57 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b81c74sm10204530f8f.36.2026.10.31.14.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:24:56 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] tracing/user_events: Don't free an event that a dynamic event still references
Date: Sat, 31 Oct 2026 21:24:35 +0000
Message-ID: <20261031212453.16116-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An eprobe takes a reference on the call of the event it attaches to,
and kprobe, uprobe, fprobe and synth events all refuse to go away while
trace_event_dyn_busy() says such a reference exists. user_events never
checks it, so a user event can be freed under an eprobe:

  echo 'u:test u32 a' >> dynamic_events
  echo 'e:ep user_events/test a=$a' >> dynamic_events
  echo '-:user_events/test' >> dynamic_events
  echo '-:eprobes/ep' >> dynamic_events

The last write drops the reference on the freed call.

If the last fd of a non-persistent event closes while such a reference
is held, the delayed destroy now fails. Mark the event persistent then,
so it can still be deleted once the reference is gone instead of being
leaked.

Return -EBUSY from destroy_user_event() in that case.

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2: keep an event whose delayed destroy fails deletable by marking it
persistent (Sashiko). Deleting it then needs CAP_PERFMON, like any
persistent event.
v1: https://lore.kernel.org/all/20261031210420.501187-1-devnexen@gmail.com/
 kernel/trace/trace_events_user.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7..ea6a20a30cf5 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -256,6 +256,11 @@ static void delayed_destroy_user_event(struct work_struct *work)
 		 * attempt to delete it later.
 		 */
 		pr_warn("user_events: Unable to delete event\n");
+		/*
+		 * Keep it as persistent so it can be still deleted
+		 * since nobody own this event
+		 */
+		user->reg_flags |= USER_EVENT_REG_PERSIST;
 		refcount_set(&user->refcnt, 1);
 	}
 out:
@@ -1506,6 +1511,10 @@ static int destroy_user_event(struct user_event *user)
 
 	lockdep_assert_held(&event_mutex);
 
+	/* If there is a reference to a dynamic event */
+	if (trace_event_dyn_busy(&user->call))
+		return -EBUSY;
+
 	/*
 	 * Detach the fields before removing the call. Removing the event
 	 * frees the field list memory (trace_destroy_fields() is run on
-- 
2.55.0

