Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068079;
	b=vCZDo2QGkrGHehiiIzu7/80pD2I8V+OJpwx0yC+oq3N3dWtICYRqnqEvn+x2ObR9oLhj
	 6TqG6n3PW55JI1fVMZ7ZO0DJVxRCINDGRIPcJ/1JH0IoMazvSjspESX159Bko2V+HLy2u
	 LeEUVkLRHXZV8J12EajI4Gil2C0/UbuBgyopeT7pvbj9/rhgE+zJL90lMBoHyQPN92UZr
	 F2IYkVIDRGbeUuPl5/VcNNJCtRioSF3BuxgZ2Mf5hWjIMO2ZthXJxcXo5sp4z7Kjuknkx
	 sk19BImXg9/1FJnZ8SC7my17IlrQbPIMP3XnNmgEiIvaznH8sxzhaSgHLwrZNs9fnzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068079;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=91R0HJ+g+vL54XmNSHpf8yEC8LGciAL5mhbOTQZc/R4=;
	b=gTZWrqATbayijt/ZFtUZsAFkbLzfcDa5K37BXZdgT0L538Er0WOit8vIfjapGKCVhi1d
	 kuLaS8GhU6un/Yy9bca84xVmkhsNFF0O5ScGcdrfOZoha4hQnroOArrJVf8eO2Kmw4i7D
	 J+GAten1oiHxPVSR67zHef+rofK3PTRh3I1dVq60pLejitRN/J3fXEnrEI4rxz99pllEI
	 qHG7Hjwjvds6KQzpCabN9Tzc6ehfhlEzS9dxnrZ7W3YzB6+nD6PTCsQCBo9HwmMYefcNS
	 0e6cZXuQrUt8b7GDPjd/bWJoC3hP57M4JD2mGvAT9miFJOu4TOSHb/scBHGo1v320AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fl1SpASj;
	arc=none smtp.remote-ip=115.124.30.112
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9D606A32E;
	Sat,  7 Nov 2026 16:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB9D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fl1SpASj
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794068068; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=91R0HJ+g+vL54XmNSHpf8yEC8LGciAL5mhbOTQZc/R4=;
	b=Fl1SpASjdcJsdzbnH6npJkVk3bYvtMyX/+7cwa94OsiWFIBP6+IlxtZ9vQW2EcdAiSVrI143VyXyV98Gn03uM11KYwJwDS3nv+Ers32aWxCj+SvYJY/Yn8yWJ5+KGvMWtmXUW2r919LU7o0b5HaeHGCD2+buJ+rc4WIf3hWdc50=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XEEn.ju_1794068067;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0XEEn.ju_1794068067 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 08 Nov 2026 00:14:28 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] net: free_netdev: exit earlier if dummy
Date: Sun,  8 Nov 2026 00:14:15 +0800
Message-ID: <20261107161415.1917665-1-dust.li@linux.alibaba.com>
X-Mailer: git-send-email 2.53.0.apsara
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

From: Breno Leitao <leitao@debian.org>

For dummy devices, exit earlier at free_netdev() instead of executing
the whole function. This is necessary, because dummy devices are
special, and shouldn't have the second part of the function executed.

Otherwise reg_state, which is NETREG_DUMMY, will be overwritten and
there will be no way to identify that this is a dummy device. Also, this
device do not need the final put_device(), since dummy devices are not
registered (through register_netdevice()), where the device reference is
increased (at netdev_register_kobject()/device_add()).

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f9436563a2e84..0d88d285c713f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11093,7 +11093,8 @@ void free_netdev(struct net_device *dev)
 	dev->xdp_bulkq = NULL;
 
 	/*  Compatibility with error handling in drivers */
-	if (dev->reg_state == NETREG_UNINITIALIZED) {
+	if (dev->reg_state == NETREG_UNINITIALIZED ||
+	    dev->reg_state == NETREG_DUMMY) {
 		netdev_freemem(dev);
 		return;
 	}
-- 
2.43.7

