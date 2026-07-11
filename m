Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4C2E7394
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782377; cv=none; b=Wo7qtg/H8zI9rXwB8T4PfS9TdWAl0k3BPtuwITo0KJQQiTUpVUgyFmwWJuzPtVXetW6YwYKBtCdyPBSt1SJkNUoPUkcHH7E1Xbm+VWLcWl0FG5+iNW4gzV5gnJQ7fhbFmcYYNS+zX2nhuHgOqgta568VuD8v6nUq875csx8b5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782377; c=relaxed/simple;
	bh=8UpyJxckMHUMLlbtyRgGGg26hezMZtk8A8xmtE1pZOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGaMLZAc+8F17zRRtThqINLrMn81036P4Ewtir2pF6AjyAoHIzvRs3ROop5MGzQHAv/oHOXnvojdJuWB4qvTORrcz87T4rz7E+yjNp+7tpEcTsJRYZB7d1mufwYfrc5tr0TZPY9Z1th/aRYNEsRVZD33zs7gx9YmB+MSWjUnVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCoUiTr8; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCoUiTr8"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so15903486d6.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782374; x=1784387174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPPgg5HFLluz6FRieBbyWJGx0FqM2rMhvYorHbuk6xc=;
        b=fCoUiTr86kQgSOzvsiKKYan57Tzz96PAu1bQQFWsiLD42jy+sf5z5Q3L2+J0aeiwdn
         spHXZekJZSooLr+afeoljgnaca6KOzJErLXDNK7YtgLE3ncbupR3DZ8bbroJkBypCdXZ
         0oLIP3r9DOQeG5iFU//9EzXaLMGu7HFWkZnUbgNLz4/IexjiW02dCmnnU2uetLZYLgr9
         pvg4SsibPrwnEN2nVdJLm6NA8TOW7zF21ZTiTcPpZJY20UZjvbzD9UPLZpXVPg4MLTWY
         CpWAvIbC7ePdk/a/7qfcpiRLro7sdW4bit3PAIiFdERbH4ZbpmFN5KSxrt0uCoiRWdUT
         /y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782374; x=1784387174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qPPgg5HFLluz6FRieBbyWJGx0FqM2rMhvYorHbuk6xc=;
        b=mjtlgQsSspHaKVq0fJ10TI0TY4nfytFd+xCO3UuiqDBZdPzHgq9ahNgAYtH5z47Cm3
         XY1WF6ZeuITwM7LuD6qeAVe9+9bqXBkBAtVwpLkCkRcBBEcfXHQXJF+9scL6/zO7S4Cf
         zE4gcSUuqqn2OchpG1hL4PY1fhD3zJ2u3ccpSCQslramIon1g7H2YK5R5w563wcxFzOk
         fa0PbPzWYTRVMHmSA8Qq2KVQSP60af83PP5IDuXZUBaUjxe7lRScvNhP0/wf3QuA4v+8
         0uAzO0fsojr8O4KQe2v47TdO0ysakWzJpIE0FMQ3QrUEiAelUOp8M0/z8/pXoHTr+Epm
         /xFA==
X-Forwarded-Encrypted: i=1; AHgh+RrhNX/nMMA61me5hv3CUxSBIX698eROVDFcm2C50vdRVQy+YvJPD2alAqD1+CP1p6swhrGHiXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53h3pvihNddJJ8mrCeoCd1xvJyg7m4pcHbdU6qoE0S3CR6BH3
	YqKu9BhUmEt8p/6DOcmybvDzKD+XZ92Vb68Dap9MpDa7Q0h1sB+NOSDFocfORWsQFuw=
X-Gm-Gg: AfdE7clLKH+nN4Nik0Fhh0c/pEfowSkjrdQCkWLVH/RvA5N6s0Cmgx4Ll70EjXSzDJw
	ycYV9nGkxoOvVX1tZABBSNZ0p2rr2KCbjCIxXzvazFkvAqLhhNljzgGX8TEB+hWnvYcRe3sxXXD
	ojHSchqd/JkWRP5tAUs09nOYTSdUNzc0ARfs9T36NJ1GnlR/BMS2f9WlsXc9vSVavVqZ1TIscE2
	3NjsdB46G7HYobgLr7rV8q+xomkM3TGi1L0rwn4nNhrATN0jvLNJ6CarLQCJOFEls2Lgyr4qBpA
	xxJlJSoakW6TDDlaA9hC7oAINP5ropQInIpdHG2E47v16D0F40nRPDShFmrBweHJ88N96HLZ7OA
	HE1oQvZvq11vqO5ndbAzUuVUf4fAc5l43oNUGnU9alyXzMim7LYMI33AW7lVBYSMZ2rPwfzbCGs
	lwQTo1gaCXsf34O0JCvCD/Gr1CO5kUuCGNgre1jzXyF3NsgkgWvbJJWbKnDe74vtsbIEoGStiMc
	Fif+xVjrA==
X-Received: by 2002:a05:620a:298b:b0:92e:72a4:f282 with SMTP id af79cd13be357-92ef2c1fc21mr314510985a.46.1783782374433;
        Sat, 11 Jul 2026 08:06:14 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d68e5fsm464578285a.43.2026.07.11.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:06:13 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: iwlwifi: mvm: check BA-window station ID before lookup
Date: Sat, 11 Jul 2026 11:06:10 -0400
Message-ID: <20260711150611.2913332-2-michael.bommarito@gmail.com>
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

iwl_mvm_window_status_notif() extracts a station ID from the BA-window
status notification's ra_tid field. The firmware API allocates five bits
for that field, so it can encode values up to 31.

The station map is bounded by the firmware's station capacity and
physically sized to IWL_STATION_COUNT_MAX entries. Validate the extracted
station ID before indexing fw_id_to_mac_id[]. This matches the existing
MVM station lookup helpers, which reject IDs outside
mvm->fw->ucode_capa.num_stations before reading the station map.

Fixes: 3af512d6aac7 ("iwlwifi: mvm: support filtered frames notification")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 269c4b45de807..d373f0723e13d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -7,6 +7,7 @@
 #include <linux/unaligned.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include "iwl-drv.h"
 #include "iwl-trans.h"
 #include "mvm.h"
 #include "fw-api.h"
@@ -1227,6 +1228,8 @@ void iwl_mvm_window_status_notif(struct iwl_mvm *mvm,
 		/* get the station */
 		sta_id = (ratid & BA_WINDOW_STATUS_STA_ID_MSK)
 			 >> BA_WINDOW_STATUS_STA_ID_POS;
+		if (sta_id >= mvm->fw->ucode_capa.num_stations)
+			continue;
 		sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
 		if (IS_ERR_OR_NULL(sta))
 			continue;
@@ -1239,3 +1242,4 @@ void iwl_mvm_window_status_notif(struct iwl_mvm *mvm,
 	}
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_window_status_notif);
-- 
2.53.0

