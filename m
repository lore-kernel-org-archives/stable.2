Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447990;
	b=dF0rOiMuLvzLFPTX0WIoCYPgq74U9NfV77mnI8gCGQzcGLeZIOCorxvEoz0PfLjeAMUM
	 VHQ3B/zKuT3yp5O2HvHo/UOgpYStzpox8p+TMXJ+3aqSfzRCEM3dQ8mxmhm1mFw1THmL0
	 tFopLWu35Sk90uZ1RtP7/1A/MpuBnNvtvpAjc17zegDG6ucPu3Dqvdt0OJ0K2EnUH+7vl
	 49hSMj8pB/aNy5KVsVowGIQDXgFNLEL/dX6d0YCcqdzqPvUo8fcfnh2m+a9CeaxjjxM1S
	 PcokTohrX3QYJlzpHacZnSdtpwgMC97BmHgOogE+43jMqkh1oaa4YWUin1AgQnlfIJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447990;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=tEkPMBUY3is8qUNhwEjXM/7z4i29Jmc9M5lXhnaOsa4=;
	b=ZO7rdULt3TlpvQQO+FbdABAsujhc2xhKu9D8av6wk5rsA0OFSELYPPOoJrXffFjMeqTO
	 RCMccR/wv0EDw8V5PpxULPkaFx3TDhwhC5aU0gyDSWAQuZL7rXPdihE/Yy0XrGDVsvmcD
	 50WZAs7H8HTCEpqYKtZault+IWsMfmzjldVsgZnsEnAisi8J/i576I/d5LpO2sJMhp15J
	 smmYqUp9/bJu9+hQmqOLrO3k38X4hY44GvVIk+GpCN5Pp+d//c4XBX4tPnAhK3miTQkIS
	 t2ApLXjI/OZc6ZjpbiiFJemLPVvIBHTUP2nsdQiTBF3OyTnUP5gbtwSH41XmyDNn2LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mk6XQCdT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vq2PLd9b;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB298606A319;
	Mon, 19 Oct 2026 22:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB298606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mk6XQCdT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vq2PLd9b
Date: Tue, 20 Oct 2026 00:13:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792447987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEkPMBUY3is8qUNhwEjXM/7z4i29Jmc9M5lXhnaOsa4=;
	b=mk6XQCdTNAxu6g/VChpbVZiDbwQxr79w6PQbjG/TSiGsIjS8+RmIlhpTRPOaNhFPof0c2U
	0CUqCfRgiKlQwYblxS+w/nOio0BuX5L3WhMsYR3RJjyQspFToSxw2BeysUFRbAVyfMlyOs
	sqBkpUegZ2CM2qnp26TeyTXG5fLctLzBUCR0zXtF76BCkHP62r0QKlvcYZ7y71sg8s+U8D
	w2CmoCYxUfJ91IAZB6V2d4tKjEvYoTb7Cbhf8ahx9I13zG1h1dU0yv14+RNm+JyYL2eIKj
	Mg3tvI9hn05eHabMYiueK8HxXov1eysIHU1wORoiYsn30Fo2hsE+NSFa70NaRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792447987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEkPMBUY3is8qUNhwEjXM/7z4i29Jmc9M5lXhnaOsa4=;
	b=vq2PLd9bEIj+nT29+S4J+T1fZznn4lc+TS86Lef4i197NXqVZxYH/i35vn1xXikqrFpMOo
	pNVQuASl8pfeJrAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Fan Gong <gongfan1@huawei.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xin Guo <guoxin09@huawei.com>, Gur Stavi <gur.stavi@huawei.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hinic3: bound the Rx fragment count to MAX_SKB_FRAGS
Message-ID: <20261019221306.d6dfPY_y@linutronix.de>
References: <20261010030901.1712792-1-yhlee@isslab.korea.ac.kr>
 <20261018170531.bILLh5Zw@linutronix.de>
 <20261019001037.3496843-1-yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019001037.3496843-1-yhlee@isslab.korea.ac.kr>

On 2026-10-19 09:10:37 [+0900], Yehyeong Lee wrote:
> Thanks for the review.
> 
> A well-behaved device can't reach it. rx_buf_len is fixed at 2048
> regardless of MTU, so the frag count is ceil(pkt_len / 2048): a max-MTU
> frame (9600) is 5 frags, and LRO -- off by default, capped at 32K when
> enabled -- is at most 16, both below the 17 the array holds. Only the
> 16-bit length field in the completion descriptor (RQ_CQE_SGE_LEN_MASK)
> lets a device claim up to 65535 bytes, i.e. 32 frags. So it takes a
> device reporting a bogus length, i.e. broken or malicious firmware,
> which is why I treated it as a robustness fix -- I should have said so
> in the changelog.

If this is something that in general opinion never can be reached then
it might be something to target net-next and not net looking like a fix.

> I found it by code inspection, not in the field, and I don't have a
> hinic3 card, so it's untested on real hardware; I reproduced it by
> injecting an out-of-range length to get the KASAN splat in the
> changelog. The netdev bot asked for these same two things, so this
> answers it as well.

I see. That KASAN splat makes it look like something that was really
reproduced. I assumed jumbo frames and aggregation at HW level.
Just because a field is 16 bit wide, it does not mean the hardware will
utilise all its fields. 

> You're right that the bare drop is unhelpful. It only surfaces as
> rx_dropped via ndo_get_stats64, not in ethtool -S -- hinic3 has no
> get_ethtool_stats, and the stats series in net-next doesn't export
> dropped either. I'm happy to add a net_warn_ratelimited() on the
> discard path in v2; it only fires for a misbehaving device, so it won't
> spam a healthy system. Let me know if you'd like that.

I would suggest to target net-next if this can not be reached and is
just there to address a possible overflow. Maybe a warning if it was
reached after all. Fan has probably an opinion here.

> For reference, eea does the same thing -- it drops once nr_frags
> reaches MAX_SKB_FRAGS.
> 
> Thanks,
> Yehyeong

Sebastian
