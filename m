Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82710F1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595407; cv=none; b=bPQDbAO4zYdGVMu2qEsI3KBnyT36I/3ZvExYLWEPdvHLDWGK+yFYoxKaz+AK6LBH5ruRheV1pcARGL0zldp4yrNL1H1zkxqZq/VRvJKwZ5cG72Og6Ih2u/L2xt4ncYIO9y6upWHkJrNF3/YrU0PV0NAV1L6wyr+DuelVipUstA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595407; c=relaxed/simple;
	bh=PX5qglLxdSqUPBlibyKS4jgk4vBDACGz1NW2OiYMQmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7gHhjlGRHV+JRd3v8e32R9MMuxnZGZ8aYgjAOTormyIoIcRL280db7Djcz5IxeOamIB5vZjUQsOXbgq4iRK7DwCvLdL5bcAMVnMD13ge9F8K7g+CP6dylDYQlDKdz9o0ifHDEZhGAtkoxqYCfmCVZp+JUt+bEMM1ouOoYPh7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzn5LjN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzn5LjN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0C91F00A3F;
	Tue, 21 Jul 2026 00:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595406;
	bh=T23RQrWoNObdMeEFBHzOjnNRzCm0TJhxr5fQ/oFYtl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gzn5LjN/QH8Jo4nG9UKjKwNKGfmCc8+3XTypoSFytwph39S8BVYrNiGNkJ552w4pt
	 e7CycQeZTBUB+6f/9Fv2GXZRQRhXZLjPaNF5Peli5icFuopIqeJ5efjlnvliUvMiTl
	 35fQQbdLf5p8kbfFbsI6XK9R73jt3upXK3BTMjowSWTdjpShwlKIvXIfNPclswNLXi
	 l3HYEvTysvMQq3I4lABtgGIIEUdKdRLP0bWrlno8AOah05PfcLe8hwyR1pIrJIHVgv
	 pWm5IINZ1xEAJ/GI2ZEPciGTJ6CyFyndYRhYJtpzdnJRr3/GVhi3XOZV7S+W1MpWKF
	 WGhEE6AapStSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.1.y] batman-adv: ensure minimal ethernet header on TX
Date: Mon, 20 Jul 2026 20:56:20 -0400
Message-ID: <20260720175500.0013-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720133657.505141-1-sven@narfation.org>
References: <20260720133657.505141-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The batadv_interface_tx() must therefore always check itself if enough data
> is available for the ethernet header and don't rely on min_header_len.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
