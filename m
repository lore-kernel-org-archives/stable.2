Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E23B71AD
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790482309; cv=none; b=JAL4UTVdgBo8+K/4iLV2sEQaKqcl+CCUpPi+BBKJ6lADsU23mRN95O13jWJdi4kHpe9kQErLauMIjXjhJqWEt7GYID47eGNpxZ+THbbBmwZSUisflLXllXscbgMvB/TSS4D96NkID9JmCSq/N3tkg20H+des9m4F89FV6WiuWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790482309; c=relaxed/simple;
	bh=xaV/yrHeCHmm9VjtGETQC++wPH6mhJCL1/6v/GQNs+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeyGQ04aj/TrQG+HatK1mesAzgSNZFVSggORCv36mKT7aRmKoPNzpTc3M9B0dMxzJO+u37Yl3AMZVqiM3cDCD0jYEp8jVX9zbhBsH5tVZFJ0xntCcnQbx0T0sgkejACy8+L1XAulya2kDHZBxRMxKNKOn6XR67g6mTVhE2fJe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPULYV/x; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPULYV/x"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0eeda3e03so262729a91.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 21:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790482307; x=1791087107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0P7XkiDHrjWCoSLhkn5DvRqIs2QJwoOotquq3MRAl4I=;
        b=GPULYV/xTzn59LdCZnwjQKtLsR/j+fwQeAVEH1d4FGmoRvuGO+shje8m26gq4etLbv
         jaTKUsIvg1Qm+rD5Ir9/AhfGnDL5sFNh7Pryycsa4zim4EGrtpDax1154OwwktO2XVw/
         /nt8uSIuTkp0TgdYhlEWfPfmEhW5OFZQE8oL2pg23x+4oDGBpotzmBYEde0f1juxJo6+
         /ePpBgRqFucVVEUVXwcgMBy7lS0Nba5S6cPAz8f8ias4tQiyErfOqxKlYnvBUtQTbNNx
         oGaaXPT0RIuZ7/ZWqUEVBF7V5IuOeandU3nkkhWwi9BZhWWh6oQPn640eFLBkFkMQD1s
         +bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790482307; x=1791087107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0P7XkiDHrjWCoSLhkn5DvRqIs2QJwoOotquq3MRAl4I=;
        b=KS+472bFtXlBkxwJ5ghyVP40RnLXm3UknDJCpUKTFZJR23jIixAJExQP0aRGNsubjf
         PPYFM7oSlRTZB06U7JcYHaiWyRT2J0u82dExxvzvopHhDTCoLi4Zx3CNoc/MtOsTnPS+
         crGty3ro/7mL4hrTS5BDu9IYVbT1WgrEWGU+C0zj2UjPJsxaWiMTZoSABUnpYgJ8kK/y
         Mwke99N3S8kTL1f7ryBRhGYrmxI57aHAp8kgAgpUMBuJBqOgjZ1G/wPxbWUyvre5Z9B7
         ZfsjB9PsiAG3UJr4o4W9l7KUMlncGt4BVbpw3q9dgejc3ESCVYWjWC40qy2YiN5cP4dh
         JF7A==
X-Forwarded-Encrypted: i=1; AKwUvBzqrGOPxssY/BJ1v9X9FgvSNRo7f/Szje9VpAufJMvj+/QORgCwffW8bnWAGUeHhoi94ithsvU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIE3sENpzJj74lZ2N+Z+xghMrMspbe2+wXOwlFXbOX0QIXvNsyN
	l7o0D+glLiq68pG2lWWXCfdQqE/3eZsDCZhbNd7jYQvAAlDAXT4r6JUN
X-Gm-Gg: AYBFou0IXQ8PNhn45Xt8jkG+tOOLXt6zti7LZnZH31A8oUwifbXKBhinGYSZ6BOrZ8E
	jNcnwXngkrzxGanIoSI9FRf65jQRvxXr1NrJW3m1CE2scp7+fOx1WrXggZ07ns1wWip90gYjePm
	hRvC76YIjdy25/L78TxP0s9/EbpwCMZMuM/VNGaWuCzuhU1AbxSLYKZtJaXJXLQlE/JH97NOXpy
	l/yRzc+fYSO3w7a8bxkeY/ViocvQ30Y5h8NvvdpnTdKFvhD4y4vjuARerJzhkYdYOq9bbiLVoR+
	kZfMhzanCP7Y7UrhJ+Br8HEdOIK7iuo+8SJvvEvNSgqYenrGbJFqBYBcAKYeKV2whqaOwjm5LC+
	Rj7egUg4yiMXKYBB6uxLPyEovwny2zinbF/4egdDKIMBQJNHiG2QKuyDE8ufr43to9wTluCXQM9
	0UL79gmNRVj9Z9f/RafbaOMXJonLaFWgt2TgjY8bbpD67JE03gF5FH0lO2pRr17EPlUF2qevUWE
	Gi2RQ+LntSLKWPmElTIUTw=
X-Received: by 2002:a17:90b:28c5:b0:39e:6a81:c923 with SMTP id 98e67ed59e1d1-3a098729524mr6985130a91.22.1790482306558;
        Sat, 26 Sep 2026 21:11:46 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4f6345fsm5542732a91.1.2026.09.26.21.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 21:11:45 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] HID: wacom: check the input device in the shared report helpers
Date: Sun, 27 Sep 2026 13:11:34 +0900
Message-ID: <20260927041138.4112920-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_report_numbered_buttons() and wacom_wac_finger_count_touches() are
reached from several report handlers and use the input device they are
given without checking it.

Both can see a NULL input device on a fully successful probe. The report
handler is selected by features.type from the id table, while the three
input devices are allocated from what the report descriptor declares.
When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
wacom_setup_inputs() frees that input device, sets the pointer to NULL
and still returns 0 - the "no pen in use on this interface" case.
wacom_wac_irq() then still routes reports to a handler that passes the
NULL pointer down.

Reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
device plus a single UHID_INPUT2 write:

  BUG: KASAN: null-ptr-deref in range [0x290-0x297]
  RIP: 0010:wacom_report_numbered_buttons+0x37/0x210
   wacom_intuos_irq+0x29e/0x3300
   wacom_wac_irq+0x1b59/0xb3f0
   wacom_raw_event+0x68f/0xb60
   __hid_input_report+0x398/0x4d0
   uhid_char_write+0xa99/0xfc0

Check the pointer in both helpers, following the convention the driver
already uses in wacom_tpc_irq() and wacom_wac_pad_event().

Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/Cintiq")
Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4cd87b781c4..177a1e09fd05 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1263,6 +1263,9 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 	int count = 0;
 	int i;
 
+	if (!input)
+		return 0;
+
 	if (!touch_max)
 		return 0;
 
@@ -4226,9 +4229,14 @@ static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 				int button_count, int mask)
 {
-	struct wacom *wacom = input_get_drvdata(input_dev);
+	struct wacom *wacom;
 	int i;
 
+	if (!input_dev)
+		return;
+
+	wacom = input_get_drvdata(input_dev);
+
 	for (i = 0; i < wacom->led.count; i++)
 		wacom_update_led(wacom,  button_count, mask, i);
 
-- 
2.53.0

