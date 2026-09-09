Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E92D3EEB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922006; cv=none; b=G95CyExpfAQf0CjDzqg6gkTP3L0Nb0KDZbskYkrNQif3sBDhT3qHQxcjOzIkDL77vRHa1zw/W/A7pDCfv2NFoeCAIxtscPjP2S4cHJMHz0uhwwuj8uhSSiUjVYv6+ELG4q4oaACfGPKCswJxW8wHuxy5hW0JVi0YAi6k32vH49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922006; c=relaxed/simple;
	bh=FaMuIMu7x2D3aJYKdS2ouRjVT1y2n3u88iUjSdpGrRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hr4ub+rJVnJ0oAjnWgJfQQNaAIFUsqWJZeQa+6482/TSLkzc76X5Lcp0tYGlxNTPgOknXJFha+uKBuP0ur4dTCt43pkUcZXekKMksceFNw1NMXb963H7u6Fo9dGhszUVrtVzGmvP0Iqg6k+ltfHrSOd7lJc4JSJIvtfdwXjNwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR6/7I4V; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR6/7I4V"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-868b3248b2cso174174b3a.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 19:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788922004; x=1789526804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZO7tbb4HSzx3MW7qh3I4JqZjxCZe9pXRQ8RRhmehi7c=;
        b=WR6/7I4Vi0fVIYRfp6HF5e67IBBWtRGM8m0XsYWT18d0KF8DgXZGbu8/xz+pALbQ+T
         vCR951JMJHfo14q69GTiM9+Lo5F94xKeA2UlZ6OuVuTfLzl2ZMcnMLnwVyl8D4zM0bfA
         KJnbDEoxANms1VHEUfccJmXNqzoYCeREvQ3qhzSphhIJZHZmzOvPqpLuo9deyK+Da7lT
         0hBLy8Z1XwoGGz5JWWht614yFm4odVliMPtQ5QtzgxcbzPdpH7DNgaJR1xZKJlsD5P1V
         J3AXQSbpPK4faNA4D6mLeLUy/QCxTK9NvnybOrqxohlaHDWb/qhfIfyltRQM6/sbYOhG
         gY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788922004; x=1789526804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZO7tbb4HSzx3MW7qh3I4JqZjxCZe9pXRQ8RRhmehi7c=;
        b=VorEpEYSwCAC16DPgBV0vNz+0zFJHbtz/IWW9QCGQWn72N+9irA2Jj7nUbNzsa/UK/
         BrZPSY8PjaARLhYo7qor9/PMF0aEQLuv7EaA5WU6eJrgwmhfDJmYU+cCr/kX8mc8V/+f
         2AsU25XgJisxLWlj9FvPDCbBRq0kQ/gqIjotytTPZhhQkCJEPLB1DrSMC9jlnxtxikg3
         1gXHqM5VB19wTsh5JdV031kGnBmX6Af3kCOY/mjRGnAJTWPLkndNved1QcA5LcjVaN3W
         AF0UkFpH69w7Yf4Y9Hfzca7hxySOFSfJhZunM3F8n6B7f2HX/4iAupYyV7PfK2XqKG56
         6S8g==
X-Forwarded-Encrypted: i=1; AKwUvBynnlO7FQzObIyxOSBkWxRZ9eyNvaHo60nVshS1E/jhMoGmryMiuWLLk5huKwaztlgVdhEw8Oo=@vger.kernel.org
X-Gm-Message-State: AFuF++m7dJVbSVe4xBauTYd2P3aMQL4ttFc2pi72l7p1Pah1Tzw+XYlW
	pGRBxRfOKAI7pprElzHwFqiqkrUf6hCati5k/gZAwSn/+jUKX+6t0aS1oPKtN374c6Q=
X-Gm-Gg: AYBFou2Lx1RR1wIREM8SLNXkpBOmsNogXMvxRWNe7CNpgPMo/BGPfO6wnyIMZVKMyiI
	36WpP3aKaJJrygGBCwzJF5eivc5+J+Q/Twi2+iYcxTwn/r4+BkKHcxdzroDV8vbsdbpm59oycYN
	uGqbyga06uQe0XLulooQuRomAFj7HSnsbfahLyG9IsDEoybBFwSnRQ9XQ4NMD11rqINvZJ4juSq
	Y69OqPrSNjy7/s1vF2mmL5yuiUfrlBZ/+MBAzasVshQ9jC8Trph92pBMhYHuH5+Tm7Tbx6I73cj
	KMgez9oBteGN5niSpLPxUkLZnnp9MZrZ3hmCR0oC8gY+TMcStLUNHOYxX4CGCELl0dggdyD2Tkh
	FDfATACKUCwAosI9gAUgI0bnFmaFAl61dCWuoC1xkCowav1Sg1s6/08/RDImsF1mfiveQnuyqB1
	vChS4HUIbezDW6izg9QmQ49JSauGZe5gHJXZOdW5eYxAJ8wH55N/PEu/vtqLG+gPT5w1+JGrxUs
	A==
X-Received: by 2002:a05:6a21:6f12:b0:398:8870:b58f with SMTP id adf61e73a8af0-3da3a03ef42mr48516402637.14.1788922003934;
        Tue, 08 Sep 2026 19:46:43 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4554a98fesm5977157a12.30.2026.09.08.19.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:46:43 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
X-Google-Original-From: Jun Yang <junvyyang@tencent.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] sctp: check asoc->base.dead before the RCV_SHUTDOWN break in sctp_wait_for_connect()
Date: Wed,  9 Sep 2026 10:46:23 +0800
Message-ID: <20260909024626.3494588-1-junvyyang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sctp_wait_for_connect() sleeps with the socket lock dropped, so the
association can be destroyed underneath it: an out-of-the-blue ABORT
answering the INIT is drained from the backlog by that release_sock() and
ends in sctp_association_free().  The loop does revalidate the association
after waking, but the (sk->sk_shutdown & RCV_SHUTDOWN) break is evaluated
before all of those checks and leaves the loop with err == 0.  A concurrent
shutdown(fd, SHUT_RD) - inert on a one-to-many socket, where it only sets
the flag - therefore makes the function report a dead association as
connected, and the sctp_association_put() on the way out drops the last
reference.

sctp_sendmsg_to_asoc() trusts that 0.  Commit c863850ce22e ("sctp: not free
the new asoc when sctp_wait_for_connect returns err") turns a failure into
-ESRCH to stop exactly this double free, but it only covers err != 0.  The
freed association is then used by sctp_datamsg_from_user() and
sctp_set_owner_w(), and destroyed a second time by sctp_sendmsg().

Test asoc->base.dead at the top of the loop, as commit ca3af4dd28cf ("sctp:
do not free asoc when it is already dead in sctp_sendmsg") already does in
sctp_wait_for_sndbuf(), so a destroyed association always leaves via
do_error.  Keep the existing return values rather than adding an -ESRCH
escape, since sctp_wait_for_connect() is also the return value of connect().
base.dead is false on the first iteration in both callers - the socket lock
is held until the first release_sock() - so nothing changes for a live
association.

Reproduced on v7.3-rc2.

  refcount_t: addition on 0; use-after-free.
  WARNING: lib/refcount.c:25 at refcount_warn_saturate+0xf5/0x110
  CPU: 0 UID: 1000 PID: 261 Comm: poc 7.3.0-rc2 #1
   sctp_association_hold+0x96/0xa0
   sctp_sendmsg_to_asoc+0xc76/0x1c60
   sctp_sendmsg+0x11c0/0x1ee0
   __sys_sendto+0x3e7/0x470

  list_del corruption, ff11000104fa2070->next is LIST_POISON1
  kernel BUG at lib/list_debug.c:56!
   sctp_association_free+0x80/0x7c0
   sctp_sendmsg+0x199f/0x1ee0
   __sys_sendto+0x3e7/0x470

Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_interleave")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A reproducer for this issue is available if requested.

 net/sctp/socket.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..de4bae94c9fa 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9400,12 +9400,16 @@ static int sctp_wait_for_connect(struct sctp_association *asoc, long *timeo_p)
 	for (;;) {
 		prepare_to_wait_exclusive(&asoc->wait, &wait,
 					  TASK_INTERRUPTIBLE);
+		/* The asoc can be destroyed while sleeping below, and the
+		 * RCV_SHUTDOWN break reports success, so check it first.
+		 */
+		if (asoc->base.dead)
+			goto do_error;
 		if (!*timeo_p)
 			goto do_nonblock;
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			break;
-		if (sk->sk_err || asoc->state >= SCTP_STATE_SHUTDOWN_PENDING ||
-		    asoc->base.dead)
+		if (sk->sk_err || asoc->state >= SCTP_STATE_SHUTDOWN_PENDING)
 			goto do_error;
 		if (signal_pending(current))
 			goto do_interrupted;
--
2.43.7

