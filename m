Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE42F7F00;
	Fri, 14 Aug 2026 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672089; cv=none; b=MMWkn2970QBG5woTjW7q1mCgowftIENVyTRofYTzBn56uMRSwu7Tf4jql0o7wbnESMcG1jUCOPQ7OsMQSq/RuSIl2zSvz4eHparuriIT7sYWq7cFTbYk9IN7reLsuHbLFyfZJ/eUnSvYLIYPr46uNzWBZemZhwvuiYa2Ej+/gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672089; c=relaxed/simple;
	bh=Npm1VJwOUjR3nAJW9jyBhnhhNvzReghvRrGLQNnz6us=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/2NRBkFMDVGP43CDeMQdhvzrwi+gFdtF66m/WAfXfaLH66g7N87kb0tycWJWc88uCyeDzRmrPC7wVJiuJDS+8vouvub0ZmrpPpl1DXMPVZDpPEqssZ3W4QPmiJ0rXTxcNHdS70887uIyzXBSMdVXGM8JEcvYI2ZviL5oNL9mFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync9t1786672069t3e22f4ae
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.185.99])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6294584403336118590
To: <diegomancera.dev@gmail.com>,
	<mengyuanlou@net-swift.com>
Cc: <netdev@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <CALruWrXs490+d7tx82mLG3rmH_H-svkwA=zXggr0qOeEhG3GmA@mail.gmail.com>
In-Reply-To: <CALruWrXs490+d7tx82mLG3rmH_H-svkwA=zXggr0qOeEhG3GmA@mail.gmail.com>
Subject: RE: [PATCH] net: txgbe: use vector 0 for misc interrupts without MSI-X
Date: Fri, 14 Aug 2026 09:47:49 +0800
Message-ID: <000a01dd2b8e$e95b5450$bc11fcf0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQC5ugZ0JSr9nHsiDy822BEagLVNa7jjqH9A
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MJoD6689lyY1jXJuXQzHKyHhZcnRErh+CJSHDIulcew3zHGo/d6nYWjE
	uNP7xaLvsApekYDM6S8GPTfVyf0+9IC48/hIf+iPj4sLaO7+tcNV/f+dAzJhSKZQlUk1MDf
	zIP8bvNJMkIyUyeZBZOgW2SPTOSu0RdlFoA1CureQCeK8Jc4qIg+Z+Fm0fARf8EHCQFjyjP
	sMSGhheeKA2FUMippjnXvWRc1iFdW5/keRW4CBURNnokUGZRAamkeAbwL7Lv1Gzr+CGFMvZ
	4bnJ7F3OkBNbIkLGWonRBWLuIYb/+qQvy43c1jy1YYfEInwIITcb/pdj1Yqeoa9jYv2GLkt
	n1ieI/vTK6OS22ZBqbGHWMYv3WZ6qHtoce8SfX/6EQ9gjeakPfUBneCC2qCTHUmzIBoGig6
	NUdCMLOmqISPQwWvjXrasa7c8+hD4yuEYVV+mOdO3FSEsZKkEPI6iO+CBl3JbN13vinY5qd
	tFtnoWj8EIMQGH+1UHrj+jootpfeu5+yx9LdhAZwKk0NFgFO1aBHFrNAPY2IgDP/IWhE/CA
	8KvIO+p06Vy4v+crfFItn9CVxtL2swnfteD0zGN3dK/BZq993CcO2+bbG/J9AIozwoLd+4m
	B/6i1RLgls2eAh8uCU/jfWW8gPDzzXTzKhRtylzISkwvrGeB4MAWN/38NUobUzXCWOcg6fd
	zh/Ic7aqfzxH3p/OdRUc2DmSGOUOqrz2tIpPZv0nRafVWwEYWzCDS/3w/Efd90vrzcL6w32
	JyrfyGeB/SLDPsWgQSBlQuMFIjJbRUUbSRq0I9UCMpM42Y/giYLYqQWua2m7EQ7pPbd5zcd
	8nmFBj+hwVCzH1/8FY5XGh4hn03trycIJZKNp3qLM7YUBTHAZ0L4X1B9cDT+TL9JsO+cZJ5
	Sj52lN3BqtqF5oaZo1il4Gh/ivSW/awRDAnnPEJFzFRJSx4Gxrnm3dW4chsDgcxGYRjV41X
	EgyPvRdKgHdcc3o4HLy9LN2jiD3LIp5hVHpfdqepgaAFVFz/feFR71E/gO07qZ1f9ABeXKM
	My9vmUVfdwIv6E9NfF4dfffcR0EKaUN5KHpzq8dt8YS9+upEscxpgSAbmpj9hf4psCFJ69x
	+k/aSTysrU2J0q3sD3wS4OVPgtmVnqTdP/qguQWTSd3JerAdGsDSTM=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On Fri, Aug 14, 2026 8:13 AM, diegomancera.dev@gmail.com wrote:
> In non-MSI-X mode, queue and miscellaneous interrupts share vector 0.
> TXGBE_INTR_MISC(wx) instead selects the MSI-X-only miscellaneous vector,
> leaving vector 0 masked after it is serviced. Use BIT(0) for the
> non-MSI-X fallback at each miscellaneous interrupt unmask site.

Hi,

Thanks for the fix. I've already submitted the relevant patch[1].

[1] https://lore.kernel.org/all/59215DA27859BC49+20260813073305.360251-1-jiawenwu@trustnetic.com

> Fixes: e37546ad1f9b ("net: wangxun: revert the adjustment of the IRQ
> vector sequence")
> Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> index 8746318ad3bc..6b5542cb2161 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> @@ -31,7 +31,10 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
>  	wr32(wx, WX_PX_MISC_IEN, misc_ien);
> 
>  	/* unmask interrupt */
> -	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
> +	if (wx->pdev->msix_enabled)
> +		wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
> +	else
> +		wx_intr_enable(wx, BIT(0));
>  	if (queues)
>  		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
>  }
> @@ -183,7 +186,10 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int
> irq, void *data)
>  		nhandled++;
>  	}
> 
> -	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
> +	if (wx->pdev->msix_enabled)
> +		wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
> +	else
> +		wx_intr_enable(wx, BIT(0));
>  	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
>  }
> --
> 2.54.0.windows.1

