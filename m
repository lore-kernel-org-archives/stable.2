Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1A2C21E6
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782378; cv=none; b=KUWTOEmXrWMy8qD8KR0tq+rzY7oL1GCyuuHebW1WSfqrG4lLDdkt2V1HVINAj+kS6yYAFF82FF5UoNtji0117c5k5XR7OMZj4mz8Wz69XaRbuGm03Ajgm5gWT8cF4IgQ5RV5V/sYYQLv+x3D5+Rc0WhegEXRN93NiKpwC3Q8EtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782378; c=relaxed/simple;
	bh=b0Csvthvox+ZikmYZaH+PCSy1gktpVVyy/GCAs1XN5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxfoeUXjlgiDVYzypff0jOpgMeG2KceTNFEKFLs3tLXRsoqLnLKzm8rOVE9t1Bs+eRkOoVk7ctN8lGXDs3RIU3zlJShM1gpBAbADIob3rq3f/nxWgeszse//LRNcJkvMFp/dTWUicp1JKur5YiKZ8zyXK+A8P9rcXeLMYmhu2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBxwkMw9; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBxwkMw9"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e85499ffbso152190285a.0
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782375; x=1784387175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gg+ng2VSqRvXrUN5u/dXzTCEv77wgL5YHqysVwmsFOE=;
        b=KBxwkMw94dijwIu7KeD0+36XbwQhET1hFLojN7VaPTWFLs1/l2g9gGRVX4e5bTTvhj
         fxfbXO2We+eT1/sQPC0LnW7DKsmT+P9NfO4fgBVmBlzftcab4a898a813DUecYViNCTI
         ZFwxwecQfdWJnfJDxwjHu7fnBvedDK5vZXBngJeTeDzLG2O1sHJXHnMi9IlLdtWmOTNW
         cLJDLa6qe/zFhJ9Yg0VeKenfyL/e7dGuEokGAPTofvM/AobDktwSt1iC45GSFkoLGN7f
         +aNNuJWzWW82h7EtO8UPdERB5dtHPs9GxkJbuKvEh05T+ecDMvh/J3M/EgIFPrYEqdPP
         dimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782375; x=1784387175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gg+ng2VSqRvXrUN5u/dXzTCEv77wgL5YHqysVwmsFOE=;
        b=OPkTXyiJwtPVM9fYNeY8zlPDfIVfDR0imnlP9XtZ7r8y6A8+guBShHZlwBvBYVvCKc
         n6fMykSmreYryQja8AaxZciaUSGDg1bUHgSOJZU6Ed8hJEoWJNQEa1/nvSNdGA5atye2
         gHCGQ7N/oj10ESvMa4Ikc08OEdDEAE8P+f5/Ss736Ph0Ptf9FgJvHmhDRkAGDWu/Vabr
         YCGCcArlHq+5+G2YAzPhrVT+mVFnHO8n7lAVr3Y9MeT80dimIeBWazg0zvu6MTyRQczT
         XLDmM0VO6OISQ78aKYk4MAtscYTPdGwZa1ZBkI8USSTsyjzfUCJR5CTiA5LTlAktGxUs
         J/Eg==
X-Forwarded-Encrypted: i=1; AHgh+RqNaPpNW8n8zWCohKdE+TTYjcW8dlocuFT69eBJ7Dzpaszzy76wcBsAskg0bjEOiUEYpT6Rfhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynM2RtnnIfJ9eMbaTAZo7llQ0bepvVZal/Tfgc7fkPq8mA9sg1
	NCd/ISxZVm9SiZ1RxXVIJU3D0rvPskFq48diIxwQwMSMqG8wRsMXZoy4
X-Gm-Gg: AfdE7ckglP/3eXdU55fkxzab8ZwdHkp1A85cyOIFerxHD89T+iSSOCVhG8v4XK9/EwU
	J8TWOZKtHvBK1fyDB/SJgvKG0ATFVMTb6QRuo706/yMLbjHg1liRLkIm98jVwS5GacWqIG+FHan
	5luCc2rYDyqEofLo3rBjzcssBbtETdfWiIQ3FoC6rPnCGKnW8rqsnOu3twiISoZqL4spFt6zhR3
	SS2WuVQrcwIUu3PzAFWhuO/ogdGGDgznfKupX2PRh3fOmyW0Nv73r8/2k+Yf92YmziyGPY5HTCz
	8afIpeLIrxI22gIDRfDrAxWQz3ULY0HXDD3TXg4MfvvXIHlZIkvpYQfL7+428JNXEtuz9s6KMD2
	YGYWCBM7D9InoQaFK2TTHOE4yoJ2PcHQ6LbgmCRoiE6PO5cp0+RJLTMf0QQIZcvfrmONP08dxuM
	7OxCyLqsjCvD8U8+gXt2l6EvYGBEvPw5KI8qZXxGlaGuN/kp6Dryse5LZcoYLWa+tRIE3y8tA0X
	47ZFj9CgQ==
X-Received: by 2002:a05:620a:d8e:b0:92b:6805:917a with SMTP id af79cd13be357-92ef2c135d5mr363868585a.66.1783782375630;
        Sat, 11 Jul 2026 08:06:15 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d68e5fsm464578285a.43.2026.07.11.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:06:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: iwlwifi: mvm: add KUnit coverage for BA-window station ID bounds
Date: Sat, 11 Jul 2026 11:06:11 -0400
Message-ID: <20260711150611.2913332-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711150611.2913332-1-michael.bommarito@gmail.com>
References: <20260711150611.2913332-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add KUnit coverage for a malformed BA-window notification carrying an
out-of-range station ID, plus a valid-ID/null-station path to exercise the
adjacent non-bug branch. With UBSAN bounds enabled, the malformed case
reports an array-index-out-of-bounds splat before the fix and passes after
it.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |  2 +-
 .../intel/iwlwifi/mvm/tests/window-status.c   | 77 +++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/window-status.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
index 2267be4cfb441..bf22750fceafc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
@@ -1,3 +1,3 @@
-iwlmvm-tests-y += module.o hcmd.o
+iwlmvm-tests-y += module.o hcmd.o window-status.o
 
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmvm-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/window-status.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/window-status.c
new file mode 100644
index 0000000000000..06807e2bdbc12
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/window-status.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for MVM BA window status notification handling
+ */
+#include <kunit/test.h>
+#include <linux/mm.h>
+
+#include <iwl-trans.h>
+#include "../fw-api.h"
+#include "../mvm.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static void iwl_mvm_test_window_status(struct kunit *test, u8 sta_id)
+{
+	struct iwl_ba_window_status_notif notif = {};
+	struct iwl_rx_cmd_buffer rxb = {
+		._offset = 0,
+		._rx_page_order = 0,
+	};
+	struct iwl_rx_packet *pkt;
+	struct iwl_fw *fw;
+	struct iwl_mvm *mvm;
+	u16 ratid;
+
+	BUILD_BUG_ON((IWL_STATION_COUNT_MAX + 1) >
+		     (BA_WINDOW_STATUS_STA_ID_MSK >>
+		      BA_WINDOW_STATUS_STA_ID_POS));
+
+	mvm = kunit_kzalloc(test, sizeof(*mvm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mvm);
+
+	fw = kunit_kzalloc(test, sizeof(*fw), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fw);
+	fw->ucode_capa.num_stations = IWL_STATION_COUNT_MAX;
+	mvm->fw = fw;
+
+	rxb._page = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, rxb._page);
+
+	ratid = BA_WINDOW_STATUS_VALID_MSK |
+		(sta_id << BA_WINDOW_STATUS_STA_ID_POS);
+	notif.ra_tid[0] = cpu_to_le16(ratid);
+	notif.mpdu_rx_count[0] = cpu_to_le16(1);
+
+	pkt = rxb_addr(&rxb);
+	memset(pkt, 0, PAGE_SIZE);
+	pkt->len_n_flags = cpu_to_le32(sizeof(pkt->hdr) + sizeof(notif));
+	memcpy(pkt->data, &notif, sizeof(notif));
+
+	iwl_mvm_window_status_notif(mvm, &rxb);
+
+	__free_page(rxb._page);
+}
+
+static void test_ba_window_status_station_id_bounds(struct kunit *test)
+{
+	iwl_mvm_test_window_status(test, IWL_STATION_COUNT_MAX + 1);
+}
+
+static void test_ba_window_status_valid_empty_station(struct kunit *test)
+{
+	iwl_mvm_test_window_status(test, 0);
+}
+
+static struct kunit_case window_status_cases[] = {
+	KUNIT_CASE(test_ba_window_status_station_id_bounds),
+	KUNIT_CASE(test_ba_window_status_valid_empty_station),
+	{},
+};
+
+static struct kunit_suite window_status = {
+	.name = "iwlmvm-window-status",
+	.test_cases = window_status_cases,
+};
+
+kunit_test_suite(window_status);
-- 
2.53.0

