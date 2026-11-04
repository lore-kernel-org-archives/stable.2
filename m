Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817904;
	b=b2csSd9Y/lH+zx4UQ9s8EWedwpfgp5+5G9wkgF+nazaYRqnEyocSQ37z8KpXtuknscq1
	 sQ0E8NgIwIwQ3aU5RoH+qIZflISsY+JWxaoKWZBjCfBdb1j5B+zjAA8GFR1r/Flj2YGc0
	 GeEiRizC7XTzlukj45nKmNtQQuC2TM4OGGrzDwuD0PXbTvNi+CVr6ihcJyry8J4cSsUxu
	 3LBlE1KqKkBoQTZvpn1na7tJgc1+iSdDT7Yl8806VBN8cgUpNP6jGWotOX0xtTELJcbLD
	 +WLMqMz3Zyl6qzEnSLkFS9vaimJ2IcYHclq2hOg/mcSVn26SnWCkb0wRpJMl9RHBslQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vp0Z7a9ktgRDwfTXrMwjxF9dH+4yaNzLINKGFx7d6oE=;
	b=aSQ2Q66Ko+cfDkxWX4EruHi3wTkd6bifM74u93+gYDD0b9zevc0ni5tZRedTohjVd9oM
	 p2U2b3OHmAdI4vk11ziCfhLRJeHGtE5d7nlnfHrcWqeaU7m/2VDOAL0ELTRzIW7iOEO53
	 AMIqmgzOlL4CO6AIQE+pjJk+F/WvRwU2vBoRdOhvUEqAqoW1/INNLpOM0JCMenax+JWcb
	 xqqqIAXO8S/PvDHH4um4Pah1ZZd7VK5Lym5Eu6vX/gxp4d1nLMMrj4ELVssgrvX3hKvWK
	 HuGfKUtXEVrrI7qmcyf2+oBYOQaf4IJbcGC3ouOFRT1ZuzlqCjVlQVQJpS3HTi6l8oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Gy+KT2Nm;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A2606D801
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 435A2606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Gy+KT2Nm
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4932b13c4ccso596603fac.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817903; x=1794422703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vp0Z7a9ktgRDwfTXrMwjxF9dH+4yaNzLINKGFx7d6oE=;
        b=Gy+KT2NmccNCFrgOhV2XRrtCJze18tPzG3Hi+1zez3z81JlmcBDMopcL5H/oRs0fSm
         nIgKNrPBSC6opodH4xy4Q3xm5Yae05enR5rF12baQadatFBt8SuvmxVaquy5nEmiNb+H
         TDzb9RaUpVASI9WiZaDWh2D9aYye0EQQk1Ieiq8rBqgMwLT8Zez0O6RM9zYLjrzJYW0R
         WGq45PbWKsZgLzVFTr5vd7xZF7a/CULjjGg/JHTpMfo0XEEf+L0LUwxZ6oJdRalRTeXT
         dMVwVigKErNzbG9+4xthygAQ2JC3MlbO/t55DdvaXYlkeSt7DzA7lpKfMffKIVnF+TFE
         nJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817903; x=1794422703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vp0Z7a9ktgRDwfTXrMwjxF9dH+4yaNzLINKGFx7d6oE=;
        b=zwsSTL0DjKeLdom18HMFePzEcbaqyFuYNi9P0lz8vYKhTyL5hdn646PlRprlP/uF/r
         i8magR7AnQD8XJtddCyq4JgDyMxptCEYg/B2qgNuWAFEtSniVrJYpnU9bShrLWRYTFum
         BLMtMQN4ny6uWHBXZuttjsqh0lnLs30IyLBwmIqOtw8xoQaYOS9iuzRjpfCV5znLoQAR
         jZwxOXBIeW5JUxgYAwuQkTRpCwcMu6p5+oy8sFqnTnnr/t71OkxUZS/inV3w1ccFDJu4
         s7DMmhmW39YFuDRO8LDXF1x0dzY+Ha5TiWQQIG1MgOuD+lymT1Ilk04L80j7ErxS6AdS
         hZSA==
X-Gm-Message-State: APuU4Z8HPRvvIqltR373qYLV5CTwWDv/ANXTZI62mtErb8UjspNb9mUv
	95bLt859VS4cYag/8pgxyy6Bfp/OEFr+hmGPW5mf4nzg86d7+L0CBGmRFXX1qQuyR0PmB5fLGeW
	REa52gSQ=
X-Gm-Gg: AYBFou36N8B6vFiXvxrGUMLRxx3CDi5iuiEpFE1GjFXGHXLE3iHMjk525C2xR5UIfYP
	7GBOWxMdTLHfkSNGZ38mvXzvU5dRuWvrplTwcloQG9zowLpsaq2X98xhfGItJ6vo1hYWn/3NVGw
	ppdt3FARvwwivqz59j4Rs/UFKOIQ0Xwc85+rN+JGgC/70ddX81ibVFyLmgDgwjFpswhLCXjikep
	gkORsDfDrws3mTOQjzeGcCN4dwMVSTbOlCaMMgMXF1U8nix0W16Uih6mFZLFKFvt3cXUL/OJ4+x
	9EWH57it4fxmN+sN2gDPLV+sH8fkKbIApDOG9eHFdE3bvL5yz0mkU7ffVfzqIgAC1690RMPBBt3
	RqwRE5o9YkC7nXo1tt0Ur6Lbx/jWiPOLeAkKWx6IDSlt7SoyCL/+ijaPHGO6Jvl6B0aCyD4lrSS
	J0azaqNTHXnXZRyNjWz6ORrJxcwW3hE0EyCWd3cveArySxZrM88XkLH8HMj3fUJTz6QmsmEGQMm
	2DXCM0bT6uN/A/lnOifleLfAcX+bCO6/9DuPP+KnXmoD142vBcMv907YNWfCDvHrHPkQhLbRrxW
	7ROo2kP7QMmkXJZVMduRwkNwulqilmtlXwj5kM1uny2YbureFHEV8+kIssOdIgj8UX4SsMbnAw=
	=
X-Received: by 2002:a05:6870:e98:b0:47a:c7e7:51b9 with SMTP id 586e51a60fabf-4a906c5c770mr10423826fac.0.1793817903075;
        Wed, 04 Nov 2026 10:45:03 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 04/16] io_uring/register: enforce per-task restrictions in io_uring_register_blind()
Date: Wed,  4 Nov 2026 11:44:35 -0700
Message-ID: <20261104184447.516768-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184447.516768-1-axboe@kernel.dk>
References: <20261104184447.516768-1-axboe@kernel.dk>
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

From: Dominik Maier <dmnk@google.com>

Commit 4a93427e99a8524f3612f29ec8bc0da5f8435a51 upstream.

When io_uring_register(2) is invoked with fd == -1, it dispatches
directly to io_uring_register_blind() without checking
current->io_uring_restrict.

As a result, a task with per-task register restrictions installed via
IORING_REGISTER_RESTRICTIONS can still invoke blind registration opcodes
such as IORING_REGISTER_SEND_MSG_RING even when those opcodes are not in
the task's allowed register_op bitmap.

Check current->io_uring_restrict->register_op in
io_uring_register_blind() before dispatching blind registration opcodes.

Fixes: ed82f35b926b ("io_uring: allow registration of per-task restrictions")
Assisted-by: ARTIST LLM
Signed-off-by: Dominik Maier <dmnk@google.com>
Link: https://patch.msgid.link/20261022232121.2538616-1-dmnk@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/register.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/io_uring/register.c b/io_uring/register.c
index 2ce36623e25a..62f492e6472f 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -1058,6 +1058,13 @@ static int io_uring_register_send_msg_ring(void __user *arg, unsigned int nr_arg
 static int io_uring_register_blind(unsigned int opcode, void __user *arg,
 				   unsigned int nr_args)
 {
+	if (current->io_uring_restrict &&
+	    current->io_uring_restrict->reg_registered) {
+		opcode = array_index_nospec(opcode, IORING_REGISTER_LAST);
+		if (!test_bit(opcode, current->io_uring_restrict->register_op))
+			return -EACCES;
+	}
+
 	switch (opcode) {
 	case IORING_REGISTER_SEND_MSG_RING:
 		return io_uring_register_send_msg_ring(arg, nr_args);
-- 
2.56.0

