Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344382;
	b=CM6V1ra91N6rMbHbvViDvqcFp4vEPqkdtTIQc7A2h/fi/mTmWuucog7aL+krzxZCSTJp
	 Rz4ZCBAL1qG12PrSy2bKiLkVu8fsIXGBGTlQqDYEs07yfI7y8CFSU6D7XrqhCE8T6TTk6
	 bxurCGMo5bZKrSsgTNXn5eXzbbedFuXdxhob2zZezVHmz5EpyCQ9fBZurPZfaG9LQbEqi
	 l3MUiBAVH99iv7h9GX+l8MzDZcimjkw+0uvE4O9DbKNufn0IW1+z/RUSP09LEZDNDUChg
	 zWZa0rebK5HGucZK7cnb9ntrEYiR5Mo6q2O8Xir82j8THxv28MBOtDuA/2Kk6Nzvpqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344382;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bRLf2eJN5BnQ1Rs/bcxgd+v8VFy6BbzXvv2K0AmYCKg=;
	b=xroSyXHn/sdMVISE5j/A6F3xP2X6WODn1YY1WZY0L/4PKJKoRe5nJd59cPSgck3223E+
	 QiQcRdJK6VPbillJ6a+NCqXHC86S6SgoNm0QEYN1FLbZ46bDeqEYLM2uLPWdIyyVCdkJW
	 gN/9gZko9ByTxvc9eHSpkXYDgpi69mX5tzfhzN5KdNvAFdtGEGLVLNmlrZo8Qg59IBXHO
	 2Mmeab/Xaa+HmXMrtr4DPgCdP0la1+ZVe2jpmdXIPjFxbXTQ1Re8EK9IOEXHR9p2Fz79u
	 O21wkXNmvNj+UmAEBRuevJjYAJ924xoe6RFtbphGHBg2tZ/5Y1gLWNCVvtHNyyIm2AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlM5W3Mz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlM5W3Mz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389351F008A1;
	Tue, 10 Nov 2026 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344381;
	bh=bRLf2eJN5BnQ1Rs/bcxgd+v8VFy6BbzXvv2K0AmYCKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nlM5W3Mz7qJXbzXx+vZqRsw7/wYbIpJjW9CVOWIElD2gFAzHeGVdC3miiPm60ZYd2
	 yysxsqTt2svLatsCIvl1eKxOT6xEE55TJIX3kMDWCll7w6A8sAQzmD5BY9pjyHesC/
	 GLvjcxlUpHEPLybSF2JtQwHkTzs72dGROkS5tND0AWjvlPX6SEM8O/u3jpfP/Su2g+
	 oSh7ZohunDzJRGuH81LixqMm13wLh1Qkf/5NIWnTY1g8+VmbnojQTN2cE37piI3rD9
	 ALTwJWhYqsc082U3k2/nSs+52KPp6sbJTpIkRV0F+4SV30kTdjQADQ0AVr3xLU8Tst
	 OnNBSRP3E0ZIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	ranxiaokai627@163.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	linux-mm@kvack.org,
	Hamid Nassiby <hamid.nassiby@nokia.com>
Subject: Re: [PATCH 6.12.y] Revert "mm/page_owner: fix memory leak in page_owner_stack_fops->release()"
Date: Tue, 10 Nov 2026 15:59:04 -0500
Message-ID: <2026-11-10-1-daily-reply-0008-page-owner-revert-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109141509.2880440-1-hamid.nassiby@nokia.com>
References: <20261109141509.2880440-1-hamid.nassiby@nokia.com>
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

> Revert "mm/page_owner: fix memory leak in page_owner_stack_fops->release()"

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
