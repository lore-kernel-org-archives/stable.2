Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163833;
	b=eMCXa3CQBGD+pzjyVGXDNO0G8LqcFl47wR35uwkxkx4VtmdR3d1I+4hHwMhd0DutEQuh
	 DeM9Rr8m8oWWgwWNoIePNG0CSKtxg3N9YrhiTPayyRHBHHkUlSIo+zASQ5rQHlDMR5lcT
	 CLYr9DJeRGFjw7FKGTW+7lKkIvC00Zcp9mZ/VGw2Bh/29ARaAIbzPlMoxM8idTnlWznk5
	 p6nIWTqWXVRY4l+jDLxkDu5+nJUYUatat3Ofss4WaD92E4YyuuiHyeGj6g0j/9UKgppuw
	 bkpH/QcZVGoYIrZAXWaF0C4D6pjMTqW9qVFpzAwW9elehLhH0/kT21roGlpxlUrsrYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163833;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=K1YZ6fRD5stM9wVm0/hkmxvxcUi/OB/8Xg9oORiLlfw=;
	b=gmdjStaoRMjYoxyWAK6rsM+Lr0mY05puQVrxT3dG3HXR9d4pSS0KO6NRxHALwdGPtlQh
	 vqhQSUiFE88peT2UgCF+RhpUYnM1vOjOfsoP6NuEC8+iJnwfQCzOOCh4rTl4D4h/qSiL+
	 l2ePCfsz0NAvGewpxwnusUeuDwugyxv0NYyJh/RXIbuUTYB1eEhYWXlGmXZzJnmtegHVA
	 0+i/K1LTXv6hu4bqcCOcVY+6xJ44cmBxwwGzj5D+5lPYN5wJNuqrDsw7uiXr0Y1kwQUox
	 fGrkyFQT5+zA/0514AwO+7IUndpSHxWOv2Xy8NNtkmUWbRGvIsjO4UEt3U565se2ZIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YgDtqLXI;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7E606A31A;
	Wed, 28 Oct 2026 05:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA7E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YgDtqLXI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=K1
	YZ6fRD5stM9wVm0/hkmxvxcUi/OB/8Xg9oORiLlfw=; b=YgDtqLXIFkkPZhv6RU
	BVvm8hYOXvi8B23GrN2iCr2HAxErBDD46q30b+CeTfzz7uCu4EYnK/Jajax767sG
	zioI9Yh128v/pH63CddAbSX4eFdUFJf+S1Mp9nd1pmwM/R3iYTc/C6jEloxfJBU9
	uOOl+A98mKAPYP0bslLfJbjLc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X28rguFqvXzDCw--.30877S4;
	Wed, 28 Oct 2026 13:03:42 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/4] wifi: iwlwifi: mvm: clear P2P device pointer on add failure
Date: Wed, 28 Oct 2026 13:03:35 +0800
Message-Id: <20261028050337.127464-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028050337.127464-1-yaojiale02@163.com>
References: <20261028050337.127464-1-yaojiale02@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X28rguFqvXzDCw--.30877S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrKw15urWfAFWxAr4Dur4rZrb_yoW8JrWkpF
	WDKFyqgr15Ka1UWayUGa1fCas8Xa12kws8CFyUJw43CF18tFySvw1v9Fy3Jw10kFW8Jw4S
	yrn8tF43WFnY937anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jD8n5UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8A6++Grhgi5m3wAA3m

The MLD add_interface path publishes p2p_device_vif before updating power
configuration. If that update fails, the remaining interface state is
unwound but the pointer still refers to the vif that mac80211 will free.

Clear the P2P device pointer before entering the common cleanup path.

Fixes: 84ef7cbe90e9 ("wifi: iwlwifi: mvm: Don't always bind/link the P2P Device interface")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 6ea9a7c8da0c..b1d4419a236c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -74,8 +74,11 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		mvm->p2p_device_vif = vif;
 
 	ret = iwl_mvm_power_update_mac(mvm);
-	if (ret)
+	if (ret) {
+		if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
+			mvm->p2p_device_vif = NULL;
 		goto out_free_bf;
+	}
 
 	iwl_mvm_tcm_add_vif(mvm, vif);
 
-- 
2.34.1

