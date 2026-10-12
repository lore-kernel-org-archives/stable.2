Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926774A6CEC
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819109; cv=none; b=D8I0+PYHyUBKPqpxxRZzmVZ2jEE5uUBXd+H4nC1Svc0fT1cAQgMW/CHMb1stn8CSDR3oJbpKfRCMbPgKgzAusY/ds7VAa7Og0KZLafQQIiENXwncIlUWaiAoJJYZYjQbUae8aGI4tSJictmdWy6ozoPsUs+O91glwlIulwVe5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819109; c=relaxed/simple;
	bh=fTvgLhvx0EUPOi2WppGSGh7iE/kCEgpNeJH9VDyNCVE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sJPo0hp+WWWigBwu43l7lryI9oNHVimgFpxtSsKQMsDNmQBDp1mGC0jX6UCH/s2LmQ+ru2cwKeyEwkyHKO+PDMGx2aSxUAih9O3jlJvt+j4P4pxuK9ruiQIzIAQn9d2J4Pmza9dimhTBQzxk+KFUPhEqyh6pCn2snuOBRwaoLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GKLlNMP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GKLlNMP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBFB1F0089B;
	Mon, 12 Oct 2026 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819108;
	bh=EAMJzZirmplJn7LCJzQOHGzyfKkGzQS7KL4QWWWVito=;
	h=Subject:To:Cc:From:Date;
	b=GKLlNMP8aNlSGgg0eGWb0PzBe5yqUirtZzrUOoezQap1oiQdMBR9/8kTNnKLYvD81
	 Css8jnIonx1WnYaYF3HhT/tjpEAfa7pYUkHg57IjlSQRB+rFszhbYsNQQvcfNYDSAX
	 KVCHXXt7JWDnslYpm91yQsVQGQRxBu0SnO4/fRDA=
Subject: FAILED: patch "[PATCH] drm/panthor: validate userspace queue count against" failed to apply to 6.12-stable tree
To: osama.abdelkader@gmail.com,boris.brezillon@collabora.com,liviu.dudau@arm.com,steven.price@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:30:33 +0200
Message-ID: <2026101233-operable-brigade-e932@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ec86c43dcfff68eab4db9bdafcd3e2b16e342e18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101233-operable-brigade-e932@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec86c43dcfff68eab4db9bdafcd3e2b16e342e18 Mon Sep 17 00:00:00 2001
From: Osama Abdelkader <osama.abdelkader@gmail.com>
Date: Tue, 4 Aug 2026 18:00:47 +0200
Subject: [PATCH] drm/panthor: validate userspace queue count against
 initialized firmware slot count

In panthor_drv.c:panthor_ioctl_group_create(),
the queue count is validated against the hardcoded maximum:

	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
		return -EINVAL;

However, if the firmware reports fewer slots than MAX_CS_PER_CSG,
panthor_fw_init_ifaces() will only initialize that smaller number of
stream interfaces.

If unprivileged userspace requests more queues than the firmware reported
(but no more than MAX_CS_PER_CSG), cs_slot_prog_locked() fetches an
uninitialized stream interface and may crash when dereferencing
cs_iface->input->ringbuf_base.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260803141149.68182-1-osama.abdelkader@gmail.com?part=1
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patch.msgid.link/20260804160048.174148-1-osama.abdelkader@gmail.com
Signed-off-by: Steven Price <steven.price@arm.com>

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5778e23e20a0..653c6755896c 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3674,6 +3674,9 @@ int panthor_group_create(struct panthor_file *pfile,
 	    hweight64(group_args->tiler_core_mask) < group_args->max_tiler_cores)
 		return -EINVAL;
 
+	if (group_args->queues.count > sched->cs_slot_count)
+		return -EINVAL;
+
 	group = kzalloc_obj(*group);
 	if (!group)
 		return -ENOMEM;

