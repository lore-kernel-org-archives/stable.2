Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049182;
	b=ug4qwBy7tF8+5ElVZL2rnoA6ZqCFA1SdD7lP7GhIdmn8slj2f1B/Euy02JhpBKk0FdxF
	 5NYMdIeKS7WVAL9/CC5zaVXowZYEQF3lfxeWvGQIypx1ZjVmhWSquda46uo8I+6Zpzjb8
	 S/YbAlNOKJLZZjLaH7V5CwX39HcscjJDtZkFnfNwGmMg3dY9zHjyCfu+a9bXB0gF7ehtC
	 M3iaoc3LxzE/evsZgGrJObHMDcjqzVJqvuep60Wl/DJcEdUZjSZKtL2AGovewuJNEPZAE
	 7gg0xeKnbtNo1K44sJ8I/KIWISC8hqyRICWSV9LAhZV5K2pSvpuBBWL+d9CtHuiUsUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BHC9eC8DhpAoDI5f4Ux+ubxIZuovky+bIklouzy/gsE=;
	b=m6fNv3yuNJ8D6B7joAUjUomDQqpxqDk0w0A3iFvh+MCvH4h+l2jjdNzr2PcTGRFGdwR8
	 JBqKhkL5pdq8wgUAVArSbUP0ncZ/awWu5D+ycHgeJemYs5ODny6RY3I4p1x0o8p/yOrL8
	 wDK//Q6tz1SHkoH6kZSO03H9P/79rudSp4z342k+1A81eHbRCwv0YvbswPki74TTk7JAy
	 CEaXh7xqsi1L/DuchPA/J/OkPW1/YcRc6GXmE118jMmxLhvWkw8/x3XGQVWX3U4bW1gH4
	 Fi6/vM4CR3aZ0Vw1zObCcsgK3vkH77oPpTNp45SSDzgnCvjaxObz8DNK4szM3/e2FYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c/XYYu+i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2E606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/XYYu+i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B91F1F0089F;
	Sat,  7 Nov 2026 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049181;
	bh=BHC9eC8DhpAoDI5f4Ux+ubxIZuovky+bIklouzy/gsE=;
	h=From:To:Cc:Subject:Date;
	b=c/XYYu+iyNYSUoB2pzzouYWiwYP34eNe6iG7F8bhZYLMe4bjPlqnI3s2jYOzd7Clj
	 29/BX4p1aDaF5Xh0k4IRkwu/vhAIGpFeCuXrcX6S2KrA9rAFfhyx8vyqK31rI2CHo8
	 f1VpAC0HSTn+spe5m6oI/WWHgWmYRj+Ds5wK6XnY9TUB8zn5inrns24gw48Nf/4CZA
	 FXAoYxHEQmrFiq6/zwbI/NLOgpGSdFUfPSOsfuk2JHQvxG8E4a7QU+udU64PzZqVDY
	 IS1GweTLcSx3Ch/DCS080t8U7cQR5nojlIgAT5aDDNWQUJUW7w0g3K80/Mal+c8Xke
	 FgolUpQkNO2Ig==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: serial_ir: Fix race condition where timer can be re-armed" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:40 -0500
Message-ID: <20261107055939-failed-5.15-d74ac4016ba6@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d74ac4016ba64cb3b20f395511d0b18025ca0ba9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055939-failed-5.15-d74ac4016ba6@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




