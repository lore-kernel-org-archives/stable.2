Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595550;
	b=hanMMntL6hfX2qNNNumGfvlMww440ISKbjtmpcSZmI/S8OHfwE2O7u1NfmMnshHGsSqe
	 rUuEOArgzBPNNhb8PsbWY53hHT4hnXTczG9ytLc0dlN8X0PB523TDXi9ULFfFxpT+PX4c
	 8ju2X2dfUwB2IbkuIQiHZUoHcZaHA4f5x3lK3OWgqj1qbUnvQexPtH2vHEWu0IXJpcynJ
	 /bCEwjk6IDijIU+qplaar/dn/vZFP+Cm/oaBRqbEoDvI9mwZJO2DmzyrVSk81bpFmTT+V
	 khhmFTXc9sB8i5ey9UCJ/G41IgxhaKpgrfdfbmSYYU9q348Y66l8XhCTWo6xDEVwgAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595550;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XXoc7CA9gV8tnv1a9xxa5IWstcLkuUI+zcl2WSj3WGk=;
	b=dYIRY0leioMS01SUae8sm1VSJbroEW3NLtmYL2xP0rzmZvlifC6mNoLXfqMSYd1T6B0u
	 yjWZmGLRKG6YGKYZrLKyX5/nuD0cFkdBMeNNDz4hvtMIv7p00gCG+cIuHMjFJ3TNtmykf
	 SeLrQhQvXIedUZ2BSE6raQ85VjdZYgAGQA/YeDPZz+UeCJCmbZslkha5Id9HuWP4xgeUI
	 7queCI3+wpgvV75LZceqlR01uHuJFrLG5ZoaCtmT7iTXq/xznxvkWI4VjkbGS/Af9twOd
	 gYZVgSz9JADqEERamOs6PrCA0dzqz9yLWv2RLhPwJt/V6Cu7C3NiVs0KD1xW+arB3mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="1iaKPln/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28B606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1iaKPln/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CBC1F000C1;
	Wed, 21 Oct 2026 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792595549;
	bh=XXoc7CA9gV8tnv1a9xxa5IWstcLkuUI+zcl2WSj3WGk=;
	h=Subject:To:Cc:From:Date;
	b=1iaKPln/L4VIMTTQJKFW0+wHntJJIN3IZwNTneTnBPi+hNiG+x2cyrRgUT2TPIe0y
	 /xak0zFGPwRS+XfoukQp9+/1uQAUNhYApQ0mqOa0/Pps1CD4bcKXMfNfeMjFyyb6T2
	 +epjvnxDi9IFvwW7cveWib//w8VGTD6Of5RZ1Jcc=
Subject: FAILED: patch "[PATCH] dm-integrity: require stable writes for internal hash modes" failed to apply to 5.15-stable tree
To: chencheng@fnnas.com,mpatocka@redhat.com,sunyangkai@fygo.io
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:07:32 +0200
Message-ID: <2026102132-emperor-geiger-a973@gregkh>
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
git cherry-pick -x b2fd92f016e9d692fd3c8c08d0ee014e9212279d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102132-emperor-geiger-a973@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2fd92f016e9d692fd3c8c08d0ee014e9212279d Mon Sep 17 00:00:00 2001
From: Chen Cheng <chencheng@fnnas.com>
Date: Mon, 24 Aug 2026 19:34:49 +0800
Subject: [PATCH] dm-integrity: require stable writes for internal hash modes

dm-integrity direct, bitmap and inline internal-hash modes compute
integrity tags from the pages carried by the write bio.  The lower data
write also uses those pages, so the tag and the data write depend on the
same memory contents staying unchanged while writeback is in flight.

Without stable writes, a buffered writer can modify a writeback folio
after dm-integrity has submitted the data bio and before the lower device
has consumed the data.  After a crash, this can leave data from the later
contents with a tag calculated from the earlier contents, causing
permanent checksum failures on read.

Set BLK_FEAT_STABLE_WRITES for internal-hash D, B and I modes so
filesystems wait for writeback folios to become stable before modifying
them again.  Journal mode is left unchanged because it copies data into
the journal before computing and persisting the tag.

Tested using dm-delay over a virtio-blk test disk, dm-integrity
internal_hash:crc32c and no-journal ext4.  The D and B reproducers both
failed with checksum errors before this change and completed with
READ_RC=0 and zero mismatches after it.

Fixes: 7eada909bfd7 ("dm: add integrity target")
Cc: stable@vger.kernel.org
Reported-by: Sun Yangkai <sunyangkai@fygo.io>
Link: https://github.com/chencheng-fnnas/reproducer/blob/main/dm-integrity-writeback-race.py
Signed-off-by: Chen Cheng <chencheng@fnnas.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index c50feaa98bf9..0370d7d7ce72 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4130,6 +4130,10 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 	limits->dma_alignment = limits->logical_block_size - 1;
 	limits->discard_granularity = ic->sectors_per_block << SECTOR_SHIFT;
 
+	if (ic->internal_hash &&
+	    (ic->mode == 'D' || ic->mode == 'B' || ic->mode == 'I'))
+		limits->features |= BLK_FEAT_STABLE_WRITES;
+
 	if (!ic->internal_hash) {
 		struct blk_integrity *bi = &limits->integrity;
 

