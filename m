Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.58.18.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792953228;
	b=QKHP/d9/KnWwTCRzrgCXdMaWvLmVhSSXwhSkg5lFIqUWuRKhlWmAL9gNXugxOMXZ1GXW
	 dbond1s/u+sVBY6CmJ9Zxe341Mx9dT7/qVtOKcWItGfcyOemBLObMkO4+672rs+wFi6cN
	 Jv+BIhT1nEf28TvXKxy7Y4dKO/oGGchsoxMGC9Z58hKEi1moXc6hxOwDfTR29AElMxQ8/
	 5nKwDZJsVAwCQWhs/BhX3Eez+ZwCFv9c9w7f03r/TyujcCFmpQ5FfXoU8LypbfRcfYIhV
	 N/KewtmSb/GZWInWSCZQ0ZUgzABEzAbvOrGTbl7ccrb5gOgGkg3W84CvLHykeyVKglQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953228;
	h=DMARC-Filter:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Date:Message-Id:Cc:Subject:From:To:
	 X-Greeting:X-Mailer:References:In-Reply-To:Content-Type;
	bh=Ueuv7cPaecuyLqONQlbjgiSDlUSKnsZNNKqCbxGlagU=;
	b=yu3wwYspFHE9zCaqAXjy3vQaqaM69uMe3rRhLlEGG8uamuPqBP5w2lD8/GEtosogCO74
	 jxHjKIi4/8WkEJvmu1bppUhSu0uoFsByIosmsBu6Z0zIdi1SuUC73nmYBGsE0+eTE2BNw
	 WPJGrhPMQ8dmbYjTogI8qujH+9GX8bTRLG/KSbZRDx8QyaA8VGGCIdJ4UHqkUvhzvw/Cl
	 mBcfEee7lz/WEIS/qle1tl983qqvVdfZQBq9r6v63CTH+jKlh1MFSfjoNwblqS+ErWcOR
	 MqSTzMahEkGhOEZi/rCbBqvSst86yc+RvlSTFLrEWQoWVDEC5/eVqpuuem/ecruUpPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=achill.org;
	spf=pass smtp.mailfrom=achill.org;
	dkim=pass header.d=achill.org header.i=@achill.org header.a=rsa-sha256 header.s=mail header.b="rpPyIj/v";
	arc=none smtp.remote-ip=89.58.18.167
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCA606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CFCA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=achill.org header.i=@achill.org header.a=rsa-sha256 header.s=mail header.b=rpPyIj/v
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id 4EB4D9A2915
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1792953216; h=date:message-id:subject:from:to;
	bh=9wB0E5yDXm3uCEDhnZZND2lq2G++pGSalRP/LdEsX/w=;
	b=rpPyIj/vuAqG+9WjIK2Bntrx/SPM2ZcjwhbgWGCzkMroSF54iPxbRvQPwgBv14lgWbbGHEDM4BB
	EAC9hebHDEVvp+7rZxQoBi3ONSygGcY5WaH9KJGgTKr5ncU7Ma8IPLD+c5LjbgmmVyHcpaX8SgwHs
	3u0tisAChHTz8YoqUFokBgaDh8SpYhBLBdAFga2bsvy81arwNIRVMUcIeojvqBTy3kkyLMvg4qOM1
	IC9z6s4cLifVzcLl2DCBCNyZ+SHOD+ameisqfFZWGZfAY+4fpJVNzfTJn5KwUtvLVNgmEo9Z1NxS+
	S1lFymKxz03UGguNUqYs4LAt/r+IAjzAFVOQ==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 19:33:35 +0100
Message-Id: <DME4VC8RNX49.3SSLD48HTOB76@achill.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@nabladev.com>,
 <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
 <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>, <achill@achill.org>,
 <sr@sladewatkins.com>
Subject: Re: [PATCH 7.2 000/231] 7.2.13-rc3 review
From: "Achill Gilgenast" <achill@achill.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.22.0
References: <20261025125805.309934791@linuxfoundation.org>
In-Reply-To: <20261025125805.309934791@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8

On Sun Oct 25, 2026 at 1:58 PM CET, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.13 release.
> There are 231 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 27 Oct 2026 12:57:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.13-=
rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built on all of Alpine's architectures, thanks!

Tested-by: Achill Gilgenast <achill@achill.org>=
