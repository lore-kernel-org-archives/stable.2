Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794694113;
	b=YzSETVfsHVm4VwNJkQtVki7f/OKYcsrEc+Ii+tupaTu8h+6p+tSNSLcoPfo8XHSlTIz0
	 4ogcPbC+UcPkQxEkUoZDX2httA5fk6EeoE+ysQG2ztYlVi7VHukqJU/mUX+itVpB3GGVf
	 iop6c+d3uTBDZGnRnFpK+TBcpDI/4txqdaZ5VRZsp8o32/sGeNYqZB25Xjnwu4qO+4l42
	 V2KIAj5TjyqNWV9BKb1ThTHgrCmMEYHqoHRRtnJVWeAayBSyLPwYVQGI39bXiB/aQYbqd
	 NsU9iE3rUupgcDAzRkiPS87msnXVmv9vEpEasJUtqF5YvZDJCa9AXxDy25jePZI1OGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794694113;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ug/apgAda5Acmym7YFj02vW4YgAYTbiXYAURle9bFHI=;
	b=cAK2p0pUFz1yWgeKjy3pWRwJzNhkIQRKCgwI4XO4iBWqy1zgMhEuUudeWGJfDFSCI94k
	 jFUz+0HrJOaF9IvTihQjCLePEZIKV9vnxBaRN8G0QH52fm6+oPyqnZB1CXNF+61zSfA63
	 aQ/ZNT9QHkgdc6Oz+EXpe2XOGXBb8YQRIxcuujocbnyEIzVyQDYC/UEpWFcCq8pad+fj9
	 4tuKhWuBIAWqZE+21AcNGr3iP9Y6w2hdiu6KMAKs088KN/v5F4kAhSZxHRvHcq5tmwXy1
	 QMD+pp9gvpNyZV3k3M1/V+sLGB0ORZGWToBpATRMQNEwuDDjiLGrLps6Icgpp5Pi+7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=QUJvRXP+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4KKpqMkK;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9D606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 22:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91A9D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=QUJvRXP+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4KKpqMkK
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 962EA1381C40
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:08:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 14 Nov 2026 17:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1794694111; x=1794701311; bh=Ug/apgAda5Acmym7YFj02
	vW4YgAYTbiXYAURle9bFHI=; b=QUJvRXP++LBrm5IOwGRYgskb0dJNHybkgN9Ra
	EhM1cxMc4efHf7wdlfBROq8VjXFhyggQX89IFqyVDiySPa9dB9xnDV4fLlKHMI2T
	ltnBnjWpRgpuanNWV/CCTIOIA3Kc3VydoaVaap0cY72X5PuBKHBOSZImoikOWJq/
	Kqny2BAU6UQr5HJT+g3wZyj+pog1iYX01iiqn9XNpr9QGPdUxSFOJZMkjgTULvOm
	24kAeug05Hre7eaB7mqfu+cXI+WFwfthAhWSuabLpfsiRoCoRHocT3qYUBz0oVGC
	n5Id+f/3ZLnAUQ58P1niv4lEbSOZwrP5KnfhuAO0m/TAHakDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794694111; x=1794701311; bh=Ug/apgAda5Acmym7YFj02vW4YgAYTbiXYAU
	Rle9bFHI=; b=4KKpqMkKIe5wC5dCD6LCz4bGesqE11RVca2/cj/yF1pmf69g5gt
	JIlEfPSCp78M418SMeUNHwmv7nptwx768CVMCcxeNcE2OjQ/e6f8oXNTrC5UqPx7
	WpS5WPazBG+y5a5PduFdLl58ercQH95sO9ccVH6UPk28YkyU2C8l5sBGlbwfrKtr
	IL40ABIKVFqLj4zXxRaPt7pNGA6Wo7ZmcVL21115LslIf3FJSQiIdZV1hAQ0nnhM
	WNTyD8J1YkUA8U0D7SV1kjYJXGX4HfBPxCUM0kN7/qzmZdJ3zecr4m4uKOF5S3uM
	E0JFkoRCp6WUYub8BMkX0Xf9SKjvzTpMBSQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794694111; d=fastmail.com;
	mf=PGdyZWVuLmtvYWxhMjk3OUBmYXN0bWFpbC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:leove+zORZA9TlpGuwsJC03yCucgfuQegC7mnxnk+66QJQT
	pW9LWHX++rXWgAHei0xO0WreGwuDf4xB/CH9UUm/vl3hxSt78GLUVH1q+7Cp7AoF
	Oi4epVI+gE6+RW375JCMZCTqsmAeNkJKSZs0miZ+Ld94/hEU0HgwtXk8o2SocF3A
	RwMxeChxEQ9rJ3CyklHpCrP3yBTQ4gPMfeiKmgvvtcnejmEZy3A0hSlJ+tzHPJ2U
	cNcrpc99hjf7evvSF3GRalZ4gDfTUKo/3IOkqetMh3ACYDMrt4tRRAi3vUoiCS1G
	ZZTHk7a9tcQQPN+Aibj5QPznbUIOyaPNRGRdAOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:bMVwpMwupdCv5a7P2o3qZ5L6a5uZykSM1kN4mGRoVLA=:bfUyrCu7q4t5KUyVezGHvAbrac7U/YzxFFt9zw7WK6g=;
X-ME-Sender: <xms:39v4avGsCpauFV2-z1Q3qk1cIQ1Wvylp5iAe7eR-EYAvbfFCFDhCqw>
    <xme:39v4anRHSHV3saclplY9BvoAunNZNDMxYg81kuTlzfnN9X1LDtlN0Fmx2QNc2zK3Y
    NTZtfGlbSNIcSKuide_8RAkbytIJYtLui30FFjSvJAdyg0Ya8otyNXR>
X-ME-Received: <xmr:39v4agIb8WTCXjBUkHFGPWEQWmMSeGQe9a83DLG8-JoJymgfaAVqNLy0G9jc-WSqws-sZKgNMwUNXyCqI1JqFxwirnPWrMtA1SlBaLJAPTDf2ZI>
X-ME-Proxy-Cause: dmFkZTGO7qDD20ztsvp8S9i6TU/49ndJrybpS1KO5n6TdTAnyqpsy+ETATuq2hoKGMiNoe
    sfGBCfIaCTXv+7IVUoN6k0KokiFL/Qy2RWMQwTL05rAoaJ2IcQtmBnhcgVSdP/X53SgHx6
    Frqz/xlf21fx0WXOKbQn/HdXvMK5/J9xCeO+kIvORkRRIc6B+xlp4CvkNtkPjH4HOY4zR+
    u3Fm159sFlA+ZChoCaw/hGBnSP9ggsZmSkbce5efhN0uFKVT6+BbQxu5ueepQ/7073sUzF
    gJClykGmqR2voUmUD5xWNyfu6fJSdQSgpZwZSqLIgdKLg+fg6FWJYZIm+tw+AHB6pruplB
    AfQdwFw8pFNRnUtMLuYZJ9gRm+5j4Rz+bVnfW4Z4Ct4s7L5d7110cPKPLJV5Tp7nxnGiPl
    dWZ/ifzjukrgJvXnvZwtRcSWYO638q1FUP08tUbuQ+z54FtTo//TCgmwUSMUF0Ew76CFTy
    uBJinbqPZf1iLhFbDV6zBfwb8kehrGXEQWh+op/T9Q+EDpUdzYFMx+aBt4q2Arroj47z/I
    /E+/c1cpuy6k1glpohqqO3mSDtt/zFlaOoBcOf/74Cc/sJNtFPqe+KGJzxuqUr05pgxG27
    Ynyy7ya0C+uyD51Cb2fHJYOHTWjvyeyvTijqfz/+mhPC0pXIYO7NJC387OZA
X-ME-Proxy: <xmx:39v4aiZQkjlIS15nWQx8VlJEvx3myQ_FPH9DOdfx4BXb8U3RAYKprA>
    <xmx:39v4ai8gmrmy-uV_SfZFgIQJEeQGIDY5PK6WA8JJBhZQy5N5maZkGA>
    <xmx:39v4ajZcjXso2amdtFfVYOTw4tscg6s5_n9E9EF_X373Zmh5uj4AsA>
    <xmx:39v4amObhblumtMfWig-3fVqRRVAbuy3blqi1DPVmSFawEEZfDdIzw>
    <xmx:39v4asfSLGzM-3aVbCoyqzb1a84SmLmVqZCH7GvRq23pCkz9ic1Sk8nR>
Feedback-ID: ib51446d9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 17:08:30 -0500 (EST)
From: Ana Veto <green.koala2979@fastmail.com>
To: rafael@kernel.org
Cc: Ana Veto <green.koala2979@fastmail.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: battery: Handle a negated 16-bit discharge rate
Date: Sat, 14 Nov 2026 22:05:38 +0000
Message-ID: <20261114220739.10496-1-green.koala2979@fastmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the MSI Claw 8 EX AI+ (MS-1T91, BIOS E1T91IMS.10D), _BST reports the
discharge rate as 0xffff03a6 while 934 mA flow. The DSDT reads the EC's
signed 16-bit current (0xfc5a, -934 mA) zero-extended, negates it with
"~Local1 + 1" and does not mask the result to 16 bits. The magnitude is
left in the low 16 bits (0x03a6) and the upper bits are set, so the
int rate_now is negative (-64602).

The existing quirk checks only the sign of the low 16 bits, which are
positive here, so the value passes through: current_now reads about
-64.6 A while discharging, battery overlays compute about 1055 W from
it, and upower shows no energy rate and no time to empty.

Also take abs((s16)rate_now) when rate_now as a whole is negative.

Tested on the device with a v7.3.3-based kernel: current_now reads
624000 uA at 14668000 uV while discharging (9.2 W), and battery overlays
show a normal wattage.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ana Veto <green.koala2979@fastmail.com>
---
 drivers/acpi/battery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 43a7543..45a4db5 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -703,11 +703,13 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 
 	/* For buggy DSDTs that report negative 16-bit values for either
 	 * charging or discharging current and/or report 0 as 65536
-	 * due to bad math.
+	 * due to bad math, or that negate the zero-extended 16-bit value
+	 * (0xfc5a becomes 0xffff03a6), which leaves the magnitude in the
+	 * low 16 bits and makes the rate negative.
 	 */
 	if (battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA &&
 		battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
-		(s16)(battery->rate_now) < 0) {
+		((s16)(battery->rate_now) < 0 || battery->rate_now < 0)) {
 		battery->rate_now = abs((s16)battery->rate_now);
 		pr_warn_once(FW_BUG "(dis)charge rate invalid.\n");
 	}
-- 
2.56.0

