Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606381;
	b=PQAIZ0GtluGf0FXadpJCtvlZiSmFjtdpRZk3R1S2uRCanwg05kZoJht1+rJ8Y335S4nS
	 QdUtOOxrzwVu2RaMJNvvQiVv8UbhrXUJsQ/OBlad124o7h1z33d6dokdLriBGA5/khjDe
	 hx5eqbAtqjQEPV27wP5a1n2berTlO+0H6Cp14SuRVkoBAtVg0Lfjg+lCK4Sm7Qgf6GONY
	 S5lVedKWYRbGxxFC36saJH/SliZkktgwgooDEjXvd46LgK+VR01x+MsEWmy9uOaXGj6pX
	 gaeR3KLs13BA5idVDKRbqHJj5aZ3OeOpBxB0dxhnTtJ7Ro+8gXpopjMpra809ywYC5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606381;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CZgXHrPj6OZYvPbj0c6Slhei18SE9FywvXtnn7fl6bQ=;
	b=1W6vHzgpi9p8Np6xYJ0LyDcfFMejVra1z9Fy9qBniI2VNMaHuktjqB4SUTUJLFCmVLfb
	 3rWZulJz9uVhN4It19KI43bZTzwvY2XhUGnbXWIjcpJj5YOin+4MZivW/jEioIWhar2xO
	 mMAIafTIIRUv/xJ1fRXjlVXVSUwodWI8ZDhuS0kPlEx0J0/FlSCf/jPkHwRTm5aT56fha
	 mNvQdnGJOLOs6cthMcM/LnpTy6ZxdBO76vdhMZBbIPurOH66GQ9vBQwmUeemexDXKHEa5
	 ZKA1yUPEB74y0MJFpltUEi35knAm2uV5XO1Yk4AVz7E1R/O6sJ9AgpjuQhZT9m7Y7dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BLaCBG7d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB9606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BLaCBG7d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BD01F000C0;
	Wed, 25 Nov 2026 11:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606380;
	bh=CZgXHrPj6OZYvPbj0c6Slhei18SE9FywvXtnn7fl6bQ=;
	h=Subject:To:Cc:From:Date;
	b=BLaCBG7dCEzP6bhIiJJnjG2xbw12/1tLTa19XCHq5cmI/GfDOL9V5Y9tmSvWq6dKr
	 vyFM79RvRJQAkSDPUCjLow7TTvJJ1OLyH01k/bPoy5NRBnuny9AccgxsZVIi9XBGGn
	 rR9vGAU9imRtpPBXIqhZdCPFrhnXKxz+6ySK2T/k=
Subject: FAILED: patch "[PATCH] dm-verity: don't restart or panic on errors during system" failed to apply to 6.6-stable tree
To: weijiang.zhou@unisoc.com,hongyu.jin@unisoc.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:20:15 +0100
Message-ID: <2026112515-electable-treachery-1fe5@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 47930d1236d2988cdc580c10d3af21b6b02d7ece
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112515-electable-treachery-1fe5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47930d1236d2988cdc580c10d3af21b6b02d7ece Mon Sep 17 00:00:00 2001
From: Weijiang Zhou <weijiang.zhou@unisoc.com>
Date: Wed, 11 Nov 2026 20:24:42 +0100
Subject: [PATCH] dm-verity: don't restart or panic on errors during system
 shutdown

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

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 6d589867623c..451c75e30a8f 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -170,6 +170,15 @@ static void verity_hash_at_level(struct dm_verity *v, sector_t block, int level,
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
@@ -219,6 +228,15 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
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
 
@@ -593,15 +611,6 @@ static int verity_verify_io(struct dm_verity_io *io)
 	return r;
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
 static void restart_io_error(struct work_struct *w)
 {
 	kernel_restart("dm-verity device has I/O error");

