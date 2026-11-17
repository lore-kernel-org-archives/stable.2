Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912493;
	b=DCSPJT528itPcR4vrLpR+DGnhfzENidpdQRv2iPM9wBo0KeAFBMw8J7OefpMpCe5rmya
	 TkupymO/oaKf32i+d/WfLo6tYcgiMxIL9q/5YMFcjB/tud17b65b/lEAfvEMZK5fyw2c7
	 Hx99ajrq/i4mUMrkKkekQQGgvc5e1rzWCo09OjAleZ+6JBLtvDB6V2KGKJbN1aJdWjOst
	 YYq05mZG9X3R+skVsUqSvDjLSkPmCttApudN3vu9Y2oPBN1VtPI3XOcHTQPVrLvgEsDvQ
	 hIctYg1XVRfrd4hGQKQyUs7pL4kY3DnWE2SbqQhNucNCacKQJHxawv4s8lLQ+APm51g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912493;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hl3+N4JPEAimQqaE2OfAnYmrybBk8pfQNCorbB15Ywg=;
	b=S7dlN7s3LB+cEqhItzGlDXd+ECgJA6ue2xaKvj40ZF8ZkyvlCDD9xP/bMZr6jeDD3dfx
	 2fFuYWrv6hv/LbUvE4sIqcFLVFhCHuLakRPEnhwznNbI5fNvyNlQ6fkHiCMLSLni2PW61
	 72NYtNndfobukvy8+Sy7pvFjOjp/CXA8WjFoUhsMy446lcyPbg4K0D7LHO6MdeaTcF7i3
	 Q1JNBofBPV1CXr6xcI3WDJlgBsGwKtCVjzJXb+74S/OwP+w6ffs8zEffRq4NOZ0UlBAYO
	 oaYJGsidNsAjRWFw8oxVfvur9lq1nsmUWxKKrLUIANNjUnTKfIhcfCgekn27mSF4mBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=qMyuojZm;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D1606A31C;
	Tue, 17 Nov 2026 10:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D90D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=qMyuojZm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794912490;
	bh=x4WVJR1u0uNzb8LS1d4YG5eAfX/gHB6/qkNUn1eJBe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMyuojZmWYZ6iW/s7zSQ7lmEd6YkaEcSII3RGhfwK/0zBJ+nMsAKCJPUkoHr0qBBe
	 wd8NFMfAvO8/HJ6u8TCepvHgkUa2U4FveX6ZO0Bzq/W2z8lHvdOR8FJnimTpddXYSg
	 orniG//einVTXOXvI5JdtaPgwtzNRxSB+MLrtGXsqSPqerR85b3lld7f+Nirrv6QWi
	 EVvxc782PM8FbZODG491ouJ2JuE9/WsQd2vjs5JufchLKH21QWcL+z3fuhklGAIgAB
	 XoOUij7A9v2LInduUXa6ggHS72sNwefhTykAGUQHiogidss4+XlgCgIWx2NkRebBMf
	 7pa2UK4TuOK/w==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E27A17E04B2;
	Tue, 17 Nov 2026 11:48:10 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Lu <roger.lu@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: mediatek: SVS: fix device reference leak in svs_add_device_link()
Date: Tue, 17 Nov 2026 11:48:06 +0100
Message-ID: <179491248221.154190.12390341729677427224.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023082948.1854252-1-coiaprant@gmail.com>
References: <20261023082948.1854252-1-coiaprant@gmail.com>
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
Content-Transfer-Encoding: 8bit

On Fri, 23 Oct 2026 16:29:48 +0800, Coia Prant wrote:
> svs_add_device_link() calls svs_get_subsys_device(), which returns a
> device with a reference taken by of_find_device_by_node(). If either of
> the subsequent checks fails, the function returns an error pointer
> without dropping that reference, and the caller only checks IS_ERR() and
> bails out, so the reference is leaked on every -EPROBE_DEFER.
> 
> Both error paths can be hit in practice: device_link_add() returns NULL
> when the link would create a reverse dependency or on allocation
> failure, and the supplier status check fails whenever the supplier has
> not bound yet.
> 
> [...]

Applied to v7.4-next/soc, thanks!

[1/1] soc: mediatek: SVS: fix device reference leak in svs_add_device_link()
      commit: 8ba2b21adad087d7dd2fd8b12877ead8b982e694

Cheers,
Angelo

