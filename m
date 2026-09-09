Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69E57EDAD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963069; cv=none; b=NN5B3UII77rKT+6HQ8cPigKAwsDWA7736o9b9JkO8TtCik9loZgJl9pkzctM154fY6VGlopPV5ul4gQkk0QgXLrTeRgm6XgcQ1nuktzZylbDy0YsdHN0s06KwDX7xfOb3XlRsnilpGimFSSrqhaRS65GO3nplPOJxMuz4YBGvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963069; c=relaxed/simple;
	bh=DddZMdbmRdnWORpOpx92hrgejLbjHibReG9BdWae/AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hpxx4un2mS5BWdwW692AU6XkAdFT9y+tC9hJb+HcMHPuPxiDi4Ag46PEWh3NJqi4uDTvtzicx8bXXWp7ikro95i7kFvOEIRZgQ4xqeYPvrQgOzVbcYHaIUOntrKE4BbQKHEgn1arfabNZZ7v5xLjo5cms7Q73vcVWVBWMujC2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lum+N8lo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lum+N8lo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6931F00A3D;
	Wed,  9 Sep 2026 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963067;
	bh=b5aX7BT6bgDYA6/YVgvOT/6XJufmFFz02Uq/lQPVtgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lum+N8lof/i1Wxc0objAzvAB0pSGTe8V45ybXh6kYgXLbgMp7eCBi2rC0S2ROh2H1
	 dXwuwmhpEIogVFOHQ1vIhRkC0od19kcVPMsA+NY34y+3CJQzgT1EE1zrZA3z2yj3Yw
	 cp4F3Yyjfcj1jTPuSz5V8AGRq1c5OY6QGuc3H42joQPRKxNbmbn5WrWSKIxmozTK6L
	 jib9g+gYKTovv2+kjoXsCg+a/oZ83c1Bb/oE3wBqsmpaicuNrAWGBTUIdwc955h5pw
	 /Kj67puRmJ0iwpw7z2rGDDzYRiltaJYnL1yT+Enm11L/PXMbL8jNVFdMaKlkZqIF//
	 ooxJcsbwswTUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/7] platform/x86/intel/tpmi: Align comments in kernel-doc
Date: Wed,  9 Sep 2026 10:10:59 -0400
Message-ID: <20260909141102.2383363-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141102.2383363-1-sashal@kernel.org>
References: <2026090334-lumber-underfoot-3bf9@gregkh>
 <20260909141102.2383363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 1192534407d0f8ab9a0503052777260ae74968c3 ]

Align comments in kernel-doc for the struct intel_tpmi_plat_info.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240423204619.3946901-4-srinivas.pandruvada@linux.intel.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 3de2776e9d70 ("platform/x86: ISST: Add a NULL check for sst_inst[]")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/intel_tpmi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index fdcebb8c30e98..fbc1b94abaceb 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -27,9 +27,9 @@ enum intel_tpmi_id {
 
 /**
  * struct intel_tpmi_plat_info - Platform information for a TPMI device instance
- * @package_id:	CPU Package id
- * @bus_number:	PCI bus number
- * @device_number: PCI device number
+ * @package_id:      CPU Package id
+ * @bus_number:      PCI bus number
+ * @device_number:   PCI device number
  * @function_number: PCI function number
  *
  * Structure to store platform data for a TPMI device instance. This
-- 
2.53.0

