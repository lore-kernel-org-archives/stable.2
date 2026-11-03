Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719006;
	b=IqpTiLlApcxE3Zo04MgoEe5Q3rFNAb4cUjv/IIzGpVJDvt7FmjwUjWTGWXho/2EmyVhE
	 5/dBvelEfs6QjjoLUsTllC0ChbzaREkbYYFHFMFz93/Ngh7WktwLW6uQ8kmMOcAqsxiV6
	 UYz8Grltn2W3rigtgmViI0HGH00Lkf6ZtQ0sziw953HCRP4kRsZCTQDDnkFvm6cVB2kxi
	 W0Jp5qHYmyOg6TGRVgH3cZDNRLpU9qoS4ytRmsZNpXGm5i5EKEM7QnLVG5tNcpnOrTI33
	 ZWLBpor3K+0/42p8LSCKA4B3FtFisaEhcYNqGmisf+jKYEUauL1prkdOZYXh/rUHHuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j6RiekLq0vN6UW8fVixfiEQTJWd1Ssm8E3EPHrv9n3c=;
	b=Iyccx0M8v9T0czYtNzpHHUDccRKtYDpSZclpis66Z+YX/1BwxtwgOuJsmD5CZ+xI4S8A
	 3d76+9i3RzxeKAlV4apMT2DKCso2DKQACTiDXHwmwXKEH3PsHk8rTY3cIWZV0ckZ/bVfm
	 jVXoog2/Mwykc8o8fLlX8yk9z4PpLqn5FBukm3ryqkMNQtU5d+y98GIzLrlkiuelNEMeo
	 mUamcfi52Iq8bKg1dKjj/Fr4dcIZandf4YCC5KWnYtCrrIL+9tH2zN86ARhD2+Qk8Yki5
	 O1vF/JWjS9GAjKCjIGvDftyEZLQ8Picd9w/smfXmDuLXiokpy6LScYlFt7eO9xGeZIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOVGFpX9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8483F606A7BA
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOVGFpX9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7FE1F00A15;
	Tue,  3 Nov 2026 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719006;
	bh=j6RiekLq0vN6UW8fVixfiEQTJWd1Ssm8E3EPHrv9n3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hOVGFpX9nPcpycyE5PPNzB0ytmKy08UkwWhFp1M/UHfriC6D3PRPAx9MG/VDcka+m
	 N41nFnJt44CcTSl9IrA6OBg6EYaNkwFJy5kBfPAUcoWIJK5q3qXWoi0LiUaX92flTX
	 G1PLWzGUzsoDONv4vDQebZaI6p4i2aeUvQo9akPbm+fdIkziRG/Z90mFg2N6NSYUDX
	 5qoeFCYx0tRKDkZdPIa6hxwWcuqGUT9TLVfbD982srTJfdTolRe4ZAVopPNxW/kE2f
	 KlXMb+GwLB9qJmY9Cizx5w14GodHBhL5+KJ4mPcseIbQT39cgz/oTpPCJJOvgj89iZ
	 tCJSarG/HOAOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	"Daniel Thompson (RISCstar)" <danielt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] backlight: lm3630a: Cancel delayed work before destroying workqueue
Date: Tue,  3 Nov 2026 10:16:43 -0500
Message-ID: <20261103151629.233835-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103151629.233835-1-sashal@kernel.org>
References: <2026110359-varsity-prefix-2813@gregkh>
 <20261103151629.233835-1-sashal@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 2cf184caab8b406fdd9db126ee40d62418237456 ]

The interrupt handler queues delayed work to read the interrupt status.
After free_irq() stops the producer, this work can still be waiting on its
timer. destroy_workqueue() cannot drain delayed work that has not yet been
queued by its timer, so the timer can outlive both the workqueue and the
devm-allocated chip containing the work.

Cancel the delayed work synchronously after freeing the IRQ and before
destroying the workqueue. This also waits for any running status read to
finish before the chip's resources are released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Link: https://patch.msgid.link/20261003030439.599330-1-mhun512@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 1de26785c3032..3ee04acbc1d9d 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -593,6 +593,7 @@ static int lm3630a_remove(struct i2c_client *client)
 
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
+		cancel_delayed_work_sync(&pchip->work);
 		destroy_workqueue(pchip->irqthread);
 	}
 	return 0;
-- 
2.53.0

