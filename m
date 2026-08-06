Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C037AA91;
	Thu,  6 Aug 2026 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034928; cv=none; b=rbZnqCkIsn1sixZAxQzxGRUTnQa2FcESz4nO1E2351XYWyWFmTGvudUDtv2j8byBy0zHgmXk5Jphe5CdOfut4AUmM4KFIhpEcV6ycrwYI1q690Zmxv10NLjEIDbynXahvzJxDq5m4W4iI8GO0vJ3SBOd6KHKaoJpujA6q3VCZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034928; c=relaxed/simple;
	bh=lkWJDWE/13dDJ/o/Q9HThhV/306dHlcfcrii65xwv94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbtREVtU6uKG9JkbKJFw9PWnkPlkMeNr9omIP0TXP6wpltU5xAB/9SlDKk+Sg6SWuDHqBCdSBtz5GXxt+LyjdVZ2Kq2mLUnLOY6lLxy+66t0o+kZYcLwch0sm6WhBaf2+FlgfMUWFCCkXrTa3aX6xvPJ0FOFkxy+XKPHs14sSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MS8TKdyt; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MS8TKdyt"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hGCsN5rfqz1XM6JY;
	Thu,  6 Aug 2026 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1786034917; x=1788626918; bh=lkWJDWE/13dDJ/o/Q9HThhV/
	306dHlcfcrii65xwv94=; b=MS8TKdyt4a+2u5zIGFGwsXfybqFmsZyzI6GeMzWb
	RmOM+NjH/M6yujoZKTgo9Eo0pveWjgMtc572p0J+fZsCa4J6rAtWdBPFGPTJrHnz
	e5b9pLlblw0k8/aKHRB2urdtK56SCLfLsA0KRYKm0XlnjGjw050Tm1aNa6WFpK45
	Rq57033hmEI9drLKD72zkk6b0K4QwCGKN0pXrGqp51JfJRdf576ZNvF+3aTATT0D
	uciDbFAmVdpjBf8/cSI1WRBScwNtCeCf5WbgrtYn/IZcOaQxZXn+KzufPRAWjfHi
	fyZ0hcoow3xoRbN69cWdIdw6gB/8Tbjs0Kpm6hUviGiFAw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Oo0JCsl_6_UP; Thu,  6 Aug 2026 16:48:37 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hGCsG4kF4z1XM31H;
	Thu,  6 Aug 2026 16:48:34 +0000 (UTC)
Message-ID: <91e60d3d-4143-452a-a391-ca17df01e650@acm.org>
Date: Thu, 6 Aug 2026 09:48:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] loop, nbd: drop partitions left behind by the
 GD_NEED_PART_SCAN removal
To: daan@amutable.com, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@other.debian.org, stable@vger.kernel.org
References: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 3:36 AM, Daan De Meyer via B4 Relay wrote:
> These two patches fix the two remaining places that relied on the same
> lazy cleanup, LOOP_CHANGE_FD and NBD_CLEAR_SOCK.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
