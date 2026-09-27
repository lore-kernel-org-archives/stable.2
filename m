Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2537DE8D;
	Sun, 27 Sep 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509241; cv=none; b=n4xJvsmMqe+BnGSi84yUezKwEo9K0swyVXZA5Y2j/q4vQk6JWc3ULBngYPmCl4dP1NXP7c0S7hcopvAXit6DGr5X9kH/6Cu6yOkErikjOCus97hZgPdoVXrL7NPviKQZvze5lhNvfhKrAGujg9xdN8DHpp/aWoQQWs+DuPadv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509241; c=relaxed/simple;
	bh=xp1IDY6mH5cFU1zGiZUUIq0UHnnp9rboVRAuqe0oQkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK+8xRVtzluxWwT9Bvu8Elu4lyKOuXM6jJiD0obdz0p9pIRdR6V8jEqWvB0VFO8Q52Uoj/O+3uWyN77po+d0XD1m+olJIaDOs1NxnU8CBRdx6oC9N1UJMKyeu0yGsY4qz7OBSSsF5Hm9E1JJryjfMgmaNgI4HO1wMUj63qjoLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZk/je4r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZk/je4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A972D1F000FF;
	Sun, 27 Sep 2026 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790509239;
	bh=vmbMvMbNo21iDIQcPjYiZ8rxZbILeVSsn31zI9BczIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FZk/je4ruH0VKxzN7nZdZENF9BdMt81miKiYG40Kbr3s+9s2grquDGd+Lyz4MPjyO
	 uWMLZqN3+ltV+QR9jcceqmehRMiAbsLI5Y6wXXDb98IGn6ddbn5YIT5HgG8Rpj4qaO
	 DtjVVTVDBCF8Eh0r+oDumhe7om23JSo+Afej2FZNb0ya/dXKwQ0NgKBxJeGOqR1pAy
	 9RnTKgnhktjFOsz4X1DkOVG1Ze7j9RSQcrnHDAMApESxGFDCU1c2pW8UZgt3h2FtBg
	 zbHE7j6aca/hbFfkQmj2ds/0JAFcBJ5eeLFQS8BaVrRc4QYl6MOQGnjjHo2V3HRaS7
	 Y8GoTGlBrnb2A==
Date: Sun, 27 Sep 2026 13:40:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Raviteja Narayanam <raviteja.narayanam@xilinx.com>, 
	Wolfram Sang <wsa@kernel.org>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [SPAM] [PATCH v7 0/3] i2c: xiic: fix SMBus block read and PEC
 support
Message-ID: <arkAZJEJTtNsCjmF@zenone.zhora.eu>
References: <20260924-i2c-xiic-v7-0-df7e752332ef@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-i2c-xiic-v7-0-df7e752332ef@nexthop.ai>

Hi Abdurraham,

> Abdurrahman Hussain (3):
>       i2c: xiic: preserve PEC byte length in SMBus block read setup
>       i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
>       i2c: xiic: don't clobber msg->len to signal block-read completion

pushed to i2c/i2c-fixes-2.

Thanks,
Andi
