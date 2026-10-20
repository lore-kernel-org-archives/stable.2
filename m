Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465406;
	b=1Iaq0Ceve+KdIEgQ32axFI5LusUmKKES8ihSVr+wLPk0+agyG4Hoc0X829SuYr/IqPXh
	 yjkqMaVnsyAM+U4OQs3ABukl+xuF6vZ2n1CV+kr3/9gSZiqa3SlbyxtZRzhXzWXc0osfd
	 L6w1VIHGlFxswe8oAbvw9P0ENiairw/rnJBD66NhKCqnmD9++9TnoIgb5QA+JkLNjtbFs
	 uF6oeyyHDGjPqcdXWPTT1UEf2Y0cZ0VYrNdibMbgNI3VDFObQSPYe2ZxjOKne5vqymTyd
	 kCKyLdBzZhToniPdS01gUPpV4vI5Pav07eHfK3bkMaybdd7lW73o34NunbId9/6IgCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7iKM8EwoaojoyuTFakOaMxaMyLliXbiGe3dN6S9YDMY=;
	b=EouRwoGDGacSK0GEnDcWSB3gL+LIYnyTVEUbHjst9QndTENghPbALu7oUlZfT2oc6hry
	 4tIkGyDWd95zyJoAoYOaXdue2cLjhAz4gLTkdEj44SMMUYtcbymv0hV2bnBtT1XldYf3L
	 yjR+z1aGJgh8c0pWGETFQYouxOh14wWBAW1ba698z8dLo05zN2DhSsFEyy/ODUKBtrDCl
	 ADXA6YtViFn89bzMZivMyDJieQpW81z831JPHPApX7w+ta0fIBfZf1B7oFN61JHXO6CGJ
	 xTgvCD9CtdNspESEe84KKIjVQf8goBiXDA/+A2NfjbK6o221GfFaS/MiebA3CjIGuTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YkYiYCQN;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E48606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E48606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YkYiYCQN
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so2380808a91.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792465406; x=1793070206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7iKM8EwoaojoyuTFakOaMxaMyLliXbiGe3dN6S9YDMY=;
        b=YkYiYCQNhIREwubHqRXjpJhIVLCmen08ktmOr/IDht2Mu0NDdDzkeStxyUqonSytNf
         NOLbZ++Nt7V5JnCVSAURZdnUHuBkGppvaArpkmC5EtySpmzRNMQYd9nwO3zsPN2eK0Jt
         ToIiOPVq2Gc0VOov9KpToQPQOmOGHk8ozyaZTkW4LVu9hsMFTGKlYL2OryBvMwpSVT1O
         omtRVAVVY2VwnWo+Te45Lt3acnvdgEfnAD5cm6ap9SEu7XJWcfvQZeu+AHZEnxAziZ+r
         0Ym21wMmptonI813GOS0BSJmyeQ/v550S/JYDvcMyTMAE23nuF6R5NIHSrHTRvtxkMt0
         m8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792465406; x=1793070206;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iKM8EwoaojoyuTFakOaMxaMyLliXbiGe3dN6S9YDMY=;
        b=e96sNi1ynFfo7xFz7f30fXUFFG3frf2Dba2PFtUesJziXJ3p2O/4oN725SanU6jf+c
         ePqPQfcj9RCCfZ0CAAnCLdaqOym5fET15XWspNUvkRrwzN0dWG4qrDEdtAFkRgqHrplY
         JC5ED/Zv9sCY49xV7DqRPnVcfjVAr9msfTeEmn5prDaNp3wkDBV0CybQ6MQ0AU8bex6Q
         E5ygQ47KK2HsyYLp2ShnYfY/D5v94NDyEF2xbdpVjpkuVQSdkIBXvVlCgwVwE+UmBj4Z
         5HDIXmHvS5H6qG64KJT2aax9u5gwtySdqOsP6Go/1W/JXQjB3QIOa7vhgF6G994e2hqf
         2ksA==
X-Forwarded-Encrypted: i=1; AKwUvBx3/inEjggrqtaG9MvjE1Uhfgv5c7e5XG/VXjyUqf4klrwhVfissEGHSacJZBaGIhDLmkdNXZM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZtGgvARAWuXKMc3JIgsGaOOlx5kHE/LBfW3NthtP43R1+wXs8
	j4UgO5ap6blUFj38+oaLSYux9wSWSLjVnx7z/obzT3BlNtvn4dtztKgc
X-Gm-Gg: AYBFou3eNtfzUzZhHKWAmzbhif6zZUS8soQ9FsSxMr/ku5sYeOVFkTXtSxiBLx14eCh
	mk6zuI9odpZH0enq0zynTi6bihUNRRs70mLAEsYwrNK6w1OpkHRRQyp92M8FFlehhEvcv0qD1M5
	v5pB38jRwylaPJzClUFPlBHQW2a7u7zpduQ/Vw6RJP554GlYyaOi7Rlk05FF4k2BSc4e6wtr4Jt
	2OBSowIpNizM8ku6V8U/Ewd0RDRQyKHYmJfgV+S4t/wbQ5Fsd0ZYua7aJSaWgN47LhXN6T0LS7r
	1wZaYmxNeh+dfWzESS6EoIrQNEk9OCisZUQ3c3V6a3ZgLp8D8l2OsodIQg3R/WreFRTlru4GX6H
	dZzXpRQSpCaOJJUPSc+vPRAiSlGfNE9kA7kaFdzGGhRa8qwbzWNh52rmCOnVwg1j31JxX78pua5
	zpS6VqGrbsgkQb/GYDD8QUVL2hkWIqxuwgcmIDAxV+6B+QQZ8nLfslE0mR2sFua2mKD0Ff8rRN0
	AkRiMEqM2tq2oCF+OqQipHqMooD0rVEWJ0cKL0MWYlKG9G6SwS4NoVChkD7vQevEXVmK5ggqUtD
	Idbl/pWwrUD89R0SRjXPP30dFykNnDsU
X-Received: by 2002:a17:90b:582f:b0:3a6:f1d2:57f3 with SMTP id 98e67ed59e1d1-3acef542fa9mr8451695a91.58.1792465405825;
        Mon, 19 Oct 2026 20:03:25 -0700 (PDT)
Received: from localhost.localdomain (ip67.244-167-222.hkg.ten111.net. [222.167.244.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d4005b1sm2215884a91.6.2026.10.19.20.03.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 20:03:25 -0700 (PDT)
From: "=?UTF-8?q?=E6=9D=A8=E5=9B=BD=E5=B8=85?=" <yangguoshuai@gmail.com>
X-Google-Original-From: =?UTF-8?q?=E6=9D=A8=E5=9B=BD=E5=B8=85?= <ygs@cgcal.com>
To: netdev-bot+sashiko@kernel.org
Cc: Guoshuai Yang <yangguoshuai@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ipsec] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Tue, 20 Oct 2026 11:03:18 +0800
Message-ID: <20261020030318.6471-1-ygs@cgcal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179237120528.3135.16925112275068010433@kernel.org>
References: <20261018005218.53267-1-yangguoshuai@gmail.com> <179237120528.3135.16925112275068010433@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Guoshuai Yang <yangguoshuai@gmail.com>

On Mon, Oct 19, 2026 at 12:53:25AM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> 
> Does this reset only reach the head skb? skb_gso_reset() writes to
> skb_shinfo(skb) only, and the frag_list members seem to keep the outer
> TCP GSO state.
> 
> In the case the commit message describes, strparser chains a cloned
> spillover member onto frag_list. skb_cow_data() then replaces that member
> with skb_copy(), and skb_copy_header() copies the GSO fields over from
> the shared outer TCP shinfo:
...
> Could the GSO fields also be cleared on each skb_walk_frags() member at
> skip_cow, in both esp_input() and esp6_input()? The members should be
> private there, because skb_cow_data() copies every cloned or nonlinear
> member.

Good catch. Indeed, skb_cow_data() copies cloned frag_list members via
skb_copy() -> skb_copy_header(), which preserves the outer TCP GSO
fields on those members. If the decrypted inner packet later takes the
ip_do_fragment() frag_list fast path, each detached member still carries
stale outer GSO metadata when reaching validate_xmit_skb().

I will send a v2 that also clears the GSO state on each skb_walk_frags()
member at skip_cow in both esp_input() and esp6_input().

pw-bot: cr
