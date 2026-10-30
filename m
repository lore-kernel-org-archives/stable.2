Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793318851;
	b=s8t6w1bbXrGWrn9Fo8uSx2DDqT7lCgOiRyWskhAZi6lgf3Ek7n/L3FBhcmM55Fg04Prr
	 uVUveSZ+evOYqzs19supkMWcBE/h9u2LZ3t59n+p88SHAfuJUw+wQijZz7Um4ViLeW403
	 lkRaSZcDwpGtmmAerhsk/F6EZ0YKrDvB13pevR4mT9HMqtah4uX0c3qi+o86DljMZvBNX
	 xYSK9PhEYp59AGnsXiMwjlL4kuLAPOyemJe6iY4d5OuJiDDU7Vki3hTFoAF4+895wmaBn
	 1MWOpHx4v7mldwqYOe3z2s2IuTYfkHqxXS+0Kp/cfDTn21LW8oLmIqHCxf/STDA1TFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5Is1q1ecUb7pBSKWvaFfSBH1p7ZqbUFX03RWCbwfOws=;
	b=xkgeJLEsr0hbeEKlIJitsgOaAlgVaPjCLbPN6IjejTHTnKSMG89S67+ozzZpd2/R+gVz
	 roSi/fX4Tl7OdETzJ8SKd50klI+SIEFIk+9Lz+QNIiYsJU28aJRC9rb68+jbhLKe4CD3A
	 JRGWnY/ICworPhjEo1cvvxIMwTDVHngfkJSS8f76c7azVmULQrS0xO3bcvFxLb2klVu15
	 qck9OAM34UE6miE/Skp7tx5xMdY319hg1Z8IuM4RNcFMy1wD5QzjTiUyrTyQ0vTVDzwW/
	 ulNdwFbWkBoDUjcvjkVOHK167ZWSkZDEad/g2rOKk7Fy7w9UfC0sCjhYDBiUrOL2DoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=CAMpbUEf;
	arc=fail smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB997606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 00:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB997606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=CAMpbUEf
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso22996b3a.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793318850; cv=none;
        d=google.com; s=arc-20260327;
        b=KldbzDK3wJ4RiZx11HYTFDVJpbh8ZeIT6RF6OHbvVbeCk45GhFiws49ey6ra+OV7R0
         JWuUO3iMmuOHsE9klhvmFVbfDR9NgwOjr+We+p83vqVKOQdxRBg/i59Kl3AT5mRInlY/
         gUADoNibsyJYPmjyfv2PaFDq6U5S8sGDnu9XAva4VvQdK35Fxi2oeyy2oWW/ecOFP35D
         1kN4FVJMPWjDEUtuviZYncTG/6d7R1LoTBlgNexW5paXoESg8KSOhkQ3gRiaY+RgvvTv
         T5cDoH1ZpnIrb7ujgdLDicoMVCVsGh68s9h76WTYABcwJmZiAp2H3DmTD+zH7p3DK0xJ
         qpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Is1q1ecUb7pBSKWvaFfSBH1p7ZqbUFX03RWCbwfOws=;
        fh=uoDCc0vBcBMKospmMAG9vf7M+QZgslybojPG32TQxfE=;
        b=CfCEkUNftC7PRYys1LuSqGL5BwfL2wl3AHCC6uz44Z2i0NokPGbwLML68RttkwKgcV
         4y2moOuxMh3y7fJ6R5JUbwDyu43UqNKD0Ko+cJutu68jP4cSpy7AQqm4xhrUOLqrQi+Q
         svSOy5jcW7VJSzSUPDF9T43yYRrqXlS+erGj5gXGqzAFfEJogmJeDt4wfsZIaGqfcy11
         T5h9sjcDO6sXbyPsy8fqXSurzH9p8o43hndV5l5xTSKJ0rU4elVvrO29OiYzpB3/bncb
         fhmpAVSrFrx25nxil8X1Z+WLLfC6Ud+rzxKHlSs321ZFHhcy8ngOZwAIReD/2iQHkHuq
         bb9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793318850; x=1793923650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Is1q1ecUb7pBSKWvaFfSBH1p7ZqbUFX03RWCbwfOws=;
        b=CAMpbUEfcPZQe2FNh/d6BZ/+67nypKPYHrdo8SlJyXickSNV2ZNWXHWV2WuakoUonN
         TleR3EGOw/HINKyt6QtO8WK2r9L4JqpSIwgKOpkyJSOxy0mU8+hKYUYJShXgypz0HSGy
         OfIIRzOs1wwTkL7jk6L5EgG54mV24y/98SJ0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793318850; x=1793923650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Is1q1ecUb7pBSKWvaFfSBH1p7ZqbUFX03RWCbwfOws=;
        b=MJjbq68YSMbwlqJNTDFQuS6WscIu3mXCjlSGhynROqVM/9jWcKLbsxtIJvjGmkcq+r
         lzNA81B5WCzZu4sVU5CzaCMRxFRQeXAcVJ2rzbk0fKyIc7BhrVl6nGJ1Bw0uwuaoewU0
         k9bFtQJ6H5BwxhDHxcztltmbmkn14R06qu0BEy/yjJzaVlYfDEgEdAKw48pp8odYTE5p
         19kclpEt1wJ2Feu+ITwiUZFTo79kYzW0lRIxQK/IfKI+Qcsrw24c4HwnqreG4mZAXr2e
         5fXN+QcLvOW5nqGc8mrhZg/G1bZyjf78u8wJCCs3QudUDRB70idVECrxElDLGIkBYeZC
         xCMA==
X-Forwarded-Encrypted: i=1; AKwUvBxkgerurNlwR/5QFYm18ayNVpKHmDZVH/qNOzObDQyIf7gAzKNSwlnlsPQlV/SrFjVgfzFtGCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIfUxUG7aWmz/6E5xUK4+mgI7CwwGS26xK55ftg/wjdC5/OxBi
	Yx38jL3gTzjAtD+wyRpSXge3oHJmJ4tmWd6z32ar9OpQ3q/m8YSqR/0DOFlbgEuGYVVi16jzYZh
	gW84TMUzIubQy3XY0WuwzsZi7B6LEWqsYHv8dzrti
X-Gm-Gg: AYBFou0rG29Fuxt8SJWuinE07TwfH7GfYn0Y7frhMRY32gENOkM9zwcqNrJnwEXLohQ
	V+kIt9BDzvuo+B7A+0NPayzmFMLJPPoTqcV0ooA8Iv51jVwVMftzmjya0UfFaFjD9d1TQgWh6+w
	K5mATFQjQ2EV3ms6aJlpPV5b1Putn/jcqm83+ReyXu826gOSgo8tWeMEGa7zpL3uxcb6RhYv/wr
	MnI8dMJh2CAXzRBiGkQNWxkAP2T7Jxbz4HLg8w83z57ogiMG9uHGCmBNveM+cqwXy0kTyverkI4
	4YBlfY8VxrF8srXcwqxwO7udJiyvgA0lDChXWK2HgvckgzoemsD2BdPlXCw+lCBygQ3680cLi+m
	l1WLbG61YSp/2j/rw7RQyKs3UgJR/vMVP+jg+CTcXYJb98mf0vThMsXxFLd3RPcScaaxlvRFZu+
	qSqlN7hEpwRV2i1iU=
X-Received: by 2002:a05:6a00:e85:b0:886:3a6c:a9da with SMTP id
 d2e1a72fcca58-8a9beb6139dmr541320b3a.26.1793318849992; Thu, 29 Oct 2026
 17:07:29 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com> <20261029165943.41fc74c0@kernel.org>
In-Reply-To: <20261029165943.41fc74c0@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Oct 2026 20:07:18 -0400
X-Gm-Features: AclHuK9pGK_NVXysy8qJ2rHmdSeqy6lRR3eJt7FQG_a8cHC6dh8dDfx_bs51Zoo
Message-ID: <CAM0EoM=WYGMNxc=n3j+nwyXA41SHq8o+bVvTR6uYp6HUeEa5aA@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched: fix short-skb metadata and namespace boundaries
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shaos <shawnq1@163.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 7:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 29 Oct 2026 19:27:36 -0400 Jamal Hadi Salim wrote:
> > Subject: [PATCH net 0/3] net/sched: fix short-skb metadata and namespac=
e boundaries
>
> Please fix your setup, Jamal, all your recent postings have patches
> posted in reply to the previous patch:
>
> Patch 2 is in-reply-to patch 1, patch 3 replying to patch 2.
> They should all be in-reply-to the cover letter.

I know this is what you asked for before - but then Sashiko started
getting weird and i went backwards and saw it accepted this format. I
will resend this in 24 hours and stick to having it reply to patch 0.
Maybe the sashiko issue is not even related to this but it was getting
a little frustrating. In any case , sorry ;->

cheers,
jamal
