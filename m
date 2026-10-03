Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81EC30AD0B
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033300; cv=none; b=JpuZWG8visaHs/hEY0xtfEZ7z0/y7VdUqbK8yloa5sdygOb0TSeMVlqLxzX6YdTyL4iZF0Otyl7PG7YjP8cHloG5w0k7nxGwpyZvSEC1slFyx075QQUS1v8nPo1NabfE5F6usaWECE9IGsZv/zXF7OlN178lHEwaQZuA+J3Mkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033300; c=relaxed/simple;
	bh=K5scdi+YtUO6CBxIVfOFzTZ5Fi3v2P36r5VX45ojK1k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RjC+7CqtCi0RUgVNI+pfG0Oh/xftrOZlO1VFVje0F/iYNmj0b5rnwYuZtiyKI0Rsc01TnvJrFTy6KF1rOxrJvgsUjeyWAjlELnzKW99vzcgWq2fdB0pQpd/vEAqBnJ0f/CYo0WTH6H3g6NK5f+Va04wFevoWf8V4kxL2kY2JMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l+BWrF9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l+BWrF9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D387D1F0089B;
	Sat,  3 Oct 2026 13:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033298;
	bh=88zm2RYnc1P6a2Z8sobQjOT3bKDsPbm4MDEmHdOmTlU=;
	h=Subject:To:Cc:From:Date;
	b=l+BWrF9CGwLnOfpDXAZTgKcBATefJanQEu50IZHaDTRpYfeU7y4QddWEosF7KGALs
	 avw4kW5j4V/zxZAQy1bnRtrBNAYr7FlgAbCVRTJuWrRg8XcRTMVT756GBG/eksVhQx
	 pKFUEH6+PpR4ZwlARtXgxlQmbQV9Q6Q2zDKONyYc=
Subject: FAILED: patch "[PATCH] ipvs: bound LBLCR and LBLC cache growth" failed to apply to 6.1-stable tree
To: zhilinz@nebusec.ai,ja@ssi.bg,pablo@netfilter.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:14:51 +0200
Message-ID: <2026100351-easing-ritzy-2978@gregkh>
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
git cherry-pick -x 2a3c3de660f96865f303fd25f1285f2ffbfd521d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100351-easing-ritzy-2978@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

