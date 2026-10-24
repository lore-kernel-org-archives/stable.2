Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851359;
	b=A+OnqZIkUQPN8UFEYQLF175pd8PaMWf/r7eG2KcfgbMhS+7sUDd5Y91MH4OKrM7oSjUT
	 lFh+kuPp3XyY3boCk/5pNy7ZnUpzU552K+BRTS4/kA1aqjXJNYMc+FdDesGKob7TJz2FO
	 O5xsWBKWKXW74efpFhfgE01OJHX5tjAnTc1lwpGI4bjMLwBsDAwX4cspOfqkwQL4nYAW1
	 siwb4EoEXD2rNZG7YR/GdRZjFL4jZ2cXZNl/W/KhizczGFKvdQCz99HUuhwpsrbxwfSZK
	 h1XVmhj/D2QE4FgzS+wtt68mYWfJ9IN2UcqjIcDmJZkGv7/O/qqTP2rVkRH02cwoJtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851359;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=mQUiIMG8pU+fZj7fVkNGz8VsfuLR/oCGpEDsFyH3rW6Hv4ECaFCK/rzkpRs283Cky+nc
	 O/OXKjOvLXayoBMhgZXGvp/fJZjs45zd3kkKWKxKnBUMHc901kDvS/UhJPkT2zGJ+A6io
	 afN+30bCFQBIBDZ4bnDseLuPwnaSq1Ha+UhLksaiaBLilaQA5BWhLEIi0uvF5lmAd8DJa
	 ZnEZ3f+38sQ3hMup6hw+SjeDRwEtKlohktr/Yj5NuBYTRmBsfINXzw2tUR6zAlVR1XHAV
	 QHAOfMn0/Gz28QdWbCARHYOHIUuWm2gzNDPOFM9HQFLt71M8NmCCCQs3loukxCu39LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuLpLsSF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27CE606A323;
	Sat, 24 Oct 2026 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuLpLsSF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB341F01825;
	Sat, 24 Oct 2026 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792851358;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nuLpLsSFajQ+azd7ExUWVF62v9KmPcEUNnQ44t+cPeVapuic0JDRtRSnGA+CFpH66
	 Ui1UXqr2JlEYidRGNXO//lS89sGPOsFHF6Rwc4WVC7kLPBcdtqAc3T1ur77oHLKwPg
	 cFzNFtKwVla0b1QZhHW7EuRlgjhNsUOGVLPQ6CseAujZCfXlw+4krYtrelMtwLu7vO
	 GdZio8WTajUDBrjbNOevaKqyx014M6tS26NlVECNdgat/ca/VaG5FHemGU5kK+sWxS
	 8F7tYrNEaJk2fqR0r4Ox8vJqFjdGasqsr/15VfRVjWZcu1PyoxiIHSSOslNwvKCuI+
	 TOAn3l9XCKmMA==
From: netdev-bot+sinfo@kernel.org
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] xsk: fix multi-buffer TX software checksum
Date: Sat, 24 Oct 2026 14:15:57 +0000
Message-ID: <179285135766.3327.5451585432349279561@kernel.org>
In-Reply-To: <20261024141157.59301-1-testwrzwrz@gmail.com>
References: <20261024091256.17918-1-testwrzwrz@gmail.com>
 <20261024141157.59301-1-testwrzwrz@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
