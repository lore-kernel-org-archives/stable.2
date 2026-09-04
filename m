Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA43B7771
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537534; cv=none; b=Xmpbb2/sYsNiaodN8UsCGBZWVtjHAvXLKhlM2wb4b47i/uPLPpNN/XeF7Q39f0cIbYLm5JG4ECoRjolZDSrG03tL0Q7/Jp0+Vcl3r3LaYSk/IbKQK8Qo3H0vO0gu79FrpT5RPqI3ogqxAZwPZ43CTpxKWCTPILTwrg6PB2Y3JqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537534; c=relaxed/simple;
	bh=dFhKZb+lBWWIiTLd8hfev1cL/TeHTEDjZiBh10KkoM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2Qr1z8kntkRiwVvfNoR//E50Lf0EjlOvmzjvmUc9Klsk+Blq9Z/ckWdhvaspqUoZCCxnzpaEkbbQWifEA2qRXa2laH2rmv+Z5PyjsruisLwPyh5Z60ikmbigWd2UABdA+cFpTZ+AYnlrPzkgAWLNZ0n5TP7Cx+US+PvV86qla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/hUHoIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/hUHoIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84061F00ADF;
	Fri,  4 Sep 2026 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537532;
	bh=pSeN5itAKiZn3Bax34Iklbrb61dwSzl3WAr35mXfiA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A/hUHoIffihq1MExusJw6v12tTJW4QuhRAw+zjmDdOIzp0u2V4hhKe49RZ6VEi6j9
	 1iBan0j72UEm6lcGt81lCkKGV81gXiUdCtiz3LKJP57YDSM40kbwo5S7iBiMggDFi1
	 xhpV5+IffrC9iJU1alGATm14U5dejQMysoX3LMKbBEhBoSH/hQhxSQDSOUlKg2dn26
	 qONCu6/rciSUO6r5muqGNdKWwAZw0LJGJtgf5hv3LmXTdb8i7Nl+U4R4ckM2QdkP9p
	 z8CKJfTcKH126Ze3kqhG/cFMYV+6quMmcf8bJlfp6KBtEhcHTNYKG33geou3oYsb0a
	 MQtrg0/OrxqJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] usb: typec: ucsi: inline ucsi_read_message_in
Date: Fri,  4 Sep 2026 11:58:44 -0400
Message-ID: <20260904155846.1071149-5-sashal@kernel.org>
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

[ Upstream commit e1870c17e550b7a114833e392f2e340117941b7f ]

There is no need to have a separate wrapper for reading MESSAGE_IN data,
inline it to ucsi_run_command().

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240627-ucsi-rework-interface-v4-5-289ddc6874c7@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: eb4573cf2fd8 ("usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index f689d292ec3a9..db45d3034aae0 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -36,19 +36,6 @@
  */
 #define UCSI_SWAP_TIMEOUT_MS	5000
 
-static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
-					  size_t buf_size)
-{
-	/*
-	 * Below UCSI 2.0, MESSAGE_IN was limited to 16 bytes. Truncate the
-	 * reads here.
-	 */
-	if (ucsi->version <= UCSI_VERSION_1_2)
-		buf_size = clamp(buf_size, 0, 16);
-
-	return ucsi->ops->read_message_in(ucsi, buf, buf_size);
-}
-
 static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 {
 	u64 ctrl;
@@ -70,6 +57,13 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 
 	*cci = 0;
 
+	/*
+	 * Below UCSI 2.0, MESSAGE_IN was limited to 16 bytes. Truncate the
+	 * reads here.
+	 */
+	if (ucsi->version <= UCSI_VERSION_1_2)
+		size = clamp(size, 0, 16);
+
 	ret = ucsi->ops->sync_control(ucsi, command);
 	if (ret)
 		return ret;
@@ -98,7 +92,7 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 	}
 
 	if (data) {
-		ret = ucsi_read_message_in(ucsi, data, size);
+		ret = ucsi->ops->read_message_in(ucsi, data, size);
 		if (ret)
 			return ret;
 	}
-- 
2.53.0

