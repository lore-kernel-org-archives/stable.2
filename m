Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793314175;
	b=OFE6xb1NbasWmdFv0N5WBVqBP/PXDRREKIe/mTcioAwhmrKi3rJl0uNef1wHQvtGC/I3
	 njUlUSy1Ansd1eKHB8rrJzzGZiarWvK46Xy2nwtU4ZC2TJWKxz3Wus3PP11RtDWi7IPxM
	 E9OslzNjhjoOp43TXxYypj6dqadtuNSaKb3XYhKSfyAw0+qUFigCb57tphzmRADgwRTtn
	 ajrP4EfQkDbbnE1BknxmIqgpTv8G8zqAZ/CmZfo9oa9H2grzo2Zuc2qVE5M2KJARm1il5
	 dCN5iLBVtAzRWwC3aNrO/RpxjBwf/jCrFI7AEz/6qF5jwEh7COg3gmJ9DXnEX45E1cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314175;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=k5BZLzJDz2RGBNaVPb9sM/jFYK8WtC4TVtwFR3UNCHo=;
	b=eyCWJwwDoM7RNup0Hv+8WziQKMZ82ST89aNbhyNjHaxtRfZ1KjB46Nzi6sfUOYwmzYgC
	 /7kTIXLWpCDCtnZretpzOlz2D/EhPafaXsgkOezDrxevytDhT5zYSIufv5y9nL5reAjoe
	 a3kuzVqRiz9VSoGgf9WIpm6KtGgYfsPLr25UEFq2NoKxczZC5jHOoCX/h5VPCQVPcGYlc
	 aaYTDrOpkUVIpwR6vSNbzd5GH8XUW46cr5EGio+svc4YAhFG/KFu077VUndVGyjrsA9L+
	 rh0fgv/eiifhu0dhsdbXHl0PYRpbFCUIigVnJ1eK2KY3baNx09ysgL+nyVyeM/M5xzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjOSsmqR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24400606A31A;
	Thu, 29 Oct 2026 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjOSsmqR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793314174;
	b=tPi0LeN28P8XxijCxecgWQeCdyFV7S+q52cBW7QvAzdeEkg66713F6iwStmKDaiaYZhu
	 u1Zi7zVyZuNOi40leFDrWZm2U8Plw9SBkkaHk3L1oCKDaWDjTxm8c0SDerwKGbzMB2OqV
	 R644nYy+WHzO3sa+oKSegrCxfDTC9+f+MJDG9z0+hezGzGj39XoXpZnT49SQLQZPeP3RG
	 q6asYWMC/kpQiI3zpSxNeBS1MhXygr9QWa7BorKIw/N/nffe133Iqlu4V2bGbhQ/p4OEJ
	 HOBToKZoD1ht4csn/H2SwntneDjwGugrTxJ+k2aOTvQASfqXLyOYK5+XjfFaLCiqvSA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793314174;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=k5BZLzJDz2RGBNaVPb9sM/jFYK8WtC4TVtwFR3UNCHo=;
	b=AFbXdXsyfhU3LQbWauQ2qn2nqbJdyxQK7lM8q9ecWT6vNYkWTacq8TtrstLYSwai20BR
	 XEaxY1AXqPU03UNBrZFvKObKRN+BeLCS6gHWHHdmT+hAs14+NVOD/X0XPJfVr32agpRFy
	 MdjcARpKz3bxf93oa/T+ACW7BpRvFeEjnW3B7ng1OchKB8xgBCoeA/ZzGt7tyjvcHoQGH
	 OW2fnMb4TWTMxMcihJ641ly1QVANr9cyCvPSFms/J+VMLCdoQeB1MHS7R0yt6wCOkZU7z
	 +F0uYYT/JvrSg2XcPsQ87s/qwmb31z23I54lObGyVJ2AJinv4OHW7M2R3umJUxNr44w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 256B41F01816;
	Thu, 29 Oct 2026 22:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793314174;
	bh=k5BZLzJDz2RGBNaVPb9sM/jFYK8WtC4TVtwFR3UNCHo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=cjOSsmqRnl9NdR6fEn3AHaUpst4e98h00BSH/T3gJo9KLSFpGpymm9d7+jlh7QseW
	 1P/11JA10l8aASih2uD57Vqatz5PrDrbfXb/w95LEZToGiJdmumY6pmYHnax/Ma5ij
	 0lPHx4MZRG30Z0wb/0PEUbGGLGnfjCbS3/WKFGRJhKW2vK+SmC2nMmd9IZ+B47RP2k
	 4CBH1XzgYdfM6CncuazBm32RgmCoCVJVTb9P7ds6dMpHK8crikNsxMyCwz0mdiSJVw
	 M8cIYnu3SVo9ablk4kx2P/svGvFfIa1ocdRzKRdUKLz3xY8e5tnDOXgVVMl1qt8dEn
	 JYOVHGuLtHI5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7742A45A04;
	Thu, 29 Oct 2026 22:49:33 +0000 (UTC)
From: Chris Simpson via B4 Relay <devnull+chris.nilk.net@kernel.org>
Date: Thu, 29 Oct 2026 16:49:10 -0600
Subject: [PATCH] ALSA: hda/realtek: Enable bass speakers on Alienware m17
 R3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-alc289-m17r3-v1-1-5d3eac605e7a@nilk.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNL3cScZCMLS91cQ/MiY10DM4OUNFNTo9QUs2QloJaCotS0zAqwcdG
 xtbUAunRM9F4AAAA=
X-Change-ID: 20261029-alc289-m17r3-060df552ed6c
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chris Simpson <chris@nilk.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793314173; l=2233;
 i=chris@nilk.net; s=20261017; h=from:subject:message-id;
 bh=ycvtrC06Uil7aW797VPCQ/Tcavwuyu8NiwvTlrPUnEY=;
 b=bsPkcmM+rMoWnu0/mTFOhvR034Ln0vgNgWzFV/cvfosNMVxuSmLvL3HBnVCuiYw7lmbs5BMM1
 LkhMTOXutN2ArQEomfa7LREKeAOZ87ZYaKrlp1qHVmYI3PdAsqIst9M
X-Developer-Key: i=chris@nilk.net; a=ed25519;
 pk=bwNSTJdm8iKtfcCRqyaQFQFlAxLuiAxLw4pMXey4Z+o=
X-Endpoint-Received: by B4 Relay for chris@nilk.net/20261017 with
 auth_id=1225
X-Original-From: Chris Simpson <chris@nilk.net>
Reply-To: chris@nilk.net
Content-Transfer-Encoding: 7bit

From: Chris Simpson <chris@nilk.net>

The Alienware m17 R3 (ALC289, PCI SSID 1028:09d1) has a second speaker
pair, the bass speakers, on pin 0x17, which the BIOS leaves unconnected
(0x411111f0). No PCI SSID quirk matches the machine, so it gets
ALC269_FIXUP_DELL4_MIC_NO_PRESENCE from the fallback pin quirk table,
and only the speakers on pin 0x14 play.

Use ALC289_FIXUP_DUAL_SPK, as on the Alienware x16 R2 and Dell XPS 15
9510/9520: it sets pin 0x17 up as a speaker on DAC 0x02, so one volume
control covers both pairs, and chains to
ALC269_FIXUP_DELL4_MIC_NO_PRESENCE, so the headset mic setup is
unchanged.

Tested on an Alienware m17 R3 (BIOS 1.38.0), Linux 7.3 with this change
applied: the bass speakers play, and volume and mute cover both pairs,
also after suspend and resume. Headphones and a headset mic were not
tested.

I used Claude Code (Claude Opus 5.5) to find the unused pin, pick the
existing fixup and write this patch and changelog; I did the listening
tests myself.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Chris Simpson <chris@nilk.net>
---
ALSA: hda/realtek: Enable bass speakers on Alienware m17 R3
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 23329d588..145db479f 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7594,6 +7594,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x097e, "Dell Precision", ALC289_FIXUP_DUAL_SPK),
 	SND_PCI_QUIRK(0x1028, 0x098d, "Dell Precision", ALC233_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x09bf, "Dell Precision", ALC233_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x09d1, "Alienware m17 R3", ALC289_FIXUP_DUAL_SPK),
 	SND_PCI_QUIRK(0x1028, 0x0a2e, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0a30, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0a38, "Dell Latitude 7520", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET),

---
base-commit: a4311e9447bbb219044db38897f95be112f46a8a
change-id: 20261029-alc289-m17r3-060df552ed6c

Best regards,
-- 
Chris Simpson <chris@nilk.net>


