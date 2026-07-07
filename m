Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D839E177
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461942; cv=none; b=ZHDPcLIFfeDAMIKMSOToRTW/EQAP8mhO/e8vXdJpk9JHJHd2xqXMpyHZxUuGc1ElxLpe1u74ONsM88fF2fzPUX+75fytiEaN5/2ZJqqD2Hit40iVuDPIuNTFr43IkNA0H13nQ4X+RjnCmVwdUh+eQ9WvhVxdxh9D/21bCnLo5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461942; c=relaxed/simple;
	bh=HD/IfcKOQqrgbt3YrPnPJCPNGxQcu/04dn/Qg516ZiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQTY6e99pxt3NvD6crpUDqvgqQJ/BF+KRFllgVAfltRAjMKmxv4/YBow76wGLuDjkr/oy6BbpJtPYpfOp6NsGxNAMTwIbJrvfRufUPB4cFPDteuinkoQu6GlYqa/wvZxEPNT7E1GKTldziOYCFeGjSQUr9TKEj6Zp7XMcAQHeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0Piza/V; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0Piza/V"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92ea24a2dbfso98985a.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 15:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783461936; x=1784066736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yxeqz0kniPlz7hPvLPMhtJlXvKgsX6m9zByp2BZxHio=;
        b=O0Piza/VKyc2gRuSBNGG3Gtzyecmafmjs07DBHa5SKdBXC78wXleL+xrzvnYzGc77G
         rMOcv96MBuZUhMB7hUm4dZsq2SU01qlLj0jsGBrAqXnom/7m6L/YFjKjqEKKOk/NmHOA
         JbbvVpc1L06Nv2SZcav+/RWKUBMu08DauBk+ACqJrndeaSsxFvMqs7MlX2svFngwzuTr
         vjduUlxuUr0Vwg1nsysvc3HEJ6+NOlZKvHIEqNRFDNmypnmJJaTcbkf3lcT4irmIicXK
         6oJKpN+r4mPQ77OBhhkD8+0Knl8qOReVfnZmCNieWgi5M3SOSrDGvi0Al6Kj8UcwaxG1
         Iniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461936; x=1784066736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yxeqz0kniPlz7hPvLPMhtJlXvKgsX6m9zByp2BZxHio=;
        b=YOyLz/tXLQmxAg1J7l9mIoAv+aBxYELepU+QWJOGNqjWBIEpBttsvJeHf/Z2QE1r1n
         76glVM1xV3dwRKx0wjQUYnCDqhcH4uvmVUgqX27RxJJuA2drBuefvjT4I2NwAANHhm7H
         W57ugcz0yCijnC/okWtwvn+GqywIBQPaYOioRSjuqaWMn7qgZ2vEqq6cHxf6l0Iopg6m
         cn6Q7v6SUkebptPpu3UwFt1MkadMYUiS6nOEULDo0douxTe6GQleIicy5qXfvVUV1wgd
         DRl9ehMyznvTbp/2pS6Gt808s9t60gbTto5QuPCmTYNUA8xlv1fiq/xBsnW+5pCoN+mM
         miig==
X-Gm-Message-State: AOJu0YzlOCoAqM38aP8NOTblZmw4A3LiW1JVrrTw1QWzy52kNqLzSq+3
	TWSsqby/qgvCN27AGYnEBdrfw0LXxXKe4oC7uS8CymPNVi41BVcueXGd+8bLTLV8
X-Gm-Gg: AfdE7cnn2lpxCMApPB7bHqRRV1MEbND2zJHmEmH4VwhsDcf6zrUN8qGNz6in3clG7w6
	0YPLVQquU+AQwtszZlmt4AuD0M2Oc40hhz36+4Ad0BRGRI/RynnqxJ2inYoQLtsIuXBM7765neV
	QSfyyICSFpk3VCWl7ED4SWex3XjQ7mprCZzDDkoJjfZHPCjXL2NeHvB75u9P47OBC3yaPUnaQsk
	V7Moluk7Ru9S3JQ80A8MlD2bi+tBYhwSfgaYb+hDN7NNJARTtWBSscvxmifPUkrorEH4KkrXJGB
	ai7eFTmGGsoLtR2f+7HDb63YLDlTDMbfBsN0nil3jeBFLQeog4C3/NtQAdw/u0n0K2EahxjoLc1
	5fMtAjeeSdPvE5/yf7puuO27EYZRZt2YVRtZdGvurFcr1FT5iPQrrtvXTut1KwX1aLzJ/eFRSSw
	rA8p75uO7Ts+R/pE4loCDM2nKOkBnAWUHXWhGoSKIMy0N7Ir0s6PLi1RGtd3HPzQQYnfseOqAoR
	mPIRNvL8jKNYSXplscjyPOGhSHXVo9VfMQ1O5Wu5YO3CiA=
X-Received: by 2002:a05:620a:2703:b0:92e:5bdc:aeba with SMTP id af79cd13be357-92ebb59045fmr842966785a.54.1783461936503;
        Tue, 07 Jul 2026 15:05:36 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cc18f1sm1250745685a.40.2026.07.07.15.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:05:35 -0700 (PDT)
From: "Jeremy Erazo (Devel Group)" <mendozayt13@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2 6.1.y] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date: Tue,  7 Jul 2026 22:05:26 +0000
Message-ID: <20260707220526.271712-3-mendozayt13@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707220526.271712-1-mendozayt13@gmail.com>
References: <20260702144207.320421-1-mendozayt13@gmail.com>
 <20260707220526.271712-1-mendozayt13@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeremy Erazo <mendozayt13@gmail.com>

commit f4da3ee15de9944482382181329bb6d7335ca003 upstream.

Copy the content of a Periodic Advertisement Report to BASE only if
the service UUID is Basic Audio Announcement Service UUID.

[Stable backport rationale]

This fix landed in mainline v6.7 without a Fixes: tag, so the stable
autoselect bot never picked it up.  linux-6.1.y HEAD (v6.1.176) still
carries the pre-fix code at net/bluetooth/iso.c:1613:

	if (sk) {
		memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
		iso_pi(sk)->base_len = ev3->length;
	}

ev3->length is __u8 and iso_pi(sk)->base is __u8[BASE_MAX_LENGTH] where
BASE_MAX_LENGTH is HCI_MAX_PER_AD_LENGTH(252) - EIR_SERVICE_DATA_LENGTH(4)
= 248.  When an attacker within BLE radio range sends an HCI_EV_LE_PER_ADV_REPORT
with ev3->length in [249, 255], the memcpy writes 1 to 7 bytes past the
buffer into the trailing fields of struct iso_pinfo, including the low
bytes of the iso_pi(sk)->conn pointer.  FORTIFY_SOURCE flags the write
with "memcpy: detected field-spanning write" but does not block it.

The upstream refactor addresses this by:
  1. Filtering via eir_get_service_data() so only the BASE portion of
     the PA payload is copied.
  2. Bounding the copy with base_len <= sizeof(iso_pi(sk)->base).

Backport notes for 6.1.y:
  * eir_get_service_data() is already declared in net/bluetooth/eir.h.
  * The header include for eir.h and the EIR_BAA_SERVICE_UUID define
    are added here, matching the upstream commit.
  * The put_user() addition in iso_sock_getsockopt() that was part of
    the same upstream commit is not included; that hunk is a separate
    getsockopt correctness fix and is not required for the OOB write
    fix (getsockopt(BT_ISO_BASE) is a controlled path that already
    validates optlen against sizeof(iso_pi(sk)->base)).  Applying the
    getsockopt hunk here would risk a user-visible ABI change on a
    stable branch.

Reachability: any host with an ISO listening socket bound as a
broadcast sink (LE Audio / Auracast).  No pairing required.

Fixes: 9c0826310bfb ("Bluetooth: ISO: Add support for periodic adv reports processing")
Cc: stable@vger.kernel.org # 6.1.y
Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[jerazo: backport to 6.1.y; add #include "eir.h" and EIR_BAA_SERVICE_UUID define; drop unrelated getsockopt hunk]
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>
---
 net/bluetooth/iso.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7ea3e6335..6b8622bec 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -14,6 +14,8 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/iso.h>
 
+#include "eir.h"
+
 static const struct proto_ops iso_sock_ops;
 
 static struct bt_sock_list iso_sk_list = {
@@ -46,6 +48,7 @@ static void iso_sock_kill(struct sock *sk);
 
 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
+#define EIR_BAA_SERVICE_UUID	0x1851
 
 struct iso_pinfo {
 	struct bt_sock		bt;
@@ -1606,12 +1609,16 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
 	if (ev3) {
+		size_t base_len = ev3->length;
+		u8 *base;
+
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 					 iso_match_sync_handle_pa_report, ev3);
-
-		if (sk) {
-			memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
-			iso_pi(sk)->base_len = ev3->length;
+		base = eir_get_service_data(ev3->data, ev3->length,
+					    EIR_BAA_SERVICE_UUID, &base_len);
+		if (base && sk && base_len <= sizeof(iso_pi(sk)->base)) {
+			memcpy(iso_pi(sk)->base, base, base_len);
+			iso_pi(sk)->base_len = base_len;
 		}
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
-- 
2.53.0

