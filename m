Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606658;
	b=LjHWOAkrEy0zcS6b/GhHmAOH7FGm8f/KIixiKkxQdqPFTM9PLJ1wSW5dPBHZ0B1mvtvl
	 Ab0ryEJ3a7k+RPaTPGuL+rJJ7JLuT3RzXt8+OBFW7bh6aE1rF2I5Od1ImMkKSFLomw8HO
	 Rd5sI32vo3u/p18/lQu+q6tjtFoADrPhR0SibNJzUI5gYDpZhhZISlU5MA4qrGdmCAYZB
	 8/ZcRApJ9AI6KXjvWGxhC20sFerIH4YahmDkg950s3wwvcbuxI088VSlzbFfvY4GeYQaj
	 40IsT4WdpC4r5UdB0HdYMWW/Iui/ea+d1U81mRJ/4/Rj1m2jpdBmejk9MIHXEA9zgCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606658;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
	b=yqragfVYvf4CrTXmqq1qbWmiDapAuQpndYVFrgU/wZaix2DVWlj8lpGPkmEsDn6QcWMm
	 XeyrmanVXSgkCpbu5hsXv4QJcjtfqMtpEK2Pt/qHFCXAc2RzPEZznshN/C0raIlVBxnHg
	 gOPeIlcFVg6rJvzp8TMr8Wprfoh456XIkg0TXGf5uvoYnKU1HL6YVZIlxMs75uIiNtzRn
	 3HFd0CV21m5r+L0TOHnk+7kszGDneU+1lleVy7ka+Pf4vPAQ6lwRkmgHFn5Fe1kQkvEOv
	 MrziiQAI1zgrnrvesVJtVM2nlp10yQdVBvihUx25+8A76CPPa27GirY3NH7NjEm7npw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KeQoy4j1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81647606A323;
	Wed, 25 Nov 2026 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KeQoy4j1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D96B1F000C4;
	Wed, 25 Nov 2026 11:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795606657;
	bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KeQoy4j1M6Kf+mD3CN76WOKGjFILfDFC6KZxaWDws4AmKYNd4Sv3XlzgxoJKRL43+
	 6iPzo0oo8tVQMfbyYC+lXZEZJ4CWZ2i0ZBHg/9U/732d+HqCx4/LXNd5qlcyCzEZZL
	 WBEKboxx9JvWcb/uu2ZQzLcGMZdMeWYkM+SaS6wlo0YZLOKwVzVZXZPT1YRQc2tRWk
	 yC3PUFTQKt7Qpz9Mh6nzy/WWz9j9vnjvF0uOOHLGRr1DYGHcWgXMnkbGrMjkj1Xpd5
	 FBrsffhz/5Xna3uepNZZ/q3M7cAs/pwKn7kvNRSi3i9batUH5eHsoztii8XHaH1EW7
	 BKXY18OQn8a5A==
From: netdev-bot+sinfo@kernel.org
To: Federico Musto <federico@rimpianto.com>
Cc: Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] net: atl1c: cancel the common_task work in atl1c_remove()
Date: Wed, 25 Nov 2026 11:37:36 +0000
Message-ID: <179560665678.3294.8918626244463796277@kernel.org>
In-Reply-To: <20261125113141.99792-1-federico@rimpianto.com>
References: <20261125113141.99792-1-federico@rimpianto.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
