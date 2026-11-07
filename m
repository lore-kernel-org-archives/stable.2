Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048131;
	b=LcUJwyoU2FeNymBJo02xlbpV6ian6q3+KXoQXcFmbqYN8h5fro9F0r/nQbR6qVp7tkFG
	 MNcxdxLrJ1Ies1Xl+sMt1oJAbrR2jf6HUOQ1ZHm8IMLiIxkYJRbbrumFuk6UeJG17qN5P
	 BpyYAMBJdY6u18u8Zaj6r82oAdwIFoj50UCNjmW37HrwqEgJdIzmEGOiKUpfTfWtBxYyo
	 HYeRIFbWaxXj15L/sfcvavo99h4OwFZ5m8Hapm5MANPNw6oL+PuETONb1B6P7ZJWbHvO9
	 KwX3xltKP+8uZA/5M4+HR2aTtKHzkcF6Xy4AJzLfn9DMOIkBcM6COK60kpE8LWh3Xqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048131;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T2PdCi6Dyvfq6o5VNbDVAXNfvY/VpYcdDlBqWWlQxuA=;
	b=oPS/vtMEAkPPzcIz5T1FAakW7OF1r3QoZh2JRX93digI29WMqYRMdrOnS/yMI37jnGtN
	 2GgletRSDuqH5F2jH8qptt6TLeEzE7HqvU6W13BC+NpCrbx7hqDXZo0iOWbPUOPyVYb+D
	 kcKdBSotPU5QDNElN6qufXTV03rR+tOdBR/ZAyMSK4pvjD9dQthl9OjOSrEsWNLjcIbre
	 8hwz+d2udi3EdUa76e6bvH054Ld/dtW+XNYET7htxPKpsF7NJcxGCskXayyb8P/rhGB1n
	 p7gW87IAtyt8QZtITFgwgTIqUo1TGlTZHLvVn4w6YZ8c7TJt2SWgMRWu99d33xVBqPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4LUahmP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4LUahmP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CC21F0089F;
	Sat,  7 Nov 2026 10:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048131;
	bh=T2PdCi6Dyvfq6o5VNbDVAXNfvY/VpYcdDlBqWWlQxuA=;
	h=From:To:Cc:Subject:Date;
	b=C4LUahmPKPMBtNykAyyzgTkzjUTFMi9vMk1yZraRGiwDIbLnD6hP2pzt+2zCMUDGr
	 ddjdwvI4cwV5o1woY2+jQkSNmcAafhd7w2c9iiB+XH7R2I4dyBkH3qIY/LRIHJdUPp
	 ibgc65JNDk6ckm64uu32dVIXyUWVLuxnX6WFE5aOz7PaTCUWRe9SetL187HkkoLnZp
	 YsRfw8CKGys6/HgDJr9X6Ace4LTW9VD6eDfHEC0dSTxbKgypWF61dkHuODWzDhtSPg
	 jq4vQ2Uwmjn65IjR6szy2qD0JXc8dkWpHVMGDqNhZxbVEU7RlQBw3JX7qtB2dvRo1r
	 JCnRygP0blJJg==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-des - fix crypto engine cleanup" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:09 -0500
Message-ID: <20261107054209-failed-6.1-5d69ed4cd4f9@kernel.org>
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
git cherry-pick -x 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054209-failed-6.1-5d69ed4cd4f9@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5d69ed4cd4f9c68ff9a6ebb2e8a1079223a4ec6e Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 12 Sep 2026 22:41:16 +0800
Subject: [PATCH] crypto: omap-des - fix crypto engine cleanup

omap_des_probe() allocates and starts a crypto engine, but the remove
path does not call the matching crypto_engine_exit(). The probe failure
path already performs this cleanup.

crypto_engine_alloc_init() creates a kthread worker for processing
requests. Without crypto_engine_exit() during driver removal, the
worker is left running after the device is removed.

Call crypto_engine_exit() after unregistering the algorithms and before
tearing down the remaining request handling resources. This stops the
engine and destroys its worker.

This issue was found by manual code inspection.

Fixes: f1b77aaca85a ("crypto: omap-des - Integrate with the crypto engine framework")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/omap-des.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 3b7104cb4487b..4b5a8d13f505e 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1082,6 +1082,8 @@ static void omap_des_remove(struct platform_device *pdev)
 
 	omap_des_unregister_algs(dd->pdata);
 
+	crypto_engine_exit(dd->engine);
+
 	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
-- 
2.53.0




