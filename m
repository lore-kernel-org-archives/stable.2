Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050253;
	b=Ep+2ycUszAOKJ/PBLoPyYOuNPS/ihZQUR6LCx1Z+RFng7++6Fa1nUIS/cRDPbF9L/Cdk
	 J9h9xqm23Jz+sibLLfuU+MAYVTreD4HHWUprKY4qRgaaZueveDcbXC2UWlvbE/9rQIMf6
	 1pykX6oZt2TMt15BDWZz87z2W2COFxt2ToWsbf045t+J5WHb7/j9gNkr8KzFjjskd4eDH
	 8WL6R/Kbl/NNJlIq8Hh8kTolQkEkdsr8zjV4FxgHIhaCq6MmilhyrZY2y2qOD7QgQa7CQ
	 0ChE7/eL3LT4G43KcEQhlql5lS8Ks1XVMLln+e3x4HoSjlQXHdYZiesz6Vw0sf+Bn+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050253;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6PG7kgbg9cU9qWFj/vBdzF9KUiXLX3dB2u4C8HIDGH8=;
	b=Bm7DsTAf9igk3Qn017wv9ve0Y3O76TJz5TdVdYUIovVIY3lgP2BrWe31kh0CHLOuQOIh
	 kw2ScN7+I0TV1J9LVoVG5aJPZ4agxhVE+9E5iwj0zwGZ38AN6di+WytDHm3Bvwcve82EH
	 IY7haWZ8BteFBC9+fkVUKUHELcCpfMbtNRPno+RVTf/GViDwIhCc/yFoCsI8nB5qAMdPY
	 CuIyK7eDncZHqNM/1b7HkLKM/bXrC4hFgoXxIi38J90GNijRNmBDOoWovKgpTITdc/rMV
	 M7Rto2f/KyC1MHgUzBt2WVsvsl3cvNdKb2I9JpbxOGckvpmjAbBwK4m+psMI9mD1lxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eN9OGCYP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3588606D803
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eN9OGCYP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A601F008A7;
	Sat,  7 Nov 2026 11:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050253;
	bh=6PG7kgbg9cU9qWFj/vBdzF9KUiXLX3dB2u4C8HIDGH8=;
	h=From:To:Cc:Subject:Date;
	b=eN9OGCYPG/1p2rSGCozjZF/QPenjc6f7lah+2M9Yu7bD+1ATkpM+xUyrWrddPtDP7
	 wxhfwy3fanjVmmsFgGOpnTO+I0zCjxTlyiX4S3du5GXC/vrG0eSQORAbPZCNZBbYaD
	 4FxxRHwsH7ezrY+Ns4O750u6r9q2I8IAqxEPeok/QEawyRXz61zmkxaEQgHGivQDX/
	 o0sC4jogQcmXqe1YrmQcpKGhVcC+VNxy/7nnYsMo5uTvoY6VRrQjur3s56ioeblhnP
	 hGUFs9F5B2oqfYzAXgpZY5KXKR23x5kRa8NCZ34OC+WCIwQZtUINol45qBeHSP9+Ls
	 xv6eBj1F6bn8Q==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: core: Check shutdown flag at D0 power-state, too" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:31 -0500
Message-ID: <20261107061731-failed-5.10-ad63c5b62843@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ad63c5b62843895e8c3cd7291ed07cc659df0355
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061731-failed-5.10-ad63c5b62843@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ad63c5b62843895e8c3cd7291ed07cc659df0355 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 29 Sep 2026 14:53:41 +0200
Subject: [PATCH] ALSA: core: Check shutdown flag at D0 power-state, too

The snd_power_ref_and_wait() skips the card->shutdown check when the
card is already in D0 state and immediately returns as successful, by
assuming the all-green in D0.  This assumption makes the code after
this sync point behaving as if all power is up and ready, even though
actually it might have been already at the disconnected state.

Add the missing check of shutdown flag there for the more consistent
behavior.

Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260929125346.1478631-2-tiwai@suse.de
---
 sound/core/init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 1bcb6a2e75507..a51b71812fd9b 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -1174,12 +1174,12 @@ EXPORT_SYMBOL(snd_card_file_remove);
 int snd_power_ref_and_wait(struct snd_card *card)
 {
 	snd_power_ref(card);
-	if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0)
-		return 0;
-	wait_event_cmd(card->power_sleep,
-		       card->shutdown ||
-		       snd_power_get_state(card) == SNDRV_CTL_POWER_D0,
-		       snd_power_unref(card), snd_power_ref(card));
+	if (snd_power_get_state(card) != SNDRV_CTL_POWER_D0) {
+		wait_event_cmd(card->power_sleep,
+			       card->shutdown ||
+			       snd_power_get_state(card) == SNDRV_CTL_POWER_D0,
+			       snd_power_unref(card), snd_power_ref(card));
+	}
 	if (card->shutdown) {
 		snd_power_unref(card);
 		return  -ENODEV;
-- 
2.53.0




