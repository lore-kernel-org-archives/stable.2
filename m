Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313937;
	b=igJ/u7L41jHBfOzg9uVPKzxXPM1wTDXsHa/PmJgYd3f02jlUd9iCDtYs01vlivvp0TGM
	 HvMAtJq7piFehrLWxzmf+JnMPy9dJoaBUO3COOZu1VMusEeSoFYyWU8oW8sxgNc45nobu
	 d59UfXJUjq76uWe+egPCaYc5sYvgd7WwFV7usXUfl0UDHB41vnYP71ZQodE7gLbN1G/HT
	 YMbDHWaCM2GPzSieAq+auXjQaEvVpzBO7ejse115k9E4IlBLf13ehOhfuy3QPQMx8ZPTt
	 u+y/Sjkwk6+PURjtyH2hpEgkr7lTyQvOFYo3syvEfsyK/CZs+QKcgXwIiCzw7lIs6Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313937;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/LIFUmRWOgeojAKU9Tf6TirygZEBxf+aEcSEfeZSBJo=;
	b=GkBXNTjeV1Q1Ng2D4n72xdjMkLqWaIdEQ5XIHv0/45VGJvCmyibM4FJwtGC4NleIvKy9
	 Zis4T/WJmRp8uCY8f1NsFxvFQWrrKeQ3NjsDI+DSrghcNH6fr+kLX16/7FVAcFYBjm3gt
	 3OXhOEYU6ozF/uGYTEzzEjVrwjoLpP4C0o0bohhk/qVLxgpmX96hEHC/oi5cHFqA+n6DN
	 Ik4FS/6QKUt62wSg431ZKcwXzjmvkJivOHRQmBaPQuxHoFbfgJpggE1xNUw9T3t98drSL
	 VaUVoHUFatnd8esnCp1PE6+R6bHssVnTxuv1qvgIKtCEt5gpHxUX6pI4k1OLlSYnnWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBEHGf9D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2A0606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBEHGf9D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1658F1F0089F;
	Tue, 10 Nov 2026 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313936;
	bh=/LIFUmRWOgeojAKU9Tf6TirygZEBxf+aEcSEfeZSBJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nBEHGf9DW/ZgxUHHevGFzIsGoyKDlwwN+YDPvjIsYew9BUvr4Tka/qTDA2aXt48HG
	 yJ8Ab2ppw9RXJL0Y4EJS5lG0LrGXClw9iUIEbGFlp14iSlRadRn6/W1XbGBFZ3tgk6
	 JwAzCaTCH8eCXg+sFLUpSkzafWZqQMxyOvULtpE11FxfWdsP3//I+pUQRU0mg4iAL/
	 SYP94sxJhWjGnb1FRFkavQSU5AMwkIduhjqVuAfUQwoT1dKiScdbQH5eDiUyLkkh7g
	 OOt491ly3GPG9jevuYDK5/QFRVzVp4wpv98Euvt2yUHkUHRcO33pyalJZMSzFhJAGC
	 88gBMAsDWsObA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Dipen Patel <dipenp@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hte: tegra194-test: shut down timer before GPIO release
Date: Tue, 10 Nov 2026 07:32:14 -0500
Message-ID: <20261110123148.1282765-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054137-failed-6.1-30167fadbf87@kernel.org>
References: <20261107054137-failed-6.1-30167fadbf87@kernel.org>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 30167fadbf87fa901a2fee49c30a5c5a506a43e8 ]

tegra_hte_test_remove() releases GPIO descriptors before stopping
hte.timer. gpio_timer_cb() accesses hte.gpio_out and rearms the timer, so
a callback concurrent with remove can use a released descriptor and rearm
after teardown.

Shut down the timer before releasing the GPIO descriptors.
timer_shutdown_sync() waits for a running callback and prevents it from
being rearmed.

Fixes: 9a75a7cd03c9 ("hte: Add Tegra HTE test driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Dipen Patel <dipenp@nvidia.com>
Signed-off-by: Dipen Patel <dipenp@nvidia.com>
[ sashal: adjusted context around del_timer_sync() in the int-returning remove callback ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hte/hte-tegra194-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index 60f0ef2cb324f..d15f358aa4e4b 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -219,10 +219,10 @@ static int tegra_hte_test_remove(struct platform_device *pdev)
 {
 	(void)pdev;
 
+	timer_shutdown_sync(&hte.timer);
 	free_irq(hte.gpio_in_irq, &hte);
 	gpiod_put(hte.gpio_in);
 	gpiod_put(hte.gpio_out);
-	del_timer_sync(&hte.timer);
 
 	return 0;
 }
-- 
2.53.0

