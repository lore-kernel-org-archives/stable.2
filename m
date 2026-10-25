Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952431;
	b=n/TTX/Pg0m3/cYZjHmPQXWZtHQM51S2UVqfS8jOLEGMErWv/c+NKuNENck5sp/dHc8VS
	 QZUvxvi570zj0Y+95q17qNVZshvNo9gUjHCAqq1riqko2uVX+99bt5mY6IDxhXRrJ3suF
	 ditIMkbR8Jt6Escb8BQgaoF+F3Ci8nsd/nIvkBVle3YRpTM7qG1ifKdntRQuovBWI6YnQ
	 x9RfAzfAtQvgRC1oGC3R+v19r+TxXXvvMTqlm+K0tv9L2LlAxkdr3NZsyFi1GQ6b+YQAh
	 cBSf6RB2nCA4lyl/Ahv2Swkg5wSbZRyh8kJJxb3fPLPfjsbh1sQ9OZpmSYazIyV/vyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kkg7v9pYa1AwlmOfl8C/ErCvRwIjr29iyWLeNc7eLhs=;
	b=y4ECeun0OAnxr7ke8XSTSIL1GwgU089GUvpzd00ZJ5yLJoHQNcWreEFhzx/WBSMdKzyI
	 BmCwHKxG9n2pbcCm0vo7uQsjCBWWCakk2eSwjrj2UFV0T9FOrxUmgREHtMxF4bxwgxuF9
	 nRiOubKyhoO7BqEtkXnxTcTsFWhqI1MqPKzRpzJBew92w1R6iGrp0VvqNiWrP3fk1H5o5
	 W1iGFQL9yXqwCN3RwLTrSxZRubBG4a2wa2ztZpd/YYsplS4vGp6zGZjm033O3xQu5OtDe
	 Ajx4TFMpMlkg9eBJ9YTPesyYSpP97a/H1gur6RMBRkJVf2wZHLqRmcUggREl/pXcyIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hGg8IcG8;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A8606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D10A8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hGg8IcG8
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8fe8e343fso12952015ad.2
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792952430; x=1793557230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kkg7v9pYa1AwlmOfl8C/ErCvRwIjr29iyWLeNc7eLhs=;
        b=hGg8IcG8zi4/Z/awlqSK8ljg8JDI7fwQl3Gd8hkVh8ELqDTkoDUnkR3YLv1jEfaZCa
         7SDrXXOS3u4rgPbH7mtse+ndeA/T3iyjofXVtdfWNSyat7E30OY7KB8hErs78BX78YVU
         RIKz9THfOb8vSxqplRih10XOdz+F7ny9kNM5k4PH3Nk2aL6eKeab/lggbYlBLYWrlNLq
         vADXZg9wus2h2VjPq7t8CZEYCGjqJLq6yn10t9uBQ4LPUHQcp05QUusLmfx5f03i+gXW
         xydEaeLW54FbOBhSn6YBcDkID/acsI3mXcWNJBxXhwgEKFat3v/Dimsx0tyLXepsqVqY
         GokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792952430; x=1793557230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkg7v9pYa1AwlmOfl8C/ErCvRwIjr29iyWLeNc7eLhs=;
        b=ijEYCEY4smChroSN8FG8s1ea9k9dQNrzFVKyIMTlBO8jKDXPlqkwgBKI1Y7YInt3b1
         uPbiAjjCrZhKVKMjTz3z0wABt3Yf6sx6TfJ6alhz8O7VFSVpnlQ1zz4a2jMUn1ttzCE2
         8PVwdeXU0imuCwa/njUkh2WTTiHxkoAniPxCUy1hqe2GDEhsdXkPkiZuXujWf4mT0ECK
         TdypnP34udS/LQFEWD8LqzUeFM0HI9O23edYchhY9nUN2wJvqM5aeL+jojWmy+6U6heh
         u/D0Ocj5GQpi3kmW0cwEuMV9iBYq3WxRBs5turNTuOM5617f3Q2lspRja8sE45YpWw/R
         z5bA==
X-Forwarded-Encrypted: i=1; AKwUvBwqiqfalQ725ypia7AC6LXU341Grg6OcZn48aGNgwIMp+j6WoAd0OiyirVhzgqza6Brr8ewuio=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUFJ7OjpysTJHFZeJEjkm74l1J3QPWw8+grWUmnGnchMTQA7Iu
	2Lw2ICYgfFWsYhpGYlQKnmCMVz1t5CLBKQufmCf6ZY2txQDD8Bs9tUxB
X-Gm-Gg: AYBFou1I6PeUHVmHmSGmtuG83UE8eXGfUu+X5Q9hTxakcpB1AK58DMUG0jxj516Xe9X
	3JXFHnXSlriWygkzP/fzEQ7D0z9pF0n4ig7D/o2NCnhAfC5EoIcTxv8YIapJ4nDxq0Y9s2Gpo9D
	+VTnGUDE68BT15XCqaBST2IRuBOMobFfOMVwB1Tme+/hLxQwPaJrV69luUcdScnhAqHz0+hQCQ/
	N7lYyayL1jaRjPXsSvAN0+PViQVwdSZJm87VzEL+hpZM8v+YHYsB1JJ8peATnkR7aqyaaH5EKl9
	bGZ8xOQXdBu+lIAKs/qkdLPePhm5fK3HOxZeBetFVDuwVPXNq+Zsdo4A6vo4C4LAq4vJENES1e7
	n5Z3ajRAGNWha3tSwkDhHpM90SHw8G6zLVYaWmqHMWosTWQu+5eVeRLroEXsvkYE9f/tJk6OibE
	5euy89tH+gQpoXjRFSePP42FnHfgHLkH5k+FYRvG3SqNQIqvhHOa2PfLn/wfqWbj9FSYGB13EXK
	f2wrMmsNg6Dg2+dwk05htcSS83HRz3ZQa2iW8EKEzpkgP8Wekpu6uSjLF0DEHbHDgybCG+MrdU9
	zarPgRk=
X-Received: by 2002:a17:90b:4acf:b0:3ac:9e76:aa93 with SMTP id 98e67ed59e1d1-3adea0b1206mr3533541a91.7.1792952430015;
        Sun, 25 Oct 2026 11:20:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6212:1232::1d0:de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaddd45sm4108709a91.2.2026.10.25.11.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:20:29 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	stable@vger.kernel.org,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dongpo Li <lidongpo@hisilicon.com>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: hisilicon: hisi_femac: Stop the receiver before releasing the RX ring
Date: Mon, 26 Oct 2026 02:20:18 +0800
Message-ID: <20261025182022.2959333-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

hisi_femac_net_close() frees the receive ring while the RX address queue
still holds every address that was pushed to IQ_ADDR.

A port that keeps receiving then DMAs arrived frames into buffers that
other slab caches have already taken back; on an EC6108V9C (hi3798mv100)
the queue still held all 52 armed addresses right after the interface
was closed, and had dropped to 43 after 15 s of broadcast traffic.

Reset the port before the buffers are released, so that the receiver no
longer holds any of their addresses.

Fixes: 542ae60af24f ("net: hisilicon: Add Fast Ethernet MAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 016605e86f0b..a44ea0a2b1ee 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -491,6 +491,7 @@ static int hisi_femac_net_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	napi_disable(&priv->napi);
 
+	hisi_femac_port_reset(priv);
 	hisi_femac_free_skb_rings(priv);
 
 	return 0;
-- 
2.53.0

