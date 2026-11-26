Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669293;
	b=ecsmbI96WWciFMMXjl11IB2nZqLWk8WH1GEB71JM/WFLioCKG9bXBKIHje5dQdKD32ym
	 xVzYRLDzFK6TM/GaKrErcSdKqdWfP5E5s3+BdysZKG4fVg5LYQRmVDCG7CpcC/MPYjENX
	 Tt5TeOtNKeX9Zuq88FzmPu/2gPUUrzInWjawBIGJof74vhZXEK9rF1FSI9Brn7aq0ZAbo
	 CWUpQouXQuMAYvOa3vGmSFmdBIs9cDAscQeumJL7MMuz6B7Jslt6rYOBBrJPtVG43RE5N
	 YQKRlBjITMw+8kAtD9W5ti86/6UujVazfp2uTXskeT+hg+ISfHvyqC5GiFWsxUjfp8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BICEd2mJPHyVCsnilGalZwmAXQNzLB3i8kGaT6cdlP4=;
	b=qkvbqDFqWPOQcGfiK6KYGk9Xml3uRYHL6ok8fAyD5qLjylstXdD9rxbUtUaBOdbbkJTr
	 o6kbEbtYHCOdrXDZ5vF2Pn4gX9UVbmcoU3evPuHKPYtVV9gqMA80HSMVcz63FVhHL14Si
	 JHzYCbl0iiImyq4tVjqsNNelBedIzRDU9WJ+Q4FSm9ojUgFQ4a1lW1q+rEl2aQhHIhesV
	 ijeV7fZF2wK7zKdnS7TI5JDyswaiBX3J4dmOXadDx0RSUlXltML4TrpaYsumri984UhUp
	 KgR+6hXAPulg6WeheA5FrNktLXO93EHSP7O8+LSyDhG74/hY1AT2rcfxwfQYheGLsNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQYU2oxG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4951D606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQYU2oxG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C00B1F000C0;
	Thu, 26 Nov 2026 05:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669292;
	bh=BICEd2mJPHyVCsnilGalZwmAXQNzLB3i8kGaT6cdlP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CQYU2oxGUzB8EQx4Ur9x4GEkHL62Tg+wXZrfg5l1nKq0I9jTWYTsS8Q4kg/8dqbF0
	 lFm04Ur8xSC4BgceCCNf3KCYJhYhkUKJbbGCUDVbIT7OWc81ffHHuCQBwLrQEURROU
	 AkqcaZlptbeP8y2MQq2YM0Q63DIm7gAZImjjLJcwPsiH9i5hvzqT0zIFedFJ1lqd2P
	 ACk1Xq9H4MfUupDGYgrrOkhe5yViQMD+C9gGSDBJesoCGhsdtlcpkBp9jmMB+El3oC
	 AmFJ9gij+kgv3/+baFQre6Ru11CI7gThOZm7tlEJKFrun1bNVN22NwJBm5nvSSpPSm
	 T45uRBWaCS6mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weijiang Zhou <weijiang.zhou@unisoc.com>,
	Hongyu Jin <hongyu.jin@unisoc.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dm-verity: don't restart or panic on errors during system shutdown
Date: Thu, 26 Nov 2026 00:01:31 -0500
Message-ID: <20261126050014.2081983-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112516-crystal-retriever-61b9@gregkh>
References: <2026112516-crystal-retriever-61b9@gregkh>
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

From: Weijiang Zhou <weijiang.zhou@unisoc.com>

[ Upstream commit 47930d1236d2988cdc580c10d3af21b6b02d7ece ]

Commit 252bd1256396 ("dm verity: skip verity work if I/O error when system
is shutting down") stopped I/O errors during shutdown from triggering a
restart, since devices may legitimately be gone by then. Errors that reach
verity_handle_err(), e.g. through a failed hash block read followed by a
failed FEC attempt, are not covered and still call kernel_restart() or
panic().

During a reboot that is both wrong (nothing is corrupt) and harmful: it
races with the reboot already in progress and replaces its reason with
"dm-verity device corrupted", which bootloaders such as Android's treat as
a verity failure and switch the device to EIO mode.

Apply the same shutdown check in verity_handle_err(). Corruption is still
logged, recorded in hash_failed and reported via uevent, and the I/O still
fails.

Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
Signed-off-by: weijiang.zhou <weijiang.zhou@unisoc.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 252bd1256396 ("dm verity: skip verity work if I/O error when system is shutting down")
Cc: stable@vger.kernel.org
[ sashal: adjusted the final hunk's context, since the surrounding code in this tree differs (verity_verify_io returns r instead of 0, and the removed helper is followed by a different function). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-target.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 3e582c1b544fe..ce72eed21d6c5 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -215,6 +215,15 @@ static void verity_hash_at_level(struct dm_verity *v, sector_t block, int level,
 		*offset = idx << (v->hash_dev_block_bits - v->hash_per_block_bits);
 }
 
+/*
+ * Skip verity work in response to I/O error when system is shutting down.
+ */
+static inline bool verity_is_system_shutting_down(void)
+{
+	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
+		|| system_state == SYSTEM_RESTART;
+}
+
 /*
  * Handle verification errors.
  */
@@ -262,6 +271,15 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	if (v->mode == DM_VERITY_MODE_LOGGING)
 		return 0;
 
+	/*
+	 * Devices may already be quiesced (e.g. UFS set offline by its
+	 * shutdown hook), so a failure here does not imply corruption.  Fail
+	 * the I/O but do not restart or panic, which would also override the
+	 * reboot reason of the shutdown already in progress.
+	 */
+	if (verity_is_system_shutting_down())
+		return 1;
+
 	if (v->mode == DM_VERITY_MODE_RESTART)
 		kernel_restart("dm-verity device corrupted");
 
@@ -656,15 +674,6 @@ static int verity_verify_io(struct dm_verity_io *io)
 	return 0;
 }
 
-/*
- * Skip verity work in response to I/O error when system is shutting down.
- */
-static inline bool verity_is_system_shutting_down(void)
-{
-	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
-		|| system_state == SYSTEM_RESTART;
-}
-
 /*
  * End one "io" structure with a given error.
  */
-- 
2.53.0

