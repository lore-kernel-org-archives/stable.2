Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327067;
	b=QarTN02ZXgbl6OvKT4uFzvKXy6AsAocWJr3EQM1k9hq3Xu9/Ht7PccYnBDFBLAb05BEM
	 c7+aPJ1QkOwYT/DJq6uNbkQcKdcvx5fEwU5PPBoUZKB5eK5T9n+IBCYKfP58aKgjYlemQ
	 C2edlJ7eoxoJDLGfcHtRHcwmTM1JAnh/L5FoIQZOsRusJmiFVVVAuX2d8IuojvliKcB4X
	 npSfMZWWo4PwGUnGvOPVIU25wuQ9fd8OQX6iDs+lBbbNVXYiDnGDaYyo+llYB8E16pdY9
	 JbglC3s6ew/FgaThzhpuh299CykT9hcnG4kz2I1Hl4UhFAF67grAGvIT16YzPtzbuKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327067;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IT9SRwnftPojdiJC5f5CK2+6zdjraUoSYqZXYZ3C4y8=;
	b=krC5P9i90fbwe3iEJFL7cWoLLuOMnARSCaxsq5IwCjTaHxx6IWPziBLTxJjA54/2tCG3
	 xJNKMRxYq40Zh006LBVpWoCW8B78r/Y0GVuitqOa2+mLyPJeeFFb8uuAuh7cfvmKmlurH
	 EUSEuIy2nl73Os0V8N22+8gq7yHfDb2UDiTWw4xiQEqvad8PhiMMTQZBflk0YD+ve6UJb
	 uFghsLrB8tD3QYYHGA5tPLWPJHEuJgKinIb6KqypNMgTvnhpkxMIi3jHCphx9PD6TenSx
	 hHt3FPMh71AvMw1idad1fERTP+2cBCxHWQt7Ng7fzGVcMb1SoTy+zednWqEW+6wIRgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqiINXDu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAC606D797
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqiINXDu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6891F0089F;
	Tue, 10 Nov 2026 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327066;
	bh=IT9SRwnftPojdiJC5f5CK2+6zdjraUoSYqZXYZ3C4y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OqiINXDuygRGE6dLmOWAsQApRaJRAfN/4dwR2VHRvEMJQCA9Vg/fkUvt4OpaAvHxN
	 NN94ze+lMDzeVarwpz6UHGLyLgmG55m5062zzZqGtSOZ6sNmaBEC3kL164vC/RICCK
	 n2EipNMzuY7YTq6v4SyA5yIyZMgjgB3Hk5QhfqonbloM7dg5ob7ZYG922eAJcBAVj/
	 HXE2l6Uc4BbQk1I4zTHYmTOxSYU004wx4UDmiHsEb2JDxnpuwb/Tupl+8Z/Qi4w7+D
	 6MVrWCVJA+q8ZBAvhmdZZU3psdOgtAoQOKX+ffuRb4olDfKQDgquXdw/yZ2Tz7vXyV
	 nQ9zvkEeKrFig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	patches@opensource.cirrus.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ALSA: hda: cs35l41: Use auto-cleanup for put_device()
Date: Tue, 10 Nov 2026 11:11:03 -0500
Message-ID: <20261110161057.2400674-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051020-failed-6.18-8d70e364e866@kernel.org>
References: <20261107051020-failed-6.18-8d70e364e866@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c437a83cc69645edab8e0bfc450a3b706abe759e ]

A temporary refcount management of a struct device can be done
gracefully with __clean(put_device) for avoiding potential leaks.

No functional change but just a code cleanup.

Cc: patches@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260803140100.919071-3-tiwai@suse.de
Stable-dep-of: 8d70e364e866 ("ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index de2fd6471f059..a7fc4ba35e3a1 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1929,7 +1929,6 @@ int cs35l41_hda_parse_acpi(struct cs35l41_hda *cs35l41, struct device *physdev,
 static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, int id)
 {
 	struct acpi_device *adev;
-	struct device *physdev;
 	struct spi_device *spi;
 	const char *sub;
 	int ret;
@@ -1941,7 +1940,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	}
 
 	cs35l41->dacpi = adev;
-	physdev = get_device(acpi_get_first_physical_node(adev));
+	struct device *physdev __free(put_device) =
+		get_device(acpi_get_first_physical_node(adev));
 	if (!physdev) {
 		acpi_dev_put(adev);
 		return -ENODEV;
@@ -1959,13 +1959,9 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	}
 
 	ret = cs35l41_hda_parse_acpi(cs35l41, physdev, id);
-	if (ret) {
-		put_device(physdev);
+	if (ret)
 		return ret;
-	}
 out:
-	put_device(physdev);
-
 	cs35l41->bypass_fw = false;
 	if (cs35l41->control_bus == SPI) {
 		spi = to_spi_device(cs35l41->dev);
-- 
2.53.0

