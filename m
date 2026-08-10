Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7439CD09
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345974; cv=none; b=a8reC5YWRaQ4CVqBJd2vx1/lEytibCy33jNXCoxdacgrrq9ec348n3P4Qdy36DyWVPbkvOXp26gc+9R7I0CAl+tnR20cO0FEoe6CpkI9sil/xVJpUmB9RESEWOjlbrdgvGxhb/yseGvFMbFflyunsoa84MlgMvNwDPXPkm4HFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345974; c=relaxed/simple;
	bh=xQQ324yJppjYXSfwfG7HdtFxsh6X7PGSrguVedWo/tg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M8B9gMjaO8EDexiON+DiRBeBjczVvqgta2J3/anLyTh1Iff/cgdzctjdcYnmX45tY5iwq4iehdEnEa8uQ1iwA9D96WhPZ+brGXlnt+XxJGMjFnZSrwotQqJWUDnOLxwaYLhXTYJF7hAZm2Bjrw5KVeqU0DRWpsmJ0xFNuVTHvNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYP9oQqW; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYP9oQqW"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8488ac68185so4450381b3a.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786345972; x=1786950772; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y+mjXAOsh87MLiqe7Al+hJ0jHWJBBARtP7EOkjQ8zvc=;
        b=nYP9oQqWq0xkWvi0DzvgIgX3JIsQ1eWQjBQV7qHtT6iMDaVEZYJRK3hA/5wHFQNcsS
         qBia91wH6/MVFdHocH4v0jX6Ywx6ZfeWLwx35JSUEKP5JypmzUOrnlbLEUa+uJDUYk8G
         dtaw9SKRstcJQOMFHHBElcHopdUDy5bnR5o2h154dAwrsDLzVNeZNzRMfvK/0paPH6Mu
         nYyMPdoiHXLgKfLspgn6NgFnuMtDKX8Em0pU3lJszF0NQ9ozrG1vIBXhi3ooxUDznodB
         Ermlin+dGVK8haee4V/UN00aQ/iA4C3KQxCOfwrIaethG3lqTsNX0l271ElG3vbeEIIg
         udUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786345972; x=1786950772;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+mjXAOsh87MLiqe7Al+hJ0jHWJBBARtP7EOkjQ8zvc=;
        b=bGrK4EfdOWX5156B74yeZO3V/Yw972VAR2SjgaIAvTp6XIHx/qhChKlI4+kPs2AyBx
         m5fXphb7dXEbKkVi2cKmYe+ddKVml3wTTnej5JuXVw+p/Do2L+eafkV4l8evCs0iWGdC
         HqNIKmGcMEG4CfDM/orG8p13ddepHgptRhxQNs+91Wsuk8CjR6GF1wzjwGqwYkKe72CU
         3uNurWNKFPk86pDqutrquftTKsMF+8c8C9O9yart6cDvvy63NHOH2X3y+y7B7M2+XVBK
         9cpFT5ccgdRxou7eQtfWCQWxTKLulqLuMw6u8Deg6+nmYpceZCG3rqF53GJRdyomyUPp
         tuXw==
X-Forwarded-Encrypted: i=1; AHgh+RoBki4U6j3IPdrw50JCsWPsuLOq0PRv8l4u/9XWpQcwsMEc+KsZwhw2jLGYOQ7cg4zPy16PEdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykIrPaSX2f3CZKIbXOrCbyzuzy/6U0ABMvbl9XUMM4RMpEdc07
	v8ZcbE20QKR8TK8Yj6uvNgD+If64YfVw62rk5/xPwPu5Jpuj9diVCAf0FO6puRNvZ18GI9TVCqv
	Qmn0k2bi+rHFurMUhU/FXzuh4GMm4C65yXQ==
X-Received: from pfbeb25.prod.google.com ([2002:a05:6a00:4c99:b0:848:49f6:6f5c])
 (user=sonalipradhan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:848:b0:84c:3900:95d4 with SMTP id d2e1a72fcca58-84f694915ccmr17354002b3a.11.1786345971760;
 Mon, 10 Aug 2026 00:12:51 -0700 (PDT)
Date: Mon, 10 Aug 2026 07:12:37 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810071237.2207680-1-sonalipradhan@google.com>
Subject: [PATCH] usb: gadget: u_audio: Fix use-after-free on sound card disconnect
From: Sonali Pradhan <sonalipradhan@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, Xu Rao <raoxu@uniontech.com>, 
	"=?UTF-8?q?Alvin=20=C5=A0ipraga?=" <alsi@bang-olufsen.dk>, John Keeping <john@keeping.me.uk>, 
	Ruslan Bilovol <ruslan.bilovol@gmail.com>, stable@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sonali Pradhan <sonalipradhan@google.com>
Content-Type: text/plain; charset="UTF-8"

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
---
 drivers/usb/gadget/function/u_audio.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index ca26bf9c8040..f0ee83abcebc 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -1183,6 +1183,20 @@ static struct snd_kcontrol_new u_audio_controls[]  = {
 	},
 };
 
+static void u_audio_card_free(struct snd_card *card)
+{
+	struct snd_uac_chip *uac = card->private_data;
+
+	if (!uac)
+		return;
+
+	kfree(uac->p_prm.reqs);
+	kfree(uac->c_prm.reqs);
+	kfree(uac->p_prm.rbuf);
+	kfree(uac->c_prm.rbuf);
+	kfree(uac);
+}
+
 int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 					const char *card_name)
 {
@@ -1262,6 +1276,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 		goto fail;
 
 	uac->card = card;
+	card->private_data = uac;
+	card->private_free = u_audio_card_free;
 
 	/*
 	 * Create first PCM device
@@ -1430,6 +1446,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 
 snd_fail:
 	snd_card_free(card);
+	return err;
+
 fail:
 	kfree(uac->p_prm.reqs);
 	kfree(uac->c_prm.reqs);
@@ -1455,12 +1473,6 @@ void g_audio_cleanup(struct g_audio *g_audio)
 	card = uac->card;
 	if (card)
 		snd_card_free_when_closed(card);
-
-	kfree(uac->p_prm.reqs);
-	kfree(uac->c_prm.reqs);
-	kfree(uac->p_prm.rbuf);
-	kfree(uac->c_prm.rbuf);
-	kfree(uac);
 }
 EXPORT_SYMBOL_GPL(g_audio_cleanup);
 
-- 
2.55.0.654.g21b8a5bc05-goog

