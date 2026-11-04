Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796820;
	b=StQi0Z2kH0wll4RgwpgURAJTWq1hiL0JJCNc6HLaIb+aGQN1bKenUileXJCfR4poIT/S
	 REocrFKtHWAi7cZ4OHtEgNWYGsvkQecjvgG0rGWgA+7sPagqCQAvPDHzoem2kfscAKxVq
	 pPxjcNUxfqIdM/RaZeDc1AcNpYcM4OihwSTwDqT0LoeEiJHypPgFn4EWMDlBcktcegGen
	 JjVXFy9cAC/RpakZI0LNKVUiXfJ2+2cKMcxDH23i4sQvq9q3SaJKnkYoLWAnD67KBB5lZ
	 /Q+wqkGBsdZUpcMOMVhXa13eRKa4uOUB6dgLtHsWg4lIdvBbztEqEpsNW1p0F90OvQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796820;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=vqyU8gaxW5boCfEBaHE56vwfREez6eNsMfJLNUhaTSI=;
	b=tPMHyL6jI59yiItE5bp/UKWnnXhDLYy/4wD6s1HYRUDqwKycsLSkMFevMj8auIwQp0GM
	 Orl9E3yHnCm33qd3DLr9yAwpc7vj/cBFkAskJTKk/7mtKCl2aY4eGl/RueN7nga4PYbs0
	 37BUGLMcXzONGNQeF3yAFrUYVcUsVahitYtYhMv98hGlAk9fwTSvI5fGXKlOF0k0hWvcV
	 lIXCekjTuCi4JW+kaBH5jeMmgTIWD7FrWXlWV1leBN/BTKzxr5i834Y9uq6Hc10ueGN4B
	 XNw61os2uzaOUiFOxiDQstrnu74kWuBNSjx0qw3nOs1gwN6JoeGQBlWV5ZwOL5iWbww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpFN7Haj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC20606A32C;
	Wed,  4 Nov 2026 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpFN7Haj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8359C1F000C1;
	Wed,  4 Nov 2026 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796820;
	bh=vqyU8gaxW5boCfEBaHE56vwfREez6eNsMfJLNUhaTSI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TpFN7Haj7mKwkjZMmYwhnZQfkBeyCL7PAbHFRfAcmoNGV4f0suKM2RmTYWcCtHarc
	 DzdK+iPOnErEJ9mPczxczdWF6bM/ikROLoHk2oFVQTyNobetpzqBwlN6vWlhlEShTZ
	 vmqiMyuR7957gxJjFiGXVrYQSPxY6WE4on+w9JPJ5jUtcmcye1mdEH6hcTs92JzLj4
	 EtekNSSJk3SKbwXDlGbB4V64FiETSnxyTLfL84XdLoRGw7r8/oT7q+n+pmygqDtQJY
	 3isuBE4BXzb3WFfml7cob9/jdJLDehdgHTMurX6a3ZSwd6Bftt9ctIKpvCXFZUmw2G
	 9ZSka7iexN7Xg==
Content-Type: multipart/mixed; boundary="===============4797847260331115320=="
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f961f3c75c43966220cc47a1fc20b1fac8a1d4763c9657e3c6c9566eb5b9f3a9@mail.kernel.org>
In-Reply-To: <20261104121316.1155680-4-sst@poczta.fm>
References: <20261104121316.1155680-4-sst@poczta.fm>
Subject: Re: [PATCH v6 bpf 3/3] veth: update mem type in xdp_buff
From: bot+bpf-ci@kernel.org
To: sst@poczta.fm,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,magnus.karlsson@intel.com,aleksander.lobakin@intel.com,ilias.apalodimas@linaro.org,toke@redhat.com,lorenzo@kernel.org,ihor.solodrai@linux.dev,tavip@google.com,maciej.fijalkowski@intel.com,sst@poczta.fm,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 12:53:39 +0000 (UTC)

--===============4797847260331115320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> veth: update mem type in xdp_buff

TL;DR: Commit message/stable tag question: the Cc: stable prerequisites may be
incomplete, since the patch needs xdp_convert_skb_to_buff() and the veth frame
mem type commit, which may not be backported.

> veth: update mem type in xdp_buff
>
> When skb's headroom is not sufficient for XDP purposes,
> skb_pp_cow_data() returns new skb with requested headroom space. This
> skb was provided by page_pool.
>
> For CONFIG_DEBUG_VM=y and XDP program that uses bpf_xdp_adjust_tail()
> against a skb with frags, and mentioned helper consumed enough amount of
> bytes that in turn released the page, following splat was observed:
>
> [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
> [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11c98b
> [   32.210084] flags: 0x1fffe0000000000(node=0|zone=1|lastcpupid=0x7fff)
> [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000 0000000000000000
> [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> [   32.220900] page dumped because: page_pool leak
> [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
> [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
> [   32.224638] Tainted: [O]=OOT_MODULE
> [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   32.224641] Call Trace:
> [   32.224644]  <IRQ>
> [   32.224646]  dump_stack_lvl+0x4b/0x70
> [   32.224653]  bad_page.cold+0xbd/0xe0
> [   32.224657]  __free_frozen_pages+0x838/0x10b0
> [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
> [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
> [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
> [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
> [   32.224673]  ? xsk_destruct_skb+0x321/0x800
> [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
> [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
> [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
> [   32.224688]  ? veth_set_channels+0x920/0x920
> [   32.224691]  ? get_stack_info+0x2f/0x80
> [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
> [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
> [   32.224700]  ? common_startup_64+0x13e/0x148
> [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
> [   32.224706]  ? stack_trace_save+0x84/0xa0
> [   32.224709]  ? stack_depot_save_flags+0x28/0x820
> [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
> [   32.224716]  ? timerqueue_add+0x217/0x320
> [   32.224719]  veth_poll+0x115/0x5e0
> [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
> [   32.224726]  ? update_load_avg+0x1cb/0x12d0
> [   32.224730]  ? update_cfs_group+0x121/0x2c0
> [   32.224733]  __napi_poll+0xa0/0x420
> [   32.224736]  net_rx_action+0x901/0xe90
> [   32.224740]  ? run_backlog_napi+0x50/0x50
> [   32.224743]  ? clockevents_program_event+0x1cc/0x280
> [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
> [   32.224749]  handle_softirqs+0x151/0x430
> [   32.224752]  do_softirq+0x3f/0x60
> [   32.224755]  </IRQ>
>
> It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED was used
> when initializing xdp_buff.
>
> Fix this by using new helper xdp_convert_skb_to_buff(). Unlike generic
> XDP, veth turns the xdp_buff into an xdp_frame on XDP_{TX,REDIRECT}, so
> the head is later released through the mem type as well and the
> helper's frags-only reasoning is not enough here. Advertise
> MEM_TYPE_PAGE_POOL only when the whole buffer was just copied into
> rq->page_pool by skb_pp_cow_data(); otherwise keep the queue's original
> MEM_TYPE_PAGE_SHARED model. An skb that skips the CoW has no frags, so
> nothing can be released through the mem type while the program runs.
>
> XDP_{TX,REDIRECT} no longer reset the mem type to the queue's original
> model before the buff is converted to a frame, as the frame has to
> carry the type chosen above. Nothing needs to be restored afterwards
> either: the previous patch makes the frame path set its own mem type
> and every skb sets it here. Add a page_pool variant of veth_xdp_get()
> so that we avoid refcount underflow when draining page frag.
>
> Frames redirected out of veth can now be MEM_TYPE_PAGE_POOL. A devmap
> egress program only releases their frags correctly since commit
> b3ca872947ef ("bpf: Use the frame mem type in devmap egress XDP"), so
> that commit has to come first when backporting.
>
> Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
> Cc: <stable@vger.kernel.org> # 6.4.x: b3ca872947ef: bpf: Use the frame mem type in devmap egress XDP
> Cc: <stable@vger.kernel.org> # 6.4.x
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> [sst: rebased onto bpf/master; claim MEM_TYPE_PAGE_POOL only after CoW into
>  rq->page_pool; take page_pool refs on compound heads via netmem helpers;
>  drop the rq mem model restores as every path sets its own mem type now;
>  dropped Reviewed-by as the code changed]
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
>

The changelog says b3ca872947ef has to come first when backporting, and the
Cc: stable tag lists only that commit as a prerequisite:

  Cc: <stable@vger.kernel.org> # 6.4.x: b3ca872947ef: bpf: Use the frame mem type in devmap egress XDP

Does the prerequisite list also need 7a20126eee2a ("xdp: introduce
xdp_convert_skb_to_buff()")?

veth_convert_skb_to_xdp_buff() now calls xdp_convert_skb_to_buff(), so this
patch will not build without it.  That commit has no Cc: stable tag, and its
Fixes: target is newer than the 6.4.x stable target given here, so stable
tooling may not pick it up for every tree this patch is tagged for.

Should 7a20126eee2a get a stable tag?

Similarly, dropping the rq->xdp_mem restore is only safe once
veth_xdp_rcv_one() sets the mem type before the program runs, which is done
by 8fbcefc9f069 ("veth: use the frame mem type when running XDP on an
xdp_frame").  Should that commit also be listed as a prerequisite?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41828746707
--===============4797847260331115320==--
