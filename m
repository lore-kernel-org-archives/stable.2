Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1DF51FCCF
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546941; cv=none; b=q96jZUsf43zhISmfxmoxGOeF8R+NJ30T+DSDZEUF5ro/LL4TcTZNF3FXM0Hh7vym3josqTfwda1PIXWeSKZyUWwPg2P/pXnCGzg3BiQ9kI5NwdhmboVGqrRBkUlM0wwXSw2/O8NmX8mkr5Ab/pjIiSkZ0m4aybzsWsGxa6xhjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546941; c=relaxed/simple;
	bh=7A2ucc0fsyO7Ogb1ABTkQpJiOnhfNJ32AUNXRKSGJxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBJVbStFSbtV60kO5rROMAF7VCY2c+CZd5RmDSVvTMQmqRQC3mqSi5KKOl9PnqLt5H4fc5PTtCeUOK3lRt4ru5+PwjhS40Qd+nF1cL7M9CZnw2gFyj1rFC5zFobXcm7ece6ThZkfC/p3FPooi5Oz67tZGofO0jRNhfDeTU+Wm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nON6ExfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nON6ExfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB3B1F00A3D;
	Fri,  4 Sep 2026 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546931;
	bh=Q6+OFvQhIN+mIrNmZ/Ye3YgBHatwb7c23Lkk+BFQVsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nON6ExfMMzxs6vIUeosMErFXHfXvqCUp0PDDDaHyh+9bfkPkl0rEwUgteNDT8ajRf
	 tBSGZowBiAFAfM0yVG4UIkDHYhB/PNdSLQEHl3LE5YhQZLT0wqmQVQFQ17UuTWmg9W
	 3akJUDG+tv5kyNTeT82Guuhror/aXX6JVhRcxwER1pN2L0pFsJuK9ZnNCF+YFqE01i
	 N+CH8ZYwtV2WmqGtMPl6e+vlmLde5kZTyXv8xNcvf5SvkJI7TAh9lIZZnKmos0rEE8
	 sYDac9gM22ZvS1GC6RumsglxY7CH7DXxyReYS6fU8L0rVfFOAR5IeOKgEdohVwvQSs
	 +nb5pCL3aX5Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] usb: typec: ucsi: move ucsi_acknowledge() from ucsi_read_error()
Date: Fri,  4 Sep 2026 14:35:27 -0400
Message-ID: <20260904183529.1325058-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090308-nutmeg-underpaid-017e@gregkh>
References: <2026090308-nutmeg-underpaid-017e@gregkh>
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
index b4703ce862120..fa0609cb7f6e6 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -57,11 +57,6 @@ static int ucsi_read_error(struct ucsi *ucsi)
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
@@ -140,13 +135,14 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
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

