Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349F28B4FA
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033298; cv=none; b=GNzT0ksj9OFeo40tbIULa1BurrW9qHjNwjZ6E3bVfSPgRvUAuL3iXoB9dqOPc6Ad9NkN1LiUGC19LYgbFKCSjKW5MjK+mAqa09kF/5uqhawFcttohHwthCyKHRhp7UYiQPNJaDkbL4ps15SATzk1zPkBub956zdkDsgluhILRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033298; c=relaxed/simple;
	bh=Pg10VTnGXpOnDVNDfCax78qsw1WXYA9oKjsxTtvhDGw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=psj3tC6yKD+fgOXKhJEM1VftnDU6rxJL5Piio274RtP7PHKltvKgyh0Ll7MA/7aAxbBGfyH1f5Rm4kaBbGKaiezoVrzG8Ub2TcY3o251A5WE/k47OgyqgAGgpPpKG1lMwx8C5mMNDTOJvjvyF1zQclkkIJrhDAzUZZTas/QNOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C57YNkOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C57YNkOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D271F0089C;
	Sat,  3 Oct 2026 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033295;
	bh=kVzvtzEvyUZB8kKH+/tU/zuqQ2hai16GExAP6xZMOgQ=;
	h=Subject:To:Cc:From:Date;
	b=C57YNkOsrY2gV28M8/Us9f+e9fgixgMl/M8e/xfIyJ7rNH2CP2SydEBIYSECTO05K
	 +t49WHFpZ+GR1uOqhGm9urjn7iwokw5bf4QounC9TMww3cb0V5xOUcENJ/rFG92Zd/
	 oRjWqLv9W2/3s0bIbg2n3DSyhJlOpeCM9mZeYhXE=
Subject: FAILED: patch "[PATCH] ipvs: bound LBLCR and LBLC cache growth" failed to apply to 6.6-stable tree
To: zhilinz@nebusec.ai,ja@ssi.bg,pablo@netfilter.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:14:49 +0200
Message-ID: <2026100349-mourner-headboard-23b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2a3c3de660f96865f303fd25f1285f2ffbfd521d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100349-mourner-headboard-23b4@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a3c3de660f96865f303fd25f1285f2ffbfd521d Mon Sep 17 00:00:00 2001
From: Zhiling Zou <zhilinz@nebusec.ai>
Date: Thu, 10 Sep 2026 13:08:32 +0300
Subject: [PATCH] ipvs: bound LBLCR and LBLC cache growth

ip_vs_lblcr_new() and ip_vs_lblc_new() create cache entries for
every previously unseen destination address. The table max_size only
tells the periodic collector to reclaim entries after the cache has
already exceeded the limit. It does not reclaim entries that the
attacker continues to use.

Reject new cache entries once either table reaches max_size * 3 / 2.
The extra headroom lets the periodic collector catch up while the
existing scheduler fallback continues to use the selected destination
when cache creation fails. New traffic therefore stays serviceable
without growing the tables further.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index a2b574904f13..55af77a56929 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -205,6 +205,9 @@ ip_vs_lblc_new(struct ip_vs_lblc_table *tbl, const union nf_inet_addr *daddr,
 		ip_vs_lblc_del(en);
 		atomic_dec(&tbl->entries);
 	}
+	if (atomic_read(&tbl->entries) >= tbl->max_size * 3 / 2)
+		return NULL;
+
 	en = kmalloc_obj(*en, GFP_ATOMIC);
 	if (!en)
 		return NULL;
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index f53f05ceea36..858393b1d2d1 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -363,6 +363,9 @@ ip_vs_lblcr_new(struct ip_vs_lblcr_table *tbl, const union nf_inet_addr *daddr,
 
 	en = ip_vs_lblcr_get(af, tbl, daddr);
 	if (!en) {
+		if (atomic_read(&tbl->entries) >= tbl->max_size * 3 / 2)
+			return NULL;
+
 		en = kmalloc_obj(*en, GFP_ATOMIC);
 		if (!en)
 			return NULL;

