Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FEE39CD02;
	Sat,  1 Aug 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548424; cv=none; b=SQQtX/ztWA5Gp5gwzwvGK03Ximem1ZqLQYnvogGlQNXNi9bxORtSj+ipOgvjnCMJ6TDPYk8NsZwoAreAKNO1HBouA/2NKQzemiS0vAunCo94nMGKJTdKvj9tV6bvwIPV0WyvgsAXVX4S3BtU+pKtpdOy4B1bzAIYJGgyF2+RUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548424; c=relaxed/simple;
	bh=ST0h2x06Xwc755aSjCRANrMjKXZx/VQqczRH7VaVIII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoKeX7vzomcgo0RY0XmqKqvDzBLemiWA8jJOgJVo6J17ZyEmUfLWPhglhrrZfFZmQjCeqPpPgr03sEozFBxBfsTD2SHRhuj/dLC8MHAl26JPFMW9dWyGHdG/Qzh3SsiUFH+/bs6n3M3INy+iDQxjCtd53SQHMBKz/I6xSC3UgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmQjKhzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmQjKhzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618491F00ACF;
	Sat,  1 Aug 2026 01:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548421;
	bh=EvogDc+M75b9b3TPBdsSj8jbjbVAHwKKv/rtp15v1+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HmQjKhzn/ZdYh8Sui5um9Q0RA+TgaAE2s/ZXntGsD2jWVfbxEbloW8/EeZsMdPxHa
	 hQ+JaxgkEWH53qtXb//z683yN7qaCdD6PID52wlEZqEVKxS8ZpFZ9ITzk5YgQLzL+7
	 EBpXuUgYnDP8Q1W+DLkVxH2WfxWVJEHLgJoWzK+pQyELTnEh8zcz+3iX5cEGuHHMKS
	 DM1TlQxApWKmZp4uN8sdVsxDqzrkXyeaAR8dWmyPRyMK7eFzrvXZ2hYRZCkIZhVj11
	 9k+B9dZEgH4gPOvjNJ0G8iRBViCl2cBItlf7mhsKdXL5+QO9BtDuhi5zNWmGrvvdLy
	 mwJso9j4l2Agg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH stable 6.18 0/2] Kunit backports for older systems
Date: Fri, 31 Jul 2026 21:40:10 -0400
Message-ID: <20260731211008.stable-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
References: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 12:03:27PM -0700, Florian Fainelli wrote:
> David Gow (1):
>   kunit: tool: Terminate kernel under test on SIGINT
>
> Shuvam Pandey (1):
>   kunit: tool: skip stty when stdin is not a tty

Both of these are already queued for 6.18 as plain cherry-picks, so
there's nothing to do here - no need to respin. Thanks!

-- 
Thanks,
Sasha
