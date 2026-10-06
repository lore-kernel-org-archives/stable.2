Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57539272E56
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246631; cv=none; b=MkNCL+RRDpsotNss1cK2SC9EbKSE7nh2qbmNO2SXAlV1llD5CnH1ftKfYcTCzOxRtqWR8AG6BYRYdIf6KYTXIZpV5svbz6ZT5YlSt82qu55kI58aOVt/QdHDFRTyH6XSsH+NdFbyqAhV7CqgRPWY5eChCkh59V8HtW2MwTnDO0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246631; c=relaxed/simple;
	bh=QK2ceTo7gPbfzPCz49z78yz9H3/H3NlFffzf0U3gENM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYF3Fn2gMJvCsgfnSXQBsnCQmpEfHaYWUWvJsdiIhM6ntHbneNyQnZI0vusKwMphCJmwfSxHZxi9SeGzt2boJlL41Y+SIa3FMtQhIH/dnrct9BmTxM1U6pWdqrAjkSMfZCwxhvXNh0KBz4fuPxIiMfduBZ+fuqIhPTaMrKj9B10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3nynA6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3nynA6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82D41F000FF;
	Tue,  6 Oct 2026 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246630;
	bh=O/Sir9FKx9g72iQI2GqUTwfari6XBb9fAcKdo6SI+hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3nynA6Q3Al6p3aKYp4i0+mLjNX3njrkoez55ccBNrlX1iy5ur+Ot2MaK1+OnWr+e
	 oz80aqiMOmYX90kD/jfDjyIhrhYojM/0v9bMjS9V0fFWhmNmcSSzlzL5bzUpf2Xojf
	 WqgkVd/E0OL5eZdlfEIhqVVvItZtnfq77aR0JpvNk4h+7BlU5lAZSQWp178qNb0p+q
	 PUg+cZ3Z1pyfyAip1BDZJ8vcbRHUz22+wp8Jun4l+iK03Vydt7vtdkiBqO+DAOkZuh
	 to3ATmp/OLRu6cPCJxPoTcVzN3ZKlCwhBLUXjBYDbua8qYq82kBxSsp/k/E9WB6zGy
	 XwoOdk6od8P0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Bruno Produit <bruno.produit@trailofbits.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: seq: Serialize compat port-info ioctls
Date: Mon,  5 Oct 2026 20:30:26 -0400
Message-ID: <20261006002931.3619672-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100529-huskiness-jaywalker-12ee@gregkh>
References: <2026100529-huskiness-jaywalker-12ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit 95b2e0361c88753afa030c10698be0a1a5b67650 ]

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
[ sashal: Replaced scoped_guard() with explicit mutex_lock() and mutex_unlock() for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_compat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/seq/seq_compat.c b/sound/core/seq/seq_compat.c
index 54723566ce242..35f67ba5e16ee 100644
--- a/sound/core/seq/seq_compat.c
+++ b/sound/core/seq/seq_compat.c
@@ -44,7 +44,9 @@ static int snd_seq_call_port_info_ioctl(struct snd_seq_client *client, unsigned
 		goto error;
 	data->kernel = NULL;
 
+	mutex_lock(&client->ioctl_mutex);
 	err = snd_seq_kernel_client_ctl(client->number, cmd, data);
+	mutex_unlock(&client->ioctl_mutex);
 	if (err < 0)
 		goto error;
 
-- 
2.53.0

