Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A743D51D
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514704; cv=none; b=FRElarduoQVGqqNNqo3uykTFYxnON1/qoKMLGSXl0CB0rnYAL9OgXGilF1sXXNzRgZg/RT1OzllN4iYIl1EpyGrnuSkjMZxVsxQkeCEyGKLYJlUj8mufdqf5WRbN/aehD8l1qoVzPl0/YQrCCxZGxYpmXjFczUND1or4QC736BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514704; c=relaxed/simple;
	bh=YOAC5Iz8b4Wfr8gFSlts5gUsGsYV93JUg+dXPJSubq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHe4Y+DqlFZ1mHqhOxeIh6JJ0dzZUDXBUSZ/M0MJKzONirvTgBsjPoEwYujewoN18enOHMwDv3EG7UVA0GXN0gNAH4w4cQwpgEoHfZ9RLZoDlUJOo7SKe6drj677B8nYOf/uelj/j3Ngw3jk7De/9IJMQOP/ozOIKQ0p8ptgwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sX1a0SK0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sX1a0SK0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84847482584so737921b3a.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514702; x=1786119502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EkiEIruiRSk3N9UIDQ+4txiR4UPtQnB+oM9OYfyxLPI=;
        b=sX1a0SK0Ddf1AB5GeYJVJTuMJ6cuSQSwFc8i2AOuXuLkYEHQas6DGP0PqU+X2G7EiM
         tzFqT5Ozs7EkEa0v4vDCTV3qcXFfZO2ERc5rZ+oaU6pQPLnoXa3YP5YU1eEEF4ocmx78
         I48pF0bNI2EqWcdGpDcLbpO/rS3uVeUytAAF4zch6IX0YyYuhDEABw/s+/DXU1gWvoj4
         8kTJYcYI87FVzjV89JpLGu53sIpqORGq0Nmt1dj5EMLXn++0de+/z757mv2K0N6xDOpu
         iTE9LKCu9zUwJdJbQnR/D2X7hDjUrrE0JuDtFN0W0WzdcyWlazzCmjBgKAJd4wvnLrFf
         +bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514702; x=1786119502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EkiEIruiRSk3N9UIDQ+4txiR4UPtQnB+oM9OYfyxLPI=;
        b=Qz9cen8hDMk+EdewBsVM1sQwbzLEkRydMSkEMIF9XuFop5MgWveZfvw9mpSrB05sI2
         pN++llDjFh0c/lZ125vBOGQwCLv5IdOUXUm7WBMewSGKlRQ/fhqVHZbWCj8yFotDPIs9
         SlDsY0d5d22NvqscfgbF3aMjodFm0euqxWqgLuKnFiHSRXVlBo6tWtXCRyK6dRbnM3wr
         dKKxvUvdmZqG9JRlm6sdPXt1nxRdfwr+YAupWfDO3Mr/OFxuQfWs1oJ8sfICw5uTqz3H
         aQu8u/JiWpuxdDB5KAV51BA+DdY95efhg9DKLEQ3aU6U8XUl6GrTjiZSMMIsd+qbUmii
         andQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKgst8SRpbby/dSbqc5GwWlIPhUbp2poBCB7xLWLpZaE07yxICqfALQ/OFBgkgZsONs+NN6tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+AlCx7ETak48oq99rshUDedUhtl7RjehKT+UgAodDexSMSPn
	Tt67w3sBK1x/76Aop2biw0PnO4VqHG9LuGK44lY2Jt9/rNMKBjtLzL8=
X-Gm-Gg: AR+sD13JlASsF5MECpx3WP1S7Osv23kwlYRIzCR3Q4pGE71PVW8R42THdPurwBzUEik
	PokLSBa3BJQrOKcTxgvwjcXhSjDa+IAQtq4QVDKVj6po11fcSG6vFtluqqHIt4qL4odjXswhBHp
	SepvVa+s0c5qenszG9cspMWbGiWOmBGq3w66o1LXYrpKMpmR9SRcrx6sgaR7Rg9ttGl0Afj99AZ
	QWVPRfhjjEo6q0AB6Q7v8Y6mmZvLAE6bcz2QV//FhwFm8ZNg/M7wJBlgzc//0qoayFXwiFdWVBg
	ivKtmNJlWKOE+p2dz/wqBk13RV/Msd7rrK2CTscvWrBlRdZtugimvrdO9mvO961RLSf9UOni7GB
	Cq20YmZcdGKNFAhBmlP7W0SQ1Z3TYmGzopr/Cs1Cw7UlSIwVZ32KSQpy3n8QP3c0A8ikDQO9Srv
	eSV/NIJTHxq+++L54+yWy/z/dti6woQl6/EUUQ3cFS6YG1wEarDb+dk9zh86n04tGztm1ttIKo+
	ubnpHtcj3cvPvkIC22NPZw5z+PK4qDuifbv+VLo3hspoxbX0WhHhjkeGsNFx7JGod8BzUHKXDeP
	gLOF3RWuIZLljf+UbTVkxA4=
X-Received: by 2002:a05:6a00:2d9c:b0:848:4ee6:4d0 with SMTP id d2e1a72fcca58-84ed7483c02mr2063804b3a.23.1785514702344;
        Fri, 31 Jul 2026 09:18:22 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29e6f0sm647072b3a.39.2026.07.31.09.18.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 09:18:21 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 2/2] tty: moxa: use pcim_enable_device()
Date: Sat,  1 Aug 2026 01:18:09 +0900
Message-ID: <20260731161809.45066-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260731161809.45066-1-mhun512@gmail.com>
References: <20260731161809.45066-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

moxa_pci_probe() enables the PCI device with pci_enable_device(), but
its failure paths and remove callback do not disable it. Repeated bind
and unbind cycles can therefore leave the PCI enable count unbalanced.

Use pcim_enable_device() so the PCI core automatically disables the
device when probe fails or the driver detaches. Keep the existing
explicit BAR request and mapping cleanup unchanged.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/moxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 680b2dd65462..02220ecf3b38 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1063,7 +1063,7 @@ static int moxa_pci_probe(struct pci_dev *pdev,
 	int board_type = ent->driver_data;
 	int retval;
 
-	retval = pci_enable_device(pdev);
+	retval = pcim_enable_device(pdev);
 	if (retval) {
 		dev_err(&pdev->dev, "can't enable pci device\n");
 		goto err;
-- 
2.47.1
