Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790252;
	b=VrKNrxnYuHcwNxx+VxP+F2vJCfbA83deNpstvh+I8TINUR6znbpgiqZ1O0ZZv4CLZ0Ep
	 hYFUHhsPeyS25Z/bvxY6KmH2yy1rO9LhvWzP0+gEF90wIxS/OG3M2TW7a5hxVewt/kZcc
	 Kuy+2N9czWySW73NluqZELw9XpFMaFGMQWxKB4qmhhviI5W5WusHgiUSAeJqq1ZUmAHd5
	 UvVDP7AdmoIKPwkK52R2tbtk+AFom7dRptXqD3qKa2RD+wuhgRsgl7M4Y/GKDFqAKpbMd
	 9Sfs1J0Ap1ImAAsUC6p2UJnPFisuZslcsTF9Ruh5ZyK+qj9Ww/VSHbJjzZSI1uKOoAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=W8Tbj15l65wdrQ6nP1bdM5KDmeBZZQ0e1b03QxB4foY=;
	b=dulHbMDpSbM/XVrXlrQzJgr279c/wjR+VJj4MN4o6j3jULyh+JHPEf7Cikq50xzJyVei
	 i2J7lVyDWfsiWh+6CnaW7+sIpuVciCuyQjR5vyHkWpPQUs1TzZFp7jNj6SliEv1rpDZAK
	 kSHshLgPlqCYKAu4Go+Unv0evxohMwvNFeA/X08ildKJ014ITUJvYax955EyXgrS821kk
	 PNf83q/Zb2v51i/6PI/TKxoEU0zuZtn8rIYH+EMfkU1IQXUf6Us1gMFMBfHVxtoMi3oXd
	 iZ8eaGdR1h9Xzi1mRpiQF6vRnD02JAc0j6fD1EFZ3FXCCLwSB8lcOCoodrUzx17SCDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6kxLp6+;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E7606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 11:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F32E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6kxLp6+
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso3183085e9.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 03:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793790250; x=1794395050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W8Tbj15l65wdrQ6nP1bdM5KDmeBZZQ0e1b03QxB4foY=;
        b=x6kxLp6+6OdHly5ZjwbVKxcP5nNxoiBGXacIlAc0bItDupUMHNN3wxAKO/SK6wXwCv
         ZS8bJuOyDtL/3ETRewTitB5b0bLZZrkIYmBtGfiaMr/Oe1fzEX6qhI8e5c+nEb8+aRMv
         fg+JZuc2M6ooueTPGzkXHedrOHw+nOdusL1FhG++ekipJH7kjXjZs0zzZLisCBD424xv
         tLooMNYvxFRoLV/CKo7KTneOEm2fE2H/TBcSDQVu1ewGGKpvyDo8geX54Zvv7a40I5z4
         TyqkhgvcOfqRMaG4InFMSmGtqEO0ss2/15WUXwuW1yeG9Efa1TQ3q4jOfrIJeYUxFkva
         6dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793790250; x=1794395050;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W8Tbj15l65wdrQ6nP1bdM5KDmeBZZQ0e1b03QxB4foY=;
        b=PYK2SCmAHIY0xD6c89MiTrv34a4QCV4OhUncKaHuq9xUkKD/ansY1BZdibXeZPdoKb
         RhGjOe/AeBmO0xm/IoDSZFONH0u+n4lNI/acMNjs2JewvUQoPaVu9eLWXx+1BhZTeCO6
         DNz6TFAnNmxIrfePgkCMjQO5psDpyBYlhC7yCq6VO7C+htRgbHZs+cfjk8lwUwPuuqEr
         GmluNKUu9PfzXU8QoVE50dhkU9mKqBqco+jInSXmZNgQl5yP/wU5peMcVZCtOLSo7pXZ
         Hxx9WWtKFUwi6xL+VsJt7AEVdecObHevbXxz8WW042j0yfBMMRAgGJyheik7LUOaDZg1
         lRxA==
X-Forwarded-Encrypted: i=1; AKwUvBynPJrpR3EezJgv6tztjTx69iBRYRfhhZgk1pqz1HMDWqxR6FLmji9BtKnd9rxY4GY3vru47Nk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aZGImwhcQhLF2MF9NMjbqYLEwNhNQFIpwZrT8QPCF8IQjiI1L
	4W+ntyWpUglev5MGprY0rcTd6RZ1iiMhXZtgB5HT6+1xeBSnCrGy1B0=
X-Gm-Gg: AYBFou2Tn6K8xoUR8IeuOMkTTmFLJqO7ya+Aq8eoxSvkXj0reictrogeBoYgPD/D4mg
	/mWKWC4cZifrWu39ycCfDURuuyaNkOkEA+U/d01+KCNnTMEbNxSl1GYOvKs0r+gr2v5ntCDICGU
	o6WhCA9SUdzMB7J6QkdFTwLY3l2tCF9sIk3NnwcWI18a7DaUVGRjxJuEDGXvj1GNs+52MKVRqTw
	emKYhDhn6GeeyGqetpGPlGgf64AR/FmIvXSmIVh2UIybJ+VaRbQQDW3/lHcbrTaYpMbZ7ozqBMY
	czANmmFOH+VuLJB0uEVxwCzZ46audXxlj+4de58VHsWyvccPedT2QKIa15K0dHcd0qwb7lMLYLs
	Q9+LtEyVlAaaPH8r2dFIIPjhXruh3GE0TBnaN7GXHP6a+SBfwItaHU7rRULsa0tDK5waZFRamac
	/OnAOMAolLyMD+3uLno87gphZrHMWQHPg+oQ+LsaK9PWqpwIG08QyBur4wx5vrVlZ89gXOAJsJ4
	BMPyY7VRkh/bGe4hbvtwdfN2fKPuNqhNdwPHDxmB0ZhJ+qaFa+/CR9at1pfNbUnz5YV3Baya33i
	2PZuv8BcQL4=
X-Received: by 2002:a05:600c:674f:b0:4a2:1655:87db with SMTP id 5b1f17b1804b1-4ac1228a434mr377260735e9.0.1793790250163;
        Wed, 04 Nov 2026 03:04:10 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c748105sm43888435e9.6.2026.11.04.03.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:04:09 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
	linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless] wifi: wfx: validate num_tx_confs in rx_helper before use
Date: Wed,  4 Nov 2026 11:04:08 +0000
Message-ID: <20261104110408.986252-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rx_helper() reads num_tx_confs from a firmware multi-transmit
confirmation and uses it to update tx_buffers_used before the message
is dispatched to wfx_hif_multi_tx_confirm(), which iterates over the
tx_conf_payload flexible array.  Neither path checks that the message
is large enough to hold the claimed number of entries.

Add a struct_size() check in rx_helper() before num_tx_confs is first
used, so that both the buffer accounting and the subsequent iteration
operate on validated data.

Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Moved validation from wfx_hif_multi_tx_confirm() in hif_rx.c to
  rx_helper() in bh.c, where num_tx_confs is first used for buffer
  accounting, so the check fires before any side effects (Jérôme Pouiller)
- Used struct_size() for overflow-safe payload length computation

 drivers/net/wireless/silabs/wfx/bh.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/bh.c b/drivers/net/wireless/silabs/wfx/bh.c
index 0071659bc9c98..d4c904324edb7 100644
--- a/drivers/net/wireless/silabs/wfx/bh.c
+++ b/drivers/net/wireless/silabs/wfx/bh.c
@@ -99,11 +99,23 @@ static int rx_helper(struct wfx_dev *wdev, size_t read_len, int *is_cnf)
 
 	if (!(hif->id & HIF_ID_IS_INDICATION)) {
 		(*is_cnf)++;
-		if (hif->id == HIF_CNF_ID_MULTI_TRANSMIT)
-			release_count =
-				((struct wfx_hif_cnf_multi_transmit *)hif->body)->num_tx_confs;
-		else
+		if (hif->id == HIF_CNF_ID_MULTI_TRANSMIT) {
+			const struct wfx_hif_cnf_multi_transmit *body =
+				(const struct wfx_hif_cnf_multi_transmit *)hif->body;
+			size_t needed = struct_size(body, tx_conf_payload,
+						   body->num_tx_confs);
+
+			if (le16_to_cpu(hif->len) < sizeof(*hif) + needed) {
+				dev_err(wdev->dev,
+					"invalid num_tx_confs %d for msg len %d\n",
+					body->num_tx_confs,
+					le16_to_cpu(hif->len));
+				goto err;
+			}
+			release_count = body->num_tx_confs;
+		} else {
 			release_count = 1;
+		}
 		WARN(wdev->hif.tx_buffers_used < release_count, "corrupted buffer counter");
 		wdev->hif.tx_buffers_used -= release_count;
 	}
-- 
2.47.3

