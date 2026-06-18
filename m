Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411333A716
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752430; cv=none; b=s7PNmJuclRR1GAfVrp/aqMRK51cEE1wsn28ETeMQxCYA/efE3MxXC9ZUjlpxEC8m0MaN///Jl26ZT+t1kWG+pPQvChsqEBqGEIyWmmYcbV47v/mKbyiHkMaZ8zfTa/0evWbpOwAAZF88VxaoWsg68TzKCsueG7L6+9Ga3QLEOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752430; c=relaxed/simple;
	bh=hEpLBSJWmIi2BGdQk8PNEPlr0dXVKHYKZdVMrSbYtOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grlWDVPiNehVWefgIbwOh1V1AzEa0GUUXNTy5/iIvSRZZXc8taU0U5erwaXrQXgI+wfN6JO/ERG0eS3hNmONPYjdJUQsPbLr3d4Xqn+rB2OiuCcaJ8SYNHUQh3zHvNZLTn7HtH4GIWqdTan1uV6TKQzxNamicHicrZR++HJOVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I8vX9Oni; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I8vX9Oni"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c88d4606ec8so234229a12.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781752429; x=1782357229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnAPP6DMQ7GwEGmMlCW71qkXAHg6fFaZ5ldwM/JO2oA=;
        b=I8vX9Oniwslzw2VTxdJixxaxQYNl+kc4oJFcXD7Q5O/oh7eRZTTfA8mfgRL/JFeAhX
         VdNFa60CdkjOq6MRoNpV43TOdn8QDNSOWpfMnOU0GTyrCKQv/OkCo7XBE74HjlIQU8R0
         7Z19u88h4VOrj7fPCydGsTnVQJ8vrLyVdoL7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752429; x=1782357229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnAPP6DMQ7GwEGmMlCW71qkXAHg6fFaZ5ldwM/JO2oA=;
        b=kgXc6mwFb8IAhFH6008g7+WsQpd3l3VYxGv42Id9JHql506B+/PXHC+2JhC47qvK94
         QeDZ2DJUfH7GIK52E/3KJplv0WrRvJx69Lu2VVPHu9aGcUTp/JDKp8W8JHHr0plLDpLo
         eew5saEe8V5WXpxX1yzL7w6MFu5+Fy9JwUOF3mjmXz7HDEvbCLeQCrp0COb528Mkb/BJ
         9e08AP/+tpaUn0BPVAq3f/YzO1cNrLS6BTFHeeshA/zjtoHFcPD4qqD1s9acqxBGmVhM
         1Ge2PVJgFu9mS6gpRUOmQVyukuYBZ+K0zdEWPoUnpanghYRf48EQnQQILH0YAZnE2KN8
         WI2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+N5qK1/Izc31SYQ/ITKRaS50vKsevALj10LJr5BNgYv487Gg4wTTBrW3+yTz+6pduECaY6Ls8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRRqm6cpDAULkhsyz06zVcdd++V7sHixz+Le3Wf5YK68vgJ6Q
	gfBlS3bLkYhVij66aSi1nU0Jmr8tVe/4WEKxVU6M/oMX4dFFnJL5j5fvEyLWrhSxRg==
X-Gm-Gg: AfdE7cmGR9FQdd+V7YT1VCSXpsW1lJUqh/D7UBQrQf02wbTRgUMcARZQrkFLXWEZitv
	jPMtsSSFsvP935s0ASctJYND4Klw7QzN3BqrBDUubvDeYUZiU6yKwl36W7OwxgEJrriH/3pb3za
	ZVW87qoODhzEvAvC2rEmghHA100NQwkYCg2ofl67dI5+oYlkR7TyAS9M9kPgEC9YERXkGndAsLI
	Q2oJbSGGl14yS/mAghT/DQPBCsiPZDlf9CYxLGTV8Zfh5F3WXTP/sbeb1N4ot6aCCKTKJ9FYstd
	box6a3X6US0rBzne7D1KFyWhMjxy0pouJV8qnkD6W/KbnwDwOGo8/JV5NHtYuzOc8FuN7TOGZem
	qb69XKXq2YQx0mzBqHupJokar8zrBVy9t8uywHmNesY9mlMYZdNKoqiv6DGmGmFUYWF/zWSC9oh
	TrycvI7NGSDFP4WpcIi+aGF+t5x4blmE+P0lEfw4zisCKp8CpFqTVhnWLl6ofx0rkRctX7LbaLw
	Cw=
X-Received: by 2002:a05:6a00:1896:b0:842:6a3b:60c9 with SMTP id d2e1a72fcca58-8453b214f5emr1655665b3a.24.1781752429085;
        Wed, 17 Jun 2026 20:13:49 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm17548232b3a.53.2026.06.17.20.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:13:48 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: btmtksdio: test for BUS IO errors in btmtksdio_txrx_work()
Date: Thu, 18 Jun 2026 12:13:21 +0900
Message-ID: <20260618031338.1011410-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
In-Reply-To: <20260618031338.1011410-1-senozhatsky@chromium.org>
References: <20260618031338.1011410-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btmtksdio_txrx_work() loop termination condition checks for
int_status being non-zero, however, this evaluates to true
even when sdio_readl() encounters BUS I/O error (in which
case int_status is 0xffffffff).  Break out of the loop if
sdio_readl() errors out.

Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/bluetooth/btmtksdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c6f80c419e90..d8c8d2857527 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -574,7 +574,9 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	txrx_timeout = jiffies + 5 * HZ;
 
 	do {
-		int_status = sdio_readl(bdev->func, MTK_REG_CHISR, NULL);
+		int_status = sdio_readl(bdev->func, MTK_REG_CHISR, &err);
+		if (err < 0 || int_status == 0xffffffff)
+			break;
 
 		/* Ack an interrupt as soon as possible before any operation on
 		 * hardware.
-- 
2.54.0.1189.g8c84645362-goog

