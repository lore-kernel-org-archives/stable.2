Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD33CE0A0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900991; cv=none; b=XkKOF95iKbzuA1whDN7d3SZDztjVzA1wbgBZ0Jw8fpyvCOeYFJWMmCfu6CrTloF5Adfjuc3XfxQMGU8m3tzpThhTiTPd/XcTjfWTuR7dZ5N79XDm569g6qEd3DD5cFxFeovKx7yvXZJdScQcpUuGlONmz9APFRU7Zl+2y/sRqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900991; c=relaxed/simple;
	bh=py4aDXmt5KI0m6G25QV5nv5VSfEcgQunBq9/JV87nRM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=U6nSnSBc78soP8UGFIWYGeTyjng30DoU7peIPPEg25BwPApH9vK9h5osHSwgbqTFVPZwxh0F91FeuINpDFHeiXi0+z2yBrpaI4zhGw5rJFJShdHUCdHdZb3kqX/2DOEty3vI0GFtap8wXqRRXl9Eh0HH/o9bZSbx3U4yI5HubvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE0eqy+C; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE0eqy+C"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1394972a12.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900989; x=1792505789; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=py4aDXmt5KI0m6G25QV5nv5VSfEcgQunBq9/JV87nRM=;
        b=WE0eqy+CKmO/K1YIEzPJDoHg1dRrN5B2lkASGhwPnz9Cs9c6yDzNY24ohZRgLN/GWP
         vx1xFHujbtmXw6Uje2qrvijclMf7fdgWszekSuN7lvpVLEGfYlwnoDxuXmazS3ezniYT
         8g+XrfwtdC1uCT5QDyWLU+jYVysR4dUBhMZGZIh/zIr9haKvSzMJ9t3YvKVNkrNciLTq
         QHpQj/nAKSh2o91rtB+IB0HbJWYOOZnohxaDnFw2hpV4339YavKjDRKWRIzmuoWEUVWz
         6Bm6b0cJLFBuftojbhg9wlWUJZ3lxOlFDmKd5N+jJObA5Z9FAc0fRZWRXTXflUEmoMjY
         gD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900989; x=1792505789;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=py4aDXmt5KI0m6G25QV5nv5VSfEcgQunBq9/JV87nRM=;
        b=jnCUiF6GHe8TiLalyxkoyB5ZRwosRtQLFZ3a5EnxJ1G+QZqIjkFT++6T+Tqx/7aBC2
         f5BZkcMU+npECnlUAtxdWq/weV68qeS7h8hK+F0qxlS1fzRtEMRLUAbDXLooGIX9Dqje
         rIFiAwSstIk8/NNITWUz4iUo32fabUBTT0Fe21tIZZBu+rZ1wQQN+ZKlWLv76nXeO+uO
         Xe6cuSwI/lKrI6sGWPUDGARbaNucPu7jg6ZoviGMVaF7BZBHHtszYuTLnD3AYeIqcTqv
         0hvkqtnwQuWL8ooN7wgNk+3+bpMYDKdVALUNpcY4J7ULj9qU8lrefZWEMICQ0ZIakuSx
         nzbQ==
X-Forwarded-Encrypted: i=1; AKwUvBz34HzI3Ns7xAgNDLZ3w2nehmTo2YMgHfyEteoom8NJv1tugi+TPVey7Tdp1BR3T4WWWoGbhgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsNTLfqFp/1jR2xA5WRMpx0+0W15jjQXfyV4MhuXpldYyDQSSE
	6ZOCvowXB0ipxnuicuis5x6JtiRkflN040xdzwMe3JptemtLpRZDtAAP
X-Gm-Gg: AYBFou3pra9DFHocRyMN8TUsXoqkQZYxZYrI/n4yLwcVigZ6DbmlicpdhW1NE3bX5s9
	XKbzmczqBXC7rxvddslK0jjIezzaWAN0419xRiPhDBKpnXkM+SWyBNYVjMcK/gyvjRSzrIuvD75
	WR7TDr17oVmCZs6tvaqoqepMYi7mP+4nu9lEVzF2pk/34ptbgfKV6Yy/Ju65t/xTh5I+f+tvWBY
	mYAGM+dzkwtftycX7CNtEfLxdLcivzldbY8VTK4ckcLu+OrnhLf1979yRz6LFUAO527j+YEHNIy
	Zc+YZaBr3FipH0e/iMNalok5PC/qVmgtszxrZitCzAC8/yy4ItgCz7Mpcqicc+fepPYMvm6t5wt
	jsoVE8seBeaPrEYR7fn+wSN9F246DLaz+uYxfgaqHdZuPcfnzrfQWt+kS/fwfyXyXGugTkhNwky
	/g6jsAVuKwBQh4zWaf8T/rY6d9UqMeSJWwx9irxoHbfKhoBsoOZtDawtfnF5k8muVHmetCacZK2
	w==
X-Received: by 2002:a17:903:2ecb:b0:2e8:6ae2:75db with SMTP id d9443c01a7336-2e86ae27819mr89626855ad.41.1791900988982;
        Tue, 13 Oct 2026 07:16:28 -0700 (PDT)
Received: from [10.1.21.151] ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e90977deafsm12910845ad.68.2026.10.13.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:16:28 -0700 (PDT)
Message-ID: <6ace3d3c.c6d97709.27aae3.cbd7@mx.google.com>
Date: Tue, 13 Oct 2026 07:16:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Bui Viet Dung <dungvn2345@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: stephen@networkplumber.org, jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hagen@jauu.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/sched: sch_netem: prevent packet length underflow with negative overhead
In-Reply-To: <179186709813.434549.16042014331752584322@kernel.org>
References: <20261012044322.503949-1-dungvn2345@gmail.com> <179186709813.434549.16042014331752584322@kernel.org>

SGksCgpUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCByZXZpZXcuIEJvdGggcG9pbnRzIGFyZSB2YWxp
ZCBhbmQgY3JpdGljYWw6CgoxLiBtdWxfdTY0X3U2NF9kaXZfdTY0KCkgb24geDg2LTY0IHVzZXMg
J2RpdnEnIHdpdGhvdXQgb3ZlcmZsb3cgaGFuZGxpbmcsCiAgIHdoaWNoIHJhaXNlcyBhICNERSBk
aXZpZGUgZXhjZXB0aW9uIHdoZW4gKGxlbiAqIE5TRUNfUEVSX1NFQykgLyByYXRlCiAgIG92ZXJm
bG93cyB1NjQuCjIuIFJldHVybmluZyBTNjRfTUFYIGNhbiBvdmVyZmxvdyB0aGUgc3Vic2VxdWVu
dCAnbm93ICsgZGVsYXknIGFkZGl0aW9uIGluCiAgIG5ldGVtX2VucXVldWUoKS4KCkkgd2lsbCBy
ZXRyYWN0IHYyIGFuZCBwcmVwYXJlIGEgcHJvcGVyIHYzLgoKcHctYm90OiBjcgo=
