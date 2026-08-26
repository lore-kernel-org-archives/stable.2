Received: from sg-2-5.ptr.blmpb.com (sg-2-5.ptr.blmpb.com [71.18.227.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67535BDAA
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764093; cv=none; b=NdnaLvZLP5BsvYV6P3/opO/d2S2uU1PMJP9ctHZUzefH2S96mmIG1RQD/2Hz0L/CCFpjJKT99MtynWl+C1Ufctj5vj8iD10TMSf7gIrTU81ArWSQG2uX8TN9bKEmNHtu8zYMOnCR0gIyc89ZDBv+Hg3FslfViNwdbZvI5Z46yWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764093; c=relaxed/simple;
	bh=lA8uhkZaDW7Vi5VTYYunr4NGhJoC8vUeSIjSRZVsHBI=;
	h=In-Reply-To:From:Date:Cc:References:Content-Type:Subject:
	 Message-Id:Mime-Version:To; b=ri4Hpv2L4fPtZVmCsscaIyHAeDpl7C0MFMQbtw1VXADoI7ncIcp6WFma0mSG19HUAJaJzXbglsydnUDPGcidnZcapsDIQLkt6sFawxCdUtf24F59bOCNk4UGdwPiQAu8kCKb2YyH556U+4qgHMAQ9Fqhu3taQHqcpa8DoVQiXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=psu6tyQd; arc=none smtp.client-ip=71.18.227.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="psu6tyQd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787764069; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YouVmwbOXKFmVb2f6IWbuJ+2i64UrcZ34QAzG438L0c=;
 b=psu6tyQdcrrnkkO6tYEsVLTgEuM9t/ECaJrSNYZ+9r+u1wLDWxXa15wn5Z8d3LMttpDfm2
 iDxQrR/OfIfczWBvpJ5w2Alwl8svTFTOBOpgKaUUXSIuzYXfeTOfdPQFViK7vjvUEFCStl
 SaVDvkAveNE3f9VKE69mgGCQb7fMJkGU/zbcLV6ZwPD2M6eb4vJBNrVTLXWXkTBZaZ2ggy
 +jblA9mio1YLjLeLuct5e0lG9J6o6DDpW31OZGl3R/pCMNBuaKrlaFDIlGb58iOKuLY/d5
 whvXsw0EgrVBEFqnQwHgOSZYaYDvFQqNUwzLhsunEUa/nnA3RKOxNz9GQWkguA==
In-Reply-To: <20260827-p54-pda-validation-v1-0-bdc2b0675056@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Thu, 27 Aug 2026 01:07:40 +0800
Content-Transfer-Encoding: 7bit
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
X-Lms-Return-Path: <lba+26a8f1d63+78bd87+vger.kernel.org+me@cherr.cc>
References: <20260827-p54-pda-validation-v1-0-bdc2b0675056@cherr.cc>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Subject: [PATCH 2/2] wifi: p54: require a full exp_if record in PDR_INTERFACE_LIST
Message-Id: <20260827-p54-pda-validation-v1-2-bdc2b0675056@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.9.107] ([111.42.148.29]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 01:07:46 +0800
X-Mailer: b4 0.14.2
To: "Christian Lamparter" <chunkeey@googlemail.com>, 
	"Michael Wu" <flamingice@sourmilk.net>, 
	"John W. Linville" <linville@tuxdriver.com>, 
	"David S. Miller" <davem@davemloft.net>

The PDR_INTERFACE_LIST loop only checks that the record start is within
the entry before reading an entire struct exp_if from it. A truncated
trailing record makes the if_id/variant reads cross the entry boundary
into the heap beyond the EEPROM buffer (verified with a KASAN
reproducer of the loop). The variant also feeds the synth front-end
selection, so this is not only a leak.

Advance only while a full record still fits in the entry.

Fixes: eff1a59c48e3 ("[P54]: add mac80211-based driver for prism54 softmac hardware")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.3
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/net/wireless/intersil/p54/eeprom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/p54/eeprom.c b/drivers/net/wireless/intersil/p54/eeprom.c
index 968ce9a411358e0e6b83117b1a077becc3207090..472edecf55772893afdf8be3020e6baaf80097a5 100644
--- a/drivers/net/wireless/intersil/p54/eeprom.c
+++ b/drivers/net/wireless/intersil/p54/eeprom.c
@@ -817,7 +817,8 @@ int p54_parse_eeprom(struct ieee80211_hw *dev, void *eeprom, int len)
 			break;
 		case PDR_INTERFACE_LIST:
 			tmp = entry->data;
-			while ((u8 *)tmp < entry->data + data_len) {
+			while ((u8 *)tmp + sizeof(struct exp_if) <=
+			       entry->data + data_len) {
 				struct exp_if *exp_if = tmp;
 				if (exp_if->if_id == cpu_to_le16(IF_ID_ISL39000))
 					synth = le16_to_cpu(exp_if->variant);

-- 
2.47.3
