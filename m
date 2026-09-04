Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE943DDB11
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508443; cv=pass; b=EFea2cfrPUXxG3ilCFjKSYHzJ2bjkOfO+V/OR2BiFAP+cWbP4dd7qGf1WSzOWRH+zvcSaO3jlK2o4y/IfXxjsno+vS4jyD8Z3BsxgqDJWYUDFTV0KISwRaZMpSOojFsGfTbhPpEkBav1oektdg7t1Ix1DWmwj7o4NR58oXkorEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508443; c=relaxed/simple;
	bh=wcvjg+AYhNTqXh7GWpJ5CTmwV5GIrw6stmgUibgREwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv9nQ1JhA7cOxN49gioZ3BIKyzafn3KG7nwdXtUywRVzViZYWdtw4BqXmKjWkbmlsW4v3XBTDfyhJMJ9r3MvEAMpXZRWBkcBstpSQcq79W7W3sWdP+HA8eg5CHTDPx/3iHRQ1JNBhJTXXeqO/75Jw/t6a8NRSuYbfVMxkK9YoE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5Ha0LCa; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5Ha0LCa"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0d3105cso77696e87.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 00:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788508440; cv=none;
        d=google.com; s=arc-20260327;
        b=Khxc6ZOZf4gc24uNqzBgWvyJ0WrYgBLwqi6WlKbqRmnPjTyi7DhthP/irPT7sy3wxx
         KHyYKVA7E27zUwGI5sv+8uqOyCv8ayUXL34PLNiA347hEjOZfmXB/1r/EyAwKoMIJv6N
         Aeb98bFvKXGabsBtwW6PWNWtpNlnSOcsQlQr6/DostnyTY4r0pzSeURP18iOGpGO7Bqk
         1JSAirWXPG4DKI0ToTFN9YnFW3c5Mvf6/7oJD//CkDilZ7MZsPCoCP5NVKgZpD7Rz7JP
         C0padaqTAO7VIKurS61LWt0Vl5D84ZMVZ4Js8b2ga3hs7kj2CXrdkRNvhLUNeDYG1JOV
         Cvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=owvm6o4N7RgrNbsjjtTXPv1xxL39SmJXwndV799foiA=;
        fh=vfI1A2KEFG2cW53/qz1WVieGYpNuGEycv3J46V1F/GU=;
        b=heCciJ9Xbws0kI82l5rOkJKrbiAiXe+XqDYE5IFQ862KgGgOA5dUsQMm1IQTa48bhm
         EVUutjxptu8i7epHVomyWQteRCsezu9VqJpPTNd/wkyT6ua1wDc2NHH3Co/knrvU071h
         n+MmtF4bM6s+ycUkaRdYPh/+QfKaMs3osJh5z472vnZgJhwsj/9G7jpeb/bXWDh66WPC
         nwybxS0Pa/9bAQ+KBi3axQX/SqNWcjt7VBgEPNsASnbfSsYIojgM8o3gYfYIV3Gx7Q6N
         HwjFdczXyOsijvusSDvhpvQcMR/whH42Z3cspnCIfeMpgZXbQFhEClhpM3fKl5tFydxT
         MAcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788508440; x=1789113240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=owvm6o4N7RgrNbsjjtTXPv1xxL39SmJXwndV799foiA=;
        b=O5Ha0LCaibk7BsN2nnHRyBzDMoqbeVXj5KTG3iJa5bLBX1zaE7CCw+7tqynZbCad1C
         zKk0wGe2lGm9v7jlCPvKyWM7DIbuJ1lWAfC07Q73g05JniSSHS2XEqh3addsSD/ILEK4
         e0LNEJ0jiwUU8cOl64RzGGsQni7ST0veQEpKsSbA70F+vL7l2CckfG2epzWIcVATwYjx
         8/EFEfd+k0fEhbeiqJJ/QsnK15T78IuYMNTypbfI36ymH+jULsqyiBHiDHX6qNKrHoPC
         jwc+xryBwpXHFzhXMtKiBbqmvcDQQTMvlQPnL9vTOOvVYdVZa/KILsRPvvQnAnNp/tqF
         I60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508440; x=1789113240;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owvm6o4N7RgrNbsjjtTXPv1xxL39SmJXwndV799foiA=;
        b=s9olL8Fo4ZnTEq0LqwIovpref/MmfeuYj7iFT/zqUnEzeI0iHPhaBxEOVOrODbGwdU
         zhtAUvexXKoD9WgdR3qq4iK5GBul7iF8NPsXsxo9oVqo1f5rPzB3u5a/x+kZW1F/XMN2
         +JibiaEUOJWdx6Oxs1frQN2xQkOxAgtTFL22tJsYlJjuXMUxr1ya00arXIPsOkliNLM2
         RrXEwNEzUrCxwX9CeKI1LV6ocU9TR34Zf3cWPaQ1UKp9XBpK8F+5HusM+SolpgGYIHgz
         iR0mbphDBaKcizf5QJY42MTr9tlUCedd7kYQ4NaurN8NwGqiDzo3d/msDYjkljEQmd/t
         38WQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNeRUyhqLjq8yk0zNbrtWs0K26rHtgtKMQjeeu5T7EsFRtoThJkT0dBPgkcfYkVGniW/ey27M=@vger.kernel.org
X-Gm-Message-State: AFuF++k9xd0F2JcE7W8ZIOcpsBGsB781j4tN8KUI2bhCikxzfXYfO0AU
	Z0JT3q94zPIX0O1jX9aIPB1Hp4sYmorL0TZGipQTFYsjM/DQpaOf2JwrCse8+RBh8Sm2SsUkQ3x
	GS7N5tAmiNcFlv1Swnkex4Ddo/94mZrg=
X-Gm-Gg: AYBFou3UHo2sqy8yV5nSNYDFU9S2vAevwYI9s792LIJCZU3e+Xmyj1Hhr42CicT1xt0
	JRXU/UBpknsbSqNnJRxYm+LwvKb90wTA8udsj2cQN1N3AbLuYXFKdGWOk9mw6xq5QVkgBtsVfa7
	gk5e8DT17VeKGRjxNBPxvccFhMtjRRf9HmpUj7phD4pTe3Cd07Yp7BB6A3hgPr7NY8G6Wzgybwt
	j0Qysfgx8aS8GnI24R3vyEcs1z5yQIwCXEnQtA6PjdvETp+53Ezfulvla5S9EGghuFXQ8Isupg1
	wRDd6LVxldDM7dPeKxfCPE0ghQD70Suck64OHth+k/o83NTZZvPLZrrrrS2RPx7wiiicTr2wGV8
	OSlclVAROR117zrIu5/TyXsi0ia+vXhh47vuqdgusJalH1LAeMobRuFmckXPWnLgOmlsM5tc=
X-Received: by 2002:a05:6512:4027:b0:5b6:4b2:c408 with SMTP id
 2adb3069b0e04-5b61707fca1mr702903e87.6.1788508439773; Fri, 04 Sep 2026
 00:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902150353.23666-1-ojeda@kernel.org>
In-Reply-To: <20260902150353.23666-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Sep 2026 09:53:39 +0200
X-Gm-Features: AcwNN1VBz_mYbTOURWZnSU-eJEinL5edJeBG0q2HqJ5Fc-4KupKLS4ugizaXgSI
Message-ID: <CANiq72knf0aMUjLzmDFf96RV5yE9PjQSgVQgeUX1LQ8SsU5_Dw@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: add intrinsics to fix Rust 1.100.0 builds
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:04=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> I sent a PR to upstream Rust to make the methods simply `#[inline]`
> instead, and it seems like it will be merged, so we can most likely
> skip this workaround:
>
>   https://github.com/rust-lang/rust/pull/162191

The PR has been merged for Rust 1.100.0, so no patch needed.

Cheers,
Miguel
