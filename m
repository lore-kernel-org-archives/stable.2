Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191971;
	b=MA2sVFkII7l2D1DgWC7M+jpvl9vn2w7F2P2eG0BNPfoDxScmu9ovQDkhGQmTmJAQ2AcB
	 K7Gdbel3JeHNLCflSqbMv0413sakKbTpc3xK+rABKV3W2LJVOKt97qPJX+wxMVoY3ZtoZ
	 olzUdnj8QtPqow3E3kg/f6ovGU8ZmfuPtyx2l+J2y/VgDESMl3Of5uDa0am9mM/tcXpEA
	 RCdiIBgRL8Banjm8c6dBxwffllcxfxTRrDVotiVc/5SrKcuX/UDuFklC548OEypYa5WOo
	 59SOvY4uSxvuANyAM0CvsOFxT1pMawXm1mYlcmgNV47BdRqh3JyfQi1cw98vg9FQoMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191971;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4GpeMPp9esUWNHQVrf4y4sbUF5AJ0dox7FxpZYGLtcA=;
	b=bZpy//3GvRuMXosFZVsF2rbJvHumoHrfE4Ovckp1TNE2y6wTkTUJZ17ldtUYsVQdDlwJ
	 j3RPCNI7D4yEpouZq99c/GbZFIPvGRdjr/yflXItBT0CYhmPEvc3TnMiIcFsa2pVYw4H8
	 jkkD6KUrfRwCL5FTukeM7qawOCrxN1wWHv6//PhtTMcnRAxqYArMvAm6MkwZ6dolR2P4v
	 KNPoms0KQph13uDPZ4VXMXnI+/qYQVraJpx4OTF3Q5K/7ogvvtkOMpNjuH2rsuGvv/7hx
	 72vJ6kOPAFlA34Ps4xJtwz39lRxDED2jn7TwWINcpPkpeSAuEmqgGq79GfuFS6HhkyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LaDROMfk;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5CC606A31C;
	Mon,  9 Nov 2026 02:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LaDROMfk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=LaDROMfkLni22zaf2pme8CxZCcy2q29gPFJ3Iu8CC77PRXHnyx46yEIrfy+0GEMznqNR0ueM1AOMU
	 2v2lZ3gZpOkT3I7bFeeeWQbBfaseSAjflMNP0Q54Z6Xr33VvhTF2J9Pu4abqgcto+h4RZeGIqyVx3b
	 y8rQi/G7KAqhdpyQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af13260230-8b943;
	Mon, 09 Nov 2026 10:39:28 +0800 (CST)
X-RM-TRANSID:2ee36af13260230-8b943
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af132011c9-7db93;
	Mon, 09 Nov 2026 10:37:55 +0800 (CST)
X-RM-TRANSID:2ee86af132011c9-7db93
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: dm-devel@lists.linux.dev
Cc: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	linux-kernel@vger.kernel.org,
	syzbot+4b232570d625662eaab4@syzkaller.appspotmail.com,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH] dm crypt: fix use of uninitialized percpu_counter in ctr error path
Date: Mon,  9 Nov 2026 10:37:53 +0800
Message-ID: <20261109023753.1278-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If percpu_counter_init() fails in crypt_ctr() (e.g. when the
underlying percpu allocation fails under memory pressure or fault
injection), the error path jumps to "bad", which calls
crypt_dtr().  crypt_dtr() then evaluates
WARN_ON(percpu_counter_sum(&cc->n_allocated_pages) != 0) and calls
percpu_counter_destroy() on a counter that was never initialized,
because __percpu_counter_init_many() returns -ENOMEM before
calling raw_spin_lock_init() on fbc->lock.

With lockdep enabled this triggers "INFO: trying to register
non-static key" in __percpu_counter_sum(), as reported by syzbot.
The console additionally shows "crypt: Unknown error (-ENOMEM)"
because this failure path sets no ti->error.

Move percpu_counter_init() to right after the allocation of cc,
before ti->private is set and before any "goto bad" can happen.
On failure, set ti->error and free cc directly, so that
crypt_dtr() is only ever called with an initialized counter.

Reported-by: syzbot+4b232570d625662eaab4@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=4b232570d625662eaab4
Fixes: 5059353df86e ("dm crypt: limit the number of allocated pages")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
Not runtime-tested (the syzbot report has no reproducer; the
failure requires percpu_counter_init() to fail).  The affected
crypt_ctr() code is identical in current upstream master, so the
patch applies there as-is.  The Fixes hash was verified against
the upstream commit that introduced both the init call in
crypt_ctr() and the teardown in crypt_dtr().

 drivers/md/dm-crypt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 1ff16b8264..3e69dcc366 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3249,6 +3249,14 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ti->error = "Cannot allocate encryption context";
 		return -ENOMEM;
 	}
+
+	ret = percpu_counter_init(&cc->n_allocated_pages, 0, GFP_KERNEL);
+	if (ret < 0) {
+		ti->error = "Cannot initialize page counter";
+		kfree_sensitive(cc);
+		return ret;
+	}
+
 	cc->key_size = key_size;
 	cc->sector_size = (1 << SECTOR_SHIFT);
 	cc->sector_shift = 0;
@@ -3260,10 +3268,6 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	crypt_calculate_pages_per_client();
 	spin_unlock(&dm_crypt_clients_lock);
 
-	ret = percpu_counter_init(&cc->n_allocated_pages, 0, GFP_KERNEL);
-	if (ret < 0)
-		goto bad;
-
 	/* Optional parameters need to be read before cipher constructor */
 	if (argc > 5) {
 		ret = crypt_ctr_optional(ti, argc - 5, &argv[5]);
-- 
2.39.2



