Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD146D577
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798497; cv=none; b=Ng9YrO3A3L9dRWb7HURYFVCqxGve6dqtNp19enXeyTHLdpzME7yHzz6Z81qJomkDneFoYxM+STVdwHHebFPSObKERCG55YZ7ctnmrXftdLZWZR6c0QGR2qJ03uAoo2jPQ2K75yM/3FZsVP8AZ0BGiZL3DJk9j1phexdWH9NuJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798497; c=relaxed/simple;
	bh=dfmbAABZOBNzKBzZGaNTByGahqCTy+OziV7PoeK5W7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PthxKA9iLmncalXcO/mJg0XqOewVOwl5eW55UWnGmWl3cLw4wiL7zNzDHXlMCkeXZptJp5Fu2jr2Qc2ifiQHtGsQA6QYv3lMMMrgHk7OAXKw88Jcg2mJjHiGz2K+ie+6/asDn71UYshnYIk5HQ5ez/Sl3CQv7PO4VkWf4M3jSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Nu+5xh1n; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Nu+5xh1n"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d719d99dso8685965ad.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790798495; x=1791403295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfmbAABZOBNzKBzZGaNTByGahqCTy+OziV7PoeK5W7U=;
        b=Nu+5xh1nNEd8lMVfFu62Cr3LPm5A+bg0oZZDTs2UVyvG8wnZgPjcFk3WU4rXlsQ43z
         H3c1+Hq6cWVkrPD2PedMd/F9zbXdXTHKchgL/wevRDCSNtRdQ6DyVDfSBLO0M4FKFR7q
         /rX9En961diAkyZL+qkUR/YeYW83qpTfZ+oBLzoKk/Uv+pxTJ4BaD6m/jHQewKODhzTx
         PKv45wjHT21QzoSmCfzCSbbUXz/6mNI1JsYTSFsPyCowSJwYbb2BDvQrk/xr/wxRD9Y+
         NOm9pfMNz/Yj+Bj2Jb9+4tk4eXP6gp8/jji9YatFc03x1gmhRfQBD8kDDIhBccnR0p/5
         A/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798495; x=1791403295;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dfmbAABZOBNzKBzZGaNTByGahqCTy+OziV7PoeK5W7U=;
        b=sB255Q2V3ugpTQN98i1wPMJCB5+QAZg8KfDD3CMpcRk0Fk8N2rNNjizjy2K8/XFnrj
         +tJhIfZTgBH+wo3y7v/H9sOzSWMY9ltS4RZhrSmFgMTel4dYa/7mE/Br+Twknd1Ae1y4
         dFLzbHaNqbr2titZVE9lAt6d/PTAH+2y3huOr6vNCGTQXVulah41z4psy3nHvC844KGD
         jvP70xN9H+HWgN083Jnr907kSHUtwpa3C0fxMX1mn+rNS9ST6DAZS7c88tOQ/Eb4BvZY
         gXl8wK23NDiNQT6nN2AE4pDzHHjVXbtsOkbYjV66r+RI/UQvpsLGnRZ6Rkh9E7lElxa5
         CwTg==
X-Forwarded-Encrypted: i=1; AKwUvBxAo/40pjCZuwxdITTYwxxGlepAHjURrAVLzOY2ArinxV6m5zTffhDcVYLoBtJZzqXqoJ+Ws4k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ4c3UovvB7lCAf4Y0Ih2rqR7tMtUQA7CosaeweyeANfWLjOfE
	Ng33f7dP2M0Dalo8Xr/b8/oukoUHioDrjbd0oA87UcjD2TVYAW51BOX0TEi+lbm2zLE=
X-Gm-Gg: AYBFou1EvcIae4SEqulw03Vi+Io9+7TgHF1FV+o/wdSvsCRZWKDnMtflfof6obfrlU0
	o0LS3aBx8+MvMn2DkOH9VzGbZGVEP0Hm2dCUGEfsGaUIk0y1HceSO+XPqkTchHEdkghbHQWgJ8s
	m9n8ksH5CVCQ0/6a6JJTGGDc9BzMsBajWYZpIlVYWrwyeAcnxuyh2mBsaNzwJVIwkE8ryWc9d/t
	1mJhiuT2mfRv4W9P1A69P8zIMgQ684WYyNp5mHpZ0npHWdgxtpVZaEKpSJUYA/jm/Lwv7UOYzTK
	lTRo8tiHVxP9LduBbXpOvK556fL6Uk3Jo6rWcxKMH2cAyo8x/89Y/7jVJtEa0gBgayrKfk2uYqY
	XvTaP8bfXHP0ZrJ57zQ6bvwNBTtTi4y7XtJYRKBqJ45VqGrkdy6haNk9uQjT1E2W3f2ndjJtXD1
	2IoemdB/bvC255DfaVSsM1YoHccsIwg2+gC30E0Zn0ovyXbw74MI10C3JbfUSQnoLXZkn5KA7KM
	jYNgz57b21MqqYV85MVrSg=
X-Received: by 2002:a17:902:f78e:b0:2dd:ad74:ac2c with SMTP id d9443c01a7336-2e2e4a24efemr20316165ad.30.1790798495635;
        Wed, 30 Sep 2026 13:01:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b6f9d3sm1812355ad.75.2026.09.30.13.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:01:34 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:01:33 -0700
From: Joe Damato <joe@dama.to>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org
Subject: Re: [PATCH net v3 0/2] net: ngbe: fix error handling in resume and
 open paths
Message-ID: <ar1qnabXsHMZQBVk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Zhang Yunfei <zhangyunfei1@kylinos.cn>, netdev@vger.kernel.org,
	jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org
References: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>

On Wed, Sep 30, 2026 at 05:47:46PM +0800, Zhang Yunfei wrote:
> Two error-handling fixes for the ngbe PM/open paths.

[...]

whole series feels very AI-y but from my reading of the proposed patches they
seem reasonable, hence my tags.

idk if these failure modes are real enough to be fixes or not though.
