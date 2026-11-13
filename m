Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541663;
	b=kW0qMDlvtq74sLFxffo+UVwMyyma2lbgcbA0IPyVJIhf+EpFZ8n9vQto7p12bhq+QAlc
	 snHTgVwyK6VxPAe8I9eBbw3fE8OFQOMxmZ8aUiHdsZ5m0/heE1ctzf0HzWsNR7Lm5TyG5
	 oggA1AdteNrRLOUXsl2F+/mrZEOq6XQ8C1yoeHMTzwsAHZ9KYpiSFz/txcePiJ5+nWV1n
	 H9LZUj4/ldNT08eMMIRymUjfvuut5YSCo9XvHKkUlWbSMbpHu8u/lHFEAIjSg6AKiJLJ7
	 EKrsTxlNDHTitNs34Ja/tGT/kPQHjtSCQne1m7EyrPs25rKkzrSXPPGCyTq1R6eKmyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NmpdXM2MjAn3pA+0zNkVS3PYgcwnWLjo5ExDBOv3ygY=;
	b=yB550BpWDdBWretno/0abwU8yAHkRELNE9T8awbLOQB9fuYhzbWfbrsd0sTKMyI7zXbq
	 yehY5Fp6uODLZ/Pp6i704d6PaUh6UAo+Y+KfKYBJ5qqSgXgcJTUdi7Q7pKwBw3tNGI+VT
	 CRahyF06NRQ5LYHO/+xOalSHJTuafOpDhE7bgqxGfjMQB0V1FDTBwDoEhAnOCl80b+JA6
	 ApB0ZEDJzvFt81ifxPPOmfa4X1VrTouQL6yryyPG938FqVW63nzr7bT5Nq98xSMlsgvWl
	 ItBYXIAb8vItnhCB5mpCxAjtfwMzKdG9LTeKWM4xZYk9SVpVsdnX24W3gEQqmcIhkJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPcoBKsJ;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA4606A888
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20DA4606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPcoBKsJ
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so742620eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794541662; x=1795146462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NmpdXM2MjAn3pA+0zNkVS3PYgcwnWLjo5ExDBOv3ygY=;
        b=TPcoBKsJ8FB+hDdRP6EBpCYWmfC9D9OSUCsSYZucdFUMVJOk/Ul3perwrOkXzeub7E
         tJX7TcO6hQFOOqjYjEs/L4g6A/KUM+YVss7SGTfrPU80tWNwFYuCg4e8rZOPgpha/4YS
         +M+RFnFm794Z5PeceGI+0nJFrsXruy7WlXCnnOmZbciCEtKyIOGpy9zvRuJrqXSX2Go2
         oS5WdQQk9qv70WMK9A8r9tesw7HxeDg63K74T5xvZ5b6rzLuG5dJxotvcv4eMFmhrgu4
         H8l5e0y664EI9gc/p5JG2NNXM2BuGsyv8T/IRs3rMcqZRmQrEysOeyJoont0QqDK+qjI
         gzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794541662; x=1795146462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NmpdXM2MjAn3pA+0zNkVS3PYgcwnWLjo5ExDBOv3ygY=;
        b=uCYuQIIso5s68yUZEiXqF09FDZat5Y1qAJDhvPWDh5dQx88z+qiXXo7m7wWF3utqqz
         CxsBxGWmL8WfSW1xGPNRSMhW6Te8JS9dF32y4waVCIAO6uM4FSUvDzttfaqyl+xjaQFE
         ZqT/UwOcDKEHN0KRmuWem3SvX/aOxCu6vfZScKS0iLVY/BCJp+X8vQoKLjZLbh5SaXOA
         RplH19cOLGo8VZgJ6nErsR3ZWy53mfhN2TmlZq/tTZRZMl4GZrm2U7DZgY1cxT02siTL
         ncx5mveJaJ/gsbsWJoG8I+JzUu2CvEx4dPs/Q2xSPGfpag1uPMF6YIB2dk8N5SfeUttt
         cwrw==
X-Forwarded-Encrypted: i=1; AL+hErGAAOy5Iuzcc8zzsha1ug+NcUYmFKTn2CCSP5q0V0fx0DV+AEv9bBCpm9+uYOW4wARo4zCJfgk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xZdDs0mEYsAq71wscVPeskwZXeq/m8/QvWSexkd4KLYm6VRBG
	OfqrRbvukW96YDF5NZbKcPIffqHcMubYMug+J+JEMA1ar3z5zbcwPaks
X-Gm-Gg: AYBFou1zOZ4pXqxdKWfBSxcX7vVclqXbD/C8iOQoAYc+IavpVREHETMpatHBB03oJAj
	Cts34JefPYQK7EW18X+IIPGmmpUwhmmQnixiZhqnpwcYs4djicB1zfgFvcyhkjuRrv+KLYrsfBp
	3FntiPRGDUwadK03yi2s+Yep3V9YKa+YFs1gQ05rjaMQrjhrTaPQWYrUnVnwV+iD77tG4FbW0TR
	TwuQxURq3RjJB5txK7XRl5gf7ag+m1oQ8AHwFIezZ7604nFLmlgVPryVBW81hxgO8SChhn+R3Sp
	zijbNoLqs1/pUHfDDVoxFVk3evLnhplgvb5IYWqq3cIMGOY2BZLBSF5XZpQ+xc+zYwlE0NL3+WW
	+j2r4G4xdiZ8xNIkjVhu2JQ2KurBiJcMB7+MnmmBlIw22/v4tg7Y2gRisKaJvF4S42MBcAOs/zU
	QFeQXc5mdBeRqKh6OMZnrqaWs8j97OItMOsyefx46xczX0WzMaxD9jLFDfESekjsR62nyJqot3d
	DnauuAiU2X9ARCQD100KLEjIclr0WvdLPCAUyWkaLhgVJ17i3igPR6NF9+CYeRX5iNgvNF4y+ae
	aQfHCOt7Q+jpPZfhAgEG7uq6e/ZzE+a6GthOj0GSzrY=
X-Received: by 2002:a05:7300:d718:b0:36a:12c1:3adb with SMTP id 5a478bee46e88-37966b52740mr1488706eec.20.1794541662029;
        Thu, 12 Nov 2026 19:47:42 -0800 (PST)
Received: from xploitoverload ([2a09:bac1:36a0:120::243:8a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm2882111eec.12.2026.11.12.19.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:47:41 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: pkshih@realtek.com,
	luka.gejak@linux.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH v6 3/3] wifi: rtw88: ps: trigger firmware recovery only after consecutive LPS leave failures on PCI
Date: Fri, 13 Nov 2026 09:17:04 +0530
Message-ID: <20261113034704.21283-4-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113034704.21283-1-skalpesh942@gmail.com>
References: <20261113034704.21283-1-skalpesh942@gmail.com>
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

A single timeout in rtw_fw_leave_lps_check() does not always indicate a
frozen firmware; in noisy RF environments or during beacon loss, the
802.11 null data frame ACK can be delayed or dropped. Immediately
triggering firmware recovery and a full hardware restart on a single
timeout causes unnecessary disconnections and kernel warning traces on
idle links.

Follow rtw89 by introducing a consecutive failure counter (ps_hang_cnt)
and only triggering rtw_fw_recovery() after RTW_PS_HANG_MAX_CNT (3)
consecutive failures. Reset the counter to 0 on every successful LPS
leave and in rtw_core_start() so that cold starts and hardware restarts
always begin with a clean slate.

On chipsets without FW_FEATURE_LPS_C2H (such as RTL8822B and RTL8723D),
rtw_fw_leave_lps_check() falls back to polling REG_TCR for
BIT_PWRMGT_HWDATA_EN. On timeout, the driver forcefully clears this
bit so subsequent packets can be transmitted. Because stuck firmware
never re-asserts the bit, subsequent register checks immediately pass,
clearing ps_hang_cnt back to 0 and preventing the counter from ever
accumulating. Therefore, only count consecutive failures on devices
with FW_FEATURE_LPS_C2H, where C2H completion signaling reliably detects
consecutive timeouts.

Additionally, rtw_fw_recovery() clears keys via rtw_iterate_keys_atomic()
under a spinlock. On USB and SDIO, register writes in key clearing sleep
(via usb_control_msg() and sdio_claim_host()), which would trigger a
BUG: scheduling while atomic if executed. Because USB and SDIO do not
support firmware recovery, restrict firmware recovery invocation to
PCI devices via rtw_hci_type().

Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 2 ++
 drivers/net/wireless/realtek/rtw88/main.h | 1 +
 drivers/net/wireless/realtek/rtw88/ps.c   | 9 +++++++++
 drivers/net/wireless/realtek/rtw88/ps.h   | 1 +
 4 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 8e62d38a269..2a38a6828e3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1537,6 +1537,8 @@ int rtw_core_start(struct rtw_dev *rtwdev)
 
 	set_bit(RTW_FLAG_RUNNING, rtwdev->flags);
 
+	rtwdev->ps_hang_cnt = 0;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 6ecbeb4ffe4..525f17590ad 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -2113,6 +2113,7 @@ struct rtw_dev {
 	/* lps power state & handler work */
 	struct rtw_lps_conf lps_conf;
 	bool ps_enabled;
+	u8 ps_hang_cnt;
 	bool beacon_loss;
 	struct completion lps_leave_check;
 
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index add5a20b843..908d2ea3572 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -166,6 +166,15 @@ static void rtw_fw_leave_lps_check(struct rtw_dev *rtwdev)
 		rtw_write32_clr(rtwdev, REG_TCR, BIT_PWRMGT_HWDATA_EN);
 		rtw_warn(rtwdev, "firmware failed to leave lps state\n");
 		rtw_fw_dump_dbg_info(rtwdev);
+
+		if (rtw_fw_feature_check(fw, FW_FEATURE_LPS_C2H) &&
+		    rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE) {
+			rtwdev->ps_hang_cnt++;
+			if (rtwdev->ps_hang_cnt >= RTW_PS_HANG_MAX_CNT)
+				rtw_fw_recovery(rtwdev);
+		}
+	} else {
+		rtwdev->ps_hang_cnt = 0;
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 5ae83d2526c..b088fad7cd8 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -14,6 +14,7 @@
 
 #define LEAVE_LPS_TRY_CNT	5
 #define LEAVE_LPS_TIMEOUT	msecs_to_jiffies(100)
+#define RTW_PS_HANG_MAX_CNT	3
 
 int rtw_enter_ips(struct rtw_dev *rtwdev);
 int rtw_leave_ips(struct rtw_dev *rtwdev);
-- 
2.53.0

