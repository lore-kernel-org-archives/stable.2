Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907857;
	b=CdfLFusJg6Qa0baS9gqo/2FwbqqMqusNNnVh/PlibY+a9zkmok1fuGzXn/zZzcl2VjTY
	 v0oH9kbZpLE3lD0BIT1YzD6Ek2OwX567SjEtcQpsoDBtM59U31oy+IW7pAatURnRT2jGH
	 C/5A1661GnOgAQWiniDs7jUfppQjAG4D2Q2VMsof6ce4iLV1HNbZACUr4KC59bJkBY1Mm
	 jp4SIm623uxDrIojI0PoyuNidxyeAOeyssRD5gPekMFWKC+iG5EIOrHi5MTll7IQZWbQp
	 i0ZJh6tYjyizNAaxuEwuCHa760RVvBYVQvp0DexhsnD2VVD3lj8yHN9rzcYg1hLI4tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907857;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=bBEAv3UO3ZxF4T+NmNpnI6CeqCaeMtA6CzKXaO3Q5og=;
	b=N2MeyFk1F73S5Ajryhqjp5hH2cfgoiKCZz+mXeQVIn2xhzLhmtZ4p3EejB/z5j9Z+Wby
	 fBdRcweWt+3K0HAPZ9QJngzR/zSHfgYLDVwSxc3s0nnL1HQw5NqqRAXhXUcUb5RtarPQh
	 ljj2kIAoy/uDEdL1F6/+XsXaecGYTOmrwCOh3k277CiyxpsfhMnhJ2nSXpaNiusKnzwkF
	 GUc5356BB21SQqKSeBnh3h9WWlL5Oe0cKN4Y787beOT3FMZlR9dT3UPDR+MwkbW0KlsSR
	 qBGgQ2xUjtTIhPNxRXBRAM+y3X37GWxFIQJDTF2xaZC0UyFRdyeUa60ulPDzjcA6NfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Jyi4g1Qe;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4056606A6C2;
	Thu,  5 Nov 2026 19:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4056606A6C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Jyi4g1Qe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=bBEAv3UO3ZxF4T+NmNpnI6CeqCaeMtA6CzKXaO3Q5og=; b=Jyi4g1QetjEvOrlqt8id4ElKvb
	dowv/IcXcedK74YGJbecI1hIHe3uBFFM6/Hmzy37aFHs+uLcJzC7y3kCHVtyOKns0ojJCrIn2aHOT
	H4RBo1tUoCh1NQu1hC2QoVGBZ/39k6h79qkzrrFDX0obUtTL71ZkRa6VnNXgwERdIXv9YYmMuJbXw
	YPYvG5AlCYy2ZyVrFD+sUDgl/dG4xTAKbp+KvPajmV87gXflWINJAZDpXguElZHiOF4wTOU+G5+ub
	cOTpU96i8INWNEGcjd8F4367d9Yq+jyHKJiccO0pR+Aqh8z7EkygCj0J79Iu9AR5BRddQ9sAa1YlG
	5mEl2w9g==;
Received: from [::1] (port=36730 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xP3Na-00000009EsF-3Ace;
	Thu, 05 Nov 2026 20:44:08 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 05 Nov 2026 20:44:08 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Paul Moore <paul@paul-moore.com>, Bradley Morgan <brads@mainlining.org>
Cc: Eric Paris <eparis@redhat.com>, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] audit: fix UAF in kauditd_send_queue()
In-Reply-To: <b446cedf8a7977337389f8cdc1e5acce@paul-moore.com>
References: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <b446cedf8a7977337389f8cdc1e5acce@paul-moore.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <341401a3fa5863542319566051bde1ea@oss.cyber.gouv.fr>
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

On 2026-11-04 21:36, Paul Moore wrote:
> On Oct 31, 2026 Bradley Morgan <brads@mainlining.org> wrote:
>> 
>> kauditd_send_queue() grabs an extra reference to the skb header before
>> netlink_unicast() since it may need to retry a failed send. If unicast
>> delivery reuses that same header, the receive path stores the
>> destination socket in skb->sk without taking a socket reference.
>> Consequently, after the receiver consumes the skb and closes the
>> socket, the extra reference taken on the skb header makes kauditd
>> release a header whose skb->sk points to freed socket storage.
>> 
>> KASAN reports a UAF as:
>> 
>>   BUG: KASAN: slab-use-after-free in sock_rfree+0x44/0x140
>>   Write of size 4 at addr ffff888004f94140 by task kauditd/31
>> 
>> Clone the header before netlink_unicast(), then use the clone for
>> delivery and keep the original skb only for retries. If cloning fails,
>> handle it as -EAGAIN so the send can be retried.
>> 
>> Fixes: f3d357b09295 ("Audit: save audit_backlog_limit audit messages 
>> in case auditd comes back")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> ---
>>  kernel/audit.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>> 
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 9412af9144bc..5e739fa606be 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -790,6 +790,7 @@ static int kauditd_send_queue(struct sock *sk, u32 
>> portid,
>>  {
>>  	int rc = 0;
>>  	struct sk_buff *skb = NULL;
>> +	struct sk_buff *skb_to_send;
>>  	struct sk_buff *skb_tail;
>>  	unsigned int failed = 0;
>> 
>> @@ -810,9 +811,11 @@ static int kauditd_send_queue(struct sock *sk, 
>> u32 portid,
>>  		}
>> 
>>  retry:
>> -		/* grab an extra skb reference in case of error */
>> -		skb_get(skb);
>> -		rc = netlink_unicast(sk, skb, portid, 0);
>> +		/* Keep the original header unowned for retries. */
>> +		skb_to_send = skb_clone(skb, GFP_KERNEL);
> 
> As Bradley pointed out, this appears a little confusing as the existing
> approach of skb_get()+netlink_unicast() should end up doing something
> very similar to what you are proposing due to netlink_unicast() calling
> into netlink_trim() which in this case should always end up doing a
> skb_clone().  I'm sure I'm missing something, can you help me 
> understand
> why this proposed patch is different and solves the problem?
> 
> Also, do you have a reproducer for this?

Dear Bradley and Paul,

Thanks for the comments. The fix is closely related to the current
code but the main difference is that netlink_trim() does not always
reach its skb_shared() clone path. Moving the clone earlier in the
execution avoids the UAF.

I do have a reproducer, which as Bradley pointed out, triggers the UAF
by indeed taking the early abort path with the delta * 2 < skb->truesize
condition in netlink_trim(). This makes netlink_trim() returns the
original shared skb, and this path does not reach clone of skb a few
lines later in netlink_trim(). In the fix, by calling skb_clone()
explicitely before the call to netlink_unicast(), audit keeps the
original skb, the clone is given to netlink, and the UAF is avoided.

I hope this clarifies.

Regards,
Jérémy
