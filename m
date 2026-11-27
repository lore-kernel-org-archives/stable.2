Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795738611;
	b=iHvoWVN3TaEgt79Q8SDN+K3u5dt90wauoUBpPqKoj9r1ZnZfRv9mrlAPc6HzGDjot23B
	 XAArgE2wrEy20m1aaYn30e3ibym3M/rnV1IabLS0zIo3nc7oskUJ+5j/I06D8+otEbBUW
	 wXEh5FqPUZaJH7ODDuPwAclsHp60nZGbZtuD8MEo6Qk3n3ctIcANyd1EEvjIhpU7pe8g0
	 wugEZg/Iw01ajVMfpia5uxv6NolCmsRfRLcc8rj/I+Tu0qfmXp8xvI8++WTFR11b2MKNh
	 JmlGf12O/Q0yNP5ugYWy/7scQS7Nolut54ZU7DhiOTA8+M0u76Ye9p7O1d4SUicCqCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795738611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FRTP8FO/eHZGhtNodRe4fi46UFA5HdjhjKCVqbUUh2w=;
	b=UJ2BHkNL12/QmQGPfq4w4bka/sZNprCr1zUu0faFe++o9jgVk588wyC+joiMH1lgBSBH
	 L/28NEB3jZVvI2yPiwQXxIl3jjVRhmICJUPnXpCxZHau6TSwAe28ZI3L3WitxFTdo/hVJ
	 y25JGuTp5lvVcSPOo9VNxXXVmG9OMaTop6DylTti4gk982xkTZ/vMlf76bXcO+V/45AEp
	 1ECFlrBm9bRR0V4fK9bujb7tGpbSneIh+2DLlx8pLK1XqbN4c+zhI0amlMJ/w0F0Sd5pO
	 675p2Qu7P5lsPpOIbkf6Vi91zjQ5sBphbBPoMOyRKEuP8yYic6zjaCVRTF9fmPpGl6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T34DF08R;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D960A2607
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531D960A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T34DF08R
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b467581b98so73117165e9.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795738610; x=1796343410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRTP8FO/eHZGhtNodRe4fi46UFA5HdjhjKCVqbUUh2w=;
        b=T34DF08RkclBqCp86/pbXD7dB5z9Qafib6EkPNsHvOuXnehvWwaTdcE+BsNxucSDfN
         4XsiBrWPynipFk+C/A2q8pjqaO0JWTyO/4qFJJAfxRecIRgjZE9BV2rW32JTVL3RiJs6
         CX8H0ARMJMDU09Bgr7ecaj4f9gF5bLK14MHa8L/j7a2mta74dKOEGWGJTNr5Z5Rg45jc
         QxtuHA968TZBD/zSTWXWYmeCCxeo9TL9xLdX25vtHMOHZkfSMN/htrrVL/XHzo93Rguw
         RvX3UmmWD8IhqExnbs4ia/wPAQxDcfUQY/UHDbYdYmTaujoz6Ogq5Ui17UB7WdIOWdKb
         k5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795738610; x=1796343410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FRTP8FO/eHZGhtNodRe4fi46UFA5HdjhjKCVqbUUh2w=;
        b=utz3w4lYWi7SFffrflkxZZbFF5wTGzPhTHn5sge8kzqoEeU2NJBicZXkcl9tyWTVq1
         mi5dK0ZGQz4gEfKcSqa4mRbqv6KZuphukt0HZksHFWToyH/hLA8HUv3xuFZnjen50mmp
         jHplTIfwJpUMe7/UefI9XIIlyyb3+79tQZGAZs53CarIHurhzzmMixJFDAIM6gWZ3uBg
         qVgbz141AaLnB3i++gEEMihZIYPX/oJ3RMZvsy10GrBkrJpC2jN1Uu9DSwSzWSzS87vY
         ncB73xftg31tap5wYqEuagy9vc+2Xnfhat2Z+bUR5nzpKi2GZiI6IM6n6HwsCEE7Vzkm
         Dwvg==
X-Forwarded-Encrypted: i=1; AL+hErFd1HMQvput0Mr555/WuuQZeyu80RkAu65/U2OkmSJYUqcveeAQxdilYZyNl1GVAF9RGbr2cnQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lDIkEZtaFjm8AruSvaDxmgzRFzbhpfNMeS0oT3ZAmuoihlzJ3
	1qlwfDz5HkqqofbPfAWjdYde6yJRbNfu4lgQvmTT8dOLivtf6MauOzA=
X-Gm-Gg: AZFdTZcoEFXsWYgDRykgjYw+cnIGF78nY+1ROf2LvN7ggtrq07LDXrNpFhYvgYzipMD
	sNJs4GPQ1TLhEPUe6C26o+a7kneRBuLZbsJl6g16yMcZ6ICrAgqdTAKgoqA6FSJ4ECDbu02WdBH
	7U89W8AB4fwRv/z40ZvQUOzBiEBsRugRmz8uPbyDu1ToSdC5eS/4kFeiyQrEqlV+XUKJ02uSzkL
	wstcfFukB/gK5y8MV1scFZ50I0y4neKJvMs0DNn8tf1VlZirpGzyo5wbslWdiPEwU+DjW45O/R0
	FMGE4KFKtLdboozPl9ZZHc8flzDjIUwG3tW/2uk6DRTGvRlKBsRzVFpucdnq6DetzxqxGzoyWW3
	arK/uNSihVNxcRXYASgy8qohbRaIgNNGkYR9L+ugX+Lldj0NcjlrBSoohR40K3VWSiVhpXmYFe6
	AdodfdP4KDQRsRiP+MDkzcnWWkrDJyiexutfHcg7kJxV8JWTTz3IqVvhF2o6MbrzcbPYuJZMhsQ
	E9oAmL2dsEXifIHKXK/oKfdApBiGkxujO7XxkQwc9xBIn9PKBWHKbSNRYDETpu8w4xnaRSLcbkz
	iawwHktDxe7enmE=
X-Received: by 2002:a05:600c:6298:b0:4bb:6375:aa41 with SMTP id 5b1f17b1804b1-4bb88934652mr434988635e9.27.1795738609584;
        Thu, 26 Nov 2026 16:16:49 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm356650865e9.3.2026.11.26.16.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:16:49 -0800 (PST)
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
Subject: [PATCH v2 nf 5/5] netfilter: nf_log_syslog: pin file with get_file_active before reading f_cred
Date: Fri, 27 Nov 2026 00:16:37 +0000
Message-ID: <20261127001637.1026589-6-tristmd@gmail.com>
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

nf_log_dump_sk_uid_gid() reads sk->sk_socket->file->f_cred without
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
 net/netfilter/nf_log_syslog.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index c3fd398ffcd77..dd15409100eba 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
+#include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/skbuff.h>
@@ -168,25 +169,24 @@ static struct nf_logger nf_arp_logger __read_mostly = {
 static void nf_log_dump_sk_uid_gid(struct net *net, struct nf_log_buf *m,
 				   struct sock *sk)
 {
-	const struct socket *sock;
-	const struct file *file;
+	struct socket *sock;
+	struct file *file;
 
 	if (!sk || !sk_fullsock(sk) || !net_eq(net, sock_net(sk)))
 		return;
 
-	/* The sk pointer remains valid as long as the skb is. The sk_socket and
-	 * file pointer may become NULL if the socket is closed. Both structures
-	 * (including file->cred) are RCU freed which means they can be accessed
-	 * within a RCU read section.
-	 */
 	sock = READ_ONCE(sk->sk_socket);
-	file = sock ? READ_ONCE(sock->file) : NULL;
-	if (file) {
-		const struct cred *cred = file->f_cred;
-
-		nf_log_buf_add(m, "UID=%u GID=%u ",
-			       from_kuid_munged(&init_user_ns, cred->fsuid),
-			       from_kgid_munged(&init_user_ns, cred->fsgid));
+	if (sock) {
+		file = get_file_active(&sock->file);
+		if (file) {
+			uid_t uid = from_kuid_munged(&init_user_ns,
+						    file->f_cred->fsuid);
+			gid_t gid = from_kgid_munged(&init_user_ns,
+						    file->f_cred->fsgid);
+
+			fput(file);
+			nf_log_buf_add(m, "UID=%u GID=%u ", uid, gid);
+		}
 	}
 }
 
-- 
2.47.3

