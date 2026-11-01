Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541150;
	b=rtBQA69BCY+dOBfcsAF8Wq20wOUFCDu+VJZG6J3cJkbvXHd5Ly5EAROc9ZxT7tLmeQhC
	 FqwS7H34KrKczlkBD5v2UNmpBe11djlcFlqDvI6Qh7zQ7UVyaAUpP/iFXTNG2ktsiCCvG
	 Frpr5JLgEQqxkxSGDJL3JfPOlx7/A2doCx0FCbZkBTXFeOFcAgTe9bJ0lgLjbNriBnRGV
	 Jh+BJxTpBthYlBIKmYVfkkSsVV1payJ0KXP4ntklHLhMEL2C8EjdKpIuJ0dU4v27wZBk8
	 8gWTt4FL5Xb/LdqMmKO69fWsr5maMio7QICGDKywsIUNvIawH7xeLMgdpcKRAVHukyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541150;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=deb38tc0CgShiFlGF5y7hmWXUTuA2F88Y7i/kEhYh3M=;
	b=dPA74r0RgNahsRBrVgKQHbtS+O2YQLHfxzQVBfxMcIdrF/815bG/HpZ55JrGzpA2oJoK
	 O+klHRj79igrie0f0bF5bBRlr76Fg+sva2O812WaOchw5s6AzjJIqfkqsCd+bMHqowxaR
	 tT8UplhdJgp7sg2Dyd8MgSeYhLhNukzzzSPbwzNm2fx9/vgoE1LaAtdiplFt2KS/zG5an
	 oo4OaxfTc3xW/I8jGemBLbU1cEvedaB51cS20KrVEWBMO+kP4urQZws511pjTEvAUv5Vw
	 S2ibwVHZUQ+SxYzxRcASPQasb+W0PfsHmHPJEOYMEgKeQTKYu77l6XLmMxag9fMxEuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlZV96RB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77D606A329;
	Sun,  1 Nov 2026 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlZV96RB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8781F00919;
	Sun,  1 Nov 2026 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793541149;
	bh=deb38tc0CgShiFlGF5y7hmWXUTuA2F88Y7i/kEhYh3M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UlZV96RBa96zsrI7RFMGrUd8i1Ob8IZtOTlfGFPhJxCZEtVQthfeXaWyJM8HxDmQz
	 kPXnoGJmPFdKFtMuiGMtqrkHiMp2i/3gc3WIAnLbM+P1iP4nPBwPSHQO0/I6MKNn6H
	 lkqHcRwhMfJhGOY+gIYrroKl0hl7OvcvEF4BCZrTApsd0n4Cn/RF7PWkBd9zJn9GYc
	 r/CNYGxOXBzkkxD+GslCJJPPfWWcAXpS+23ohDQjsrFsLYeChqEMeEueMJ9RBLtsBl
	 kSNxSluRAACSHvTZ9zgFnVautGO20+Q6EPqgaYa4CXS2/buLNWff8e8SdUN53rxMer
	 O4pB1AWLu6tIA==
Subject: Re: [PATCH net v2 14/14] batman-adv: tt: limit local table to single
 TVLV response size
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Date: Sun, 01 Nov 2026 13:52:28 +0000
Message-ID: <179354114897.3131.2074837253295301799@kernel.org>
In-Reply-To: <20261030135105.2555887-15-sw@simonwunderlich.de>
References: <20261030135105.2555887-15-sw@simonwunderlich.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message describes the pre-patch behaviour wrongly.
- [Low] Two kernel-doc comments no longer match the code after this
  patch.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the same 16-bit
  tvlv_len limit is still not enforced when a node answers a TT_REQUEST…
- [Low] This problem wasn't introduced by this patch, but the size limit
  is read before the lock is taken.

--

batman-adv: tt: limit local table to single TVLV response size

This patch adds batadv_tt_local_transmit_size_max(). It caps the local TT
reservation and the resize-to-MTU limit at the smaller of packet_size_max
and the largest full table response that fits in a single unicast TVLV
packet with a 16 bit tvlv_len. The reservation logic now computes the new
totals in locals and writes the counters only when the reservation
succeeds.

> The size limit was already missing the 16 bit tvlv_len cap since the
> original packet_size_max check was introduced. But this check was only
> reachable with fragmentation disabled and a hard interface MTU larger than
> the maximum unicast TVLV packet. In this case,
> batadv_tt_prepare_tvlv_local_data() refuses to build the full table
> response and no oversized packet is created.

[Severity: Low]

Does this describe the old behaviour accurately?

batadv_tt_prepare_tvlv_local_data() only bounds the TT value with a u16,
and does not count the 4 byte struct batadv_tvlv_hdr:

	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {

batadv_tvlv_unicast_send() then adds the header and stores the result
without a range check:

	tvlv_len = sizeof(*tvlv_hdr) + tvlv_value_len;
	...
	unicast_tvlv_packet->tvlv_len = htons(tvlv_len);

All TT components are multiples of 4, so a 65532 byte TT value is
reachable. For example, 1 VLAN and 5460 entries gives 4 + 8 + 65520.

Before this patch, the reservation allowed that table whenever
packet_size_max >= 65556. The full table response would then be built and
sent with tvlv_len = 65536, which htons() truncates to 0. So an oversized,
malformed packet does seem to have been created. The receiver in
batadv_recv_unicast_tvlv() then just processes no TVLVs.

The code change handles this for the local table: table_size includes the
TVLV header and is capped at sizeof(struct batadv_unicast_tvlv_packet) +
U16_MAX.

The stable+noautosel reasoning depends on how the old behaviour is
described. Could the commit message be made more precise here?

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index f0100ccf93deb..46304069b3b75 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

[ ... ]

> @@ -266,6 +269,25 @@ static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
>  	return hdr_size + batadv_tt_len(num_entries);
>  }
>  
> +/**
> + * batadv_tt_local_transmit_size_max() - get the maximum size of a full local table
> + *  response
> + * @bat_priv: the bat priv with all the mesh interface information
> + *
> + * The full table response is sent as a single unicast TVLV packet. Its
> + * tvlv_len, which covers the TVLV header and the TT TVLV, is only 16 bit wide.
> + * This limits the response size even when packet_size_max is larger.
> + *
> + * Return: maximum size of a full local table response in bytes
> + */
> +static int batadv_tt_local_transmit_size_max(struct batadv_priv *bat_priv)
> +{
> +	int tvlv_size_max = sizeof(struct batadv_unicast_tvlv_packet) + U16_MAX;
> +	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
> +
> +	return min(packet_size_max, tvlv_size_max);
> +}

[Severity: Low]

This is a pre-existing issue and was not introduced by this patch. The
same 16 bit tvlv_len limit does not seem to be enforced when a node
answers a TT_REQUEST on behalf of another originator.
batadv_send_other_tt_response() only checks this:

	/* Don't send the response, if larger than fragmented packet. */
	tt_len = sizeof(struct batadv_unicast_tvlv_packet) + tvlv_len;
	if (tt_len > READ_ONCE(bat_priv->packet_size_max)) {

That check leaves out the 4 byte batadv_tvlv_hdr. It also has no cap at
sizeof(struct batadv_unicast_tvlv_packet) + U16_MAX.
batadv_tt_prepare_tvlv_global_data() has the same u16-only
check_add_overflow() as the local variant.

A remote originator's global entries come from OGM TT diffs. The local
reserve_lock accounting does not limit them.

Take fragmentation disabled and a hard interface MTU >= 65552. A relayed
table with a 65532 byte TT value (1 VLAN and 5460 entries) passes both
checks. batadv_tvlv_unicast_send() then sends it with tvlv_len truncated
from 65536 to 0.

Only the local reservation and resize paths use the new
batadv_tt_local_transmit_size_max(). Would a check in
batadv_tvlv_unicast_send() that rejects tvlv_value_len >
U16_MAX - sizeof(struct batadv_tvlv_hdr) cover every caller?

> @@ -290,22 +312,23 @@ static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
>  static bool batadv_tt_local_reserve(struct batadv_priv *bat_priv, u16 num_vlan,
>  				    u16 num_entries, int *table_size)
>  {
> -	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
> +	int size_max = batadv_tt_local_transmit_size_max(bat_priv);
> +	unsigned int entries;
> +	unsigned int vlans;
>  
>  	scoped_guard(spinlock_bh, &bat_priv->tt.reserve_lock) {

[Severity: Low]

This isn't a bug introduced by this patch, but the limit is still read
before reserve_lock is taken. The old code had the same READ_ONCE() before
the guard. batadv_tt_local_resize_to_mtu() also reads the limit before
taking commit_lock.

Can a concurrent MTU decrease leave the local table larger than the new
packet_size_max?

CPU0                                CPU1
batadv_tt_local_add()
 batadv_tt_local_reserve_entry()
  batadv_tt_local_reserve()
   size_max = <old, larger limit>
                                    batadv_update_min_mtu()
                                     batadv_hardif_min_mtu()
                                      WRITE_ONCE(packet_size_max, ...)
                                     batadv_tt_local_resize_to_mtu()
                                      /* table fits, nothing purged */
   scoped_guard(reserve_lock)
    reservation committed against
    the stale size_max
 entry inserted

The purge decision uses batadv_tt_local_table_transmit_size(), which only
counts vlan->tt.num_entries. It does not see in-flight reservations
(tt.reserved_entries and tt.reserved_vlans) or entries that still carry
BATADV_TT_CLIENT_NEW.

Nothing checks the table again until entries age out, so full table
responses may be dropped until then.

[ ... ]

> @@ -4727,16 +4752,16 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
>  	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
>  	int timeout = BATADV_TT_LOCAL_TIMEOUT / 2;
>  	bool reduced = false;
> -	int packet_size_max;
>  	int table_size;
> +	int size_max;
>  
> -	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
> +	size_max = batadv_tt_local_transmit_size_max(bat_priv);
>  
>  	spin_lock_bh(&bat_priv->tt.commit_lock);
>  
>  	while (timeout) {
>  		table_size = batadv_tt_local_table_transmit_size(bat_priv);
> -		if (packet_size_max >= table_size)
> +		if (size_max >= table_size)
>  			break;

[Severity: Low]

Should the kernel-doc be updated to match? The kernel-doc for
batadv_tt_local_resize_to_mtu() still says:

 * batadv_tt_local_resize_to_mtu() - resize the local translation table fit the
 *  maximum packet size that can be transported through the mesh

The loop now compares against batadv_tt_local_transmit_size_max(), and the
log message below already says "maximum table response size".

The kernel-doc for batadv_tt_local_reserve() also still describes the old
add-then-drop handling:

 * Add the requested number of VLANs and local TT entries to the reservation
 * counters and check whether the local translation table would then still fit
 * in a single full table response. The reservation is dropped again when it
 * would not.

The new body computes the totals in vlans and entries and writes the
counters only on success. Nothing is dropped any more.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030135105.2555887-2-sw%40simonwunderlich.de
