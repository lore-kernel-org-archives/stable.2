Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D94547072;
	Tue,  6 Oct 2026 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272303; cv=none; b=ILxXl9Ulce7gHoHmjoVQSHzlpjR1uOhHshIGFqBR1yBb0Yu0l8ckObHZpxoiqk2/xBq71QpMUC5d1LNLbpmi4p7QBGu82QhcKo6EMCoSpal7QP5J4ySjg7GtbiJDm9GFi3dl2sv0qhHLQKzyzXyexMh6ZCoQ2YiaSYXbM2dkFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272303; c=relaxed/simple;
	bh=Ix6rHZxeicX3kdIK9yyM338VddWxcFfM9aS479bXyGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RtkwmODUjFp+Cfo4tfMavQplnHLNWW8GAtWxZeuJ/f0qLLWNohWVoVCpLJq5/CXd5qvnsI+iD8Cl5G5+Q/nOgf8onBLyOMv7PNg9J5B9gvrkjg3GRyLfBq+ZAkfkrUmPTghtY9XR7GF7ilYCuVdl+zIOiA89awT4Z6jfl9Z6oHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVi6Vg8i; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVi6Vg8i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791272302; x=1822808302;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Ix6rHZxeicX3kdIK9yyM338VddWxcFfM9aS479bXyGI=;
  b=cVi6Vg8ijNl0w9F6vr4kue+xndVOyME9yR6GY4NlFFeOP6dRZCPWdEhF
   xZdMZJKy1piOTR1r0KrcRodXqCNt2b+dgUIeI/1GhfqNZUTlzj6wxiQQ1
   1/IikAUhcpvUcJYs/TSTOLRy5qLH9hV4Lg/3HQj/bNqO18t42dTMzsVGP
   ytlmSuvv4aJhGxAMofTrdZG+VCMa/EDPQAFPYH43ytnRtiY8HdRbfTx17
   XN/0tXXUB04Qj5RZzPj37wDJK9QvZgwlyjvxFUAs8JIet0UsEuuBF3pwu
   FGjm4OF+owxod8/edCV9brIOk8M695b1flNGy68SyzCMJSRWgpu+PPaKx
   A==;
X-CSE-ConnectionGUID: 01CnLQpoQ5ayL1f/zd/v/w==
X-CSE-MsgGUID: 2TUKrXgATsOVozd/BRhJog==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="3644"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="3644"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 00:38:19 -0700
X-CSE-ConnectionGUID: hPYCujVPQTO9teTPKhnUGg==
X-CSE-MsgGUID: rut/W9aoSrqLzDdFEUkYRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="284984663"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 00:38:17 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Tue, 06 Oct 2026 10:38:00 +0300
Subject: [PATCH char-misc] mei: vsc: Fix packet CRC computed over pointer
 size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-vcs_fix_crc-v1-1-b7b149f13c1d@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5W+giPfgVEdE0ag5WSUAE8e9Wj
 8Mwc4OSMCm01Q1CJyvvuYCrK8B1zAsZToXBWx+dtdGcqMPM14CCJvkJbRhj42KAUhxCRf237sv
 FbKwI/fO82615bGgAAAA=
X-Change-ID: 20261006-vcs_fix_crc-d2bc03a64163
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Wentong Wu <wentong.wu@intel.com>
Cc: linux-kernel@vger.kernel.org, Wentao Guan <guanwentao@uniontech.com>, 
 stable@vger.kernel.org, Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791272296; l=1461;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=+Gs4giFYHlUO8cBiRJAuKHgnryCDBc4Pgp0lkoPukTU=;
 b=aYBhbI4Gql9Wvl7egSVVyouVVzKirgw7xsCeOj3MdqtVNtO6QiHdarWKXSrRHQhpYKASy8/pD
 jkmKSeVJmMpDSM2HsF/ti71WqGdM0YDOvcVsfPIAd3zIDJrlVkbTHsj
X-Developer-Key: i=alexander.usyskin@intel.com; a=ed25519;
 pk=X+qoF/nFCdDOV04IForWSxnkyoCAbUE10egZi6PSfcU=

From: Wentao Guan <guanwentao@uniontech.com>

vsc_tp_xfer() computes the packet CRC over sizeof(pkt) + olen bytes,
but pkt is a pointer, so sizeof(pkt) evaluates to the pointer size
instead of the size of struct vsc_tp_packet_hdr. The value correctly
match the 8-byte header on 64-bit builds.

Use sizeof(pkt->hdr), consistent with the header size used everywhere
else in the driver, e.g. in VSC_TP_PACKET_SIZE().

Cc: stable@vger.kernel.org
Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 432bc59f11f9..ce877cb95757 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -293,7 +293,7 @@ int vsc_tp_xfer(struct vsc_tp *tp, u8 cmd, const void *obuf, size_t olen,
 	pkt->hdr.seq = cpu_to_le32(++tp->seq);
 	memcpy(pkt->buf, obuf, olen);
 
-	crc = ~crc32(~0, (u8 *)pkt, sizeof(pkt) + olen);
+	crc = ~crc32(~0, (u8 *)pkt, sizeof(pkt->hdr) + olen);
 	memcpy(pkt->buf + olen, &crc, sizeof(crc));
 
 	ret = vsc_tp_wakeup_request(tp);

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261006-vcs_fix_crc-d2bc03a64163

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

