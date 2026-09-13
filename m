Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26E3839B9
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334085; cv=none; b=f0WQeOEWYroWksmqwLuyD+EbRYQxOMJLKBLJozU4y6LooLLpwAESCX1HMWKIpb4FmAGqR1YvpS8pqIagptrH83//EwR1+4zvArPEj4iaeTS1i1QmbsUfd54Menode3bjcsqhU7TjAE5krnUg+DO+2YOZt4WlVlbPtQ2BB0huUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334085; c=relaxed/simple;
	bh=RYuywvqdjTiryWx0HZMQXcmBWyUUadoRXwkVxaTdKoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+1BZN2Rqmf6fJ1msXAZSQmof7kbSIOR3VGCJ+BPjb3q8xUEqrU84Q1a67/vE5yHMFaHzHnWcBL0Gha6heWFD1eOqp1C0bp06wVbQwTWZSCmknQOOe9jXL0MuFjJkdH5cHnhxdQg+PulHDbL0NpeqUtW4/7x9DEozSZBH2EUck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5QRQrxj; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5QRQrxj"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39da614ab21so278608a91.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789334082; x=1789938882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=keGOAuFWtk7eVvvyNyqZYN9zhPLoleoThR6yxbotHPY=;
        b=r5QRQrxjQlldyKYYQjyCWVKVir8Xd/FKtbgNcRWheFkG3pyyRKpPEkVKfIrQUjXRKo
         pWgRqOaSoVl6cTEdptFOmBdhGFqv6IzxQi8HNXLFnQn44hbkY2WS++Wv5wumLOunNzIZ
         nT/Vp50zfIElETcpgyghrYO6kqTfuEdrFrn5Uz9gcvFrN4+FjySshrT5acUgAmVbWuO9
         eceH+gN2EICREwqMxD+8WS2WTAa0ml+ASJORW2dzQVidLi1EJJ+7ymr3cCdErDOxwDMl
         gSFqT8LsGokh570emrIhmDGPObZfsRR1PPbLetCHwAvxbtz+zvVyXaLEsx+ZLq3IOled
         vtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789334082; x=1789938882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=keGOAuFWtk7eVvvyNyqZYN9zhPLoleoThR6yxbotHPY=;
        b=BtduJVsDB8LycUwAtSHS6Myz2XtpRcUCF3Il0zH+4e5/lxsfdVwELdc5b0Qdue1w7m
         +4rurk2CbvqQw3QBX8336POgEheMJaKocmCYcEbZl3tOJKpA5HrK2TPFmLo7o4hhT35d
         D3Hsv+ZgpPh1cMR3fmWrOxfh1WNDbcIfIum55bpNDP/Y0uP2Jg97za3e54Ule8r/0m6x
         4+T5dqE/Dobx++Zxyecb1ljsy3OktM7zd+VkX/J+JlXPOVkdVERU8f/6DwUnaUjLbtbW
         aEla+MMeO1Ir8ZA+1x4+bj/FkyqncNh5Ah8mM9dFaPDP0pECDD1v4AVk1XgwciGC8F2d
         n3Og==
X-Forwarded-Encrypted: i=1; AKwUvBwPYraMuMsAzBife7IInWDNGxofIPFVLrhgiMhw97aQzryhYo9K8FzlhGr3qp3MCBZipQ2t9QI=@vger.kernel.org
X-Gm-Message-State: AFuF++nFHF3xtvQFnA7pwuJNlP8kQI8tCyDXhXKZ+Go5vzt4MauFyebZ
	OGTjg+VjEcVniIfRWSwrSUlsFhPr2UF8DR4XRA0y9Z/nVKAnhxIpM1Zo
X-Gm-Gg: AYBFou0yihqCn3IlDQPUa7xy0/na3T9+gqUe72hZv78sk0aixDokm034OpuPUa+fAXP
	4+EX93htQntg3NpB3ozI+U5hvkvD90IuVi2tOtZYthuUIKAgXSeGTZ2t1CHm0OZ9Fo6bL9wldjz
	ImVGdWyhf3UWqsrwNjQu9pXDXTdDjao2foT+exA7lOoHYyhJHc9hq5pzKb3YGYtnnylf/TU8XfY
	7hayQbS8Qevgfp6P9vkEKotIntelaorc6RIBXNEx0FMPI91l6jCGmuclX53R4WsJd56a1cdv3T3
	XYBjx/P0Gd53unEQTcCwEvKZYqlZHxCo21T1M469qvIFEMH9FtzCqdSJzrnIEgDHBEeCU/fRI+R
	E1EUarW6/IGEoxV8kWRC3Pa8LjDDx06ndZuhbT/jxS8REF6ac/2Gs1lvAgICxJV7yt17eML62AP
	f3HTnnqh3oNvgCOd67cU/2DEea/K9C9+Vpe1s7ibnbiZVHg+HIMYw0BmS/4BqPYQzivKp3j7ZQJ
	SGBaCO2lMc2cc7SR73R5YpB7C7Z2ymwRHOYhRVjKl8FMk73UDtq8+ZFz/jUSHvPMS4vxCYR8vJJ
	N7Wfa2OpTv7iB4gPfnK/
X-Received: by 2002:a17:90b:588d:b0:398:bac0:238d with SMTP id 98e67ed59e1d1-39d9c362f8dmr16743869a91.5.1789334082514;
        Sun, 13 Sep 2026 14:14:42 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm21382925c88.3.2026.09.13.14.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:14:40 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	emmanuel.grumbach@intel.com,
	nika@nikableh.moe,
	mpearson-lenovo@squebb.ca,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v3 1/4] wifi: iwlwifi: pcie: cancel the ME recheck work on probe failure
Date: Mon, 14 Sep 2026 02:44:25 +0530
Message-ID: <856bd0ddb7f3391aec28e6af710edb077204076c.1789333511.git.navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789333511.git.navonjohnlukose@gmail.com>
References: <cover.1789333511.git.navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iwl_pcie_check_me_status() schedules me_recheck_wk a second later. If
iwl_drv_start() then fails, the probe error path frees the trans without
cancelling it and the callback runs on freed memory.
iwl_pcie_gen1_2_remove() already cancels it; do the same here.

Sashiko's review of v2 1/3 pointed this out.

Cc: stable@vger.kernel.org
Fixes: 41fff83fe6cd ("wifi: iwlwifi: pcie: check for WiAMT/CSME presence")
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 28b276c..a30854d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4369,6 +4369,8 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 
 	if (IS_ERR(iwl_trans->drv)) {
 		ret = PTR_ERR(iwl_trans->drv);
+		/* iwl_pcie_check_me_status() may have armed this */
+		cancel_delayed_work_sync(&trans_pcie->me_recheck_wk);
 		goto out_free_trans;
 	}
 
