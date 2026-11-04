Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802306;
	b=J4zEpynwmmrMmDLUmT7C9QOfR4pjgpCQaO96ACIO8GjTJ26O3sWJcR+6eplUWkbtlT5o
	 ZP9POP65WLC1vXNXoh9AVvUzbijz8nAshinj12mWNfTGxj4hPIGqMDEIEKWk34rOXYyqS
	 hx0cKve33Mv396yWmVjtKj4SW3nCPEh04yz730+55abSCTm/ewXbIkF+PLU6zX6TMKdsh
	 urdpUurv3aOjRAfK1ySwQbI7/dcf3ptcNuRBWk6znw9LEp2Uxdl4AsxtZL4q2Bc/jziCw
	 TIjtL9JOvUULWdYVagkRVyKalBwqELacv5JFDfwkZwnm1PO7cgfumhfMToBAW6P9b0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802306;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=irHPdz2wvWYNKYf7mWdFHnLgLMv4fr2gMY0QXEy+pPo=;
	b=d6w9A7QPHX0AlmHy8RyGudrX92qSfKp/gzRSevF4VMjS/Mp2RYtCQ2o/6F06vUynxqsS
	 IwBd3iamsXC8vYHTs+VSplPKdCLOvdTHz3ljle3OBlKtLIkSaW+UdBVGvjqIwQ1CaFPW+
	 uETZ+P4xIphDqrEgK6ZgJ8VPDr9c1Ni5NPnARbk/MF+h9QiDPjixYctJJQ9bwFy+8XZkI
	 /B+wj7qk50xUyX97ermRPU07u1IavjwaJBcxGKe4mySMcQ161JDFBlwxtz20Yjb8fVK54
	 e5/bpSU6zyJbfSsMqeMgg3DdkH6j9E/yyK9zBcYM0eepcaQ0Dux151t0wUPQpNboq3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UPDlKa+T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BB606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UPDlKa+T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C221F00A18;
	Wed,  4 Nov 2026 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802305;
	bh=irHPdz2wvWYNKYf7mWdFHnLgLMv4fr2gMY0QXEy+pPo=;
	h=Subject:To:Cc:From:Date;
	b=UPDlKa+TcTJ7oqb/NsfznAfksEuuUAnE1Mc1x6aO+vwvE9oy8LM05oYoOScHiru+G
	 LsjM75uMQh93PIf1vPKEjmwkNlXAEDDsY0k/oYZ287hyKvbY9iDqdQN8WMaycfcx9F
	 ArHFX1y+r8ZMAlxHxzjTvbpyxcVvB7sT2inZXHAA=
Subject: FAILED: patch "[PATCH] wifi: ath9k: delete channel-context timers on deinit" failed to apply to 5.10-stable tree
To: rosenp@gmail.com,jeff.johnson@oss.qualcomm.com,toke@toke.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:24:43 +0100
Message-ID: <2026110443-depth-overbuilt-7852@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 81394dfb9a7905472957628b560ae894eae3a30f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-depth-overbuilt-7852@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81394dfb9a7905472957628b560ae894eae3a30f Mon Sep 17 00:00:00 2001
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 11 Sep 2026 14:31:44 -0700
Subject: [PATCH] wifi: ath9k: delete channel-context timers on deinit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ath9k_deinit_channel_context() cancels chanctx_work but does not delete
the offchannel and sched timers set up by ath9k_init_channel_context().
If either timer fires after deinit (e.g. during driver unload or
suspend), it accesses sc->sc_ah which may already be freed by
ath9k_hw_deinit(), causing a use-after-free.

Delete both timers with timer_shutdown_sync() before cancelling the work
item.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Cc: stable@vger.kernel.org # v6.2+
Fixes: 705d0bf83dbe ("ath9k: Add a routine for initializing channel contexts")
Link: https://patch.msgid.link/20260911213144.130192-1-rosenp@gmail.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
index 8b27d8cc086a..cfb1c90eb4b6 100644
--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -1363,6 +1363,8 @@ void ath9k_init_channel_context(struct ath_softc *sc)
 
 void ath9k_deinit_channel_context(struct ath_softc *sc)
 {
+	timer_shutdown_sync(&sc->sched.timer);
+	timer_shutdown_sync(&sc->offchannel.timer);
 	cancel_work_sync(&sc->chanctx_work);
 }
 

