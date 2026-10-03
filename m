Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A945304BDF
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033304; cv=none; b=PBwkrKu3JsaRsAX4EcWS+K9m0V3q/62smEjEbLuk7jZfN40tJ5/6es1KqB8GgemFzHkgt46JBV1feOBcS5+gydX/qDZ8zCI4fxNNo7sAedr+C/q0A1NBR6+NueJj3UjD2BbDj1C6fyf7enNlyZW3tpeW4ak4APsB+gVUq0EW9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033304; c=relaxed/simple;
	bh=/uQ7Pgmcyek2qej+afZHxN1DHSOlu7e7cQMRyZtC7Co=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m2jr3bgv9+a5g+BMTG+ZeNgipK5qF11YNgg1/v3w8Xz7hSvIBw8oigAn8BRqheRi/lZZOKDNjzwrReN3SBYEOQvIjCtIVtL7mGiB1rAPI7HeciIP71z2oVbXiBUgOb2oZROCutaeLwQcsWce8954tjOPHMxw6zq6auphj448LlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1gqI7ab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1gqI7ab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090481F0089B;
	Sat,  3 Oct 2026 13:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033301;
	bh=eHkX+RMCyfUzAS4Sl9e9FTIWsSOP59UQjmBE2qGjvZE=;
	h=Subject:To:Cc:From:Date;
	b=h1gqI7ab7NEkfNd5Xt3hb+z9HWhdrn6EqWeWGIMtmrZg4zaYrCLFPdjYTfTJYVd3y
	 CKhPbp5Fn4Jt7IE00VSvQ+ilbOvWBaEyq4K3DuOMwEDMA1MZe6laawr5O/vIGneWO9
	 zrxd+kHl3tQDfORjfA9hDgXl9th1fyQ8EGR8mR3E=
Subject: FAILED: patch "[PATCH] ipvs: bound LBLCR and LBLC cache growth" failed to apply to 5.15-stable tree
To: zhilinz@nebusec.ai,ja@ssi.bg,pablo@netfilter.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:14:53 +0200
Message-ID: <2026100352-expletive-silica-be66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2a3c3de660f96865f303fd25f1285f2ffbfd521d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100352-expletive-silica-be66@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

