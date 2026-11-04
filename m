Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816982;
	b=qve0PRzUm9yWGc0LzAznX8klumtEqvZ8F5WVDl29xzZBkOiePIV7JkeIEL7PFCY0ixSL
	 5vlyvBlOhYdT0LwOKSvBZUT5pw2iAPuuJ48sLAlwXralKzTOYiNeB3qYiyRPp9oqEvbzd
	 rkMt6xb6Vji4N1CkG83oy5SiD8In2tTk2beZnWOQnjPSh02mPkApn0OV1dDQkDjI5k3Z8
	 f0+aFlzkC3hPU4EeggI7YvYGMObbl6ytApLNBDEUGq3d1UspS6k8ta0ICiekR5RrXjtQH
	 639cCbgIA3gen4NWUO6V9/wZLcF6dI+iWF6ygGqFImmn75c2D3qjyw4QcBkGgyryOXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816982;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8k9M17B+vCEQB5q+WJKsC/Kb8NyIcxQMMJgZRJs/RXo=;
	b=BeYnVDY/N7HbY6rfDCO6WN9Oe2MLYsp8WRzPCDnCkYxN3X+wlmaGe8MSiWRfw9/fKQ7w
	 mMldKifkMvG4qlzEyR0rMR/CsGJKmd+2p5+nOWpnpTziBrP56hg4PxUJ0P2xi7XECvWe5
	 Q83Kzu3tRoehV0JzE7dMa/A5PvvzvnT68dzEGKhMG0Otr+fosljBgH81O349CfGxcil+p
	 +x8TO4fIviIkir9seGuwoKWQDGyfD9e/S/rinI+CiIU+gFG1uKByPLCsgTRkZBHkDuOyt
	 d6YHlwpRtTx+rSXR88Q6l9zpGbkiM6FyNZ3M6S9AD0UtOQguwbHxAFS3ZdCgP16OFkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Xym+6K8f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280A606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Xym+6K8f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84291F000C1;
	Wed,  4 Nov 2026 18:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793816982;
	bh=8k9M17B+vCEQB5q+WJKsC/Kb8NyIcxQMMJgZRJs/RXo=;
	h=Subject:To:Cc:From:Date;
	b=Xym+6K8fAlHnDqpNIZcSeXOquhGZWBNfLBfEa4KYpfBZy5uDVv5Js0d50IIRWJlJd
	 W0QhNqy1JF8UAt0GLgMC0KEuqqVxt7j9V0GuAniV8g+3Nr0frP7smVfKpKSTVLC6Nk
	 tRDOVdxCM4KBWSQeKg8diUa+6XutmUvYipfP7CEA=
Subject: FAILED: patch "[PATCH] smb: smbdirect: fix buffer length underflow in RDMA transfers" failed to apply to 6.12-stable tree
To: metze@samba.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:29:37 -0500
Message-ID: <2026110437-bully-enviable-15b3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7193241a49c958782ba4b8df06da3734d1e317d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110437-bully-enviable-15b3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7193241a49c958782ba4b8df06da3734d1e317d2 Mon Sep 17 00:00:00 2001
From: Stefan Metzmacher <metze@samba.org>
Date: Fri, 23 Oct 2026 19:26:09 +0900
Subject: [PATCH] smb: smbdirect: fix buffer length underflow in RDMA transfers

When a remote buffer descriptor is larger than the remaining local
buffer, smbdirect_connection_rdma_xmit() clamps its length and sets
buf_len to zero. The common accounting code then subtracts the clamped
length from buf_len, causing it to underflow. If another descriptor
follows, the loop processes it with a wrapped remaining length and
includes memory beyond the local buffer in the RDMA transfer.

A client can trigger an out-of-bounds kernel write with an SMB WRITE
request, or an out-of-bounds kernel read with an SMB READ request, by
supplying multiple RDMA buffer descriptors with an oversized descriptor
before the last one.

Remove the premature assignment to buf_len. Subtracting the clamped length
already consumes the remaining buffer, so the next iteration stops and
only descriptors within the local buffer are used to build work requests.

Fixes: e628bf939aaf ("ksmbd: reduce descriptor size if remaining bytes is less than request size")
Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-33549
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/smbdirect/rw.c b/fs/smb/smbdirect/rw.c
index 6fe38042cfb9..cb142c3c50b2 100644
--- a/fs/smb/smbdirect/rw.c
+++ b/fs/smb/smbdirect/rw.c
@@ -143,7 +143,6 @@ int smbdirect_connection_rdma_xmit(struct smbdirect_socket *sc,
 		if (desc_buf_len > buf_len) {
 			desc_buf_len = buf_len;
 			desc[i].length = cpu_to_le32(desc_buf_len);
-			buf_len = 0;
 		}
 
 		credits_needed += smbdirect_connection_calc_rw_credits(sc,

