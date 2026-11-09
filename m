Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239647;
	b=dojc+M3j0RFoBPUfqzoxUeyyZqG2ZbpCqKvJl99PKNcQFL5msQADcZl0JEVwrPtyE+y1
	 xow/6DCrcdjplDIch3YhkgkYQHN5CsnsqKHxZcbpiuE52qBZ/tUbD9ww6/BrojvQxCrrb
	 CsSVwYSj5r+QP9NFVkADxd/NZ2nxn27A/2WajWLWqkGjOsoGLUR/o4/l21jDVP2f9W2mu
	 LNw4XrlsD/Tp7uPIqHaeFJLb+sKTvunv5+zlrHsqP1iRUoalA/aZs6icF1AV5JULfowNq
	 G+wsP/Yd0PPldc6JaunrnLjKnEwTGym5otV6wOLvrj+XA/peV6InG94ovCe2bxMmehg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239647;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VbTfV/eNqcjJm863bC4Ya2yaOIePo98mE6aOgEIU+wU=;
	b=Dw0nWSciehY3tkZV9jpNBG/H8f6Kfg9QHlaWvkC7JCjp31jTnmXj03FX9a2uLovoB1i8
	 gy/sdSX7GYfSb1zBwc3/3ppzsmIXONWyb1Eepw//kegPQZnDIXt0UAiGxOt2KqAi8H+/h
	 pz8DW67qduBgvz3mvwMxJ5OaIjjnNjjdpNTZZP653K8i56njDgcs9HIRJBV8pbK8wP1Z+
	 BtkYj1jHJvmcDig3t/GcjZyJGgSzRKKqVeW5fshE9WDlD5QrFVbrQhPmI+9GZzFgkL+20
	 pBx9ObyKKN9CBJ8oRC8xto2fLEY+uo3qz4Wp25KRU2cShARYrwsRBN69Z1c2xLb7vIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+8HmGsK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6CA606EEB4
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+8HmGsK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910391F0089F;
	Mon,  9 Nov 2026 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239647;
	bh=VbTfV/eNqcjJm863bC4Ya2yaOIePo98mE6aOgEIU+wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+8HmGsKmYM0xFFmF9BGj+ShP3KC2Kew50am4u+SVXrUDqRwZzS3M0+Md+/GgsCUg
	 +cJH+US54DUNUNaHV+S9GrtZ+JIVwTg2g7w0md6XMsYU/CiQdnAZoQlq0mhZ8hTPhQ
	 v1COAikQSoVqVpKmkWovTnFX7NN+9T/2cMZPWWlINi0JcntElRetyelXwjGWVNjyjN
	 WLRQe7mCPGJQ40TXWzuoIz5Ele5ekGNKD+PULzyH+qI7w9uN4y6Kni9nfuDNMnG6zT
	 ZuSKKIPOn/VoREaox3psV3xYdYfrep17zqLCkiSJMMg3E/eedIfIY7JmwufT9BAsE7
	 0ObycX8kqJe0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 7.3.y] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Mon,  9 Nov 2026 10:53:22 -0500
Message-ID: <2026-11-09-1-daily-reply-0040-ceph-inline-7trees@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109030611.419331-1-zhugl3@xiaopeng.com>
References: <20261109030611.419331-1-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> ceph: clamp the inline data length in ceph_fill_inline_data()

A few problems, which apply across all seven trees unless noted:

 - On 7.3, 6.18, 6.12 and 6.6 the pr_warn_ratelimited_client() format string
   is "%zu\\n", which prints a literal backslash-n. Upstream has \n.
 - The added if-block is mis-indented on all seven trees (extra tab, closing
   brace misaligned).
 - The backport note says the warning was dropped, but the diff keeps it.

Could you resend all seven with those fixed?

-- 
Thanks,
Sasha
