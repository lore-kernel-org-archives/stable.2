Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761590;
	b=fXcmOJBglbX9P5ZPqND5x6eJ/oX/462YIJZfaBUf9vLe+/h7UPomJ0S9bYCZawpd+tdV
	 CXE5e6AZZBm54V9DEjbg7jqaVQcRbvMR7I/q7uHI9IZOOVpCUKlspb8wUYoRCsANqUGTX
	 GmWVfhMEHCzyD2CQRkXJNCvZTZOfkaHTl+sfWLFMwqs0/FqVJ6Vtm2H25vpFEav06ojk2
	 UyJKhBMxOHxSefCf8GthvkXAB4Z0d3qe3SMEA0yHJkiTy5lMDcp/GLJH0LyQmRDHWeC+3
	 +RoI2TDbHYeCtKkxZflYRLTW3wdhcHacMfEOQiCRMgKmBiXPVCmwOZ3j6aAn5EH8OSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761590;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HHzMsJF9k+4VDbAqBeFrm1tYK+OTd3TiwEcV01FAU2Q=;
	b=1hgHOgO/gJO73a+jPSByrT5GajC/NLVUs5VIoM4WQ158IKhVhytlmzXanp8CQwu33H+E
	 bPn5OiPEf0CC/8vEWZ69S0rpI36nYsvcCtQSCX03zjyyNphPZ1wSD4khKbmGcyeknVu5K
	 /rIGNeb5LpnFrGFk5XUuLDPGTchFXGjub3VtY2b9RjjC+KzI81FycUxgPns15sRcE0Nv9
	 MFyuEeCdU28N1jD+WhmjsGGWTBzj7ak973N2Ptwzz4XFpB7eMvYik148N3SRtEIXJQ0Vn
	 e6JSAswJHSt8PgrN5KiW7A2jEPFzsAbMFkcV1WDdzOh2Rtw7PtqgauMnnSgdnzhmcLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=hzbNQsxN;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56769606A31B;
	Fri, 23 Oct 2026 13:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56769606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=hzbNQsxN
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id 22849197A3;
	Fri, 23 Oct 2026 18:19:47 +0500 (+05)
Received: from fedora (5cfcac1b.dynamic.mv.ru [92.252.172.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id 1716E18C5E;
	Fri, 23 Oct 2026 18:19:19 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 1716E18C5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1792761586; bh=HHzMsJF9k+4VDbAqBeFrm1tYK+OTd3TiwEcV01FAU2Q=;
	h=From:To:Cc:Subject:Date;
	b=hzbNQsxNPWeKZVw1AVxN7X4/T6UWnbisKdc5tGgmorz8wyqNvIOjw8kTAAvJjCueZ
	 DTNictk5sERsOzco/0fltSVrwZLOgXjm2rZKV6xLuw0t+0z9wdDwbcK+oA0NTWRWm7
	 AWyV75kxt6kslS2d04xrLxx3XaW55isZe4RrUPDkXD4QLDCJ9cHLih/cM41hoBBVD2
	 Ms++EvppuZDhWf8qJjUoGJCvE5Yj/CN8nh1xkg8WKnTTrn+d7mlvCM1BjFxbcVUhML
	 5w1o36LdNzacxTLTrIsd+x7R6jBZZ/olI1ksqE000k3R6TCJ2DzolbZPn0pO39eo3E
	 V5qEtsIATESXA==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] media: tegra-video: Check CSI subdev before error recovery
Date: Fri, 23 Oct 2026 17:18:50 +0400
Message-ID: <20261023131859.95819-1-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
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

tegra_channel_get_remote_csi_subdev() can return NULL when no remote
pad is found or the remote subdevice is not a Tegra CSI subdevice.
Passing NULL to tegra_csi_error_recover() would cause an invalid
memory access through to_csi_chan().

Check the lookup result before attempting CSI recovery. This keeps
the recovery path consistent with the helper's nullable return value
and allows VI recovery to complete without accessing an absent CSI
subdevice.

This defensive check addresses a potential invalid memory access
identified by source code analysis. No runtime failure has been
reproduced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1ebaeb09830f ("media: tegra-video: Add support for external sensor capture")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 drivers/staging/media/tegra-video/tegra210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/tegra-video/tegra210.c b/drivers/staging/media/tegra-video/tegra210.c
index a6606768fa03..82d054c9c34c 100644
--- a/drivers/staging/media/tegra-video/tegra210.c
+++ b/drivers/staging/media/tegra-video/tegra210.c
@@ -346,7 +346,8 @@ static void tegra_channel_capture_error_recover(struct tegra_vi_channel *chan,
 
 	/* recover CSI block */
 	subdev = tegra_channel_get_remote_csi_subdev(chan);
-	tegra_csi_error_recover(subdev);
+	if (subdev)
+		tegra_csi_error_recover(subdev);
 }
 
 static struct tegra_channel_buffer *
-- 
2.56.0


