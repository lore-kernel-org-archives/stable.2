Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4F538DC68;
	Fri,  4 Sep 2026 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490404; cv=none; b=AVsTYrfFAjGIuKNqQXvotLypXoXdStDMfIE8vcQw8Yog8NH7HRNWOQ7jUG3L850fVqVkg9d5p+J6tBXaV2vJeH/ICx69sznKGPmzTYW7Iol5Lirzq3OLnzXXXsWQ3VVmPCpO6zqjYNBp7ybcZLc0TSzmlvC1/KmRjMS8TnvNKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490404; c=relaxed/simple;
	bh=NdXMfV9cXifMLjaaUsBZDZA7umcRgM69YQOc0rvM/18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny5jAy2O5fCYUfAWj3PH7qSaYzluc5D14dxP7sRbgkelGo4cYT+56GEL8s9m2XuG+stInORkC8oxmiZQxHK9xchnSZLg1LWzKywZ2sqZChCECRUvxWEuQYKNagm/DyZ6gwl58IlnvqmkFbmtPl+Kn6sQV0ByBUiqzrGeEoANMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpmYbhE+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpmYbhE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6781E1F00A3D;
	Fri,  4 Sep 2026 02:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490402;
	bh=F8YU566cGOJIICXUyDOV1mx2Ay3vuXzyzHiGuW6B0ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lpmYbhE+H+VzSC72Jois6a7MIquQDnJCGMhnqxL6ISKWoPsY5gWibn4HCyXHSDUYW
	 auxd4X1ebfObbJbKcJhcCk7d4YiZfkubX1lpFCxA2NBaPmZEE1t1JiaFQYOqJCPOx2
	 XqH/6NCQkkL5FZFyUxMNM46jy0ujW91uP/qEuC4UL4LS5Erjrjp3sMWIrLpJZvEZWt
	 36ZTlp3oiHLmigQtEtdqFzXGEFIbxrHGGmDASRxwPTh0qXud04qq1tXYWwZqkXc3Nv
	 eh85MyuWw+rrcQlDu/yos8iYwkranqw29QRP864fqiiYfb5qf/mGBttHimf3C1/OOC
	 5KlI1Z/H7j9KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH 6.18] ovpn: run deferred work on a module-owned workqueue
Date: Thu,  3 Sep 2026 22:52:55 -0400
Message-ID: <20260903-daily-reply-0003-re-ovpn-workqueue-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903132715.3823803-1-alexevgmart@gmail.com>
References: <20260903132715.3823803-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Add a module-owned workqueue and queue all ovpn work items on it.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
