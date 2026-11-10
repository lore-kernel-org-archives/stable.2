Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330807;
	b=I1TEwB+j6Caf6oMqcN8f2SabaT55QqAvsM7O7EzzoH2Zae491s13JMziA59MaChuWAuA
	 YXPvR9CrIp7leLe3EaQ8G+zToPUSHwp1eJUk2JsCb1sFdqTS4OKsGb/qGea/o30Rif8YK
	 wFkDowQ+TwTwdcJaFrbGtaavqKkc21wxOBxgDyQlaXpao0slpx+RNAtpxJstP4l6m3BA0
	 8AwOKvHTWAuBDvAWdvV6JDXL7R3OYVmN0meiSUNO57xmA4RoP7xgZgEn9Ws6weGgTaPYF
	 EimQw4MCCjRA2uJufteBSpDRAlPc5vgrtSizXGDZqyCmC1Tq8bdO+CB1KIDwm0R3Kwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330807;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=72g33SxzWXKHvB52lrU844hZ7EwB55XERmVH9+vwAt8=;
	b=E1+Jk/f5ngZhS8wEp1ISnzQ4Ltat4bcjRwzUpmlzsI9z/BgniYY4etWyR7vD4UeAY4UR
	 2e7tQUdHmw7mfgNSgevj+4s8dFGAz5mqfxdIOYG5Tfadw7ko3fLfzSHsb5mh1JV5eQbyC
	 Q7s8NtGygU0rpOUOPQurKP6AnfOPW+IicN/u/pRs+6vNNazDn4NI/1fheowUF2AghYV9z
	 s0PBQ0pA+w+eQHdXxnFt9mGrpGmCgMKsBfwDlANFofxhWDq+9NR7Lkii+VfG2feUskauR
	 6MQjuHiIP4UdDB5EFZxmQsvXTNogItFfgOaBO5ASOkHEimkvnNITbz3dNHMrKoJTAOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+6TjpdM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+6TjpdM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2EC1F0089F;
	Tue, 10 Nov 2026 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330807;
	bh=72g33SxzWXKHvB52lrU844hZ7EwB55XERmVH9+vwAt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C+6TjpdME801kyrd4GLu4HahVKsxuEku1TIqO/Um3IpXl8T01BBXPqtcrcgECUGX1
	 tftKHCiNRqxcIyNlBkjDk3Z4wgQLpsChsNRWAQUWvr2OgbE65eNg3sidt55MRnl9wI
	 XGusKCVfYd3zX3pWawnAqS1XAZ1dG91Z6lHxbuPYuFCtNL/vd5HnawYtH1o433l30G
	 dauyz+pCAQ83hXCqrNYH2hfyx0XQaeOQ26fe6iBgGrnLo+qEj28rOyW+QtTvHaf95M
	 BMxIxNql1eGWtti1KFJztiUAOrLRAY9cH3KiLbsitMyxbBFzBnljB2E5G7ItotRcuc
	 SE7X0XfuwLtOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Jacob Chen <jacob-chen@iotwrt.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] media: rockchip: rga: fix clock cleanup
Date: Tue, 10 Nov 2026 12:13:22 -0500
Message-ID: <20261110171316.2718911-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060145-failed-5.15-a875c43dd95e@kernel.org>
References: <20261107060145-failed-5.15-a875c43dd95e@kernel.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 254f3337ce2575bf94f1fb40cc40fdbc70371116 ]

Fix this smatch warning:

drivers/media/platform/rockchip/rga/rga.c:734 rga_enable_clocks() warn: 'rga->sclk' from clk_prepare_enable() not released on lines: 734.

The reason is that aclk should be disabled/unprepared before
sclk, instead of the other way around.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Jacob Chen <jacob-chen@iotwrt.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: a875c43dd95e ("media: rockchip: rga: quiesce IRQ before releasing m2m state")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rga/rga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index bcbbd1408b368..02c2ea2b42a50 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -717,10 +717,10 @@ static int rga_enable_clocks(struct rockchip_rga *rga)
 
 	return 0;
 
-err_disable_sclk:
-	clk_disable_unprepare(rga->sclk);
 err_disable_aclk:
 	clk_disable_unprepare(rga->aclk);
+err_disable_sclk:
+	clk_disable_unprepare(rga->sclk);
 
 	return ret;
 }
-- 
2.53.0

