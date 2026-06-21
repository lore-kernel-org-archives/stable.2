Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B7423A99F;
	Sun, 21 Jun 2026 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782067615; cv=none; b=EUTXOp7Z1qHdsmy1fHF/26qMyf6UJjx+hdHMl5VVgaYEAMNlZNDzop3ByQI8uVdOsL32rawRgJua+8p3H1xdexKPwiVen/V0AqdXYrFr0JUpiR0ujBtGZYQrLOeXAyD2R6AyKVEASp9uL5mTjiOuzgsCUU9mAT3/0W4OKeP7BGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782067615; c=relaxed/simple;
	bh=bsaXozOlFtQLOff54MxvFMSE/NC3fOX2WCCYF6g0RiU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OxVjcyPmgRU6kuJPTHqJZxpopniprA7JeN3flXHyQ63cu+DqxePwT87D3L2/p6aHe93L/OdulehTGS53mBthYPgTjKOsXg1siaxo4JOZl+dgi+dTf3Z6YBZ5AoMh9yS9Bsrh8CbBeSktL9jmTghfUjx7mIUyVRmJkj2v+tvD5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pOXh6p/a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=300V/f4B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pOXh6p/a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="300V/f4B"
Date: Sun, 21 Jun 2026 18:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782067606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JnEArZozBKZQRQM6LoKdX6St8L1j9Kmrh3b24zqzSC8=;
	b=pOXh6p/aSkomxtAI3R9B7JlFAky+WpeCgVkrRdLRS9NMe5ckHbB0Odc7n1e01lpRpP4GkR
	2TC9WmcV713N0/zMY1jzweWwCjat8Z3PiMKgZpohptpr6jF4jL05yan7sHu0Ba1XGmJnDJ
	oVh0fTkThijUHkdg3E08kBk0LcvwvOKg4Bs8xsGKgc8mN7ayyVsESABvIZiC0JBESaQlu2
	hZ5M6p4U39jTR9dbik7XT2MPvhTJ7nPE3OoYMiceieJMoJfMLq0aLBekGg26mq5xff9iPZ
	KD45ACfwRMPNNTAvUifUR7OJ6QFXQcfY44zDfgkeozQVxJPNgwfA1GeJ/Y3lGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782067606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JnEArZozBKZQRQM6LoKdX6St8L1j9Kmrh3b24zqzSC8=;
	b=300V/f4BvTw11YBtoQAq7uf9a0tymUvskKeD1NF1A1FtRccOmKs//YG4WgZGth7MSodYYC
	GajSuuueRTOh63Ag==
From: "tip-bot2 for Bradley Morgan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] cpu: hotplug: Preserve per instance callback errors
Cc: Bradley Morgan <include@grrlz.net>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260619163719.12103-1-include@grrlz.net>
References: <20260619163719.12103-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178206760461.2745857.6453349457246781207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     673db10729fb121ea1b16fe57791a0cb9eac1eb5
Gitweb:        https://git.kernel.org/tip/673db10729fb121ea1b16fe57791a0cb9ea=
c1eb5
Author:        Bradley Morgan <include@grrlz.net>
AuthorDate:    Fri, 19 Jun 2026 16:37:17=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 21 Jun 2026 20:44:00 +02:00

cpu: hotplug: Preserve per instance callback errors

cpuhp_invoke_callback() unwinds earlier callbacks for the same
hotplug state when one instance fails. The rollback path currently
reuses ret, so a successful rollback can hide the original error and
make the failed transition look successful.

Keep the rollback result separate from the original error.

Fixes: 724a86881d03 ("smp/hotplug: Callback vs state-machine consistency")
Signed-off-by: Bradley Morgan <include@grrlz.net>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260619163719.12103-1-include@grrlz.net
---
 kernel/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8df2d77..3ed24c7 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -175,7 +175,7 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum c=
puhp_state state,
 	struct cpuhp_step *step =3D cpuhp_get_step(state);
 	int (*cbm)(unsigned int cpu, struct hlist_node *node);
 	int (*cb)(unsigned int cpu);
-	int ret, cnt;
+	int ret, cnt, rollback_ret;
=20
 	if (st->fail =3D=3D state) {
 		st->fail =3D CPUHP_INVALID;
@@ -239,12 +239,12 @@ err:
 			break;
=20
 		trace_cpuhp_multi_enter(cpu, st->target, state, cbm, node);
-		ret =3D cbm(cpu, node);
-		trace_cpuhp_exit(cpu, st->state, state, ret);
+		rollback_ret =3D cbm(cpu, node);
+		trace_cpuhp_exit(cpu, st->state, state, rollback_ret);
 		/*
 		 * Rollback must not fail,
 		 */
-		WARN_ON_ONCE(ret);
+		WARN_ON_ONCE(rollback_ret);
 	}
 	return ret;
 }
