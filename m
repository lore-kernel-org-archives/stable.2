Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840230D40E
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788656689; cv=pass; b=pECBUQO7e5dd0G1QlZviAH5fHtLejkU9JGdl2qbaRvz0lHSfBtFiDEGm6kQqXqV1YDtKVp52KAl+zTAGShg4MU597d58YDSo1Hi19WuQPGB/NKeHJBr93Ds+Es3iJbabQLG0l1bL03+tukBr7qubRb3c8K7kEKC/M5L5YCvcr4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788656689; c=relaxed/simple;
	bh=6v9JT4KWbHlAzSBmvHtzBswCMCsqSOF/aCWlorwgI/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1r+sXUqWD4E0wOAWaGQJ7sIiaEI9Ya/cShV6K732seThA+7/Wk3vVRMHLfaFHEtjmEIxTG1/OcsaJcers8nfORhG7Mt9rxOrcEA9dk/TyWQyDYMU0sDGCtoY6COew2u6YDg5oiXV2IIyC7f2odA/uCVugmqtjFgz75MFXc14r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw09Lr3j; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw09Lr3j"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396673bd281so306737a91.1
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 18:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788656687; cv=none;
        d=google.com; s=arc-20260327;
        b=LuCKJtAPAm/BkdKvIBNIak6QwwAV2030sg+MmxvWXlu1Iv7pnxaC+ZGD8nZhAH7a3h
         k6jXP+oZ+Eq0ZhFVwDRyAu7KNohlroofVEH9ntRYv3u439/H8fdyPLozat4u1ha30yK5
         JSUTGS0xzItbQUEK59Wegr302i67t11FX5J+sJUpsQZ9r5AnDzSj9U51n2ZipopttHDK
         L80XiVLCje2Kb1EZDg+LcTlIp6l+28hx6wNbXxBzfftJ37KVB8UQWiPsWMBchm4x6KpA
         HscH33nzn8ct2WMgV28ydMKksahHn0WdduPuizmNo6cN0n3ILRCK1ZcEgGW4IpX+DlKH
         PNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XfakRqp8F96veZF3ZNAhymxMT3EzOfSxeJXjQ9JrCuo=;
        fh=Lzro6kELf1/GMa6dAY+tyFw0xsVm98IleVMvwyXxNzw=;
        b=MVfpRYD2GH5n5sLj1Iry8kJ4kLiC7z5Q8d55bLKFFPgJwlfDcpREXRGewWQZCWlbXe
         yTUZwpgqGVoQkkMIYl3SXgGhhZNCeqtDrfnamMFm5JEQMnWbZ/YngHsnmS9Lh/GXNWq/
         65oe4nCpgKjJMPn6PhYr9PmHtOERng07r1wK/wno9afGBWkTXkqW9fLHeXKf2BD8kzKM
         wa8gVao2gO0Gsg86V2o+0nLzVI/rwlQczECOH063bQC1IVBaipK0bbhJ07iBacl/IhfB
         fZWtGQQuow50AUtGH3hkMzlAMystF0vNbitPNa2XLkKy3hd4IcQczgd+BvXa+TPHcwlV
         ZRrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788656687; x=1789261487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XfakRqp8F96veZF3ZNAhymxMT3EzOfSxeJXjQ9JrCuo=;
        b=Lw09Lr3jsG6pnj5YacHyTDvI0MddYnPZsal9ybEqU1rCNob1lXd/pPoQKqvfFhmDmF
         1g0oaWUl9zqD+l4bZCMezHwFYpXq1P3tiWMVBpHSGgQFjQIAyIkGII9KuCWs4RmiAwKc
         RMXPJ8DMciu7uIYS4oLyI6bl9zp6OnYALLKPdzy7rvQbcpjbMAtIrMjrG9Vx5rqH2hmp
         Vn1uspj6zgkODLppL7Q/jefZvo68E2M10MFjF6ujtfOvqqZ7PALyPlnyjQbQuHkptlmg
         MBZW9MVr5lg32sdmFC4hsdpiiCN9V0YivpLHMqDvfzcONZuixrveu/5DW2YrHeEcA+yc
         3BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788656687; x=1789261487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfakRqp8F96veZF3ZNAhymxMT3EzOfSxeJXjQ9JrCuo=;
        b=Wf6V9ctCrBPU8G6QxOH9CWSAdfH0XzO2GEh+TpI4Mf9w3cHXt1izzdJ0ToSuVSMDBu
         5RhIR4mlEa2Hd06T4WdIj9/5CZr9Cw8IWinDoSScRCIET7BN5pghgmuyjRHySG9dI+MF
         7DSkil2JZ/zQQO9XbZSILGhjgJe56JxKLLQVMZX1putqA/fj9KGj/ATXmR3dLaOidnIc
         PAQNUwdneu4I1kxedWcpj8ESpSsaLRWCxxX3jOOwer0+hdypQID4XQul7dgq1ex4Zq4X
         nw5Pta12jfMMou0JCDhO231IOnJMzXA9HSeNhFO3V1oc5VXv4O3Az2Z0L4spPG361JXg
         ZbLw==
X-Gm-Message-State: AFuF++lA3dIcIpDvJUo+f4SReKurxP7nlH7n6EAeyw+bjpzcou5rA0sU
	qmAg0g9r6KFRd/H6Tssbe4r5yWoQ99yzMCDuUUVhry8tp0LE5O2ohU2K6JMhbyoI/B5r0ugOtTH
	0bwLj3WFMXD808md5LgG77tKWAtwZgXc=
X-Gm-Gg: AYBFou1Ho7aAU9y6L6PnjMUYAEa1/PceAWrfz2uUHmSSLpI0eomwGDkCedNVX338xbk
	xYM0/ah05W0pH4M7H1eBxQDY1C9hEZm5NLUsuDVt/1puRBCYo6pnpwpysncQVzYfALShIoxLliE
	cQCxV1T5nKeiMl8ArYoBkc0nX9gN9edG5FgelcoR8Nie87NP9t7PBRlChilpkz+pPsfVNTTBwC0
	KyUi+y6auFJh1J65fP9QNrbIQVKWz1p/pCyEh4E6QCWM67WcMkWznB6CEeA5zffqnwq/9AL+LaR
	+3pNiiPt1bO1ne6ZZyQ1Wq/gAHJ+JWOZEAzkLr3nAHaZglYkYkPxneIbpUJHu56VxAbquLphkmr
	ngo3QfSTGfFkPnXIEKtXtg7e61Ctkw/wYMnfvISeBa9zFvbFOjjIykUmXdbZfCn30pvbq2+Q=
X-Received: by 2002:a17:90b:4b41:b0:398:bad2:c0f with SMTP id
 98e67ed59e1d1-39b3d8310d0mr7481550a91.5.1788656686629; Sat, 05 Sep 2026
 18:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904045747.813364717@linuxfoundation.org> <20260904045748.373148168@linuxfoundation.org>
In-Reply-To: <20260904045748.373148168@linuxfoundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 6 Sep 2026 03:04:33 +0200
X-Gm-Features: AcwNN1WEVmNLRk5OAmkHLSMfaNhjTk_FiTinpZME8xNMMBHr8yOLjbuFrkxEBxI
Message-ID: <CANiq72=EounScE9CxhQVRYTMe6XxgZzfid_cJZ5dxmkz7MQ2kw@mail.gmail.com>
Subject: Re: [PATCH 6.18 024/552] rust: bug: fix warn_on macro build error on UML
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 7:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> +                $crate::str::CStrExt::as_char_ptr($crate::c_str!(::core:=
:file!())),

In 6.18.y, this needs to be:

  $crate::str::CStr::as_char_ptr($crate::c_str!(::core::file!())),

Cheers,
Miguel
