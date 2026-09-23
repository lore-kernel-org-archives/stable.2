Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEC49C4B0;
	Wed, 23 Sep 2026 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160248; cv=none; b=TeemwwO4ff22V54l1wiQ+xTTfBTYJLzk5GCm/m0sGz2J44O1XFJwLjEA7UGkAsEdH8NJRybGzh1Yb0lzf4Canqb1tq2Ni1edkxICDsr2fktLPgmJsRS5r4xra0c/YFvegfF3an3wphEBbq28IeGSsl7YqWOhC74HdPBUoW/Y8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160248; c=relaxed/simple;
	bh=XvRTG431l92TtO9lmCm1PxcEwMrhHJEggB4RWtQwXoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IySXGhekYJhxRl9vVYw/5D7Wke5Qrs9vnH/HhRutQm7mRybTCy0Hn3TdGMu+0cfZCnxbZmeVJw4GT7oUF3owfcyouZqPsmcR+XFdGC2/G9obVHCIJLQUlzg9Bl4x/K0gyPLQoiH1aKU+zA4wbnAkeQZqsBtjpCLIfKe6wgVQ1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eS8AFRXP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fifc+0ae; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eS8AFRXP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fifc+0ae"
Date: Wed, 23 Sep 2026 12:43:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790160227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gvCXDUOLOu+Ia2p9CgJqLnqgSQsSoYjyjZdMuJqNEBM=;
	b=eS8AFRXPfE/UNrVT3y152JRW+dWVLA2lOAysGODRnGfzO2YHmHeWn31SDfYv6Q9io2Ojfo
	zb0aVaJg+o73BFtg6qCmp3X3xB632tgqUQruD0RTkh/nY4fsODM61dFCRnmCaHIWsHIOUC
	RtPz5iuxSFFLze2LdtpIrXwxlyCA9jJQWhKmQWbPZalESrUuKhMMCd8p+JYexE/M54xv/x
	3lJI2aw1CX9m2gaxBLfX0ijSg2orD4ip2iNFLBAr1ll5IuIcci4HlY5vsFXKr1RKn4s9J+
	AivTbigxmvGVP69h+dTPghgwAIDFJ/5uIsbPt9H695pL3jUalbmN5OXBmod4JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790160227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gvCXDUOLOu+Ia2p9CgJqLnqgSQsSoYjyjZdMuJqNEBM=;
	b=Fifc+0aeBqxiODwcsR112GJu5mjkqXr/3sWTDv2+VClwmMaFcRECfXIu+YYsTZ0+6Cd0Pf
	CMQ1zkls3RVbSsBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com
Subject: Re: [PATCH 3/4] net: hsr: unfold GSO super-packets at the forward
 entry
Message-ID: <20260923104346.ur63K3h2@linutronix.de>
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-4-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809121455.1745-4-xiexinet@gmail.com>

On 2026-08-09 14:14:53 [+0200], Xin Xie wrote:
> HSR/PRP require per-wire-frame tags and sequence numbers; treating a
> GSO skb as one frame breaks those semantics.

Wouldn't it be simpler to not allow such packets? 

Sebastian
