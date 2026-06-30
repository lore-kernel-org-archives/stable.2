Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30A3E3C5A
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818168; cv=none; b=Qa8eoaf/Ip90VRQoCQfn/apwXi/7nsgK6m+I7xrdkBA8dwXzpPOYnCu6NMCEzw2S8KsmFa/Oaf1NpfAZonGH0Gd8pPmDJFBj0AVsFjkk3dF0K3ZVEn4JtAr5btj4rG0GAKPVUTJEW0g4UgQKAECkdzjcs5I3XIn67FIQY/tboPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818168; c=relaxed/simple;
	bh=s5LFEK1Pa253fBmuQHxQ2azSIMnGRrnpfip1MZDg1Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9jyfi9aWQ7AjVBkGKTXdeUk99pEe2RHYzj+mUusiqDGMdf/ykiTylj7lw3kDKCwKfea3MNseSoKtw35u45hgAWJkVridXpIFBp0/fZmyTquM5+Rk0iP/CKYIp6zjUg3Folpu8XycUdP0vN599y89MdTHZxYH968QO9ZEjIvX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9mMHZPy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9mMHZPy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-472326ca506so1410032f8f.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782818166; x=1783422966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvb8CfoUDD5Z1NJ95/7IaMiF39Bs5qAnQxdvVT+CaO8=;
        b=i9mMHZPya2f9QJKbyUWzyPY7ulChkJdJcUfrgfYneDxC1jC3EkSND831L6YgdN9MU9
         Xn9dGbrHUS+k32uNF/ynjJBq7aI/sQixR3CGInVMgryLCgM4xz5JmcE3jQyo0f0euGZ7
         Cm42bad/WG8UpzDAfLw2tUdSQu1ejHwK7K/M10A5XJyI8duwdC+HUfuACJWtCiwNvY/8
         oo3iK+F3OCJXpgxHfpxGajfGQRY3XoRsw3jMnmavnYS3CuYVaaM+7BqxU4nOdA50Ao2f
         jPL++CaFpKWRvvSdhdPPKZ0vrLILBYMFSNPhkBR93GQOpcf/u3/ElbpwkTk17cEhY5ng
         Upjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782818166; x=1783422966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvb8CfoUDD5Z1NJ95/7IaMiF39Bs5qAnQxdvVT+CaO8=;
        b=SDQ82rXWcXS+NAYZ3JoZGCUwwOAmRwWAUWo3gEz7TzwWm+JGD6wZuoeFzoTcS3Dajw
         wo2BeXoZP1+nu3DxKbXM+FWhSFMqARTJY2guVdJYKAwILWcS/gU1LhYz6DfUlopWHe5n
         vvqbf2OfwstTwETKcx5GNkyh8zMAugKHUriwsUStQozSs8WIzAkaAHLSj7IzCObMx0zE
         qjkDJZsQ+H58EHXWUhg93KlOVXnP0xtvrhSBLVwqIsd+tU/HHhGpQ6q1Pro7/9vKjHv+
         dlfeYshS8/lsC463BaHP3i9MpIMSGX0qgXwHJbCyHvZqalhb6G4R6fmrszxrH0C1CJJs
         NLXA==
X-Forwarded-Encrypted: i=1; AHgh+RoxLoiqjlju5/P98ic9qG2SSRJmIpKbdZRn8iJWHTX85nZq7w4vTgLFcOiSBid8scAYpxRbF04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IMiECXXPECViy2Or4QWw2wYXXspV/B9jPRSJHN94kPaIxkbK
	IquiiVdbbgbehWH1vpltMJAUfF3DX3ZvxA3CoRxfhun2CJHzcTAS5oYE
X-Gm-Gg: AfdE7cl+lturG0Fd2QadBCAJ/5AYNqkX/oSeLRg+HD2sourjyfNKeBj144uyxPGw9OF
	TQipcER6h9foQHNfYWva13Tv3WfuGPnhlvgoJTNvyUXqzIwACHo0CfDgr7cFHiYyEGVYsM65CGE
	9JEQVuXkZHV0CQCtKGVNzHWf8W2WS5bo7CHJhK9qi6CRhB4FljZNPU2vW/E03njlKUn76d16LS7
	Fn/QEnGwE0SN/LQFA43q8aqzen4L8Kbmx340CzmiYKqQwWhDcynP3DxZx91noQCKxw4pgWcibYi
	Fn/dypNiCZ86zVLANpQobnKuaxV7WRYy5rQXohVmhBdL1RMQIpLDLOUXLo2Zhz1uksdd3KRYUV6
	fI25xWO9xhwKSM+/mr80LhMDWIOmXnpsyL9NdsFixnzjWwOSsB0Hp0K2u2N8K9HG6msbuT/hAFa
	lx8mGWUF81QasJO0m0QWFfsqFeUBukK/yKUl9+WHNEZnsnlwl1BHXgZMM=
X-Received: by 2002:a05:6000:2884:b0:461:a5d3:915a with SMTP id ffacd0b85a97d-475507dde46mr4416732f8f.6.1782818165524;
        Tue, 30 Jun 2026 04:16:05 -0700 (PDT)
Received: from tolga-Legion-5-15AKP10.local ([78.188.87.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm6263329f8f.19.2026.06.30.04.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:16:05 -0700 (PDT)
From: coredumpdev <muzaffertolgayakar@gmail.com>
To: ali.sabri@zetasavunma.com
Cc: Xu Rao <raoxu@uniontech.com>,
	stable@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: gscps2 - advance receive buffer write index
Date: Tue, 30 Jun 2026 14:15:52 +0300
Message-ID: <20260630111552.9612-1-muzaffertolgayakar@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Rao <raoxu@uniontech.com>

Commit 44f920069911 ("Input: gscps2 - use guard notation when
acquiring spinlock") moved the receive loop into gscps2_read_data()
and gscps2_report_data().

While moving the code, it preserved the writes to
buffer[ps2port->append], but omitted the following producer index
update from the original loop:

	ps2port->append = (ps2port->append + 1) & BUFFER_SIZE;

As a result, append never advances. Since gscps2_report_data() only
reports bytes while act != append, the receive buffer always appears
empty and no keyboard or mouse data reaches the serio core.

Restore the omitted index update.

Fixes: 44f920069911 ("Input: gscps2 - use guard notation when acquiring spinlock")
Cc: stable@vger.kernel.org # 6.13+
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/460B5655BA580C60+20260624094739.850306-1-raoxu@uniontech.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/gscps2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 22b2f57fd91f..bf9b993f5733 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -219,6 +219,7 @@ static void gscps2_read_data(struct gscps2port *ps2port)
 		ps2port->buffer[ps2port->append].str = status;
 		ps2port->buffer[ps2port->append].data =
 				gscps2_readb_input(ps2port->addr);
+		ps2port->append = (ps2port->append + 1) & BUFFER_SIZE;
 	} while (true);
 }
 
-- 
2.53.0

