Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795738609;
	b=3kCZVGPDaG5fsEbze5FrXRvsL1LvwFRA/jXU/wX7zLivJ8Up3nhSedv/HGB3EsRNAdLC
	 aAhHy+I2rW+VS6rYKJAFaLxvJu55IadsJAL/Ovm/OctFLRuXgNG0PJ4cRaoloEy+HOWFP
	 pVgC1t4Y7y/yhTBypLyl+akAg3oo3B2BLh7IBRZyJ9LkjelSxeWemV65N8qEl5MyNhxO8
	 TJYhXClazpIjf8szAc6AIjRlk7mO/fOf+P7wHNc364MCaasaT+ifd3u6qHtvsNq1aYB+a
	 Y8Fhj/W/95ExhayNIFhGNoLYprq18xzPGjkO0q+f3NYVMqR8FewsC6+yIb0nKF7wzAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795738609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=npRlcaBUGO4zBESfN/npXWj8+rVH/w1YcWRi93JmvYY=;
	b=lXbGSZr5lcgDTbXlkMm3zQdVhDy91+6PAHn/qserKEsFJI9i6Wu/nyYZfPI7B0oKhCTU
	 usjiuoM3zewBh2U5ChYd3p43gx5HYxC2C3D9ioCIRckyckN2EL97l1unpNnFtUaC0OOhm
	 sO3iWxNGEKxuyMSFAKJt/3sbfwy0X6ek8OoJapBTZNfZ2Dvm/NvgOe2uePSkIH//5OgUt
	 Zchai0m16VDrfd2r08L1MwngCvBTFzDg3RaHdOz1z7dcBKhxWj9s7yG0jPUzD31x30kJd
	 Mg5+mTQmG1teEofhyHybiurDuhKFcSdwcyTpgwlKaraZA2SvQMicd0vzZo4fWoUABdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYO8aFEt;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655B606A331
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3655B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYO8aFEt
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso72176105e9.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795738607; x=1796343407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=npRlcaBUGO4zBESfN/npXWj8+rVH/w1YcWRi93JmvYY=;
        b=PYO8aFEtgcaK2RPagOerewhpmmc0ZDfIuCpod+G7twgg2sk8nOtwoVzXqiOruClPIm
         ykZa2Gxh+SbdOb03Tk7Ecox+GJjbV9l2/iELPwatOZLCW6UmJZa8NAe8B/w/TKjjd6pb
         Z8lDEzwMElZT3VuGrs7870kS2fZ5W6L3Y1LHKxricIzTODmmgHGB8yL32QZKvtgZU/Ea
         c/FH6xopP1GpfrAy773fdIGxTM8VNlJBn431gWDOYNXBHbqBmwGj7RPl1BwxdeO7uPEu
         JszKhsTKy2u/qCKbWkAQnfWQfdvyXVGBNEX4EE1GUhwSFa4Z8PJSs1cVbio6w2uoB1CD
         pzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795738607; x=1796343407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=npRlcaBUGO4zBESfN/npXWj8+rVH/w1YcWRi93JmvYY=;
        b=Lzd3vtiqxI1Q+UAO2CepCBIcwFtlfZipJf52YoFkDBBKiU5n7mGrW02TiRIvht5NXh
         OdAJn3T5zy2HqXY5IKj2oZgZ7GG4LaAvx8Mmad+nUN6FTVxrwOHnXsR0/emyDaPirnpW
         A50vKYDmbJtWKFuf2GPOqZKr5H16fHnwynyZt7Zm0avxw4srPHgHsC/oAcCFmNtc4Rg6
         qriuEXqkqDzunaNi3+IVHp0wrAk3ODI5X+dCtxEGmddg+qcd5tFTkw8DtAxV6tPBmore
         BnOHML/VvNFGn0kZ/HAsXW9viW//U6yC91eHc7Ui8Gu19br0Z0aS0PLOQ2LAL7TQ892W
         wWYQ==
X-Forwarded-Encrypted: i=1; AL+hErH8Z0IwrIitrMqEa31TkrcWMHpeTQ5zzyFmmqF/IsOYvpJGavJt8aXDqFD+OGJ+WdoGCCIH8Z0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eIO9zKl3MxGVvozr8sBtFnmFKRgd/v095YrUxaa+m0PVyuNRN
	ulcymGzaCv5fPhS1bvIaqg8Umiw8hnVfucRrSVJcZ2YmEdMpmxtfpdk=
X-Gm-Gg: AZFdTZciytMd5QgXYosXSD7a3KdaC34MPt7iifDG/ffeo6u1DPiaTNoG3BW1OdfcIJQ
	NtZ2nBK97g5hUDNPaq4ruW6SEaXVW6XNkY9axjDQ5ktdmy3g0yAkwsVhHigiF0syhx4dKyKmXoL
	MPAwzvlNReXcyqklqSVnzxu/TzCYSsyPSSKKB8OD6VSM4eGddl8gm3f/tPaNC2jRZHWhcG7md41
	DC0FVF88yCxi68tFHe6+Lhu5wrRx6vjHE1n206Fo1wkH9mDfoULgdWBF+4yyolGRk44XwaQsam7
	Br1TJbRH7tqTtj4qeXbwG4bLgMe7kkbuLoqXSjEY2kInAlFmI6hTIN7vuV4hn/zvlTd4AlgSsBK
	lbhQI+GNT2r3ecZxkgZaGJx3uIvi/QdG7uZ/1sVS+Ax5tuxqZ00UTxlMNeuYyCwgmxjjsH8v6Xt
	dRM27aE+cqPEUAfCp3/o98XqtTWfh8Hbuy3pbDqeNAvnD0b2JYQ7IdsQK1MSbjINOK5Nd6y5YwY
	tXz8QJHPtNmuPM4fZftvnPltt/yPUsPRKIJw5ZkV4/W5Vpe/tChJAUk4mfPDT7zoszcz86GCeAi
	VuVbHH2PXzgzy/0=
X-Received: by 2002:a05:600c:5306:b0:4b7:6aac:7406 with SMTP id 5b1f17b1804b1-4bb887ca0bamr418564775e9.3.1795738607398;
        Thu, 26 Nov 2026 16:16:47 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm356650865e9.3.2026.11.26.16.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:16:46 -0800 (PST)
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
Subject: [PATCH v2 nf 1/5] netfilter: xt_owner: pin file with get_file_active before reading f_cred
Date: Fri, 27 Nov 2026 00:16:33 +0000
Message-ID: <20261127001637.1026589-2-tristmd@gmail.com>
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

owner_mt() reads sk->sk_socket->file->f_cred without holding a
reference to the file. Since the file slab uses SLAB_TYPESAFE_BY_RCU,
a concurrent close() may free and recycle the file object, causing
stale credential data to be read through f_cred.

Pin the file with get_file_active() before accessing its credentials
and release with fput() afterwards.

Found by manual code inspection; not triggered at runtime.

Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/netfilter/xt_owner.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index 8f2e57b2a5868..75fcff0ce21aa 100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/file.h>
+#include <linux/fs.h>
 #include <linux/cred.h>
 
 #include <net/sock.h>
@@ -65,8 +66,8 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	const struct xt_owner_match_info *info = par->matchinfo;
 	struct sock *sk = skb_to_full_sk(skb);
 	struct net *net = xt_net(par);
-	const struct socket *sock;
-	const struct file *filp;
+	struct socket *sock;
+	struct file *filp;
 
 	if (!sk || !READ_ONCE(sk->sk_socket) || !net_eq(net, sock_net(sk)))
 		return (info->match ^ info->invert) == 0;
@@ -77,14 +78,13 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		 */
 		return false;
 
-	/* The sk pointer remains valid as long as the skb is. The sk_socket and
-	 * file pointer may become NULL if the socket is closed. Both structures
-	 * (including file->cred) are RCU freed which means they can be accessed
-	 * within a RCU read section.
-	 */
 	sock = READ_ONCE(sk->sk_socket);
-	filp = sock ? READ_ONCE(sock->file) : NULL;
-	if (filp == NULL)
+	if (!sock)
+		return ((info->match ^ info->invert) &
+		       (XT_OWNER_UID | XT_OWNER_GID)) == 0;
+
+	filp = get_file_active(&sock->file);
+	if (!filp)
 		return ((info->match ^ info->invert) &
 		       (XT_OWNER_UID | XT_OWNER_GID)) == 0;
 
@@ -94,8 +94,10 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 
 		if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
 		     uid_lte(filp->f_cred->fsuid, uid_max)) ^
-		    !(info->invert & XT_OWNER_UID))
+		    !(info->invert & XT_OWNER_UID)) {
+			fput(filp);
 			return false;
+		}
 	}
 
 	if (info->match & XT_OWNER_GID) {
@@ -120,10 +122,13 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			}
 		}
 
-		if (match ^ !(info->invert & XT_OWNER_GID))
+		if (match ^ !(info->invert & XT_OWNER_GID)) {
+			fput(filp);
 			return false;
+		}
 	}
 
+	fput(filp);
 	return true;
 }
 
-- 
2.47.3

