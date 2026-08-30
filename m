Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959C2FD69E
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788115350; cv=none; b=f/6WOcnG/U4jTl3dINwEmqDyPQbPCBnp0rkf2kdGJBpIZEEny42i3w7TtJE7A4xSzXlqz38RePbBZk/d7RTpeUL107BWp2IhbwK/MuYOjuVIL+tSgQihP+vcTHJBhxihlYNtL94nhzWQJy++sjb/wu0VDY/9hQdb19NGRmvIZms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788115350; c=relaxed/simple;
	bh=SrF4lGDuqb18AiYQK+XAitOgl2PdPBmmpoICN3rX6cs=;
	h=To:Cc:Message-Id:Subject:Content-Type:From:Mime-Version:Date; b=mUWmyPc1q0RZIw56embJM9PeP2VvJkz0+1DDAfPfBbsfwujbBfai3e40cI4mfjX/zb0MCT+NlgMVPVq2y1rOBPw5ztoS4jrhKsQHJ7fL2dl/TxUMbmEChqT+dLVPM8buF6G9FP4p9Onpnh7t89ZMcmhsnxCE+35Bej+s9GuNV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=Mdb51yEm; arc=none smtp.client-ip=71.18.227.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="Mdb51yEm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788115336; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bB01TT1YdOFmumjs5xBfnT0rs/gQGK8/OqDRpsjfOIg=;
 b=Mdb51yEm8oqtUuCpxG0dp3bZ+Slgpzbj1n/xdumMF5hXj5kVtZO0ScYxEs+bJKAunMNZ6N
 0PGGJOIJOktrJb81/xMDud7HvozydfFTQBe0lmBW5OxdWukUHi3PU8mIRA5wzKCtpYgsVG
 l77W4DDbOm5ZOewrWPQ+Y3qyY8ZdEcaheox4mvThdb1zSWlLTjIvKavRPAltmUzf5kCWBc
 XS+FUQN1Txy4/a3/2z26i8/LoIaT2zuGK0JjjF2M+TR93s5Nezr644+YRZmRJ54jtT8rul
 nEzXZzt2sshxVfCWMcaYPJcl7ytEpx0simjhzcqYqHhKZjCZCgu3FH1DB7o4rg==
To: "Christian Lamparter" <chunkeey@googlemail.com>, 
	"Michael Wu" <flamingice@sourmilk.net>, 
	"David S. Miller" <davem@davemloft.net>, 
	"John W. Linville" <linville@tuxdriver.com>
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>, 
	"Christian Lamparter" <chunkeey@gmail.com>
Message-Id: <20260831-p54-pda-validation-v2-0-dae566b388c8@cherr.cc>
X-Mailer: b4 0.16.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-B4-Tracking: v=1; b=H4sIAIN5lGoC/22NwQrCMBBEf6Xs2ZV0bVP15H9ID2mytQvShqQEp eTfjQVvHt8w82aDyEE4wrXaIHCSKMtcgA4V2MnMD0ZxhYEUaXUmjb5t0DuDyTzFmbXUsRuIL/X YWG1OUIY+8CivXXrvC08S1yW8949Uf9OfrvunSzUqHJylQemuVa2+2YlDOFoLfc75A0enJ8+zA AAA
Subject: [PATCH v2 0/2] wifi: p54: validate PDA entry data lengths in eeprom parser
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a947986+1fe1fb+vger.kernel.org+me@cherr.cc>
Content-Transfer-Encoding: 7bit
From: "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 31 Aug 2026 02:42:11 +0800
Received: from [192.168.9.107] ([111.42.148.195]) by smtp.feishu.cn with ESMTPS; Mon, 31 Aug 2026 02:42:13 +0800
X-Change-Id: 20260826-p54-pda-validation-7b2e91f4c6a3

p54_parse_eeprom() walks PDA records supplied in the device EEPROM but
several handlers consume entry->data without first checking that the
entry actually carries enough bytes, so a malformed or truncated image
makes them read past the EEPROM buffer. This series adds the missing
length checks in two places: the PA calibration curve data and the
interface-list records. It continues the EEPROM trust-boundary
hardening of da1b9a55ff11 ("wifi: p54: prevent buffer-overflow in
p54_rx_eeprom_readback()") and ebd6d37fa94b ("wifi: p54: validate RX
frame length in p54_rx_eeprom_readback()").

Patch 1 rejects the PA calibration curve entry when the channel and
points-per-channel counts it advertises do not fit in the entry data,
the same check p54_convert_output_limits() and p54_convert_db() already
apply to their counts. Patch 2 advances the interface-list walk only
while a full struct exp_if record still fits, instead of reading one
from a trailing partial record.

---
Changes in v2:
- move the curve data length checks into p54_convert_rev0() and
  p54_convert_rev1() (Christian Lamparter)
- collect Acked-by from Christian for the interface-list patch
- Link to v1: https://lore.kernel.org/r/20260827-p54-pda-validation-v1-0-bdc2b0675056@cherr.cc

---
Shengzhuo Wei (2):
      wifi: p54: validate curve data length in the calibration curve converters
      wifi: p54: require a full exp_if record in PDR_INTERFACE_LIST

 drivers/net/wireless/intersil/p54/eeprom.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)
---
base-commit: 66fb95a521110da673090294561844c9f76ebe64
change-id: 20260826-p54-pda-validation-7b2e91f4c6a3

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
