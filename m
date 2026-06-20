Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032C1519B4;
	Sat, 20 Jun 2026 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781958162; cv=none; b=XbpaoOB03gRukzm9i/1SzHUGn9PxJ5lDOhD41O2Yd1Ho1I36MCBaEcEPkP5PX18LWKdRDHbgj79gVvjua4Fy/wdodLFSC2wC7/j5dsWG1aJ70U33xW5iqXSd6levTvfBDzets0Mj5Pw+3hpJkp/fMYbqAqExWJyxnBnI57LXxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781958162; c=relaxed/simple;
	bh=z06SE+O4l1uGAOhNHtwzja9IB6q+7NywnrXY4VAhA4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKxtifTsEpOx4TxpRpRnnbw/XKB2GJdUMH1m8iPpnF8Ip9Xf6hM2MyOkbTwO1IoHKzErFrnOQlon/zUP7dbrNmXh6x51d+O/1TeaX1WI5Y53og6PyR2RvUkpQxfkEOHWAtJGNK4/WUVOjZcV0nmNPOekPg2feAIJKEONSCJLnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=owiumOIG; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="owiumOIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781958117;
	bh=eEa12VyWOAHw9CqaKZFjtIC6GC3hKtxVz3//tNqOK0c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=owiumOIGfmaNj4Mb2yeitidXINZnqM0RgxC69kjKqKb/8IOEluMUbjhsr2LFYlY3W
	 iRhEu/5BP7AqMhKgNHfCjbGKm2/cxPiyaDHntbVyBP3vHc4o0dXxMey9I9d/yLTTIX
	 rfM3ba37OOwZmJup6McySIK5d8B/G685vRmzPmaA=
X-QQ-mid: esmtpsz20t1781958101tde85a756
X-QQ-Originating-IP: nP3TNb6yzfWUz4A1IH3zVFz+MgH2sNiB95uBKV9/DYg=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Jun 2026 20:21:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9996273884252133458
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: michal.pecio@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	mathias.nyman@linux.intel.com,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] xhci: pci: Disable soft retry for Renesas uPD720201
Date: Sat, 20 Jun 2026 20:21:31 +0800
Message-ID: <DB886E067EE79C2A+20260620122131.4050642-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260619124234.0a9e4670.michal.pecio@gmail.com>
References: <20260619124234.0a9e4670.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NcfXIs+Ms1qHAGY9hd3YKAt7lQWCiV9g3+762jj9RJwIL8wNRpp2ummy
	uJsmKjMJ3pw/LBOzzBfcAYALM6KtPZx7bAcULRRgdXJ+OINyyhQ3caAPSvQznqZl8DcWL3P
	wXKAGST9NsFUOt1tLcnDMqB+YGy5u5dEWWI5XkvL5NEpED4diUfwQI6o/QqzrZMEqRFyXWF
	8TeHRLtHaxFcxqtHh6KojJu7bExKfwqst3dOwIIz+EEAQRww5Obv29Ht3LxNS1r3JUYUCFZ
	307mCqblJ9ZIMnJNNMB8NjFTr8y4Zf5f/NG6HiW80dIQpI3CphzAopiolvGAhA0TEJi5JNN
	bjZmMg0JAmYcFbyWk+/oCWeUFbVC+WbB2ZfbNs/uBRRTWimT/J4XmjiwvZULS0GKtsp5Xay
	u5sMkr5xFG/BknPCFTBfPNOAJ2cniVT0RHmPcykPnozllS+tYLgW7mF9PtDuSAvwQfNpGyn
	tumw/1sXcdkfBGpOGQEBSDYi9PJKV0Pe7LE8zmEr/gdKQNjewGTMC1+NuTsbWXHRdXSxJYJ
	gvVqw7tltgeWp01g5eSiYraMRPZgY9oVLLsM13xy1hRy34PNz2sGwqBCmfBBpvBFulxfns9
	DxUr7sZFmBfxerhGafH396FdZv9PpenLMIxzlNkW4GWW/L+6HXQkazQLYUbALVYQqAK5UZS
	30dXV49yMeovIz3/HOifAIoNtdTqm0P+Y5xFpAgbJ0Qeh6DauKDweI/kgdMpro1+kk3nA5Y
	qZIcRDLYN91+qef+MDn8s5gL6VGYYeRxbWyL4Sv21sREQyY6HqECzT9PZ1nP/M147plrFR7
	zgzJCUUGpgtrwf6BlCK8aGOOQl4cITxCCOAaGwqFhCbozi4AAf1F0yiGGHNBLn4tUUB9YXf
	tB6NLjed/2KPS++rBslPXXYtBjjfX+o/c1/KVDMrwyTDEge+YFwOn1Nq9Jjcw5e1L40vRcw
	VlHvIstyeZM1RNYVewcnGi/CrMShxzJNR4Oc40yCiGIk8NNE0CaH6yjG67WIwtgxtjxsdwv
	eAI48iW08JxxGOcBMuaF1k13uHNXZDf4zpW5ycGA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Hi Michal,

Thanks for testing this and for sharing the additional details.

> > > The host reports a transaction error on the RTL8153 interrupt
> > > endpoint, queues a soft reset, and later times out the Stop
> > > Endpoint command while disconnecting the device:
> > >
> > >    Transfer error for slot 8 ep 6 on endpoint
> > >    Soft-reset ep 6, slot 8
> > >    Ignoring reset ep completion code of 1
> > >    xHCI host not responding to stop endpoint command
> > >    xHCI host controller not responding, assume dead
> > >    HC died; cleaning up
>
> There is other stuff too, like concurrent teardown of a separate bulk
> endpoint, not yet sure what exactly breaks these chips.
>
> Would you mind to apply the attached debug patch, reproduce and post
> dmesg from your system for comparison?

Sure. I will apply the debug patch, reproduce the issue next week, and
provide the complete dmesg output for comparison.

> > While debugging this, did xHC controller otherwise seem somewhat
> > functional? Did you for example see port status change events, or
> > transfer events between queuing the stop endpoint command and the
> > timeout?
>
> Mouse continues to work until we kill the HC. And I can even abort the
> command, but then some URB is never given back, so teardown of the USB
> device gets stuck and IDK what would happen later.

I observed the same behavior on my system. During the roughly five
second interval between queuing the Stop Endpoint command and the
command timeout, the USB keyboard and mouse remain fully functional.
They stop working only after the timeout handler marks the host
controller dead and starts the host cleanup.

This suggests that the controller is still processing transfer events
for other endpoints while the Stop Endpoint command is stuck.

Thanks,
Xu Rao

