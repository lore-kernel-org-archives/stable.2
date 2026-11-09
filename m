Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239149;
	b=aluQFhPRsZ1Xj1hv8fm+a5fYY92jlXuS2WeVfJGbkQ/iRqbcIw3lnY20/ClH6DOZpYBP
	 xs4zhQ+W4C3eEXvBxBaAqwjhEoUb/6GtbkqmJ05UfeGiv5GV/+jjU+nw6Ec7fNeLiKGE2
	 sBuKYohWqEryP2b59s3c4sbZ+UsFDIEtoFDUtqZCuXmy8D82sfsQPlhnLU7jyF69y6RUx
	 E62DAx3wpzmTOkpElcQe7/5ElR6/IFpHa7WPa0OGmzM9/zyTuOfre4QU/Av5EC6SXGQyi
	 gaQvBQ5kTlbdEa+wPehosGIaOGm/HGm6l9Gflisl3P50qSZ1j/dNYeyGQcYa6CvRf1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239149;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=gzBEdLhuDNvl1oskW5HjpiceIPfKX4gTd0WFvHlJlcI=;
	b=E0+E1FRh/OwJnu7OWD6sEZF+B/20Qi6szs881ncowZh2UWJudy6pg1sPEJxKEfqjuxkU
	 /mhvURIoZUIc6+C8liFH9sM1Wpex3GfiuHy3+fs1nL7HdMJP+RAzUdq4FdQ/8uXSJIXLh
	 JT3BX18ASi5iQy4Vs3nCvNEnuSROkfl+m0tIKQYE05SLw+fXR063h6/qdsHyLFfFlLbEo
	 TdWF4/MNSf1FL+YQXaVMnixHxH43gk44Ms7cP3VLdF20Fn9ypty6AhxmyAx1B+jYa0c4Z
	 knH3pugpq3Q6tXtz/pgmxgSY1Lbp5xK03srMGLSDa6YPmSZo/3oKg/5JYYHswgshWWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSbNzEHG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB4606EEB7
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSbNzEHG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A801F008A1;
	Mon,  9 Nov 2026 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239148;
	bh=gzBEdLhuDNvl1oskW5HjpiceIPfKX4gTd0WFvHlJlcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZSbNzEHG9IIpUr6aL8NoNRF6KpUDk0bsxNMYk6HLSYH5aNK7xxUPW59mUC/BLFUoa
	 Xs58vNlVY2IDfPxVmO+hMRfqv8XsVsF+BHlJtCjcqoQ9YferiL3XKJw4jpOut8QWrS
	 zeD0GshA7/pQH363QHIQY6e1KpX6d9/Romcdhp4OrAJdBGwqi7/RqJn5+0VsRFvXkK
	 wctKcftWDiPY6LsUUIenIJt4/6V0MP3nHaLxPzp0PWb+DEhTtXRFq0m7k2s8O3b6Kt
	 NrdnrdOFJMwlNGW0PGQ2neeRDKtHEP92BEr//zNaaF/Z8lxsd8gn4pwk6L4SnJHdU6
	 68fmnRoUH9mNA==
From: Thomas Gleixner <tglx@kernel.org>
To: Igor Velkov <iav@iav.lv>
Cc: iav@iav.lv, Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y, 6.1.y, 5.15.y, 5.10.y] genirq/kexec: Do not take
 the bus lock of an interrupt chip on the crash path
In-Reply-To: <20261108-re-tglx-kexec-backport-6-6@iav.lv>
References: <20261107053823-failed-6.6-717862eac6ef@kernel.org>
 <877binwiyw.ffs@fw13> <20261108-re-tglx-kexec-backport-6-6@iav.lv>
Date: Mon, 09 Nov 2026 16:45:44 +0100
Message-ID: <87h5hquhxz.ffs@fw13>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 08 2026 at 19:50, Igor Velkov wrote:
>> -		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
>> +		ret = __irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
>
> This needs desc, not i: __irq_set_irqchip_state() takes a struct irq_desc *.

I'm an idiot.

