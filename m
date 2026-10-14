Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F742D949F
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941258; cv=none; b=n3KGYXGRV/sSuTH/2w58Uty7If7q5PKTKY//znsAKS3DzSIVkcCnb+y/lKKzUI5owIHMlNT3A7tNqTPXkxvossQsMZUd7+tdqLuM7t/FPYtfX3s0Cvcfqb8y7uRGBZo3xhqcyls3qPZGGHDv77U1CyvDDYiBA/4gg24kLFRDtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941258; c=relaxed/simple;
	bh=jLAMhg4JWlP2kbWG5qKUAKQXuQJwSOAc9C2M0XFQyHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMxcS/uYjERVHd7UrFZMY+n4lHGibF7FkbAsPtLbEeWgqkDG/zqL7PBd6Uw+VBshahTWMEme30E8E4EfvufwDUQmye4poBhsDK7N98/HiIVtgd/HucHGIJsXCwzuX7BzzBlTJyKpLdJa58XHGJOh7JC/FGW/K8wQq3+ktEnyZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G26Ht3w6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G26Ht3w6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DB31F000FF;
	Wed, 14 Oct 2026 01:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941256;
	bh=cbxNOxHc+MnZq2gyd9XNzRr83xglmHdHPPyjhm7vBME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G26Ht3w69TxKfZKDvPqMb+D5IPGoav7eTvf/Wep4/90iwk532w0X2pq7vxCzvzwXx
	 FDq7qsJWavR6ecz7a0kSHzxEa2wxGVR9HdPeswRn7iMmleVcVg6YIUcT8L1b/6Ml8f
	 AsCmO0IE9siXKVs9BpM7jQ/GQfV9Hgwi9YYMlSTiscS5ZDIz7s7fHs0lmkg+X4EJwi
	 Jt3e3+owwGyxkRnf/DTu/kfm7pTZPSXL6QGSzzAVDD98pMQbcAWbmQzm4Sccdgnyu/
	 AVCDIsZ0L9vGcPapAdCgzy5kp2uXwD4cR7W7t2RTE0AWOK9EK0bj33JOmN6QOOW75A
	 yHJsBkcRuhxew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Charkov <alchark@flipper.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6.12.y] regulator: of: fill in supply names in of_regulator_bulk_get_all()
Date: Tue, 13 Oct 2026 21:27:06 -0400
Message-ID: <2026-10-13-1-daily-reply-0016-regulator-bulk-get-all-6-12-not-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012160501.1170944-1-alchark@flipper.net>
References: <20261012160501.1170944-1-alchark@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> of_regulator_bulk_get_all() returns an array it allocated itself, and
> fills in only the consumer of each entry.

Not queued for 6.12: nothing in that tree calls of_regulator_bulk_get_all(),
the same reason you gave for 6.6 and 6.1.

-- 
Thanks,
Sasha
