Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B244238D
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514858; cv=none; b=XSmIf8m+R1y6Mg5nHT9nyDYPcPi4rYKE+P8aKs2J+196JXod28Bo57TanS2UzRW4jc+nptmmWGaRVi32gHfPdfRGP1MI0r7q3kZn65vFZ2JpPYHbe63UlGmMziWOMJdXvZFRk+SDN4gPZvucgNK2et6e1ZjjgDuiqG4IvwKQLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514858; c=relaxed/simple;
	bh=ho/52/p04ArcEHoYn7XPv3stLX1St2y5PEusO5BX3T0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j1V05eFC5ubd5Ky2fRbMcFzvTvZ4uz04GIPpTXROZ7fXnjXFWs9X94u/NX1uflLBwdO96e/thZPEqpXjDrL7+WKuukUndusySWI0ksDQKR7Gp6TK8QAZWMim6dQzvy09BVbWCJmE0NgeDKJzAINEggLCh2Y5r3KmHxyqVPpL67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJIjVgi/; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJIjVgi/"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa4e4684bso20933605ad.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788514857; x=1789119657; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K4mhV9MSta3oYwggEM8uZ8Zw8CbEKn79tdknc0viU4c=;
        b=vJIjVgi/l6gaqaCv58eS+I4be4HJo5huge7hK2QDB2KbDhbZXTGZb78r6Unro/r04S
         oBhmi84spxvHS5PV49NHbeMDFprb02LB1DDEUdDhoGSF/Hy0enAv3erVKqCmZIxYAvFX
         1FH+zA0KitmQ8PnAeKm30s708LL6NJED20FWI5NGISHmVLoXhwzVBOrtq6CEyqUdYS44
         lxsE6LYkWNCkXxNjPz/UfZrMO6Snrr/Z8EnAvgsn9goNJD8ekWLIZN51a6BR1scfxwgo
         y20unlqOj/Cn+b+pmappONwNFhkHKtCcw7DVAct+BH2/fq2FFD09Z8cOIRM3wmcFcs3G
         7fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514857; x=1789119657;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K4mhV9MSta3oYwggEM8uZ8Zw8CbEKn79tdknc0viU4c=;
        b=AHOcjKWHNVNeRVOcB2wU2i7yR5D+hXihjJyzah0JrV9mKANh9ma7AGMtlBBnQMHHy3
         EnE44Lcjx3k4+mAdjJKcR8Pu7AEwEZ+ZFBnBFGTLT7m/Pe/N4mYYbqX1SuMsmlvqV5f1
         Bed2oovW57bBBfSEItz3tN25IpG/VURTR2GloC3oLru0MMBXkg+l4QVIaXaXLpzGfq+n
         xr4DRtN05+4ItpRuVVnzZR3J3Jz+qOXCcWeG78a/OalN5JeJtZD9+YPbRjcPN4OrBzaw
         MJA3itsbXJAMJkzr8aHWhfev3ccqgLZttIq/YbMZKj510vcn+oNYkLdr9hEjM1tGMDkS
         f/Hw==
X-Gm-Message-State: AFuF++kfKokw/+T7cGr/ubE//HSd3RaEfhghZUZuVK96I7ki8UwyQBgy
	+95M2IRaISlS4rS9TQIczRcjvRd1syKrVrNekjNgv0vzGVHLjYFtUznkRYNJM8RYN7LSFhazYFh
	JAD0hrrbS0AT/my6pPbpPdtIEKcfEPlPUJNQCPOjp6O6PVWQXqRMuvLLzrp7ACPMmkeBNG7+Hb+
	BC9nx8614HhCWNo+Me4rIowvnAErOCCN++Mr6gEIg8PJe2zqiXRCcZzXicGHDauYhvakGJzKBWL
	A==
X-Received: from plqu15.prod.google.com ([2002:a17:902:a60f:b0:2ca:ddb3:59fc])
 (user=sonalipradhan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:7788:b0:2d7:4cd4:5a7f with SMTP id d9443c01a7336-2db127c0b20mr54278235ad.12.1788514856346;
 Fri, 04 Sep 2026 02:40:56 -0700 (PDT)
Date: Fri,  4 Sep 2026 09:40:52 +0000
In-Reply-To: <2026090324-poker-gradient-aafb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026090324-poker-gradient-aafb@gregkh>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904094052.592539-1-sonalipradhan@google.com>
Subject: [PATCH 5.10.y] usb: gadget: u_audio: Fix use-after-free on sound card disconnect
From: Sonali Pradhan <sonalipradhan@google.com>
To: stable@vger.kernel.org
Cc: Sonali Pradhan <sonalipradhan@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

commit 858965947081d10d41d9a1010a540d3d5eea958b upstream.

g_audio_cleanup() invokes snd_card_free_when_closed() to initiate sound
card teardown and immediately frees the underlying struct snd_uac_chip
context. However, snd_card_free_when_closed() returns asynchronously
while ALSA control elements (kctls) remain open in userspace.

When userspace control applications access or close these open file
descriptors, kctl callbacks attempt to dereference kctl->private_data
pointing to &uac->c_prm or &uac->p_prm within the freed uac structure,
resulting in a use-after-free (UAF) memory corruption.

Fix this issue by deferring the destruction of struct snd_uac_chip until
all references to the ALSA sound card are released. Register a custom
card->private_free callback (u_audio_card_free) during g_audio_setup()
that frees uac and its associated playback/capture request and ring
buffers only when the sound card reference count drops to zero.

Fixes: 6c67ed9ad9b8 ("usb: gadget: u_audio: don't let userspace block driver unbind")
Cc: stable@vger.kernel.org
Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>
Link: https://patch.msgid.link/20260810071237.2207680-1-sonalipradhan@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[sonalipradhan: resolved ureq field naming and placement conflicts for 5.10-stable]
Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>
---
 drivers/usb/gadget/function/u_audio.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index a387ff2c8b73..2d190d6f628c 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -486,6 +486,20 @@ void u_audio_stop_playback(struct g_audio *audio_dev)
 }
 EXPORT_SYMBOL_GPL(u_audio_stop_playback);
 
+static void u_audio_card_free(struct snd_card *card)
+{
+	struct snd_uac_chip *uac = card->private_data;
+
+	if (!uac)
+		return;
+
+	kfree(uac->p_prm.ureq);
+	kfree(uac->c_prm.ureq);
+	kfree(uac->p_prm.rbuf);
+	kfree(uac->c_prm.rbuf);
+	kfree(uac);
+}
+
 int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 					const char *card_name)
 {
@@ -560,6 +574,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 		goto fail;
 
 	uac->card = card;
+	card->private_data = uac;
+	card->private_free = u_audio_card_free;
 
 	/*
 	 * Create first PCM device
@@ -591,6 +607,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 
 snd_fail:
 	snd_card_free(card);
+	return err;
+
 fail:
 	kfree(uac->p_prm.ureq);
 	kfree(uac->c_prm.ureq);
@@ -616,12 +634,6 @@ void g_audio_cleanup(struct g_audio *g_audio)
 	card = uac->card;
 	if (card)
 		snd_card_free_when_closed(card);
-
-	kfree(uac->p_prm.ureq);
-	kfree(uac->c_prm.ureq);
-	kfree(uac->p_prm.rbuf);
-	kfree(uac->c_prm.rbuf);
-	kfree(uac);
 }
 EXPORT_SYMBOL_GPL(g_audio_cleanup);
 
-- 
2.55.0.979.g7e5102b832-goog

