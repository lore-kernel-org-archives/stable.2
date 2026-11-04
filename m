Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817929;
	b=HgwX+euQfd4s6TSun4PN4OVp8KSPUMz2aiYXvMMP5XKpheqD9fT6d6c7aDyN4H7eQwAa
	 TWHOVGF5NdZzdPXatXpn4BXKx31Ys5I9zqEDtb2KemGOqUQymHh3kUOoLF7GNZwjJZs+A
	 PB/+HiNNcFIjhsbf23MRh4EWW5QZh79aUcISBsgdkgOoyNyF6bmnFGflDxqVMiQ93FloT
	 w7QAKWkdmQVd+x/gS9sf7MMEH2YFrgxLaC+Qz459WlfChFlZXmsH17RflIkxMlAvXaVR7
	 FWe70MqJjLyH3yxJNnVxUsvhK2cqsacjFsagPZZDMK+tl6buItZSeGzwP3+SU588WLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JTqdFZGZVuVBeRPFocqcr918byeGzTtOW6Ly7O72eFU=;
	b=HHNz01jI5YADKI9t+4tJQwhetA6DpOhCoLO5z673SrB0TzkO+rUEO4I+7qj/yxsqugtC
	 5CIkMAj9weZG3p9Ru++88nKF+alrJXIVymewbJGZD7AKANVVQY0YO2oojsgv3QE35IRy2
	 433Dw+9X4CCE+zQ1q57yrIhzYC/B4BfmWi+/T7O7h6jK5lTKNbBeF/5JlRHgpxctpBOie
	 JFnQBYPpLj4MBYjHAw4zaWY5KPxpV2HMJEwtFeq52njCMVFiE0vdqUQQlHkMWynYdNdjN
	 64HBVAkmnvTWz2PDVJUclmA03aaVIHv7zxK+ZU6IMHLjCh/PCFZ3wSklYUrxUpKOgfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fYIn9Ivx;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94693606A33D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94693606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fYIn9Ivx
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a75171af39so282415fac.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817927; x=1794422727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JTqdFZGZVuVBeRPFocqcr918byeGzTtOW6Ly7O72eFU=;
        b=fYIn9Ivxa3pigvXUonZhWUfAqygxCTixEiSa3+9/8FnCN2b+dxkUIMYtI9TAPJ26IY
         lSA7KeFBldhyfQO/TkcJ/xW2TGAbx3xG+TWTevEM2A9mmuDB1O3aJQH4Drl9siGYIyef
         2/EPIHVaGqDXgc+T+DV18mhu+twbQ6cSke+Rn4JqjnRCzo9aBMow10e+9eE8M/5qp4uc
         vWExXXr7lKNtFqnbuoQUcTYLRvCptMUPXSBN5B40gP00hTP8vuv5Ax2jxyWzPnuvmSYg
         KuqcCTmznJZSIQH78P06+Fj8YMhWpwEI+qc/8+OJybN0l/Eiq6SALE/uaVeRRlqPkuzS
         T91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817927; x=1794422727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JTqdFZGZVuVBeRPFocqcr918byeGzTtOW6Ly7O72eFU=;
        b=VHoCLG82IhNQHTLUL6ibSlfGqS819h4j91aNLvqdPnhioxkITkxPQMAFr1BWU2atkf
         G8IUW2E83qzSKOHnmg7UM8TaXcQ0iMZIf0r56A6i5W7Nk1UI9fAMBturzsWhoXc3qRWJ
         ntUupdUP27OOITflLgw+/+APd0FdlRAZcxQXBvz3uiUDdvCI2LK4CROiACcslM1OhBE6
         /U048D1sO80JoWoRFsvZ2/7mHtK4P4sexRVz75Tu5PxN96AEiqXnKWnU8VMZNPhwMKcs
         Z57KoxM8h1bDYyhIAgCWEHcYGXyd74ZQgCC3+rIyeKgRFrLWqIYqfq+1xFkpcidMf0+B
         dxVA==
X-Gm-Message-State: APuU4Z8vRnx1dArCj8lh5Nc9KLnKbzAsZK0x65wUwj71GnuRszmleo8B
	lGOY8gKRz1Jp1xbOXxRXKZKeLpqOtSvNNm2Z8g3+m90Ka4ONpzVrAWeWT9f/KtDDuwJRohxwPEI
	8vAG8euY=
X-Gm-Gg: AYBFou0uOB2XscCUhgtL4vq9WCadTYIoXyuparLsMZ2cI7/roNDp7dqknvaepIt9qKX
	H9D+utvi0GKSL9/GZ1MZUJYWzski/6EeurqZKXPJ6/CjceUm0kDZZdnAjmrKFW5VaAKM3xIMpdp
	/XCk64qPipkcVMFOO9nhMkyO0a9kGNR6nSoLqtvA3HskZnrFU3ACP47awmzdZU1kB91rva3zW32
	umP7snoVSDjug8tLf2TeWlvtTH/xx4aq1xPlzVuTWqbkLqgGchVIHAamWuwkqsniwJDFmdmErt6
	WF5SC+yaXCniiN+5cCbNzfERMa5HkrY+yt/qCWV7Bdy7XI+GdxHgir4lfK6pLVf3H14F7BFtvPY
	uwHTuaWhwPMOPLz3nG+n0XKPD47ATVwFp/5okiNUjUkjVWLk2OQTe0lkctPQfBiuhKNwId5yxtN
	otz2CRP+C31FennZz6J62GbdlVw4fN3HQTgHk0QxC/StPdNTEQw/hCKhQbFKEaHZMjR+8quFohq
	B4kCC89O8KgxsEYiLntRQ44yqMou9JRNSaYk4f9o/OEb1JNyc9NXnb1uiMmtuH0zbw4+lL7qkDi
	ZwlidxrUttNv/hBSO7WJfFM/CXyXTFn1ZqeU12RZWeEMsZ/RIAUtHRNLQDCAHXscqWVUalNqLW4
	ACKS4JmzJR4g3DbLZNdI=
X-Received: by 2002:a05:6870:2dca:b0:490:105e:16f5 with SMTP id 586e51a60fabf-4a9075faa3amr13382281fac.14.1793817927232;
        Wed, 04 Nov 2026 10:45:27 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 11/16] io_uring/bpf-ops: clear bpf_ctx while submitting SQEs
Date: Wed,  4 Nov 2026 11:44:42 -0700
Message-ID: <20261104184447.516768-12-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

Commit 8543a39f03db8816a2d80d0c92c132a19f2afb48 upstream.

bpf_io_uring_submit_sqes() calls io_submit_sqes() from inside the loop
program, with current->bpf_ctx set, and requests issued inline run with
it set too. The socket code uses has_current_bpf_ctx() to recognize
calls from bpf_setsockopt() and friends, where the caller holds the
socket lock and has already been vetted, and skips both.

So a SOCKET_URING_OP_SETSOCKOPT from the SQ passes sockopt_capable()
without the capability, and runs without lock_sock(). A task with no
capability can set SO_MARK, IP_TRANSPARENT or TCP_REPAIR, and two
threads changing IP_OPTIONS on one socket, one through the ring, double
free in no time. SOCK_DESTROY via IORING_OP_SENDMSG ends up in
tcp_abort() without the lock the same way.

Clear the run context around io_submit_sqes(). The SQEs come from
userspace and must be issued like those of any other ring. They still
run inside the program's RCU tasks trace read section, so a request
that sleeps there holds up that grace period, but other request types
do that already.

Fixes: 890819248a86 ("io_uring/bpf-ops: add kfunc helpers")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/bpf-ops.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
index cf2bd068e331..6c2a587fb1bf 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -17,8 +17,22 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_io_uring_submit_sqes(struct iou_ctx *loop_ctx, u32 nr)
 {
 	struct io_ring_ctx *ctx = io_loop_demangle_ctx(loop_ctx);
+	struct bpf_run_ctx *old_run_ctx;
+	int ret;
 
-	return io_submit_sqes(ctx, nr);
+	/*
+	 * The requests come from the SQ, which user space can write, so they
+	 * are issued for the task and not for the BPF program. Hide the run
+	 * context of the program from them. The users of has_current_bpf_ctx(),
+	 * such as sockopt_lock_sock() and sockopt_capable(), take a context for
+	 * a call from a BPF helper, whose caller holds the socket lock already
+	 * and needs no capability.
+	 */
+	old_run_ctx = bpf_set_run_ctx(NULL);
+	ret = io_submit_sqes(ctx, nr);
+	bpf_reset_run_ctx(old_run_ctx);
+
+	return ret;
 }
 
 __bpf_kfunc
-- 
2.56.0

