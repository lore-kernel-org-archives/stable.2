Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982968;
	b=h0lKsNUd5YNVaEbNN8jhMq5DZ/M4dF6+6uF9xyp5f1xiNDCVhkHcEZU7Cd3XK/0v71BC
	 gTiItV2EnxBe46VEBhVYm3KiVtHbsF+v6mPvB81jIGZAyxeSfr/jhF+v7MP3EGxns6vy6
	 pGo+EmxCvePyLapP7usg92uOQteDq6vxSR133Fsl0DdZZgyn0zUoiNMp0V0LkhPDVix7q
	 zWjrahZYUo5QC8VRTnfd/tH+ML5dGveqNgiZIeehIHF1BYZa3EHwQril34QzxayACt9nQ
	 o2gAVDHLN/MwgsGzsaw1HCN7KyUzwZmov83+8juROELqWBAuDuqdhGR6zK/U+xZyQiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982968;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nv6TTsQFVxrUPnd1xr2yM6p1zEbsWhtAzJp8hQu6xXE=;
	b=xVZT2/+72eU4bG9wGAldJY5IneOmOgAZxakfyMveUmDsyGgx3Ok7qsNNHui50vGL5c0s
	 yKHbLMGhjHzsZQ7FEyCBBWK2ug4yTytv7xomaIGwS1YQf0aGngBUylkj9UNXJ11o+CRdv
	 1eTQJxNLeiK59hltbLcmR4m5xkvZr+2EO0aeTDr/4xcxB8vRWMOUpF/k6WwZkv7sI85eG
	 NbQ1mdR4U92VQIiJYZ8P1kWUt1u2tTNF2nMA5VTN0LM315vSEuZLnS9Gev1FeT3g++9n2
	 +xtwIwL7/5zcuHyvmQOHlt8MaIhSwgeLT/lHLNs9o3Px5dEXKW5JW3n5Q9Yq0blHocw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQ+6NKoU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6D606A338
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQ+6NKoU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298111F0089F;
	Fri,  6 Nov 2026 16:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982968;
	bh=nv6TTsQFVxrUPnd1xr2yM6p1zEbsWhtAzJp8hQu6xXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DQ+6NKoUWgB3+OGPRQWiN9J4QdMcTEp0G9hgy1s7AO/GosjIRICg5FczP8KaIHPnB
	 ILdBrM+5+vzWYrGKPBzwy3nv2h2EUC6gl0xou7zdwN/FW7PkWtIl/9CxXuqIiC0FK6
	 1WlFQpxwWYfNT5cqW43XV1V67B2l9I0wFEIeia/xTmcdQ/9yXeFOtUagtGvmG58RH+
	 HW668Bg3z2STBpAKYgO5EQaZP/vjQR3TTjIWVywy7lAHJVDmNIlFr9juOPQ22ZpUvI
	 PA63sArHjmlXYS3w/H0/SYeOFtx7gEAElYQWpAzlqFFb6TLlVK2Ip52ztgAVb5RFrs
	 J5YWQaPTztvDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Sasha Levin <sashal@kernel.org>,
	Gaurav Batra <gbatra@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH 6.6.y 1/1] powerpc/pseries/iommu: Restore CONFIG_IOMMU_API dependency
Date: Fri,  6 Nov 2026 11:35:46 -0500
Message-ID: <2026-11-06-1-daily-reply-0011-powerpc-iommu-api@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105232402.4033385-2-stephen.s.brennan@oracle.com>
References: <20261105232402.4033385-2-stephen.s.brennan@oracle.com>
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

> powerpc/pseries/iommu: Restore CONFIG_IOMMU_API dependency

This is a hand-adapted replacement for af199e6ca29c ("powerpc/pseries/iommu:
Define spapr_tce_table_group_ops only with CONFIG_IOMMU_API") rather than a
clean cherry-pick, and it has no ack from the powerpc side.

Michael, Madhavan: could one of you review it? I will queue it for 6.6 once you
are happy with it.

-- 
Thanks,
Sasha
