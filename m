Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA157F737;
	Thu, 15 Oct 2026 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092996; cv=none; b=bkjSwr09ywBz+gKM0H7Z3X3sTd6Qkvl52PRJECrsIpg2dgm+kmnMuzsz4pkOmN6RItN0eqMLO5KCh7AYdTLwNi9QvWKtBRSQDF/1PnOLdsFOWQE+Zl/ICjyII72NVfL21tnJ7V4ILy993IiHZPJcW05hPdtv1JlOIKOIXvdNHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092996; c=relaxed/simple;
	bh=SeBcNgkQBK7Za5iXV5fOqlOL1js507ZqRU1i8o/lEic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7ysn3aOzaapQ662Kggg+IB06Ax4g513vehJgo2+R/gJWfqbtBpYTNbRuVaaIzkdRfu+QlAJmCqgrw/4xYaLrbf9rLVQqnC2FM6SkWgVi2dKyS3Ir1pfqVpfJyZTqHfrLE7NtQQQgQljDKtw4Z7jHyOayJ+CyQvf9vqNaONBIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9cHzVS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9cHzVS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D941F000C7;
	Thu, 15 Oct 2026 19:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092995;
	bh=fXzqqh5CAD5Z8eSp9wfrHb02UN3CQ3CFqYCkLDdQpps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b9cHzVS8HzmhWLNsUTGfk/BiSl5UQWVTIgMBU27QoVvldi4T1Ge9Qq9keTswbQ7jq
	 /Fzz3NW4vNHfryrTuDf/QFyy3wprsSKLyaJ3PQo7NJP5K6cCOIh1fNEAIkRp/loQYe
	 BT09bgwIlULnuz9BTongGk9LIw2q/19tIN033b+bXayob4XfS758iuIwAlZs3/MG6J
	 K1ckNj9kOVWaHw2/QU0pBT3DDaxDHFIQYiB/1G7Aj5LSCtxhQSouDUabDKzRdnQbYZ
	 mSi6kXm1woKE+HBxylio9CiTzUC2AP9up3GOadldLxNlwM9wt4mlyMXEmt8MqsDE8R
	 CQaxDgJn1D/ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	abdun.nihaal@gmail.com,
	christian.gromm@microchip.com,
	error27@gmail.com,
	gregkh@linuxfoundation.org,
	johan@kernel.org,
	knavaneeth786@gmail.com,
	linux-kernel@vger.kernel.org,
	parthiban.veerasooran@microchip.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y 0/2] CVE-2025-71272, CVE-2026-43317: backport fix series
Date: Thu, 15 Oct 2026 15:35:55 -0400
Message-ID: <2026-10-15-1-daily-reply-0012-cve-2025-71272-most-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014191452.23814-1-artem@trailofbits.com>
References: <20261014191452.23814-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider this backport series for CVE-2025-71272, CVE-2026-43317 to
> 6.6.y.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
