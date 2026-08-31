Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E94A1DFB
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183710; cv=none; b=XuXkpOFqBnKEOhr4TZdg+VCaP3ROZKnPio4zQEM4ZI62/uneZk9zBmqHFAngT2yswd/Q+fZu3egPwDuzb64FbgaSJ8GbVJ2bq5zYgK3z5VNIDdT53CwT9GPxiJ3yWoQJDK6gfjyLK0OHsExP+kzN8rPruGxOXRJhXjCz6tuvs3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183710; c=relaxed/simple;
	bh=IMH5XC1IQty2kDprL4vVOLUz5Rdo2SwjUCPUHF5zKr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWXRfUoIB+NMQNMrbrCnUpIgUoIu/DXV04ohJP0sQvZuhE4h26WGROYW3Wa24jm8LfBnOEOMdNR3GYKXfS+SOY/aKUKwwqlbPMqdmbo4lPYDLuvmOo4fcFAmuQ+6OunCRcMMsYv0TaXICCLrvkv0zR9LB4f/15Uv6BC3dBg7e2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZDVK5yD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZDVK5yD"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-396555b8c7cso473755a91.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183708; x=1788788508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KrvWK7y12wmzNf9yKs8qJQvTPbcMwwSOqP849lffmgI=;
        b=HZDVK5yDk7ea1S4CDUxnX9LVpqoEFKBb0JHwtgNyj/G8afJOxq1C8huzipUFej2Uhs
         PZLwfI/X79ztsxmdbJF52j20q/kCxl77ovuyRFycQME63o+tWReFjoybngSQsf4J/FQ1
         kDSfokbeLeB7CyhGgx/wPmDJtfl0Dy+ntQT8tiIS+ELK66yXmcfmGo9B39qq8CVbn+Ek
         NniAElTDOhVmhhJK2XBiTWsjs2eWOhNqBKqYCm0Fa5QzeLyyU7Jil+DAM+1004ZtrHCV
         tD+3oWMYpHWzsTEW+CpbgZ7l+H3XvKYx+XfhVJboEAtTGyR8KwA7JZnNzcQ5+YBxYCy1
         A+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183708; x=1788788508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KrvWK7y12wmzNf9yKs8qJQvTPbcMwwSOqP849lffmgI=;
        b=lgzFF3xVKG8ARdS3/yPfItWIiRPsNPgd6sdYSFe8dQQE10nfMf+7dNBjz55A96oHKd
         ryQCOIDEp+4sn9wUWbPMlP1SI/p3kdXtIcMMVpszRRBMVLLQltkdpmhVkO5v4Hmodk4a
         6IT2us31VdVK8lESuLkyyTjwCVrCKqIwm1iqoewv0+ZXJrWefgDBRGl1iKCtgft+mRJ4
         BEKQenJnv6EK4ONEMl4ckNady9J3NzDDcsaOt5T7IltxHKDz8ksNkDZuj8UJHa8Rywuk
         tHsdCcQnO8JBcBIyrQRBaHuu7v4Z1axM8OKdDL1hMqUfY5kyjVkMcZ4t7iODckivrcJS
         x80A==
X-Forwarded-Encrypted: i=1; AKwUvByXpdzmad8Jz3u4NGAO7ATasnXUjA7xlHBSwIfPFVcyz8hcGUlMJhhqeVOaofXybFRIecrTm6A=@vger.kernel.org
X-Gm-Message-State: AFuF++lO/j6lqH1GeIKcfZfJclSN5I6M812GfJpa/w+miv4BWPFVFMet
	/SMq1smV7BT8RTCUeUjXGakp388k2urPt8+tcEoIPwtZ7RqxFsfQjTb+
X-Gm-Gg: AYBFou0dL/U/gZVVaVN4D5Zdq/LPnzCtwshvi6g/Zx93SOOMEZK6sUjzILqsvMtzm2S
	JtgLYmKtxIOzMCpzHnDOZQXCY09chdMnUTt1ofZofxAb1HRSmYVZEuw6Pgs9v7WiKaA7sHePxMj
	cJ4UsiyNlST/Q6r64qtTvyKpNxg9S4P7Kuv+KGfCS75+kJitV0jiLOPVpUmD9rBLfVchZfen3bo
	iB+3LJtn49WkSH/kCL1NHEbFsjZnnDzRgC5MlgjX+U6+xOi5hmAlpj01yjNrGAbeY1IbwHWteKM
	s+cwt8GcMPOF3xgHOfbJ4xErIw4ldGqC03GYZ7QUG2Dyw/K9zvNJYN1Tk0CLeO2jhkmvEzgDeli
	cFtCI3FA05/fWYP/fPlXqKupGXnz4nY1b2+rLg7nHKbQv3Rgre5IGHGTWFvgbFIJXJmckwpTeo2
	x3EGqMPu9AgRot24I6cYp+pLdj3KrOxKqxweclk4mOoJvRX5g90efs2MKtzWIq0aMAo2Qz7U2gZ
	EfN3reVVdf7Pp00Epf27i5xuGyT
X-Received: by 2002:a17:90b:4ad1:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-398bac28133mr12752617a91.4.1788183707208;
        Mon, 31 Aug 2026 06:41:47 -0700 (PDT)
Received: from cachyos-aura ([45.112.149.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be440sm34752102eec.7.2026.08.31.06.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:41:46 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: iwlwifi: pcie: cancel the ME recheck work on probe failure
Date: Mon, 31 Aug 2026 19:11:40 +0530
Message-ID: <20260831134140.480276-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iwl_pcie_check_me_status() schedules me_recheck_wk a second out when it
cannot decide whether CSME is present yet. iwl_pci_gen1_2_probe() calls it
before iwl_drv_start(), and if that fails the error path goes straight to
iwl_trans_pcie_free() without cancelling the work. The trans, and with it
the delayed_work and the trans_pcie the callback dereferences, is freed
while the timer is still armed.

iwl_pcie_gen1_2_remove() does cancel it, so only the probe error path is
affected. Cancel it there too.

The window is narrow: reaching the schedule needs both reads in
iwl_pcie_check_me_status() to fail, and iwl_pci_probe() already bails with
-EIO on an all-ones CSR_HW_REV before iwl_pci_gen1_2_probe() runs, so it
takes a device that answers config space and CSR_HW_REV but then fails
iwl_trans_grab_nic_access(). I found this by inspection rather than by
tripping over it, and I have no way to force that state on the hardware I
have.

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
 
-- 
2.55.0

