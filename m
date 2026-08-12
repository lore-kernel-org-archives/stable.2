Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1942CB05;
	Wed, 12 Aug 2026 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552019; cv=none; b=qHTS2aau8+nv+184L5ivrlCYk5VA4i4LYi1Mzk7/HuslR1h43K1xJ2fGksCRy0306soisdCVC6wd3G3Ifgu9k0lUqwP7HVukwdWcFmP9NnE8aAorQHFQfES82qmGTcMoQr1jJoBoEDqVHyyPd166yrzgeAvtLr51cW/UU9W1IWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552019; c=relaxed/simple;
	bh=vVoS3aZjKfWh5mUsEWbeSvP93isDGyQfh4lMYd/QpXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8GYTXPOUrFJBAIzsOKn6sBFdVLyruscym8gQun3cpr2s2xo2Z9cvJAiql2v/bmhLMrj4FesuHei+tONhBwL6PKYz8J8ySl3bV6ULr4Jgnb1HHXkIW2XJ7D/GvSWVFNjdM0H7KVmcNqCsiZQVfhuhrOiZBWKHSfr6nNgQNtyZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDgfZ6MH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDgfZ6MH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3B01F00AC4;
	Wed, 12 Aug 2026 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552017;
	bh=mfet8GT5AVs7leGxOiMdksWpNvxSQ28g5VxJV0229fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDgfZ6MHQpPtwu35pMU4B/qnxoxggfg+egjPy59H3/kjC92LumtK1/sWTrlCrGcCb
	 4l4/ddRgJbwFV8S20n/vNxtCNrG2z+vzeQoO/d6hQN8rXzsemYGznnEaVpvo5u8Vhh
	 dMH+SBhgcaBhq5O68F98xJqAUEXLF12NPSXwNbRSzIgpu4DLnHVvgmRUduujsnhsdT
	 xLLSEU0AkBVC+P0B3Fijd6v8hHTDzYbFlDQSn0FDh4za2BimL4KFZTPN9cNdximMd1
	 0ksXvrSGARK69+GLhteia8MIAcbxSrBdhZN80mVCyh8macpodQbOCf7Nwaxrm8/Gdx
	 cVSJKHb2QKOZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	stable@vger.kernel.org,
	Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	David LaPorte <dalaport@amazon.com>,
	Gabor Juhos <j4g8y7@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Frieder Schrempf <frieder@fris.de>
Subject: Re: [PATCH 6.12.y 0/3] Backport fixes for SPI NAND on i.MX6UL
Date: Wed, 12 Aug 2026 12:26:43 -0400
Message-ID: <20260812161500.10006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811161342.533280-1-frieder@fris.de>
References: <20260811161342.533280-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 11, 2026 at 06:13:35PM +0200, Frieder Schrempf wrote:
> This series contains these fixes picked from mainline, applying to stable 6.12
> cleanly.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
