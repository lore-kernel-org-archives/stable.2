Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFB2641FC;
	Wed, 14 Oct 2026 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956609; cv=none; b=U7BgrJJzCNk1IPuCTvGwc/7gpAAsPq5qMi+7c0b4e+/v9/rcT76BHvZdzpquvNsHC6702auLaoqfpjXBkbG7MctuVcRNvDoUoVU6j2px1I4jpfgeDVE9nxE616cHH0EeJzDetb1ldtKIunWAJfJMna20J+Bxw09mk05OhqgS7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956609; c=relaxed/simple;
	bh=nZGDtIvWTqsOAEDV67yWrCTNZ5DsN+RFeToVH2zdZgA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S40FGPFvGcPqWspG+xmTjOhtedMzgPv5HToNfnUq6NhcJbsRN8Fx2EZfFx8RfFGBN5NE2JpQblTDCY23xzFJL2lLFaa5bZh4iCbtUiLCzhYoybilN4h6US5lT+nqFpVJV4uYKYlWR1KBFKB6MMFhkVnXxxCNjmpjg04TUGpB/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=Ls7B4hBH; arc=none smtp.client-ip=109.224.244.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="Ls7B4hBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1791956595; x=1792215795;
	bh=XLj0Q12xq9jmKaEcZE9Dg32kMIG0/MR3cjYm2lOuOkQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ls7B4hBH28Mu91mix+S/REftPrkvbGaKRSUR4jA6LEQAsHtoaS0seXxqwG+e6C62T
	 rOM8dvfNc1IjlmXM+gCBaY+aKYpgZBEfp1KEuVOF83QNLA9EVf7jVHuaxIuW+yifwt
	 sJVDOgmzbF+cI3tFmtdvKMj5KpgGls8k/EDPA0GHOiyD7PL9nDcBsgrK66sKhbpUvK
	 0DR6KSG4c6IHkiWTVPWMjdgiuXNcS3j+PrS2IJ5s4kwZOS5GYxhpiA9JyZQGsOqxH3
	 nvyWTEu5fJP/QNRRsd/e3EpOLqXZ3Kd6S/grVgX9pYU3Df2IvVX+gjCAA29ZtSKyfT
	 fHAmf7H73/I3w==
Date: Wed, 14 Oct 2026 05:43:10 +0000
To: netdev-bot+sashiko@kernel.org
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, maciej.fijalkowski@intel.com, avigailx.dahan@intel.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] igc: only strip RX timestamp header from first buffer
Message-ID: <Z4u97qIiSB-8nYCRmd03ddR4OFMcrpNVUcTHSoOADzNQcLvQVIQotijZpukYAO4AzV4r6j11nGS_lWTwyh709u_USu516VJmvffbjukcAs0=@1g4.org>
In-Reply-To: <179194315897.434549.3743742848544230715@kernel.org>
References: <20261013010854.4068874-1-p@1g4.org> <179194315897.434549.3743742848544230715@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 86b642f83886122985208bb05c205eb5c5c1395f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 13th, 2026 at 8:59 PM, netdev-bot+sashiko@kernel.org <n=
etdev-bot+sashiko@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [High] The patch fixes the TSIP length underflow only in
>   igc_clean_rx_irq().
> - [High] In igc_clean_rx_irq(), the new condition `if (!skb &&
>   igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP))` uses `!skb` to mean=
=E2=80=A6
>=20
> --
>=20
> igc: only strip RX timestamp header from first buffer
>=20
> This patch changes igc_clean_rx_irq() so the 16-byte inline RX timestamp
> header is only stripped when no skb is in progress. Before, a continuatio=
n
> buffer shorter than 16 bytes could underflow the unsigned length and
> produce a skb fragment of almost 4 GiB.
>=20
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c5..41b293dc10c3a 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
> >
> >  =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offse=
t;
> >
> > -=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > +=09=09if (!skb &&
> > +=09=09    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
>=20
> [Severity: High]
> Is !skb a reliable first-buffer test when an XDP program is attached?
>=20
> Suppose the XDP program returns a non-PASS verdict (CONSUMED, TX or
> REDIRECT) for the first, non-EOP buffer of a multi-descriptor frame. No s=
kb
> gets built, and the loop moves on with skb still NULL:
>=20
> =09=09/* fetch next buffer in frame if non-eop */
> =09=09if (igc_is_non_eop(rx_ring, rx_desc))
> =09=09=09continue;
>=20
> On the next continuation descriptor, !skb is still true, so the TSIP bran=
ch
> subtracts IGC_TS_HDR_LEN again. If that continuation holds fewer than 16
> bytes, size wraps.
>=20
> The wrapped size then goes to xdp_prepare_buff(), and the continuation is
> run through XDP as a new frame with data_end before data. On XDP_PASS, bo=
th
> igc_build_skb() and igc_construct_skb() compute:
>=20
> =09unsigned int size =3D xdp->data_end - xdp->data;
>=20
> That comes out to about 4 GiB:
>=20
> - igc_build_skb() passes it to __skb_put(). On PAGE_SIZE >=3D 8192,
>   igc_get_rx_frame_truesize() also wraps to a tiny truesize, so
>   napi_build_skb() would place skb_shared_info inside the packet data.
> - igc_construct_skb() turns it into a fragment of almost 4 GiB. That look=
s
>   like the same corrupted skb the commit message describes.
>=20
> Can this be reached from the wire? On PAGE_SIZE >=3D 8192, igc_set_rx_mod=
e()
> never clamps RLPML:
>=20
> #if (PAGE_SIZE < 8192)
> =09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
> =09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
> #endif
> =09wr32(IGC_RLPML, rlpml);
>=20
> So the hardware still accepts jumbo frames even though XDP limits the MTU=
 to
> 1500, and with XDP the ring uses 3072-byte buffers. A remote frame that
> leaves 1 to 15 bytes in the second descriptor would hit this.
>=20
> Would it be safer to track start-of-frame explicitly, or to drop the rest=
 of
> the frame's descriptors after a non-PASS verdict? Another option is to
> reject size < IGC_TS_HDR_LEN before the subtraction.
>=20
> >  =09=09=09ctx.rx_ts =3D pktbuf;
> >  =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
> >  =09=09=09size -=3D IGC_TS_HDR_LEN;
>=20
> [Severity: High]
> The same unchecked subtraction is still present in the AF_XDP zero-copy
> path. igc_clean_rx_irq_zc() strips the header from every descriptor with
> TSIP set. There is no first-buffer gate and no size check:
>=20
> =09=09if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
> =09=09=09ctx->rx_ts =3D bi->xdp->data;
>=20
> =09=09=09bi->xdp->data +=3D IGC_TS_HDR_LEN;
> =09=09=09...
> =09=09=09size -=3D IGC_TS_HDR_LEN;
> =09=09} else {
> =09=09=09ctx->rx_ts =3D NULL;
> =09=09}
>=20
> =09=09bi->xdp->data_end =3D bi->xdp->data + size;
>=20
> Can zero-copy frames span descriptors at MTU 1500?
> igc_configure_rx_ring() programs the XSK frame size through
> IGC_SRRCTL_BSIZEPKT(), which is (x) / 1024. With 2048-byte chunks the fra=
me
> size is 1792, so the hardware buffer becomes 1 KB.
>=20
> igc_xdp_enable_pool() only checks:
>=20
> =09if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
>=20
> That accepts 1792 without allowing for the 1 KB rounding or the 16-byte
> inline timestamp, even though the comment there says frames should not
> span multiple buffers.
>=20
> On 4K pages RLPML is IGC_MAX_FRAME_BUILD_SKB. A received frame of about
> 1009 to 1023 bytes, plus the timestamp header, would leave 1 to 15 bytes =
in
> a second descriptor.
>=20
> The reproduction in the commit message suggests TSIP is set on such
> continuation descriptors. If so, size wraps here and data_end ends up abo=
ut
> 4 GiB past the XSK chunk.
>=20
> Wouldn't that let the XDP program's packet bounds checks pass for offsets
> past the chunk? On XDP_REDIRECT, it would also report a bogus length to t=
he
> XSK socket.
>=20
> Should igc_clean_rx_irq_zc() get a similar fix? Should
> igc_xdp_enable_pool() also account for the 1 KB SRRCTL granularity and th=
e
> inline timestamp?
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261013010854.4068874-1-p%401g4.org
>=20

Yes, there's work needed elsewhere, but it's entirely independent of my fix=
. It's=20
questionable how much of this is even reachable and if any impact whatsoeve=
r.=20

Here's what I can reproduce with and without kasan and what my patch fixes.=
 You are on your=20
own on the rest.

I'm sorry, if only there were more time...

Good luck.

[  981.289013] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  981.289028] BUG: KASAN: slab-use-after-free in sk_skb_reason_drop+0x36/0=
x280
[  981.289051] Write of size 4 at addr ffff888201376fd4 by task kworker/7:2=
/92

[  981.289069] CPU: 7 UID: 0 PID: 92 Comm: kworker/7:2 Tainted: G        W =
          7.3.0-rc6+ #4 PREEMPT=20
[  981.289083] Tainted: [W]=3DWARN
[  981.289088] Workqueue: events igc_reset_task [igc]
[  981.289152] Call Trace:
[  981.289158]  <TASK>
[  981.289163]  dump_stack_lvl+0x43/0x60
[  981.289177]  print_address_description+0x55/0x1d0
[  981.289188]  ? sk_skb_reason_drop+0x36/0x280
[  981.289196]  print_report+0x58/0x70
[  981.289203]  kasan_report+0x117/0x150
[  981.289213]  ? dev_kfree_skb_any_reason+0x4/0x180
[  981.289221]  ? sk_skb_reason_drop+0x36/0x280
[  981.289229]  kasan_check_range+0x3c7/0x3f0
[  981.289238]  sk_skb_reason_drop+0x36/0x280
[  981.289246]  igc_clean_tx_ring+0x24a/0xb40 [igc]
[  981.289296]  igc_down+0x7b1/0xc70 [igc]
[  981.289339]  igc_reinit_locked+0x5a/0x80 [igc]
[  981.289379]  igc_reset_task+0xca/0xd0 [igc]
[  981.289418]  process_scheduled_works+0x805/0xf10
[  981.289435]  worker_thread+0x8d2/0xc60
[  981.289443]  ? __schedule+0x1011/0x2330
[  981.289462]  kthread+0x2c9/0x3a0
[  981.289468]  ? __pfx_worker_thread+0x10/0x10
[  981.289477]  ? __pfx_kthread+0x10/0x10
[  981.289487]  ret_from_fork+0x14d/0x3f0
[  981.289496]  ? __pfx_kthread+0x10/0x10
[  981.289505]  ret_from_fork_asm+0x1a/0x30
[  981.289517]  </TASK>

[  981.289523] Allocated by task 0:
[  981.289529]  kasan_save_track+0x3e/0x80
[  981.289541]  __kasan_mempool_unpoison_object+0x82/0x110
[  981.289548]  __alloc_skb+0x2c3/0x8f0
[  981.289559]  napi_alloc_skb+0x58/0x220
[  981.289565]  igc_poll+0x400f/0x7660 [igc]
[  981.289604]  __napi_poll+0x91/0x380
[  981.289612]  net_rx_action+0x4e0/0xbc0
[  981.289620]  handle_softirqs+0x173/0x4d0
[  981.289630]  __irq_exit_rcu+0x63/0xd0
[  981.289639]  common_interrupt+0x81/0x90
[  981.289648]  asm_common_interrupt+0x26/0x40

[  981.289658] Freed by task 0:
[  981.289662]  kasan_save_track+0x3e/0x80
[  981.289671]  kasan_save_free_info+0x40/0x50
[  981.289678]  __kasan_slab_free+0x3a/0x60
[  981.289684]  kmem_cache_free+0xe9/0x370
[  981.289693]  br_stp_rcv+0x39a/0x1390
[  981.289701]  stp_pdu_rcv+0x227/0x370
[  981.289710]  llc_rcv+0x552/0x8d0
[  981.289718]  __netif_receive_skb_list_core+0x600/0x790
[  981.289726]  netif_receive_skb_list_internal+0x6f0/0x940
[  981.289734]  napi_complete_done+0x1a6/0x400
[  981.289741]  igc_poll+0x5c6d/0x7660 [igc]
[  981.289779]  __napi_poll+0x91/0x380
[  981.289786]  net_rx_action+0x4e0/0xbc0
[  981.289794]  handle_softirqs+0x173/0x4d0
[  981.289802]  __irq_exit_rcu+0x63/0xd0
[  981.289811]  common_interrupt+0x81/0x90
[  981.289819]  asm_common_interrupt+0x26/0x40

[  981.289828] The buggy address belongs to the object at ffff888201376f00
                which belongs to the cache skbuff_head_cache of size 224
[  981.289836] The buggy address is located 212 bytes inside of
                freed 224-byte region [ffff888201376f00, ffff888201376fe0)

[  981.289847] The buggy address belongs to the physical page:
[  981.289854] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0=
x0 pfn:0x201376
[  981.289864] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0=
 pincount:0
[  981.289870] flags: 0x100000000000040(head|node=3D0|zone=3D1)
[  981.289879] page_type: f5(slab)
[  981.289889] raw: 0100000000000040 ffff8881003437c0 dead000000000100 dead=
000000000122
[  981.289897] raw: 0000000000000000 0000000000190019 00000000f5000000 0000=
000000000000
[  981.289903] head: 0100000000000040 ffff8881003437c0 dead000000000100 dea=
d000000000122
[  981.289909] head: 0000000000000000 0000000000190019 00000000f5000000 000=
0000000000000
[  981.289915] head: 0100000000000001 ffffffffffffff81 00000000ffffffff 000=
00000ffffffff
[  981.289920] head: 0000000000000000 0000000000000000 00000000ffffffff 000=
0000000000000
[  981.289923] page dumped because: kasan: bad access detected

[  981.289930] Memory state around the buggy address:
[  981.289935]  ffff888201376e80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  981.289940]  ffff888201376f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  981.289945] >ffff888201376f80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc=
 fc fc
[  981.289948]                                                  ^
[  981.289953]  ffff888201377000: fc fc fc fc fc fc fc fc fa fb fb fb fb fb=
 fb fb
[  981.289957]  ffff888201377080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  981.289960] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  981.289964] Disabling lock debugging due to kernel taint
[  981.289972] ------------[ cut here ]------------
[  981.289976] refcount_t: underflow; use-after-free.
[  981.289980] WARNING: at refcount_warn_saturate+0x84/0xd0, CPU#7: kworker=
/7:2/92
[  986.631187] Modules linked in: igc
[  986.672125] CPU: 7 UID: 0 PID: 92 Comm: kworker/7:2 Tainted: G    B   W =
          7.3.0-rc6+ #4 PREEMPT=20
[  986.786934] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
[  986.837256] Workqueue: events igc_reset_task [igc]
[  986.895096] RIP: 0010:refcount_warn_saturate+0x84/0xd0
[  986.957010] Code: 74 2f 83 fb 01 75 38 48 8d 3d 1c 18 0b 03 67 48 0f b9 =
3a eb 36 48 8d 3d 1a 18 0b 03 67 48 0f b9 3a eb 28 48 8d 3d 18 18 0b 03 <67=
> 48 0f b9 3a eb 1a 48 8d 3d 16 18 0b 03 67 48 0f b9 3a eb 0c 48
[  987.182580] RSP: 0018:ffffc9000073faa0 EFLAGS: 00010246
[  987.246116] RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffffb7e=
3a117
[  987.331872] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffffbae=
eb8ec
[  987.418053] RBP: ffffc900012b7440 R08: 0000000000000007 R09: 00000000fff=
ffffb
[  987.503797] R10: dffffc0000000000 R11: ffffed104026edfa R12: ffff888204c=
57288
[  987.589959] R13: 000000000000e0e8 R14: ffff888201376fd4 R15: 00000000000=
00011
[  987.675711] FS:  0000000000000000(0000) GS:ffff888864da5000(0000) knlGS:=
0000000000000000
[  987.773233] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  987.843183] CR2: 00007dc52cee8781 CR3: 0000000113426001 CR4: 0000000000f=
70ef0
[  987.929069] PKRU: 55555554
[  987.961732] Call Trace:
[  987.991154]  <TASK>
[  988.016584]  igc_clean_tx_ring+0x24a/0xb40 [igc]
[  988.072122]  igc_down+0x7b1/0xc70 [igc]
[  988.118496]  igc_reinit_locked+0x5a/0x80 [igc]
[  988.172072]  igc_reset_task+0xca/0xd0 [igc]
[  988.222531]  process_scheduled_works+0x805/0xf10
[  988.278089]  worker_thread+0x8d2/0xc60
[  988.323413]  ? __schedule+0x1011/0x2330
[  988.369478]  kthread+0x2c9/0x3a0
[  988.408473]  ? __pfx_worker_thread+0x10/0x10
[  988.459993]  ? __pfx_kthread+0x10/0x10
[  988.505192]  ret_from_fork+0x14d/0x3f0
[  988.550284]  ? __pfx_kthread+0x10/0x10
[  988.595629]  ret_from_fork_asm+0x1a/0x30
[  988.642823]  </TASK>
[  988.669290] ---[ end trace 0000000000000000 ]---


[ 2138.124024] [Poison overwritten] 0xffff91bb928da594-0xffff91bb928da594 @=
offset=3D1428. First byte 0x6a instead of 0x6b
[ 2138.124040] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[ 2138.124044] BUG skbuff_head_cache (Tainted: G        W          ): Objec=
t corrupt
[ 2138.124049] ------------------------------------------------------------=
-----------------

[ 2138.124051] Allocated in kmem_cache_alloc_bulk_noprof+0x8d/0x370 age=3D8=
9089 cpu=3D4 pid=3D0
[ 2138.124068]  kmem_cache_alloc_bulk_noprof+0x8d/0x370
[ 2138.124075]  __alloc_skb+0x35c/0x3b0
[ 2138.124080]  napi_alloc_skb+0x4c/0x110
[ 2138.124083]  igc_poll+0xf1f/0x1c80 [igc]
[ 2138.124108]  __napi_poll+0x2f/0x190
[ 2138.124115]  net_rx_action+0x299/0x4c0
[ 2138.124121]  handle_softirqs+0xd1/0x2a0
[ 2138.124128]  do_softirq+0x4b/0x70
[ 2138.124132]  flush_smp_call_function_queue+0x43/0x60
[ 2138.124138]  do_idle+0x1b4/0x210
[ 2138.124145]  cpu_startup_entry+0x29/0x30
[ 2138.124150]  start_secondary+0x95/0xa0
[ 2138.124157]  common_startup_64+0x12c/0x147
[ 2138.124162] Freed in __tcf_kfree_skb_list+0x38/0xc0 age=3D84826 cpu=3D4 =
pid=3D0
[ 2138.124172]  __tcf_kfree_skb_list+0x38/0xc0
[ 2138.124177]  __dev_queue_xmit+0xbe1/0xf20
[ 2138.124181]  tcf_mirred_to_dev+0x41c/0x4a0
[ 2138.124187]  tcf_mirred_act+0x30f/0x670
[ 2138.124192]  tcf_action_exec+0x95/0x220
[ 2138.124196]  tcf_classify+0x8e/0x200
[ 2138.124202]  tc_run+0xc7/0x120
[ 2138.124207]  __netif_receive_skb_core+0x4d5/0xc60
[ 2138.124212]  __netif_receive_skb_list_core+0xbc/0x290
[ 2138.124217]  netif_receive_skb_list_internal+0x178/0x2e0
[ 2138.124222]  napi_complete_done+0x99/0x150
[ 2138.124226]  igc_poll+0x16da/0x1c80 [igc]
[ 2138.124246]  __napi_poll+0x2f/0x190
[ 2138.124251]  net_rx_action+0x299/0x4c0
[ 2138.124256]  handle_softirqs+0xd1/0x2a0
[ 2138.124261]  __irq_exit_rcu+0x44/0xa0
[ 2138.124265] Slab 0xffffd132cb4a3680 objects=3D21 used=3D19 fp=3D0xffff91=
bb928db9c0 flags=3D0x100000000000240(workingset|head|node=3D0|zone=3D1)
[ 2138.124274] Object 0xffff91bb928da4c0 @offset=3D1216 fp=3D0xffff91bb928d=
b9c0

[ 2138.124278] Redzone  ffff91bb928da480: bb bb bb bb bb bb bb bb bb bb bb =
bb bb bb bb bb  ................
[ 2138.124282] Redzone  ffff91bb928da490: bb bb bb bb bb bb bb bb bb bb bb =
bb bb bb bb bb  ................
[ 2138.124284] Redzone  ffff91bb928da4a0: bb bb bb bb bb bb bb bb bb bb bb =
bb bb bb bb bb  ................
[ 2138.124286] Redzone  ffff91bb928da4b0: bb bb bb bb bb bb bb bb bb bb bb =
bb bb bb bb bb  ................
[ 2138.124289] Object   ffff91bb928da4c0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124291] Object   ffff91bb928da4d0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124293] Object   ffff91bb928da4e0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124295] Object   ffff91bb928da4f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124297] Object   ffff91bb928da500: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124299] Object   ffff91bb928da510: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124301] Object   ffff91bb928da520: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124302] Object   ffff91bb928da530: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124304] Object   ffff91bb928da540: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124306] Object   ffff91bb928da550: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124308] Object   ffff91bb928da560: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124309] Object   ffff91bb928da570: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124311] Object   ffff91bb928da580: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[ 2138.124313] Object   ffff91bb928da590: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b a5  kkkkjkkkkkkkkkk.
[ 2138.124315] Redzone  ffff91bb928da5a0: bb bb bb bb bb bb bb bb          =
                ........
[ 2138.124317] Padding  ffff91bb928da5f0: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a =
5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
[ 2138.124320] Disabling lock debugging due to kernel taint
[ 2138.124337] ------------[ cut here ]------------
[ 2138.124339] WARNING: at object_err+0xa7/0xd0, CPU#6: swapper/6/0
[ 2138.124375] Modules linked in: igc
[ 2138.124385] CPU: 6 UID: 0 PID: 0 Comm: swapper/6 Tainted: G    B   W    =
       7.3.0-rc6-nokasan+ #5 PREEMPT=20
[ 2138.124394] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
[ 2138.124398] RIP: 0010:object_err+0xa7/0xd0
[ 2138.124403] Code: 85 d2 74 3d 4c 89 f7 e8 87 fe ff ff 48 c7 c7 0b 28 d7 =
8b 48 89 de e8 e8 cf ff ff bf 05 00 00 00 be 01 00 00 00 e8 99 ae 12 00 <0f=
> 0b 5b 41 5e 41 5f c3 cc cc cc cc cc 48 99 48 f7 fe 48 85 d2 75
[ 2138.124408] RSP: 0018:ffffab8bc02f4a30 EFLAGS: 00010046
[ 2138.124414] RAX: 0000000000000000 RBX: ffff91bb928da4c0 RCX: f49708951d9=
77900
[ 2138.124418] RDX: 3fffffffffffdfff RSI: 0000000000000000 RDI: 00000000000=
00005
[ 2138.124422] RBP: ffff91b9c0b967c0 R08: 0000000000001fff R09: ffffffff8c4=
5c8f0
[ 2138.124425] R10: 0000000000005ffd R11: ffffffff8c45c8f0 R12: ffffffff8bd=
8ed9a
[ 2138.124429] R13: ffff91bb928da594 R14: ffffd132cb4a3680 R15: ffff91b9c0b=
967c0
[ 2138.124431] FS:  0000000000000000(0000) GS:ffff91c192d95000(0000) knlGS:=
0000000000000000
[ 2138.124436] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2138.124440] CR2: 0000000000e9ac50 CR3: 0000000150f91005 CR4: 0000000000f=
70ef0
[ 2138.124444] PKRU: 55555554
[ 2138.124447] Call Trace:
[ 2138.124450]  <IRQ>
[ 2138.124453]  check_bytes_and_report+0xea/0x110
[ 2138.124461]  check_object+0x131/0x360
[ 2138.124467]  alloc_debug_processing+0xaf/0x1a0
[ 2138.124472]  get_from_partial_node+0x11c/0x410
[ 2138.124478]  ___slab_alloc+0xad/0x760
[ 2138.124484]  __kmem_cache_alloc_bulk+0x13c/0x190
[ 2138.124490]  ? kmem_cache_alloc_bulk_noprof+0x8d/0x370
[ 2138.124499]  kmem_cache_alloc_bulk_noprof+0x8d/0x370
[ 2138.124506]  __alloc_skb+0x35c/0x3b0
[ 2138.124511]  napi_alloc_skb+0x4c/0x110
[ 2138.124514]  igc_poll+0xf1f/0x1c80 [igc]
[ 2138.124538]  __napi_poll+0x2f/0x190
[ 2138.124544]  net_rx_action+0x299/0x4c0
[ 2138.124552]  handle_softirqs+0xd1/0x2a0
[ 2138.124559]  __irq_exit_rcu+0x44/0xa0
[ 2138.124564]  common_interrupt+0x81/0x90
[ 2138.124570]  </IRQ>
[ 2138.124571]  <TASK>
[ 2138.124574]  asm_common_interrupt+0x26/0x40
[ 2138.124578] RIP: 0010:mwait_idle+0x49/0x60
[ 2138.124586] Code: 80 0e 40 48 f7 06 10 00 00 00 75 1f 48 89 f0 0f 1f 00 =
31 c9 31 d2 0f 01 c8 48 f7 06 10 00 00 00 75 09 31 c0 31 c9 fb 0f 01 c9 <fa=
> f0 80 26 bf c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[ 2138.124590] RSP: 0018:ffffab8bc01abef8 EFLAGS: 00000246
[ 2138.124594] RAX: 0000000000000000 RBX: ffffab8bc01abf0f RCX: 00000000000=
00000
[ 2138.124597] RDX: 0000000000000000 RSI: ffff91b9c0959080 RDI: 00000000006=
6674c
[ 2138.124600] RBP: 0000000000000000 R08: 0000000000000402 R09: 00000000000=
01c00
[ 2138.124603] R10: 0000000000000000 R11: ffffffff8a78a5e0 R12: ffff91b9c09=
59080
[ 2138.124605] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[ 2138.124609]  ? __pfx_set_next_task_idle+0x10/0x10
[ 2138.124619]  default_idle_call+0x39/0x60
[ 2138.124626]  do_idle+0xbd/0x210
[ 2138.124632]  cpu_startup_entry+0x29/0x30
[ 2138.124639]  start_secondary+0x95/0xa0
[ 2138.124645]  common_startup_64+0x12c/0x147
[ 2138.124652]  </TASK>
[ 2138.124654] ---[ end trace 0000000000000000 ]---




