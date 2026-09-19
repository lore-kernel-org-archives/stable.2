Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAB339B41;
	Sat, 19 Sep 2026 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851608; cv=none; b=Vli95vAo5vZVP9SHMG/VI9ZqB3Ewqxj164o3Jc/p9jz9dldgxhhq7fVzxDXCX/wlw5nlf2RN+wphZmj7zBcwDu9uzVZyYJlE6bWuyTsnRK+Jd1sJBrIub6nImdsb8zBcsQJ0ZLsc9xzon27R2f1ARJOsXEY5favOb2aS9YS0OTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851608; c=relaxed/simple;
	bh=vU3Ky9Y1yuB97VMU8A7vEJ50Ntl5ut7d5+Q0g1WNnHM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IDqk70et5FaWmW815EDQ/EBXX2croA8Zyt0Rvk1wjbU2G0CinxE5MbQLNw+ZKZoNWAGoGV1F2j0gcRFsqxsjMqBd///Bm1KtiZP01V0idPd90q3L5QkRGqbuFdqn0ZYtTEMx4LfANL3mTy/yDvXmV5riWpdCZguyxqiBpl9HGoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mlAZhsEJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0gTXYrZS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mlAZhsEJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0gTXYrZS"
Date: Sat, 19 Sep 2026 20:59:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789851598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=n26Gp2HxexvhPVyY3zHAGJFG0S+vIEf2FkOTnT/Yr8w=;
	b=mlAZhsEJdK9JTMUZ+XbUkGFb2kmatME6rHAyP39xDpeJuAiBgj/MlaCBzUHOAlobut+sy+
	VlJ6gyR0Oie2RyZdnGY+t3KNOU3/VNCFvbw9rwzsJzRXE0rNSa4aS1aOLS7Xfs0jcegtE0
	U2ha4T6iKiRCYpmoQVWi46AFYaANr1TDofw3LJ1stWFy/txyoZ67AwwBz7RezKU1bjso0a
	WdIXey+hup8nURoWoNUAT92z1Dylf6zONnXzybOJio7yr1FAMQN+s2e1D2vO4S/JODlEgt
	iZtZO9kOwngq7135lz1GSMU4Ce30QeVs+klUlMP9qW4SQFtctrvLSzoSkd8dDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789851598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=n26Gp2HxexvhPVyY3zHAGJFG0S+vIEf2FkOTnT/Yr8w=;
	b=0gTXYrZSQ4eIJWbQFqf/WvKa+eIUq0N3bRmtYjQKTw25Lmn+Xen3nVpr7I5STYBYKW8tb5
	XLrsi2xwnNNVCIDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-cpu-timers: Prevent freeing a timer which
 is queued on the expiry list
Cc: Kijo Park <red993688@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178985159690.2819794.12787056098231534809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     c21eaa72f02fc6e85621cbe09d303d8fb8bd39cd
Gitweb:        https://git.kernel.org/tip/c21eaa72f02fc6e85621cbe09d303d8fb8b=
d39cd
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Wed, 16 Sep 2026 20:48:30 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sat, 19 Sep 2026 22:56:22 +02:00

posix-cpu-timers: Prevent freeing a timer which is queued on the expiry list

Kijo analyzed another race in the POSIX CPU timer code:

Commit bf635681c906 converted cpu_timer::firing from a tristate value to a
boolean. This lost the distinction between "not owned by the firing list"
and "still owned, but delivery was canceled". The resulting race is:

    expiry handler              timer_settime()        timer_delete()
    --------------              ---------------        --------------
    collect timer onto
    private firing list
    firing =3D true
                                observes firing =3D true
                                firing =3D false
                                return TIMER_RETRY
                                wait for handler
                                                       observes firing =3D fa=
lse
                                                       finish deletion
                                                       unhash and free timer
    resume list traversal
    read freed elist.next
    -> UAF

The firing bit is clearly the wrong indicator since that commit.

Check whether the timer is queued on the expiry list or not instead. If it
is queued clear the firing bit to prevent signal delivery as before and
return TIMER_RETRY so the caller unlocks the timer which allows the expiry
code to make progress and remove it from the list.

Fixes: bf635681c906 ("posix-cpu-timers: Cleanup the firing logic")
Reported-by: Kijo Park <red993688@gmail.com>
Debugged-by: Kijo Park <red993688@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Kijo Park <red993688@gmail.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/time/posix-cpu-timers.c | 40 ++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index d73d31c..0bf4fcd 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -408,6 +408,7 @@ static int posix_cpu_timer_create(struct k_itimer *new_ti=
mer)
=20
 	new_timer->kclock =3D &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);
+	INIT_LIST_HEAD(&new_timer->it.cpu.elist);
 	new_timer->it.cpu.pid =3D get_pid(pid);
 	rcu_read_unlock();
 	return 0;
@@ -566,6 +567,24 @@ static struct task_struct *timer_lock_sighand(struct k_i=
timer *timer, unsigned l
 }
=20
 /*
+ * If the timer is queued on the expiry list, then it cannot be dequeued bec=
ause
+ * the firing list is not protected by sighand->lock. The delivery path is
+ * waiting for the timer lock. So go back, unlock and retry.
+ */
+static bool posix_cpu_timer_on_expiry_list(struct k_itimer *timer)
+{
+	if (list_empty(&timer->it.cpu.elist))
+		return false;
+
+	/*
+	 * Prevent signal delivery as there is no point in delivering a signal
+	 * which is made obsolete right away.
+	 */
+	timer->it.cpu.firing =3D false;
+	return true;
+}
+
+/*
  * Clean up a CPU-clock timer that is about to be destroyed.
  * This is called from timer deletion with the timer already locked.
  * If we return TIMER_RETRY, it's necessary to release the timer's lock
@@ -580,18 +599,10 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 	p =3D timer_lock_sighand(timer, &flags);
=20
 	if (likely(p)) {
-		if (timer->it.cpu.firing) {
-			/*
-			 * Prevent signal delivery. The timer cannot be dequeued
-			 * because it is on the firing list which is not protected
-			 * by sighand->lock. The delivery path is waiting for
-			 * the timer lock. So go back, unlock and retry.
-			 */
-			timer->it.cpu.firing =3D false;
+		if (posix_cpu_timer_on_expiry_list(timer))
 			ret =3D TIMER_RETRY;
-		} else {
+		else
 			disarm_timer(timer, p);
-		}
 		unlock_task_sighand(p, &flags);
 	}
=20
@@ -731,14 +742,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, i=
nt timer_flags,
 	/* Retrieve the current expiry time before disarming the timer */
 	old_expires =3D cpu_timer_getexpires(ctmr);
=20
-	if (unlikely(timer->it.cpu.firing)) {
-		/*
-		 * Prevent signal delivery. The timer cannot be dequeued
-		 * because it is on the firing list which is not protected
-		 * by sighand->lock. The delivery path is waiting for
-		 * the timer lock. So go back, unlock and retry.
-		 */
-		timer->it.cpu.firing =3D false;
+	if (posix_cpu_timer_on_expiry_list(timer)) {
 		ret =3D TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
