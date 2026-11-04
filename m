Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800081;
	b=Z1QC/GfZQAxLsKo7YmzG6SGpsRFvFv9Q0Qq0vna6mXI+uFgRmhHlPhxHP7Cjro1IK5bP
	 LaYUSwYE1gzv0AxTgqUzbHSTB7KOpzPBA18jf8tqA7YaIEj75EQT+K5JOIUH3Ba2EDw6s
	 R6z1zxVHW1rp9r7wr+lqqMNdO7VjFkHiivdv0oDzgcp+7GP2/lf0GtM+sQWtw/MoXjf7I
	 Z8mZM12E78iIKkOx92rv2zNc2V6I24GKrUkCRQLn3E3RMdbYXUb4qkQNxIGKdOQfg5OuL
	 2n7lo1WU55fsUCZZ7oLCvu27jj1ylX0kMwP0nEyN2fDgJeBVQEVsrWjuoLPxOnqwgew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800081;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C6ACa+TjXhr+X7Iq9vFU50y5vOFUS5seA4cBfPQeuKk=;
	b=rZqTNJI7e5j2haMgb5JMgFQuW60y4C8+AknRkd2m2qbOYP2HrGyaJD+HSJuRVYrVDd+r
	 dLvtAC8Kt6YDNImSv1xmk5QWAKcvbyfHeceDUj3CAxrLAAiaPpmE9/3U4wlC+YbVtw1Bw
	 nMbPuFQzhUb9lYIv0hCOe8z+9tRV4WPFlUDwBqG1f1ce0K5jQCdVeW4XjyFU3xo40nzzK
	 EG6mvZHleNp47UkydZyUa59chXDsEG4vS2+k9fqVe27IBWT/x7Mvo4g7+zOpk9pgg5fSh
	 p5aE+FERd5MKlQTgRvacICjePP7LEUjMd8Yv2ygVAKIaBOeKXDyMLZguA1MDvVbxekQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=t6QZyyKe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AF606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=t6QZyyKe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657971F000C1;
	Wed,  4 Nov 2026 13:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793800080;
	bh=C6ACa+TjXhr+X7Iq9vFU50y5vOFUS5seA4cBfPQeuKk=;
	h=Subject:To:Cc:From:Date;
	b=t6QZyyKerEaw0d0pR4takptNpi1FH06WY1yJ5PWuiZlEtCK24mjEfDF9GHeInTnaW
	 XPgTv9yztPnL/PvWUbdnPKbpMsnrI7jCKFqhn2h0rT6etZBd5fArxaiWuNGtjg4bqC
	 /tGowXkiBdCimSlab1zAEy8Ci9/e7rxR/3pLEECQ=
Subject: FAILED: patch "[PATCH] media: au0828: fix use-after-free in bulk_timeout timer on" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:47:22 +0100
Message-ID: <2026110422-surrender-slip-c8ba@gregkh>
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
git cherry-pick -x 521030837bee352515d5ea57cc6a29581db3506e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110422-surrender-slip-c8ba@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 521030837bee352515d5ea57cc6a29581db3506e Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Mon, 10 Aug 2026 05:51:28 +0000
Subject: [PATCH] media: au0828: fix use-after-free in bulk_timeout timer on
 disconnect

start_urb_transfer() arms dev->bulk_timeout, whose callback
au0828_bulk_timeout() queues dev->restart_streaming; that work in turn
calls start_urb_transfer() and re-arms the timer.

au0828_dvb_unregister() cancels restart_streaming on disconnect but does
not sync bulk_timeout. au0828_usb_release() then frees dev with kfree(),
so a timer still armed or pending at that point can fire after the free
and dereference dev through timer_container_of().

Sync the timer with timer_shutdown_sync() before cancel_work_sync().  The
timer callback queues the work, so the timer must be stopped first; the
shutdown variant is needed because the work re-arms the timer through
start_urb_transfer().  The dvb->frontend == NULL early return guards the
register-failure path where the timer was never set up.

This bug was found by static analysis.

Fixes: 53460c53b761 ("[media] au0828: Add timer to restart TS stream if no data arrives on bulk endpoint")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/usb/au0828/au0828-dvb.c b/drivers/media/usb/au0828/au0828-dvb.c
index 9c95b7ceaecd..d3fff47f0edf 100644
--- a/drivers/media/usb/au0828/au0828-dvb.c
+++ b/drivers/media/usb/au0828/au0828-dvb.c
@@ -537,6 +537,7 @@ void au0828_dvb_unregister(struct au0828_dev *dev)
 	if (dvb->frontend == NULL)
 		return;
 
+	timer_shutdown_sync(&dev->bulk_timeout);
 	cancel_work_sync(&dev->restart_streaming);
 
 	dvb_net_release(&dvb->net);

