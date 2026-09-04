Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC13BD653
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546938; cv=none; b=DQvAgKTlTkXiOwPO9EIpXyUsPZp4cwufJtTBTCJUzRYYGNQW2eFm1RHdeFouy1mJkxGOpc4tpBK1k+EswxqSXkSKCtR2RJxzBqrD9kykvHZLy+gth3m9XFQxjSD/w4BZpBR6H3FsJjO4zsOoBKPiNGWXrONVkCl4FbPbHeOYQ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546938; c=relaxed/simple;
	bh=7smqHqCEoxG1H0EqEjrOa2jKJJ5uUBl6/cgeBuHv37c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dvkx7Fh3efZ0y59HQnjtkc1jDiL66uvG4QD+iIQFsuT9zxaoERa+7q721dN3tucD4OaqRZJdOvnobYgEBU4dNKNP2aKtLJnBf/lyChIcjiBg0QXAKF3oE3AOX9Kq18tBO56aSX7FOHwSUKM51a412eOOanPesxTespG+RTPb4Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThC++LJF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThC++LJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA381F00A3F;
	Fri,  4 Sep 2026 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546932;
	bh=mh3jOgouqV+NP26cE/Ary02Ci21vvqsuf+GL3keClAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ThC++LJFr7yTZpiK0/FAUCgqRtPGZQyeByJKIshLLxFNeFOqqUF9ARyZjIABoPonp
	 455B2ryqSYkkZufev9VdnCP+QliyjQYdBxDoaTT8Tfv+cnDuEnvdQnxjNrs44TvShv
	 G8huq3j9Z5oEPlhaB2lI1ryeILB3CA7zgenC5krAmoWUq3/TFcjh6mZ0eyfufQJKhx
	 k6jt3ejwuL5BuiGGvr/V1A9fZy7BkIqF4synNWBQ4eB51eCu5JHh4S51HqaoImI2GX
	 agANxhR69CETdg+aL6AwDax0d9n4zYLurAJJd4Ci2UK4Lpdg3UEkOmk17kkqQ1upgX
	 3VyJklQYR5kGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] usb: typec: ucsi: split read operation
Date: Fri,  4 Sep 2026 14:35:28 -0400
Message-ID: <20260904183529.1325058-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183529.1325058-1-sashal@kernel.org>
References: <2026090308-nutmeg-underpaid-017e@gregkh>
 <20260904183529.1325058-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 467399d989d799433ec7dd8da2ebbfbc70207d03 ]

The read operation is only used to read fixed data at fixed offsets
(UCSI_VERSION, UCSI_CCI, UCSI_MESSAGE_IN). In some cases drivers apply
offset-specific overrides. Split the read() operation into three
operations, read_version(), read_cci(), read_message_in().

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240627-ucsi-rework-interface-v4-3-289ddc6874c7@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The read split depends on newer UCSI callbacks that are not present in this
stable tree and is not needed by the dependent timeout fix. For the stable
backport, instead move the existing ACPI synchronous command handling into
the UCSI core while retaining the old callback interface. This places the
hard-coded completion timeout where the dependent fix expects it without
adding the unrelated read-operation wrappers.

[ sashal: Reduced backport -- upstream 467399d989d79 touches 7 file(s), this
  backport carries 3. Not backported here:
  drivers/usb/typec/ucsi/ucsi_ccg.c
  drivers/usb/typec/ucsi/ucsi_glink.c
  drivers/usb/typec/ucsi/ucsi_stm32g0.c
  drivers/usb/typec/ucsi/ucsi_yoga_c630.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: eb4573cf2fd8 ("usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c      | 29 +++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h      |  3 ++
 drivers/usb/typec/ucsi/ucsi_acpi.c | 51 ++++++------------------------
 3 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index fa0609cb7f6e6..dd4ce8723b225 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -36,6 +36,34 @@
  */
 #define UCSI_SWAP_TIMEOUT_MS	5000
 
+int ucsi_sync_control_common(struct ucsi *ucsi, unsigned int offset,
+			     const void *val, size_t val_len)
+{
+	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
+	int ret;
+
+	if (ack)
+		set_bit(ACK_PENDING, &ucsi->flags);
+	else
+		set_bit(COMMAND_PENDING, &ucsi->flags);
+
+	ret = ucsi->ops->async_write(ucsi, offset, val, val_len);
+	if (ret)
+		goto out_clear_bit;
+
+	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
+		ret = -ETIMEDOUT;
+
+out_clear_bit:
+	if (ack)
+		clear_bit(ACK_PENDING, &ucsi->flags);
+	else
+		clear_bit(COMMAND_PENDING, &ucsi->flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ucsi_sync_control_common);
+
 static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 {
 	u64 ctrl;
@@ -1541,6 +1569,7 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 	INIT_WORK(&ucsi->resume_work, ucsi_resume_work);
 	INIT_DELAYED_WORK(&ucsi->work, ucsi_init_work);
 	mutex_init(&ucsi->ppm_lock);
+	init_completion(&ucsi->complete);
 	ucsi->dev = dev;
 	ucsi->ops = ops;
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index cee43f19adf5d..c78b29affeead 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -67,6 +67,8 @@ bool ucsi_con_mutex_lock(struct ucsi_connector *con);
 void ucsi_con_mutex_unlock(struct ucsi_connector *con);
 
 void ucsi_connector_change(struct ucsi *ucsi, u8 num);
+int ucsi_sync_control_common(struct ucsi *ucsi, unsigned int offset,
+			     const void *val, size_t val_len);
 
 /* -------------------------------------------------------------------------- */
 
@@ -308,6 +310,7 @@ struct ucsi {
 #define EVENT_PENDING	0
 #define COMMAND_PENDING	1
 #define ACK_PENDING	2
+	struct completion complete;
 };
 
 #define UCSI_MAX_SVID		5
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 03c820fe5b0c4..7ed5eb9801b75 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -21,11 +21,8 @@ struct ucsi_acpi {
 	struct device *dev;
 	struct ucsi *ucsi;
 	void *base;
-	struct completion complete;
 	unsigned long flags;
 #define UCSI_ACPI_SUPPRESS_EVENT	0
-#define UCSI_ACPI_COMMAND_PENDING	1
-#define UCSI_ACPI_ACK_PENDING		2
 	guid_t guid;
 	u64 cmd;
 };
@@ -72,37 +69,9 @@ static int ucsi_acpi_async_write(struct ucsi *ucsi, unsigned int offset,
 	return ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_WRITE);
 }
 
-static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
-				const void *val, size_t val_len)
-{
-	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
-	int ret;
-
-	if (ack)
-		set_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
-	else
-		set_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
-
-	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
-	if (ret)
-		goto out_clear_bit;
-
-	if (!wait_for_completion_timeout(&ua->complete, 5 * HZ))
-		ret = -ETIMEDOUT;
-
-out_clear_bit:
-	if (ack)
-		clear_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
-	else
-		clear_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
-
-	return ret;
-}
-
 static const struct ucsi_operations ucsi_acpi_ops = {
 	.read = ucsi_acpi_read,
-	.sync_write = ucsi_acpi_sync_write,
+	.sync_write = ucsi_sync_control_common,
 	.async_write = ucsi_acpi_async_write
 };
 
@@ -125,7 +94,7 @@ ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_
 
 static const struct ucsi_operations ucsi_zenbook_ops = {
 	.read = ucsi_zenbook_read,
-	.sync_write = ucsi_acpi_sync_write,
+	.sync_write = ucsi_sync_control_common,
 	.async_write = ucsi_acpi_async_write
 };
 
@@ -155,15 +124,15 @@ ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
 		 * still report the very event that the core is trying to clear.
 		 */
 		set_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
-		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &dummycmd,
-					   sizeof(dummycmd));
+		ret = ucsi_sync_control_common(ucsi, UCSI_CONTROL, &dummycmd,
+					       sizeof(dummycmd));
 		clear_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
 
 		if (ret < 0)
 			return ret;
 	}
 
-	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
+	return ucsi_sync_control_common(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
 }
 
 static const struct ucsi_operations ucsi_dell_ops = {
@@ -203,11 +172,12 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	    !test_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags))
 		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
-		complete(&ua->complete);
+	if (cci & UCSI_CCI_ACK_COMPLETE &&
+	    test_bit(ACK_PENDING, &ua->ucsi->flags))
+		complete(&ua->ucsi->complete);
 	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
-	    test_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags))
-		complete(&ua->complete);
+	    test_bit(COMMAND_PENDING, &ua->ucsi->flags))
+		complete(&ua->ucsi->complete);
 }
 
 static int ucsi_acpi_probe(struct platform_device *pdev)
@@ -241,7 +211,6 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	init_completion(&ua->complete);
 	ua->dev = &pdev->dev;
 
 	id = dmi_first_match(ucsi_acpi_quirks);
-- 
2.53.0

