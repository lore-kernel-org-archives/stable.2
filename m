Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050190;
	b=5QlIxLO9DNtiA48x1YahntKpoJEQsegVPXvR2Ztn1y/KXRz7opITJ0HLy8ec90UM717l
	 sLxChVlMtkwraQkn6h3IP5FKkfJvIA0MCyjjx6JHuB7rFd4VJOp4mjfMuy/Co1cD617kc
	 vyigWNquAF/H4iVWN+4PFdAZnJ9yuymbVHvmhsRJzvU6D8IJFD6lSh8bLiqrvegZHY62c
	 kfISYQ/Us041l9k3dqhR2vGoTqOJBe+RZUagvnqVQt1i5MIUDDV+wQqD5L48qDNoMAolD
	 k+WmJTtucuFz+3DEn8+vNeFI9yGGd0TXvzOyFfsV9rqluQF5uKZz9JyzpYNj4iij7bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050190;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hpA7TqS57zQgZKg/IzkKYf1aHGSeeHjw48XQpq0dM9c=;
	b=ihfrxf/6ETLh3Fvw1EVF06a/H3fgpUH7egH8HA7lGfIsp6zkex+Ts2CFefUDsuw22WKW
	 xtQWNHwdZr4609Yw2mefZPSQoyyIVtLzulR3Z0BFietn0BueiI/F0H8AN01t1NdAnrcTF
	 ildXIySI1EeQ3I/04NWJXskWc/iW7DH6UtDGSgAraISsf/HMUqsd49tmMzr8ADkIgd2Tl
	 A8rVrg66IZQoF0RhYT7B0n3LVExKSUxTKChcOJ7NYdW/JKThktnMFgouGfbJU/kgqZxbA
	 kbZEzzCFsk44OsKh+yjNsn57IRFtjvoFX0eCUTdmrq8Yz0SzO19WSS/WksVek+HVbBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkuZlMUm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D574606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkuZlMUm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95871F008A5;
	Sat,  7 Nov 2026 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050190;
	bh=hpA7TqS57zQgZKg/IzkKYf1aHGSeeHjw48XQpq0dM9c=;
	h=From:To:Cc:Subject:Date;
	b=kkuZlMUmeK3HZ6eApcfuyHhUsBW2/e9dJMljsEo+vc+95rlRZhPFGi/LpQ4q8ko/o
	 wfbekqG+uPnp1lcR5dGcdPCfdmnNj9WBdQoTqixMTFteixXS0h35GwQJXfQbD9Nulf
	 swXESfuRz6dg4am+qaNiKLR/ZGOS/eHj0u7cmdX6dm/GwzFTWO3tusVzgbjbjFTXdu
	 8Cl1/3sDdJK+UALRazqGutaV8+ZOHE+eEAFwHwEzRrOOacww2fpkR/UxtssvsZupfx
	 en0s5YapkDOpHJC1ynvKML2R+RO0xTfglH8do7mcrYGFZ9cqYgGlqxgAWcYMh63dab
	 oYk5qkQ70DESQ==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: serial_ir: Fix race condition where timer can be re-armed" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:28 -0500
Message-ID: <20261107061628-failed-5.10-d74ac4016ba6@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d74ac4016ba64cb3b20f395511d0b18025ca0ba9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061628-failed-5.10-d74ac4016ba6@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




