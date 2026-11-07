Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049703;
	b=W+roonuckeDG9VGJ8eeyVhCohZB+IWluZqY6ie5ig6tQ8rL+yxJ1C6JvO3qisxZWta5U
	 NHWlxCOubWN5duwmb/fXhumCAjMPxwxVIM49tCpqMrByEAJRhVJY8vrNf8eJtCo+YSCew
	 MI9v6D+jQXnVn3Av9AE3Beh3cSXlEq9nZx/vcf6ma4s/wwjfF3LxX+viyJYNBAtEPwU/e
	 t47h1utTWBpzqjemfsc3c2YllItiI3UnZEHM+jU9cyvl/QIwZTtX7LiZLWVY+n8XRQvDh
	 3U6QQWN21rl9HhJX7LUUEp0f2+vFsR/QBRo8b7mFq8ET+0hySrAcHckQ299ddBD6m+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qpKH6tgTeaJIE5Un6n8889tR4ds8sPar/0hgGf2E0KY=;
	b=eOKhcqygYtnE/mZoPyN/AA5/znmxlIDEZTNvg52rlOpCt/IRTl/vNq/eVQjxjUOI4DUI
	 /brzPBj4o88B5Qd5F67FFDwTvpZ3L4D6xngmn22vR8sI5d63yZ8o0/G/xzIYy0J87fGda
	 ae+X0z3qowCQx9/rpM1cgJqfmQ7ijchp55b58XRkdXA3CCf3o1KC7ub6bCqLVYSdP7i9T
	 ey/yjQguix9NSI8vwq/Bj0pc48Ftc5V+ibNiroQMtm7fG76UnCFDlEX37PTyPuI+BtNlK
	 aUGAIdaPpFya/G+eka5OuCGDI3TNJMyNHZ6/AEna5Xymbegr7zQS1RiGy9ElQtjMb3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5tkE0pF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F162606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5tkE0pF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967621F0089F;
	Sat,  7 Nov 2026 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049703;
	bh=qpKH6tgTeaJIE5Un6n8889tR4ds8sPar/0hgGf2E0KY=;
	h=From:To:Cc:Subject:Date;
	b=F5tkE0pFr/6ZoIC8xVlYfMw/2DYFezDDKyal/hqH9AuBC05gH5h2eniDslH+Yi9cJ
	 KW5tiRHbY2cffNXd5Qojo6Ul9i/3FbkhGAdz2Q9HnszN4oXQUyxgn11Rh+8adfZ/9g
	 fHhHrufy8g+VD2PFFKd0tGXJwIuyZA7l8XxliOP+BgeD9G0UBFKVG4scc2qjXlNpUm
	 XfZviFAL7XFPxJQd+ZWbKoQEaTPwNHNMH3CM+m7ziJaqZNGMv5IjbNF8ZwmxEDMfWl
	 I+GtkY9S2wVNEt6BWW0nMSroHYSw2HrilMNmWSIQQQWuzCmSMgSUdHrkNwWdCpLnDQ
	 IraRAusxQGJTg==
From: Sasha Levin <sashal@kernel.org>
To: kylebot@openai.com,
	david.lee@trailofbits.com,
	pablo@netfilter.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] netfilter: nf_reject: initialize IPCB at inet ingress" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:08:21 -0500
Message-ID: <20261107060821-failed-5.15-73a73d442f99@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 73a73d442f9986353fe284bd1b504d0313d0f153
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060821-failed-5.15-73a73d442f99@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 73a73d442f9986353fe284bd1b504d0313d0f153 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Wed, 7 Oct 2026 23:01:00 +0200
Subject: [PATCH] netfilter: nf_reject: initialize IPCB at inet ingress

The inet ingress hook runs before ip_rcv_core() and ip6_rcv_core(), so
neither IPCB nor IP6CB has been initialized when nft_reject_inet passes
a packet to nf_send_unreach() or nf_send_unreach6(). skb->cb can
therefore retain metadata from an earlier protocol layer.

For IPv4, icmp_send() treats IPCB(skb)->opt as parsed IPv4 options.
Stale option offsets can make __ip_options_echo() copy an
attacker-controlled length into its 40-byte reply option buffer and
overflow the stack. On an unpatched v7.2-rc5 kernel, the IPv4
reproducer produced:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo()
  Write of size 255

For IPv6, icmpv6_send() consumes IP6CB(skb) as parsed IPv6 metadata. It
always uses iif for source selection and, when MIP6 is enabled, uses
dsthao as an extension-header offset. These fields must not be stale.

For NF_INET_INGRESS, clear the address-family-specific control block and
restore its input interface before constructing the ICMP error.  This
matches similar initialization normally performed by ip_rcv_core() and
ip6_rcv_core().

Fixes: 117ca1f8920c ("netfilter: nft_reject_inet: allow to use reject from inet ingress")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/ipv4/netfilter/nf_reject_ipv4.c | 5 +++++
 net/ipv6/netfilter/nf_reject_ipv6.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 59ec465a9df98..7cb33af671e26 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -357,6 +357,11 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (!skb_valid_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
 		return;
 
+	if (hook == NF_INET_INGRESS) {
+		memset(IPCB(skb_in), 0, sizeof(*IPCB(skb_in)));
+		IPCB(skb_in)->iif = skb_in->skb_iif;
+	}
+
 	if (skb_csum_unnecessary(skb_in) ||
 	    !nf_reject_verify_csum(skb_in, dataoff, proto)) {
 		icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 07cdaa10da0d0..5e08d8529cc88 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -444,6 +444,11 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
 	if (hooknum == NF_INET_LOCAL_OUT && skb_in->dev == NULL)
 		skb_in->dev = net->loopback_dev;
 
+	if (hooknum == NF_INET_INGRESS) {
+		memset(IP6CB(skb_in), 0, sizeof(*IP6CB(skb_in)));
+		IP6CB(skb_in)->iif = skb_in->skb_iif;
+	}
+
 	if (!skb_valid_dst(skb_in) && nf_reject6_fill_skb_dst(skb_in) < 0)
 		return;
 
-- 
2.53.0




