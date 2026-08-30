Received: from sg-2-3.ptr.blmpb.com (sg-2-3.ptr.blmpb.com [71.18.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B963016EE
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788115351; cv=none; b=tAqAoqUZU9cccW1ljA+efz/nxZ0xrxLh3upb0lyWegUFx3FgYXY9lCyhKClxHoaXb8AgHIPXDzlkOq5Ih7GC+pCsIwWmXmYKNxYmjFy33Om+fzokxXyEmrvOjqCsga+56DBYyS3YxB2D2UKHAdJV0Id+5WUQrkRjECoNJ6nSSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788115351; c=relaxed/simple;
	bh=CL0/kY3bZfJVBbAxvDY0/bQoDkW/j7WSp2TzqY/TE7I=;
	h=Mime-Version:In-Reply-To:To:Subject:Message-Id:References:
	 Content-Type:Date:Cc:From; b=CnHSkEiXboYLnkCAsbwjOcEC/8bM8UrPjrbDv/D5nBcglEchgQscM/2y3OE3Ls9a+Ylb9qcV99Wf8+GLDy9soaQ4zSAMB4/6veH8zQ5vuslWJarpJp/Qj8e8kDuCDCbm+Q3enjwhr+SnOCCQ3mHbg+uQLB51fivU7U8nnP6K4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=Mx2foPvK; arc=none smtp.client-ip=71.18.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="Mx2foPvK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788115338; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=7KRhxGIVwdrzN+rJYLkuSNUS8MiHyIi4c/SKannXfOI=;
 b=Mx2foPvKWAwGNZtoxnw0/HO9s4PNHmiDi4hNueRtO8nncKT204MTnh+BJXqjr0WPfjT3Cq
 3v6xeSetoaHr9zmhdsZYuQ8baTnsHfbaALM3uZQFICyfhU9rXFc8Fo5YI2XNtWtkQyXHVb
 a8wagT7WSobEUjNeieObXfhaqdAj0QDoCVL6eT+yrK3Kxul+C1kEr/wkPMTVhbhwRSVtOo
 thlET6oGXcIceqVGgSI3fkdvEWChk4bkSKdPZujeMG84P0uRL7MzxczvPQv3EJ2DZ+Pn12
 BiR0C+FkgtlytGJiY4mERAlsshoMP4Eg9P/Rk4ykpK307sgrUd184Ok3dY+8gw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260831-p54-pda-validation-v2-0-dae566b388c8@cherr.cc>
Received: from [192.168.9.107] ([111.42.148.195]) by smtp.feishu.cn with ESMTPS; Mon, 31 Aug 2026 02:42:16 +0800
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a947989+2cf692+vger.kernel.org+me@cherr.cc>
To: "Christian Lamparter" <chunkeey@googlemail.com>, 
	"Michael Wu" <flamingice@sourmilk.net>, 
	"David S. Miller" <davem@davemloft.net>, 
	"John W. Linville" <linville@tuxdriver.com>
Subject: [PATCH v2 2/2] wifi: p54: require a full exp_if record in PDR_INTERFACE_LIST
Message-Id: <20260831-p54-pda-validation-v2-2-dae566b388c8@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
References: <20260831-p54-pda-validation-v2-0-dae566b388c8@cherr.cc>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 02:42:13 +0800
X-Mailer: b4 0.16.0
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Christian Lamparter" <chunkeey@gmail.com>, 
	"Shengzhuo Wei" <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>

The PDR_INTERFACE_LIST loop only checks that the record start is within
the entry before reading an entire struct exp_if from it. A truncated
trailing record makes the if_id/variant reads cross the entry boundary
into the heap beyond the EEPROM buffer (verified with a KASAN
reproducer of the loop). The variant also feeds the synth front-end
selection, so this is not only a leak.

Advance only while a full record still fits in the entry.

Fixes: eff1a59c48e3 ("[P54]: add mac80211-based driver for prism54 softmac hardware")
Cc: stable@vger.kernel.org
Acked-by: Christian Lamparter <chunkeey@gmail.com>
Assisted-by: GLM:5.3
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/net/wireless/intersil/p54/eeprom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/p54/eeprom.c b/drivers/net/wireless/intersil/p54/eeprom.c
index 0dc848d77c5e..0475222d54fc 100644
--- a/drivers/net/wireless/intersil/p54/eeprom.c
+++ b/drivers/net/wireless/intersil/p54/eeprom.c
@@ -812,7 +812,8 @@ int p54_parse_eeprom(struct ieee80211_hw *dev, void *eeprom, int len)
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
