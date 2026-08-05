Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF473C062C;
	Wed,  5 Aug 2026 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920262; cv=none; b=cicjPCPuP4ePFTNk9n+tSqN4XPu/NheKfBrODypnQnds0yvmiU+3HkxaDdhx6KTjCRSZZC0ktntUgiQR05MnsrxQ7oPnMqKIfASxwISCotiH9SoN49Z9IgkLk6OUV5kzw635mtc/EFOp0Q0vnQYHo+LleJa7GxAReQOwo0bvhLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920262; c=relaxed/simple;
	bh=bnMPh1m4dcOLE2/1Njkj44YOx8CqEmaf3C3/hzUEbrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YjwM3NWxG3UMa/dQuSB8kJ9PoADuOsdVXH4KbCRs2a+/A5EsQBXrImy9tfrAzjivdDTWn2VaaRx6skYNEiJEiJm2vaPNWYDfUhGAM+CVJMPClYDR9wEp6rTQisOF4hezH3kw4YmM8Ap83sR+IyfIuEnOUWiBqzxfaln7sSn6x00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: af75588a90ab11f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ebed00ad-3635-4fa3-ab01-94a2a9b225f3,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:f65d137e80cbdbe83eec97128c29acdb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: af75588a90ab11f1aa26b74ffac11d73-20260805
X-User: huangwei@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huangwei@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1407271787; Wed, 05 Aug 2026 16:57:28 +0800
From: Huang Wei <huangwei@kylinos.cn>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Wei <huangwei@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion
Date: Wed,  5 Aug 2026 16:57:25 +0800
Message-Id: <20260805085725.389761-1-huangwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/usb/typec/ucsi/ucsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index d221ca9bc88e..37fa20b302ba 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -91,7 +91,8 @@ int ucsi_sync_control_common(struct ucsi *ucsi, u64 command, u32 *cci,
 	if (ret)
 		goto out_clear_bit;
 
-	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
+	if (!wait_for_completion_timeout(&ucsi->complete,
+					 msecs_to_jiffies(UCSI_TIMEOUT_MS)))
 		ret = -ETIMEDOUT;
 
 out_clear_bit:
-- 
2.25.1

