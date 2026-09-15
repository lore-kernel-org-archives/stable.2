Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E602F83B5
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434278; cv=none; b=QNIaGNdEWztNnprpe1Yqy9O6pNt8mq0I0R+nMqAas1Y3SzBBrRTewl8Ds0FY/qRRr7p261lQixyATBkDVbnbQUe1a+I3Eg9u5LQTEGmUZkDzFHgXf5tGpdTAg3QkMzq/WSEwD9BYtwc7aXyHhDktCuq/voP5pQazp3N6E3nu0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434278; c=relaxed/simple;
	bh=XtFWOjAsvoRjnsnISmN2wy46HkfLdVZ5riRgkIpNj1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdxtDKOoJjLRoMlXAMhHvXcvWigHNl1EoQSizo61xWglX0sP4TnloR2xpQeN/pt02gb9w+FovQOss9J7ExNQsB4qzrDuCMXKoaYZ8W2fTZtIt9m/i0zyKMkRwhPgn76U0LNKT5eiJykqRUiAvXrBPmAR6bemVO57T5wpzGSPQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBIQw+em; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBIQw+em"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5301db51586so46971551cf.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789434275; x=1790039075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+EJ+DL4v8rPAjl13J3qL+WXNCO4o+Twy0SZVgoN/JHk=;
        b=XBIQw+em9jCNuY3ve7MzpmFKuERzdbxP6wC9RHv3StiX7X48EQRwW6mtsKQpPH5s8i
         jPVDjPIxk/qKLy4zx0G+sAY5WXttYRBhlcsSkOv3zNjCnCvptFgKpBrnLSogzkEjzs+M
         kCdd3vXKU8NUImx85Ut8tdCMh52gQcp32AP5kwpStvOQrx5ESLdLl+s/Hk1qfq2ssHxS
         c+WEuadKYxEsiHQttYOVr4bCytEHvxrmu7tnJyBScUxF6QRI1uah6driq4srUOxDyCFG
         ntvwUK/nJfpfDXRwLQIUNnL30x55G74BZPmJZsfeH1WXKC0F6oQ9me/sxtUzyMwQ0oGk
         cPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789434275; x=1790039075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+EJ+DL4v8rPAjl13J3qL+WXNCO4o+Twy0SZVgoN/JHk=;
        b=pTshXjBxlvmKxGvhQDpKrx71EZ4/Apwf1lkwYXuyuIxXGhJSTDMzstQjhOBcu+bXiK
         9QtjFKtSnYVuv3J9MNR+6zNWSwZ5KKqPCD+rBJE4NmW/oArTmuP+wcAKkWxTCmlejBA6
         qYQPP81Y69XEpnnjEkTw9gdegf6qwmB8kd2jQLEaRVy1w+AUyup6KfvFKL6j7qxQjRzW
         igfO2gBei6r2yhHzF9kWH6rf7wkvWHE2TedJZp8YV7RXdV0jjbesGCPoE0hoBNa8ImpZ
         gj1G0oRWfnDOkCZx715AlKj7e7887eGjr5nepchqv16rXqhujionrnE6BjpqEVs7rYiq
         NUUA==
X-Forwarded-Encrypted: i=1; AKwUvBx+71eLsPa5hyyBPPA61iMKER6VzqoE8xWE/pyJaKpw3Nv3eLrTqqK15CDaszwLbZnfZiDhy7Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n0Nz7ZVfN1mhPdn2fNT/fRHpzBrLp77z02ji8NB6KRTWUJ0IQx
	QWqt9yKvgHGq/u2+kIp4Yy4ox1+tgwpvcC6xQiDOa1BjXtvqxbD1zNkc11lFwWNkhg==
X-Gm-Gg: AYBFou07hrpYvB6yDTmfbLElJz2MSEcUrTqF5osW20WnzATZJdSiD9O9PPuFfwrtNWH
	lJSbeDwHh2dMaaz21bPGgf5OMI7a3kC6ZHWDLTR18yptOPZnXaaSKSYfsfWNn3vVe7Tp9fTpuWJ
	QuDHn7p1dyqIGm1A9aIG5B7qIQ0jXwWb4YPOWvgsiKkvFGyxgwojBLqnIMe75IOw977+0BKgveX
	TlC76u1rwxi8XRnJM1sIhdjsI2LSfSoLv+3ipIDKeQVZjzvx0s51LAEzhuFOpZkOzESkVn6pBQM
	dhg9IxgZC0QAfaCqQIwmouHwOD0/T9nVNYLSx9+IXXnKazWPH6D/op2TVe8Y2oC2GVjqawPKmnD
	g7+h6RyZozmvLmvllmUE7o5YGC3+Y/ZGgfcNLFbFgu4IaCAlAV/ZFUobUjxrJat16z6S9gETvrb
	Ts5Zv+yZnSL0wRPquJ5o9Uz26e7UzZgC18RZiq9S9cYph4dFEVsbS4ULPZcn8AqcbqiwFGgPs96
	9KATvgF96NfQMeZTucRvWsaH+s5DJRms4ghXKvpmPAeqn/iPFXAtw8AdGAHdUsEo0RYzl5alzDu
	3grChT7WHsbI+ijhKkuhGcLgoawQn4bqLk7wqrVg6ybsYtMtW7EgqNC1Ebz7SMaNr2TM6A==
X-Received: by 2002:a05:622a:587:b0:530:f60d:2225 with SMTP id d75a77b69052e-5310cf700e4mr71705701cf.25.1789434274975;
        Mon, 14 Sep 2026 18:04:34 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca460a32sm114730831cf.9.2026.09.14.18.04.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:04:34 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-parport@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] parport: pc: balance PCI enable on cleanup
Date: Mon, 14 Sep 2026 21:04:26 -0400
Message-ID: <20260915010426.53563-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI card probe enables the device without disabling it on later
failure or removal. Use pcim_enable_device() to release the enable
reference after the registered ports have been torn down.

The early return for already-probed onboard Super-I/O devices remains
unchanged and does not acquire a managed enable reference.

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
 drivers/parport/parport_pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2888,7 +2888,7 @@
 	/* This is a PCI card */
 	i -= last_sio;
 	count = 0;
-	err = pci_enable_device(dev);
+	err = pcim_enable_device(dev);
 	if (err)
 		return err;
 
