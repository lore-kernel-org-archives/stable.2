Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050166;
	b=k20dfx139SG3/W9E0qg2EiIR5CMb7ZbNp9H44wy7cICUbFi5JR6V5kvArIvskqZzWckk
	 NVTNy3kYo4yfWAS44m/jKCIlvSEcsN7LOkgFDeP5Vo7ItafhWYoQ7loc1q2GjDguCF4Ny
	 84Dyej38nkfv6Ibt70faLq66gd2k/KUcjsBfRmsH9HY16oFUMoiY6DbRrVL0h4ZzcM8o1
	 deapKM8t8LFH4Tj7eZugTOlhQVFr1VfO2pJmSN89Y2uhMnUnqpWnTmI2Pcv70+ZxuKfg7
	 RcyDiQhHEL8z2eS+3a4mND9j921wYNR7V/oVKGgUiWapJcxvKG9K0PLkeqthK9ko7Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050166;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I3tKYGrhXmbUL1s2DQHLBegtCfpjn7uHG2Zd9UTTQOA=;
	b=p/WQD25aNtLgXi6Qlsvsy3wHItJh91JatWrlCpL4vaPEyBzyUo7cPHnT+2iz+xT8KXge
	 PVrE6gI28toxjxEmF51Won5tYOZycQFQ4wYc1KdPyvJOI1NvAFaeZ6F6Fu7yYbn2R209G
	 quZS1DC/YNeTmE6kFyPAyi05GkVNGnTd+CnEoR4xz68sb9gsTiMbdpnhw0CL92xcBRBMf
	 h+SMTIaVF/vSPVDHWfRtnACn5xIE2Pk+1V+NLL+HCcWJ6Sp/4/hXGX+AnPYZ/gpP6604h
	 54xI3wFMrNHj86+Im1yMt/fPxBrrG9Zzb4l+hmmmR8IDSVt3eDDR5twl4c9ZwFysFAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Cl6s2/fk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F08606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cl6s2/fk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F351F0089F;
	Sat,  7 Nov 2026 11:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050165;
	bh=I3tKYGrhXmbUL1s2DQHLBegtCfpjn7uHG2Zd9UTTQOA=;
	h=From:To:Cc:Subject:Date;
	b=Cl6s2/fk6eldY+TWMOFdo8t/+hHiZOOk5CkKuluuhTwp6jlKWT8Hxs8wfHxAzSpHj
	 z4WMH1l4dFXpbJqe0zvSByYtMEHhNSMq825PyYQTz2bF8skjQLSuFEAXj/03Zw4nno
	 fQLbBUt/5Oxee25inZWhgRNEP/LAVFsaYkIvzYdL7mKCwApIQAOAQ4Gi4nNJ+G++6h
	 qVbN6sTWezeHxcL5Ei8bKy2vRmseMBvtPnNqOb9WgyZtyVOxPQBMVwm746GGn8xrx6
	 WtncvpkXXWASb39naF4S7zrvxkDsIjCZweZ9ftTXEtduZ2nH5B1Y8dt6bf3ockGVY3
	 aEfxeRG8znlgw==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: omap-sham - fix crypto engine cleanup" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:03 -0500
Message-ID: <20261107061603-failed-5.10-be51ea091c65@kernel.org>
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
git cherry-pick -x be51ea091c6563158531e8c74e040552fdb1e28c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061603-failed-5.10-be51ea091c65@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From be51ea091c6563158531e8c74e040552fdb1e28c Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 12 Sep 2026 22:46:08 +0800
Subject: [PATCH] crypto: omap-sham - fix crypto engine cleanup

omap_sham_probe() allocates and starts a crypto engine, but the remove
path does not call the matching crypto_engine_exit(). The probe failure
path already performs this cleanup.

crypto_engine_alloc_init() creates a kthread worker for processing
requests. Without crypto_engine_exit() during driver removal, the
worker is left running after the device is removed.

Call crypto_engine_exit() after unregistering the algorithms and before
tearing down the remaining request handling resources. This stops the
engine and destroys its worker.

This issue was found by manual code inspection.

Fixes: 133c3d434d91 ("crypto: omap-sham - convert to use crypto engine")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/omap-sham.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 12d6dc68438a7..5e739415a0102 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2129,6 +2129,7 @@ static void omap_sham_remove(struct platform_device *pdev)
 	list_del(&dd->list);
 	spin_unlock_bh(&sham.lock);
 	omap_sham_unregister_algs(dd->pdata);
+	crypto_engine_exit(dd->engine);
 	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0




