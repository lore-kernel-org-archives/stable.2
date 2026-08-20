Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD93B840E;
	Thu, 20 Aug 2026 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254865; cv=none; b=sJhaPccv7I8lKqHY4DqnDFQKdRa/LIVKUfDDaRcjC9HvfhLsYpXi3WKv85ZoYmiXKtgJ1Pab+qPhD9vB3MLSqcFKsI8uvOjaAaeluVXbHIeSAa3MPwhUD3ZS5q21zdqXyYTQqmuyiD+0XEa2+oKdgl93NjMoXvz4fV/4lAHq1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254865; c=relaxed/simple;
	bh=K4nc2hoZdsVI24iFfFJeoqGHnZW7Sv/s3DtpfuEJOJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b04NsT7gaYCfN8t57UpU5B3kE1Tp0EXl5AxtCXNGIGFRnMKRedkFFpQGGKfffgIELyh8cuxh4m2GTA2up4A6/RQQ0ImoMQlMJ8+IECKfxaIe1XckNUo1LNfr6TrkfVRRJBx8LyprEDgE3YMtwfXF37nsL2dscLyYpd2Q6bAVbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzwmSLcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzwmSLcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFF91F000E9;
	Thu, 20 Aug 2026 19:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254863;
	bh=YbVbk3phJPiABIQsr/CWJgb9+r92r342EoMtGsHWBq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GzwmSLcVw7tO8govzh2CkZROz2G1lFxxgZ81GyFwAqe6VMGVjBR+yqZ/Y/bS1nVWI
	 398BXZeHkV95rqdyo21C7D4fJrivJJNWtzgsr4yv5lVd0ZHXWAO2JmMZ8B29tdq0BW
	 ldQ4hUuh5As5tOZS5pZj/C3Rwfm0ehigc2VMSSgJEquOtHB2EUYUIwwVuhQQwVNmvt
	 1hNW+FzzJYkIyD/vOvg0Ngbmq4glNPMpLwj7qRAFyc4gOvJi+mBm3NJEg2yy1fpjH9
	 63SQcVa8Rch16lx3eBEGKKyasEYU1ayt/aMhknb62WPB8Pil6r8Nj/RNLtRG6RxT29
	 yPAykNgIeTOQQ==
Date: Thu, 20 Aug 2026 12:41:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, dmitry@broadcom.com, eilong@broadcom.com,
 ariele@broadcom.com, yuvalmin@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 13667453960@163.com, Sashiko
 <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] bnx2x: fix NULL pointer dereference in
 bnx2x_free_mem_bp()
Message-ID: <20260820124102.41d18d4b@kernel.org>
In-Reply-To: <20260817151326.765824-1-yijiangshan@kylinos.cn>
References: <20260817151326.765824-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 23:13:26 +0800 Jiangshan Yi wrote:
> Subject: [PATCH v2] bnx2x: fix NULL pointer dereference in bnx2x_free_mem_bp()

This patch does not apply to net/main, please rebase and repost.
-- 
pw-bot: cr
