Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2B83E1D17;
	Tue, 29 Sep 2026 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651745; cv=none; b=Nj3yzE47UfBkiFbza+XnrQGV5+vueIFrnN8z5FTXv2Rq68Sz/Zq+zM00dq059h+pdAIBkYhvsSz1+eMlIvUm7/qLJlMekrzt0FpH2SB6TxpFUXP+1DK9knSnPOX8Bs+WbLgFJsK7f3uWv1WqVQx1MKhFMylO+Moy4IcMUeQMJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651745; c=relaxed/simple;
	bh=czl7lfZqXst6J0w7kzHyJSCW+ys9hUWlHMIMCDB/ABw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMJJyAWBWYH5F6YzF9ESuas6PkU1dsTM20cY8Fthd4S6pt4rcncuwi1rTEauiZU48velnAiDHDoP1Dv44u8gdoTbPlGywH00yewRx3sQzZVeMOiubHu58ELPKxdeEEFx58rZGT5n8NO23uxcyjcOFBwX1+ioWnO1bqcv894Z4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeSHRayK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeSHRayK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1866E1F0089C;
	Tue, 29 Sep 2026 03:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790651740;
	bh=hsbCMGZfkkFxPuF39HD6OgcKculliT8JtGPXz8W41vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CeSHRayKSuvUNixTz5M1ARLzq/8dWeVaREnMqg8NmdNRqw4im37+CGGeKLmdhPZYl
	 Tt5S8PaX3BvA1eTqAtFBkHyt58wqEUc6DOu9oIw0vX/9eMqOyDANj2Jzt5iTK7IfRq
	 MFCyocV3KDjXFCDL8hALls0TaSYMQA+/frn4HhjfO4H3iDVbZIIiTkYHH58ppCvdQ1
	 9+wpFkDMdy/ZCxoLpd+iF/Vmymbaw4Vd6736k3HUcKDHtLmGPLvbStaHK7MUOn5Efa
	 wMqCtVHT9BvhEs9msoyvVEm7olDKZSyuz8eJm+/phxLGwlK1d6Bd/w0YQv2Gqan4aC
	 Z8zgdE9ki7A7A==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Molly Sophia <mollysophia379@gmail.com>,
	Petr Hodina <petr.hodina@protonmail.com>,
	David Heidelberg <david@ixit.cz>
Cc: Konrad Dybcio <konradybcio@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] arm64: dts: qcom: sdm845-xiaomi: Recent firmware needs bigger XBL
Date: Mon, 28 Sep 2026 22:14:40 -0500
Message-ID: <179065171014.2673486.16148940203428568525.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916-sdm845-xbl-mem-v1-0-6e3c88507997@ixit.cz>
References: <20260916-sdm845-xbl-mem-v1-0-6e3c88507997@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 16 Sep 2026 00:25:45 +0200, David Heidelberg wrote:
> Applies to all known Snapdragon 845 Xiaomi devices.
> 
> Verified against the vendor trees, only vendor trees with smaller XBL
> are < Android 9.0.
> 
> Needs some Tested-by, I don't own any of these two devices.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sdm845-xiaomi-beryllium: Extend the xbl_mem region
      commit: 511c4fea32708a065e03503c0e4d44f48990c530
[2/2] arm64: dts: qcom: sdm845-xiaomi-polaris: Extend the xbl_mem region
      commit: 38458f12419f456b16385c118bcacd76899d99b9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
