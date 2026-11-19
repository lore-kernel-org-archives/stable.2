Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092575;
	b=cQyfwSjPd76HRo46PcKSYtasSTe5XQKug0fwTePYApK+Zld1zjbotZBEW4EcnqGG8G7b
	 9TTnK5CT6AlMCWcOhXS6gJcHBSvTGbMYdrp0OGbZoVVU4/uuwbde3birZ7odPH2qvGZhW
	 GkfmGRppCf9D7kphY6nhlZGHzSR3hr5Ii81oYjDx4G3X8CwY7ge+XGaVV65KPr18cedCV
	 H33OM1G8LTuxdUBa1VHf9dFNpYTOWMLZxXCl1EpJRxdZgrpvz2Z7D5oxYfPWnJO06hoMV
	 Ng6UlPIJEeZcx4LbjUR7HiQkiTKoi7gztkbWCkVBj3WQPXYafLJ4Y1i4pkrguLfrG7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jl9oyBMBlY4JXOrQAW23CuXlJczhQJcy241+h238qgg=;
	b=37oGxkz6TVDdqUytQy4EG4RxAKEacP+T1KynyqFuFGScLQmR3HnfpDATT5pwUvi2fWph
	 2CfCLpLCbBGMtofi9xLqF4nCXmFFJ0Zqk62CHmwQNDGnUjvPSZzLu8kZtpaOx59SkQUyp
	 tO+mOrNjJ2jq/l6BOjBw8Wu/zwquzRq0nkpGQd2cm/bRYC9wWCnojq4fZ4ZfFwSRh3JyA
	 MT9Sn96JZUnI//pI2GCGJGTwZDACykZAhogv8lqDXOa3fJAgoiuu4yPLEiVcq0dD/Jkdg
	 QNij67VPVLDfb+lBaYYSOQHgLuhhkRkIhBlWKOKjwV17LMDrw7MBAim8FYKFU9UTVuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHPvpXlb;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC02606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC02606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHPvpXlb
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-381d542bc29so4017054eec.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795092573; x=1795697373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jl9oyBMBlY4JXOrQAW23CuXlJczhQJcy241+h238qgg=;
        b=qHPvpXlbIhX6l5QoRi3WKlIpWEpfRc1OTafFYafo8n1ZlnpmXKLNMPRPXKNrmuufPp
         hzIeG09r1p0ytIZrctJBtcxF4iErP1nVvzksg59PYdnjOIlbEZjpSKWlZoqEXiUhX95a
         dw3a7z2+9bvdYH+t6i6J6+mlpZtFQhoFarTQayDm7paKto2P45Um3dtPYTv+ZwTeaBox
         GeMAi7y8o2h48ljsXlmRei1G07l+vvPdLPI1h0xqajBpQ2NrzVSukAW29/o4upJiQxeM
         GrQ5BXdrQ6C4yTp6GxXhbJRk7N4WJouEktR30jYIrW5JFMbXRZ0C+oZiMQC9wNfdbNpt
         OoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795092573; x=1795697373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jl9oyBMBlY4JXOrQAW23CuXlJczhQJcy241+h238qgg=;
        b=RyVAyaZ/NJqeVQTSHzGmMLRni7YW5FvWO6utW4vDxrQdUrxAouGLPXyFQE8hKtNvfx
         XHSm7J0SWTXzJCuJ62dN4lVW2SMcsF+UHfQvawsIMARVtNR23aP7PEzp8QhpgKOtj1my
         G0FgcZQGkTwkd6Jm1rTXtKSdt/tRvtTqqTCFOXTV+ke0JQU8Djn17jdjuQT13DGB02d4
         U57B/buh23edPDJRPM6H9jmCv6dGjuBvAy0MuToTjgbTHKw6HXpuFXLCfB1kd7U6FVmW
         7hRytRmVuWo2GDpizU6In3M+kJJS7ta+WmMovlvQNQmfvUnD3AJ7voVIz6lGqanHblsf
         XkBw==
X-Forwarded-Encrypted: i=1; AL+hErGHcQveNv/t7Th6U4OsBUzxN+rFkLoeYj3Vn20fl1q4lrwfeOVZ+qhmOg0/l4AHlnaEQlN+BGY=@vger.kernel.org
X-Gm-Message-State: APuU4Z88x7HRLGNZuRwyU+xSmv6/x87z9dwpxEyXCtHnzu5Dhtr3Ex+H
	eOI8I1dvLBJ4OraCXm5ErSbbmJ2BKBmAL1qSKQ1rc3K5Pq+n9YNryOYE
X-Gm-Gg: AZFdTZe6ULpwP+LdJMGLWvi6+FhG8mZq/ul21iVeZFHyCzzK0byjY3ffGdKDy+1/ova
	Rs0/Rwv5a7zJJQb+AdrqLH2mXQJPwBIOobdamONkBSF3H/lryIKezyWGa0YS6uR2QZLt1WBVIQq
	v5n7xs4t+vV53iePzhs4wImHVOVzubN3iy8jx7JmPDnECYJz9ywD8Q8/kz52oREotsb2ldEcWZf
	pu7ojCcynXA/6gJS+u7Ty6QE3ln2GXuM3DKDtoFwI092FwiGMCRfGwdsCgUKnTQfCt03nkixila
	Mft2XGLQCcN4Nbf5lx4qjbP0+m9bo/N2hd5de12Rpu270QyrABntZ0GMW6RsjW+W4W9jSgCi6Sk
	G3A0G+OPCTE3mrM8qwZd14P8k/21jxTQadJerggqboPbnj6D1LBCwn7F0Is76/4LhDVr0ZcBpfy
	pBf68UlvksYhkYs0CsYSFyW9bTk7DzOjhv2uuq9Ha9Ffxkd5BneH8jQajNpw3f8H01WyY3c6oNn
	pylQDY/m7PO4kIy53FE/F6/Hai0REj32f+XavsQDAdvCDZZktlzXD7+u4rC/CAKHzeNH0TWnVzQ
	icD8/Q6gPkaPvpk+szb3DSWD+Siv5xWRBMsuw+Qx3St4Zn17R1RiDw61ktAiWOk0UJzIjfYhhvo
	=
X-Received: by 2002:a05:7301:1a14:b0:382:5dd0:3bb2 with SMTP id 5a478bee46e88-3827fe7882bmr4750485eec.9.1795092573428;
        Thu, 19 Nov 2026 04:49:33 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bc05cfsm17909542eec.26.2026.11.19.04.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:49:32 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: sdio: check the RX packet length in mt76s_rx_run_queue()
Date: Thu, 19 Nov 2026 20:49:28 +0800
Message-Id: <20261119124928.1398520-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

mt76s_rx_run_queue() reads the packets that the chip announced in the
interrupt status into one buffer. It then takes the length of each
packet from the first word of the packet and does not compare it with
the bytes read. A larger length can make the driver read TX status
records past the end of the buffer and build an skb that extends past
it.

Stop at a packet that does not fit in the bytes read.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under ASan, which reports no such
read with this patch. Not tested on hardware, only compile-tested with
W=1 on next-20261116.

Fixes: dacf0acfe2ce ("mt76: sdio: extend sdio module to support CONNAC2")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/net/wireless/mediatek/mt76/sdio_txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index 3f314e8e1e69f92..86dd1165d2c7f1f 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -127,6 +127,8 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 
 		/* parse rxd to get the actual packet length */
 		len = le32_get_bits(rxd[0], GENMASK(15, 0));
+		if (len > end - buf)
+			break;
 
 		/* Optimized path for TXS */
 		if (!dev->drv->rx_check || dev->drv->rx_check(dev, buf, len)) {

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

