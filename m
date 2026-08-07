Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D67470EA2;
	Fri,  7 Aug 2026 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103407; cv=none; b=O0n5CXa/5E71fxNhcCkh58j1LpowKTmimKgWx/C6li/z7HSdAX4BnBpnrlu66BbfbW2rcFdsVrHZtiRGC6a9UArW3p2KVg7nP4iJ+2fq8cHVRtxVraMjTlP9rbEjj3rkw1N2BGkDTKjmn1T1m4FyFys/CxfBZwHBPoK8z8wmMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103407; c=relaxed/simple;
	bh=QSPIBgA4ncqbSJ4N9+o8dK3jhaZa12bTlOCh56Cj/5I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UK8g/Csb+Z0ejFH235PF76dgmE0fuImhG40zNdFEo2/PVUT2Xjf0tlgOv1BaiS4s9/Mw8CqxR0Y9xAQA1e/gOAIT1/Ok7Yxqibv842kIfq/f+Ncni3K4pnDVoX9IOO90dAiY5yMavRZHWi3vmCI/Ppj0QpTMw1lOnKza9XTj4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I2JPvKe/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I2JPvKe/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DE40D4E41132;
	Fri,  7 Aug 2026 11:49:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96D69603F0;
	Fri,  7 Aug 2026 11:49:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E31D11C3771F;
	Fri,  7 Aug 2026 13:49:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786103385; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=nwbDmQ8hsvN7LjBOnlIUijdJpanxk8RlQdvmVXPqkkM=;
	b=I2JPvKe/1EeRG5cO8yNx5vOFhVlCQZ+YBJwJ8IDon0G9dgm96ePmWGlMumWC3CFDbr+jBh
	oN3EvmmYdgymreklskyjsMd5UHtsk2Sf8kosifRtW0zzpg/3DE6te5/3rbNgIJTn4F+AMG
	/eSWuXxcEjSdiNnyCbpE1ux/3CO37aKJaIGiK7UmwI8L6PapoIMfUTzJS3BxuS8gh9002V
	TZqVL7vbdSRYGkNjyUdRVGqzeMtXg9holpLNksnzK91xHemXlxhO4/jb4ASvzO3yLo1QlW
	3Xygvuri5kB/LNgIv16KZFuGOpM7TTkMdEVKI4IdewfS/wcITv5LZsMf3xcV/w==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Subject: [PATCH 6.12.y 0/2] spi: cadence-quadspi: fix probe error path and
 remove
Date: Fri, 07 Aug 2026 13:49:19 +0200
Message-Id: <20260807-cqspi-pm_runtime-v1-0-5973a0a208c4@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBREr0L+2pK2YgVX3sMQA/VXvpEW20Ikh
 LsL6M7lm8zMmyCgJwxwSibwOFAgZxcQuwR0U9k7MrotDJJLxY97zvQrdMS69up7G6lFVuWV0Ep
 IWWQZLLPOo6H3dnkBlQqZjlB+89DXD9Rx/VubDYXo/Li5B7H1fxrxrxkE48wYXhtdYI4Hda6di
 0+yqXYtlPM8fwCGSUsXzAAAAA==
X-Change-ID: 20260730-cqspi-pm_runtime-a8a1c6122944
To: Mark Brown <broonie@kernel.org>, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 Pascal EBERHARD <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=QSPIBgA4ncqbSJ4N9+o8dK3jhaZa12bTlOCh56Cj/5I=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqdcZXk0YTll/sWJ51cv7z/nTiEmNnv9+anOSsZ
 MOzGGkV3CuJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanXGVwAKCRAGvnxbVl7J
 RTgmD/9irB5srzEDYBBhxvMmJkZcVeiaqv0VO/nzgEvgaqOug1gJ1ZzL75RYp+bvaSINu3x0mJ+
 8SjI+44UOCL4j1UMk5zVjwtDd76X28jDWqYFncFpsOpeh3dahkPWyQMU9MDGuUxhujVlyemtJ1u
 WnmVdZJswbRH+Y6Ax2kW8Wy5kMxDMouCgWGVAkYhr7DuX15PdghCcI5p5l9TOQyxQnmtjsAxnBo
 FISUvu+WXpPFoEd7f7ZJKfZCrNo8NZOagTEO/c1h1LeJ2dEl3f1viGgMvHCXy5J8jzYg+wCPX4+
 CAuMEotKX5FF0QIhYJaehaRVuUdgBM7iwMG1II/uEjaYa7p6U5lxjjFhA3nfcR4FduZtaxwnirZ
 s0TZpKh21t5v+UjLgwjJfIRCwXrywn4/UY8MFu/Ejp/YPrgpuXwhvfQtevq8t9mYWYpOjCGbKzm
 hC0nmqesvF9DEtM5EuFrJjjprQh8Wyr+swJbMLEewVlypzrcl8B7lTw7kJ9l2JBINaj3r7hKu9w
 2lLSsEdjIJwLlqHbsUffjQCchp/4Ur7MX5+gcmlb8Tu/hWaB2M8b8hEUwvggh8ulRKQbzYMlIFe
 hKpusNAzaXz/Q9i0tQv8AUwx7m7DM7dcLc3CisifIfY0oDKHshIciDZwnO7MjlYS7kEqX7wcINw
 Vls49Gk7voQCBCA==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

This series fixes two resource leaks in the cadence-quadspi driver's
probe error path and remove callback.

Patch 1 fixes an imbalanced pm_runtime_enable()/pm_runtime_disable()
pair: when probe defers after cqspi_request_mmap_dma(),
pm_runtime_disable() is called without a prior pm_runtime_enable().
It also adds the missing pm_runtime_dont_use_autosuspend() in both
the probe error path and the remove callback and a missing
pm_runtime_put_noidle() in the probe error path. This consolidates
fixes from upstream commits 5ff4d5d1af0c and 5e8bb0cc72f1.

Patch 2 fixes a DMA channel leak: when spi_register_controller() fails,
the channel acquired via cqspi_request_mmap_dma() is never released.
A dedicated error label is added to release it before the runtime PM
teardown. This fix is one part of upstream commit f18c8cfa4f1a.

Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
Diogo Ivo (Schneider Electric) (2):
      spi: cadence-quadspi: fix runtime pm cleanup on probe failure/unbind
      spi: cadence-quadspi: release DMA channel on probe failure

 drivers/spi/spi-cadence-quadspi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)
---
base-commit: 7351870f56cba79097a2ab57e609469719ea4f73
change-id: 20260730-cqspi-pm_runtime-a8a1c6122944

Best regards,
--  
Diogo Ivo <diogo.ivo@bootlin.com>

