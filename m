Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792964843;
	b=ceF+gSb78Y85o1b0SYKwWwKq18z8ZXRG1rk2g+sSbJqmb084TV4CE5cyauB6m5aE/Vy2
	 CNve+psuk1QZZ7hAxY+2btG32N796/0KbPjWIeR4ftr/DXBWsZmI5HV5CnLE4NmEP9ASR
	 mn5+3ZhB6eleDAE6Kcb4QfcD+CI6J2OTDbH4kCj1yitsJ4SC+VW0LhncG+KZpNmuqirD+
	 HktUNsssj+b6uME8e3LK5pC+5a6OFb6pUsEOAtNrRLiPmpG5GjxVqDbOisoILWjuyZuxG
	 0IGI9Iw3RRFC7WXQTmLBCDjH8Pqn/4CP/NXtVUoBbOzEdFv+NBmP1cBkKqZeqOOI7CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792964843;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=i9B7tXH2AzrLW0vuwkVrMR3kkLydQ1d8KYQRN5oSqWU=;
	b=UuJ1akCPXOYJcL9iH1HbAK8vtjHLViSXYk4rInuP/GEJMgGTpCVM6/tplDutn1vx573Z
	 jIfMsJ/X4D/kb8oh8eEkkMn5vqc1jHvWMBsGZtPIS3rRrSUS817q5uy64w8Mh/P0y+Min
	 ehoj0Hvh/SgatiTfFwkYHfuMOBQiuUnv7G7p5yXOBSOK271ZR3E5HpnzxRiDcNRKHAdkw
	 SUHNtqbuD3RHdmAuwJQWwddxIOQX7WGpxB+PNERoW96kim1E1XyvcjOtDkGeXKnadVQp9
	 UbLuBxQdLzCW4WgYh2fAitmrXqOj3haGpdAnzZ622KHrsHopAXkhH90iD1bRGOhHzeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HgFGxxou;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8+E1ZHZp;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65886606A336;
	Sun, 25 Oct 2026 21:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65886606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HgFGxxou;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8+E1ZHZp
Date: Sun, 25 Oct 2026 21:47:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792964839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9B7tXH2AzrLW0vuwkVrMR3kkLydQ1d8KYQRN5oSqWU=;
	b=HgFGxxouUocHuPzP3US//33HzqlqYwPeZPeh3OkKi30s5rZ+9GB73po2QNrL723dkRpd9Z
	MO5z2NluhErzB/WBy01A0QSOMOSRkHMTk4ZozZJvWI6Q4KzOO3/dM3Uh6kHY5bqiMp6NOR
	P9mzzT/zKIKPtsrtHK8r3h/0Xre5cviuvS/pzTk6w3IZqHh0Q6qUs5UQJgSpOs7PkiEXhD
	h4UoLryuQVGwPuCA0XGTJbYT25i4//xer2tUztD62Z7htsPT1rhxWXJPJo9+rpcui6vGvU
	oiSQSLC88wUryoMAb6cwSOiK9M3Dy/bTGUyV9BX9/310HdC7NwJb9RUAaCZ+cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792964839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9B7tXH2AzrLW0vuwkVrMR3kkLydQ1d8KYQRN5oSqWU=;
	b=8+E1ZHZpz1XTL3WmjusUBMgqVLHqmonayNBycAHg/RVwmF2l6Nfg3ZwPHg02Ss3t/hUvVu
	3KLdDlBfk+uP84Bg==
From: "tip-bot2 for Hungyu Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] posix-timers: Accept NULL clock_getres() output in stubs
Cc: Hungyu Lin <dennylin0707@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261020161121.85042-1-dennylin0707@gmail.com>
References: <20261020161121.85042-1-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179296483844.4109677.8357415934692809026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     5b819071e4346256c4edbae5cc2095dff25694fc
Gitweb:        https://git.kernel.org/tip/5b819071e4346256c4edbae5cc2095dff25=
694fc
Author:        Hungyu Lin <dennylin0707@gmail.com>
AuthorDate:    Tue, 20 Oct 2026 16:11:21=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 25 Oct 2026 22:43:19 +01:00

posix-timers: Accept NULL clock_getres() output in stubs

With CONFIG_POSIX_TIMERS disabled, clock_getres() returns -EFAULT for a
supported clock when the result pointer is NULL. POSIX permits a NULL
result pointer to suppress returning the clock resolution.

Only copy the result when a destination is provided, in both the native
and time32 stubs. This matches the full POSIX timer implementation and
preserves clock ID validation.

Fixes: baa73d9e478f ("posix-timers: Make them configurable")
Fixes: d822cdcce43f ("posix-timers: Move compat versions of clock_gettime/set=
time/getres")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020161121.85042-1-dennylin0707@gmail.com
---
 kernel/time/posix-stubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 9b6fcb8..5a27335 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -83,7 +83,7 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,=
 struct __kernel_time
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_timespec64(&rtn_tp, tp))
+		if (tp && put_timespec64(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
@@ -166,7 +166,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clo=
ck,
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_old_timespec32(&rtn_tp, tp))
+		if (tp && put_old_timespec32(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
