Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048478;
	b=miEYu+MvxicWmnulNmh4rdNGqy/tyQj0SQRPS12Q7JFHl7+661ovv4UVGsePdkkF5ZbI
	 e7RxsA9q+NUyRe6zCUPNCjL7NaMZxgOGHJVsxHZSfNGahO2XFgw6gaBi2fn7u1r0D8cCq
	 GGnZO5IIseVqSTsCHOF6EHnw9+JTkdZ5KJE2tvwrOdttH2ff0z326SirO05R3fAdEEjUV
	 CdE9Ey9uUTVLuKmjszlBc4xasbq1ru7KB4V2By4UiHTBMjtoO6WG15bcue7heqeQ70Hdl
	 lMKcZ09ReVrfhzAf9vArIUrWNKzzB/gRyPh28evLxBkim3Ravg/kvTyd0dEEXnemSew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048478;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R7LSUlRcNpKNmwJGaHF3+zBP7VrtRjn/VirNAwzut+Y=;
	b=k7bcGL0evz2eyf/C3BwgxmuP7TuYe9zsBYW0+t45nVZ5D1nFU/FkXuZeqZdggwb07Uop
	 WZIY4dTHcLdKgRDS3oBTG6Go4AtzNw/lkkyBFa1+2TY97LREDCuHc0UbdEQoSep/FY2rS
	 6OAcgmJ1f2xRL9uORWEglfo3EZ408DDscNiz90MvvpXEOA3ppp7DmUDsJqMd9IjbXp9AV
	 FDZaBsoK2H6pzBuliL7wnFuwSDV5ZQ3UAu6nlpV7xAkdUWt5rvSmk4Npy8x4S6IjB0IXf
	 o2Qvaj7lP9IlpHkvWwECSsjXl6yMkO17V7IqYNY4fFZHUntLmqTRs4jvFBj5TtxeHSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfvqSbza;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0782606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfvqSbza
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA3B1F0089F;
	Sat,  7 Nov 2026 10:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048478;
	bh=R7LSUlRcNpKNmwJGaHF3+zBP7VrtRjn/VirNAwzut+Y=;
	h=From:To:Cc:Subject:Date;
	b=LfvqSbza9ZGho00c154mpyft+gEPSEWTO1sDk13qEo6Jq9mC77I9Ldzo+T052hCP1
	 kHdtjrBlq021Meq0Es1QkAfYIla2wdG4BFrKd8Y8eyAwum9093MtkhVO1qkNGwmbrQ
	 7CH+ancWEILIr1bGy01uhihR8a0ormD0HRQ1G7r/5zDZRsHh7gTFsg8YwaRsTL6NWh
	 P2w7+ZicvdPz7WWLbVpplKGR0gaeUVKtEhrSvfOiakMUZz3pBvjXGxfYuDfU008omf
	 7gjYbGeukTeOsvJBSzyCgKZpT9kyj+ZFtWg7fA/RxE9UsmZxi9xpYBfIOZ0a+s+uKN
	 STXwDFw9Ro1FA==
From: Sasha Levin <sashal@kernel.org>
To: martin.fuzzey@flowbird.group,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix data corruption due to unexpected xon/xoff" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:56 -0500
Message-ID: <20261107054756-failed-6.1-8bb50e95c0ab@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8bb50e95c0abd44607bc60a43032c1dbf7470d5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054756-failed-6.1-8bb50e95c0ab@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8bb50e95c0abd44607bc60a43032c1dbf7470d5a Mon Sep 17 00:00:00 2001
From: Martin Fuzzey <martin.fuzzey@flowbird.group>
Date: Thu, 1 Oct 2026 10:05:35 +0000
Subject: [PATCH] serial: sc16is7xx: fix data corruption due to unexpected
 xon/xoff

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
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 296079c16fdb9..7ddc8a38adab4 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1516,7 +1516,7 @@ static int sc16is7xx_setup_channel(struct sc16is7xx_one *one, int i,
 	/* Initialize port data */
 	port->type	= PORT_SC16IS7XX;
 	port->fifosize	= SC16IS7XX_FIFO_SIZE;
-	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY | UPF_SOFT_FLOW;
 	port->iotype	= UPIO_BUS;
 	port->rs485_config = sc16is7xx_config_rs485;
 	port->rs485_supported = sc16is7xx_rs485_supported;
-- 
2.53.0




