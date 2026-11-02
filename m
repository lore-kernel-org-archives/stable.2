Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608230;
	b=k41atQdWC74CFCbjsshr0K2POOvMqScTVLqW3WoIoy38nIFdGiRpc0ZCvbFYqxIGUpMB
	 Yb3hSiP6PmHJBA7+Z1eDCXApOJKn7f51NNUbH/Nxq04gvrwD2EddNSzzV021vSy3cHlji
	 ra4Di1Wt6ObhT838UbPwKkXEWg7YEbJwHAgykP2SV/xFl+UILmDbPyNv1umWvMsFo3RNM
	 PMbcY1D2OGNnXihUwSbpUzzWM7U5TM1/jMP/Gil2qjDq48Butb5A2YAso0vYHcT3/thnY
	 ZpSJRc/XKK7X0k34pEve/irgSHR/zoqTs/Tc2+FUqD78BM5+UbVvoC12NKElqfHD4iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608230;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QdPaChMlUp6IQ0Gocdr8F1FO5YD2Pdt9AJOtZr6iK+k=;
	b=nx+7FMudVQQDpgJAskdEyH4vIIDRmaxezcSpI8hgdUDjsHaz3XZrlmh2ENgmLZt/puLK
	 gNhDIJ+3d4XcJEjpmHMkBC4+gmQGwVQM9D1GZZ3xTxIFT+SoiAolkCGnO1jIZ8Ze5RDjH
	 SE5VpfbjTTSsaPDZbSEAmUBHdyCdUGgqKBLUU7YrWvp2Zx0n1xxBlF8dyaF9fDue3nEZZ
	 B0O5CdOMHXnaI/CvQB38jl8pwCZ37rDxLkq9ChcOyfTT/0qpjpAzeQD1BUhsj+aMsEgVT
	 ids8XRixQ95aNESVrd4DqGr6O8rxdAMmxAdXNPaZARzSWZ6r9nKjnWrbkxqxxI5+glw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2oFU+16;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC6C606A324;
	Mon,  2 Nov 2026 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2oFU+16
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C7E1F00919;
	Mon,  2 Nov 2026 08:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608229;
	bh=QdPaChMlUp6IQ0Gocdr8F1FO5YD2Pdt9AJOtZr6iK+k=;
	h=From:To:Cc:Subject:Date;
	b=U2oFU+16sVrzpCiLXIT4IUExffomnzmwDBQawGz6EI2p/0AzIhhXqG+U7NdJcaikm
	 Is8MgtubVoWsCrc/KhxTLUUBH1HXJlsVSr3skIHmNqoD9BHUrzVfnje23x2/6tOrFO
	 imCLCyNav+3/Jt/jRbkfk3AYaTJ/0fBKBL/Vo9GVDpVGlGTMNvaJpjFHQdZG5RS5VG
	 ubzYRJbAyRyseoHdjsjf34Kzw6KlDDSiDV/lkNk7AtrpBft57QTaKbc19XM1L09Ldd
	 bRKhGc16fn1kLjsRKasCi2khnb3Jz20NtMm6V9z6EUCabc7AdIQLOTLCyYuD9DY+0T
	 qyFl9rOYDVWwg==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xNnQx-00000005Lpt-3Ywv;
	Mon, 02 Nov 2026 09:30:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Won Chung <wonchung@google.com>
Subject: [PATCH] driver core: fix memory leak in physical location error path
Date: Mon,  2 Nov 2026 09:30:18 +0100
Message-ID: <20261102083018.1275566-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
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

Make sure to free the physical location memory also in the unlikely
event that creating its sysfs attributes fails during probe.

Fixes: 6423d2951087 ("driver core: Add sysfs support for physical location of a device")
Closes: https://sashiko.dev/#/bug/linux-b178c32c-f23b-48fd-9463-70f321f2d91e
Cc: stable@vger.kernel.org	# 5.19
Cc: Won Chung <wonchung@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index cbe05197d4a0..bf97b06337a1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3011,12 +3011,13 @@ static int device_add_attrs(struct device *dev)
 		error = device_add_group(dev,
 			&dev_attr_physical_location_group);
 		if (error)
-			goto err_remove_dev_removable;
+			goto err_free_physical_location;
 	}
 
 	return 0;
 
- err_remove_dev_removable:
+ err_free_physical_location:
+	kfree(dev->physical_location);
 	device_remove_file(dev, &dev_attr_removable);
  err_remove_dev_waiting_for_supplier:
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
-- 
2.55.0

