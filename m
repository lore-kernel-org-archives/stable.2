Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705547;
	b=05L7mewPTE9nB/07HsEU8nmEFfgACwumsweD90FkD04+DZRy1h86hwkj2lAj1B7GLN4S
	 mPQ3bR/IR02HPdJZKPgtIl7CqexT/ScG9rm1dBRwITUSZNLbgmktvcKIM29BFnbZaKZP3
	 RqCb3NBg8RNObhaY6T1k47plZBiIZzpr6103VbqjxgItYHWCZrGibp482qjdGWRG8ryce
	 R7qgi7qHkeBqzvrSiBAZQhdfLVP2yRF0l9+uZZqM0IaEkTTH6IrjJCrC5DAN27Lk2oXkE
	 TNjNjLb0qpxYujHvW6C4gawsVym3EGy7rgTHIiZEES69yTDb4mrmmlI9rjhsaRxhWaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fvU9x/aPFVVb2NaTG1izoVYSc5CD/TU9wun9Yo74EtE=;
	b=klJhvSutQOBQ+nB59RwSSdev23I/eS4BkB+6X01tv0TKDrckbpLla/cd6FLug7Fc1MWk
	 oBR854iIMbQaV+j10H1wktHoefeJadgvz9Eyl/ZAxotoHcyzQTiWsTHwpdRNVUFAxWq9k
	 iB2ANup2J9GbEx5joHSiHfMRImrder9H+4axTM/1CdQZ/v80TEekvssWEK+FMnJePea51
	 7Zn/K4OxEudKYhYEQTRIJE3Sfe5nac0kZ6X9mcH17NlUXYUp2DTkuMmqyEtaiORoJtr3J
	 p6U2QJHpYfEVZKRD/kOOpfvwZNu/HeiPo0pHu65Or0uBcfZ01HThAL4qh5hZG9RqDiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XS55VKtM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545D0606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XS55VKtM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4738B1F000C4;
	Thu, 26 Nov 2026 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705546;
	bh=fvU9x/aPFVVb2NaTG1izoVYSc5CD/TU9wun9Yo74EtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XS55VKtMFdXO4si9UnjbeGMiuYWV1j4bN8dPtf2QU/bd98EEr7sKPPjL7fXr4sNS7
	 yhL6FxPwNseoTRuKk+Mjdu5zD8eq/3j9ND/3CLupIOboEGRBOTpHEyA13KpG9Z/ZO4
	 4RivAzs/877kedyaUnhPwxbUg9HVwP/EsPw6kraXZBrR1i4KgKIMcFkRmo6lZrUsIH
	 +LMLp2arSA/zRpW/PIYG+gqZn/4WlJXDdDNp+KIdzY5ko1wS11Ds91wGPU6bALfu5q
	 XfxMgPhroC2pGahYKqGb2ZlrXgp3QJNWCFZ1TFCKTbrOl8sYiHQPn0yvMNgCqefbX4
	 ilmHrkObq1jMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Schlehofer <pepe.schlehofer@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm-crypt: defer async write submission to write thread
Date: Thu, 26 Nov 2026 10:05:44 -0500
Message-ID: <20261126150529.2235735-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112521-babied-pebbly-f2aa@gregkh>
References: <2026112521-babied-pebbly-f2aa@gregkh>
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
[ sashal: adjusted context since the clone bio is submitted with submit_bio_noacct() instead of dm_submit_bio_remap(), and the surrounding lines lack the BUG_ON check on iter_out. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-crypt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 7a528f62fbbd0..dcb42505cd78e 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1963,8 +1963,9 @@ static void kcryptd_crypt_write_io_submit(struct dm_crypt_io *io, int async)
 
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

