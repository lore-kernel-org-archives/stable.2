Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB153D891C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474563; cv=none; b=L+jVW6b1V1FvJrIhmtgpOQ2l6iF28A6zPDFPcGIiCzFwr8JVyA8NBDy+fTgkC0jjYmO73jcXaM8cA1xj6akWPOaB+0XlpcbBmffgNFyCkPlDzGPiA4rAXl76Egchd0LVBzzxMmzBoZKxPu/t/K6RyziUCVkPxCvvxS4lbI+TKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474563; c=relaxed/simple;
	bh=7UbJV8dV8R1ZkzTuTpIP82dIWWxpddW659mG3Kcsf9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r04lx/SVkCePvMT1/XNxKQbpEiauCN8/4lVkwpIiscyea7GEnCVqN9f6OkGWaMIwJGzH4gvT7ZvghBNOZVR15rxrLYkQBQWNzJIX0ezY0BfJ4gz13MyP28sKcoLlyK30s3xvfU+nTRpptw9ME8OJfM7N5B7ipb/wmbgKzOKI7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4cG2J3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4cG2J3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC7A1F00A3A;
	Tue, 11 Aug 2026 18:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474562;
	bh=paqxkS7rlQsVoH3I7+PQIBkAIeemQS3/ExtKuqBo3pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4cG2J3hBXY0c3GGOdusSDHKwxzDG4IACK5uAcjbPwelEnjK0hq2VgkpUf05WOebN
	 UXFXqT0V2EiDZLZZpZikQ/MNNwjYVGPcnwN56bllydtEon4/bVNlI9PaFnv1zSkgl7
	 qKbV8GQJJ+uwqEMp+TKqPwD+PunvnxcohDBbzT8kdpuNNhom6KY5NWzxCjI52oR4rg
	 YqAsDykGMsQSN3Gv7rt0xVaAn21pujsNdrDVrQ1EH4ncWtieEXgT/IZCTl2C8LLvwU
	 IiybdrEgy3P+kI0cBItyCsE1IVVm7NoHOhuuw8wbtWy6N8derWGq5yAMfiYPJPxb1J
	 s6dzPL399XTzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 6.6.y] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Tue, 11 Aug 2026 14:55:47 -0400
Message-ID: <20260811184500.stable-0002-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810141713.564497-1-dengler@linux.ibm.com>
References: <20260810141713.564497-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Extend the _ip_cprb_helper() function with another parameter 'scrub'
> used to steer scrubbing of this buffer. So now the caller has the
> opportunity to decide if scrubbing is needed or not.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
