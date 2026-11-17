Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954589;
	b=pDJhPVMDLBycZ/aT1G99RripvJBDwvnqiK3n73X4cbgXO3GVoXRyrWj6GqNQk8+0Iyyc
	 f0Zrl38/lhwLqUQjopwxq+NfAO2W6YgCE+o2Il8FqFkfkiFE6FdZHH/iaP+ryLy/MW5Nw
	 COeFsb4pN8h2kjD+wIG8BAofUWidwt+/eSzt5KcoYZPOjj+tLLQk3nVrfY7xH9xhQNLOt
	 RE/s/+0AwUyu61j5coTDbubsuZw8LqZsygk4kt0x9HY6n2gSYHkjSivHEAABmGJNW8yZ7
	 u/qpry4IE5MgUld5i+zzMug4HJLYm5S0551Nnv92girms2UG23DkgZZvNzSv52K3ykg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954589;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qo8xXJc3Mp4P96fCJAZDQldRqGD5RCtuIUJWfIukpEI=;
	b=5ocrgO7z4aENtkX+orWKjd56cQk9yfBIRddQfCE/CkGe3VAYy3MKpZvfRdgKp/osWZhw
	 2iojTrmwK9X+jJIUA2KsKIUZpSaBIhLQIqh/gTsVl/FuasQ9ucTPbi+Ab5vZ/zC2Hoh4J
	 +jPfV06K6d9Jt9zzocS5kpCkS3GbaeD72aDgDQ7bA6cp+fVV0GVUrXjxKG7+n8pxLvXEc
	 /mula0ohqiaA/01JzuqYDz5rUFETe5xJEWf/YNnZJwSHXhttq82vsPHg4zmXNUMpUtGsL
	 gmYVPDBVIedw1wFO29cnT4VuzhoadL8k2iz+8/TB/kMCdB7ihpN5sujwFXDYDinjceQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVOadpmS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71623606A880;
	Tue, 17 Nov 2026 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVOadpmS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEDC1F000C4;
	Tue, 17 Nov 2026 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794954589;
	bh=qo8xXJc3Mp4P96fCJAZDQldRqGD5RCtuIUJWfIukpEI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZVOadpmSJvAnKfgiRjhCC7Mev2RiYCfRptFlRb/5Bqj4SUbKOfmyhY+jbTPLc39kf
	 BAFdhWWo8saiz7w7XTtA8l6OwkFuxiq0Ql4bDQYUUbS+RclR1fDFCknHnInlurMohL
	 ZUbr5kpOp2bDm8EJlheX/ptuKigDUgSNNdFGaMK0YFtD4SNtzsRxqBshMGvhYKDsxq
	 joW/t+CC+G7fSOd4iaEtY4ZQ6LdvvS43jaIvow+RN0Py4J/3j1Y8U1/lf2YLxxCYLS
	 HPP/FL+mSgpA6oojLp8EudUM2viN+QxHw86vc24BXRR+DUSFt5/GjyMG7PM+x7sV+k
	 gVOeHVXlcgpBA==
Subject: Re: [PATCH net 4/7] mptcp: push queued data on passive TFO subflows
 becoming established
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 mason@kernel.org
Date: Tue, 17 Nov 2026 22:29:48 +0000
Message-ID: <179495458816.3136.11667924714644178222@kernel.org>
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-4-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-4-bf7656de653e@kernel.org>
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

- [Low] The commit message of "mptcp: push queued data on passive TFO
  subflows becoming established" describes behaviour that depends on an…

--

mptcp: push queued data on passive TFO subflows becoming established

With TCP Fast Open, data written by an MPTCP server before the third ACK
could stay queued after that ACK, because the ACK carries MP_CAPABLE
without DSS, so ack_update_msk() is never called. This commit makes
check_fully_established() call __mptcp_check_push() when a subflow becomes
fully established on a passive TFO child (syn_fastopen_child), so the data
is pushed at that point.

Closes: https://lore.kernel.org/mptcp/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/

> Without this patch, and before the
> earlier commit "mptcp: arm the rtx timer if a push leaves data behind",
> this data was not sent:
>
>   server-tfo-write-before-3rd-ack.pkt:24: error handling packet: Timed out waiting for packet
>
> Since this earlier commit, this data is sent, but only when the MPTCP
> retransmission timer fires, here after one second, as the tests increase
> its interval:

[Severity: Low]
Which tree is "mptcp: arm the rtx timer if a push leaves data behind" in?

That commit doesn't seem to be present here, either at this commit or at
the end of the series. The following patch, "mptcp: push queued data on
subflows falling back at the handshake", refers to it the same way. Neither
message gives a SHA or a lore link for it.

In net/mptcp/protocol.c, __mptcp_push_pending() still arms the rtx timer
only when data was copied:

net/mptcp/protocol.c:__mptcp_push_pending() {
    ...
	/* Avoid scheduling the rtx timer if no data has been pushed; the timer
	 * will be updated on positive acks by __mptcp_cleanup_una().
	 */
	if (copied) {
		if (!mptcp_rtx_timer_pending(sk))
			mptcp_reset_rtx_timer(sk);
		mptcp_check_send_data_fin(sk);
	}
}

__mptcp_subflow_push_pending() also arms it only inside its if (copied)
block.

So in this tree, without this patch, the data would hit the "Timed out
waiting for packet" case. It would not be sent late, after the one second
delay.

Could the changelog say where that commit lives, for example with a SHA or
a lore link? That would let stable backporters find the dependency and see
how the two changes are ordered.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e%40kernel.org
