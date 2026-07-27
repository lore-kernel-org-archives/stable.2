Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276C3F824D
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153461; cv=pass; b=FCHR/Qjzdy8hQS5g8QWmCg2llQ2XQrs3+PNlZTsbBxUyuWBIeeuLPW85DGjtVa1YUagzno4YlyGLZmiiZbATZ8GI/NOHf4XRLr6aly1eqmghf/Tw6qJrGQK/9ngty8DTqinDM4JQhTOeSgfZjywxaW+5h+jvr54M/aX7C7qFvzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153461; c=relaxed/simple;
	bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S881Q98/JmrfvMUiPOuSXWM6EaBfxbZpxgPk+cmdsRlkc8peMpXlI42M1bNha+3TWqeHbnI9J1EllpGq0asues7BUPzq8oFv/kausW8XLZME0Na+aTTLAPctUbs98Mjt/i+N6a1dCmatem8JqQQMry4RtOgaMNZDxzjLTC8py6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZtIpfPX; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZtIpfPX"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15dd4b9132so385295966b.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 04:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785153458; cv=none;
        d=google.com; s=arc-20260327;
        b=DBBOlLBQ8P+m43qM3eUgEXaK3C9ZoEVIlSiBk11USlAWL8XG8KguV4LNYcAdPPb6wI
         PaaV5BsH7EQevbnqWfZqMHD6PJki1Ifu9nYCSVoIJ6+DOiQGeZ6skc96SvHYQd4T1aqb
         5MfO4sTUzpHM8d9RG9RwiuiIQhPBKgmLVZpvfb9fVSzVWFEEQxYWvZl6kiUZF8frDcPW
         pmmmozzn5QL/qSQ62Vj1XxjIb0EMNmEMhmAnWQj8d28L5XX5nae73dXwMPNY3Ufu5bfr
         S29z/wFG/VSeIG5XROrym6mXWLyUGtW9Ns+qojMOq9RLDJnHmbJbiG9h98yRguApM8z5
         NwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
        fh=5MLxJYccRR1O7NPO3yKTE7NMxJ/UBhArcILl/f0HNHg=;
        b=SWjxXSJh6KG5jnOwITZkoA/uP6lbcTrFOji/ZooPBqrnUkijc/zvXz3CGvC3ggRby2
         V5S+F1/1LCnJGXe0LnXYMA5jGU95F4Xx0yvWKKEBluhUQFB91IEtraGZjVggtZq8atI6
         ityWTl/ONceIWH+mogBAXnwueYFhm86FtIXtFZQkSCrJ6CWWMJxO2pfRbGifWAtHuXUU
         Dbu2gPXxSRRvNL/4k22yVdQF6uR3agzhcNpsmPt//vkymqfko5JCRY9rWdYyUZQcMy+t
         AAf33mrVfCRo/YT5G/srKdJst7ujvVCzMdapUuP6Uv/LaJNF39tgex0pZcACP8mnXAwR
         YNhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785153458; x=1785758258; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
        b=OZtIpfPXTTcaHnGhkDxSZFynofniA5nD8GoqxxI9N6LieHRLhnYkhl1h+62wg1zYXO
         1CNEhOdxBBsIpFaGd+cQxgm+7attBl0knRJ0a6IoNWcmP9tpy7Lh5UWy8i8CVT4iqhoJ
         2VadF7Ww1aMJK0JPQ0dUuRkru5DGuldDq4VwDsgOKMtgQ+HqHw/8lIRevyi5w4nZKa58
         a+CPrKZujkAykRFbCyYjM/N17g8Tzqu1UzMQNqmCqMP2zgncjLH32tidtuP7hMYJxTNk
         goeswJLhtRWJC2rVTcSEVT2RfRhjSG5BMcUz2s8g1Vh32q4Ki62TdriB3gdm7bpu3Gjt
         zOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785153458; x=1785758258;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
        b=XaNVk4RG4rCpfqYCzXEgrFBYYnuVaGj9UYxOYR4qLo+SUliJtYQP21njW/AC+DBOQC
         cCwtoy87oATEsBgDJ7dc/Lqob5rPGXLTR4gR/6y8uZPE9OMmCYXiu5Bi5NH94u/92SCk
         NUyj2Kuwu0Um+gG4T8wpXMWvGN1zFTTzVLcQB232o/iwG5VQeMXdQyokFQcp8VJdZtC2
         Vuc6yKTHDBJ1KAvH4AbI9YTDgSBAwN0tqeXbZBqHdMalmwcQvx2M2K58cttyNuV72++y
         bn65VeAtVWbAD2CPSU9bla56nedLy6cXqU9IU5lJ7wqtclIo36XpZ6SNfO6F50aDMdIf
         v05A==
X-Forwarded-Encrypted: i=1; AHgh+RrbMy94wpT9g0XIJQ9ftt/Xn2kq4ajJ+QTpMcNM3q63yMggPOqOY8w8hGMKd4PiQed7HrVW3oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdacE15MjztJI8KWyXPkzL4uJlIv/B0RQgW/CLYgRUNICy0We
	c17Xx4GfA2xpWU3gxv8UD6mCop5l2eTJI1LqsiPwrIv/Opyd8TDxJYIPdlIVqRaAeubpb2M7qu6
	SYOjo9Xsb5ILyFT/3v1TQPYMLwIG5ixM=
X-Gm-Gg: AR+sD10pcJ8rZ8LGYGwPQq96+BZtlN7go/QDv+USPg1o5lzZi3+SaCTZ/6H7NRJy3O0
	hxm9ERLqttjZ0cptzCfwSDsPcfxVm0P5Xj30E7EPp/pUy1WusDtUIvKZsTg+q8PETW+ujzV+hjc
	uyBoS7p44fBvDPQkrYftJ3kobcJQFEYfkdUln6a28z61AWUxXAWOrd367IfYRykg4bsWVLjbFTP
	U2Fc3lQ3oG1zLdjPaM5FIK2fkNX5MPuLuQryyioTL2xoNidWiv2fPAEYMSc
X-Received: by 2002:a17:907:d641:b0:c15:ca27:5818 with SMTP id
 a640c23a62f3a-c1f1eeaa320mr395955766b.28.1785153458189; Mon, 27 Jul 2026
 04:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026070925-delay-gauntlet-bc7c@gregkh> <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh> <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
 <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch> <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>
 <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch> <CAE2MWkmbdDrCw1HUKm17QG7dyihuxg_1VGTUNeBq9v8NVwJV3Q@mail.gmail.com>
 <20260719082223.GA1899043@shredder>
In-Reply-To: <20260719082223.GA1899043@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Mon, 27 Jul 2026 17:27:22 +0530
X-Gm-Features: AUfX_myN8vMPcj0vJcxFKIYLNoX74G7CTQydU2TzsiEAmJ7bTFLP5Hg7T5Y7VYE
Message-ID: <CAE2MWkmE3N6q=_bOv7AaMFS15+SizkzVQV-SCMumc-D1rWcv3A@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>, 
	Linux Stable <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> We asked to target these patches at net-next because they don't fix a
> regression (the encoding never worked correctly), so they are not
> relevant for stable. Users that require this functionality should
> upgrade to a new kernel that contains the patches.
>
Hmm, understood!

> Regarding the stable-specific patch, in my experience, stable
> maintainers don't accept such patches and prefer to backport patches
> from upstream, even if it results in more changes.

Then I feel we can skip the changes for stable now. Hi Greg, skip this
thread and the changes from it. Will be in touch!
