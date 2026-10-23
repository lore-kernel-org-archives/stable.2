Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792741656;
	b=hIvGG7ZCBFy0IUjW5rDHptS56VymavSu/9MM+aFy+YL+II0S5RPTtW5xdRszIBYuPapN
	 WRYRcdv1RuPisn27wPYmF/nGRxGVysTXjVZwTwh1RH1wrJoNOKZMbb2z69pXThFzwKae3
	 iFGaks1rufmLhArZRJzNGQffHRm3J0kYnlH/wJFnDGU+ArFg9kU+ZuG4/cCsod2S1YS9G
	 V3x22/R2L7yLMoDzLg5b7Bqi9MIoPG5TQODKqhepth8dLPaoKq7cTzDLjqefF4dDhszZD
	 V8apfABaj+O99hQt0Ek4A3aX9Pf2XQcFfzeQDXLfsGH5vNWdIeT0ow4wPifJJa0idOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741656;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ct73//Mwk/lszBpxsfflyCE6X+qFY3OTxiUoNMBpG6I=;
	b=2moVrV1YHMRS+GnLIbjTHc+cuktRFy5PglOsH1bQd6hrKxsinPukG6aOo0lOU5jdN/MZ
	 2KLGlQCfNRyL7g5oTVXnuWV5hYm3PB3Nx9IUV8vtMLNR3TN/iQdOyFeRqaKlf2vseP0Ft
	 q6I9hN5TCjOrdx52x1b1jQcJCXuZWL+3vXA/cW4Lk5xgAh+ePJOwXh4wm9d5JZ+8S67jJ
	 Ztc025hJbxekUJkerChzRQoWAH1PeuCzhCfM9crZNmWzWYMFN/bMUZaqzbgFrELjq0o6C
	 cUrSh+HDIkXSBromKUJLO1lziijnfpLFuDqlampKNXWT1UTPPRj9kYXRIUp7Qu2SB5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HATD3x9K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A76606A31B;
	Fri, 23 Oct 2026 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HATD3x9K
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792741655;
	b=nFY7q8c+q4MbGhhwnq/Y18kDAknpGPYHCa8GbvumX1AOc23fcECAf+B/zSSfgQyJajVz
	 girPd2Y8zDAlxvqKJxfUFInwLLQ7PxVE8NchB9QA7o0Q1fDRdp/KyrKK3HbJU3qvKMgId
	 xJs0MBsP08YZ7kH24e/BVVruuRC0lpSyW8BQihvOQCo13SKULEDWTuoZAuWGhxU4vMV9H
	 sLlE3S6uAFTg9BWf7rX7TlxO8hfnU6268qKHeE0iXX4kfjVYkhyZ/weW3TcWUlnFBCIAV
	 Ses6kcB93/XJJVbir8S9PsZsKX6jwTXUaZ4Kbx17vRuHaVJ5jRDUu7PJKS/CttM7Cmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792741655;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ct73//Mwk/lszBpxsfflyCE6X+qFY3OTxiUoNMBpG6I=;
	b=Uah4hDVjlGV/r6/VD8aQSAeY79GiSBJssO+/EbaoNABBBFgLwD7ky6P1tEZjsEAlPOG4
	 VhVmEpbLYawKQ3MZni4ae8rkRqHoeG38KB+GkUs6pH6KwXGh0V5FD3ktZNa0ab63ksSl/
	 /8SOInSAET7DGlrIUMHzwJ6onD8xrFPdnEt7iOc3u2RY+AoOX+0qjdiGCKZDK5PdRT7xY
	 UCktqf7wPDF97ihMN85Z6Kd11RI1kxgFvqBMfLqMkjYkLr0TI4c5uTylCyNxQx/o5h/Xh
	 I8u+1x0LK3ng5x4YUH/pJR7GpslHFeT5jrISxODAFT7OTn6Arpt1FbKIsG+Yrh25BKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AF60D1F01828;
	Fri, 23 Oct 2026 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741655;
	bh=ct73//Mwk/lszBpxsfflyCE6X+qFY3OTxiUoNMBpG6I=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HATD3x9KSJnQYQPmAS49vnnskkBvVGvKhAMB4aynAQKyuDLeS/5WbKfGIDqxpbNCG
	 2gYtmbMRbI4/0jRkClBuXzIFEDx4N9XtZZTIHZXtRodW9rHENEOJ1QBnj6SQPbHNpl
	 qtGRsTcmH/kzofHWkmbB5jw4VBjaijhFTgxEE/Bhtl4x7U1QkFhqJ9Wm4JJ58GQFMX
	 RNP86Tej4K/l9VsnRL1jY0p8h1nOyoGp+I271DGNi0GfH+RsMnNKl7YMhm58dMXTmz
	 2bELcBpzfYwmoGcfG2bjF7hUHDpyBUb/9dAXa4gdiIlCeBgVpdERxHPJNbLT/Ad7rr
	 YPwhKHDV9CxfQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0F32C443F2;
	Fri, 23 Oct 2026 07:47:34 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Subject: [PATCH v4 0/2] loop, nbd: drop partitions left behind by the
 GD_NEED_PART_SCAN removal
Date: Fri, 23 Oct 2026 09:47:19 +0200
Message-Id: <20261023-b4-loop-nbd-stale-partitions-v4-0-2baf05e4b2cb@amutable.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43O3UrEMBAF4FdZcu1Ikm2brFe+h3gxk4w20jYly
 RZl6bubrCAiwnp55ufjXETmFDiLh8NFJN5CDnGpobs7CDfi8soQfM1CSz1IKwegDqYYV1jIQy4
 4MayYSij1L4P2SrJno1CjqMSa+CW8X/mn56+cz/TGrjSzXRBmBkq4uLGNZsyFU1uMIZeYPq7FN
 tWAf3bYFEgYDJHp0XpD/IjzuSBNfO/iLFqNTf/wdHfD09U7WdVjb4xj8n94x29PSa1veMfqGdd
 bdkjDydlf3r7vn03m/y+WAQAA
X-Change-ID: 20260806-b4-loop-nbd-stale-partitions-2d10ede71a2a
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Christoph Hellwig <hch@infradead.org>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Daan De Meyer <daan@amutable.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792741645; l=3132;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=sPPVu4iJxaWGfV0YTWn1NFDKocSxyPtXFqSoQBma8cc=;
 b=elUCr89cUZfXi8D6aSlTVsOaNwDS65768Mgli2yNSip8k00EIDuICkF6/MRocaQmhOIJGo4CH
 7HhRU1dU0S4DnCB/4zMWeAbY8BbFVNvuajQki/T0pSqJbnEi3evA2eU
X-Developer-Key: i=daan@amutable.com; a=ed25519;
 pk=I1l+WwrtmzRgofA5SQ1wTuJi18fjh91w+f5uRkFeZEA=
X-Endpoint-Received: by B4 Relay for daan@amutable.com/20260712 with
 auth_id=868
X-Original-From: Daan De Meyer <daan@amutable.com>
Reply-To: daan@amutable.com

Commit 267ec4d7223a ("loop: fix partition scan race between udev and
loop_reread_partitions()") stopped disk_force_media_change() from setting
GD_NEED_PART_SCAN. The caller audit in that commit only considered the bit
as a request to rescan partitions, but it did more than that:
bdev_disk_changed() drops every entry in disk->part_tbl before it consults
disk_has_partscan(), and only the re-adding half is gated on partition
scanning being enabled. The lazy scan on the next open was therefore also
the only thing removing partitions from a device that has partitions but
no partition scanning.

Loop devices without LO_FLAGS_PARTSCAN are exactly such devices, and they
are not unusual. bdev_add_partition() only rejects GENHD_FL_NO_PART disks,
so BLKPG_ADD_PARTITION works while GD_SUPPRESS_PART_SCAN is set, and
parted, libfdisk and systemd all fall back to BLKPG when BLKRRPART fails
with -EINVAL, which is what a loop device without LO_FLAGS_PARTSCAN
returns.

Commit c4f4c0fc551c ("loop: remove manually added partitions on detach")
fixed the detach path after this was reported as loop devices picking up
partition devices from a previously built image:

  https://bugs.debian.org/1141434

These two patches fix the two remaining places that relied on the same
lazy cleanup, LOOP_CHANGE_FD and NBD_CLEAR_SOCK.

Regression tests for both paths have been submitted to blktests:

  https://github.com/linux-blktests/blktests/pull/259
  https://github.com/linux-blktests/blktests/pull/260

Signed-off-by: Daan De Meyer <daan@amutable.com>
---
Changes in v4:
- nbd: Fix the lock order described in the comment and commit message.
  nbd_open() takes config_lock under open_mutex, not the other way
  around.
- No functional change, so the review and test tags from v3 were carried
  over.
- Link to v3: https://patch.msgid.link/20261022-b4-loop-nbd-stale-partitions-v3-0-7c58ecab69c8@amutable.com

Changes in v3:
- Rebase onto current mainline.
- No functional changes.
- Link to v2: https://patch.msgid.link/20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com

Changes in v2:
- Rewrap the comments added by both patches so they fit in 80 columns
  (Christoph Hellwig).
- No functional change, so the review and test tags from v1 were carried
  over.
- Link to v1: https://patch.msgid.link/20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com

To: Jens Axboe <axboe@kernel.dk>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
To: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: nbd@other.debian.org

---
Daan De Meyer (2):
      loop: drop stale partitions on LOOP_CHANGE_FD
      nbd: drop stale partitions on NBD_CLEAR_SOCK

 drivers/block/loop.c | 10 ++++++----
 drivers/block/nbd.c  |  9 +++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20260806-b4-loop-nbd-stale-partitions-2d10ede71a2a

Best regards,
--  
Daan De Meyer <daan@amutable.com>


