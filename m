Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845214;
	b=PQxA31q4vAc0XB9dDnxXdeVrzED7I/7XTtUGpZWTVo5yINte8ArnqNRKh/eljpqJr9He
	 PKujav8nAYlJ6cZUZj8XGeMhlRyCz/8+3/fR2Z+VKno5mIDllQlni4+UprJ+2vxhkv7SD
	 UeBvjXeyFL+3UCEadzu6fV2tUzAnquhxo9ugRA6wkSKgD7Aoeqot4gWsZJXnsGdY1P4FY
	 jb9t/x+firg1xfEc0Poc7QSYdUxPPdQi1/oAzUhKN04cZJnYAv1VHeH2GAMObgaxvSZvv
	 Fz9P+oGgQVWJMdoy4XOVXDc3pjzP9r5DzMFe4boyvcNzxahkzg8tQsjPWX62LLhs+vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X3a20bgxU/2nOTNwxKM6Yvmyu0ovIKjUKPYamgHf03k=;
	b=vE+uS5TXjuq6aXTngRexVnE3n4/9JIzhcS3k61jFWMKPjYAcTtNyXxg/wtVg9baoSPy6
	 A4OgVf8vJo0+xvpkiyJeBYyfuM3DEvRQGoz8YK5bXVwEqwjUhNx2j/urpruAGy5GyeYpr
	 8hCC2HVzM+Dz3DQEyVFHYN+oPkrhqRvkNWwH6Bec7Z2Sst/sMV2J85NzyRXPv6tTeilxk
	 DwWeCvB2pMAoTmKWFDLy/3G1+kO6xzotsMYURn5BqoI+MntUQVNjZp6ktEw/c7W0F3UaC
	 9afLfFEgFARAXeP1fEs3yfNhUshVi8hYTAWYglqC4ZkGTyO+8K9WCcFUdSyXImv2c+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0tRwKs2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC09606A335;
	Mon, 16 Nov 2026 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0tRwKs2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B126F1F000C9;
	Mon, 16 Nov 2026 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845213;
	bh=X3a20bgxU/2nOTNwxKM6Yvmyu0ovIKjUKPYamgHf03k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0tRwKs2CbHZYXv1zlr2X+lFj/X8SGNCWB5+rZtRi1WYE3eA8Diaiy3jpJUx8z9Of
	 GZnJUIZNvDF1PACdmBrUF0tLuWon5smhvhh5nqkHwB2UPqmewKyX8nSREKTQQSCCqS
	 FbMMMzvaxkwsBtfwnBs8v9rkyeBAbq6zoDjiQiFS820BWBtirjcHaUjhJkTWkzs59a
	 UI4zOakSjifzJlhUzd3F0Te3oL8dRdpCDYGn1ga3xI0Q7EAcjuZsM+sJW1FkPDvPqP
	 D0H4luB+Ky/UnC4HK06z71l2N2+6aW5aQb8bRtJ0E1SO5epfUBev9dd3VM9ROcoGk9
	 ZneTOl/tFxbaA==
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
Subject: Re: [PATCH 5.10] selinux: prevent KMSAN warning in selinux_inet_conn_request()
Date: Mon, 16 Nov 2026 11:06:42 -0500
Message-ID: <2026-11-16-1-daily-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116105355.89902-1-petrvaganoff@gmail.com>
References: <20261116105355.89902-1-petrvaganoff@gmail.com>
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

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
