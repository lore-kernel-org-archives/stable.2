Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637054;
	b=nWz/svMjQV1k/PRqiVuGG36TLHBrBUgTp29YMnUXQN2mf5EjyvMwhZE2GZ3ULIC+Dr7H
	 4tVnfeZVFfjO0Ge1HOgx2phGb0A9n5HaOb48nX8WuNNE9FMhYL6EYuyoEZvsU/VRHGJ+e
	 he/wjy6di1E99258uRfy0HJ0887KCenirR8aUJZmFiQfmOz5nf7uvvHv8qSa+uvzeII6H
	 sBMmfqIDXr5N9p90ORojpgX2oj5T4KDLZYxDrjWlkl16M/pbvypB8xppBxnc7KP6XaizS
	 ZrMLsgZzh0XEsfkWG/TmwkDN1cXcXwmP4vgG12ylWv6PZ1ifKM1szg7oQnlK9bV6ong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XbA8xSo/0EvP3bC+6uqk9zXWFfD3XB7Srs6wgP7XMNE=;
	b=ki5Gw48G5Xl4nhQLgh3jQ3TMvhEvV92TrcMfb9qSzXZwpZfEBptw8Vcf62K7nesr1m8z
	 0f+nj+QDk8r8MCBjRPuf2WK/zQTVe6GpFqeiTeS4lsZy2Js+PvGXCfd8OULukv5V91jC1
	 QB2GylMMD6w8yS+Kif+G1GRKhNHMZjuGsdArNfbfW5KsQjKan1SANELbsC/AsyQFIUZDF
	 GaCQiyn3wdfeBM3CrEkJzazk2dU+HD70N2J/QKVzfs5DHAoc9FJohj/hCHGuC6I60Frhi
	 xZzNNnNNwfQRxnLtQMQeX5z0DklGmR7YKm14OmUSj4LtGCD5p75r355HhS6Du65csSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andrii.net;
	spf=pass smtp.mailfrom=andrii.net;
	dkim=pass header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=X+Nmy3Pu;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6A606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CB6A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrii.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrii.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=X+Nmy3Pu
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3b40f4d4b5dso2778314a91.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrii.net; s=gmail-2025; t=1795637052; x=1796241852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XbA8xSo/0EvP3bC+6uqk9zXWFfD3XB7Srs6wgP7XMNE=;
        b=X+Nmy3Puuqqf4o7Iiigbk6Dm4/3tNwm0vWiP/LoJitR3bDbsnNlDSx9ypWR+9O6MId
         fnSShOI5dopdTEH/ymJtP9TVOqdvMM24XjAyeDmO4CJEZYSKVCvFYZLYdBpFeE3AmSFo
         3azayYBE6wB2qIalrb0xKeV9A2iEtr972pbUQSvZdUKNkvLHC2UstIlNn2xYXqmg4ame
         1zT6VAGwTcc9cUih4Z+Eck8hYh5qSbmkH9X934A7R8U5i1wGydFOuqkyURx37kRvJLrB
         UvYiGu7SFNI9G7Fcqy+K16g9gdMFDn+iYFDe+TnMQGVlnBjAJvhqEnEOL7wAYnCucHLM
         arXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795637052; x=1796241852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XbA8xSo/0EvP3bC+6uqk9zXWFfD3XB7Srs6wgP7XMNE=;
        b=esOModeDSJNsgPd10yX56XgpoIC3eA8OGHUjhBRMVlqYhepBtKj78Ybc4K1bgqhSXV
         sfqbO1VfAsbN1wBYywLgLi/poEMiUowuJjlpqUwiXp2iI0IypXyZMtWI7xpy1tAqTqxW
         xac269/aqSFGi3nhKjLcf18cUApPXqxNhwHy3SIF/AifeAEdCLaPRLi9oS4Id1XfEmvC
         woUMyb53ER973g1wThHnfbHPAytXyUxmtpwDGNfN5ujdvIkeJ52XDTa9DvQF2qqAq63c
         9oW9kuT+jUBLcPnQwBg7cMvajqlVc1CE8w8yqAO0Ey81OljZlYeYGPxaxL22NnOfvOy4
         H4Kw==
X-Forwarded-Encrypted: i=1; AL+hErHjqxb+JR4zcSlz5h4GRalAe7t6aEdyNblkyiB1qmG8EvGg1FxlERFB5G06h+LfDqawJbpmLYc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VLWzl5ePOLrdnpC4h1RdyL9gG9u93UoJ5hETDMKtKPGGlXj19
	lcqOqkot7IWwxexRkadBordrQI0h+YdwKYhnpyY+FOyh7W2nrbsZEYTxEaMyWAq79LCi7XTDY1v
	AGrsq8wk2i8BX/5dCXAsn8ajSR+0LvdduW2k8TdaZjEUoQ2R4aTDT
X-Gm-Gg: AZFdTZfF/tVrlplubwn1/c0aZWtE6fJgFqEEQpG15DyluoZukLXJ0aBl003wJ8O34Eg
	tDrSKXQ73FkDIqIqO1SiIbiEO2YDNQ6owEcj0iiP2JsK14lcqYfJrWspwkiaia5hIbyTHDWthVu
	k+g3PJhby3dtoFWrGyn6kWfUd0QSthpa74n0r1kYDZ3AYq5QIagkMq1QXfVuJaRpAz/n0iUoQRx
	mO9k0jfOUQtpbV8aySd2UUEUQq9waGP5/mP+B+NRV34YED3K7dAEmrbQMLDtTAS/olWOGVRXPlY
	7F1UYvVKD511Rerqt7Tl4cwxUqi+u7+3q1tZt6oNzWS5pd5HPi1IItMPUqb8tcsXi0FtoIHSyjm
	Qw1dKEnXWndDfo/yJut/eIw2dNN4=
X-Received: by 2002:a17:90b:4e83:b0:3a8:32f2:f4a5 with SMTP id 98e67ed59e1d1-3b41c956a0cmr18014294a91.53.1795637052486;
        Wed, 25 Nov 2026 12:04:12 -0800 (PST)
Received: from andrii.ai (mac.hestia.andrii.net. [2602:f337:ed:4865:7374:6961:204d:6163])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41d224ba3sm7118846a91.1.2026.11.25.12.04.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 12:04:12 -0800 (PST)
X-Relaying-Domain: andrii.net
From: Andrii Tereshchenko <opensource@andrii.net>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ipsec] xfrm/compat: pass on the translated length of a socket policy
Date: Wed, 25 Nov 2026 12:04:09 -0800
Message-ID: <76b0ddfc-33ff-48a0-8113-db94076f2473@mid.andrii.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <5249741d-fa84-4d54-bf77-45f48dbbb169@mid.andrii.net>
References: <5249741d-fa84-4d54-bf77-45f48dbbb169@mid.andrii.net>
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

The netdev AI review [1] raised two older issues, outside this patch.
Adding Willem de Bruijn, whom I missed in the Cc.

Sashiko (netdev AI review) wrote:
> This is a pre-existing issue and was not introduced by this patch. Does
> this translation also run for x32 tasks, whose layout already matches the
> 64-bit one?
[...]
> Would compat_need_64bit_alignment_fixup() be the better gate here? On x86
> it is in_ia32_syscall, and net/ethtool/ioctl.c already uses it.

Yes, confirmed on ipsec master with X86_X32_ABI=y: x32 requests are
translated as i386 ones, so their SA and socket policy requests are
refused and a NEWPOLICY loses its template, leaving its traffic in
clear text. Gating on compat_need_64bit_alignment_fixup() fixes it; the
fix will come with the other xfrm compat fixes. x32 readers of dumps
and notifications still get the i386 layout, which needs a separate
af_netlink change.

Sashiko (netdev AI review) wrote:
> This is a pre-existing issue, but should this translation be limited to
> IP_XFRM_POLICY and IPV6_XFRM_POLICY?
[...]
> As a result, a compat task's PF_KEY socket policy shorter than 164 bytes
> is refused before any key manager sees it:
[...]
> The gap came in with 96392ee5a13b. That commit replaced the
> in_compat_syscall() -EOPNOTSUPP refusal for all optnames with the
> xfrm-format translator. Could an optname check be added to this fix?

Yes, it should. I have that fix ready as a separate patch, which runs
the translator only for IP_XFRM_POLICY and IPV6_XFRM_POLICY, and will
post it with the other xfrm compat fixes rather than fold it in here,
as it is a different bug.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/5249741d-fa84-4d54-bf77-45f48dbbb169%40mid.andrii.net

Andrii Tereshchenko
