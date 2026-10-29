Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299433;
	b=5WOvNgTAyQW9R+pBVN2PuYWXfJfr2L2+bzYehjjnR2vW+jt9vxAg0MbUFxR5sRs/aaEA
	 1ZhOK5jQ/zYLAyfHZpGUkQnfLt2lbypJjI8WgKNOCOpE3di9SqNgP7eMwkc+6VHHkFeZb
	 XNzF0xGRFO4IMzQdKjPgtWrqlCrYPWMJ+v5LFTX7d/N5VvJ5jTTu4LFc2wuVgIZXaUi5i
	 ViCkjDuQcsEanpoG5dcGydkN5lUGS7v7lgwoL2JO0D5VCW9TLsGEzCmKiMghhZmZs0Af4
	 0usUB7xA0GCb2DGx6+8FI7n0+KcDTjmrg4og+l05zVw9JlgDoJagWE+AWU/Jogyl5YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299433;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5RlOZ0RJnKxUgeMhyqw1L0vtv0SrDqaFrd5yVGZ9lls=;
	b=M7ICHZnvJZxqiMXStSN+F8Go9XQEl5KGVCFG8TojB4mkl8nYUgs2FOgBV5lcnhvAwo7C
	 fOObq/m9Rf3LUS913wAfps5KrCxc6l0j+WmEAtpes813U/WWRymr/LqITBE3geEM04FoS
	 97J/abHkyxoQ3925e/YMGLx4O9ecfqOJiYS5eE9l//z7BlA3JL1HFMjl+J7en6tmiJKFt
	 nbbQ5ecf40rg6nnAqvkzPlycSWUatgZQKtVtcFqJEw4nPAsIaZIhlHgmGWd5IpOZ9BctO
	 72RXViMGZP/Xxj+FS7+C3ZLcnTugbgUOS8LP1dXmAoifCw5FZDb2Z8K0WVb4yMDX88A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ac/UXf8u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C328606A329;
	Thu, 29 Oct 2026 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ac/UXf8u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B351B1F031F0;
	Thu, 29 Oct 2026 18:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299433;
	bh=5RlOZ0RJnKxUgeMhyqw1L0vtv0SrDqaFrd5yVGZ9lls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ac/UXf8uFBzxv2bpCCzl7qRy0rDogI1PYO88cY0CRfc7m/4oc/gb0xPzCa26OlZRh
	 7tEvn/S/wb3Y81YeeDPe/YLBl0pWmgW8BbYz5B9109czSpiS8wfunoNCZNwq9pF9KB
	 CGvJ/y3ksPu/l6nXRVeKpLkTVQu5/Dqy6wq0zR7gwqFhXilMJA1viOxfST/Ym4K2/s
	 jxA18FFm9dasRD3UEafADVEjXpJ/oHm8jO7DNPb094PPrxbeVtHVQ0+RfG9SInmBdi
	 +DPBLs+4UwYLJRyteCOrFaG03DjAkbdMdHk8o7+BFsi3k1pUTPgGUl2swgjanVbD2Z
	 8yBItAgxVoVag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.6.y 0/2] mm/damon/sysfs: fix pid leaks from wrong error handlings
Date: Thu, 29 Oct 2026 14:43:23 -0400
Message-ID: <2026-10-29-1-daily-reply-0016-damon-pid-leaks-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141430.161175-1-sj@kernel.org>
References: <20261028141430.161175-1-sj@kernel.org>
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

> DAMON sysfs interface can leak pids due to wrong error handlings.  The
> issue in the mainline has been fixed with code refactoring.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
