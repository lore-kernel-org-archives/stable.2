Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C74A95E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245413; cv=none; b=aPQJI1mOQ1UgKgPcawm3WA9yuAJ9F/XeNe2j4Ky47UGM4PGBJIODc2TGN5XPyQ2o+S8A1Y3iFeL/awvbdT5PzOLYXVBPIBD8bNO1GVysudMBtZHpfPwNAikR+FSyIS1uKksc1IjM5fvrfvWZXvaNbu+o1QGrDUwcQT7/haWVVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245413; c=relaxed/simple;
	bh=2AgYhqe02CCett7Tw3jVo1HXrQowt/OZNmew+xn8Tbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX9yDUmabQDFCNOzG24QS5FXXoztVOUJPE2b63FJBQTySDriCgweP33MuH/Eyfiqp25tNukNd6njytg2VNKdQUihZC/15qRSmBs8+DIIfpa3Bftyt2NeWD/fXfutYbW4qRc00zQaIcs5d3r1gcoLcjjijfipot1GHGpnqbivn9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Peo+p/p7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Peo+p/p7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D791F000FF;
	Tue,  6 Oct 2026 00:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245412;
	bh=ftKiTK+/zM/tg9LTMdhFJFpXR4LJVWeyvpIDHvokMMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Peo+p/p7tHii4IhKKx7X530GCxV5d0Bafj9b+wl/vapqIrCk/E0y2GwSkx3I9+IqA
	 XlaRa59YsHLLSdyS1aSRkd2t/MqbqEFfhiEjSpGmZKdGTcZZ68YMYmimub/JTyFHZM
	 yxemnbRy5O2iq0kEej35PnJ19//9JDkNhOdXVU5/50wLWmSU3/gjN9nHc6A1GMxdlB
	 YyE2Arwa9XhLhPb2QcZdQQsc9t8CiHXr9s1Swa47psfR5agtR5YBihfS04XgWtVHii
	 ek0ggYHweYol6OG5K4/wuhUAwzAYQP6aLuGGw9xuwaLPh1RyCTFuIgusEsy891vTT7
	 VDrbgpl61lnyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Bruno Produit <bruno.produit@trailofbits.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: seq: Serialize compat port-info ioctls
Date: Mon,  5 Oct 2026 20:10:09 -0400
Message-ID: <20261006000849.3530845-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100526-essential-squishy-ce6c@gregkh>
References: <2026100526-essential-squishy-ce6c@gregkh>
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
[ sashal: Replaced scoped_guard() with explicit mutex_lock() and mutex_unlock() calls for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_compat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/seq/seq_compat.c b/sound/core/seq/seq_compat.c
index c0ce6236dc7f1..65c385f3ef894 100644
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

