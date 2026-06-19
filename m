Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5DC331EAD;
	Fri, 19 Jun 2026 04:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842046; cv=none; b=OqjSEI6J/ApGrJ9rg9prqyBA2rKxr2Hnrg+KNWVsDMIIlLcXARh8seg/KDUO9BE5Vtbefr+PAPkMOIjvcPKHiR/g6cjCga1aK63CYdsp1y+GBVHAUyuqienUkb58S1X2hsg2j1Dg3ck2Yv4BHvTj7e/ztLLQM3kECiXKkq5OKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842046; c=relaxed/simple;
	bh=FTOGV0IcZ3HP1J4Rz+C5FGe0WbFuAs7UdWEPpj+TEBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=livuMAblXGju1GEjBO+5IIGOjkhzPmRp5mW07sU/RpcMkowgwlqR9P3oW1KWQb7RCBzX96hxwbdfv3jHCte6avqzuyNKhZQUxgSSnN6DLPlXyOK02drihFUQYs8foC8rZ6bim/OE3jnJ3I9J5cKLU0HYODUgO6dC9yIGzwE8cQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qv3mMbuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qv3mMbuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81FE1F000E9;
	Fri, 19 Jun 2026 04:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842044;
	bh=otxLglsZFBQirL9yFBv0Oki6Sn0lIscC3dBfyTEk0hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qv3mMbuAHwAaILbgyHrPHLf3RTkjWKy6DeXQLVGVCJdMaoiMADKc6b15+NAGwkJTI
	 QD+b3k02wYZRdxdsHcNz9Jg493GURf7y9QvkIxvDs+XHLSECh90iplKi6K6MeCzPKv
	 aq6VxTig3mu1wwEOr2oYWY3oN1vYBaiRFFs4x7LNObYE1BJmHgzcdYjiWj95pBzj0R
	 QST/6vRay03IShJqYIo5KFY23kIt31Q7M93dX+/dJAMTM6Jv0EAwy0Rauw2mpz9UMI
	 ltyW6e3VWTEg6V1XBLNU2ScxVbth8lU8n5GJFJ/Hoa16oytACKXum4uZLUAaCUetsJ
	 ecdYOW2/W4AFg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	io-uring@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH stable-7.0.y] io_uring/net: Avoid msghdr on op_connect/op_bind async data
Date: Fri, 19 Jun 2026 00:07:06 -0400
Message-ID: <20260618-reply-item041-iouring-70@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617192722.3041610-1-krisman@suse.de>
References: <20260617192722.3041610-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  [PATCH stable-7.0.y] io_uring/net: Avoid msghdr on op_connect/op_bind
>  async data

Queued for 7.0, thanks.

--
Thanks,
Sasha
