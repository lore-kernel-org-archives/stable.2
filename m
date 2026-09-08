Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD3374185;
	Tue,  8 Sep 2026 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850091; cv=none; b=q7tEdo1Q8Ot66D24oGryqftNbpVkw6EfVIvQyTOqG7Vh3FAmz9mpHOlgMOviSLXRgxrx1YYOph2qDmAc98vUpoo5iwN7ss10XJp9SrECxxKV5NNksF4IrFYniJ5YHV88a0lalSf0aCthboPw5BMUJnRoKbAfnijnhbV9aU+BwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850091; c=relaxed/simple;
	bh=4vCBStj0otTUtVTu0qj6MyOrMVUSPf9QFSW5L3m2yHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUjhljIesGy5NEGG0D7+FImGwRPq5n+iOfqt50+Kp6HgzGq47gGEflRmuXPiQOdj6O1KUZPCa6fov+yIMJLu7j5isemKJbRk/SF7Lqs6PWqAjRyRzB2KnZSwH0tzlS9p5bJV7VatbsMR2bRABQSc7YNd5ZgBPt+Gcj5WvzoQWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SaAEMaGt; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SaAEMaGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=UcLQ9MAJW5b7qdzE56lh0/qw2q5Zbh2qXeXHiBMDoj0=;
	b=SaAEMaGtaLuG2bda4JHBuyKcmCGbEsj/HuOgmPUpVoBJWwCuhe62u+H3GgO9s7
	bUPsLQRDyWbxQ2hGsnfvmy0OKDwv3ETXUv23ayJ0pT0K4MsulneHw7pkVyLjk9MI
	rfmSTOc+QVTXFFvYqdO6NbSWJAz7P5Ld6sIj1dl4/h0ls=
Message-ID: <cb505bd8-cd0e-4a01-a8ba-329e60f2c0a2@163.com>
Date: Tue, 8 Sep 2026 14:47:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: KVM: Validate MSI data before routing it to
 EIOINTC
To: Huacai Chen <chenhuacai@kernel.org>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, yury.norov@gmail.com,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, zengchi@kylinos.cn, stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260828093604.56622-1-zeng_chi911@163.com>
 <CAAhV-H4Jc4txZ-cQO-h6yZmfk3YEgeEptKtRQcDO=US3sies0A@mail.gmail.com>
Content-Language: en-US
From: Zeng Chi <zeng_chi911@163.com>
In-Reply-To: <CAAhV-H4Jc4txZ-cQO-h6yZmfk3YEgeEptKtRQcDO=US3sies0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCX496Gr59qQKzDBQ--.25065S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUO89MUUUUU
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbC5wiQTGqfr4jdOgAA3G

On 2026/9/5 23:10, Huacai Chen wrote:
> Applied, thanks.
> 
> 
> Huacai
> 
Thank you, Huacai, for applying the patch. I really appreciate your
time and the LoongArch maintainers' support.


Best,
Zeng Chi

