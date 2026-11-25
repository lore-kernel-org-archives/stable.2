Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640520;
	b=pWnMPaZ1hITDwyRX7MD1fMxyPE4Az71IJXYVvhPpTCmblAdzWMK0VneBW5xCnMaEZmT9
	 72/F4LHXq76nrmbDLFyJCoUgyaz+l/XmraeCOj/dByfyNXzBNeEmeAWzF5j1M3wJCHV6g
	 UNa/P4RRiGpn5j8Sm7v4AFYwd1O5SGbjL2nrtO4Qmwrsqf26rq+Nb+orNESjUFGs5yYf3
	 /FGNWfPDvy7U482e0vsh0VzHWVQDBNNAS7g4qlfo14TGGC4mmm+my1A2SCE9oVixW4M3E
	 ua8/6gvgwOQUYuV9Kpf4UK8puROfAn8RoAKG/WCXjRfklNF5DqQtbPmF2rsnttxx74Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=smmSgaVZzApJQV+Cv6DawJEFCZsBgrWDBhUsefeJK8w=;
	b=eg93Jw0yHQrZSXIMhZlVtWOL2gmOxLXvDgNNn2j0wuqcBls8KKhpT7qoh4nmWpWNcT1q
	 pSDe5wpiZDZ8JapvTN9eUMn/lWk3tLbWIBA8ZM+FqQJOIsGU0BJITCEhY5JJciyKKoWP3
	 LtRxRL8XjH6ZwfKPHMxHKSrV+uwlI5SQaun5zjmnhYB/W7w1rGb2hRvfdR/DTvzEwMZpK
	 bnRdhXzDNAYaAzjBMdQjVawGEmlooR2KrDVWMJi+m/NyieTersmoYCngRb6gvlnbE0rgB
	 aqF6gXwNgqs4XLaJbrB4rubS81sFe5CmhXFom6Uxq1dkN0V6Ln9BQ5JrtUKEcP6+0cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SBBTjyQR;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DD606A68C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 427DD606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SBBTjyQR
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-383ec96a7deso6779524eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795640518; x=1796245318; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smmSgaVZzApJQV+Cv6DawJEFCZsBgrWDBhUsefeJK8w=;
        b=SBBTjyQRI+HmVsOr3WFPMfUjzGNEBW9liGXOEX0r8CFWlKW/1Cbec9gW7kGsd3IsTM
         9/+7+8kiVHYf2h/kIe2f4/QjdVDxlrQPL1Jd5M3HxwyV0kF5W2C8tluVDoJMHKOP0f0n
         HV5VzIkLuGjbJ9HOv3FaIWeOlOjPI98Nn6Hh3uos2tbZKgaaLV4+XS/gkqLNC/gVMMq2
         85JOMA3KIPG3EWpjQ/xrlP3m0t8tTyTiAQhBD5oe4e6eeS7h6l4cdgLTH3hc0dqKdPu0
         JJx078Iru7tlPDEqg8eNTKRRUnuZEbAfqTkHL7pKcUqeegdvppQmXHR7B6h2dD9D6qTM
         jsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640518; x=1796245318;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=smmSgaVZzApJQV+Cv6DawJEFCZsBgrWDBhUsefeJK8w=;
        b=N0whYCwWwPCkCoxzhL7Ew/GoFPnRAKOwh8e0hXyixubZURIq3uJolrpbZbgi8vcY3N
         9g8OJf+jabi/2bpZMxY7PPLcdWkOR+0I50+3uyTOhWw8hkhQEiD3sjnfN5bSAeXfBH+F
         E3h7uCtAssuZyekyqRtzbuVazwfAAgLmoQnH02QX+g4sz7F/U7iy6TpBaQyuzpCCvRyN
         JKU/HHt0wTy64cBv0bOzDYsfohwVGmeiJLSIoKu5aVgLjnQSMpvHCN/mzt5mRZtJXVpD
         Jt4tJ31x6TrqVIIR6apWqfY9dV9OH7cR3mx2G2aXYe5xc635kHmO0OOA6YxmOXtkbetY
         XDkQ==
X-Forwarded-Encrypted: i=1; AL+hErFFFVGkbj+l4T4pUdpFlUTCHuKFtFqEgXe1ICaWr3vPtrjKPH0e2mgkuQ8K5X5V2jV4JjCChQc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ctcM4W4mSZlYPHS0a6RpyBvYbhBBMi/eFFWrjml2k/DnvGSOl
	cgDDrC2KlnjEDw0U0WFSYpn5ShX4nvdhOI5/cSP5nM29zbvypqzwR4j3a1eiGHZU/OLlY88CML4
	hJQ==
X-Received: from dybto8.prod.google.com ([2002:a05:7300:f148:b0:386:c442:456c])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:60d4:b0:369:fe81:a575
 with SMTP id 5a478bee46e88-3857111f203mr23506949eec.35.1795640517818; Wed, 25
 Nov 2026 13:01:57 -0800 (PST)
Date: Wed, 25 Nov 2026 21:00:38 +0000
In-Reply-To: <20261125210038.1277960-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125210038.1277960-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125210038.1277960-4-elkin@google.com>
Subject: [PATCH wireless 3/3] wifi: mwifiex: validate ext scan event envelope
 and TLV lengths
From: Elkin Cruz <elkin@google.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In mwifiex_handle_event_ext_scan_report(), event_scan is cast from buf
without first verifying that adapter->event_skb contains at least
sizeof(*event_scan) bytes, and scan_resp_size is not validated against
the remaining event buffer length before dumping memory.

Additionally, under TLV_TYPE_BSS_SCAN_INFO, scan_info_tlv was assigned
before checking whether the TLV length matches the expected structure
size, causing invalid pointers to be retained on short TLVs.

Validate the event_skb length and scan_resp_size upfront, and verify the
TLV size before assigning scan_info_tlv. Break out of the switch on a
malformed TLV_TYPE_BSS_SCAN_INFO so the loop skips that TLV while
keeping bytes_left accounting consistent.

Fixes: 21f58d200388 ("mwifiex: implement extended scan feature")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 27 ++++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 53aa16c1df33..52543532367b 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2627,9 +2627,21 @@ int mwifiex_handle_event_ext_scan_report(struct mwifiex_private *priv,
 	u64 fw_tsf = 0;
 	s32 rssi = 0;
 	struct mwifiex_event_scan_result *event_scan = buf;
-	u8 num_of_set = event_scan->num_of_set;
-	u8 *scan_resp = buf + sizeof(struct mwifiex_event_scan_result);
-	u16 scan_resp_size = le16_to_cpu(event_scan->buf_size);
+	u8 num_of_set;
+	u8 *scan_resp;
+	u16 scan_resp_size;
+
+	if (adapter->event_skb->len < sizeof(*event_scan))
+		return -EINVAL;
+
+	num_of_set = event_scan->num_of_set;
+	scan_resp = buf + sizeof(struct mwifiex_event_scan_result);
+	scan_resp_size = le16_to_cpu(event_scan->buf_size);
+
+	if (scan_resp_size > adapter->event_skb->len - sizeof(*event_scan)) {
+		ret = -EINVAL;
+		goto check_next_scan;
+	}
 
 	if (num_of_set > MWIFIEX_MAX_AP) {
 		mwifiex_dbg(adapter, ERROR,
@@ -2690,14 +2702,11 @@ int mwifiex_handle_event_ext_scan_report(struct mwifiex_private *priv,
 			}
 			switch (type) {
 			case TLV_TYPE_BSS_SCAN_INFO:
+				if (len != sizeof(struct mwifiex_ie_types_bss_scan_info) -
+					   sizeof(struct mwifiex_ie_types_header))
+					break;
 				scan_info_tlv =
 				  (struct mwifiex_ie_types_bss_scan_info *)tlv;
-				if (len !=
-				 sizeof(struct mwifiex_ie_types_bss_scan_info) -
-				 sizeof(struct mwifiex_ie_types_header)) {
-					bytes_left_for_tlv = 0;
-					continue;
-				}
 				break;
 			default:
 				break;
-- 
2.56.1.839.g22a8290db9-goog

