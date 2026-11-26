Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711872;
	b=ewtHT7Pq0kA8j5fqlWhwrYWCqk89bQ6cz+ggE+k57ErZna913AshOeuWUjj9Ml1j0OcM
	 WRl6sqRMRc43Xkd9QOagOqsZcNBdtHHC/ip7pO5zc/alsOOZFyk4/O3fgf9SAot7Rrdq6
	 MMa4cWTEcK7QvVq83R0B8l7Uy4WN13kdTiliFYW53VCFsDvCyUBb+O/yiRFQrcKvEu+kd
	 Rub6PHx/OntPLh3Mi6CqL+HeGIHb+CyJ/hqhO2+UPWzqmd3HF1Lwzs+5CGTaak46bEapM
	 DxOdq9DBZRJCHNT4vakr3rbsm8XvLI4ijAY+Lx+GLTvved5bVJL/SnVM33rfIYU9tsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711872;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UPREIQcVT1UkMDsdsT86Ok5BhzWUni5GeNYHdx+/z4M=;
	b=i4qsxvqoHkqCspl91FX3YZQgtW1twYjXMYv/LuwKAk71G47J7Kk7GpRRm+Z0TT3sOiV0
	 MD1Po+X/KhJMWM0ErsF9ReDhaG/8FhnoRYmjOnQjLkCX+ydznIe5bUzXN1eyFiGhfPo2A
	 j1tfq44ie/W3OGw8wo86wASXWkPfmM3Beyhpab4iSLGpj3FmV930XSzSaDU2YhhOxO1Pt
	 sIV547gQB0EnuNiRu/PgXivblBnAkNHlU/JDGI4pupMKbCc84s2Sr9P6jxHkMreSyeUjl
	 tb8B1FaBVm2wsGVlHgoN3Of0ffyuj+hoCPwqlqy3FxJ+S/SDNI1/Ju9/ipqDIzEnUYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMiVfewl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ADF606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMiVfewl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342C31F000D4;
	Thu, 26 Nov 2026 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711872;
	bh=UPREIQcVT1UkMDsdsT86Ok5BhzWUni5GeNYHdx+/z4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oMiVfewlMZK/r3vIi8PS2lHuHhbjLP2k9Xa+7og1e6xrEzlHdspSQWrpHSLZh4vp8
	 LJ5njzT9hmgHKpx2WQdTdD75ICOIp9V6nvsUKV5REhwF9+M71g+VpFkziac/8kfdQo
	 CN3+O8vGn4cvAGe2zRpHoGq0uLGEtkA+DCg4qX9tRpnn0s0aM0QcB5DXUhLS80XjoG
	 rW/o9wDxlv1yZiiCuaNCEMPye97WG9uBVAtPzK4GV0ycxLGVN2salqY+cCP8tnd5IO
	 iwY49iq/0UUvIzEgP7ZYwfmTDULrXn1M2qbC4CL40oyF0In64Ipxd/sJPZyGgX5Hqz
	 j+8/3hJKOybyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] devres: Add devm_is_action_added() helper
Date: Thu, 26 Nov 2026 11:51:07 -0500
Message-ID: <20261126165025.2602010-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126165025.2602010-1-sashal@kernel.org>
References: <2026112512-disfigure-marmalade-b2e1@gregkh>
 <20261126165025.2602010-1-sashal@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit e383bb8f958444620d96386811aacf6a49757996 ]

In some code we would like to know if the action in device managed resources
was added by devm_add_action() family of calls. Introduce a helper for that.

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Zijun Hu <quic_zijuhu@quicinc.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250220162238.2738038-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Stable-dep-of: 6c6508e742b4 ("usb: dwc3: xilinx: unwind ZynqMP platform init on probe failure and remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/devres.c         | 11 +++++++++++
 include/linux/device/devres.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 03da20f0431dc..89fcb95efad93 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -756,6 +756,17 @@ int __devm_add_action(struct device *dev, void (*action)(void *), void *data, co
 }
 EXPORT_SYMBOL_GPL(__devm_add_action);
 
+bool devm_is_action_added(struct device *dev, void (*action)(void *), void *data)
+{
+	struct action_devres devres = {
+		.data = data,
+		.action = action,
+	};
+
+	return devres_find(dev, devm_action_release, devm_action_match, &devres);
+}
+EXPORT_SYMBOL_GPL(devm_is_action_added);
+
 /**
  * devm_remove_action_nowarn() - removes previously added custom action
  * @dev: Device that owns the action
diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
index 9cd1787ef28ed..ae696d10faff4 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -165,4 +165,6 @@ static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(
 #define devm_add_action_or_reset(dev, action, data) \
 	__devm_add_action_or_reset(dev, action, data, #action)
 
+bool devm_is_action_added(struct device *dev, void (*action)(void *), void *data);
+
 #endif /* _DEVICE_DEVRES_H_ */
-- 
2.53.0

