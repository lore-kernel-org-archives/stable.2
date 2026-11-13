Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541644;
	b=Vj38V5pyYM5OtzpOK3LGq9ngFT3rKIakLm3WOZRXRJjmD5kIcAs0z+6MTb415hoEr1sD
	 hnRlNPv8/LiK9NT/xmCMZ9MxUWki852nVFYfJ6/XI24odZBEu9eOpFs4b5N9pE++IiJwZ
	 zvIgwz5qcupVDw30wQJbbYbZU7w8YHjJQGB0HLNI9G5ACIosaESLeXZocJGJOES5pe0xW
	 LdvxzZ3r9vao1F05B8WmQMjgZv4Sjey9AIldb00zQoi+dc0OZWSrjj4wTSl9H8p63VvR4
	 7ZYk92IFtFrHZCKSSyObJNiuWSmCkbqsYECYTNJQ6qDvfGnTD/tDVt4Q0IfdN9iT85w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ynMPM81I67xV9QoDYs65toYtNzNIzlwETu2rn5u7e4w=;
	b=GgChL1rB318qV2HS+SbJ2zTIvi408pAawo0HaZR/LkRGbntoAkVfF+/18FkuIXH3csgM
	 aX26ScmJ3R13lpAMe0sw54KXRA0aMCAqUMoYy/SItp/JKI8kXRMW1EWNzLHOryyztVemT
	 aAAlInhCleNY+bULDOECaza+2pPHxvdNzdl3brRqTt8mX8nBsoYlCSxnQ6R9GpSD4CJ5C
	 ZJsyFiGiFLgzIBhaRHYrCDQQcXdz16w6hEoOX0F9LmMkvUtl/pqJvUcWS16t84oqPLQ5W
	 S1AeXqKcokB35JukOtrLQ65dfT/O/e/uyCqTCnkUjZ23GcetxMxYfsTkVvJJl4Y7uhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S9OaCw/k";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A3606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E7A3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9OaCw/k
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3ada81853so391056c88.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794541643; x=1795146443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ynMPM81I67xV9QoDYs65toYtNzNIzlwETu2rn5u7e4w=;
        b=S9OaCw/kRtA/w2JT7L3suOrNq4SoyIFVO4O2mlpiXzlkr4J9EHe551B3zGt58A4pnc
         S717E6trPQekMT1eRpDdGVj3B8XuQZW4m+1yH5PUnzapjKJ2zrY967rBYszAzWYJcU4p
         sNXRRD2IAYyJeTwALGP/8uKsQtnj7h5UqwIczMTUYFNfq1UnQXwTHTe4i8E8ag84+JV/
         EdcvemhhC2iF0NxkZlM45xmxc5PcBsASADIGr93WxTJsZ0OBEnHMILjGD4nYFGhao+wH
         NffXdhhH5sdX7TH/MrDe8Bzj8en8h0OlceW8Xylm1iXPD8SxDtA2fc96N7RPwAwwG78F
         zXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794541643; x=1795146443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynMPM81I67xV9QoDYs65toYtNzNIzlwETu2rn5u7e4w=;
        b=w6GqkswcseLm3bovrxaQqkOUhm5yDc5Rd+LanobLHugNNCyu+H8iGIOcc4n9qCd5+E
         4myi5SC//7BozFzpd/mhNWhZ2oWVL3/AyquL73/MO/bxGEPulFEtRuebojW8Jvt5Y5t2
         6W0b3Bdw1VCHaeOnUKpRT9xZzwTJyo2ggoRA1prh8B5E9fO6DQz37US4P5Lu0mjYJw1C
         uo8alMDLgmGF+J6GyDXB26FFeK0TxBYwlCxxJG8iDmbK8nwNfCp9vUwpAX+vHVs8AI9f
         dvZg1lRYPK/S1C/dVoAit5UQITnlO0PHkbRKU+ntAh0PXxGENRDxwOZN2cJtPHGXLYzy
         3XQw==
X-Forwarded-Encrypted: i=1; AL+hErHiXFgyxSNUP5hNIHo193gY0FQmUWtUD/Dp1D2k4m/I2KKEqRSb+vqdz/xBXNDk6BmHPBVyvHg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LDuuovxKongL1iQRfccKWs44FBjEVvSJ13ZRv/8m2aNid6t/U
	YDqvoiGewdVSma0kRp4CeI7BSS/yDQv42SZiH+o4Lhf7WQLQefPUwtPueqdH4dOK
X-Gm-Gg: AYBFou1hh7Wjp3vQOfhF7fg1+YnbaA6QpOfwJSfa3H9MKPVg+fXNLYwRrT9NraaqObq
	Dfe7L4fT3+fVnkqWmZIMc6zkgqm0nnGKQyGxRIZBkLeP36/epkQasMLP8xScG7hFq6NnTfI5Nhj
	F16IVwvGoQ3mBxok7A0f6rb6wlYgzNM49XoI3AVnwo2SFWjIe86CgK5kRK97WKxUppx/40prhZg
	ijsN20EMT9zCUKu3m3w5jslQ0B+FzvMOP953ORsT7C0Dd+2t87oZVNT82p00Ec3AzlLdc+k7D8V
	ok9CIdgdZ4jCjDlzvPbQJV9R9YHU3vVSnjrgLw3sV7uoa/IrJwHLdkHmo0xwQZuXd3GsxH8Ybjy
	rPSjWLSMyhDWU/Lyes15Y5ieQqxclKDf+Z2Epz3sSOOOwWR1fqi8WWl/UFSmKx7apWLSIhibD6b
	gDnOshBFYRTGtp3qgavwoMDwQ6oE2LASOMnicDHJbme4f+W9TMyAkPP0iNIzpsXq2PoZFdy00+v
	W0Jirtbmy0nuMiEhgnM9qcThtVqnCaEfyap+Jojj2hxUo0natGaD++rzOW+izOfn3HIfJvZFauA
	voaA0kQcBuIsSg2VGq4t
X-Received: by 2002:a05:7022:1701:b0:1b3:9b4d:85f3 with SMTP id a92af1059eb24-1b5030ffe36mr1270705c88.19.1794541643361;
        Thu, 12 Nov 2026 19:47:23 -0800 (PST)
Received: from xploitoverload ([2a09:bac1:36a0:120::243:8a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm2882111eec.12.2026.11.12.19.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:47:22 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: pkshih@realtek.com,
	luka.gejak@linux.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH v6 0/3] wifi: rtw88: firmware recovery fixes and LPS hang handling
Date: Fri, 13 Nov 2026 09:17:01 +0530
Message-ID: <20261113034704.21283-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series addresses firmware recovery robustness and LPS hang handling
in rtw88 based on review feedback from Luka Gejak and Ping-Ke Shih.

Patch 1/2 from the v2 series (DMI quirk for HP Laptop 15s-fr5xxx) was
already applied to rtw-next. The previous LPS leave recovery patch was
dropped from rtw-next by Ping-Ke Shih for respin.

This series splits the recovery fixes into three focused patches:

1. Patch 1/3: Clear RTW_FLAG_RESTARTING on stop and start failure.
   mac80211's drv_stop() skips local->ops->stop() when local->started
   is false (such as after a failed drv_start()). If rtw_core_start()
   fails during restart, clearing the flag only in rtw_ops_stop() left
   it permanently set. We now clear RTW_FLAG_RESTARTING in both
   rtw_ops_stop() and in rtw_ops_start() upon rtw_core_start() failure.

2. Patch 2/3: Skip already reset station in rtw_sta_remove().
   During station disconnect (e.g., ieee80211_set_disassoc()), mac80211
   leaves LPS before removing the AP station. If recovery is triggered by
   LPS leave failure, __fw_recovery_work() removes all stations via
   rtw_reset_sta_iter(). When mac80211 subsequently calls
   rtw_ops_sta_remove(), rtw_sta_remove() ran a second time, resulting in
   a double free of si->mask and underflow of rtwdev->sta_cnt. We check
   si->vif after ensuring pending rate control work is cancelled, and
   clear si->vif, si->mask, and si->use_cfg_mask upon removal.

3. Patch 3/3: Trigger firmware recovery only after consecutive LPS leave
   failures on PCI.
   Restricts recovery to PCI devices (rtw_hci_type == RTW_HCI_TYPE_PCIE)
   because USB (usb_control_msg()) and SDIO (sdio_claim_host()) sleep,
   which triggers a "scheduling while atomic" panic under
   local->key_lock during key clearing in __fw_recovery_work(). Retains
   rtw_fw_dump_dbg_info() on the first failure (guarded by RTW_DBG_FW),
   and requires 3 consecutive timeouts (RTW_PS_HANG_MAX_CNT) before
   triggering hardware recovery. Gated on FW_FEATURE_LPS_C2H because
   legacy chips clear REG_TCR on failure which masks stuck firmware from
   accumulating consecutive timeouts. ps_hang_cnt is reset on success
   and in rtw_core_start().

Changes in v6:
- In patch 1/3:
  - Pick up Reviewed-by tag from Luka Gejak.
- In patch 2/3:
  - Keep cancel_work_sync(&si->rc_work) before checking !vif so that rate
    control work scheduled by rtw_ops_sta_rc_update() after recovery reset
    is not skipped if the station is removed before restart adds it back.
  - Clear si->use_cfg_mask = false alongside si->mask = NULL to prevent a
    NULL pointer dereference in rtw_rate_mask_cfg() if mac80211 re-adds
    the station across recovery restart.
- In patch 3/3:
  - Pick up Reviewed-by tag from Luka Gejak.

Changes in v5:
- In patch 3/3:
  - Drop redundant rtw_hci_type check in rtw_fw_recovery(); the check in
    rtw_fw_leave_lps_check() and the existing PCI-only callers already
    guarantee non-PCI devices never invoke recovery.
  - Only increment ps_hang_cnt and trigger recovery when the firmware
    supports FW_FEATURE_LPS_C2H. On legacy chipsets without C2H support,
    clearing REG_TCR on failure causes subsequent register checks to pass
    immediately, resetting the counter and preventing stuck firmware
    from ever reaching the threshold.

Changes in v4:
- In patch 1/3: Also clear RTW_FLAG_RESTARTING in rtw_ops_start() if
  rtw_core_start() fails.
- Add patch 2/3: Prevent double free and sta_cnt underflow in
  rtw_sta_remove() when recovery races with station disconnect.
- In patch 3/3:
  - Keep rtw_fw_dump_dbg_info() in place on first failure.
  - Restrict firmware recovery invocation to PCIe devices to prevent
    scheduling while atomic panic on USB and SDIO.
  - Explicitly check rtw_hci_type() in rtw_fw_recovery().

Changes in v3:
- Note: v2 patch 1/2 (DMI quirk) is already applied in rtw-next.
- Add patch 1/2 to clear RTW_FLAG_RESTARTING in rtw_ops_stop()
  with Fixes tag.
- In patch 2/2:
  - Count consecutive failures before triggering recovery
    (RTW_PS_HANG_MAX_CNT = 3).
  - Reset ps_hang_cnt on successful LPS leave and in rtw_core_start().
  - Suppress raw register dump on transient failures to avoid log spam.

Changes in v2:
- Rebase on top of rtw-next.

Kalpesh Solanki (3):
  wifi: rtw88: clear RTW_FLAG_RESTARTING on stop and start failure
  wifi: rtw88: skip already reset station in rtw_sta_remove()
  wifi: rtw88: ps: trigger firmware recovery only after consecutive LPS
    leave failures on PCI

 drivers/net/wireless/realtek/rtw88/mac80211.c | 3 +++
 drivers/net/wireless/realtek/rtw88/main.c     | 8 ++++++++
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/ps.c       | 9 +++++++++
 drivers/net/wireless/realtek/rtw88/ps.h       | 1 +
 5 files changed, 22 insertions(+)

-- 
2.53.0
