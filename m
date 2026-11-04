Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816989;
	b=u9Mqv5WODO/EMWPyDgRdYST4YkISUkknoadFew3ffVp6Zlj2RxItfZ/c1BbXNczPECEb
	 3HdSTSrs0wpTvEHjteOjIMpqM2CDTrYGE3pYijBqrMVD13POSRy2dOC0l/pP6PMDggenb
	 C/PqICsSZNIv22Osr1GW6zxFrZ5OlGpt5TpkxFklzc5dZDPlI2rm5+iNr7FdYcRVD4bDx
	 KFG6lsT+aX1gqOiG5DbSsaFEmbDGigwimHT9Y/tM9zDPrIj6yqBn8E8yw+Z2za/Vi81OV
	 +CuoRuV8yvOG4GtzVb3f3oWW2VvFCszOgSeFl47Ro0GNsvEsu6WpCpmPYYUAAsDlSJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816989;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hdDbyn7s0aneoL0EaK5ZZYpNZDMV24DyEOZQL8B7k3s=;
	b=dlaPrmAIL6jWmLc2J6HrmJM4VzwsOjAUzOwdI8itdWC+mnIq7/sDaivl+DiiYh+gO3/L
	 noqO64/N0bsaEdG6BWFuFkWtXXyZ9+RgxAvlcmeB2Eaire9rKD3gPZbgFDITQRu5seXtO
	 WeYUIOTUHYFBXSyzz8/Df5EcIKC4Xmcv3XJxQo23MUd9xZBqqOGSjjI4W7wiydVDRbjLh
	 uWY+sc4VnWZMz9N+mo6PDM5dR1u+qJJDUKu5OQztpMphAZNmKQa0P7kBGKy8CZ8gvZzGc
	 +kd66ST6tsgjnOwIBkQ95JnQ8WOHu+bg16pp8zO0insPr4q4MX+a2fS5jdNPFCeo5KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zO1S90YD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE2606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zO1S90YD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79A51F000C1;
	Wed,  4 Nov 2026 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793816989;
	bh=hdDbyn7s0aneoL0EaK5ZZYpNZDMV24DyEOZQL8B7k3s=;
	h=Subject:To:Cc:From:Date;
	b=zO1S90YDlUIeQgVyd1QIVXAa7DkiGOCZNsDFZ9CrmJSaAX2eVW8gltBIrbCN6lJhp
	 KpJijBvB6AhbILfhYjFapVeqsI9RGQGKqTdU54LtBKluIqsbRJ7gmMM3k19aLJNB3g
	 BsLFAEGCHM4yt1/+rpcztEFIUE6LUtdKIYV3O1do=
Subject: FAILED: patch "[PATCH] smb: smbdirect: fix buffer length underflow in RDMA transfers" failed to apply to 5.15-stable tree
To: metze@samba.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:29:39 -0500
Message-ID: <2026110439-qualify-confiding-f593@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7193241a49c958782ba4b8df06da3734d1e317d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110439-qualify-confiding-f593@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

