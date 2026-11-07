Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048639;
	b=B4w7fqeXg5uE/gB8aq2HpuJWWvxCWXKtTP8zAEqg/EVMmNiPqDmlKNywPhplhE6H37yF
	 RX8e1hcHsmMR1rHZ79S7BNUcY5meooBRTJeRL+0Lnc9e2FtHeC6kJOKyvhK/sh86YoEkp
	 aJrNLOUh0Q8acw7R1KgYWlbEDuDvy5MEDEhLN82pvn0eQrMxxZ+ec19pmp+lMRAsY56HH
	 YcZCpbnGv+5t6zDXsqQeyRt3IMo8GuOyTxRpbHFAXvFQ+uvkP8SGCeDSRCa6skeQWGTJN
	 hTVDRtFi+UBg9TuaQW3AtjFQdnOmHAb3YMExMZkN8sq0xs60Z+YAyACc8iPlYg7rT5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048639;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PGE8Q4jvrvAw6RwsjPaMvJFsB1p6ZzLqsrwStJtsjkw=;
	b=llOFA6OzVXlpye/tsKCMX+UJXPDQT+3wxisKtfUSHpMKs9oq8cSZvdRyj0Lp1/NwYYTz
	 N6l/vqCVhYUGLRzfzuSuQvLD73nSQgQsEk9YMMvCWNXmoqPBSiVrhckl7AB0NhyOxRs10
	 l+Dtj6uBFyt4dYyWUEE7MsmZj+A0CKoglk7Wjet8yESWeNHM65t5bT0hVy8hEdkyfarOH
	 +F40413417kRqTBxRPfV3ZZPkbmAEvaL0is9BwK9AP8tPIkBVtZhgTmzrnQ10CjFtrExD
	 NZXzxcPVEBEw7er0NATXJereRYVHrTIOCLzVhfSZ5u4wjt1DV9sNX2J5l/ZfjmCHxuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPHAlmT9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D929606D839
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPHAlmT9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07D61F0089F;
	Sat,  7 Nov 2026 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048639;
	bh=PGE8Q4jvrvAw6RwsjPaMvJFsB1p6ZzLqsrwStJtsjkw=;
	h=From:To:Cc:Subject:Date;
	b=XPHAlmT9sIN2zN/V2qwgNjxEwpXoaCo5JtU9ijJZM3OOaz+rtc5BPbPzY359ZNeq6
	 XraT+3lP2C4D9gsJ9ygbgTy2b4Ff671EMa3aTA8AUCt71G0XA6LujTAX6SIfDin3vT
	 uTkKllAyuEQJMEoHHUGn5xC/6D+cOrWyUM9EEiqtioZnOBNoyrFtO9O0agOdrKZkul
	 fLzLDjR/rGoV8JcsOSy1kZZkZTM5gBFp9ZKJ8oZMPV88ywWUYkY6sU3KUQDo+vfmPb
	 CYdw3VIAvDhfkoveWl6e2Ytn9Mra/eZHPvBZ1i3T2GRHrfwif5JQCS2tvSxAgDIvwl
	 /OE3hmgFr9SWQ==
From: Sasha Levin <sashal@kernel.org>
To: gamaerry@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:50:37 -0500
Message-ID: <20261107055037-failed-6.1-d933955c456e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d933955c456e0573b40eae4f72a3af37ab1c15c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055037-failed-6.1-d933955c456e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d933955c456e0573b40eae4f72a3af37ab1c15c3 Mon Sep 17 00:00:00 2001
From: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>
Date: Fri, 16 Oct 2026 18:50:39 -0600
Subject: [PATCH] ALSA: hda/realtek: Fix internal speakers on Acer Aspire
 AL16-31P

The Acer Aspire AL16-31P (Intel Alder Lake-N, Realtek ALC269VC,
PCI/codec SSID 2782:1718) has its internal speakers wired to pin 0x1b,
but the BIOS marks that pin as not connected (0x411111f0) and only
exposes pin 0x14 as the speaker. As a result the internal speakers are
silent while headphones, HDMI and Bluetooth work.

This is the same layout as the Infinix Y4 Max and MEDION E15433, which
share the 0x2782 subsystem vendor. Reuse their fixup, which configures
pin 0x1b as an internal speaker and limits the internal mic boost.

Tested by booting with snd-hda-intel model=2782:1705: the fixup is
picked, pin 0x1b is used as a speaker output, the internal speakers
work, and they are muted when headphones are plugged in.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>
Link: https://patch.msgid.link/20261017005039.9139-1-gamaerry@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index c33a385982f2b..af43e7fb99b71 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8671,6 +8671,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x2782, 0x1701, "Infinix Y4 Max", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x2782, 0x1718, "Acer Aspire AL16-31P", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x4900, "MEDION E15443", ALC233_FIXUP_MEDION_MTL_SPK),
 	SND_PCI_QUIRK(0x2782, 0xa128, "Positivo N15RPE-S", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0xa212, "Lunnen Ground 14", ALC269VC_FIXUP_LUNNEN_GROUND_14),
-- 
2.53.0




