Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911782;
	b=F+2ELV3n6ievyKYKvHhT/0i1AYOJvpbfvUs5o1gY29h4mwH6l4W2YcEi4DKHQ3dcS4VR
	 l1W/6BGCSsNFVvLmvmFssclAU4VBzPc4vCjefHLwb1G3mQyuIqLcfRHZYLS2gbunub/QU
	 UpAjN09ill+d+mk3gP7sfk9BUQe+DNX5eOJz+LFBstejeSvktPejHbbnefp2BiryXhYn3
	 Gf9DjjingGgdAgAkShQhAJEVAJ7IKltYLQ5KeideitYUtEeY3cr99I77tkdEjlNGC/QBF
	 J4AY1ZMhlqu4rm942QXWgPX4uwwzdx20xQgYcQdnMSOqFUF09Jm8di0zdbfYEd1RGzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911782;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=Du4p69xKr9+AmnSRpFKYJ25KgktaivwBhjM59KvpxlI=;
	b=eJm2l6h3l9Ah2ohfsOT9l1NIwyHyj5vV0wq+8uvGqiW7S5ZQyoZIp6wT+pQgj7LU1aTY
	 mT48b6yU1iL84q2ysmIEXAvuCh6CWLokeftMHKNaPWUYSPp63xZsS/HrY1wNf7XpWMOva
	 slqvMu5x1G0oW4Lnmp+tz5xrzwDvbKIdVWOpTZuCwrvkFivNALrCixwJ9ixHIYxNXDMar
	 kJ5uvrhGQ2P0wxfxsvhAmYqPWd03U7I/Qkxa6wu0+7Mexv0GyzoqyqsOxiPxAzGwf2Wk3
	 NCfod96IaQ01m6pLX3GZaxIOrjPhHqxshLILT/gz2vZac0PcoVz23axIsWjTz8sh63A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=KR+fCUHu;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9445606A31C;
	Tue, 17 Nov 2026 10:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9445606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=KR+fCUHu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Du4p69xKr9+AmnSRpFKYJ25KgktaivwBhjM59KvpxlI=; b=KR+fCUHuTSr0QuKIvPJNzKc9N4
	/wPHeFctJ7tPjs3IYYPaRv8Jc5m4a/diEFghdBPeZ3rQkJ+0f4aw3LYhJsHZoeSo7HXVyBHfigKYM
	1N6gUNJdLO6YFdstE3Y80qT89dSHTb4midjKMJMukiLXxB6Zmv/uVMfSI3W0a7oTPuJgRPuifRX+l
	0U41+lMRI0+AHlEO2i0AEDA19DBnUAdEAmk9nOLHhpCWqS/DHc287GllMo1Lso7AxWY6KHLqrNEYh
	4fA2+KfsEBw46LchX873bFrjb/NA3oyg4MWGBQTClkx9FLtkr75yRbwdJ+OOfI+SQd0O6fePwuq2w
	3ycHXtcA==;
Received: from [::1] (port=35722 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xTGY1-00000005qNO-1NB8;
	Tue, 17 Nov 2026 11:36:19 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 17 Nov 2026 11:36:19 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Paul Moore <paul@paul-moore.com>
Cc: Bradley Morgan <brads@mainlining.org>, Eric Paris <eparis@redhat.com>,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] audit: fix UAF in kauditd_send_queue()
In-Reply-To: <CAHC9VhQECaSwpjUgSoCgZAgEphEk2jKnZFESn4ivM6JAjrC7HQ@mail.gmail.com>
References: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <b446cedf8a7977337389f8cdc1e5acce@paul-moore.com>
 <341401a3fa5863542319566051bde1ea@oss.cyber.gouv.fr>
 <CAHC9VhQECaSwpjUgSoCgZAgEphEk2jKnZFESn4ivM6JAjrC7HQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <a9f7228c3ab1989bc1b26a0f4e686293@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
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

On 2026-11-16 20:44, Paul Moore wrote:
> On Thu, Nov 5, 2026 at 2:44 PM Jérémy Jean
> <jeremy.jean@oss.cyber.gouv.fr> wrote:
>> On 2026-11-04 21:36, Paul Moore wrote:
>> > On Oct 31, 2026 Bradley Morgan <brads@mainlining.org> wrote:
>> >>
>> >> kauditd_send_queue() grabs an extra reference to the skb header before
>> >> netlink_unicast() since it may need to retry a failed send. If unicast
>> >> delivery reuses that same header, the receive path stores the
>> >> destination socket in skb->sk without taking a socket reference.
>> >> Consequently, after the receiver consumes the skb and closes the
>> >> socket, the extra reference taken on the skb header makes kauditd
>> >> release a header whose skb->sk points to freed socket storage.
>> >>
>> >> KASAN reports a UAF as:
>> >>
>> >>   BUG: KASAN: slab-use-after-free in sock_rfree+0x44/0x140
>> >>   Write of size 4 at addr ffff888004f94140 by task kauditd/31
>> >>
>> >> Clone the header before netlink_unicast(), then use the clone for
>> >> delivery and keep the original skb only for retries. If cloning fails,
>> >> handle it as -EAGAIN so the send can be retried.
>> >>
>> >> Fixes: f3d357b09295 ("Audit: save audit_backlog_limit audit messages
>> >> in case auditd comes back")
>> >> Cc: stable@vger.kernel.org
>> >> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> >> ---
>> >>  kernel/audit.c | 11 +++++++----
>> >>  1 file changed, 7 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/kernel/audit.c b/kernel/audit.c
>> >> index 9412af9144bc..5e739fa606be 100644
>> >> --- a/kernel/audit.c
>> >> +++ b/kernel/audit.c
>> >> @@ -790,6 +790,7 @@ static int kauditd_send_queue(struct sock *sk, u32
>> >> portid,
>> >>  {
>> >>      int rc = 0;
>> >>      struct sk_buff *skb = NULL;
>> >> +    struct sk_buff *skb_to_send;
>> >>      struct sk_buff *skb_tail;
>> >>      unsigned int failed = 0;
>> >>
>> >> @@ -810,9 +811,11 @@ static int kauditd_send_queue(struct sock *sk,
>> >> u32 portid,
>> >>              }
>> >>
>> >>  retry:
>> >> -            /* grab an extra skb reference in case of error */
>> >> -            skb_get(skb);
>> >> -            rc = netlink_unicast(sk, skb, portid, 0);
>> >> +            /* Keep the original header unowned for retries. */
>> >> +            skb_to_send = skb_clone(skb, GFP_KERNEL);
>> >
>> > As Bradley pointed out, this appears a little confusing as the existing
>> > approach of skb_get()+netlink_unicast() should end up doing something
>> > very similar to what you are proposing due to netlink_unicast() calling
>> > into netlink_trim() which in this case should always end up doing a
>> > skb_clone().  I'm sure I'm missing something, can you help me
>> > understand
>> > why this proposed patch is different and solves the problem?
>> >
>> > Also, do you have a reproducer for this?
>> 
>> Dear Bradley and Paul,
>> 
>> Thanks for the comments. The fix is closely related to the current
>> code but the main difference is that netlink_trim() does not always
>> reach its skb_shared() clone path. Moving the clone earlier in the
>> execution avoids the UAF.
> 
> Thanks for the detail.  With that in mind, I think doing our own
> clone() is okay, but the ternary operator for error handling is a
> little uglier than I would like in this case.  Removing that, tweaking
> some variable names and comments, how about something like this:
> 
>   /* clone the skb for retries in case of error */
>   skb_clone = skb_clone(...);
>   if (skb_clone)
>     rc = netlink_unicast(...);
>   else
>     rc = -EAGAIN;
>   if (rc < 0) {
>     ...
>   } else {
>     /* consume the clone and continue */
>     consume_skb(skb_clone);
>     failed = 0;
>   }

Hello Paul,

Thanks for the answer and the suggestion. Here is a rework of the
code to follow the overall structure you suggested.

I have added a call to skb_queue_head() on the skb_clone() failure
path to return the unsent skb to its queue to retry sending later.

If this looks good enough to you, I can submit a v2.

Regards,
Jérémy

diff --git a/kernel/audit.c b/kernel/audit.c
index 9412af9..ed050f1 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -790,6 +790,7 @@ static int kauditd_send_queue(struct sock *sk, u32 
portid,
  {
         int rc = 0;
         struct sk_buff *skb = NULL;
+       struct sk_buff *skb_retry;
         struct sk_buff *skb_tail;
         unsigned int failed = 0;

@@ -810,10 +811,24 @@ static int kauditd_send_queue(struct sock *sk, u32 
portid,
                 }

  retry:
-               /* grab an extra skb reference in case of error */
-               skb_get(skb);
-               rc = netlink_unicast(sk, skb, portid, 0);
+               /* clone the skb for retries in case of error */
+               skb_retry = skb_clone(skb, GFP_KERNEL);
+               if (skb_retry)
+                       rc = netlink_unicast(sk, skb, portid, 0);
+               else
+                       rc = -EAGAIN;
                 if (rc < 0) {
+                       if (!skb_retry) {
+                               /* No send was attempted, so return the 
skb for a later pass. */
+                               skb_queue_head(queue, skb);
+                               rc = 0;
+                               break;
+                       }
+
+                       if (skb == skb_tail)
+                               skb_tail = skb_retry;
+                       skb = skb_retry;
+
                         /* send failed - try a few times unless fatal 
error */
                         if (++failed >= retry_limit ||
                             rc == -ECONNREFUSED || rc == -EPERM) {
@@ -827,8 +842,8 @@ retry:
                         } else
                                 goto retry;
                 } else {
-                       /* skb sent - drop the extra reference and 
continue */
-                       consume_skb(skb);
+                       /* consume the clone and continue */
+                       consume_skb(skb_retry);
                         failed = 0;
                 }
         }
