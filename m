Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE6341077
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116923; cv=none; b=WKteoyxDo8N8D7r15ShqH85vEgHx+Mj5Vol05Yk6/NOC6lzevhnYPRelyxinN94VCqak4ua0OZ1EMJyWyTE9Os0Ke3kplY7fsX3RGQIXwkFkaDSnH9f2n3Wl+7/mNEpcqz4tpD4APvfpnAcU+zHz6N10XDW7u6Q9o6p/hhBvGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116923; c=relaxed/simple;
	bh=brkVOHrBWqwYBSh4vVHXBq8X4XZ3NU20+5+9rKzi3Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLCULyYw4uZ3AkoiR+DJrGQk5wdHuJeDOQ74imA7Z4f4A2mXIkbRCy8j+SQl8QvmC45Cxjga7OEFBoV8d6HwgoJihMnGmciGrWFDXa8+KtET14urq7+xPzaUPzewKuKqiV7KKEqhFktl1hldN1FJXXrXtVFAi4u265DNaiNXBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=NnWgu7OE; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="NnWgu7OE"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35943f55c06so708861eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792116920; x=1792721720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KetdpdwOSj7956r3ldfd9Rrxy2aA2uCf7cxzgWAH5cU=;
        b=NnWgu7OEV2E1Li20PRkbqSPkcWep5xv8fI1MW5pahOubHJrxUUKwrPcQV/MbT302zr
         F7uYl9USPUhCLbf0MBWIpVsAn0dl3QbqbKlfJusqdFFPNZYr92Tm3uGDtHGqWUQwweF6
         PjThNApX0ZJ3jkcrd1G0/v22Z2YQbUneG2E9u6yyNlh+1NpgClOkWISzAMcUDMUCo1vU
         D1HfnM3rhJCHtV2gShd0tSpijkpv/zJ3FMu9fvS8vLnTg6DELXoJSLCxxZ6tHBAw8ynm
         XnevBa8g2LBVv9jDq3D/YA/OcXJhL/6Q8Ba2jyuPE8dyYDLxsk6eJCIu70nf0wQUGZGS
         li9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116920; x=1792721720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KetdpdwOSj7956r3ldfd9Rrxy2aA2uCf7cxzgWAH5cU=;
        b=HcYuUIdh3vwDpTEYG2HSkhzpNcfBiNjPTEOs76uX/9q6O/l+Uc54Arv2Tx1IwyCkfq
         OtrdDR9pmcKbbRDKKZrHLGK8QlK6JILTfnP1f1b24n2IHNTUzr/h35WggG7xUIz793DP
         u8rZ6/i36CZ5UKNFk0VWRQKo7YdbFEY5cmOErGsPX+TtQ3ec2fRzUKQwiYXOEvA+3jJ8
         8sTnKXycvInOQuATvaBrJLyWa5+AHciLtW3d5hhTs5yacxZeC22giWb9UMDNRg5Og1+Q
         bzTvrqelLnHU9Dh6EpEBCVrt77BShkyE7hWHufcbirbHHIONKUkNLOnTCW7qsYW3UBB+
         bj6g==
X-Gm-Message-State: AFq9FYKGRVcRPou2/rJedxZ8sg6D9U7oDTi8tjAkqOxViX/RgOsRIhX+
	OaKnOh9YUkOKUg+Az/gBxdCTofRC8TnHdLiZCj1r0GqvZnh1um22SM2HoQY/v5e28n8I2rYxBe+
	cdCYpSX1Ynw==
X-Gm-Gg: AYBFou2FtSz62cSnXXAgg7R7NoTOHvIzFZCZysloMpjAMHoLfJz+dRWPpBMQN6gBztf
	yq+44ZgTQGeYo4k8D9G/vRIz9/9u5niz0EEnjJzND8xpYafc7IT3qPfeQyHWD6OUGW7P4vFGoyd
	JTGacAEVPDyUrTClEiX1Kb4o152+RvhANpfcRED2YtbYBY9aiLIfkPYi9Pf3UrUW/nw2fAi3zOT
	df+62bT1k2b8bxPlDeemqktWwF6Bq4V3iBKWD6C8My/V7/lns4OtnVE5BvP/0YFg3JrPGY23DBh
	pudVD7Qv4KasnTqNXyXTC8ProXsZZjlUg7pnfXLjXSxwCpx8w1rZjSk555VV9xDB8Z+5HEYon4O
	5/zMYgZ6OPeYRLJMPqA8BIbJ0j2I7L/p9AbC+v1WYKljEKn+a2MQTez92l0qwszTTcQ8g5aBjrm
	0KfDwI5cnYR7kSJan7V99G6RzY6nu+Nv39PqaKpA5Bm7yiKlwTXp2o3M37IpwHamoqOnlmnuylX
	gyUmpDMPxXiCW0GMCogkb1Nt8OEo+pU9T/TwvCyTRDItUc6g5SEm0rBNXfs4FqsJiLjNg==
X-Received: by 2002:a05:7300:fb17:b0:341:c383:9afb with SMTP id 5a478bee46e88-3602ef82f4emr2267276eec.20.1792116920170;
        Thu, 15 Oct 2026 19:15:20 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cc23sm2221123eec.2.2026.10.15.19.15.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:15:19 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org
Subject: [PATCH 6.6.y] Bluetooth: eir: Fix possible crashes on eir_create_adv_data
Date: Thu, 15 Oct 2026 22:15:17 -0400
Message-ID: <20261016021517.16686-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 47c03902269aff377f959dc3fd94a9733aa31d6e ]

eir_create_adv_data may attempt to add EIR_FLAGS and EIR_TX_POWER
without checking if that would fit.

Link: https://github.com/bluez/bluez/issues/1117#issuecomment-2958244066
Fixes: 01ce70b0a274 ("Bluetooth: eir: Move EIR/Adv Data functions to its own file")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Assisted-by: LLM
[ Backport to 6.6.y: The extended advertising PDU is stack allocated here,
  rather than addressed through pdu->data. Pass pdu.data and
  sizeof(pdu.data), the actual HCI_MAX_EXT_AD_LENGTH capacity, so all
  optional advertising additions remain bounded by their caller buffer. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2025-38303 to 6.6.y.

The code changes follow upstream, except the extended advertising call
uses its stack buffer and sizeof(pdu.data); see the backport note.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 net/bluetooth/eir.c      |    7 ++++---
 net/bluetooth/eir.h      |    2 +-
 net/bluetooth/hci_sync.c |    5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 7a28baa2b71feccc8bd7ff3f1d45b6b1f39984f7..2f695f1c69b36b129d9e52ed1453c91f3e2662b0 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -242,7 +242,7 @@ u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 	return ad_len;
 }
 
-u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size)
 {
 	struct adv_info *adv = NULL;
 	u8 ad_len = 0, flags = 0;
@@ -286,7 +286,7 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		/* If flags would still be empty, then there is no need to
 		 * include the "Flags" AD field".
 		 */
-		if (flags) {
+		if (flags && (ad_len + eir_precalc_len(1) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_FLAGS;
 			ptr[2] = flags;
@@ -316,7 +316,8 @@ skip_flags:
 		}
 
 		/* Provide Tx Power only if we can provide a valid value for it */
-		if (adv_tx_power != HCI_TX_POWER_INVALID) {
+		if (adv_tx_power != HCI_TX_POWER_INVALID &&
+		    (ad_len + eir_precalc_len(1) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_TX_POWER;
 			ptr[2] = (u8)adv_tx_power;
diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
index 0df19f2f4af94499defe78897e8c78fd0dbc2daf..4497f8fd5fefb5eed4d70477fb0fdf9feebe7fe4 100644
--- a/net/bluetooth/eir.h
+++ b/net/bluetooth/eir.h
@@ -9,7 +9,7 @@
 
 void eir_create(struct hci_dev *hdev, u8 *data);
 
-u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size);
 u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr);
 u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 607667cc357558ffefa812e1cf001ca923fdbf78..e73b4021dc6505924d6befaf667dadcaca6f0526 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1334,7 +1334,8 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 		}
 	}
 
-	len = eir_create_adv_data(hdev, instance, pdu.data);
+	len = eir_create_adv_data(hdev, instance, pdu.data,
+				  sizeof(pdu.data));
 
 	pdu.cp.length = len;
 	pdu.cp.handle = instance;
@@ -1376,7 +1377,7 @@ static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	len = eir_create_adv_data(hdev, instance, cp.data);
+	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
 
 	/* There's nothing to do if the data hasn't changed */
 	if (hdev->adv_data_len == len &&
