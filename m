Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273584;
	b=LwOzju7bSkqRbxCgp3kUlYpO6QUhEudihia1oBawCrJP0UD7pNxu/1nS4On1h8egW+RV
	 cBUqUSaB4+N3uoUju0NiJe6nvuuevVxsTn1ZReeQ79VCvX42KZOwJO+KXlSmcCf2u9QO6
	 WAIR2VOBAf/QYmqbPCM5gZ2YqZFI7IkS0SGat4xmfTYXgZSRXKR6RLI8XNVCRDGAssjPN
	 ceqAqHGkcvJoP0B324MnnfMzxpI32P/YHAVXR/+HF453cAJl1Tgudu43HV4yv9xeusNbm
	 qzKowZUnJGlzTBUmK5yWWbKENl24oemyzwklNO7lJw6HirFvR4sW9rKynBbQyXXVz5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273584;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z/FjBEOSrlYP8ZPSM+Z7dusqvr06xV8TiEif5/t6vcQ=;
	b=imlHSeoquW5lMJm/Gs1wUJBNmqDMOtDJumO7oj9bz/XTiOkdKzjZIbrIau1QA8HfITT3
	 G4/npvvPRrCB00+OQmko8j5LIBclKU7/WAeml5YFDLXA9m8G1YmobkCVJK7774C+Z8X3a
	 4IXwU4Rjh1GRi44d/CbaiBeyEimjDfRyFSSHcnztynzTZ+gk17TyNPNDiNq5RyNC6DGle
	 5n0TLaC9tdT1CzlLhobxBPM9wgWm1AW23EMTDtLLKYqqCzly6EvsdK345ggsMMDb4+zKk
	 AYvULNtMbaLCZQaGiL4HZ/7VKePPP/VxAJZj3Yfw0VO+nY5Elw94k+KI7hbHPaGlM6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HIYkKl/O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D64606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIYkKl/O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529CE1F0089F;
	Tue, 10 Nov 2026 01:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273583;
	bh=Z/FjBEOSrlYP8ZPSM+Z7dusqvr06xV8TiEif5/t6vcQ=;
	h=From:To:Cc:Subject:Date;
	b=HIYkKl/Ojwv6XfSZSdLHgzV+GpZcfpj6TqMM9QYS2nPKgqVEOYrbCQfU8IUFtBZYX
	 S4Frg1QOfLmcdYRLYxz4O13Y9a5ViFXNKUsBzMN53V19xY5TUwAFhD/ls6WO2grd4z
	 esnUkLr7w+JIv2dWP5djKDYdtfAbCXoLPKx98dc7RozsyPKrSzMr3k9kY7yiPNAh+6
	 LjsKhzbSkPoPaUFrgVUvb2ONwsDiqHaU/wkdwxlsPGCn+F6yDr/R66D9Xh4LzJvxaP
	 VSwgT6sEqYjCOlOcPoIn/io3i2D9NHHwSbHV9I1hVop4Xq3KszlcQYU0uXPF19i4Dh
	 tNdZZtJjQhTPw==
From: Sasha Levin <sashal@kernel.org>
To: 25031212351@stu.xidian.edu.cn,
	byu@xidian.edu.cn,
	wencheng@xidian.edu.cn,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usx2y: Refuse a retried DSP load after a failure" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:19:42 -0500
Message-ID: <20261109201942-failed-6.1-1f8101b6adc8@kernel.org>
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
git cherry-pick -x 1f8101b6adc87a3ddbd51fcb6609251591758026
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201942-failed-6.1-1f8101b6adc8@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1f8101b6adc87a3ddbd51fcb6609251591758026 Mon Sep 17 00:00:00 2001
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Date: Sun, 1 Nov 2026 03:15:57 +0800
Subject: [PATCH] ALSA: usx2y: Refuse a retried DSP load after a failure

snd_usx2y_hwdep_dsp_load() sets up the asynchronous sequence URBs and
the interrupt URB when the FPGA firmware image with index 1 is loaded,
and then creates the ALSA devices.  If usx2y_in04_init() or
usx2y_create_alsa_devices() fails, the URBs that were already set up
are left in place.

The core keeps the index unloaded when the callback fails, so user
space may issue the same request again.  The second attempt then enters
usx2y_async_seq04_init() or usx2y_in04_init() with the URBs still
allocated and trips WARN_ON(usx2y->as04.buffer) or
WARN_ON(usx2y->in04_urb).

The URBs cannot be released at this point: the card may already have
registered PCM devices that user space can still open, and the
disconnect handler accesses the URBs without holding the DSP lock.
Mark the chip as hung instead, so that a retried request is refused
with -ENODEV and the assertions keep their meaning.  The URBs are
released by snd_usx2y_card_private_free() when the card is freed.

A failing usx2y_async_seq04_init() still releases its own URBs, so that
path remains retryable.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Link: https://patch.msgid.link/20261031191557.8460-1-25031212351@stu.xidian.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/usx2y/usX2Yhwdep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 7f153a2fcdd81..3800c5b5887c8 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -179,6 +179,9 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 	int lret, err;
 	char *buf;
 
+	if (priv->chip_status & USX2Y_STAT_CHIP_HUP)
+		return -ENODEV;
+
 	buf = memdup_user(dsp->image, dsp->length);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
@@ -201,11 +204,13 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 		err = usx2y_in04_init(priv);
 		if (err) {
 			dev_err(&dev->dev, "usx2y_in04_init error\n");
+			priv->chip_status |= USX2Y_STAT_CHIP_HUP;
 			return err;
 		}
 		err = usx2y_create_alsa_devices(hw->card);
 		if (err) {
 			dev_err(&dev->dev, "usx2y_create_alsa_devices error %i\n", err);
+			priv->chip_status |= USX2Y_STAT_CHIP_HUP;
 			return err;
 		}
 		priv->chip_status |= USX2Y_STAT_CHIP_INIT;
-- 
2.53.0




