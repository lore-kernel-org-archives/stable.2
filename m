Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461084;
	b=HYDhuD7/U/AoVYOpFVoT96+AsWKmA3zdf5k1dhQN9hvj7ckSPE3a6JwTfzaw8jAki5kx
	 fntFmcdo+4zBGoyIDR+dAdecd8T0PSiZ/nPLCL0dEontdOM5EDaOxH+/frXPCM9I7bwQr
	 o/EyxzvzLCVVIDJbhSBLx5ejUtkmnHZsY7M78c/IOGI/PVNJZ1KP4/UPvDz09kLeZehZD
	 CqXB2fWoKquYbTt9x+EPa+kbXPfRQzArtmZUhi0IvYnDhWdi5Jkaig8HXboPJkiBb2Lec
	 HvIWswrICwUa5MSPFfez8mrkMZ9w6h57OLwMR+XUsMhXHv8RDFjGtDKeepj7IlJyHFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MqjW0hsT+jUaSbjhgq/J0Q8J8U6i1pm0dFrQ9EH1or4=;
	b=lvq0Bachpgs/AkzXjKDSIZucY1YQE4rSEwCDTk12cqgZHfOw0qotH0VCX/61CAfPNiKD
	 lODLgHAc+5Z5cWGj9cqN+3R8Z3lmm32vlI03hwPI4z8HvmQhBZDzBW3rBDGWK8AQtcX9k
	 7+3kSNteZYkORWh9CJruHAKLvG7AI6sFRqHclcikk1EzQ0IfMwp4WjO3dS+RRO94JdHTI
	 47/9pyBs+bv4lNHvZyMQwGv6dAf7Do753FS0LDlk8Aji3QBu0GmC/YGA/8WjZeWp//y9i
	 thdFHHeRARtwuPWJEJJfCtaGfoKJUn9J/jUfayJdoa6WO6XHYMksvSPiLIvknLanlHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=Zc8hcYSc;
	arc=none smtp.remote-ip=74.125.82.226
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC4606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBBC4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=Zc8hcYSc
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-33fb4680717so9921594eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1795461083; x=1796065883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MqjW0hsT+jUaSbjhgq/J0Q8J8U6i1pm0dFrQ9EH1or4=;
        b=Zc8hcYScQnz85XtfBfVcG5UIkyudsTINdSxEfTb5Hjta0eF3zkJ/22em5JmMtALk3W
         d2JjGzuEoVF6A15xrw2lgsWugp7IXkf4XuKMyyHd6orzkoRKZ1Ydurq3E/itK6D+Qje9
         WaemBFGhPuHbrlLVvm08doVvwTz8rQobE2VzIt7IQuChKUxaVkXeqJ+2kvffHPF8cQuc
         FVb5ozWcIxtV0PsipLCriEYmBU+MXGAKnRpvy5vwP0bvCC1IdZD0ahmD7h07uEH6c/zt
         kEOLQ5+O+ktGk6amUCGE/de152uokpEFtf0g6+B7JgZErhSM8Owq46jl6vfmlYxXiMoo
         n5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795461083; x=1796065883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MqjW0hsT+jUaSbjhgq/J0Q8J8U6i1pm0dFrQ9EH1or4=;
        b=C7yUK7jINguV45KLvstez70jFboHaO74fx0+Fx22F2L6uIU0grZIRUQLxamJXXUEQp
         uVaUuZCPsnP1ZmJ6qyX8tTMKuw+kiE4GOh6LyLurjWoH2LEAILNGIpL+KxwYJg8W002z
         jY+7Jx04T3D8jTf/s82EZ/RvWgNOy6gexcJ2w2CApS4lRvBxxoTIp12+O28GyU2pImB7
         NjgyBcdTtrVG045RZ+AUpBkEO7c4a3WX5rXhTd7h4TQsaq8f9/ri3y53eXk9trqzKA8c
         OELTMVpeh/TWHObErkM4+xM9jU+7/VusIOkInk9zeogG3mXeYPABZmqtTwvUS7M+8e1s
         7Lsg==
X-Forwarded-Encrypted: i=1; AL+hErGIsY7b8ExZhSlDLl+3QyJXZuAiM30Z2RuRx4KlJH+Iq/2jYR+3cSJA8lyODaopzmlqzHYf+zc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SdYl0Q8g8ERKVBjFTGZQEgxhP8r5MG6n5p6hbRYAG55aEk57d
	RYeO5CN7a2iPH/5Uy32csFfc5CFZ+AafqfFVEqCuXwnIjneiMrhVEbOHBVF2Wv4K0SZ8OfBrrge
	TvNKpPmxpCEsd07B4ejxI0qOGgpjL756ae2O5
X-Gm-Gg: AZFdTZe7Uf8mUViDhHy0xCS680MBpVDqAUxxL3oncdYoWqYdMhqjhpP5cXy8mJUMVVX
	IArrrxPMrdRTTUk1wtTILlt77tiO94O/v54i5JXp9u3NJ0oHs+/8nPWLJj6KD0RSUjQzSJ8PYKl
	Guiz2t0kAB0dv6hDBpzKRMDJscxlCmTz19/enhvG2rSKF25V2aULjoMjsAbX/D7cEAsbJ/ZJWUZ
	4br1v/R8uPXrGVbn2DxUI+8zDShU2skfAi0V6wf6rn932Wp2B9rZIuREUvbtNmhx3phC2Hel+tP
	BvbG4a7hZnW6MeHYVr/1hiZUmfzKtdv8yzvI05ZNkC0MaX8BiosioroYdQ4+7kLnjMkH+KVF+Lb
	XUXAX6xLBuwNgTagjz8MrCo9StaXv80qKu94L3II=
X-Received: by 2002:a05:693c:8859:b0:386:b826:3f9 with SMTP id 5a478bee46e88-386b82605b9mr2057039eec.7.1795461082934;
        Mon, 23 Nov 2026 11:11:22 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.128])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3869bea0c92sm1285374eec.13.2026.11.23.11.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:11:22 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 53D713400F5;
	Mon, 23 Nov 2026 11:11:22 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: cel@kernel.org
Cc: anna@kernel.org,
	ebadger@everpuredata.com,
	jcurley@everpuredata.com,
	linux-nfs@vger.kernel.org,
	slingappa@everpuredata.com,
	stable@vger.kernel.org,
	tmenninger@everpuredata.com,
	trondmy@kernel.org
Subject: Re: [PATCH] xprtrdma: Retire the connection generation when a connect attempt fails
Date: Mon, 23 Nov 2026 19:11:22 +0000
Message-ID: <20261123191122.1682509-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <90d0ff6e-e9d2-4b2b-9b89-8245ce502e99@slotpi15m67>
References: <90d0ff6e-e9d2-4b2b-9b89-8245ce502e99@slotpi15m67>
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

> LGTM, with a couple of cosmetic suggestions.

Thanks for the review. Posted v2 in
https://lore.kernel.org/all/20261123190823.1680365-1-tmenninger@everpuredata.com/
