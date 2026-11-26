Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669500;
	b=Yy8a5st13hWbp/dbEkZK9f7eIWDfPKnyZQS1yeWtrxtSllnLxEqHFW98JLh/9hQf599V
	 k2WjAogJZFQ6kffGFUydEzsgnN+Cux5z8dnRSrRjHCMLqKHuScLL6/CR8hJiee27dKnWJ
	 RDmDZvfE8sEZHUbaRRpKlCnn2fHMiOSqXPVcJon8E+mwTOVZNUtJKCZLxarjJoxtAGEr1
	 4IVLP6wsnCMtj4fW5EcDRKToFvo8lOQlCmaTFQRobsYayLkknh88Yw+HuT5Ww8I19jV8g
	 XAZSwgPN0Lt443amVb10DmjRI4QRIrANPoRoqpaMFHqAFdKYmDq003PJka3/NgsZmrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669500;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fnI9fUiuSHBT3AmJ/kAlgmIimI8+chPnVw6fHdyz8LQ=;
	b=xx/nOT6u5qwK95M/y6tePqC/MF2DHnOysomMVTmbV6CDPQwJDiYvU/WgOHOvIPh5ZMmO
	 0v/t/2HVGju9IEjRTkMIDlydapjgeXe4zmFqgutB0+IZDagEWIO8QQ1Etx8Iz3IlABylm
	 XKbuccS7sbDXhCxlGkPoGdSlCkGG3cSJXEqUIKgVkDkFQfOV7uKI5wzU3i9r03Z1gYN+c
	 guV8UmGQPjsFk5re+PxtoncJSlGDv9GV1qwHx5p4np4c0aGqaPYK0Ec1SaFK1JcLmCKFn
	 v2welQSmNVSjaVtNhA8/VO8RCw9GKay0F8GkIzrxdk+1nnZJnGKFX6s/ljOlHhnlGAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lj1Qwby8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461A606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lj1Qwby8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC101F000CA;
	Thu, 26 Nov 2026 05:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669500;
	bh=fnI9fUiuSHBT3AmJ/kAlgmIimI8+chPnVw6fHdyz8LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lj1Qwby8/yY9Fhbyy7PD45LQvsK8oZbOVEsDDkvHsZWSaflQ0P27/zFCE0P4ay0qe
	 1s90R7OtSApqf7fdSvb41zb6JOKfHfvpV3Hfn6zxYmGqm9ENf7ZOVyCq3sKh9dlGX6
	 9d6sMInWp7RVdOqODJbhRnCZ8F2L1oSisUO5VC23OyKPjeCFT0yF4Ul3oQqGjdBcry
	 KVMTlgsioTbnopmzQ97eq2dCtgrLfPZY7ropeDKXHicd3g5EKy4SiH0AIAX86OuVoI
	 Ybcq2ZqnF+sm0PJ0AdVjfuZ7t9JFDzP/tXIj/CJ9vbzkTlRW6Z8deP4FSe5h8dyhG0
	 RaN2t+Klbi6Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weijiang Zhou <weijiang.zhou@unisoc.com>,
	Hongyu Jin <hongyu.jin@unisoc.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm-verity: don't restart or panic on errors during system shutdown
Date: Thu, 26 Nov 2026 00:04:58 -0500
Message-ID: <20261126050433.2096184-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112516-magnetize-reverb-2675@gregkh>
References: <2026112516-magnetize-reverb-2675@gregkh>
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
[ sashal: adjusted context in verity_verify_io() (it returns r instead of 0) and in the removed system-shutdown helper's neighbors, where restart_io_error() is absent from the surrounding code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-target.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index d92eae5278309..2a7266f96ce6a 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -207,6 +207,15 @@ static void verity_hash_at_level(struct dm_verity *v, sector_t block, int level,
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
@@ -254,6 +263,15 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
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
 
@@ -548,15 +566,6 @@ static int verity_verify_io(struct dm_verity_io *io)
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

