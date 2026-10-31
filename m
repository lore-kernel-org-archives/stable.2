Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481361;
	b=NgvzJq84cxhEuyGoBI6M4u/uCA44hJ/cYpcaOArWpsy2WPhlXXvwRaJoYe7edymGZd5x
	 GyfKjad7STJSiVTb44SjnL+F0h1wi3FzFOpk9WHGYANos4TD3GdvlpTnb1XydZYcxyx1w
	 ISzNBU+cc/EOw8cJ8aJC4U2KGzvJohnlpSBGP1w4AtWSz+ddyzMfxTX+EHWmhTiS8BDR0
	 xrNZda8fyABMGLBEagYKhYuAnlJs9WbnGT2CFQhKuwnOQxuxVcMTPCynMGwgtZTcbtK/H
	 hW/75HO+/DF1e8bVKLg8dNl1Nr5R6DVT0+vE4/4Tfd3Ctzbk/xp2iOxqh/wzBVLBwhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481361;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=/ba8KQsZ3EiQOcT65AhgZE+XZiuOVWA08LshL8rUrYw=;
	b=4CerOia1FhJNFHO3SvreNZzSFt2rpJ3PLXrfse0PpTDU19HIuSHgOvVPt4qul7NMmnQv
	 756UE+olZhEGm5uJ5hfAhRIu3B0LC0+KJ4GYy2THR/JEC5yUVD6fzkySefiY/7tIz4bL6
	 xOAYKKmp8uV6X+dDdHZEsTH2779uK2Yh0x9YJ7AV5xmdixvVSV2WmH+IQrvpr2tjnQMvB
	 TR54FWx8cWNDfI8/fvMvu6j1gBK1B+MGt+wjeU79OLAROFGlDa57J1in2mtaw9zmkElsj
	 fUOjhlMm4u1Cln3ZeKckiDQmad97/SgYLigWowncqeFPR0AlyPUF//gPZp7H4Wn6QSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=BELv0g6d;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08B606A31A;
	Sat, 31 Oct 2026 21:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C08B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=BELv0g6d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=/ba8KQsZ3EiQOcT65AhgZE+XZiuOVWA08LshL8rUrYw=; b=BELv0g6d+CXyQ4T50I9WNXSiEm
	xZ1z/ufpnkaOh6RIBuS3mZv4cYN0z9MrPkyEeqI9Tp7AfORdtXEjr2CvjNjs/SM9vPyWQygAsAWHY
	qDejpKxe0mZ4W3sIBXKouKvSf+A1vkTuF8zF0j6+P/5QsVmEOAWBkxxQFO9hFutDAgV0LxCKGGj7M
	k2PMC79g+KjJdP2fBnCFwgRdNuw0pKoV9JRkH2H2xlTPEwtR1pFAEtFwIiP9XEwsbK9wTCrzT0xEP
	bAIrBUEjKnKCSMZ7A098Cn6gexy4IDwGBpm/T4QMLHAyhvTGmPelYjgywobXday2qclmF3faW7qaf
	ydv8SldQ==;
Received: from [151.115.150.205] (port=51266 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xNGQj-0000000DA0E-3Sis;
	Sat, 31 Oct 2026 22:15:58 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: Bradley Morgan <brads@mainlining.org>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] audit: fix UAF in kauditd_send_queue()
Date: Sat, 31 Oct 2026 21:12:59 +0000
Message-ID: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

kauditd_send_queue() grabs an extra reference to the skb header before
netlink_unicast() since it may need to retry a failed send. If unicast
delivery reuses that same header, the receive path stores the
destination socket in skb->sk without taking a socket reference.
Consequently, after the receiver consumes the skb and closes the
socket, the extra reference taken on the skb header makes kauditd
release a header whose skb->sk points to freed socket storage.

KASAN reports a UAF as:

  BUG: KASAN: slab-use-after-free in sock_rfree+0x44/0x140
  Write of size 4 at addr ffff888004f94140 by task kauditd/31

Clone the header before netlink_unicast(), then use the clone for
delivery and keep the original skb only for retries. If cloning fails,
handle it as -EAGAIN so the send can be retried.

Fixes: f3d357b09295 ("Audit: save audit_backlog_limit audit messages in case auditd comes back")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/audit.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9412af9144bc..5e739fa606be 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -790,6 +790,7 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
 {
 	int rc = 0;
 	struct sk_buff *skb = NULL;
+	struct sk_buff *skb_to_send;
 	struct sk_buff *skb_tail;
 	unsigned int failed = 0;
 
@@ -810,9 +811,11 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
 		}
 
 retry:
-		/* grab an extra skb reference in case of error */
-		skb_get(skb);
-		rc = netlink_unicast(sk, skb, portid, 0);
+		/* Keep the original header unowned for retries. */
+		skb_to_send = skb_clone(skb, GFP_KERNEL);
+		/* Preserve the connection on a temporary allocation failure. */
+		rc = skb_to_send ?
+			netlink_unicast(sk, skb_to_send, portid, 0) : -EAGAIN;
 		if (rc < 0) {
 			/* send failed - try a few times unless fatal error */
 			if (++failed >= retry_limit ||
@@ -827,7 +830,7 @@ retry:
 			} else
 				goto retry;
 		} else {
-			/* skb sent - drop the extra reference and continue */
+			/* skb sent - consume the original and continue */
 			consume_skb(skb);
 			failed = 0;
 		}
-- 
2.47.3

