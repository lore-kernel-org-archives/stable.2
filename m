Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA73445AC4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196723; cv=none; b=bajjkoXiPzYoJUIOTIPZzYydUjSI5Vizvndr5PBr5TyEmddAdQZbo7Jzg/OkRZmSUj0wqp6QfL4DZB88yleSIEOyyyrQ8b8b3ZNLAF5DRto9r8+5brNlVjqWzftC4MGkGkL9ShZGK1RL20aOhiwgHsx7MYLUWnAH/PcJeqjDcow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196723; c=relaxed/simple;
	bh=UBkDA3s+QGLz4peqSWeFMKgTbB6hbDJ5TkZD9IEE/G4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H+jv4ApDKvIhrJVWloZuZs/EFpwF88/XNNJPqBKNejTYmBVQKK38FUvYg/lkeCNtFKnlofkKFmxec0nN7ACZg/Q42SyL8vjW/Nb4vmAotS8Ki3Rwqx0RA8sZ1Ydma4pv1a6E2AoyzBh/D7nG4ED41ZpPJp1/85gHSA7xvO5TczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBmMakio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBmMakio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DD41F000FF;
	Mon,  5 Oct 2026 10:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791196721;
	bh=kEipzxgIEzVoFZ/8qdHfhjPLnpZSTG+IM/2OCvUYRoM=;
	h=Subject:To:Cc:From:Date;
	b=mBmMakionGejrDTEU/AdMVCXlxeLQAzxwS8wziA3BRSyBvBFC6HAcNuT88ml2w94p
	 qdOP81sEyynFw7QpqeP1lZHTANupXrQP9cwyku3u5Zh7WT/pG4zF6lBcW1N2BIXIGM
	 bDaZlC1WuVFRuXwJgvOrQVnizayGK9FjU2IHfSOo=
Subject: FAILED: patch "[PATCH] ALSA: seq: Serialize compat port-info ioctls" failed to apply to 5.10-stable tree
To: kylebot@openai.com,bruno.produit@trailofbits.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:38:29 +0200
Message-ID: <2026100529-huskiness-jaywalker-12ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 95b2e0361c88753afa030c10698be0a1a5b67650
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100529-huskiness-jaywalker-12ee@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 95b2e0361c88753afa030c10698be0a1a5b67650 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Thu, 17 Sep 2026 12:56:43 +0200
Subject: [PATCH] ALSA: seq: Serialize compat port-info ioctls

The native sequencer ioctl path serializes handler calls with
client->ioctl_mutex, but the translated port-info compat path invokes the
same handlers through snd_seq_kernel_client_ctl() without taking that
mutex.

This lets concurrent compat CREATE_PORT requests pass the port-count
check before any request reaches the serialized insertion. The computed
integer port index can then exceed the address field range and wrap to an
existing index. Subsequent subscriber teardown can resolve the duplicate
address to the wrong port and access a freed subscriber.

Take ioctl_mutex while dispatching converted port-info requests, matching
the native ioctl path. All translated port-info commands share this
helper, so their accesses to the client port state are serialized as
well.

Fixes: b3defb791b26 ("ALSA: seq: Make ioctls race-free")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
Link: https://patch.msgid.link/20260917105643.90102-1-bruno.produit@trailofbits.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/core/seq/seq_compat.c b/sound/core/seq/seq_compat.c
index 22679dca9aae..80110501da6f 100644
--- a/sound/core/seq/seq_compat.c
+++ b/sound/core/seq/seq_compat.c
@@ -44,7 +44,9 @@ static int snd_seq_call_port_info_ioctl(struct snd_seq_client *client, unsigned
 		return -EFAULT;
 	data->kernel = NULL;
 
-	err = snd_seq_kernel_client_ctl(client->number, cmd, data);
+	scoped_guard(mutex, &client->ioctl_mutex) {
+		err = snd_seq_kernel_client_ctl(client->number, cmd, data);
+	}
 	if (err < 0)
 		return err;
 

