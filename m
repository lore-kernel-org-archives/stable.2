Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702007;
	b=OCuPIz7o3iF4vDZLWib0LIasv2DznO1hK2x+E3G5AhWQRRSaCxO9AphmhSlEjTW1N9tV
	 QjLUkTra9DmPKp7w7hbdECQIQ0pWuPONEK7NHPkDypCBzs4Pw4+qZrfUm9CLZUWOqUGnU
	 ZDGJ+F8gNdbAiG6VArx/a7NmM9HwN+NlfIVtHygCQ/Wv7woEASkoAw8eqjJY1fjmLFwIv
	 4eurVnm11p01X74oboXwkD+wkJbdktl5VIZr8tObzznuUpfFqhCk0+bTbxlrJjWqa54ff
	 fWP7KoA7zzURnfq85iNhHHNE66QYbTz5thwHAH9YU2VDfteZ7zHQbI4JT4DfemfgRkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=AXI5Fk6P7laqpHgOTZygc/t+WznLoQyIIR9IldmNjAlb9DH0c0nT/gept4OxopY/z3ip
	 tl7BuYXyx10zBlvvlR7ZJAU5ZnFsnyw0MhtDCpgWUUdHNVu0dCEGPrgAyPQyGLvbUPO9F
	 pHjN6T3Uzs0osU2GFSRcTk2RApW25CRUUp4LovczjA6aAytMcDa+78UJLIXdTPOWRnIHt
	 vC68zo2SzI90wkfvr4gDIRayenPAbxGyQCKMH9r9GLnPem7y/jNb0wPQ7DQdLR5NcXFbZ
	 P5ikj6rNmRmen/fB6hPCksrQnG2fXhxl60EO/Gz5i53AeA2PMve9Ou5sTn1otI+Y9RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6Mb0kqj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D466078499;
	Tue,  3 Nov 2026 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6Mb0kqj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54DE1F000C1;
	Tue,  3 Nov 2026 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702006;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S6Mb0kqjpFw9XBMfata+aRfxVVxPTSWqKBZjjIeocp4gTOldgaP9iPrI7qZgAW5QA
	 gAOT/JMFV19OFZD/bfxkkb2FnhTZCE25RBMHlwkLKl9LLn5qFnQ0rvbzZkiCombYq8
	 Quy5IuCNzmiMlfV74VnHsGj2fqqfnokpkbv8TPpmmZTg/hH+xLIKT4uz+WDpQplqfl
	 paiZlJZrk/m8l0rTAzxrQHY7k82cxeqgPQ+DUnlKThIdqANl0fmFYt1vK0rrCEwGgx
	 tApMrVls9LpMNi7+meWGiyWX78LX+xtCKOlZDwcHVpe1bp5HAnsvfKCHukAcDmKUK1
	 XUTAWnTy6LJmQ==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: lan743x: disconnect the PHY when PTP setup fails
Date: Tue, 03 Nov 2026 10:33:25 +0000
Message-ID: <179370200518.488859.11611277839546236733@kernel.org>
In-Reply-To: <20261103102852.1340530-1-vulab@iscas.ac.cn>
References: <20261103102852.1340530-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
