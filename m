Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CA345ED4
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375512; cv=pass; b=mU0U55SctWBZAO4hxvG0OkVV9MKmXGzExODAcmb9u0yoi6lZZR4boesW96rtRbihxjdoaYZw2Bj16jWhOoO4SJbzf8EIh8AVq0W+b6pktVS4+eO73cnpIWPVYFscFrFNosMgV4us9Hcx0joxIGqWHGvJN3NInvF8Qat9spxxCtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375512; c=relaxed/simple;
	bh=8zBDICRMPnt8GFs11qbylQhJCwpuqapD/b0ZEoHAKso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HS7Qd8CVunY35ux7IErZP8R2EPd0+2MsVmPn2G9EovG67MYom7TRoKurijEOLJR7HUc1XiE7gJcx1ooEBrfJdQYR0BOb5Xh/IYwM++YR0AKwQJHYX+3pR3evkiyl7h7yV3YcpZ31zElWp9BTzRLHDdPwwi6kuvAeszC9sV7YU8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm0FcOwI; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm0FcOwI"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca6a6181273so65034a12.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 08:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786375510; cv=none;
        d=google.com; s=arc-20260327;
        b=RV79q/bYzaA+JPHq+V0SgQ+/X5aqUSAkjs2MnZIrNhW8139dvZPPTRhAoZYM45Fkmq
         lVzCupOZJYmewesVbOj4/MJKRzciP+PSPtxZbu8KBbMxiCLvNr5zlOMDS74L1ViQLU2X
         yX2MqSn8bbEj5uyZDypZoA212P21+Z4oBtpbXQhWrFSvplHeRpuHInUfyLQNcY0WcTMT
         bf7sf8CMOqLZCdbdPyHIfI5MQtltGUvCkGvt4NKqwlOowVZ5wsyRgthGpnvbOO0tgPIm
         A5d0dg/K5o1MNoU0QBE92lmVUwilfuWoUmm43Jvt9qM0c6hQD/5TlQZf527Vr4zHHDvi
         d9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8zBDICRMPnt8GFs11qbylQhJCwpuqapD/b0ZEoHAKso=;
        fh=Kuto03Wjh7aeVqwIIxGtpx0Fv9vgycRoFFoGxnxamsk=;
        b=gIhRzzjZKJcayHc53nTdDICjGWhh973oAD/x2SPjGSNkz4iaviZ/yWVrbIafLoAK5E
         ixf2bnevMSA5uKUK75cusfsA4/hNDEltxE+lIiFix2TDYSoXmH4NuyCzYpGFXkzpWoOY
         a4pmKlk9DgCerNobrx1GPJYY80A1pkmY09yQWJb/VGNPSMewWcb360Zd1oO7nDJIPKAX
         P3XI0zdIivug+PIi4sAaJwQu0wTeGnRO70CbVos704WxTautk/Wqs1t7r0L6OmkSLpfq
         T5mzMx0dBGje+GQQHIQk+S6VkL1DpgM2CYaW065pPCsf0xEYuja8wrm4BP6g20hSG0KR
         CkrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786375510; x=1786980310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zBDICRMPnt8GFs11qbylQhJCwpuqapD/b0ZEoHAKso=;
        b=Dm0FcOwIvyVJGQ3AV8gsVIT0e4cg3u9bAdXpG9nJAfPz/HMbQlyIp9EgcL/wp3l3l4
         Fe3XAs21xiO0WpQZdkBnSxb0XllPOUsxgqiCl7IjZoFoRRvVvlT+64EDVfouhvytVLZf
         joXsLGsadMtdOPl3tkqQaQ5Bh0xRtXoIUrUeTiwFjHKL5SgV85qJHkhI5biFZvSm7kR+
         XNpBt6OVj2XnSaNMsA2Zwf30JtEqGQ+uWAabJ+76IpkFiSsvOnakdOgeBr6JfcKbi/ic
         Su+AozVNGEK1ZC0Wcu7VO0rQI6V9ZUqg9OD3B73VbC+SVQXBym9h1EQNtlQ0M6Zm0k25
         PoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375510; x=1786980310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zBDICRMPnt8GFs11qbylQhJCwpuqapD/b0ZEoHAKso=;
        b=O/pFsUO00TKJ6RC02vHAym+Nyk8PLLkkKTWCtUJA3XX/zFEACQ1S9W8lBWPTogfRGH
         BDdWfaZPoc9QdTlSCCkl8H4EBrkYWLzr7MEz1K/Wf8Q523WjnND+YFiZ6NlEdRzV0v0x
         ER9Di3bzNTedkxObJZI2YiYLdGh/rXPFSHhd8HdL4XxHHU/aXKhfMdJdyy0u+oSFMenW
         XNBTzok7tc8wvQDwIpG6gThBx724AGCRo8u7XlS98BcIRHnKdiNb5gAkGFPmeO7nvtsu
         8R5tiSOrco6gaRpv3X67MML/MAyrwizbCHvgt7ZT76O4jsG30xEUHX95OqR5T12t/aPk
         PzMw==
X-Forwarded-Encrypted: i=1; AHgh+RrlIAptiqNiQSiufl5dhbhzRwvpLbrrpYXIoh6RTgpWnl0XO5AErJgcHUeZ2A7N2m/mtTnWa8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeMEi/kaAFn8gFnK+FIAcrcfygEWYFbNxU/Th2ILQa+J6obHu9
	RE2SyQnL4zlgncQRbSsq6SaF08v187bX4qNg1MQbsOr4BTCsgYpiu5OTnQldK2gb+VyG6bbWOPX
	GjwBiuCW5f0UGvjeJuem1rP7GX7ioIA8=
X-Gm-Gg: AR+sD115SufdLSRvdHmoKC4MINUMrfcAAH93or5LWfoTJSETGCI2PZXjM0bjqZRb4e5
	7gimTUS7eGGQRPSlthiQIM39k9Jol9ZOedMGao9vyVBT+j50AOt7fSKJ4oJzNYEmDXn1T8kq6Hu
	qwjHC6ZmdJQzOnuB4g27dHmr+B3BRa+MMGKnIP7qkrt4YhoNHerSohSRtG5HCYzR2asX1yl8MlF
	/30M52zbWSx1nnWlARrzZREaazcCcbuWyhlYIyL7BuwAIUgh/89yRlRKxh4LeXMehzEo6xhni7U
	0OsZ7CwZRgLASgURh2KhW0DHn2IhTiXQ2fybMMK4VbSZ25AqXyqXdbC8dO1ZDBhqeMhVlY4gzls
	i7/ZmlPOGGYq/Z2QjWxuyVxGJ6gYVYpkm08vrJZBvXDo0hrmmMHb9dPGssHrx
X-Received: by 2002:a17:903:1b2b:b0:2ca:ecf6:9115 with SMTP id
 d9443c01a7336-2d0caa9bb8bmr359062935ad.2.1786375509674; Mon, 10 Aug 2026
 08:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807151715.7247-1-chang.seok.bae@intel.com>
 <CANiq72=bEB5-GvvroXigiCVtHjGtkhs1ARkk+mDbvjNAR4XKVQ@mail.gmail.com> <b00de567-f828-4ad8-a6ab-6ab1c47de68e@intel.com>
In-Reply-To: <b00de567-f828-4ad8-a6ab-6ab1c47de68e@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Aug 2026 17:24:55 +0200
X-Gm-Features: AUfX_mzWnk5jh2TEzlCLZWc2-FcFxFmP0_qT12wwYg5gXrjgdQImcClko_cEbXA
Message-ID: <CANiq72kT7KozY5yXyCFpN7-7rc1Rbw1cLPs-c5AFuKYVu2f4KA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/build/64: Prevent native builds from generating
 APX instructions
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	rust-for-linux@vger.kernel.org, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, ojeda@kernel.org, 
	nathan@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, 
	work@onurozkan.dev, Omar Avelar <omar.avelar@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 5:21=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel.c=
om> wrote:
>
> Yes, I intended =E2=80=9Cthe commit=E2=80=9D to refer to the one in the F=
ixes: tag. To
> make it explicit, I can add the commit back here:

> I=E2=80=99ll add the link to reference the status of the Rust support. Th=
anks.

> Yes, I have included it.

Thanks! With those:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

I guess this would go through the x86 tree? Otherwise, please let me know.

Cheers,
Miguel
