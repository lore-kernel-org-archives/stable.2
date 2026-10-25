Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792964841;
	b=Rx/V2ETYt7OulCPhpce9W3Rm9A3uEehKJGCR6IOk7cf+7j1nn5u1YdApuHTODTib76Tf
	 WwZTSSbFRAPFyeJgN465bF5EVnK8u2xJYDg7XAuO4AJLpuD8jVWJ9WxyvreIIh+PetYFS
	 Q/ZqVrObwnj/jb/31aGm5sAByxo7UZKwb935eVOR3JqrHnZGVHYIEgZysUEM8pIEWicy0
	 FhY1TCvCRgr3hm2YZ6ANYmls2kjc2zTPYvG0rXwldt3aVueVBmXYtk6cdYFoqzYrXHvkT
	 plmdtWVc9wo/qXO7Dr5NIFbfH1+r80b1ZTZPXfR4xK9LAjZHLtYIsh2yURPDYVE844Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792964841;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=EzJXTChK18OLYmyzG6WMr93vRlPcJzOkQ1c0SwxLtfc=;
	b=O6bHs7XJTkVrGSFaenb105LnS7sW747RLk2ODzcsgZmi6BDFaQKHyIj0gB9z1Q7TH5Ub
	 AOnSm8X1gu/rwbiAvkD3ZfJA9tjAjGnY5aSA1AP6UGL7rejxTZWbLUArSC/PHxV5fGuZE
	 3zVUohZi980Fia2aFoMlt3RNJJunhADmuYoKcIV/PHnHAJ/QDLzCBZ+xKAfZvmUul9mLG
	 HgS6DrwSEzlNp6prBb6b0/vaY2mg3sRm0mp3eQbUfdWolXf3xugIhYHUvItKBbbWUM9Gy
	 /Wlvyts1RLfzPoQucgW8M44S/ISQRoMB/w3usBaohCE06Jnyqpzr5z01P/cK9mS4v4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2tZREvlT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iovcXWSL;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E54606A31A;
	Sun, 25 Oct 2026 21:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E54606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2tZREvlT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iovcXWSL
Date: Sun, 25 Oct 2026 21:47:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792964838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzJXTChK18OLYmyzG6WMr93vRlPcJzOkQ1c0SwxLtfc=;
	b=2tZREvlT/wcaYlrfJKkNI8140xn4RBVbJ9QZbvBTmQX7ysWoVDxdmEwzupx+UeJUi6Omkz
	QvVMC29SPKgBNo0xEUvsoE47XL9qKFGMz+luWzYfAqV5GSlyZlnM/5feYpW/RHqOezDWyu
	bQshkwvWF9hxr4Hgwx6bm2U9ESFdYPqQz+8bK2X6oGeyLwTzrnyVO9kgC9Q23XG4+pOlB4
	ITEARueQ48KJj4a0VdAFISzLWEMb9gpzwINQsmKxMJyT6btVqFyBdU9TZoeNzd4+gJABcz
	zXtkS58LJs0nL/gmeI4+R4px4p2wFXBMAIxw/7DRbqfMDqN8/398IyuHDEBDrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792964838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzJXTChK18OLYmyzG6WMr93vRlPcJzOkQ1c0SwxLtfc=;
	b=iovcXWSLeFlWellawRhBioMuTczHwtX2SSjnSz6GrkGJJWvZRnXt6LaRVAue4gjCZXh0To
	8Ph36UUCtJ7wz8Aw==
From: "tip-bot2 for Hungyu Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timers/itimer: Keep a nonzero value at CPU timer expiry
Cc: Hungyu Lin <dennylin0707@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261020223957.87842-1-dennylin0707@gmail.com>
References: <20261020223957.87842-1-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179296483697.4109677.2336366179934830243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     ef60f61208a30eb5b941b707debdf04517271b4f
Gitweb:        https://git.kernel.org/tip/ef60f61208a30eb5b941b707debdf045172=
71b4f
Author:        Hungyu Lin <dennylin0707@gmail.com>
AuthorDate:    Tue, 20 Oct 2026 22:39:57=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 25 Oct 2026 22:43:19 +01:00

timers/itimer: Keep a nonzero value at CPU timer expiry

get_cpu_itimer() returns a zero remaining time when the sampled CPU time
is exactly equal to the nonzero expiry. This makes an armed ITIMER_VIRTUAL
or ITIMER_PROF timer appear disarmed.

The cputime cleanup replaced cputime_le(), which implements <=3D, with <.
Restore the inclusive comparison so the equality case returns TICK_NSEC,
like the overdue case and set_process_cpu_timer().

Fixes: 648616343cdb ("[S390] cputime: add sparse checking and cleanup")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020223957.87842-1-dennylin0707@gmail.com
---
 kernel/time/itimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 03a32df..f7de397 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -60,7 +60,7 @@ static void get_cpu_itimer(struct task_struct *tsk, unsigne=
d int clock_id,
 		thread_group_sample_cputime(tsk, samples);
 		t =3D samples[clock_id];
=20
-		if (val < t)
+		if (val <=3D t)
 			/* about to fire */
 			val =3D TICK_NSEC;
 		else
