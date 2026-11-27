Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795744075;
	b=bLVNLa/F5NbeL7sIJizP2wCJaGRLOBHsQz/1qwFDhpZGHPlaao4oUbJ8A1FeAL4ysj+7
	 YhGkiFo0lFyUgEjGb342vvWReaFrX+JCrdG73HxRFXgKien56XMv5EJWqfGwXYwbr5FrG
	 Bnx2UYpUDRauHtx+NyXgnDT2HW6RYdwuRTzSQ4fVGd28SgbESdC5J6A/R1S+RIiUwET1I
	 CeDWt9GfAnVnlEoLnotldgUGJd+dEy6MCbXkLq1W7jKAKmFls7ncaa3XrftKwE4HmZ/wE
	 4v+UBBb5W7vm/JTwp4fD9wuk6TH2fRF3Hf4Ps2RudE5sCtQkmoEzB0jDY1rozSxsUqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795744075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9rpdsm/VQNjI+QZyvQZysG3z/mkS8qpvjAF0HDQXOiw=;
	b=WDI3BYLYrUp03AVw785tTCtQDDc36IKhO/T/VDApJwL879JH+nHXkStbETZXsstuqlKg
	 LV0/CfH/mKnyDDhkMbdEbZxr5c6HBOvbOrlrZ3SjEoAfRRO9hq5ODuXmYkcGjjSSFwgJW
	 wFjZqdijy9S9MC5Pj81ZYBatEIsddFkIIR2PiU9JBIPuL2Ca7tt1mLsbH+c9P6FI2i8NP
	 yeQqgRCPu5t7q7igo74/jsPDcrR8LV+hqMKI7ZzZti5sYnTyrSrU0I+l+662k0I8J3ncZ
	 ET9opLbkPFzcCgSCvKFfyiteHIdi9Yc0rrmDbhV6XvOOHwPmQL+YVX64k4k/peQNg9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andrii.net;
	spf=pass smtp.mailfrom=andrii.net;
	dkim=pass header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=W9umYR6B;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220CF606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 220CF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrii.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrii.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=W9umYR6B
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so4298573a91.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrii.net; s=gmail-2025; t=1795744074; x=1796348874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9rpdsm/VQNjI+QZyvQZysG3z/mkS8qpvjAF0HDQXOiw=;
        b=W9umYR6Bu05MAqt8vQxTPaZuHIj8L7nkoqY7roaXz/KTOuU0vid4imCewE5ztw/rXx
         h4KetozT0hoS7sXnuW/fq85mVt9zpfR6JRkVpxBfKZkcRQlrHikdfsoDem8IJnaM2Cj4
         9cwe8pDu65JPoWmf0uzO1mhZztzErO6vjL9Wzp+Aj76Z945LQaXM0fNNY02GCDcU07YP
         OuVlLLTbQtV2Z4OO5pwSCXDAwml/8Gr44oxlyeR3eoes0VA6EFJ8wE/XMGz6oap/ipfF
         1uDzFiDy+c8Txk+tjbKX9kIFMgYRczn2nrzTPthOc0yICs2VWsF8YdjxqI1A235TPWks
         KeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795744074; x=1796348874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9rpdsm/VQNjI+QZyvQZysG3z/mkS8qpvjAF0HDQXOiw=;
        b=e0TBuAxNlxhQqv5ykXIcs/gVNQfUMnlqVTwxSO/Tk77YJWmWEpNfeJStWloFnEvjhs
         uPjSNF87+/uFbITaEhDYOO7/qNUw0xi1L7Ucihs9Zst0ZCO94rojSjM9ZPTV4ic9mIH3
         QusB9Wb52iCKtD+Sj0VDxILx53zyYdnwGMxudGsKDDLf6xPDnzZilsZCpVLaK5GjstFy
         Lql5E8yliBrMJvqClg3F7z54zBRGoAYEHY4A9cDDMQKVJ72lPiovS8NIQdBz94yilXnn
         Ojspa77odZMMNt89YMBHl+iwt1YjdBOfPBIDm/AeCZIgP74vbjlZfuo+nlDVSnzW+oY/
         0p7A==
X-Forwarded-Encrypted: i=1; AL+hErFa6i1fqfEu/PrBfM9+TnoxUVI/OWcJQPt8/OB/W983Msp7Z51CwCfiurkOoCkRFw9GBRU03TI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/w48hcQNPuF0j2z/vBKwStlN2NJacKMSmtzmLGrb9ZL9T80yNg
	qBxFRjpRar+4BoS+to2bSApQa8TV1PfrKvpa8ceAoAeDiWkH+fML7v4+jwefUWx9qxGUzcGQVSX
	yUdt3OUE4CtB06rMtpaDmPfTqBbQj+5zVybkO/vYj+/o6xnpGtWc3
X-Gm-Gg: AZFdTZeNIFYVLNtIXoRzENFe503yVMyOgq26V/rl7NLpgcx8Iw0FjoYRB3Pf7GmPEzo
	V+lIecDPq3+lP7rAO9zNPJSnmJojspZT2CEwqSCb/b2lb9WG/On+Zbk4nA2jjHHqvmTLrPqBcuk
	BCBap2WEW+PKNUbpWa/SyFb5savZZgyD0iWsppr6rfthhoFfYlWXgKidHNd5eTwhjGzr37owpGC
	hjvlPLfmCMi4wlBSJ9J/sg2whyAjLl9vwwi8iRacMnhLxsfROSasyMxvHxFonkhta+i+31QsNkn
	njOsFOATvuLqP+QQkKtgw3tT0ohFbHDOdR14H1KTSa5GtjuRf9u+4ofskkB9lhd9WLwnmyG6Iio
	boHffa+HDSjklofDh5yWP9EdebP8=
X-Received: by 2002:a17:90b:288e:b0:3b3:ab75:c94f with SMTP id 98e67ed59e1d1-3b41c92a098mr21400073a91.31.1795744074328;
        Thu, 26 Nov 2026 17:47:54 -0800 (PST)
Received: from andrii.ai (mac.hestia.andrii.net. [2602:f337:ed:4865:7374:6961:204d:6163])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b4062a77f5sm16585106a91.6.2026.11.26.17.47.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 17:47:54 -0800 (PST)
X-Relaying-Domain: andrii.net
From: Andrii Tereshchenko <opensource@andrii.net>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ipsec 1/2] xfrm: iptfs: don't modify the shared info of cloned skbs on output
Date: Thu, 26 Nov 2026 17:47:51 -0800
Message-ID: <5ea528c8-ec02-4f2d-bc59-50700be8216a@mid.andrii.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179531150722.3135.5639628464200463791@kernel.org>
References: <c1e999b5-15ee-468d-81c5-530a560e84df@mid.andrii.net> <179531150722.3135.5639628464200463791@kernel.org>
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

On Sun, 22 Nov 2026, Sashiko AI review wrote:
> [Severity: High]
> Does this guard hold the "they are never appended" rule from the comment
> above? It only tests skb_cloned(skb). It also runs after
> iptfs_first_skb(), which may already have uncloned the head.

Yes, this is a real gap. A head that is not cloned can still share its
frag_list members: after skb_checksum_help() as you describe, after
pskb_copy(), and after skb_cow() of a clone. v2 tests skb_has_frag_list()
instead of skb_cloned(): a first skb with a frag_list is sent on its own,
aggregation stops at a following skb that has one, and
iptfs_rehome_fraglist() is removed. That also covers a deferred skb2 that
becomes the next first skb.

I drove your route directly in a test VM: a cloned CHECKSUM_PARTIAL skb
with a frag_list sent into an IP-TFS SA, then a small packet behind it.
With v1 the original's frag_list was written into every time; with v2
never.

> [Severity: Low]
> The commit message says: "ESP copies a cloned head anyway, so this
> moves that copy earlier and does not add one." That is not true...

Agreed, with aggregation ESP can reallocate the head again. v2's
changelog no longer says it.

v2 follows as a new thread.

Andrii Tereshchenko

pw-bot: cr
