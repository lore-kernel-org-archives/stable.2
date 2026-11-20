Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191647;
	b=xkrH4nANUysGKR/kgQP8JmW8eLHWEzWhiu/XVgyE8tGuctVsC06SLkEa4pLgpsADrtV0
	 lpdGRsJer0+WmvFM/P4PML26lxIHcipEOIs0dUp+CgtGDcjjU9776Oq1vTDhyowf/y+m2
	 ckGaeQebCWaX7E+QkHKxNvS48+HUjRFKK3czxkrfNVC/7eIehYzdEOR+S1p6xWAEOKkqd
	 BEcvUeFE6GAGjSQtnjljZ9aIl/vECVTln1hvw12LLZxn0Xq28uragCWANkVYsYi0DERM4
	 paP9q61DM9k7WGhB8IsANI+idJXSR18zoD3YmkTQuxh/lzFQAK3WBCPnXG75cSNv/jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oRxpEC2GG8v+kUysfDv1Clo2J6a3wzMDb38qxEUjywA=;
	b=V90MZu0B2G10jHsV1EbNlWjGsvMVlwdwm7DCkELHndilRoncvcjmaqo2QbffaqXWEsx3
	 DeDbbj/rg/zKmjjLIwK6YN87OVfT/lQKeXrCVe/hi6zNprgtw+MCBHV82Ik71BjDN0Yla
	 9YecEfCuWbVMUn4zZl/q7nnBukkxCspkez1GKI44NpgWPcHS/YHv0daLSauQBAxL2zxE/
	 ZXfpM59nmCC/3+v4q4ppfMdLqz9DUuPzAdHj8a9jZbvmatvhWxAX1Y47XDT/f4NFSJMxO
	 NV2g0qxnukBgohtqq7ygqEPUQMpUNtdgkOiTS8/VflWVGpwTWccvEux3Yr7kEHm2hVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andrii.net;
	spf=pass smtp.mailfrom=andrii.net;
	dkim=pass header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b="m4SK/qcu";
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B08606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B08606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrii.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrii.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=m4SK/qcu
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b3fb193c03so558377a91.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrii.net; s=gmail-2025; t=1795191646; x=1795796446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oRxpEC2GG8v+kUysfDv1Clo2J6a3wzMDb38qxEUjywA=;
        b=m4SK/qcueYDr3XuCRqc7TgUWMwRcuhFcdHtQ1FBF9Zbdy4lQWhLf6vs9SK2vMlbqK4
         2dVtbe5YrdXbiV5wSQvitn9jj/ERoP4RArf9CQJZ8YCbonVWZpKLUIRSi3u4TPrVfSNU
         HCc053Mu7Kv9NA1DHUZOC/If/pZWqEwQbrdEW39w6o2Ymr0JveR0z1lnhmsZUuoYIpV3
         28XYNtgskHippdDC6wwaWV8uHljshF6bTNFuhro05DnVitr1CdD9kaXfFp3DziiMUwwT
         JqaWZ4CRsy+oPwwwyLutZ/RVdmHkUJXRX4fp4Owh7kPP3r8SWDb98FBqfxwpBLcSWcVL
         hCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191646; x=1795796446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oRxpEC2GG8v+kUysfDv1Clo2J6a3wzMDb38qxEUjywA=;
        b=h10/KjKtB2t6tE8oQt49nYliGF9gxzx6Q6XYp043rHyPvohAclM14PDDJfAT4LdqLZ
         6DekBybQM+mw9XpmTbO44sRpsFM96YktnFpte/+MNj1Wyaw7pAhrjx+++RkXsasrJcM9
         fgXFLx+++6+3/BFB1nYzO8eRo1aZO/Icb5fbmxS3n5G+vxfl5dXxWcHbCeyPS6gsFcIq
         e7ZYLf2B5J7D7yYUbJ6FWlTVrmLiAB+t+k868OD8dhRk0IwGgCXb1bqXnj1WHJo40D7B
         IWt5NmwDh7hWJ+/1dj5mS3pqajnPq0QD8TaSmd1g3FoKqCycLfq52Fjw6L1kGlQGSZDA
         gfTA==
X-Forwarded-Encrypted: i=1; AL+hErFog8nqEIWm55rma4sJGAWjrDlM+sNNleIWx1n5qGDIs3hMjZ9O5vLBk6wszXOAa3+Cm31afow=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7glJ8GfYLacblLw4J5Y/ouIsUwa1ijbW+n3vVU4hQLiUu8muM
	49acmc6fItjm2XOhnF/QwwXejVZHVik6RSFtkdiGYcWcxgVq5YiFBmqY/bvH312lfNfNGh2YmCz
	30cR3p4vbF3aFg+FwSpX2W1ni79A+SC/GEFliGIBWzsfcLeKewblJ
X-Gm-Gg: AZFdTZdqbqEuT4t4IJlLZeo1ues7bgTlAqw5AD2JI2GG7+BJFvRIfLneiLY67hacFWz
	UNlQXlItfNx8u4Q3Z5/cdW3lYUQtsbSbPiXfkhb79nUnuBBHh72Y+1AT40JHyM9lOQ+3FhBO+OW
	4f+2tW0q3IrPuNhRIrnwqfmVdpUh5PHCeB5ea+EOaKmLxdW/ivdm0/OlYP2COw+k/jgYqhxptKt
	I0FEsPqQqi9bipn9WhjBsLos+g3wDoJZsgLBQ1CngjJociin6zBzt8VCgEVwicPU8KSe8u3zVfC
	84plXyytcB/pghv9+64PMrz+rsypWerMF+GD8xbcguQFa7q4HJ8IP0DTUDuFAcjWgRWoqTpBV7N
	Si3qBj7fnKpLeg8RkXAfWpvhxAnw=
X-Received: by 2002:a17:90b:4b8b:b0:3b3:b9e4:e3ed with SMTP id 98e67ed59e1d1-3b41cb47a0cmr3245756a91.63.1795191645728;
        Fri, 20 Nov 2026 08:20:45 -0800 (PST)
Received: from andrii.ai (mac.hestia.andrii.net. [2602:f337:ed:4865:7374:6961:204d:6163])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b40625d66bsm3383925a91.4.2026.11.20.08.20.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 08:20:45 -0800 (PST)
X-Relaying-Domain: andrii.net
From: Andrii Tereshchenko <opensource@andrii.net>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Hopps <chopps@labn.net>,
	Piyus Kedia <piyus@iiitd.ac.in>,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ipsec] xfrm: iptfs: make room before copying a continuation in reassembly
Date: Fri, 20 Nov 2026 08:20:40 -0800
Message-ID: <d9a8310d-e139-4edf-9cf2-4b32664facb5@mid.andrii.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <ac558468-8e5a-4b1e-8d4d-591221b2dbf0@suse.de>
References: <ac558468-8e5a-4b1e-8d4d-591221b2dbf0@suse.de>
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

On Fri, 20 Nov 2026 12:18:09 +0100, Fernando Fernandez Mancera wrote:
> This commit message is too verbose IMHO. It is quite hard to read and
> understand.

Agreed - I will shorten it.

> Manually accounting room and need allow us to perform a single
> allocation but I do wonder, is it necessary? This is a very specific
> case.. maybe we can just call skb_linearize() first and then check the
> if there is enough tailroom and perform pskb_expand_head() if needed.

Agreed. In my tests regular traffic (HTTP, ssh, scp, ping, UDP on six
NIC drivers) never took the second allocation; only packets arranged
for it do. There it costs one more reallocation and copy, but the code
reads better. The first version of this fix did what you describe. For
v2:

--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -909,7 +909,15 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 	    iptfs_skb_can_add_frags(newskb, fragwalk, data, copylen)) {
 		iptfs_skb_add_frags(newskb, fragwalk, data, copylen);
 	} else {
-		if (skb_linearize(newskb)) {
+		/* A newskb started by iptfs_pskb_add_frags() has little
+		 * tailroom after linearizing. Make room for the rest of
+		 * the inner packet before copying.
+		 */
+		if (skb_linearize(newskb) ||
+		    (skb_tailroom(newskb) < ipremain &&
+		     pskb_expand_head(newskb, 0,
+				      ipremain - skb_tailroom(newskb),
+				      GFP_ATOMIC | __GFP_NOWARN))) {
 			XFRM_INC_STATS(xs_net(xtfs->x),
 				       LINUX_MIB_XFRMINBUFFERERROR);
 			goto abandon;

Thanks for the review.
