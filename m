Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142F480DC6
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581306; cv=none; b=axX99aI5O6qXor1f9biVZbEcQAxdZ323arPMHmj4/e7F6GBFmilEN7mE5rXFfcgXNR8AxPU2QdxWlNAJ3c70mZzkz07tSCoaQCRQ/+5v2mCTZ2uYT02+OCBWWESUvmOXFuYGe8o0VIQTpVl4Rp3+ai2Wmw6tVZg81NormumbVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581306; c=relaxed/simple;
	bh=ahwY0mo7nj38JbvOSS27DVdv7w503GVt/q5wtKMtv9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6dP11DIvjOEveaBQpZDp8CfRhpo+6IjvKt/I5wqs/KbEXAru5I9eTz0sQEAADcGEF8IoOQTkYn0QkJbH4j+LK4YHjLwJ/PTu++dRrUHWiPxR0VZ7MJScIzbBO0Ke5ZcUzPNpUGLuT1nXXy5r0pPyUqu7ACfiiYHK433ms7Ny2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB8nLwZG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB8nLwZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288BA1F00893;
	Thu,  4 Jun 2026 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581304;
	bh=mLEf8AF3GUQqFeTecbf8z690NrO+UZIWTLct2P4pf4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BB8nLwZGsfW2lkf0+wrLsgnv2i/W0Ka3O+EOrARlL4FKgbnnflXsTxl8ns3taEOEn
	 tuz1BArIJXLrCptlHo0Ki+Vji4FWgKdEf4K8/I6NAHet8F3F4uwj1VHmiUZR2dVVup
	 VlE/4Gam967KsVjJLn0Fu/qzy6YJN9Yr0Q5evwXDszMWNJEvMJw3QlskAgwNCY2EFk
	 Iseg5vEt3u8BEo/HomXMNr898X5NZa5MyeDxNtAc0+zkikxNn8pr5OzYqe4hpQMgUg
	 Rur9PWkWnovcRb0AprxKxLrQuqv134C0XE25olExO4IvXXpMH/as6qS5oLU9O53Nz5
	 oEGztC33klKlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] USB: serial: cypress_m8: fix memory corruption with small endpoint
Date: Thu,  4 Jun 2026 09:55:02 -0400
Message-ID: <20260604135502.3494174-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060436-tubby-pancreas-41ef@gregkh>
References: <2026060436-tubby-pancreas-41ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit e1a9d791fd66ab2431b9e6f6f835823809869047 ]

Make sure that the interrupt-out endpoint max packet size is at least
eight bytes to avoid user-controlled slab corruption or NULL-pointer
dereference should a malicious device report a smaller size.

Fixes: 3416eaa1f8f8 ("USB: cypress_m8: Packet format is separate from characteristic size")
Cc: stable@vger.kernel.org	# 2.6.26
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/cypress_m8.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index e29569d65991b3..53f27dee35e6bc 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -445,6 +445,14 @@ static int cypress_generic_port_probe(struct usb_serial_port *port)
 		return -ENODEV;
 	}
 
+	/*
+	 * The buffer must be large enough for the one or two-byte header (and
+	 * following data), but assume anything smaller than eight bytes is
+	 * broken.
+	 */
+	if (port->interrupt_out_size < 8)
+		return -EINVAL;
+
 	priv = kzalloc(sizeof(struct cypress_private), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.53.0

