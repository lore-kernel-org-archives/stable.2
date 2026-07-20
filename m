Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92D2E7366;
	Mon, 20 Jul 2026 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570246; cv=none; b=APx5yKw1G91grXAjxz/gCWvvZBxHqzUSsnvEoUHhweog/vNtvhKoK9rSoy/RchBore6CBxynrGg9E8sddnm0jC0K3bG1R6C4lTy48pFHfVMRot3hT0WuQqzRiHjVn+4WP6rjzdumgZRG0DbA4VbE2MzZ2I50NLrxBrlG5PMtaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570246; c=relaxed/simple;
	bh=iBipNNCa4SACukw0LpzX7vOYnNLBCyeY2IhWlxk51W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnsBw4N/RIfKlutCFS18iHRZMpuETSXNRVVN3/bTW9eAi4SotPfPhU0IERlCzER3AxNv/0msa8B+hJPbmiQoxQGaTV4B5UKRBK9D/X5lhZH6NSebFs8M6r8BMwXdil3/NTShlUrAuxCht5S5P7i6kxorB4N+m1WSHq4PoDTF0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=w27+if9T; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gkpXiI2W; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w27+if9T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gkpXiI2W"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h3pBR1l1zz8v2N;
	Mon, 20 Jul 2026 19:57:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784570239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9/NcPVq+5yU0f3GDkZTECnaZvyY6Bv5QbbArZrpQ04Q=;
	b=w27+if9T5lY9m2GZm/G3v4MBtdXiAmDiBBBn19U3wZjK4HuIjaQGmYcmnLsWxLQ1Fsdfn0
	SR5kICyKmnTokvvKPTmYnPEvlNKeyBhNoJJlnvQ0HNCH87aYuNaH28+p4C7XdTHIijzkrf
	Ociuv2QJbmw8mzUnDjbkUJYCO1DSaAorZqK/Doa5me/YLrWS1cBwaLTk84YMzWmH8ZDIKo
	D1mz+098zKdk0U3fYFqkcJlrMDpiMRXy56Ejw89tAlTmgGQY1arHsSJozndCUGO1Y0uWRF
	vglFxs8o8atn88umMb0hE7JON3edlGlQI+OHGWCrx15/Ceni+FvafehBEzujsw==
From: Benjamin Boortz <bennib@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784570237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9/NcPVq+5yU0f3GDkZTECnaZvyY6Bv5QbbArZrpQ04Q=;
	b=gkpXiI2Wr/VCu+7nyfWQ9KXH5bQ++klF1LFd1WLqT+Jfdn8xhqO4joO+HXkbFU82AJrjMW
	EXccccdoh3dMKHF/hP+Qg2FqlpMjnwImfZO7vK87V3Kw4df/FJrsyJhXXGi08oKIKJRyUQ
	NItb46i9oNCF0yWXUNT99wdlAHra4uq1In57EPN92VjDTsqpZkAfFxIAvQUHh045ykDUcu
	0OrraLrnNgsGengszhLTdcjnDLAVzvcvVjGApVHavCMHVa6dOvJW9K9h4QLd7dGx9JHt3K
	Tt902Gmge7RCPiGwQUA0O4f+tZrz6BDg6/uDp1VHAEorQUbhs/VLagSffIDUig==
To: linux-gpio@vger.kernel.org
Cc: linusw@kernel.org,
	mani@kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Boortz <bennib@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: bm1880: add missing select GENERIC_PINCONF
Date: Mon, 20 Jul 2026 19:51:04 +0200
Message-ID: <20260720175611.2294418-1-bennib@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 75f6d0ecbf86a25bcbc
X-MBO-RS-META: on16cpyzae17esas1k3dadu9rescftme

drivers/pinctrl/pinctrl-bm1880.c initialises its pinconf_ops with
.is_generic = true, but that field is only present when
CONFIG_GENERIC_PINCONF is enabled (guarded by #ifdef in pinconf.h).
The Kconfig entry for PINCTRL_BM1880 never selects GENERIC_PINCONF,
so any config that enables CONFIG_PINCTRL_BM1880=y without
CONFIG_GENERIC_PINCONF=y fails to compile:

  drivers/pinctrl/pinctrl-bm1880.c:1288:10: error: 'const struct pinconf_ops' has no member named 'is_generic'

Found by randconfig testing on arm64; tinyconfig reproducer below.
Add the missing select to fix the build.

Fixes: 49bd61ebce5f ("pinctrl: Add pinconf support for BM1880 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Boortz <bennib@mailbox.org>

---
Reproducer (tinyconfig, arm64, without patch):

  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- tinyconfig
  scripts/config --enable CONFIG_PINCTRL
  scripts/config --enable CONFIG_PINCTRL_BM1880
  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- olddefconfig
  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
      drivers/pinctrl/pinctrl-bm1880.o
---
 drivers/pinctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 23ea76dc6261..eda54aa5fde6 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -166,6 +166,7 @@ config PINCTRL_BM1880
 	depends on OF && (ARCH_BITMAIN || COMPILE_TEST)
 	default ARCH_BITMAIN
 	select PINMUX
+	select GENERIC_PINCONF
 	help
 	  Pinctrl driver for Bitmain BM1880 SoC.
 
-- 
2.55.0

