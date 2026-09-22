Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1C5158AB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081758; cv=none; b=BA9O3csGUu3YVGHwm/FCcdSa6B5H9B5PnMTatxnrGeRb4LkthTjseuinibhftZsFbPKLidw/q9Zz+WWPi4aYXQ9OaIxDaItYWsTS477GV5tATsqt9t7rUwGWM3D+AMyg/XMjUlJjGFmpVT0SSbpvVf83LyVmo9LbH26fUGNMrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081758; c=relaxed/simple;
	bh=ubxku8kcwK9zep0RugzAUAMfdFzxf1SrVF+xee3tIEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6ztcypCdckCiV+8cewmDEGRgn2aeWznN5FscYmAM/wmWueLekOPNqxgB22EXhpFNKpcnTciDAqBipJf48trcc7sI8PPWjwWTZZU4KJ0Nme2K82ecQWZSn6ksuMAiWdW+us0T7Bw5ODsPlss1SX+ZcgRwzlx56SCkWUbLTMxqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3dkxaOX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3dkxaOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790081755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q+Q202Ulk36gGraSq8aGSjuKZeytZD98yewc/uwH6yE=;
	b=f3dkxaOXuSlYNsZpQMJfgZV2zpR2de0Y+XPkjF+C1N5C/LxeUJ093yt0XzX9IuPCGQgUhl
	AxHFJiHCxZ1Dl3k9SuCNFQ1hzsa01erggOkjSwxoS2KPWZ+XK8GlCn2IHDGYXBstADv1n8
	c6gNaPPoPr16nzJ2Qj/FfqkNqej0kkc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-Cetgdzf5PD-aejzMw1bNew-1; Tue,
 22 Sep 2026 08:55:50 -0400
X-MC-Unique: Cetgdzf5PD-aejzMw1bNew-1
X-Mimecast-MFC-AGG-ID: Cetgdzf5PD-aejzMw1bNew_1790081748
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AC7D1802171;
	Tue, 22 Sep 2026 12:55:47 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 545E21956042;
	Tue, 22 Sep 2026 12:55:43 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 22 Sep 2026 14:55:46 +0200 (CEST)
Date: Tue, 22 Sep 2026 14:55:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 02/17] signal: only SIGKILL and the freezers interrupt
 a coredumping task
Message-ID: <arJ6zZuI59BJnXpl@redhat.com>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-2-8e4adb1619e6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-work-coredump-fixes-v3-2-8e4adb1619e6@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/21, Christian Brauner wrote:
>
> For quite a while now coredump has allowed either SIGKILL or freezing to
> interrupt an ongoing coredump. Since we seem to like it complicated
> "freezing" can mean a lot of things:
>
> (1) Power Management induced freezing
> (2) cgroup v1 freezer controller induced freezing
> (3) cgroup v2 freezer controller induced freezing

All of them do signal_wake_up() which sets TIF_SIGPENDING
However, zap_threads() clears this flag.

With the recent changes including your PF_NO_NOTIFY_SIGNAL and
05/17 "signal: don't retarget shared signals in a dying thread group",
what else can make signal_pending() true? Apart from SIGKILL.

So perhaps we can simply do _something_ like

	--- x/fs/coredump.c
	+++ x/fs/coredump.c
	@@ -508,7 +508,8 @@ static int zap_threads(struct task_struc
		int nr = -EAGAIN;
	 
		spin_lock_irq(&tsk->sighand->siglock);
	-	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
	+	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task
	+	    && !freezing(tsk) && !(tsk->jobctl & JOBCTL_TRAP_FREEZE)) {
			/* Allow SIGKILL, see prepare_signal() */
			signal->core_state = core_state;
			nr = zap_process(signal, exit_code);
	@@ -583,7 +584,7 @@ static bool dump_interrupted(void)
		 * but then we need to teach dump_write() to restart and clear
		 * TIF_SIGPENDING.
		 */
	-	return fatal_signal_pending(current) || freezing(current);
	+	return signal_pending(current);
	 }
	 
	 static void wait_for_dump_helpers(struct file *file)

?

At first glance the change in dump_interrupted() makes sense anyway.
For example, dumping to pipe can't tolerate signal_pendin() == true.

What do you think?

> Fixes: 403bad72b67d ("coredump: only SIGKILL should interrupt the coredumping task")

Well, I think we should blame 76f969e8948d ("cgroup: cgroup v2 freezer")

Oleg.

