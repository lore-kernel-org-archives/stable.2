Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669033;
	b=1CDWRXD1gDjJ89EoDAuC1yvE+4snPiV1UDiUsjiA6pZndZZPrmMoeL7wQxGfBTapfEBg
	 sXDBVCKgJlgleJCEsEMA0+hCDpTZ6qMV6e9Nc+bmN6kBDle+D8ArYGr4AKWe4zmvGmaxE
	 aN8oye3DNmA+5I9fxj9AInC1JFDNWsjqdm8xBrBNoZT8QTf/Oy4sK7dESuCE1DAIw+gde
	 +v58KOeyotbBsEru8yatkyt2fQxdbPvQcQ+ETdtYo24o+SO8x/p5mzrD1QZF/tXEvw8QA
	 ioX3xerE1o+6Wth8UVtini94Xynfky6vOa+q+DrumtXLtgH81ioQtoq9xkWOH/VenyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N1r/9IZ8aztAm2hWy2umWjRPYC9UdAKqSUxxm+hGHIc=;
	b=Hh2fvF5S63nlSiGHiGarGuO1imfKBuwpraeEd52ommYCWlpaMpxuEPCKtj/NYfNs8uGA
	 +RQJ+C5uQVEmG8DvID91C3vk4NWVALafG2DePkzm9bu5hbqcNEBHY2DSVr1FtDL5hhOoO
	 AM9Bo887LRvEAE39mi9TDYbKOc5s9ZGrW5L1m7leiaLGxuaoHPspy/pCW7Pbt9WycxGL5
	 GzlJ8QZEePlAbvf4AouCkJEnin+9b4fJetdImxH9udpGuSa690yC+miJR07iaH3dG1u3E
	 50ssEdC6Klo72GlmaLmLSyiSjwWt/e0iy5Bvm7Xi/Y4I8xyizh0gLoUoanxM4FaTv8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+iAnDU+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB3606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+iAnDU+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0313E1F000C6;
	Thu, 26 Nov 2026 04:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669032;
	bh=N1r/9IZ8aztAm2hWy2umWjRPYC9UdAKqSUxxm+hGHIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k+iAnDU+dI+PiUhqY6LmFcWYr4R8DT310LQsM80C+Ds9Kq5/DHPuFu2Vh+f0rthEH
	 rJR7ls2fM+9oXsUyzUfdCbjSsPdcTi3IVEQbLxS9Z17IdmXkdoEXxMEUh+7qvunvNK
	 OOcxca0NoyKlJuy1hRUc/lM+qNIqImuyh1pQpeT/gtzsNjZSbzyMiJUKSyZiZSZvKw
	 pN7ZEu46cLYPLl7M8Fhq3fVq97ZXIF8utcRjSlkcLbuD2HUNF17dhspGJJ0eMkfvCf
	 KGxnQ+I5zE6Wm6MvA+aDPz7IzOfkRh4ZQS6xJ/d/pQypXSQlfwh7nGTUE5onms6MSW
	 0z2Zem632f9NQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weijiang Zhou <weijiang.zhou@unisoc.com>,
	Hongyu Jin <hongyu.jin@unisoc.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dm-verity: don't restart or panic on errors during system shutdown
Date: Wed, 25 Nov 2026 23:57:10 -0500
Message-ID: <20261126045453.2062293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112515-electable-treachery-1fe5@gregkh>
References: <2026112515-electable-treachery-1fe5@gregkh>
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
[ sashal: Dropped the restart_io_error() context from the deletion hunk, which this tree lacks, so the old verity_is_system_shutting_down() copy was simply removed. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-target.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 27ef5c0167cb6..7cc599ef87a4b 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -217,6 +217,15 @@ static void verity_hash_at_level(struct dm_verity *v, sector_t block, int level,
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
@@ -266,6 +275,15 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
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
 
@@ -668,15 +686,6 @@ static int verity_verify_io(struct dm_verity_io *io)
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

