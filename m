Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1011D435F
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787703973; cv=none; b=B1DU5USgockFTj0A1o6gOzmT+UKv2aSCi079Pzx2uKZJtv9a6tI6KGKWvLrWp5UN6dN/kLFi4Snnq0OFr4gWgk4k5yyWH8LeVLNpqmVGid6Z3q/629pqL2O0K+WThCPGYv6lNw6sUCb97u3gQL9M6gdaZqZVBSGf2/NJC09A3LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787703973; c=relaxed/simple;
	bh=NxDKxbFlED+fFDd4TCm7HQl8oeKXvA3b2POunZDitW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TPfvvesqqh12kJI0qGdqqTR87J28kNRQ5JAMVmpnbZbUPC+z7J5IL/SN5ZQovt80oOgJGyu4N/GibLULu/LSfVFVRURJf4pEiMvUMjjWtJrPO4oROMNhwFHOM5XuPFnKNGJiyq34NCryeASHV6/AbPpZ5lL45/xer+ciV97S5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev; spf=pass smtp.mailfrom=cressey.dev; dkim=pass (2048-bit key) header.d=cressey.dev header.i=@cressey.dev header.b=Ib3XOxXQ; arc=none smtp.client-ip=91.218.175.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cressey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cressey.dev header.i=@cressey.dev header.b="Ib3XOxXQ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NxDKxbFlED+fFDd4TCm7HQl8oeKXvA3b2POunZDitW4=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787703967; v=1; x=1788308767;
 b=Ib3XOxXQJkoWQKEBd5zro/bWGaiYgZIDmTcAHGGm3k8WpxcCLx1AiZXiMd+B/zenVFY/CBzX
 TLtTkHJhjp/H7ikoerKPLH7gprkMqG3H3T3a42IA2s0DcNH5ESMl0m6vn0yxI5uQ2JxCkvaeYFQ
 C10XOWyb+Vhh6BbwcpSE51+qlvlI+TeIKVUQ5TgETx8ic+gkjjbnU1sagnSmDFb8KpEj9Cmp+b9
 531IB23AAcCHZ//RhVgkcvONtWvUt9kamh/jjwdjmoYjgRqB3+dICGFUvrUvQf4L+SZnbFc1MWr
 hsoIlz0t9q4PkzFoWZcY7PZG6LNBMbBIhIZEZLB1mQvYQ==
X-Envelope-To: stable@vger.kernel.org
Received: from coder-bcressey-whiskers-0.coder-bcressey-whiskers.remote-dev.svc.cluster.local (35.83.186.167)
	by smtp.migadu.com with ESMTPS id d88eb38d4e98656b;
	Wed, 26 Aug 2026 00:26:07 +0000
X-Mizu-Trace-ID: d88eb38d4e98656b
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Date: Wed, 26 Aug 2026 00:25:33 +0000
Subject: [PATCH] dm-crypt: fix a tiny race condition in crypt_dec_pending
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-dm-crypt-dec-pending-v1-1-395bfee3576b@cressey.dev>
X-B4-Tracking: v=1; b=H4sIAHwyjmoC/22NyQ6CMBCGX4XM2QnYyKKvYjyU6Qjj0jZT3EJ4d
 wGvHr9/HSGxCic4ZCMoPyVJ8DNsNxlQb33HKG5mMIWpisaU6O5I+okDOiaM7J34DndVzQ3ZfV2
 VDHM1Kp/lvc4eTz9Oj/bCNCxbS6K1ibFV66lfpFvMKbyCXlnz1fp3A9P0BZHs6qOwAAAA
X-Change-ID: 20260825-dm-crypt-dec-pending-467e8ca9765e
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, Milan Broz <gmazyland@gmail.com>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, 
 Ben Cressey <ben@cressey.dev>
X-Mailer: b4 0.15.2

crypt_dec_pending reads io->error before calling atomic_dec_and_test.
Another context, for example crypt_endio called from an interrupt, may
set io->error and drop its reference between the read and the
decrement. crypt_dec_pending then drops the last reference and completes
the bio with the stale status - so a read that failed and was never
decrypted, or a write that failed, is reported as successful.

The read was placed before the decrement by commit b35f8caa0890 ("dm
crypt: wait for endio to complete before destruction"), because that
commit freed dm_crypt_io before calling bio_endio. This is no longer the
case, dm_crypt_io lives in the per-bio data now.

Read io->error after atomic_dec_and_test instead. atomic_dec_and_test is
fully ordered, so no additional barrier is needed.

Fixes: b35f8caa0890 ("dm crypt: wait for endio to complete before destruction")
Cc: stable@vger.kernel.org
Reviewed-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Signed-off-by: Ben Cressey <ben@cressey.dev>
Assisted-by: Claude:unspecified
---
Found by inspection. On x86-64 the load and the lock decl are adjacent
instructions, so in practice this needs an interrupt or preemption on
the CPU doing the final crypt_dec_pending.
It could only be demonstrated with an mdelay() inserted between the two
in kcryptd context: with dm-crypt on top of the "error" target, 20 of
20 failed direct writes were then reported as successful, and 0 of 20
with this patch and the same delay.
The affected pairs include kcryptd_io_read_work vs the read clone's
crypt_endio (deferred or recheck read), kcryptd_crypt_write_convert vs
the write clone's crypt_endio, and with an async cipher the read and
write convert paths vs kcryptd_async_done.
---
 drivers/md/dm-crypt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 608b617fb817f..9e170de50ad32 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1745,7 +1745,6 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
 	struct bio *base_bio = io->base_bio;
-	blk_status_t error = io->error;
 
 	if (!atomic_dec_and_test(&io->io_pending))
 		return;
@@ -1767,7 +1766,7 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 	else
 		kfree(io->integrity_metadata);
 
-	base_bio->bi_status = error;
+	base_bio->bi_status = io->error;
 
 	bio_endio(base_bio);
 }

---
base-commit: 39c5aa3bd8ec3912d2cd0b3fe092642b0d2b0713
change-id: 20260825-dm-crypt-dec-pending-467e8ca9765e

