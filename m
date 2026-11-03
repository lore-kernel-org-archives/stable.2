Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702036;
	b=upHz79eDadz2OZ+l3rYWUBRY5iOZJHVFZwcokF2diHoMYqLkA33MR7xTHnGsw8350pdW
	 vsMLMW0Tkfs8gsuH7QISCYD8APvOUNNGd2aoClzpGv4z7lSVcp6hSivs1oSQxXKdLoQJL
	 6PIRRmcXH2QMMvKaAeKvP6TpJIFFLSxoXfAKNinbEFmFhOIo374sJ4zCtHj4Kl40u72Y8
	 9wPPrtDusZbJsf43ck4BdX/5kWiu5///w4lEEILWt9EfVp1HOM+m/Nq9WuP2FnU5ayrqP
	 WcZtTFHVjVSWZ+0GWVmXkOeR0mF2f+hMKREoBPFrRyCL/PA+QpEA6hFFMPlp4QieneQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702036;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=x+9NS5V7w+HWt6erpfAK3tUpsFK1hWbbjVtHMSKiH+UEffwGZgFCnLtSERY/Soco3bvj
	 filkFc96kTXvne2soG74iTClWjGMxW/xHXgsQ4leMjhGcvNOqglL+2S9xv2y2VidgctFM
	 KD++D+9g/ktMjqH7boA1fG3o3jIypDZuWARkcrBZibTXih2R+8/0FBO9c7+tJxn7XS53l
	 YSq3UH+XBZI9dj7mRw1U6au/IMv5EJjgxo4Co13+tirKIUmDwr2jSJqLuB3dB2On01qn6
	 CQs3LNGngAVtc1QPzUWHT4CV26cDt3C79b1i8GSGqBWenNChAyqsQON3VipSZFroKkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuEOfzmC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46245606C59E;
	Tue,  3 Nov 2026 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuEOfzmC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5541F000C1;
	Tue,  3 Nov 2026 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702036;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IuEOfzmCDgN5hl865JBaoVHBzTLHR1HJv4qrBQRag+uz/GazTAdpHPP8daqavbKrf
	 WfpiHgurTnrRBhoh2A9Nt2cjzao8W3KtotAtNRVIuVhNW2iEuIiOTUJm5CyAkkR8xj
	 GNz0CQbi9eqKh4McUC5Q4Chcl18UkNAClp3KQPjvOx2hAUm3/XK7YBL4eBitkFc9um
	 VTrkE6ecR+UooLQb5T99aFqMJVx9u00XDvTJoMsxHM4FFQusfh57wieStX+9PNpwzP
	 a2EbEWo72NRNn3ZIof0/fn1IBODCTP+xW5twcuTTDzIdPtBHm03m14FSIF0oJtpWRL
	 zBG4QVqblJOOw==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: mscc: ocelot: release the mirror reference on
 policer failure
Date: Tue, 03 Nov 2026 10:33:55 +0000
Message-ID: <179370203505.488859.17715292710591924072@kernel.org>
In-Reply-To: <20261103102853.1340556-1-vulab@iscas.ac.cn>
References: <20261103102853.1340556-1-vulab@iscas.ac.cn>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
