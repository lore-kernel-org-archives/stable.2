Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032FA4CF489
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289328; cv=none; b=NhYFDwBIY8SbhFzeDC2HOfCXWYdlqfFqkCsk8ah5QSbbTnkt9V1VzVZ7gnX+96L2o8LxKYsX4Yg45Bm3yn/7mFVDrvSOV9WHf+/oJDD1oVyISQFfEFR1Q2ICO+COk3A27TIlrYXE7L58HfJZhzMYRfA4F1ZR+IDep45oaszw0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289328; c=relaxed/simple;
	bh=ow69sVINNaVvr2Z0q+1YVQzqsCXceAWHPGehvygUFA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6CsCFHLNly8Xfe18LrjMUx5AhCkTFXpVoEpQIpSJjpzVKo7VScLkw76biQD0cDgfjAfsB0wlJGqEn9yAlE/SSPvAIj18YQcgr4V7o7EOgxzFRq8orsg1DvhSAinHVi++l/09S+OhWqI/7xxN2TANJEdSOHsUukXGW9PpOPdtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPlWBOVk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPlWBOVk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533972e0cccso13400211cf.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289326; x=1792894126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RaGAAGiU7kTJl217HSqn7DxbRR+6QeuVGQHPa0XU5iw=;
        b=mPlWBOVkqSoa40MfIhSXJRka9r5QpJvEQmzcBu2AoExSX0cGEbXGeGmYxDv/zFZYZ9
         0U+IQidBjkH4nt2igg+bZt0MSOnKYocUpLsUmQDJdH6z1ewtuVUaeFzoHHnjSLea6zEx
         7U6C/nRvb/6NZk4qc+LC+sHcfVrCwN26o+1lnXrXhpHuAqXg0lmeUdT82mb8uHpS4n7x
         LJsTE6r4uesd5RPCFrA4A8n0VdQg4Ww1ItWiCMFgPL3ytmQtRVnZqN0vjoX8ZT5+R5cN
         AJPtnNtK15OsRAUDFWlnugLaI9xR57hBUB0Z+ryV7eFWasHlrie1sKmEEFGPGB+victL
         FvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289326; x=1792894126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RaGAAGiU7kTJl217HSqn7DxbRR+6QeuVGQHPa0XU5iw=;
        b=dHWEcDCvz22eYKYFAfX/a8QONnqDSoCcYfPP6fAdmK2aPS1wyoWD8p/Wj05WHixaT9
         gUSiWDgFn1QEFvTfxXFKnhFb/N9mO/L/cJDKw8WkA9ktwFnq/wkLHg1UmYLDd8zFB5HU
         XAxFkEMT4rj/8dPUM8p4DIEIDO24wXvmbtK4pjQ8Jn1uraVulY0I9uIejjAJ1CCYYtp8
         KX1WdkHQ4d2EiDL+ruusrMdSwI7lbRSfOZ/5TSwJ74R9brq+zpzBGlOG8yOzQ0j0PJg+
         MlHpIF78pLvu54svwZ3w/KxwHsgduXxPhIaxCQUslVaHkagU7sLDkgVvlbZCENY5IQky
         g17g==
X-Forwarded-Encrypted: i=1; AKwUvBwPZ+I23+4dqyLSvHiqU6D3o8JJhw8TPp9edasTP716rIWcq1k/OokfgGvDZMU1bLMcy84w/Qw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIB3sNFYrkUag+BlnOGmRlbhaYB3q5C+vEUMZUWB8ovVRUtT8ol
	aQuxIyvb9C/uW0hhiv67oKk0ZdrOIFP1EwoMI/b7HKI+0xDrnIDhPV0=
X-Gm-Gg: AYBFou3M2jLhKcCr5EsDG6+k9J9sk36DDiWaSsYSipSwGZozLhxUfToAZb0ZTVK+1qO
	4au7JFXGw+H3XFRSJUHG45UFyrOlE3Sm5Xun0Ue+zmJRqmh7zW5BEQOm7nzdDCnFbkKstfYzT64
	yk9e4fDX7vClR4a97/Vp0hTeszdAGlgQ/rEL+EOa4r75AJYxjgIAOtF91/5d3nQm1gslN4EC7sx
	qdb35iqH/M53POnacRFsQnGgJpFgcY9H3xi/x62IOyPZZHVNtJU+/d7T2aEvk5iwL+dYXz9B7HK
	PYWlzjha0xHmBuQcMBUhJ0ktNeFYj+kbi765IxE7i3RAJXg3DvETof7+yMo8AmF0xroen+MFY8n
	jIpAIzw22w0an9u5uPj6eq47m584VDGHOIaDwjgXpbPtcbwo7vhNICZKYyw5OOigTLDWaEWuEWa
	AH8xHCbiowfNRfK9Utz75qfCepI4bP2pDkIIvuE9qUBtAJyNRdO5PQ1JqxrCj0mFXvd3ZoxT8cv
	R8SoR52SL07vE8TTIkujl3c8b7DF0r3c2gxsuiYj7iDg4TnAHR8/KwAha0tT5+ZmXT5hMX+6zQb
	j7vGG1lwU1p8cUlmerhaiAolQJkV
X-Received: by 2002:a05:622a:48b:b0:536:575b:8dd6 with SMTP id d75a77b69052e-536575bbc1dmr35825921cf.0.1792289325861;
        Sat, 17 Oct 2026 19:08:45 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa68f8esm61731291cf.29.2026.10.17.19.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:08:44 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ae878000@gmail.com,
	daniel.machon@microchip.com
Subject: [PATCH net v3 0/2] net: nixge: fix tasklet and DMA teardown
Date: Sat, 17 Oct 2026 22:08:38 -0400
Message-ID: <20261018020840.3851552-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the IRQ/tasklet ordering fix and the DMA shutdown fix from
v2, as requested by Daniel Machon.

Patch 1 releases both IRQ handlers before draining dma_err_tasklet.
Patch 2 masks channel interrupts after recovery has stopped and waits
for DMA reset completion before releasing the buffers. On reset timeout,
it retains those buffers and prevents a later open from replacing them.

Changes in v3:
- Split the IRQ/tasklet ordering fix and DMA shutdown fix into two patches.
- Give each fix its own subject and commit message.
- Order the nixge_stop() local declarations longest to shortest (RXT).

Changes in v2:
- Wait for DMA reset completion; retain buffers and reject reopen on timeout.

v2: https://lore.kernel.org/netdev/20261004042702.1130389-1-mhun512@gmail.com/
Review: https://lore.kernel.org/netdev/20261007104833.4ukkys7rnmv7ki5i@DEN-DL-M70577.microsemi.net/

Based on net commit 6dc989ea46b96ce170840174b4a38c4a387fb005.
Found by code inspection. No hardware testing.


Myeonghun Pak (2):
  net: nixge: free IRQs before killing the DMA error tasklet
  net: nixge: wait for DMA reset before releasing buffers

 drivers/net/ethernet/ni/nixge.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.53.0

