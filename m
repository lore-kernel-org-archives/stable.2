Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509B4562AF
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196712; cv=none; b=ngzLCUocv74sJd6BEGuEwwVUyCTJp2rcEtxVTS/8UrlB8xA+PC4amROEY8p6odyc+d349Je1M//XdNyFzfwPgbbKaRJdq0+cSqlVHqe9wpkdUOfmsxtwhGYj0v0Zc9d9As3yTw9Rn9k/k8D1Hid6BOJmRxrJ7rHjyani+QqF0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196712; c=relaxed/simple;
	bh=hhbKDREd2IFwi05b6wWen667xv19XHhAv8lRaz/jWUQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RGTDm6jYgTyRNQnp9GyRxRaTsQNN/xyb6O68P6tUw/TwszJL4sEgxwmh95S2KY3VjYIQz2rB8noS9BAcn8c3Go3IPm4l96mzYKpTidlgaP+dH5JIp1v00z0fG7HBtSqfS5mf4E0ksCHeBSkldn5bK5bYJd6YFAVGjfV3o/33bv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kfJx1OE+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kfJx1OE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927AA1F000FF;
	Mon,  5 Oct 2026 10:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791196711;
	bh=iFV5AqwWnAGZTsaSj9chD9XgMZ8uMxLkJHbntKOm9t4=;
	h=Subject:To:Cc:From:Date;
	b=kfJx1OE+XbtIEH8YnABhkyRPy26unzXLRgRInmwskzzvpFiAUj76kUiJFBOMdgr11
	 AkTL2cYjykmCV9Xjsx4xYqMq/gtJ02l4yVo+ls3nRi7a9HThesigYXqjH1Xn0QRJP2
	 0zX8JLMjJv8QVcpEVhOsw5lPhwpwTiUPOntOOA+0=
Subject: FAILED: patch "[PATCH] ALSA: seq: Serialize compat port-info ioctls" failed to apply to 5.15-stable tree
To: kylebot@openai.com,bruno.produit@trailofbits.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:38:27 +0200
Message-ID: <2026100526-essential-squishy-ce6c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 95b2e0361c88753afa030c10698be0a1a5b67650
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100526-essential-squishy-ce6c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

