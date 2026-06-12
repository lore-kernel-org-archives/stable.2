Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F8318BB8
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246938; cv=pass; b=g15gft/vBQU84wcnpSkqGoTMHldTUCbHeALsC6FQC3/MXWFrcO9hCrBVV+TaLBklyr8nuSAendu380MNCudH/+/NNC3r96h7zK/P85rT9FqYRZ+cPpvvogfaSDnxL14qNQu99fMwItHyYdjIk5XEKk7x5DHlxqvHNG9YV4ZTByc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246938; c=relaxed/simple;
	bh=nH0j2TthBsX4g4WEkeRNbgEc7ybeZPyLCjDs1nfYJ/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEDh44Ou0H2yci5kiNtyiOBU8eUUKcFegT/B2bZhw5Cqoa44k3SHcjHfYAcO+WRsTdqMQNavBBaeYS9JeFqvujmKMWJ83PCuCCx4YDwYNep7ANmQZR91c/OrHsVyTzp/vXGFSXezifVZOQJb/Z3WoHPPyDmMDMdcKF39nJ+XBeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBeoX2Pv; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBeoX2Pv"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1383e116edfso685921c88.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 23:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781246935; cv=none;
        d=google.com; s=arc-20240605;
        b=BiY71DGpsifeUuo0QXvETmVIRVXoNESBmYiylpkRxLGXYoQ/3hPcCFI4K9y5/teWIs
         5clad2dO481aO/Fh9wgXmA801PJ8AKeKIHy7PggTWcLekuXT+B6oT+gvyLiaPyFCLZOo
         LYa5TKixxrvwMEHJFx5cn7ktImY3cS17ksQ9Hu76V7Q6nLTbg/gJeyGa3z8LvHyGdEHX
         IBNP0d/joKM8n+ia9bT3HW6s3ee2qCMKQ5DWO8MzbQyszU15QFVVgQYYux0WlSUM/kVV
         QNTuHBo4Gg6CuOy190i/68vjM9CdTSRnUwANtYoj3K9KJRSSlbGeXupRr+9AbEasrkzR
         NU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nH0j2TthBsX4g4WEkeRNbgEc7ybeZPyLCjDs1nfYJ/8=;
        fh=96PMY3BhYrBB3rjdfGscaoCxckALgwc6VdtkBoFSyCE=;
        b=dugrxi02nLTeok4N7NBRCcekL8wT07ivRRqNGPlvLIrldsND0RT2naG5l1rX/jRcmg
         BWiFBHpOoLNIvuxuiq3uugoj1QWys35pocPDkTcDaKkpjjZSuY+6ePEPMNCEFJY4O8hZ
         Q9ZQ86qsKtRnqi0RgpdHZ+OTymjIZL087maDKxZb1jkxvjCc2KUAuS5S7UqCWV4OAnp4
         iD8iFaVUlrnwtahZHl2o2NGZK3EtXt2Qdegnc/IgeiB/OY682+GKCWSx42q9yzx9uHXz
         2LXCSbMk0Ap1SGAIFF0xbNwrzMX8gLKXEHnns7x2OUSpVe9Q2tS6yHyhcHl+O93wiVtd
         YcjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781246935; x=1781851735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH0j2TthBsX4g4WEkeRNbgEc7ybeZPyLCjDs1nfYJ/8=;
        b=iBeoX2PvooKYa9X4oy7kLjC91K9wuK9UHMke5dvRCVzoEslEwFrkLS0LgcnivfPTN1
         M1/vH5o4ikPac+ncqZkOzYMuUr4UnKJak2MVydGAEVG9vzDtBRQ2KEkVe307PPBywZYA
         +L+lIkw4AAHY7bwTf6+nsP0b6UK5JtNjAJVI1e4MSg3erqQJ7+ztjGlQic1RBAvX71sH
         rUMbhJ9BoL1VERlOfx4pWZa5TG6bxMmFe8RCc+tsfcLPLjN+gegwVmEbY2BS/i7MyTjz
         IEfeWRN8SUjJ60H2O+F/3LcX0TvImpEmflO6LUxm9j5i7Ckpvzg1G0a9AS5/ZtuzMlAh
         tbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781246935; x=1781851735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nH0j2TthBsX4g4WEkeRNbgEc7ybeZPyLCjDs1nfYJ/8=;
        b=Ekk3wTHXwrAskhlFqVbdM+WRCRfuDtePY8cTh5kxaC4H6AESbFTS67xc999kSNWcTh
         cxkMvnbw5F3oplzi/sbD4N3QYIJe4BjM6t778UFSD+ZDrkCgJbbGbRdmzWgQjYtJ/Y70
         1U6lCGyORtOeu74g3U0AOKqAMcBDVMgLQOeF3DUkyk9kb7zWX/JZfQq4WyPvVq/WS9QJ
         soaivWoL/p9D/WSKKosv8rJBSQbs3O/CSRu1P1S1uuOgoN1s1/OQJvSRlUsWP/gRtMJL
         Zd+ahcwoTbIYXRgF+jr+h3/pM9KBaX2OcNYTCJ2y9uvoTS/OigdCONfOlIIIt1Fufai8
         6HmA==
X-Forwarded-Encrypted: i=1; AFNElJ9P5MN7n9BuskCKldXxBBJ/WIUufKjRyd4KCNw/FRWSQZEO+QFv7sUszygLh3gVerDB4eT7LqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl5fsuEaCTScnehoS86Hn3n8Yo2ON0TavgSAENevtWXtkDPfVW
	QUHc7RPkdD08wdQ1bx/KW1J/fXKfu627lCkWJBAnsG19rB10WYZVzZbdpPvcg52gCssm6frjYjb
	ttagKWO25lqJvDQ0wP+2smXkTv97GXdptV9RfuAwJ
X-Gm-Gg: Acq92OGWYJaXlZyzsHEh5o+LjOxKfu7VVAF8X3LsiYGHYQm7Y9k7SIo4X6pjd8jnNF/
	GLUL9CbK/rOFv2FHtArQ/m/CO297Zy+oMxEQw8aScZeBsMuwGQvhf04aJ3QOm9qkjjEwPeMGmz4
	DP0DqyYK6Y3rR/Wp1YMRUh1kK9s431fnmP4p+Tk2R6dHQX9Jmv7CVtqRaf268vWf25S39Rpvhqv
	iWRW/YFKzxnLzKpLm8eni50A+zuuxzRHckqzoTv1uJWZtaiwKTJI/gZ1gLvTZxviMoTCwZ+stY4
	wlRYsA4RRkx5zj9RN0mLYd4U+RuViYQJaIqd2fkTkn1Jhe1LcO/IZ4xSyWNTThTjeoUDtbjna6R
	obKgHHEzSTH3eqW4D/ErhuLe2cuRrybJJLmeutAj8Ze0Z1OWkEKqp
X-Received: by 2002:a05:7022:6886:b0:138:4023:8b6 with SMTP id
 a92af1059eb24-1384bafeb84mr807429c88.10.1781246934483; Thu, 11 Jun 2026
 23:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-4-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-4-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:48:42 -0700
X-Gm-Features: AVVi8CfTT_OjI7diC_WbJE9Auao36PreXQJZM4n8teeX0XG7ZHKPtQ01XJckUHI
Message-ID: <CAAVpQUApoBagChVPPFZFL5+aJQbd7BUrUpfmfOMHnCQPsWL-5w@mail.gmail.com>
Subject: Re: [PATCH net v5 3/7] net: ip_vti: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> vti_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Gate vti_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")

Wrong tag again..

Fixes: 895de9a3488a ("vti4: Enable namespace changing")


> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
