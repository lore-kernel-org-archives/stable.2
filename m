Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629826;
	b=LLYkhrsDiZ385AR3pATU6O9oqVBFXuRyeieL+hndPZfy156w9IZs2qgnrI435RfjBMNw
	 PgNVNrSGusUENcXY8CjIwgc+WrdjL3GSk9Kej5t5rNWTlfrIyRHuvCi/b6oRFSYrneyB/
	 SemtYcffSNztz8nOtRFOClPpzShaE+uUSuo7r8fWYP/70p1XNHZUEVTlK7nat+nRIEonX
	 oZNSKtwsL9/POIv84I584o6Z0+W/O91Joi2VwLr4Pi0MGm2qrB9gdES9Ek0fDu1wWQuoe
	 pR8qblTkcCwB+VAV8zkcp3UsZ1+JBLT5ORt4QMgKgaVdQk9VO4QQVrXMjsFgWPemgRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629826;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=xXAdh7MCtVXkdjkxwFTBIoqLmR1zeTpwQISlrhQl0XY=;
	b=2mkapEodz5buQn/R2XfAbWnnjW9tspd2Z8Ni+FqkpWn/lcUNQZBdZhjLWgVQHZfy81xE
	 EyiTe7YzDFQHu8jmvWZC3i8hGLjHowHA5PHH6frgc2FQmQD2uWSjzUMiKP/vxrBa0qKYM
	 GGYQgRhHUNGwBO95SGAfOVBJBQPRuNYHpJsllCRwpQ4j7iTotLOLXBibKhYha7olzIoKd
	 txsxSqEu8iNp84k70KHeayK4Wm+1GIOagV/TrTPqJbKtD3llsMO9t2rUpRO9d/BwA6/Pu
	 MeyNYJp/vEuzVgUpwuK4A0t2fhzTjQ/zmrwjmcFXYpL5HvzfthrtQInWhnKPtplDlNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="Ly/x5Cvr";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A706087A15;
	Mon,  2 Nov 2026 14:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A706087A15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Ly/x5Cvr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=xXAdh7MCtVXkdjkxwFTBIoqLmR1zeTpwQISlrhQl0XY=; b=Ly/x5CvreHuBiPAnQMKDdkaOoP
	5g1n8x9SaFMSRd4Bt1ttji4by1J+9VgG6wHlA2e59iBjKUJpXJE0Ec0xcH2I8a1DJvzTiGr+TQdG2
	C19W6h2R/HdEvhFI9IzfRYxQ7sM75SarbDxLBnalEyd/5Pi+MuBk6/k1koMJ3GE71DhYIGpWV+VmS
	QgFN/48z+zo1fXqSb1HALOre1dxhOXUk+MqdZi6FuWYdlmwfnGiQX1y9NTbSaSf0uX1UIEL5Cn9uo
	q0DCptFOyEaahlwPyiqyIXILzhpALHID8gr2FHolvSrv/I2Zp/pBYIxOBwJf6NfBNTUwLcB/oLcF3
	fxTbqLvg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xNt3A-006DkU-1r;
	Mon, 02 Nov 2026 14:30:16 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Nov 2026 06:30:11 -0800
Subject: [PATCH] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-ring-buffer-head-moved-v1-1-165973790be4@debian.org>
X-B4-Tracking: v=1; b=H4sIAHKe6GoC/yXMQQqDMBBA0avIrDtgQizYqxQXMZnRKTTKpIog3
 t1ol2/x/w6ZVCjDq9pBaZUsUyowjwrC6NNAKLEYbG2fxtQWVdKA/cJMiiP5iN9ppYjcBs9N9K1
 zDko8K7Fs9/jd/Z2X/kPhd93gOE7KoBd5egAAAA==
X-Change-ID: 20261102-ring-buffer-head-moved-f9caf5da9444
To: Steven Rostedt <rostedt@goodmis.org>, 
 Vincent Donnefort <vdonnefort@google.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Steven Rostedt <srostedt@redhat.com>, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4635; i=leitao@debian.org;
 h=from:subject:message-id; bh=MqirCjy4LMxfEGQqwd42zRmE/cvyrglBE7IpN4USET0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6J51RwGT3+NFq8ETCFmY/EVcHmkiOEfARz06i
 YqqvuXCm12JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCauiedQAKCRA1o5Of/Hh3
 bcyND/4leZ9SfRd9S5lAT3epSqzEECQiRsU17LEQpHJe81jIuRbClmf2W9sS/FDvyunoGWnH+aL
 VtC01Y8i83InOeKuomDYbE90oVz6el64QF7YKjXU38rQQRZx+W1diwwxjcxi8hkb6JOu62GOxvi
 IaEsrONWR4HoTdYl3y+hX1Vto9JEwFXnjMfMMUcy6EvF+AuKFzLIqztyFmbTrtTbF+9Nnb8DCIm
 d+AKg4bluHcbnJV5XFPZKq2E1UL/SLrDZoai0qqf1edPYk1nhqcBBrGYjLIQ8C2pMMnzzkmwAIE
 LzFpsn6kruu/LnsOvkvuw+nfYbKlIweq7/WfeHUFtx/duQ21cGDfPBgiPIs8Ie1MWsRhL1KT4G1
 hA08QXrLrQTyjNmPxRM38pGj/ohvSoUB7D1BThGaZXEuLlsfpCY5ofyFBWRSvhAyUHaG7XiULR1
 LgKJEa8sd68f+J21W8PYtCtGr3LSHArdgqiuYRmIBAYETt6/lkSFUUfaqtjyorZxAhB8gN+OAVN
 ryQWZ/I0Vqa2RulNa3AscLpIf8+fgQ78T6TVS6MF8agbI69EJO4Pva7f1lvJroHRQeQiawCf9LK
 gZuyYqlX3ePlSqipwBMZqx4EYjniGUfBdrXpoVCldtdyiJEvjNBPSvBQDZQF9c6ferEGX2oFZaY
 BBNybhJcLNpf2DA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

I am occasionally seeing the following  KASAN warning when running
some debug kernel at Meta's fleet:

  WARNING: kernel/trace/ring_buffer.c:3793 at rb_move_tail+0xf78/0x1050
  Call trace:
   rb_move_tail+0xf78/0x1050 (P)
   __rb_reserve_next+0x648/0xac0
   ring_buffer_lock_reserve+0xd00/0xf00
   trace_buffer_lock_reserve+0x28/0x188
   trace_graph_return+0x220/0x3e8
   ftrace_return_to_handler+0x2bc/0x5a8
   return_to_handler+0x20/0x48
   __arm64_sys_sched_yield+0x18/0x30 (F)

I've understood that rb_handle_head_page() moves the head page forward
in two steps: it marks the pointer to the old head page UPDATE, then
marks the pointer to the page after it (new_head) HEAD. The second
cmpxchg is assumed to return only HEAD or NORMAL, but it can also return
RB_PAGE_MOVED:

  CPU 0 (writer)                        CPU 1 (reader)
  ------------------------------------  --------------------------------
  rb_handle_head_page()
    old head ptr: HEAD -> UPDATE
    new_head = page after old head
    <interrupt: nested write>
      sees UPDATE, marks new_head
      HEAD and moves the tail page
    </interrupt>
                                        rb_get_reader_page()
                                          swaps new_head out for the
                                          reader page
    cmpxchg(new_head|NORMAL ->
            new_head|HEAD) -> MOVED
    RB_WARN_ON()

RB_WARN_ON() disables the whole ring buffer, and the function returns
without clearing its UPDATE flag, so tracing stays off until the buffer
is reset.

Do not treat RB_PAGE_MOVED as fatal, retry after clearing UPDATE. The
head already advanced past both pages, so the caller can simply try
again without losing tracing.

Fixes: 77ae365eca89 ("ring-buffer: make lockless")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
A nested writer and a consuming reader can race so that the second
cmpxchg of a head page move in rb_handle_head_page() returns
RB_PAGE_MOVED. That trips RB_WARN_ON(), which disables the ring buffer
and leaves the old head pointer flagged UPDATE. The patch handles the
return like the RB_PAGE_MOVED case of the first cmpxchg: clear the
UPDATE flag if this writer set it, and retry.

Testing, on arm64 KVM guests under virtme-ng (32 vCPUs, KASAN config,
next-20261030; kernel/trace/ring_buffer.c is identical in v7.4-rc1):
- Setup: function_graph tracer filtered to "*sched*", buffer_size_kb=7
  (two pages per CPU), overwrite on, a trace_pipe_raw reader on every
  CPU plus a trace_pipe reader, and stress-ng --yield/--timer/--futex.
- Without the patch the warning fired after about 12 minutes. With a
  debug-only 50us udelay() between computing new_head and the cmpxchg
  it fired within a second, and a debug print showed ret ==
  RB_PAGE_MOVED, type == RB_PAGE_HEAD and new_head being the reader's
  page.
- With the patch: no warning in a 5 minute run with the udelay() (the
  RB_PAGE_MOVED case ran about 1000 times) or in a 25 minute run
  without it (it ran once), and the buffer kept recording in both.
- checkpatch --strict is clean, and kernel/trace/ring_buffer.o builds
  without warnings at W=1 on v7.4-rc1.

Not tested: the fix has not run on the arm64 Grace host where the
original WARN was seen.

The original WARN came from a next-20261030 KASAN kernel on an NVIDIA
Grace host under stress-ng, after an interrupted ftracetest run had left
that tracing setup in place.

The analysis, reproducer and patch were developed with an AI coding
assistant (Claude Code). It triaged the WARN from the netconsole logs,
wrote the virtme-ng reproducer and the debug instrumentation, and
drafted the fix and changelog.
---
 kernel/trace/ring_buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee13..7a60fa175e2cc6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3789,6 +3789,15 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 	case RB_PAGE_NORMAL:
 		/* OK */
 		break;
+	case RB_PAGE_MOVED:
+		if (type == RB_PAGE_HEAD) {
+			ret = rb_head_page_set_normal(cpu_buffer, next_page,
+						      tail_page,
+						      RB_PAGE_UPDATE);
+			if (RB_WARN_ON(cpu_buffer, ret != RB_PAGE_UPDATE))
+				return -1;
+		}
+		return 1;
 	default:
 		RB_WARN_ON(cpu_buffer, 1);
 		return -1;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-ring-buffer-head-moved-f9caf5da9444

Best regards,
--  
Breno Leitao <leitao@debian.org>

