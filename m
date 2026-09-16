Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE035E95F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576836; cv=none; b=I7VfmTh4u2MjFp/MUReFYIetb2Qur4tGiNKf1xDB4SIxHmKBX4d6/pAfPNrJ9h8WKukEqln/Lvs4E2aNDZ9Air1Pf7V48719wA6dDPj6Wx1JxqGHGpLqjm+NMWZtVp6Cevvk4K8cZ96eNRZC1SV9ry5vUELh08/IZm5OFmoTtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576836; c=relaxed/simple;
	bh=NMD7vBQ6RWs/J5cNo+VFCsSkxyb2apVp1B4H98H0FXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9AMzGNQaHmvCWockFr8xVfzZ3LZ9+r+cSpUTEMjCjmQKkZkYDwTxlevBaxb/lWTA8BNUNp56RckBUgM+8XO2R1Rf+TJQxVJYjADlLLdRDsphgJgwMiYnf8JI+6/TdRTgS1dUjAkl43qfe6aHfpiVD3kx+X5AaGHu6RfJAdaUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKsIZmoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKsIZmoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212391F0089E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576828;
	bh=NMD7vBQ6RWs/J5cNo+VFCsSkxyb2apVp1B4H98H0FXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TKsIZmojAOCZjVkuTEgu/Ojwjhf036GzQdXroxfypwiDNIxHQWqBjvK0vOkxCSOvf
	 SDTolr2qG/vfhUXo0swwfHYpn9E8Z47GZVBKvuDxpwgQ1cXXuQh9Fh877873KVTmzB
	 XQyqW0MAgfIvsHXGLckUqVpptBkk31pAt/Q9KMAu02W9Fvi9xEodCxZPsLnbYp+k8+
	 n+6cOLyimrkEwcaLHYCw4WMeswPWzpUp5oX0knNETQuVaKKQ8xoaEsU1O1qy2GNzPg
	 aR+ez/vPscABS5AEn7M4qruHiurIohb0SFlk4+C07AlCWDYM088WL3whOU8RqNtLXx
	 JMVjqi15NNTfQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1801fso1310764e87.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:40:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz/WlNnvoBkDZ2YCXshpDvG0vLECDS3/9+pNmsmCXwsOwzJ9PkCBPyvYCupsrE1megKraIpu/g=@vger.kernel.org
X-Gm-Message-State: AFuF++nzvzCWuFexufJ92dXPTDoHpk5pbqCFlq15gdudkK8JZcEo/x5Q
	uHsg1ct282J/mYleKGJajO6ChiCTnaEZZXECOX2fM6a1GxkSEHeBqPzdSHBcaHODt7z8+qHdOY/
	q/bF3T9QlJ6K0kbt1hvscJeBMlJM2rYk=
X-Received: by 2002:a05:6512:1107:b0:5b4:a836:13fd with SMTP id
 2adb3069b0e04-5b8b661e3a7mr897834e87.22.1789576826773; Wed, 16 Sep 2026
 09:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
In-Reply-To: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:40:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLkQw-U=e43K7Zjdawid5D54hoQFAkVLBLmOsq00FGOoAg@mail.gmail.com>
X-Gm-Features: AcwNN1WRdUJu-Cn8nI0om7fEFyccuBINdekovMd8_4ronkacx1OYdjXuVXiord8
Message-ID: <CAD++jLkQw-U=e43K7Zjdawid5D54hoQFAkVLBLmOsq00FGOoAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Xiaomi Poco F1 (ebbg display variant) fixes
To: david@ixit.cz
Cc: Joel Selvaraj <foss@joelselvaraj.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	phone-devel@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 2:45=E2=80=AFPM David Heidelberg via B4 Relay
<devnull+david.ixit.cz@kernel.org> wrote:

> Been broken in mainline for some time.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Looks good to me:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Or should I simply apply it for fixes?

Yours,
Linus Walleij
