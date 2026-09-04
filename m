Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21E314D18;
	Fri,  4 Sep 2026 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527287; cv=none; b=rPdgPExkFlPahKKdJ2I+R9EgFKS9IOZMzgcqIIDP2crS60AoApke8TlVck6Qvb76dHfDdhHBi3uKkj3w0/W0Z2lZWRccJSEO7crORrkxKvqG2/f/iVRO26MiGXjQuc6sDOwuuAGbmgMxyVUJv8eWdsI3urI5X3YTCM3lXc1oufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527287; c=relaxed/simple;
	bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMNhX9D+enZSMLbC4lUj0vrHQeYGJtOb/Hbfn35KMT09MgoKzin26xl5tTyqFSusvhSdpkN+T4io0G+JlHmD9ZxTva79PD61G39pW3suM6i1ZomfiJ/QIE6bV1Rf8y60qcamE/zHm7wJf+n9+yiMW6LRVo5l86EJ7eIawSYD8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=WDkrXgFn; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=g84ii5hB; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="WDkrXgFn";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="g84ii5hB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527277; bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDkrXgFnk2PdnZL02MIkJ0yy+/L9WQ5jGsnps1hz7y3N+5Dilg7IkDKTJiKBo+GGG
	 nWIQ2QhPNe1a6464K2UkuQzJtzKdiXjR9bN/MRLgBlDIoaSlQHf6T0OAn5ptT7+wr3
	 lJoYe0+GE/4Gb1Rp5zgIu9NI3nPkoJoUA+m33h2n6kx5yY6pxAlsY/0UzKPQfa9fsX
	 gH6sPXJgKFpCrxT+2dWukfrP3enLKtFKvSQagyiYwMFgiNd3+ZkjytT1CfYK5P941u
	 Je4xMaFL9BqQJo8oI4frUCmEGpFxoTkkEARQGukJecEbWG9RK/izH7JQqKNQbv3Tgq
	 D7LKvBP5S9xWw==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 924314144C; Fri, 04 Sep 2026 14:07:57 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527276; bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g84ii5hBYLAja/MhkLc6VZ6yYjhS7YXOv1Nev26hViUe2AYqaaYcngdq/FfOQCYUa
	 GTPCvqrRT693+GaAeQ5YVqDgCIR/9rlT+jdEMSfoB2hJ2sHdolAUH3LZsrri0ufbtP
	 G/dvWmTaQNtPsq0ZCghu8HaMzDizMwt1XG3oUJVHsgkf28Zl+YLFkCQHgKYJtukoAN
	 JXWJqV4AzLE8Z3dFkdlFxAqMAk3+eNvGZocme7A7q/Btpt3LvJBkWudCnvVLqGYFCe
	 1zu88WmfObEC1lYBiHW2qb8Nmd5zXmx3tcJWp+HGQAkVWim/IeUcghzzx3KriAAWk1
	 z7IqUHMVMXEhg==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 8F15B41444;
	Fri, 04 Sep 2026 14:07:56 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/17] media: rc: Ensure registered is cleared in error path
Date: Fri,  4 Sep 2026 14:07:29 +0100
Message-ID: <b0940b69ebb9f1ab0c4ad0639ff408a9717a6a8d.1788526920.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788526920.git.sean@mess.org>
References: <cover.1788526920.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If rc_register_device() fails, ensure that registered is not set to true.
If lirc_register() succeeded, then userspace could have an open file
descriptor open. This leads to a use-after-free.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index d93e98189c1a..1f99540456f1 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1934,7 +1934,8 @@ int rc_register_device(struct rc_dev *dev)
 			goto out_raw;
 	}
 
-	dev->registered = true;
+	scoped_guard(mutex, &dev->lock)
+		dev->registered = true;
 
 	rc = device_add(&dev->dev);
 	if (rc)
@@ -1982,6 +1983,8 @@ int rc_register_device(struct rc_dev *dev)
 out_dev:
 	device_del(&dev->dev);
 out_rx_free:
+	scoped_guard(mutex, &dev->lock)
+		dev->registered = false;
 	ir_free_table(&dev->rc_map);
 out_raw:
 	ida_free(&rc_ida, minor);
-- 
2.55.0

