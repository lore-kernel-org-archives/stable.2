Received: from mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350333FE05
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356508; cv=none; b=Bd1nBiZggr1BZOPdmtTPkEMCfW/RGjiM2m9n9MXIE4djzZMJ7idl7xf/eMFDEfty9gO9LosXj68KjvgU+sypjTdEGV6xWJ9bqUqHDMYQZvacgSr1LHL/p5RAw9cgg9rfLlTM+07QlNbYG5pj08cTY4II/Ugu1KZytKS5ftmIWnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356508; c=relaxed/simple;
	bh=BhOoplpH8aQ2/P2FDuekf9zvrM4AlsAqzq2fRd/+8Jc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=OolOUadrBB0F5tnfdaPfjN/Recxpl6Js4SJ96beVPEcgPSACbqqYSgH2S247CN+Q9VFeO4qtG1Q15oz7LN6hA6gOfeJf20XJ0k+lcgJYq/t+wxp74K07mYj4pjBGKG9k6cvFBeUTkck8dCGOcRVzauL/JWAjrgd2QJF4HQNpXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=idwsmpM9; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="idwsmpM9"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BhOoplpH8aQ2/P2FDuekf9zvrM4AlsAqzq2fRd/+8Jc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791356504; v=1; x=1791961304;
 b=idwsmpM99osFmxYmj2oYxcPZfhppBBOc4QfbHjY88bXyhFcFUlLXL4lg3J9JzDM2mgEovaHp
 8Z3wPvBTrcc8tEB5QmND4eAzRhM7blxOm/e2vSMTppDFbEiSFy/RjG/PPW69sgtkd0hQ6UbEeQO
 Q3S13TUHIdQ+yeMmdljUfBjk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c6333aa925ab6f2a;
	Wed, 07 Oct 2026 06:18:38 +0000
X-Mizu-Trace-ID: c6333aa925ab6f2a
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Oct 2026 06:18:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <f9b5c4d2aad190bde1ad403ab3ab9491a18343f4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH rtw-next v4 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
To: "Ping-Ke Shih" <pkshih@realtek.com>, "Alastair D'Silva"
 <alastair@d-silva.org>, linux-wireless@vger.kernel.org, "Kalle Valo"
 <kvalo@kernel.org>
Cc: "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>, "Jernej 
 Skrabec" <jernej.skrabec@gmail.com>, "Ulf Hansson" <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 luka.gejak@linux.dev
In-Reply-To: <9f5d3b374ac9793b745e96121fcfc875083dc873@linux.dev>
References: <20261005084849.3109337-1-alastair@d-silva.org>
 <20261005084849.3109337-3-alastair@d-silva.org>
 <6665409e1d374c1face4936b827a6a9d@realtek.com>
 <ccc69689fe2a2cccc39d40221056722e24263f2f@linux.dev>
 <1b8a86e84c474693bfa71f39e946e7e6@realtek.com>
 <9f5d3b374ac9793b745e96121fcfc875083dc873@linux.dev>

October 7, 2026 at 07:21, "Luka Gejak" <luka.gejak@linux.dev mailto:luka.=
gejak@linux.dev?to=3D%22Luka%20Gejak%22%20%3Cluka.gejak%40linux.dev%3E > =
wrote:


[...]

Sorry for duplicated email, migadu was down and I thought email didn't se=
nd so I resent it.

Best regards,
Luka Gejak
