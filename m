Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046918;
	b=R6VXT9ag4T5JiwZca96E+nNFWT/v9QNhg5eVl1lglycR4z3xkUipFGpMyjGUcSosSeXr
	 3bUl5lyPAAuSaFiItiuUE+SSgfXdRvf+XPZwpFCD+AErKPF+o7D4e2uhsLT1fzM0NSwT7
	 lic3WhQATcN0sqkVtBlpIpieA3z5iY/r0G71XwgOwfCh88Ifafa/9todh0JQb1eY8x4XL
	 YOm+mFm1WqExG0OhDWF1NqrYEtDCve+1QQkhQgRnraVDB1VZYunDWPc9zAZvBZVKHPbla
	 4C691G+KmbdNuCSoX4ctEvSuAo2MkQA+zZcaW3uLZnqR0UQmCZzYRzjeTLc+XAXVpJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pVw+Hgi8MmoyG+oFoKlN1obFKEpaq3HCREC54OGwBt4=;
	b=L4NqZs3NrrDP3+PQxRUNxfq2rrTQDvXtmyAaqHSFP3r6Ar0uaIG3+W3Vy3ioDzHXfTo8
	 qKJ4UASM3wrNV98EBlpp+hb8Mmq1uAnCKUKTrS+24IjwejuFkMgRv49cZ3Yr9xC3TzObt
	 dFgXoEAeBVj7jwfSz7X4OcBQTnRdLzvg9hYRQmOighf3rqy37nbktMNfRhhmv19UyU5yf
	 ncyla6OvwZZRfD4+7syd7Jot/YttB0+oAFYtMsL6b/7YiIHVVQ1F83rnUTPdD0oN8NV0/
	 PFyqEDb5igR4pY1ahoB/7Ovok1c7yJEPd4x9044w2poywW8dMHGK5XPd5UoXzKjVQ2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rdcvxw2h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC926606D806
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rdcvxw2h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9241F0089F;
	Sat,  7 Nov 2026 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046917;
	bh=pVw+Hgi8MmoyG+oFoKlN1obFKEpaq3HCREC54OGwBt4=;
	h=From:To:Cc:Subject:Date;
	b=Rdcvxw2h07CBAaC07OT0kyywNE5pR5bWfq1yGnUkFTb2tuzoBp7zYCNyjlWl0hUDM
	 Rc11SI+oyNLwsxbnX/1pblWiP2PLu2FaOIVAfDMMLxQXBp1Mi2pyKaNakEU3Vjsa0o
	 H+7NILSwleAiG4dyylE30EG1gveszI8lbhK+w0grwsQi0BVgCan8YFI6p2EBMM88jK
	 oEsrbkt+2GIGRfrtb/KrFFcVXA7votY/jyY3tcli9mzjKVwyfEzYWHuxqHkUGKIoed
	 53ilzVPMl6vTfTkhp4xlEh81njZFXKZHSpaSRHrUyLkOlOq0ZSL7YU3Mzjp0A+wL2o
	 2Za+z75+cRpzw==
From: Sasha Levin <sashal@kernel.org>
To: martin.fuzzey@flowbird.group,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix data corruption due to unexpected xon/xoff" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:56 -0500
Message-ID: <20261107052156-failed-6.12-8bb50e95c0ab@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8bb50e95c0abd44607bc60a43032c1dbf7470d5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052156-failed-6.12-8bb50e95c0ab@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




