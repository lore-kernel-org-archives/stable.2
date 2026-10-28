Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206976;
	b=A962rkRCw+FzTKVooL3eCzjLGilh4siF6+2FiJ5UpJMTasBfm9blzSBuBr81OEb19ABE
	 QWBpuyt0BuWtvd9UeCBPf4RdyNED7qbPZKocyqWBuFweXIV5IlFS17iQMPqGBrJsofpYP
	 Ilte3s9XJRRaHomvm9AV72Ojn/OqBiR/I5lSM8wLUy4I6Uu3hCgPiiFVH3PJbaUkqbG6G
	 m/UOcbtxXwfta7OwCGvMxn29prinK5Kv44GSWoJGi2n3m3rKDg6d6/lkA7+tWEstknTxG
	 UAbfISSyqW7lQzN6EEIbYzmKHk9sD83kNKRzgqLnvxkHPibUpu7hKfzZKH1MQ6YWUKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
	b=nxkK916aV/pAPR1Aah/0ZxClgjG0nLITvA+1Sv/mP4mosf3JD/5K5PsswzBdmxFLN9np
	 +kZ6p008q9o3wL7KfaeBCVlZ7aJvK+ZpS9imo6RnM8U4R0loUe8Hww3SLcX32yN1E8gTs
	 wi75lSJb9cXwaMCf6psr+ejhco0WFwNZo153V+tUWvbDG3R842NRoZRDdoEMES+KC7/m4
	 u04/sM244Ay+BtUguEwARkqFZVSHAb99kW/qF3h7OppPrm65GmSG61QghJzDCX0KrMQHx
	 S5Qily6UAeqJoiCv1Kc5FvfS5F3MWBUdoD1LMV/Qlpt3JDJ0CPTuo2NwciyokLDvXYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCAI4bv9;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E4606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 617E4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCAI4bv9
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a2551d7b5so871013eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206975; x=1793811775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
        b=YCAI4bv9xSVcIEtZZaopTpLKWw5rgxidiA4KHd1ETDF3VFw/DfKTavFs9CaBLKyh/5
         h11acdL2CovSAMzz8UNgDnNvIY7iNaXLMJHjQ1cFOxKPtBNItZrHUHc3XHoe4utkiNCD
         xqK/qjrVFj4WH0kg157KhD5X/Bv0VswUeRX9pPkCwSP12x4UH5MTBZMD36slc96SMvIk
         h5qqjOvV5XE30Bw3pjMH21OLn1MnqaSlIkoZWrumIY2i8x/5NkIlwpJNXc4AKXWExkZa
         wcBX9XnWB8A8VndSqWrXnPxdwqbNZsrAqVMaWIllbrG/dBN8OAp77B3wV33PgFvvJ3oS
         X8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206975; x=1793811775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
        b=YOpZK5SvMxCqEq2nvBvBcACSjTJF6I4KnwJWrAFqqLhczBzOejBrKQA72RvIXL0Roi
         P8EmIUX7DkeqaOuhkyew4v28902nqSozFrJnXN6+73e6a4GZB/tzAh2Qj56IeZ5zMotZ
         HckvkKq9NiqveDgVatQnX5MNGe9j5pxmLcT1r6rpzCQbQn0uvg+oqsVotOftc6ipoczx
         W5LiE06b/jQjXYn7IXOyhmkmwxusuJgPBNjkhZvNXcxKFnYs24bRC9FMEq04J9JAw3HT
         MuVZC6d8lojcUOcppCsCFNoC0c+2YC9rzEsB6ufugPgmjS0JvfbQNNZWLDr8yKTJt0Zf
         OF/A==
X-Forwarded-Encrypted: i=1; AKwUvBxxEfTMxATT2ZKajWlYR8TG2RsgE25ecyQqa+oXBFYqSYznM+646RYKFbptNaZBppGaZIvALsA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0dGdsOsPYXbrxiF4W6iSOTV7guzAaCmjhh8kfa+FfUDv48q8S
	tjHKk3DQEHYeOOlGaPIJxfYN3vEf9DJjHKZBVgrLk51xCUD9Wdp0W7Us
X-Gm-Gg: AYBFou2RPMrLhXP3RnMs4Tz2A261llzBj9NqTZrZUuKkCWvCD2kMwPHQ9UeQTkUC3HD
	3JdaXaHsZs38hHznhYIS6j4oxiLoKs41Lgx4SjCUAp7yPRg8rqZ6Ycb/WUPUrv+YOIMnKPQxZBl
	HefmCZIRF5oHGLZtbNKdx3f83pVDEhutRDUswp4n2SB/Y7/Yrr2vNdUPapQLU0ASi/sOlzUOWsu
	b4GJm34jUFWZs8myfQTjIQawUZmvcGae2wuxx5lLjUctuG1Gm1O/uL4sCMwn0M2ZIhBnvzQYAvc
	eF+emG3ZgptT8OVAWUq+HWmcjJ7lumo5LEN9X+uQpw3/2K2p3K/iMBsbZxx7RI1M1c1rwOPxe9O
	C/8nRvTsD73D7ncZGyRBDIFxh+cisWmoMbqvCXUrQy1KNfk7PLqSTM4CEeybhDgyH8QkiTWkGuY
	1zIAOhJNXpvanVfJayWNQa5G3Gac0RBkk3g2RVfY9618iM7Iu7RmLHdNGsE+9kk5wKC8HBIvB8h
	kUxvGPQdJpO+CxXXTmm75Hve3WGA2wZZVliw17Pwl2TeXzhYmRMRQLvgjsQkXTGyJd/OzMWSE/a
	kAJeFEmb5UgEevJknrl9C2beClzyXWrQFJ3BENLWEKgozfseVn0=
X-Received: by 2002:a05:701b:4514:20b0:181:6b8:31f1 with SMTP id a92af1059eb24-1a9494d8c4amr124363c88.10.1793206975189;
        Wed, 28 Oct 2026 10:02:55 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316:67c4:cda1:9c81:43af])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75ef5b2b2sm6832139c88.15.2026.10.28.10.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:02:53 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andre Brait <andrebrait@gmail.com>,
	Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
Date: Wed, 28 Oct 2026 13:02:39 -0400
Message-ID: <20261028170239.28606-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When an skb arrives at the driver and the header length exceeds the u8
hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
are sent to the card. If TSO is enabled, some header lengths will cause
the card to hang.

This was reproduced on an I218-V with an unprivileged Python script.

Fix it by disabling GSO and checksum offload when the header length (and
checksum offset) would exceed the field widths. Compensate for a
software-inserted VLAN tag.

Because of a quirk in the ordering of ndo_features_check, the skb's
transport_header field may be stale. If the skb carries
CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
no reliable interface, so don't offload it.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6f85dab5c55c5..370776657d100 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *netdev,
 	return 1;
 }
 
+static netdev_features_t e1000_features_check(struct sk_buff *skb,
+					      struct net_device *netdev,
+					      netdev_features_t features)
+{
+	/* Do not offload packets whose header lengths exceed the u8 fields
+	 * in the descriptor.
+	 */
+	unsigned int hdr_len = 0;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		const struct tcphdr *th = (const void *)skb_checksum_start(skb);
+
+		hdr_len = skb_checksum_start_offset(skb);
+		if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
+			hdr_len += __tcp_hdrlen(th);
+		else
+			hdr_len += skb->csum_offset;
+	} else if (skb_is_gso(skb)) {
+		/* Work around untrustworthy header offsets in this case. */
+		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+	}
+
+	if (skb_vlan_tag_present(skb) &&
+	    !vlan_hw_offload_capable(features, skb->vlan_proto))
+		hdr_len += VLAN_HLEN;
+
+	if (hdr_len > U8_MAX)
+		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+
+	return features;
+}
+
 static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_open		= e1000e_open,
 	.ndo_stop		= e1000e_close,
@@ -7374,7 +7406,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 #endif
 	.ndo_set_features	= e1000_set_features,
 	.ndo_fix_features	= e1000_fix_features,
-	.ndo_features_check	= passthru_features_check,
+	.ndo_features_check	= e1000_features_check,
 	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
 	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
 };

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.43.0

