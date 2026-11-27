Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774416;
	b=0o/Ky8TYT7D/vbDQ5w6+BOlZA0nbUM2dkzgg5AA1hbpVXdFKcVzroacEsn3czgZlel0P
	 th9QHwR/CDtBP9/ovqR5gnBYxkHZTOcUHr9/0YG7ui/mmvhoJaHy0DE49bMaUxE5BMbN3
	 pJby1hGS36Ye6ljVr2JlU6TEONkLsFiDMBdQ2kZyiu/uXXtrWx44mQfA6VxkcsZMPiXwX
	 A8+sgixXFFijS9GQKfXOEVZcGqAiNRcvR1sMLJjy3nKmlDClUOZxdjh87r1mMwkMoGHHD
	 e6pSR7Xsd81mJzUv1FvEPelaAcIyH5Aqqquc7qSyfGHWtlWab+VHqXdh3OY4TkR1lYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774416;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2DUY6z4JUx4XuUzTN36qvUc60BpHxHxrJWb2xIPMw5c=;
	b=uUUQny+WIyyT6dgN65FMpKqMa+o6nDXjoO+LbGz3XU0m4Rd7I125Wo9G9R66WhsPe2PO
	 1vCgqDptUxP0isa+5hVGwkfVtJOu1+m3KUd6Y6eYaooIzOwjlfp8Zb2S/+fIck5m1bAFa
	 Kk0ByWYpf8AYcF/jv5yZ/T23/QtiJrr9kfsIsuW1CVTZkcAvHgQxfmrJjV0kRgogpe9Ch
	 HJmSyVDbiSiYVV8zewvzJHmKX3MTVsxsB5/k8BRkv1c53YZAICU76DAdGohUPcUVN8Lse
	 oTed64KiciuVmtTY+QwOAVMGrZ2DzWYcJBqcdplRslS/EolLLdcXQbssLL4lvhpjcjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqitOORF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B6606A323;
	Fri, 27 Nov 2026 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqitOORF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA2F1F0092B;
	Fri, 27 Nov 2026 10:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774415;
	bh=2DUY6z4JUx4XuUzTN36qvUc60BpHxHxrJWb2xIPMw5c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JqitOORF4rvoKzl42R2FT2VhYXdQiDkbj5iTF60u2/uNuCaepvKCFvkKU3fbvf2Jm
	 4UrdoioeF6mVTEyV6LlN1uPUXw3+K+LNWmA5T53ZOjm9hTmY0qEpzAFzfQcjddc7+d
	 JAgu3Cq8yw5Hjd3uPs3NNGKfbnQ8gQRvEGghmnDqqHDw+FR3B6UFCF5BbAcyo//TX3
	 9j8Jl/5iV6Hrot138eDsZ7mRwvYgOUfRZxvruZLy+V+CvobTCIfDrOkUAwD+RpuJwI
	 OCJCRJvlnGxjPpkZfGDC23HTN/+C6u5fzHAEIn6Z0Fi+mbFoXJFXhavfx4BxMS0/2F
	 Oba800gf8DQJA==
Subject: Re: [PATCH net v3 05/10] rxrpc: Fix RTT processing for a presumed
 lost packet getting ACK'd
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 10:13:34 +0000
Message-ID: <179577441465.3135.4498965455896872277@kernel.org>
In-Reply-To: <20261124161302.4044422-6-dhowells@redhat.com>
References: <20261124161302.4044422-6-dhowells@redhat.com>
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

- [Low] The commit message for "rxrpc: Fix RTT processing for a presumed
  lost packet getting ACK'd" understates the impact of the bug.

--

rxrpc: Fix RTT processing for a presumed lost packet getting ACK'd

This patch makes rxrpc_rack_update() return early when the ACK'd segment
has had its segment_xmit_ts[] reset to UINT_MAX by rxrpc_rack_mark_lost().
Without this check, rxrpc_get_xmit_ts() returns KTIME_MAX and the RTT is
calculated from that value.

> With RACK-TLP, under some circumstances a packet that is presumed lost has
> its xmit timestamp reset when it is marked lost.  However, if an ACK then
> turns up anyway, rxrpc_rack_update() sees a bad RTT calculation because the
> xmit_ts is calculated as being KTIME_MAX.

[Severity: Low]
The code change looks correct. Could the commit message say more about
what the bad calculation leads to? A single bad RTT sample is only part of
the effect.

Before this fix, take a segment that was never retransmitted. Its xmit_ts
is KTIME_MAX, so rtt = acks_latest_ts - KTIME_MAX is a large negative
value. Both update branches at the end of rxrpc_rack_update() then fire:

net/rxrpc/input_rack.c:rxrpc_rack_update() {
    ...
	if (ktime_after(xmit_ts, call->rack_rtt_ts)) {
		call->rack_rtt	  = rtt;
		call->rack_rtt_ts = xmit_ts;
	}

	if (rxrpc_rack_sent_after(xmit_ts, seq, call->rack_xmit_ts, call->rack_end_seq)) {
		call->rack_rtt = rtt;
		call->rack_xmit_ts = xmit_ts;
    ...
}

This leaves call->rack_rtt_ts and call->rack_xmit_ts at KTIME_MAX and
call->rack_rtt negative. These fields are only written here and are never
reset. No real xmit_ts can be after KTIME_MAX, so the state stays this way
for the rest of the call.

After that, rxrpc_rack_detect_loss() computes lost_after from the negative
rack_rtt. Also, rxrpc_rack_sent_after(call->rack_xmit_ts, ...) is true for
every segment:

net/rxrpc/input_rack.c:rxrpc_rack_detect_loss() {
    ...
			if (rxrpc_rack_sent_after(call->rack_xmit_ts, call->rack_end_seq,
						  xmit_ts, seq)) {
				remaining = ktime_sub(ktime_add(xmit_ts, lost_after), now);
				if (remaining <= 0) {
					rxrpc_rack_mark_lost(call, tq, ix);
    ...
}

So remaining is always <= 0. On every later ACK, each segment that was
reported but not ACK'd is marked lost straight away, with no reordering
tolerance. This includes segments that were already retransmitted, and
the result is spurious retransmissions.

rxrpc_rack_mark_losses_on_rto() is affected too. With the corrupted
rack_rtt, deadline = now - lost_after can overflow, so loss marking on RTO
is also wrong.

Would it be worth describing this lasting loss-detection breakage in the
commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124161302.4044422-1-dhowells%40redhat.com
