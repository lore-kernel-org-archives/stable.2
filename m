Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62BD4F55B7
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537533; cv=none; b=WFp0YemmgWxmxh4fHvi+EQCjFuWz1gb42WkcNPBBvwgxB7AsPUqqqvUA4QFxRVKH3CS+lzPzWO81dBkNFbo8oQJE4cwfpmEEvR0G9HV+Yf0fwQ+fxtSMJIIiiQpz/aR6MAfiif1X3vB6JD5v+sZ06OAvPPoEAOA1hDCFwTsTWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537533; c=relaxed/simple;
	bh=GxvdFX01QAPGmY4ahmpvvTA/8eSbcfPxxy4MZ0xPaeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0ifJAq97msVPR9Y/aPJQaoKFpMyX7/RMeR4l0oXzH+O0EAYvju1/wbXGD3eck2DSPClFQxOhvXZULIT8qWMP6l8uDwQcYaWv5EJkak8PHO+09kMJiQX5/f1sFmCLAV4XKZrANCJF3/XUd9t9CYU/YQ4wEItmiN18lpNeQJbDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iamidKnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iamidKnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CB91F00ACA;
	Fri,  4 Sep 2026 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537531;
	bh=pQsIPEULZIW9cRbbnWu+/Pj0oV2bOa9tJlCidwmrHQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iamidKnryf5mjVm7aazmpo45TM0FM4RIeIop+ZEhNZczq8bR1v2sspQlSiDCP6YJn
	 kW14vzwnVblogb9yt82cF00e+L1ivG5xEAFi1Cg6nQF2NinDjuid7znRZfpNfj2nwB
	 uqiVLwn/4G0//5uPna/0vHKkKpCqN3+/Jve356XCOACme6zu8RPk8CldwvSeLwtw37
	 vkKn/ph31rpf98baY/icFYBT7InbcclpMnhPIRDqFs+gLGuc2oFoIJ1oR+kuewt+uY
	 8C1f5JRBo7my55xfKw+jSiHWqBqX0oGiQ4NhksqLmQW0v8YlVTTxnUJdGoup7S3ZuS
	 OipvXZ21SdA/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/7] usb: typec: ucsi: rework command execution functions
Date: Fri,  4 Sep 2026 11:58:43 -0400
Message-ID: <20260904155846.1071149-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155846.1071149-1-sashal@kernel.org>
References: <2026090307-cannot-posh-1230@gregkh>
 <20260904155846.1071149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 5e9c1662a89b1d5dc3042d8a2f1614bd8124ded5 ]

Rework command execution code to remove recursive calls of
ucsi_exec_command. This also streamlines the sync_control / read(CCI)
read (MESSAGE_IN) sequence, allowing further rework of the command code.

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240627-ucsi-rework-interface-v4-4-289ddc6874c7@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: eb4573cf2fd8 ("usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 137 ++++++++++++++++------------------
 1 file changed, 64 insertions(+), 73 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 56ddedb6a44aa..f689d292ec3a9 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -63,25 +63,74 @@ static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 	return ucsi->ops->sync_control(ucsi, ctrl);
 }
 
-static int ucsi_exec_command(struct ucsi *ucsi, u64 command);
-
-static int ucsi_read_error(struct ucsi *ucsi)
+static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
+			    void *data, size_t size, bool conn_ack)
 {
-	u16 error;
 	int ret;
 
-	ret = ucsi_exec_command(ucsi, UCSI_GET_ERROR_STATUS);
-	if (ret < 0)
+	*cci = 0;
+
+	ret = ucsi->ops->sync_control(ucsi, command);
+	if (ret)
 		return ret;
 
-	ret = ucsi_read_message_in(ucsi, &error, sizeof(error));
+	ret = ucsi->ops->read_cci(ucsi, cci);
 	if (ret)
 		return ret;
 
-	ret = ucsi_acknowledge(ucsi, false);
+	if (*cci & UCSI_CCI_BUSY)
+		return -EBUSY;
+
+	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
+		return -EIO;
+
+	if (*cci & UCSI_CCI_NOT_SUPPORTED) {
+		if (ucsi_acknowledge(ucsi, false) < 0)
+			dev_err(ucsi->dev,
+				"ACK of unsupported command failed\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (*cci & UCSI_CCI_ERROR) {
+		/* Acknowledge the command that failed */
+		ret = ucsi_acknowledge(ucsi, false);
+		return ret ? ret : -EIO;
+	}
+
+	if (data) {
+		ret = ucsi_read_message_in(ucsi, data, size);
+		if (ret)
+			return ret;
+	}
+
+	ret = ucsi_acknowledge(ucsi, conn_ack);
 	if (ret)
 		return ret;
 
+	return UCSI_CCI_LENGTH(*cci);
+}
+
+static int ucsi_read_error(struct ucsi *ucsi)
+{
+	u16 error;
+	u32 cci;
+	int ret;
+
+	ret = ucsi_run_command(ucsi, UCSI_GET_ERROR_STATUS, &cci,
+			       &error, sizeof(error), false);
+
+	if (cci & UCSI_CCI_BUSY) {
+		ret = ucsi_run_command(ucsi, UCSI_CANCEL, &cci, NULL, 0, false);
+
+		return ret ? ret : -EBUSY;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	if (cci & UCSI_CCI_ERROR)
+		return -EIO;
+
 	switch (error) {
 	case UCSI_ERROR_INCOMPATIBLE_PARTNER:
 		return -EOPNOTSUPP;
@@ -121,78 +170,20 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	return -EIO;
 }
 
-static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
-{
-	u32 cci;
-	int ret;
-
-	ret = ucsi->ops->sync_control(ucsi, cmd);
-	if (ret)
-		return ret;
-
-	ret = ucsi->ops->read_cci(ucsi, &cci);
-	if (ret)
-		return ret;
-
-	if (cmd != UCSI_CANCEL && cci & UCSI_CCI_BUSY)
-		return ucsi_exec_command(ucsi, UCSI_CANCEL);
-
-	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
-		return -EIO;
-
-	if (cci & UCSI_CCI_NOT_SUPPORTED) {
-		if (ucsi_acknowledge(ucsi, false) < 0)
-			dev_err(ucsi->dev,
-				"ACK of unsupported command failed\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (cci & UCSI_CCI_ERROR) {
-		/* Acknowledge the command that failed */
-		ret = ucsi_acknowledge(ucsi, false);
-		if (ret)
-			return ret;
-
-		if (cmd == UCSI_GET_ERROR_STATUS)
-			return -EIO;
-
-		return ucsi_read_error(ucsi);
-	}
-
-	if (cmd == UCSI_CANCEL && cci & UCSI_CCI_CANCEL_COMPLETE) {
-		ret = ucsi_acknowledge(ucsi, false);
-		return ret ? ret : -EBUSY;
-	}
-
-	return UCSI_CCI_LENGTH(cci);
-}
-
-static int ucsi_send_command_common(struct ucsi *ucsi, u64 command,
+static int ucsi_send_command_common(struct ucsi *ucsi, u64 cmd,
 				    void *data, size_t size, bool conn_ack)
 {
-	u8 length;
+	u32 cci;
 	int ret;
 
 	mutex_lock(&ucsi->ppm_lock);
 
-	ret = ucsi_exec_command(ucsi, command);
-	if (ret < 0)
-		goto out;
-
-	length = ret;
+	ret = ucsi_run_command(ucsi, cmd, &cci, data, size, conn_ack);
+	if (cci & UCSI_CCI_BUSY)
+		ret = ucsi_run_command(ucsi, UCSI_CANCEL, &cci, NULL, 0, false) ?: -EBUSY;
+	else if (cci & UCSI_CCI_ERROR)
+		ret = ucsi_read_error(ucsi);
 
-	if (data) {
-		ret = ucsi_read_message_in(ucsi, data, size);
-		if (ret)
-			goto out;
-	}
-
-	ret = ucsi_acknowledge(ucsi, conn_ack);
-	if (ret)
-		goto out;
-
-	ret = length;
-out:
 	mutex_unlock(&ucsi->ppm_lock);
 	return ret;
 }
-- 
2.53.0

