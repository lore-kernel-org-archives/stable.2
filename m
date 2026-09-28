Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BC407CCC
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576193; cv=pass; b=TG3GFlWVYtbdrFHd2La+4J0hgncmHgEWQt/9zSkPChTZNhARb1xg9lRFcXjf2E2gxTlHTYJSyoTNwZ1W7RFrZgALEkidaVoeGY6JuuEHA6VutgtggbordDDUHPYxnfjqCGj07fOyBsWHmTrOMocvWgD2wA3DG+NABhROOJ1kvYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576193; c=relaxed/simple;
	bh=UjLMTkNUsMTAhppS3VjvlrSLbd3vV2p7wtKDBinOEwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0uJbF8WeLxvztln8lN1uHLqckfVtAOsMaXGesLKv1OksnNoGZiyImei8JQhQ9BxyAdr57XPsG0j+sq4BMkQVZel8p7gXVZfyfELaT/K+hDrJqGcuTqCDdy9EyWt2PDB43wf5ItFF99xdC0ffSg8wDwXlSdJGUF+dCR2pmBPYnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXDR2pEM; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXDR2pEM"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae6345fc0so369911a12.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790576190; cv=none;
        d=google.com; s=arc-20260327;
        b=jRCfZTUlc0MJgHPMcb5c8ojenm4Zmwf6llwJHDFmDttkHMpMmxfJ3f03s4sQiE4hEj
         JZBnq0hcnBgcTfzcRyoJQ6zwWiuThJyVzY/xRQ/DiVNmdiYtw/rtjY7gYmVtalSSy+p/
         1szZ0VowJlY6bBNb1s9JksiMLU2Y3TQ4c32VRrzzVuOcjo6jgccBlnLaY9GffyWC8EGd
         5vVQyJrnCQ5Aiw4hFZqkNX5mLfxVcw2MuOfCEQSCy/ftJSf7OORZtN7+rhvffw0XsTpV
         LUjccYSHyOqnDIPBYY4NLNH5ez7XRvUeQKVcpz8M1k0MvEURvNTOhi5y2mI0O2+6+T7O
         k6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjLMTkNUsMTAhppS3VjvlrSLbd3vV2p7wtKDBinOEwQ=;
        fh=QphkaxwN6SCpSeys/aoXE9yU76wDlE9rhchy24P9rXo=;
        b=VKXhsf8oHCt2fW3i45o2ZsFIYtiN0mYZGCPPerhGK0lJLpUEpZR4kTWgWjXrITIxMe
         jXfb6gz6+O06YyacXOWMV6cjs7c3Vr3mewUGXiWP4sk2bamEBn+k27230Gy2lyfVmb6n
         EqEu3NBtymzvYDPhTf20BQE/iqYeaM5M0MkprweLfJUkaCSsmpt/x8IqOhY6d5M7wy8A
         Vzch38mA/NKxndxYpYUQxAlcZf0z4CCiuo1q1laQuzMUiqPxrSeuMZtGep8P8P0bWaO1
         HCgICuqfBgSsTi+f2IDRHLeTPO/ivyViuDlpuSCGqwodEzbmkps/7OQq0kIrTYwfTf8x
         kjUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790576190; x=1791180990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UjLMTkNUsMTAhppS3VjvlrSLbd3vV2p7wtKDBinOEwQ=;
        b=KXDR2pEM1JTLSxBj3wu9/o164MNmf454aZ44Thf2vTM156Ks03aMOJq5qhUWpydv7w
         36dX8Lb++kFHLk7kqmqu4aABQ/f4OruhsYjcBE8lrUwl8ksmWOruS+UZtlJzfC/seFZr
         HavIZXgr0de1ONBuIegYb4ZJM0v0ZtJMGZscsKr/vfVkd41aD/PVymcPgi/6iGTud0Fq
         DLNJpmxvWn50jAkXnKdPy+zJw6rcz5Xy//6P/Js/ftYPFJl2M2R9Rpd+HW9RCE/Tc0xB
         g+qNzwzqph/No56lN78rZ05898pllNfOGRguS5ZYQLXjj5+/cFR16gM1lQ+An4Lxfc7f
         b2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576190; x=1791180990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UjLMTkNUsMTAhppS3VjvlrSLbd3vV2p7wtKDBinOEwQ=;
        b=eYlud7JTbktOsLFHg8TiQcRc0Ost1oxN095RqeWnb42LvD+FLrq3NXRrfNsFgu+WsH
         tsWQO4vr0TU7kdmKZ8YJrEEhyVc3beqiVmZHFl1mAN/AgsehpfekCyGWxUJjQ5h/Cm9/
         /URct7osZWs6CmYrhFXb8DL5hFqRtTFwsIAMswLsohRQVSxpNJVIGTClyb6zdJI3jxFJ
         gmHHr2meK919bj0q3hTa0xbzHGwwKNGoQI8sBmXZdzlD3z4fH5JCFpUt06FmxUUgEubH
         N89l1CYvR8ylgSdNIi3XyNurc/FiOZJjeTLkhddJXrw9FOobPNZ/cXwlqkh4ZqoEs3Np
         7bkg==
X-Forwarded-Encrypted: i=1; AKwUvBz3Q1pm+4B1AlMC1ism/7vgRJXSRDAuaEnnmquM+owvTTWvXPhh+ILpJuh+lujIH41LwPjmOJA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJm0z/2otJZhwh/mKXNrhAcSf1+F0T7MococMxOP2FLBQ/18+qh
	nlwfrjHPB4K/r4VgOz5YTIwIHhF2vBvFCffD6EhP6aBzZ6uGJfHSxatJw2l1o9SviNy5n8r2Aje
	KxFmeCkv8HbSUDajktXlSlVlQ/68GwFc=
X-Gm-Gg: AYBFou0I4YBu5UpQmyrNbeVziCIcx/LbjnYCkb0Y2BMDjOr6PlqvEjlJDYphv3YVl+P
	l+Ay2USkIl4umn6InftIJ41ny53PjD53bHhCdtUKh3Jj3YxFW3zz2JvZfeC19YXV86Kn39QZTSm
	Wrep1EMT0gcWCQCG1hivGMJqJRXbx956Fw8bsRj0P4TyQZCG2ciGxHf1exmmePqRpqSkjJseNim
	xJ2R0NpjouY6rtUzdM7ZMQf9baMkACpwOqalN7anFpG5e+f7Ij1SQG3lHKwMHZ7UpQH5oJDnS9D
	mqI7Ch8BuuTWwwQDvuh1pWced1/YuAwpR/cJHnbgqSKjVumKLOM+ylliRlUKGiCHZ1vyxPQw950
	WjdQonQojkQ0=
X-Received: by 2002:a05:6402:400b:b0:6aa:91c2:63b0 with SMTP id
 4fb4d7f45d1cf-6aae1fb697dmr8189174a12.2.1790576189556; Sun, 27 Sep 2026
 23:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927073203.3694279-1-nicoyip.dev@gmail.com> <7960d73e-e316-4853-8398-144742e866d3@linux.ibm.com>
In-Reply-To: <7960d73e-e316-4853-8398-144742e866d3@linux.ibm.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 28 Sep 2026 14:16:18 +0800
X-Gm-Features: AclHuK96mTZ2XsqOn0lcw6M7Xfg64Z655RWGZWQn7KbinRvEPkfuuOyZHISF2wk
Message-ID: <CAAo+4rU=hCYRfhQLf4DS-_5xsYqfVfQ0YYEgBj1OLdbbMPccrA@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: serialize sndbuf descriptor release with
 diagnostic dumps
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:57=E2=80=AFPM Mahanta Jambigi <mjambigi@linux.ibm=
.com> wrote:
>
> Agreed. This is addressed in v6[1] by unhashing the socket at the top of
> smc_conn_kill(), before smcd_buf_detach() runs, so no hashed socket can
> have its sndbuf_desc freed under a concurrent diag reader.
>
> [1]
> https://lore.kernel.org/netdev/20260926065023.1629497-1-mjambigi@linux.ib=
m.com/
>

Hi Mahanta,

Thanks for pointing this out, I didn't notice there was a patch
working on the same problem. Please drop my patch in favour of yours.

Best Regards,
Chengfeng
