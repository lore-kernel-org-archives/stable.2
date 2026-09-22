Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9865678C8
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093024; cv=none; b=ombuN+3ZsykJr/wAgbK8Zk+Gv6t3wtlFNeKfr4kdGmLOvoHIc5mZbLppeO/V3O7Fh8QH/K1vyCc4hDvNUoQiLYNWK1mRcOE7KQkxSmYWzyCjxynBzBBNJVxobtZbyZCEkKmHUu8WTJvwnn4ju8GPzTE+zFhBtBSzDq/QNM9UoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093024; c=relaxed/simple;
	bh=hQZJ5ITtu7mmCIFxChx6eL3ixqdH47EDoygDNzp5gLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQhaSEzP6QgE6T89WTIJNECPVOCbo1j5z+Lj1dfUXNG9ZPWWfkGo8116i4Z7zGjqShyjtZInqNW3ZE4n1aPavD2AFVfJ5WVkVk0U24+pyV68t1Ffdhta0EJ1RxplrUFJm8oQi5n3KOFzJ66+5aslkLIdraLaErfcoUL54Qreekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KroaVk8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KroaVk8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09C61F0089B;
	Tue, 22 Sep 2026 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093015;
	bh=6YX7z+YMGGgc0+uU9l+cY0dm7Czg02f9Cs+Ba4svNrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KroaVk8vcX4SlRp8R4xnQMZ3YxnPXl59JBR89/HFwkAs/TX6rAALz67HYWuiPWQ9K
	 Tb9TF+Iu5t6gJ5Zqz+wrtll563zB3L9hya2ccwceNy/cok3t57798kLfpDfcBoT4ge
	 3sYcXnW2qTLqyyjYgQqrqjBZFkRzMFSGpnZBhb8yRw5I3QOnhq3N6uacHzSKr49qmu
	 dSvhCHUZ/H7GuqrF8LlugLw2Tdcog6DeGhfbc69TuUom20HQEAT2POmD+yJQf9BISE
	 yMjq+K7TtIK1r7yBdYQiN0sZuyiCzXNmA8yYWHGAohkcWf0veHrGZRdE3LJbWLcdWz
	 aSPJeE0zQWo8Q==
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
Subject: [PATCH 6.18.y 4/5] scsi: fnic: Bump up version number
Date: Tue, 22 Sep 2026 12:03:28 -0400
Message-ID: <20260922160329.2942693-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922160329.2942693-1-sashal@kernel.org>
References: <2026092249-remedial-elsewhere-96be@gregkh>
 <20260922160329.2942693-1-sashal@kernel.org>
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
index 5ceb6a596a46a..9da651410a73e 100644
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

