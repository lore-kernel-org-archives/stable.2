Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379865;
	b=sgapLxEWTZrBTaOaP9tx144T1t7MpCARqXe8vmPT51qkEvOMd9/SzhQcbCIx+PsyHlxe
	 4EnlSs3JT4BLEvKDpOZUt7HMZ75yeOq0FM7UOsa1Kgir9sHzRdyB3ZN+CfnGXiTeGe/ll
	 mk47om14RskVzumTYJ2b1ptR2U5TohF+acL+MgC/q2kuu7EuygLx0OOhPlP+NJwoo/VXL
	 qSZPTFuSoS0rgR9uYhpClZ5LRXQyDAMj02/ZcsbYZ7EqRrbirUyEzMHYQXp8O7giHw8IX
	 RTfFR/lGXS3vTqyoiBDxTsh3hgQZ3nPVWlcYgJYkQo+QsYJCEEHZdqr9TdSSBMJHa0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E4R8h7MFcdwbDDqOfCHR8zbDow4VH7LIlDFzvboffvI=;
	b=lWVJtdA7xedHzCZKS2Z8mug+ULJj9+Bw7xP21igQ1kInXDj3yHNHPtXrrGu949Y5kMkt
	 EJYSOf8M19CgjoCsPRWsXiBza7F+bNbJxqxTutMoUEEvQ8fWP7xNvjXBsAkm7KLwsjxNN
	 TtDf0qDDv8fvRMQOsYQpvyKHpnZk4ZD40nCLIUiCfbRVe5/yGXXcjodJxTbVFkNm4SK07
	 B6eUtaC+9sbcezJarBQej1xZkNPd46R+gVyFWb9W/1760+d/lH6m6KbMnfTBltcmE3SoP
	 Ajz6H4zdYBJcXyDuf+wf8InSY/u/jcyhwir49nUU6hmMxQ3vyX71s3TNQU/el+pxHHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vmFpJkl7;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BABA606A321
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BABA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vmFpJkl7
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6ddef424972so735224eaf.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379864; x=1793984664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E4R8h7MFcdwbDDqOfCHR8zbDow4VH7LIlDFzvboffvI=;
        b=vmFpJkl7EBNCYxDVYDJYKFjF4bIhiWR6Y9qfGSDu2HtVycSWM/UJQ7qwbN3W+6RrMy
         UiiN72XyOoTobOprNNaufTysF8RjSXj2Qp0ywU2Y5YG5YctI8Rb1PpKqQ8bLatBK7Nv9
         yN5CT03COYYOORcEy9hW8ii6N6gVvPp1btreb06r06BqE9bGdSHv+Idh0RVHJB64FHmq
         fYmAKFxjkmxxMpIg9pKDJM7FQKIrGbOnFGgVqgbPeXLexNcL7thz0V8GJkDlkpFv2vQT
         M1dvfVvh7RUlO20ykEWU/ftkF1erTjruOyL6KjaBqYneP8xxK5tzS6BNqAItE5MD+Rw7
         evAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379864; x=1793984664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E4R8h7MFcdwbDDqOfCHR8zbDow4VH7LIlDFzvboffvI=;
        b=yQk/hMi2ZDBlhYkKcFY10irdUhHM3XEC0ZIOxjCFtrm24Ql9k35315TLAgc+fOYtuD
         S6r/U2tHd82U5Mc6cXU/nQbRrCHclOxVe3N+3Q2amWkN03JpaLIXc7/BmWabuzgP3pcC
         0/LLuLHMIikgSEP/pcSUcvXMlYpt4Xk2xk+Jn4NMV8Mkc3R+/BgpZotK+6P1/BnNd903
         U2gz//K2Z+ve1fm+aATMyzcdctyRoDlvv8mIg9PunsWa45yivRQ1cUdN4pV8zwd5b2fu
         jxSm/VBAgT978enbFR4W/clQAHqZRpSanOm8i8eE/PgWAv1so+1PKGsDxfRJi4IKBiCu
         sRCw==
X-Forwarded-Encrypted: i=1; AKwUvByEEJr7ESgE3oRR4OMClFdHWtybi6f9ViKcD1tuusO/dSfChfWbbMM6XmZTY5eR5bhPhc2aLmY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9Gy68xvodKCpWdquiPECyhuBlkuvBQN1qryyutTtKilPzAwZx
	gAgDFkwRcoWlVWBZBcis7Ja7EmpqMZrg0oPZYefvhXzS56JvZVJOOmmCth3OvcnxcJc=
X-Gm-Gg: AYBFou0tWO26nIkofS5dbrtTQZ0dPH3OcMLNEA35b68BJPMeHZeJ03PHaOL08NjO19G
	S23XanhyGFvQoO0VvXXkToojMa2yVPbsol6O0VTXoqw0/gVadTY43qgepPkITmGF7NpEBmy1wNd
	B1WJQzZMiCzOdOI+5ptISw0BdssyHZyPuOVyDFeMTWigW2tmWswwI8Un0T5N+bWHknVwa9CqfJM
	DgcdRy+Ntu1jH3tdkXaW8EZZoF3eqWZ6gdrYlfhKMEXHRCotr1yDkBH8WrLW0LLR4AC7Ao0jThX
	I0oy1L4wkDhNieu+Is7qE3kBg862lpXzi6U4/wgYCUYAz17fWCzkXXKmBCLBlfQQIqw73ewEXNM
	YO9aTrfVmh5MuvDJd2sfNz6mq7Y0a7eZNv7AzqWY2Fh8Xqk8qb3CeryTcnnSJz8R8aW6fgPbAmj
	1YOad5Oz9FdcxzOz5INv+wE3xn8uIeIZXBzcjM4RnopE0BqC/mPdjRxrERbxTtBHPvHvnsWyMJO
	aLz/FA/dAyIfUT3fg6KtA6z4YTVyCxjJO2FU7jQ/L24HRwirQMSgDo9zx5/cDYx6cCYWqm7t9M8
	hOToWMIMd9vbT5uccNchLzE7iVuKyltQRN+K/rI=
X-Received: by 2002:a05:6820:8598:20b0:70b:638d:4b9f with SMTP id 006d021491bc7-714f29eed98mr1265557eaf.47.1793379864124;
        Fri, 30 Oct 2026 10:04:24 -0700 (PDT)
Received: from cachyos-UX582Z ([47.185.113.166])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2a818b9sm2419780eaf.1.2026.10.30.10.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:04:23 -0700 (PDT)
From: Slaton Christie <slatonchristie@gmail.com>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	Slaton Christie <slatonchristie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda: cs35l41: Add DSD properties for ASUS UX582Z (1043:1a8f)
Date: Fri, 30 Oct 2026 12:03:54 -0500
Message-ID: <20261030170354.7427-1-slatonchristie@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS Zenbook Pro Duo 15 UX582Z with PCI SSID 1043:1a8f has two
CS35L41 amplifiers on SPI (CSC3551), but its BIOS provides no _DSD
properties for them, so the amps fail to probe and the internal
speakers are silent:

  cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: Failed property cirrus,dev-index: -22
  cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: error -EINVAL: Platform not supported

The Realtek codec quirk for this SSID already exists
(ALC245_FIXUP_CS35L41_SPI_2), and linux-firmware already ships the
tuned cs35l41-dsp1-spk-prot-10431a8f-* files. Only the property table
entry is missing.

Add an entry using the same configuration as the sibling UX582ZS
(1043:12af): internal boost, CS/reset/speaker-ID GPIOs at indices
0/1/2, 1000nH inductor, 4500mA peak, 24uF capacitor.

Tested on a UX582Z running 7.3.0 (CachyOS) with the change built as a
DKMS module: both amps probe, load the spk-prot firmware, apply the
EFI calibration (R0=10611 / 10708) and the speakers play audio.

  cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
  cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: CS35L41 Bound - SSID: 10431A8F, BST: 0, VSPK: 0, CH: L, FW EN: 1, SPKID: 0
  cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: CS35L41 Bound - SSID: 10431A8F, BST: 0, VSPK: 0, CH: R, FW EN: 1, SPKID: 0

The boost values are copied from the 1043:12af entry, not taken from
ASUS or Cirrus documentation; confirmation of the boost parameters by
Cirrus would be appreciated.

The diagnosis and the patch were prepared with the help of an AI
assistant (Claude, Anthropic), from the dmesg output above and the
existing 1043:12af table entry; testing was done on real hardware by
the submitter.

Cc: stable@vger.kernel.org
---
 sound/hda/codecs/side-codecs/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
index c50c7e6..d5a9e1d 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
@@ -107,6 +107,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431863", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "104318D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "10431A83", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431A8F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431B93", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431C9F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431CAF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
@@ -566,6 +567,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "104318D3", generic_dsd_config },
 	{ "CSC3551", "10431A63", missing_speaker_id_gpio2 },
 	{ "CSC3551", "10431A83", generic_dsd_config },
+	{ "CSC3551", "10431A8F", generic_dsd_config },
 	{ "CSC3551", "10431B93", generic_dsd_config },
 	{ "CSC3551", "10431C9F", generic_dsd_config },
 	{ "CSC3551", "10431CAF", generic_dsd_config },
-- 
2.43.0

