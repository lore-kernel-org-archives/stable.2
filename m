Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9043466AE5
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730867; cv=none; b=Fxn9n5jyzBruiAAQBowyF2Rk0/nqK70WFEbh62BywuTrD+QwfslACCOjpv8PdN96rRnVpFmMwmsecv7WfC1YSzcQ/fTJWmV2cOW4OPFahR+0ViuTLCR7WvnrUgjWicMAF1H08UyIgssLkBPUNprMuQudVh+Cfo1N2zQrKonLdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730867; c=relaxed/simple;
	bh=4OCSru/Lbt4T5vhKJNlhummD6FRhpLVQSxbJ9kBbnCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwOxkpNlPIXGjhIPKDNmkjCB6UlYG/U4s3l6lCxOoQ3YHXRJv7oauqDjok6IXqX0V6O/tO88sMW2666H508kbyXI2fn1d6aX49ifmE4in7KGIEa+9Y5HTQENsI7D5EHizpRVLdhLzEnJi5nXJ/Pz4vq5rO8gbQPF4lj1fyf56EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=KD2ipIkd; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="KD2ipIkd"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5339199d8c3so12659521cf.0
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791730865; x=1792335665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OCSru/Lbt4T5vhKJNlhummD6FRhpLVQSxbJ9kBbnCc=;
        b=KD2ipIkdTrNWNjRpftF4SR5b6WV59uayvIoVhn5KioWYEchdJ1KAiyqoCE8AQJQjnK
         TiSGb/YpgTci8iCpQF0Uf3X/BSk/svo/ISY1+rpGgF71pKrJoLWw5/LdauVLFqYAmcYk
         OSt9SN3i6szpx2UumRTHjL73SgsfbO/hy36hdI1M725UMyssrzSAMq4LYMwHbUnwASsS
         Vq31D0Fa1T1LXqJabvi2lQCxlAPWK8t482k7SXhWS6yD1MkE+7sfEqjPKxhp0i4+ZLrE
         YTZELzUdn+WECE43oArfSnBTdtLsjfM5ThRQgUZMHvzICTrjg0ngAvo7HqoEm/3j2jDD
         MljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791730865; x=1792335665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4OCSru/Lbt4T5vhKJNlhummD6FRhpLVQSxbJ9kBbnCc=;
        b=0AdY8FMs2U4BPBNzWySoJ6VTSlIgQAHA5bdRpHlX6pAZ7WXKujmLI0073GSSF8dyjs
         uwsaBcbYQepDWMEda8ol81Y+2FHnCFqnQLFH/0tmMKNFUpgnE/Ez0lrGYFsYcHoFEdQw
         NKdJD0G4NvsyTCqQNnKgDoDgTEQi3eUzoiEUTNe/R2V60AaVRbABd6am9F/RTwg0umhd
         vIafzbDw9tyCcysqKVQpKvtkXkD27dFG5HApmaHuSauAZrpyII1P71OycYTTg8Eoomkz
         LefX8lvN1rxSci87bbKngp1zTTBFNHm6RNuNdVVGMkEoDXxgdy7YdiUu/jA9HqmJVoaP
         JdEw==
X-Forwarded-Encrypted: i=1; AKwUvBzF931UfVoWG31QheXmDVRlEQ5FeRXwoepK08k4TBLfzVbvwZqONIctnTFkyARlKUQDe+Bp6DE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIx6Zzp5sX/7xmgbuGFD9v8o5rRwI4rxc+YGfQ1xlq4em3EQnYx
	ZrDXu2xo1sC10kNf9GGntz1M8IUdU7odF3TTzX1JsfvIPpg8Soccd+fZaRidOR58swX5lXwKwHA
	1xhdaNg==
X-Gm-Gg: AYBFou2f3jxtwiqCk8i6Du6n9UxcfKg2vl9C+MmhGTOLlDsV1KKwnFeN1P0jVtGKhVP
	f/6q+mgRrb35HF5S1fIntFVtnMDIyR/m2S6MEuRjQMbuo6NoFF1CwSYJ1QU6uvQdQFxk+T3+xnZ
	d9AXt+xHwqiTM3lqFTgwUjmzcDRuysuDOhSbbsdAqAW/ATRo+kibzsHsw5e9r5vKKigoj2lobQP
	j3vXqlZizJRFz1/1Xv6XrPxnxwQh3P33gfWtB95BjlyOqDSI5Ja+Jl/hpPhDSDH5Ym8RtSe3Z71
	/MTjh/Z3dDGRQIrQA+/n7V9UgY1vsNR+VN06WfCBwGoeF9V8fDIMONmfRJljI4cM8Cwdj2JGl6h
	qAxTHNSAXL3Zmff19PKUdHnSn8HCvOKNhuW1MLkoK7XyZhqFD7IngrwDOM4sWgO7GUlurcq3Px5
	KkrGnQxXopgfmbQYTvVVMLURO0t721KjJAvvYGnJ37PjEXN4/y/1EBvd1qKq5jCq1/ndpx+YCvS
	iBV2fgliZd3TwMqihXl5w==
X-Received: by 2002:a05:622a:1909:b0:535:2db3:c05f with SMTP id d75a77b69052e-5359fdeb97dmr128255601cf.61.1791730862788;
        Sun, 11 Oct 2026 08:01:02 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b76eea2sm60407431cf.18.2026.10.11.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 08:01:01 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix TIOCSSERIAL and TIOCSERCONFIG on uninitialised ports
Date: Sun, 11 Oct 2026 11:00:38 -0400
Message-ID: <20261011150038.1466236-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ast-JWIDzyly6WuI@hovoldconsulting.com>
References: <ast-JWIDzyly6WuI@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Johan,

Thanks for testing and reviewing the patch.

> How did you find it by the way? I assume you are not using an ISA serial
> card?

I found it by comparing kernel behavior across different versions. I was
testing in QEMU with the 8250 driver, without a physical ISA serial card.

Hengyu
