Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795738610;
	b=th0S1cwE9vaduAUArpf7jGKxcqrQs2NQcopJkMXIg11dUYQZ4ouMZv8L8p/ZOnJVuqZ2
	 BR40h9bA390tDvgsXzJxBFHUkYP8a3cgvWTQzw7ieyXyH0cpKy1tq8iSGIxjGqDh5nbJs
	 AG1T/32hdfu/W36E7StX0X+1zfdgDwKp9xDRK6X+Xu+jJNmFwb4uhuPDC/EFEyDbyHIhj
	 r3kkP4DULLMmqS8r5XwXvamOeBCva6GKJ3eDPGNfBSB97QLibf9aq3kS/PjOvYpN460Sb
	 D9Pd6RQZpz6+qBgcZ0p00ZGmoV5CEMeMXdnYvvgr7DlX4lrvYNpcBIETulLJScMxwBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795738610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9nVnoKawCciJJKvofe0ViAurGqoccYhIy4wdIXnHSVE=;
	b=DSIIkERsoewKOAqah8244DPNE0FNl4qsI+cPJ2BfmJ49yYiR3kqfMdqw36goSHUy+tQG
	 jWIA7jd1Va0OYzsWB1wyBqWhidWc14fE0JdMDbRzMgnBX85HK1bDSD0NrSShjIqpvL96o
	 fGkVxbIvcSbc1nR4BbTp8hQ4owjawF59DFpHWdRLeSiV0+0MdVczujds6X0r5N7dUL9Ll
	 VYY4AI9WbaVzfEyuu0jhgNUvW9N0+Ufd5Q9bRRKTEIME3OOS+RMg9sdJzBxUsCrsZ5hfx
	 0HzQno7W5x4RcyckYIC1BczBMY46dYEAjY92zl1S0c8iVkHiUSuieheXZGkx1TNhN3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gTyRMsh9;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54186606A69B
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54186606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gTyRMsh9
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4a42b34e930so6607102f8f.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795738608; x=1796343408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9nVnoKawCciJJKvofe0ViAurGqoccYhIy4wdIXnHSVE=;
        b=gTyRMsh9XGGeLgDZLXjO7XZSKbo+yBjLM9WRsFDN86Q2ovOeLCH4qChPqGozxhmVNS
         C2hqkmY72B9gawQh8BMCZ6/54ms0o4T9rs+rsOh2aIDIXYh6z9F6RyBrum53dxgrvaRw
         W/qFLObMtiCACdySief3G1IBZBuRQKL6je9gxQSBn1ObifSbv66SJclVPcGQPdSzX+Aj
         mc426/+ugAtnGKpvXPrRgCDd3nex+ulW9xLKvRye/jQHADqFebQQcpbRhgwiPPAddgDm
         NjIPr5CmPEsadmfz2cNBp3zC+g/dTY558D23aERp/PjEyOI5dvFcP3ytmzMbGoLxjM4a
         9H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795738608; x=1796343408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9nVnoKawCciJJKvofe0ViAurGqoccYhIy4wdIXnHSVE=;
        b=CyPywmbTUdidxrnMhmA2+vrXG97z7lTMowKb9njrytnCRtEfxROCRWtv5JlPHYk4+M
         eLl7aliR+9oKWcipcnazzHfK25eCJE0so7YDJ1EISGM6RVvw4nWRyxqQwT2acg6S4epr
         tlMpHpG9D3zhI0lMc9jAoaMe4FWqMm5B1qavDBMHZzTioz8B8lFr733Z7hRwwdyA9kcX
         D4NbABjNczPhurFWjyk6eh/gysifBTDtOXMfpEkP9ZwMcyITefHH4cZtQ11RQP2HleUG
         lW9ol2B7DaIsZA8Ory+z1sSrhKJiBy12aa4AeFUkfCSvUr+ORqkWtE/EtEHnf1kZXji/
         ECRw==
X-Forwarded-Encrypted: i=1; AL+hErFTsqQwisTbfHkoDgpwFAuFWk5F5i1aDIrD/m5Y99fdCFXbGhWymej2xmA7Nu7RpCH+aU7UL30=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w9fs3XpIqTkNBmLvMbnI0NwubEZxE8lTAwKCB81aqV41bpT7t
	MBZXEqsmBcXFq5pD3F7x7TE9KGNXVGcTH552sc1dp8Pz74L1BhmN3Js=
X-Gm-Gg: AZFdTZeKappVJQsMfpDcRmclFr0iu0etbqI1zvIVfiUfSzC7yFrCcZ30ZzL/PWt4FtV
	qXDOQLtJUg9fSQYggxlVwNg3YgZil+5/5yY4Im7jmQeb7EciWmviA8HjOKThPdg4OA7wEADb2Zn
	eFL6gqCHgda21Cdfkrnxc8DSiiIQSNrTcmkRN/HhAJ+QjFlPToY39ZaRqgjCmLLqyQtkuPEHPjt
	rO/w3zX8cfd9rZfwgMI52Txlx0a9ExooH/3Hfl+K8sV2tQe+wm0/PqzWN3UbpFpHoOAaMI9Ub1j
	uZOtG/zk9j/cVgCy3/dgtpjl53W/UiXxDoSh8Y3i+vNACbDR2COGHNSWDomFYt/PegYdPjWZYfF
	cdDRAS4TQCiKdi2tkPexlup6Y8Dt/6FennqMTn/OMlvOOGZgkB2zL5BqcDvpSmbhDYVokiVpjI9
	vyYDwJmaOkkyZzD1laOVjHvSK5stfrvkALEGYuPC1RUsi+Hvow/IEWs/TOAcbSeJyvlVmXK/xIF
	Cbli45SBEaS4Ijs6d3X/E69TtN6Vhr/DUJrStLxpkN2QlbObn/P9leBdg/4k6p57ZIDFil6QtFD
	C9rcq6mU3SOvhRc=
X-Received: by 2002:a05:600c:83ca:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4bb888176eamr461715755e9.29.1795738608524;
        Thu, 26 Nov 2026 16:16:48 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm356650865e9.3.2026.11.26.16.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:16:48 -0800 (PST)
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
Subject: [PATCH v2 nf 3/5] netfilter: nfnetlink_log: pin file with get_file_active before reading f_cred
Date: Fri, 27 Nov 2026 00:16:35 +0000
Message-ID: <20261127001637.1026589-4-tristmd@gmail.com>
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

__build_packet_message() reads sk->sk_socket->file->f_cred without
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
 net/netfilter/nfnetlink_log.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index d923f2cb13980..d4fe9a12088f4 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -28,6 +28,7 @@
 #include <linux/spinlock.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
+#include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/list.h>
 #include <linux/slab.h>
@@ -632,25 +633,23 @@ __build_packet_message(struct nfnl_log_net *log,
 	/* UID */
 	sk = skb->sk;
 	if (sk && sk_fullsock(sk)) {
-		const struct socket *sock;
-		const struct file *file;
-
-		/* The sk pointer remains valid as long as the skb is.
-		 * The sk_socket and file pointer may become NULL
-		 * if the socket is closed.
-		 * Both structures (including file->cred) are RCU freed
-		 * which means they can be accessed within a RCU read section.
-		 */
+		struct socket *sock;
+		struct file *file;
+
 		sock = READ_ONCE(sk->sk_socket);
-		file = sock ? READ_ONCE(sock->file) : NULL;
-		if (file) {
-			const struct cred *cred = file->f_cred;
-			struct user_namespace *user_ns = inst->peer_user_ns;
-			__be32 uid = htonl(from_kuid_munged(user_ns, cred->fsuid));
-			__be32 gid = htonl(from_kgid_munged(user_ns, cred->fsgid));
-			if (nla_put_be32(inst->skb, NFULA_UID, uid) ||
-			    nla_put_be32(inst->skb, NFULA_GID, gid))
-				goto nla_put_failure;
+		if (sock) {
+			file = get_file_active(&sock->file);
+			if (file) {
+				const struct cred *cred = file->f_cred;
+				struct user_namespace *user_ns = inst->peer_user_ns;
+				__be32 uid = htonl(from_kuid_munged(user_ns, cred->fsuid));
+				__be32 gid = htonl(from_kgid_munged(user_ns, cred->fsgid));
+
+				fput(file);
+				if (nla_put_be32(inst->skb, NFULA_UID, uid) ||
+				    nla_put_be32(inst->skb, NFULA_GID, gid))
+					goto nla_put_failure;
+			}
 		}
 	}
 
-- 
2.47.3

