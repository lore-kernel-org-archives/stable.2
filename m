Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B1272E56
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966330; cv=none; b=cyT8QcE5Ky4zaiLdoXEHc7mLWXdHQvF7Xk5BLh5T/KO9AQPyz+IedhftF5AY9U/pXRzYnuOwEUJdKesnxLM+9odHpuqg8GFHUTWtP7ZjH3CLIOVXDjOUVc4T9X8tfpZ5h/W5c/9zXyjdCZaByo83ai7hEI3yFYGb12ALIxEnM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966330; c=relaxed/simple;
	bh=crSwYXviOeKV5ydXTcXL3L3beLqw5FLC2sglj/GcRus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RW/KiUT+tNw9hYGG0rBLQRCGkY9ZmiRIK2muuY7DEDhEgTXVZsRks6tzqUafW5Xs96m3ga7bgGtlj7Tgu8Jx/O7JHUeOTL6/Ih5JL6mpI2+9Ia/k0Eemgfr9rmqAuCp1+LeeSzYK93llTeQK2OlaWprcjromoKbDdkklB5MnKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1CCj2tt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1CCj2tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576C21F00899;
	Tue,  9 Jun 2026 00:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966329;
	bh=crSwYXviOeKV5ydXTcXL3L3beLqw5FLC2sglj/GcRus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g1CCj2ttyN5nY9htFGHY+4f7rhLZ9aZVpxiq3xZYYIa0+O4s0NMwKzUasUXRJ9sKl
	 hJ6H1Ntm3mA5XYj5D3X101KuUlR7vqcpEE69CB13gwUKvLGq8f4bsHoS6A/n5hZ4Sc
	 h4iCZh5gVPe8hQ/gJvbybzVOGX3FSkfZUi42QzZ4M0BNcICEXvbyqYBHnhojBPZ/Kj
	 AZbNlIWCG3ZJLW/XLCAcdH13eLMCL+akYgUXKjrrmzQIL/SmUX4TjAwnSVNB8qaZu2
	 lc0v3tIZMOn9YN1Qb2iQH4yTfjoSAmq1h8vRxX/ONT7UaxirloQqAeGYymZNffL1rz
	 OV6LosHnyihvA==
From: Sasha Levin <sashal@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y] USB: serial: mct_u232: fix memory corruption with small endpoint
Date: Mon,  8 Jun 2026 20:51:49 -0400
Message-ID: <20260608-stable-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aiZlktxkHGdTmi2y@hovoldconsulting.com>
References: <2026060400-renewal-coagulant-3a75@gregkh> <20260604121133.2771807-1-johan@kernel.org> <20260605-stable-reply-0009@kernel.org> <aiZlktxkHGdTmi2y@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I forgot to mention it here, but this one should also apply to the older
> trees (I just verified on 5.10).

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10 as well, thanks.

--
Thanks,
Sasha
