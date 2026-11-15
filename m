Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786072;
	b=rLxnxmsRk/beyvOxKiP6QFhLVP/f2Tscb25lFsbao33uUqfgvdvjbr68wg34o04Bt+R7
	 9C1njaVmSJZBdsB/yIcTY7keC8OjfP5IcMa/C8mKXoRsUa1w/DdntAlEFIzB/neKDbuAB
	 fgsdr+crzPVSswh35wghskB3PmpflIUleZNBHWiCb2oUHgJKjHq2/Jh/ShHZ5fJgMr4V1
	 eSquWwegnq3Asd84dcJg9eX9leARBETTyoVi1m3edz+7DBRAAuNVm991E7gjrfrV7L8e/
	 xZUlIVyr2EeaUXE9rBSQdLiGMLU2hgzhUXbY1HTNdwlFdUKEoVgT44LIA5gVoN7fcdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786072;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ARpm24wDY1AqJgIg8sO8Wav9gx3nmdleNoCMKL5Pkeo=;
	b=GrfrqX/c+loW6mAbTTlf+jQwnxHA2hKQVLUMdPzuoYzlGsjuJmNEQp3ID42IX/A2DqTU
	 uy1K058weIOeIHu7GNjNIELhPKLVCHfkUmGv2O+6nz0kZYxhxbHUkYAuZ7xXpa6ZgI3vk
	 N2Ks3ExHyAx+C9DKe8FGUKPouim7ciuWhKmcLVFmr2KgRySchwQEKZNfZgfgOcwOdcoIe
	 cv+vK+MIc5fS8R5DnbTKPK/O9L6d3+Wx0rqbjtQuC165NfeI/OPMEzsEsnXEt/RrgvOz4
	 4cLxn97Rthyjm+eqFdcRcuAm70hzJAa+Uq6vSwRov90D3YD8am+x7ghqGbvJEJPlZUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkXT49Cv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AB606A33A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkXT49Cv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C691F000C6;
	Sun, 15 Nov 2026 23:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786072;
	bh=ARpm24wDY1AqJgIg8sO8Wav9gx3nmdleNoCMKL5Pkeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jkXT49CvUK3AyHiWz7PHnJmR5DuhyIjaVhAzxJeIl1gJ5dnvWCq7x0a4pRVpaHniO
	 qtHD/m/earrjKdf8m+9SAwK0iXhCojUIzteMaAYX0ns8l4lwodBmLH+LDTAYcodtG/
	 rdWVKyg+fVrR93AYmk8yc0MsRdykA4aLY+lzU5rX2VJUdP8FFcAUMa3uGs/Ps6bAJC
	 Elam0WY++9OpQAXpo87MI9adBC451iRdbZaqj3BNvq4ZAJxiKE7ZJHSd/Bs2guLjwq
	 KfPLrrV2r9IZK+LZSwgTuMr2Ym5obcxFI6wE1nlRsePTnG5GUdqn277hCM/9dw0RSB
	 gFG9wx5dGpbLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	ljs@kernel.org
Subject: Re: [PATCH 7.3.y] mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows
Date: Sun, 15 Nov 2026 18:41:04 -0500
Message-ID: <2026-11-15-1-daily-reply-0003-mm-vma-lock-seq-73@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114175238.44352-1-ljs@kernel.org>
References: <20261114175238.44352-1-ljs@kernel.org>
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

> [PATCH 7.3.y] mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows

Queued for 7.3, thanks.

-- 
Thanks,
Sasha
