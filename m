Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB93EFFAE
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478803; cv=none; b=krOaoaYcHZksDgYWJZFvt7JbgZqY2NuUmZTR7UOsINFuFmtRCtY/7ktLKn2bAzyhrMaETw0nZEHevkfkB/sUaZCN6a7N/X4tC/8zm0WQ4xDYjoTZdLA9JLyT06q5xKoAelaYDJ/D87gb/92kCUkKTQ89N8kRkolfQCl6AS2svUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478803; c=relaxed/simple;
	bh=ZI5hlcZuATeNvade6rLrhYipntrypvLyDovguUE985I=;
	h=Message-Id:From:Mime-Version:Cc:Subject:Date:Content-Type:To; b=PXPohxRDn8v/4uhoYrEt42AkbFVm0KFaVTkdJKpPMN3KWFeyseXNS15yTJTl8Bwo+FuxP/Se3tNPfvMhGzNc3Y1uKzxtYQlBGk8UWesm9k3owFRRnZZGxsTr0mvEO5ZXx1E15Iid7Z2OwyAFUEGqaeSh0CSBfMvsTb9/L+Hq66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=olHFBq+U; arc=none smtp.client-ip=209.127.231.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="olHFBq+U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782478794; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bjAzTl7d+Kl4TVionb8E/T68k19GosyQDohWsclNhM0=;
 b=olHFBq+U7L0i8Q72NXXM/afF1eDWA5TGUApsQAOTRDRb2PVSsl3k5OAFqIeaiWkc+CNTkW
 44JSDrLgn+uO1+3XMSsR2kTJ5RpUrvisyLHKLBGFM5k2CprrUDhi+AvraYgFyL8iPlwcfD
 bs172XOOgwQh3GHerBzAx4/4+jouLWF6O9t5HvHc+WcWGx8712L71Ijx8L3EnytirKH2nL
 PIprGuUol3iwa4DmXm8nUIsUHdgkWkVxtbl40jZxoyR530pFRCOed7f16mqfe2s6VPsch4
 7hOvYWxQnCzOaj/tCYzHdkMyPhSdWecwvaB0xxhSnbCSYkzy4wX/cSGyaDE3xA==
X-Lms-Return-Path: <lba+26a3e77c8+b0991c+vger.kernel.org+wangyijia.yeah@bytedance.com>
Message-Id: <20260626-b4-arm64-515-preview-clean-v1-1-ad19e286e322@bytedance.com>
X-B4-Tracking: v=1; b=H4sIALx3PmoC/x2MQQ6DIBAAv2L23DWAQGq/YnpAWNtNKhpIrMb4d 9HjZDKzQ6bElOFV7ZBo4cxTLCAfFfivix9CDoVBCWWFVRZ7jS6NVqORBucroT/6H7mIrRZP34Q +NEpAGRQ78HrPOzC1NPUG7+M4AcOZvIZ0AAAA
X-Mailer: b4 0.13.0
Content-Transfer-Encoding: 7bit
From: "Yijia Wang" <wangyijia.yeah@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yijia Wang <wangyijia.yeah@bytedance.com>
Cc: <shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <will@kernel.org>, 
	<catalin.marinas@arm.com>, <broonie@kernel.org>, 
	<linux-arm-kernel@lists.infradead.org>, 
	<linux-kselftest@vger.kernel.org>, <cristian.marussi@arm.com>, 
	"Yijia Wang" <wangyijia.yeah@bytedance.com>
Subject: [PATCH 5.15.y] selftests: arm64: signal: skip SVE VL change test with single VL
Date: Fri, 26 Jun 2026 20:59:41 +0800
Content-Type: text/plain; charset=UTF-8
To: <sashal@kernel.org>, <stable@vger.kernel.org>, 
	<gregkh@linuxfoundation.org>

[ Upstream commit 78c09c0f4df89fabdcfb3e5e53d3196cf67f64ef ]

The fake_sigreturn_sve_change_vl test needs at least two SVE vector
lengths so it can attempt to modify the VL in a signal frame.  On systems
that support SVE but expose only one VL, the test initialization returns
false and the signal test harness reports the case as a failure.

Mark the testcase result as KSFT_SKIP before returning false when fewer
than two VLs are available.  This preserves the old bool init callback
contract while reporting the unsupported configuration correctly.

This is a minimal backport of the behavior used by newer selftests, where
the same single-VL configuration is reported as SKIP instead of FAIL.  The
5.15.y selftest still uses a bool init callback here, so keep returning
false after setting td->result to KSFT_SKIP.

Signed-off-by: Yijia Wang <wangyijia.yeah@bytedance.com>
---
 .../selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
index bb50b5adb..915821375 100644
--- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c
@@ -6,6 +6,7 @@
  * supported and is expected to segfault.
  */
 
+#include <kselftest.h>
 #include <signal.h>
 #include <ucontext.h>
 #include <sys/prctl.h>
@@ -40,6 +41,7 @@ static bool sve_get_vls(struct tdescr *td)
 	/* We need at least two VLs */
 	if (nvls < 2) {
 		fprintf(stderr, "Only %d VL supported\n", nvls);
+		td->result = KSFT_SKIP;
 		return false;
 	}
 

---
base-commit: eceeec79dbc646d6dace49ed1ba2f656683d5537
change-id: 20260626-b4-arm64-515-preview-clean-9408c3dbd320

Best regards,
-- 
Yijia Wang <wangyijia.yeah@bytedance.com>
