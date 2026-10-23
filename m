Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792741656;
	b=1XD63uHGEXu6ZyU76osp04pe+eEFHXy5Jykb6p/CiyDeFtT0fLoQ4CzdtMCuY0rEuygk
	 hTm7KgALbgfB6Y9Tm80kz0rpGGmlGSWJUcA4kY/gLT8Gvf/R+U2lHie7QMVDljCjbJ7UW
	 rRC0gUDRkUl5ex6t4H4HcqVG//f7R+oxoVNDhQTgZI3GytWXBQeS61STPZQrLzplRVo9j
	 jJK/x3MbNFlV/CEZFCWh66RhSTXb2jE0aHse0hFiLVd+NF+38Q+20LY0NSGWDvbMTM6MX
	 s6+ESXt+Vj8gjPe+m8/4hddi9hilz9eG+zMvzzzykz7QXum4GsklyLbcUMskY15+E7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741656;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V65awey7PH+EaVz0Z/qFwHRAyR1mJpUy4VAJ3/5UO5Y=;
	b=zToqf1SH/a8xMROKcVYYwT0QPs4kSwxXwML6KKdvGz35ywbeARTuXq5tBqV2/mbjSjKp
	 VbV1R58r6DPuUAk6KqPFxBq6+yARYm0Xap6JT69jUPdLuC/myFZuRIYG+CLe20H3srOuE
	 8VxgL0y/XixRngyprn15rXV2e5ZDjfnOtPaJ/oD0L6IMIBCTUl6hnw3gFTUBGYHiQu2eP
	 MhflXTLer5q2q9MkrqMrGwQhiy48vszHVx+Bd45VbHnwj34hzSVj/DeM117KESCzmT6Ni
	 jamooJ6Kb2jAf+3HQBwnbfIiV+apQ31kVvjXnjGG1zZuO44fJ5s1VTcHVzi9yzwqFmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e92g5dyt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFD606A320;
	Fri, 23 Oct 2026 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e92g5dyt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792741655;
	b=1nNas0DairAlD7QaQuVf2HQp1m9hB5eOe+MeHTTLuSXT8U0MtrGObV33453lRA8UO9yS
	 68V7N6GoKw0JxwXjo8VpiIJAozgGGcjcvoNu52TCcRSLnRlQNeSio0Wkl68uZ6s5Epaqq
	 6O9eh8/yK8XffLDW1vJzbQiri0vXepH/+/1evnHQlYsKrQ4PXj1ICb7+yTT/CrICvqgG1
	 REA0Qhd6r4U2GmmCaHsY70NsApg+l/U4MCbdInS+E/usM//B/k7viux5cooUF8PVrJUxm
	 6CsT4Wj4qoOiQUhE0aUe1I3C5NKCpDPXS5infA9ApvlwxGjXaLTeo/XA8mU8jTxk1+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792741655;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V65awey7PH+EaVz0Z/qFwHRAyR1mJpUy4VAJ3/5UO5Y=;
	b=qFXrPEJaq9JzjGfSrTb0C2XIot18Vi/+OZP3tPP1FWjalfOZFxLq5Lps8M0bKjoS8+D+
	 198Z3UKQd8AN48JBT7+ShajUJQx1CoDNhPEkU+tGLgF9ojsCwT1hMbHVPNid/vx186RiO
	 FFDMDdyHUn7I53ufk1iLk84KzmMLJHhgOKuknTJDqp8PRZFoUJpEqur9Mvjc3cG0F+oNT
	 dF7GZ+tIVMe1+TLVn3tQOKhmwZAZdPNyU3LcCj1ewNBKMOZ9ZkbOZrZK9ayNsIh8edOlj
	 kJeuS5AF45D59q9MdI+akBbcKDg6EdC57HWBgOQJ5Weww8oPNbnPZNHmb8V6b/0l8Wg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AF5E11F01825;
	Fri, 23 Oct 2026 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741655;
	bh=V65awey7PH+EaVz0Z/qFwHRAyR1mJpUy4VAJ3/5UO5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=e92g5dytaHr+WzCny7lr4KtmtpWdBcMb7dXQe9DNNfeO8Vb0rXvweQ9EBPZqtBaOR
	 o4FQSujBsNgQkH/vUAdwn1VYH4YvhC6wW7Lg0sB2BGzyzgYX0dEP4tBo0v+mBoGaqQ
	 VVz59ZXGWvZm+qtQ9ylKzuRuAtQzWhr98RRkxUdGgMR6EiwsLXCAWUz0rBxqJWEW/c
	 7YJTJ70IrQUDIAOu8FX7ZKONULoT+GAm0VJXK+GpWBnJRRvGGSbcg5JdS1Z84uNJMx
	 vE1pg5UCySpzE7YiP15MpUJmEOfob/OPRQDU3YsyX2PQ2easy9s1u7axivJmizxiYs
	 /Ki+us5Trxefw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 22ABD44400;
	Fri, 23 Oct 2026 07:47:34 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Date: Fri, 23 Oct 2026 09:47:21 +0200
Subject: [PATCH v4 2/2] nbd: drop stale partitions on NBD_CLEAR_SOCK
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
Message-Id: <20261023-b4-loop-nbd-stale-partitions-v4-2-2baf05e4b2cb@amutable.com>
References: <20261023-b4-loop-nbd-stale-partitions-v4-0-2baf05e4b2cb@amutable.com>
In-Reply-To: <20261023-b4-loop-nbd-stale-partitions-v4-0-2baf05e4b2cb@amutable.com>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Christoph Hellwig <hch@infradead.org>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Daan De Meyer <daan@amutable.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792741645; l=2448;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=Xsf7lw9CzriaYcZ7LSWs2dUmnLL/EkAep1GawGfe3ic=;
 b=Gk00yNSAxP0BGLLgZfO+zaDaxRJD3UmvXzA2USAiHH8ymQf38em9AeTOaEeJgTv7csveCg6OV
 S+Ui/WVp2pFB7LgAZP1DCBYHO4ZjfizxVy2yFlSfoOzrfWpY9IWgabW
X-Developer-Key: i=daan@amutable.com; a=ed25519;
 pk=I1l+WwrtmzRgofA5SQ1wTuJi18fjh91w+f5uRkFeZEA=
X-Endpoint-Received: by B4 Relay for daan@amutable.com/20260712 with
 auth_id=868
X-Original-From: Daan De Meyer <daan@amutable.com>
Reply-To: daan@amutable.com
Content-Transfer-Encoding: 7bit

From: Daan De Meyer <daan@amutable.com>

Commit 267ec4d7223a ("loop: fix partition scan race between udev and
loop_reread_partitions()") stopped disk_force_media_change() from
setting GD_NEED_PART_SCAN. Besides requesting a rescan, that bit was what
removed stale partitions on the next open, as bdev_disk_changed() drops
all partitions before it consults disk_has_partscan().

nbd_clear_sock_ioctl() relied on that. It zeroes the capacity through
nbd_bdev_reset(), but nothing removes the partitions of the disconnected
device anymore. With the default max_part=16 they linger until the next
connect sets GD_NEED_PART_SCAN again. With max_part=0 nothing ever sets
it, so they are never removed at all, even though nbd does not set
GENHD_FL_NO_PART and partitions can therefore still be added with BLKPG.

Set GD_NEED_PART_SCAN in nbd_clear_sock_ioctl() so the partitions are
dropped on the next open. Calling bdev_disk_changed() directly is not an
option as it needs open_mutex. nbd_open() acquires config_lock under
open_mutex, and nbd_clear_sock_ioctl() runs with config_lock held.
Taking open_mutex in nbd_clear_sock_ioctl() would invert that lock order.

Fixes: 267ec4d7223a ("loop: fix partition scan race between udev and loop_reread_partitions()")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Daan De Meyer <daan@amutable.com>
---
 drivers/block/nbd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf008..322dbd16dc93 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1616,6 +1616,15 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
 	nbd_clear_sock(nbd);
 	disk_force_media_change(nbd->disk);
 	nbd_bdev_reset(nbd);
+	/*
+	 * Drop the partitions of the disconnected device on the next open.
+	 * They can exist even with max_part zero as they may have been added
+	 * manually with BLKPG. Dropping them here would need open_mutex.
+	 * nbd_open() acquires config_lock under open_mutex, and we hold
+	 * config_lock here. Taking open_mutex here can deadlock against
+	 * nbd_open().
+	 */
+	set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);

-- 
2.54.0


