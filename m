Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E333469C
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295457; cv=pass; b=q2EUsLEz1OwUH3SMoInTxS6xaKFEeYLb423QwY+XU8R+Xz3NAbtM/4fI4jFFFj2bqL3Bnfs98tYBGHxs9PS/MLA53ySYPJHjbipaEbsGIf6005ShVdayYKBYjk0hyvtN6ko3d1tvKJ2cBRONScPVT82QCdK64ghAYis6dlYxEuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295457; c=relaxed/simple;
	bh=R1yhEG4MKoXjJ4bO08OeDXprdSO1fiP+peqcjquLtrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JH5yZTCFDeeMU1VhdGP+0hz7gLYD/aW/vGk08Q5dNRNjduhYVoEpH5OWYCgTbrfFdpKPJKZo96UgMFWYWV4jopanToSPVSu3gK0g7lPY9dveyKU6GxJdGik5Nl2H2OIQga/F31VpoP2eR84Bg4YsSpIJBteBnEmBYcVr9ENeKtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TewebJpN; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TewebJpN"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-306f1213aadso56434eec.1
        for <stable@vger.kernel.org>; Sun, 31 May 2026 23:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780295456; cv=none;
        d=google.com; s=arc-20240605;
        b=hT0aaNrHHnrI5CownqvFkwPaxgvisEFJ5zaovaOAsTPeBHQzqnzOTozAj5r6ba6WkL
         Sk8He36eNNJaxH1QNLnvBECm61pK8Vw4CJP3okDJMvZoEygzIGbHXt72B4+dnLlqTWg4
         SQlwy1P4omIg/2JSlCiDasdxYv3XILF74wV8/zliH+GQRiCOZdGbzadSbEdtZDR4M8E3
         ajLwW97u5+WESPLiDZyrGwnlU8xYvbhO5fL31bWPGLaCf57qV2F9gigJnA574hLQA2/u
         SGdM3ekmEowkixiyQW07Z9c309g2V51zEjG8re32KexALsY7eipEAmtKF9VFmDNDt4q+
         8Qfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R1yhEG4MKoXjJ4bO08OeDXprdSO1fiP+peqcjquLtrs=;
        fh=r9bert3WXkPq7rdqgwNo5t5goYV2bqnNcl5OhqfmSIQ=;
        b=DDuVdn2jNfApz18L1aS6RoBL/MjvM2XjwHLvn9e8wlSEpR2+9ReqVNe1XYVj6yOG6W
         LfqTrHXph4ppJacHafsy8vRn4fVTFBPQVl14tVemP03IlHuXlUmHSTxUa9EoHePlzdpH
         v8tSGcIFdqFRmG8aLU07/uriiY1m31PGmoZxrLF8x+SChmrGOZRVrZXZ2wcls6K6/INe
         XiTytv6r6vxWCwVDfQykIuRvzoAC9pqZ9mValtaFk7w0OACY7/U2rRVCxWtPzaQyGifm
         fTYiAID+UDZLofZWVVpCzQBmKFgjo2cGgq1m7ZBHp2/rN00DkD/9e2DY8l0etQXEOATX
         vQCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780295456; x=1780900256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1yhEG4MKoXjJ4bO08OeDXprdSO1fiP+peqcjquLtrs=;
        b=TewebJpNtT6qAjTZUa+Mh16aWsN8/d/7b3VddeBekOT6dBZYswciaPWb0aQ5iZJCyf
         4baxLX5lRuW6PXHqZZteTZ4MYFyYmFHYxQewdtTUz0v6WZe3N4Y+Za52bSSBYcc8atW9
         XqKFeoRGNJHG8Z4l78aOK92iCqV0zMYn/DaIbVIczgsCXnLa9EXoQqUE1K0KAayO697+
         fWAO2owf/6pFEgo7Fv+hfs2mlEcNf0eDEfJkButpuEu1KNF/HKxVaCbj6K9LEtkgD7ar
         O1mwUp/kcuahZ4f4CWbhwGwTuoIGoyMUlvE3tQcl7QlXFW+kk/wP4hWDB4lNux2EAOpj
         PRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780295456; x=1780900256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R1yhEG4MKoXjJ4bO08OeDXprdSO1fiP+peqcjquLtrs=;
        b=eQam7NnMNdHZ9cX2Db4/x1LgX+3pGp0VFLu1gGPYsiQnEQL2N8Im0eayYD86dfqOib
         g1EOtDM2VQIloPL6LoF27yVV6PNU0fQ6dmJiIV6w5gnKkBsiQ6mH/OBhbeNICP6IhueN
         +VK8LnCzkVt+5i2BQ4A9xrmapfwLj245ehGbbnJUYtbCe+4WHde7Mqvez7zzi66CU/Tx
         DOnH8wWqwRw+FBjTJdKNxcZZugDZiE3TGRHcCP0Wt9bpFJ/way/bR7VqvECnPCrHgWRB
         r2a60uJ/eMMt0Ll96MXk+A2FySLWJSTJa65PNHRVQwBzWyBVPw1DHAOD5VQQkUNTOYUw
         DSQA==
X-Forwarded-Encrypted: i=1; AFNElJ+efO3zj6NOUlXWhJ6x4s6IClmP19Tthbhnt7bcq8AjoCVT5pUG5HpOKed/vw1jk5nJcw93JIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ml0GghQRxaK5qGA82gPtvwvPkXevocoBjKsIEzu/l7hHKw+I
	ZPeShjEh978EF0fasH6NYp6WlyfRBCq0nVHjCBdhZRPCeGfTcqfdN8DxWvcOQjFNQ5hMMa6akwy
	dOBdzUj51x/4t/ZJAOYqlXsm15Ozz6jQ=
X-Gm-Gg: Acq92OEtqTK8COUyZieYLxg0EvMOhaeD4u7cLEqWpIQO3Bk9OCSOmkxkyMABWpNhjQH
	xt2pTgJEb2SnnJ+y4ENgEsfY3+fCCd3mQCaVn3+9JMSG9sCopOiICtrk0t3Q0f71LCSNlgyw0jX
	2JCA8NPKoZ8cJIEJsMDcv8l/L1UeL9CNnHcCaCQPTL58YQYBvtwcJNRPjPs4nLidIT0g2wZFzwC
	xkl+bUYnqh4RzzMGSnBma0kraGC0WMgIY4nNV3nqUyynzZ02hv8qD8satHE6tGkZeK3P7iekFUu
	cMnpL4qnC1qhCTOdAYASkMidaBYmfVZXad7FFnqqXEbhUfeHR8o+sFtmkBVnpYOe+Cz2puox2Om
	pCcyGGwwIUvuM9MKahZ1luuYeUAR/lWhOcA==
X-Received: by 2002:a05:7300:ec08:b0:304:2af3:5fef with SMTP id
 5a478bee46e88-304fa70effbmr2039142eec.8.1780295455709; Sun, 31 May 2026
 23:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530095809.213611-1-ojeda@kernel.org>
In-Reply-To: <20260530095809.213611-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Jun 2026 08:30:41 +0200
X-Gm-Features: AVHnY4L74PI_Op0lO-oFiwBsbA3m9WuT43J5CDI-t5H375DzSgGheCIUTH6PY5Y
Message-ID: <CANiq72miRU9Qz1+ehyNa26LaG4LbT1XcHgKoODRhoHBxxDdHXw@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: clean new `clippy::map_or_identity` lint
 for Rust 1.98.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 11:58=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).

Adjusted to "6.18.y and later", since `cpufreq` was not there in 6.12.y any=
way.

(I didn't use Fixes: because it isn't really a fix, although as usual
it depends on how one thinks about those...)

Cheers,
Miguel
