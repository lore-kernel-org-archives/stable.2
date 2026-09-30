Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED431D375
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754840; cv=none; b=UfKfBts/4rFyvWeH/cAOqYocG7NIZm5sq3XJxFB+hbzkBzBhmZ8kRuhlDNr9vda4i3gnVC/Fuz88XXvkZiJIRuoYwQi5lYTZIPY/uLg6NCuNA+0JzypahNVR4qicYCOX/uhvpMJ766r7ahPVsoL07hMr6XjsI8Lv14xWzBp2GJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754840; c=relaxed/simple;
	bh=kme3tdZ1U+Tgn9vwCyFoV3w7eCQqGn1Lw+epSPi0aO8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpY8StREFh2AH2CUCJSIAMk09BogjMWGCb7xsZVhXm77oJc2CGDpUnRzbWLosjDrydjPKmb30wF/CWZm0ex6Z2Iz3vwwn1v10/e+FRCW6EesNpifT6MvZ4n+0O4QjtjUBDfPlWhlTw+Ou2c+nV0AOX6NcbypQtQfP1usfwMs3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUUxkOtg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUUxkOtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDF31F00893
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790754839;
	bh=kme3tdZ1U+Tgn9vwCyFoV3w7eCQqGn1Lw+epSPi0aO8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ZUUxkOtgzhi1Q9N62ORXiHk/J3rf2zvdX2UOKTcMkQYhx9W0FZVO7uiIwJSBMjUCS
	 ttu09aKi/NMV640uKB02QdKg0C5urdSYtQXCkA7zxmsDhg0aa5qj8g7Uap/+2QeAYb
	 LIpk5dhMZjxezm6f3lq0m3eqskHddWL0BdYa5AiPBy8LoCk2Sg+bVBc8qLnk2HwgTF
	 3xGltqxpEDpwVtQsn5d6qzH/QIaHR+L3pMRKiTiRkI7/X2DWE07zwtc+oUl21UYMEj
	 rcERDx0VjDTXdcHUUT9jLDrlv1b4CLQa+ItiSiv5Bp+ZAlbB6FeKo7wq8V3C5cEbSN
	 LAV2PqPbYF6kQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3e27d525so262766e87.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:53:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx2X66yiI2LV5JVY64hch2RKeZ7Q1kNJ2mGQIa2zyl3Yk1PoE3Nfq61dTMOuiQmVY/LTXJKkKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDDNZiXF7/q/SBs0VbJPAw9/HwzFWdTVx2XJKnmR4uzZ0D8Of5
	JebeftZrcXqTqmQ+k1gOO9rmGVKkS6+7GVjTACF3pGdYy5GE+pO1lafQOm51DpKsDuuOd8PL+lB
	j8NK8Nk8IWVBufITm6RQh1CHwCPl5IRmRL340jTgosA==
X-Received: by 2002:a05:6512:31cf:b0:5ba:3c49:6ccf with SMTP id
 2adb3069b0e04-5ba402b853bmr239606e87.1.1790754837737; Wed, 30 Sep 2026
 00:53:57 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 00:53:55 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 00:53:55 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260929-gpio-shared-fwnode-lookup-v1-0-57d54811de1a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-gpio-shared-fwnode-lookup-v1-0-57d54811de1a@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 00:53:55 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mdrd+=5x7OBAK=EtjwtGH+rvJQk_GnzRXNnmzoDnUXBTw@mail.gmail.com>
X-Gm-Features: AclHuK-bKs-DiLDJzi14gqE5ctPrjcYpWHqNaXVB07vwyWRRN1rks3MP-AEwIX0
Message-ID: <CAMRc=Mdrd+=5x7OBAK=EtjwtGH+rvJQk_GnzRXNnmzoDnUXBTw@mail.gmail.com>
Subject: Re: [PATCH 0/2] gpio: shared: fix no-device, fwnode-based lookup
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sep 2026 14:32:02 +0200, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> said:
> Abel reported to me a crash on Eliza linked to fwnode GPIO lookup for
> shared GPIOs. The second patch fixes the issue, the first fixes another
> problem the clanker found during review.
>
> Tested that the issue no longer happens and that sharing of GPIOs still
> works on Qualcomm Eliza.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Please disregard this version. I need to account for multiple fwnode requests
for the same con_id which currently fails.

I'll send a v2.

Bart
