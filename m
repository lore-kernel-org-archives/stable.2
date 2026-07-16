Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9D3368AA;
	Thu, 16 Jul 2026 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238076; cv=none; b=Sf0DcI/f6fFT7O1g3mIEEV+FOoQXr3IPLjtkzk6QxADPFsYls3Orz/XjvxCrps8AF/Sy5HBdxYrdlYP+qHkum2uR/bw8J/cYC7M0usX3llrAxc3loLerXCOeYivF+HnfvRPFQFPlXpp/AeuhDL0qjOtr1wZ39WHJ7HUdrtB9zJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238076; c=relaxed/simple;
	bh=eRhuCpvWjc7kvd84sy7nllmOJuFDQdB5Ez0qHwDnqCc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N/qSVuTo7xjTseTbAhU4/g1KhWyKysTTYWAMRFDKLtmKxZCyuHDVSVUnF46EmQdeFozaAovjnFfmTLVS5m2Q6ImodE5dG8elwvXJ0+d0ao2rcG3I/6ZIKeD5y6IMwaRPyu+zQeuDJ/N+Pofc7cyZG+C1PSt/UxN+TiCUUqIwiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIJ7RUz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIJ7RUz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AF41F000E9;
	Thu, 16 Jul 2026 21:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784238075;
	bh=A1VUEt4ZbtRKEN98GFb2gMWca30oQHPqo+NCfy/COYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bIJ7RUz5GFR3Cm9up4+itFlPOR+0iEdvIvAMM1eIyZs50oJtf/DjJKV8h0LNrDlSv
	 P8Bm4sOmZD1rkXH8HwcDrWbCspf1CLEuc4AB6R0b23wfNxv+r4CFaKiht/HGOiFBbs
	 CRkYGLX99QlMUG2K7t9LYZtd9Z5kmwJRZHJ0FGi91Fxp385KC5tHbM1efb3EVk1iQZ
	 MGTw59C4AofVu7lLuGEQHZPr0sQ9WXKkWuOTp3zvQoYSDMakObhjYJdYxy1xfaWfFx
	 bbDpMjyF1qUWoZffgr8S/ku+vtO59yXp6sQTtsQa8BnTYeB88LMibtqigH8VJ+9XQ1
	 bveU2ClV7bnXQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260608-mathieu-nvmem-fixed-layout-v3-0-12ddc69f4c51@bootlin.com>
References: <20260608-mathieu-nvmem-fixed-layout-v3-0-12ddc69f4c51@bootlin.com>
Subject: Re: [PATCH v3 0/2] nvmem: layouts: Add fixed-layout driver
Message-Id: <178423807401.383885.5242183138960161089.b4-ty@kernel.org>
Date: Thu, 16 Jul 2026 22:41:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 08 Jun 2026 15:42:42 +0200, Mathieu Dubois-Briand wrote:
> 


Applied, thanks!

[1/2] nvmem: layouts: Add fixed-layout driver
      commit: c00ca6cc2fc96a0b72372192577ae79a94b59527
[2/2] nvmem: layouts: Make the fixed-layout driver optional
      commit: eeb4218f73b55abdf81cfd2029658c7c2669ba19

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

