Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804616;
	b=A6bwx47oDMsx2/6I4tlRPgrzOEecFeaARIISJLLUWvllEhm4omT2zV1i4X8+C+Jn/w/K
	 9cgOUVZrfwFGJAcZ0QFI+AHrz0LvuD6T6rixnFj9U6bJs2L/txiu+ULJYy+sCKQpYhqEK
	 oyeSObj3SFbzDaMeDUoAjxj2zj2KyaL/x5p0Ebw9gMAnHkG1deJTPDTGmv9tsK1gLi+tX
	 DcS6ClccoSvj3aPyCyoVtTD0LxKeO2e1h8Ek75EByKL8C1hUFXigYsz1mv2EFVXC8y5u5
	 6g2zMz+e2T5PLT2iHeBeIPaERnB9w30A20wFUp6n4obLaqdu2OLLE6QDo/kMnQTvxGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804616;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=biD0UOZ2A/xxN+1YSKCsqCVArjFbN0hGcNjdy3/q7kg=;
	b=GAaS89P7u+zUlwNg3AztFGHlI2L58wgioLn91CtyFP0qIKlTdq/aneiaG1WX9WjLoxKe
	 hy38TjTPxcg48g5XfwiRFfOxNtvquFsh9beBeRoFA0Np2vjnyYXjfCx3K0zjxatUDz/JB
	 Az5F9+cHJLCK+eBv9XZ+j/IBPfGKSVukIghXR/MrFQ0KoNJIrEf4iPWNaokg6zoOfR1Ln
	 Ypj+PqID4ga/So4lSg1lchxKPT0sTMelpwZ07BX3ZL4XQ0kHOPayEqPppM4PYZpZd8ASz
	 hZTT0liBQk9MGNFxSa5BlXYwRQsFYo1I4F7negACGsIzU2tv75c1anpOZ1dletYMYeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhWA3azO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA6606D806
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhWA3azO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2B21F00A18;
	Wed,  4 Nov 2026 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804616;
	bh=biD0UOZ2A/xxN+1YSKCsqCVArjFbN0hGcNjdy3/q7kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BhWA3azOZcmvTmjr+5tlqJcBsTuzhTGQIA1oGIuE6FKRBnAYtbeSRueVx/BHNCiNe
	 z44NvD5Fmrmc91uCPcMWulAFYVUJJpUIaVaRu1wQ9nCa4UgrArEUnszzyPLy/13XjO
	 oi4xK2NejsyuZuDUEL2PPBnug8s5LUY/aEqC8H2M8GlA3BZX50aXdA4VEkUwnm80nF
	 zJn0ZNx6CE27hyQvrnlB+FhZ7YvanOhgABGzw/kSXxjU1ZuTevRc/fBkmDzycR1oxU
	 9uBLtTWRDij/0OZUbJmDkxSk1QCjW6xkReEytDhn8acol1YU8P8tJcGJ/gwXDCHlJg
	 JoVerCRbWyxpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH stable] EDAC/mc: Really fix error path ordering in edac_mc_alloc()
Date: Wed,  4 Nov 2026 10:03:17 -0500
Message-ID: <2026-11-04-1-daily-reply-0008-re-edac-mc-error-path@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103170439.2f918d14@endymion>
References: <20261103170439.2f918d14@endymion>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-03, Jean Delvare <jdelvare@suse.de> wrote:
> Affected
> branches still under maintenance would be v6.18, v6.12, v6.6 and v6.1.

Queued for 6.18, 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
