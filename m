Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794837045;
	b=KU6sWBSrItnHXb0vXjt5Z26lBpAVoh/XFG6JHUa/1Hwvu4Rha6lc1eOgwWnizcjjm9qI
	 VcqQVt+zNauX+5QBVKQf8cDBfepTr2did63geVYowvuByRiGUMyar301qnbpAwLd1EzDR
	 ssdmazIf4yzNBuXFsq6kAhH5WUBQB0C58QJWGNdbDfyXBhuOlurJzZP3b4kj1NUYRzabx
	 8uL08+52J4KFkC00ZaUsctUcaewoZAj72oWvlxrBPChOmMhAKPU7ZFOufTXF3mwcjHQEV
	 1ZF+m/3J1v+EvvpfsggPf7eO9t5QyhRVNe3mwTx8gy/I1y4HkCcjszBrGtCa5wGiUig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837045;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=tFhGeWPMb1PBc86u5Bnfejx9Gi5hzNkST1rc5EOHv4o=;
	b=ZjPtGTYZ4jo/0W7It1cX29qy/Wj+JSfYtk+ca5nxqy8SCNTynncKUtlKJ1GcJDaMFwyM
	 +3/1SxWH+4fXMyo0uLjmPrXmIJifp9u5ryRZ375ac17HGPrTYSHhjjSg3IdywjpfVg1+U
	 uGkeii0H0WbpuOHBhj0WhuaMOoGGCjz+t18VE8zE6xAtY2D+5dPRm4FhT+jPVGFIO77XX
	 rM51DE3aVvR+lFanadt/fbNFgThSfBIFMV5/OEtSHqhniBvKYQKfaN7VkSt7ORiat8XgZ
	 KejyqKBjTKu8GUYde+MQENyp8wshsdSGIVl/gZMQC+QmdVnd6bFwZ3m+1UT36F4X/KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=oXtNoBAw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35103606A889;
	Mon, 16 Nov 2026 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=oXtNoBAw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794837045;
	b=MtlgwJGqKf/najP2H60X3+Mh7bNYXoBxH3V/hxpXYA7vWzVayrXc9ciXBMvR6sS7GaXL
	 Vu29go3AtXESsknnUbOq4ar8f3Ye60NNlLPWng/62+6LJlBqqK9+PgqBbU1rwAtDoGqjl
	 lScLTVjerQhqiL1qLciULa+oYrOLF+IRy0UXZBnRQcOpn2IH9EhHkiORZq4KXSD6HrAWL
	 0O9r703Bppd567L1+wCXI0kWF8Kc+aZqPW8i/uen4CuiJm3UqRZH4fgf+/urHF0cF+L+D
	 EzaTqclg3O1PlLLG5raBdRpiKBi/r1POTMyT/GpuRZaTHX8AGiiwnV7mtxilFMFuNng==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837045;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=tFhGeWPMb1PBc86u5Bnfejx9Gi5hzNkST1rc5EOHv4o=;
	b=QmTfvKdUxSCISyYblhsJuPdoVO2SBnQuRviLwlo3h+iNuYzBlyrHTIOj2QxykeYuNte9
	 supf9dfhmLA0hbjEgxCo0Qyz+8yFVbZd+kJquc+Xqkltm3HOEST7i/hPGu4pmbyZh9Qy8
	 VJYUSYFRbMKP932wbWQfzHUoe3RjDJvH4h/crfzQUpra+5KzpJYchmzcXt6uTue4bv3wk
	 br1wONbX1BOIqToiVertNbwvpLQWr5ScNDaWdO5W61Zn2ZwRBqRjDU0EQhkppB2Qgof9S
	 tfKCsRdM3GaJjrgAcEokxLh2UNbITIPT6n3Z9OO8jmYEK5JEmhcYInmtZoPNY89N16A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 401AD1F000D1;
	Mon, 16 Nov 2026 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794837044; bh=tFhGeWPMb1PBc86u5Bnfejx9Gi5hzNkST1rc5EOHv4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oXtNoBAw2fvyvYFd+9G8c0gXlCpsXbPBW46pcS6yfJVXgact8Uf9pqR3M55SwgMAj
	 /KzOyr8WBNJ5z1INYo9rAHv4lWp4ktIe67+0eayFSmt43usasUpVNE8R0r/XgQ/szz
	 iRxbcWjKeUrsVYZA+sM0yhyiTUdhxYpHTfFoKNMk=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BA9E44A47B;
	Mon, 16 Nov 2026 13:50:43 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Mon, 16 Nov 2026 14:50:22 +0100
Subject: [PATCH v4 1/8] media: i2c: ov9282: handle error from exposure
 range update
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ov9282-fixes-v4-1-f78e5d415c6f@linux.dev>
References: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
In-Reply-To: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Daniele Alessandrelli <daniele.alessandrelli@gmail.com>, 
 "Paul J. Murphy" <paul.j.murphy@intel.com>, 
 Martina Krasteva <martinax.krasteva@intel.com>, 
 Richard Leitner <richard.leitner@linux.dev>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Jacopo Mondi <jacopo@jmondi.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Gyula Kelemen <gyula.kelemen@advasolutions.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794837042; l=1053;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=b3Jbh3NXBCORRMCvX19hEQQG/dyvlyW8ukNEV55mjLk=;
 b=BQ2C+GJi2mA7bNtypbQm/aq10Z/E3Y4qJZSPooqJnK0LNpPgywiSLXYMBEMC8e0Lo2XZrJqgi
 uY/li6RR+ByDvevK0s63Z0HM8XwsfziDUPmc9zbSrquavN6X2rEnHyH
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

When setting V4L2_CID_VBLANK the V4L2 range for the exposure control is
updated by v4l2_ctrl_modify_range(). This range update missed a return
value check, which resulted in ov9282_set_ctrl() not returning on an error
from that function call.

Fix this by checking the return value and returning it on error.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Fixes: 14ea315bbeb75 ("media: i2c: Add ov9282 camera sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index 039a47c1918cb..546b43c209097 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -608,6 +608,8 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
 					       ov9282->cur_mode->height -
 					       OV9282_EXPOSURE_OFFSET,
 					       1, OV9282_EXPOSURE_DEFAULT);
+		if (ret)
+			return ret;
 		break;
 	}
 

-- 
2.53.0


