Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184486;
	b=3/AQoQGG+cFMAsDpK54lNFJkhHT+01+SyHAeB13zMOmSdpruc+mcTEoj/irWBHmCkYaw
	 BD+v4XpEQXEg7uWlcWOhTanKFgVysZiYyecRIBhfvUk0h20q05DjkKpgsNarYq6E20jg4
	 5fcqFAZ6yDDcOLyODUn3UDRKVP4iUZEsLnuu4IB3LEUjLmAxuZXMVr1MSxAYnjQb4akJi
	 YwQ1135zSsfQRp82r2ZBdNhQq3hXCv4dx2xYy8LZLXVedZtJ6ukt10OFsEPRP3tDol/ba
	 khBVq2e15k/J0MQldqT438vxrOg68m5g3xRhGik7h8VCzsjyz72XBeHehU66v3OX+RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=E5xnbRRvGX+emrk4N91VB6sFX36KActaF1Z2z7YOGMA=;
	b=fAL55lkuPlb6G9bkYRPeEOlM0mFC4OBuvdICtCwWfQmBGcMscEnt9HVvq9k7zeUoWgEH
	 0rA1UIINAw6NmBVavux0kTKsbW93F+34jG+v6I6ulPtLCWdRRDhLdgijdFnRtAofZrXet
	 V06tsUf0iMAt8F9dHQSIs8ldDZ+kVLnMGoMrODGJo+Un6oL5L3ltsRzBPkl0DAggNZh4b
	 N3acYFKZNod3DKXMVVhZV+Vt2PUq8bAgcbFELp09Cl1jAsHfRd6/9gdvVeVdFF7AChNVj
	 60BIWeLJDh/RVD9SIvQVADYH/Aa58j3NTQk+6qEoGB1pd4oWAyRDCt4fxeIDX6GAm9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=na8FO8YP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5C60A2623
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=na8FO8YP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36981F008A4;
	Mon,  9 Nov 2026 00:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184486;
	bh=E5xnbRRvGX+emrk4N91VB6sFX36KActaF1Z2z7YOGMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=na8FO8YPJnZkd1WouSq2wWMgJsGTnW5dCzvQtvPXoqmpaOvmWU7sOstNnXcqOIwg/
	 nZiRMFea6m1hAlWLKjDzWlYcpPGjSK6DzrJReSFYOPryWt4kvCjmzFkzA4lusC8bgt
	 ZEJ55hEW6yKmygY/dBPCHdK/2p7s7qjqAt0OTuhM+IQZsWqxDrs/t9xbasD7TuwcZH
	 P7srL4h5G7tFfVeyuXhVmMJM9VhB3gvt1MVKLog2/OfaEsHtUUkRIsoebcuoecOWXX
	 W3i22bxxzCh1vmU3+8OhnGe5AZZzwZE30E0kAvo4O5DysG57s1NM5rg52C01zvypsC
	 /rJR7lO9QJGZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Siwei Zhang <oss@fourdim.xyz>
Subject: Re: [PATCH 5.10.y 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sun,  8 Nov 2026 19:34:32 -0500
Message-ID: <2026-11-08-1-daily-reply-0004-l2cap-a2mp-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108000617.1969616-3-oss@fourdim.xyz>
References: <20261108000617.1969616-3-oss@fourdim.xyz>
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
patch) and resend the 5.10 series. The 7.3 through 6.1 versions are queued.

-- 
Thanks,
Sasha
