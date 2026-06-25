Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6642E7621
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396532; cv=none; b=BjOBjhnsXlX4Gp2/q0bV4Wz4gl1g8SDwmravwZkcJJqIITK/oxjxKLmVeoJwbtypB+uFzwL88P/F9s7Y5F+g9LC7XKJvAmU/SVDgeqVQZ2es436wqHKtN7owDT5J2fjwzF6G02h2ndd+25x0HgA8GNH+pctEWH+X6Vx5u/5bVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396532; c=relaxed/simple;
	bh=MH/s96sNPlvn9lOYo2JR8nEAqdj6y5oThWWheCVl5Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlXPVQorjpK4ougFTxeVmj+tYMrQvbTi5mkN4xLIe4Yyi7dZ+a2dl3d5sswC2DVQ3xyZ+/iYeWquZ2aupnAiXj3otSJmJqbzavH4qG8EijS2InU5GxJoSj+dK+72m9nBwblzRHZzHl1SXv+9yKQvSYdmCenpNWxz6JOCr6D2vWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bns2wuKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bns2wuKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682DF1F000E9;
	Thu, 25 Jun 2026 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396530;
	bh=izaEyQ9E6T4Te/xl7KBDD6loNN0rnsTBNbmG60rRYoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bns2wuKGZAEkJaCaSr21jLoWqPxrFcMhBdq5CzUrTkNrq8iVIyhS61rCe1AO4CN5Z
	 PT2aGQFG9v00baQ+X/z25bo9I1/tjKTRMCCRQn0dhG3QzAtMGfL5k/JKPpKEHEzOqL
	 49c/f1tftpFNl5xQskUk9Y1N1EdHYVbchKLJ79krDjopL6HGW9t//xGe2E36+sell9
	 mntj7sJ7gY4iXoYaAFFpLmVedjkpffiw7iJQRIswZyuqwgpfLo2bYi1XEyYszu8qwm
	 XtwRJMWF8QQiZRt0CivJiMoV1rEkfenp9YoTXUBfPmo92q5FLGrYoBYRzEdu8KIjg5
	 Itx8gFkfi5C7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] crypto: qat - Replace kzalloc() + copy_from_user() with memdup_user()
Date: Thu, 25 Jun 2026 10:08:44 -0400
Message-ID: <20260625140846.2431963-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625140846.2431963-1-sashal@kernel.org>
References: <2026062532-unpaved-jujitsu-26c1@gregkh>
 <20260625140846.2431963-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 1e26339703e2afd397037defa798682b2b93dcc0 ]

Replace kzalloc() followed by copy_from_user() with memdup_user() to
improve and simplify adf_ctl_alloc_resources(). memdup_user() returns
either -ENOMEM or -EFAULT (instead of -EIO) if an error occurs.

Remove the unnecessary device id initialization, since memdup_user()
(like copy_from_user()) immediately overwrites it.

No functional changes intended other than returning the more idiomatic
error code -EFAULT.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: d237230728c5 ("crypto: qat - remove unused character device and IOCTLs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
index 70fa0f6497a968..b029420f9a310c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
@@ -94,17 +94,10 @@ static int adf_ctl_alloc_resources(struct adf_user_cfg_ctl_data **ctl_data,
 {
 	struct adf_user_cfg_ctl_data *cfg_data;
 
-	cfg_data = kzalloc(sizeof(*cfg_data), GFP_KERNEL);
-	if (!cfg_data)
-		return -ENOMEM;
-
-	/* Initialize device id to NO DEVICE as 0 is a valid device id */
-	cfg_data->device_id = ADF_CFG_NO_DEVICE;
-
-	if (copy_from_user(cfg_data, (void __user *)arg, sizeof(*cfg_data))) {
+	cfg_data = memdup_user((void __user *)arg, sizeof(*cfg_data));
+	if (IS_ERR(cfg_data)) {
 		pr_err("QAT: failed to copy from user cfg_data.\n");
-		kfree(cfg_data);
-		return -EIO;
+		return PTR_ERR(cfg_data);
 	}
 
 	*ctl_data = cfg_data;
-- 
2.53.0

