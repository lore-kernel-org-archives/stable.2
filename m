Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11A339389
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718083; cv=none; b=LJT8CmQH8B6oIBSnMz+G+0smEF4k9M9qwDxEiWGjca1QtcgZI+i4vwW8gaqJbemE+wszEt436xjzbBPsqp3qVB15/UuJm6H5FwbOEYisd8/Mi4wb5ABevAX9dNIg+I1B5fwuOJjA7YhBPMqjy1lAk2x2uyKPvH7J2f2zeoO3IiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718083; c=relaxed/simple;
	bh=CooQiWzYxsiKsZ7mgbJADjk1rN7DsDd6eB9e/fnjp3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqN1S9d+GqnqGk/6iIKlxaSux9rvpHAOGrdOnVlRBbwYyVXzceomjkutWey6hF76bNRsYjnX+s927VQyiBxcHLfHE7kYRnK1fGFuPr9QSuHopS/1fOcbv+IasE5zd2p7C+mp6Fbdw9mM37EQTpnBgU0ErmYYvccduwZyqTbMxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV0cW6wo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV0cW6wo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15721F000E9;
	Wed, 22 Jul 2026 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784718082;
	bh=dFKNZDvVyGTYOoZKwvEHdhuvyWQpemYq2pjHn+NBeUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QV0cW6woEoRWl6QBGs+Rb9cL3Fq9pA9M1WO2XXSeCalxbKGafMjeD/ee7NIGLVvoN
	 gbhtqWtCGBDB7UE0Xun8qPjxRXBwl9+FJIIGG3OLi/j+UuqU9kPuUOvdoBO4fznP58
	 L+rwmYyAyR0cXlkqsUNgECNQcMt7rV/nRnv0SHUHTVodB68AqKexC84VBejjPCCuaf
	 +UcVlpuX5U0NDC8OQakPaT3XDgoEYW6a8mv4zqvesJBrnNTlxqUHmu0X4Luwnegta/
	 eagnwHR/U9M7TUScrkFl1MZp12ZifJBQRnbSRZRnIn3xGl6DCxyPzMWFn8+QzIxMhu
	 lXXQ8eoPLaTbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda: conexant: Remove mic bias threshold override
Date: Wed, 22 Jul 2026 07:01:17 -0400
Message-ID: <20260722110117.1006143-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072002-coping-spinning-bac5@gregkh>
References: <2026072002-coping-spinning-bac5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Heng <zhangheng@kylinos.cn>

[ Upstream commit f52524da7084c1a54683ae9fbc73e93fff19dd64 ]

Remove the mic bias current comparator threshold override (NID 0x1c,
verb 0x320, value 0x010) from Conexant codec driver.

This override was originally intended to support volume up/down controls on
headsets with inline remote controls, but it causes microphone detection
failures on some headsets with impedance less than 1k ohm.

After consulting with the vendor's engineers, it was confirmed that this
setting is board-specific and should be handled by BIOS/firmware rather
than the generic codec driver, especially since inline remote support
is not currently implemented.

Fixes: 7aeb25908648 ("ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Link: https://patch.msgid.link/20260713100329.306892-1-zhangheng@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index f6e563e03edf2d..ec1c92db7cd67a 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -168,9 +168,6 @@ static void cx_fixup_headset_recog(struct hda_codec *codec)
 {
 	unsigned int mic_present;
 
-	/* fix some headset type recognize fail issue, such as EDIFIER headset */
-	/* set micbias output current comparator threshold from 66% to 55%. */
-	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
 	/* set OFF voltage for DFET from -1.2V to -0.8V, set headset micbias register
 	 * value adjustment trim from 2.2K ohms to 2.0K ohms.
 	 */
-- 
2.53.0

