Received: from mail-pj2-f34.google.com (mail-pj2-f34.google.com [74.125.227.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E888463B77
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798301; cv=none; b=ZfWDr6685gmxs0+fg+8sdEq9fRYDSiPSqbSJJFOLBHIP8AlOaMSTVi3ntjHrQ4g192UJ8R6zqznZsJamgpMMMfYMvvpRFRhMnqZyrB9uRoMEkBkQfLZRM65a50+xiF7QrXgcATLMR/YTY9MqBGN1/KOKc3ojqQJr57M+yNnKxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798301; c=relaxed/simple;
	bh=TY9HTzhIi2O6++k11RsmYUXoF9kBqGtjhJf6CkG3wOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm0IxesGdhXbpMODbqliLQdMFF4Qxs+Ea1qNSYnfy5GKFU++he8QKyBzQC82v0NQl7yRXZ57qfDbe0RJIuU2bWdg8qv8S8Wi1fVgfrYgBG1QibGx0fWj0AwB+wZZU/JuL1H9j9k/AZP5OPFXcsf/I3IN84uZfigpFv8Sg+wn/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=kQ+Vazu3; arc=none smtp.client-ip=74.125.227.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="kQ+Vazu3"
Received: by mail-pj2-f34.google.com with SMTP id d9443c01a7336-2d747eb79f7so25979165ad.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790798299; x=1791403099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wwT5G3hOZ+437mDeNovsYJIgF/coP9gi596iqTX5ReA=;
        b=kQ+Vazu3P7ZEgQtiDY3Odvn0EqUCNM4Buzby4H9j1KC8OuqVoKin7+Xih0qPyNZ7HP
         A60KZcNeDBJRlDVlZNfVkJoB/C1F8aCCT+7p1WRvlNS70VOo8ama8IHdN9OoSEuZnVCK
         loSex8RqwAUFHYPjalmqoaTj5ypHT8ca+RXdoeZjLj7TXADOaDgSPbzaaayM+1FZ7IDE
         MTRxANXH4YcPfMjwMzixcotf2kFmhVk4wdlN7Jix5ojnOTzPMjqMDrHoaD06F/5wNHwN
         hVtsat8Ss3ktPXjiaafaGxLwrVLv6CrcYuMUYQezPTpznROatfE76WTR/z/O2LWe6aXh
         vlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798299; x=1791403099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wwT5G3hOZ+437mDeNovsYJIgF/coP9gi596iqTX5ReA=;
        b=dp90S7IWKUTgqvAU94CaFCuNzWEyo+YFxnWpLvGfR/Vd7xdOE4dtsUnPzjq3HlDFdx
         V75sSRhg7H67VfZIUYKlwaCpWR3W64RqpIyPpDpuC5HaG/uICSZH9aUIZFvC5pyknwFD
         AP04pqKeodklV4V0zt9smYjud/YakTfoN2udM0WExbBnUGxljBtqiP+AGUUTnTbYM54u
         nLh+Js047yqVClEymDWazEopenOs04NnQBH8i8K0jnZhoeUEsoJYB29mIL4/m3Li0xWH
         LI2/jLVejGlYxFbQFrQmopojRRL8tgNrEAFxZaTAX7WZJhkiMS+6O6DtTVDQgGZVkkaf
         MkbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzt+mK1YkegdwYrAtB3RCi+PwPlj5wQ2CIuoVo/BpMx0lYhyXhn/e9k7R3Cs7JWDEfGQJ664RY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL17rOk+XibLuqYM+k1OpkdiUhQ93VamzcS44Rc2ORpbY6UFr4d
	LVlc9hPwHnmd+tIN/69Hzmp5xQ52IyV1UDKQhbmZTW887FjzPZF3/dD0eaucpe7qhNQ=
X-Gm-Gg: AYBFou0f+iPNytA0d87BrUYD6yGVSUak0HslBXjMKxK6LjvldzHTpXdz8agKhsbBbID
	oQhzWohK1g/ZgCdHH8VgjwbZhm0mHiUVCudLMBP9RFB6hfdzr56SbRkOH/CRA7VGQAQ9AmQqY0V
	D3QWg59/+AIjltEsZCiXv4dF+SXdk8uvquiE/5JGydw5zbw16c7FLdrruV20AyQqrY1hX6VQOuu
	RulMA/2MkIdKKgeIrW8+W1XrqzPny6kS9i1c9BLDfcHAyHNSxcHIoVRrHLB6GUyBr4RpT2Uzfh8
	aPjwPyD+Bd9EMUIoTYVHwFi/UkQThwtwrcBIjOI0mQ8+rZLPamnOb3e/Y3nCIzQ4YgAHQp5oZD7
	I+Ybv/hxEOP1JssuwmpZyZzoXMYC7jVkqMi2EIpiKnBMEQFv1bK2V1cNazxsRtkwkHyKLlQuluv
	jiSgJiDaGI945Nxyko1R7G1UphpU16/Wv7z2z8BmyUqjqV8zBcHMnaJ/rFuwUShCoo9fQ5m6JeN
	ZiYg8wS6hjPEpIuH42Gjt4=
X-Received: by 2002:a17:903:2308:b0:2df:a023:6883 with SMTP id d9443c01a7336-2e2e4a1e373mr18255265ad.17.1790798298669;
        Wed, 30 Sep 2026 12:58:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e30099a3f0sm1868405ad.23.2026.09.30.12.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:58:18 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:58:17 -0700
From: Joe Damato <joe@dama.to>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org
Subject: Re: [PATCH net v3 2/2] net: ngbe: clear DRV_LOAD bit when
 ngbe_open() fails
Message-ID: <ar1p2bK3Aab1RT5U@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Zhang Yunfei <zhangyunfei1@kylinos.cn>, netdev@vger.kernel.org,
	jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org
References: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>
 <20260930094748.1198085-3-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930094748.1198085-3-zhangyunfei1@kylinos.cn>

On Wed, Sep 30, 2026 at 05:47:48PM +0800, Zhang Yunfei wrote:
> On NCSI-managed systems, a failed ifup - for example when IRQ or
> ring allocation fails under memory pressure - leaves the port
> without either host or firmware driving it: the firmware already
> handed the port over on open, so out-of-band management of the NIC
> through that port stops until the next successful ifup.
> 
> ngbe_open() sets the WX_CFG_PORT_CTL_DRV_LOAD bit to tell the
> management firmware the host has taken over the port, but every
> error path returns without clearing it, leaving rings, IRQs and the
> PHY torn down while the firmware still believes the host owns the
> port.
> 
> Roll the bit back on all open error paths, matching ngbe_close()
> and ngbe_dev_shutdown(), so a failed ifup leaves the same
> firmware-visible state as if the interface had never been opened.
> 
> Found by manual code inspection of the open error paths. The
> deterministic reproduction uses a loadable test module injecting a
> wx_setup_resources() failure: in a QEMU VM the unfixed driver
> leaves DRV_LOAD set after a failed open, and with the fix the bit
> is cleared. No physical ngbe device is involved.
> 
> Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> ---
> Changes in v3:
> - correct the Fixes tag to a1cf597b99a7, the commit that introduced
>   the bug (the first ngbe_open() failure path after the DRV_LOAD bit
>   is set; v2 pointed at e7956139a6cf, which added more failing returns
>   but not the first one); no code change.
> 
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

idk much about these devices but the reasoning and code looks right to me
after reading it so:

Reviewed-by: Joe Damato <joe@dama.to>
