Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745364;
	b=lVs7/rVE29VEmRjrM7CCuG7/jLGDQGN7Ri4bav15CZCBpB61TIKKz3w3/oKFDAqC1vKw
	 KeSuBPXifUC6BNK8XWxs7fUu2RqnJ5sSS7OObTusqJyd73XfMyIgqP/tScYWmSg3+u/8Y
	 neAmhaK6MEDOwLVeokZUmLDsYp/WsEvgrT63UcYMUowXKUOm6QvHaWHUgCyVBcmjnDaZP
	 Pi8noY0Wqe0twlxdS6FJpoHTbgQ4PAEBe0SP0PJOyA+eOq5FdSA2d6zipkZSqy+9R3keN
	 SLQuMkYnQZDBVVMcvHe5wlcgedO9QOuU6+1tFW0AinetZIdbANpqkhZCo5jnkBMKmVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745364;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TPqHx/cU/fq4H9wkiHqa3VQQRQQa86H0rWb12bSD8zU=;
	b=3aY8BuzgSIuhB6KJHByITsoJ+14miuDtxe7gPqwKdf3Aix0U7x4m0CCQ6gAAg33O/hT4
	 mwoWPWxCyfbcVOMNgKGECoavKazXhfne+WAmbmbZ/6rasva7Y/TYq5TnBDes02EN2PJ6W
	 6cEwzILUZC0WPjjwL/yn04/GkE7JTe5v7l/FR6QFbguGFTNmyKJmxNIwqEpynhH5xuyiC
	 XomTvrehBCCUj8d4WJ915hjV5iPogSkuCrbv7Xs76NFsMf6JJsI6h4320bJkH2gejxA0R
	 opgD8yRmAOs/H3Yzv/dbcJPOj1OYGZ0thFJTw+waepxyWuJVsjfFGIaAalKpPNbvI9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=temperror header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=IGTPazC6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KlANgHAH;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C48606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C48606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=IGTPazC6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KlANgHAH
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 54866EC07E2
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:35:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 03 Nov 2026 17:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793745357;
	 x=1793831757; bh=TPqHx/cU/fq4H9wkiHqa3VQQRQQa86H0rWb12bSD8zU=; b=
	IGTPazC6xy0M58vzjx+JMD+W/XqY0vU7KCETdJmNajTLiiLiNtdicG6viC1P3Q5X
	+7holxI4BILs6EvMqaxHPtYwnnCLc9MK5KChqNGQjKcAmRTHkfIe2kNVqZHZSf3Z
	IaOD2wskcYeXenEccKXYTRbJPk0E4zhYqMjiYt00NIfT+NTmQyjC2rMlZohGRQic
	4qEWsrVlu584kqWSAMwiC8HcUhHZVHhyioxgT3dttyXw/XE7C56h6KL4avz7AmDS
	ZQExdPLtI9zpBODYfRN2Y2s/1UbUzNAPPC1+zJJnipcKOkjUx9yvpdaZFwZmwR1i
	aobMI4Zez2s6930XuBb3KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793745357; x=
	1793831757; bh=TPqHx/cU/fq4H9wkiHqa3VQQRQQa86H0rWb12bSD8zU=; b=K
	lANgHAHVasq8yLCrxnHyltI/29AjvR8kMipRGuUdMycKDNdYRetGjZpx0nXu4U5Y
	3ZxMEGSjla0dSYF82ae8UuH30X9RNRLwkhNafPnyFZHeNzjiVuGQYY7aWN+INY39
	QO1vibN/JPQOAE1l/j3V3qIsZ9FsEQnyucEG2mTGX7DwuJrGKcgq78sp6I+BJh0h
	hfYDElzmPYrCpsbAz4s0skinura8ynB0BHfGX4UYFRwE+NFeesfJCZATuu0xbfTJ
	7NJh2NjmDMC74VOZXl/G4wW5OIDNSo2BZqhVJY+ToWQ5IqDFjKRmFUIhNzQfhPL5
	yMPetsULrHbhpCer25Ftg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793745357; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MCBBFy0zCDjVVO/5WmLgEia8l5DZV7lPpJ52sXq+AYQwgmy
	+kDOkbd+6ArHeRjvKfcEdY7alV2LsPpS7Z36IPM0orVMQl745dBE8+eGKUXCzldC
	hDvBB2IyoiD3jnfTK5Q5oyte+W9JG5oA/tVjo+odFqKuU8nLJp1vkl9mkxK+KBXg
	XsCjvcMdPHY6P+l8Xo8hgcvo1IyHnAEsY9Q9RstjRa0wx2igxmWZedu4xYlwdXSF
	78hPSdJ8ohX0O35u3qedG937wCyynbwnn78+ILG+gP2qOYkpfLdB7rP2JPgHGMUW
	SDlMFvgf7dIeeocsI5NojPR/hIBbeJRK4pZc1qQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eAT+53BcZGsO6bsWh4DIkgOl3GszBJNp7CsO8VE5dxg=:tSVY1u0kwJzKuDCzne2np0L26kae7IHeO6zV5GRD6XA=;
X-ME-Sender: <xms:zGHqaqDAaaGox9leGsWQqkVY5CqLLqXGbGUZjKlyBhIp1_zSRGEMpg>
    <xme:zGHqahGrYohptLzOBz3vmqtzmT-Owvk-YX08LtJaV3ELzoxhTUCT1HnqZp00B_BmR
    ko1sE4u8EIJMVZEisAbBRdvx973R6q6bG-7EIZduXkgwMHU4X4-gBA>
X-ME-Received: <xmr:zGHqaiBVBp37714ASGQLG1FqYyshCRMxtmiauSxcdgvDLTiWmW4IWJYFPEIp8g>
X-ME-Proxy-Cause: dmFkZTEWuavI98npZyJd5hGbCm3gmnPP2dElHheiEi3bgLGrOZg9pyjbzXfSDwZjjgcO4w
    U3vFMoXwy1uUO2fihKGEUsRiLxnsse9WZHGg5Ezm0QidUnsW68dPy3vOA7lcuAKOAXK3Gi
    zYvmcJtdErAyHG0SbkJzF7oprUSLqBkjjYYNZbwEe5oUXNKzvqXd67PkdiUUsSn+asqfgv
    huLk0RTugANZcEqyEZHyeIW6wpZ3XVwcYI6l7/j3p9OrzNxyp3ZNbPnQ+vtDfRw6uvQY4r
    Zkzdl/n4jLMNVLYd3TpwZn+UqToQLCk89WYhttwK7/UYPkcF4UVJQbuRhbPoNhLlrMycHi
    kfjyverQ830dJfhtW/lTTx65qMmGI/f1W+uN4DECy4YqJpGS7t2KGc1FyK6cnuxzlIxD+F
    fwd3526Wt8M7CeBPbIH76gwSHu1t+WjBmI1jYrY7CoS1PRuTkEFUrQKfoQfIF0Wy0AEaII
    OkFMSe79oQjRLYtAGZ2vax4wvs52P2lg+HK/k2M9WSWE8ePdE7opF+jkvRfmbbZ6zJim3K
    hNJXgjIAIRzL/67cnB9r7dHOlirwvZpPnd9uZZQ7GRmK2QVWr6D0DbEnBsa/S9H+LbHIWY
    ti8+hz6zknslcqy1Qn3Z4PYZ7JPzKSCYpMsBI0ZlCjCBgCDxFPmCpk3CgbLw
X-ME-Proxy: <xmx:zGHqavn_IfY0Zep3N-ll48-WlE6NBwbByPLRAwZIDZbxe7tzACxd5w>
    <xmx:zGHqagOLHZxgk5HXKRDjFaOBCsupC6urbyxkuLYiP8O3nJYkKFeUoQ>
    <xmx:zGHqas9ZP53Cha5AF72aQqgKdSs_52vxcO2nhtxC1r2rSUTouxr5fg>
    <xmx:zGHqaiGgPb9Sh6HOomnip8DkUR4hG9JuW0q7o6dQyqxfXUSaBchLlg>
    <xmx:zWHqaswAAp8m_hflg8Bcdgn3Dm7RJ2AIq2JiWd8oxOA6hNmBeqtIJ_J7>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 17:35:56 -0500 (EST)
Date: Tue, 3 Nov 2026 15:35:53 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, Abhishek Sahu
 <abhsahu@nvidia.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah
 Khan <shuah@kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 5/5] vfio: selftests: Add test for device power state
 transitions
Message-ID: <20261103153553.6caa7d7d@shazbot.org>
In-Reply-To: <20261029203324.1637772-6-dmatlack@google.com>
References: <20261029203324.1637772-1-dmatlack@google.com>
	<20261029203324.1637772-6-dmatlack@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 20:33:24 +0000
David Matlack <dmatlack@google.com> wrote:
> +/*
> + * Put the device into D3hot via config space and then close it. VFIO must
> + * return the device to D0 when it is closed.
> + */

But we're only testing that it's re-opened into D0, there are multiple
ways that could have happened.  It's pretty common that a guest
shutdown might put devices into a low power state and it's brought back
to D0 on close, on reset, on the next open, or even on the reset in
open.  So I don't think we're testing what we claim to test here.  I'm
not sure this specific D0 transition is observable, even if we were to
resort to pci-sysfs.  Thanks,

Alex

> +TEST_F(vfio_pci_power_state_test, close_in_d3hot)
> +{
> +	power_state_set(self->device, self->pm_cap, D3HOT);
> +	ASSERT_EQ(power_state_get(self->device, self->pm_cap), D3HOT);
> +
> +	vfio_pci_device_cleanup(self->device);
> +
> +	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +	ASSERT_EQ(power_state_get(self->device, self->pm_cap), D0);
> +}
