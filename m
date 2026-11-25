Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606410;
	b=2B2q0KWl8ZJuXam8XWquI95oOAetCL3QlxAow1bGzsPY3zEZGPKI1ym646p78tMeZZk3
	 BOtcpTrNnYVbuqmflCtTGK5VWXgr2+oNbNbdGKj4+NoRu9JfMAlK5HXWv6Q69fa6lT3+H
	 qG3lvOr6Wb1JDMOPTQhxOht/VUsQHLeBBBOgPaa6e5QeoHGfZWhR9et+OId8GsXhmxrka
	 tSht+idAiHYFP/Q/Yzim3bE903/Iun1mfbLof5rxsSAZC9oaabCnYAk1dkj3Ifs5/Z2VX
	 2WtFiMuOdWiPUXP+OwGtkKm1+XH8TP8FTDVaQ7nlvjZraMw9ORz/px3sf91P+7EhMmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606410;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jF5LIC9Xe2rZRO3u3siolTQ/bd6eCpIV0KtzurRwpbM=;
	b=s+mpruBz+XbebvIT5B/uNhqAx1gYeFSJO52I5y0vLpmg3IRikSixryc/GiDbbvu0KV62
	 TyJDJP5YEv9CzJ1ceOip5QAp5eQE/EtEmRSgUOY8zfvBzmUjzpZXuLqE7n6cUX5j5g9U4
	 t9wKe6aunQMvQH4N6z2sdaO2VqxOEJ4YdY8v0DIC+R9nWjqe0xaWVgLle2HYWv4G0p6dA
	 5Ly7FwYCZRuupzI48mBVAnznE+gQ4BYlmf5+zS8UGPO2b6sJBcDlGuXHXpQorWuKCWdfC
	 S9MOAge2V2LclBQixMn/scbASSjLA4KOA7HkYl+oM4MJk+ps61B7ypvtrbYq5guhbmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wON21ePl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4DF606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wON21ePl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F118D1F000E1;
	Wed, 25 Nov 2026 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606409;
	bh=jF5LIC9Xe2rZRO3u3siolTQ/bd6eCpIV0KtzurRwpbM=;
	h=Subject:To:Cc:From:Date;
	b=wON21ePlBS/igP8uRv1no+2BeS+A2Yc+y9kXIqx9aU3u9YNVmo/3irKO/YyXjMrlF
	 oNOpEMufveDLe6EIkYKKhnPzSzdB8c4nF1PgXccLtrcZPCK+kW0biR0gE2qdDTs2tH
	 a66jsQ7HK4e1hAo1utrGmy6IvCygGOqwwCX1QBek=
Subject: FAILED: patch "[PATCH] dm-crypt: defer async write submission to write thread" failed to apply to 5.10-stable tree
To: pepe.schlehofer@gmail.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:22:21 +0100
Message-ID: <2026112521-babied-pebbly-f2aa@gregkh>
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
git cherry-pick -x 6fed9e26810f0b466dbcebe35a73d1fd48793ff5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112521-babied-pebbly-f2aa@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

