Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284873;
	b=Na1ghWwR0pORaz4vKZhUFbTA+BNJpfiNWK2Fx/SfPE2v7c4yC+flD+weBbcNrzhR9tp6
	 c85QcWHerzLUTat5iFd7l2MKfFoqH/IUNC4gWDmXVUlq/+PBZK50F3yKhNWJZX/4L4IVd
	 vfp67usvUeLy5WhfmqcHVfXI/vyph//1ttjmZPJUs0njlUZt9yHvnK3pOKAoyZqqyEDnG
	 m/DHDxwpgh8Bb/OaBwK3MX6t32UZNV1Fx6IdTswIkin9x+W4d9Iazyw8HQkCxpvES6Q56
	 RpGefoK4Vrlx0ueTzy7KSTVG86HnsA5yUuNT8LEgOgtL8df3z6hDi4m6/WOSv0ZkWjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284873;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xM6EUZXCK1fTMczDy5q0wk0/juYMvazlqxFhxzlHSMA=;
	b=WJ46CFAUHuvkyE/giUx8e5aAjJO6ccA9q7DkrJzC62Hx6f0ArzJGiywk98x/jvvKOQya
	 IfcB1gDCKaym0rXr00ZGyfK7oAIc8pgr/GumEEG8Nri1gpHqbX98RXDap7A3qr6o/cH9s
	 gBUuKw51lAHiWNYR96lKx53nEAGJf/QcLrPzkfhqRnjHkFLPVNPnIY99T7KGZ9xiOBo6I
	 RNW6x1mq+4ZuoAztjrI9/6H98k0KNYw+IDC5Ti0qvXkmkzp2854Sm2489Z+5vqP2oXzYQ
	 b/M8Wfsoyl1P/WSDN8VrsieIYmfDTc8wyzhcC6jjNyN/eL6qLTjkr1UCUEEjqhZxgTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjQ3atkX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5851606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjQ3atkX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F9D1F0089F;
	Tue, 10 Nov 2026 04:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284872;
	bh=xM6EUZXCK1fTMczDy5q0wk0/juYMvazlqxFhxzlHSMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BjQ3atkXbw7kZorqVZ4NpA35zMqWGKBRToAn7TVb9Pt4Sl8wZ5s1ebICB/hLBJp/O
	 49JUtkRLddwV2JCdebFklNAEOKKk4mg5BX0hRBfILk8jcRJGHgU27pZ36NX63ZsZhs
	 Q95E9yxS5QXHgFW//g3jCMxBTEgbVgg3ZGfniAsKQnuCBHmZ2Pwd29GM57hOF48ub5
	 rcO24h6n5VsWBPzr+MPXv+Ho8Jwq3kfYLVlhut57tKo3p90S2rKHSRdQPQVl960svr
	 3j6HIZmAZ0at2zY+eKyyADUhvJPynSmEyewdi3jSJOz4DuSZLI3illf6ObSxMtoGt6
	 foVGkRek+g7ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] platform/x86: int3472: Fix uninitialised variable warning
Date: Mon,  9 Nov 2026 23:27:50 -0500
Message-ID: <20261110042739.342108-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054103-failed-6.1-70e6384fe0f4@kernel.org>
References: <20261107054103-failed-6.1-70e6384fe0f4@kernel.org>
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
[ sashal: adapted error reporting to the older GPIO handling and helper APIs while preserving the callback's existing return convention. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/int3472/discrete.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 0f16436e5804b..57ae1afe951af 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -226,7 +226,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	struct int3472_discrete_device *int3472 = data;
 	struct acpi_resource_gpio *agpio;
 	union acpi_object *obj;
-	const char *err_msg;
 	int ret;
 	u8 type;
 
@@ -255,27 +254,31 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, "reset",
 						     GPIO_ACTIVE_LOW);
 		if (ret)
-			err_msg = "Failed to map reset pin to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map reset pin to sensor\n");
 
 		break;
 	case INT3472_GPIO_TYPE_POWERDOWN:
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, "powerdown",
 						     GPIO_ACTIVE_LOW);
 		if (ret)
-			err_msg = "Failed to map powerdown pin to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map powerdown pin to sensor\n");
 
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
 		ret = skl_int3472_map_gpio_to_clk(int3472, agpio, type);
 		if (ret)
-			err_msg = "Failed to map GPIO to clock\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map GPIO to clock\n");
 
 		break;
 	case INT3472_GPIO_TYPE_POWER_ENABLE:
 		ret = skl_int3472_register_regulator(int3472, agpio);
 		if (ret)
-			err_msg = "Failed to map regulator to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map regulator to sensor\n");
 
 		break;
 	default:
@@ -289,9 +292,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	int3472->ngpios++;
 	ACPI_FREE(obj);
 
-	if (ret < 0)
-		return dev_err_probe(int3472->dev, ret, err_msg);
-
 	return ret;
 }
 
-- 
2.53.0

