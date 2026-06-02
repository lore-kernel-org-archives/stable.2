Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493EF396B84;
	Tue,  2 Jun 2026 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424516; cv=none; b=aeMD6sA+hH3kzLRjzntg/HTu9NWg9Nj3DaTz3QiQijmOYHJaL58wm1p+ZbDkp6q+23ezKUpOWfWd9/22gPwXMQU+gxx3H4tR//kfbBC1Vy6qTUosUJK4sqLMOLjgWW7UmohB1hVdkJRpjUna/1ngmF11CHrAJVls89OIT9cVXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424516; c=relaxed/simple;
	bh=VqcC3FAALlNFchhDu1XHRiw/utxjMFlHh0rIuwzVyMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3Eg5S66/XNjCX0suCllWhM7b8x5+1WkUjVgK76rGunaQAGI72mRZCNXVZ0yLK28qHPuQ52xddeBcwOjx6UtGUOz9+JzpgbYjW+EZH4mcCu5WKtsZw6TJNHhFWSbQyFQIWkmn/By0q5ps5KoTVqFvc69Y/sYjIUVdeqHNvVy1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVbU4IXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVbU4IXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEB81F00899;
	Tue,  2 Jun 2026 18:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424514;
	bh=VqcC3FAALlNFchhDu1XHRiw/utxjMFlHh0rIuwzVyMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVbU4IXtXkkczzi/aIwB0rnXter1VBUqzgt5fcAJ8lSc67kRfYbFOLVoKncKI+D2r
	 Sg2LS9dpM/SrUGOVv62rCHcQIC7cN0cNcevwoz7d4maqSTMcT1PLy18dh/7+vFbL8H
	 ayNzYjvNz/amND+xlcxGXTNZdtpcsWfCBwTXG/SqOMLtVXNp5Ln7AL/6Hh4GfHhkdq
	 PEY3km+lH7Ftaje7csaadQ17wNRgNerVQFnVR6J2Hj5fA7jsNil5rLERz86S3pleLc
	 nTJvJGoTjasCyPygcQNB061olLfN89SWBmAK8Jm4cMBmdMTdC8mLhdrmYWRDhtphHT
	 pQfwHsyuAY9cw==
From: Sasha Levin <sashal@kernel.org>
To: Wenshan Lan <jetlan9@163.com>,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 5.15.y] dmaengine: idxd: Fix not releasing workqueue on .release()
Date: Tue,  2 Jun 2026 14:21:30 -0400
Message-ID: <20260602180900.idxd-release-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601052412.72913-1-jetlan9@163.com>
References: <20260601052412.72913-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 01, 2026 at 01:24:12PM +0800, Wenshan Lan wrote:
> [PATCH 5.15.y] dmaengine: idxd: Fix not releasing workqueue on .release()

Now applied to 5.15.y as dd377066acf6a4 (backport of upstream
3d33de353b1f).

Thanks,
Sasha
