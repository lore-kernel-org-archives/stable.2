Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04CA4AB3B5
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573280; cv=none; b=Betpps5YeetPk/NuXUXFE3PSybaSKJ6cOCea2J9d9HO/T/wCieG9NKVYFTCoNww63Nkwu05hpsi15eeU02zWEsp+uYlOA5nZti6sz7V7H1POTDujuqmrknG8x1MAgqPsfUiJ9nAaARM7Ga4hI+sVtLBpztoXcwTGSrRvoRJ4QX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573280; c=relaxed/simple;
	bh=PqLpabq8cfezDnmPibE/PIaBHId8F3Q3z0trzQugYH4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W5SbBpjFgTKH7AmMldMtYMRLJHIxwJJStmWosrFCKx49kCZd3Q7Ip6ltJ+p3HR7lY2opeEB78nW8C2mhDmXNBC158CmVfeQpVwfYAc38O3wUEeKmi9E/R2O0zUc0ywfPGQnKgi5W/57AsNhVxLtvkBHZtJzEePDp1tWh8rKDu6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ksXLuH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ksXLuH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFED71F000FF;
	Wed, 16 Sep 2026 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789573279;
	bh=91es3qsErtd9bo5eZUeKfzSBVADxxNePPDhkc2XJFXw=;
	h=Subject:To:Cc:From:Date;
	b=2ksXLuH/nBVaxWewSL2etZXSYpgd4rbcgjk73aZqBIwv2ihW7FmsCJZN8/zYYJixv
	 O2Safy+RrDfOSsuZuqQY6FkKsAFfyBPj/QJ6O95Xdm09Ql+HqeE4i3aw07oMRgMN2V
	 kiNnps6HoUuc936Q4ddCzErxeCVp/YTSBaGqKVNU=
Subject: FAILED: patch "[PATCH] net: mana: Reserve extra CQ slot for the fence completion CQE" failed to apply to 6.1-stable tree
To: sahilchandna@linux.microsoft.com,haiyangz@microsoft.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:31:23 +0100
Message-ID: <2026091623-upstairs-protrude-105f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 80dd7e754b3aa9637a0758ad93fa209f9650ec48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091623-upstairs-protrude-105f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80dd7e754b3aa9637a0758ad93fa209f9650ec48 Mon Sep 17 00:00:00 2001
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
Date: Tue, 1 Sep 2026 07:17:58 -0500
Subject: [PATCH] net: mana: Reserve extra CQ slot for the fence completion CQE

The RX completion queue is sized to hold exactly one CQE per posted RX WQE.
MANA_FENCE_RQ makes hardware post an additional CQE_RX_OBJECT_FENCE after
the packet CQEs. The current sizing reserves no extra slot for it and in
rare cases, CQ has no guaranteed slot for the fence CQE when it is full of
packet CQEs. This can lead to dropping the fence completion while the
driver waits holding RTNL lock throughout the timeout duration.
Reserve one extra CQE slot for CQE_RX_OBJECT_FENCE. mana_gd_alloc_memory()
requires queue_size to be a power-of-two and at least MANA_PAGE_SIZE;
the reservation pushes cq_size past a power-of-two, so round up the CQ size
in mana_create_rxq().

Cc: stable@vger.kernel.org
Fixes: 6cc74443a773 ("net: mana: Add RX fencing")
Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Link: https://patch.msgid.link/20260901121837.3503240-1-sahilchandna@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 7a1ac853e3ab..45a7520491a6 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2986,6 +2986,10 @@ static int mana_alloc_rx_wqe(struct mana_port_context *apc,
 		*cq_size += COMP_ENTRY_SIZE;
 	}
 
+	/* Reserve an extra slot for Fence completion
+	 * event (CQE_RX_OBJECT_FENCE) in case RX CQ is full.
+	 */
+	*cq_size += COMP_ENTRY_SIZE;
 	return 0;
 }
 
@@ -3080,7 +3084,7 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 		goto out;
 
 	rq_size = MANA_PAGE_ALIGN(rq_size);
-	cq_size = MANA_PAGE_ALIGN(cq_size);
+	cq_size = MANA_PAGE_ALIGN(roundup_pow_of_two(cq_size));
 
 	/* Create RQ */
 	memset(&spec, 0, sizeof(spec));

