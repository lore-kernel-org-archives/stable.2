Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717553;
	b=CGtJWTiiKZuKUhT7fI+q0QcOvkJ7QBvc3q76hZjtvj4bbCxF6Ey2DKSxI/4OHwbKx7DJ
	 tMK1s5mn8Fd/wnvqVUhH08wdbLrwRc+gRlHNY1FMnB1I0dvqhfjIAGVb5PKhSsFA0J34J
	 UwdU0stPx6F2ipYILrF89+Kl0CPeKBQTW5vz989sksKn3D88EVfDb+tW3yJPzXlMnPeux
	 DMBimqO3AumTJ24ParEMv04cavlC+QlNGTkNgPks897bNI37QVn9uQbQLV4/T31ftiDU4
	 kyZDRFKES6xZZ83Gz45GtvecjJAIm4fMBP/IMoeIXUsojQbokDOFMstSPFYkUvtZooQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717553;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LDPivuZnnU8Rh56OehEp+c1hcVH92q7KfdacsYP6D2k=;
	b=gA4aM1HNBBo6L8bCLLTk5v6pZi5kEsWF3/tOiygZndAsezlMwTlHzi8SKiUhoFXm/+on
	 8MXQ/prpmROSWmtGnvPJJO63mSOMceKKDAaMA9YLDbJeun9Awm1qUpNHMNFfjCXBs+YTf
	 xItUqREkz45GRkLy5Pe/md7Ufm0mU10RSDGf6L5e66mX/ECokymzVFubojXfL2ZpbVRJq
	 0rLNyAiTCNjq/wYR4FuzD6j1FOswFJi6L+1I4h7qigE1U1MQMQ8o09ngv3NdJ8iwHVAc/
	 4+UhcfoNrsxgzzG/23+FsTC+QWkxX5wyk85BAbsL2dBOlb1Kn/d+whwhBT5WX4XMRKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LY1gFOl6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1860A5BC0
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LY1gFOl6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941F71F00919;
	Tue,  3 Nov 2026 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717553;
	bh=LDPivuZnnU8Rh56OehEp+c1hcVH92q7KfdacsYP6D2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LY1gFOl6JojcNE5Ns6UtOnNCIel+D0a2gcftWIHGqHrKCXlfoP/yT25E6rTpUQedO
	 cir/tgqH6eIIqPo/K6xhbnjjBDkUkReb9ppXeLOyLTTmLHY4eNxpmjtajlEj188tts
	 O+pGoe83rjDkglma1IwgPN1zWVVRXZQeHTBGT/CWkE2ywDxfa880dEZvRqwfr6mZBO
	 mZ7ECc/lBUYMnMGbWTQkAogpMPWLLBxhdonVY5KT2HWbtnqIe8z0rxshfwJtUVisY/
	 IivRdnE+qT+ySCQNTMgse4axvOmyDEbvGjZ+Z05DoHNLjgIOktBbQdLF0Ixl5h2Dyn
	 LtUBms2dabu6A==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 5.10.y && 5.15.y && 6.1.y && 6.6.y && 6.12.y && 6.18.y] x86/ioperm: Prevent NULL dereference on theoretical missing IO bitmap
Date: Tue,  3 Nov 2026 09:52:05 -0500
Message-ID: <2026-11-03-1-daily-reply-0017-re-x86-ioperm-null-deref@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103093047.571626-1-guanwentao@uniontech.com>
References: <20261103093047.571626-1-guanwentao@uniontech.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Outside the IOPL emulation path, the IO bitmap is always expected
> to be allocated when TIF_IO_BITMAP is set.

Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
