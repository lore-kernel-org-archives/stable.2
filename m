Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541149;
	b=2BB6paZlREypg1Pz5XGbGH5RbmQqWXiFuuof740sy2lhR15DThNUTSz8UVWAIc1x/2zi
	 MTHodld0++x/bspdDYlKiNbSNs9v48Im6bExCq1Y7A/1MSoYgOLccS5kUfiG+OslIl0T7
	 Jc4jhkTajvYN+WsHsm9ITehcVUPoHYDYML63lhs7MfHVvZsoQDGW5kBEHMVMktn5QQRJ4
	 wc/ZTneg0rv71bP66hjRQAFZ04x3mR/RZQ42oDysKcnz1SSsqK0Ch6M+XUPo0fMAV1eYT
	 ujiyTFnektS+bjJp+5EvxwAm1/WlXjpz2YutBveYq/PyF0JgxQmxsh4qF7A2xfH5jDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541149;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EWk1o24hNVLI6fMDx2Ljuovu3/zKSyHGHALwckQZDtU=;
	b=1TVYh0pMO55yl0SP+Do7NPfj4fey20C+fPBcdzVGb3yfdi1tkQ94F8/uMjcXMheUPhc1
	 deNovCu343FfYbzaotUW+4/t7cArvZKR58AnbZRAO1IVrJfFVXXm4r+iRkBzpTBditFNz
	 NaTNiGpHVUwYDxqv03qfBxhTWsZKe5FvctnBudkoGZtXojxVjlxDCFcLKEI20SV/2/qAe
	 lx0Cgat9Xp8q7mCt0TCgv7ZAJAht14nFe3Xk6GtGg9ijdk6OE7m9bdTbEJMCHREf+OafV
	 MblQw8eups4GcaHOU0upQ7lrA+AQ8c0NeApE94hm3a9qCVx1hAgjEri7EpmzzL+Nu6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FeFpMrWz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38153606A326;
	Sun,  1 Nov 2026 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FeFpMrWz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C751F000C1;
	Sun,  1 Nov 2026 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793541148;
	bh=EWk1o24hNVLI6fMDx2Ljuovu3/zKSyHGHALwckQZDtU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FeFpMrWzZwvt7lYtODCQjif7PfV4/ocTOlCv2ATVqb5hVXeXIxNCqvLtoe/h2RlZy
	 sxUauEJAxCs8NraEvaYQKbZM4jtL0g6jfb21uL4+mI+JUniUq1Sxf93ILV9HUMJ1zd
	 BZuRzYyoCb2S5Ok7dK7K6bmB8rDrBLBf5FFpM0y/aLSV9IA3GciRYlK0zeTwZg/59q
	 SeFdmtW+luPNJFUfkL2tghCMn87wVVWsatVBKBIwZntVyOc6XQ4S0ozy7KRhq0v000
	 XNwsi4ikbRcynoDeV7/g75RdVVh9D0VsOkD9wEqaNRI/V1CHg9YmX5Ctbaizc8ICRB
	 LF4XQAeyzBoQQ==
Subject:
 Re: [PATCH net v2 12/14] batman-adv: tt: only update flags for TT events
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Date: Sun, 01 Nov 2026 13:52:27 +0000
Message-ID: <179354114771.3131.18425781657657497381@kernel.org>
In-Reply-To: <20261030135105.2555887-13-sw@simonwunderlich.de>
References: <20261030135105.2555887-13-sw@simonwunderlich.de>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch now treats each new TT event as the client's latest
  state and writes its flags over any queued change for the same…
- [Low] Claimed mismatch between the kernel-doc and the new behaviour for
  NEW clients.

--

batman-adv: tt: only update flags for TT events

This commit changes __batadv_tt_local_event(). DEL+ADD and ADD+DEL pairs
for the same client no longer cancel each other. Instead, a new event
overwrites the flags of the change that is already queued. This keeps a
DEL that follows a flag-update ADD, and it keeps an ADD with new flags
that follows a DEL.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 247cce95c09f4..fa5ead248f192 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

[ ... ]

> @@ -665,25 +667,12 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
>  		if (entry->change.vid != tt_change_node->change.vid)
>  			continue;
>  
> -		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
> -		if (del_op_requested != del_op_entry) {
> -			/* DEL+ADD in the same orig interval have no effect and
> -			 * can be removed to avoid silly behaviour on the
> -			 * receiver side. The  other way around (ADD+DEL) can
> -			 * happen in case of roaming of  a client still in the
> -			 * NEW state. Roaming of NEW clients is now possible due
> -			 * to automatically recognition of "temporary" clients
> -			 */
> -			list_del(&entry->list);
> -			kmem_cache_free(batadv_tt_change_cache, entry);
> -			changes--;

[Severity: Low]

This isn't a bug, but for a client still in the NEW state, the ADD+DEL
pair used to cancel. It is now kept as an announced DEL:

batadv_tt_local_remove()
  batadv_tt_local_mark_removed()   <- breaks out for BATADV_TT_CLIENT_NEW
  batadv_tt_local_remove_now()
    batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);

When a NEW client is added and removed within one OGM interval, this
causes an extra TTVN increment. It also puts a DEL entry in the TT diff
for a client that was never announced.

Receivers seem to treat that DEL as a no-op, because batadv_tt_global_del()
bails out when batadv_tt_global_hash_find() finds nothing. The commit
message also says the extra event is accepted for now ("The first and the
last type of event could in theory still be removed together ...").

Is the extra announcement intended for the NEW-client case, or would it be
worth keeping the cancellation there?

> -		} else {
> -			/* this is a second add or del in the same originator
> -			 * interval. It could mean that flags have been changed
> -			 * (e.g. double add): update them
> -			 */
> -			entry->change.flags = flags;
> -		}
> +		/* the other nodes may know the client with different
> +		 * flags. A DEL+ADD must therefore still announce the
> +		 * current flags and an ADD+DEL must still remove the
> +		 * client. ADD+ADD and DEL+DEL only update the flags
> +		 */
> +		entry->change.flags = flags;

[Severity: Medium]

Does this overwrite rely on events reaching changes_list_lock in the same
order as the state changes they describe?

batadv_tt_local_event() takes its flags snapshot under flags_lock. It
releases that lock before __batadv_tt_local_event() takes
changes_list_lock:

net/batman-adv/translation-table.c:batadv_tt_local_event() {
	...
	flags = batadv_tt_flags_get(common) | event_flags;
	__batadv_tt_local_event(bat_priv, common, flags);
}

The ADD callers in batadv_tt_local_add() hold neither the bucket list_lock
nor flags_lock here. The DEL paths queue their event either under those
locks (batadv_tt_local_set_pending()) or after removing the entry from the
hash (batadv_tt_local_remove_now()). Nothing orders either DEL path against
a concurrent ADD.

Here is the sequence for a new client:

CPU A (TX path)
batadv_interface_tx()
  batadv_tt_local_add()
    batadv_tt_local_create()
    batadv_hash_add()             <- entry is now visible
    batadv_tt_local_event(ADD)
      batadv_tt_flags_get()
                                  CPU B (RX path)
                                  batadv_tt_global_add()
                                    batadv_tt_global_purge_local()
                                      batadv_tt_local_remove()
                                        batadv_tt_local_mark_removed()
                                          <- NEW, not set pending
                                        batadv_tt_local_remove_now()
                                          batadv_hash_remove()
                                          batadv_tt_local_event(DEL)
      __batadv_tt_local_event()
        entry->change.flags = flags;  <- queued DEL becomes ADD

Before this patch the DEL+ADD pair cancelled. That gave the right result
in this case, because the client was never announced and is no longer in
the local hash.

With this change, can an ADD be announced for a client that is no longer
in the local table?

The same window exists for an existing client. batadv_tt_local_add() can
take the ADD snapshot after batadv_tt_local_update_flags(), and
batadv_tt_local_set_pending() can then queue DEL|... before the ADD gets
changes_list_lock. The DEL was also lost in this ordering before the
patch. Now the stale ADD replaces it as the latest state.

In both cases, remote global tables would keep a client that the local
node removes, through batadv_tt_local_purge_pending_clients() at the next
commit in the second case. This lasts until a CRC mismatch triggers a full
table request.

As far as I can tell, the later patches in this series don't change
batadv_tt_local_event() or __batadv_tt_local_event(), so the window is
still there at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030135105.2555887-2-sw%40simonwunderlich.de
