Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420440;
	b=YLRP7UMiAhVQS7z8HDUQbmk7oEeAIEGDCtxuPVVg11fEBgC3PNK2vWbrogV0KEzzQt62
	 XRoObvn5rEp/6tM0glGA0v28imjsPaSdXQ1JYd8MIRXtCj5D0FwxCBOrOXx56TLAbgZW9
	 7I4NJddg04cehyvLZDVBTE8ByzEqENlxWzoc7i6Rm4eNVe+BbTFCSCwu/Bfc7tHbP9s3C
	 Un8nYJKR4RcVL09sTYmjtWybL9htQtI15+Se0qvDQrnAMTQyffA8s7H+TBBWQmnoCso/i
	 9vza2Mfb9/EFsYqtWM3QETuIJZSLNUYpKifjOuaEXMZ5IqEWHvAqE1kNKQYdxlARk6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420440;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2vKEEQ5bJ7S5gzkdWIwdfGgNZEgvCztGMVRk5dpJH4E=;
	b=LzulA5LYVBadFtrUc3+m3qUUUzYXXWa8fvisXsgqlkm4r7rURqVjTpz9Ouzgd6gW5/Ac
	 OTcjC0RoO8x5Uvq21bNS7egtCdMydE6Qz9BvvUdFc57RWwwxp1Gchp8/KoAzmNhQthh+M
	 0j71GmdeVXjrj+lba8ZRHul7xOK3jKvKhRF/wKwBHg3/g1aoBQxOR+MvIkkVYrqVTndCG
	 0RbV4BQfki+vBVcfoAQHCoh4ZvfAcEtNdyOKpcFw4AgnMunLj4+J3nXr0ISpq30ktp+Cj
	 uWzkVSgKBZoUyLrjtCbJy5uahjd1lxf33mQ1NIl/LyMgmudyrBhMFWb+eNCyP0uO8ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/KQoflb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C71606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/KQoflb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03621F00A05;
	Wed, 11 Nov 2026 18:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420439;
	bh=2vKEEQ5bJ7S5gzkdWIwdfGgNZEgvCztGMVRk5dpJH4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a/KQoflbXbaq7zQBNZ2Z6GyT2rylQj+kHq+KUmBYupyLe+CFklqgsVjTlFKugaqHp
	 qtZwZC69DtLi1+KTMThOfdt51l9tqKxck6sGBRs/VESMZaMhPYX9+bTPuiPQ0/jrPS
	 ssm5/2+5h3L46+unEj1olzAUvCTO81pIzU3D9pk/XUTiX6RyfeswjoF7FFNhhiWNNM
	 YtSSELg0DucKU+7xd7Bc4/Tk6Cl+Xqftlg3sdj7kY+luOPx4yIn9LMTxiB36p/l4lN
	 1zqF8l3mtu5asv4TsbQa8AVIk6q2ww67npseENwBc2lAC0c0J1WXBdgJHHbcObnac3
	 UodYDB2IMA7eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>,
	Charis Stratakis <c.stratakis@proton.me>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Rong Zhang <i@rong.moe>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] thermal: intel: int340x: Evaluate _TMP exclusively
Date: Wed, 11 Nov 2026 13:07:17 -0500
Message-ID: <20261111180711.3754313-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050528-failed-7.3-c4aae727beb2@kernel.org>
References: <20261107050528-failed-7.3-c4aae727beb2@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ali Ahmet Memiş <aliamemis@disroot.org>

[ Upstream commit c4aae727beb23a736c15b8d53e219da29d791065 ]

On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
without taking the mutex the battery methods use, so it must not run
interleaved with them.

Evaluate _TMP with acpi_evaluate_integer_exclusive(), also where int3403
and processor_thermal probe for it.

Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
Reported-by: Charis Stratakis <c.stratakis@proton.me>
Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
Cc: All applicable <stable@vger.kernel.org> # 80892972ff23 ACPI: utils: Add exclusive AML evaluation helpers
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Rong Zhang <i@rong.moe>
Link: https://patch.msgid.link/20261018122220.678822-4-aliamemis@disroot.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261111164858.3300811-1-sashal@kernel.org>

 drivers/thermal/intel/int340x_thermal/int3403_thermal.c     | 3 +--
 .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 +++++-
 .../intel/int340x_thermal/processor_thermal_device.c        | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index 264c9bc8e6454..2262de1e14d95 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -217,8 +217,7 @@ static int int3403_add(struct platform_device *pdev)
 	}
 
 
-	status = acpi_evaluate_integer(priv->adev->handle, "_TMP",
-				       NULL, &tmp);
+	status = acpi_evaluate_integer_exclusive(priv->adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
 		status = acpi_evaluate_integer(priv->adev->handle, "PTYP",
 				       NULL, &priv->type);
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 965700ee69626..9451fea1f65c7 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -18,7 +18,11 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	unsigned long long tmp;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(d->adev->handle, "_TMP", NULL, &tmp);
+	/*
+	 * On some ThinkPads _TMP switches the EC page selector without
+	 * taking the mutex the battery methods use.
+	 */
+	status = acpi_evaluate_integer_exclusive(d->adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index b0284c2e2e74d..9bdb65f54b6ae 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -287,7 +287,7 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 	if (ret)
 		return ret;
 
-	status = acpi_evaluate_integer(adev->handle, "_TMP", NULL, &tmp);
+	status = acpi_evaluate_integer_exclusive(adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
 		/* there is no _TMP method, add local method */
 		if (intel_tcc_get_tjmax(-1) > 0)
-- 
2.53.0

