Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705397;
	b=k8WydGkRHAhhzwsGGqkIjhtDfXvka1+XgvrSrrMUpQiEZyGtf73FZccD3kMZQQqjhlLJ
	 vc/BkpgF7Df2gLrjqgVZxsla1bUTPftGbWl7dFSW13MhoMmOQcR0Bh2iHeQ9/JSsP89fs
	 XJSiCAp2duuGjvruWtxSJKQjtPscDvyOKIt+t12rC4f/V4pWMfT+0mHdgC/UEK7pG75Lr
	 lC76hlISRXLRV8AbfHXrOX9OLaNeaqw10MkLshJtMwEfyra1Hg2FikCMVYOBwIAoCpeF2
	 SNldlo+d0YENCr3qMg4lPvrjNzwzzucmnlu273R6WwdbYywoy1thGOpI8EnoDwWsvxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705397;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J1QilM+aYDElq8YlP1xFkza0HRCaGOl4ERWqk10bcJw=;
	b=rCwq89QpkDFbtBB2H29FILm/ByLBrytIRUeoNLf1DBJHB+34QuBGVBcouQxrHbA1jbqa
	 mn5OVnlGCBhKB2/DzG758DaCs/xhP1t05G5ndeEku1I7vlFSaQk2ZFGspgTMs9x0dy0cY
	 G7tyClRmi59abztm9woojc12ViDlygv85gaIk70oDKnSWRyP2O8OnTeBU4ovnk+kd3DFk
	 zJhiBsFw6XsI8lX/KG4qSVA4Md7S1b0I0Rj8jj6v/2eeXrZBJDrA3xPOuxnE3WoaAVrKI
	 NxBHlubdsvcLuhfUd/f8bj51D8s66yGhVbAYOEr3dF6rYYsNj35ptRdL2ElGT2vVaEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0wj8hkA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B09B606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0wj8hkA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674941F000D0;
	Thu, 26 Nov 2026 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705396;
	bh=J1QilM+aYDElq8YlP1xFkza0HRCaGOl4ERWqk10bcJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P0wj8hkAuzVljs6bqf5pMGrWlF7kzlqLWlBSioYmFIYQDRyYUWjF+l3578WA593F+
	 FTsdp7etjlY9D1xESCm52ziBlgs8GI404AQsHpJAqOVz0gO4BzcW/5prt1t+0ePHoi
	 1jjGKuiPRFSkF87rKc/TV4QB6qsYhLiOB7VXOuvSN4MJrQEaLgDvjKoW6enWAzE11U
	 U5UAlpHn7+M5mIeYlqjLpQgQHxPEZOWM0ok8q1kT5dw/KyK3P8iLDmyXvS/B6V5MjC
	 4zP3dBhTVQ/FpN5c9jfSZXJzzSAHMT/JrWkHISyeHrwUXgg8TTT9j94lOVYC7N5dUB
	 dNOLqBCqdpCOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Schlehofer <pepe.schlehofer@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm-crypt: defer async write submission to write thread
Date: Thu, 26 Nov 2026 10:03:15 -0500
Message-ID: <20261126150254.2214336-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112521-nibble-keg-edbd@gregkh>
References: <2026112521-nibble-keg-edbd@gregkh>
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

From: Josef Schlehofer <pepe.schlehofer@gmail.com>

[ Upstream commit 6fed9e26810f0b466dbcebe35a73d1fd48793ff5 ]

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
[ sashal: Kept the tree's existing submit_bio_noacct(clone) call where upstream's context uses dm_submit_bio_remap(), since that helper is absent here; the condition change itself is identical. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-crypt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 611d92ae3218c..16135160501a4 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1941,8 +1941,9 @@ static void kcryptd_crypt_write_io_submit(struct dm_crypt_io *io, int async)
 
 	clone->bi_iter.bi_sector = cc->start + io->sector;
 
-	if ((likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) ||
-	    test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags)) {
+	if (likely(!async) &&
+	    (test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags) ||
+	     test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))) {
 		submit_bio_noacct(clone);
 		return;
 	}
-- 
2.53.0

