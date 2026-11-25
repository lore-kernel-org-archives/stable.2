Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606419;
	b=c9BVwuNQKkadITTBKf5JrBNaxAM7WyMhqXn0nC/wHxK9LBQsXF3SFTR9giAGPVA5ko9X
	 DWu5ALO+2Xh88EKikpehwCGgxMwG81Ko33G8RwktwGA6FbxM7PvcKLPwqbwf6hpwt+atk
	 XX9gY4+zn/zlhat027mz4XBdySTGAdZ2A2g3O+8R8b8kRqptzVfbijvdwEvO7tDu8lJtv
	 4orCCqbIaxjwP76+sniMKWHu8hsGCqUcolILo7ZUaGERNW0wclXLiIJmpONclN+G7jRz4
	 RMB/djE2rvejmpeCFRuxtByGSfllndNB69v/z7JpQH/0CWtKnEiBN6FBRImyXQSi7pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606419;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2MlXXTxtbCQUKwrMgbBR1DmUKtGDuKihq8HNxzJabHw=;
	b=I0EInAllcjbpcoRrSq+zUwObthUUV30Ex8rnn3n4yfEKffRjpv/G2Htn1gMAgjBDjHi6
	 E0fa5kT/AitdHr9mX/XqgulQVGPKLPT6MZCmhzZBIjejUY4HexBKpDoNf/BJ6OpiGJtGF
	 y9tYv2o3CMB6Dhqztyj5rC/Fq/DIXNfhRt/TJC0MLkn7b2xxkq2CDk9Kqmmx8Q3ka0St2
	 KNUVnbQ4b+r1leU1Bh3IFLX7XzzGSuJbWbdzhoWd+98QUXkQRCAeNE3E4z2jcprr1KXv6
	 ORCFOkR1A+6QegrJT1JN+G+4H7pL5T94KeuoFx/41B674t9S7/vOkBLF/lIKZxEjhIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qnjaQlGg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463E9606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qnjaQlGg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E351F000C0;
	Wed, 25 Nov 2026 11:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606419;
	bh=2MlXXTxtbCQUKwrMgbBR1DmUKtGDuKihq8HNxzJabHw=;
	h=Subject:To:Cc:From:Date;
	b=qnjaQlGgJqBGhwJCgRl+G0B8o74z5oc3pKfsuCdu/CCJp0LvxCQAUx4dFlLBTHjHR
	 JNwqSj+uY4QJflHbvWNNk3Lt93zALp1VVcdAndieyQNRlHA2Uy1d8+PUsEkBp8aWj4
	 WT3D29Ou5iTJumJTyEM3qDemP3WgP/r8en/PvZLQ=
Subject: FAILED: patch "[PATCH] dm snapshot: split discards on chunk boundaries" failed to apply to 5.15-stable tree
To: chencheng@fnnas.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:25:41 +0100
Message-ID: <2026112541-propose-squeamish-528e@gregkh>
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
git cherry-pick -x 4fe2c2baad01da64d47f1a0c8fc093df994bcef5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112541-propose-squeamish-528e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

