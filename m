Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347D3A7D82
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505462; cv=none; b=dF+TBpSzeDDphk8HqQEBU8d1HSwLY0fV9GSVehc9jzam1ddxmEPOvbUmbF7UqXZ4HPO4lWRP8SnXCDarmmoFObWaalj+B8SZiQkoawrmpeQEfVCDuMAMNmxZwy0Cja4YpWR2ATKU1CpK40XEc/IcYGQWUanqXBowJEbi2cvqVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505462; c=relaxed/simple;
	bh=3tUZi3lxjcz/XregwVnnMT850Yc0VvCh330sIoemU6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MApK+ZZtce1eTPXWsBti2KQ5zun13fX9T9fU7sDHRFFf58n4tkaC6LWveMRht+trBDxM0EpI1NOsQ3mwG6/OXDZqCiOVNfgDuS19QlApjZl34Fr2HGn3P3BqxkxBk8I8naB7PvDJQwzJTKEPh19Txn4aOD9uexzra96r1AoLi44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by47bbpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by47bbpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728A81F00A3D;
	Fri,  4 Sep 2026 07:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788505460;
	bh=YawR6a3Oqrj+SrZGCK7xg+xT5B3C2EL27I20IxBfIhU=;
	h=From:To:Cc:Subject:Date;
	b=by47bbprErNXW9cHG8FaePD4+b3qDeK3qDk/sK4ZNundiQNRqXGbMuPaGfRYTR9/E
	 JoMdavWDWJjedPuq3Oo3kjg8Xjou3XHJlUS5p830Bsed3FpzpupSbjpOEPMKUILfoj
	 u55sWxDTkxpAHOCg69EAbrlwRNK5JmOZp48ATYDgcWaBpDGsAuu8zUeqxekUYVOaRM
	 vpUjAUk4fWDg8hKOEyGS955OUtCi1+P6BfXHYTGWoB8pFsSgjPFuALj05O45lalddu
	 S0QCM+SKDsMr/bptGN9hVBEfUgxzwK76/crBd/1Q/0FX8I0OyU7m8BMgmutSfWgovU
	 7mpVcWgSDUyMw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] ALSA: seq: Fix port lock leak in deliver_to_subscribers()
Date: Fri,  4 Sep 2026 07:04:09 +0000
Message-ID: <20260904070409.80648-1-tzungbi@kernel.org>
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

Fixes: 6389f2c13531 ("ALSA: seq: Add UMP support")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 sound/core/seq/seq_clientmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index f2feeb97765c..bd2d7a9fab5b 100644
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

