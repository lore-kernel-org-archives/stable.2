Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C440587A;
	Fri, 11 Sep 2026 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109752; cv=none; b=P1bQDnk/dP3GfhHKY5Jgko/Q63kO4HlbI8KJs4hGVk8zDVEMug3AQTXlHzbB/PloXTn7RR6Wv93zJtomniwNoJFwTqfBT4lToi6ozNdrHv87Vg2i0Ab2pUjkPlWRJ87PXU0EgCmahoEg7WtE3ngpiR0CKqsvdY5rK5r10ao/4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109752; c=relaxed/simple;
	bh=ISVPbbt0Fc5BFamR3eYfpcVyINYbzazSJuHDTzPCUqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V5IH8dglDQ3VR5xyVL8wqhLIvANl14P9yv/8MqL6K45Xeidf2qYNjbM2TO6TK9P7iXJcpif42n4cSjBJv5lgwBZTGTGJpi+Di5o43YxawTnrif0rXTNwKaVWJkQO2/zPcRHpXv/2SxHmtY/NmLiw1ABqu6I5J8QInHQ1BOw4gdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/XbA+tV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/XbA+tV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B071F000FF;
	Fri, 11 Sep 2026 06:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789109741;
	bh=f1i7na06iDth2FdJIH8BE1JqijLD9bS75AOuEnYVjg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=F/XbA+tV/fjHLp6KWUkt1UF/rxFDoluhj3dEGL2nQVc/LNX/RMVRIvVsEWGLmqb5O
	 EmlovJpiVWVtk5TRgXB3Jv3ntHC6ZCBpkJFIBmWUCjvwWWOYFeih08MDGjTtxrMel5
	 ipyWBbV3O7s2IqzXOp9HlSE82W9KtD0APDTnH3v1rHUnJ7yGqVbgnoRNrOaYq5/TI7
	 Xp5CSIZH3LlnevFxTisSWh9m1gnGtLSsjKmjCInlm5pYZdqrm9TykzIDpLpvvRilzS
	 C2xtkv8J17Fv6cJ0zPQpDSKNy3uzIlRXQDx10xGyP/P48PdUfQtqzW3CSHbk/lPjJd
	 21DymFi2/97GQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lukasz Luba <lukasz.luba@arm.com>, 
 Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Jiawen Liu <1298662399@qq.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, stable@vger.kernel.org
In-Reply-To: <tencent_B0189529F550458590E3BA614EAB800FBF08@qq.com>
References: <tencent_B0189529F550458590E3BA614EAB800FBF08@qq.com>
Subject: Re: [PATCH v2] memory: exynos5422-dmc: handle clock enable
 failures
Message-Id: <178910973800.29600.13263415611790690641.b4-ty@b4>
Date: Fri, 11 Sep 2026 08:55:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 04 Sep 2026 14:01:35 +0400, Jiawen Liu wrote:
> Check the return values of clk_prepare_enable() for fout_bpll and
> mout_bpll.
> 
> If enabling fout_bpll fails, propagate the error. If enabling mout_bpll
> fails, disable fout_bpll before returning. This keeps the clock enable
> count balanced on probe error paths.
> 
> [...]

Applied, thanks!

[1/1] memory: exynos5422-dmc: handle clock enable failures
      https://git.kernel.org/krzk/linux-mem-ctrl/c/cce46902ea9fcd585cd200fffa3166f63bc571f1

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

