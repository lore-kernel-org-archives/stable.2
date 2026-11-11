Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370420;
	b=j7oFGLKnuRtOOp/VwEtNn4aHOQB6LY86r4wtIwRxOSPlJG1FTwFEKh38niLbZ50KUlYM
	 qnhriBu+iVFMGUvY9sS3k79U8qtNcN7aM2rPm7ryeVsn1NpkyFl3f32RfH5EhPmV6yMmE
	 JxU4lMZZ83w6jcGj6kV+bkr74cG/qt8VJIL4Ovh634EZcdC6zIF75LiWYniQtJjHq6wWv
	 l/5mwTd3gduk2CzBEkt74Q6Ya3K9GpYzVPh3PZd70Nhie8T8ytj+z0WFM/BZ5ZbEXrrVl
	 KfAerBPAASnRFNQlmThddC622ScNAehdJLf3SIkCEGFK9DyHMEL/FkuGJuNXDoN091g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370420;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nE50cVqEmuTioaFgPF2gmuEmb3VwiWhwvWvdSOpxQ+E=;
	b=3NDlwItg8kGt0ctIKcZ6II6SUMecbp+lS4NI5trVWDxlS2aoHr/26bYoFDJ0iorXFS3t
	 WtD9HuE+34/juVEPSVwb731KDw/jVsmFAcIOptBhJw14sEf5qgCoTUTd2IoKzX4P7xUhx
	 23fR+4wEcMUpi8Y2jl25HLBIV2Jjp6cmyS9SZf3HbKvGJQNF+Mqc1gYr7hUb2yJ4SyXZi
	 LB3GPcYv2an6sxXpYAbph1kszdf1DCWedGBffypoJKFKcNUYxqU4LKaJCoTAROLkyTbxA
	 ybgH1JpgzLFdRiIUOWDuBQ0FgJkHQ3HYGqDRPLk30rRsCnouDNoHekwrkIbsE8/RTsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHoufocQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF46606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHoufocQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038DD1F0089F;
	Wed, 11 Nov 2026 04:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370420;
	bh=nE50cVqEmuTioaFgPF2gmuEmb3VwiWhwvWvdSOpxQ+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YHoufocQ9hXmveVZAX91UUAV2rA5pTbUXJgmOOWvGYbKGxmhypw8xSe7hvTX9ouF3
	 l3oos89X/BZXWeMlxlYl8G0uIirqEofP/+YIpq/xv4a7qtJwISjxl8skCEVY9Y32qH
	 tmiiNtN//hcBcu2YYIbpGZel0MocCDZwvcZ6SVsjU51uxOVByGrbyS5fiPP7F+P/qP
	 B54bnpNWQunYJKrZLNe4zbgNRpbTMY9/oe3yY/YSwfH39ZwQ2I6CchArOvMkExTVrw
	 cnaCw3edLXiIj/HI7cm4OiQep/Z2n3sIamf6QBAYT5IQgi6P5Fs4l1WCCuH1VTl1XX
	 RfoNWg0EXdbGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Foss <robert.foss@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] media: camss: vfe: Don't read hardware version needlessly
Date: Tue, 10 Nov 2026 23:13:33 -0500
Message-ID: <20261111041132.1029567-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060052-failed-5.15-e5d4b0e69a40@kernel.org>
References: <20261107060052-failed-5.15-e5d4b0e69a40@kernel.org>
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

From: Robert Foss <robert.foss@linaro.org>

[ Upstream commit 8cc80c606bd1db7febd43d900fc129520580beab ]

vfe_set_power() is invoked a few times, which causes a lot of
VFE HW version prints.

Secondly there is no real reason for calling hw_version_read() from
this location specifically, since it does nothing more than print
the VFE HW version.

A better location for the hw_version_read() call would be somewhere
which is only executed once per VFE unit.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: e5d4b0e69a40 ("media: qcom: camss: vfe: Fix VFE reset while another line is streaming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 8beea27004ca3..72a26dea84212 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -714,8 +714,6 @@ static int vfe_set_power(struct v4l2_subdev *sd, int on)
 		ret = vfe_get(vfe);
 		if (ret < 0)
 			return ret;
-
-		vfe->ops->hw_version_read(vfe, vfe->camss->dev);
 	} else {
 		vfe_put(vfe);
 	}
@@ -1302,6 +1300,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 		return -EINVAL;
 	}
 	vfe->ops->subdev_init(dev, vfe);
+	vfe->ops->hw_version_read(vfe, dev);
 
 	/* Memory */
 
-- 
2.53.0

