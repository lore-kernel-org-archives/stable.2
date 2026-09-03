Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3D1DCB24
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457014; cv=pass; b=fHeXIDO7ZR4HgmTDIN2Wv+0kLHMSxWxxJWwsIiAHuZBtvLWuXGEXOaMC/W2vLqlWAGv2y2/TqZ7rD4sCCRk91qQrO8vQl/MUlYvBy7buuCKq817ATvL18ZE4muEZUzNAOJWG+rHJyq0VdJITXpd10Z/qTWQtv7WMwQGfrg11tI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457014; c=relaxed/simple;
	bh=BwdsIT+n3/NMdkvDDo2zQxXn9RgFpn34iyHl6HneOgk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=stNJwK2MIrGCB2xBRn2VI/ppFk/cjTGgYA9OJUF6tPHnb/804uFsEd8+e0wLYKWJ7gPkA57SjK8sVg/W93c8vdUs/Z28e5Xb2vJdKr4BXJTxWJ6Dq8ioD9j1SOOtyrPt0EaV0NJ/vZvG3QocstwqzJdlYuyR/FJiqEkZJC+KboM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOMRdkuX; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOMRdkuX"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1c7962bdcso22222a12.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 10:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788457012; cv=none;
        d=google.com; s=arc-20260327;
        b=Vp4lXVh4QV78sel7ltKcKtyQlJEWuKJ60KKzCIG1bB4kZ16cV+WDAkWvl2IgSs80WI
         08PtMrVIXd5obPu0BVWqjRvWfD7/6+QW/ae+7AnmNf+8C1IML8CAm5Jtod/DXcQBx0lb
         epfN2NPFDO1zGwYSZ9b3Ijd3dWoSBCLLQSQeES1NQrfHmpf4hFqVCpaHWjF8t7+JxCEp
         ahucLyOa7m5OkWBgJLdAXQjtROYW5+bg9VIpwr06ZoRR5v9jXHC0rSDVodgXH9OChYuO
         KPyxtNm/BcfZQZDohNbjNFALRssRosKz6YGukOu5v7dxVl8PCPTJTSBLIurucgqNTAGJ
         kThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pgTcWdO985XhydOdWkaHkIRwkTFbVtsREVc4kKPhqxo=;
        fh=DxwbIFFe6n5vl0oH6h30xUjkH49vp3QHt6o5uhIZtVo=;
        b=iv2gqywpCMtYL7SoaTodQsTumYg0lN+04UX4DTrL0k/Cpbd3kPzLIj0boIs1GU+pTT
         qyfe2tasCi0AXkIuAoqdjACFzbmQstH6Ow5w8HL//UzAPGKi3AfmtrdBkqluGrWKYGya
         ygntbmaurAanRZcb0sDvT6MPoK5XzkkO6DwsquBky2yEyqpfduuSciSXR3MjxZaz9gKC
         tzUzeTUZc/pspudsrnZJgKPnGYEkkIv2nZNJCiv4t1P5KqnWvXOQST4zVb45pQSDJ9iQ
         rYlTkRgfX0bIH15faAdc3MNYEvQZZqVAVo3NQiSwrsThN0QklC08VJcT+r+/n8ObelnD
         c4mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788457012; x=1789061812; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pgTcWdO985XhydOdWkaHkIRwkTFbVtsREVc4kKPhqxo=;
        b=ZOMRdkuXsGtVs3BG580ORvMvHCZcW+ig30DM8uUbYF3Fz94uGRmsBUa1XY7OzDznIK
         vYx3V++yRt4a7CUFZKjbSvFqPzRxHBVAAP5ViwJqExlOkhnO1KRxT2eNyk1ac1ftiuap
         4ZGe7PznpmAYiwf1/7gM9/qG++ZrwFtd1nZ/0Vwn/8JikEbcXXwTcTiTRnGqKOe4AkLS
         Gyzdc2CokLGNon6XF8z2nhQaR9e1SuTjdOYq6dS6KgMjCIKpTx6xPGJ+cLBh7/xvUNu1
         FqtbSGx/pUSBuhsY4cSSP16zQEsw8fu67zoN5H6CdLlZG0NWdIUnPLsY+UN1SJQTvpQl
         95Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457012; x=1789061812;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pgTcWdO985XhydOdWkaHkIRwkTFbVtsREVc4kKPhqxo=;
        b=ngVsGzHWbg8faS6YRKzp/j69UmthAh9bGmjiGl0Qyi//AJnrjI57SqCB6+ipYwuUSX
         QYBIyyCTum8I0MUmx0i3oNVvWwpRa0CLAxyIus1loczKjRV9YbF3Nc0NssSoa5vnLIzW
         xdi+Am+/v9nJx8KenEjxJoVx2jWLlz4nQvgMCbSwV066OGi8atlYK2Q9K2QjHFAynvs6
         OO6EK21etxMcfqABHA98LuGJ4RAP8zRQYkgN9tnGpFOpcNoFMdaaVSBr8dZzBS8sLXay
         5YCes3kP9/balmEOex2HKFpnQQEfrCoTExULer7aJdnNZxoxVzDXfswJYqq1jWiuiAeH
         S9ng==
X-Gm-Message-State: AFuF++mYTXdXcUVlXPy4tXfDIT2ud/dJjhesfqFPpVk/b9VJn25J4Vy9
	rUi2DBACNY103xenoOLc/LANUKLcwSxnLfHws1oepbe7CXlaSoQAcCgrPDKybVZCdK5prhFSS9U
	Ymv8Oa/ENqKhYJXo2GZa8gr61eO/aVCw=
X-Gm-Gg: AYBFou3C3avmp4pLuxSOogdWJj5hVvWm/59kFiHKL+NkTKuy7Y5EvDbcoBSMXMs7J47
	XJyriHekAfSb9h5fcT03pmTd903R3FHHLV7DhhJuyFIkcThShxig0V+7fKDc4wXnIQiw49ghDYi
	RsDbXiePBqhqzu6IKIdQgEyS8872X+YbRPLcUaQvGCwkmZl2vSl9p/VBOBJ7L53e6Fqn4cFlJbI
	OH7tH8dzfHhcyRUO2GMWuQJv4BwxvSeiDsgZSnHQSo40C+QoCcIyT5g0OMK5uFQMgiBSkCzsAXr
	NEUiCRUS9A8ystBvu8e06lRbpPSbBSg1v4QVyQjrsUyg8Nx1XiSv70ZKnLcosEuciL5+u2/MVUL
	fu5j0vlk/GBpcoKngOA9Gz9fkF1vFchEN0OgxySbtSoy0kb+6JqXHtU6OPQlC
X-Received: by 2002:a17:90b:530d:b0:396:63a8:699b with SMTP id
 98e67ed59e1d1-39b263dcec4mr8876a91.1.1788457012258; Thu, 03 Sep 2026 10:36:52
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 19:36:39 +0200
X-Gm-Features: AcwNN1Ulaf0ME_5kutVICqi0yn17W_TdQ1AOQzNcCJSC_obJR-J26XFIJmW6eAM
Message-ID: <CANiq72kmYx5GBU7VL3z8h3bAWB=vw-TX+ptskDO0k3Ro-F450w@mail.gmail.com>
Subject: Consider cherry-picking 4 patches to 6.12.y and 6.18.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please consider cherry-picking (in this order):

    c18f35e49049 ("objtool/rust: add one more `noreturn` Rust function")
    c431b00ca6af ("objtool/rust: add one more `noreturn` Rust function")
    16861ca3508e ("objtool/rust: add one more `noreturn` Rust function
for Rust 1.99.0")
    993f235c4af4 ("objtool/rust: add one more `noreturn` Rust function")

for 6.12.y and 6.18.y.

Thanks!

Cheers,
Miguel
