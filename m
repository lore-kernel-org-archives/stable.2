Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845211;
	b=vQKPnXIpG9weLxrxc2Op5ss8OfGzcsOoIQjeviAQTwAuixOtIhfju7yPqzDtDAHHyxmj
	 reugNU/kHeCNyKFTxkyXq7zIvoQAwOt2gZCp4wAr37mhwPC1x0vZ2G7rXVpYk8qK0mZIV
	 D3yionhZzZQT9fH/LMZSjE6PwVUtCnmN9CgleD6WCx4ZOLhcGZYd+mb/wKiCIgzk5F2+C
	 TqqbGIXdh3RPJhbEH9Ycgo0WfGVpb3VVYLowPWd6U91U0b2dJqDPEngq9O8zL1SZyt5zs
	 +tqxBfmTcBmnDZbcNU9HqkkpT5gjG+NIzW1C7+dPHPXW48PY/OrZDhFAdf5njoM1Y3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845211;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vYDFtCr0jLCCeKRhsJ3pL2cWH6ta6QdzhP1Bew1pyVw=;
	b=VuN6cIAKk1GfwTVht95WT1Oz+5g9BYiVWdQXewWjE2LAvq+eQQ7OO8ohdtuWxwV8h55k
	 F4OPVSBudtPT2I7N5sQqJGsID9OKPYm+tZhv3ac2QX6d1jkQ4RW1YHRPgqFjLKrSgjGcX
	 TyqOPFtDiiJ4hONWBgP5iW0SXekIP/oKIEGov4UZ6paU3+W2IMih/gms19oE8MnhCvRov
	 Q/aGiiN1/QLh9WTcO6ojTnZkNOwWtgKZCmdW417prR5ZfGIvIXpKTX9R5ON5GeXikEARo
	 gNzSENCfP1rNxsQyE1rD4q4WCMpx9rjGxerB/+hUf/RCn9iPkWjLcQsGNPD2a8td0Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mCW/Fc7s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C990606A32C;
	Mon, 16 Nov 2026 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCW/Fc7s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2315A1F000C9;
	Mon, 16 Nov 2026 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845211;
	bh=vYDFtCr0jLCCeKRhsJ3pL2cWH6ta6QdzhP1Bew1pyVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCW/Fc7s3aCZo5SkAgfIIhKpRUnO9zJs6kjSg/6DrQie3xebHNbxotcGqpQxc7gMC
	 MOQaWbtPhXQKo8K2VtoOPhs62h8uPNjSe6FBRKGOpbYFrllBtvJtXb5apLD0OJMGNX
	 g4iddzsUUF8KWV9IBv8ZemyidXp5AKNJIXbB7GDa18CBMkIKKiz3HZgalYhJEz/KwV
	 Dzsdy9mSiDRoDoA2C9fVDpB7hr8DiSkILkKNq+/zsuh39nq0qMkoC2NbljQSlFtiX+
	 +VbLbelM9aHBsQgZo+fqF7ZMtdnLX8gusBKGziFWWvGToO8Kka6EK/rn5xuMcf/rj5
	 NVVqAspZfN9Og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Petr Vaganov <petrvaganoff@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Andrew Kanner <andrew.kanner@gmail.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1] selinux: prevent KMSAN warning in selinux_inet_conn_request()
Date: Mon, 16 Nov 2026 11:06:40 -0500
Message-ID: <2026-11-16-1-daily-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116105307.89727-1-petrvaganoff@gmail.com>
References: <20261116105307.89727-1-petrvaganoff@gmail.com>
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

> commit 1df83cbf23a27174aee6ea5e52462f03f7e48a10 upstream.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
