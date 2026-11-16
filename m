Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845212;
	b=jS9hbACcfeqwztKqCBV7cyuUeLyU4S/VCMI4ZRr6yRwPGkHwGyL2bcreA7PV2/UCjvjY
	 brScesLr6vHcn/9dAO92NezEko6b3LKIrcWkc0QV6gGf7NwdECF09XNdWkxIAr/OsoGKu
	 /8PF/lM5ZLmbp7+OAjq1S+6V9RKQ76OvPEEj3FdACHeYCNMcd6DW1i0NfMDUp/cjiFTkb
	 Q2hgtopS2uI8N4WSlYlzXj14t5A2o4q+33VsBRut0K9zcKSiGXsINXfSLYTrG3o26kIjF
	 3Nf2jyAo5BaelAlf7Y0KKYoKVZT3lKVZearHk02mk7nsGht4g339EZc1h8RHb4NFe1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/sMqsb3iNTMCRIUp97kCu/JOMgp6EIphZvrkAcwP2r0=;
	b=0YM4rB7fg9EqA0Bk09eE7kRbWmmFi0oBOP/IUql80nkk7GZn0gCurshnTqz6sWa+Ou2V
	 8zvh0fv/sAzc0X2I+iyiIxtbQ7C3/b0t8Ld34dkDdV8aUCrMcYoQil0cb5R4HnrZdvoCV
	 0rDWzh3HXkUe0MEMT6zMICBeYBs5yUoIoS67wuaALWOS0lwWs4q1Z3iavhLMR0VA4K4kB
	 8N/IrxT2SHpH79y0f9uC7LQvhRgJq4/ydPKIpPMQLHjfM/oDtAFNKbOVEH8HPoYx73mku
	 T0K+4OUpC3MaQTw8RvGe4GcNuWICdkDu+NlwDzB4x8m35uM86OKxi0mLMlW+tl+75HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FKAEzz/9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D4606A31C;
	Mon, 16 Nov 2026 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKAEzz/9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CB41F000C4;
	Mon, 16 Nov 2026 16:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845212;
	bh=/sMqsb3iNTMCRIUp97kCu/JOMgp6EIphZvrkAcwP2r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKAEzz/9V6kR2oIuNxqWFMofssH54hENZXdEImDXAvz6lI9HpLiHIOFwXCFFoexeT
	 wBa4GKdIxoZ5Htwy3CTvSUH8/b7CBdpxss0+pLB4m9hZr0zRYzg6W9OTqMojyNADeU
	 R1GXtBnBS2DyeS+zXw9kqxevmSLYOZdVpR/90w5FDfSgAGk+61YRWPTec4TUeCgFI5
	 rFL9Q+OD7K5aZeyj+uAXGUeMpCezuSK/ToiMAWz9te/ccq9icOqpLbZo+b2A3k8A5S
	 7LChXQOgDIB6ETd0uqXkRMIpLlTOZp0TnioDBbK05BIfiHnyxr5vfNqyZXz8A3jRm2
	 ywEcogbap1xZQ==
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
Subject: Re: [PATCH 5.15] selinux: prevent KMSAN warning in selinux_inet_conn_request()
Date: Mon, 16 Nov 2026 11:06:41 -0500
Message-ID: <2026-11-16-1-daily-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116105333.89809-1-petrvaganoff@gmail.com>
References: <20261116105333.89809-1-petrvaganoff@gmail.com>
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

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
