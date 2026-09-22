Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB032EEE85;
	Tue, 22 Sep 2026 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048968; cv=none; b=u+FaVPueSgl+g0LG/fZz6u/VkJh69auQGKSHq2Bv2YnSVWRdfbA8WROT5butTQBeo/Fc0nkEczFk4W9pmCeM0STzivZOYL+LwN3BNZapoczZAWgc8rhzIYxvQe2LlUk/61IW1jMp66dBRifM0IhXYbxZYzWBHOMJFyyGZGKUJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048968; c=relaxed/simple;
	bh=04fweWYgP4tzb9dihvvNf6pAuAit0WBMaqTDHKcUBrE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z3Kq/St8kwsMa8jXjDMQbLNkRN5Uv3UyHlkuFPY8k8/vtIIMcfWjcOsROeYR1Bc+9nP85ojxCJZgA5eQQ5PTeYwN+AxWVZma+KVyOLR9T7Pz6eK+koHXePKVwJrnl9GEwo2YsDvQhFpDjOHEW7AmFMb6K1kkp/vffZjOgdsQjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3B7As6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3B7As6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55711F00893;
	Tue, 22 Sep 2026 03:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790048966;
	bh=8Di8dG2HzKR6XKcHMzmhu4LwQUFVMCXRw5bLUr91F7U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b3B7As6B0gBqa8si6+TyyJkp98RNSG8aVT4tWZOlVep74AjowSXOWFnnyeI1F0OBp
	 bTzCLRW6eFSMNS5aIU39NBwyhR3+nXNfxzBnMEqGCfAU5yqM4JjzSe+7peb9r8fEkr
	 UCr/Ej3IdBdYyQRKPD9K1di305p8Tg3SW4lBVP3EEwq154RcdFJndCRdNB1kSHyqCG
	 WEA5osYgiOmlI6HtmoTT2ds+72HAhsjHgZFT8YEPzfnHQ9aOyWn49dXaaBkKx6wpho
	 2F8b7zGB8KxKpcUAvoVg6S8+RDVGk/Jz4PqMj8nbxFwjt7s5JJIfVpGkHZkKdGfxW5
	 M6MtTqkB0QPYw==
Subject:
 Re: [PATCH net v2 2/2] packet: use ubuf_info completion for TX_RING packets
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com, kleaver@janestreet.com,
 doebel@amazon.de, stable@vger.kernel.org
Date: Tue, 22 Sep 2026 03:49:25 +0000
Message-ID: <179004896529.2160803.14644876688990648036@kernel.org>
In-Reply-To: <20260919004748.1463985-3-willemdebruijn.kernel@gmail.com>
References: <20260919004748.1463985-3-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new per-packet `sk_wmem_alloc` charge taken in
  tpacket_snd() (`refcount_inc(&po->sk.sk_wmem_alloc)` at…
- [Medium] Documentation/networking/packet_mmap.rst still describes the
  old TX_RING contract that this patch changes.
- [Low] tpacket_snd() still carries the comments `/* skb was destructed
  already */` (net/packet/af_packet.c:2949) and `/* skb was dropped but…

--

packet: use ubuf_info completion for TX_RING packets

This converts tpacket_snd() from a custom skb->destructor
(tpacket_destruct_skb) to standard zerocopy completion, so a TX_RING slot
is only released once all references to the payload are gone or copied.
The uarg is allocated per packet and holds an sk_wmem_alloc reference, and
the now unused skb_zcopy_*_nouarg helpers are removed.

Closes: https://lore.kernel.org/netdev/20260909085542.3370986-1-doebel@amazon.de/

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 50cae32ae269..64b501db660a 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2530,26 +2530,6 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	goto drop_n_restore;
>  }
>  
> -static void tpacket_destruct_skb(struct sk_buff *skb)
> -{
> -	struct packet_sock *po = pkt_sk(skb->sk);
> -
> -	if (likely(po->tx_ring.pg_vec)) {
> -		void *ph;
> -		__u32 ts;
> -
> -		ph = skb_zcopy_get_nouarg(skb);
> -
> -		ts = __packet_set_timestamp(po, ph, skb);
> -		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
> -
> -		packet_dec_pending(&po->tx_ring);
> -		complete(&po->skb_completion);
> -	}
> -
> -	sock_wfree(skb);
> -}
> -

[ ... ]

> @@ -2589,27 +2569,56 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
>  	return 0;
>  }
>  
> +struct tpacket_uarg {
> +	struct ubuf_info	ubuf;
> +	struct packet_sock	*po;
> +	void			*ph;
> +};
> +
> +static void tpacket_ubuf_complete(struct sk_buff *skb, struct ubuf_info *uarg,
> +				  bool success)
> +{
> +	struct tpacket_uarg *tu = container_of(uarg, struct tpacket_uarg, ubuf);
> +	struct packet_sock *po = tu->po;
> +	void *ph = tu->ph;
> +	__u32 ts;
> +
> +	DEBUG_NET_WARN_ON_ONCE(!skb);
> +
> +	if (!refcount_dec_and_test(&uarg->refcnt))
> +		return;
> +
> +	ts = __packet_set_timestamp(po, ph, skb);
> +	__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);

[Severity: Medium]
Should Documentation/networking/packet_mmap.rst be updated along with this
change?  The "Transmission process" section still says:

  The kernel updates each status of sent frames with TP_STATUS_SENDING
  until the end of transfer.

  At the end of each transfer, buffer status returns to
  TP_STATUS_AVAILABLE.

With slot release moved into tpacket_ubuf_complete(), TP_STATUS_AVAILABLE
now means "the kernel no longer references the payload", which the commit
message says can happen before transmission:

  net/core/dev.c:deliver_skb()
    skb_orphan_frags_rx()
      skb_copy_ubufs()
        skb_zcopy_clear()
          tpacket_ubuf_complete()

The timestamp section also documents a specific recipe:

  Getting timestamps for the TX_RING works as follows: i) fill the ring
  frames, ii) call sendto() e.g. in blocking mode, iii) wait for status of
  relevant frames to be updated resp. the frame handed over to the
  application, iv) walk through the frames to pick up the individual hw/sw
  timestamps.

When the copy happens before skb_tx_timestamp(),
__packet_set_timestamp() returns 0, so the frame is handed back as
TP_STATUS_AVAILABLE with no TP_STATUS_TS_* bit and stale tp_sec/tp_nsec,
even though timestamping was requested.  Can that documented procedure
still be followed, or should the text describe the new semantics?

> +
> +	packet_dec_pending(&po->tx_ring);
> +	complete(&po->skb_completion);
> +
> +	kfree(tu);
> +	sk_free(&po->sk);
> +}

[Severity: Medium]
Does releasing the wmem charge through sk_free() here miss a write space
notification?

sk_free() only does the decrement:

net/core/sock.c:sk_free() {
	if (refcount_dec_and_test(&sk->sk_wmem_alloc))
		__sk_free(sk);
}

whereas the skb charge release path notifies first:

net/core/sock.c:sock_wfree() {
	...
		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
		sk_write_space(sk);
		len = 1;
	...
}

A blocking TX_RING sender reaches sock_wait_for_wmem() via
tpacket_snd()->sock_alloc_send_skb()->sock_alloc_send_pskb(), and its only
wake condition for send space is sk->sk_write_space():

net/core/sock.c:sock_wait_for_wmem() {
	...
		if (refcount_read(&sk->sk_wmem_alloc) < READ_ONCE(sk->sk_sndbuf))
			break;
		...
		timeo = schedule_timeout(timeo);
	...
}

With the default sk_sndtimeo that schedule_timeout() is
MAX_SCHEDULE_TIMEOUT.  If the drop below sk_sndbuf is performed by the new
uarg charges only, is anything left to wake the sleeper?  A path where the
skb charge is gone while the uarg charge is still outstanding is
loopback_xmit(), which calls skb_orphan(skb) (running sock_wfree) without
skb_orphan_frags(), so the ubuf_info survives in the backlog.

[ ... ]

> @@ -2908,7 +2918,24 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  			virtio_net_hdr_set_proto(skb, &vnet_hdr);
>  		}
>  
> -		skb->destructor = tpacket_destruct_skb;
> +		uarg = kmalloc(sizeof(*uarg), GFP_KERNEL);
> +		if (unlikely(!uarg)) {
> +			if (likely(len_sum > 0))
> +				err = len_sum;
> +			else
> +				err = -ENOMEM;
> +			goto out_status;
> +		}
> +		uarg->po = po;
> +		uarg->ph = ph;
> +		uarg->ubuf.ops = &tpacket_ubuf_ops;
> +		uarg->ubuf.flags = SKBFL_ZEROCOPY_FRAG;
> +		refcount_set(&uarg->ubuf.refcnt, 1);
> +
> +		/* Hold a sk_wmem_alloc reference until completion */
> +		refcount_inc(&po->sk.sk_wmem_alloc);
> +		skb_zcopy_init(skb, &uarg->ubuf);
> +
>  		__packet_set_status(po, ph, TP_STATUS_SENDING);
>  		packet_inc_pending(&po->tx_ring);
>  

[Severity: Low]
Just below this, the packet_xmit() error handling in tpacket_snd() still
refers to the destructor that this patch removes:

net/packet/af_packet.c:tpacket_snd() {
	...
			if (err && __packet_get_status(po, ph) ==
				   TP_STATUS_AVAILABLE) {
				/* skb was destructed already */
				skb = NULL;
				goto out_status;
			}
			/*
			 * skb was dropped but not destructed yet;
			 * let's treat it like congestion or err < 0
			 */
	...
}

With skb->destructor back to sock_wfree and slot release moved to
tpacket_ubuf_complete(), does the slot status still imply anything about
the skb?  TP_STATUS_AVAILABLE can now be observed while the skb is alive
(the uarg completed early through skb_copy_ubufs()), and the slot can
still read TP_STATUS_SENDING after the skb was freed if a clone or segment
holds an extra uarg reference.  Should these comments be reworded for the
new completion scheme?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919004748.1463985-1-willemdebruijn.kernel%40gmail.com
