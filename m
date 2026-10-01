Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007233CF21F;
	Thu,  1 Oct 2026 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892117; cv=none; b=TyB6l9ZYZkXo89S9MXYZfMVCBsdHfQ8gzzPk4/XFAx7JVpZ3YltKSx3RZHnqtRHl1z/SF9rAfXSN+EpjI09mwTGmXp5y3bsFKXUldErvHEktt/4MUhLurJh+Fzw8/Q3D/CvKelzNTejL4TNRzfpndGkjkPepgAkbBjcNgqRkfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892117; c=relaxed/simple;
	bh=QpSVf+WhHYdG/Hs2ZQWrnDWqO3h9QFr4UO6sF1I39NI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NgvwaNXNKY953czz+mhRpPLg8CH9KqK0RHWjM10Sntm0LyRJ+JMW3gHHgQBskhG0oll0YTlJxabyX95tKp+b/eiAtZ/LOY936K3sBC/EEIFKdFg/clQ0LWcINNW6bw1A0lZLCdTuiOveNdpdhjKzjqcZnit4nZF/3C0swMu/+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItlGiUTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItlGiUTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574501F000FF;
	Thu,  1 Oct 2026 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790892111;
	bh=hvjTwEVtjKZQAd/DtFPWaDqigakbTrWsSDpKRwegzOc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ItlGiUTA6lqdYnbjrD64Kn+vCiHfIziHdvyaFqpKNz8YhT8tE/DtA1EdHO5n+Z5iR
	 Fe+rivPDWlI1NNcLe/LfpYz3o8OVbzyu6LxG3aaggNRu3bEDxPyiCwy2QziOpGigb0
	 7QwlMukIep768/fzTIMT2X5pG5VHuNFrQIFkEq6hqil4tgrfgPxKc3Y6BRDwPdW90X
	 V37sbSkn5Ti7E0hT7qo8q/pvHCf/zBkRCqxSLeuyw9BU/0nXis0giP+jle+MATxomO
	 ZDNmcJjE6L693KRf0JgHfilFTRDsMMA96MKIei3YueqkuuUgG/HhOJCLC5rZnjb1FD
	 A0PWB9Q38yBsA==
Subject:
 Re: [PATCH] net: ncsi: clamp filter table counts in GP response handling
From: netdev-bot+sashiko@kernel.org
To: kattamurivamsikrishna17@gmail.com
Cc: netdev@vger.kernel.org, sam@mendozajonas.com, fercerpav@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, gwshan@linux.vnet.ibm.com, joel@jms.id.au,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 01 Oct 2026 22:01:49 +0000
Message-ID: <179089210982.434549.17369347580583679927@kernel.org>
In-Reply-To:
 <CAANnmVAicVNhy8fMUaFJ_N+b4DnbwpYi1MOL4yMVisix1WCX4w@mail.gmail.com>
References:
 <CAANnmVAicVNhy8fMUaFJ_N+b4DnbwpYi1MOL4yMVisix1WCX4w@mail.gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 2 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete, and the commit message is wrong about the
  SVF/SMA handlers.
- [High] The new limits in ncsi_rsp_handler_gp() assume n_uc+n_mc+n_mixed
  and n_vids always describe the buffers behind ncmf->addrs and…
- [Medium] The new limit on the MAC loop in ncsi_rsp_handler_gp()
  (net/ncsi/ncsi-rsp.c:886-888) also limits how far the wire cursor…
- [Medium] ncsi_rsp_handler_gp() now reads n_uc+n_mc+n_mixed and n_vids
  under nc->lock as the size of ncmf->addrs / ncvf->vids.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the loops it
  changes still read past the end of the received GP response.
- [Medium] This problem wasn't introduced by this patch, but the new
  limit of 64 (sizeof(bitmap)*8) does not match the width of the on-wire…
- [Medium] This problem wasn't introduced by this patch, but
  ncsi_rsp_handler_gc() (net/ncsi/ncsi-rsp.c:816 and 823) assigns new…

--

net: ncsi: clamp filter table counts in GP response handling

This patch bounds the MAC and VLAN filter table loops in
ncsi_rsp_handler_gp(). The new bounds are the entry counts allocated by the
Get Capabilities handler and the width of the u64 filter bitmaps. The goal
is to stop a device that reports inconsistent GC and GP counts from causing
heap out-of-bounds writes and out-of-bounds bit operations.

> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index fbd84bc8026a..fa1ed405dfbb 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -883,7 +883,9 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
>  	ncmf = &nc->mac_filter;
>  	spin_lock_irqsave(&nc->lock, flags);
>  	bitmap = &ncmf->bitmap;
> -	for (i = 0; i < rsp->mac_cnt; i++, pdata += 6) {
> +	for (i = 0; i < rsp->mac_cnt &&
> +	     i < ncmf->n_uc + ncmf->n_mc + ncmf->n_mixed &&
> +	     i < sizeof(ncmf->bitmap) * 8; i++, pdata += 6) {

[Severity: Medium]
When this loop exits early, is pdata still inside the MAC table when the
VLAN loop starts?

In the GP response the VLAN tag table starts at
rsp + 48 + rsp->mac_cnt * 6. With this change, pdata only moves forward for
the MAC entries that are actually stored.

Take the example from the commit message: GC advertises one unicast filter
and GP reports mac_cnt = 255. The MAC loop stops after one entry and leaves
pdata at rsp + 54. The VLAN loop then runs:

	ncvf->vids[i] = ntohs(*(__be16 *)pdata);

so it stores MAC table bytes as VLAN IDs. The enable bits still come from
the correctly located rsp->vlan_enable.

Those bogus vids[] values are used later:

  set_one_vid() skips a VID it already finds in vids[], so a real VID may
  never be programmed

  clear_one_vid() sends SVF commands for the bogus VIDs

  NCSI_CMD_PKG_INFO reports them to userspace

Could the patch limit only the number of stored entries, and reset the
cursor before the VLAN loop? For example:

	pdata = (unsigned char *)rsp + 48 + rsp->mac_cnt * ETH_ALEN;

[Severity: High]
This bound assumes that n_uc + n_mc + n_mixed always describes the buffer
behind ncmf->addrs. The commit message calls it "the number of entries
actually allocated". Does that hold when a later GC allocation fails?

ncsi_rsp_handler_gc() stores the allocation result before it updates the
counts:

	nc->mac_filter.addrs = kzalloc(size, GFP_ATOMIC);
	if (!nc->mac_filter.addrs)
		return -ENOMEM;
	nc->mac_filter.n_uc = rsp->uc_cnt;
	...
	nc->vlan_filter.vids = kcalloc(rsp->vlan_cnt,
				       sizeof(*nc->vlan_filter.vids),
				       GFP_ATOMIC);
	if (!nc->vlan_filter.vids)
		return -ENOMEM;

Suppose a first GC succeeds and a second GC for the same channel hits a
GFP_ATOMIC failure. Then addrs or vids is NULL, but the old non-zero counts
are still there.

A second GC can come from NCSI_CMD_SEND_CMD, because ncsi_send_cmd_nl()
sets nca.type = hdr->type. It can also come from a device that answers any
pending request with a GC-type response, because ncsi_rcv_rsp() chooses the
handler from the response type.

The next GP response passes the new bound and runs either:

	memcpy(&ncmf->addrs[i * ETH_ALEN], pdata, ETH_ALEN);

or:

	ncvf->vids[i] = ntohs(*(__be16 *)pdata);

through a NULL base in softirq context. clear_one_vid() and set_one_vid()
would dereference the NULL vids pointer in the same way.

Could ncsi_rsp_handler_gc() allocate into local variables and install the
new pointers and counts together only on success? Resetting the counts to
zero on failure would also work.

[Severity: Medium]
Does nc->lock keep the count and the buffer consistent here?

The new bound reads n_uc + n_mc + n_mixed (and n_vids in the VLAN loop)
under nc->lock. The only writer, ncsi_rsp_handler_gc(), does not take
nc->lock. It also updates in two steps: it installs the new buffer first
and writes the counts afterwards.

ncsi_rcv_rsp() releases ndp->lock before it calls nrh->handler(). So
nothing in NCSI stops the GC and GP handlers from running at the same time.

Suppose GC and GP responses for the same channel are handled at the same
time on different CPUs. Can GP read the old, larger count together with the
new, smaller addrs buffer? That would give the same heap out-of-bounds
memcpy() this patch is trying to prevent.

In practice NCSI frames probably arrive on one RX queue, which would
serialize them, but nothing guarantees that. Would it help for
ncsi_rsp_handler_gc() to publish the pointers and counts together under
nc->lock?

>  		if (!(enable & (0x1 << i)))

[Severity: Medium]
This isn't a bug introduced by this patch, but the new limit of
sizeof(ncmf->bitmap) * 8 is wider than the enable fields.

Here enable holds rsp->mac_enable, which is 8 bits. In the VLAN loop it
holds ntohs(rsp->vlan_enable), which is 16 bits. The test is an int shift:

	if (!(enable & (0x1 << i)))

For MAC i >= 8 and VLAN i >= 16 there is no enable bit on the wire, so
those entries are always cleared.

Indexes 32 to 63 can still be reached when both the GC and GP counts are
above 32. For those, 0x1 << i is undefined behaviour (UBSAN
shift-out-of-bounds). On x86 the shift count wraps, so bits can be set
wrongly.

The same shift ran for i up to 254 before this patch. Would a limit based
on the enable field widths (8 for MAC, 16 for VLAN) avoid it?

>  			clear_bit(i, bitmap);
>  		else
> @@ -898,7 +900,8 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
>  	ncvf = &nc->vlan_filter;
>  	bitmap = &ncvf->bitmap;
>  	spin_lock_irqsave(&nc->lock, flags);
> -	for (i = 0; i < rsp->vlan_cnt; i++, pdata += 2) {
> +	for (i = 0; i < rsp->vlan_cnt && i < ncvf->n_vids &&
> +	     i < sizeof(ncvf->bitmap) * 8; i++, pdata += 2) {

[Severity: High]
The commit message says:

  "so any count larger than 64 writes out-of-bounds bits into struct
  ncsi_channel"

and:

  "mirroring the validation the SVF and SMA handlers already apply to their
  indices"

Does this patch fully close that problem?

The 64-bit limit is only added to the two GP loops. The root cause seems to
be ncsi_rsp_handler_gc(), which stores the device-supplied counts without
limiting them to the u64 bitmap:

	nc->vlan_filter.bitmap = U64_MAX;
	nc->vlan_filter.n_vids = rsp->vlan_cnt;

vlan_cnt can be up to 255, and uc_cnt + mc_cnt + mixed_cnt can be up to
765.

On every channel configuration, the ncsi_dev_state_config_clear_vids state
calls clear_one_vid() in net/ncsi/ncsi-manage.c repeatedly until it returns
-1:

	index = find_first_bit(bitmap, ncf->n_vids);
	...
	vid = ncf->vids[index];

	clear_bit(index, bitmap);
	ncf->vids[index] = 0;

With n_vids > 64, once the 64 real bits are cleared, find_first_bit() keeps
scanning into the next member, the u16 *vids pointer. Can clear_bit() then
clear bits in that kernel pointer, and the next line write through the
corrupted pointer? The only trigger needed is a GC response with
vlan_cnt > 64.

The same mismatch between the count and the bitmap width seems to exist in
these places:

  set_one_vid(): find_first_zero_bit() and set_bit() are bounded only by
  n_vids

  ncsi_rsp_handler_svf(): cmd->index is checked only against ncf->n_vids
  before set_bit()/test_and_clear_bit(cmd->index - 1, bitmap)

  ncsi_rsp_handler_sma(): cmd->index is checked only against
  n_uc + n_mc + n_mixed before set_bit()/clear_bit(cmd->index - 1, bitmap)

  ncsi_write_channel_info(): find_next_bit(&ncf->bitmap, ncf->n_vids, ...)
  reads past the u64

With NCSI_CMD_SEND_CMD, userspace chooses the SVF/SMA index, so the checks
the commit message mirrors have the same gap.

Would it be better to clamp or reject the counts in ncsi_rsp_handler_gc(),
so that n_vids is at most 64 and the MAC total is at most 64? Then the
sizeof(bitmap) * 8 limits in the GP loops would not be needed.

[Severity: High]
This isn't a bug introduced by this patch, but these loops can still read
past the end of the received GP response.

GP is registered as a variable-length response:

	{ NCSI_PKT_RSP_GP,     -1, ncsi_rsp_handler_gp      },

so ncsi_rcv_rsp() does:

	payload = nrh->payload;
	if (payload < 0)
		payload = ntohs(hdr->length);
	ret = ncsi_validate_rsp_pkt(nr, payload);

As a result, the ntohs(h->common.length) != payload check in
ncsi_validate_rsp_pkt() can never fail. The checksum is then read at an
offset the device controls, with no check against skb->len:

	pchecksum = (__be32 *)((void *)(h + 1) + ALIGN(payload, 4) - 4);

That offset can be up to about 64KB past the header.

Nothing in net/ncsi calls pskb_may_pull() or checks skb->len for
responses. So ncsi_rsp_handler_gp() reads 48 bytes plus 6 per MAC entry and
2 per VLAN entry from skb_network_header(). Only the device-supplied counts
limit how far it reads.

A short GP frame with large counts would copy bytes from beyond the frame
into ncmf->addrs and ncvf->vids[]. VIDs whose enable bits are set are later
reported by ncsi_write_channel_info() through NCSI_CMD_PKG_INFO, which
needs no privilege.

Should the response length be checked against the skb before the handler
walks these tables?

[Severity: Medium]
This is a pre-existing issue, but ncsi_rsp_handler_gc() leaks the previous
nc->mac_filter.addrs and nc->vlan_filter.vids buffers when a channel gets
more than one GC response:

	nc->mac_filter.addrs = kzalloc(size, GFP_ATOMIC);
	...
	nc->vlan_filter.vids = kcalloc(rsp->vlan_cnt,
	...

Neither old buffer is freed before it is overwritten. The only kfree() of
these pointers is in ncsi_remove_channel().

A repeated GC can come from:

  NCSI_CMD_SEND_CMD

  a device sending a GC-type response to any pending request

  a re-probe, where ncsi_add_channel() returns the existing channel

Should the old buffers be freed when they are replaced?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/CAANnmVAicVNhy8fMUaFJ_N%2Bb4DnbwpYi1MOL4yMVisix1WCX4w%40mail.gmail.com
