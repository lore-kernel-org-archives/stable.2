Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336397;
	b=SlFePSIaGvR3IWK0ayXrcs2hjtnITHrf2E+Blv2cnfXbnP63dEu2rT0/2kTH5GAuUDjJ
	 yn3oKPhAjF24/E1Niiu9HQoHYCFLo4vJoFzo1DTuP3WmDgHemZfuZ3xl6BqlG7A2YP2zG
	 msGCGYnJ254GudbS/tS6bWEGYPa+aJEIzWzznrALsBf/1+yC/3TtJTTmJZtS5L8fDd4Mn
	 69tm/XHGEL0IjfU9oafPlUhuOwgNyeJGeFIqK9wp0sK46VDtGc3/gyYUD5AR8VuEQLoPd
	 qORQ1SN07/QlafqCGuyNqi25cdAmL02o90WTyUjCzD+V216jjDah4VBujW/KX648XRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336397;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5CK7WiIx21cPw/6PapMTRw1gl0OwkM/RjR36L7BZLJ0=;
	b=qdBlPNnpkec3gV3Cj7tJLsf+k/QPAt61If/ySkXEtJj+gOnmzlQHpTD79DwMJOd2UBLR
	 gCkXv54ksynaRZ4Xxi5jMoy+kxyk+bhR+4YdoJJSpCDOk+NvaeX6yTF1l0CO/UUtiFm8p
	 9VZSFYoYKO6sG4sdgWLuNm/Tnxr3K75fD0i32JoX87YC1It2qfgcka3NE7nCrXd60t6SU
	 WPt8ENDzW/Vz+zqz60P5u9v8u9VjgiPXoggo5eJeg50045dSzHNGm5sZrV4GpwGoMgGz/
	 MGv9eLQhjhDw3WmO2lpTs640347u1T57DKHCEfLy+cq3Bjw9O2GoARQ5XpXwCRFZQSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhrMP3nY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3C606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhrMP3nY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9F21F0089F;
	Tue, 10 Nov 2026 18:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336396;
	bh=5CK7WiIx21cPw/6PapMTRw1gl0OwkM/RjR36L7BZLJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DhrMP3nY9kwB+o30sHHqbm/HLA8Zl+kqjn9rhDcGiJNw9d5LWg8T2No3AhmqlgBFT
	 eFsZmRFF7dIkHy7YizFxo+FqvSRTKe519t2m0ZOkrvbMaXKgrBtHbtORwAl6t3xt04
	 JTLGX1D7h2nr/L/wBvFbEwCFlnPeEuzoEwHZYJF3tLw/Q4Ajr7vzBM9p3IIs88b+te
	 gFUlDddQA9vyKIhJiQqC4EVuSbXyDJ9YN+MyzmdiTqTsK6hJD7JCVNhJN2+/VieGNT
	 CKnO9YiMn9lSjlVSKBIkrBh1xzurvfnxRxqBeSytNvI512+L0x2zH2ksakL4D5zr6s
	 Joy5Uf0yGZ12w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martin Fuzzey <martin.fuzzey@flowbird.group>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] serial: sc16is7xx: fix data corruption due to unexpected xon/xoff
Date: Tue, 10 Nov 2026 13:46:34 -0500
Message-ID: <20261110184605.3404435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053422-failed-6.6-8bb50e95c0ab@kernel.org>
References: <20261107053422-failed-6.6-8bb50e95c0ab@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index b208181de2455..7eaf9af61542e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1584,7 +1584,7 @@ static int sc16is7xx_probe(struct device *dev,
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

