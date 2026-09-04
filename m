Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96AE377A8B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505447; cv=none; b=o9NeR3m/qGmf7hoJsyFaX/SJpE3ztnMfmRhTQbFCSUm5hiyjSRlew2TeH9gkQTEesTcQdpdBlU8yDpOQ/kw7jiMKQm8Mf2NLF07rqgf5NC2dtvsEoFBj98VpCQDYjcdnm5T5IXbXqcNDtDI7tnMRtZeZd3LZfVReNft8vrhaMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505447; c=relaxed/simple;
	bh=m8Vq14wjGEle04nPXsdB4QEY1+8wvsxldq81mjFlg2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PE4ExvhjUHPeKNu2qnwm86NVEWcmQCluw6APepkrQD2ppaa0dI174ek6HKVwTUD/8NBtIHvtqpZtRJRA0yCveqc+Q+kEr4yZQ5O2dWayE6n9ybpeEaCmjWMlkcPOmXafWoHEtVeJwfJG1u8c57X71xxtz4z4pkFR0xDPPunJQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSVw5txk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSVw5txk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818231F00A3D;
	Fri,  4 Sep 2026 07:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788505445;
	bh=iBXF5v1VOSzvxor8PqmVy7xN/iYE8cXe4jVbYbzgvRg=;
	h=From:To:Cc:Subject:Date;
	b=hSVw5txkdUb6t10+1fBJEidf3szXKlD/yKG7dT2Yi8chQzFdZW6c8w0EzXCuZprUh
	 ugfcnZKsfYu9IxxEP3iS4QfJ0+Mg8sHvBn0DLgcxTSOd2ciViKG02KPyizGCaSaCa4
	 5zoBZkBu18MROvb2MxlPPtHbXJOtyV71euyieULA4wsihrx3F+XR7vSlQGkfm/VzgF
	 rDdkAMJDzKXJ+V7ifL9s+NyBvFtuVX2V0YnJRB71dIGxlI+O5znRBqBe4U/8uNKnPf
	 tJbZFWoKTfjXu+uuBILtxJfTLGQnaVGNz0MH0siz9SHUZz/VlWwe8KHmxbflNP0H4o
	 O9/3AL/gXSBEw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] ALSA: seq: Fix port lock leak in deliver_to_subscribers()
Date: Fri,  4 Sep 2026 07:03:49 +0000
Message-ID: <20260904070349.80497-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 46397622a3fa ("ALSA: seq: Add UMP support") mistakenly removed
the `snd_seq_port_unlock(src_port)` call in deliver_to_subscribers().
As a result, every time an event is delivered to a subscriber, the
source port's `use_lock` atomic counter is increased but never
decreased.

The leak prevents ALSA sequencer ports from closing cleanly.  When the
client process exits or destroys the port, port_delete() hangs forever
at snd_use_lock_sync().  The process becomes stuck in an unkillable D
state, triggering the following warning:

    ALSA: seq_lock: waiting [1 left] in sound/core/seq/seq_ports.c:250

Restore the missing `snd_seq_port_unlock(src_port)`.

Note that commit 177ccf811df4 ("ALSA: seq: Support MIDI 2.0 UMP Endpoint
port") incidentally resolved this issue upstream when it refactored the
locking logic into a wrapper function.  However, since the commit
introduces a new feature and might not be suitable for stable release
branches, this targeted fix is necessary.

Fixes: d7e2ce72833b ("ALSA: seq: Add UMP support")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 sound/core/seq/seq_clientmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 9b82fccd959c..37930d74e394 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -733,6 +733,7 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
 		read_unlock(&grp->list_lock);
 	else
 		up_read(&grp->list_mutex);
+	snd_seq_port_unlock(src_port);
 	memcpy(event, &event_saved, saved_size);
 	return (result < 0) ? result : num_ev;
 }
-- 
2.55.0.979.g7e5102b832-goog

