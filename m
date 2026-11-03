Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704246;
	b=TgUv8HupivLOK8voeuzFR3c9APg01+0CZ4zT8LxmD3yzOZsHkSA0s4Z4z++ojinqwupu
	 uhZ448d4sdWQ6Bu8+uiCoNFZrU9uLL8DIOvjI1+fPWjjJXupACVy0eFqxlyUTrOY6Hv+m
	 pgU+8sa8eZ9hNeTiuiShzmFPfy85Cjkub+xHuGsaYR/ZsUCcz9BUo4CX9JcFQ/hYEx7Sl
	 VxOuhbbpik3D+i7JFBh9/FUrxySQfK+JLZOKdMtONrxqHEAzKlg4aPWAkPg2N/mLmNFZn
	 NOjtRMVnO2sz88zp5mKB57Iz6JpHgGiS9d5uKcbG77F+7EAqGi7Q8NKOULlz703+Euw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704246;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oH9yiNjBLnPnYV/tVi7O279D04XNMxHc/uOO8R+Zy+Y=;
	b=vb32gFMtiRwIho0hcr5KwAXOWyFiOfA+B4vwKpqPGx8RNKarYOxgp85a1M7goS7rd/pK
	 u8FI5iUnMwQJAEeLUMYhx4HI1JA1D0aZOuVJi2DT1Bca0xEl+Xn24094J8iyLNI2MNmVz
	 T20Jo954FWcYnEyJeH//wSl+VJHxKqZfj+HEy8X40NC+B2dxWBoaa7Vy7zicPkq8SWh4Y
	 GIfhrbeMSrI8RdloUwNcRY3l16HrCsD1P954lhMuxwoHBuG0QtL2YAbVdWhYrDvThclQp
	 5OY0dh7/qz2zePE/qDaYadpsEGoQeL+DieZMnDSznm0TyKLty6aUa0qgI/O8bfRNhwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDKJNtTK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD84606F7C0;
	Tue,  3 Nov 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDKJNtTK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54E21F000C1;
	Tue,  3 Nov 2026 11:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704245;
	bh=oH9yiNjBLnPnYV/tVi7O279D04XNMxHc/uOO8R+Zy+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WDKJNtTKYmj96sfXMvVAPPRf3HgcRFFxdAAYJC6MtHaveC8CAnlhpk/JcYNLFAgk0
	 uz/V8fWC6JQVy8G1RUO0jtwPiortNGkJ8dqwOG9UKof/5X2lbKiuwXpZ3i226kwTby
	 upR25nu7N1+mvBEn5AflBBkh/UJMINeUjemytOljYUN34gc45eMe1/oNn57PHTfCtv
	 U2gcWmh/h+KAU/83XNmE095pdnNXKkqDaz9sfqGXHJ8BeQWtgp+gHOeJMNDM6WyeJi
	 SjP1eewS8LaWWJ3KsYM9PHDIuKmK1TjlPUXf1MG/HQcqbRVX2adAMBZoZo3EFIznSM
	 Cg9WNITXZUq2w==
Date: Tue, 3 Nov 2026 12:10:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, Saravana Kannan <saravanak@kernel.org>, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: unittest: fix node reference leak in
 of_unittest_dynamic()
Message-ID: <20261103-jumping-pretty-leopard-b094a1@quoll>
References: <20261103104236.1373631-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103104236.1373631-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:36 +0000, Wentao Liang wrote:
> of_find_node_by_path() returns a device_node with its reference count
> incremented. of_unittest_dynamic() only returns directly on the
> allocation failure path and otherwise falls off the end of the
> function, so the reference is never dropped.
> 
> Release the reference on both exits.
> 
> Fixes: 7e66c5c74f73 ("of/selftest: Add self tests for manipulation of properties")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/of/unittest.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




