Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1210F1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595414; cv=none; b=lINnuIjwA8xiTdP0hbC0M48/q84erwoSdzqrM38SlbJQ6o6M9tzvkLWTgV3ZdVBYe1g+xRoJat9Cq2aNsUYdXtjSmcj5D+mwWq0k5k9WAjRGSETtHcZccPLrwGRlCxyKtW4vWRaMOHk5PJDv2+qaPANfCZ+8u08C9jqS7JtT+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595414; c=relaxed/simple;
	bh=53YO0R7t6JeFwtlbwvsahGwR3zrcBA/aDqXif/5YWTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twp0ZQa/z29wV9SoCDYeM/dpW8cjNKroCpBzmb4je1SoiYE2jclVlfL+M+V4m/10a84jtdGJAflcX76Mqva/tI4WHVbFlynz3VxQru6STCsgbfNw38gkxKT7G/vwp/C3pkMhtd2sZF1WT+qzfwWXwaKPlV9Yj5/jj2MPu+Zduc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TF5bMI6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TF5bMI6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5002F1F00A3A;
	Tue, 21 Jul 2026 00:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595412;
	bh=Jdr4veEnInTnrj9f6T7zTQjBfM3t/xOqHi0bvuhWLDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TF5bMI6fMbJTMa2os02NLxva1na55I/r3gQKDW20VHzCpXoR7gaWIszS7/eFEb8Af
	 B2L0RahetO69Ib3E6/d9dHON/CtBuXbDPYEaam3XuEkM3y616Lf6ltZ+JszBj2LVeh
	 P2ZNv2NtMZOxiiDRR+5MedanQYWaisnay/zqfrBgQCs+LDghp8deTLpNNlZUIC1jXs
	 9FzFLbiaBQ7W3ahxXHnuDFpHTqEAL2vXdcH/26SKZq9YoLRaKHnkK+p0jtnI/jbEE4
	 upYVSrch8Ywk1+rhd7gabe+v1RQR/ctFagMZfpLFs9s12VWRizPJZPQCumzo7E9uOM
	 8rUnaUzZzVtAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.12.y] batman-adv: clean untagged VLAN on netdev registration failure
Date: Mon, 20 Jul 2026 20:56:26 -0400
Message-ID: <20260720175500.0019-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720134234.568023-1-sven@narfation.org>
References: <20260720134234.568023-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The register_netdevice() call will try to clean up the net_device using
> unregister_netdevice_queue() - which only uses the .priv_destructor to
> free private resources. In this situation, .dellink will not be called.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
