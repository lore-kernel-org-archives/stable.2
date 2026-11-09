Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184486;
	b=ZPRXedwIbXRiXld08WApjODlwnCXuM5F2QixDj8FMtEsQULsWceX6JNqyaQD+Ux4+09Y
	 6KZnRhqDfiz2HlRAXfyUrr9bj+rHBuHO+D9RCC/OMPb2JExODj80Pf7Y5x+lNoJD2nVv+
	 IuYtnYKBMCOGylbpgEqNobah+A4xcU9gLRmo9IkYgk5SaB7UKHv3UewMBC/wCXhwSgqaM
	 V0p7sU9H1LKnjZywCBo6OteKWpt5hmkDeVR5nEgmr8SQaWZqroqKrMSNobRRc41YWF4ln
	 PlZDfdf61nheT30xJSgRk/aPtSEyzPwi8HZXwigjgGh6V9Bow0MH8qSZkoqWkzQmL5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QNZVl5b+HgE9UeZXo5/shDDDByZ5nVgAEtH+ycjMTmQ=;
	b=NHEdwq2xS/PRfXlTjcUNktRJWu6S2gutqcX2XT87Pp+hNns71sjePhXOLTJT0jsKVgvn
	 9B0r+Eqa6KKPGI27YvmhLY94+arNtbqj2VDdt+UESvQ1440sS4fjjrHE8yPVO++LAjKqZ
	 9Tg5AwsP+yOy+ZT6gD61CepI/8PSg/3VWTeuVRBGiP2yXcNPTURryotVFcpe4lQHHpxL6
	 g6JMjDqfMgj4T/941rBuODD4y+1l2AzogFGl0X6QfB9BVamDNjLUgoplQnM8BVWUG6E78
	 OtbTFb+ysyFyIQyq08E0PPy+MtuUqoeY0/QWS8l/MjMYYrcjgDZqOqP9hBf8hWJLl0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GLe/0pdt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB3606A33B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLe/0pdt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EB01F008BC;
	Mon,  9 Nov 2026 00:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184485;
	bh=QNZVl5b+HgE9UeZXo5/shDDDByZ5nVgAEtH+ycjMTmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GLe/0pdt9R7lSQBUt1V5QoV07VY0VycNy6cW5XvR9aV8xJqcjVH6u7zNyAFwb/NkL
	 VQo+QZzX7UynNFP35xZJHtVHYpsb88SmjQVykHTU9YxAwC2fQG6s2kw4FOYZGe2qAU
	 XAp158bCORrujoSaCXTvbVD0NR3tT8r8IDSc/vQvkiJLdxEHYtqy39dqAe5ORK9j9o
	 2wrwt41RQpMGmmWmUbLKjOoRA9N1rTdNAnj856Za+NMR4yc2vpMYES7p+pfBufl2hw
	 vDNqm9OmsJfh3tgVg74wyTY6WeNMyZfbNZUMztw1eb2mRSFM63g/ixZwHaVa5jMNGC
	 D2FmjylgWehYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Siwei Zhang <oss@fourdim.xyz>
Subject: Re: [PATCH 5.15.y 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sun,  8 Nov 2026 19:34:31 -0500
Message-ID: <2026-11-08-1-daily-reply-0003-l2cap-a2mp-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108000542.1969015-3-oss@fourdim.xyz>
References: <20261108000542.1969015-3-oss@fourdim.xyz>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> +	/* Only handle the response to our own Discover Request */
> +	if (!test_and_clear_bit(DISCOVER_REQ_SENT, &mgr->state))
> +		return 0;
> +

This early return skips the skb_pull(skb, le16_to_cpu(hdr->len)) that every
other A2MP handler does. a2mp_chan_recv_cb() loops while skb->len >=
sizeof(hdr), so the payload of an unsolicited Discover Response gets parsed as
the next A2MP command header.

Please pull the payload before returning (or drop the A2MP extras from the
patch) and resend the 5.15 series. The 7.3 through 6.1 versions are queued.

-- 
Thanks,
Sasha
