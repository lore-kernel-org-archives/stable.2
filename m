Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774411;
	b=tGbFIshWIEmgjCXwP2xc/QzGqU2DjbnTCBnCMN/YtcPGkMjaD9ZUFLBkqeO+rlXqByNo
	 dnrp69EpqT6bRjyPueybF2WRd7qzl828MhbQ9WeKo/MPEUApjqUqdZ04O6MBk4pwJmuEN
	 hFCh1ZkAg+tN8fZHnQzDn1Ms2Vqo/P4WIkLCPD1S0ig0ULGH64u+7408lEcJE3JOqcSUa
	 +YlrwpjtQJX1lCZjetKzPakz+Hjp6XnZiBiHpQX4dFqvqXaIOBjZkx7KNixS5yZVs+aL2
	 XZi2Jt0y9Wgb7e2iAROGVl52I5DJhfnVGr1NPGB+BM0X1FNm5kIA+VZL4apiAgVBzfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774411;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5EEtXQ2PrPKow39VsKQpKiA8DKM12Edkw0WjIixiSrM=;
	b=aRL7PERxHCVGhUFLKkd1Ka9Hy++Wjdcwxm8sXkAAcICBbS2HaBlOIBK7G3UkIbHPaP/d
	 Yl/U0pUtf6cH1OZ1D33CYPILUXEuieV4O7EMFqaKjPf6Y01fsIxLlHJ2zkS8aVsXfBShk
	 fIhuADWtTX6fFB5HSbuHRoOH12Kv6D4X2vlNvji5Hw5L5b9OA+GuoVsIHefwGSKLi76nk
	 /XecKkU43Fj/UoOfuHn7VckRJ8fSLrR2QwFz8K7azbEAD1CWODGDIs7MNF3oIVBjRhlJR
	 XNU0SsZb67C28Ji4rdMC0MMluZ8XhXCXMhP1K1FRoY2Xt5EUBtoA6JJLe7yDXIlS9oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njOFpL7V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12B606A31C;
	Fri, 27 Nov 2026 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njOFpL7V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9531F00897;
	Fri, 27 Nov 2026 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774410;
	bh=5EEtXQ2PrPKow39VsKQpKiA8DKM12Edkw0WjIixiSrM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=njOFpL7VVZGSzLW5gfrvWVnQwvafApz9JVxQQ+pxEXUZmWiEE3FJUeDF31np/+k9j
	 /i3+gFrVuh6n/rbjKO8s995C1dh8tG0jco8QAY4hpmBeVrPSrxGJVj81FP4ilHhbL3
	 LezGJkTPDAnItsxna6MRqAaVG8kU98zNWUwoy9YtevwV9CHlHXOnkIjF48g0NKm8Pp
	 od2mSYlExrmWhKhilC+A74LDrSH5evptlD2h8ntMDUNWAVAsswOoeNIJoHm02HEmh3
	 v71rTlWd4ES6sb5JoFVm66hjoEXrcAbc3erDoKJvfyp6zDCIEVTuLaZTOk0vACU4n3
	 Zmvq2IirOdbdA==
Subject: Re: [PATCH net v3 02/10] rxrpc: Fix time unit conversion truncation
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 10:13:29 +0000
Message-ID: <179577440967.3135.13515803634362574241@kernel.org>
In-Reply-To: <20261124161302.4044422-3-dhowells@redhat.com>
References: <20261124161302.4044422-3-dhowells@redhat.com>
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

- [Low] The Fixes tag is incomplete, so stable backports of this fix will
  miss some LTS trees.

--

rxrpc: Fix time unit conversion truncation

This commit adds u64 casts to the srtt_us conversions in
rxrpc_propose_delay_ACK(), rxrpc_congestion_degrade() and
rxrpc_tlp_calc_pto(). Without the cast, the multiply by an NSEC_PER_USEC
factor truncates on 32-bit arches.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201258.290827-1-dhowells%40redhat.com

> Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201258.290827-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>

[ ... ]

> cc: stable@vger.kernel.org

[Severity: Low]
Should this patch carry more Fixes tags? Of the three hunks, only the
rxrpc_tlp_calc_pto() one in net/rxrpc/input_rack.c seems to come from
7c482665931b:

    pto = ns_to_ktime(call->srtt_us * NSEC_PER_USEC / 4);

The conversion in rxrpc_congestion_degrade() in net/rxrpc/input.c seems
to go back to 5086d9a9dfec (v6.2), where it read:

    rtt = ns_to_ktime(call->peer->srtt_us * (1000 / 8));

That multiply is u32 * int, so it truncates on 64-bit arches as well.
b40ef2b85a7d ("Manage RTT per-call rather than per-peer") later changed
it to the current form, which fixed 64-bit builds as a side effect.

The conversion in rxrpc_propose_delay_ACK() in net/rxrpc/call_event.c
seems to come from 153f90a066dd (v6.9):

    delay = (call->peer->srtt_us >> 3) * NSEC_PER_USEC;

The patch is marked for stable but only names 7c482665931b. Will the
stable tooling then skip trees that have the older truncations but not
the RACK/TLP commit? For example, 6.12 has both of the older ones. 6.6
has the input.c one, which is broken on all arches there.

Those trees also use call->peer->srtt_us, so they would need a tailored
backport.

Could Fixes tags for 5086d9a9dfec and 153f90a066dd be added? If not,
could the commit message say what the older trees need?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124161302.4044422-1-dhowells%40redhat.com
