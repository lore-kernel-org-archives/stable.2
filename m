Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368684;
	b=4VvjB6aJgTOL9QLV21B3t2qLuHVQ8Pg5RfLaLacpKrxDGy6x/NgKi3Kx8gV6c4thQ50v
	 OZkwj+16ImZQW578cIDY8UgSqD5HccYKpP7wHbK6zZiHOP6fOcZxcxrelbfh/RLqO1nCS
	 lZ4eKTnGrD3k6aCdp28YivbrKO1MioqABS0NPDRzkQOi3nDw32IArJONwEmRLUj2/Cnco
	 YsDvnZu+QXCURixXTc3Csvcll2VbjDaV5WojZppaHY/7aa4/AqFasI5y0pXZMqXsL+pZ7
	 JMT6SaS7LKcd3ogk0uHYB2Czk4uRNGY1jXOu+h7tuNOyRINXvtmDBRNlxWGaHYM3CLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368684;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0A0yDuSV3+1izEZotsYpqG58Xyg8ZLXo9/H+r3IOpeQ=;
	b=ZFaVIphiggDBJABYJOLyQKAu23OQiKPT7Ngndd/A4szesRXNwigQpyORTxYXU0xk7u13
	 vbN8Wc8LV6E7wglmXryl1cWsqa7+UK5i13dEwRLz5J8OWWnMFWYqctA6LEIY5y9tfUPB6
	 4U5r4Q6N2odgNHVfn2+lA/4jXGIVwLzv9W3SIDSyCdhIfU6mppwnIhQQlHS/WMQZlZdAz
	 PudkV1/ZyMhZatR96T8AseL4UziMbO0AMiqaU7okyZggFNH5UsCElllu19eH/v8wp18Z1
	 x23u1eZ+Vto8K4W9mBC2DhnrxiIp946c9vmfDBPn/QtlirNFB7RO2h5VgteTpiHvICQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xqo9auGd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xqo9auGd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B583B1F0093C;
	Wed, 11 Nov 2026 03:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368684;
	bh=0A0yDuSV3+1izEZotsYpqG58Xyg8ZLXo9/H+r3IOpeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xqo9auGdShowW7lGSUu8KtqE82RXsHXoofn6MJDNDuFx5MAeNx/IqDrkQYrPNNkly
	 nFNV51XCd+JhCQ3Ga9k0SDGQkRYfGh62mB3xJJR19XYtB2ULmMW7QQkH+ghs/b5R9J
	 mIoWdkwd7FRayprWCkM8UyiOOUMWwRbeli3Q8DKSwtrXtVfv1uWi/ZUFu9dmU/vDZt
	 890hFazLE+qrudwcoH3rXZdKq95HBzhDdy6xIrSTpdbxj5esmxENALpAKdthSGyffA
	 Vw7uGwikNOyJntaq6QjaUsl1oCt6zK0x89d3ktJZhEhEcCF8YYj0gkAGvQKepggjRp
	 q8cxa/fwmvoQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] media: qcom: camss: Propagate vfe_reset error up the callstack
Date: Tue, 10 Nov 2026 22:44:40 -0500
Message-ID: <20261111034413.979341-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034413.979341-1-sashal@kernel.org>
References: <20261107053039-failed-6.6-e5d4b0e69a40@kernel.org>
 <20261111034413.979341-1-sashal@kernel.org>
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

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit 5c07f30bed52ed85673b634f77467e404645785d ]

A previous patch I had removed the returns from vfe_disable() since we
didn't trap any meaningful errors. Konrad pointed out vfe_reset() could
return an error, which is true.

Trap the vfe_reset() error code and throw it up the callstack.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: e5d4b0e69a40 ("media: qcom: camss: vfe: Fix VFE reset while another line is streaming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 17dc713b43cd7..f4a4f0fda45db 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -432,8 +432,11 @@ static int vfe_disable_output(struct vfe_line *line)
 int vfe_disable(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
+	int ret;
 
-	vfe_disable_output(line);
+	ret = vfe_disable_output(line);
+	if (ret)
+		goto error;
 
 	vfe_put_output(line);
 
@@ -443,7 +446,8 @@ int vfe_disable(struct vfe_line *line)
 
 	mutex_unlock(&vfe->stream_lock);
 
-	return 0;
+error:
+	return ret;
 }
 
 /**
-- 
2.53.0

