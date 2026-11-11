Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368989;
	b=QdTy2Sj4aVNzb/RgzlrNEI6gK64C6Xc8JXywkiJB2SP/SJmYhhwXOz6+QpRJblH47Gvl
	 fFwKP6BNB2VTbNgmcW1A4rkpyIWQAMh6V9Tqs6mZa5lB8HYlKO9kSpnh7X2C/H9MXWH9u
	 w7BjZodOhS7edBUtNIk1BJXKfSoMFw/056k6SWE06zSFG5D9RWD7RIxZmj3BVLN8teEYO
	 7Qkxkkg5X45eb+4gax3+xqv67VU++4/dAO/4/rIRUB8zufqfd/YfaBuPfbjTDRv7/bLkp
	 KiC7QG+TB8Y0nLPSrZb1GebGv4ozHfe/1j1gL+WO9+kCwoTodma/gBgVhKDf0wpseQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IgxpfQAYfG5JY+eOry/tZfFGdIsADJfoB5MkUiWVmC0=;
	b=UXwOLG1qgZbV3oHFVCKuCfDK3ir+QhbPChroyKvQb+E5OsJYSGfaSMsSAemOn8uOn3ca
	 FIWjVAwrSO5vNdKx5Utlye7UjNeKl6B2066HnDVLqupjjYwexjizucq+u8UxiquBHpFOH
	 GvpV7wjYox1GF26bQtiNs6NkFdsXvtg8fVqVa7H/2NWtxMfSLYzTN8gSTH/yqqqofwjno
	 8KYnxT/nOK+YYRS1hUZoHunu5uZ9AIuFzIYMqFPRu9xfWAXJ8Chjq0d4fEOR9hqwG8+m5
	 VZ8uJjxrRV8NH5L/31oQrWisOxnlSlW57Fo0xsXne4crk9/JmOpUF+HJj6ps9jmy+qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9ln1cch;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F80606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9ln1cch
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640781F0093C;
	Wed, 11 Nov 2026 03:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368989;
	bh=IgxpfQAYfG5JY+eOry/tZfFGdIsADJfoB5MkUiWVmC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A9ln1cchkwAdk8aIsjeaYJf+yQ2/Y15NYMSQVmJMRvgbCrU3dUCf4U6p/0T3WuazT
	 lKidhQ9WEJFN+e2zNuR1O1fIYYerUKPdYM+Vu85qzozwHdYPXoRrAyl5un6aTWjzy6
	 lTjAKj8wCVMUNMmb5fyDGOJ4Em2kPEyePx6GO7LMfSk2JqlYzuCqgehWpkgXfhYkGk
	 Tx69B3gvuYMo9pRPJEwnMcACqq4W9bKc0cwKtP+1VGYdkSm4Xw0ayIxPQMJagO3hpH
	 daEhajGNNP2XhKNXB4VF1cG7EEDqrm+VLvNoCFGkC6HjXggkOavKgMBjpHBhetY6+G
	 Axv9xoRM4iKzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] media: qcom: camss: Propagate vfe_reset error up the callstack
Date: Tue, 10 Nov 2026 22:49:45 -0500
Message-ID: <20261111034941.1012493-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034941.1012493-1-sashal@kernel.org>
References: <20261107054314-failed-6.1-e5d4b0e69a40@kernel.org>
 <20261111034941.1012493-1-sashal@kernel.org>
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
index 3597788cc02fd..e333e4463433b 100644
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

