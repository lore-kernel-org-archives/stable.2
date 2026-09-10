Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48446EF92
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038552; cv=none; b=BakzYN4RYKa8TLxXKpCR5FlYo9HQJ4q6aKR+FLanuRx0tU6CgsCmrDsIXf43tkAVhc9CD10WefiM3ekX3EYRv6IGer7OCcfHanuA4xzlqa4xLvv90c6TeEOLT6C39yAij/ci6UEJnlaE9hsLpp/gBAEeX1ros+Lv+BKVNoLyCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038552; c=relaxed/simple;
	bh=4TAVJz/ZZiTF/QiT1wMD+IYuJag9OSzcpDScKE0VYds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmxq4zaw3UapdDXzIybIXQWi7kWGNqOAWk/B6FWMQLvvQ+x6wJPoCAaQGAUYBf++tJBeD6Kow4aDpkUpHePe+3yq+61rgRu8Tas93xhkr3FuukYZOJUSx1LlED8FMm05Gq5yL9NEE19RHgn31GHwxlGSW7jh90wbS3Sy9L79wUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl6ZEtxX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl6ZEtxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6DC1F0089A;
	Thu, 10 Sep 2026 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038550;
	bh=nT3qwIxjEOhCeOliNSb6oUAYDDK+nC/aw2/usqhbdAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gl6ZEtxXed5mpW6bN761SwPx9SSxz5U/kx30LVE16U9yC68f4L6Mx2vlo/bWwFtn7
	 5dNqQS9chqOyDpG1FZoZxd/HWGt2yQs8BQjBgiRm1yjs0r5ixckslQGGXDQjpIHwAy
	 8RVFR1pJfaggno3Tl4F1w/uRhtYfy6p0oNK+0VOPIJWPCxnLO3alS/KaEp6lGxYDPG
	 A80I+yb6Onf2/TvqDh4x+W8Uiaeo01/h7QvHp8etGZ0iTjxU7ADQCE1loNuwVcQXov
	 AI1L6xrKLt+PWFw/XZwjSyPkS1IfNgSrgSYxL7hwFnT+qzBJE5ub8sa8qeAC9WFpk9
	 UDwhv3QSB7fCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()
Date: Thu, 10 Sep 2026 07:09:06 -0400
Message-ID: <20260910110906.4147966-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910110906.4147966-1-sashal@kernel.org>
References: <2026090853-convent-spill-68e6@gregkh>
 <20260910110906.4147966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Bilal <meatuni001@gmail.com>

[ Upstream commit 99aa998dec83ba180822f70e6d48a514fc81c20d ]

rtw_get_wps_attr() walks WPS attributes inside a WPS IE taken from
a wireless management frame. For each candidate attribute it only
checks that the fixed 4-byte attribute header (2-byte ID + 2-byte
length) fits inside the IE:

	if (attr_ptr + 4 > wps_ie + wps_ielen)
		break;
	u16 attr_id = get_unaligned_be16(attr_ptr);
	u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
	u16 attr_len = attr_data_len + 4;

attr_data_len (and therefore attr_len) is read directly from the
wire and is never checked against the remaining bytes in the IE
before being used as the size of:

	memcpy(buf_attr, attr_ptr, attr_len);

Since attr_len is fully attacker controlled (0 to 65535+4), this is
both a heap OOB read of wps_ie, and, more seriously, a stack buffer
overflow at several call sites where buf_attr is a single-byte
stack variable, e.g. rtw_get_wps_attr_content()'s callers passing
WPS_ATTR_SELECTED_REGISTRAR into a stack "u8 sr"/"u8
selected_registrar" (drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c,
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c). A crafted WPS IE in a
beacon or probe response processed during scanning can therefore
smash the stack of the parsing thread.

rtw_get_wps_attr_content() itself has no independent length check
and simply trusts the attr_len it gets back from rtw_get_wps_attr(),
so fixing the bound here also fixes that caller.

The "attr_ptr + 4 > wps_ie + wps_ielen" header check above was added
by commit 1463ca3ec6601 ("staging: rtl8723bs: fix OOB reads in
rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()"), which
bounded the fixed header but never extended the check to cover the
variable-length attribute data that follows it. Add that missing
check before attr_len is used as a memcpy() length or accepted as a
match.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260728125456.32359-2-meatuni001@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 82bd36f3c1cfe..196349bab11ea 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -798,6 +798,10 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 		u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
 		u16 attr_len = attr_data_len + 4;
 
+		/* Reject attributes whose claimed length runs past the IE */
+		if (attr_ptr + attr_len > wps_ie + wps_ielen)
+			break;
+
 		if (attr_id == target_attr_id) {
 			target_attr_ptr = attr_ptr;
 
-- 
2.53.0

