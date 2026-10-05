Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D948381A;
	Mon,  5 Oct 2026 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208286; cv=none; b=G0VrgT61k9a6Atg9dWlVmuCE+MwQskAfjxoZWlNK5P4itsb/AaaDcuueh6r5vu69NAwoshj11NsgT7IV3gFCfdKtDtk+rMisZwZESTjvT72RcytdpUQ5UOHAUGsD5IvWxz16T1nuplu6TXaPd2wKLRpbqRYz3gXyAfnwl0TLULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208286; c=relaxed/simple;
	bh=3NjzWYutcPrORh/gl4IrUSuatVwC+D/T+erENM1I0ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OppcFJhAWSrWpuPfc+sTDPxQcmwTFh/2u+g5+0gCtPJbRslTmJy0/axD8X8ocstXj3UwSUPKNPRojbd60eZ7/6w4hCTuurAqxSy5K8ZbWHt74noKo2kRxI6GT5xk/BsVNgGyFz30h3wBg+C6AWEk1sKKvRJ20bRqNran+2b7su0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwKoOcuJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwKoOcuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB371F000FF;
	Mon,  5 Oct 2026 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208285;
	bh=GYeRblUwYpaEcsFBUVyp2RrHYnUZhl8nRNM/EKTcxcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GwKoOcuJR7SOVihWDa5VpivIcwj8DQ9MMwSbekeM3SZjIMCuiNFCTwf6YR0WCy244
	 bfddiuxAgLqWFh4TxSmTI+lYCMPR+jA3Y87GBDbCDABpVuuCaGIzhOAsRqYdDg2Fcz
	 +auBOWdnFFuYI31xQQKKGaK9EVkhkJ9bXVC8SyDkv+ylBQRPGgaSiibRuumshGVxzI
	 /OoKEcujuv4x9P/kqBDYsMr9Oue02fPsaMqZwT4DnJOY9HwZ0Hegf+cCeMeWgsgo4H
	 cgU6lfb5bgYBJpAHd+wgUSeAfzKmImpKd9K0HZmdrm/lvFFwItXymg0lNzhj7dszgo
	 z1w+kLypm4IKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan McDowell <noodles@meta.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Baoli Zhang <baoli.zhang@linux.intel.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.18.y] tpm: fix off-by-four bounds check in tpm2_get_random()
Date: Mon,  5 Oct 2026 09:50:26 -0400
Message-ID: <2026-10-05-1-daily-reply-0005-tpm-get-random-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005075730.134611-1-jarkko@kernel.org>
References: <20261005075730.134611-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix this by checking the response length against 'offset', which
> already includes the skipped parameter size field.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
