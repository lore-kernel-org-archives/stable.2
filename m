Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794623616;
	b=kZIY1Fn+R7uLID91ikds74oTGSESCTE1qkI0hR22/MNy695Ow4mL+eMb9szKkkoyLqcz
	 cKX3oy21Ywb3mPcy4NmGHbiuk95r4viyfEWw3ikQMHCs19r7K5mWKUyrI/cpTC7lEDnU5
	 X6gNDgrGZzTeNdNS/mpt1GCW9usGmeUUwPZ85YZ3vu4AGVsyx1kkACrg6Z6SDiXO0a2tM
	 qAN4dWHbPYEFF1V4TJlEUs/jz6RLQAfbKjrYJzPU4lNlCNI0u2zwKqyToFXNj7P4tiJHm
	 z4MS5BuPRM0uSulbztrNP07xbql5WIqePcJM1HqtiRhZ6WFWoKRYuQpOgQv16Jn6kdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794623616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bJehl/EaRvv7fxLuacOZsocXgCWzK0RPTXvgb7IEb98=;
	b=KvZsOXCOW1Lz9d1x5iHkshC4DBtpbpZcmn87lU4yVGzyganEmn14jaNmoUrIp/AI6lqN
	 8St5yJdjrXsqZgQrw67MglnCpX+fhmQF5PKcbYH2LjaabPb5qYu9g61GTC2Kk+JM1yDZ8
	 A9aVT3AzIF1uPn6/+hYJU/RlxL4VfCEcvxmacIKwBwTufAkrE2Tv3cPMwkoC+r44fGrRO
	 dXxUrE/Ec19LxRN+5hJO0I9XgHHCE0ci/DvdPT6T8VS2CRAJ1opOMb3FWfAOW88WvEAjP
	 sDAepNeh5dVvO6MMgYfV2QWsXjKyUOQKMOrM9PkdZ2Gee34bjgt9Aw3ta5qps0kL8iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cpyhwBf2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C1606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 02:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E95C1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cpyhwBf2
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c6ce60697so43553256d6.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:33:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794623615; cv=none;
        d=google.com; s=arc-20260327;
        b=L2JeoCrbQdgcxxWYTmWjtloV1P3bN176pYyOC/Sm8cA9V0w7FLUq1mmO8RE+nPMPyF
         xe55jgkQ3Dl03Pq+Vjl2wzACCAswPyBd8awv9UCMF3h6hi9bv3V2A1cIQ9t0SoQXebbs
         xmT/hcT3G1lqPz4RKDv4DjITQQKYyu00VGE4iDoF+THbaOnB/G7hdSpyAZpgZYcLcgWp
         yvV2HFjuvV82JOR6uFPsLiljZdu3q/1k6Nbwp9zU6TAbRr2JfeUmOwKSidQrcFTuPdD6
         uU4KuZpWvDH5ypM+90Oi03a+9KjexVSIMugUvZUyj8KXb7JRswpReiHS/VoeUDIBtBV2
         8mnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bJehl/EaRvv7fxLuacOZsocXgCWzK0RPTXvgb7IEb98=;
        fh=VWaTlRjA4BoJMQkAzLoMNVQlwb1Grl9EV56hq/QR7Cw=;
        b=pEYVwPkf3HIJk2wG8Eysc0nnImgvQ2sBgWNN+wI9o8umqahP/bCfpusOFTeTwmMehN
         SKG1vyfmw9onwqRIEyaHKLoi+5+R7BsvaYuOfrnHCqWCedcpDCVch5OuYRmlbpIjDMsN
         U8X1JeNyokaE7IyN3Y+oIOItjVByn6TndNtItsrJKTQliru1R+DdYjvlLkD/4Pek+KLy
         TKLdPxa+/r43GkMQWt0Id3lpjIoMFi8OyI2NsoNX3/2KDvBF2/uyRnrutfnZSVnSBwCU
         rQcrG1pZ3FIFT2RDAs7S2NeYVdpnSD3JT27BtyAd0kvv/avzzDmFrP/WOOaqj1+90Tjx
         0/xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794623615; x=1795228415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bJehl/EaRvv7fxLuacOZsocXgCWzK0RPTXvgb7IEb98=;
        b=cpyhwBf2J6X2pdPgqT6uFinbC+cZWDMFfRBjSFx0RWM0tJyQlQh2JkQrnFEhUxBwdm
         cMXk0oRnH1iM2FlgUJtr14bX5lYTaDSVQvQazMr5+RMSyqpF62LcVh6Kmx7I6rkBQwxZ
         4B0sAvNZ8XfR0KeHSEAAEKS5aGRRr3Rg5rA4tl1y/g/DsrzWz/T0/uetEQ7t8QH6T5b7
         X/JjJ9X3e3L9uUvOCe5bIIIZxeuf9+o8ke9L1DANUdvR99hRRa5hXXCzYndOHnHKWJvs
         eic+kKavTP/lYmQOFaiK29aiOHL56z2kh2wof4fBxmWYGidLFGwlmO8Lk0PErdB1tH3P
         AKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794623615; x=1795228415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bJehl/EaRvv7fxLuacOZsocXgCWzK0RPTXvgb7IEb98=;
        b=tAOq0wFBOwlutEGO8hzYSH8sjtUtr6/7u9VCtGYtVyfYbGBD/Kia7wEdX1/WpbPGgc
         j7WnNscnapMy+3krjLVGLszR9Or11Xmo2gHkVB2uT95vU5tqH3zPw2DekXCleIzwFIea
         xUBk3t/DnSRG32n4ynKxI/soqv9mxGIHVLE18t+l8iYxMDb8ROdddWZpjw1WbW1cgKmu
         WtC8DVGg0JMs6/Dl//DKyF1lBLSFKc/1GVdjuVrVNzwoIadGItKEHpGulu7jGF0wRXxb
         OG6sFqHj6SNBqjhu3qDqWHvkHqf8g1+Wdq5QTLHEVlmGFVW/Le0KynD0LnVak7eAIeX8
         sE/g==
X-Forwarded-Encrypted: i=1; AL+hErElYwx8pQpBntnQ0LCegAOOF+SI7RuTXbYZQDUQzuuF6ZJJwpuxgPNes9vsz2FlGoGYaIKsWHI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/i2MzCvexMa5GKDWYKHtNV0rULQ6BNfW0IS4O4MY5Sarduoj7m
	0ChQRtIFBp0vxxdQf2Ee7YINS9T842k2s4otUnM8Lxdy3jO50mIDCxovLVHPobr87e83jRovxdZ
	NBcsadeSOnWlwV86+HEczJ5EHc/Ypw3k=
X-Gm-Gg: AYBFou3KqtTrHVDdhaZCn4q1bfL+KRVv7ax0nfifImXev0SQDiTDqj8WBavuvLxnz7i
	HjJWmya4SuBeOG5+1jBeQyMRZNuQNpOF2WB81ewggbukOJH5mvdnkjR7ZORVWHpHxhhkEVmx7yB
	jeThcgZfwFTnCAADoPJeLkUMPaTne91vATcGjC3MOzJENbCUtEAYTETrokb8253wBo2+aDt6wtT
	vMLcTGf+0h16Jv3VW+3jUpyvEx3e8ICJQGln8200toBtxeZ6sEsC+buA1k+/TvNZdtUAFBSXOTx
	0oqxUmJFXkq82QHu3QxbKuKwuB+citn29gfpoxZUfUp4c1SOim4N9RBLcKQPjdn875YEubv6b58
	dxZXhYgpx6ug12ZfHxmXT15RE7YCuaSoeJTQW
X-Received: by 2002:a05:6214:5907:b0:91e:938c:1615 with SMTP id
 6a1803df08f44-91f242070b7mr68774826d6.40.1794623614738; Fri, 13 Nov 2026
 18:33:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114015554.2187341-1-zxyan0222@gmail.com> <179462149962.2168702.2687296647559611353@kernel.org>
In-Reply-To: <179462149962.2168702.2687296647559611353@kernel.org>
From: zhu xin <zxyan0222@gmail.com>
Date: Sat, 14 Nov 2026 10:33:23 +0800
X-Gm-Features: AclHuK9PJFdnYQp60hzQr-aoL6oSJj2AKTDyP8sv_Y5ch8KGojZzj_LkveAYZWE
Message-ID: <CAP7veT+LavpYFKWuniXO8ddfXF7cYXNO-r_r=0Bj_pKVXJdawg@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: re-enable on-chip parity checkers for
 XGMAC ASP 0x2
To: netdev-bot+sinfo@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, horms@kernel.org, 
	0x1207@gmail.com, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue was triggered on real hardware during safety-feature
validation of an XGMAC integration: FSM state parity error injection
did not raise the expected safety interrupt.

There is no kernel log to quote for the failure itself -- the defect
is a silently skipped register write.

On XGMAC 3.10 and 3.40 cores, with the patch applied the checkers
come up enabled on ASP 0x2 devices and the same FSM parity error
injection now raises the safety interrupt as expected.

On Sat, Nov 14, 2026 at 9:58=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
>
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.
> --
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
