Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683747;
	b=ry3Enp0fIX73nlvcRAwuah9xWj5KBDX6RsZIevend821XdN3iCEGcNOpI8xdRBSyzsYF
	 nFmC7eiOUeLPSvVfz0a+oXsxwidkD3t3bOAQo8NZ4aouMerSldqAVgZIoBHaNj7Bzo+4O
	 dnGPX2IcRIR5+oqfc00dh3VsT8jq4ktHwAfTRMjw5Gk7Qvth6gBwceZvHdNOGwlt6dnAZ
	 d0ub9nPE9dIdoTtW5NJR881zeUTe0v9KLje7cXWCvTUtCaOxm4Pc8ChKmuoRg+kQ6WlBU
	 d0DH8v7ktzEfDK3Yq1ORBZIPArAOroFxZR06tvdYKbokaAloD2JaJy//OpmYLsHDc9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kyA6YgN8qGDEZTh7erLhMR/RU8AaJWhDA/nGGj59ABQ=;
	b=FnizPByeWGXxRSoRzwkv+EPxkRbfwelzZ862KQ/2x89NPTZu4hOyhPowD472VdxUnxcG
	 XTItW5ZMNCQ495xIxknuzottPMzikhjdgKVwqUrZTG7SQa7KLTywa4kdJUNVCcmm8CBZA
	 8aEITQdyafTzVGFl7ItLsOqYHabJd6UD+lRN+UYyfSAivqjmXtXza1yA+3bk7J8uNpzdp
	 hDBrAmEpdJDL6hdY71QTCg09NY/69hvftNkacZ72f/iLpFBSP4IhdLF7QPt5xtno41BVC
	 T567qPETpz+UrYXm+ljyR8zbdVQmRE5oWXP0d2K/hi+OmJuh8c5dlyeR9wFApRae7Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AV1uMkMF;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6149606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 05:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6149606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AV1uMkMF
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e94f72fb9fso36949925ad.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 21:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793683746; x=1794288546; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kyA6YgN8qGDEZTh7erLhMR/RU8AaJWhDA/nGGj59ABQ=;
        b=AV1uMkMFV8Qiumc6keDPr+j6sMXlonF9LIML0A2w/wRFHDsaQN4MpgQR0Q2qOLVcCA
         qtUaKNdOXSx6ADJiCXYU402DFtzPKLGJCIBeJXIWIPfzAxNJt7YNWZukuDllBR0d2SRn
         Cs5KTulkk3aj1OMwcBeQIWlaNS5qlwzVCurABOd+UHwq4i1mCwaq4h/KB/qm0hwuVWks
         m8Mes/yRkuWrqcPi2wyCD8loycNPtsY/vPD6yqXIORZMRQIjG7oWTaZGvapPzC0BWIIV
         E/Nqm4aAchACgSvjhIgFGzoHMZgoSHBeALckhDrrcAGZvITmAQcpt/oWOPUaBZrpWBsm
         mLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683746; x=1794288546;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kyA6YgN8qGDEZTh7erLhMR/RU8AaJWhDA/nGGj59ABQ=;
        b=G7XJ0jEdzG/GPDF+xyUvT6jpcdG0201wOV42JeUWGe25ZoFpSdkFN8yUVuG/XnSC8+
         CL30oladAX/ty5kn/PellQNFocUznaRA9akecRaBc6Da6lnYyOm+5pJZwab8dmOkWyZk
         bjjWTYV/lZPJquTYG9BCnRVgAGRiNbAw1Y7LVUF8gG/236RWEuWSv4fwmzBmLG2yyHS3
         Ukh6IUNI8BT5gh9PDz6tx7tbjSNlDxqu1Rte+BpkM9v15ntfreS98Ce07I3HXOR5u0hL
         u/w8exFHdvrOCPRg+Y0rcUgNQ1BIQQ4aQyN+BO93eAR24InF3A53O+8A6fxm0kcanS3f
         eQSA==
X-Forwarded-Encrypted: i=1; AKwUvBx6ZISgxQROhMlkXTF1b8Xz7r/ZvKLYZPIxydni2gqhAMGr42Kv9q2Fs989nwhmUpqxGQJmX+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uOJgYpXxjCtgV4qyw5LTgRAJNy0UbSK+jpMde/GuI237iHY3u
	3dnc3hd2bJJQULhI+W1UL2yUrvVM4G0J3QSSrqtAdc+rpT0LzdPxtkT9/a+6y75VPCRvz9XHqLF
	6cjIb0g==
X-Received: from plhq17.prod.google.com ([2002:a17:903:11d1:b0:2e9:64c:38da])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:245:b0:2eb:a1b:e9e5
 with SMTP id d9443c01a7336-2eb364e7bfdmr113562095ad.52.1793683745906; Mon, 02
 Nov 2026 21:29:05 -0800 (PST)
Date: Tue, 3 Nov 2026 05:29:05 +0000
In-Reply-To: <20261101061331.286404-4-jiayuan.chen@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261101061331.286404-1-jiayuan.chen@linux.dev> <20261101061331.286404-4-jiayuan.chen@linux.dev>
Message-ID: <aulxGkfJ-7V8RUZp@google.com>
Subject: Re: [PATCH net v3 3/5] ipv6: restrict mld_qrv to 255
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Fernando Fernandez Mancera <fmancera@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Thomas Gleixner <tglx@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>, 
	Gerd Rausch <gerd.rausch@oracle.com>, Oleg Nesterov <oleg@redhat.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, 01 Nov 2026 14:12:01 +0800, Jiayuan Chen wrote:
> net.ipv6.mld_qrv only has a lower bound, but ipv6_mc_reset() stores it
> into the u8 inet6_dev::mc_qrv, so 256 wraps to 0 and the first MLDv2
> Query received on the interface trips the WARN_ON() in mld_update_qrv():
> 
> 	WARN_ON(idev->mc_qrv == 0);
> 
>   WARNING: net/ipv6/mcast.c:1327 at mld_query_work+0x1fd2/0x2cb0, CPU#3: kworker/3:1/2688
>   Workqueue: mld mld_query_work
>   RIP: 0010:mld_query_work+0x1fd2/0x2cb0
>   Call Trace:
>    <TASK>
>    process_one_work+0x93a/0x1b20
>    worker_thread+0x6d0/0x11d0
>    kthread+0x358/0x470
>    ret_from_fork+0x5b3/0x820
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Make the sysctl a u8 like mc_qrv and switch to proc_dou8vec_minmax(),
> which rejects anything above 255, and document it.
> 
> Fixes: 2f711939d2ea ("ipv6: add sysctl_mld_qrv to configure query robustness variable")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
