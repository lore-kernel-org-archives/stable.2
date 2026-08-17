Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DCA428830;
	Mon, 17 Aug 2026 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979932; cv=none; b=hmVCAHbCYcXin6cTn9LB1Qyk0IFKJYEsfKXFeE8I15Psf9FfdUnJnVNrpH+iBcgtRgSCGYM/XpnqQ04B3h9wgIqTXYK5GlnNoYJ96yKbST7Xh/gw4pE9dQQcqg76tJ6Fr/HWgt3aBdYGcATyuCx68acOlF93IKKAklAJOG0zhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979932; c=relaxed/simple;
	bh=v4ZZC9QkLLMc4yoAk839Oo2ar7Abh68ilvR2z5N1Q9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXPhYGfQhA1c4n06IKMwALbE5vypNNovuF646Qx8H7endZ5wN7KVlMArBjD/1DANAA7sOJL3aC0XGk3+LKluP1BAU8ACZ8BDpGmsj9NdvBDgHlEFmLDFyHYWNww2WmgO1JP94LGTkVh+36VgfYAkpEv4nN2rB9tdWK0KB72krvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKJiRM+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKJiRM+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104741F00A3A;
	Mon, 17 Aug 2026 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786979931;
	bh=v4ZZC9QkLLMc4yoAk839Oo2ar7Abh68ilvR2z5N1Q9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jKJiRM+xzo66KAr5FzFbz9OqiIgInoYEgHmig2TZmpoB8ebwI81yaPOcy+O3JBOUO
	 LE7QFRnhnOCLfEWXCNf9wty596FIrWpwcU6ezy6tp4gb5qVNPFmQBUDGGGv5Zd0m/o
	 4J1Hf/GYdwwXfMPi/Umnz6ObKGOh7GbO9rIFCxcQk582HMpFiIWwvdwk9n6S51is6J
	 Q//GxhSYEVG0PlPKiqYfnQZDKRZ5oXYifTV9iUk4qegZ8eUA4S76uHcl/m0046Be23
	 j8MaRKtU22EIlTbVIWhWtWSdPnVvCdSsIpXr9YXUfEhWyAQqsOXw1zuLhxQjdLkaN0
	 KJz9rP/EnoJpA==
Date: Mon, 17 Aug 2026 16:18:46 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: nv: Fix life cycle of the nested_mmus
 array
Message-ID: <aoMmLrIjlykQJ3BP@gremlin>
References: <20260814103230.858578-1-maz@kernel.org>
 <20260814103230.858578-2-maz@kernel.org>
 <aoMhRtpohuNHcEzw@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoMhRtpohuNHcEzw@gremlin>

On Mon, Aug 17, 2026 at 04:17:51PM +0100, Lorenzo Stoakes (ARM) wrote:
> One issue with a typo'd type below (the compiler is ok with it because it's
> expressed as a sizeof(ptr) but it should be fixed) and a small nit, and
> also Wei Lin had a comment re: the commit message.

(oops - Wei Lin commented on 2/2 commit msg, disregard that bit for this
patch :)

--
Cheers, Lorenzo
