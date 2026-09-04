Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AC4CC27E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537530; cv=none; b=uJ5Ive6AI4GfnMfKmBRZnXaHyYlZzM8+P+NNiwBvPsX7VOTmz8EA+ji4fpJHEV839WYgxQtozqf4B8frZVbEVkzBnVC3WuT12bqiRuVKcj655hf9qzRT/wfXLugtg4kGTpeOH0kqhvsMpq1hBU/cCu2Jj69aBG4l+mFGezxKx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537530; c=relaxed/simple;
	bh=gNYe8WpJlYxjwHmCGtGWwK/Gotg8voaqjdDyK2fF1Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlG0VcyCEx/NBEYN4OV6uSPwasNbSkm+1KxdcOxNf51O6ojMt6CqtCNKhubfUaPdSmYOF3wcsW9op26+cUWlsIpoKVI23EhZ1p2bybDwb5ClybYfCGjHwidBC3yWUbzfVHX3zpi6gLYnTpP2V08LfzsZqmtWXpbBOm8m2COeE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0tDRVCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0tDRVCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328961F00A3D;
	Fri,  4 Sep 2026 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537528;
	bh=twzyJBbT4/SBfKcOB1N5Li4kkT+xzVRkYiANx/6hABM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X0tDRVCv1/IsfET/7SGEjlDQtK2HeLXiigQs5mdZH9SEFSsfWlg2lMC+gmqi6YgcG
	 sQuYiQ3tlroeQrbcnFOwK14JxK2dLrhsvmMVU0KZvvMlTwVgLRKtlCPic0722oO8um
	 QwQ5CyKuIrzUe65soZeYpINXkReTm9fQiUiBbE7BTouaJJMcB45QdXvwupq6KnY/Ph
	 j2VrDbVtpyiuT2A29G4Cf9v5VrrJ5uEJIDAJcx9/2xb6ykFKv9cYUQVMSFWY5q9oY+
	 /8UPqMYl3YEHLNxvkzBshFeZwneBB54JO/1bbRkJj4tFrfQ14rcpQtBcd8eu4EBgDf
	 FcmuRB+isqBsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/7] usb: typec: ucsi: move ucsi_acknowledge() from ucsi_read_error()
Date: Fri,  4 Sep 2026 11:58:40 -0400
Message-ID: <20260904155846.1071149-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090307-cannot-posh-1230@gregkh>
References: <2026090307-cannot-posh-1230@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit a7d2fa776976294d39d4cf36b25ca43be8325c3f ]

As a preparation for reworking UCSI command handling, move
ucsi_acknowledge() for the failed command from ucsi_read_error() to
ucsi_exec_command().

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240627-ucsi-rework-interface-v4-1-289ddc6874c7@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: eb4573cf2fd8 ("usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index b0d5f071664fe..37c6d7d7c46ae 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -70,11 +70,6 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	u16 error;
 	int ret;
 
-	/* Acknowledge the command that failed */
-	ret = ucsi_acknowledge(ucsi, false);
-	if (ret)
-		return ret;
-
 	ret = ucsi_exec_command(ucsi, UCSI_GET_ERROR_STATUS);
 	if (ret < 0)
 		return ret;
@@ -153,13 +148,14 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	}
 
 	if (cci & UCSI_CCI_ERROR) {
-		if (cmd == UCSI_GET_ERROR_STATUS) {
-			ret = ucsi_acknowledge(ucsi, false);
-			if (ret)
-				return ret;
+		/* Acknowledge the command that failed */
+		ret = ucsi_acknowledge(ucsi, false);
+		if (ret)
+			return ret;
 
+		if (cmd == UCSI_GET_ERROR_STATUS)
 			return -EIO;
-		}
+
 		return ucsi_read_error(ucsi);
 	}
 
-- 
2.53.0

