Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268364;
	b=gGQ132+UkDFX3c4Q9SmQCQSS0LCUTz0Xsrza0lCE4+vh1Aa2v0ymM+oak6zN2TtA2nMF
	 Ftm8qeej8NatrqKsO/o9t48DHhwtvSJtJBVwuo104i3du6G/7qDOHYcKn+DioQ7B7wi8T
	 FAcIoKrfUj6Opyjw+O49tf5O0posoBrYzZ1Fc1zf3on4oenq9e5GQ/jPzDOLrhNd6fNCT
	 zV1mpcQr0J8aunCZdT3ksvEMhT2ZCrra0E2g22wcGgVZBhozHNEi4RHXQwdJtGqVWk9u0
	 cQeC5w8Zx6IiG88hCKgSfFQ3CaqI+qpAsOiS122MbF+JkwscCAPFWVsizsJZDk7Nd6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268364;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=CwhmwwstFNj5j10OWiKD2vxusMpjkpm5sJ4KEs5Li5g=;
	b=qYiRYUqUhf8kndkXvqQRQ6Bd0wu1zZRi3UP245ekZeJ7M9vvwRAxHBsLOhp+nZPQb1sb
	 oH+XX26b9wr8F4rxF/JNz01s9imLtfbTWyY/If2Of/pNvasAP37TbJbgJwsSMl4YXux1r
	 ZBiYCo2wbqQoF1IC2MJxtU1bsD4pCQL8laMC8EQof2beYAVV5mid156F4QRongqcbo4VL
	 ufE3VxkmHBWpYBrrclhGPYhLZ/WmDCoCT/dd5NK1i5+jL0Fpfrm00L1mfRcIPpToz0Xyk
	 nniAiiRZhSdNcUG2lOQKUjCbxdfyVkq4vqRK1hmKukwZBzkw32viZhNROU5OTye/oiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cQq2SEPn;
	arc=none smtp.remote-ip=91.218.175.25
Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED1606A339
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9ED1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cQq2SEPn
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nHdmsnjBfSxwIaneBQeFmfOSq68GBVeIj65sbAMafCU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793268360; v=1; x=1793873160;
 b=cQq2SEPn+Jf/ZWFJatP4k8UfUzMA0vRvsYRQwjOexyPzuuQX0xi2tnTLd4AIVQQi5+INRPZq
 nGVmU6h6UM3d9wY9RtrVEopN9yaihH3lkBvLXjW+gsDeVkA4/x+JYu8rIMD4bZs2PH7PmlqahHU
 teutKOSBGhR3hODSnqEwCsak=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eda39c8b15cf919f;
	Thu, 29 Oct 2026 10:06:00 +0000
X-Mizu-Trace-ID: eda39c8b15cf919f
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so7260e87.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:05:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz7FP1JMucUeDonc7lTreAZAW0iG5GAu0lnHeumf8zjtNWpglgIx2/kRInITJGV70X/8uqJgnM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfvny13z6i373I4qb9aitAmevLWwyVVW1mo00OM2NwbcE/xVJx
	Gx4Am0rcZTYkps2CpZShxh1yJc98yFd5c+3+a9Dp0OW8Flev2xI1dOcGc73Bs9i8VLJOHHTn1rU
	xhLmiDwcRF2TY/zsxbzj30cRDBTeCTd3zvCymSgkc
X-Received: by 2002:a05:6512:138f:b0:5bf:d10c:ab94 with SMTP id
 2adb3069b0e04-5bfd1821c8dmr108375e87.11.1793268355473; Thu, 29 Oct 2026
 03:05:55 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029090522.64662-1-oupton@kernel.org>
In-Reply-To: <20261029090522.64662-1-oupton@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 29 Oct 2026 10:05:19 +0000
X-Gmail-Original-Message-ID: <CA+EHjTz-kXVbzcjtMte8B26f0Undr+kWjF2-d0B8TLT8n03hJg@mail.gmail.com>
X-Gm-Features: AclHuK-zARc41Snck-YLig2gcZHoGmmDIC8y2XoXzzXzf5M8gD2OxXTNVUK6Dxo
Message-ID: <CA+EHjTz-kXVbzcjtMte8B26f0Undr+kWjF2-d0B8TLT8n03hJg@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: nv: Respect HA when computing translated TCR
To: Oliver Upton <oupton@kernel.org>
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Oliver,

On Thu, 29 Oct 2026 09:05:22 +0000, Oliver Upton <oupton@kernel.org> wrote:
[...]
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
[...]
> @@ -29,7 +29,8 @@ static inline u64 translate_tcr_el2_to_tcr_el1(u64 tcr)
>                (tcr & TCR_EL2_TG0_MASK) |
>                (tcr & TCR_EL2_ORGN0_MASK) |
>                (tcr & TCR_EL2_IRGN0_MASK) |
> -              (tcr & TCR_EL2_T0SZ_MASK);
> +              (tcr & TCR_EL2_T0SZ_MASK) |
> +              ((tcr & TCR_EL2_HA) ? TCR_HA : 0);
>  }

Should you forward SH0 in this patch as well? It's missing here, so
the walks are Non-shareable, and looking at the ARM ARM, this would
make every hardware Access flag update CONSTRAINED UNPREDICTABLE
(R_WLTNL, and the IsWBShareable() check in AArch64_S1Translate()). An
L1 that programmed SH0 as Inner Shareable could then take an
unsupported atomic update fault.

HPD isn't forwarded either, although at.c reads it from TCR_EL2 for an
E2H=0 guest. Was that intentional?

Cheers,
/fuad
