Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB193AA9F8;
	Mon, 31 Aug 2026 03:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146881; cv=none; b=cHHc3qW6Jh9aFN0awV9kT0eKNzlWXDyBgMo/iJesZjVgHtLi5wGL9ASIma7brPeEXzoX++/d95i9jI9yt0gqrtUiOHnnaU7XNqadtzRClNtWUXZ0Qvr+DAFVhRVENbInU9ynWhw/4+oG5o3q8It9TQlPwYyY2mw1chxNRHakECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146881; c=relaxed/simple;
	bh=KNTgq+/0Kuouzn61el1yz5cV3CZE6r84n255mD/gSww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RhRZjB5yOsEL8MHbK85j7rv7qVMg2GiyF4/xXVECTl9+tDgaR0IVZkI9+6F8qQYtYQ72d//Gw3Ng0vxLxtRHQED85Mg1wqK3RWxId6ntvrbmu0LU9KhjGdgJuLU0lkQX6bl7pzG5xz88W8iT3YzGSy4BhAoHa6bDqVlMzDpOmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=cvRjX/dL; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="cvRjX/dL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788146814;
	bh=FvM3PUyvegHAq8oz4A0YkG+fZ8ENWHND2m9+xtLaGUA=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=cvRjX/dLXH95CsdVjKYhTGQCgsUrAIIBNxsSmshdVrIlWprIevufCdDMvUuJP7fbO
	 KvbbgF70giZv9R3eHaCDeNfwpHfC6uok5GuBYJPYpwNwOFgfdjoP9bSQGhlOPS3z5F
	 0jIptt4LjVR5svLerDEEHbBnDy19qm1KGK6yDXzg=
X-QQ-mid: esmtpgz14t1788146807t62575c63
X-QQ-Originating-IP: mdvl2m5PSw8hny9/qhqo0Ig0a0QY6rf0hYVmTKpGJmk=
Received: from = ( [183.48.245.118])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 31 Aug 2026 11:26:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13306223604564133587
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 31 Aug 2026 11:26:41 +0800
Subject: [PATCH v3] clk: spacemit: k3: add 1.8 GHz PLL5 and PLL8 rates
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-k3-pll5-pll8-1800mhz-v3-1-530ed0978615@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4V07ZBpeRVX/odxMdQiVV6hQFDCv
 0sxJi5wM8lJ7pwzM6s7oy07ejPr9GisaeoVgoPHVEH1TYO5rswEihglCngE0JZl5I4ELhGr4gV
 KcplEhJSGIVtf207nZtq058uH7ZDdteqdyy0KY/ume27dkbvdNxHuJ0YOCBRQEsk4VjoQp9LUw
 +TblpSuTO+rpmKuNYofG8c/NgEciLI8jzhSkia7tmVZ3v3dTJohAQAA
X-Change-ID: 20260802-k3-pll5-pll8-1800mhz-c81875a0a944
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Yixun Lan <dlan@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-clk@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740;
 i=troy.mitchell@linux.spacemit.com; h=from:subject:message-id;
 bh=KNTgq+/0Kuouzn61el1yz5cV3CZE6r84n255mD/gSww=;
 b=owGbwMvMwCU2g/N9w09jE33G02pJDFlTvhQmXYxRXMqwYsvXBYvY3qyKn6B04e7Dj5IBdx71b
 zBONis82FHKwiDGxSArpsjS/YBnW4FPlG2BQKEvzBxWJpAhDFycAjARHVaGvyJHC26u5poVyfFx
 wxnHg38Lb9ar7dx+/HPTWvO7UY2ymyYyMkz6NeHtm1aptmh2rQmePIvar5fLLXq2ckU8k/EzNi1
 /Ry4A
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=openpgp;
 fpr=3FE5535CF1B0E658E57DB59BAE1C2FBEA7DB42E1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N+U/QWJ6RP+kQ836Kwwm3AcWBTOGOGO97xDCcr9fzZ9n080CwsqN/XxU
	h6SMekBpdheDbOXL1G0UE4wD11kKyIDE1dYWTjbbehMLM8i+nw0qh2vGyVUiNJc4Q06POuT
	ueUykx24wjjVZ1jFwZKdpeQdlXbaO8SHJHn6LhjMES0wFvE6MCIQhcw2x3cLUkR4ipZ0o2w
	OT+nnaTl2MkhmUVbFLwgVODQXdyPq36T1xEanovRk64fqBKnV2nTUg9xGCQXLXiikEz2ypE
	DvbdrFKJ0vdIMzIodq+hFoMVB4LYz6EuadmDOqUd0LeF4FBIpSSI+c0o72+lg9iOH9Pr8d+
	naQ/YFlB/L0YNYpSGrnyppp5jkp+7ilOjicA+NwhCKbrIeRMRrctXn+eQzKFLCxWV3lM0s6
	nxprzwxDRm7veAYuSwoic6j15WNSMEO/3dLufjHXIcNndSwMmnp7qTSU/O+2Ok1DuNcdDyg
	XgHIlP676FpYvvOTwPyCnW44KLcMPlr+tSVoazK6XLP/dqBWtXb6O3xuV1uNS7J+gPmddyj
	dL2Cmen7/EytKqiMeeg2hYgZbkE6N8KxlDEiYEwtkDEEAePi6n2DnA6MwqypywTQ73KShT/
	rWxB/t2XVqebIGdC55hihYblsQ6+ZFHD0SzZOWfCKIeYhRNfL30n3ZPq4o9PxV8J2MUx4Bw
	LCVCmQqgTLrwsDgfm0pkXB7bXeyIhws1eQ5+195kvYz002dTvSeTzt9kwVhwG6lMPTmzRqx
	+oOgYTfXa9wO6FJWdTJqc92HZEDoFS26owdlCf/UQKcm5zT8sWY2NwQgZxg21oYuvQeCRzd
	NsPmvDwc1RCy9rFUm2A0EGcsWK0B5hnHpuvOVpypPZIDXHSGvmBYZoGkIYzaiJYgtqXvPtA
	PX4ALQpxLV8Bg/+v+ioOMKWhvAOd2ctgH1ET9AQ23907h7W7ZOYWwvX4oLKFk4iUKeecVtv
	2SJJLDspXV1xgMAow2sOwKy03U2HFxD+XezDZexnmZAaGKe8PRM+RcZghWbsbyHIoei8s49
	HBmkw1DEeFw+gVnxYc/kgwaFYcnpLXZo63+tin4ZuT+D4CpXXoRhsEtQQjXA6YMByQTv/py
	D1ytnYIWSNdKxQM/W5m097LL+aiSyzkLw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

K3 boot firmware configures the C2 and C3 CPU clock domains at
1.8 GHz. PLL5 feeds C2 and PLL8 feeds C3, but their rate tables
currently contain only the 2 GHz overclocking operating point.

Add the nominal 1.8 GHz configuration as the first entry in both
tables. This lets determine_rate() and set_rate() select the firmware
operating point while retaining 2 GHz as a supported overclocking rate.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
The related U-Boot change is available at:
https://github.com/spacemit-com/uboot-2022.10/commit/fb95cf3d848b771c61b5a1b3e5cbbee223faf352
---
Changes in v3:
- Mark the change for stable kernels starting with v7.0.
- Add Aurelien Jarno's Reviewed-by and Tested-by trailers.
- Rebase onto v7.3-rc1.
- Link to v2: https://patch.msgid.link/20260810-k3-pll5-pll8-1800mhz-v2-1-aabff510a797@linux.spacemit.com

Changes in v2:
- Drop "clk: spacemit: re-enable PLLs after init"; the PLL init issue
  will be handled in a separate series.
- Send the K3 PLL5 and PLL8 1.8 GHz rate-table update as a standalone
  patch.
- Clarify that 1.8 GHz is nominal and 2 GHz is an overclocking rate.
- Link to v1: https://patch.msgid.link/20260804-k3-pll5-pll8-1800mhz-v1-0-a3a75866ce32@linux.spacemit.com

To: Stephen Boyd <sboyd@kernel.org>
To: Brian Masney <bmasney+clk@redhat.com>
To: Jerome Brunet <jbrunet+clk@baylibre.com>
To: Yixun Lan <dlan@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: spacemit@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
---
 drivers/clk/spacemit/ccu-k3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/spacemit/ccu-k3.c b/drivers/clk/spacemit/ccu-k3.c
index 92b930d5ff30..1796236d8dc5 100644
--- a/drivers/clk/spacemit/ccu-k3.c
+++ b/drivers/clk/spacemit/ccu-k3.c
@@ -38,6 +38,7 @@ static const struct ccu_pll_rate_tbl pll4_rate_tbl[] = {
 };
 
 static const struct ccu_pll_rate_tbl pll5_rate_tbl[] = {
+	CCU_PLLA_RATE(1800000000UL, 0x0b4b0000, 0x00000000, 0xa0458585),
 	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
 };
 
@@ -50,6 +51,7 @@ static const struct ccu_pll_rate_tbl pll7_rate_tbl[] = {
 };
 
 static const struct ccu_pll_rate_tbl pll8_rate_tbl[] = {
+	CCU_PLLA_RATE(1800000000UL, 0x0b4b0000, 0x00000000, 0xa0458585),
 	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
 };
 

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260802-k3-pll5-pll8-1800mhz-c81875a0a944

Best regards,
--  
Troy Mitchell <troy.mitchell@linux.spacemit.com>

