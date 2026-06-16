Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984237C91E
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578673; cv=none; b=drd5JU82IkvalPcAvx+EG8Q4eKMGCYfk/6Y7qdZolsk69BZqYxLENezDEei1cDUiw2ZPQO4JpwxXsXjRHONR0BUfqiQfkorUyUw0Or32KDiMjuSbbznaPZvJhVC3o9qTt+kkixlBPMSlvXtKroYx9Ft4D9uETJ3ISF+LrtrbsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578673; c=relaxed/simple;
	bh=yWnYu809aw4VyCjiZEjn8QlrNbMDvllsqr7kEpvozXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ5NMycYzFf4+ZiTnhXQQ7bt0Q3P43AXstZGDmI1POVWhjm+M4vJgmjTIj7mPjRGy3lWM8JwCkO/T3JuMnYe7bKK7yZR7D5QjgzHdxhsdA19YcjsajZ4Lltb38hZvTKgkGdFiDoWWqQj+vBvoGAb+MVBm630pHIHWpJBbnAqX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwbVEM+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwbVEM+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902101F000E9;
	Tue, 16 Jun 2026 02:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781578673;
	bh=yWnYu809aw4VyCjiZEjn8QlrNbMDvllsqr7kEpvozXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cwbVEM+x2hpfKtqgGBNPWkX3kluPEvtDvdlwzMqVrp1SwhS1dbeXgk5plHwCDIE6Y
	 5h0LZTcAjQ5Pi4munZnob4NgoQQWRdUXasQUy7Kkc1w0dbp5I72JPvDP/lVtaJw7tb
	 Z2ZhMmgi0KXVg80z1F/sYQEDFzbZEmTnZ7kv4Wqd0GYlyf3R8znNxoSuQdQgE+QGTv
	 DOGMoL4/W/obouMBrVjVS3EKs5Xt1qCLhkskpE3jz8s1pAxGPybbgvuZ3YRjWpoe8+
	 zmWMoZvUNNPGhb6fFVsyFvCWx7jPeLfNmaxVtiyy+Nq6r6E6vyMfWkyNnC3tTU7XtK
	 CjQ5QKsOuz3eA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [PATCH 6.12.y] mm/hugetlb: avoid false positive lockdep assertion
Date: Mon, 15 Jun 2026 22:57:43 -0400
Message-ID: <20260616130000.1000001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615160955.258138-1-ljs@kernel.org>
References: <20260615160955.258138-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 15, 2026 at 05:09:55PM +0100, Lorenzo Stoakes wrote:
> [PATCH 6.12.y] mm/hugetlb: avoid false positive lockdep assertion

Queued for 6.12.y, thanks.

--
Thanks,
Sasha
