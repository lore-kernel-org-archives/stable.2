Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594794;
	b=DsG6NG8k9sX8o+36Omw+Qk64rr1CC0Tb5lLtyFh1BkZbaMOUYNcvJppapBZbqaklitby
	 ezEaD3yJ4c3hkiMARYIIZ2s5XAvlrgw85/JrSuWv5/4v1isTsoodyoKUVtKVutQwF6AAX
	 U3wNiiXJoAmGbwAD0nxpAiCA1bhXHWqUUbQwWi1gCA97xgwmFWWZPbz7r8jkDZQg9N1tf
	 jTJWCHyDsFZsVOMrhwB5J73XtFM3kY4OQ1BAHaKVS9LekEYWfJ2TZ2rHq2rVPhXjDw8sw
	 vxs97nscYmsgQfmuKSg+ziSe3W7XD7n0OyrtRCcahsavc5dPG6PckmAPSQWtoxOVRFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594794;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=xu5nzEsZd0l35GVhHFCh0SlG77LpEEgxmOzFQfr3Xr4=;
	b=ink/Y4RKMlz7uWsFtvn62TX4tueUErxPRthCItsYePhXdJDSbp27+TjwGpfAfpzgHEMi
	 g76UzxKq3bbVQCYWTXwGzHDjwQHIk9Yryb2kVJ0dY41xDgF1ACLM/9TWIONd9oc54gqWu
	 FXFOYCHRpDOmKyXU9BYd4xySz04jPyIxlT7NiRaWsqX4wIyOh9EajbGsKVLeCQR4W4Bf1
	 +TvokyG/0t53cMn06J8vvoNajU9Jwi/h4GouPF7vCIm9ZFdsGNXNeHtOXUWQc6dzf1cMB
	 WPUeyX3pWsJqXkgJSqK6LHl7e2fkO7S/BEUTrvqFSWU3EyJROZK01qy9fiMdEV2ah6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=UDXCoVVT;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8959A606A31E;
	Wed, 25 Nov 2026 08:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8959A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=UDXCoVVT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795594758;
	bh=xu5nzEsZd0l35GVhHFCh0SlG77LpEEgxmOzFQfr3Xr4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UDXCoVVTDgdKi8dBF1232bxuyGzzv3SqbF/heeBPfMQQ0dcbSjB7YGgD4Tysny147
	 01zhOwXX/QdiVl+ANhmlLmP9hEDjSu9aDObXu+GFpWIW1XuVAKsKl3QRXYhM/tI0oa
	 DNZPjM22hxtdL0DMBjAh1S4fDIxFll2ks77vbC60=
X-QQ-mid: zesmtpsz6t1795594751t2eb92d61
X-QQ-Originating-IP: qqS8CVJIZvW3wddgupBQu1lX3rm7FFgkSfJu9wwGnEM=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Nov 2026 16:18:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8163225211566540910
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: raoxu@uniontech.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	peter.chen@kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH] usb: cdnsp: fix NULL pointer dereference during system resume
Date: Wed, 25 Nov 2026 16:18:31 +0800
Message-ID: <961901B5BBBE3741+20261125081830.304847-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7B818A718E70C344+20261125080021.3907332-1-raoxu@uniontech.com>
References: <7B818A718E70C344+20261125080021.3907332-1-raoxu@uniontech.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Ntq8+Af3r9XFXzCz68jJstO4wYtttlyMQ3FYw7g+ltVo3fOrna9XeAW2
	7lbjWDLY50gIaEcGq30GgyxvKFMOn742oTK3BgROYdvxMgVV9nBkXoaDyjwhVwAKMFwMuNQ
	Kkt6+SPGXpcL1RRLxuV1swcNaVfydpwFTR7gAMwmmp+9MByZai04L6mzy7c6RsXaw0vo3Y2
	XdDjKjEpBMiDa3upfk+DwOj68hjwRqrAkWDRprThiIieLgChl+GqSdKpqMhsSPwTEl5cLob
	asshj/DJ8fTOz54aXkC5xtjeeqdaWMOF2pgTRSASy5ovwCNmv3ZcOrOoCTCJjIOQ7PjfEYC
	ifKndVTYsKVnMahA2e/aT7tgXB394nX2XhPSMUvU19T2yhWayRhT1Py7ASKOvRgc3pKXkq1
	V3CIEF4bVk8/fpHky423nimi66nXBHjxj7tK4R6k9i9CaTdn+H3FkJ/8NRgMSAqDu4LaZyq
	Iwp4NI6dER8SvyaM8BtJaCeCE6rl2GIeDZMgznEK1pB6+qkdHAaQe9hT+MbZyvb+7Hey+QR
	7FLvBMl6GxGOgPH2bnPWdDwktnTCEL8uSIWe4yYgzmqZ45PDSHIERH4tB5akhLcfFoBfRtS
	RS8I0ClQCF1TPR5TXmywQYzy0AGiEjPz/iihXFfAss5Dt7hRJWG2hLjussPURvRAb/pcv0Y
	WW2VeBGQHrG/8f8yZAQO4yz+KDQQig4Bod42jR83cOndWGsSlhc9wbG7gf6Qphg0bokcU4B
	L/dGqvLefmSu+Oz+m8R/9+FMmAMWuapetnqdZUI9gqQD/uBvq5ydgOcHz9DRU1bXeyGRN2n
	HHiNdtYLwXPI+V8RbyAHG8BpvhjZvX3qxhWMyBUL1QY+WX8umIMt8yWF0b7IWHSUGNaJn3L
	Kwp/yf0BL5aMHH/AnyKRfriSDO1hApqenAvWdl2+RwmTri8m1BdVK/pFsBGUC2hp9BeywT/
	pni+yqrzGzK+Z0cBu3um+7JBfd8X39iCge598U+nDfiHol0IQPVYT6C8Jq0qs3QodbE2shr
	x2YNMcNzKNFARed6L+qP7QVznRny3Z6x8U7HtYoQA9WSWCkPA2TGEyS68v7IlICBXLHPwKX
	TfKykIo/BDw
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

> cdnsp_gadget_suspend() now always disconnects the gadget and stops
> the controller, even when the link is already in U3. cdnsp_stop()
> disables the slot and clears active_port, but leaves the cached
> link_state unchanged.
> 
> If the controller retains its context across system suspend,
> cdnsp_gadget_resume() may call __cdnsp_gadget_wakeup() based on
> the stale U3 state. This dereferences active_port, which is NULL.
> Port-status event handling cannot restore active_port at this
> point because resume holds pdev->lock.
> 
> Remove the obsolete wakeup call from the resume path. The previous
> connection has already been torn down during suspend, and
> cdnsp_run() puts the enabled ports into RXDETECT. Let normal
> port-status event handling establish the new connection.
> 
> Fixes: eae6460f6173 ("usb: cdnsp: fix wakeup from S3 after controller context loss")
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/usb/cdns3/cdnsp-gadget.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 2830b595d632..350e45f511f5 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -2160,9 +2160,6 @@ static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)
> 
>  	ret = cdnsp_run(pdev, max_speed);
> 
> -	if (!context_lost && pdev->link_state == XDEV_U3)
> -		__cdnsp_gadget_wakeup(pdev);
> -
>  unlock:
>  	spin_unlock_irqrestore(&pdev->lock, flags);

Reviewed-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan
