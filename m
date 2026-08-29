Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF955343D63;
	Sat, 29 Aug 2026 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974496; cv=none; b=UBIUbUmmSF1DtivVkf0k/BwzyRwpxK8tLaX0JctZybPFhF1mkj+UhZtO1wylbWcCuRh+NiwYsdP41ZndZqVeJcj7T1G1hNW4dBNd9nKFCnJx0PDLBSRf29OOxOCIdO/atPrxXrZJXYy8hNdMYs1WscaDz+B7vOYvB5ZW7LnhKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974496; c=relaxed/simple;
	bh=mqo6RXhbqK0a7bKTbyuqHGSxMVVKty5TSzXt10GwHVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9wU/tu7w0+LQCgUWKyCs3FcygDehxqjrW7PrlnEk0iGUq6boez4EflnMqJfAxUrC3eLE9Pzpk0AeetLuGAVrhKe+W7ume/mZ97PaOiLSdDeAPEP2+d1dhpS1hUuXOgOdVASBTw/SwafBYTg99GNVUaJjbZX4BQWFrzGvlw+hzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxWb7x3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxWb7x3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94171F00A3E;
	Sat, 29 Aug 2026 03:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974495;
	bh=xbaZqm6ArufAHT/YW+nOlk/tIqrW9IH+o3BJpw65ul0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LxWb7x3yegeaUjOO+B6/VynLCp9iV/8YpI8msRT0FuSoFh1spA71RQ8ugMVBtptyy
	 qvrV0ue0E/EKssYKbHHNgxtU3s9s89Rz2tUZ408DWYZV5DZHIZMCQOkec7kqyrAsZR
	 1SdT+F91F8bbomhbDBmPuDpy4EMqHApbLULTTeGDRTpOLYDOAm378BHDbQnJcXH5m8
	 a/1SznMLOvXmKopOAPy/yMk70UhJewQNNwJaGdg3ZWJjQa/oFyY+hEXHhZ/ABeK0Zt
	 t6u35Mgwu5dplG4kjGNrd+f67BoZkk8YNX2XRa0hwiBRdI5JmPnZouKYumGRNGmIhL
	 xmQJ1q6BeIq0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 6.1.y] Revert "usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal"
Date: Fri, 28 Aug 2026 23:34:40 -0400
Message-ID: <20260828-stable-daily-0009-revert-fsl-usb-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <de6cc86708372c418d670cf8ec4d5929538c3417.1787901520.git.ralf@mandelbit.com>
References: <de6cc86708372c418d670cf8ec4d5929538c3417.1787901520.git.ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The reverted commit uses disable_delayed_work_sync, which was introduced
> by commit 86898fa6b8cd ("workqueue: Implement disable/enable for
> (delayed) work items") in v6.10. The function is therefore unavailable
> in 6.1.y, causing configurations that enable CONFIG_FSL_USB2_OTG to fail
> to build.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
