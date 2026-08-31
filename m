Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E7306779
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181428; cv=none; b=qxtWSpLWZMHP6MtLPlTjjOqUVQbi89a9JNfw54IGoUOI7WO2IW2eqSSyxzW5vQzl7gNEvIfx2MOACn8ioIJFaysSzvXDyaN0SeDStuwveXUBpf/wSxtn6vrcppiaZSu+CSkoA/44OSkPD00wkNKOMadTFUmWOOPnK0r/LlYxxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181428; c=relaxed/simple;
	bh=JtRrT10yzm9fRrctsX/tmvcSl2xfmZY5ICiRplDLZlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMfvGS+Dk7icw6K1mz7Gy/khS8MMMQZovqStAaYsVtbXfvi4zt0sMyiPq6+kf6tdUj1Njn8wjA0aPWj1PkBSlNlzM8T61HeRD9Dr5Ufnh7Fi2voF3qpqM3mesTo8QP2Qd4sJUjNtY0o0DqLpxoIRzBzFpkz0QB2LGNuaFE9Y1pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgaAJ54Z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgaAJ54Z"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d8f2ed7bdcso2848195ad.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181426; x=1788786226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GI4/mZK5VgpY291BuG3CaB2hCTJccyuWSOR/bez6Oyc=;
        b=fgaAJ54ZHiPW3n3jZ2H1zio3wiWl16E5Vasn1OvdyaXUI7bmpU5m75I80AmOfhbEp3
         +tI4NP/JEFZYtID3j3aayU4BMEG1aZ99BtGB1JL9Rc3i8bcwxBeGVWKM4B2uvdsk1KQn
         GzSr90r/35At9b3gelvO8HGR73byY5uaVthYy4H9bwxCNuZzjThYtlvz9BVfd5iWeDQF
         hbPOT6ib6HxSKKh+K95yyDPcLPtRJ1ZkK3GZrxqU340vG4hAOr8yTXszfEpIuxWpSLHg
         36lBsSHfoWfT/zQJCKtaJ1GqpTZZN0HugfE5ykKLqeW1X1N0BlOaf9VwjLl2KwmOkVrU
         Fhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181426; x=1788786226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GI4/mZK5VgpY291BuG3CaB2hCTJccyuWSOR/bez6Oyc=;
        b=nDmInxbYlG1/0FtHcIK2hLPYvHzH5XnKhrcADuG+doAWfN8y2TLxn3jhS4vj1lx1vF
         PAqMB14D7F/zVlpDajIG+CI5VnR00U+mvtPlEtTeBzF0r1tP6PtFUZMGf4KkLhd5cvEi
         jGa5gfSy2+AGZh/xKBQUMWJDO88YVtuZ8vnxwccFE+TZ4l8UoK5gNhuy7CscSZGkzWff
         +WGtwb+WzGsOtnfakoZn2JoHnzJ+zXwcVYKOVUDVhxkSlO/a141LS2Xf5yyFnlBjOnNo
         e9G3KFlZij80oX+yL08C3z7eXo2BIZZmkc/RhrFRZNjv+UAipmeJPi830j4YSxC/hRPG
         dkbw==
X-Forwarded-Encrypted: i=1; AKwUvBxDEG3aveWY/M8L8o3uG/BCz/icHfWn2gIejhs3aaM1/Z92wCZSm/rljA4O8aapH2aQyikTdsQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kf8iewmKI0LmFsmQ/lQdEX1xB+uTxSmUjERI8kZk0wDgT4XC03
	ukpjIhMgrsgHvclFp6mD2A0TXoEl2dHftoYrWAFrSZd9CXRh9HxCc2BT
X-Gm-Gg: AYBFou3RlyCbzgV6B7fh8xnTr5GbSYFHRPwLR9cVa+qm+/VqP934DIx5eQCQGdjakxD
	hB9ettXnm9Jkt1xcbpALDM26eRKoRGRQU6bWSrmB5rAciutM9nROiOID9m2GfRH72ZQgo+Oh26a
	NHcPAAMg5BTAEsI9ffJfRlB7VTeGF9SlJtxHqOB3IfHgVn0sQ8V+U+IlM8o9GpO1aeOE/9Q1T1J
	M7Wwx8KYvjKSg/UXPSkvw36qLy7pYz/E4sbwLPqYuwLrncRjG1l003r3k7sRWOeKpAQ/6AAXPAU
	RkQI9mJBIt++g4iELF0m4tWMv9TRXRwbVP/ShEdcRGQXUSfzN2omeW4teSXh1D8DJ1R4UYWuyk6
	d0uspptpl9WqbrqUPal6ZgjSUdzFfT0+FiJWMkIA8koBV6R5zwxdUz21CMuBSjA6/3yhE+dD4cz
	81Fc8rJ0rAB8KmqzNvHbfcJMtvfdG15Ewv9DpJKgTFMdycZKhC/zJza9qSWDpdA1l1hanelj6XB
	zqvg+L9YN4zjqCEcCgA5mtjszCv
X-Received: by 2002:a17:903:1104:b0:2c9:8287:fd0d with SMTP id d9443c01a7336-2d74df62ccemr213174865ad.3.1788181425049;
        Mon, 31 Aug 2026 06:03:45 -0700 (PDT)
Received: from cachyos-aura ([45.112.149.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bf283sm32567749eec.8.2026.08.31.06.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:03:44 -0700 (PDT)
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
Subject: [PATCH wireless v2 1/3] wifi: iwlwifi: pcie: don't infer CSME presence from a failed read
Date: Mon, 31 Aug 2026 18:33:30 +0530
Message-ID: <20260831130332.323549-2-navonjohnlukose@gmail.com>
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

iwl_pcie_check_me_status() decides whether WiAMT/CSME is present from two
register reads, without checking that either read reached the device.

iwl_read_prph() returns 0x5a5a5a5a when it cannot grab NIC access, and
that value has CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN set and
CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT clear. A read that never reached
the hardware is therefore taken as a positive statement that there is no
CSME, and the function returns without scheduling the recheck. That is
reachable at probe: iwl_pci_gen1_2_probe() carries on when
iwl_pcie_prepare_card_hw() fails, and iwl_pcie_check_me_status() then
runs against a card it cannot talk to.

The second read has the mirror-image problem: an all-ones
CSR_HW_IF_CONFIG_REG has both ME_OWN and IAMT_UP set, so a device that
has fallen off the bus latches me_present to 1. So does the one in
iwl_pcie_recheck_me_status(), which runs a second after probe with no
guarantee that the device is still answering.

me_present is never recomputed after that, and any non-zero value makes
iwl_trans_pcie_reset() downgrade IWL_RESET_MODE_PROD_RESET to
IWL_RESET_MODE_FUNC_RESET, so one bad read permanently weakens the
recovery. In the 0x5a5a5a5a case it goes the other way and permits a
product reset on a machine that may well have CSME.

Don't take those values as data. iwl_trans_is_hw_error_value() matches
0x5a5a5a5[0-f] and 0xa5a5a5a[0-f] but not ~0, so the prph read in
iwl_pcie_check_me_status() needs both tests, the way
iwl_pcie_irq_handler() does; the two CSR reads only need the ~0 one. At
probe that leaves me_present at -1 (unknown) and still schedules the
recheck; in the recheck it keeps the previous value.

This does change the reset ladder in the poisoned-read case, and -1 is
truthy: a product reset that iwl_trans_pcie_reset() used to allow -
because 0x5a5a5a5a had been read as me_present = 0 - is now downgraded
to a function level reset. That is the conservative direction, and the 0
was never a reading, but it is a behaviour change and not a no-op.

Cc: stable@vger.kernel.org
Fixes: 41fff83fe6cd ("wifi: iwlwifi: pcie: check for WiAMT/CSME presence")
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
Backport note: the bug arrived in v6.14, so the affected branches that are
still supported are 6.18.y, 7.1.y and 7.2.y. All three have the code in
pcie/gen1_2/trans.c as trans_pcie->me_present, so this applies as posted
with no rewrite.

Only if you care about anything older that has the bug - v6.14 through
v6.17, all EOL now: v6.16 and below have both functions in pcie/drv.c
(377edee91b89 "wifi: iwlwifi: pcie move gen1_2 probe to gen1_2/trans.c"
moved them), and v6.15 and below spell the field trans->me_present
(cd6d6de694e2 "wifi: iwlwifi: pcie: move ME check data to pcie" renamed
it). The hunks are otherwise identical; iwl_trans_is_hw_error_value()
exists in every affected release.

 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 28b276c..c6a771e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4194,7 +4194,8 @@ static void iwl_pcie_recheck_me_status(struct work_struct *wk)
 	u32 val;
 
 	val = iwl_read32(trans_pcie->trans, CSR_HW_IF_CONFIG_REG);
-	trans_pcie->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
+	if (val != ~0U)
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
+	if (val != ~0U && !iwl_trans_is_hw_error_value(val) &&
+	    (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN)) {
 		trans_pcie->me_present =
 			!!(val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT);
 		return;
 	}
 
 	val = iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
-	if (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
-		   CSR_HW_IF_CONFIG_REG_IAMT_UP)) {
+	if (val != ~0U && (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
+				  CSR_HW_IF_CONFIG_REG_IAMT_UP))) {
 		trans_pcie->me_present = 1;
 		return;
 	}
-- 
2.55.0

