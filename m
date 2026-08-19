Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831D37DAAE;
	Wed, 19 Aug 2026 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110354; cv=none; b=aoHfJSkWc3E4NsIQTd1SQ2kl2YhZOx4VnYfXutf0Lr45QjZRhhJpc8WGNWoUfUowoqNUVAzdgNsIu8h/6Y7Lho+5mvPmwtLYjg8/kHcX8wVlg3Rhbm81qnAiz8y0x1mius5E6utp/ItzIEbT+1pZQL1Lt+t93MPrK5boRaNkJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110354; c=relaxed/simple;
	bh=Z6yTlG0UMFfArXLh5lgmcLP9n4twNCqgrT+M8qitUBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb1vBT7IfVCtO1nfTZ/KbvwISkzmkOhNsCWRuMjvzwl+GYcyhwLg6BwPyHhG2tzUjYB5exuILt0dDgEbuBcPbKJbPicH6bdbSZF2yFcOFa2ZvvaLSD2MvdZ1AZT2ru+zJBjGkF12L+64MNDVZh9+LKlPRgvtNF9knKmr7VEGFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrJSi9I1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrJSi9I1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486091F000E9;
	Wed, 19 Aug 2026 03:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110353;
	bh=BtQbj+u+MUQexSxtJ0tuVp5UZEsWTY/w6sB3Bs6NvNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YrJSi9I1Cuf00pkoaLESEI0pc4ydP7v1lDllYIwPSSxpsCkAi/gKg3Rj0QpYK2jac
	 7Iz00981BsqjbJKc+lOQMjjdPU4JI9cai+fjjKkhA3TV0rAz3S4IC6q+E0qkH4I7pm
	 fDs9MG2Xy7sf7mDdSmWlBSgdwMg4we8Nx1Kx49kRGdOJY1x+Yc3v8WaA/IK+bVnBek
	 82Yo1z3tSSLjIm+4rmG/RfdNYgRvAZBS1XM+Inm4ug+Od5VfDYlnCbuB7ezGyR5lV6
	 04MB1pAgdB2+GHre1ffEau7f5yI0Sp1+zbVVJpLJXWZhsWqhaX8dToeK1CAKOVoZ13
	 4ZcE2w+VVq6pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Weidong Zhu <weizhu@fiu.edu>,
	linux-block@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: Re: [stable request] block: stop the timeout timer when releasing a never added disk
Date: Tue, 18 Aug 2026 23:32:15 -0400
Message-ID: <20260818220420.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817195833.2971170-1-coshi036@gmail.com>
References: <20260817195833.2971170-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 17, 2026 at 03:58:27PM -0400, Chao Shi wrote:
> Please consider the following mainline commit for the stable trees:
>
>   26cb8ebbfaf7 ("block: stop the timeout timer when releasing a never
>   added disk")

Queued for 7.1, 6.18, 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
