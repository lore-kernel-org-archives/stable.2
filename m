Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596063;
	b=2NCjpYZruJR+jDovU3T0IEEYcMIAOeNhoJvJcm2LesrbqW3OXLy4guYKJTSUoaNnx3NU
	 /IGdbBnlYwCirYtdDTojhHIxqY4hxfyxWpMTde3rl2a7cN27d05N6nlbcO9v7wPrjsAuw
	 bIAJyNpRs9A3MkBj/w2STceJ15w6QPwIGpg3WB6/mneuIbFXAeg2331Pa1aMUw1k2lvAv
	 CQwMa2v5DLo566VMlJD1/2+DT+gCQwvPtZJf2J+T3lXlOUyYoDsafzaBSuByN+YY1eV+F
	 bbD9+cR5X8NwelfUDVltmfHRQw2vgRQBVUGbyOELbAVK3AJ9zNDxa2mpwBpwazcKx5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596063;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vmgKLeyzP6wYjMeA/rCbtyx0g8MP8eL1cI8q9KS6PAo=;
	b=rUKCK7jrnYNTxJ3kcQL06ULS2OBwl9TnzXZM/1W4mujyGQTTGqDPY1666ZmZLQSA+dD8
	 FZ/VAHCXaAQEmqBUQeLk6Apdav/DBRZBFZYaM9kuKz/0fA7d6kQrXmF5KYjtyvjx4dK7X
	 AooQ37Vk4fI8jeq8AKvyzqvkPOOW+sczDrUF5+bWGri56NDtmQ03UQKpmOgA6pmqAIWyz
	 Yzufwp459ZoLB8LScnP0UsopfCiDiAd4JLyk5pSOwzzHd9IvaAr/wdFMba6oAN96zojE4
	 TxvT7cg9LvfLU6djNkPEmmQZ+Umi7HzYvT98TVX1d/8E9XZlwALqFYsyo2LbbyuPOBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OurqCYeq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC03606A332;
	Wed, 25 Nov 2026 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OurqCYeq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8651F000C4;
	Wed, 25 Nov 2026 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596062;
	bh=vmgKLeyzP6wYjMeA/rCbtyx0g8MP8eL1cI8q9KS6PAo=;
	h=From:To:Cc:Subject:Date;
	b=OurqCYeqH24EhUaFIkbGRxt4A5/s0R3WyRP5l/AEZsFKo4BmGGeusPS36kMdH/X6z
	 2VuioqFyhS4ie6BimFoXVj5G2GamKkMh6mSNCrE52yetxMCsgj5ZEn9KooTot2/CyQ
	 hSCFhPDMI9GlLxkwgB8fLJrnI1kHBvPlih+lTNrl3v6lJewysEU2EuG2ouOlnR30qI
	 dc96mYXe2c5+vekkpuVVYbd2eMg6mjJtnIKfDd4FCCRHD5iVjZ3pI0vjuHRsGf6Pf6
	 KMYV5JlMSkLSv4y45N1hnRBZo3oMuTQmcvPxNORpcE4i26Wr9djsHFVJfNDjEFn9yj
	 zqbFgr61Zmxdw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"Claude Opus 5.5" <noreply@anthropic.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] serial: rp2: remove ports on IRQ request failure in probe
Date: Wed, 25 Nov 2026 09:40:59 +0100
Message-ID: <20261125084059.84951-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.1
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

Since commit 016002848c82 ("serial: rp2: use 'request_firmware' instead
of 'request_firmware_nowait'"), rp2_probe() loads the firmware and
registers all the UART ports (via rp2_load_firmware()) before requesting
the IRQ. But if devm_request_irq() fails, probe just returns the error
and leaves the ports registered with the serial core.

rp2_remove() is not called for a failed probe, so the ports stay
registered, pointing to a card whose devm-managed memory (card->ports
included) and iomaps are freed. Any later access to the tty devices
then results in a use-after-free.

Call rp2_remove_ports() when the IRQ request fails.

Fixes: 016002848c82 ("serial: rp2: use 'request_firmware' instead of 'request_firmware_nowait'")
Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: <stable@vger.kernel.org>
---
 drivers/tty/serial/rp2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 158b06424b56..f82270bf7060 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -755,9 +755,9 @@ static int rp2_probe(struct pci_dev *pdev,
 	rc = devm_request_irq(&pdev->dev, pdev->irq, rp2_uart_interrupt,
 			      IRQF_SHARED, DRV_NAME, card);
 	if (rc)
-		return rc;
+		rp2_remove_ports(card);
 
-	return 0;
+	return rc;
 }
 
 static void rp2_remove(struct pci_dev *pdev)
-- 
2.56.1

