Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794709738;
	b=5o6SxazaYQH9jscYUQAvxCXH4d5OiHnNTUNaGLvUiFECRXlbRayUt9eoFZ9RwfggBigS
	 KuvTpwqk6RYT/xdIuLkJY+pyAVRCP+5m/9tcSweumE9ghOgq+0kw7Fn+cLSbi6I198/5D
	 Kvb6XGkW7kVlPEvZkhhAWW4aJ8JPP/3HRRb7C5O0vcChKawzQU/fRWmWqpTMXcNS4N5Pr
	 u0APeFLA0usDzKenFkHolv7PkVhY4/KqqYpfIbs/lqbTkkz2HkjWAV01KhsAT0bwJWCef
	 jWZP2dYZcA2TKw0+dKo2fXPhcvrihErCssrRj0KyWoVSdWDNVmdUm5nG6eXEZkHEXoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794709738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=G0R1NDMcyta6okyUda1y3v58EnPaSSc7GPjs8feVmgU=;
	b=FEaTetsGibrMtpl4jnC/zsP94XBXwvIYcni9BKkrY2+sgLU4r6Y5lgm3Q4eNiQAS2QSC
	 16ZRbUgpax9fNQdMvx/hS8RVvkOBedvdb0VNn/8KhGmCv553Kt8h8MTHi8WHMuc8teTuo
	 zE0YAwA2U2s8vTeNIL42ZqqiemFhZBDX96zy3/Ml6ZkpjULJZvETDyCTxAClH7MYhFbTo
	 dK7SGv1ENaxZxpoEzMRkGAZc5GCIBoKned/uAHA7tddY9agQG3x7UW9SJ67u++Rbx/IZu
	 BYMLH1I8RweYT/ZyWtRVdCK/2q1bo1/4i0L4C+MkoOziCDcZSIvbtKeO1wsdQsdXFTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nbfneGYr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1F606A32C
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D1F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nbfneGYr
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-716c0217635so3399314eaf.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794709736; cv=none;
        d=google.com; s=arc-20260327;
        b=rJBeoDxJEircYEDSv03dV6DPPQO0tQcZ2eSJSy9wX8ZkSIhrebb8hbXaNaLIkbHcZY
         ekUUSarpQGiCuFrHp39uHNLrpgkLeryb3Vd8KjSqH9IBH+8dM7gq8KEqMCz3OZ4jJkLF
         9mVVPNx1wW2K8fv/JRv1pVhq3hojC9Eo3m3LGYA78EnYfdt1zptiXK/Qw07kfwuZMEF4
         vuF2DqKIKNM7Wn40PsFCTyguVlEjHCvPHiLx4nEvzPwXSKZoT70B/x2fowuxQjV6HMxt
         4Z6x/6TvXUonBURP0MHeLTOqx+LNhwS5P+z2DkY+JBvtxpWdL5g57kTSv9mMSleGBQIc
         oN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G0R1NDMcyta6okyUda1y3v58EnPaSSc7GPjs8feVmgU=;
        fh=zKlIH3DqejfDYJ7u1zFpo3zSl4mat25CN2fWwh1ZbW0=;
        b=r2eYCpT1jNW6PqjRZ1YLXO5mb41sfft4Pm7ApT9b2vAFLJkO2cutjayNZBQ/dng42V
         vZDdQo7xBId23Hl5WzpzHm2jzMmGen8qlwAhaVkNpNgkNYwEIMoujzLePY/ZvlOYGnsr
         hC094p2tMZZ1JPu9UdpEiuI4blD1Os/gE4TxAnBI8PirTCneoiKAO81H5IP1sfHX/BXe
         NRr5cGeUYN1rpuoBkoJqI4k7Ai0YO5jPocKuImWc6QEiQ4rmpmcyow0nZzUT98O4lJ7N
         G7bZKGsrF7oXOf1ceGnjPWujXbkdmgEGfDx+Fl8pIOnLwPfRHftG8MwhEeYyRtFAxcVL
         2+LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794709736; x=1795314536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G0R1NDMcyta6okyUda1y3v58EnPaSSc7GPjs8feVmgU=;
        b=nbfneGYreYpMfUAFkHDdlSMQmERdv23sSDuuWJ0gzACuRP9FFyRT1YhoCeaRNHI/jL
         GsNPvJ1lCij/s0E8/JKYBXgeOm98BmOsIqtmYEEd9Q11go5twbrwrZfHYhwsxndejGwb
         coGSqvOT/VjRhCiU0gDbZO9XzTM9tsW8vq8oPHjV11xIHreG57Y+9SAlELikVNansz7w
         DBfUMM01rxIJZvCOdRfWEtFTZUWi91j+FXUH6H2pFwKEpwV1o5EMLC3tREoEQjcKt6Rx
         rQ043/klYKCRt+u1wmVY8lr65wlrxV5NKQbmiv5au+/hyPqPvinslNUx6gAjn09+GaSY
         CHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794709736; x=1795314536;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G0R1NDMcyta6okyUda1y3v58EnPaSSc7GPjs8feVmgU=;
        b=wFBRZmQWfhbTuA9V2M5Q713nnphIRapTk/V40nHNfVgcQ2QAHq6icjHxpY8bvHNHZ7
         ByaLNrTf5vqxU75BAO71MtPdEHF8wRGahZRAVvisskV/+kw9hNbk3O0b6hAR5c+zuKNw
         Jy6pyge2Xyo8byEgFYuKE4EbHLoMM9K298iVTfTpeRAvXOfEyjhhG8lbL1Xp47q9AaxT
         1Umi4QZLk4pnrdFOf3nTLripeuQ8RwIqJWHuxgKR0ex7OEwmoIuv+LtfaoAycvzAow1x
         nxzUaKf3ztrI5YqCQn/+w3C0XrZ1ysuOMCOtWU2xi6rpNL0wnxljuAT5yiGlt0cmATw/
         e8mg==
X-Forwarded-Encrypted: i=1; AL+hErFCJz2Xp6dJ317TrFWNtrL0NpeekIh3XMQguKru0Pce7ro4YMqOVIwxpgpfJWYVTKpms3k+U84=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ftEUD3PQN8e9WUhBTycTZEFPHqhF8pqF4ZAn7eefXJecRZHqP
	GtA/YR6bVTwX4j1wGYnvqDrI1Jt7fxk0MjfTt0ATbYU8Y67SwZP2Pod+S3qGjZYK8GK8YZdoBzO
	Zh4d59ebv2aOZNV/E1aQDQOS0c2Pfi966DbL+
X-Gm-Gg: AYBFou3IYicRuUSJC+iTxuTkNvAckDqUGZqvHmxWjdYtU1PONocp7ObFE5PeirxJtQ2
	97EM9kL+Na02DwrIHbVKVgYjX58wIkZyOIuYVYPcAlq7JZhEFr/zZQtrvW3+CEyw1PeoWdLTe2s
	L63ZFVp3Cc2NZKtZYYFlrRhaVwrTP90M/7ClDpxCjCk4O2gxV7PywJ9puZHoz2dTKmqBOak2ieb
	PheCQdPPImeoG9VlRKFRYqIYMEz90ZftZiugRTyozVQVeKnDDFyuCWoe3nFT99gjOxcOHn5TNhc
	SJUK6OmgooXKgsM3CFTgzXgFNTC6//jug2ZEi8yFzLHXScDhKSx017P7zEJ0XgRxf7a8ndPW6Vg
	VjNNdUqkb4HQTL2OfUMSiqtTq8kjFkYXiCORptedMABC7XbcayhkjMm1dQOcTrt61Or5ur10owO
	oGyFyeqUcdGgAeeUt+NWWuyEG2jbVu31Bo9X6wz6BTfgNEE8QyXzHV0N6OSg==
X-Received: by 2002:a05:6820:8105:b0:6dc:7513:c06d with SMTP id
 006d021491bc7-7197cf12f05mr6314842eaf.50.1794709735598; Sat, 14 Nov 2026
 18:28:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
 <20261111225759742pwhACD8p_0GdXSYIk_Ob6@zte.com.cn> <avkT5yu3hJgi-YWb@fedora-laptop>
In-Reply-To: <avkT5yu3hJgi-YWb@fedora-laptop>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 14 Nov 2026 20:28:43 -0600
X-Gm-Features: AclHuK_Ifc5tkbepMLK0d8ZgWsUZJ0Zl-dFfIWODo7gKqOHzWbB2LamABucX8Fs
Message-ID: <CACVXFVN0Kw+jvDuZJB-XaAN3hNDd3WFvLZULJcpKrpz3qiehXw@mail.gmail.com>
Subject: Re: [PATCH 2/4] selftests: ublk: propagate stress worker failures
To: shao.mingyin@zte.com.cn
Cc: shuah@kernel.org, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 8:07=E2=80=AFPM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> On Wed, Nov 11, 2026 at 10:57:59PM +0800, shao.mingyin@zte.com.cn wrote:
> > From: Shao Mingyin <shao.mingyin@zte.com.cn>
> >
> > The stress tests update ERR_CODE in background subshells and use a bare
> > wait in the parent. A worker can therefore fail while the parent still
> > prints PASS and exits successfully. Calling _show_result() from a worke=
r
> > also removes backing files shared with other workers.
> >
> > Generalize the recovery PID collector and use it to wait for every stre=
ss
> > worker in the parent. Return errors from the worker helpers, leave resu=
lt
> > reporting and cleanup to the parent, and reset the PID array after each
> > batch. Keep failures ahead of skips when collecting worker exit statuse=
s.
> >
> > Fixes: bb2cabf23568 ("selftests: ublk: run stress tests in parallel")
> > Reported-by: Ming Lei <tom.leiming@gmail.com>
> > Link: https://lore.kernel.org/all/avJ0Vn9G7XhZv-XL@fedora-laptop/
> > Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> > ---
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
