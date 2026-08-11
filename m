Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E444682B;
	Tue, 11 Aug 2026 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456083; cv=none; b=k0i7/FZg7T9Mi7dRi/ROKQXkxhnSJeQctwTR+bfPKB3Q1dLHyjPDsfQt9yJYgODpmuqQckV5arqJdVNSE5vJxstLZxmLieZhgIfTgaVDL4UATzP82CBpskQQNtCkIHPNYarFVyDmxh9a3Usuy8P8dRKImkCuvqOlcnpVp8mvYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456083; c=relaxed/simple;
	bh=GmK2apw3TNF0IzPg0EBksgdyJOCP1fuqk4+cV672RN8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dsUta51SIycvpNUNozfMTSgE4yP2Y21dy2fdzqihOqcMncx7T0iQWLZ2pnreXvU2AQ6K2unzDSPHFgBLUua3g10qSkyB9dc/2vHKEiIRuVnrRt937iK3PSAxCLhF4ylZaQLdF3kzXStXSOv8862veR2AmLGa7RUyH4Txk0c1ZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5ikw+h4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bBccT7yV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5ikw+h4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bBccT7yV"
Date: Tue, 11 Aug 2026 13:47:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786456066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdiehF+rwookk3F6NmowQRMmZlX6z+VgrWEoEb52LmM=;
	b=Y5ikw+h4aIbXF+G6YVlwKkgzTAL9P5yOLZHJ7WEls8xThKwYRyMbIwxXdyp41c+O0O0gLL
	jq3ePtn7jVJlq9HZ1qha3jcZAMrkOD6/8MTQxIckEOtSo/4EQprQzs5DNHZpKTkfFl5rjh
	8elcwH+dNQalYJ+yLlsFm/jf7bfPUKhbqScgJU6D92mkVO9QQ2KhsB9VYBkfh5nGd7LZvs
	RhG7fKfUvp8XB+58NUBFyoJFFXR/uWawa/zStWwW/Tv66uwslNI9Aq8/LI34g2ga8FzPQZ
	IisqdwIK+txKXoF3mvdGxCU9Qv2+nuL9i2tVSwjgj3gPQ0vhFUEsZEoM6dy6QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786456066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdiehF+rwookk3F6NmowQRMmZlX6z+VgrWEoEb52LmM=;
	b=bBccT7yVKMwn1d9zmNCFtYTGc7BBkbL4bHcPEPlCGkjf5u962g5ySft+WhISOVGfa/fcUN
	76Ar2MACNvwFYJAA==
From: tip-bot2 for =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/itimer: Zero-init old itimerval before copy
 to userspace
Cc: Jeremy.Jean@oss.cyber.gouv.fr, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260809190428.1523014-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260809190428.1523014-1-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178645606445.442315.15832880596325645724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     18c7d85864e554adc8fad1e8d2e9d2cb6c3911c8
Gitweb:        https://git.kernel.org/tip/18c7d85864e554adc8fad1e8d2e9d2cb6c3=
911c8
Author:        J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
AuthorDate:    Sun, 09 Aug 2026 19:04:16=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 11 Aug 2026 15:43:12 +02:00

timers/itimer: Zero-init old itimerval before copy to userspace

On native sparc64, struct __kernel_old_timeval contains a four-byte hole
after tv_usec because tv_sec is 64-bit while __kernel_suseconds_t is 32-bit.
put_itimerval() fills only the named fields in a stack-allocated
__kernel_old_itimerval and copies the entire object to userspace, so
getitimer() can expose the two padding holes.

Zero-initialize the aggregate before assigning the fields so implicit
padding is deterministic before it crosses the user/kernel boundary.

Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Assisted-by: Codex:gpt-5
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260809190428.1523014-1-Jeremy.Jean@oss.cyber=
.gouv.fr
---
 kernel/time/itimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 7c6110e..03a32df 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -100,7 +100,7 @@ static int do_getitimer(int which, struct itimerspec64 *v=
alue)
 static int put_itimerval(struct __kernel_old_itimerval __user *o,
 			 const struct itimerspec64 *i)
 {
-	struct __kernel_old_itimerval v;
+	struct __kernel_old_itimerval v =3D {};
=20
 	v.it_interval.tv_sec =3D i->it_interval.tv_sec;
 	v.it_interval.tv_usec =3D i->it_interval.tv_nsec / NSEC_PER_USEC;
