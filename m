Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD91D20ADF8
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588836; cv=none; b=h0Ex1Aslpoiqw9k4jz4z1Vr9UZXUNc/itty34S6+01hPEXGMM74vrNSlhrMl50vLdxxuxLYi1QzURl3PFWcEC5aclTjeF7YgAjtH0SnYf9DKvcbfxxHYxZ/0ZIIMTa/yybY55XofmdRlothxpywQvC9F8tLI5I+L/D8UxE8PUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588836; c=relaxed/simple;
	bh=Rm8yJnlT3fsCQLbfHSwTkl17wnWlfVroX3yT09INhmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G/ANR8dOIPnrTKDAqEs+2BU62CckgJioZbci9VVYPa5m5MOYxhZ3d2NRFS2XZsKxPn4NUmZQ79XsEfCJFICwZghr3oiMcvh2Wv09qdT9e223L5o+v0KCdZsM/2yt/xmucPDu+wUQP3E7DS7xF3+PVkdugWx48ZHPaAh+z1BoGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MI2SiVZZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI2SiVZZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so1433439f8f.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786588833; x=1787193633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jBG7b5ISCcqvogeJMToUIR5kJKEpeXF6DhAFVm+3bAY=;
        b=MI2SiVZZETU7Om+O3zztE1F1/rnfur19hTeebve2Zap+DxfTGVVtU0hU18NoEChDRH
         gSWt+ke9uukDEFK+zBTQI4lt6MzuzgAiXLmUaFr+Zwk/7WXcYQnv58WiJvrZUo5RXTFf
         ovshDJatEggJIKRvrH1VQRIhXavjYkKDh2lOAkithqEJ4qJBGfOu4ZXDSd4mYrwjXVHD
         aRkCTyZAv6fnZc8WNtm7rg2bOHqxydImbURWhB8zikr9/l9MpXcTIf7ZtQdVrE/OzQ88
         b6/Kusp5AAlYTmpgzUvnfXvGOo/HUK1WXb2gD+rz1fqN1KJBuOJBMVFgcxkTR7/DgMR0
         BXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786588833; x=1787193633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jBG7b5ISCcqvogeJMToUIR5kJKEpeXF6DhAFVm+3bAY=;
        b=g54ptzKqotxqAArxtPlGkraxzbzblIbk3vPgptlcLPm0uW7szyy71q46qH01PcpzZG
         WJEBCTwk8iK4MoLFcDSNSdhX9paUwMLSq/j8XYggKgLVFT782F8k3ZNMeWqhzg8bwfme
         cbRSLGNlc8ggd6wx/voFHgfNVkQpAk9dmihp6fNqAoqBEnieefKPzKvlhp5GQ5Lf5Ih4
         9PJp0i2IuN9NwY/VOYVufW2bpu5ua/byf1nYDKcKRAgeaTWk3jI/79D7www+p2f7BrEw
         xF/pYBUGaD1hAsKFeWc61K4X5AMiqk7kPzZkGmryAxZp0txWEL4rpq4Yegev0wweVnkt
         QCQA==
X-Forwarded-Encrypted: i=1; AHgh+RoISIQvWRcmmPg+C35alXbLCNI0pPqrwxTXjXr/26HMw1NWM6ibMsyoG429AEmrLt/WEagF92s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+aHNUpfhJUkvaW6lIX/DBi3XuyC3B7hMaUiNKYd/7W4Zknvjy
	Rt1pa7z1AqTPpcPUpxyoCWJhgXbpFkKEgj8FvIhrGkkT2Y3xmzpx1H/jtLRwVfv5
X-Gm-Gg: AR+sD137K9RYoXYdSMnfUvXhyt5zJzWSfrPer92B/9TIkwW0VY6UoibBsZcK0ZPEc50
	UCYBTHXuQCE4pb3SkBUdtSXyDeEpD3i5re9vJXL7f6EXIxX4IUE/QgLKJVd+/IqIIFCNSXgQVAn
	Mkc+moPh5z4enMb4lMF9Fex0C61oE09nAA9uNOX32n2M1PFmfLnkHW65RbLs2gjF6fAYKraje7Q
	obkCtYkY9/Xds41T7EBHZjvwyUDvwJ2dcQEP+H/7TQKUucA6uUVycQWOal13hJ1yx+fwmHYpL4V
	o+v6JeF+b8KVKsDJGAWiNIcM9k1w4JSO/EAOCTA8J3KF8qCLiclClKlpPyY5fdOdVJMSXwthZps
	8bQyEICo+xQl4AVJVl60qpubQqV7NDr+NXzpUB+SGy+rOCYq3vz/b4vB+5dyJwTID+ce5TbHcWl
	Fk5ZLusqhxJTlh49SUDAqQgQ/MbZe/9WEa2nGgTlg5GvXPcv0q7miS9/8nF/Y3n6y1aqO7UYG0A
	8so5+I1D6kvUxFjXNbC/2j9rRTgVFkcX/upGms7djldyJYuG2N00AFUgmIoUrX1vvyiBG7/jHJq
	6ZxezMA7DdEPzb1MakFtkqVkTRqnxgc+iswImVRrvsnIa+dLAs6xxLQ5tJnicLE7Q0hi
X-Received: by 2002:a05:6000:388:b0:47f:e770:13e0 with SMTP id ffacd0b85a97d-48159ccc59fmr3151747f8f.7.1786588832762;
        Wed, 12 Aug 2026 19:40:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c79-1f01-1565-573d-10dc-99f9.310.pool.telefonica.de. [2a02:3100:9c79:1f01:1565:573d:10dc:99f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5c2308sm2306362f8f.33.2026.08.12.19.40.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 19:40:32 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Michal Simek <monstr@monstr.eu>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>,
	kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] microblaze: Fix MB_MANAGER build with older binutils
Date: Thu, 13 Aug 2026 04:40:26 +0200
Message-Id: <20260813024026.5402-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 88707ebe77e2 ("microblaze: Add custom break vector handler for mb
manager") added the suspend mnemonic to the MB Manager break handler.

GNU as only learned this mnemonic in binutils 2.42. Linux supports
binutils 2.30, where enabling CONFIG_MB_MANAGER fails:

  arch/microblaze/kernel/entry.S:946: Error: unknown opcode "suspend"

The suspend mnemonic is an alias for mbar 24, and both encode as
0xbb020004. Use the underlying instruction, which GNU as 2.30 already
supports.

Fixes: 88707ebe77e2 ("microblaze: Add custom break vector handler for mb manager")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310310151.UhB396Qs-lkp@intel.com/
Suggested-by: Michal Simek <monstr@monstr.eu>
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/microblaze/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index 582d7256d8154..ad44341a5dbc7 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -943,7 +943,7 @@ ret_from_break:
 	mbar	1
 	mbar	2
 	bri	4
-	suspend
+	mbar	24 /* suspend */
 	nop
 #endif
 
-- 
2.53.0
