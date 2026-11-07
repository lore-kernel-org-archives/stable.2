Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046649;
	b=PJjmqIXDRytSxX8zUVBoH/40AJyLcMYqXUr6ZlU6esrl0UdZXrPS0woAyiIY4FWPeDYr
	 BY88Jxkud0mEALtybWaTr14PN1C3+a6JUhR84pV90p0Wjixe3yR9VD4h42BUiXMzVH8js
	 rfu8JaaAwIjusUYT5KDSDDT+fEVCW1oTdZxs4g7tbtM/RvP7vmJ0TnZDnCkh1E1pGi9+k
	 xrs4GdCJx4c4qH9YPzFtu1x6FttTwDzpvAdyt4C2Lvf0ocQ8H4IHKbGnq31yqTgArnAxy
	 xlThKtbWEsme7onpH4Im+pD0lpzT9i5X0hPWx1a7TT2b06vGUuva3zROpbKKbCjjpAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046649;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cxR7DLefFJK034K/cZh4GX9CaGn7ATS0/Tu74blhRoU=;
	b=yPJPp+oAOKbLiFuyofLoHcsnJ7Gk7+Mw9k1LjDDmolBSNSpTHAike90UIEYMfZ0HZLKZ
	 swjib3iWKsUxqWZN/EmW4HTC7vMieIvlGOJKRcQP7mpNCDgd02KDXV0dZ3LGvYVS9fh8s
	 dPtsKbIWOAhm9r6gaZHVGcyc4fgIOBe4aJi1gP3U3Kw1cNna0UMmvwuJ12kLZ9yaGSEzF
	 3Rj0hPvpfkW5QG+MAppJB4Fdc4nxjz+WnKOKOcNDXL6bWIZ3F/TnL91xpoozNcOLSF3j0
	 MTDa6BAXAttdDVmvmXZUNrCByfAl1lSZfH2ml3ekAEaFllOe4L/8YfTD6mTf0BbynAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=is1VHogd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BD608D94E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=is1VHogd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15B31F00902;
	Sat,  7 Nov 2026 10:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046649;
	bh=cxR7DLefFJK034K/cZh4GX9CaGn7ATS0/Tu74blhRoU=;
	h=From:To:Cc:Subject:Date;
	b=is1VHogdx6za0vJ3d2Owfvd0sysTrM9YP0h2qDbU2wiiBAdQxO0tgFiZBK4rKnbLL
	 P6hyP/FF+aoOpOXu4elSedy3pTpbHVt/dUBK9sBT+DmCfCYdC0aEjt7Fm7W/LPJBm2
	 505QGwygGJasecl4M+STAmu2Mg75goTVyKzqIRfwRycgE+p8HJO36W9MNAcJASbi3+
	 nrVyXunNgdzyZVOteLDyZ7ZBVW8Omy8RuY27gyjyNpchtwndH/ZT63thL9eeHMyThC
	 boa8I1O/EbrL2rrZWE2fK8wX+5Hq2IqTVZ3aIw0NTZRKJ/eG/7O03oVJmXlfR/WSFe
	 nLLP0MEeWi9Lg==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: serial_ir: Fix race condition where timer can be re-armed" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:27 -0500
Message-ID: <20261107051727-failed-6.12-d74ac4016ba6@kernel.org>
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
git cherry-pick -x d74ac4016ba64cb3b20f395511d0b18025ca0ba9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051727-failed-6.12-d74ac4016ba6@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d74ac4016ba64cb3b20f395511d0b18025ca0ba9 Mon Sep 17 00:00:00 2001
From: Sean Young <sean@mess.org>
Date: Tue, 1 Sep 2026 16:20:18 +0100
Subject: [PATCH] media: serial_ir: Fix race condition where timer can be
 re-armed

Ensure the timer cannot be re-armed.

Fixes: 2940c7e49775 ("[media] serial_ir: generate timeout")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/rc/serial_ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index 992fff82b5245..f6702b3df9a03 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -798,7 +798,7 @@ static int __init serial_ir_init_module(void)
 
 static void __exit serial_ir_exit_module(void)
 {
-	timer_delete_sync(&serial_ir.timeout_timer);
+	timer_shutdown_sync(&serial_ir.timeout_timer);
 	serial_ir_exit();
 }
 
-- 
2.53.0




