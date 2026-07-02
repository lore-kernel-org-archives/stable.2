Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C280142A7AD
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000555; cv=none; b=CFwK2rHqRiCAZl6W61CBWRk0FbhKuWwbzVcYV0ichEx2ns0z/6F3/OqT4LHfR0I134hoZqCBNB5fPKLXyCqjYbL5H7BabPRM771pK7Zwjoqtz7wDV2F0ANwP0dIf/ng4YzQIZeL1A5LrxIJTQEVBfk7wvEYC31ORYtGoSNegdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000555; c=relaxed/simple;
	bh=NylqzK0dP3Csw+2M8L0ogyXTXN4i+y9mQM3416bvCCE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FfYx0qCE1vp8eipNirCQcnUSrkf3Zer2ikaubreNiQy0cgCPCH0lg6/bNgGFO+0HmGfNt7eBWzSQo+Xb9QTA7QPToPFLcZ8LPbr1eJsuqgjwsDKZJSvprwlrCTHUrG7xvxf+QXtVbLDE1GcocgZ4RZwKQAdHHYM0YxEJuF8p3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rpDDOafU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rpDDOafU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C29C1F000E9;
	Thu,  2 Jul 2026 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000554;
	bh=xVGeVET9m3V2FA060eKVwKODCTyoXkHVGTuFW7r3yR4=;
	h=Subject:To:Cc:From:Date;
	b=rpDDOafUC247xVCT/0xwKuvwmDybJVlKnClX6hVQ0CvgtSi8lqSIwY4ijF/Nz+nr1
	 /rgJb14nlOoUYqIMPnowgaqIxswu4+LTo4Cz73pMX/IIX6NcmsVp7ij2j5RtddsPT7
	 C6MzDcEBgbXZi/fhVygI5NMYTkVXDnQQVIjIviHY=
Subject: FAILED: patch "[PATCH] NFSv4/pNFS: reject zero-length r_addr in" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,anna.schumaker@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:55:57 +0200
Message-ID: <2026070257-maimed-expletive-8052@gregkh>
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
git cherry-pick -x 41fe0f7b84f0cb822ae10ab08592996a592b2a25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070257-maimed-expletive-8052@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 41fe0f7b84f0cb822ae10ab08592996a592b2a25 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 27 May 2026 12:30:35 -0400
Subject: [PATCH] NFSv4/pNFS: reject zero-length r_addr in
 nfs4_decode_mp_ds_addr

nfs4_decode_mp_ds_addr() decodes the r_netid and r_addr opaques of a
netaddr4 from a GETDEVICEINFO multipath-DS body, then immediately
calls strrchr(buf, '.') to locate the port separator. Both decodes
use xdr_stream_decode_string_dup(), and the current code checks only
"nlen < 0" / "rlen < 0" before dereferencing the returned string.

When the on-wire opaque has length zero, xdr_stream_decode_opaque_inline()
returns 0 and xdr_stream_decode_string_dup() falls through to its
"*str = NULL; return ret" tail, leaving buf NULL with a return value
of 0. The "< 0" check does not catch this, and the next line is
strrchr(NULL, '.'), a kernel NULL pointer dereference reachable from
any pNFS-flexfile client mounted against a malicious or compromised
metadata server.

Reject the zero-length cases explicitly so the decoder fails with
-EBADMSG (treated as a malformed GETDEVICEINFO body) instead of
panicking the client.

Cc: stable@vger.kernel.org
Fixes: 6b7f3cf96364 ("nfs41: pull decode_ds_addr from file layout to generic pnfs")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 12632a706da8..0ff43dbcb7cd 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -1075,14 +1075,14 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 	/* r_netid */
 	nlen = xdr_stream_decode_string_dup(xdr, &netid, XDR_MAX_NETOBJ,
 					    gfp_flags);
-	if (unlikely(nlen < 0))
+	if (unlikely(nlen <= 0))
 		goto out_err;
 
 	/* r_addr: ip/ip6addr with port in dec octets - see RFC 5665 */
 	/* port is ".ABC.DEF", 8 chars max */
 	rlen = xdr_stream_decode_string_dup(xdr, &buf, INET6_ADDRSTRLEN +
 					    IPV6_SCOPE_ID_LEN + 8, gfp_flags);
-	if (unlikely(rlen < 0))
+	if (unlikely(rlen <= 0))
 		goto out_free_netid;
 
 	/* replace port '.' with '-' */

