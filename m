Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538728;
	b=sbiebsAgbvqXyaIlDqYqy10o7dWej1VGajjewiH2AJgJI6NHKvHFHOrpuwk9RvRbk0jN
	 altP8Eq0dVFexRtEqdaycuTuh8LHO+8mxxULaU8KsDDysqhTpaohP97o6118iqrO6cp9s
	 dS/UD8Lz7ru5oOJpmFwGg0N9gi06/ML3YWuq94Doowfp/QOCmo8haNCiDnJTH1VrKvC3x
	 m/YiZtaPMpx0Dyin8hKDIQvjvvY2DQc7kFnxpLzcgYzyETzWS1lt6/hZErm9G/3F7TcuR
	 im9h0CP5X56954dP4b/sBrHx21wXKHSvAKMz427nF8ITN/v8sKMJWF+bBSFXbgpCofA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538728;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3NNn+X6mBYpzhsvkcgn80LErUaFlJtswiOwKmKVX65k=;
	b=wY/oyeC+nUqvPco/2s/rEi5fcvEig04Xh5S2R3R89SSh3qrGso0wsAZBSwsOqGPa0jKr
	 3zRtmNv7ne3hTcY8Q4iArXlRCWhpTP2zn6Tr6FHzKT2OmJ/eVtgfCV9kfYlMlDDmh8QCC
	 SKRjbfnQG6Z0TaoFQG61kCkAudANA++3oXtS2wvCaTKvyxW5fKjzhZXEVVpGSgnSAZAsK
	 QYUlNo0nPZWku7aB+x4m+KAaxtxGlBZxPlLkJWeqfvo6Vy/bmUCgJGb2+kqL7/M3wFyhK
	 YSIFaoZfhVxiHAciUblVHVTqvc7VrPofpwPPmQ7f5UUzVleFXGeo9lT+NBsxE+W971Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CeiMxS5G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC3606A333
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CeiMxS5G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7761F000D4;
	Tue, 24 Nov 2026 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795538728;
	bh=3NNn+X6mBYpzhsvkcgn80LErUaFlJtswiOwKmKVX65k=;
	h=Subject:To:Cc:From:Date;
	b=CeiMxS5GLJPK9J1HPuFw4Jk1J+1vmhzbJGouieX77yNczS7H1xPolJnlCoIyRIZmn
	 DlkRuYLDMu/ee7H2TGeVeDMQ45D0wGqD5Pfzt1/btuUc8uaaMBUPLvuBEpx2TtMibx
	 pCQTik449N2sHd5R8OHEUZ7UZOkjl9pfhz9bIZ3s=
Subject: FAILED: patch "[PATCH] macsec: reject frames that decapsulate into runt Ethernet" failed to apply to 5.10-stable tree
To: kylebot@openai.com,davem@davem-thinkpadp1gen8.ibmlond.csb
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 17:45:40 +0100
Message-ID: <2026112440-cranial-zen-ea50@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112440-cranial-zen-ea50@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Thu, 29 Oct 2026 21:22:37 -0700
Subject: [PATCH] macsec: reject frames that decapsulate into runt Ethernet
 frames

When an SCI is unknown and the C bit is clear, macsec_handle_frame()
removes the SecTAG and the default ICV without checking how much of the
frame remains. A short frame can therefore become an skb shorter than
ETH_HLEN. eth_type_trans() cannot pull its Ethernet header, and a second
stacked MACsec device can copy stale skb headroom into a packet delivered
to a packet socket.

The matched-SCI path has a related hole: macsec_validate_skb() accepts a
short_length of one, so a frame that passes the existing length check can
still become a 13-byte Ethernet frame.

Require enough bytes for the MACsec overhead and a complete Ethernet
header before decapsulating an unknown-SCI frame. Apply the same bound
in macsec_validate_skb(), using the selected SecY's ICV length, to cover
the no-SA, synchronous-decrypt and asynchronous-decrypt delivery paths.
Leave other unknown-SCI handling unchanged.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 87f3f4bdb026..240ba0ae07d1 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -408,8 +408,10 @@ static bool macsec_validate_skb(struct sk_buff *skb, u16 icv_len, bool xpn)
 	int len = skb->len - 2 * ETH_ALEN;
 	int extra_len = macsec_extra_len(!!(h->tci_an & MACSEC_TCI_SC)) + icv_len;
 
-	/* a) It comprises at least 17 octets */
-	if (skb->len <= 16)
+	/* a) It comprises at least 17 octets. The SecTAG and ICV must
+	 * also leave a complete Ethernet header.
+	 */
+	if (skb->len < ETH_HLEN + extra_len)
 		return false;
 
 	/* b) MACsec EtherType: already checked */
@@ -1331,9 +1333,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 nosci:
 	/* 10.6.1 if the SC is not found */
 	cbit = !!(hdr->tci_an & MACSEC_TCI_C);
-	if (!cbit)
-		macsec_finalize_skb(skb, MACSEC_DEFAULT_ICV_LEN,
-				    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	if (!cbit) {
+		len = macsec_extra_len(macsec_skb_cb(skb)->has_sci);
+		if (skb->len < ETH_HLEN + len + MACSEC_DEFAULT_ICV_LEN)
+			goto drop_nosc;
+		macsec_finalize_skb(skb, MACSEC_DEFAULT_ICV_LEN, len);
+	}
 
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct sk_buff *nskb;

