Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736339B48D;
	Sun, 27 Sep 2026 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790497161; cv=none; b=ErpkuXjy6qYSGZM1N0S4d4OM5/VXpuC9+A5QmjZCXwsfSY/5QqlU8pI3Mrc7IH8z02Vw4wD9XOU1ekemRXsxjJZUGMjA9bYgrWeujHDxsQgvea16aHcnXwKIGw2XrxNLCAZ1hKtOeu4WUnJ/iudUyaHAh3T5u2LigvMeRjJQUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790497161; c=relaxed/simple;
	bh=Eerh34NEDalT7cOEsgMj+oWM6IMiwMDKuegRj+hdGDM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OezF9RZZmp/gMMT8YULjNo/kkRKDCmmGXUB7dplRaebiqb88Mn2gswHXJKKfcWsVg6l1P+E0xjkt3FZ4Oyc8V8WO2ilBwmaVM5e+RGWmE32kOHfKeZ7CzEwyKJQCM0rO0nlGc96mbmAqjeR6OX/AnBI2wJiCsicRJ99RFX/NqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=vQLlBTJ4; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="vQLlBTJ4"
Received: by dvalin.narfation.org (Postfix) id 30792202F3;
	Sun, 27 Sep 2026 08:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790497151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=He0WY3jCbriwnigCsrMUly3CG2kXHpH728uQPwmsPaI=;
	b=vQLlBTJ4eC3l+pNRvSFlUaxIVfk5Hojnyeh3ymiRZ75iTAVtyFWl1fMleSfdhNHUM2lP69
	Vq8wfCCoINFEiQdFKqfuZUNwQIvHLdK+CD5zMUE7dWfc4Xp4kqvBafj9FJ7IR37mVCtY1J
	yd9/npehRVseGciIjGl4GkWnW4+BxaA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] batman-adv: Close OGM aggregation before
 transmission
From: Sven Eckelmann <sven@narfation.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marek Lindner <marek.lindner@mailbox.org>, 
 Simon Wunderlich <sw@simonwunderlich.de>, 
 Antonio Quartulli <antonio@mandelbit.com>, 
 Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260926172600.2394088-1-nicoyip.dev@gmail.com>
References: <20260926172600.2394088-1-nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 10:19:00 +0200
Message-Id: <179049714090.25414.9706892666916736240.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4389; i=sven@narfation.org;
 h=from:subject:message-id; bh=Eerh34NEDalT7cOEsgMj+oWM6IMiwMDKuegRj+hdGDM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk7LpZHiNucl+29Nt84vbqNa/Lx+6uNAjepnhXpvduZ9
 0pxEufkjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEEm8zMqx3Wzv90rLK9E07
 01n6W1PdVtQ7lgRdb652agvdqKt2/CYjw2mrpljNztVLGjl/nmWV/plxinXZsXJJKy07ZRGxpvQ
 z/AA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

Thanks for the fix.

Please don't submit batman-adv changes to netdev directly. And please send the
patch also to the person which introduced the problem. You can use tools like
`b4 prep --auto-to-cc` or just the underlying ./scripts/get_maintainer.pl 

    $ b4 mbox 20260926172600.2394088-1-nicoyip.dev@gmail.com
    $ ./scripts/get_maintainer.pl 20260926172600.2394088-1-nicoyip.dev@gmail.com.mbx
    Marek Lindner <marek.lindner@mailbox.org> (maintainer:BATMAN ADVANCED)
    Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED,blamed_fixes:1/1=100%)
    Antonio Quartulli <antonio@mandelbit.com> (maintainer:BATMAN ADVANCED)
    Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED,blamed_fixes:1/1=100%)
    "Linus Lüssing" <linus.luessing@c0d3.blue> (blamed_fixes:1/1=100%)
    b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
    linux-kernel@vger.kernel.org (open list)

This change should not go directly to net.git. The target tree must be
batadv.git

    $ ./scripts/get_maintainer.pl --scm 20260926172600.2394088-1-nicoyip.dev@gmail.com.mbx
    [...]
    git https://git.open-mesh.org/batadv.git
    git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

The last tree is irrelevant for you because it is really unlikely that Linus
Torvalds will apply your patch directly.

> The OGM send worker leaves its forwarding packet on forw_bat_list until
> after batadv_iv_ogm_emit() returns. Aggregation holds forw_bat_list_lock,
> but emission reads and clones the packet without that lock.
> 
> CPU 0 can therefore start emitting a queued packet while CPU 1 takes the
> list lock, finds the same packet and appends another OGM. The sender can
> observe the new packet length before the corresponding direct-link flag
> is set, or clone the skb while its length and payload are being updated.
> This can transmit an OGM with incorrect flags or inconsistent data.
> 
> KCSAN reported:
> 
>   BUG: KCSAN: data-race in batadv_iv_ogm_queue_add / batadv_iv_send_outstanding_bat_ogm_packet
>   write to 0xffff888100fedcf8 of 2 bytes by interrupt on cpu 1:
>   read to 0xffff888100fedcf8 of 2 bytes by task 70 on cpu 2:
>   value changed: 0x00c0 -> 0x00d8

Is there a reproducer and where can I find it?

> Set num_packets to BATADV_MAX_AGGREGATION_PACKETS under the list lock
> before emission. This waits for any ongoing append and makes the existing
> aggregation limit check reject further appends before inspecting mutable
> OGM flags. Emission walks packet_len rather than num_packets, so the
> queued contents are still sent normally. Keep the packet on the list so
> interface purging can still wait for the worker and retain its existing
> ownership of the packet when freeing it.

I might be wrong but this reads a little bit like it was written by an LLM. If
this is the case, please think about following the annotation style described
in https://docs.kernel.org/process/coding-assistants.html

> Backports before Linux 6.15 need count-handling adaptation.

This is wrong. You are depending on 434becf57bdc ("batman-adv: Limit number of
aggregated packets directly") and not the counting adaption. Of course, for
4.10.x-6.14.x, you also need to change the BATADV_MAX_AGGREGATION_PACKETS to
BITS_PER_TYPE(forw_packet->direct_link_flags)

And it doesn't belong in the commit message (like this). Please annotate the
dependencies as described in
https://docs.kernel.org/process/stable-kernel-rules.html#stable-kernel-rules

> Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
>
> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> index 53fbdbbe8f4f7..59847299a1237 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -1909,6 +1909,10 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
>  		goto out;
>  	}
>  
> +	spin_lock_bh(&bat_priv->forw_bat_list_lock);
> +	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
> +	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
> +

Can you add a small comment above like "mark aggregate as full before forcing
emit" (or something similar).

-- 
Sven Eckelmann <sven@narfation.org>
