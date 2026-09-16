Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89C3E6DD0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539070; cv=none; b=OfPl8dAVVwjY0OqjSMALAcbBz6DBwxpcGpGQnMjVRiQCX6ILmctmIRkYLjmS6XYr9EXh7Rgn3sJygzPEgPh0oXhhmbG23usOGE0zM7sR/7EPE0vU24n4YIMaBxUVAqteDOKb6RXKgc59SSkNYI3e4dBEe+FnBglVq2DhtczDQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539070; c=relaxed/simple;
	bh=LCQlOENHLpgDLFIJjB+UUCKmKYjt9PyQtWzPpaNJYRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3gpsJij/khoRKsCNGlMNNsun0dHgYy84GdPZ3or0HzAvgjSce3RRdSMaL3YZhDho8GpXTF9RLn6CmYnPpcmpFimfBLn3BpY0guxjKkGsFX5QvEhm1XdMQxOR9ZNW+CycaZR7aBAkWn4aqvIbbUfhnTHfoV5wR1JP2T/KiyBEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVyFxUbt; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVyFxUbt"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso470257a12.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789539067; x=1790143867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TmAAY2RsOedvqqE/dv3Tvbl9f0z0X1eUeI0/bSG7dyI=;
        b=YVyFxUbtjjPyq2bxlYUyZB8mVnZY2F8OSFvRFfGT7gMxR/6gBR/HOlAnZTqS83zXoQ
         zjL1odG7IMnsVOU1HjniVbsBtEYn/fNykmfGAWYl7HB8gq5p620MPTMG0k0PyapLbfZr
         7BhQGh8+e9YLpvWtyFzY4VQv3HTUglxqGKfvAAzDyvitLw9vng5LUFLUcFoKu8lbKYtQ
         ld4J+mxLVCimQ0r/zFrjyFqXIlaM7pM6r2mZ5ZkgE1J9UWUgH9/yl1cuwQ54ix5kwZEQ
         zwMDg5F5Z9WVf0oQiIOpyN9jDGiqtHiL+mMQvkelaqy6v16rK6tkemTTbiBls3Xw8X6r
         E7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539067; x=1790143867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TmAAY2RsOedvqqE/dv3Tvbl9f0z0X1eUeI0/bSG7dyI=;
        b=cHthyuhe4mPZz4fd1jsZbb76WeFAaMP+v6iMAlWWVyqhHjJzziSJg7woMpw+Vs7Qop
         FUpgW7EytjQ9HDSpvioYcrdl5sdY2jQkVbywrCS23jPHQB9Fm4Kxbygk/u6VvcJVBLDQ
         Kbm9Nm1KQREyomI5RJ5Tspf8brrmbdiKhXrXzJcoWqSMgiTryue+jnf7RQkrh+4icoNL
         065vAF4RhIzCqqBcSN+ZAefIfhkLDr15FUwPAi6XjRgl8JSsN3/Z6l6BAt2eI56raIk8
         zRG4sKDqeKe/nuSt3OTDrO1+6/RMMf2oaL2XeDoeYVh/6qFjiYuYUzzgLpQpC+6qLhor
         evfA==
X-Forwarded-Encrypted: i=1; AKwUvBzZYSCZNV1neDopi4EUT6ZriQFIc4MJp3K2uTisEhAOPiGFcKp+mkH9MmPdetnBjA2jE56Uz9o=@vger.kernel.org
X-Gm-Message-State: AFuF++mD7L44MNh/BJBKr+BRoJmYiUTrV0VfGsav1Wm6+ZAU5Y0jv9eW
	gaU5B273fKvw5UERjHtyeVE/6nqKya/XQhBHGn7DGwE1UnyM2sdvGnLg
X-Gm-Gg: AYBFou0EG+yoGIMoiMbU55fs4E4GVUTOD+Kqs2UHHV8QmC0WnIfxzXV2Y62LLMjAOVH
	Cm8mu/EjruCUXdsC5yns4Ugj+XvmQdyn00AKCZPgNriD6Obu/Hbxu1dUBFmvkiCzwbTg7ItpB27
	2GEuRjgOVoXEDHR/7qR47kBn/tSXNmoQMyr08/FE4yQ9iBkL2uY6LQx2D5awkkQQ7LT+EZ6tt/L
	Q4TqxpdhZrCn153nqHZal8KP2YJe9HOuCOEtEbuxAih5VhIiRtm2bQfltrfxBOBmaFoAv0tbqr5
	mvTIySxoI6jsV5AxsIiEe7hVtO36oMHPLHe8TO0APXJjaNsRu4Jt3FsBZQ0LCGXWCeovzNyh/ah
	EusuycLdM5bJizRGr3lEhhYdrWlfqaN2Jqb17T3w4GWVu7696Gb9Ytrmp5cEpZ4z4nnsKtbS3O7
	+immse22No0ior1X+j19ftccu7qQCju2B3fN9vfzTbYJiiaat7UjdC6g==
X-Received: by 2002:a17:90b:390e:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-39e1e424a7dmr2996805a91.12.1789539067435;
        Tue, 15 Sep 2026 23:11:07 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1c4ac8cbsm668374a91.2.2026.09.15.23.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:11:07 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Samuel Chessman <chessman@tux.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: tlan: disable PCI device on remove
Date: Wed, 16 Sep 2026 14:10:56 +0800
Message-ID: <20260916061056.2917164-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tlan_probe1() enables the PCI device with pci_enable_device().

The probe failure path disables the device with pci_disable_device().
However, after a successful probe, tlan_remove_one() releases the PCI
regions and frees the net device without disabling the PCI device.

Call pci_disable_device() during removal to balance the successful
pci_enable_device() call.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/ti/tlan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index 274a1837025c..0a8bed6c9ca0 100644
--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -302,6 +302,9 @@ static void tlan_remove_one(struct pci_dev *pdev)
 
 	cancel_work_sync(&priv->tlan_tqueue);
 	free_netdev(dev);
+#ifdef CONFIG_PCI
+	pci_disable_device(pdev);
+#endif
 }
 
 static void tlan_start(struct net_device *dev)
-- 
2.43.0

