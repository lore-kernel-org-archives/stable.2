Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85D356748
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967406; cv=none; b=LLwN9itkcXVK5m7eYXUORfwdWkqqVoXITQ3QnmEO8CylURsCr/XgFDZ9NBDLU9Z7huOqeiImhIINn6y2UZoErl0oEV4/ynL5Olj4ysBYj0/PshVx1bK3Nl58+AKzkbNMbmVMhR8o1Njx6VNatuOKUb/9Tbyfwqf7WSCX/tMbu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967406; c=relaxed/simple;
	bh=AtyAw70H6JdQEtq7j/aBu5GNC1eYZrvXIK9N2K4CYtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLXPSjshAdlAn1+/RlUEavliW/bS+l+P6Mnoj3YFunVWAS+zegj6K6Gikrcqc98ESpKF7PYoyAhReRMqi1SeEOSSbMCW9WLi/1TS7DwYqK7j7fMzZ/Atab3a6+J34CvXRG8eIP/VgfLRAjG2MGhuPBWqQ6tm4AUvmmJdzW0ewYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rbd23Rzn; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rbd23Rzn"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca06a25so16791885ad.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 22:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789967404; x=1790572204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLjGPjvI2QHlThE3TyfoKLHBso+1y45Env8GNkzTPB8=;
        b=Rbd23RznPIJn5FkGDYtOKcSm5Tgkmq0Wmm6uaahejTVFkzQYy57C7darMphQ86Aqdn
         nmLjCUNX4PYwwvC6bHqLwePL75GjdIYgKTptxENkvKzAaOarGTYyQSXH/AzzomxO92WU
         DHXV+k9ggl3HrhU3M8pnlg1TfJH2E6p2tfFIoMPK8/juWoHdTh0m09wb/kXM5t2kLRdV
         HhE6hNpE05cVCpaTxEtYa6R/oOnWBUBcs+lby9J74UQ5Xnnuyl6r0OQcHlurU6mJKXM/
         Auq1R5dRerp8vl+aOWhFRO3khL21PUMu3RuWykr11GdQ7rcK45oIyBjLatf5HUWwfn8e
         5ZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967404; x=1790572204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wLjGPjvI2QHlThE3TyfoKLHBso+1y45Env8GNkzTPB8=;
        b=fShsX0PntmlSy2ShrDa/mBVvI5XeRjTwa+oMexQXWau4yQQUwietScn6IRDjHIh7tQ
         Wpa37ZxvohFnWcJ03usB4ciRpOcL5CslEnN0+ubRYsZ78yh8RL3GL9XkJbwc0DR3O1BC
         fEj6TEHxyU3D9odzk2G1kWs6NjEBQtNtKO9Xtg6IVOfvH+oYFUBs8xYOt3FlJy4/IGaE
         rUp7YpIy07kqRJozKITk8JHPOvgw2q73gEoLL5J31t0odiymYw5K2ov85kiHOzFddWtG
         DxR4Bxyw7XCSNCJMiheVXMD7xatXriasLYnqLlfJz4Mm9tAANL4ZoZPn8B64dkxviKLU
         vXtg==
X-Forwarded-Encrypted: i=1; AKwUvBy2OXJ7BYhdoAoHSIGOzHzO8jhcMXdqQvP7nM3uXm6LG2yLclkiV+6ZUyiqUOvrNcO9j5hsJOc=@vger.kernel.org
X-Gm-Message-State: AFuF++la6vX13rYTL8m2ichl1MNDjPJ99aWJ7+FNUu49UY4eLqxEW/HY
	v6wVZGxi0cUY5xIpX5PRtUnpgbDNcuiQxzFEEthG/+1nJ6dDAsJX16wL
X-Gm-Gg: AYBFou3IGhRgK+UArLZuGih9UpSV6Krs6lH1OW0KuyjVEI0rr5ca02H9l3aL1DzXF/i
	cXuN22UyVUciMFfSwgcPtfUpZcvJRVbZX5J11IOVnm0hfigR0VHwuD3miSlQ3lPOo2zh+uPRltB
	fJXgUDPyj5PGUcWjysdedxlzrbGW/qB7D4q77SLRCAsz+CSn+VL1qg0rzRaXxzkptQsQWdSLk5X
	W2W2qA2gm+ET3fwOxVBYrW7impggrYUD+iNO2veZIhavWdPxBk5isYmEjNfUqMx6hVovjAJp7xP
	vhOjBov28/5m8UgWuzKEzalgrMgTqNmnE4ZEN2SjibK2NDnfJqoFlpDm3c2FzkOj7AG7JZ9LbQJ
	xht7lH7Di7LVJLHgih3IEkYhqTwje4OZ0W0Pf95YR9vqsg3gLHLlJLtMs223Ar2tD/yN6LlK3te
	6dT258mGe5I9gHTpDTLCx4NFS6le0uDm46qsdSh9xcyId3wfrALlD7eIXwURiiwo+SrqYoJRQdG
	2Sk+toS0RuDNKrZRAtWq3BTa5JmXhKMInZ8qaEEKQnD5P96ktMBnx7UM7BFt/8PZafmd5zIYvuN
	F+y9Foryfw==
X-Received: by 2002:a17:902:e549:b0:2dd:c1a0:c7e0 with SMTP id d9443c01a7336-2ddc1a0c90emr82125145ad.15.1789967403745;
        Sun, 20 Sep 2026 22:10:03 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17e17e0sm27229695ad.70.2026.09.20.22.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:10:03 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v2] mctp: route: iterate socket tag list in mctp_lookup_prealloc_tag()
Date: Mon, 21 Sep 2026 05:10:01 +0000
Message-ID: <20260921051002.1656692-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <159f68ef9444f8b44a6d5764de8696f094fa889d.camel@codeconstruct.com.au>
References: <159f68ef9444f8b44a6d5764de8696f094fa889d.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a socket transmits a packet with MCTP_TAG_PREALLOC set,
mctp_lookup_prealloc_tag() iterates over the per-netns &mns->keys list
and matches netid, req_tag, peer_addr, and manual_alloc, without
checking whether tmp->sk == &msk->sk. This allows any MCTP socket in the
same network namespace to use and consume another socket's preallocated
tag.

Iterate the socket's own tag list (&msk->keys via sklist) instead of the
namespace-wide &mns->keys list in mctp_lookup_prealloc_tag(), ensuring
that only tags allocated by msk are matched.

Tested in QEMU against Linux 7.3.0-rc3 by allocating a manual tag
(0x18) on socket A via SIOCMCTPALLOCTAG for peer EID 9 and sending a
4-byte message with MCTP_TAG_PREALLOC from socket B in the same network
namespace. On the unfixed kernel, sendto(sock_b) using socket A's
preallocated tag succeeds (ret = 4); with this patch applied,
sendto(sock_b) fails with -ENOENT (errno = 2) while sendto(sock_a)
succeeds (ret = 4).

Fixes: 63ed1aab3d40 ("mctp: Add SIOCMCTP{ALLOC,DROP}TAG ioctls for tag control")
Suggested-by: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Iterate &msk->keys via sklist instead of walking &mns->keys and checking
  tmp->sk != &msk->sk, as suggested by Jeremy Kerr.

 net/mctp/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 2ce0d9a39bd3..f2b0d8b21f0e 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -826,7 +826,7 @@ static struct mctp_sk_key *mctp_lookup_prealloc_tag(struct mctp_sock *msk,
 
 	spin_lock_irqsave(&mns->keys_lock, flags);
 
-	hlist_for_each_entry(tmp, &mns->keys, hlist) {
+	hlist_for_each_entry(tmp, &msk->keys, sklist) {
 		if (tmp->net != netid)
 			continue;
 
-- 
2.49.0
