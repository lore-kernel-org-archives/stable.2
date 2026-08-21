Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42E45C71B
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310016; cv=none; b=LOlCn1FLXlrAarO7w9wlYMVOJ/8mt/QyeMUSrEvfke554OKT4Licf7Y0Sm7nGMK08+wQAQTnyvOg9MZMr0zUozFsu6SvCoifoIKDcsWDEk8OH8ovxh0IS2PNOxXTuLElSagJ8bpuJBZeitO4HSHuD37HG/9n4DwvpANXk2PHRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310016; c=relaxed/simple;
	bh=fLOYKOLQCXqn4fnYcGLYwLShMHwQSFkVJDxOcHWBhpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R50B285luBbyNOR0BWFufOl+8Os2B+cXfTmCefFriV9HFzh7jStCRNpU5i4wbSKGc1y9SYgoMGSlyPwGwSVp+jaShGI2+8BVPM6hFtNRYmwAOuv7CgLTAZ60nSP95gTZVYpkJXgp5M9QIyj3nWGe+g52C8+G8bbix/QHlG2yfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htt7EyGp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htt7EyGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4DC1F00ACA;
	Fri, 21 Aug 2026 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787310014;
	bh=HfZSrHAF28KRWRRUQoG9WQrHJFQt9Fy2iK0AqFlJL+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=htt7EyGpJiOBh6oasMd0CxpcRrcdvhBIg1iR4tCz8o+IaIzbSWIGYv5ec7WxrN6Bw
	 DFGZbJb1+2EqAsne/f3jFGFWR6Pnz0jHUnvSdNs1uIV7PQ4r8FaVlngn2HAxbl/n+9
	 1OxD9hsNNHwbFlIdEwL5Av3NBNUi/4E2f2u+OV23UyP369bCfh/DmtdhaeomncaONI
	 gzzdQx3Hy/0h7/Jq9L1pgdDNnNEfsRwcOlfjwQ2xVqRGfiAnvWSGBqgA0bcB3acr6I
	 d/HyirPP8knXEn+GzT11fpDEx/j4jMVMq1t44KKeAWco3ht5zdxfvbtakqc4sObeFG
	 L+dXgJGysbfcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Fresi <luca.fresi@bithiatec.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] serial: sc16is7xx: enable THRI before filling TX FIFO
Date: Fri, 21 Aug 2026 07:00:08 -0400
Message-ID: <20260821110008.2816500-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821110008.2816500-1-sashal@kernel.org>
References: <2026081755-absence-womanlike-85b3@gregkh>
 <20260821110008.2816500-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Fresi <luca.fresi@bithiatec.com>

[ Upstream commit 246ac114f485c2affb454240f3ea4fabfce22456 ]

sc16is7xx_handle_tx() currently requests the THRI enable only after it has
filled the TX FIFO. The request is asynchronous because the IER update is
performed later by reg_work.

The SC16IS7xx generates a THRI interrupt when the TX FIFO crosses its
trigger level. If the FIFO drains past that level before reg_work enables
THRI, the chip does not generate a new interrupt. Characters remain queued
indefinitely even though the hardware FIFO is empty.

This was observed on an SC16IS752 while both UART channels were active.
During the stall the software TX buffer remained non-empty while TXLVL
reported 64 bytes free, LSR reported THR and transmitter empty, IER had
THRI enabled, and IIR reported no interrupt pending.

Enable THRI synchronously before filling the FIFO so the threshold crossing
cannot be missed.

Fixes: cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
Cc: stable <stable@kernel.org>
Signed-off-by: Luca Fresi <luca.fresi@bithiatec.com>
Link: https://patch.msgid.link/20260721222404.204746-1-luca.fresi@bithiatec.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index d73bd07c864f1..02b74a695c8e0 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -871,6 +871,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 		msleep(port->rs485.delay_rts_before_send);
 
 	guard(mutex)(&one->lock);
+	sc16is7xx_port_update(port, SC16IS7XX_IER_REG,
+			      SC16IS7XX_IER_THRI_BIT,
+			      SC16IS7XX_IER_THRI_BIT);
 	sc16is7xx_handle_tx(port);
 }
 
-- 
2.53.0

