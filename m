Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B564317145;
	Thu,  2 Jul 2026 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023547; cv=none; b=W32l1Y+ofiifibINAq2ZmrVHzKXZXMttiTJ7HYNVWBwcec9j5oBfO5rJV6bZnMyFl/23aEyLnuamiMZS9JOD9JdhKJM9u7tb6IlPoS26FcMdr8/Da3yhC/xvJL0W4ElRCYQxgiEeDHOzqxTjtFL5EgfMjN80nC0gS+NVoJu/R4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023547; c=relaxed/simple;
	bh=qexeE/2gTnXvkaqyzrBOKAnhdyFue8P22dcPUPQvgoQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MZ+1OJDNEA1yJkuE4NsDN4qCzscUNT7XaE4WF7kt+2vGqnjSmOhl499jhZw2D/gPvtwDJtm1qJJ91zXIF0t0nueG3NARvicVfLf3mLu5xPZvQ+9N4AOAkLzt3U6WV9dbZhIZKbjjsLZIcr5zu3Nly6XbU00J9pvC6cz+fyCBRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k+Cfut7P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACaXtwOp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k+Cfut7P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACaXtwOp"
Date: Thu, 02 Jul 2026 20:19:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783023544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjA4peB+gYdpEvyNe7XePqEWTyZBGMyiDYlW239HnrU=;
	b=k+Cfut7PEIORkypnWpNuRXDBUtxxDvQNsPe+HT8nnNPAk/xJs/Fok7dNy4nS1uOjZl67gn
	zl4ui6GSaHefgsZ426tDJjyNBEHj7YzNcbioj7k1/8qi6V/MBaHc8SrHI4mSNxeGABIPfP
	IFCD72kkKq09aRhnj2qqGHDUOzkQtbrZhoe3UfkoWkSUe6Uw5m28WM3Ct7c+8y9by18bAP
	u2stpSsAICDJPBvJCUN7cQTHYDM9lH28K0wE3k0u+wE6p4mxSat4/Uq55Z23k6MAw9jKF2
	pUH+6IJC0r7yGxhvyETAHrV//kJctU0uX+Jq+fTCup+bamBrJ0l3l0A77pulHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783023544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjA4peB+gYdpEvyNe7XePqEWTyZBGMyiDYlW239HnrU=;
	b=ACaXtwOpuF9XgnY2M1A70ZQLDX0t9XPE7uLD/8x6+hpPnwtM/fLmPg3KxU6cLGAIy6SkfW
	6LI1lHj4hBGPr0CA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex/requeue: Revert "Prevent NULL pointer
 dereference in remove_waiter() on self-deadlock""
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260701131150.0Ijhq4Dw@linutronix.de>
References: <20260701131150.0Ijhq4Dw@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178302354241.3843924.17363437869359149725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     39def6d250d370298f86c116f4ac60093cefadaa
Gitweb:        https://git.kernel.org/tip/39def6d250d370298f86c116f4ac60093ce=
fadaa
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 01 Jul 2026 15:11:50 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 02 Jul 2026 22:14:08 +02:00

futex/requeue: Revert "Prevent NULL pointer dereference in remove_waiter() on=
 self-deadlock""

The commit cited below should not have been merged. It attemted to fix an
existing problem ansd thereby introduced new problems by keeping the
pi_state in state Q_REQUEUE_PI_IN_PROGRESS and leaking it.

Based on the commit description the intention was to handle the case
when task_blocks_on_rt_mutex() returns -EDEADLK and the following
remove_waiter() dereferences the NULL pointer in waiter->task.

That is already handled by Davidlohr in commit 40a25d59e85b3
("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued") and
requires no further acting.

Revert the commit breaking the "waiter =3D=3D owner" case again.

Fixes: 74e144274af39 ("futex/requeue: Prevent NULL pointer dereference in rem=
ove_waiter() on self-deadlock")
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260701131150.0Ijhq4Dw@linutronix.de
Closes: https://lore.kernel.org/all/20260629020049.2082397-1-michael.bommarit=
o@gmail.com
---
 kernel/futex/requeue.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 7384672..79823ad 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -645,12 +645,6 @@ retry_private:
 				continue;
 			}
=20
-			/* Self-deadlock: non-top waiter already owns the PI futex. */
-			if (rt_mutex_owner(&pi_state->pi_mutex) =3D=3D this->task) {
-				ret =3D -EDEADLK;
-				break;
-			}
-
 			ret =3D rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
 							this->task);
