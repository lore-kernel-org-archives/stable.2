Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259284A5C4A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553943; cv=none; b=Cd5I9R6Tpoj5gkZN154UOqDrnoFxMIXXjU80O/RQGiyZxFkcJeWBPPiW6tJ3WCWQzBjoSCINN2lAOuXigMSHeXDgH3R8+LINnjmXfxfCti/LF5RRsac7yYd/P+lSt8vIyZl8QNq06pb/jjHuJRsLkDu/sYiexxEtSdChgIJYd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553943; c=relaxed/simple;
	bh=kOaMDtU8qs70jLyDD1X5VGLSnIQxoTe2KMaWCvzFKBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcOmMyzKh30oQ1UGRRskXMBBuY73k10RYT7WVq5PXKp+pshZuXqsdnC+QO6tx9vCPX3Vt10OP6MON5AyeQyUgzRb+MBwsU+wSdh89eSvG7rDxLDj7dLJsQeraipbjD3e8pdSzin2zeXDpAMVrc/kEp1bTKRnaZXfjWI9EU4cHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfM8HnKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfM8HnKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1F51F00ADE;
	Fri,  4 Sep 2026 20:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553930;
	bh=MtDHAI1QujWYtDU1/r70dkrINkaDWlIMV9IuDCtmWAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TfM8HnKxmBpcdjbwbWJpLFldtyibY2ARxF3ajp/7Co7HztTQM1Ppw2rb3999Ce9xX
	 UJ23W6JU2aPW3j1yBYJpckALsh7UnbanIOpkN+EwFrv77OhHuCjylZ3hiaY7Of6qK+
	 JZDZHxgTSFUQqPuy106qZfY6uDxCr3h/8H5SIGkTgj9R3ZXs+2TcX65Lxu2VSXda9l
	 YzzSEdQ91UeG5K7c9d0jP7hgFOM8mYi+SLp8Qpx5cgbtKC6qpujDf7ke7NpyugKNmW
	 PM1eXCRwXOLW3w0Wob4KeHAqRAWuFz3xORXmHD9j8c5G5P/fKcVZKwz27jKAnsbl2g
	 cagWzewvTh2aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huang Wei <huangwei@kylinos.cn>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion
Date: Fri,  4 Sep 2026 16:32:07 -0400
Message-ID: <20260904203207.1547529-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203207.1547529-1-sashal@kernel.org>
References: <2026090308-uneasy-legible-48cb@gregkh>
 <20260904203207.1547529-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Huang Wei <huangwei@kylinos.cn>

[ Upstream commit eb4573cf2fd860b20adfae050c3f6ec6ddc3abdb ]

The synchronous command completion path in ucsi_sync_control_common()
hardcodes a 5 second (5 * HZ) timeout when waiting for the PPM to signal
command completion via ACPI notification. This value matched
UCSI_TIMEOUT_MS when it was still 5000 ms, but it was not updated when
that macro was later raised to 10000 ms to fix PPM reset timeouts.

As a result, the two PPM communication paths are now inconsistent: the
polling path in ucsi_reset_ppm() respects the 10 second timeout, while
the event-driven completion path still uses 5 seconds. On machines where
the firmware is slow to respond during boot (e.g. some Lenovo ThinkPad
models such as the E14 Gen 7), commands sent after the PPM reset, such
as SET_NOTIFICATION_ENABLE and GET_CAPABILITY, can exceed 5 seconds and
cause UCSI initialization to fail with:

    ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed

Once UCSI init aborts, USB-C PD negotiation never completes, which in
turn blocks USB-C dock enumeration since the dock depends on a successful
PD contract.

Replace the hardcoded 5 * HZ with msecs_to_jiffies(UCSI_TIMEOUT_MS) so
that both communication paths share a single, consistent timeout value,
and future adjustments to UCSI_TIMEOUT_MS are picked up automatically.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221740
Link: https://bugzilla.kernel.org/show_bug.cgi?id=2183790
Fixes: bf4f9ae1cb08c ("usb: typec: ucsi: increase timeout for PPM reset operations")
Cc: stable@vger.kernel.org
Signed-off-by: Huang Wei <huangwei@kylinos.cn>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Fedor Pchelkin <boddah8794@gmail.com>
Link: https://patch.msgid.link/20260805085725.389761-1-huangwei@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 2fade504b6235..d3fbcec8e46a1 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -66,7 +66,8 @@ int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
 	if (ret)
 		goto out_clear_bit;
 
-	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
+	if (!wait_for_completion_timeout(&ucsi->complete,
+					 msecs_to_jiffies(UCSI_TIMEOUT_MS)))
 		ret = -ETIMEDOUT;
 
 out_clear_bit:
-- 
2.53.0

