Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776935DA7B;
	Tue, 18 Aug 2026 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043412; cv=none; b=Kc4phiF5bF6sC9Z2ArxntfFGf96N2zyfkzPhbzMdEIg+W0NirBrxr03G88O58ZOnkA4nQX3XiOzppmWQK1nZWQ9SD/DPwJzyD29Usm0w0QJxVYcm/HyKsEixyyqS6Xp2ZAJP66Uz1L6WytbeS+lySIGmN3WjPVrgzXGz5pILQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043412; c=relaxed/simple;
	bh=rGO72Nu3u3y59i6C77GnLE8GqGgMgPtMsemmQWxPX3I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ppjRKrg/g97IP2AalqR7LDWtg9Ly343hd0oDZ3y9cPcUB1pnO7NdneaYuLk2KxgL/dSTjG/HCRweYpORszh5LJzE7sLVnmOko9oBfF6aH52AfRKmJaL43cqpJJN3p+I0uzmfF25nZYKXEE+HoL5rmxwX3TPseIJHhkham5ukGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CVHhtU8m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iihNEubs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CVHhtU8m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iihNEubs"
Date: Tue, 18 Aug 2026 08:56:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787043401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlyxpcd3AxqgdzdJIfA5KIIkNn8sIPxtRHQXBl0W0Ew=;
	b=CVHhtU8mAPjxBry7Jh2iwtCLS93ZPCDOjpLMV1sDUq+vOaGyBviHK9yuyZJahs8elXC0W/
	OaRrjx+Kjb1R8Uz3VGikNfuXZW7W0wqc4ZWd3hmnunvCMQ8akdxqLy6pfpe0nyJcz45a1b
	QEHbFrFkKT9u18VgCcTQiantNNUIwfw+17guGJHbOFGR7fEmqoVjmaklYgK2JlkOQOcCFa
	edHAEFJPaG6i2TmlALhQpy9WvaqF8LS9bFlcPmYBPBUrj+qbVjyEf0zPfcCWUWiOxgjeQ6
	lhZHVfhn0JLfJMoXlsFOLKpQpTVtT6ZzDjXXT18B1BmxxiLe6Iw8O9XqM/8tuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787043401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlyxpcd3AxqgdzdJIfA5KIIkNn8sIPxtRHQXBl0W0Ew=;
	b=iihNEubsfUD4FhOk+3QKUyCawyvYxQvpi24Al3OfOsZprTCx1fyEAAF9u2TBmwJp65QMq4
	j3IcLquFG65pmtDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] timer: Keep debugobjects state consistent in
 migrate_timer_list()
Cc: Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87bjb0l7ha.ffs@fw13>
References: <87bjb0l7ha.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178704339949.1542179.13819936766894002577.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     c793bbfc4a0a9f5a66978fc91559e9681748dbeb
Gitweb:        https://git.kernel.org/tip/c793bbfc4a0a9f5a66978fc91559e968174=
8dbeb
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 18 Aug 2026 00:14:57 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 18 Aug 2026 10:51:43 +02:00

timer: Keep debugobjects state consistent in migrate_timer_list()

When timers are migrated away from an offline CPU the debugobjects state
gets corrupted. The timer is accounted as inactive on deletion, but the
enqueue on the alive CPU lacks the activation call.

That used to work, but got broken when the trace point and the debug
objects call got separated. That change missed to fixup
migrate_timer_list().

Add the missing debug_timer_activate() invocation to fix it.

Fixes: dc1e7dc5ac62 ("timer: Move trace point to get proper index")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/87bjb0l7ha.ffs@fw13
---
 kernel/time/timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 655a8c6..ae9abf1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2492,6 +2492,7 @@ static void migrate_timer_list(struct timer_base *new_b=
ase, struct hlist_head *h
 		timer =3D hlist_entry(head->first, struct timer_list, entry);
 		detach_timer(timer, false);
 		timer->flags =3D (timer->flags & ~TIMER_BASEMASK) | cpu;
+		debug_timer_activate(timer);
 		internal_add_timer(new_base, timer);
 	}
 }
