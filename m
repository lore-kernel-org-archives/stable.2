Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743291;
	b=ac+fTe3X+YsAkOhRs0/UZX6v5VSlP0qZdBqCqCOszRVud+SODhpfni/dJPRkATHekLGH
	 zL/xyMA8z1rvCmsepT6QV2kBamtfIRFHdcAYfakw9KdCEFG7YyF62gn6PpIsVr+hCzLdt
	 7mxWAa9SXnpJrCWTxcfKyI2FaEx0JBL/4LuJQyTCE4bHitlRU60KHfRETIzHQSzA+r30g
	 +w/7H3c/u5fC6bl7RWh/XOTEmw/pu014U7KVjvlOBKcBh/hZGbROS61yOR3KG22rE0U/v
	 8jnpKNOrlgMHuATBoPdukV/xwibPCVSTdvf0KDpqvXT2jemDqS7GRyeVnC12DioeMiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743291;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=JuWsfAp8paSqsFy21hQ7TQ2kPA5+o4Jt7FI0our2Ftc=;
	b=su45Nttz3SKzJBH/BptHVQ08J4jht0TKc8S5GA+2ytSSJraL8lh5Ghe5dp72Zqmd5l+X
	 Y8ysdcu5zkO9tvrDkHLhQ8HpwbFZOVnBysaklWawS2CrN1EA36STORvDjh9bz97wftT32
	 hMCW2ThW2YkGstJA7suWq4m8IC3QVqwFt6ad3KMWCthrRhlNkPjPpMyyP5ogV/M8C9L8n
	 EjJ3a6wBiBV9Tma/1ZiMX20PBBllQvUJWlwTufhKWTNEtjLAFmPTtsY49JmWTJ7P3K+We
	 a+NkdIzi12RW7589gy97cJok+InURUCzY03Zh3BShezk1PMSXZ538TRdwUtj0NZAFOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=YGvR4bFD;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2260A2625;
	Sun, 15 Nov 2026 11:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E2260A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=YGvR4bFD
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04e5;
	Sun, 15 Nov 2026 19:47:59 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Stephan Gerhold <stephan@gerhold.net>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v6 0/3] net: wwan: qcom_bam_dmux: fix DMA channel and
 power-control lifetimes
Date: Sun, 15 Nov 2026 19:47:56 +0800
Message-ID: <179474327647.103840.9539614513141118915@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df091dbd03a1kunmbac61c98bf79a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSh4fVk0YGkhKTUJMTktCS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=YGvR4bFDoeBSUkTOrZt9kluRG7Ucxon95IgkXaU5i3BZubhkWbw4kEKYrd9GY4LDqiRySGnJ5d7Slkowh4Cc+LPEKAfvPoY0eNPB8BnxY/NRbS+ng16ByFzQvnsg7agzgBv77ZD6vVHDY/qukdR5hvRwUpY6OLHf5PdxwzRx5kY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=JuWsfAp8paSqsFy21hQ7TQ2kPA5+o4Jt7FI0our2Ftc=;
	h=date:mime-version:subject:message-id:from;

The original report described a TX DMA channel use-after-free during
runtime power transitions.  This revision splits the work as requested:
the DMA provider now offers device_synchronize(), the client serializes
power-control and DMA lifetimes, and removal stops the state publishers
before tearing the interfaces down.


Hongyan Xu (3):
  dmaengine: qcom: bam_dma: synchronize outstanding callbacks
  net: wwan: qcom_bam_dmux: serialize power and DMA lifetimes
  net: wwan: qcom_bam_dmux: stop state publishers before remove

 drivers/dma/qcom/bam_dma.c       |   6 +
 drivers/net/wwan/qcom_bam_dmux.c | 317 +++++++++++++++++++++++++------
 2 files changed, 266 insertions(+), 57 deletions(-)

-- 
2.50.1.windows.1

Discovery: found by the author's in-house static analysis tool.
