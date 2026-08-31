Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367283264D7
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181435; cv=none; b=h1U06QnUc06ZkiT+VxDXL2OdvlZBYBeyZMdxxSLyTg3aEjYS4YecRdzZbrJN8c5peWG0RACBw+iaIaF19m0lOsRHH/XSRhh8Lyh3AZXcB/ZlVSnX7MKBpgc687kWuR1B8RRnUtCRnCseNFVBUzP2PLIb/Ep2Od+MA0oUZD8OZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181435; c=relaxed/simple;
	bh=V//q0jtU9XTTbMl5NPi6UcTLSaqr0Evx37P5sMiaSJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drVw/BD6p2m/ktjwkTJHLwil9aIjOZjTdzm1oEAR5TfIn2RvwACODuLs2A28IJl0dXhbxSJTtRsiYxIM8FXFJFZ+fR3Y71caNblWRvJ6Yqd6yUjR6kbMkTREjjIT7fc5iFLBSheW2IaRMg13EDcpsKAYitaGvIHAYFcqc4ApXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxKPQpjb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxKPQpjb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d900ac39ffso1713055ad.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181430; x=1788786230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIkEaTsAou/6x2ZpYenzr6Kjhqg+r06MkNAF+XMgBd8=;
        b=DxKPQpjbegPTpugshIwSDtMDpy+IWy8STxYwpvacmGquHLR3FStiBIvcOAovzr1eXB
         84RtL43V9rcMH5cSz93AMxFIwjgHMntKi6hGF+++1uO6e+UuwAvwkt0Le8ROMDNTH3Jd
         uXBueXeEjQu9qegDp0KfqwLsuEm/kleGtLwizmlEHYBQwUAWpy/IB5dicayxU13Ywi+h
         lmV+Q7N/CsZ9JYKvBF14qR0GrZ4DA2MlLqLcka86xOCbelviVNEDIbshSa1yF2bpaTvs
         cchAMIdPx92qiC9OhTWLzk+chWiTiW31dQ/62pqnrzguWGAQ9WrAvAjIscy8DKEj/aba
         tQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181430; x=1788786230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIkEaTsAou/6x2ZpYenzr6Kjhqg+r06MkNAF+XMgBd8=;
        b=s6heXZ5umfdoZfmnR+0lp66wiAgSi3aaVLexENiA2AjfHvlmk58/amUi02YWyXtiPv
         fABiy69CBZq8rmxtUDpleigo3EWDXqXTJgtNW/cVxGlGY4RRtV8WZoUEOzNm8tceE7p2
         H2tJma6Z7KmtrdNbc+hiVs7OrX3C/FWOhLtj8AfTZ81I1a2Qi8lIzMNdLl57EVx8f6/m
         RHJ0Q0qhmVjVsDsuStz63yea6iOPbR29wZHsFuA8IasHIJrGnReSDOJJfRp+NLSE114s
         RH7bCbgTAbd1umS4cmsxf40dE3RcMPjwKhvlKhli5whMTQZTgua9EkMNLN8x98woMkeS
         /m9g==
X-Forwarded-Encrypted: i=1; AKwUvBxwdVkUDm6egvWVXyqMWBf+7uk5fBimd+A82kOkt60BXz2rf3AQnRlvXO41Jo1IqRWs2vW5J70=@vger.kernel.org
X-Gm-Message-State: AFuF++kWgwt66GkkmgWE6cYpqAJOUdV92M4yGhconAihYZnkAT/b14Ac
	Y1Wb/YX97KiQtTGeBxVsZxOumZKYZ4EIpSAvGYdJKSxsux0I4IvQZh7q
X-Gm-Gg: AYBFou2596rdJVDayQXDbIp+bIkdqC92efLbMdhBGbbtX1zyaToF0NgJHK8ewIJGEjn
	MHFbAvvhMNoUElHnRk81mGASSCVuv1C12ObCwZANjJEbzLJ1WZBvorIQ6B0FUsw7mLVidrTMY5s
	/qFKz0rMQ16TPkJmXy+Qv9wltGnuDyn4TiGIizzbyrEYhMm1hT2QtLptQFM5vcPjmpUiC8wLryu
	u/cKEIMEHShA8oNYcn89O495Pai0jrbRyse8ke3JU7Nwz2ToWT8gJgvDVuFB9ysRGSttW8uMHeD
	gYQvJsJ3XQbvKbTgVq9VJ0834Qky74R2X2E7tGlGzH7Y1ieyGWd+FEqRusCnIYaIuAuBwm4x5CD
	pL7ybVzt4WqsrdDh/42omYvTRBdfGDXpyNb7SAdfOXbgxymrCk8jU/Qi3N02rDigeUFEU6py1Oj
	WxTgFKYRNxmWU4oBwDWxdsxAThzhTo3+dP67Yr1dwZhWfUbf7vuuEPsQ87cp4RJXTt76eH7tonc
	9fJ6tvVgQdsKnEDTToif3mWzMLg
X-Received: by 2002:a17:903:1106:b0:2d6:f09a:da1f with SMTP id d9443c01a7336-2d74e0bab6emr217965675ad.4.1788181429982;
        Mon, 31 Aug 2026 06:03:49 -0700 (PDT)
Received: from cachyos-aura ([45.112.149.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bf283sm32567749eec.8.2026.08.31.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:03:49 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Nika Krasnova <nika@nikableh.moe>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mark Pearson <markpearson@lenovo.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 2/3] wifi: iwlwifi: pcie: deselect the product reset mode at probe
Date: Mon, 31 Aug 2026 18:33:31 +0530
Message-ID: <20260831130332.323549-3-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831130332.323549-1-navonjohnlukose@gmail.com>
References: <20260831130332.323549-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mode that iwl_trans_pcie_set_product_reset() selects lives in the
platform's ACPI namespace, not in the device, and nothing deselects it on
the product-reset path. iwl_trans_pcie_removal_wk() selects it, evaluates
_RST via _PRR and removes the device; the rescan re-probes, and probe only
reads the mode back for the log rather than clearing it, so it is still
selected. (A later removal with a lesser mode does pass enable=false, but
that is the path that does not need it.) It is plain namespace state - on
the platform I have it is a named integer written by the vendor DSM and
read back by the reset method - so it survives S3 and s2idle. Neither the
driver nor _RST clears it.

That has a consequence. _RST branches on the mode variable, does not
clear it, and iwl_trans_pcie_reset() takes the caller's word for which
reset to run. So after any product reset the next escalation can do the
wrong thing: iwl_trans_determine_restart_mode() asks for
IWL_RESET_MODE_FUNC_RESET on rung four of the ladder, no CSME involved,
iwl_trans_pcie_removal_wk() skips the Bluetooth teardown because the
mode it was passed is not IWL_RESET_MODE_PROD_RESET, tries to deselect,
and if the device has stopped answering by then that deselect fails
silently - the DSM is gated on AML reading the device's PCI ID out of
config space. iwl_trans_pcie_call_reset() then runs a full product reset,
Bluetooth kill GPIO and all, with the Bluetooth function still bound.

Deselect at probe, after the two calls that already read the mode and
the previous reset's status back for the log - so the inherited mode is
still what gets logged. That bounds the window to a single driver
lifetime.

Note that on discrete devices this is not literally a write of zero:
iwl_trans_pcie_set_product_reset() also sets EN_WIFI_FLR and EN_BT_OFF_ON
unconditionally for !integrated, so the write is 0x6. EN_PROD_RESET is the
bit the platform's reset method branches on, and that is the one being
cleared.

Cc: stable@vger.kernel.org
Fixes: 9673c35486d4 ("wifi: iwlwifi: implement product reset for TOP errors")
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
Patch 3 also depends on this: it is the only thing that clears the mode if
the rescan after a recovery reset does not bring the device back. That
dependency runs patch 3 -> patch 2, not the other way about, so this one
stands alone as a fix and is tagged for stable while patch 3 is not.

 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index c6a771e..df89fb3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4256,6 +4256,8 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 
 	iwl_trans_pcie_check_product_reset_status(pdev);
 	iwl_trans_pcie_check_product_reset_mode(pdev);
+	/* a previous trans may have left the mode selected */
+	iwl_trans_pcie_set_product_reset(pdev, false, mac_cfg->integrated);
 
 	/* set the things we know so far for the grab NIC access */
 	iwl_trans_set_info(iwl_trans, &info);
-- 
2.55.0

