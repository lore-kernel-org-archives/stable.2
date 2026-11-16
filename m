Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846074;
	b=V45t+f7f7OPN+ctb8mttxLeEMWms03DQxWmMfcqPRFiP0qMAFkSE1YvOG8s/HBHAFde7
	 7KE6GKvyp1MTvZFGfxuivOf6Brf+AMKNxR6alD4DwzHd6IyziBrcqDQELtDjBCSk7fVBc
	 tnihUH9kCGfc5ydLXw5xMvIm/a3NT4Iv5H5qEAFSHI3LzXtLtU77uVnMLspYX7bsZTsnJ
	 HirTwwbb3ACoDrbFFWspfTSygXr4MaEz6DEHLKQNVnTu0aMu4wlogpLhEjVCctgkhlGg6
	 OBMxCUd+sywjSy+SiAHHWFm1RPFaxAv6d3GnvSBGPxBxS9n/8lPdcq1x1+Puk1Xh1qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846074;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KfrMIznTPxa2yE9FrkggciGBvOzUaeqzqHBaXFUlP00=;
	b=pAbS8TYNkaRlcZVVZegUOp9AOTF5geePaRVsX4ga4ScsIAADfNlHkoaSAtjxlDkMgYQg
	 y9c56Mfx11K1PqkEvjVFtEHeIPTQGZUiR1c6+oGiAMABZU1hbiF03Y0kMWwMFO469KRg4
	 fr98AQJgm/wjeUoTsdTMfGQOWWOG1GTyKU9kTOsABJtCQw/sK6Hrj2g+KFQ8emcHS3AOM
	 x81qNSkLS7RKJ9Z3ruPQEcSFuGohv8g8WXvuAHjFazXa/b0n3BBipzAR8acDVrcdmC9zP
	 WYkuAloSdzfbkOP24g7Iqdcz+evRKYq53t6A9n8IGZjuahEsyAt10bWbNPi0W2/TxTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlNCtANk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576F606A31C;
	Mon, 16 Nov 2026 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlNCtANk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B6D1F000C4;
	Mon, 16 Nov 2026 16:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794846073;
	bh=KfrMIznTPxa2yE9FrkggciGBvOzUaeqzqHBaXFUlP00=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jlNCtANktlATNh7bwB7zOXxHXMW8lACqeqU4vjMj9/REAp0CtRTDxZ2DU2lMkW2v7
	 YlpBslE4i8vmj8E2sQ4gevyd4BDW/bvYco2ysHENbgUpl8kGuWhbDJuTt3QRa95pvs
	 9/INmLz9lyfW3NU32GaT9sBZtoEEfm5GlaAN+ncqBmp4N+WR1fYUdnMxywwcA6jFyX
	 KLA7FDJwIqeUNkWKrmTnzCebzVfejieBCA7NyDQy6dKh8J+TdPopQbtGxCGLXXIj6n
	 oA/dtX9jxM8GfZvPEl6PiNgg6MGWQqhVkdCrDc5JLJWQyXz2g86D2L2mxiJq3Ri4VI
	 oYMyszXWzrcXQ==
Subject: Re: [PATCH net] net: qed: fix dead NULL check on the MPA buffer list
From: netdev-bot+sashiko@kernel.org
To: zihengw03@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 16 Nov 2026 16:21:12 +0000
Message-ID: <179484607270.3136.35330548202236483@kernel.org>
In-Reply-To: <20261115161815.941090-1-zihengw03@163.com>
References: <20261115161815.941090-1-zihengw03@163.com>
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

- [Medium] The commit message says nothing guarantees that mpa_buf_list
  is non-empty, and that whether it can run empty "depends on traffic…
- [Low] The commit message says commit fbb8bc408027 ("net: qed: Remove
  redundant NULL checks after list_first_entry()") "removed the other…

--

net: qed: fix dead NULL check on the MPA buffer list

This commit changes qed_iwarp_ll2_comp_mpa_pkt() to use
list_first_entry_or_null() instead of list_first_entry(). With that, the
existing "No free mpa buf" check on mpa_buf_list can actually fire. The
patch has a Fixes: tag for fcb39f6c10b2 and is Cc'd to stable.

> Buffers taken here go back to mpa_buf_list only through
> qed_iwarp_process_pending_pkts(), which keeps a buffer on the pending
> list while an FPDU is split across packets (-EBUSY). Whether the list
> can run empty in practice depends on traffic and rx_num_desc; the driver
> already has an error path for it, which just never runs.

[Severity: Medium]
Can mpa_buf_list actually run empty here?

qed_iwarp_ll2_start() posts rx_num_desc RX buffers on the MPA LL2
connection. It then puts exactly rx_num_desc mpa_bufs on mpa_buf_list,
and the comment says this lookup is not supposed to fail:

drivers/net/ethernet/qlogic/qed/qed_iwarp.c:qed_iwarp_ll2_start() {
    ...
	rc = qed_iwarp_ll2_alloc_buffers(p_hwfn,
					 data.input.rx_num_desc,
					 buff_size,
					 iwarp_info->ll2_mpa_handle);
    ...
	/* The mpa_bufs array serves for pending RX packets received on the
	 * mpa ll2 that don't have place on the tx ring and require later
	 * processing. We can't fail on allocation of such a struct therefore
	 * we allocate enough to take care of all rx packets
	 */
	iwarp_info->mpa_bufs = kzalloc_objs(*iwarp_info->mpa_bufs,
					    data.input.rx_num_desc);
    ...
}

An mpa_buf only leaves the free list in qed_iwarp_ll2_comp_mpa_pkt(), and
only for an RX buffer that has just completed. It stays on the pending
list only while qed_iwarp_process_mpa_pkt() returns -EBUSY for it.

The -EBUSY paths are win_right_edge, cp_pkt/recycle_pkt and a send_fpdu
prepare failure. In each of them, that mpa_buf's own RX buffer has not
been reposted yet. cp_pkt recycles the previous buffer (fpdu->mpa_buf),
not the current one.

So every pending mpa_buf holds an RX buffer that has not been reposted.
When a new completion arrives, at most rx_num_desc - 1 mpa_bufs are in
use.

rx_num_desc sizes both pools. Doesn't that make the "No free mpa buf"
path unreachable, whatever the traffic or the value of rx_num_desc?

The only crash evidence in the changelog is a test module that empties
mpa_buf_list by hand. The list_first_entry_or_null() change looks like
harmless hardening. If no real path empties the list, do the Fixes: and
Cc: stable@vger.kernel.org tags still fit?

The changelog also treats the existing error path as a valid way to
handle an empty list. If that path ever ran, it would repost the RX
buffer and drop a TCP segment that firmware already sent to the
unaligned MPA path. Wouldn't that leave the connection's FPDU reassembly
state (incomplete_bytes and fpdu->mpa_buf) out of sync?

> Commit fbb8bc408027 ("net: qed: Remove redundant NULL checks after
> list_first_entry()") removed the other checks of this kind in qed where
> the list was known to be non-empty. Nothing guarantees that here, so
> keep the check and make it effective with list_first_entry_or_null().

[Severity: Low]
Is this an accurate description of fbb8bc408027? That commit only
changed three functions in qed_ooo.c: qed_ooo_release_connection_isles(),
qed_ooo_release_all_isles() and qed_ooo_free().

The same redundant pattern is still in other parts of qed: a NULL check
after list_first_entry() inside a !list_empty() guard. For example,
qed_ll2_txq_flush():

	while (!list_empty(&p_tx->active_descq)) {
		p_pkt = list_first_entry(&p_tx->active_descq,
					 struct qed_ll2_tx_packet, list_entry);
		if (!p_pkt)
			break;

There are similar checks in qed_ll2_txq_completion(), qed_ll2_rxq_flush(),
qed_ll2_tx_packet_notify() and qed_iwarp_free_prealloc_ep(). There are
more in qed_spq.c, qed_fcoe.c, qed_iscsi.c and qed_nvmetcp.c.

All of these are guarded, so none of them is a bug. Could the changelog
avoid saying that fbb8bc408027 removed all the other checks of this kind
in qed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261115161815.941090-1-zihengw03%40163.com
