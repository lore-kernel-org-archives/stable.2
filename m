Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192C41B355
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688257; cv=none; b=T/nJYhuSsDqq6/R8JPpw62Mu5wb/RXSxa0gpY7oM0rFwln0OBJL92zeVCGX0urPffNrdOlgPH2jIl8DBBEzWL12nimbeo2xphufsrjlwPm9W8l9cnY+4Dyrv2Zb+Tfq4/OPcydvjL3aKwHZ8qghayzAR5rX8gbEK42xUO5oHS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688257; c=relaxed/simple;
	bh=fGKHpOrKyzcaN165ZFG+JvHbXtU9pb48j4QftNiABNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bH9mi3Y8AeS95hhQ4hRyt9TCXkRvyyqo3KE5EUlpUMVuMnghH+Zb421Wco/IsKfhZI1p4JM4XlIyoQ1MllZkVxpcuVw/+Bpcps/D6gyl+uDwUmXcxk4sB/Uk1mqa+Sn9wsZqH7GtAwFG/ChcfJ4AxLEI7N/r2lBFu0k9NBcCPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayyVTVAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayyVTVAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0A41F00899;
	Fri,  5 Jun 2026 19:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688255;
	bh=rDyEOOv7PTvKfquzsf+pdrP3W8bHBbKo8aeZo1IbZ7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ayyVTVAm26In0yFfoQg3/I+Nwqw20/JgHRVJPMPZfpL9JaytrrjF6tQ+FgBsAtveQ
	 R8HzY278u2MheyJGX/aYyuZuKd3uxwxUrRa5LDz2SZty5qHtKlsapg6JW5rXsDsVHS
	 Hj0QdQyxeX4jji3qgTZ9JQGXM0AiL77bWPkp0T8WV4kYtBzm9Bsjfr3ufmen2kh7jk
	 dsSY+IC0XU2Or9ZvOZNpXy2XIlE9xwf+ORL4ByQNxpA/repdeoATLFjGNVRmMwwm6o
	 YTMSHnyne8iFeBueb3J7hWsxRvhneeJsq4jEz9wGz47fxo6BJz0T1LEnICdT9Mj1Bf
	 1yLrJ9ExLlZwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	acsjakub@amazon.de,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.1.y] netfilter: nf_tables: restore set elements when delete set fails
Date: Fri,  5 Jun 2026 15:37:09 -0400
Message-ID: <20260605-stable-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604083245.77985-1-acsjakub@amazon.de>
References: <20260604083245.77985-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y] netfilter: nf_tables: restore set elements when delete set fails

Queued for 6.1.y, thanks.

-- 
Thanks,
Sasha
