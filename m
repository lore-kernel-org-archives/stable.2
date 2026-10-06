Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959C38550E;
	Tue,  6 Oct 2026 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283187; cv=none; b=u4nUNrznrl3HxDy54h0qCZVit+NFE6Vmij2L9ej8LpvTnJRiVmYPpUBd41ACsx8WChpuBgDJkGRmBP3Dp1772eSZtUM9joy5SW474UEB443eEDZuQ5tbGpKu2CFPn1M5xrKJkLayS/V4J2B+uYh1BDe4N3UVyY23C7VKTAJLlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283187; c=relaxed/simple;
	bh=cP96fxvQRUXL1ivWbFgfb8A2r6XFc9ItLo0Axu6G9OQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/fjvQdr9wCDaqXtcjl/SSOUOZ96155MeEjdxxfPJ81NICF2ziNB6NW3/xGfRO6rj8tU4f3wLNe2Ic2QxzMLaToRclkdsLUm5br/JQwlQv/q6QLAYGTlzjl0rdbFJMbtRokEqe8962Iz99unkviwS5cQD2LHGCLqJajfsPgA+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+tDKz/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+tDKz/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830501F000FF;
	Tue,  6 Oct 2026 10:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791283186;
	bh=r6vziFNG7bang1G66r7uDNjLqBkWnGjYAuZvUzOaPSs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j+tDKz/uD+FltihnD2HnHFllx+PyxnrXT0miata+/7EEQMiuYk0VBhFZ+MO70DO8+
	 5G/smT0mURtpYtnuyxdldFsZl2FOxZkLLGojLtr/8x7Lt+6EAvwIW/91xtYsh26g9Q
	 eHurIkY23J1Jnz/HkL8+4c1wtnND1Kdv1B5QixqxEJi4BKMYQJHWzgGpHYILFr8u0h
	 A3FT33EiVUIZuJAVVnUuSUCrQlnPi1SGEGAFoT9EaB/ZQL2Z6HLdfoFv2cURcjQ7ou
	 WAsb3/4d5jvCGVRCv8wrnlOdBkYaj/OGNmJj38656pryYlm+ntOKGMrLOLLJhkqVIw
	 LuUSectJPa1Hg==
Subject:
 Re: [PATCH] net: ncsi: clamp filter table counts in GP response handling
From: netdev-bot+sashiko@kernel.org
To: kattamurivamsikrishna17@gmail.com
Cc: netdev@vger.kernel.org, sam@mendozajonas.com, fercerpav@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, gwshan@linux.vnet.ibm.com, joel@jms.id.au,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 06 Oct 2026 10:39:45 +0000
Message-ID: <179128318508.434549.4140597995682209212@kernel.org>
In-Reply-To:
 <CAANnmVBJ7NCV-SJrFtT9FO3VnaCK3xG5UzNud4xxoicxpY5qCw@mail.gmail.com>
References:
 <CAANnmVBJ7NCV-SJrFtT9FO3VnaCK3xG5UzNud4xxoicxpY5qCw@mail.gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Medium] The new MAC loop clamp in ncsi_rsp_handler_gp()
  (net/ncsi/ncsi-rsp.c:886-888) also stops `pdata` from advancing.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the NCSI
  response path never checks packet contents against the actual skb…
- [Medium] This problem wasn't introduced by this patch, but the new
  64-entry clamp in ncsi_rsp_handler_gp() still allows i in 32..63,…
- [Medium] This problem wasn't introduced by this patch, but
  ncsi_rsp_handler_gc() publishes new addrs/vids pointers and their…

--

net: ncsi: clamp filter table counts in GP response handling

The patch limits the MAC and VLAN filter loops in ncsi_rsp_handler_gp().
Each loop now stops at the number of entries allocated by the Get
Controller Capabilities handler, and at the 64-bit width of the filter
bitmap. The goal is to stop heap and bitmap out-of-bounds writes when the
device reports contradictory counts in the GC and GP responses.

> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index fbd84bc8026a3..fa1ed405dfbb7 100644
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
Does this clamp also change where the VLAN table is read from?

In the GP response, the VLAN tag table starts at offset 48 + mac_cnt * 6.
ncsi_rsp_handler_gp() only gets there through the pdata += 6 side effect
of this loop. When rsp->mac_cnt is larger than
min(n_uc + n_mc + n_mixed, 64), the loop now exits early and pdata is
left inside the MAC table.

Take the scenario from the commit message: GC advertises one filter and
GP has mac_cnt = 255. The VLAN loop below would then decode MAC address
bytes as VLAN IDs:

	ncvf->vids[i] = ntohs(*(__be16 *)pdata);

It would also apply the vlan_enable bits to those entries. Later,
set_one_vid() compares ndp->vlan_vids against these vids[] entries, and
NCSI_CMD_PKG_INFO reports them to userspace.

Could the packet offset be kept separate from the storage clamp? For
example, the VLAN start could be computed as
(unsigned char *)rsp + 48 + rsp->mac_cnt * ETH_ALEN, after checking it
against the payload length.

[Severity: Medium]
This is a pre-existing issue, but ncsi_rsp_handler_gc() publishes the new
addrs and vids pointers and their counts without taking nc->lock. It also
stores each pointer before its counts:

	nc->mac_filter.addrs = kzalloc(size, GFP_ATOMIC);
	if (!nc->mac_filter.addrs)
		return -ENOMEM;
	nc->mac_filter.n_uc = rsp->uc_cnt;
	nc->mac_filter.n_mc = rsp->mc_cnt;
	nc->mac_filter.n_mixed = rsp->mixed_cnt;

The new clamp reads these counts under nc->lock. However, ncsi_rcv_rsp()
calls nrh->handler(nr) after dropping ndp->lock, so the NCSI core does
not serialize response handlers.

Suppose a GC and a GP response for the same channel are processed at the
same time on different CPUs. Could GP pair the new, smaller buffer with
the old, larger counts and still write out of bounds despite the new
clamp? This would need NCSI frames to be delivered on multiple RX queues,
which may not happen on typical single-queue BMC MACs.

>  		if (!(enable & (0x1 << i)))

[Severity: Medium]
This isn't a bug introduced by this patch, but with the new 64-entry
bound i can still be anywhere from 32 to 63 here. In that case 0x1 << i
shifts an int by 32 or more. Isn't that undefined behaviour, which UBSAN
reports as shift-out-of-bounds?

The packet only carries 8 MAC enable bits (unsigned char mac_enable) and
16 VLAN enable bits (__be16 vlan_enable). On x86 the shift count wraps.
For i = 32..39, the enable bits of entries 0..7 are reused, so set_bit()
marks filters that the device never enabled. The VLAN loop uses the same
expression and has the same problem for i = 32..47.

Before this patch the range was larger (i could reach 254). The patch
narrows the problem but does not remove it.

>  			clear_bit(i, bitmap);
>  		else

[ ... ]

> @@ -898,7 +900,8 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
>  	ncvf = &nc->vlan_filter;
>  	bitmap = &ncvf->bitmap;
>  	spin_lock_irqsave(&nc->lock, flags);
> -	for (i = 0; i < rsp->vlan_cnt; i++, pdata += 2) {
> +	for (i = 0; i < rsp->vlan_cnt && i < ncvf->n_vids &&
> +	     i < sizeof(ncvf->bitmap) * 8; i++, pdata += 2) {

[Severity: High]
Does this fully close the out-of-bounds bitmap writes that the commit
message describes? The commit message says:

  The loop indices are additionally used as bit numbers for
  set_bit()/clear_bit() on the u64 filter bitmaps, so any count larger
  than 64 writes out-of-bounds bits into struct ncsi_channel.

The counts come from ncsi_rsp_handler_gc(), which does not clamp them:

	nc->vlan_filter.bitmap = U64_MAX;
	nc->vlan_filter.n_vids = rsp->vlan_cnt;

vlan_cnt can be as large as 255, and n_uc + n_mc + n_mixed as large as
765. Other users still treat these counts as the bitmap size.

clear_one_vid() runs during the config clear_vids state:

	index = find_first_bit(bitmap, ncf->n_vids);
	...
	vid = ncf->vids[index];

	clear_bit(index, bitmap);
	ncf->vids[index] = 0;

Once bits 0..63 are cleared, find_first_bit() continues into the next
field of struct ncsi_channel_vlan_filter, which is the vids pointer.
clear_bit() then clears a bit of that pointer, and ncf->vids[index] = 0
writes through the modified pointer. Can a GC response with
vlan_cnt > 64 trigger this on its own, without any GP response?

set_one_vid() follows the same pattern, using find_first_zero_bit() and
set_bit() sized by n_vids. ncsi_write_channel_info() calls
find_next_bit() over n_vids bits of the single u64.

The commit message also says the clamp mirrors "the validation the SVF
and SMA handlers already apply to their indices". Is that accurate?
Those handlers only check the index against the table size.

ncsi_rsp_handler_svf():

	if (cmd->index == 0 || cmd->index > ncf->n_vids)
		return -ERANGE;

ncsi_rsp_handler_sma():

	if (cmd->index == 0 ||
	    cmd->index > ncf->n_uc + ncf->n_mc + ncf->n_mixed)
		return -ERANGE;

Both then call set_bit(cmd->index - 1, bitmap). In the SMA case, that can
flip bits in the adjacent addrs pointer.

Would it be better to cap the counts at 64, or reject the response, in
ncsi_rsp_handler_gc()? That one change would cover GP, SVF, SMA,
set_one_vid(), clear_one_vid() and the netlink path. As it stands, a
stable backport of this patch alone would leave those paths reachable.

[Severity: High]
This is a pre-existing issue, but is pdata ever checked against the
length of the received frame here?

GP is registered as variable length:

	{ NCSI_PKT_RSP_GP,     -1, ncsi_rsp_handler_gp      },

So ncsi_rcv_rsp() takes the payload length from the device's own header:

	payload = nrh->payload;
	if (payload < 0)
		payload = ntohs(hdr->length);
	ret = ncsi_validate_rsp_pkt(nr, payload);

ncsi_validate_rsp_pkt() then reads the checksum at an offset derived from
that payload, without checking skb->len, and it accepts a zero checksum.
There doesn't seem to be any pskb_may_pull() or skb->len check on the
NCSI RX path.

ncsi_rsp_handler_gp() then walks pdata for up to
48 + 64 * 6 + 64 * 2 bytes, based only on mac_cnt and vlan_cnt. With a
short GP frame and large counts, could this copy bytes from past the end
of the received frame into mac_filter.addrs and vlan_filter.vids?

Those vids[] entries are later sent to userspace by
ncsi_write_channel_info() through NCSI_CMD_PKG_INFO. That command is not
marked GENL_ADMIN_PERM.

>  		if (!(enable & (0x1 << i)))
>  			clear_bit(i, bitmap);
>  		else

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/CAANnmVBJ7NCV-SJrFtT9FO3VnaCK3xG5UzNud4xxoicxpY5qCw%40mail.gmail.com
