Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773977;
	b=rjHCdLawdMz7o6iswTeoLhZm7jJTwbybsA9+z2Lb4QU91IsIajcccQCUTH84gwmHrzre
	 mEqprol8LbrCP/RWNyx2BWwWhWNq2wu2sA94V/BiFVYDHs2yBEENDn6nWOpBY/O6+9prv
	 ImCSK4VqeNKpyabLXzlIJOsbrYf6ae51HJLMKk/WqgqyonQrjA/mmoRSGfYP8IlDNdf5c
	 516rA4fazdVa2AT+CPhI4/+GfguMRouRnAkpICtrpmq0Nei6nNrFkcWhfxQ5hISVDPfxx
	 FhrQLAsvIzL6h1eRrd+EvOlcyLgMLEUz+ShWCDV+UdKbxSBqBZFf9Vn4kwqMmpFZ0Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3aaNxA+Y80f5W2oIEWGHyfzyjcTvu4C9UEPW1tV6LQE=;
	b=ZldKr6npNgpbkGI4a5rUKWGcC4v79Xh8tHE0uynBeJcIvCS2fwEQlwiMrxa9/3F5Zj/v
	 OAZERSJXDssjOZb6Sa6KldBL/B8WnTt93u8BoEWx28jthhPNInO4W67Kqs2CrTARpi1Ac
	 kpNWyptMjyF70usoRWes7wKoxGtmp9kk6N/nKcOoH5el7/2mmjWzJbz91cUtHKcL0pgzB
	 AxyAbsMeW3dn+Vam7nxW9z2M/cLtGoiK8Vgpo4BlYa3K7eR0o1Vunv4/+ndcUkqnalmjc
	 WXmiMP4IXldIOK8asZ2lwu3H1IlEMkJwE5FJcOu5jJ0AfVZYCHORXIoa/TDGieRh2/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ox44oH8m;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5332606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 06:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5332606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ox44oH8m
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so279537a91.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 22:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773976; x=1794378776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aaNxA+Y80f5W2oIEWGHyfzyjcTvu4C9UEPW1tV6LQE=;
        b=ox44oH8mr058i0miWerj3EmnZjHQtouQjtG/I2FLwO27N5lEpBV2MNi850DLMHzvoh
         Ln0uwPXCoEHhGW/db4tWmAa4FhQUaMg7WLyM0JzW11IfELPrvxa5gg81vYXHNSw93ZuV
         3NmrD5TyL/i1ptZ5Jc3/4eBx4Y7szq+jeDndIMTkhdwMn6OYVdc76+U8N6d35QOMgRqW
         ZgF8lZGyb3ObO/eMf91JRd/9b6Dlmxx2Mqc1A9I+Xy9qeVSrSYYlZduxkeX0WckNrOYu
         DwS0bTgNbjNcRJWONoT089aJcBL414fGZOwTwncYVr6MDVyj3FooJGV82E++YrV57lHM
         a3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773976; x=1794378776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3aaNxA+Y80f5W2oIEWGHyfzyjcTvu4C9UEPW1tV6LQE=;
        b=Sm3pVlgbTXLTM7EzmHSZ5cP38b+PplF/gJ61/d9fe7qu5lhv3j6Go4LrCS4Q9uaE79
         8LYhLxN03yyxi9p4gC5jFJmGrNdJD9ZXfUWIYgDbBOzljBQqTjyU2r/Y7Db10WcP+1q6
         YKSRDn9sAE0SxliiIRIM3/0ONmugsmY4kCeU5mzWrkSPkMkmOz/g6KpX5AB9wXPWnWPw
         5dRtcqGHxiFC139bPIn6PC1KFmWW8tLSw+/wOt16J8tSIq29AZ8rTln/k8ttEW1vbque
         NdgEmHxTtuWzZH2r7LYL4YwlgSHgc5UqqD0PRxC2RTUS3Dt7pqlifK+5KZDwe2z4mfp4
         kHNw==
X-Forwarded-Encrypted: i=1; AKwUvByVE8qSgxDvcRjkXe4HGrJ3YmpoDmd7N8Z1W2J6+FINM0XMGJBZXycocmZDgpJ0ng9IoC51KxE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+t8I8mfKvzl/txrL5szOiP8qvaqay1mD79CyNkJNvtovxHaGe/
	webmR9qT3xDjS9r9I0slL4LsIhk06tj+sLnm4KKwUGOYaBlHOMHBZp8S
X-Gm-Gg: AYBFou2DKb573D0vJ2H8LXEkCtE5CXlyVVW6GGK7idVvmE3n7LvSE8c1dHvEehIubvx
	/2tiwPwP8e5Z7Xka9BqrTRWuexp8ixelh2WDxeyyT3X9mIyG1sZqu0qY6JGNIJF3QT2VXPj/Zqj
	TzMZhDOI0uiNOZZul4d7ka4LkVSe8lnQj1QJkL+JdBGMF0m/3n9e4QH+pnFyiSs6SDmTylauWYI
	bLoGJhpeS1dCOyNqxkVxOKg4fB5lAz/yd/irqqX/PvkMugsSNjae/hCN5Xnj7KFrn6nCEgh0Kej
	dmatXHwGmScobdVbaaqNceEZGzUMhuYxFGrbRVmt7kNRjMIr6TKlvOVFflzoDlKBNjL7SLzEVq1
	ngVPmDGphHq23D5VSenZJ4C3W7IiIpu7W4is5/YMo6+OlegTUKxPg3236B+G2cgV4JbTO9/LdVS
	D5X3Exyh+bGnsXs3F9sQRgJZRt1t5dhuA52tfUmHscUkKI7RYKZDhmxlsTke3sMDf2Y35I8QYNk
	pcjBxg1fe4i/doua6O+nULuV0B5v9ZDDrfzuXyZoim8KQNGrwurtpccD5CQSboUmnL7arxMA30O
	WRiH1iFADyFlMGpKn2Jbb+uDPhwOQVkaeasVQVoPAUxbMUgyS1VnCKqb
X-Received: by 2002:a17:90b:1b08:b0:3ab:884b:65ab with SMTP id 98e67ed59e1d1-3ae89857dadmr12874069a91.55.1793773976084;
        Tue, 03 Nov 2026 22:32:56 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0945104dasm2583207a91.17.2026.11.03.22.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:32:55 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Snook <chris.snook@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/3] net: atl1: disable work before freeing the netdev
Date: Wed,  4 Nov 2026 14:32:43 +0800
Message-ID: <20261104063245.23402-2-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104063245.23402-1-0xbeac@gmail.com>
References: <20261104063245.23402-1-0xbeac@gmail.com>
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

atl1_remove() frees the netdev without disabling reset_dev_task or
link_chg_task.  reset_dev_task is queued from the interrupt handler for
link-down and DMA errors and from atlx_tx_timeout(); link_chg_task is
queued from the interrupt handler when ISR_GPHY reports a link event.
Both callbacks dereference the adapter and the netdev, so a work that is
still pending or running after free_netdev() touches freed memory.

The original driver never cancelled these works, and the current
reset_dev_task was introduced when the two reset tasks were merged in
03662e41c7cf ("atl1: fix kernel panic in case of DMA errors").

Disable both works synchronously before unregistering the interface,
then delete the PHY configuration timer.  disable_work_sync() drains a
queued or running instance and rejects a later queue_work(), which a
plain cancel_work_sync() would not.  Deleting the timer after the works
have stopped also prevents a running link work from rearming it.
atl2_remove() cancels both works and deletes the timer before
unregistering for the same reason.

Fixes: f3cc28c79760 ("Add Attansic L1 ethernet driver.")
Cc: Chris Snook <chris.snook@gmail.com>
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 2883e9462f..2bd35c3cfc 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -3132,6 +3132,18 @@ static void atl1_remove(struct pci_dev *pdev)
 
 	adapter = netdev_priv(netdev);
 
+	/*
+	 * reset_dev_task is queued from the interrupt handler and from the
+	 * tx watchdog; link_chg_task is queued from the interrupt handler
+	 * when ISR_GPHY reports a link event.  Disable both before
+	 * unregistering the interface so that neither a pending nor a late
+	 * queue attempt can run after free_netdev().
+	 */
+	disable_work_sync(&adapter->reset_dev_task);
+	disable_work_sync(&adapter->link_chg_task);
+	timer_delete_sync(&adapter->phy_config_timer);
+	adapter->phy_timer_pending = false;
+
 	/*
 	 * Some atl1 boards lack persistent storage for their MAC, and get it
 	 * from the BIOS during POST.  If we've been messing with the MAC
-- 
2.43.0

