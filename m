Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1633438F;
	Wed,  9 Sep 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968745; cv=none; b=XCpPkH/ASFU8nliHimOgqCm1uxIy9/IHMFllt9ZPyQEvlw9Ks4ymopzH7j/mw+qWq6ejeMNmsprXD+W+xxNs97vDmqb5AwScgbTJdrilcPHN25yxa4QoutA2P3yx33jGCderwpsEk0oUpzSzIt8w4x928TgllWqpou8mpJ3rUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968745; c=relaxed/simple;
	bh=I2rle+zu/ri+CODGl/XdnfKTXVC90SKls9odin13bqs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LCPUicd6ZpNeYFFzz/nM6+VYykEYvMduJIytuCqb6xVQhjU2WxJJ0cU4LL/YM5qyR5Pu2KmRaeUWGq33kt0/M+CmoDsjvxiRU0oMP44go4Mlkktw6nJaH8Aw0NgGdySKtsBsvck9XNjdpzKQZyPTCMHmQUbTQbny3M9B/r7ahzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J21aYGhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J21aYGhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C9D1F00A3A;
	Wed,  9 Sep 2026 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788968743;
	bh=sakVHRs3/NQUtJQMSRKwg9fScIxwuZv64HPK97858Jk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J21aYGhdTBRlQ5DAhIgqkQQyWchCjk/EpO6vfuvdcusk6aBHCdPdjiJbaI1prqaO4
	 fo7KG6Flt+LHGoSEcsZAONN3aCFxKsbO9c+vk4pY5RQmcHlSJz6nK8tNWk8bA+7uxN
	 C1WVPP1gSrU5FOK5BLlPoWIVNwUw+9AZc9/kDzVG5uxQTqwBrwEZ0FikWailvsqAxO
	 q4DWpv2mRqIxLOTkczY60R2EmNxwjeCfLMGHg7itRCdDd/pH7XpCq5L6iCv0HTf9Ys
	 8GEBUKlKuiMhg8gHN+N2N+5qn7ynwno6YHq7Cy9RzWEAmGWA1s7tDBsD7o6gRbsU5c
	 iZ3iWKhjYxRTw==
Subject: Re: [PATCH] wifi: mm81x: bound response memcpy by actual skb length
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: lachlan.hodges@morsemicro.com, dan.callaghan@morsemicro.com,
 kvalo@kernel.org, arien.judge@morsemicro.com, johannes@sipsolutions.net,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Wed, 09 Sep 2026 15:45:42 +0000
Message-ID: <178896874260.219967.8962297974075267128@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001B37B237975CAE6092B80C8B32=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001B37B237975CAE6092B80C8B32=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 3 (1) · Medium: 0 · Low: 0

- [High] Incomplete fix: mm81x_cmd_resp_process() still dereferences the
  device-supplied response header (and, in the else branch, the 4-byte…
- [High] The patch adopts silent truncation as the malformed-response
  policy: at command.c:207-213 `ret = 0` is set first, then the copy…
- [High] The newly added `length = min_t(int, length, skb->len);`
  (command.c:212) narrows the unsigned `skb->len` to `int`.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the memcpy the
  patch hardens writes through `dest_resp`, read from…

--

wifi: mm81x: bound response memcpy by actual skb length

This adds a third min_t() clamp in mm81x_cmd_resp_process() so that the
response memcpy is also limited by skb->len, in addition to the caller's
expected length and the firmware-reported hdr.len.  The stated goal is to
stop a malformed device response from making the copy read past the valid
skb data.

> diff --git a/drivers/net/wireless/morsemicro/mm81x/command.c b/drivers/net/wireless/morsemicro/mm81x/command.c
> index afb7ee9bb236f..591e5ba107533 100644
> --- a/drivers/net/wireless/morsemicro/mm81x/command.c
> +++ b/drivers/net/wireless/morsemicro/mm81x/command.c
> @@ -209,6 +209,7 @@ int mm81x_cmd_resp_process(struct mm81x *mors, struct sk_buff *skb)
>  		length = min_t(int, length,
>  			       le16_to_cpu(src_resp->hdr.len) +
>  				       sizeof(struct host_cmd_header));
> +		length = min_t(int, length, skb->len);

[Severity: High]
Should this clamp use an unsigned type instead of int?

skb->len is unsigned int, and min_t() just assigns into the requested
type with no signedness check:

include/linux/minmax.h:
    #define __cmp_once_unique(op, type, x, y, ux, uy) \
        ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
    ...
    #define min_t(type, x, y) __cmp_once(min, type, x, y)

So for any skb->len above INT_MAX, "int uy = skb->len" is negative, always
wins the min, and overrides the two correct bounds above it.  memcpy()
then converts that negative length to a near-SIZE_MAX size_t.

Can skb->len get that large here?  mm81x_skbq_dispatch_work() in skbq.c
pulls the outer header using device-supplied values without first checking
them against the skb length:

    __skb_pull(pfirst, sizeof(*hdr) + hdr->offset);

and __skb_pull() in include/linux/skbuff.h only does:

    skb->len -= len;
    if (unlikely(skb->len < skb->data_len)) {
        ...
        BUG();
    }

With data_len == 0 for these linear RX skbs, the subtraction wraps
silently.  The precondition looks device controlled: mm81x_yaps_hw_read_pkts()
sizes the skb purely from the chip delimiter (dev_alloc_skb(pkt_size)
followed by skb_put(pkts[i].skb, pkt_size)), and the only later adjustment
in mm81x_yaps_read_pkt() is

    skb_len = sizeof(*hdr) + hdr->offset + le16_to_cpu(hdr->len);
    ...
    skb_trim(skb, skb_len);

which can only shrink.  A small pkt_size combined with a large u8
hdr->offset therefore leaves skb->len wrapped.

Before this patch the copy length was bounded only by resp_cb->length and
hdr.len + sizeof(struct host_cmd_header), both small positive values, so
the same malformed input gave a bounded stale read.  Does the new line turn
that into an unbounded memcpy?  Note that fortify cannot catch it either,
since dest_resp is a struct host_cmd_resp * with a flexible array member,
so __struct_size() is unknown.

Would min_t(u32, ...) or skb_headlen() be the right comparison type here?

[Severity: High]
Does this cover the other reads of the same buffer?

mm81x_cmd_resp_process() dereferences the device-supplied header long
before reaching the clamped memcpy, with no check that skb->len covers
sizeof(struct host_cmd_resp) (12-byte host_cmd_header plus the __le32
status):

    u16 resp_message_id = le16_to_cpu(src_resp->hdr.message_id);
    u16 resp_host_id = le16_to_cpu(src_resp->hdr.host_id);
    ...
    if (!HOST_CMD_IS_RESP(src_resp)) {
        ret = mm81x_mac_event_recv(mors, skb);

and the branch immediately below the memcpy, taken whenever the caller
passed no response buffer, reads bytes 12..15 with no skb->len bound at
all:

    } else {
        ret = le32_to_cpu(src_resp->status);
    }

skb->len on entry is fully device derived: mm81x_yaps_read_pkt() trims to
sizeof(*hdr) + hdr->offset + le16_to_cpu(hdr->len) and
mm81x_skbq_dispatch_work() pulls sizeof(*hdr) + hdr->offset, so a chip
reporting hdr.len == 0 on the command channel hands this function an skb
with skb->len == 0.  The sibling consumer reached from the
HOST_CMD_IS_RESP() branch, mm81x_mac_event_recv() in mac.c, reads
message_id, host_id and vif_id from skb->data with the same lack of a
length check.

Would a single early rejection, along the lines of

    if (skb->len < sizeof(struct host_cmd_resp))
        goto exit_free;

be the better shape?  That would also make the clamp added here redundant.

[Severity: High]
Is silent truncation the intended policy for a malformed response?

ret = 0 is assigned before both clamps, so a copy shorter than
sizeof(struct host_cmd_resp) is reported to the caller as a successful
command, and mm81x_cmd_resp_process() records nothing about the response
having been incomplete.

Every caller passes an uninitialised on-stack response struct, for example
in mm81x_cmd_get_max_txpower():

    struct host_cmd_resp_get_max_txpower resp;

    ret = mm81x_cmd_tx(mors, (struct host_cmd_resp *)&resp,
                       (struct host_cmd_req *)&req, sizeof(resp), 0);
    if (!ret)
        *out_power_mbm = QDBM_TO_MBM(le32_to_cpu(resp.power_qdbm));

mm81x_cmd_get_capabilities() and mm81x_cmd_add_if() do the same, and none
of them use = {} or memset().

mm81x_cmd_tx() then takes the status out of that same buffer:

    ret = (length && resp) ? le32_to_cpu(resp->status) :
                             resp_cb->ret;
    if (ret > 0 || ret < -MAX_ERRNO)
        ret = -EIO;

So if the device reports hdr.len < 4, or skb->len < 16, the status word at
offset 12 is never written and the command return status comes from
uninitialised kernel stack, filtered only when it happens to fall outside
the errno range.  If the truncation instead lands between 16 bytes and
sizeof(resp), status is copied as 0 and the payload fields stay
uninitialised while still being consumed: resp.hdr.vif_id in
mm81x_cmd_add_if(), resp.power_qdbm in mm81x_cmd_get_max_txpower(), and
the whole capability block copied into mors->fw_caps in
mm81x_cmd_get_capabilities().

Would rejecting the short response (ret = -EINVAL; goto exit;) or zeroing
the untouched tail be preferable to extending the clamp chain?

>  		memcpy(dest_resp, src_resp, length);
>  	} else {
>  		ret = le32_to_cpu(src_resp->status);

[Severity: High]
This isn't a bug introduced by this patch, but the memcpy being hardened
here writes through dest_resp, which is read out of a pending command
skb whose lifetime does not look protected.

mm81x_skbq_tx_pending() in skbq.c peeks mq->pending and drops mq->lock
before returning the raw pointer:

    spin_lock_bh(&mq->lock);
    pfirst = skb_peek(&mq->pending);
    spin_unlock_bh(&mq->lock);
    return pfirst;

mm81x_cmd_resp_process() then uses that pointer while holding only
mors->cmd_lock: mm81x_skbq_pull_hdr_post_tx(cmd_skb), the read of
resp_cb->length and resp_cb->dest_resp from IEEE80211_SKB_CB(cmd_skb),
the memcpy, and the resp_cb->ret store.

Meanwhile mm81x_yaps_flush_cmds() in yaps.c purges the command TX queue
first:

    if (yaps->flags & MM81X_HIF_FLAGS_COMMAND) {
        mm81x_skbq_finish(&yaps->cmd_q);
        mm81x_skbq_finish(&yaps->cmd_resp_q);
    }

and mm81x_skbq_finish() only cancels the dispatch work for to-host queues:

    if (mq->flags & MM81X_HIF_FLAGS_DIR_TO_HOST)
        cancel_work_sync(&mq->dispatch_work);
    mm81x_skbq_purge(mq, &mq->skbq);
    mm81x_skbq_purge(mq, &mq->pending);

For the TX-side cmd_q there is no work to cancel, so the pending command
skb is freed under cmd_q->lock only, and this happens before the
cmd_resp_q finish cancels the response dispatch work.  The callers
(mm81x_mac_flush(), mm81x_mac_restart(), mm81x_mac_unregister()) hold
neither mors->cmd_lock nor mors->cmd_wait and do not flush mors->net_wq.

Can the net_wq dispatch worker therefore be inside
mm81x_cmd_resp_process() when the skb it peeked is freed, giving a
skb_pull on freed memory, a resp_cb read from freed memory, and a memcpy
through a stale dest_resp?  The same lockset gap would also let
mm81x_cmd_tx() read resp_cb->ret and call mm81x_skbq_skb_finish(cmd_q,
skb, NULL) on an already freed skb.

Would holding cmd_lock (or cmd_q->lock) across the peek-and-use region,
or making the flush path take cmd_lock and cancel the response dispatch
work before purging cmd_q, be the right fix?

>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001B37B237975CAE6092B80C8B32%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
