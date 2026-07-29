Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F12D46A1
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295081; cv=none; b=J8D7EOGMkGvO57+DCeBxY4lsfvVFf7vEYmdJ/RRaLdIAZkj/C3VUCXoFceGqDJUze52YcSrJolVFqxULfmrzfVj4CiX/EcrrCTKtpY3ms/WuvO1CbcPr2B4V45I9JSmKJR1U3KO2jsgT27wKo6YoJwhpxwkXrldK0CzLUS9ouOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295081; c=relaxed/simple;
	bh=GQwpRzCgdDAtkQ/lbBEGmTbrWFm7TQU8R+OVn8q8NXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw2nwOvCDjKCJ5T3qv4gJfQHflH32wnzhdFjuUEbKdJ0i+4UK7cK6QR2YJFOdhjOV88IHrAqU5galimGn9mnH/Fe46FfCBjLHgy7ZfWrhYmKFpb95DPA49ynwmq72OTFZHlv4Hyw78U6rjIHyyF5wLu5cxk0J0Z45ae3L7rRvzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S48vbH4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S48vbH4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763F41F00A3A;
	Wed, 29 Jul 2026 03:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785295080;
	bh=w6igIDwgI5emoH6B2L8HmRmQ9CoQDDBDMkELp8aykhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S48vbH4guswQJ3cUWRiNK7dc+NKYyvukMhUqelzCgrJXPEMpKrd8/9/Z+68FFuCcP
	 L2C8O4OVgEQ78w6IKIcBcfMoU3/YkwjmEcRNRJCjhULR3E5hR7qxAofJvOohw00Yzr
	 ubDPSFJb3/cB/RB7rFAB75JuA2sL0m89BjaooB34OQRsf+C2QTKvTLL+pYnA1qYSUj
	 Utd3CirY12yYGVax+4fTRuhfHbfTi562EUH9GyeadIZeXFLnKPbaMCk1X0OrYHS8G8
	 3YW0JVB1ZHGQToB6GsPbZylSmOFyJ9ABkF9cUcJirzPl/OJlTsYHh7dwtI1vhZtGwu
	 tU9sUyGepjlfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5.15.y v2 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
Date: Tue, 28 Jul 2026 23:17:54 -0400
Message-ID: <20260728225510.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728163944.24110-1-socketcan@hartkopp.net>
References: <20260728163944.24110-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 68973f9db76144825e4f35dfdc80fb8279eb2d57 upstream.
>
> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> synchronize_rcu()") replaced synchronize_rcu() in bcm_delete_rx_op()
> with call_rcu() and introduced the RX_NO_AUTOTIMER flag.

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
