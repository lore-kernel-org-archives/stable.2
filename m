Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C384F4043
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691172; cv=none; b=AnBsEl5eLVQg7bmq2uNNOjuX9I4RQ3HK5W1cATqYtds5WhD1MXo0Op7nHyKFcAt99hZof5UCgk8S+q4nTj3g1lpHNaoiUaIJKxbGLJFe0ERUIj8pMhwiib6wl5p4LunjQIWF9ZDLI49gUIEdvcapz0F9hMx7XCJee+C4cGt/AT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691172; c=relaxed/simple;
	bh=DLO+7t3bHpqzoEwg9AltS+fu9p+sRo+N2CiYqa7Vbmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1FGH4anxwREpeG8FLnR6Jn2VNFfpOj44e1kBH+fEHuvEAD9hL7fNktN5m/6S9Ng2yZ+2JvuApRH2BMvraQDg1BiCJPqpuTBq43vMhxaS6le0cQuz1r2aSk/S04BkrkdllliLlClHDrO53jTHIa91AD9MHTKpxQqgp/jndZALdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7U/L8BI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7U/L8BI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD8D1F00893;
	Tue, 29 Sep 2026 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691171;
	bh=Cjx0NTdOqEmXBP4QViyFD0j1PDJWAaScdECTTEdBvWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R7U/L8BIJszz6HIUozKp/35no/EyG1IBsn4JVi0mZNxfIP5qCTj9RZ+YaaPUkb0p4
	 FgFNKPzUGwHkAV6wG5q8dHavUKlcQH+DUJ29EoPymtEeZEPo39mtNMQ0KEpb/vvgWm
	 RpNndcxUSMd0w4fCgqCT8D96FXAa0+W0pVOqYPK+eUYJWpWogamrIEt6tGIr/17Sd2
	 GALky0PAb2i6e3yrjGbZplH+ZaNi9FcfDkwqvOCT1g9iLShzw0T1Qwd08ofw7lB9li
	 gI18jlQ4dQ8ZIx8nTyQi9zpBsN+kePgBArVHepTS2McW3aZy8CdNFM6Ska9VgLAVms
	 V66JyAYqaNTvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] bna: prevent IOC timer rearm during teardown
Date: Tue, 29 Sep 2026 10:12:49 -0400
Message-ID: <20260929141249.3537974-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092952-unknotted-program-cc12@gregkh>
References: <2026092952-unknotted-program-cc12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 77b1718e39e5c9f6956fb60807326af20baf889d ]

bna: prevent IOC timer rearm during teardown

bnad_pci_remove() and the probe disable_ioceth path call
timer_delete_sync() for ioc_timer, sem_timer and hb_timer, but not for
iocpf_timer.  bnad_iocpf_timeout() then takes bnad->bna_lock after
free_netdev() has freed the struct bnad.

Deleting iocpf_timer last does not fix this.  sem_timer and
iocpf_timer rearm each other: bnad_iocpf_sem_timeout() can arm
iocpf_timer, and bnad_iocpf_timeout() arms sem_timer from
bfa_ioc_hw_sem_get() when the semaphore is busy.
timer_delete_sync() only waits out its own callback.
bnad_ioceth_disable() can time out and leave that callback live.

Shut all four IOC timers down with timer_shutdown_sync() on both
paths, so a later mod_timer() is ignored.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1d32f7696286 ("bna: IOC failure auto recovery fix")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260922014605.588040-1-mhun512@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ inlined bnad_ioc_timers_shutdown() into the existing teardown functions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/brocade/bna/bnad.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index a3b6b9af0b057..437a87b1ed4f9 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -3745,9 +3745,11 @@ bnad_pci_probe(struct pci_dev *pdev,
 	bnad_res_free(bnad, &bnad->mod_res_info[0], BNA_MOD_RES_T_MAX);
 disable_ioceth:
 	bnad_ioceth_disable(bnad);
-	del_timer_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	/* The IOC timers rearm one another.  Shut down all of them. */
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.ioc_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.sem_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.iocpf_timer);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
@@ -3788,9 +3790,11 @@ bnad_pci_remove(struct pci_dev *pdev)
 
 	mutex_lock(&bnad->conf_mutex);
 	bnad_ioceth_disable(bnad);
-	del_timer_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	/* The IOC timers rearm one another.  Shut down all of them. */
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.ioc_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.sem_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.iocpf_timer);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
-- 
2.53.0

