Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818491;
	b=HZC18KSdhNmIe0/fCB8pBnOMTk26Y5HGxSzcT0AHBKQ02cyx/Oy2OWEvW2qhqj/tZAzc
	 Q2Lv5fdMKy6PEstPxLvf1omBFLrygi9OPjHVtX7P5tX7je4lx2Py+4uxTSl0QAM43soGC
	 LU4py0shqLJkpkWfVb4UEHOVpbxK8cqR+QN0qym10X9ndmV+WV9PE6APfEjSJqboy3Pfq
	 IkScB2WAtPf+SQZYfSEZO4pNx/ZIh7PUirWOnbZNWgeb6xq7FYy4X49smM3Uy0MgDpoPz
	 7QoXBovV0xvLe1EhaSI2G2V/6pLshWaJLqKLVfact72w0Svd9Ue/SqvYCmbKLNNWsWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=cG8AFS3ByOoBWQgtRmImcWG2ty8e5AClYttQEcmlyV0=;
	b=GVHdVN47pojDCQbN5oMVX++cGRoaWB0gcAkKb0w9MP1hATL39gvWxOqbjQNgL2TmwWku
	 Sdj7BsIPXnJmCUT+uSbjTXBeo/a3FfPQ+xsffCJ/2ySqzlsSZEwObAGp6O+qIHf6ErG1z
	 ZntOxF9NM+ICNoJQwD2dSjeEhZ8VYH+IPMNUq2cyNq6ymp+waukzKtTEq2IBmltJBwa8W
	 amzGvGXSaKAgBLLzFlJs7R18PnSJqmWS4l1rE38sh/sMJPDzdT4YL0mVcZti9/ItNCQCD
	 z3PaELlRoxyXufZYLq9ti+XuRjLv6qIdWRjC68lKoOUjoqGjB9QWcGYD0ABS997463g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c6/OxIO9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B974606A31B;
	Wed,  4 Nov 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6/OxIO9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2C41F0093A;
	Wed,  4 Nov 2026 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818490;
	bh=cG8AFS3ByOoBWQgtRmImcWG2ty8e5AClYttQEcmlyV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c6/OxIO9ovxn8GJYWHEpG/eDiFPVRRrez8Wv7t57s2/ynK91AeIhoSiBBNKk0SFL0
	 Z7tNIJl/rSyIn0GmY8c9sU1sWSgo2t/kXu14aPvD7sofA2K3ASpz+6U3W2P+W1avHW
	 Ek7qb8IjBGwBMSC0N2oqxGJNvP5sB4mZmSYmBt5gmp+lZZbbShdo2vwxHMQYKNRJQ5
	 /2Uk/9Wh5cIckuTC4cVsFpEUHOetB+fSB+HIWGmO0RN/cMOsoTo7JLN00jEXHSh5xc
	 0dZou7Cg//UxlqjdxMq3HRrlJBxrfz4a11riN//z7dGD1U2zLG3iuibykmPEN2+xCn
	 sTzH56owHOrPw==
From: William Breathitt Gray <wbg@kernel.org>
To: biju.das.jz@bp.renesas.com,
	Li Youhong <dayou5941@163.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cosmin-gabriel.tanislav.xa@renesas.com,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] counter: rz-mtu3-cnt: put runtime PM ref if counter init fails
Date: Wed,  4 Nov 2026 13:54:37 -0500
Message-ID: <179381830098.3891028.14535825465805662095.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101130746.1724364-1-dayou5941@163.com>
References: <20261101130746.1724364-1-dayou5941@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=419; i=wbg@kernel.org; h=from:subject:message-id; bh=S5lTQ5T5UT09hfDy0YUIYDGlXhFkuKtIkneowjRJ33Y=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFmv631cd1RqHmY8saDs4Kz7Zw8yuV+foeMXqb//7eZ5N roei5nndJSyMIhxMciKKbL0mp+9++CSqsaPF/O3wcxhZQIZwsDFKQATmSzL8M+s1VJP5J9Z0v5H Dkki4tf3Xk1alhU6ZzlrvNmx7snHgmcz/GYtn/byzITZB/ReJxaFX8xZtakqse3Uzhp5vhcrBWd +OsEMAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Sun, 01 Nov 2026 21:07:46 +0800, Li Youhong wrote:
> Counter enable takes a runtime PM reference before initialization but
> only puts it on disable. Drop the reference if initialization fails.
> 
> 

Applied, thanks!

[1/1] counter: rz-mtu3-cnt: put runtime PM ref if counter init fails
      commit: cfd4c04ef6abceaad377af65b56621405d850eb4

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
