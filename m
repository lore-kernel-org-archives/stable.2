Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD8466AE7
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517850; cv=none; b=bJkr67UDiWsXRPhSDPUNdsF+SQNSZogzwRts4oaFF/7Lj+iwnQ3KOfoRJXb4vjWbnjB1JENC+Fru9yHE51dIkeGPmv9rbuHLouIGbQ4KNhLW9ER9Lry+cdGfeHH/wxsQoLzPpNCGu56gvdOKX75EL7vJqxjz6ItZInjs4s4L9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517850; c=relaxed/simple;
	bh=rnKoky8df3F04GRJ8g3iD+ywyPjmkdvpXLARgUT3Cf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcrWCi6KL0zOacImE4EvCcJdMZxDzt+OdGmpMKpDO5veiHoQHKFIGfdywB2tZ+oYLhiE8upYfapNKmqavCMr9Kg2eJSVa5xhC2h4RmDt4Wy0MCwsRsrctOcqkm6osKxNKGXcnLjDMLW+D2rRdFBY7dFTwA1swWOgdR5vRUUKVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRvKCYpI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRvKCYpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5E61F00A3D;
	Fri,  4 Sep 2026 10:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517849;
	bh=OsXNGeQnJWem64WGTp8b5yfaIcXW/NTMUQcjB1xDwQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jRvKCYpIEsI19lA47SEsIu9wTRiNAEAJRpmQMTUCK4k+HfWYRCobsgmndvps64ZU6
	 CKfpYgua2MqTtnfL2WT5fQwUT+ED55Ggq+U41KzGWbRMTWz6UpMYSoOXacMFFol74E
	 7tit8yrTN61+vACVhUOH2MpmcT62co5RIkugcBLxRDoq0hgmwIR3alzaLW3feiXJUp
	 KNPNzrNMprtYMPq2CqlMbHNgqt+scTyZJGHpQgsaml6YtrNfJ7sx0l+uNMClPtNxva
	 L0WHx1/w2WKFiOPXteQmP8TPbTJEikS57/QytWv5B0IL+Lrr6CRMHEydVkCInRpWYT
	 8aLq0k3jFyNOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] xen/balloon: improve accuracy of initial balloon target for dom0
Date: Fri,  4 Sep 2026 06:30:46 -0400
Message-ID: <20260904103047.2503626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-booth-lavender-dee9@gregkh>
References: <2026090358-booth-lavender-dee9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Roger Pau Monne <roger.pau@citrix.com>

[ Upstream commit b13cd24c15d74f6dfcddf0d53ae6efb58d3f0461 ]

The dom0 balloon target set by the toolstack is the value returned by
XENMEM_current_reservation.  Do the same in the kernel balloon driver and
set the current allocation to the value returned by
XENMEM_current_reservation.  On my test system this causes the kernel
balloon driver target to exactly match the value set by the toolstack in
xenstore.

Note this approach can be used by both PV and PVH dom0s, as the toolstack
always uses XENMEM_current_reservation to set the initial target regardless
of the dom0 type.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20260128110510.46425-3-roger.pau@citrix.com>
Stable-dep-of: 5d00a11d484e ("x86/xen: fix init of balloon stats again")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/balloon.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 8c44a25a7d2b9..9b6531eb28b65 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -724,7 +724,8 @@ static int __init balloon_add_regions(void)
 static int __init balloon_init(void)
 {
 	struct task_struct *task;
-	unsigned long current_pages;
+	long current_pages = 0;
+	domid_t domid = DOMID_SELF;
 	int rc;
 
 	if (!xen_domain())
@@ -732,15 +733,21 @@ static int __init balloon_init(void)
 
 	pr_info("Initialising balloon driver\n");
 
-	if (xen_pv_domain()) {
-		if (xen_released_pages >= xen_start_info->nr_pages)
-			goto underflow;
-		current_pages = min(xen_start_info->nr_pages -
-		                    xen_released_pages, max_pfn);
-	} else {
-		if (xen_unpopulated_pages >= get_num_physpages())
-			goto underflow;
-		current_pages = get_num_physpages() - xen_unpopulated_pages;
+	if (xen_initial_domain())
+		current_pages = HYPERVISOR_memory_op(XENMEM_current_reservation,
+		                                     &domid);
+	if (current_pages <= 0) {
+		if (xen_pv_domain()) {
+			if (xen_released_pages >= xen_start_info->nr_pages)
+				goto underflow;
+			current_pages = min(xen_start_info->nr_pages -
+			                    xen_released_pages, max_pfn);
+		} else {
+			if (xen_unpopulated_pages >= get_num_physpages())
+				goto underflow;
+			current_pages = get_num_physpages() -
+			                xen_unpopulated_pages;
+		}
 	}
 
 	balloon_stats.current_pages = current_pages;
-- 
2.53.0

