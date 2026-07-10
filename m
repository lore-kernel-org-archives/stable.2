Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2713A5422
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717411; cv=none; b=XQezV1zEmA5orHxLOtPG7J5gAnNGSI14VZdjbr7y9hRnzGMOvxc0UgtJyUtK0zzuNffxdmTRXwj6msQkX7MYbHKCp5WqH7Mqfcp5WRbZG7lwj1AKSbgUpzx4sOD9DvDjG8ySkjX5mBdcfrrbBZRu/pKwqnDD5ecZJChpyD/Otrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717411; c=relaxed/simple;
	bh=dGhvgE1KPwWzvjYxuoJ0GOlhR7MymQh7elYZaRPNznA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl1gMh/4NdhL2GHdI9sjN7A7hdfpEoSFnysKo0pMHRq2kfgohTkchY25Ebpqp7DnP8eP+yAhNgbk8TZOaK//Fe8yb8mDqyPTJpU7vqS4Nk7El9T6t4IsxncG/7KoiURqmA1zjXZTZDR2qK7iY254oXmS6Qx3zescKM1uUKKf+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggspvjEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggspvjEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2C31F00A3D;
	Fri, 10 Jul 2026 21:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717409;
	bh=ULt6gHh2QCdF8zBbv63MnnI7JTZyzfPB5ocJSvuLQZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ggspvjEe71UciJcW4OC1V6S1KpRjoNP6I0ns1KgpIUPl4MTl47uLWtTmizQoQeK0W
	 o061InGZCSgctE/0HeDeRIVuIjEqi7s6a3qazXS5Xvsx+inTrfboLP3UsZdltUfw7v
	 TduLs8ntNo834jp9qOUGG2l6GXyMrxvZsVfZCMAtSkNa+oM5+9mN1f07S9NZ2xUC8v
	 Qx2RMIoIP2+of6P/1iKR+2ZTlEDJLUFMUoNmK4n58A36Xu9bwfTGukgRkxNSIJuvqA
	 Kx2/IlzPqZ+RO8nfB9WhM4el364snvJMV55nbuPiTlGQRM0aswqkOnOTyLC0RWY4x9
	 J8I8iaFXtKd2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: Re: [PATCH 6.1.y] virtio_net: Support dynamic rss indirection table size
Date: Fri, 10 Jul 2026 17:03:02 -0400
Message-ID: <20260710163023.agent5-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710112521.234909-1-pulpannie@gmail.com>
References: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com> <20260710112521.234909-1-pulpannie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 10, 2026 at 11:25:21AM +0000, Hyokyung Kim wrote:
> However, the indirection_table was statically sized as
> VIRTIO_NET_RSS_MAX_TABLE_LEN=128, potentially causing issues when
> vi->rss_indir_table_size exceeds this limit.
>
> This patch implements dynamic allocation for the indirection table,
> allocated alongside vi->rss after vi->rss_indir_table_size is initialized,
> and freed in virtnet_remove().

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
