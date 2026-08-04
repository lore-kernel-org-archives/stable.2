Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C53C8C77
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805555; cv=none; b=oVlnTR5hoKzcbYpfrm/Omds9EJ/g4o/oZe9FBQhMoZ+nK+L19TFtHwZ6WDqa6hX7bmBKZprGip19VFRJ+cKsYYFHrlVkSSpDUbPOYJo0L6ACAhqJjaUOSYBL2NUWJzbdHw+a/wfAy9ZQj7wAh6xGSC3rfbnUswCN6hcspZJcrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805555; c=relaxed/simple;
	bh=zBkWTRIQJ266Vipk9uDWJTe1jOGOG6HBa1SNgj13wVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXqYiKVdgLgNmhdxbwXEsLoeguQdSXsJulPPFEDWPtaUr5szPuWggKEC6JU5rwdtktLd6QKNwUEYmIF/3gXgFIYhRR79shuiqjh1Q4oDsf8iYsnj9LkkADwHV2Jgg0yd25OdUDq9xKRrvVmugURDQ2P8b6A7fiyZ6yyW9L4AJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osMbXW51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osMbXW51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA39E1F000E9;
	Tue,  4 Aug 2026 01:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785805553;
	bh=OIsutFDROjAawfXqhATjxUhNDmVtdp/Edn0nplJF5n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osMbXW513P1keNxfM75i/joqZ7ZNgwCFEk1m+GnoCXuS3eXGhuaCbn9iZhZS2AX0I
	 WIxpgxUXCon983msVhtltwFAIKbybphNkqS8aJXNXDEU5HRKU//eGX5wcl9Ppm3+QS
	 HTpF5V8Iq117gqPsakZzIXS2NNg9owJwSPHnWQ7hEZWzikFjhbvaZWuMzmaoB2JzoV
	 ODgGkC6E6alrwBO9h9bzooiYm9S5iagv3r1rdRICIhbmQxRnmSnusAOPr4w2tXrvTR
	 fhmE8TlN0MaWkTlzksusCHM01O8zy0KG22uKU0RGChy5XC60UOuGoNKgbtTKVKp3EW
	 EhUf3DtxWZpxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	wen.gang.wang@oracle.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	kuba@kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH 5.10.y] tls: separate no-async decryption request handling from async
Date: Mon,  3 Aug 2026 21:05:46 -0400
Message-ID: <20260803210503.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803195149.7578-1-wen.gang.wang@oracle.com>
References: <20260803195149.7578-1-wen.gang.wang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 12:51:49PM -0700, Wengang Wang wrote:
>Subject: [PATCH 5.10.y] tls: separate no-async decryption request handling from async

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
