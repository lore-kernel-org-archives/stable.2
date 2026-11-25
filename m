Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606424;
	b=UxyfsglB4YbxWkBFvjcs7H9xTy+OJF8Q+oUKY1fRgfX+7dgXbKF065h7AOVLokE3i+CI
	 +8YeUYZh0IUw39SAn6ZNGsBizH77s7FC8poBQKMUNaevr5VSjsBrxYpP4MqDJZz/uHHsN
	 kQC0zLgM9yHWDt/7kORvi3sAlE201v9mzU087QFZT1xSadTCw1OHhGtS5O++k453pqNK0
	 CejmysUjy5z3Rr40vjJ7d3/qYo2UAMmbh6ziKqGXNfdEk6H7NGSj9kKKY66bg0gOUC5k5
	 6UW+JYcTe8+nzsX3HnIWbdUDkToIQ78cfu2dVVqoAdD0MGmL3oHHUL5879BGvog9B+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606424;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LgOQyVkJ42nDmUsd5Ma/OkSnH2YgFNOVYXEcjfTiFbI=;
	b=l9+/YNfvOEJPbCz5OXB2IAtmVtmv3craLruFPE7Bh7naTkp2ilrBMFafwo0VzHEz+L/7
	 S0J/Cmda3QitPxYypqDLwYA5qixlxSqHGNxpRiCDOK6WTO2tStFYjrCr4DjrGHp4guzuC
	 xjKSd0LIWteKDIFiE1kRNtMHXJEdNfMhB6nElPYwZSy0e8y29vljzzQTbn1SqifbgbOyj
	 qu6dfzvQW4SW0gtPBlJCxK6qF2ABXeNPwvupl8NR/389lXTspODxaQTLX692lCEl1y3dv
	 VDKDzmxeS/0mNNuWlpQhyF1JncgRaBpaYTC7CjV8MGoIwSQPPesIeMea1v+rdQ/z9HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OdUMo71O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9226606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OdUMo71O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F661F000C4;
	Wed, 25 Nov 2026 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606424;
	bh=LgOQyVkJ42nDmUsd5Ma/OkSnH2YgFNOVYXEcjfTiFbI=;
	h=Subject:To:Cc:From:Date;
	b=OdUMo71OhPav+OAaepDVBrfNaSwTaGgQzu5x521FuAnSYhfJyA7VDS9JET3cl/zAN
	 j3ZqUB0bXS33eAecr6LUk9g2nigXk3OHQJ8aZeu5go8yV3yG6YdVM+aYijWgjhLUEJ
	 7xZUVUQBOya3Vw4p+3k0xpaqAfe0LFecn8s1pBLE=
Subject: FAILED: patch "[PATCH] dm snapshot: split discards on chunk boundaries" failed to apply to 6.1-stable tree
To: chencheng@fnnas.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:25:41 +0100
Message-ID: <2026112541-handbrake-curtain-5903@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4fe2c2baad01da64d47f1a0c8fc093df994bcef5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112541-handbrake-curtain-5903@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4fe2c2baad01da64d47f1a0c8fc093df994bcef5 Mon Sep 17 00:00:00 2001
From: Chen Cheng <chencheng@fnnas.com>
Date: Fri, 30 Oct 2026 17:21:28 +0800
Subject: [PATCH] dm snapshot: split discards on chunk boundaries

dm-snapshot did not set ti->max_discard_granularity when it allows
discards, so a discard could reach the target unaligned, or spanning
several chunks.  Set the flag, so dm splits discards on chunk
boundaries.

Fixes: 2e6023850e17 ("dm snapshot: add optional discard support features")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Cheng <chencheng@fnnas.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 31676ee05514..e49427bdbeef 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1358,8 +1358,10 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	ti->private = s;
 	ti->num_flush_bios = num_flush_bios;
-	if (s->discard_zeroes_cow)
+	if (s->discard_zeroes_cow) {
 		ti->num_discard_bios = (s->discard_passdown_origin ? 2 : 1);
+		ti->max_discard_granularity = true;
+	}
 	ti->per_io_data_size = sizeof(struct dm_snap_tracked_chunk);
 
 	/* Add snapshot to the list of snapshots for this origin */

