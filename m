Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370375;
	b=tdmdxAA/XDUjGdAF70cqi2WGZzuiszHPbTcWun0NOPaUX/evOBpdBO7oP7mPQeGTS/hU
	 W4XqYGUezsEfzTRlpGHYXe5cl+swBjUbPTCbv5JAj72j1krPd5GTAOYw2FGNsV82+Mn4g
	 /mxUEYAfplVF+T0qEn7ETv8QAuI/9DaK2YwPoX4LdOmwgy/qbHFJ2PE2on7A2VB1Lyv5g
	 5kt+joQb6LTMR87GCTAfTI4tJUkZWOR4Uj75QrTK4R/y7SBKgJRNunDxDuCoRM+/F7x3j
	 teJf4DTyZ+xK9CH49ZZjPIoDAVhOO9oe/JqMuT2noW0bdw6ON15XlYBCdsZXQ0PvLEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370375;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uLniq8O6XYqPzH27/PvcOhr+BiNaq9rB0JGdyWgSbGw=;
	b=2XShb5vtzYp0AIic6DjwUy4MNQsrJf0D5Jk95y7UHjLcs1YxvErkvMiJzPhG+drzq7n8
	 PzyzlEFYu+ZgEXBkbFytdGoOU7B4NvwY8TgZnRfwkFCqOfdT+jHruypa/xGMgNx5kXkhG
	 qgHS0RCwVivnQrkt5Z/WvQIF73ridh87NXacoiRBDTsWT6WGPFxdg0sPN8JnxJu+pWMRE
	 JNx+GaGUnZX9A/KlGL+iGQGWuSU6/rP7kE/vlRaaOI4s7GSKaIFvBMaaEX8I63AAZSwsz
	 bPCheJGn7T5xGzo71ih0Ild218wiLUibxQu4vcKJB/1gMJR7FvJr8LO5J7xYnVNESCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=oMStJb9y;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B399606A335;
	Fri, 30 Oct 2026 14:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B399606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=oMStJb9y
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id CB79E26FD9;
	Fri, 30 Oct 2026 19:26:04 +0500 (+05)
Received: from fedora (5cfcac1b.dynamic.mv.ru [92.252.172.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id 5B5F0266AE;
	Fri, 30 Oct 2026 19:25:46 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 5B5F0266AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1793370363; bh=uLniq8O6XYqPzH27/PvcOhr+BiNaq9rB0JGdyWgSbGw=;
	h=From:To:Cc:Subject:Date;
	b=oMStJb9yitBjLBnw1pBJ+8PwsWcPvPTyqP1XSnclIraGxfxH/cLJIWg45cc9FMfEr
	 tcNkxl3NB0jlwSLaEItIsZkuhisddK6y/fhZJ47Wkja9e/+UQfyn8toNseclhdWSFO
	 LrzXBfnp3oJQsSgvIJzvohCcyhMO3sqGj1Y7HnFhHX19/DT6gD03n6C37dQS3djW0P
	 JH4d629BnKDjpJM8cqRW7Ws+WXuBf4RqJQsegP4eCuya18aDviDzyKqnZ0mNwf14xK
	 9jSzpPXBiEyEgx3METKrD8K1JpKusHWF/2asVwgWV86vtkxCb7PE8dxkMyjbHCH2/z
	 jzfj1JZ0ljnoQ==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Takashi Iwai <tiwai@suse.com>,
	Denis Arefev <arefev@swemel.ru>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: cs46xx: Handle SCB creation failures before dereferencing
Date: Fri, 30 Oct 2026 18:25:27 +0400
Message-ID: <20261030142529.415697-1-a.kazinsky@ideco.ru>
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

With CONFIG_PM_SLEEP enabled, cs46xx_dsp_create_scb() can return NULL
if kmemdup() fails to allocate the SCB data saved for resume.
cs46xx_dsp_scb_and_task_init() and _dsp_create_generic_scb() dereference
the returned pointer without checking it, causing a NULL pointer
dereference on allocation failure.

Check both return values before accessing the SCB descriptors.
Return -ENOMEM when creating the null SCB fails and propagate NULL
from _dsp_create_generic_scb().

Found by Linux Verification Center (linuxtesting.org) with SVACE
static analysis tool.

Fixes: 41116e926cb9 ("ALSA: cs46xx - Fix suspend/resume with new DSP")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 sound/pci/cs46xx/dsp_spos.c         | 2 ++
 sound/pci/cs46xx/dsp_spos_scb_lib.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index a77e6f5a14ad..57b0a6321e0b 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -1104,6 +1104,8 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 
 		null_scb.entry_point = null_algorithm->address;
 		ins->the_null_scb = cs46xx_dsp_create_scb(chip, "nullSCB", (u32 *)&null_scb, NULL_SCB_ADDR);
+		if (!ins->the_null_scb)
+			return -ENOMEM;
 		ins->the_null_scb->task_entry = null_algorithm;
 		ins->the_null_scb->sub_list_ptr = ins->the_null_scb;
 		ins->the_null_scb->next_scb_ptr = ins->the_null_scb;
diff --git a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
index 71eee5cb478f..ac914bf784c8 100644
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -274,7 +274,8 @@ _dsp_create_generic_scb (struct snd_cs46xx *chip, char * name, u32 * scb_data, u
 	dev_dbg(chip->card->dev, "dsp_spos: creating SCB <%s>\n", name);
 
 	scb = cs46xx_dsp_create_scb(chip,name,scb_data,dest);
-
+	if (!scb)
+		return NULL;
 
 	scb->sub_list_ptr = ins->the_null_scb;
 	scb->next_scb_ptr = ins->the_null_scb;
-- 
2.56.0


