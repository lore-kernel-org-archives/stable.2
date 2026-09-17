Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B584AE8D5
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642652; cv=none; b=OrVVoPvHf4BhHVFws1nSC0VBomylfBzysYwm8gW9UjjTM6v/aJxZ+veBeN8mWSp+NW4SvnQjXyRwqi9vWMTdcIVFl9e9wixb4eASZObjmS0Op1py48n9WAGqfbqjoDrKCHQFM88mUVk6+5DFDIA0rgWMmZyH9wO6HMKxsKVbFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642652; c=relaxed/simple;
	bh=q8YXsS2Mnty1xFmiXZ0wd8c6UDOy/RD/D6nsd15HyW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0kXPCdHnNLrdqce+hBSq05bct926kZKKL1b4Xq+tnlqXihJgy8NcGkfkkQlalkUyC7LYS4d3tJ9hdNovQ/57afg6wKo79TmDI1+TJ5PNAIPyZigD+iqsz+G6vhvqhY6Y2dmbXKBA/qcArTJuduXSoajy0tpgoe9TnGTJVMXhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=fjvMlNYu; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="fjvMlNYu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso8759215e9.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1789642634; x=1790247434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vBiI+NCmLUKT+8KZgMAIP50JLY8JB1G0uYn55nZbHhQ=;
        b=fjvMlNYu5m7ufVikOMpk21ncFdBgIlRcLQe5SLxtY8URK2O7HmWcOCmbMjT5BL+VbH
         +o0XursZ7FrqKs6qMrJ53nXBeMT8rllB256GUaIj5ZldBZWptG7bApip4c0IbxT+/BIm
         BQra8yFP+ohwUPDCAZLyYrSRcteaqcUDnHOGLtk4epFgSdtPsRC9cQCtS+UZSf8kRE7S
         zUW/Cc2BeSBWG4kU0h55l7U8XnhuIeLW9EarR4y5betJDpH20ukxaXv5x7DDgCbayeIe
         2RGkyNAO1yokUFZihc+VrTmuq6z4FCNCLKP/1AnEQBXvNpBEqg0JPtX5rojkh3sl4Xld
         1s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642634; x=1790247434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vBiI+NCmLUKT+8KZgMAIP50JLY8JB1G0uYn55nZbHhQ=;
        b=qwjwQS9/9O3twfoBSR+Z1KFuCkN58+3BC4lsCERY/IL+h99lpopjELPiPT4ZA7ZXXF
         Ijhewhg+25uw9dhxr94sMlMouW+IOOqXhs/wGUjbm/Y5vfwWCyFI3ifNoY4qa9NIgutU
         uB6XbdfMq1c4uQMcdo507mgfBd81CPwpnEQkcgzbGxBVoQNZldALGDlp8TXfs7/Mf6cl
         d3hVVUdwghoUWQFAWBpTkVi8F04WCkM7s2et+7JQH3O2855KOpP/nrTA1LArrkS7LxI0
         02X7yP5vNocT/TyMIbeRttmCIzGompm4XZXKYdyY2xUW/3vKEiTwUVuyP7G2xxt/mUU9
         AV8A==
X-Forwarded-Encrypted: i=1; AKwUvByWCBPiy7Y2CyGtxFrdjM1lwuX9F8NuOKX/xoB0OYm9aYQlC06U0Xy7JSER4Eco6dW4lV+QYWE=@vger.kernel.org
X-Gm-Message-State: AFuF++nxnxTykSFen9rca1O8zIVgDGRBacnAqsuywmlatUMgRfMiiYC4
	KJ+Ec7JSuNfivp0ZM4Tf7fpQ/Fa5tSKRxFBg45skpxmqxMIabPtAtrYXDuPhXebede8NmwOkX0F
	lVmFnut0=
X-Gm-Gg: AYBFou1QmcwFWzoEloLQRsMNZzkZ66tPF4QV+coIMgWBh1wwOi62sZJPkr87vXOo9gx
	x0qilZLkzPfqYhLEJyPmlEG0YNlWAopZ6pbC5skjaRn2lyJPUpJEZpOFBpsKIt5b9qGwz/kpNQJ
	I3bI1tnyk8QVx7OQaqA/9IBV+oE/Y1DUXQF3wiOBT7XWDHDl4b2uR/4QbtaWEgS6pcOOZxvTZi/
	+/p3kU4UqzEN0SWtYGaVbOH/klWAzlYg5NDwTshWYB92dGOeGjOgIAAxiVzUExeojrWLlZjCyCP
	3ITgFf0yIEEAvwixkK+L8gKUAP5w051k15Swl7dzTSz6eebwBmpJ/tQEkUN9W8IHt1FQxUtuJLb
	/DYE+giGoCR6dvixzVM/X9pEEZfXlpkQLsPp5jOR6fPdKGeZ4Cbh0iXrwEMoJlTQZIoUl1owJ0w
	Zz1peF0FzlvLkikptFdzhMjz3eRT9y4+MBDzVkj3uVXroftEC2Xv1ZtcUiXS+hdVr8fgoijbPMw
	Yv1hQFd
X-Received: by 2002:a05:600c:8586:b0:49f:bd3c:bc28 with SMTP id 5b1f17b1804b1-49fbd3cbd97mr26974735e9.35.1789642634000;
        Thu, 17 Sep 2026 03:57:14 -0700 (PDT)
Received: from localhost ([85.195.240.20])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4870bf1fe7esm14884635f8f.6.2026.09.17.03.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 03:57:12 -0700 (PDT)
From: Bruno Produit <bruno.produit@trailofbits.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Kyle Zeng <kylebot@openai.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	stable@vger.kernel.org,
	Bruno Produit <bruno.produit@trailofbits.com>
Subject: [PATCH] ALSA: seq: Serialize compat port-info ioctls
Date: Thu, 17 Sep 2026 12:56:43 +0200
Message-ID: <20260917105643.90102-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

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
---

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can it share if needed

 sound/core/seq/seq_compat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_compat.c b/sound/core/seq/seq_compat.c
index 22679dca9..80110501d 100644
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
 
