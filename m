Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5915E47127C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902633; cv=pass; b=Fu+DRC4NPyRd70rFh06IaNSuSc+PiJFA2ldHRdn7fHrCPyASXegh3UYdxsX/m80+/gPJU9JEP+TI9ffPlPZ+ao32nbZiVb/olNAgNCCJUXj8LvuBOdSL84wIHTcyNito6rotAU68X1EMnr0eYWoa3MABffqPJ2G9LX81zn/rrUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902633; c=relaxed/simple;
	bh=H8km6J+La0K0BkRJYFqKmLKh74NIa7uSrWdkAYb5rWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbqcO9rYaqGtPw5DS34/jCpkAmN6vz3rgppv7p7EjPj6mMbB9yJ0KXZsb6CCAYy2LPRtEFN9tXdYhghWhPROczPqjJv97QFcTFVPJ0ibwuIl0nhJto9NiEJdABEnEJVqxtdIA4IOONWV5O2PdXmQwEQgnyO+X8Ctec2sk6XsqVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxU0ZlXX; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxU0ZlXX"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666bed442so890540a91.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 14:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788902632; cv=none;
        d=google.com; s=arc-20260327;
        b=Z059mcq28Xvc/UozMdm+lblIaIDTuxZfV8PishXYFnP+v6UBMYLMOPtu8Z9TLIh5bc
         gd8BGaLr06OlzXxU3YuZ3AXU69zWxqaLQmj9xJbG1MvnpCyTwY21MVcbo35kQGKE1Vh5
         bkmacpU6cIWliLWRf5m5eWylJ1yVHCZqMhZcgjRaNKiiUTRw7jtTPazlPSirnqNhkee+
         3/W/sBL8AlddkGChggdNiebvTRNm7z3ZPYbxkBfnuPfX/Tt/cHt/f7iHZdTaHcvprR4l
         e9G8OUzixuVcS3nakRNgCkmGOWr7D1xj0xuqvXSOV9mjHnuP9meOOyZ1/83Msp9sUXf4
         EBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H8km6J+La0K0BkRJYFqKmLKh74NIa7uSrWdkAYb5rWc=;
        fh=MMZID/F9/WFgXQmoqel3Dqlpeej4ZQ/H5Phs6fC6ci0=;
        b=H4HJQ1KRmEEhPukR52aOFK5eiLaxU89K+yc87rEtRzNaaAW4Hmzf1X0gYr0+1YXFb7
         kUPsCnL7y6vGl8Z1lDgaXbXAjeoh/oic4FFKJ4PJBgnRS3+3c84VSSnyynrLC0gKojV8
         mpsM7fv6SZtCBYZae18ifQ7Ej+BujDVRVrHz91IFu17KUzFHSYQ/uHoHVO5M+NcPyXDI
         IOUpJ2pCf7btGY6RF9Hmpq2pLPw4B3GEz63hIFc/M8AvxqOLUBCAo5mrjss2iEqWzurX
         Fn9YvejvTxtsBlmpnyPOcf2WwPIzIDnAERIRye5+lyIjl+tpAF0bZV8QlplYKckV7Leo
         rx+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788902632; x=1789507432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H8km6J+La0K0BkRJYFqKmLKh74NIa7uSrWdkAYb5rWc=;
        b=ZxU0ZlXXjWJx1SfpuPholGyclksOIOdBi4ZhTLJ4wF4vmaB+/hHUx19zZtpavvwn/u
         DYXz1KTFO0oA+kXlUADY96JCXquFxX8Ci50sIsz/2KwZplhbrZQSH8o5CbzGZ3VPEvhM
         BoLGlW+dnHO/xUTTjDHdnPIbQtU6svube/rpGC5ICB8PsnfXK/kuXe/x87uiVcBrcpi3
         WmKdZutD2rHr2GXmZsbYB6KY7p8nmT36ljycRxbqnEP4ERysbokTHNYF+dJ29e2dGZKp
         pP+w+tmU5d0+lV+beuvDbu2qTmhONpmFq1FB/0kEnyaywk7c7mIIFSiwi58T91hDvbF9
         Jrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902632; x=1789507432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H8km6J+La0K0BkRJYFqKmLKh74NIa7uSrWdkAYb5rWc=;
        b=FOncXHPFGOXSX1XlfERIurACwhGGjjhkyioaEtlgaKbgmkM9izBE6NpwBD2NGSUweE
         IRYh18wthKT0H5JqyUluKLqIAZ3hEGEz+B+vMkr6G2ldoI/7px9KPsANd877PtUwgV2M
         4IrxP2g6/CCqaWuIuqcg+6xzoNV8ff8xKmdeMP5zG+CkMbdiVA2Ukm680y8WDoxK6EdF
         apeA9tKO8xLXFoParxIHsgj3eR+tD7G6/134uvox2seS22GIoX7O7SE2gliqeOa4/tU1
         W74qUBJ1u/OfxoiwbNZxEANx9EKRtY0TlQ9Mltj12t+cZaQYFlfrZDAD26KYJMAvKvfM
         mgUg==
X-Forwarded-Encrypted: i=1; AKwUvByEnqKKY/MhNoRLRkyFFhjwMo8SfhvCjjF+mnJYekk8JyP+gvx2U8g81MiCGanT2nOY73YggeU=@vger.kernel.org
X-Gm-Message-State: AFuF++kkS1w39rMuB4J0SLlPK7PPVQAVJKuoQc+OCaf9hjZl3VidebXG
	aLWzSq031ZTIrBDIsZuHoSb4sk0dmQFPlnPZKM79WVmfqOenG2g646aloekcedQw0hWz6X7Y0vV
	sl/A+vD5o9fKNDCENAwrCKa/rEoSh+UM=
X-Gm-Gg: AYBFou1ujcxGkNjKN/uPtIxIq0jqxgMSFD4K+CSQBlpM8XCFLqEbT6zM/L86w9Is+VY
	8WcYscdST3H4xK++JLBY+8IDe+BpspbbIEODTa6rc3nhkme4I8ZEn1cL4a/LCjA3J8bYmNl3hRp
	Gu2X7jfGd8y2qgYPOYhfxGBehMyZyVqk3LNunNVWOSPCqeVhrZJUxECnjeD7IfblRoGOnvv+OOU
	EY4H4rmVyLizsInteldz/gMVJT6HujmutATD89Auf7Gu4gMPwtW4bZOX62Zwr4DRHCCcL/Wpo7Q
	GpzAQNc6kn8k2oSy38MVBJy3PCOA9dpbfaF0HS1O+aJCEPMoachhCsEdXY19zwPF0arEd8L1ZjD
	LH9zm+cOnzIzfsllg5s/kJBvYw/7+rU51e59312KIGLxHaWbXs6L9hUqZa9VbJtuHJDM6HB3Rl/
	/DmRtSbGxlD1xsdPY3r8MXbmhsPV8FwBJ/jxm/bnjz
X-Received: by 2002:a17:90a:d64f:b0:390:af7c:fe5e with SMTP id
 98e67ed59e1d1-39b26741434mr30003398a91.2.1788902631620; Tue, 08 Sep 2026
 14:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908170539.345207-1-ojeda@kernel.org> <DLA8FDX8R5V0.7L5PQVACRZ75@garyguo.net>
In-Reply-To: <DLA8FDX8R5V0.7L5PQVACRZ75@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Sep 2026 23:23:38 +0200
X-Gm-Features: AcwNN1X4bcqwQ0MJOPRu5vcewCnbUR4xNtVMmUXXz_IpufoE2vKr7IUf6UlsnAk
Message-ID: <CANiq72kOPyQxPEpRCpTGA77uu9qqZhDB+Xmsw7zgk0egrTD-mA@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `unknown_lints` in generated bindings for
 Rust < 1.88
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org, =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:54=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I think we can drop the cfg on the `allow(unnecessary_transmutes)`.

Yeah, you are right. Perhaps it could have been temporary with a quick
0.73.3, but Emilio replied already.

Cheers,
Miguel
