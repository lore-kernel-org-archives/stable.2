Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D6402430
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526691; cv=none; b=umyxcuSzCfgqOYQWT447OracG1+YFK9Z55I4ZJzcKeTbYoNZWplyhI9s5vV2UXWh/zfis0HXptfj3cdpIg0NwhXtIAbgngN3dvU8sLWkVZYB5L4DlkxdV38RAD+r8TT1s+tHLAbLB6VArsLm/JqAekfInO0of8Ez2NlaJCV8hNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526691; c=relaxed/simple;
	bh=xMZ9LKd7Y4IqdZ/gTTx7waSmUHvUp6ONCJSsGWAPp3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FONzWujpy8nNH1Ag77ep2UQOyHuAuIxiqjTzOZNGs5FW1TsZuVNeIkNVpMuTx6TrTIUSvCSjhepMqfYj1WSHoWlGiamtCZV6EgeRL+5/333QTACcFGpwkxyfYENXTPYhj7JhgIDaC0IUlHEtDyVHrAu5Id5gleqb3GlKGLCKGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0G3eJh8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0G3eJh8"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so576178f8f.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526688; x=1787131488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SLJ77/vbQiJHKcovBSZ6qUF923u9W7YbSMMe93GKMVQ=;
        b=G0G3eJh8n2DlTxiN0HbJmhwfo6jplBn3gf7coS5U0cKshI0btxxWzb/6leDI2Y8yRa
         yqc+7U8I2fJpvJno6luoMO/EGKSGC/GPx+zq4gnFuzgWO1qytpu8qA9qXqfU81jDMTvO
         5SRdhDeoY40xUze4BdyM3XeBfmnCSxyyC8xWwJ5anatp9A1Fk636JAqmFkkIwic0TvYV
         vEd5+DZ8srx0uLllF93Ql37S0h+41vFA4/uvC2zIixr1S/GmwnJ9DfEu44/IRk297EKr
         QFqe8dDRBXe8VFX7LD0kxlbByfcpJ8b2I3UH4WjCvrjp/RjJKMgvK54mk5k29Actlg45
         xxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526688; x=1787131488;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SLJ77/vbQiJHKcovBSZ6qUF923u9W7YbSMMe93GKMVQ=;
        b=gc2zwv+rEFk9eIM6r+ZCu9Ml/jMN+OCoBNBRUDJO7Ddn+soWdoqQ1t1UBkkItti25W
         rBraXGle6V1eHuzFI4AKpXmBYgOAqWjS8FOUHiX4KgUIuHfdNNZZ+AzcEWwaR2ihu2kj
         TQOVUFBlGYBygHVmHfXUP6Dx7w6xDLQeKM/jf9f1vLzoSjdzw1fcz/NhN84Q56Q7g7AA
         mNY+BS/uzekS9Q5XgCppx6gJK/25oqmtvOZHbrB2Vqt9eu54bfh2MwslMak6YNxTizSM
         Nv42UbTbmcgc1pFRtS6ZcSlMry4sk5FEQRRCv0u7d7azAipdbnZRrTaZYwt83UizHekv
         mhJw==
X-Forwarded-Encrypted: i=1; AHgh+RpJ12YXNR880cN6nn1DJz5WyZvPel1SyXcQWifY8Xg1ig4JaknWv8EJtSj4pbln5e21zYgrLz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/zTGx9+iCrp+qG3QShLOyWFZI+LhCgJGL6p5a9T3A4iXX+2l
	i++XMfjCyqLyrsLRPxqa1SpwbS2y7GRdUM5zYK20/zZ9u4lv5uc32Fp+
X-Gm-Gg: AR+sD10uuhMDLf+XhnqIBPj1QVVRj8dZSMXO7AY6km+R0kZ4yFu8nx2c9I7Jy8NucHF
	Y31dGyjAqanG1BNSmr55ljArvdwmudFN/VYBpbwd+IP/sVaCEAdd1xukYNincllTnzF33DVxNqK
	KaWLvzVLiI8rW/lzN5GwRrXcS9U3MsZ+X9lJTroEJCdFOVr+wof49/yXzUniVs2wvljdtX9pnYR
	pTxiV2IPoSa+95s8osBxs+ZOR5EAr57nWcO3HYC5JirE7x8Zg7srI2qLpwX29XPJbOf2tRq9kdu
	hd3gcQmDo760QxzdsRra3ckNJ5cCAtu3pG2KoiY1jYGZzTeqMxTherZKZ385Qf0vuDlj0X5qM7G
	pd3PTrv7vkrzrCxwRNRgzULFU5CeX5Q87S6BCXIyxcOJrJnf5BAA3eXkaIpxd27IF7ZbE3x7DOd
	HUszCSWrFLRjVYA6csbx5Hd4ntueG3mdB1wIZ+ofgJ1vRzdU+MR7K6c90cyI7+1w4KcB5UbPXhh
	HUNS0dPkzxdMons2k2BJaZZvTXHbker1QRS5RxdKw==
X-Received: by 2002:a05:6000:400e:b0:47f:7964:9887 with SMTP id ffacd0b85a97d-4815290c662mr4271585f8f.25.1786526687523;
        Wed, 12 Aug 2026 02:24:47 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815231c308sm5152338f8f.11.2026.08.12.02.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:24:46 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	david@ixit.cz,
	snowwlake@icloud.com,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net v4] nfc: nci: fix use of uninitialized memory in NFC-DEP general bytes
Date: Wed, 12 Aug 2026 14:24:23 +0500
Message-ID: <20260812092423.161497-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

nci_store_general_bytes_nfc_dep() derives the length of the NFC-DEP
general bytes by subtracting the fixed general-bytes offset from the
ATR length:

  atr_res_len - NFC_ATR_RES_GT_OFFSET   (poll, offset 15)
  atr_req_len - NFC_ATR_REQ_GT_OFFSET   (listen, offset 14)

It never checks that the ATR is at least that long. When a
RF_INTF_ACTIVATED_NTF reports an ATR shorter than the offset the
subtraction is negative; because min_t() casts its arguments to __u8
the negative value becomes large and is then capped at
NFC_ATR_RES_GB_MAXSIZE / NFC_ATR_REQ_GB_MAXSIZE. remote_gb_len is thus
set to up to 47/48 even though only atr_res_len/atr_req_len bytes of
the on-stack atr_res/atr_req buffer were copied from the packet, and
the following memcpy() reads the uninitialized remainder into
ndev->remote_gb.

Reject the notification with NCI_STATUS_RF_PROTOCOL_ERROR when the ATR
is shorter than the general-bytes offset, rather than silently
continuing. The return value is not decorative: in
nci_rf_intf_activated_ntf_packet(), a non-OK status here skips
nci_target_auto_activated(), is propagated as the completion status by
nci_req_complete(), and skips nfc_tm_activated(). Silently continuing
with remote_gb_len left at 0 would report the malformed activation as
a successful one with empty general bytes quietly substituted in,
rather than as the failure it is.

This bug has two independent points of origin. The POLL-mode
subtraction was introduced in commit 767f19ae698e ("NFC: Implement
NCI dep_link_up and dep_link_down"), which is where remote_gb and
remote_gb_len were first added. The LISTEN-mode subtraction did not
exist until commit a99903ec4566 ("NFC: NCI: Handle Target mode
activation"), which refactored the POLL-only code into the current
nci_store_general_bytes_nfc_dep() and added LISTEN-mode support fresh.
Both are tagged below.

Fixes: 767f19ae698e ("NFC: Implement NCI dep_link_up and dep_link_down")
Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
Cc: stable@vger.kernel.org
Suggested-by: Lekë Hapçiu <snowwlake@icloud.com>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
v4: Return NCI_STATUS_RF_PROTOCOL_ERROR instead of silently breaking
    out of the switch, matching the behavior independently proposed
    by Lekë Hapçiu. The break left remote_gb_len at 0 but still fell
    through to the function's final "return NCI_STATUS_OK", so a
    malformed ATR was reported up the stack as a successful
    activation instead of a failed one. Added a second Fixes tag:
    767f19ae698e is where the POLL-mode subtraction was first
    introduced in 2012, predating a99903ec4566 (2014), which only
    introduced the LISTEN-mode branch.
v3: Rebased onto current net.git for-next, requested by David
    Heidelberg. The function moved and gained an unconditional
    "remote_gb_len = 0" at entry (from commit 9c328f54741b, landed
    after v2 was posted), which made v2's explicit zeroing inside the
    short-ATR branch redundant, so this version drops it and only
    adds the missing length checks.
v2: Also zero remote_gb_len explicitly in the short-ATR branch so a
    stale value from a previous activation doesn't survive into the
    new session.

 net/nfc/nci/ntf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512b..c2352ea 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -631,6 +631,9 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
+		    NFC_ATR_RES_GT_OFFSET)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.poll_nfc_dep.atr_res_len
 						- NFC_ATR_RES_GT_OFFSET),
@@ -643,6 +646,9 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
+		    NFC_ATR_REQ_GT_OFFSET)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.listen_nfc_dep.atr_req_len
 						- NFC_ATR_REQ_GT_OFFSET),
-- 
2.55.0

