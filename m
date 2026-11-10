Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316222;
	b=sUScXFEDG6XfAho4thOMV/1xFqmqKHW/8mcVvHgs/fBjpKw2+q8Yd23CpRma+yyLib1o
	 7A1SxafIsnrOXbyYawcPM8cRRzPw5XjPN6uuIt447igF++3CLzfVo4r0eoR2scgTCzpUZ
	 X1HDFyLTDpNgr9Pg2XKyHagIHJRefGNlT8OvY9Xfcw2CCxK531lIm0OU5G5TazFnRAT/E
	 P/d8lEKWRXy40uj7zf2MUi5B1xAzEQlOyEtpyOi5EZc6hOQMoWRN4qoKM7O1teJicpHVD
	 jgud0t0+BN6mb7nM6lBCU6TQKnZJuTRvx1eD8XrM/ldpd9moPB0VZBmAt0yVKZ5cZMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316222;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=tFhGeWPMb1PBc86u5Bnfejx9Gi5hzNkST1rc5EOHv4o=;
	b=gkcIdvSQZBJDI3xujajCVYRjFtp+U5/ouiTai/hJkA0lG9Q5ayVRlib7LsOc7BLGLcDl
	 OdV/daNkxigTC7GNWcgEdxXAUNZXZaO1uRSK6/e7k/gR6BubifR0eYrU41KZAk+22sHM0
	 1FI4p43ikYYl1CgNnLXA776GsNs+3cUPpRqgJ39twzcimryTtlybnynuIHhgPedx4gDmg
	 oa6d0FCd66DfbVOR/gP0DR7uyhtmTashLfXEe79LFNiV6YtqMJcXoj/hm/Q3ySSyONVBY
	 5JTYLuFFapcHOS9c5QfkPYwUZOerVBvTKPn6wNQalreTSDE4ZC+If9pq1DR3l4AmC8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=t3ZJAWRd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D26606A321;
	Tue, 10 Nov 2026 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=t3ZJAWRd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794316222;
	b=nbT8Vec70bO3T9seZyumw6lM25/QkipxEUMmiz0Qs0iSjnINZsQD+V1z09mc1IqW4JBA
	 KI/U3Ib1D/OQV4CL+kXqLbCTl7bGjPSkFyZAiy4jocv9FyNWRr4aN5eOm6pdR15MasGpr
	 amOSDhoGYeQyssTlOUPlnLN+J97oXn6NN0fNJ8y8SJPMSnw6sdWwLUgJ+PSEUNvGFrtYE
	 iJs03PqCNEByW7BxdHossXoIhYqgxwTARizTqw55aLh6iHv74eSBM0fJIMdmrRMu/OEOL
	 RC2RUXIhRmuVOZido16UDKDGLUiSDOdttle7gP7xp/YjyMwkbfkAkRTfa5pG12UB4Rw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=tFhGeWPMb1PBc86u5Bnfejx9Gi5hzNkST1rc5EOHv4o=;
	b=ZyN5JPQlnc9ouv/aCloJY3CAsmJSgmaNU8KDVib6QMqzzCj9PZKYtAz9pDuANVa7MhPa
	 W44tfSfsSd/1vjqrA5ZiqaUEsqkXeSmBDZXnfNdX/lEGDk8YXCifKGS7FQQeeHTu2tHJr
	 hZ0UEgd9F2zo588QnKYT0l4O85jzwTgtaA0ZZXMTOEtqgbKRmlf7twE0rsRluq8e8WhVY
	 O+5JtYeb7bTA9hY/I5GhvaITwQ96ekBlSe3t/yW+RAnjcfvNToWpR7yayw3EiNuCRqvj+
	 XgkC0t3HBLRtd5u6hMjs7PrN/FfCuHF9L84mfa8ZP3DmTft3ZA2GFAdQjW/whRes1RA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6ED7F1F008A2;
	Tue, 10 Nov 2026 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794316222; bh=tFhGeWPMb1PBc86u5Bnfejx9Gi5hzNkST1rc5EOHv4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=t3ZJAWRdjFB98XDAr6LcrckmwDth4hSK1/Yjma75dS0CUpE2u0IqgrTy0q0/06q7n
	 dGwVX0fx7YdEwXDjFXsxy3X+dTPDlTXFAvrPquG0cNbc6qzklH8dniBUPvhRwKLMrs
	 Qrevhg1zEXEpXGsn4dhUXCD8Xph2FeEbBiQjB2/c=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E42AC48B5E;
	Tue, 10 Nov 2026 13:10:20 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Tue, 10 Nov 2026 14:10:10 +0100
Subject: [PATCH v3 1/8] media: i2c: ov9282: handle error from exposure
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
Message-Id: <20261110-ov9282-fixes-v3-1-cb6df80cbc22@linux.dev>
References: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>
In-Reply-To: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794316220; l=1053;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=b3Jbh3NXBCORRMCvX19hEQQG/dyvlyW8ukNEV55mjLk=;
 b=0LYX0WlBpqGTpmcWQoTr02nPDBI8Qozf5gOjnEVM+uzVkF/oAlMZI5BT5QSU/HRlsNEDJHjvP
 S0Z7x2+EW0HBA5OoNg9mHiy0laO0w0fmlb8okJtkKr9enMoyJjgEGjN
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


