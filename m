Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05973F4DC2;
	Mon, 14 Sep 2026 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373257; cv=none; b=Z4vhRDoyzVc30CGG9rl4gM9FkBhHYiKRVZIYcmNWczSCl355Nv73nsOh0iRL4OKoSR7mDHCFqsUht7oFWeUN0pBkQ1VEU04IbYaUHQStJ8GzWR5qgNiLXzijDnkMj2raMSrxAWmz6YEY/BkumL7gUKtaZtJdrrNW8A+jOzm0AnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373257; c=relaxed/simple;
	bh=8e7WGv9Wbn59L5zZG9EX7KZXLR5OzQsjUIfycOfg8WM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HTFx/PSs7IPjRA3puvjbPX53taZ7qYNXw4IEx48iY9SzW/ZKtCY+W82d2W4hmfyXiqmX1Ato/UAzqJz8MyoHXetn1ETKjcnBC8n3phNFJqEth6F2HH81m1QE02r7PhnIIkYgMI27/pj9Kdas/90aoxeSqmnIsDlcGsGHbrl9MJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3XfDGpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3XfDGpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9111E1F00893;
	Mon, 14 Sep 2026 08:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789373255;
	bh=IzPzHT2O9FcOj6iMVx+MrnepZgj296Jj/Ts9i8e4R0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=F3XfDGpu7a5ak5OovQ9AvQpAc2X8WC82R8M37ob14XYX6u+HiAfDNrBK5qxDI0cEa
	 VmDY4Vbs0fqVAbi4fXPPt+ouX/C+zcv0kK9c1sR0Kc35Oe7jxyAQK+H58so9b4Mm55
	 X6NBjnYUeb7QaVqfi1J9oowExKPK8yE2VLZRxQofldmAx1tU7Rr/MaeV9sjevLf9NK
	 mBR6T9ma9oKERL6zMN26F08UR8DKqu22jloHmpDgxtbNmsLUPB6+ybfeOKjNNILfKy
	 19KYK/ip4i0VtdmqHw/JJ75PCQqhz+vBsnv5/oBPf9lR5kR59KxZR5CtuUlHtZJReL
	 iINyFzJ1VNUIA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Yifei Gao <gyf161023@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260811225102.1077841-1-gyf161023@gmail.com>
References: <20260806235056.456341-1-gyf161023@gmail.com>
 <20260811225102.1077841-1-gyf161023@gmail.com>
Subject: Re: [PATCH v2] misc: fastrpc: fix double-free in
 fastrpc_map_attach() error path
Message-Id: <178937325340.257763.18070145219812711052.b4-ty@kernel.org>
Date: Mon, 14 Sep 2026 09:07:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 11 Aug 2026 22:51:01 +0000, Yifei Gao wrote:
> map->table is assigned right after dma_buf_map_attachment_unlocked()
> succeeds. The two failure checks that follow, the len > map->size test
> and, where subsystem VMIDs are configured, a failed qcom_scm_assign_mem(),
> jump to map_err with map->table already set.
> 
> map_err manually calls dma_buf_detach() and dma_buf_put() and then falls
> through to fastrpc_map_put(). Since that change the error path tail is
> fastrpc_map_put() -> fastrpc_free_map(), and fastrpc_free_map() already
> unmaps, detaches and puts the dma-buf whenever map->table is set.
> The two operations therefore run twice: the second dma_buf_put() drops an
> extra reference on map->buf, and dma_buf_unmap_attachment_unlocked()
> dereferences the map->attach already freed by the manual dma_buf_detach().
> kref_init() sets the refcount to 1 with no intervening get, so the final
> fastrpc_map_put() frees the map synchronously and the redundant cleanup is
> deterministic.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: fix double-free in fastrpc_map_attach() error path
      commit: 2159430fe26068ca3c89557ddd2d5eb17a5a8cf0

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

