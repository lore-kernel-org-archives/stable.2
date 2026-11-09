Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239626;
	b=h67/1bKdSQD6fVOt4NQKtmi+bytJhKA8mM9lEhDY3h7WBESbI/Iczao9Rs3ZQSC3NzYv
	 ajE4u9KCgcmQvPsO+dHp59NHTo7Uyw9Do0zqVQutoLqF3PcXPt/dXd1DqxIazy4vkGYtn
	 tBgr/nW3ZyN/y99PYtBTtZG+PeqLb3S76QrdWghKK6iRMv6ZlP7pDel7oQvUErx50Zrja
	 CI0nMUZprABLp9+VvR6Z9Wfp88/iYLTRG1ckHQcwUVuauntIT7n9xGbR6jdPuShAbVL2Y
	 IGse/l0xHnNnrLYJDQgKHs/4kctG148py66ArfLWZMf+CVnKQSOMS6I8zPBDrmbpUqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kHqHs9zHVuR6E/aYiGkcWflDQPWNMfp2CtizhRwYwDI=;
	b=TFV1Vcf7jwzbco9cbXSYqMOZniyteGb3JUiInr3GIuVpY5UzlKpcqmbhyj9mC8mTONrg
	 bp9K2o7vjb5DV6GHcKbrLeXFU8/HMlYNj7UTMX1/fKF2GA1qqv3zBHOPPf8rrW9kVeQMD
	 xoYV3GTomHnSSa/qt5QviHv5uEHH1GMzZf4jxnOmWLCv9iZVvvji5ScQJKH6BOfJytCga
	 UH386UZ6LCdVy8hJiC5dz+ovwD6GiUWuSXCcR+fNg88dawqR2X/pZWlVIzFANqIHX8X15
	 6lVpX4KwKAFbStO7IKP5clD5rW0jXKsaUPba6C9EiV/6QtAEKdjnG0Ii/pm9DnMpc7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLeRT7yb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE53D606A326
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLeRT7yb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356B81F0089F;
	Mon,  9 Nov 2026 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239625;
	bh=kHqHs9zHVuR6E/aYiGkcWflDQPWNMfp2CtizhRwYwDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BLeRT7ybenwUneUutvfsG1w+tR0fkYrk34xBdvwZ1d7rBfcqGpViEp9UyScZfsN4l
	 CVJntvi3hWQXjwBX9xdIyXaappyZqoiJkSV11t6JBNGJSwPLzUN4h9RTiOgGbAvWRl
	 4LBZOJIvXqo/axQPtxdU8CeQLlbKA1cqJuFOtU6qlOchD7VqeIP2C5KjG9Y5qKwUpf
	 hPEYgJC/IBIGP3WHLe9Dz7DTtUFkjHPrvRdTdjTGUvrEF02RHFZE60vPQLjYue4nHX
	 C/f6b8Yljz3TbnSnrtOludE46mbEsHY9RSKvsVzL1oN+kQlpI9z2WJq61sC+bQd6Ej
	 7PkvNgURsT27w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	liuwb@xiaopeng.com,
	Mark Brown <broonie@kernel.org>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 5.10.y] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
Date: Mon,  9 Nov 2026 10:53:01 -0500
Message-ID: <2026-11-09-1-daily-reply-0019-bcm-qspi-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109030623.419544-1-zhugl3@xiaopeng.com>
References: <20261109030623.419544-1-zhugl3@xiaopeng.com>
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

> spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
