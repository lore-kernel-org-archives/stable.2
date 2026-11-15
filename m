Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743293;
	b=gu2RncayUCdm7wwuV4U6yFj2gJluHG0cKWXepLX2h+SFH+zXZLP/YYbFS11rgsjQ0k/L
	 /CqYxtjMlg8TdUPLsfb6YbXqW35V+5JEjPFTUYtzSLtAmceFblqB5i5OJOsxIOVbR25Cw
	 EasHuudnz5mAz9Wf5Yd8edSmXjBTRJ+863WvFD6LMvXWjw7NbBWXRw+smBtxq1LA48Yt3
	 QfBj2mNov04G/+CZCMke9zsX4NLNvFsMHDpPHqDSqiA5oY8REcMo32Np0MfJS+Rb/QdMz
	 sB56wKDtqkavNPKWTQvZW5FKw7ZKYJRRwDzDIFwMSWRh94qdb7e+2DLLQj/wGRlTRng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743293;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=0Cn4oWoP2n7fe+cmCgJKQDfY5yx76B+/Bp4WeuLCUlc=;
	b=QTBj15/oW6E1s0V6m7hLv0nN+gm5ib595VOozoGtrcH74fwHPdy183844gC9Was2j2DL
	 1TC3j3HfVhxcTb2+4+h/tPHQ7qNfjhnyTq86UyZLhd70k+zE68d61smpHjSfNjaDdWcoP
	 SIWFN70aieehmeXS9gKlUNlyqahvGPFfXO9AHh/d3OYvkzdeJJll70uwQEBCadSM/IItE
	 Zj0MeW6hkIkI/zk2nLXW+TIlpTJ4I8Ep8yonqhJ8xBdQw6iAMBVWgqK6Sl0D6lHJKgRzP
	 kuMswsPnCoGWIv6jTk2d+8Z0WCrhB5jyZTdndokT3O0X20SL34BbFnBGaG2adgnbINA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=HHvz2HKt;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA560A3806;
	Sun, 15 Nov 2026 11:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0EA560A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=HHvz2HKt
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04f1;
	Sun, 15 Nov 2026 19:48:08 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [RFC PATCH v2 0/2] drm/bridge: cdns-mhdp8546: order teardown against
 producers
Date: Sun, 15 Nov 2026 19:48:06 +0800
Message-ID: <179474328603.103840.4363768155390012601@seu.edu.cn>
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
X-HM-Tid: 0aa1df09431b03a1kunmbac61c98bf7b4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSU8aVkhLGh1MGkIdT01DT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=HHvz2HKtonMn5+t3pSPdVz57/+1YCwuxLYJ6zHb7hZ8V/i6/VbuMnXDwAgt9X2aoe9miBU6vo5ECgKjusMNOngSjfXrH7I9e0ZSOdJnxgk5n7Li9deoQvUk+P1465uYmXPiE+AgKpIsenGGZ1dgCr4LUd/uonxaVBkqLuMSxefs=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=0Cn4oWoP2n7fe+cmCgJKQDfY5yx76B+/Bp4WeuLCUlc=;
	h=date:mime-version:subject:message-id:from;

The bridge teardown cancelled work after the controller resources were
released, and the atomic hooks were not excluded from re-queuing it.
This RFC uses the current bridge unplug critical section for the whole
resource-facing hooks and work callbacks, keeps a reference for the
asynchronous firmware callback, and drains the IRQ and all work items
before the controller and PHY are stopped.

Patch 1 extends the HPD helpers so unplug also covers their mutexes and
clears the registered callback while the mutexes still exist.  Patch 2
applies the driver-side lifetime repair.


Hongyan Xu (2):
  drm/bridge: protect complete HPD helpers during unplug
  drm/bridge: cdns-mhdp8546: exclude producers before teardown

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 333 ++++++++++++++----
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   2 +-
 .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   |  76 +++-
 drivers/gpu/drm/drm_bridge.c                  |  41 +++
 4 files changed, 365 insertions(+), 87 deletions(-)

-- 
2.50.1.windows.1

Discovery: found by the author's in-house static analysis tool.
