Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257380;
	b=Wr7BnjOfo+mHQ6vnEBz1k1S41LZzgGjdAF0BZMikeG/ykLIe0597nqQSD042MHfsoNwB
	 mA3FoT4o5P+m37VdeBJxCQpJvPc4VdHfNbgHFHT0ENkZFbrbYB04i6+Nw7JSL04x5aRI0
	 77tuxhPhqW7VXclkc0JH+XaEuGHxyiX/fJlpuayXSicbz6Y1awb6fWHRiQc0Py/hSH73N
	 gZauaNM6/U9P2stWmNPracfQ8Aj6BhKlyuSyyaYo4oqlMcyAdAUkRXE+j8aYbJP/MX/E0
	 IWW/V3idvzlQSz/g4IEmxYFqIYdf3KqwUBVvsMpTIN++4kVIG+H5jmnWgIA2vC9t1kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257380;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NbFQFN91qaMdMtABEpavMVWgG0Qsy/cmfOXML4mbN6U=;
	b=YKQujg0m+N5w3X9ht7Wrb/yJO7aplcqzp8vVHmbe6e1VdJ2WHJx5YmkixwPXzjGmQIns
	 aFnzMkZ2l82kSeb2Z9IKKDHK1UWsrpt/6RTyuGklpPB7BUv/leeTKCfBenl4IQA+nb4Xe
	 kDv+r8G0uRTLvUtrxtBM/PE4Vo7rs1AI/8SylNqL2+FXDZkhj/OyKq8pSWXcoE1B/zI5O
	 5Dfx7cc247LQiraoPcmNCWgZbnJp8l1kd6OPIhyY0YG0mIh7uRPtEIHHgT7JhAhtj7/Vj
	 PWpj1DbtuTq4F45Jho8fyhVFgTj4rDYO9Ox1JszO8BJ1XhAY3jWiBa1ja/3nrH1L1Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJj64W6k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B164606A320;
	Sat, 21 Nov 2026 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJj64W6k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CE71F000C6;
	Sat, 21 Nov 2026 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795257380;
	bh=NbFQFN91qaMdMtABEpavMVWgG0Qsy/cmfOXML4mbN6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SJj64W6k9DMAE4f09RxIGrHGHTIHKaUAJ9o7CrB9odISiYnD6Yi19ZEhBCd8HUMEe
	 mf7HlMxxkysT+acoQRGVKehYAzuIiAVHAkv8TNzyvLNRCOwCKsXLgNb+UR7dQj29A4
	 gYDmn5xvwKmspQpFB6Bvflb4CRQ3u/hXipL28FAJlZFGdtc/26t0IH/Ime+OJwAP1M
	 IaqAc6OucmHm8SQ7kb+Dw6Fps8Eo2a3wqL9wKQi5viKsDkJygiKoGWD73ODdBX2Yv5
	 3m7UQ1fOQ45JhM9YASWp6gHQ5Jxhidks+dsqwyY7563OHTdMNKGNRmxxSo+cUNVW4a
	 YxjO9o9r0uYuQ==
Date: Sat, 21 Nov 2026 11:36:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>, Luca Weiss <luca.weiss@fairphone.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Fix
 DW9800K support
Message-ID: <20261121-excellent-sociable-limpet-fddb4a@quoll>
References: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
 <20261119-b4-dw9800k_cleanup-v4-3-df26c431595e@fairphone.com>
 <infkyto252rc2ocolww4ihjuptd5xg5qcjtkft7gpyssxhp234@4dnragxtdfxm>
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
In-Reply-To: <infkyto252rc2ocolww4ihjuptd5xg5qcjtkft7gpyssxhp234@4dnragxtdfxm>

On Fri, Nov 20, 2026 at 10:35:27AM +0200, Abel Vesa wrote:
> On 26-11-19 10:51:25, Griffin Kroah-Hartman wrote:
> > Update the node for the DW9800K for correctness.
> > 
> > Now we correctly select SAC3 mode and enable timing-control with the newly
> > updated device tree bindings.
> > 
> > This is a breaking change for a part that was previously functioning,
> > but only due to manual register writes in the driver. Now that we have
> > the correct documentation we are able to update everything to ensure
> > functionality with other devices using this part.
> > 
> > Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> 
> With Fixes tag addeed:

Why? The DTS if backported without drivers, e.g. by other projects,
would stop working, no?

> 
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> 
