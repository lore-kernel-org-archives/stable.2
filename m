Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6349DB9C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954641; cv=none; b=M5o3uROcgvYqKozNy5DwCImEqb5pGoWyFk/GBYeEtZWlSviRKroJFiG+NGDz4IwKrlZ8Kz1Mq2X2ymhilIwmJzJ9/mHCT2J8ryNHBLUmntmkugeCk84Y3bqCqbVeQ7bGOuR5slADYZkIUwWGLh1cLEywg0mIsBQoHaZqy00OUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954641; c=relaxed/simple;
	bh=fsUvkmIYw5yf6Nzf4xaCuBjPMP9H48JxhWrJwxKwohk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rhmybc0dfi5JSD0vc5AajKRyt1nnNEw7VktCc8jqh+Ou2zizaMZqH7ynJbYmA6NYdvL8PHrkkoEEPvCRyukaiZw/1L0+UVVyFPdUyheOgPZIIPMs6WxSiUk/3rovo0RbysvDJOPIxORhIDKTL/rxVtmmZpojoKhlRyCUeNpyNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I7QCwsDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I7QCwsDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DD41F00A3A;
	Wed,  9 Sep 2026 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954640;
	bh=AVzWGupg4iig6Qo/i66jAmSyn2KpYDVCEmunfAGh7ko=;
	h=Subject:To:Cc:From:Date;
	b=I7QCwsDfrYOnns81apbvSlRB9UKaf9bLbUVU6A92TPErQfd3E2+YnD9hvcvsxWq5r
	 h5tGA/2LWPLJAPC16gJtO6Cqy1Uw2Xymexv4Hy4VkuQGBPeqpjFaY/FI6Y0JmA8w4B
	 flqGMh3XhShqG5/qy9bXUFqsP/7t4Jjb/iKgbH84=
Subject: FAILED: patch "[PATCH] drm/panthor: harden firmware build-info bounds checks" failed to apply to 6.12-stable tree
To: osama.abdelkader@gmail.com,steven.price@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:38:38 +0200
Message-ID: <2026090938-backlog-baton-1bbc@gregkh>
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
git cherry-pick -x 8321b093fa6c297b80586460ce6914d9655df170
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090938-backlog-baton-1bbc@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8321b093fa6c297b80586460ce6914d9655df170 Mon Sep 17 00:00:00 2001
From: Osama Abdelkader <osama.abdelkader@gmail.com>
Date: Mon, 20 Jul 2026 13:32:11 +0200
Subject: [PATCH] drm/panthor: harden firmware build-info bounds checks

panthor_fw_read_build_info() checks whether the metadata range fits in the
firmware image with hdr.meta_start + hdr.meta_size. Both fields are u32, so
the addition can wrap and let an out-of-bounds range pass validation.

The function also reads the "git_sha: " prefix without first checking that
the metadata is long enough, and meta_size == 0 can underflow the NULL
terminator index.

Use subtraction-based bounds checking and reject metadata that is too short
to contain the expected prefix and trailing NULL byte.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Link: https://patch.msgid.link/20260720113212.11981-1-osama.abdelkader@gmail.com

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index de8e6689a869..6a6f014d63e8 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -697,7 +697,8 @@ static int panthor_fw_read_build_info(struct panthor_device *ptdev,
 		return ret;
 
 	if (hdr.meta_start > fw->size ||
-	    hdr.meta_start + hdr.meta_size > fw->size) {
+	    hdr.meta_size > fw->size - hdr.meta_start ||
+	    hdr.meta_size <= header_len) {
 		drm_err(&ptdev->base, "Firmware build info corrupt\n");
 		/* We don't need the build info, so continue */
 		return 0;

