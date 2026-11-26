Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713139;
	b=z6MBHHA7zGqGfo60ezwQTEdut2Qp3bYqhDs5LOTH3xh6bwlVxSMV6st2bdx6lKm4ZLk4
	 ha1D2g3kRWLVtntU2CqgJdEHvnet0Ojrw/bSrlqjx/NcMn5hytkUOLpvYJrJ/eiuDaO9z
	 WISHNjqqf/0IhkSp3kBqmcV2rnNynCG4O/UuPGkZxpPtMleHtiDUS0g11LSrJMSjh4SSU
	 zokuK5RHndiz1GGrMEbeKk/YBFtgO2JQ8G1YtwgD0L+niMoOiN95MqCjS+pZ80hQVXY1a
	 FA+su8/HH6zjKofy1cC2437nmgsntZ2jN2GtBior00bJrDODa1XbSwUbCoODEAH8RoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713139;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=NRZwYYtJY1FBmZapDven7z6o3IJs9tgIYt6fVrFcmSg=;
	b=v0YagpTIZ9d1Q+juPvEpo7qx07xVpShAIH569xSbSF0aZSApu3iHtLQrL7c+Fwsb4ojK
	 YZo+EzD/W+OKHmv3m5W/kvRc2iaFpZMVjKC6pvl7jXlTBwRDvNRxVGoUNaTtbIEp6zncD
	 8I1mIbhpcsBr5M4tl10s4pYuSNSXOTSPjpi0FQoIRHb50DObdDjjEfYFmx3xJF9Cn0v9P
	 5YTjqeBtGESy7VqjNI3yPhP3t5hxz8v0q+gwzh2ETiWhPpPkPdI2A/ukav05B7S0Gx5L2
	 +sk/Kkib/bxmBVnxW5Vj3+AiUdkFiL0OplhyDK7dWADHHcmmULC6yFocWWrT9d7wIHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5oHTCud;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EA1606A31C;
	Thu, 26 Nov 2026 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5oHTCud
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FA71F000CA;
	Thu, 26 Nov 2026 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713138;
	bh=NRZwYYtJY1FBmZapDven7z6o3IJs9tgIYt6fVrFcmSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K5oHTCudkOQtURtEXGSjrRALJorjM8pmTyWJ4CCTe/gkJ3Gi72icFLQv/FSVPfYhA
	 NwHVoWkVytNi7TSC89s4jjsSUEtIK1C67agHtXbl38xMoQPfBbxMPnWikLacyKJcQ7
	 iKFIi9LL6juWBsMTiKd1YQxvmej/q3sSWcIBCUc6lxj/K3sPHbCsekLVr02hOcKCt2
	 3lRNO+BuMzff45rhspJgzWEZfifNVSH2NXhz/ItQhD9dmJIXVF25D4ytZIUECdYJyQ
	 F5uln5ry7spXmtHA9w+xvxYhb2/U3pSjUV+xTBzcnsLtN9YzKimIt9SlEBxi6ED+D8
	 ++OJFFq4QtJDw==
Message-ID: <f833e17b-3a30-46c8-aac9-060157cc6973@kernel.org>
Date: Thu, 26 Nov 2026 19:12:14 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/14] PCI: rzg3s-host: Create the INTx IRQ domain
 before setting the chained handlers
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-5-claudiu.beznea@kernel.org>
 <179562505368.5580.2150497706749194750.b4-reply@b4>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <179562505368.5580.2150497706749194750.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/26 18:44, Manivannan Sadhasivam wrote:
> On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> rzg3s_pcie_init_irqdomain() installs the chained INTx handlers before
>> creating the INTx IRQ domain. irq_set_chained_handler_and_data() also
>> enables the interrupt, so an INTx interrupt arriving in between is
>> handled by rzg3s_pcie_intx_irq_handler() while host->intx_domain is
>> still NULL, leading to a NULL pointer dereference.
>>
> 
> Did you observe the NULL ptr dereference on the device or just figuring it out
> from the code? If you have seen it, please include the log, otherwise just state
> it that it could be possible.
I haven't reproduce it. Will mention it in the patch description.

Thank you for your review,
Claudiu
