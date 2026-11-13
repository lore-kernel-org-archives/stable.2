Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601192;
	b=i7ZHxNA+fGX7m40PobZHcdW7zDlLKuncgWIPTTxiRYIiIRLYMYYfkZtmg0rLm+aaQYQK
	 lRI490k9d0SyGYBQkKq3rMr7eXs4tVyhuf68hAp0c6826Yb/W8QjHOlwrCa1k2Cw3yCio
	 dIkCuMm7krA66m5KtezBWhOx3DNU7XaG7QNR8eoDFSaJQof2+d739sAmllYeS3p03g7rM
	 x47HipY7goJhM2qhuv6u5uaEARMEE4i4pnQSitHIjBTVYFF+3xP4sSGPYbO3syhvTBrDV
	 WjvbBs8feDkjVDQ9bv4fykX4OIA2MV0YjupbcZTU7oIto3ZkG+dvyeHUhHOrwynbTTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601192;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=AzCrmtgJvnx68leHyyaS6Vl9kEi+cLVWz3k7UVid4QI=;
	b=a5gCcu7SA8CmLTmAKhmup2e74ajAvomBykVqnyez/mR/WaznNiZdRi4UlsDjz8eAy7Eo
	 zvqpPq4BMUXzZLFQtF9dDN1aUuxkFrjtpiYw0m5ucM6AbU24rkVuMW49LiQt8uI6DURSm
	 e6Oftl6YYu3kIECLgO19vBmQOX7XJZbzImX6f5R12gKi1gsHOAuaGywP44FnXNH8+/YKv
	 WizwaKl0DMDuARxK3gR6V01rAYkxEuMa0FyO+JkMeA9swZgggr4pqIR/wItp1OauV4aQA
	 hcTY+btyQCZtyxsxiojNIAdlyaEkYHT4A8udTUaPEZCu52kReIMgEXfx1azqtD6lyvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=DlS3J0QL;
	arc=none smtp.remote-ip=185.136.64.228
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A76606A337
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A76606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=DlS3J0QL
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20261113201940f89cc4acd40002078b
        for <stable@vger.kernel.org>;
        Fri, 13 Nov 2026 21:19:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AzCrmtgJvnx68leHyyaS6Vl9kEi+cLVWz3k7UVid4QI=;
 b=DlS3J0QL9rg184nKTwozO15R39YojUzbZuCd10cJ55QyjNF5L4+2T4yIzGhiHak2vd6Kmj
 LCzH26gAcACQCzbMvgX1yAsk9DxDhLKZSkWPQMqWtGJp0oCILex7prVlwWRucGwSn96tN70k
 vqDWk5tsGYvSQkmJ/YKJyVw1BhCeOPH0xjXbTjUFlGvVzR8KIHMGXY5JzLjQRdVxj/CUYzjG
 q7H7YeneDAftFdKLYCqBYqCVi8oWdNjFwOdvR2DFxZRfjXkisTC/kK6njMrH0zv/Fe7lWhOL
 2Qx9ubBZY+WaS2THCsFzYXpkaz7cA6vNDpeTAqLUWfjpsLUS+/MMrLfw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-leds@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 3/3] leds: trigger: netdev: Report invalid interval to user space
Date: Fri, 13 Nov 2026 21:19:32 +0100
Message-ID: <20261113201936.2645736-4-alexander.sverdlin@siemens.com>
In-Reply-To: <20261113201936.2645736-1-alexander.sverdlin@siemens.com>
References: <20261113201936.2645736-1-alexander.sverdlin@siemens.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

interval_store() silently accepts out-of-range values: a write outside
the [5, 10000] ms bounds returns the full count as if it succeeded, yet
the interval is left unchanged.

Reject out-of-range values with -EINVAL instead.

Cc: stable@vger.kernel.org
Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v7:
- rebased onto for-leds-next as of 687615faae92
v6:
- patch introduced

 drivers/leds/trigger/ledtrig-netdev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 601c4d9e0198a..870b374fd9c48 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -509,6 +509,10 @@ static ssize_t interval_store(struct device *dev,
 	if (ret)
 		return ret;
 
+	/* impose some basic bounds on the timer interval */
+	if (value < 5 || value > 10000)
+		return -EINVAL;
+
 	mutex_lock(&trigger_data->lock);
 
 	if (trigger_data->hw_control) {
@@ -516,13 +520,10 @@ static ssize_t interval_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	/* impose some basic bounds on the timer interval */
-	if (value >= 5 && value <= 10000) {
-		cancel_delayed_work_sync(&trigger_data->work);
+	cancel_delayed_work_sync(&trigger_data->work);
 
-		atomic_set(&trigger_data->interval, msecs_to_jiffies(value));
-		set_baseline_state(trigger_data);	/* resets timer */
-	}
+	atomic_set(&trigger_data->interval, msecs_to_jiffies(value));
+	set_baseline_state(trigger_data);	/* resets timer */
 
 	mutex_unlock(&trigger_data->lock);
 
-- 
2.56.0

