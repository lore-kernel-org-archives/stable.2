Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795738610;
	b=DmZDNAsMpyub3zuPH877TrqkGNjvhkg3iump5VCBdiQz5WD7vooPATFB7WJKcohaSQqd
	 OSoedETatWKzHKu0p/pa+AbcWf5sOjpkTj8KOxy5IPajZ3tJNSH7VhR2/kigzDUvyzpSV
	 jXtgyBdCfalwt7NTKxupmDVnELptapL8S6FlAML5PGZhYCswq3qOrlNx6JEE201++t4iu
	 T+P4KtL0azmMX1uhaP7xsUVEFudIt7Hi3EbjVl96cEh0IEZ9/ZYYsD1OKYGKN5wLHJ1qz
	 tkjW0+dOuyAh+nEBUsMruSG/g1ib/f3PRAmvXgdQ+yx+secbx7ybKmfNSVlDKS+GBnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795738610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gye4YsbUN5yG8oY4A5kAtzWYZXrQDCSgln8D0vjm4yk=;
	b=l+jRF2aypbvARMKcRAVWmwO1uDJ87C5SQG1dawyVz/rybjboWGsq8EbPhydI5IGOuMZh
	 54RO9Nk7XmBsRAnZCvzH6hT9lYTzlHjAzZxFi50w4TNME1f7FRiiLX020bqGiDlrYzNyf
	 C+unAXOp7zm5MAERt37oYocQ0LDa7C4I9gJls9fg04YoI1veZ6JrsqfgO8ecBgqVNynwy
	 a3Wc8mESMfiJiIMmBwbKl+ONG1r5/CzQjkrOdqWTiaCifsYMJtVLZYoy7OeB9X8qo9N8K
	 NL4KnQG/dYEgpC8H9ea6r40f5i+coDuSaM+I4K6kJ/D0r6QQ0mZon01dqX5QijIYXTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBThwLrg;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC8606A33E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFCC8606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBThwLrg
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so68512585e9.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795738608; x=1796343408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gye4YsbUN5yG8oY4A5kAtzWYZXrQDCSgln8D0vjm4yk=;
        b=sBThwLrgwtNi/8V+i5S1cCVxWVRMg+L2Y0aTjHRPpx8c8uWlF6atBR2a4U/9ViPF/N
         JPpZAwHvyB4+9tipx396YodjkCn+rOfe2lENaGPMNlBJ0GNCCehx/uyfqHfzRqdpFTgM
         cZRd1rPnlDFW3Hh1yCBYH1LINsqHDqMpBSNBvgHSHPFWMxvWohlyTz2QSXhZyL2b6z26
         M2sUHErEMu0C/DuQPOLPmluzICGiH2bVMJZs6cHx5AEdjCLX0As+kKmm+2oxoShPI3M1
         /R0I9yWT3Kl9v7nzj7MHwDKFIt7EoczG0wYfYnpGHyXXopj9zSMIhm9uBegyCilBOmxf
         GWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795738608; x=1796343408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gye4YsbUN5yG8oY4A5kAtzWYZXrQDCSgln8D0vjm4yk=;
        b=o3oJCe/rZYwfQ4OGGs/EkfcRqGcLGtpckg4+NLEAny7JOPkOkMq6H7fLk1gDaQeG7d
         qdPnnob8e1+HaatXzwX+3kFDwrSw2hjxhnCcWPe0LP/Pv1CTUxykEwxm3Owvqp8ePWI2
         t8ndra197StDqvxB1dYwuGJWLzKB+qE8Dt5jCFd6njrigcO7s9t3ggPr+w0idbGRfnE/
         OFgmWZwjPd5bFuP+7BrkSfoNlPLk8CLpYolCjqGJizGP2oq/gmxl0vVwm1OsXsdK/ap/
         ngY6sT2PpBcnpuYCnNMEG701l/T1KULcdau1KS/ZOXNz+rNzPwqUTnRR9IfLkS+PDtoT
         Fndw==
X-Forwarded-Encrypted: i=1; AL+hErFFDSnHO6+UHWJKatmPFufbPoiWChVTyBuXj/B5V9CbItRDtVSwq3y9VmL2V/ARidm/k2cT1pw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OiIWlUCF6FDjyOYTnGfjpERHrflXsatu/Fya4yhYHBLnwzttw
	0SC5QR9bghNtyEevRAAmByCfojOGOit7lOSCWjvr/QcHlTvK3vJQIl4=
X-Gm-Gg: AZFdTZegJoMN5Q0+9enQEJwgvRWK9KIIZ4tnEl0NnyrO1qigRSL0sEbXfV0jqoCJ9v9
	RmytAS0R1h+8IiBL5J9bs8ozcOwNFTCvUIvZQV3Ofgl6CrG/6Oz7gc9a1Ny+c8Q8zUxJY4OsBnx
	b5wfDhwj5lAUMq+3cDDEAwNyIEB1aqfMbd/3cYTWtNGMgTkxOL/gEtGXfOTIotneI8KaQdjUzaM
	xMqQYiVv4x+oAQd7A4ZL41rTLR+zBAVOC1r2v2oXNMpwrTbx0wtPn9Is1gUZ+0ewLHHCBqigC0N
	lZz0KylPkXO99hYnY8WZiYPZlIoQRUuA6tjq5yjXG6ofFCBkvJwWnOdvvGImAHVzYe4TTRj6S1d
	tvXQ1L/lnUf6atkOuDL9XsE1JQh4zkOSxxXO6TgNxM9+ohgyXsK73wle1JhYVOkySiUn1yVeXyO
	uzo3/3B0EtaHHpCQQiVJqd18JF3Vwmdl8WjfWruWWGYotrvnxC10QTRjdO7laPOz4A5nhK8tNLp
	tTmUNDqXJYmJHSMmy/ZvVHD6vhRRmEPtcdl3ZNRhTY4G1jMxr2j+C1crOhJ0CdggaUEhXpv+qfY
	GEpi4TK/wjdyjhBH
X-Received: by 2002:a05:600c:800e:b0:4bb:7757:fe58 with SMTP id 5b1f17b1804b1-4bb8881b9d7mr470420415e9.19.1795738607998;
        Thu, 26 Nov 2026 16:16:47 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm356650865e9.3.2026.11.26.16.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:16:47 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Christian Brauner <brauner@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 nf 2/5] netfilter: nft_meta: pin file with get_file_active before reading f_cred
Date: Fri, 27 Nov 2026 00:16:34 +0000
Message-ID: <20261127001637.1026589-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127001637.1026589-1-tristmd@gmail.com>
References: <20261127001637.1026589-1-tristmd@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

nft_meta_get_eval_skugid() reads sk->sk_socket->file->f_cred without
holding a reference to the file. Since the file slab uses
SLAB_TYPESAFE_BY_RCU, a concurrent close() may free and recycle the
file object, causing stale credential data to be read through f_cred.

Pin the file with get_file_active() before accessing its credentials
and release with fput() afterwards.

Found by manual code inspection; not triggered at runtime.

Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/netfilter/nft_meta.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 01cfbaa365250..abf0bbce9bfda 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -17,6 +17,7 @@
 #include <linux/random.h>
 #include <linux/smp.h>
 #include <linux/static_key.h>
+#include <linux/fs.h>
 #include <net/dst.h>
 #include <net/ip.h>
 #include <net/sock.h>
@@ -135,19 +136,17 @@ nft_meta_get_eval_skugid(enum nft_meta_keys key,
 			 const struct nft_pktinfo *pkt)
 {
 	const struct sock *sk = skb_to_full_sk(pkt->skb);
-	const struct socket *sock;
-	const struct file *file;
+	struct socket *sock;
+	struct file *file;
 
 	if (!sk || !sk_fullsock(sk) || !net_eq(nft_net(pkt), sock_net(sk)))
 		return false;
 
-	/* The sk pointer remains valid as long as the skb is. The sk_socket and
-	 * file pointer may become NULL if the socket is closed. Both structures
-	 * (including file->cred) are RCU freed which means they can be accessed
-	 * within a RCU read section.
-	 */
 	sock = READ_ONCE(sk->sk_socket);
-	file = sock ? READ_ONCE(sock->file) : NULL;
+	if (!sock)
+		return false;
+
+	file = get_file_active(&sock->file);
 	if (!file)
 		return false;
 
@@ -164,6 +163,7 @@ nft_meta_get_eval_skugid(enum nft_meta_keys key,
 		break;
 	}
 
+	fput(file);
 	return true;
 }
 
-- 
2.47.3

