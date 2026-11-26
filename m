Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669652;
	b=3iAG+wySFNlU8olKzaj27gl4C4DLr7G6D+QrsHdlDzD5dxdngY7ls1rtxYiyNg2hXRLW
	 brT+Y5cFRVOPEphyUVMRDj2H2Q+U61INixXpuPbNG8mnb8Js98+D+aU/DW+j8BGjsNAS2
	 1DRgwQo2udA7+ZlexQK/Mv57crHYXV9O68TVOtKZcWUvJMljez+UaGLZMdQnky0JyQfob
	 x2LivLTCwGKgjwcVigU08GJJnytdlAnSOkyVZqv0oUF3AU38qBYe/NAFUk4/IDd6i0BpB
	 UbFOhzXwiF5O1cxkXV60n0TqO8+abdu+1revEydICoL+hR0pHAbxcc8HgY4kVx4i1Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669652;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M5dh59kqHqoZRXPfiKHZ+BOL8WOJh0hhNbCfEWsydU0=;
	b=rz8Wl9BnSwMOcxqd+yji8D2yO6JS+HnU3hxqqGwxw6UbVLHnE7CIMe7ONbumad58n4vg
	 PQl0Po/ne/e6otdXT2N0yT84Mbl2kjamuW3MwRxvkE3tyuxAhSTnza4gml9LLNdPi38Ma
	 zSff5yf969asYHQB2qUqb15mDgx2V7u8jzBA4JLTX8OWX0DPR/TBQKqgBWU73nIBLq1x7
	 ZZ5KDuCH+yltUdRq2Im901XTFSWCfJercdmnZQjXP3XMoPWVLRZX2yTZuixwPrgdqDvMv
	 OJFORww/qYXUXD0PsxXJ557bgZZj5eus/m7W1H1SDm0kUWhMLBsReo7QZ9E4ElKs5gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJHf1EFi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BC9606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJHf1EFi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819901F000C6;
	Thu, 26 Nov 2026 05:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669652;
	bh=M5dh59kqHqoZRXPfiKHZ+BOL8WOJh0hhNbCfEWsydU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dJHf1EFiTwqeacddx8KzJGfNgJri3JXiDbWD+ZRFd/4zLx1KbIO7ytNRNerKMtboE
	 PrDebLdk7e7yXPFUZ7m2KzI+cu0ck+7jQjGqg01abu5TXbb9VvFHMzo+BjQaRQ98h/
	 FVtg3k5IoIYfVk2toZJW7uJZt4gB9CNqh2X8GAesKwzt5i7yomFxY3kVsXSYOo/rAA
	 I9E74YBABHwjuqPKAFgAbhMqE6DruqXyI6q+eguOkpxNpej5rkhlLX3rWfKpDwfpoA
	 KR3zIEp+7EA9qWdTmQ90dTzK9x8QYKV2f3zUVj4mnLNjDlIOokJLj+VpubpujiXDeI
	 uYREI95HbeFcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weijiang Zhou <weijiang.zhou@unisoc.com>,
	Hongyu Jin <hongyu.jin@unisoc.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm-verity: don't restart or panic on errors during system shutdown
Date: Thu, 26 Nov 2026 00:07:30 -0500
Message-ID: <20261126050707.2107329-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-most-helium-cf76@gregkh>
References: <2026112517-most-helium-cf76@gregkh>
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
[ sashal: Dropped the removal of the now-unused system-shutdown helper's old context: the surrounding return value and neighboring function context differ (return 0 vs return r), with the same helper removal applied. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-target.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 926a8c990163b..c36c90d1b2166 100644
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

