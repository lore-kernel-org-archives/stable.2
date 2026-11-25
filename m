Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598717;
	b=Qsit7XOS2gHIYRcQ7PfUIjY9jmtPjjX5Sr2N5xr/PBA8L2ZKrjXtzwh4ZyS2VteSvKR9
	 L5EeXact28XlOa06ALQR30A0pdrVY0hh5KlTWhSielvOJoOrijTrPfF3biTSklJ2W0wg4
	 y3iN00/lFwOXqt/I2ou6Ru1qf1plbiS4kgEP0my7cplrA/GOfVnSRgfe3ksiJh5/0hAuS
	 KbGreNbpkJhMJZUNxVS68KYiWOAAdMLoKZxtGEYx1wFx5OArTVxxmEURxRaku6aRMSS/5
	 l5mQG1T8so1nrLybEen8ljfBvzhpDlWQEvWTOZUtngnyBoCHycm6OgG34ygaRDraADQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598717;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=F6zxDmiyw68tnYJDhNqSAQQCMytCrP5fwgqP7JgGDXk=;
	b=jzJMx/Gs0/5WuIZIP7eiGOQe4j6lrCm2CeB0ndwp+sehvEg0Z1/14vpmes5GgrGRLjDh
	 t6bkd1V+vvMl5lGbDxAKqNeu44+E8lM+wLZhiN8gYRmMJfIUhtCU4b/FCXGk22H55M24Q
	 c/VkzNpCKYP1Hw9hFQsQzRe6cMwE8xbixpu4eyQ/+pMwAQ9augdckofk6gwyJQj1IOXSm
	 p2z/3f5aJ8KRS/OKqesNSpZ54MoKb9otjNRrZcZKNhpw5P3J4Z3bEDmi7k4q3SRK2o/+r
	 LzaG/uus9KCpfj/UoWR+ZZa6ffLmfl2v8N7ytI+jkKMr4y2Ts9i3jhdNHANp15ejvxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=U2KeOZUt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F214606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=U2KeOZUt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65C71F000CF;
	Wed, 25 Nov 2026 09:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598716;
	bh=F6zxDmiyw68tnYJDhNqSAQQCMytCrP5fwgqP7JgGDXk=;
	h=Subject:To:Cc:From:Date;
	b=U2KeOZUtp15LRBzkPJOSG1UNmoqSqkIg01j86wxNBOSKtZavNW+drcw3vJBCy5137
	 KXSv6mSAU4IDvsXBLT/5ksFBVXCdIL0hly27jllF5GT0zPCveJgyQq3PVT9uy7so2c
	 nTPFzwVLJ0yKCMCAHifB2IMdLvt0HXuKrAB6YcWM=
Subject: FAILED: patch "[PATCH] NFSv4: Prevent indefinite waits for out-of-order OPEN" failed to apply to 5.10-stable tree
To: tmenninger@everpuredata.com,anna.schumaker@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:15:53 +0100
Message-ID: <2026112553-underarm-mama-755d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 151d95a1e696979a7d54b23c96338754be2fcc1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112553-underarm-mama-755d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 151d95a1e696979a7d54b23c96338754be2fcc1f Mon Sep 17 00:00:00 2001
From: Tim Menninger <tmenninger@everpuredata.com>
Date: Fri, 30 Oct 2026 23:44:22 +0000
Subject: [PATCH] NFSv4: Prevent indefinite waits for out-of-order OPEN
 stateids

When processing an out-of-order OPEN stateid on an NFSv4.1 or later
mount, nfs_set_open_stateid_locked() waits for stateid updates to be
processed in order. A five-second timeout is intended to prevent
indefinite waits when preceding updates never arrive.

However, each iteration calls schedule_timeout() with a fresh
five-second timeout. An update to the shared open state can wake the
caller without satisfying its ordering check. The remaining timeout
is then discarded, and the next iteration starts another full wait.

Under sustained concurrent OPEN/CLOSE activity on the same open state,
repeated wakeups can prevent the timeout from ever expiring. Some
tasks can remain stuck in update_open_stateid() while others continue
making progress.

Compute a single deadline on entry and pass only the remaining time
to schedule_timeout(). Once the deadline expires, take the existing
timeout path rather than starting another wait. This prevents
wakeups from extending the wait indefinitely.

Observed on Linux 6.8.0 and reproduced on 7.3.0 with 96 concurrent
O_RDWR|O_TRUNC open/close loops on one NFSv4.1/TCP file (nconnect=16).
Ten workers made no progress for over 300 seconds while others ran.
With the fix, all workers resumed after transient stalls.

Fixes: c9399f21c215 ("NFSv4: Fix OPEN / CLOSE race")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2b01421edee7..6759fa61b9b4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1722,6 +1722,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 {
 	DEFINE_WAIT(wait);
 	int status = 0;
+	unsigned long deadline = jiffies + 5 * HZ;
+	signed long remaining;
 	for (;;) {
 
 		if (nfs_stateid_is_sequential(state, stateid))
@@ -1756,7 +1758,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 
 		if (!fatal_signal_pending(current) &&
 		    !nfs_current_task_exiting()) {
-			if (schedule_timeout(5*HZ) == 0)
+			remaining = (long)(deadline - jiffies);
+			if (remaining <= 0 || schedule_timeout(remaining) == 0)
 				status = -EAGAIN;
 			else
 				status = 0;

