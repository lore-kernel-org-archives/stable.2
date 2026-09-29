Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB33BE632
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658823; cv=pass; b=Qf5GDZ0mgrThK2+CHD+BbJLc8R1sFD7O6V/ltw1DVLjfpmPKgetVSbFtyN+mCo4nEyb+vP0baHcX8NYuUZ0yEAVbZWu5CcP2xJyqyMv4OEZTlPgHTEQkneydEiQNM1hZ2ZB6XpwRfPuYDZmL9uo3dTOjtbR7s6XJC0ho6KuB9ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658823; c=relaxed/simple;
	bh=XhKkM1Fzuw43vycp3rNOw+pMnftgNR09wN8bT1caJoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+SL868If3YAa9J2Uuabkeos1BPrNSrecNuhrJOcmIgVyDWogqrR0o/vZcppQY36T13pHsFqheZTu6XoT/LV2x7qaZRYpy1ORzAD+OI96P0gHaL3rHsWBS9Zq+9c4ya2YdIbQAwRpljpqk7mVPDOYfz8e5iBu61dwiX1rIRWJyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzlumpsh; arc=pass smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzlumpsh"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e4e75342aso262341eec.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 22:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790658820; cv=none;
        d=google.com; s=arc-20260327;
        b=pYNTi3gsAvYMc+m6ewt1Y+Dz324Vv5D+8kWMfP8XbsEZo+OAPbeOq6ijlTTqaKVr1I
         l/UFxtGQZqNKDW06Jiy+31MXBm/LR2JRJtikdoj7yBe2QOQP2CE+LRZpgqV6CgmvPFHl
         hsvBHoSAmrunt8PJl39cfRyb+f8MO7RhlXVQ8FyZxBApsDAvX1AqFraIGNmqhP2gaTT5
         A8Z70/S7bemT5ESaQTETQa+SH7or9bEazK77KUmdqJAf8+ra3HFgxUWu3CTgLrBZfKN9
         317LstN3vsdCQq4ZHNk4/pyZb0b1YKA8o+xmL0nzsbkVIv/+vD+nlffS6+gdrKUAxcj4
         O5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XhKkM1Fzuw43vycp3rNOw+pMnftgNR09wN8bT1caJoY=;
        fh=5GskS2k+AfKhiyekJRNMQqHHONfLs9jm8p9rrlzyVh0=;
        b=ITTZn689Dm4Y86cVdtWcGdRzNON5jLsMAdnOt8bimHO/jjZqWz6fBwGzoz0Khs5HnX
         OAFix2wsuFmPXlzj2kwmMCF0suTWRNr8lmIONUJfpSvHYTC66e4F9R6jn5JVH+eab8SD
         X+3vk72kYEkZQWDfqgngDzjsBMbAvprGJJNJbx9LxxwXlZizhEC5v8XrqIVx7sPqIWGU
         X4HR9V97GRyUjThD56l5qmDpWKGf3MExJCTq2f5b8ei5THq9L3zRsVK/NUMtY9Ip9QyA
         9RS1K21CaY5qkEVqLFR5JO++aST682erCspj0vlXqCXBKkHbwrzqvwaVbMPKevBKXr9u
         C71w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790658820; x=1791263620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XhKkM1Fzuw43vycp3rNOw+pMnftgNR09wN8bT1caJoY=;
        b=pzlumpshljnwMz44N8xldVwUahQilQJ7puOd8Z9D7+pMNBuUFTlr7CQd7VDjedY7rN
         7vwr3HyiOsDIaIV5lPib9faD3kgT1opSvgH1LNiomZFvIy2jWBh2ZdZCSaNPUtmtd6jU
         r9Q1PRtugoWdlhOMcY3aCs1obx708osTCCpmuDXSktmDGC/cBr56ze+8QxdcRD5P/BGo
         Lh03b5VXJphAq8vgF9OWX5liHJFHw2wxL//qyxaBzhNeCbQwzCJbSmYkt19gWwPAT1nN
         IAsR+si8e+HNhZFm+Y8fGbxG9hEiQOJvQlI1Iz0vBK9LF4/rzUmbYnUkUiTs5EljGKcY
         r2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790658820; x=1791263620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XhKkM1Fzuw43vycp3rNOw+pMnftgNR09wN8bT1caJoY=;
        b=bpHqGdedPsGP/+FvfJROGr36FSP6ifAnsmfOSvqjuDQSMyMMSqiTLli4YiUgiwEabi
         MIny4yyPhhHM+jgAiIsH+BRp3b39d+0pzZnNciaPiCY6NYeIEMyhBy8jNs96Fg1W99XD
         Z5JiaoxbcJJonIqlCVCjI1kbWfx55uhmfUWmf/LY70vAxdnTo1hSg04u8mcmhyJlli7/
         iCbm1hAOecznvzR55SlgsrSHZQwN9XXxM8ksgsVdM2BA88INcrgaYYJL2I1+BkSP1br8
         mfV9c7lPU7f4r2wwdAJw8SREICwq0+dztr0W+1xw1Tvo5rAjafC161t4kl26BL2OIXRD
         FTqw==
X-Gm-Message-State: AFq9FYIcWqnnxoPIgOkhPaIVMG1MlexEDwRTPMGcFrCQf1cNL3yXMiJG
	14lvX2F5bFc9/p9q5Zekx2OVQZ9afvqXXk5VOiDahpY4NoUIeP5BieZxJeYWUrKLXW4DfVEJYf+
	8W2K21PYHKkO4RythiKrqshUnP1y75gs=
X-Gm-Gg: AYBFou11Jtpr3LRpJccyn1cZuOY8ZEn3R91zg3RO5Yu6RMVDDKhJxkbr6AUV9kQYQS8
	h0vqot13eusrB3oZPahFVQJEu9HDG1GcW8ZD9J6TPzcSbNOf12DD/DgNUC2Cw+nY+sqZGSCa4P5
	V1VzjSajbFHXHDXBELtPUcngT8OvE53hsHAKC5bKmpeH/JPXQbRTLTbTZw3OcVyGJ2QujM5enw1
	xuxF52LnOJ9ZFydl3XH/FvchnI98A5DQGmnAfo1e7MAkJ5ektd2t/3P3S7ooYY0rhqq+3Je3zMf
	eaS+friV/xZsvRSVE/YyvIV1rtsskLOrlcIAQdzytoNS9PmRW+E4g30mJRyYKzOQK5QttLAMoan
	BWti/8RFSuPo65XUwdO6CBFLuRbMKK/Ztxi57KBW0hJoS/Uumh2l3FKF2/pn8cUcm4ZgdiazWKi
	ZFq3oda1ZMdNa95LLdOCmrrY2OVu23wKXMEhrPaRS4P3Zx+CoXfCw=
X-Received: by 2002:a05:693c:4099:b0:33b:ee8a:2061 with SMTP id
 5a478bee46e88-3427169bcc5mr21939468eec.1.1790658820349; Mon, 28 Sep 2026
 22:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928104855.205416-1-ojeda@kernel.org> <20260928104855.205416-2-ojeda@kernel.org>
In-Reply-To: <20260928104855.205416-2-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Sep 2026 07:13:27 +0200
X-Gm-Features: AclHuK9GzLjndk0mMRwHVa6Cw8VP7RAODD9JN9IpJOnw25Uowvke0Yaoule5oaU
Message-ID: <CANiq72nVAr1_1mpGNmpjQHNKL3fvRTN20iivY3L9eqc0JKJ3KQ@mail.gmail.com>
Subject: Re: [PATCH 6.18.y 2/2] rust: net: phy: fix off-by-one bit positions
 in device status accessors
To: Miguel Ojeda <ojeda@kernel.org>
Cc: stable@vger.kernel.org, Chunfeng Song <springbreeze@stu.pku.edu.cn>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:49=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Chunfeng: I assume you meant a patch like this instead in [1], right?

From the other thread:

Acked-by: Chunfeng Song <springbreeze@stu.pku.edu.cn>

Cheers,
Miguel
