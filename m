Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7D52CCC5
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990165; cv=pass; b=uDoj8HhummDoYyQKYMW7SBhk1jdSvFGGePGuPyCrtfY/krz4AMLtwpy6XlWagCt5I9+CWPGG6B/x96yFzmkS+aU7nnMosiP/yBv+P6HyJTrzXBCoDneH5eLWVgcj5UyKn28lUDN1mZogLDInwECoQjUDRylNuERL9EJGHG27Sms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990165; c=relaxed/simple;
	bh=peUQ9Y2a5XEmnKO7ViaOJtAdf4c17RcSOD9PNqTPBgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgQ4tjJzu+j7k0ZvxBWCAo6bY3loU0KLowdMuhA6pBFZGWBflpbI2jVPLNh+rmO7izn69BN0HnJwq763+YWTcDcxZhYnarr8DtGxNLn9qkXsWAs6Ri6SFTitflRkuBS7YomCHio8WlT0vki/FLEtGgf/JZq9NcZEe7hooOWGJMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMB+WnaT; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMB+WnaT"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so43604a12.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791990162; cv=none;
        d=google.com; s=arc-20260327;
        b=S6vW7eQCaWJNxkY/DLeNTUI4HmKhH23Paxk0y2BjXKkbUAic7ZZ0ILW+3uJPldOKiZ
         yV+W8HxikMwfRsmp0YsTv8IAqvkvn/a0LCaLd85lvtUmrMyiKONJ4SqZWDOw+s2lwJfl
         hpZ3SNHockpmrY0entltxhzF/bFUehLaxvWY2mifHC/S54Yv/Bf5tvpjI0ryrIcyzq8C
         j9DYOwb4QQ+1LHAWetH7FL7ghuvH+fYvYwAhcjGjVKhebtM7jZQ1Ov0lPSknIhFGfnz0
         +eo8XqWBnF8ukYNiLAQ0m24vdmCQ+gwdX1mirp1oegMIHlPG3As8PNtE3vzUp1390nH5
         TraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=peUQ9Y2a5XEmnKO7ViaOJtAdf4c17RcSOD9PNqTPBgI=;
        fh=EKls3SsfpGp6Hzo/5oTARhn58mYegU3cmBCF6UfbSxo=;
        b=fCPW+Bp0hFeRFB+cdDRrG9TNI62SlUcfeEtaUqoqDNd+dfqp2PE6wF3hKiWyZ05cbO
         w7SISOQyfAfZIi156kPxT9adbwetF1RvEidPbTTYUQnNTxZFmSWIdDocUJ48fuLcW4Fz
         lndoks8Wz7CvAe/CBP4dDlNjggLUw0Le9B4EwfNNnKp9cTYc9ZMTIyn5I/uHQLZs4qWG
         pjoORkIlhggRd5T2rWiMuYSvvM/vemIGIww3XelxKe7zXK217pbPPiNr5kJxQ53yOorX
         K0i0M4TiXB5kahwCcUtbd836jCOIyGzvU9F9zM6ZaNulTZEKkQ4f1d50lHqE07NAaZkL
         UG9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791990162; x=1792594962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=peUQ9Y2a5XEmnKO7ViaOJtAdf4c17RcSOD9PNqTPBgI=;
        b=nMB+WnaTXoFFghnw3y+ZLz2ymntwqyozoB1+GuCz13Sd4tNMIktmzoMTniQuYBCuYQ
         9nK5h+c4kzs6KTpDtMSj/R6zsSRvwaWIfHXJl3RnMCqmWDeGXRzWsTCzhgeyAOV1mdp/
         g7RA3KXwg0f6yq72zmR+8dNw3PdiSzxVoaO0CVufThA8X55e2uK7Ey5BRAG+nBUg8i/E
         nz/Z2IiGZrQCFs9boJ8jMKBH2Whqpf/iZMCEreB+00AvfJhpiu+iNejxaEpr5mWJDWxc
         0vvzZTVEETfE2Z1j6ekgqD+Jy09+t2y6LJJCg9C0jkWaR/i7cCYkTNM5f101sQqMUfkw
         UNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791990162; x=1792594962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=peUQ9Y2a5XEmnKO7ViaOJtAdf4c17RcSOD9PNqTPBgI=;
        b=l5OIRtNlsMknxHGT9rMKQerBnArV24sHZ2C5XS9DlxhM54KbMGAAJ/TqesZCvTVA6s
         KuG5NAQyGa0J4N9EAuxkqgAzN92Tg2tfhnsqu8XssC8kqoyRaIP+WA5KqxZWCoOmaK7u
         sRdebFEsqm8PcMAbYPMjDEmPU1phWKL/+xhVA4HGNOeKkHPm0wpb8dBXa0MPW29irRA9
         TNDb0HPxNXl6FpbA9tlnADTc6Kd8KhcY+l6BbZArwfVQtsVlmEHT3D8nT4vorgMNLM+a
         YtqDvhKxy2Z04TePZ06Xiy/qxyG74nJ3sMz4d2iGRkNHYpXAZvtN11FG7JL/xrQUa/PD
         1zmQ==
X-Forwarded-Encrypted: i=1; AKwUvByqechKihOWgmUMZY8qOWaav0EvQC/kmlhB5qzQ1tWtunjfXrp58hHX/xgRWWQV5auTDF+5Xdw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKj5+7EHIP19FaE1ispgGZKdUGc+jbSweYX8siV5MGmtkpcPkef
	xEORLAPYPRFRja/KqgtW2WPB3x5yReIjEhaBSXWeUJJzEDppOq227m3QePXhSx9flkOX3Ey+fDC
	Apy9wOjmGdLMew839O9q2fMqAWqdz+rr2jxvMhL6A
X-Gm-Gg: AYBFou238RjbqPk5nBjaKQeY9OmV4OJh5biAHDtCCLALui7tszfycdKc61qq65+muaj
	uxTpoa8yKuKtEBuI31VQU56M4vP6aBKPFL+9BnkiFn+YSc1YGanPxravN/FpFA9SIg4s6wpTuFd
	Kwz1dzajdRIDUH5eFsT5Y8sszlhmT76xDOEbO0xQ3yjDuFdbSdMjDq0EgzBqB9CDPU+oyIfZnm/
	2SQipqYFhyjIC1HuX6+DwqzUjMvKF2ybHDBTM9yRzQGyhQ8YCaS9i8cgzXww6dxJ/wbd65XWgvx
	ChG2YDyTcEE4peMIZkw/FpK9gVXBkipIlGRPIw6DBD++u0XVky6sTig=
X-Received: by 2002:aa7:d407:0:b0:6b1:b607:a5db with SMTP id
 4fb4d7f45d1cf-6b20976e77emr47828a12.3.1791990160901; Wed, 14 Oct 2026
 08:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-2-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-2-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 08:02:28 -0700
X-Gm-Features: AclHuK_yhR3qanMwsfhsd_KJEDCodUKEAzljmDfv-F-Yz96nQUzINa-EzATGdNc
Message-ID: <CALMp9eSoidVrzHqTrq09LB1SCwsf5DuwAcys_q7o0TyrKM1Ciw@mail.gmail.com>
Subject: Re: [PATCH v3 01/27] KVM: nSVM: Flush the TLB after forcefully
 leaving nested
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> KVM flushes the TLB on nested VM-Enter and nested VM-Exit, but not when
> forcefully leaving nested. In this case, L2 TLB entries can leak into
> L1. Flush the TLB after forcefully exiting L2, similar to nested
> VM-Exits.
>
> Note that vmx_leave_nested() handles this correctly, as it reuses
> nested_vmx_vmexit(), which handles the necessary TLB flushes on an L2 ->
> L1 transition.

Fixes: ???
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
