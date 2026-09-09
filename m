Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072037646A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974272; cv=none; b=B0HlU7kH6qrx6Oji5pnUrlR3rh7CBLdRnS7kvjTcJH25zcArvnxCubM1L4RRPMflN5IA689IUXTOTfKkg1FpUE0h7vLeHT7UwBaE9z71JzJ/qzw35vp9kONDVofUxytcRQ7FFL2utLmTiHj1j0cI6OrZfrie8Wl7HqwnpAhiakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974272; c=relaxed/simple;
	bh=j4kVuSZPCO17AwJ5MKvMnU/AROlTB9eVqd0owDrVmHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPvgfckFv9WMHbT+agZZgiBgl/KTv5nwzHk53dZYlYag/n7IUZ2URs1WnyDmIV4LnswihALLRbC5wcCyDta6mIqZWGhlUOTCdQAUfA7RfbhKlliVlOURGDVYc2l8qT5+fvsIWnIKdUkHBvCRyZ+EdWFg6NkA0UkgoSgzwyDWeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBqCwKjb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBqCwKjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EB91F00898;
	Wed,  9 Sep 2026 17:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974270;
	bh=Y7pJ6OxzG3T4SEDfVYkzKHNlsdO6Tc7AwBn6JEeUNvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JBqCwKjbmeI1Ltf8BM3FGLDRLxBX15PrPOC5d2SYqADHdc8DJ3D0psliLo1Ckoeg3
	 /vAHQweOGgCIm94E6UwVw3ESoUZLN90LZoI2MSbhVMHqQA08w/maqPlQwTIsPQ3TQD
	 7U2oNCQhcjmvpdoWT3z3n+fijWaVA1FXKAgrSjnDelS/v/0nNrTcZk338r7679FanJ
	 hYnu64CqO1g2yeK29QowM91lBKmhUTn3ZMwnW+Sh8OkU2NPDEoAVmCx9BHXfAapASs
	 RaSTk0PYTaoOb5nz3IIrEUUgff1Oaf9kTHctFc6vmLDtQm0l4/dTSZypPirLLXuNG1
	 zKLM29UG1Z68g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Ye <fy15309206903@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net: thunderbolt: Release the Rx HopID that was handed out on mismatch
Date: Wed,  9 Sep 2026 13:17:46 -0400
Message-ID: <20260909171747.3248535-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-language-antitrust-4e97@gregkh>
References: <2026090358-language-antitrust-4e97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ye <fy15309206903@gmail.com>

[ Upstream commit 2f1463554d0561a2fead81e3888604e5c1125e29 ]

tb_xdomain_alloc_in_hopid() passes the wanted HopID to ida_alloc_range()
as the lower bound, so a taken id is not an error there: the allocator
returns the next free one above it. tbnet_connected_work() asks for the
peer's transmit path, treats any other id as a failure and returns
without releasing what it got, so that allocation stays live for the rest
of the XDomain connection with nothing left holding a reference to it.

Release the id when it is not the one we asked for, the same way the
error unwind at the end of the function releases the expected one.

Fixes: 180b0689425c ("thunderbolt: Allow multiple DMA tunnels over a single XDomain connection")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260811-b4-tbnet-hopid-v3-1-9e75d1b51331@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 3c8b26ebf525 ("net: thunderbolt: Mark the connection down when bringing it up fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/thunderbolt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index 7a448a6bd3374..f329e1d407eb2 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -625,6 +625,8 @@ static void tbnet_connected_work(struct work_struct *work)
 	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
 	if (ret != net->remote_transmit_path) {
 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
+		if (ret >= 0)
+			tb_xdomain_release_in_hopid(net->xd, ret);
 		return;
 	}
 
-- 
2.53.0

