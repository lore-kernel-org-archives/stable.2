Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F13911D6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090600; cv=none; b=dcCcRsiR2Jehvz3EWVb4wuAPyTWBkF0SliarUcOUfW9jM44RU9Hfyk0FGn9EH5TqwIClf3kGhnNasZ/9ElQDs6U1uOupvKMHS2S5cbADB9dfCZvdRM0OFLNj2OPb9xMAG4PBcYe47ZpdNQ0e0BLr3abohEbUDbrxkyE17ZgXnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090600; c=relaxed/simple;
	bh=4rOnmSPW3veVAvsOZmcxW9l74YVeeXwvm5LQWIQ3/3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFU1mYtfsFVX9qMUkJCXBOT8ZkG18mqyiGCDku749jdVF727sHBT4H8KUb7ZVO9gUlfb8NPf1nIolFW8kNVW3HYQ8677MaLMfWg8YhjC/3kbEuBwAoDiE6NSJk1eRoFcryPrWkTHpzjMaBPXufEg2uka4mIvljfbGqcq+TZJES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2Fd+JdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2Fd+JdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504EC1F00898;
	Tue, 22 Sep 2026 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090596;
	bh=Bp9EEPEuDi1txNvfX/+2qnMi2EYpC9V0J5OVsmCNTg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G2Fd+JdMzsi09BXyEdaWQ/LLv0r+cgM4gIMt6X9cPWGj+GxKA+KKuhdBl/XpAOjU/
	 obQ5z8AdoGRyWmCRuLQlBeGvf/FU7spn9tUti4w8xeFI40II7LPX1diZW9DdW6ISuW
	 Ncwe1R5d2b7R+BdQd9PsiVfh/xhrMKlxj2ESO8CgoR7PUxe7h2kHPCKlzMXno3qTLl
	 mvlSYQyn9UV+t+DzL9UOtOVgu9JJk+3G6Y7dKY6sxvevI+n+cInf+27xYcdBN8n8TI
	 QtuBjiYaZ7rCjmVVy+Qul5aR9wtw+f/OQdWL+OnkWcKBSMnJYiaoySx33njJkhjgCC
	 octZjxVKW2+Gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karan Tilak Kumar <kartilak@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Arulprabhu Ponnusamy <arulponn@cisco.com>,
	Gian Carlo Boffa <gcboffa@cisco.com>,
	Arun Easi <aeasi@cisco.com>,
	Hannes Reinecke <hare@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/3] scsi: fnic: Bump up version number
Date: Tue, 22 Sep 2026 11:23:11 -0400
Message-ID: <20260922152312.2801183-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922152312.2801183-1-sashal@kernel.org>
References: <2026092249-reminder-deed-f10e@gregkh>
 <20260922152312.2801183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karan Tilak Kumar <kartilak@cisco.com>

[ Upstream commit 2265541d221dc550dc89b52e49e9d9eb2f824996 ]

Bump up version number to 1.9.0.0.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Reviewed-by: Arun Easi <aeasi@cisco.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
Co-developed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260724174811.5118-14-kartilak@cisco.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 0cb1fd924126 ("scsi: fnic: Fix missed link-up when critical IRQ targets offline CPU")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fnic/fnic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index ad152fb4c15fa..b401c8afeb5e3 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -30,7 +30,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.8.0.3"
+#define DRV_VERSION		"1.9.0.0"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
-- 
2.53.0

