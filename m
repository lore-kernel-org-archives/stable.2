Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284078;
	b=04HAFx8zVoYYXUyHwejxFflxgn8vnjRjw1VaWh8rxsHWS77GCl6fPpRKqdOpxLNKRJI+
	 /RP4f4gXXuDBzX8I9/oCwtJgqf3kiUuZfU1OKpTo2BLYA7wouA5YznlgLtfw/8jcqSX6s
	 pBs5t4WEdxwunpsYknrq12ON9rrKz6Elv9USTVxSE3Gs8dHdLlejvhZlBjbsibyEVcb6Y
	 UOxq+R4Hynvom7hft0sz7q8d/tlb/9QZsUKlkwGo3fcYdRIq7tNCK4TYpxdRRR2hr/oxB
	 SiZLzMcJny8dTniBuYtni+t+sqP8Np1DqUkghLlEC3fJvWgczEPU7eh2RtS8aCTbr/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RfP/iI3k76Z8aDfGwkMe7ZVTwt4avGUzB2QXStHk91Q=;
	b=n3ILUXSuUh3rMYlZs568L0cxLce6jd772WywYrtAlYZC+7mJfeuFbj/Xqb2+M8IpDfvo
	 rjQgwY81zP04bg5hKPLtpUMkXULuGKiGZYBzwVBs0TIHVCC4fo6arznKEdTKndv/IWL+Y
	 iy3+9A30FT2Vo4PPrIZBxDcKwNPdLBJkVMZPHDbNxr+06ar6OH7kjvzM5qIU+ToR/+Sc9
	 BSDlwFhX/B0cf1yNIx035NivtETqb69W+qMTLj7jJ8VeSFL1TDc3ARz0P9c7U/LezwzGL
	 NGRAjTDexAXlfYJTDWPKTQZgO94V6HNroqoRFZSv0flelsICDSUPMFhHXYLmOHg+vpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jUZFbi/N";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6304606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUZFbi/N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E551F0089F;
	Tue, 10 Nov 2026 04:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284077;
	bh=RfP/iI3k76Z8aDfGwkMe7ZVTwt4avGUzB2QXStHk91Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUZFbi/N0bTw/uu7wumHhwy5QAxX7ZlTUN8wTf4/7bIp0T7mIviwx64vt5gmMArAf
	 ej4zPsurOJI0jh+HLMToMthJaDnLRLwURTwoqeklosTuSbmT9mpl8v2DW9f0M7R7IM
	 KuSpzh2ur8lIPIaIlNo9bRwn/cbk5a8XRRNl0lcQsW3HBNuPzfGNTAHJTQtwatl/5/
	 deNbOjaBJCvOVqx3ofl3MWhwxD4ms5ZIKQoGJ5s3oarnVvSz1FDJfIQEmGrXsqZ9Xl
	 O/9DiddUryQAoL/iP2bXCgebA3J4tKQgIYwBS4QZq+8OI7NPK2PWPGLvQyqTIG+dvu
	 TkDwUMuNS5MaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] platform/x86: int3472: Fix uninitialised variable warning
Date: Mon,  9 Nov 2026 23:14:35 -0500
Message-ID: <20261110041421.320869-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052834-failed-6.6-70e6384fe0f4@kernel.org>
References: <20261107052834-failed-6.6-70e6384fe0f4@kernel.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 70e6384fe0f4cf9768944f81924f6c1478b0ce43 ]

Fix a compiler warning about an uninitialised err_msg variable by printing
the error where it is handled:

drivers/platform/x86/intel/int3472/discrete.c:440:24: warning: ‘err_msg’ may be used uninitialized [-Wmaybe-uninitialized]
  440 |                 return dev_err_probe(int3472->dev, ret, err_msg);

Fixes: 5de691bffe57 ("platform/x86: Add intel_skl_int3472 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
[ sashal: Adapted error reporting to the four direct GPIO helper paths while preserving the existing return ret behavior. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/int3472/discrete.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index d56f79043f5e2..d18678b06616c 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -156,7 +156,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	struct acpi_resource_gpio *agpio;
 	u8 active_value, pin, type;
 	union acpi_object *obj;
-	const char *err_msg;
 	const char *func;
 	u32 polarity;
 	int ret;
@@ -202,25 +201,29 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	case INT3472_GPIO_TYPE_POWERDOWN:
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, func, polarity);
 		if (ret)
-			err_msg = "Failed to map GPIO pin to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map GPIO pin to sensor\n");
 
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
 		ret = skl_int3472_register_gpio_clock(int3472, agpio, polarity);
 		if (ret)
-			err_msg = "Failed to register clock\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to register clock\n");
 
 		break;
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
 		ret = skl_int3472_register_pled(int3472, agpio, polarity);
 		if (ret)
-			err_msg = "Failed to register LED\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to register LED\n");
 
 		break;
 	case INT3472_GPIO_TYPE_POWER_ENABLE:
 		ret = skl_int3472_register_regulator(int3472, agpio);
 		if (ret)
-			err_msg = "Failed to map regulator to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map regulator to sensor\n");
 
 		break;
 	default:
@@ -234,9 +237,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	int3472->ngpios++;
 	ACPI_FREE(obj);
 
-	if (ret < 0)
-		return dev_err_probe(int3472->dev, ret, err_msg);
-
 	return ret;
 }
 
-- 
2.53.0

