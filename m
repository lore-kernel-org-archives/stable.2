Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674977;
	b=J9MEHrsakzu/Co5rzeeRqjPRAq1BVIMt6r3Tdv11XXUwhoDduHo7u4+bU+0wZ5wcKdk1
	 vvrtefa8UlBAFw5R2S4os+hiIOqskFmmNR1Y0ef4kzmJPRAoRc0GFt5ce1dKR/KC4xok4
	 bTSBalpiofSO07nRQWGcnLwia9fwK22qEQkYzWBu9BbAQGGgmzbBHxZWMvMVU5vs4LYP7
	 0Svj6+8mfC1cgGUmvvL/jn6pl5PLflzNK0H8sQYr59EYr9t/ISgfqx8YMdQLdGIPCXUqu
	 nPTwW+/8oUFHwb69p2maV8ThPJikHsGb1M25l2DzDwo4kCvSWAcEtXnazV3Yk3XESsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674977;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Kha7J0B18jTy76jkzk1IUtHEHyVitNdIsz6nXWVhzVo=;
	b=5PXTLrYUPI/+sNoZeqYGlB8ZLev2VwvkkzdW8LvhNtS0w6cKfH4gmMsdQ3ON8C44T/gJ
	 NVQJwgcsUsHrcgjwuFHT8UbX83IQe5ig0vgGgOaLsvZHU/C0TcUGWjA12OOoYVYqqjNNF
	 w/IzVqnD8p3G3Ws9jrrYh2e82OQeiErzTCSIj4fsdfp2A1TK1DGzjP2VPNs/EVAWYSCFW
	 HekbUJ083Q8MRRN1WSjLG4rHfLKTaQXlhstqXX2QpyRXOSqJ3wW8ywLuxHnJx3osrDgvA
	 /IJIjfP5OZGKZCFHswVXuMjDwoNZkQdyAhQInNCwHgorjv0aJUb+a6RAs8NeTU4d9tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXx8gP8b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55E606A332;
	Thu, 26 Nov 2026 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXx8gP8b
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795674977;
	b=PWV5p4/+vX6+RoQpf84VS+IRTnRp/Du2FBQpiuoIFcBEoVitGO/a4O+EkCT0KK+9LhYa
	 2lemcZRmAX7Q+5TqtmysK7bbwIFGgu1syHKxJKimUiY8sMt8yZIP54bfDIUnMi/DVcynH
	 iJ7OoZaWnB57eblJwwPnUtBOh0Ruh/S7zhaVBrhUEurAmfPJgHrjwHeOsRxzPvMOeCj1q
	 jXoIfC7jmed6aRTpwMgaU654bhJ/5US3HvGIu7dFqS1CXLgIoNKAo9w4+dlnHBWJvShtU
	 2ddem0rPoIO/6wAU3oN5am9LOgr5HuOehXa1ujMykbsZVGUSfA4oJLelTnxOW3+KpeQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674977;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Kha7J0B18jTy76jkzk1IUtHEHyVitNdIsz6nXWVhzVo=;
	b=CEEiD73STgK+x6nR/5BSZl2xfJNMZSSdM9PSmOZmOCdN3lDwP3qp1cN4bn43NAKoDeXA
	 7Tc04oKlI6wrRL88KbNPDf+tUYc4O1+JW63vO4xIdAj4lSJXy+cUzZOE1/Im+aDl5tYGk
	 1PUrrH5tE6TH/TuKGOjctvImdaZWhyvTYJEP9Qg4tYvyUP6BxLKm1UbO9vcKsrVfuyLUx
	 T9wuexp3ZR42GnKNCU3wN/p2l7m2DUOaGkjfpo7NTYTG2tfoRTTVHhqwZ1ynLhGxYzgvY
	 CxsZ86Vrvhu3UopvjeQRNSNerDx2ZEnxPdkrOf0pArZdnSAcWbOnZTL8AxbhV2E6ZJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0833C1F000E1;
	Thu, 26 Nov 2026 06:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674977;
	bh=Kha7J0B18jTy76jkzk1IUtHEHyVitNdIsz6nXWVhzVo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=HXx8gP8b2jC8kb0AC8dls4aBrse+DsUyJCl2Fhoy8mNmIxF8xA8o12P4hpaTTcTUc
	 B47vnnnXeu8OpcaViL6oTHf6K09r+Uh+n0dcIncO/1ddM/IdnzA0TguZIYGdzN/Qhp
	 Ym1RV5ZwtE7Bph69UcSgXG8WLms48F6MKW+BZSd7lc8Ug65rqwy5+duimbod3o5054
	 oTK9WncCat5cdjXmS68j/Q6G401dVrVimkw6p1jqVcORTW1GhzQO1gaGT6idm24etB
	 IHwpHWFuN4t0K6ztRDv9doJqnP/b3aT8jzRPdBv5KCCWQygmtSj54+xSmL+XUUpT8i
	 Pv+4gTPDSiHhA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 87F614D274;
	Thu, 26 Nov 2026 06:35:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 06:04:45 +0000
Subject: [PATCH v2 5.15.y] pid_namespace: prevent TIF_NOTIFY_SIGNAL from
 interrupting the reaper
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-pid-515-v2-1-7f7ca8955797@certik.com>
X-B4-Tracking: v=1; b=H4sIAPzLB2sC/y2MywrCMBAAf6Xs2VSzklj8FfGQx2pXJCnZKkrpv
 5uoxxmGWUCoMAkcuwUKPVk4pwq46SCMLl1JcawMuEOrNVo1cVRGGzVEGwfch4NGglpPhS78+p5
 OYHpt+jecf14e/kZhbptWeiekfHEpjE0JpTjnfFfNb/97WNcPL2yHLpsAAAA=
X-Change-ID: 20261126-pid-515-8d6d823c712e
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795673084; l=3176;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=NTwKCRqRaZQa2oaPT2BuiJfwuLkiWEctDvxTR2Fk/QA=;
 b=BbhStkw6O3dU/hOHy+LJPaSq5sxQnnTIzQjt7+9FMSA4mRbiciBEecb5ZpRWIHc2l+uAach0/
 Gpx6ptmrUOdBQZeRVI3sEQbS46r/IC7exAdv4TClaLDbM0bYUACmULr
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Christian Brauner <brauner@kernel.org>

commit 5c0985dd3c32fc2bbd0e8beaf13cf52cd97376a2 upstream.

Since commit 7fea700e04bd ("zap_pid_ns_processes: clear
TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING") zap_pid_ns_processes()
clears TIF_NOTIFY_SIGNAL before every kernel_wait4() call. Otherwise
kernel_wait4() doesn't sleep and returns -ERESTARTSYS if
signal_pending() is true and the reaper busy-waits.

But clearing TIF_NOTIFY_SIGNAL doesn't fix it. It can get raised again.
For example, klp_send_signals() sets it raw against any task that hasn't
transitioned yet. And it keeps sending it until the livepatch finishes.

The sleep loop waiting for pid_allocated to drop has the same problem
and it doesn't even clear anything. So a schedule() in
TASK_INTERRUPTIBLE returns immediately.

Use a no_notify_signal guard. signal_pending() will ignore
TIF_NOTIFY_SIGNAL and the pid namespace reaper sleeps until a child
exits or free_pid() wakes it.

Link: https://patch.msgid.link/20260824-work-tif_notify_signal-v2-5-6609e42b3157@kernel.org
Fixes: 7fea700e04bd ("zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING")
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ adapted to 5.15: explicit save/restore instead of guard() to avoid a declaration-after-statement warning ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
 kernel/pid_namespace.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Changes in v2
v2: resent through a whitespace-safe path; v1 <CAFaZ9epucF3AKE=B3mB9JD1sAcorBQDsgre_Wnv8Sati=tomPg@mail.gmail.com> was damaged by my mail client and does not apply.
v2: dropped the signal helper patch, Sasha already posted it as <20261028212317.2257095-1-sashal@kernel.org>; this patch depends on it.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 40b011f88067..d3e860d3678a 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -167,6 +167,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 {
 	int nr;
 	int rc;
+	unsigned int no_notify_flags;
 	struct task_struct *task, *me = current;
 	int init_pids = thread_group_leader(me) ? 1 : 2;
 	struct pid *pid;
@@ -212,9 +213,10 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * kernel_wait4() will also block until our children traced from the
 	 * parent namespace are detached and become EXIT_DEAD.
 	 */
+	/* Task work must not busy-loop the reaper, see signal_pending(). */
+	no_notify_flags = no_notify_signal_save();
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
-		clear_thread_flag(TIF_NOTIFY_SIGNAL);
 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);
 
@@ -270,6 +272,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 		current->signal->group_exit_code = pid_ns->reboot;
 
 	acct_exit_ns(pid_ns);
+	no_notify_signal_restore(no_notify_flags);
 	return;
 }
 


