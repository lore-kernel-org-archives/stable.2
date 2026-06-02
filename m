Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC88374197;
	Tue,  2 Jun 2026 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432206; cv=none; b=J+87eixI+in2hmsxyLvnqpRw/00Mx1yokk9BscxqfnhvJCKRrG1PYY5GstpZHacDaUoRozJe27UCTTzzxgUb6bZp3/ECYyEBWePxH96kdcEhyiv80reMgmA87h+uU/7sgx2CpeYallm4NYR47kvlbKnU/+LvEFKUOz5BikVRoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432206; c=relaxed/simple;
	bh=i5SYj9i5cHbghf1STiHGU3eZPHVCMFJdGY3KBUp68uo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pyoWyZi21WMMNLpC7WC/8cOYJNYnbBcjtwW8JvHE0Dn9uFZnlgM6XTFdyqtES9dAqPcsvFcsocSwH7B/uLPmIYQHOGTaN3ZEDaNJxlhjCdSMIu4XOrVz24V5Uvhq2+mWT+m7IikNO6BtKu/UB+64gxv+vUfG7AyDSr7hi6G1vdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M0ljdZRS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QfBVUyem; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0ljdZRS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QfBVUyem"
Date: Tue, 02 Jun 2026 20:29:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780432201;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JT2id3ot+ZX883mnmhQb7WXFAiH8vnsMDSo9XQXC4NE=;
	b=M0ljdZRSeZxBx7w93y5ldroTZbYNZRj4ZUW3UUHmpJjJhL7K/xa7V5wtjayax6eHJhT4jz
	2tPHSh4IlLPieKLeKjopSiVJTH3aNnbpv03EmB7MZP0ji1q1Lq3R77MW8uyNNMcC8zuFaK
	hMt4vqv1Pl+JMZcL4LYAoMTjSVLu1C1fBUUYPCfqNdKTiACY1hpJplhvl4JpKpBL15WsLg
	loewPbAfIiSGmeMgQwn8dAKkeKWlp+j90uL4uzxmaAW2ZOPMzOZxZgfaTf2AU6enZef8fY
	oEst4MNt9ZvLVl/OSTWUxBGv8BwFRVuYcGrry07k6Qi/v301ZTqqHf9uCrPdaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780432201;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JT2id3ot+ZX883mnmhQb7WXFAiH8vnsMDSo9XQXC4NE=;
	b=QfBVUyemRzu983NIdBFqkdX0GVKtA6sV1LqPeKQk22xtC0Dv8U/kJ5MUUW64hwDPGwqMAs
	OuduSmrp3v9pdMBg==
From: "tip-bot2 for Ji'an Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex/requeue: Prevent NULL pointer dereference
 in remove_waiter() on self-deadlock
Cc: "Ji'an Zhou" <eilaimemedsnaimel@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178043219965.710.14371056919722189579.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     74e144274af39935b0f410c0ee4d2b91c3730414
Gitweb:        https://git.kernel.org/tip/74e144274af39935b0f410c0ee4d2b91c37=
30414
Author:        Ji'an Zhou <eilaimemedsnaimel@gmail.com>
AuthorDate:    Tue, 02 Jun 2026 09:12:04=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 02 Jun 2026 22:27:04 +02:00

futex/requeue: Prevent NULL pointer dereference in remove_waiter() on self-de=
adlock

When FUTEX_CMP_REQUEUE_PI requeues a non-top waiter that already owns the
target PI futex, task_blocks_on_rt_mutex() returns -EDEADLK before setting
waiter->task.

The subsequent remove_waiter() in rt_mutex_start_proxy_lock() dereferences
the NULL waiter->task, causing a kernel crash.

Add a self-deadlock check for non-top waiters before calling
rt_mutex_start_proxy_lock(), analogous to the top-waiter check in
futex_lock_pi_atomic().

Fixes: 3bfdc63936dd4773109b7b8c280c0f3b5ae7d349 ("rtmutex: Use waiter::task i=
nstead of current in remove_waiter()")
Signed-off-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/futex/requeue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b597cb3..1d99a84 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -643,6 +643,12 @@ retry_private:
 				continue;
 			}
=20
+			/* Self-deadlock: non-top waiter already owns the PI futex. */
+			if (rt_mutex_owner(&pi_state->pi_mutex) =3D=3D this->task) {
+				ret =3D -EDEADLK;
+				break;
+			}
+
 			ret =3D rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
 							this->task);
