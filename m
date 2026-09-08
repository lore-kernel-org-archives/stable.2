Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DA577E2E;
	Tue,  8 Sep 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882867; cv=none; b=eb9dBXqlzkoeBq98mlGAb+lvacLvH3fgfxk8tRlESq4RY61mfXIEYb3gfc5ralIMZUTjcIHId/xFRMx8uCWJQd8oqjgRYNW3GinIxBmrSzOK6vFAgxjvnHtu4C0vj8lNZHaACawCYf1hs7u7CQAFW/aDcEItv0FMBr5ftIIU2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882867; c=relaxed/simple;
	bh=WLZF4ujfdR+E7R4JQmpFaDaz0BbpV+afU5uwMPHuUuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5rST5qYC6vzrv77T+q+/YDFd+nC2PhTOzH8ndM9sh2B1GvH6wc7XjAgVDiM2yXjQ2qi7ejcp1rI8bgCDGGPLJiPY3QUZbHV3dDvHSxVRbZ5hSXHv8oy3gakfDNEeDGOvEmT+5025IU7w5lkMG9cSqqeq8rxMlLZkItLdBS6eWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Ce2ACI4k; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Ce2ACI4k; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Ce2ACI4k";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Ce2ACI4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882856; bh=WLZF4ujfdR+E7R4JQmpFaDaz0BbpV+afU5uwMPHuUuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ce2ACI4k/rWIgoYi/hnb0d5qSZfvs2Tlxkry+NXBEdZTAAEdQ+Jd/eRNP5I66w//d
	 nX0+XZKpDOXZb37iZXG3JP7P+CJqNoGPeN/xpiM6m1EbvA+/mv+9V1lcjti9IPElel
	 oFtzJk6LHD/RAu5DCX/iqFWCi63xe1N2CPqcOj5Ms60bhxUxK2j6IH0JhV125Uz9TK
	 +0PE8JT8yDgBa3r1EkWtjZlRhPX9tuEbGz8/tPHAme4M1gXT/6IqVBnVuefNhUNye4
	 j7G3F58kWtpX+6phN+5an7Z3JTViUFzef/+Ra/LttFeucgip8lfF1chL2Rz7zoJmR6
	 C+s6kkgNaIiDA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id EFD3041471; Tue, 08 Sep 2026 16:54:16 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882856; bh=WLZF4ujfdR+E7R4JQmpFaDaz0BbpV+afU5uwMPHuUuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ce2ACI4k/rWIgoYi/hnb0d5qSZfvs2Tlxkry+NXBEdZTAAEdQ+Jd/eRNP5I66w//d
	 nX0+XZKpDOXZb37iZXG3JP7P+CJqNoGPeN/xpiM6m1EbvA+/mv+9V1lcjti9IPElel
	 oFtzJk6LHD/RAu5DCX/iqFWCi63xe1N2CPqcOj5Ms60bhxUxK2j6IH0JhV125Uz9TK
	 +0PE8JT8yDgBa3r1EkWtjZlRhPX9tuEbGz8/tPHAme4M1gXT/6IqVBnVuefNhUNye4
	 j7G3F58kWtpX+6phN+5an7Z3JTViUFzef/+Ra/LttFeucgip8lfF1chL2Rz7zoJmR6
	 C+s6kkgNaIiDA==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 662DE4146D;
	Tue, 08 Sep 2026 16:54:16 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/19] media: serial_ir: Fix race condition where timer can be re-armed
Date: Tue,  8 Sep 2026 16:52:03 +0100
Message-ID: <23c97b39255ecf4ce4ee1f8cc77b76b0f9e9870e.1788882189.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788882189.git.sean@mess.org>
References: <cover.1788882189.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the timer cannot be re-armed.

Fixes: 2940c7e49775 ("[media] serial_ir: generate timeout")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/serial_ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index 992fff82b524..f6702b3df9a0 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -798,7 +798,7 @@ static int __init serial_ir_init_module(void)
 
 static void __exit serial_ir_exit_module(void)
 {
-	timer_delete_sync(&serial_ir.timeout_timer);
+	timer_shutdown_sync(&serial_ir.timeout_timer);
 	serial_ir_exit();
 }
 
-- 
2.55.0

