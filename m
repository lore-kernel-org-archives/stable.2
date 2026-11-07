Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048156;
	b=eMyVsCxj46dKTMj7vXLK+ri7uYVaInyErBKUvR/p3a3uq2SgJmvsBxse2efD8kCc0skr
	 aFYl23I/cGp2I7pAd6pk/c91sJSYQaOBctkZYlrJ/Wq9/GMkdtzBN38v1DMpNFV0m6R73
	 GJkYfdTS1KGNtdTWUZCYH+lkX0GA8XGW4fAAvWDHD10/XU1jsfoXObLZugbGiIihzjUye
	 NfAyWRs71CHbYUFYNA4923eEBSv6imzPGpvE1J4jrqIq2U6WlPfKtpMbjzs33e+y8Tn76
	 K9MMV88mECOGOXKjbHzI9GfGLgsWO46+pGa5xHOTudTekAj5BCNHBdzBgRxwbJ4YYZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048156;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=42JKTL1JN0qLpZmzsKzhb06BRm7pBvnbNNHnaEhmZC4=;
	b=rpRId5nq2V+pqrpcr514CYbVfi6MFqpFA8u5UU65D+TCHbQckYzQCf+TF3MC7AvhJnVP
	 R/eEMeWVOL0/DYPoFei84eVlMF5i+Hlog3jMMmLzJffgCYB3Cy8pd8Ms/jYMgCfnULuwu
	 1T5BIgIzz4q+xEV1+cTr0c9SbEkGo+91apFXWYQp+kPkQJ8lRiagH2ihvJ+qMVa+dw6vy
	 W74n60n39S5mSKt7WnSC7bIVqtyzN+hMdsk3/fxfSeS99ljV1nC9JK3BVC4PEMow5rscO
	 SXbRRWWw8xt9Z4o1MODIYrGMQkLELOKdMmaz6dSVBVlmltczV01lfmJ6CCtOn987Nvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVm0Ipfd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E75606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVm0Ipfd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2D01F0089F;
	Sat,  7 Nov 2026 10:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048155;
	bh=42JKTL1JN0qLpZmzsKzhb06BRm7pBvnbNNHnaEhmZC4=;
	h=From:To:Cc:Subject:Date;
	b=hVm0IpfdsKgv4cPky6FDjPxVlXjluE4uFFlHes7D5CTz/S/m6cCKVKlGneJVGzu/g
	 zko6bW401YFMRBpE3ag9NqpaMB0jR7+9gBTwZ1xMgoShrkEBSZ00IbtJlbn16+CdF7
	 XuSzxrFpqBL6yUNF6HxdRtZi/5pHeC5lf3s2qELd38tv95cYbGII5iFEVu8DRxONx2
	 2LS0UPqarmcIFOVh9VGGgCpLa40S6F2xkQItXiiNtZLbjGE4w4dRAujgaKK8B1aOt9
	 IyV9TCCB4HP0iM9s9CggIH4JUCBMglJ/50TBzjMAVeO5vapjfLL3px7dnh3ZSlL90u
	 rzZmZv/q587UA==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: serial_ir: Fix race condition where timer can be re-armed" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:33 -0500
Message-ID: <20261107054233-failed-6.1-d74ac4016ba6@kernel.org>
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
git cherry-pick -x d74ac4016ba64cb3b20f395511d0b18025ca0ba9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054233-failed-6.1-d74ac4016ba6@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




