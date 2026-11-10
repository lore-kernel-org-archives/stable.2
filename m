Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347166;
	b=WjvehxZeG03fSe9ETg6Jkm123+PNeNGJAUDfq/wjhHgkSYS7hiQ7kwXSpNdCftZtZ2Fr
	 y0lD733lflnjtyu/LOiB+3fVLuc7PnYJae0nRoaKtuL0r77/6h8m/ruNfUSmGj0HNz9Ra
	 AnCS7k9oFs4vzAfIK2q8bn098mMWSWhC7iBsd/VXYektxA9brlpfWSlj17bk+CBo6G7Xa
	 kgDVhHlNqYkbGtuG369E/rYZephn+t6ZAmjevKV+VkW1faNuPAhJi+849jbyKYNlh2JGE
	 4rRGHXc3nnzv+aNtHzoQGh3bVzoC9uJHMgzWzZLwFmlr8U00eRomgsyxmshS409+1pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347166;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t7hlakBmsAr3ax6jNP3TT5p5J4dPA8EVncGbr5D8iSM=;
	b=f9Wi+ANSFXLfJ30pn00zQsLfFaZIWSseu7zesTzAUlTf6HlbUZvdL5irMlPrqrtk2xZH
	 HveSbjXwqvaOCIlIalD2qgoEJL9IjdxBkj6Q0DzbSF04VE87PVO9Su9YKZjbvgAcWtJ7h
	 v35dLPjN+64qmT3KnO6d4OCEv5emp8dWxUIUUQMWRaEYGHZ1HUTHFItIsHuD07j6HASMs
	 N2BKUSDtfQ/o00Da61zmH3Is3AkWZo3toAH+1SxB+aoXkyDDlEE7x88HyQoPnLy/Xte+k
	 wiIx5vwymdYeGmMoluYk35CJ5Ar5VN2S2T0pZ4Tt5Whp4dtK5yFU7IVdRryOg2JipUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwHsAh4X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F860A2604
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwHsAh4X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342891F008A1;
	Tue, 10 Nov 2026 21:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347165;
	bh=t7hlakBmsAr3ax6jNP3TT5p5J4dPA8EVncGbr5D8iSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mwHsAh4XapvkFPSLj5zARdNEsHxUbLk5ZjDVTC70h2CACuN8ejUBEFl+xV3FHl8sh
	 BM3V4qYe/Y9lzDV3c52sAolPhdUdWtJPxELQfVmxVrE4fUFUem3GbgoTa0klmDRz2t
	 uHA6F/yyvgR3klrYw3Euy8wDcPUXSaQW7e+2y1/V7GXQntKetTgdMynUQ/9C7SJu0B
	 lEfWKgAAsPoqXk6TY8bEfzjGwX9Eib1i57ywgSDFHwKWD+WjrTHkUCupfxlBUd0iEd
	 R/kcIT4uiOd5Z3dxvyj3r7/o9tU4xA5SohEIFuPp5TBmaH6zNd2iyBX5uEcjkiAPnF
	 TSC128j02bUQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sehat Mahde <hskmahde@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/5] ASoC: amd: acp-config: force SoundWire probe on HP OmniBook X Flip 16
Date: Tue, 10 Nov 2026 16:46:00 -0500
Message-ID: <20261110214345.3938361-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110214345.3938361-1-sashal@kernel.org>
References: <20261107051216-failed-6.18-38cb2ef26b64@kernel.org>
 <20261110214345.3938361-1-sashal@kernel.org>
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

From: Sehat Mahde <hskmahde@gmail.com>

[ Upstream commit 4d6642d64cd00f276549ec2c0b0278aea2f8c1aa ]

The BIOS on the HP OmniBook X Flip 16-cc0xxx (board 8EA2) reports
acp-audio-config-flag = FLAG_AMD_LEGACY_ONLY_DMIC. This binds the
legacy ACP driver and registers a PDM-only card, so the SoundWire
links are never scanned and the two TAS2783 speaker amplifiers and
RT712-VB codec do not enumerate.

Add a DMI entry for board 8EA2 to the ACP70 ACPI flag override table
so the firmware-provided flag is overridden and snd_pci_ps probes
instead.

On the affected system, an otherwise identical upstream kernel
without this entry binds snd_acp_pci, enumerates no SoundWire slave
devices and exposes no internal speaker PCM. With the entry added,
snd_pci_ps binds, both TAS2783 amplifiers and the RT712-VB enumerate
over SoundWire, and the amd-soundwire card exposes the internal
speaker playback PCM.

Developed with AI assistance. ChatGPT helped analyze the ACP and
SoundWire behavior, structure the controlled A/B testing, and draft
the patch changelog. All hardware measurements, kernel builds,
reboots and playback tests were performed by the submitter. The
submitter has reviewed the change, understands it and takes
responsibility for it.

Assisted-by: ChatGPT:GPT-5.6 Sol
Signed-off-by: Sehat Mahde <hskmahde@gmail.com>
Link: https://patch.msgid.link/20260825224640.13662-1-hskmahde@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 38cb2ef26b64 ("ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-config.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index a46b9a029cbb0..d73059f400d57 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -44,6 +44,13 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83W5"),
 		},
 	},
+	{
+		/* HP OmniBook X Flip 16-cc0xxx */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8EA2"),
+		},
+	},
 	{}
 };
 
-- 
2.53.0

