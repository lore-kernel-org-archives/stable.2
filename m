Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335470;
	b=D8zF+42NNocGuz3leHMbc0wZW/QBDDNhQtPD/hqTS2BEiecgYROYYETuGTR5OFCGXquO
	 iy91sg6SKLmS6iBaV8S/NMOK0cM3TuNRvK2IB2KerhAfoObNTBxorrvJnMctxH9XlPWXu
	 b1eDUYS05snKihXSdUbRq89LloRSF+aJykDcz00ouvyOj+OdY3fa/+aJY6/pX793GoQ4W
	 f2SHuInxaJ01q7/sI7sox9kJhvNDocp64fM6txIJPI2mFa6IP7wvcHdNsLsapKeYpLYJ/
	 8+6ZbJ8+BAHpnuHJDo9ZBIXDjaPrV1Co8Qu8hIXH5T1qrFhMWftl0OEyhH6Vh5zXRTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ytFhHp9n0JJXjnSz+V8pvrLLED0p/7nhoN5i0MWphzQ=;
	b=4516byabCr7mmJiZmhUSCrMsrm3tcqW+xW+fwxJyVsiajh1wq1Bhr5f63bB5sy9iH3tH
	 RO4alrJ4iyisSvIZJMfzGcAmxu68RBQEkLeW7zmSwk80+esqTv1Dfi7misWh3SRntAcN7
	 ZCjiksSggNtz92CQ/oiaidCbtlVcj+e1u4oyAyWVkd603HVU/EuzyLPe8Kc8TobHxThp5
	 nI2E5dILukc8h/rCQH8mB4+1I8hjnTQ+LwqcSbTYUPaSdImwwhL0vWF6JYuN3CP/L1RzH
	 4yUe4sAIhYlKuoOn5G7rIk2/qBzWcUXGJeRbdKY1+owSKLzz5zf09sHnSACEdcsogMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNiO6BiC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F959606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNiO6BiC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792951F0089F;
	Tue, 10 Nov 2026 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335470;
	bh=ytFhHp9n0JJXjnSz+V8pvrLLED0p/7nhoN5i0MWphzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VNiO6BiCL4DQxhgXedHr+oVJWLkBbYaPEdCE8SsdI+c5or2Ir6Sdy3hGsTSUYFE+m
	 XX/BdfvkF7clfNNFHR5SShE9b2ILxQ5THq5bHn1n9HDHppU4brP6Wp2eenfOnJ20/u
	 WSy70SsxgX+GvVhytDUKiClYBx0FvGOJjShT+nCa0F6MrMliZSd8sebTnSN0AleqKN
	 ajeADJ1i0RzsKCs3wJwBywnElGzO5TiisKKjYmxI6NoC1IqoH7m7KiwrczT3/AJ1nc
	 0RvRkyU2i5x5daQnUd+xj0iEzCAbDq7JxN4ZC6kyx8pPA7HU9O/CgXEZ6g73FnRCk7
	 znIKw98Vghliw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martin Fuzzey <martin.fuzzey@flowbird.group>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] serial: sc16is7xx: fix data corruption due to unexpected xon/xoff
Date: Tue, 10 Nov 2026 13:31:08 -0500
Message-ID: <20261110183034.3115565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051100-failed-6.18-8bb50e95c0ab@kernel.org>
References: <20261107051100-failed-6.18-8bb50e95c0ab@kernel.org>
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

From: Martin Fuzzey <martin.fuzzey@flowbird.group>

[ Upstream commit 8bb50e95c0abd44607bc60a43032c1dbf7470d5a ]

The hardware supports automatically sending XON/OFF based on the
FIFO status and that is already implemented by the driver.
However that capability was not announced with the UPF_SOFT_FLOW bit.

When the port is opened with the default of XON enabled the driver
configures that in the hardware.
If userspace does not want XON/OFF (which is normally the case) it will
use TCSETS to disactivate it. However the serial core optimises this
to only notify the driver if someting imporant has changed, and for
XON/XOFF thit is only if the  driver declares UPF_SOFT_FLOW.

So we end up with unwanted XON/XOFF in the data stream.

The problem only occurs if nothing else needed to be set by termios,
ie if the user space requested values are the same as the default values,
except for XON/XOFF.
Since the default speed is 9600 this means that the problem only occurs
when requesting 9600, otherwise the call to the driver will be made to
change the speed, and that will also clear the XON/XOFF.
As 9600 is quite rare these days that probably explains why this hasn't
already been seen.

It also only occurs on the first port open after boot since the subsequent
opens will use the "logical state" set by TCSETS but not communicated to
the driver the first time.

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@kernel.org
Link: https://patch.msgid.link/20261001100534.1225894-1-martin.fuzzey@flowbird.group
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: applied the flag change in sc16is7xx_probe() instead of sc16is7xx_setup_channel() to match the existing initialization layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 42ad926f1fe68..885c0c34b50f2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1646,7 +1646,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		s->p[i].port.irq	= irq;
 		s->p[i].port.type	= PORT_SC16IS7XX;
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
-		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY | UPF_SOFT_FLOW;
 		s->p[i].port.iobase	= i;
 		/*
 		 * Use all ones as membase to make sure uart_configure_port() in
-- 
2.53.0

