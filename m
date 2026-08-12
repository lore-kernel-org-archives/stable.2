Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709B3128D7;
	Wed, 12 Aug 2026 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515265; cv=none; b=UHZBzzeH4djACQA77OBJVAguin6uetGEhWf7eqgRRLcZ6GVCi4y6yufdcsO3s0FpDPBfohosUC/XKb2cbNwYFASZu52XSlLS3ZzXAoGYZhw6mpoINxNDaB1KX5qIbW/QsvesoyDkX4SkcqLs79zohcpcy5VQqVvms1ftxpoMizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515265; c=relaxed/simple;
	bh=fQ4oko5wF5ZBxDaB9YE4n5V9QWQ/YrKSqgnhbaA330Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=XTfo+G7DUgbf5D7hzXpExiobZmOCHgORyGHt1gEBrRZiU8ylrh3V0111SHXkQqna+gP581J9gvuK3qAaTV/ylZXT4JmLRCWi0YGTPRrUwDHEaGBatgSKP3lfMufy0oQNocd+J0ZIXqSSQUPAhE9Gn9abAADCB0rVUnbeuvSG32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 1E437111;
	Wed, 12 Aug 2026 08:14:19 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 08:14:18 +0200
Message-Id: <DKMQSZRM4QEZ.2EXQD5U58EVTI@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: scope the exclusive RWW lock
Cc: <pratyush@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
 <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>,
 <stable@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Runyu Xiao"
 <runyu.xiao@seu.edu.cn>
X-Mailer: aerc 0.20.0
References: <20260809084223.3596259-1-runyu.xiao@seu.edu.cn>
 <DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org>
 <6e208a8b-da11-4ba1-adfc-f1e80c891310@linaro.org>
In-Reply-To: <6e208a8b-da11-4ba1-adfc-f1e80c891310@linaro.org>

On Tue Aug 11, 2026 at 12:05 PM CEST, Tudor Ambarus wrote:
>
>
> On 8/10/26 11:25 AM, Michael Walle wrote:
>> Tudor, do
>> you know why you've omitted the guard() in spi_nor_rww_start_exclusive()=
?
>
> because using guard changes the behavior of the code.

But that commit removed the mutex_unlock(), thus keeping the lock.
That wasn't the case before the commit. IMHO the Fixes: tag is
correct.

-michael
