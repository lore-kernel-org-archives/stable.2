Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCCB3876A4
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334090; cv=none; b=sXvYrkxYwm5nfi7tZZLyoHwgyMdC8NMzORh7rGyPC2CkbnI6EqoTWJSGlBqoVfKZY+xDvo1vlfcNagcJmeFUAM79B5lY5zcRbeiNxPkMhNrNt8WuXSWYjD7n+smaDZjdrhu1wZ3wdhmkK9sXoyl9TGWY4xk/Jh8pAyqGt/2DWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334090; c=relaxed/simple;
	bh=pPoaZ6WN/4rsL54zfkdxxVZNYOjgO9uDq+DyE0P6oAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkLtlXID9+Myp8dtOaIqkYb4Hp33gdBpOCsnagSMA4UtkvOYH4jNvDI+uVDpii0+mi7l/dWbcZNYrPctfguRRzpmZ+D55JHp0J5JRLL/Eb1vZwlFYYtr15Tr7q7DzYkf2EqT4smlfnZbozfLQqYxUtr3ovmPhHY0jrxm4sHneTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK6yGtT8; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK6yGtT8"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd4ef687f5so2104315ad.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789334088; x=1789938888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZpCRHMmToydeaRFWtETHuU4TdBo7QJCJ2jk+hcXVaYc=;
        b=GK6yGtT8sT4fQuA6JTb+gE6Xl172A4Diy+aaJ9NhF+95yuSg+7mGWJ8S9luluzzO7a
         0FPRhEFaF8hT1dbNrOUA1S0WULjtkhjojPLgBKE9a9UmdIyka9p1HOsU1KS2jcgxm0Ga
         ruj1PnESJFaQwzeSTTLeraH7tSo5b5HbhQwkEu1jyksOSul6cPmhq/MMTWW17UvCh8Va
         Ioa8pXcibG2UnlY0lxvVOd2BISrvGdlxZp5MGkk5ELLTZTMjYNaVsL2FzSFBVDpJylmr
         GA6xNfGhOIWEm0PS+a9V0gPLGud+u1DmQTiiNr9dFRR/YG9AQ2O5f85SXdM/kt1G38ao
         tDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789334088; x=1789938888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZpCRHMmToydeaRFWtETHuU4TdBo7QJCJ2jk+hcXVaYc=;
        b=dPXnXHQ2dRtDvX9/QHK63UprEaFhEhzgv5tC9kGjC3266TLxNewF1sbDs85SXEujcm
         pSI1a0ivOwhQKBpXdyBjdPFSVe4LuG0aDnXX+bAtzxnuIQJtputBeBOMeWkRsbD0N0M5
         2j9xo16svD/7DJMhXKc5RN9K2pX4LNKHXhYMSC+G1tbMxhiApV2Av32XX5EZxLpoo5X/
         gyehs6qahM0T5xrW3yNJDvqdf3RTayR/usFwn0xpUXwOSQjMJ3kbBGVgXwlllCjd+JBm
         wf9e3eqHMpgV8YV4xPK0wzgmBgcQt1s3BisDL/AbIMj5eoZCE8q3YyGWfcPHhNmCi+R+
         vK4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzxI7Ur7T3mZuZNt8gZNyfOUQ0inoROy4QyyMq/GTtBceHu2smmt2VHGZYOADOYTStQ/WpOSvM=@vger.kernel.org
X-Gm-Message-State: AFuF++nKTPSof9VStXOFB4pOKzOHRe5Ggm9PhwyMz5Wv8doxoR5ERbEv
	W1q8KGoerGbM3Zz92Q7EBJN3WlsXMUQddiLv9L7P4Rh4e2pNrIH5bo60
X-Gm-Gg: AYBFou0D3oPxcH1ugjMHLajlBNPS6J5cRCIAp7ZMoHw1b9rl3W9ncnZHi8dc8J8qyc+
	mwMDq/0Es8cDCQA2GpC+6v1Am+5BIDHcLPYfnHsgWr3niTZvwWSAKH5wq4t07t1X8vkPEYh+9Wn
	k33duoBSazDUnn9atj82Ei4gmvhkoYbdeJ/EFipBmEBOvqqWV4kqvi9E4tyz33sDvffICPbod5t
	MZ99LflkZukaWR4Ixd4K+U0lnQBhs8QVF+MJsqjsqGpD4CKMFxFhZzJZSXGkOSyPoqSwmkuerAE
	zRLxtJB5UhV00gxxZEseNcr31QKhBiqpKAidphHuBmDdrWj1VCEGD9aAtPwVAOkHkMZNyglUJ5B
	xM1ZGjm1XUho32Hgai7RpO3wxw2+Se9RUoi+j9uc5K6PCDKgxEGNoRBFt5wBhQHUqnENyng/ef3
	+s2VmnTe/Dy8rziIN9Dg4SrZVYsPq4JgHC9vO6F160vdNcQ5VMO5kdBtMx1evKcXHSwSVQI4G9G
	rEBwb1OnLtE73v6+1PFWSEunLiMAaK4xWjueTMqWxXNBUg/uBVlGGywci4E69rlochttM1Nw8uB
	FcWNljaGUo3R0qrMDBk7MLahZ98Yv7o=
X-Received: by 2002:a17:90b:5147:b0:398:a2e4:c784 with SMTP id 98e67ed59e1d1-39d9bbc25d1mr15745452a91.1.1789334087817;
        Sun, 13 Sep 2026 14:14:47 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm21382925c88.3.2026.09.13.14.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:14:47 -0700 (PDT)
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
Subject: [PATCH wireless v3 2/4] wifi: iwlwifi: pcie: don't infer CSME presence from a failed read
Date: Mon, 14 Sep 2026 02:44:26 +0530
Message-ID: <dba458f8bff1159de447653b03a9f39fb60e9549.1789333511.git.navonjohnlukose@gmail.com>
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

iwl_read_prph() returns 0x5a5a5a5a when it cannot grab NIC access, which
reads as "no CSME"; an all-ones CSR_HW_IF_CONFIG_REG reads as "CSME
present". me_present is never recomputed and gates the reset ladder, so one
bad read skews it for good. Reject both values. This does
downgrade a product reset that a poisoned read used to permit.

Cc: stable@vger.kernel.org
Fixes: 41fff83fe6cd ("wifi: iwlwifi: pcie: check for WiAMT/CSME presence")
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
Applies as-is to 6.18.y and 7.2.y.

 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index a30854d..e5edcc2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4194,7 +4194,8 @@ static void iwl_pcie_recheck_me_status(struct work_struct *wk)
 	u32 val;
 
 	val = iwl_read32(trans_pcie->trans, CSR_HW_IF_CONFIG_REG);
-	trans_pcie->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
+	if (!PCI_POSSIBLE_ERROR(val))
+		trans_pcie->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
 }
 
 static void iwl_pcie_check_me_status(struct iwl_trans *trans)
@@ -4212,15 +4213,19 @@ static void iwl_pcie_check_me_status(struct iwl_trans *trans)
 		return;
 
 	val = iwl_read_prph(trans, CNVI_SCU_REG_FOR_ECO_1);
-	if (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN) {
+	/* iwl_read_prph() returns 0x5a5a5a5a if it never reached the NIC, and
+	 * that value has WIAMT_KNOWN set and WIAMT_PRESENT clear
+	 */
+	if (!PCI_POSSIBLE_ERROR(val) && !iwl_trans_is_hw_error_value(val) &&
+	    (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN)) {
 		trans_pcie->me_present =
 			!!(val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT);
 		return;
 	}
 
 	val = iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
-	if (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
-		   CSR_HW_IF_CONFIG_REG_IAMT_UP)) {
+	if (!PCI_POSSIBLE_ERROR(val) && (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
+					       CSR_HW_IF_CONFIG_REG_IAMT_UP))) {
 		trans_pcie->me_present = 1;
 		return;
 	}
