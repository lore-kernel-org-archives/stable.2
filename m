Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937C3515E6;
	Mon, 21 Sep 2026 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990226; cv=none; b=H4VpBjJKl7oKyjNHxvAHj4xNk80Meh/Z5uH31PXXnK0qVEU8Uu66gBJehwXiKH64I1mr9Jhl3tRdtkdszgENT+neZobwiGa+eQ202gn7YHv3tYgIPjZjJsJJZbt5i5xRvS9h30MMmN2bRf6ifloKVbaCu3PveEzOhrJUpRnp+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990226; c=relaxed/simple;
	bh=18cCMPilsRUYuiHgtZ4z7dDpI6Ppa0jwDYnxvbfdWl4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WTHnpZMkYl3nPmujY/jVgbadlAIxuWGMDm8wbDT89RdR8mTgq/niL0nnPATQVjqXdQ0AmWX1jgnHLPC+QPjIg0p2l0qdPAKclhvNnOdSkpPZ7XnOOkQC74TxhNrqPbkVs+p9nM6aySGBhwuECDr+7ndXyIuFkJG6vvJAZVq/8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=E6XaliZR; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="E6XaliZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789990222; x=1790595022; i=markus.elfring@web.de;
	bh=RSpXnzktNavmcWvFOJG7CqU76cWDLD9tgkhka+ZQM4Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E6XaliZRMCNXYGBGyAzOAvFfCHwz/bmB/64eJAOsO1J2zfqdUB+UXtoBzHuKkpDZ
	 iEjT80v0yo0jQWn1NHHwschFItazfFSv/tIWwDvQH/gya16fe0U/iiwqeTCuwBizx
	 tY5Wz+AyVcVHibMvd7j26e7RYuS/Ae92Y/xmkUB5Z7JyTVmG/YxyItHMDRTSQUsO2
	 zWODqs4Hdz4eIy2TQFgxrwaArD9pxshkZQgvUkLXq1Vtd/fE+1qdTn10mwXP85MZk
	 4ftDS35O12Q6PCxZwvlKxpcfPXhY96BOVDSKD0D39GlJsB96+/o0Iz1AKvnN7nNAo
	 sCpKJr7TwY8ad1U9Ag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL4Y-1wwWss1nEK-009aP0; Mon, 21
 Sep 2026 13:30:22 +0200
Message-ID: <4d1536a9-6836-430b-a84d-aaa19f6af9c6@web.de>
Date: Mon, 21 Sep 2026 13:30:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guangshuo Li <lgs201920130244@gmail.com>,
 kernel-janitors@vger.kernel.org, Dan Williams <djbw@kernel.org>,
 Kees Cook <kees@kernel.org>, Maciej Sosnowski <maciej.sosnowski@intel.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260919175925.3739806-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] dca: fix provider device memory leak on domain allocation
 failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260919175925.3739806-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E9BUn34A1IfG7EOvw63uPGD/6i7Df4b0xAGg7dSoB+tPzwIrRBC
 2DGbBlK4t9opi0Uxiye+h4KfPMlIvWoGOvm6Mx+ycPcTSH9kdzaQNwSpLHlNM/NvyMqEk0V
 RftYbzTs0YM101jK4na2VM/FdzIMUJQ5ulD6u7BhuisazyoeRuaUC2PcT5b5jXiyebavnoE
 o16Srr/j8veQeoWZWxFkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aKQbupmJN/E=;2UUdxqXMOcDbaK1eiBwsYgcvCUC
 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
 Rx7/bm3gKCKDwabp5/+TPo

=E2=80=A6
> +++ b/drivers/dca/dca-core.c
> @@ -368,8 +368,11 @@ int register_dca_provider(struct dca_provider *dca,=
 struct device *dev)
>  		raw_spin_unlock_irqrestore(&dca_lock, flags);
>  		rc =3D dca_pci_rc_from_dev(dev);
>  		newdomain =3D dca_allocate_domain(rc);
> -		if (!newdomain)
> +		if (!newdomain) {
> +			dca_sysfs_remove_provider(dca);
>  			return -ENODEV;
> +		}
> +
>  		raw_spin_lock_irqsave(&dca_lock, flags);
=E2=80=A6

Please avoid a bit of duplicate source code in this function implementatio=
n
by using another goto chain.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.3-rc4#n572

https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/dca/dca-core.c#L3=
35-L389

Regards,
Markus
