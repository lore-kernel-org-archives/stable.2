Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B43164D6
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434539; cv=none; b=unMSMSZbMDNHTmkdQNDLNszMyQlkLfzyOzwjb16kKt8K1RRKXlMTI/fOJTO0cnXEmVeMRoFjxZjjwI3WepWruzA8XysWaMrFbmhLlVLCnVNdJGa/u4oeQNAr0YV4IH7spuQDnX3qZA1wOIOFd4DCaCeg9bgm87NS6gNUy0jdLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434539; c=relaxed/simple;
	bh=VN+1E7Ggrmb9r3vg1FtqgtE5D0dYCleTF5eIdAx6oLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbrz3b9K+74Gw0enYUmQ96OoGMVwMPBYoCIu2rgiacujGKu34qebogKvLBDYv99b59ultWQzry9K87mTqqRM+kWvz6FW7rBkI2mW/NH2GSgznTnCGiBCdG0pANG3DeqT4IDjkq5VQTNoj3Wo/6JRmK4rB+MG+bNzALGuodkS7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSbbV6ki; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSbbV6ki"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c4so205595385a.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789434536; x=1790039336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zuhD7bbPqMz9xYO8EZgChXwB2VgczRrhByJD+Et4u1o=;
        b=CSbbV6kiU6lS63kK6QigSaHOMtkDIj/zYQtfZlSALNXoNbj8NeX7U9UAmNnfPcXcf/
         m723BqXl96RiSWyJEisflxXoq/Lu+iJdi4tLtU3W/veuHOZmcspBtFoK26xFnYHB5RoR
         q5I6L0ZVOWFVID3zpF+7174l1/fku9P4PtPztwUSU3c2QfQGj1DXz9tWSnEvDnI0sTtE
         itzAyVjPyO3GvfdYKEIlyMVjtXPmIGtZUPmtVn+m+XNdoUCMOdjyisCL93Uwn38JAjXM
         iHuIYo/FanK1exeqEXrm6mIKoh2ki8sx/ivXD1T8igNdlQ8dcjtgcmhSTNI31uefc5Vt
         UhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789434536; x=1790039336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuhD7bbPqMz9xYO8EZgChXwB2VgczRrhByJD+Et4u1o=;
        b=CYzpnUCm/VOE4weJajO68lQ8WypQxmpS2DwBMPMPe3FrCZCcGuX7ha7+6gKZuHV2LK
         56tox8ZqDWe/oYZKEnGwRNOS1kREEB2rylM12ehgecluT6Si7L6A43sgROglXcT3hyhe
         HcR772k6N1OTjAhhA+F3UHSvFMzfGwAaMi+PY0fxbZAru905WYF74HjpTIOBI+9S/qLq
         eCA+iah8Z6JMUNdRsytis21CiEm/yW8NdtfhZ0J4ls4wt3sLRLpOze2di1TM28Egz9W1
         8Wm9NGC4WxVd8/grYziuYS7kxwG+iw3uhtkhUvdfkXz8cBOL+E4Lssk/BCoMzX3yGqYJ
         TZGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVf6M5AfGACdfG1itnnhmy1+9cOw96nsN2usv0AnvUNGNuh0nTJeBoLVnwraEN/zgT+Qlqjm8=@vger.kernel.org
X-Gm-Message-State: AFuF++kPiKndcNJbBYpX58mjbsxci0YoMqwmxTRNpJ23DWXRVZ57LF97
	yN4WSg1EKQLI5+iroSh2YtQmfra4aXVCgnkdt8ju6amXAqsKTPWZqLE=
X-Gm-Gg: AYBFou1IGQXqr0uvN7av31Rc+Wg9dusffTT4J+pDGbqLTqh1EjQM8zxJE9+0doT9sha
	DqXKXEVxWjO2dy4D5j+HcvlbnMaWKZDZ8MVn9WjFJbF0Rg7z9bpKtVyCv39JbbXjLEZ2gt+WqP+
	6fcY5Dlydc8CprRajlKzZtWf2qOhG+LOGo4EOi1y93cjKvkUQ2AlzLas3ynwFrZ+1VoDeQCMuj0
	UT4TePA65wmTC/ltUCT3BqwOj2+2krZgKGNuQqk17cMlks9rzBHIS9mCtrNcyREZRU4gpElqCNc
	hOjIyTFWNIX975gi2N2SkpKgGMG9dEpXtiCrk78yHWentZN1vS9+J1DCiEeiPcT25MJTsAxpbxn
	Gwq7S4F0RUw5r3AHoGD4qkemDxsKElUwaXR/4mRdprh7bBqYAQebLle4jq0P6KgYUZXKAyhpjXz
	zg32uQgyEBn89MJ6/9lLHp/CvWmBeWNQ8EmNwsfINMiHzapFeXZSI2wsMYleSkTrUjckWsz3gHH
	IbkhhuafxeIBLoLeVJ5bWq5KvVsofFOaip0daeX0gRVzBeQX2BnZm1/KxvAoBDGqzzFQQ5eYhwJ
	uVkP6u01h9ACrf1YipoZ9XtO9fLWZKG/7tQvSlK2Wi/n5U5fa6JUguDVFRk+gWVxm28QGA==
X-Received: by 2002:a05:620a:470e:b0:939:b43f:341e with SMTP id af79cd13be357-93a2987f902mr754452485a.22.1789434536496;
        Mon, 14 Sep 2026 18:08:56 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-912321108a5sm18935796d6.46.2026.09.14.18.08.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:08:55 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: sundance: balance PCI enable on cleanup
Date: Mon, 14 Sep 2026 21:08:49 -0400
Message-ID: <20260915010849.54718-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sundance_probe1() enables the PCI device, but subsequent failure paths
and sundance_remove1() never release the enable reference.

Use pcim_enable_device() to disable the device after existing network,
DMA, mapping and region cleanup on probe failure or driver detach.

The imbalance is already present in the initial Git import.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/dlink/sundance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -510,7 +510,7 @@
 	int phy, phy_end, phy_idx = 0;
 	__le16 addr[ETH_ALEN / 2];
 
-	if (pci_enable_device(pdev))
+	if (pcim_enable_device(pdev))
 		return -EIO;
 	pci_set_master(pdev);
 
