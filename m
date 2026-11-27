Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793548;
	b=JQY1b9EYvz1LeG3Pzo21J4NY1q07kgyHX6BvuBgXxJ2B2ixQHT/YbT027fzECMzZ/jtI
	 zxekAIYcAGsmlsI8/awRNlqk9myr3+b6N4Jkk4z2tti+S4xmJEfi++ZSShZcIEkgRF6Fk
	 UdsBKNW3k/mWMxg4tqnl+mVqXm2BWKiqvJ/rLj5yteroDbAnxxBreaTeJ1EcPExBvUg1N
	 aF2JOtSVT7e8zW5+cPKDVYIIrtSEhMtALOhKHcf0DGvtEbHhBqHq3GMcOU2+ICB6fxNoy
	 tC0er8shCe82Rl03s4DkIQzuXK5ml08VdpD8fKS1SnuIeVBHe/20hqkWLodMsS9Ntjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ReJpU7l2I7/goLcuKAs//JuOo5i7inhbve69UWfTunU=;
	b=Xu9nR3FdJGDb7DGl0L/sm+cyWKKAWJL8qFtCGc83f1U8B2JJBieZShHoYMCgFTZmErMQ
	 Z5tZEvYcu4M1l9seBvCN0tc8mRB0/dXMxI2OdQODtOQ92FGdnFkOtMhXR8bigeNgFdGpT
	 /soIRCC6/WEqFOxPTzZqW95vT4/Q717mlPxNQgXXS1zyjCh/f3TUOBoHkuyUEWZniYABA
	 Bpeh8BFMVqwkpZVC7Mon4n0q/UlfymJYMhyBNhhnKKqMbPrglrsj8SHlpGdZ36e/FDPaN
	 n23loZEx0T1QDqvASz+tmhXvRaQF5qcZAE2d/RBQ7EfwQb6lPmU9fQGfy/uPM9JgsWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gO1ExOJe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F9606A330;
	Fri, 27 Nov 2026 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gO1ExOJe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F271F0089B;
	Fri, 27 Nov 2026 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793547;
	bh=ReJpU7l2I7/goLcuKAs//JuOo5i7inhbve69UWfTunU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gO1ExOJembFManR2Y5GIYaNorzfLn9fadBJ57aopK8Awur6RLUyrrF0DYL+moFgMm
	 ZwsEBbgMBuxrAym/c2LFFpOtFCejvPi76YfsfyuEb7fGbNAIon8CFYLFEvVfRYvd28
	 QF5MVIiq7mIaQgSRR77u/Gtndn0XvpPUjNRru7pkb/ZpyektSuEPI1YHat2v60Nkvt
	 G1hpfCGetf4tFK0i7ZtrAErVHmaC2hBlEM/ODIjDS2iR12A3KWy+riN9QK3aH6Xt8F
	 lRt2XoULTjriU3F4K9GK7JzTM2N9zXzivFKQMx36MfTZGf8XJCDGCJzSFuvoo5IffE
	 ktRuYU8rHqh7w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 03/10] spi: ch341: Limit transfers to the hardware packet size
Date: Fri, 27 Nov 2026 15:31:06 +0000
Message-ID: <20261127153158.2969573-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127153158.2969573-1-lee@kernel.org>
References: <20261127153158.2969573-1-lee@kernel.org>
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

ch341_transfer_one() clamps each transfer to CH341_PACKET_LENGTH bytes,
of which the first is the command byte, so at most 31 data bytes are
moved.  It nevertheless reports success for the whole transfer.

The driver does not provide a max_transfer_size() callback, so the SPI
core never splits longer transfers.  The remainder of the data is
silently dropped, and on the receive side the caller sees whatever was
already in its buffer.  For spidev this means stale or uninitialised
kernel heap from its bounce buffer is copied out to user space.

Report the real limit through max_transfer_size() so that the SPI core
splits long transfers into chunks the hardware can handle.

Fixes: 8846739f52af ("spi: add ch341a usb2spi driver")
Closes: https://sashiko.dev/#/bug/linux-a21e23dc-14b5-4ed1-bfba-f508132e11a0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Rebase onto spi/for-next; no functional changes.

 drivers/spi/spi-ch341.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index 56a5caa5975a..0783a2d39a61 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -63,6 +63,11 @@ static void ch341_set_cs(struct spi_device *spi, bool is_high)
 			"error sending USB message for setting CS (%d)\n", err);
 }
 
+static size_t ch341_max_transfer_size(struct spi_device *spi)
+{
+	return CH341_PACKET_LENGTH - 1;
+}
+
 static int ch341_transfer_one(struct spi_controller *host,
 			      struct spi_device *spi,
 			      struct spi_transfer *trans)
@@ -187,6 +192,7 @@ static int ch341_probe(struct usb_interface *intf,
 	ctrl->bus_num = -1;
 	ctrl->mode_bits = SPI_CPHA;
 	ctrl->transfer_one = ch341_transfer_one;
+	ctrl->max_transfer_size = ch341_max_transfer_size;
 	ctrl->set_cs = ch341_set_cs;
 	ctrl->auto_runtime_pm = false;
 	/*
-- 
2.56.1.839.g22a8290db9-goog

