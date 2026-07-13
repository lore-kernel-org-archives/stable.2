Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE539DBFA;
	Mon, 13 Jul 2026 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930835; cv=none; b=ASohXP/Xq/5bK+FBFH8fyGQr6OE1HFVxTb4cyjVIMk7JXc3XnwgBp27oRS9Fl6RWiASjxaOIV4IK7BdH9I//t0UE4nakecRQKZPWgunTj+fCYtnWwKnwOTvRspGw6876AY7BBmN0Kz+Qvxd5e3dKrxzUdDRaZGdduFJupoZLlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930835; c=relaxed/simple;
	bh=Kw+8n9BEqJupOzqbbFyJQjnGf+shbG4s6iul5dzN1dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNPWJ2dmDvlMZ+IAkkpUJfqL8et2eD/GtrSU3XucRaLyaxNC5jNK1fDGYPg/tCdFVTnkNL2b8GeLfLJr/vVjLZarIRcwPkebP1RHCmDZ2dY2zfXEsoV5TL6V25jpuA368aJXo5drDnjFCn0YeoE9zdjZLOQmIGERJ54hZgBWvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lsy4KSlJ; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lsy4KSlJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783930821;
	bh=Y8K42LrhKNlp4t3cHpL5HCc7k7AMisqb3VGvbxXhQRY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lsy4KSlJOu1nEz/XQtploqkwZmemGFJxrM7AnJ/YoeyW058QyQtaOWmu9UVd8SBGS
	 hnab8rFlmx+UB2XawJzVYQfS7St7EK7L1KJoKWGr0CEVlm5q7Vb1WdC447OXlJpeIL
	 QFXPD2eUKHLC/OY/56SB576O7uNfRSAus2XHwVSg=
X-QQ-mid: zesmtpsz3t1783930816t35d0d81d
X-QQ-Originating-IP: tWKVSNlqtRFyHRxPfoGDbld5T8a4BMUef/PZCxQYXZ8=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 16:20:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8555531889193894704
EX-QQ-RecipientCnt: 4
From: raoxu <raoxu@uniontech.com>
To: phil@philpotter.co.uk
Cc: linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
Date: Mon, 13 Jul 2026 16:20:13 +0800
Message-ID: <461EA3D17ECF5C5C+20260713082013.3423808-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MAXRuxnbzssePFkFwOQzXtjmFwzFupZkC+S+pPp6oPAtf7edTnBPlGVz
	BOh5Tn9eTo4JrpgkjdoCgnRXUGwKQ+/TDv49u+Nfax77USc1uuoWRzY4exszPgj5QxL3Hc5
	SytoAmabTjaAQoR106Z0nFrCN9APzOtf+LLxkz5DVHZDfjFKsS22QaQUXBrG88ANOYJydKk
	VdOEqN0fezPEo1Yp93/muYB730A3UAYRK9dOPO5kcW4LRq5lw9cmrwxbyDRHlC22WM8J082
	1qvM+CHgBDy8DrtPGx02XWH0N7WhKdxTMxXBlRZAHALTYShLlKTkAwkwuj4zAGWSyHpLxX0
	1tXWuENyPDOpmH1uTWICs+Y/SoSBeCwfebte37Eq74Y1SV50IlLhtTR0QELry2+y7RleCeZ
	nKuA1Z3Tx3chIJN9J1ocWAjWTza+YHO3BBXX8HatV2xWGQ97bKS5mzpPmJRhWzEwOLThg+R
	RqxsLNqoTmuwE3V7EN0tsYDDqtmLJryEuL1CFD9DenwrjHCYY/TYEFRuZKCaO57+p9bbsRC
	cYBnM7RNEmClbq6W+TCELrtgALC1J0ZGZymhZmMjHJpXV0WA/waxuxJ/3hW6pl05kuPJkHS
	rJRMn7h1Zsk7KKJRUbLttZtzeGixPTYPfkmWlLuAfeuhPcvusfhWVRI8pfii9HEXk86kDwJ
	uEr7P1tAXaKtBSE5zJsPZzOF5TJnFFwXF4TXCa3eR7j4HGDdL6Z27nF8JDnk6N6Gyhh0Km9
	5FWCSOmHFdh5sYHoKw3gEmktjNI2AwCCwWw3IiGViv3mMe7nwN62eG55lKMuZIc2QWqV+81
	49Cv6Ua+zLc4bI6u4qJxlCwdn0wR6NTqlNUAbWV8a0295agRWBmTxZdg5dAyy0tf4B00fsM
	Suln2TNixAmJskliiQFXSZ3YRjsHjrDtMwKM1x9HW7bWqXfqN9idc+c6uxxsyWU5kqXVWEF
	1qGJK3+F579kXgEVi4rn+JCzXVHai3cod/LovDdACn1Jp6FYtxGEsdPCIQCqoxQ2Qamcws/
	nKL3rh2i7JrtPXEEARSWbCS79Q42vC6VQ5m9Wze1kQ/bAAZMJ5rv3JiUnqhos=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

mmc_ioctl_cdrom_volume() first reads the audio control mode page into a
32-byte stack buffer with cgc->buflen set to 24.  If the device reports a
block descriptor, the function increases cgc->buflen to include that
descriptor and reads the page again.

For CDROMVOLCTRL, the function then builds a MODE SELECT parameter list
by moving cgc->buffer forward by offset - 8 bytes.  This drops the block
descriptor from the outgoing payload and leaves a new 8-byte mode
parameter header in front of the audio control page.  However, cgc->buflen
is left unchanged.

With a standard 8-byte block descriptor, cgc->buffer points at buffer + 8
but cgc->buflen remains 32.  cdrom_mode_select() therefore asks the low
level packet path to write 32 bytes from that adjusted pointer, reading 8
bytes past the end of the 32-byte stack buffer.

This is not hit by CDROMVOLREAD, and CDROMVOLCTRL only triggers it on
drives that return a non-zero block descriptor length, which helps explain
why it has gone unnoticed.  The overread is also sent to the device as
extra MODE SELECT payload, so it may not produce an obvious local failure.

Reduce cgc->buflen by the same amount as the buffer pointer adjustment so
the MODE SELECT transfer covers only the intended parameter list.

Fixes: 3147c531b6b5 ("cdrom: split mmc_ioctl to lower stack usage")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/cdrom/cdrom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 62934cf4b10d..4f1fd389260f 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3187,6 +3187,7 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 
 	/* set volume */
 	cgc->buffer = buffer + offset - 8;
+	cgc->buflen -= offset - 8;
 	memset(cgc->buffer, 0, 8);
 	return cdrom_mode_select(cdi, cgc);
 }
-- 
2.50.1

