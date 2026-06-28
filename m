Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0AB348C47
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683134; cv=none; b=thZnlvTszwZx3NUUHHoO0+LufBVGiBAu7Ac6KvFXKZISGToA+/Ddqy9oxOsQWSs653xKYr3u07BCjfvQmDxnH9BDosFh53eK7XX64xImEpdVPPfC1BYrSjiznl88p17MgrlyNnbXJrdZ5GjX2xtbqAO/BskqrylOLBUhENhVnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683134; c=relaxed/simple;
	bh=4qFHrJ8TjRhzwg9eX6E4uCk78ScEs4rJofH5o2OZmu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+A5OL6hfg9dWHgDQ/x2+zXTTC8qVzHWAM1u5UDev4SKeYO2l9Bbm08Gzl31elj1p3quywDogdHhOYaNHRKZ7OgP9mgFOoGMoUOjtsFI30y9phH2bWMGFAEg+U5/knKxX6rZAsGAh+V473m37oe5X8gAyxojpXgvZ5Qh9FH3E5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKqsUip1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKqsUip1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c9c9916f75so3726605ad.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782683132; x=1783287932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xJeWro39OB82LbHgE7JTjiXJkNJO0xjWGuLEsvgMVw=;
        b=XKqsUip1DJ3JQySetJNaxJ4jizXOX99VIMVrzuKdBMyJTRmG+Mjc73hlI1VT52wyaF
         GhW2sSvP7DkdOfyMo4sCpHgZeCJt1PL3y3/uK/ICDk1/s8cAJ/wARjVu6yzQAhLAylmz
         3FLkQM/2mr9s6agkOUPCohyayxunWKm+itDMFJUa4f5MVTJpY62wXPaxbEOnDa0E+rk3
         oJRpLeYmsBNupvzw0lSIcoD2ThLxm3lDzam/lyDpYERZWxwH87U2Tuurjq3nbRADauoQ
         g0yF9j+0k7KlAWGNMDr41on9qEU4YOmdMCeHsboqjfy8cSC/9HZDE67CbPPYd+Tkgtu7
         MAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683132; x=1783287932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xJeWro39OB82LbHgE7JTjiXJkNJO0xjWGuLEsvgMVw=;
        b=mww9Y/x95izrGexKjUp49t+aopK0g9KeJg41mzpO4Vwnt+p4+rq+DLm7AsW+0OcEHZ
         G9wuBlX/UuAp0R0M3Rs3/sbO2sUbO68J2qCqVsqrV+wiswoHdmJ3IrQXD1qh5uwdij2W
         MC+iwWDdq85reX/p3fZribj7O5sE6EM5OKBzsNARCfZccRcFnMfZC9Mak32OvkKiu3M3
         xYo+xmtWd2cnWT7yk4hBWIBSFSwxSbTXLnqKVnEomwjvC8s8ORX/02oJh5HGoSIYcFT7
         /5+w497ToFhe9x35gr762ByFXyqeeGhVF4BkTgonGRbg9nILjE52wSGMZK/rtCv1FcRf
         O0Fg==
X-Forwarded-Encrypted: i=1; AFNElJ9yT+vtO8rB/60j4ZCOVnyms1C2m23Rg+XN+ev3AjYTqHqrGmfykt2NWiLXn58mZP43ejowYLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9c8APbjwdO2HfNMhvJDUXYL7pILV237aWnKQKNhveKIDU47Ns
	wBss4YStq1pki1mppp7RAV+gqlX9YDVLzAig2Lts7mfN4aquyhSASC4o
X-Gm-Gg: AfdE7cl+tpyHNRm83zI7YkmEd0Ycx2Q9oBEFC2rYx6kZUACIR/q/XVTao7G9npJuGBL
	R/0a+RDvP4ZJv0ezLCff+gJ90XEwFT1LAv5odk6770omBQ9KH6ebdvT+04Woy1QPfPzhfRFnruG
	z7/ENrA2vSgbu4TfJdpiRUoqc6Klix/yFW2gEdIJvSk/cnvhVfVvm8c/kQFltYUGyhCfuE2NQPW
	bb13v7GYg6jib2HamHG4gcsUZYSMtVm716uTv8QAQYLwHRIxcinLgYeY1EW8to4c+y29RRliZcE
	s+2XOeIJ9HBurWZBCJ2F67ADy05jiFsRzvsfLXaK6xGcqubcI66wXFly+JAsBVu5WU7k4+eemg+
	scpaVa5vdYcM6E4w8BwBEl9YpkxNEp+W4DBJs6amCcF/z/7b2fxIvNkVMsNZY+ak6zFOVi3ajuZ
	D2barE76ynioiiaPCa0d/T2VASC6iVqm/WRG2FDTgW2bClYGj1Vs9InJWlG717
X-Received: by 2002:a05:6a21:6f8b:b0:3b4:b276:3650 with SMTP id adf61e73a8af0-3bd4b15313bmr13996540637.26.1782683132169;
        Sun, 28 Jun 2026 14:45:32 -0700 (PDT)
Received: from node ([149.40.62.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bcc91f6dsm6572185a12.27.2026.06.28.14.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:45:31 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: david@ixit.cz
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net v2] nfc: nci: fix use of uninitialized memory in NFC-DEP general bytes
Date: Mon, 29 Jun 2026 02:45:13 +0500
Message-ID: <20260628214513.134855-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628211627.131617-1-meatuni001@gmail.com>
References: <20260628211627.131617-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_store_general_bytes_nfc_dep() derives the length of the NFC-DEP
general bytes by subtracting the fixed general-bytes offset from the ATR
length:

  atr_res_len - NFC_ATR_RES_GT_OFFSET   (poll, offset 15)
  atr_req_len - NFC_ATR_REQ_GT_OFFSET   (listen, offset 14)

It never checks that the ATR is at least that long.  When a
RF_INTF_ACTIVATED_NTF reports an ATR shorter than the offset the
subtraction is negative; because min_t() casts its arguments to __u8 the
negative value becomes large and is then capped at
NFC_ATR_RES_GB_MAXSIZE / NFC_ATR_REQ_GB_MAXSIZE.  remote_gb_len is thus
set to up to 47/48 even though only atr_res_len/atr_req_len bytes of the
on-stack atr_res/atr_req buffer were copied from the packet, and the
following memcpy() reads the uninitialized remainder into
ndev->remote_gb.

Zero remote_gb_len and skip storing the general bytes when the ATR is
shorter than the general-bytes offset, so that a stale remote_gb_len
from a previous activation does not survive into the new session.

Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/nfc/nci/ntf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 802928ca4d51e..b72545daa2051 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -654,8 +654,10 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
 		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
-		    NFC_ATR_RES_GT_OFFSET)
+		    NFC_ATR_RES_GT_OFFSET) {
+			ndev->remote_gb_len = 0;
 			break;
+		}
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.poll_nfc_dep.atr_res_len
 						- NFC_ATR_RES_GT_OFFSET),
@@ -669,8 +671,10 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
 		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
-		    NFC_ATR_REQ_GT_OFFSET)
+		    NFC_ATR_REQ_GT_OFFSET) {
+			ndev->remote_gb_len = 0;
 			break;
+		}
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.listen_nfc_dep.atr_req_len
 						- NFC_ATR_REQ_GT_OFFSET),
-- 
2.54.0

