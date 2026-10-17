Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062F26ED33
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198252; cv=none; b=nDXJUaD57gd1oVT4rX0mvsIu6DGSKFK9tAbNblmKP6mvr5PZb6zzJDbKKnwRTSzPv18DKEY7mkaGK/z2k1QUZDeUw9PtSx7VC9ThGgaAS6WgaZvwiKmXabjlwxC2AVpD7JLFzF8evpYXdmvLFqc1NS+qb3dEnFeUahK3iC++Dgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198252; c=relaxed/simple;
	bh=5V8rinvEffdQKrE933/i9Jyx4668IhiI+lCFsqIuIZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eozbPe27Vtws5tNQ7Bbp5wVjaNOyJ/6kmIzW41eb89tsvyET/Nsxd1vMZFnijhgGlPAUIrtElS3e9QkQXqm3B34Q0VpJCHkwkXsEyQZLt6OQ2ZQbbN1L2q0IlARMqydk/XFYOinmxA6mlnzO1TsWD8i7SKoaRKUgdKv5cBVW7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gehfVjRO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gehfVjRO"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-823b938464fso262827a34.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792198250; x=1792803050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+hJXj8wwiIb+5no1EG7QW0zHdqHn0SmMCU0JKT/7aQ=;
        b=gehfVjROL79+MsFFUIGuyrVCyf4r0h1E9bbuMkuV84/ZaS1BwEL0bfHMAmD9NL2VdT
         GVGgeVmy9nHjrYYdRxGcf4k8xAGFVGvr4GjaYYzjxLy2XwC73Rnx61QunLMUUpIAA5V2
         1feC4FsXQzc2xYeMFys3cNsMjtuoERILxL2I5uyETcQESlwmDz3XGLa6E5bjpBOjQ7I4
         CbxyDQfqOupAGlslzuAc81M7BtqsixdKmFME0zcKvWNvdddxElXC5NPB1PGgsm5IBU6M
         S+YBXEkWhPnboNMtZSTzrg4jXGn0WJ0oZlyoWD5SpiY6OzCrhHwMXslGPOaJjeAnLZwl
         nNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792198250; x=1792803050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+hJXj8wwiIb+5no1EG7QW0zHdqHn0SmMCU0JKT/7aQ=;
        b=sOOqjDEX7g5qHX0Xlb9KrW/uL3bxKMpZT2XCJruXBLmerp0KW4mb5p2RURw7K36zQu
         CDOeIJdzq0YYyOF88AMCyhbhPXIEgdwR6h8THpLHo+RNOJddZl6hBVEmIJrWrC9YtFtz
         fw5NWld1zma+uijjMqJIagOtUiFEiXUA3ubmKwoSdnuDIZnP4Bg9D8aaYg4WvZG1Bqiu
         lo7wItc3IdLK/o+8oHYbezsK2yILximxKaSiLw+vZCXqUmTvEN7r/u7kHGhNBGzApHO1
         SrCST+IrMHWUW4GADVUPwso2z1Bwx5VBLcVjfoyfre0Gx4weMJrnl63eJqYPkGNNAjh0
         9cAw==
X-Forwarded-Encrypted: i=1; AKwUvByfrSCyuWhMFOhDqCD2qoNHLkcMjCwdjpiVuTjgC5Zqgb7O8cZ0KN7AHnZx4NgzzOUxLo1y5uQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkvqjscW4ffs6efE5YKLiwQeheD6Chm/ZLfUs9tuAHOwdsKlEM
	b6sDsSpHwL6ZksiZPlfjYGwzQyzZ3XSAKAZi1K3ZCODOeXYiYrFKPVyj
X-Gm-Gg: AYBFou0bvwf8qsgPg0ATdhUHj/rhL0aGfa0YEy11toGaUFi+/2/bylVAHevI9ebrrDF
	M1gmpNoedhNPt7S1Ng3v3i+4XIy7faFHRFM3Zgsk1R8/7bOJl2UVD7f+UvSrR61tFSUYhpGkCTY
	Och2qrFqr3EsVTHhnqfMXa5f7xjD8/Bc4fW6aNMeG6CDzXyP/t0BtvC6i2JizoU80mKbgLofAtP
	SpgvdefPsdv63jdEGZJp7VRDRPqbf9LeHM0S3bEhmErtDUv6q04V1uunMlHdImAcXXA5JAzkCH2
	djipTSrElMU5lzCkR7gDkbQjExDXwzGzounAvxezgx4i7EueeMc7zTg63NbhXQ35PUAZJu5jfYr
	Y3z2r84wW+OB0Kuzige3rNDkUaytgX1T5816uAHYlhO7ePbG2U8bX2YS/rQMDD+hxYvToX2pyw8
	RWnYM6Nd/lc4B7KgUuw9aURLgoTswDZOfAUItXV56NQxE5ur1lcT4xmMXH0TvgA2E=
X-Received: by 2002:a05:6808:1245:b0:537:3bdb:2d7b with SMTP id 5614622812f47-53cd247bf4fmr1239261b6e.11.1792198249790;
        Fri, 16 Oct 2026 17:50:49 -0700 (PDT)
Received: from fedora ([2806:266:482:9274:1367:9be1:68ed:86d5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b63cff2sm2843941fac.7.2026.10.16.17.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 17:50:49 -0700 (PDT)
From: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P
Date: Fri, 16 Oct 2026 18:50:39 -0600
Message-ID: <20261017005039.9139-1-gamaerry@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 36d3bc23a..2a0d25493 100644
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
2.56.0

