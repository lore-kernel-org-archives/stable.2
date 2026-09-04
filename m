Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9351FCB6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546939; cv=none; b=Gnza6+eEDLZNMBz2yiuPLVJ5KDEj/teQ5sKEYd7D2+wZzSHH11nT/H2wg5U8GskLYOfntr7AcvDYhL0cpmtT8xLsZR3jIAXbBVB/apFKeBcF1d37fITMzysr5+Y7WiKuo3GIubEZ1vFPEUDZ1m12nzXfoBM/R2iBdTcxa97qy88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546939; c=relaxed/simple;
	bh=4THXh1bjAhfGCcS9aNWcFLwmqKEyzgQwy4H047xKL+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWIu55yQ3ZtvIVsirCDqMnTZj2voOTX1bkVIDQbMTDCShrrn8jXXTxsrFSJyVsCS5nV7xUAxNaEnSe4AZf7RXpVQ8qA/+CcgC/QhUJ4wlmevsZOBJATeY+zCCCxVqrUquSfoFMv2RHRK6Pacm6boAPfToJCmHhy8e6KARi0VPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmdiyQbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmdiyQbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34BC1F00ACA;
	Fri,  4 Sep 2026 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546933;
	bh=IpL7gULiRDDAChC7oZZY5S+ziSanjAnENrCFvnn4ssU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dmdiyQbMsj2wXJFFVRSUKtnpaTTtywjSv4c2ah7gijg4EItQthFEGrH9n22Y79cfT
	 JeaUWk4uBxRbZwyXw8bvVnSJPEtGFGDkARELvydPC3y4YraAugBVXy6EcIPafrz/IV
	 447xOqqZ4c0hBSEv6pRqr+erRtGnmkz2VpQRDc40IoFM+OaKgcGeMB5uUaZFKz5fLJ
	 L9NjDcV7g1vcyzxz+96u3UGGU4K/thzhZkk9PrF/alpEqZp69rxea0Hd9VjJq853ay
	 maMiIr/ohxSGbNout3/ptmtmbcONWR/z61IitAjIcYoMbKq8WTafcFb1MrfsM6E+QB
	 gZJs+eGFCqy7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huang Wei <huangwei@kylinos.cn>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion
Date: Fri,  4 Sep 2026 14:35:29 -0400
Message-ID: <20260904183529.1325058-3-sashal@kernel.org>
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
index dd4ce8723b225..7340675883ad5 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -51,7 +51,8 @@ int ucsi_sync_control_common(struct ucsi *ucsi, unsigned int offset,
 	if (ret)
 		goto out_clear_bit;
 
-	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
+	if (!wait_for_completion_timeout(&ucsi->complete,
+					 msecs_to_jiffies(UCSI_TIMEOUT_MS)))
 		ret = -ETIMEDOUT;
 
 out_clear_bit:
-- 
2.53.0

