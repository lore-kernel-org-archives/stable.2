Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938D3A1D02
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461941; cv=none; b=muV37BLexgP5TQOOiEBV5AbhdNFlUIhzhCrOYqfspgOTNk1HmhV589B0w29FnU6WzOpNNH54uBpSTGtyD6rpuY3D6zUnPBY+ocBZAYUxJwJsR5bSciWCp1Uh1YdjogIQOUcxOpLtyD5wRhzCIqovMQp5hYj+4lWQctt7NUcVLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461941; c=relaxed/simple;
	bh=pBjlrX7yc7iWSMsIP+cQ2j6MxLyzrTuCrJliZbSWiho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G438/9fbqwma290pONUgBQqTiljXBEpPmbzovEiQJjmCzkrI0GWRiTzZe5RdXHoHz3ScjRhKiUILyyjKMM7wwlvnSgALsf5ZbU9il4E6uz2F8Foj2AVd7VE1zvc93AsjNun5qeHakKhwW5y72uXOs6hsoIvXSNDzORvYnxYzj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp0+p056; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp0+p056"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e54f8c051so228186785a.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 15:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783461936; x=1784066736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuDSN5qpWrmOuyqcOwJR50zBGcAs40Wq+fAb7qOT/cs=;
        b=Kp0+p056FNVnKZS4h9n44Fcw0+IIhJnXL+c4Bz8Rmjt15qmCSNKLAtP6tmjBma9VIu
         5W/odDmPmudEEz1rIANtVYk2Zfq0ZzwjybIMhTN5S6Cd2Jm5dgOGPjeZSjHS51c4k+mV
         Z6IWdzuB1V7FXV67wKFbwU/+HMk3KdjN6ygm1+p+QZNHttMfQ4+3I+W3fYxGgYy+Ei0B
         gUyEFjhfRp1A+OIbXRgFhB11RLdQw7J9hMHDNtCMypGALfR0sir7oqKNJHVd5s6kd3kE
         KwUpZvy6Xnv1I2WC5WJ/B0m+0SfD5qdoimymhkOvi92p+8T/r7jgcEzT+/vZYC4RwoCD
         P6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461936; x=1784066736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuDSN5qpWrmOuyqcOwJR50zBGcAs40Wq+fAb7qOT/cs=;
        b=Y8743Wg74keOnamb4Iu3hscMvW5P/LjYuHA35VlSgep5wgt+3s8dNaw2FxZa5eAMcK
         batfOBOqfB0wzHqirG64Fc2fAJ+PRXv7dmvn6zRI5+egVNYiaH9HIbv5uHXYui37v/lr
         WU7o4Dp2c0EwKdo25TMbGKLrLgzuIsunFJqDib2bKnJFySgM7szeb6J/1XxHld+LKi4x
         gPJ0U/mEMtyc/yRqgUJPFoI1s2+1DHf0idJqR/b748TD/1kQXH1BbDPTKZQFOJ1d+BIe
         zUJcm3oHbdCpndpHLpnFqaHGxTVFqyEvQ0iGCaREgM2XQqR96xDrhc3ioP0D5dM+2EMk
         6irw==
X-Gm-Message-State: AOJu0YwmoZ3dyba4FANrCeD3rt+ed/18oUH1WtceLmHWuNFUEJKwUx1e
	uLc5oc8SqXh0GlHEAZAfTSYn49CXK2u5c4z3219E1/TBStl010y+FfeRQ55KE3cJ
X-Gm-Gg: AfdE7cnbxtpwQRTOOO+jiUI/9eFKft3kOfVbFbymI2DlfuRZZxyC1ulqyRys5AZN8mc
	8cN58ux3Rva3C63iDDGqGVEQJPkUh1i65xTIJtkGxhGYBcR80Fh4umPhwIWJ+i5ZLPWUnpbQiHO
	sTCZ/sYCiWYRKqfFlmNZE6nW+PrAdEbqME15pT8nOIFWbMFVSWxFr8e+9NMaAkpxQeRI/6/z3hC
	1gJK3MjdWRYyS3dRNRl6Hrxm3SROxKBAQPv3AL43w08/kVRoS08QGYlMP+bNcZKS74kd9OOIaXs
	hAee9QQpP8gvhxxAyF4uyi3W5XZujDDfX1CbPSFLTtcJSF+EUr7YiuMMfUwC2f+bnWcRAkmWCbx
	ugovgHO9ZQUOpsl+QWSCpIjTxd0P+JD+u29uWUQHVnqBhut9/z72oHgRLIIm6ExAuJCyZ2ttoXY
	RTNqQXSfcIKLpzJJbv7dwZh3IjnuHZGWZ4szPTI2g0rfxTe/UbcYpqgL2MiKYV6hHe/9uPXLS5S
	8rm+VYvNKC8gUMO1Mf6IpZAE7srHvfjRJz2
X-Received: by 2002:a05:620a:4009:b0:915:a6ca:f12a with SMTP id af79cd13be357-92ebb58fed2mr863565585a.54.1783461935481;
        Tue, 07 Jul 2026 15:05:35 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cc18f1sm1250745685a.40.2026.07.07.15.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:05:34 -0700 (PDT)
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
Subject: [PATCH v2 1/2 6.6.y] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date: Tue,  7 Jul 2026 22:05:25 +0000
Message-ID: <20260707220526.271712-2-mendozayt13@gmail.com>
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
autoselect bot never picked it up.  linux-6.6.y HEAD (v6.6.143) still
carries the pre-fix code at net/bluetooth/iso.c:1935:

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

Backport notes for 6.6.y:
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
Cc: stable@vger.kernel.org # 6.6.y
Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[jerazo: backport to 6.6.y; add #include "eir.h" and EIR_BAA_SERVICE_UUID define; drop unrelated getsockopt hunk]
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>
---
 net/bluetooth/iso.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 011b2187b..3259c9c1e 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -15,6 +15,8 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/iso.h>
 
+#include "eir.h"
+
 static const struct proto_ops iso_sock_ops;
 
 static struct bt_sock_list iso_sk_list = {
@@ -47,6 +49,7 @@ static void iso_sock_kill(struct sock *sk);
 
 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
+#define EIR_BAA_SERVICE_UUID	0x1851
 
 /* iso_pinfo flags values */
 enum {
@@ -1928,12 +1931,16 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
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

