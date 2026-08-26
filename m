Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C793A9620
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764099; cv=none; b=kqySUJqQ4bAbQq/tznwFiZb0DbgyqiS6fL7ho/ivetidH5wtmeZSB/FB7Dph5lo5hhlt+LzWzUVMqsvbLwrZisijYCJ0J0iHAHbpEmVGnN40p8D4kd6iJoF33Pd+G933W64Ro4twAIxOD7fJKo10z7fknLcRBo2KCM+SiZrB34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764099; c=relaxed/simple;
	bh=4xBhgvMDLs/XLN2pd56fd3I5TV/RbHd5HZxG+sUGfYE=;
	h=In-Reply-To:Date:Content-Type:References:Cc:Message-Id:To:Subject:
	 Mime-Version:From; b=ZbPl75mjr6w5vCpUfaoQhXb1dGMs1w0ITQgJcUjOya/rnsTvc3wH7BFqvFPIEkMso57iDUKm6u8iuwILhgTQoQtazWOHBI+uvuITKYpF0tyYXdneob3cUZlAitjsazi0APbsNRh6CWuoBdffL7mOmUXqLdnq5halIIdWpN1aK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=lr8a2Wyd; arc=none smtp.client-ip=71.18.227.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="lr8a2Wyd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787764067; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PJ594cLpPW6v3aDbK0/v/dsM4wWK1cUjGz46u5+Upc8=;
 b=lr8a2WydUUTX98ut1cOxoPJt1e3sxlbvLI3l9DmCiBzlw0KJPSq9c5axlmNijbfTm34PHz
 5loafIostJobZknPqe4IRoIp0SBuTI8KZyWtPG+TrqtPc4Y+Nav6x5+bKz6a3ekQPbWz8i
 dHfHWBsxf51a86oYVV/ryoGlGCe8SsyOdw4wno+A2QKuemCbdqWoLXh4tcyZSgcGee6mAN
 7pB2jD3sdCNt0kFA3nHor15GFw6EU8YA6U7uxBWCkD5xV+rnB8rvGfXl2PhTyz0m364CJl
 BxOEwwln4A3+VIMg2qUtH10cKhVMgJfmUd7+Sfid/BSIIgLJ/hArm0FYKuiUpA==
X-Mailer: b4 0.14.2
In-Reply-To: <20260827-p54-pda-validation-v1-0-bdc2b0675056@cherr.cc>
X-Lms-Return-Path: <lba+26a8f1d61+c2da0f+vger.kernel.org+me@cherr.cc>
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Aug 2026 01:07:39 +0800
Content-Type: text/plain; charset=UTF-8
References: <20260827-p54-pda-validation-v1-0-bdc2b0675056@cherr.cc>
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260827-p54-pda-validation-v1-1-bdc2b0675056@cherr.cc>
Received: from [192.168.9.107] ([111.42.148.29]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 01:07:45 +0800
To: "Christian Lamparter" <chunkeey@googlemail.com>, 
	"Michael Wu" <flamingice@sourmilk.net>, 
	"John W. Linville" <linville@tuxdriver.com>, 
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 1/2] wifi: p54: validate curve data length in p54_parse_eeprom()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>

p54_convert_rev0() and p54_convert_rev1() walk
channels * (2 + points_per_channel * sizeof(sample)) bytes of the
curve data entry, with both counts taken verbatim from the
device-supplied EEPROM. An entry that declares channels=255,
points_per_channel=255 but carries only the 4-byte header drives a
~191 KB slab-out-of-bounds read past the EEPROM buffer (verified with
a KASAN reproducer of the conversion loop). The sibling converters
p54_convert_output_limits() and p54_convert_db() already validate
their counts against the entry length; this path was missed.

Reject the entry when the counts do not fit in the entry data.

Fixes: eff1a59c48e3 ("[P54]: add mac80211-based driver for prism54 softmac hardware")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.3
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/net/wireless/intersil/p54/eeprom.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/intersil/p54/eeprom.c b/drivers/net/wireless/intersil/p54/eeprom.c
index 95580921d933827c5eac55b79404e26bd7a57ba4..968ce9a411358e0e6b83117b1a077becc3207090 100644
--- a/drivers/net/wireless/intersil/p54/eeprom.c
+++ b/drivers/net/wireless/intersil/p54/eeprom.c
@@ -763,6 +763,8 @@ int p54_parse_eeprom(struct ieee80211_hw *dev, void *eeprom, int len)
 		case PDR_PRISM_PA_CAL_CURVE_DATA: {
 			struct pda_pa_curve_data *curve_data =
 				(struct pda_pa_curve_data *)entry->data;
+			size_t needed;
+
 			if (data_len < sizeof(*curve_data)) {
 				err = -EINVAL;
 				goto err;
@@ -770,9 +772,23 @@ int p54_parse_eeprom(struct ieee80211_hw *dev, void *eeprom, int len)
 
 			switch (curve_data->cal_method_rev) {
 			case 0:
+				needed = curve_data->channels *
+					(sizeof(struct pda_pa_curve_data_sample_rev0) *
+					 curve_data->points_per_channel + 2);
+				if (data_len - sizeof(*curve_data) < needed) {
+					err = -EINVAL;
+					goto err;
+				}
 				err = p54_convert_rev0(dev, curve_data);
 				break;
 			case 1:
+				needed = curve_data->channels *
+					(sizeof(struct pda_pa_curve_data_sample_rev1) *
+					 curve_data->points_per_channel + 3);
+				if (data_len - sizeof(*curve_data) < needed) {
+					err = -EINVAL;
+					goto err;
+				}
 				err = p54_convert_rev1(dev, curve_data);
 				break;
 			default:

-- 
2.47.3
