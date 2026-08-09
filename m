Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26160187346
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786244485; cv=pass; b=JZeF+4Dl9BykSg+yilB+r7RcgLOSocTVdDBaSXLCc7uWiJiRjMNOfk8500kYG5zZzJbS/2TiXSWTHdh+Jc07ctyZNJoFrqV0sdxxbIjGxemNqihN1tOuws8gN5Gh8j0ps9JSssm5fluH3Urv2aq86o2anX3IRl6b169jLR3W0Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786244485; c=relaxed/simple;
	bh=QssombK2y2bxkLpbfBWs6fhMLQY5cUQH/zTynZfaBI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOVktUa0yoTx8pLEi/H+CQxOEuVRsiM+2bJUEa0o0lj83EyMNEY3PA6G/9/StbLttQrjol8KgARI+MM+T5EGZ7VOquCqBIcAbdvykF4ES3Tpez+KI1zcaPn0j/qoHQu0rB1Rm54TeAFKpyRKf4vK+UkYwOLb3/vOyPdtlkTiC2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHe1k+A+; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHe1k+A+"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9d290216d0so52943a12.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 20:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786244483; cv=none;
        d=google.com; s=arc-20260327;
        b=cnjwL77krQ1BZ//roQXFPzSaI80ttyHh/qBa1CSjye3oX8QWXJ1pqCCYde+6chkZnF
         aWZWVrN2tM62dm8BqfWNRU94OdzLx3f7IMYI1Gols2tBi6rhz0f9+4huL56wBXobJrUE
         n3G16nHKyK8DKE838znDzjbqgerYNFrowva3XfM0Ud6IwTuZlspI7iIQqW0RI74qX1bD
         yFuAnU2pRoVr+pz9D8Iehy8Ik+wCxKEfABhXBBduLVO5UGsmuWIIv0phFSzhYFOeVPjn
         gNKWTSTrj9kdD2DZmKDhe0ifmXkJjFA7JS/HT2N40hePHSIMCMsyQxAqIqtF4Nj+iEDM
         OAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QssombK2y2bxkLpbfBWs6fhMLQY5cUQH/zTynZfaBI4=;
        fh=mMBVRHComN+3pGukwfdtykRlV0fJ9Xxv57e8OtsOPrI=;
        b=hs5SokhJMOdRSO7tb8z520ljjiUjmygzepLD/ezZjjYItT+TyIHhSjpYN7HvnAUCeA
         xGaaQktM28UOgEfINFDI1aspjdmUGmpgOA/3Myame9hquXLTz+kwKUa2i24G73+fF8KE
         ILj/ujp7daDdCI1/7oD0d6SfjZmSUWQGEVLd3uai/ftXx9NE3/yoWE+WdTfM8wSKBs56
         F6DhDQ+Ki3y5aAoKrL/1jQbDcLbxaOGEPMrxEElDWk0wa91RSGwY7VOKk4ovy20r/6/S
         f9vbh14E2otKQ8S9g+pRVciXbfrVsJZeJBjOLKLCadPp2SsYw07kLoWsqtIPih2Cxwyh
         VlMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786244483; x=1786849283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QssombK2y2bxkLpbfBWs6fhMLQY5cUQH/zTynZfaBI4=;
        b=XHe1k+A+ofr/m2xBkHUba1sSOt/SKTDPyye8l0XWCLJwKhfcMjUoaWhc22TZNZQW5F
         qmroRaJQ5Sjdcp6TaB1xyRtJqhtUEvkD1u18mcseqsCPlL36fosipukEf1n/JoHnZqLN
         xsIZqpGO1pNqAAN92ET6ybqD8rBAqGivBtEBRe5refWahrYWAZQik0ItgmpqQzMGV6Bc
         jv8+L2BII6w1NMAjBYEVfs6ZamojnVPgzai76p3cSO415Bm++05fhFjivTITm76qjC/y
         iyNieZdEE3mwwsvUNX/7O3jEg+5w+rFPCfYsULrbqLOuvsifYTborhMmG/nTU0eOdEhK
         aZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786244483; x=1786849283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QssombK2y2bxkLpbfBWs6fhMLQY5cUQH/zTynZfaBI4=;
        b=DdZkVu1tFBNqFifaaOJLb3Wf6u623fm+faijwBVkBoWkmpx2xMJlzS8CRKba62578A
         PHuwVVyNoXHlSiiAAwdIzGJff6t5MnrwnEv6/7ixv0W67m5k1NSD5wR0MI+ddrljKREB
         WH7KPEJ6c8GywYrectMQ8zTL92oqLT/P7zM/K0BUFSSgBrvFXIZgdG2sNZnqWtMDHjGi
         E+buY0LCfZigY00NGcMaaMfgd2XrGz/U2gv47/jBIC/Qo+Xfwm3l7jtdSEHOejFmxpLF
         szyCJq5CxLHPE4VszzNOLm5JOXsHF2NDJm9Bmuz3GyuCqwzHXfanJN33Uz/AfNpTT1Ci
         5tjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZy3VaSAaRFTuihc+QyZQoAR5q6wpeasza94aIE7qFB1splVXzxs11m60GNmKgs2a30Gi6Pb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzldznttWxK1z0IlgWAejT6C4AcFt6eFff0xN9FiGnXqWtjV8Pf
	SPpLkKb1Z5D0dqs5xyAccVi9raFTarPkxLEPJ5jyui/wKXivqHmrDDUp8QqdT+6SRnFd+qE/w6Q
	JSZCJp2ob72MZ2ZC9CkmSuM2pyblHyxo=
X-Gm-Gg: AR+sD12uGUdb8oAmU4P/U1/AiL5mLLJY9R4yjnrzCI1y+7uTBpNdfwP1pfzCumVOFRf
	QRTb9eJOKouVTXeyV/5i3sdAKlTDZISNcl5W8bFvf1AH0wRJ12BpAUsQXiqKvBSGRx4Nco3yjLQ
	YBL4qjoJLAKKxLoMWeUqabfYvmGbvaUGaLBoCH+8Jfnl2iGCVUwz4qcChbfiDho1ZkbqTsDSzFX
	hDG5H+CCIGR4b5R4eb7i1p7Ap69iIEwz0Q/Pft9PoJ9/yQ1NgOr16VFuQmLSIPFQO6Vn2M/L/9K
	sIuLbkdfdysZoyOGMdrbsy6gOeKI6ojpCn+cXkYL22jLiPbcTFDzUI6nVRmuz+XdupBOuhTXuPy
	KgN4QTu+6HuHw6s82fYoq0xZW+kSyek36LGWKkPDa3CQAdfshDbK++l8UK2Qh
X-Received: by 2002:a17:903:17cd:b0:2cf:ca85:57e2 with SMTP id
 d9443c01a7336-2d0ca7b0285mr257513645ad.1.1786244483476; Sat, 08 Aug 2026
 20:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72n4=fz=JNKY0Jdm8BnLa=RmHB2B7s0bO47YTJ7hygqBZg@mail.gmail.com>
 <20260808.143013.1251068388254615351.tomo@flapping.org> <CANiq72m70uWCRFnhs3axdymSTGCirBrYAvKh2BiT0xqW2j_3jg@mail.gmail.com>
 <20260809.095041.602618436881623934.tomo@flapping.org>
In-Reply-To: <20260809.095041.602618436881623934.tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Aug 2026 05:01:09 +0200
X-Gm-Features: AUfX_mxOkJgVjfpd9Xjn2_lEgaaMyCa2CI5K0zvJDPjtb_T8ut0EX3_Stxulh1A
Message-ID: <CANiq72nxE05HEyNmxGj2gYHaYL95eQQVF9SAuhDdHX0RDW1i2w@mail.gmail.com>
Subject: Re: [PATCH] rust: bug: fix `dead_code` warning in `warn_on!`
To: FUJITA Tomonori <tomo@flapping.org>
Cc: ojeda@kernel.org, arnd@arndb.de, krzk@kernel.org, 
	alexandre.belloni@bootlin.com, linusw@kernel.org, chenhuacai@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, fustini@kernel.org, 
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, kernel@xen0n.name, 
	loongarch@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 2:50=E2=80=AFAM FUJITA Tomonori <tomo@flapping.org> =
wrote:
>
> Then `jump_label.rs` needs the same treatment?
>
> `arch_static_branch!` embeds the generated arch asm too. It is not a
> problem today only because, like `warn_on!` until now, it has no user
> inside the `kernel` crate itself.

Yeah, I think we should do it to avoid surprises later.

Good eyes!

Cheers,
Miguel
