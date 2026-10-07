Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DCB2F616A
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353448; cv=none; b=fDx5wq4unAvAktMPqA0xmxTetwtucdIitlIrPp9W16BFDu9Uc+/XLwrZp9Lgzetvh4k27g1RwmxCOwMt95abolehPfmhAbLO4J849t5l4pNaOyvQ5CmxWWv1qEnv15FQVmBW/vX/Z9lWCxAJJak+tN0sKlX9Bc6DSIcmIM84zf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353448; c=relaxed/simple;
	bh=qvgqGqBABNSIxmKh5CJXwp58Sk7ikYMFrfhKLj9fgdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB/ieLPi79JXOAor5e/6WPxQrud+KvGk+XvvdA3L4NbcPND1/P2FPJgfIdo+CxvvjMMUONJ75dV7AnQEM5Cuvf5rsXW/wdpHHMPra/ktq5O+6aG2xfo3h/Wq6FhQVNEX3t9C3P1MhFE6G9IUN7YA6IygCmVDi+eJZOv3wxLv9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGRCxxQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGRCxxQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2E11F0089B;
	Wed,  7 Oct 2026 06:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791353447;
	bh=m3yMEQCLBZJMbJ3sUZ8qvC2biuheCyU5b1GzOIWmrbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGRCxxQ2To1KdmdMqPiCSDvvfuXBINPhwVtCmp9l6uaVLc0SIAyZEY7GpmuIYLNMC
	 NPaGlr4+Ha3ofYTVjDyxQ6CKbD3Rkscu/lA0MsYvalXyCpnMhCvEsP+MMoLiwnJzYQ
	 JpisSB4aTe0YHhEKlLQXfXckaVtgPFd+kaO1+PqD59Cd9DHD9vVzVtr454qMwSKH8I
	 uZDSConpGqfQwU42hPcQxbcGKDxIwTW3CvSR0iIDIoNsRsBD5xRi5oKb6VRefMzSGo
	 RkZPtvvj+a/9O5xdlwqVPsTAggVbBzJvOpm8yz/AuTFoI6cR/RGlADKN4hccpCULFP
	 48N+2SoNzeK8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] units: Add HZ_PER_GHZ
Date: Wed,  7 Oct 2026 02:10:41 -0400
Message-ID: <20261007060913.1488382-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100606-wolf-obsessed-e5c2@gregkh>
References: <2026100606-wolf-obsessed-e5c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 5083dba0fde5446c00ee1a82a3911c8f88a2c72e ]

The is going to be a new user of the HZ_PER_GHZ definition besides
possibly existing ones. Add that one to the header.

While at it, split Hz and kHz groups of the multipliers for better
maintenance and readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260112134900.4142954-2-andriy.shevchenko@linux.intel.com
Stable-dep-of: d61521056420 ("iio: adc: ad4030: fix invalid oversampling_ratio validation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/units.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index 00e15de33eca2..0c296a004e897 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -25,9 +25,12 @@
 #define MICROHZ_PER_HZ		1000000UL
 #define MILLIHZ_PER_HZ		1000UL
 
+/* Hz based multipliers */
 #define HZ_PER_KHZ		1000UL
 #define HZ_PER_MHZ		1000000UL
+#define HZ_PER_GHZ		1000000000UL
 
+/* kHz based multipliers */
 #define KHZ_PER_MHZ		1000UL
 #define KHZ_PER_GHZ		1000000UL
 
-- 
2.53.0

