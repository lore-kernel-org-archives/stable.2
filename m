Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200F3B71DD
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652864; cv=none; b=ibH8z6vYa1Bcr5PUJ/ul61vs9uGWev1/nbGbFceWRv6Ks94G90O64lsJRmz4er5XEhWQLQqZv/zhmARGcZQlw59+BsALYhz6QXkXlaJkzWDmlZO/zCITf5LOazV5Ee7cNjd3vglQ6GzwZy6oxXX1PTZeNK5mc4BY4sbYFCW+JRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652864; c=relaxed/simple;
	bh=RMLKSBf6td0blMo/wVsTeAPKKkNErN1kqNLPI9HYRUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VwJRDamja261S8/u6fe4OoMX6J5DxiwFaKvdJp22UMtDmwif2wQHNLmPhkvYjG4N0oCFoGPFwBg6FOMuX6j0CaCulPai+MsmwxcziAeAuY1j//a0AuDm0I7mObDvyAXJeyZriEAej+06zq89/KCYw8oPZ5URSbpMB53dzKbNV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scXglLyP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scXglLyP"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c3546924so11400265ad.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780652862; x=1781257662; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RMLKSBf6td0blMo/wVsTeAPKKkNErN1kqNLPI9HYRUg=;
        b=scXglLyPbY6K/tARilugvxthvt4HPQsFqVwUnDa267LNnSRkINOs3Qao1vLepMhU4j
         ViiWg8Elha9BqtGAiadYENzvAURYQt2bFENA7BidFdeuOJJ+jLlWImRaLbTJfEwDTTrX
         aBiijmfENBMzUgEshFkPR+HM5XFr9uM5pnIeYRJS/w6LccMk1lVeV5Vj/DFyTTjFlUnW
         0VgzyxixiKhr+czvlVroUVLZYxx0/+LdEjGSpn2vXRXQrrdGJjG/fgmDABE/MBeWJ3SM
         lonQvsFeVcigB6aFzY3QhxISfGc5Lc1syxTEJhdF5Tw8SNRJYtpvWn7ZLdpoNWCEv5nE
         E6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780652862; x=1781257662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMLKSBf6td0blMo/wVsTeAPKKkNErN1kqNLPI9HYRUg=;
        b=fM2vpiVAtmJRKr1+e26dfMSyVwgFUiuss101OnLLPtFzIc85kwEw89gCSDA0UFm7ws
         J7a00UHEE9tDNtqTuzyGO2Cr3Se9sf+T2LXzOvHXpRbY2FFdR9B543sR/ODDlGim4u4R
         Uh31Peky94xm3IZxI7ZRYJUEocntm8QGusAktKPFbodkH3E7Ydu1I+7Cz8x2l3+ixZsU
         00PvzcKOVsO8lcfZ5bAoc0T2xbfT/+a7X+oPO2H49UJzKMWIlEhUh4Tt5EoimjxzPa4Z
         Q65HCx5jF4fdlFlMj1k5EtGBrKF9/cPKtOyvTxEUNi3yC2owXgeSZhIMFCoRtzpOQaWU
         zSPg==
X-Forwarded-Encrypted: i=1; AFNElJ+syStC4iwC1iyr8jAe7KvSzbS+EFgQPQCzvdWs0/WLdgNjAdIy26rxV55ytwPABOq760jC5ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5uUcIFLaFIQoLeA40NVruR/qWgPmlKcdJz/OHRIR8Q+New2kz
	awyY+xXcCoKd6ccW9IM1Y/usphRPiFoDIt74l/IZioGD593djJ5Djcwx
X-Gm-Gg: Acq92OEzjQIIM0c2IPSbWp6GioizTniE9R3poPvDFkqh9z0f6JuK33eSkOLeRDAMHUQ
	RYoBQ2+JaeQStvsHdrv5/q2AJZbgtVFNECD2wE8a3NYGEIWBR0ohA0I49JCRP4IFQuEL+m0qzK2
	+nZX1kRM1ACzMhGhL/NzyVxK2FKjPOv/S8GQ1NDv4CkRn+wtECs3fNpSiu/vUnNixKWqJNYeW1z
	qeWQnsxxKXijmaxkcZ9K7jqsJgS6XpBJiDl4ZtU3HaCKkifPuVnc6ynQWH397wZpeAKtQKj2tLe
	rz/78CMyVOjY21KxF7SX/6WwQtdMBzSe4fKV4Ug7S0Ez0u2E6vy5p6W1IBz6dMWPjvWvAlhHMoe
	WbQm5WxrQuG1GMJ/ODQN+oSEtF2FfIERlhQw/E56nrgGkpT1gcVKcFXPZgaIOpubhag9LW7bnlv
	m6chjtSjkZyMrNqv6KFJrzmM2rIFBIVlmcfmgHTmBVgsbCT6EJX+LcI6JDX5lNgQ==
X-Received: by 2002:a17:902:e5ca:b0:2c0:b932:867d with SMTP id d9443c01a7336-2c1e893d0b9mr28693575ad.29.1780652862144;
        Fri, 05 Jun 2026 02:47:42 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2e2sm84127505ad.49.2026.06.05.02.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:47:41 -0700 (PDT)
Message-ID: <cb44838a3bd2437366b840d50a09d40f444a8b2c.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Keep dynamic inner array lookups nullable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: dxu@dxuuu.xyz, stable@vger.kernel.org, John Fastabend	
 <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Kumar
 Kartikeya Dwivedi	 <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song	 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 05 Jun 2026 02:47:38 -0700
In-Reply-To: <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>
References: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn>
	 <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 23:11 +0800, Nuiqi Gui wrote:
> An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
> inner map template. A concrete inner array with a different max_entries
> value can then replace the template.
>=20
> After a successful outer map lookup, the verifier represents the
> resulting map pointer using the inner map template. Const-key lookup
> nullness elision consequently uses the template max_entries even though
> the runtime helper uses the concrete inner map max_entries.
>=20
> Do not elide lookup result nullness for maps marked with BPF_F_INNER_MAP,
> because the template max_entries does not prove that the key is in bounds
> for the concrete runtime map.
>=20
> Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullness"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

Thank you for spotting this issue.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
