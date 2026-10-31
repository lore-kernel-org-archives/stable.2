Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793457459;
	b=24SJRvMTtXnD42AFOqLBhJnYRrksITKeAaoyYyWZEakwYJoQe42/Tek5W3EsfDP9R5Gr
	 bFQQ2sxyBYUGoINqg1hTlzXyiGpRq7i5PoNbNnL3elvMpbMWxUHOsFcltNEk3nWSQ88oW
	 VMZZcMVXFdQAFX1YfNv7GZHKDzsCaPm9Ghl9YmsIhfFtYH5a7d9NnjVdf7nTr6FXPiOU0
	 VVy4VS8RRJt2+bVyJLzNoxXx5WJjYnLCeF9FZU2FWLqKhX1mgex/qho1hSM6C6zAzgBuS
	 Gu20fgD7ifY0EC5G+gsdCZ1AOTMvZbZaOmVRK0QMEiREiXy1JdNDwCWmMasNh8+sO3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793457459;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=com4tf7eNvFeHXYior235CsQNxUcBzH7h9gxsnVNz+M=;
	b=aQyMIMs3SRE6GtoqSiz89u7FLmZ/Kzq/Xz4NAx083MwyWv2uFDFzGcs7GFWQSO0ckH5K
	 Lxy/IwbWWn1fuTAy9UZQzfNOi9RCOvD0NNwkz/IJWsUEUaiU97pzHnG5TIdhbRuvMGyyu
	 NLCe+S+xyQ6XfeYGUhLGjrFU1OjhaUwuMOHjVZp7JwFOCE8cZaIGicPciTrNW3iDDCieI
	 VeX5jqAqtyJiCl3a1qYHWWO9hDo6p6J9/wU4nE0c9bNsm1nnY+BTz4ltwwrMdENlf0agm
	 WrRZ+6iVytPpsWlDao8FggwDu5878tR9jdVrg0HhzyBELEy83F3RvQsqqRZZZicC2Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJp3wVBa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEA606A31D;
	Sat, 31 Oct 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJp3wVBa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC6E1F000C1;
	Sat, 31 Oct 2026 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793457458;
	bh=com4tf7eNvFeHXYior235CsQNxUcBzH7h9gxsnVNz+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iJp3wVBaOg44N1EI4Vv531dL6XN4jIawq+9RY20K53Xh18KmmepPtLtdbyNWonUvG
	 Y6ETztV4fTbIAErxRu3RksaOL45P4Iy/8eQGaZI/WP5ep0CThSMuD9PVaJh/bzluTP
	 a36VJ3xwTNeLB9J8ugRpyTpjcP/1K7/5l3OBVzd7kO03qdDxw8jjxnAX6XlewEleGk
	 5Wzboj89zoo9Gj7RYoURBT5TWBF9P8hz3+kJTs8WLrMp9yhXf0BUNrCeZe8zQv6ZPT
	 ZAgB2W3cNvpmqGXKTh5OJ7A7bvOe1cxWGqqtE59ypf0oMB75e97NPtpMzFbrS/lInm
	 Yp8GGV33tXqeg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jianhao Xu <jianhao.xu@seu.edu.cn>
In-Reply-To: <20261009060155.1162262-1-runyu.xiao@seu.edu.cn>
References: <20261009060155.1162262-1-runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH] memory: fsl_ifc: guard optional NAND IRQ cleanup
Message-Id: <179345745629.29452.3239719918835071572.b4-ty@b4>
Date: Sat, 31 Oct 2026 15:37:36 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 09 Oct 2026 14:01:55 +0800, Runyu Xiao wrote:
> The IFC device tree binding permits a controller to provide only the
> common interrupt. In that configuration, irq_of_parse_and_map() returns
> 0 for the optional NAND IRQ and probe skips request_irq(), but both the
> probe unwind and remove paths still call free_irq() unconditionally.
> 
> Guard the NAND IRQ cleanup with a check for a non-zero IRQ.
> 
> [...]

Applied, thanks!

[1/1] memory: fsl_ifc: guard optional NAND IRQ cleanup
      https://git.kernel.org/krzk/linux-mem-ctrl/c/f3b0ddf7a9a3de5a59ae7e25943d60a924d05b99

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

