Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606413;
	b=U/N58Pjxnozgtbp5cKFqQZ9+LFUQTjtUG+cZRDVUZBRrJDXQESaDIgxKapYxBA4RjozT
	 07gemtgAqj2lnSRWvOGbVtDge4UpvY9Y221FKuWIZImLyQ8I4PCnC5//R8tCpjh82COdy
	 4BAgmA4UI02CLXPUza/JqmUKJz2I36FD5ZekVdTICFxvzOS2ymquGAxZl7GiDTm2wn7z1
	 ybNrAS8TIplplKRdcFYSQ0dB1GGQ+1/LjnsnLguY2O+f+dBt3NmM2nOXoAwWnhNq83Qc9
	 5f298gia/pm/0jgOEbsb0AsN0FmH6ZfU9m4Md8QMH8MSlF+J9zyePn9Z0/oiOX1E+7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606413;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=refvThfbKER27NjayOMX10La+lDNB04iTgPuTPeJr8E=;
	b=Us0X8QnwViqobGIWBtRw+j/4OCs5k2WpXTubwXVR7hvVYvbHgDCnjALvxr3KqwS+tTyP
	 1mGxeAboc4sm4sJ65XZJ4Gi+HRU6hhlGRU2xwrNc7UAuJBlAIGdxi81LRIXVXXa7vGT7v
	 qwAapoMR3l3bhobXBl3EKVGQHhUjvZz+eYE89il11i7piHFislha+OdAC2uxzhbZjwh18
	 2W4l1IxELQg8G/N690x9i6GFd4D/dUQOT5bJOVeiaARllCRtBcaSFyFUprbHxTbd0yjeg
	 KeBiP2Qv47C5uz0baRwFMAFnHFrM7+f4KHIkdboH4v6GSG+ayHHRWajVH829EOpVvOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tY3BZaaM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C5606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tY3BZaaM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4811F000C6;
	Wed, 25 Nov 2026 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606412;
	bh=refvThfbKER27NjayOMX10La+lDNB04iTgPuTPeJr8E=;
	h=Subject:To:Cc:From:Date;
	b=tY3BZaaM9/zuWlatcscQIOaI7VTw32w/ussluwkyhEI8x/4mhMcYMmY7jnCzg7W2s
	 sje/dZSCj/kxce/QwU9FlRVRg2k0i3Jjg+dm/MTjTwEMaVToxypQaWMC+ioI54ay7/
	 0eyzxgLsAQ0SA34hijsVVyFMtgeOTi/9IzX/etGk=
Subject: FAILED: patch "[PATCH] dm-crypt: defer async write submission to write thread" failed to apply to 5.15-stable tree
To: pepe.schlehofer@gmail.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:22:21 +0100
Message-ID: <2026112521-nibble-keg-edbd@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6fed9e26810f0b466dbcebe35a73d1fd48793ff5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112521-nibble-keg-edbd@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6fed9e26810f0b466dbcebe35a73d1fd48793ff5 Mon Sep 17 00:00:00 2001
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
Date: Thu, 5 Nov 2026 08:27:08 +0100
Subject: [PATCH] dm-crypt: defer async write submission to write thread

With no_write_workqueue, kcryptd_crypt_write_io_submit() submits the
bio directly, even when called from kcryptd_async_done(). An async
cipher may run this callback in softirq or with BH disabled, where
submit_bio_noacct() must not be called because it can sleep.

Submit inline only when async is false. Async completions are sent to
the write thread, as is already done for submit_from_crypt_cpus. Use
the async flag rather than in_interrupt(), since callback context
depends on the cipher driver. Sync ciphers still submit inline.

Tested with cryptd in QEMU (x86_64 and arm64) with
CONFIG_DEBUG_ATOMIC_SLEEP, and on a P2020 running 6.18.55 without it.

In QEMU:

- 4k writes logging "sleeping function called from invalid context":
  100/100 unpatched, 0/155 patched.
- nr_requests=4 on a loop device: 0/6 unpatched runs completed,
  4/4 patched runs completed.

On the P2020, a warning in blk_mq_run_hw_queue() appeared in the
6th unpatched run and did not appear in 30 patched runs.

Fixes: 39d42fa96ba1 ("dm crypt: add flags to optionally bypass kcryptd workqueues")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 8853e9af1c3d..c0552a300e62 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1982,8 +1982,9 @@ static void kcryptd_crypt_write_io_submit(struct dm_crypt_io *io, int async)
 	/* crypt_convert should have filled the clone bio */
 	BUG_ON(io->ctx.iter_out.bi_size);
 
-	if ((likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) ||
-	    test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags)) {
+	if (likely(!async) &&
+	    (test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags) ||
+	     test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))) {
 		dm_submit_bio_remap(io->base_bio, clone);
 		return;
 	}

