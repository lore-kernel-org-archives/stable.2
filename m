Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774412;
	b=t8OzIWHRNF1afKIeOcw94S13TG/dcer14lel1wAhCOSfJnPxQ5UwoG3nq4pMR3T81QIZ
	 rhgyWsO+p5179dTfl5Wy/0n2FUH34k3I4TbqPRH+zDLV2PFpwIp9f6R+PUJb41lAMlZ3Q
	 xUUMRgbln6r23z5ScYqyK+WMw0xx9T++ufFIzQw8Mrze40WC+JrWw0DLuvvhe9NYW4wEe
	 B24p920t8v/tsV+a8Uozbulb09jDB/3qmzSC7CST2SCH7LZWtOc0KuY/Be7sXhXIRuxuY
	 54dB5wnd2PlX5SCMkg+k1QJ/3kR7STQm09Egm2sGdaT+4XzoUJPVqHtcenA3oLJRNXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774412;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Cdp4y+NU/kVwGHCxRbY2Msr2auB6YOWOh/0ZbWxjaPM=;
	b=zKHR5y16O+fQ6UWW5rzZs12X97NPxq0+BAQ3/eTztF9jsdz9LTcO7KovbxwJfQY3j9SZ
	 vknpSGxW+FPlJTNqC/DfuxwKSEyLsFJ2fuIVYSTahrVOnU/m+iriyEhHjH9Q2fe13umpv
	 BzbvywkiXomDRB/8sMNiFPYeEDUjwGSdHWBJd6VUaBKXdLJSmXM5f4g1Z/9KSNO+zUgx7
	 44cn8iB6uvrYjbdi4yQiLvv64V/OiEsWLVdjZh6G0OwoyQmnoCQkXwhkKnmxkfu52rnp6
	 Q8o1KBXEKBjk9oza1DwHKUinZQh8g6ssqjRqbBdUNJPAzrGYYhG5ZVDKvvpFZmolQWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtN5IqiK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376A606A331;
	Fri, 27 Nov 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtN5IqiK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B6D1F00897;
	Fri, 27 Nov 2026 10:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774412;
	bh=Cdp4y+NU/kVwGHCxRbY2Msr2auB6YOWOh/0ZbWxjaPM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MtN5IqiK0Le+qSmGizqREknUJkOENsWEDWxcFrWTgvyCt7Ar/tZRIJZZWnIxrk9G0
	 mpj2gfkRZvD97s4yMnStIWxgfGDoDXKk8gS8aX1qAHqrisMSgdLb4AgwvhPTmGm26G
	 StPTMRpsCHNm357pcD7Yduj2wvH3f/zxNXfVEg6zJDgtg7r8rZd+naCLKXLRC+XdO6
	 wPMuCFYHQnn6qIdZi6RQZVGFqJb1KcrFcIkevYZvBMAeA56qxZpN4eUQv1DhFxIItk
	 7TkNR5J1GAjOs2kXV0TrUHmjTzl2/+LI4h5fuUBW2/xK2o28w+vrXNiCjYvThaq0IH
	 fjTqEoC35U1fA==
Subject: Re: [PATCH net v3 03/10] rxrpc: Fix carrying of in-flight calc over
 retransmission
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 10:13:31 +0000
Message-ID: <179577441120.3135.18228727853946391641@kernel.org>
In-Reply-To: <20261124161302.4044422-4-dhowells@redhat.com>
References: <20261124161302.4044422-4-dhowells@redhat.com>
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

- [Low] The commit message for "rxrpc: Fix carrying of in-flight calc
  over retransmission" explains the mechanism: in_flight was computed at…

--

rxrpc: Fix carrying of in-flight calc over retransmission

In rxrpc_tlp_send_probe(), this commit moves the rxrpc_tx_in_flight()
calculation to the point where the value is used. The value then reflects
any (re-)transmission done by the TLP probe. Before this patch it was only
refreshed after new data was sent, and not after the rxrpc_resend_tlp()
retransmit path.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201258.290827-1-dhowells%40redhat.com

> rxrpc_tlp_send_probe() calculates the in_flight value at the top of the
> function and then doesn't use it till the bottom of the function - after it
> may have done (re-)transmission, which would change the value (though it is
> recalculated in one place).
>
> Fix this by calculating that value at the point it is needed.

[Severity: Low]
This isn't a bug, but could the commit message also say what goes wrong
because of the stale value? The patch is Cc'd to stable, and backporters
would find the user-visible impact useful.

In rxrpc_rack_timer_expired(), the timer mode is cleared before the probe
is sent:

net/rxrpc/input_rack.c:rxrpc_rack_timer_expired() {
    ...
	call->rack_timer_mode = RXRPC_CALL_RACKTIMER_OFF;

	switch (mode) {
	...
	case RXRPC_CALL_RACKTIMER_TLP_PTO:
		rxrpc_tlp_send_probe(call);
		break;
    ...
}

In the retransmit branch of rxrpc_tlp_send_probe(), the call to
rxrpc_resend_tlp() increments tx_nr_resent and may decrement tx_nr_lost.
Both raise rxrpc_tx_in_flight(), but that branch never refreshed
in_flight.

Suppose in_flight was 0 on entry: every outstanding segment had been
SACKed or marked lost, but acks_hard_ack was still before tx_transmitted.
After the retransmission, the old code then skipped this block:

	if (in_flight != 0) {
		ktime_t rto = rxrpc_get_rto_backoff(call, false);

		call->rack_timer_mode = RXRPC_CALL_RACKTIMER_RTO;

That left the RACK timer at RXRPC_CALL_RACKTIMER_OFF with no RTO armed
behind the probe.

Could the message add something like "no RTO was armed after a TLP
retransmission, so the call could stall until another timer fired or an
ACK arrived"?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124161302.4044422-1-dhowells%40redhat.com
