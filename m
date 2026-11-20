Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795199316;
	b=zietn+mSgDzGA2WA6YE1bosw9bhTSages4kWkpvEvnhK1mtnr/s7S6KZOrzX+zgeyRoT
	 h3UnzvlHcGECx2PNYcFtEEM+/M7iR9yhcw8EMdn5rRdRpJMq5+hCAcNbB5979CH4ZklhD
	 PwRJuNhD07ThRxeTNMN+VApKw108/wyV1AsH44oX4zoLasBXbN5fc/Q3IBk8SNaj6fUM7
	 wtqzPp9L8hVdoAoter0r660NxnvFHfLdUNShXXj2U0xcGnOYa7V5gLwwM/pXq3Pjn6cUt
	 UkcvpHOK9MYPXMrhOP58xShoeZ2zBECW4vuPDmeP0vvyUarEcWUB5MDqalC99nKzKXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zNDQo+a14v9s0HW9OP+czAcmraAhXwLLM732JTo+ZL8=;
	b=E2iOWu41/Zkrsf+syk0mvM6qyh2ClwTq4cGp9RcHIBPi9nDr1I6HVqucI65BOGxpj+0t
	 ogq7qU+Ja/rZdBUjjT+vjmHRTXrjPUzQUQBMQsy47l876/RajgJndSbbX8YhoY2WsiDVk
	 CZBhW/8SKbT/NLtgKIFAOCx2r+dJI1o/HLmOcN6v8hNtsvi9mdHar5NE8bHeIKYPUaGbc
	 e3bahXMM3OwUExemBpseNR5aTfhB8Oco8bAjTslqz6vK9UKYD1t9ghWQy2obp6SD/TlSt
	 eFhjXyABA5b5iQr90kAkFyVwRND/qIN3rVFHXmKY7KH/O8DClGf6P8Lx2QiIMzz1wfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKP+VL7U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E261606A332
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E261606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKP+VL7U
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49a92144733so654297f8f.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:28:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795199314; cv=none;
        d=google.com; s=arc-20260327;
        b=K0sDyjELL2otJQplpfP5fgOrDHsJhFVmmFnqA2FsQoxzF/uy/aWsQykOKrzIb6swzd
         MNsJ0PpGw26SzmcQvlVEUsQoHNuQYvnF/ZLNopBzeOAqQAAJIMGb6nbgZ2NOKqDgwzFb
         FLnhyS/wQ6DgpUkYHnknCcXR7z9eqbcwCGM3mIRIujfgxe0h3+FlwqYcIbdoSG7vGosS
         8EhEV5LUmjhl+JctYwYJl+OnZ3LGiD+Z7oFtFN0I7XTrosVNRxe56/zkgJwKYbYehYI8
         QV9Y3FwL2frqsvTD3qpywhBuRULSkVqx+qKeZdUASSpn9z7P8VmrEaY86b1KXYsoFOzO
         QDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zNDQo+a14v9s0HW9OP+czAcmraAhXwLLM732JTo+ZL8=;
        fh=S6WueyjgEKZTktWG2RrupzRPPgtqKxCMnEW5F8IGeew=;
        b=C/UHCXeFMUhCW49C6NXdgXEVWTm9yQZNCdjD3IZrOCKXRlXCIdXBJCgEHxKSnobEcg
         n8f9pxovHfzrCAAdFy8wwXvENWqCwF8jkahwSKu1D8h19jM2hDQcfhwLiiyUWJskdqBE
         yQKYCrtlgcF60qVmJABAMoxLDh8J17seV5yPgnmO0i51bO7R09/yFS02s2hvNm1K7eWO
         +DZrwh5nEsj31eut41Njwyzs/o3BHmONm/mG0In3MTlhX1jk2Fibe0rJVfyog15J53ks
         iHLJ0D2o9/ORrCe3bv1YypfkuRqrKjhzr4BYRJirEi/3UI74sBQ/iNzGoHx6l+xhJXAc
         AseQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795199314; x=1795804114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zNDQo+a14v9s0HW9OP+czAcmraAhXwLLM732JTo+ZL8=;
        b=SKP+VL7USEbVWLzyNKe8vqlVzzCV9Yk8mcaoFQiMau8f8rXDzwpCak4Vsmv6BR/+pr
         RgylvG9oK1tyn9HVNxsfbZVUNKkIchTWZ9X8kJuoyh1kq64J4Ht2rzEa0T1VyHr22jgY
         8LCDGRU15JxcXqPu3SUUV5SgqRuHz+Z1iEokPyTEcAcId1PaGovoxia4Ty6h+zvaD7I3
         4y2tVCh/h1q718vD/ixJINcglatHqod8P/u+jn7b0Kg91rBesPqOPLmb7sdtO2eGD3hu
         BDKWUbOZHypesxxEv5PhgymmUWQHQko31GpAGU6sziXf/1R5N8yEfF6gUFxCmLJXMEQq
         BKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199314; x=1795804114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNDQo+a14v9s0HW9OP+czAcmraAhXwLLM732JTo+ZL8=;
        b=w8fPX4qmpdFkEuZ3mmbGnMD4V8W6TU0B4nSS0GaOfaklONTDuW4/Kt/TPfq96dEBk7
         CzTbm+WSsMw+7un6N/Qp0t4dnYRM89eaW9nKQkmL/9k1f7jDs0dbNdG3dFQbxwgMqBbf
         EUlJ1eGDJxbHk+vtKTB3rUOcaEtlCoeRA7JhmzcpSYH9i4UoYjOyQhWmvUgKJVQOLfJZ
         crbv5cta+9eB3WkXFHK3WsgLY9oPiMo9EjF7JzFvrM6DPtA3upvSh6IpHwXSR2+x2Rvw
         3zpTpoIO5s7sdFtRNZTq6+pFA1dilziEET5sVSyInGD7mCGzih63pHgTO8nts1GFX6O2
         dMaA==
X-Forwarded-Encrypted: i=1; AL+hErFE/WCPYVLVi2nO9or81KYBATAE4Nen7mJoFPfzwxSPBF6T6rAvBCeuvwcnese3bA4SlrKgzW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0HkS20usVH4hnTlSZ1GxaRqgQZ6KDIluDsSvyWyzV2actwc91
	zazTtrEyEMsevV5+Xqy4QH1mQ3Fhvnss6JCu2eYRTBb1O/Vw8FSxUTtoJ4Ng6YuYUo42ExlKW4Z
	2nUFF5quSdlScFchKCCqAoliAbZsy69E=
X-Gm-Gg: AZFdTZd39OujAFszQFoDDWyQeRCuZ4XsOMRVFbBXIvYEbqHkdp6vdBwv01NIjK1j7oC
	uhavxvpdwD4E5Y0Cc/cuY3waxymI6y4hsrnAumSSIRpWzXs+xQlVVV5es9wzl8I+XEPtIGG1/vD
	yA7M1HF8cgeLQ/e5bKaI2NTv3IZwZCZg/DImNr7DnYsEF5Jh4Wvriyp0TpahjNP1sAtiB4WIy+T
	CK5JB54mZXH+9dP/bYJDXWtm884BaUNvEKTTMD49tE+ywNC5f07+Zpf3jNFj3Y3OF4ouXeb9HmE
	bxPfxRNN05hS6t1IfcfS9nraewyEQNhcMzSnfMW/Pu2aKRKkcYHFq/td6x02NZAEpoJeAXoGbbt
	U351/7+0EZEyqnoyT1wQV1ilOTGv2aR2qAQRGRMplGTdrXh0lAJuTc92lSYEeNQx7cYImiXE2Ch
	BKRbZCJew9kwwRnBYqyre5zl9nbdw1MpiF19H7KHiNb/L9CtSGs4lFpwsg1w==
X-Received: by 2002:a05:6000:2f81:b0:4aa:ba0f:c1a with SMTP id
 ffacd0b85a97d-4abb683bca6mr8274343f8f.40.1795199314113; Fri, 20 Nov 2026
 10:28:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261120002549.1908299-10-prabhakar.mahadev-lad.rj@bp.renesas.com> <d4405a68-5df9-4e76-84ff-fa034f162429@lunn.ch>
In-Reply-To: <d4405a68-5df9-4e76-84ff-fa034f162429@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 20 Nov 2026 18:28:07 +0000
X-Gm-Features: Aa3M54otSF2In6FsOUyV1sYkafqWIOL4jrRT5kqPhS7eswmhjTdncZ_k_zb5leE
Message-ID: <CA+V-a8vj4nCZ+u_HnzNxKXu8xuOR115gHDF7YACFfiDpskQsjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/24] net: dsa: rzn1-a5psw: Fix
 VLANTransmitted counter offset
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@linux.dev>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Simon Horman <horms@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thank you for the review.

On Fri, Nov 20, 2026 at 3:29=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Nov 20, 2026 at 12:25:19AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The RZ/N1 hardware manual places the VLANTransmittedOK counter at
> > offset 0x8f4, not 0x8ec. Correct the register offset so the driver
> > reads the counter from the right location.
> >
> > Fixes: c7243fd4a62f ("net: dsa: rzn1-a5psw: add statistics support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This again seems like a real fix, so should be for net.
>
Ok, I will re-submit it for net (and for all other fixes patches in the ser=
ies).

Cheers,
Prabhakar

> Submitting these to net will also help with your patch count.
>
>            Andrew
