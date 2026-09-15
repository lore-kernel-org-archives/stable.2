Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810D23E342
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434010; cv=none; b=fo9WYdNb/Ak8e3VSL8SGcFjL8hs9J3IU1+ghGeFXqbN7kEJ4Ggxfv6mwTASdM5E6CbVKewv+4pCLyC/EfF5VBX8flk4w0ilp5F/MIQi+3SGWfxKaEMV5aBLENXSMvUws3yU+ACJ+ZExaqBjZvZsvtiYTHKmH77Dp9lii2eYhIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434010; c=relaxed/simple;
	bh=qlgJnVNJnJoSBLr05eULVqVezSxg7LvXVVWvg2QlTUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmkDbR34OxnNZ7SKzChw+ezGItGDm5u2o3r2fUU77KZciE4pcAF+7xpiYVMbIluSZXugPBfiZupfBkUchGijeAjsam1J34fQd5k1ajbNPoK53Nt8WgQGJXxjRpIwvLVRr7dKkI7aJg12yNFUUxUE6k3+5VKUhfonP3vFZEwzF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqcMNKxC; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqcMNKxC"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5306d609317so38062251cf.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789434008; x=1790038808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y4EOq0mriYCuSqS30PzcXKU3cp8OOqJ/M9Nu6QAqqPk=;
        b=RqcMNKxCn0U5dhNFHaOsM5me8NtmkMVOOruZx9BhY3AS0kTV6fv7V5CGt2ZWxY/sZq
         V8DNz30USFiIZIlP/q+FKBrLA5MebozEUz6NlXJCYJkyBmjqksXRMMZKsui+ud7vAPHS
         UPRPasW3fd6NeFVRoQkFPfp7CLdILEH7pHjjzkTqLXer+AyywcTRpzj5Ndgd3cjIsBMP
         s9TexaiszmOwkoLav9nRqNUOpRCqapzH9loAiXVOqF3UK6hSv5FDbHNPZVdYSnjHbNNF
         UWZAICBiV+CCFID9WK1OLyB8b6bY/5NGj7oCivvYk+lU4qawZDRx4GnYs47PJcCUJIfu
         FROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789434008; x=1790038808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y4EOq0mriYCuSqS30PzcXKU3cp8OOqJ/M9Nu6QAqqPk=;
        b=fytuq9I7Lqyzs+niADbTjHIehYyy6Ia6fBVlFcz9Ln+Ko/D7XP9rUOmXeEVTb8idhw
         7RKm1oxW2Ojgd3XdcWhlC3rmHQRgDMZ8dXqxI+iX1rWCiCxTsio1jx82uwrlWCwQ7+Sm
         tVG91ZSWelA2MDkO+R7FNYwtZIn0o5IhdI/Vbv6u1RdxijdkbKTzAqrLOnAOCcgLUF89
         zdSysdLW+lgiXfJQ7XlabTQS1jQMT+KDiFYhSyU+6J+Ntji7P+i68l/Wtmoree6KPYql
         ZCyDkFkxt0SytmV0DQqZMI3g55+wDNBO5WN4IVhywSzti0nRaK7xrC8j0UAeCYdD4lNk
         /Pog==
X-Forwarded-Encrypted: i=1; AKwUvBxt932IXcP7l7ld6gzcuLDAvp1kN5UAkKMGFyJLG2iS7z/m8yN9Ic5Qy+6v2Swz0+2EkRZcYMo=@vger.kernel.org
X-Gm-Message-State: AFuF++nX7yKyENqutVMz0uGv4WxNoPDwYOnntn6fEXaIcpRgEFQWeWcm
	mW4rCesJU5Hny7cwSi+jDTThvjLpaqgiMUcz5wB53E7J6QNb8tjqNXk=
X-Gm-Gg: AYBFou29F9/i88PcNieRGGAas5IOgCO7Z/BR4pFcCa28SSnLfvU5rzA45lIg4NXK+Y2
	J24WqtmDzw8QbqCGbhIcKRoxlQY6FE9p/eNPPNHdB7icfT0TC24+hurJdyJqAjapQrKct5zbznc
	NJ4K0fRVfrWzww5b+GeIbKtWQYmYwcwlWOERTkJzdCGCgU9SAO0NTsVZ4x+0gCH7Q4ndnnJfEFI
	p4YPKTiVvV31Ev+kauL4rHnSsz8OMoHKYvezHcqS5024MwDPdFvFOkfBqoyNLuMnZw56R6YVIXe
	sE9axH5xxhFu+dWp7jqXn/9hiaFbV2L0AVf7/f/uG22UJIl29+cTBFGhFvGdrrxz6NoZFqWyyYD
	/4E1TZ/bvy/dVxrN/qMtkAUgXYNic8QWnUHaO10cXD3R5u088U0negl+r8QdB7jH9MeGFb+q2Li
	6OGVCn320zL02DfvJH/hQV065Y+9KrjIr4qDtvWckNedTGV9FG8e6bjNZB9f2GlL+m7YEIRiqOr
	DQYkW2xmrM3hMC56T+xyDqNvynqjnXX7iYeitOzyY2wE7ibfOf2eeEvqYy5UF/5L4ouOAqJyAmC
	q51CCv4nk3GGRTXfltF8N3b//6+DFuaXcD4bX7qQ4f7KrbVNvPD4bvZyJ2SOyFUvfvlYont1wE2
	OX7f7
X-Received: by 2002:ac8:7c49:0:b0:51c:6b6:9d0b with SMTP id d75a77b69052e-5310cf168bfmr75785851cf.2.1789434007725;
        Mon, 14 Sep 2026 18:00:07 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53112de74a4sm22931071cf.14.2026.09.14.18.00.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:00:07 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] serial: icom: Disable the PCI device on final adapter release
Date: Mon, 14 Sep 2026 20:59:59 -0400
Message-ID: <20260915010000.52974-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

icom_probe() enables the PCI device, but the final adapter release
never disables it. Balance the enable after releasing the IRQ, mapping
and PCI regions, while the adapter's PCI device pointer is still valid.

The imbalance is already present in the initial Git import.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/serial/icom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1691,6 +1691,7 @@ static void icom_kref_release(struct kref *kref)
 	free_irq(icom_adapter->pci_dev->irq, (void *) icom_adapter);
 	iounmap(icom_adapter->base_addr);
 	pci_release_regions(icom_adapter->pci_dev);
+	pci_disable_device(icom_adapter->pci_dev);
 	icom_free_adapter(icom_adapter);
 }
 
