Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA0423794
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323781; cv=none; b=QdnnGvirajzT3LhqRvzO9S8KRB0TbF2hX+s6aWzBnziYQekkr/8qIz5HQt5K2WmohVp07Az/QkPK/r9BsfN9rUOfdK0VhAF+5vAbIlrXR5vA4/TqnHgHFUU3HvzFBfXZ7qtHVyqz1tpRNJKIcugs2oxrWOI7grzoq0ItByKwNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323781; c=relaxed/simple;
	bh=vqFCCW1lFLH1nazKpux1BBpVGIKiX/RW0r/sAxkWwL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2VlKeC9BnVVYcVmgtBKyL+MNPk4vmcz/taJFyhj1B4PQQTeI1yNP/yVYEeM+yq2L0WYSBY4mfbPXx8h+aJXGMkHAaz8BPbxHG2JUALM0YLDJjs2/1wvb89UirFtzRcyno96EI6kUE7sdGiH6SS5qivYcEDeWHyYsSYIzYOY8CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7um+4E2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7um+4E2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506461F00A3D;
	Fri, 21 Aug 2026 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323779;
	bh=c4U99MRfI92PlI2yPjYNpCigvVyUuw0h14hbOxUCYK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d7um+4E25EbhpOXIY5zcDH3XLYqAmptR+qCKD9Xff4TsDJ/j1do7e6TWgc9qrwu55
	 A7A1B3RrMkh8yar7XZIeCMZyPUQKFtRzEPZekKtmv58BgLKWyW9o37kbFP/013k3lv
	 mHHKH0X0gHDkNB8kLAPdLzFoeUZuQ12HxJFXMnp4SRrYhB8BVfYfTeMnta2Z1My2HU
	 nUvtwgHudJW2tYrEb8NqDR/aUml8o+niAGU5OznigvGuj03RZCi8tV9qwl4tnrp9IU
	 za4nSmRXJNepzWoXQjp25TCuZxvMS8LWUZd7W86t9a+G1+Ge5xMg7fYVb2D3P0klqa
	 7R7Zx7t7MJ6Xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Fresi <luca.fresi@bithiatec.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] serial: sc16is7xx: enable THRI before filling TX FIFO
Date: Fri, 21 Aug 2026 10:49:34 -0400
Message-ID: <20260821144934.3428649-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821144934.3428649-1-sashal@kernel.org>
References: <2026081755-unbaked-recycled-24ab@gregkh>
 <20260821144934.3428649-1-sashal@kernel.org>
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
index cdf24617cf10d..f0ba5a930b2c3 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -874,6 +874,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 		msleep(port->rs485.delay_rts_before_send);
 
 	guard(mutex)(&one->lock);
+	sc16is7xx_port_update(port, SC16IS7XX_IER_REG,
+			      SC16IS7XX_IER_THRI_BIT,
+			      SC16IS7XX_IER_THRI_BIT);
 	sc16is7xx_handle_tx(port);
 }
 
-- 
2.53.0

