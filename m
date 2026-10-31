Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793491054;
	b=VN/OkA4eLBKVlAfl1Egai6xbpm2RY206TTAx3s+5S2XfkunI+whAk8clW9wMztFhufHj
	 H1uuXRkh7VMMVxHoUhrSG2xJ95ZNdATXAV1/lU9+bv/o73bob3bu2PaOU3GZ7pX/nr7Fp
	 +dM+nrrr96pUEV5O8UiGQyhPEwz2BLCDu7Tix43LWnvMET6v7kp8hmFXwNr7COnng7HFI
	 2qAw8qD2IQ2wE8d3/YcDK5wc9J0F7yE0NPo3baGqWDUxaTPbeoXwgLllww9oSOnSxzIL0
	 iP7kpXeg0RTh8FGCnVkX/vhyJxt2FWezAnnP6OspO/5NW3KM3HjFHK9rXY3zkOl6Cwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793491054;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ysWUmcxgVRXv2jQI8n69SegsVOhd/dtKdXxdVfo7JLM=;
	b=0+QuEWcPXB3zy5nuMiEF3vEmbrujnINYRvOhf9w/jGi8C0xzXJdshdcpZ+0MSDFv53v4
	 IKOuDn54YtHIW5ZswihBetwDO4SuRDRZE4rpsayWJpYe6okgCyz9FCn1/YaI16/3Prg6D
	 NgwuE6MZBmwhHtjcsKggzOyEs7aYVZUusU1+E40Sh6S9rkQPPE5uJztHMyd1ZHXVjHb5f
	 2+mm/VAEcqewAQzgsWGLDXdk+RTSMmuJ0XXqTyIsZRZ0p8MlBZVB9DeZL8NQ14S6MNg15
	 bosNp6ApwrFBh5JaNryXE7kGd9zkEhaFAl5L1UgFS1CYVdxXPAJUszgk49Li9GreXMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=pB1hre5h;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=Yd6iqCpX;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E895A606A31C;
	Sat, 31 Oct 2026 23:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E895A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=pB1hre5h;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=Yd6iqCpX
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793491007; bh=ysWUmcxgVRXv2jQI8n69Seg
	sVOhd/dtKdXxdVfo7JLM=; b=pB1hre5hAAkfc0jGIwgRRWwiOalmOObNdf98xXxeUScj3UJ/oT
	nyBfIucryEdQF+QGs/OKBvOExqqTRvUz7yAImSr/EXLqFSDWWfuEerCg4CAJRitACX/IjKEDqbg
	K4HaljVFDt0F8WrnVSaN+w8VQS4fEVHJVmpCSYHOqt2MEcyphXMzVsdZ7AG2o0b04RGiCi5ALQs
	2pBoOEkE+nJv1YoJ8Pc51X4k9KXueBy+B6n1pZ8UG427kpCzjQheL0H+yUrAgYT2T29vdqgb33R
	Qc0+H11NtBu47ghZpOZK3Fn6EfuBPudgP68IyG/+XQXVvfX+WeNc3DMX0d+XHa4YRFw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793491007; bh=ysWUmcxgVRXv2jQI8n69Seg
	sVOhd/dtKdXxdVfo7JLM=; b=Yd6iqCpX1oOWvqiNIDuB4WCPkf06X8/KvpPF73LxUXzFLJ9bMN
	9H8TigSMJCeMuYbSS4IqDFB5GJKvKtns84BQ==;
Date: Sat, 31 Oct 2026 23:56:47 +0000
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
CC: audit@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] audit: fix UAF in kauditd_send_queue()
In-Reply-To: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
Message-ID: <6F0EE0A0-10C3-4B96-AD77-A6952672CDB7@mainlining.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 31 October 2026 21:12:59 GMT, "Jérémy Jean"
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>kauditd_send_queue() grabs an extra reference to the skb header before
>netlink_unicast() since it may need to retry a failed send. If unicast
>delivery reuses that same header, the receive path stores the
>destination socket in skb->sk without taking a socket reference.
>Consequently, after the receiver consumes the skb and closes the
>socket, the extra reference taken on the skb header makes kauditd
>release a header whose skb->sk points to freed socket storage.
>
>KASAN reports a UAF as:
>
>  BUG: KASAN: slab-use-after-free in sock_rfree+0x44/0x140
>  Write of size 4 at addr ffff888004f94140 by task kauditd/31
>
>Clone the header before netlink_unicast(), then use the clone for
>delivery and keep the original skb only for retries. If cloning fails,
>handle it as -EAGAIN so the send can be retried.
>
>Fixes: f3d357b09295 ("Audit: save audit_backlog_limit audit messages in case auditd comes back")
>Cc: stable@vger.kernel.org

What I cant work out from the changelog is where netlink_trim() went.
With users == 2 it usually clones for you anyway (skb_shared() is just
users != 1) and then the receiver owns a different struct, so this
couldnt happen. Unless it took the early return:

	if (is_vmalloc_addr(skb->head) || delta * 2 < skb->truesize)
		return skb;

Which one was it? If its the delta side then its the tightly filled
records that trip this, which explains 18 years of silence pretty well.
It also tells us what this costs, where trim would have cloned anyway
you just moved the clone, otherwise you pay one small slab alloc per
record.

>Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>---
> kernel/audit.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/audit.c b/kernel/audit.c
>index 9412af9144bc..5e739fa606be 100644
>--- a/kernel/audit.c
>+++ b/kernel/audit.c
>@@ -790,6 +790,7 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
> {
> 	int rc = 0;
> 	struct sk_buff *skb = NULL;
>+	struct sk_buff *skb_to_send;
> 	struct sk_buff *skb_tail;
> 	unsigned int failed = 0;
> 
>@@ -810,9 +811,11 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
> 		}
> 
> retry:
>-		/* grab an extra skb reference in case of error */
>-		skb_get(skb);
>-		rc = netlink_unicast(sk, skb, portid, 0);
>+		/* Keep the original header unowned for retries. */


A header isnt a skb, and the comment you deleted said skb. Also this
line is where the why belongs, since the why is the bug itself. e.g,

		/* netlink remembers the sock in skb->sk with no ref,
		 * so send a clone and keep the original clean
		 */


>+		skb_to_send = skb_clone(skb, GFP_KERNEL);
>+		/* Preserve the connection on a temporary allocation failure. */

Well, this one doesnt preserve the connection.. -EAGAIN falls into the
same bail branch which does sk = NULL and then squashes rc to 0, so
once the alloc failures hit retry_limit the connection is gone anyway.

It also eats a slot of ++failed for what is really just an ENOMEM and
not a send failure. Might be fine! but the comment says the opposite of
the code, can you make it match?

>+		rc = skb_to_send ?
>+			netlink_unicast(sk, skb_to_send, portid, 0) : -EAGAIN;
> 		if (rc < 0) {
> 			/* send failed - try a few times unless fatal error */
> 			if (++failed >= retry_limit ||
>@@ -827,7 +830,7 @@ retry:
> 			} else
> 				goto retry;
> 		} else {
>-			/* skb sent - drop the extra reference and continue */
>+			/* skb sent - consume the original and continue */
> 			consume_skb(skb);
> 			failed = 0;
> 		}
>

--- Thanks!
