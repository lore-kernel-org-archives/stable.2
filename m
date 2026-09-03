Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9094EBAD4
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449946; cv=none; b=nhGj1xIFUYpN//Y8Gdhd/ryKOZJMQuekrDhgsV4AyT6ktoNfUyXTPxCrdUk5fUTGCu2gVe30n1jxTo1JE62UZdzcznNYDC3m3vZbZadnyICC+KBB13tIDFBddysFckVaxOYnm3IDidPwKbhRip8YdiKXRjnyJTJ37w/mwywjmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449946; c=relaxed/simple;
	bh=cskD6jYYimUvfR/Srd3ShTDVYyZ/cEqh1w02VrxaXEo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j3J20HO7ZSz9SpqbSvdW+vRwdEDI/9YGiczylEKUnNgvVbO3rZIoK6uebLdjRfXbsX+fy1XIa5TcGax6gHehmWcKf3JZyJce/ReqC6UZZ51XGTxaWzLY4wnUt/HNWEqCF/+CF+OXaoKTs5j9JQhyd8sfPtUkWqiTreX6ur+0cJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G8NsKhSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G8NsKhSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E241F00A3E;
	Thu,  3 Sep 2026 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449944;
	bh=mlfcn2BmHOsuE/grZQLHS4UpdL2equUIZ3v3AU7gh0I=;
	h=Subject:To:Cc:From:Date;
	b=G8NsKhSdcmP04aOnMRhBVo63F9Kodgljgy3IxhjRmzpY7wT9JbuKYiAYkbJXzi+1K
	 PQHAv8rRjdHnXs3aW8Fl7ClCZfjFn0qgH2apcFpShk7NWvqymNrq2gzV/O4CN3fFyF
	 38MB2SNtqLYUFVYIk0MvSWKBDZocJYHHd9D/48DU=
Subject: FAILED: patch "[PATCH] net: skbuff: don't touch shared zerocopy state in" failed to apply to 5.10-stable tree
To: norbert@doyensec.com,i.maximets@ovn.org,pabeni@redhat.com,payload.jang@gmail.com,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:11:10 +0200
Message-ID: <2026090310-contort-crabmeat-e1bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f66bdb1cc0fcd227a062378f8be0b5873aa5600a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090310-contort-crabmeat-e1bf@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f66bdb1cc0fcd227a062378f8be0b5873aa5600a Mon Sep 17 00:00:00 2001
From: Norbert Szetei <norbert@doyensec.com>
Date: Sat, 22 Aug 2026 11:15:08 +0200
Subject: [PATCH] net: skbuff: don't touch shared zerocopy state in
 skb_tx_error()

skb_tx_error() completes the zerocopy uarg and clears
SKBFL_ALL_ZEROCOPY, and skb_zcopy_downgrade_managed() clears
SKBFL_MANAGED_FRAG_REFS. Both live in skb_shinfo(), which every clone
shares, while the caller only owns the reference it is about to drop.
Through a clone it tells the producer its pages are free and drops
SKBFL_SHARED_FRAG for an skb that is still in flight.

Open vSwitch reaches this with a non-last OVS_ACTION_ATTR_RECIRC:
clone_execute() sends a skb_clone() into ovs_dp_process_packet() while
do_execute_actions() keeps forwarding the original, and skb_clone()
does not privatise the frags here -- skb_orphan_frags() returns early
on SKBFL_DONT_ORPHAN. A flow miss on the clone then strips the marker
from the packet still being forwarded, and a later local ESP delivery
decrypts in place over frags it does not own privately.

Skip it for a cloned skb. Nothing is lost: skb_release_data() clears
the zerocopy state once the last reference to the shared data goes.

Fixes: 25121173f7b1 ("skb: api to report errors for zero copy skbs")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Tested-by: Jongmin Jang <payload.jang@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/CFAB292A-674B-4C14-BB2C-BB8830AD5659@doyensec.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab3d161247b9..b9541329f1a7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1417,10 +1417,13 @@ EXPORT_SYMBOL(skb_dump);
  *
  *	Report xmit error if a device callback is tracking this skb.
  *	skb must be freed afterwards.
+ *
+ *	Does nothing for a cloned skb: the zerocopy state lives in
+ *	skb_shinfo(), which the clones share.
  */
 void skb_tx_error(struct sk_buff *skb)
 {
-	if (skb) {
+	if (skb && !skb_cloned(skb)) {
 		skb_zcopy_downgrade_managed(skb);
 		skb_zcopy_clear(skb, true);
 	}

