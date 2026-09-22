Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97032360EC5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041573; cv=none; b=u0L/acGRNv1zhpslGY6zP0EarixUbLTRYypZnbejVWP+ahp18dUTbcGYYZf2BnJ7QtEgBJaZfuHY/KFde1e+ZgOrbqteoYi4S5ut8PjyGe1Ppft/BA2p6Myt5Hrj8+l7MV15OuIjdWDptQ4Vk7OiiHJnDTCK0QO5uYmgftmKs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041573; c=relaxed/simple;
	bh=y+XAD1bzLlPmvSg9e/3OC75RDcM7A3CrfnaE1zi3yj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flUmuNvS6RM3Ss32y/udA7xKhykEJt65fbP50v5vCDGtmV+3LzI3Cds5Dro3T1Tbt0EqxZFg3Lk9ht3rSE2vMYkJS8FyaHWUxc9uZ9AQknBvd8QZxo62rshJ4Qj0fVCNeYIKIXdYsJXT1gk8rpdUTtY2SYoKI3w1hz4Va3zNPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwNHhgDL; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwNHhgDL"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-532db7db0c6so3927601cf.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790041570; x=1790646370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y8xPShnnQq1RRm8SZPF19MXAMPQrqUo2Z2vKGdJI+3o=;
        b=NwNHhgDL4rP/C/q35BW5E+4t4rw7psMkxYpIWrRf7Rtw2yYmiE82xVbc7x9E69lbgL
         ccBJ6OPJkKusO0h8nCldSxZwLhojVaYSsXxJ5jf6JRHSk45SlmTy53ncHVocjs2pXq9e
         ji//CEeZUuuSUtYufvXJ4IVhufQN6gA6Z5jRHqZ6nS8atrvq1Zf/yCmeVbThH2PSobvG
         TMQS7qBTvmSJpMEZqfkudm1R5GpPeubd/iL0Gkzl6KFr/BAdbX/+YrLtfX37x7Afgf4f
         XdtRwkyY7O1UjXwHGT5CoK2lvrgXIP+17QaR27EcEuMtfiw3ql8KpKDbsCf9jy4dMoI7
         Us5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790041570; x=1790646370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y8xPShnnQq1RRm8SZPF19MXAMPQrqUo2Z2vKGdJI+3o=;
        b=p0S7IJX8UdyEdzQrzX1nPRICbNP5gVwOYl3dB4fgLTOdxZyU0/oxLeXktqwuZcviWS
         NenDNmF5Al6NPwTB9oStbjvfvHF7Hr0LIBX0C1qw5JDlhmUmbV5QquKdPmvj7epaydaX
         SEU6y5OWXBbhKGbbrqzFn2PwZvIh3E1uZpk08odxOuoclX/XtFVOHTCpXiqESphrV9Pn
         w4edIl9Lv9PcdguIr4D9OA9VToJOKphe7D77s5LRyjr7ornFwf2cybqn1ddFw1YYhqzZ
         oyPXrx18T4uavcRiqTeRihVrCvCoRVrUOmz3XoHzetkOkH657WbIzaabBmyzwPw22Hj5
         Wq3g==
X-Forwarded-Encrypted: i=1; AKwUvBwjR63C9oTLN0hFVHJdC4xTmhewdpDRNmfoZ+bS79cJOYvnoEd4Q2mQFkEIGs7Za14g6xLp6es=@vger.kernel.org
X-Gm-Message-State: AFuF++lytBy86tgzL69He+LC8r8Dl7trYkPAcYyYxdfb+68ytOzQVG3l
	vsa6r7jON5dxMp//SkJBnNfCz6w8tJzQUlVappskKEQ6K0rgk8agUNk=
X-Gm-Gg: AYBFou2NF37hFd+rtACnPeQx7x0SXi3Vbqt+BxkWWT6DWFmYrxdmFqB5gL5EvS7+JLJ
	9h0Gprf0MbCNOt8g4tGTNtOR1fKCVvO1Nph7CXUpONF8p+ZsBbI8HqxnJk7aefwNDoSsPDQUQVt
	hle0CDUKVI59jIouqdpsvHpocJzLUJphwAINW+z8TfnnxLBFkTW5cvlIYyIuDZOQFIfVLEfgEJ8
	pg4rtz9aRgIWHUTB9T1xLj58vR5JCTvTWpmbaE1qaRVhw8Fi1zDRYBlnnf1OocbYDqd9x6iUfJp
	eX4If3UhlHkZ98yFFhQn34i9Edo53NSQhGaj4LrnJ8O5R6Ggf2/ZDHxW9emLAu3ftxb54efrB/k
	Oh7mGGPnh+lNFwF1rxO5sFlR96BdAtY7REVrXyB5Tvuf4we2kgff4F2mTw9rWxniSbVdTZEHoTb
	12k9obIuVx/RPDaAwQFkROwmPRFHK8BpH1IJqlVf2CTw86Y2pYvKQyoIJi8F2uZbKUVgsdrKM4/
	XGkXV8ncJVx3eE8GvYWBSrJ3xy7eNbiGgzCVfUb1AvGq/W5ZqvcwGwexmDxe/a0p9Q+XzrJCTiv
	gdW66I37Wt+2M1YxmZ6mn4pggJ43
X-Received: by 2002:a05:622a:1cc5:b0:532:c925:c31e with SMTP id d75a77b69052e-532d8d34820mr37916871cf.16.1790041570399;
        Mon, 21 Sep 2026 18:46:10 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e17123casm1228641cf.3.2026.09.21.18.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:46:09 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: GR-Linux-NIC-Dev@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] bna: prevent IOC timer rearm during teardown
Date: Mon, 21 Sep 2026 21:46:05 -0400
Message-ID: <20260922014605.588040-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/brocade/bna/bnad.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index 8b75004ba7c9..55dfd4896785 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -2571,6 +2571,22 @@ bnad_ioceth_disable(struct bnad *bnad)
 	return err;
 }
 
+/*
+ * The IOC timers rearm one another, so deleting one cannot stop a
+ * sibling callback from arming it again.  Shut them down so a later
+ * mod_timer() is ignored.
+ */
+static void
+bnad_ioc_timers_shutdown(struct bnad *bnad)
+{
+	struct bfa_ioc *ioc = &bnad->bna.ioceth.ioc;
+
+	timer_shutdown_sync(&ioc->ioc_timer);
+	timer_shutdown_sync(&ioc->sem_timer);
+	timer_shutdown_sync(&ioc->hb_timer);
+	timer_shutdown_sync(&ioc->iocpf_timer);
+}
+
 static int
 bnad_ioceth_enable(struct bnad *bnad)
 {
@@ -3727,9 +3743,7 @@ bnad_pci_probe(struct pci_dev *pdev,
 	bnad_res_free(bnad, &bnad->mod_res_info[0], BNA_MOD_RES_T_MAX);
 disable_ioceth:
 	bnad_ioceth_disable(bnad);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	bnad_ioc_timers_shutdown(bnad);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
@@ -3770,9 +3784,7 @@ bnad_pci_remove(struct pci_dev *pdev)
 
 	mutex_lock(&bnad->conf_mutex);
 	bnad_ioceth_disable(bnad);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	timer_delete_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	bnad_ioc_timers_shutdown(bnad);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
