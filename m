Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841163A4F5F
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324125; cv=none; b=sdMjRECqm+1bRUUThYwSP3jI56GpE+5olvFXjz+nuSpsLtOyYaHMiK3RbYg5Mbe2scD9ASTlEckX1YzW3DFWmwZ1TQ69yxRBK6a9xDxb0r8BSCb2I954B3635O78t/hZdayrTzvSjAU3ftJGFirrZW6ODQsWHSeLNASYxM7iRiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324125; c=relaxed/simple;
	bh=AbXhVcCd73fAAC58JhtFvSP0Bsn1GbJgoYS464W/nkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUqxHB1uVbvcSInQm7IwZELw9UMr8A42ugQxQxv/99aJtj8G7I6NLByvqpSMIKQqyAcvj32uZP9xxyJmlsQVTWmjZZN2Zqd8ScxUR6cru3Su0AXTK5mW2k/Pu+GpwviBOd0BQ2V2z2Dkpni64zrkbD6a98hBPoFh8TWOMgpczRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=irczHMkU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="irczHMkU"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-beb1bee8c16so257776566b.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780324122; x=1780928922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qgZZ2KjqH6+dykDseENzBvcCh7IAoqMA3tNRsz9qr8=;
        b=irczHMkUC7/OCVr5DE8M49rur/I8jbHqOwtkmZgd1/cvfDs/Yk6kdMy7PfyQY8DkFs
         LubOs+bazsXWZ4rHqI6HVWIWAnt1xXbyCBYkomfvFVA4el32mSyPCW60zFv62L2hgiQl
         V38XGEZPwNAna64i4x3Fjoae269fcLSeE/uCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324122; x=1780928922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qgZZ2KjqH6+dykDseENzBvcCh7IAoqMA3tNRsz9qr8=;
        b=sqgZSqy15Fsk6I8Xm+CvZi3KlidSc716kNM0QCxMVc5KftOfnCFk/hrG/a+jh8iwfp
         zPg6Z2QdJm+Omir1XoQB7AFY0rWi5x6wKxWt0e4Oko6EIqFvQjBU463opIC9ziJm5HNj
         7PSNcTC7HLfz6p24zmL6KoIN3cKXx8BtuZEN7fdPma6Q1Hn3xOFUCqXRm7aXppWWA79U
         EhvC/G1wvHIl8jlzN4gD1DkdaMFkh+CPMmdjyCkOM1Y3Lj3v11VZGXa7cJ8o62VNtC7n
         qXBgiG8XD9ltzib0olz0FLWf3541Q3LJCXWDZgoIf4tvuja5m3S8GNSHHj/clZeqBYlZ
         LemA==
X-Forwarded-Encrypted: i=1; AFNElJ8RebZT4D3jrUIFFPXWccFyCLdQlp/jJpphw4sShjcWTFKMDHCkX2uUgrKCt+2NKUT1HuPPb9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLGvAjev8tB3DZ4CSaPGRKz9PBzEEJUi5WBSR/4hlXq/2Mwok
	uFk87Wg+8WAPKliC3dEWMy1fRo+5Pm9AQkXb/GSB0x5ItoYV9oFbK8dZD02B1ljlgg==
X-Gm-Gg: Acq92OGK3ZYI/ncnViiQPffrAZnSyc7ZBbHgJQ2NlR2GgGZucOyw0rc48nsHDfq9BmF
	6sSkN6dSCyFVO6vcnfOFvlpV0Fx9bJwywKZnjfSmwRtg5rxWfQhfKcOwmgWGDtqKMPRGvCbMwv5
	Dldgpb3kJ2gPdbP1HeyY3zpnC37IWs/HTAsbyf60EPdknE1uPQMwtVmtmUioA1Uti4tHgMMLSyT
	HPbuwxYQXRxYkUVrWSmP6zliOSH73VwgglyH/CJe9++Ah4lWMSvmz607bQcdh8l+VD3cOB3ZHHh
	tUj0pi4WE+38ICm/9zmbU7aZ2uWbOIFlOYhcC1cAY1HenEztM//8N/ZZ6KMCoRoZNHllUJY9CaK
	2BhgKurJPBnC7FWK1/SDIKdgZrDabjwA3f3oPxh54/iu5BAyHqyZls1nMwccK77ueZtHoG4dPlU
	2qd1PUl6nywUXcrjuXLBT6uvJOJijwKtsaylDz1HJoXjShnPVI7qlg7UmktXuHkCeuMWSWudmvv
	56IGkH6U85cg1MxGYnfYJI5sfj9y5o=
X-Received: by 2002:a17:907:c16:b0:beb:f357:7755 with SMTP id a640c23a62f3a-bebf3579814mr370481766b.12.1780324121854;
        Mon, 01 Jun 2026 07:28:41 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (208.220.32.34.bc.googleusercontent.com. [34.32.220.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bee7bdf4438sm46562766b.55.2026.06.01.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:28:41 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Johan Hovold <johan@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Invert DisplayPort role assignment
Date: Mon,  1 Jun 2026 14:28:37 +0000
Message-ID: <20260601142837.3240207-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing implementation assigned these flags backwards, configuring
the partner's DisplayPort role to match the port's role instead of
complementing it.
This prevents proper configuration during DP altmode activation, often
causing `pin_assignment` to remain 0 in `dp_altmode_configure()` and
resulting in VDM negotiation failures:

    [  583.328246] typec port1.1: VDM 0xff01a150 failed

Additionally, the fix ensures that the `pin_assignment` sysfs attribute 
displays the correct values.

Cc: stable@vger.kernel.org
Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/ucsi/displayport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 8aae80b457d74..669f08013c7ab 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -166,12 +166,12 @@ static int ucsi_displayport_status_update(struct ucsi_dp *dp)
 	 * that Multi-function is preferred.
 	 */
 	if (DP_CAP_CAPABILITY(cap) & DP_CAP_UFP_D) {
-		dp->data.status |= DP_STATUS_CON_UFP_D;
+		dp->data.status |= DP_STATUS_CON_DFP_D;
 
 		if (DP_CAP_UFP_D_PIN_ASSIGN(cap) & BIT(DP_PIN_ASSIGN_D))
 			dp->data.status |= DP_STATUS_PREFER_MULTI_FUNC;
 	} else {
-		dp->data.status |= DP_STATUS_CON_DFP_D;
+		dp->data.status |= DP_STATUS_CON_UFP_D;
 
 		if (DP_CAP_DFP_D_PIN_ASSIGN(cap) & BIT(DP_PIN_ASSIGN_D))
 			dp->data.status |= DP_STATUS_PREFER_MULTI_FUNC;
-- 
2.54.0.823.g6e5bcc1fc9-goog

