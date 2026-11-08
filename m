Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154781;
	b=rZKj/Xi3CsQUzK0EEkm5iOMEcKbtSSfBBuwSL3v4FeM7m7JcwbAnHZlt5P4aZ2Rmg9jS
	 u95QUN1l7ll5j3ZmUtXSSo35pbGKokUuvIcQ+bxlHXZi+MOcZxNXv/hzi2m60xyitqGjW
	 wNt2+QB08nv+W4DHJPBevd8Z0H8wDc5sRm6eIB2ZC27dhaFiGB641Kpqdq3CJuKsMhBya
	 hzV6vJA+1jILr70T/+aTZPMtFOJfsk2J/kepHrp7JxubD5FnJX8gSgYhkAOcXFvjoQA+O
	 fuHuW1oxvjDKZB6C7sRDsFP3aNsegaG4M8ZjUAY4s2zGTOjdKW5JLISx5OKQT8Ura5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154781;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rYLFoY9JuUAWtQjVa8EfK7ekbKLIQtxVRKhNRoHNOrI=;
	b=CVLZ4mssFcWibff3H/x4jcR8TJD+KLcXxj5NyLu7fFoBSpemBbp7ZDWr2D8Ow1Lfp4aw
	 oisegiaJBzingYnAtLO24AvRDd0zrfLg5LuGH6zOhBqtUltHFyNHr9TpWZNN5n1Ws+zXZ
	 EJeQ6vbWsNdzGTRDufUCoT2/tLenAn2VgiY0pNV2X8Cae3SEpBE8I6DPEQB2n/gFIgYo7
	 5VYALLrrUs4+hOca+xHHZGO+aL1yz0o/p4TYfVZ+oWfzmkOVqnCIazSB7VGmMPhM7jdKm
	 Jrnjttw68mMUHESLw4f2goV5fCqP2M2qjs8q+9gLiynJqKLSPwBboWPYBAwrXMbw5Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB7606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 16:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5FB7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so1656645e9.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 08:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154779; x=1794759579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rYLFoY9JuUAWtQjVa8EfK7ekbKLIQtxVRKhNRoHNOrI=;
        b=hNcGFu8zsR4Vq/d+/x5Zz23L3IWKJJdwUsTP5pehdSe8oJMRMnG2U7TCPGYlyKD20J
         cpbQk3W6fvEnBSltzf+9uVzIA8ph8DA3YoMwlm+YvFiMkymMS4bYZ8spGRmFxr4a0cVS
         A9etLxfG7fGbdC8uPg5ukONoNf/FEr9IGppTNvFLxmu1w91I3HBW7n6KBNLRm/XCxW83
         XTIn3B456T1lEj7BSM7DSUaccLs2TdpX9zUAJ+s2tMCXeWBX5oBbQflOJeeLlhPr7i+7
         7EWYGts34ML2/93kYTNlHrDbUzKcLbef/b20vRslWLYseNn8iHPCZb4SO2VsrjZBiBqR
         cGDA==
X-Gm-Message-State: APuU4Z/tW/jUsoLH4x1M9zobDOoahfCYWrTyXsx8cG33+SwMf71/qjIj
	LE7X8FVb5jZxvpY51QfJqgZcApTZxC45UZtJYuNJaXwkPMEfIJTALRtvNGd4BoZs8570fO9iCbK
	nbPDdVB/ckQ==
X-Gm-Gg: AYBFou3QoEvTLSJsSYK1k071SY/cPfFxRxIN6M9ZxRxpZrQe5fmVGPl4LyP3Nx28csZ
	J4ZEYwd+PefZkYLqRwRXHMg38eD+QT+4SufRPd89cDnu4FAqr+qrUUm/XKKpq+ZJ2lWIurwm/hf
	pydxSxG5nl4vx69m7b9u2EoskwI4lL3wjCd9+zub1Xr7uVR09Vz6SPYPnEI0HWazwJDfzs+iqUH
	s+tH5oF73UcMhN3nCIMdHWVmL6ClXcSsn4UciQOqJkltWJPAS6IGoBXXJBDGsHsCtrGaTwMTJrs
	lKWNYaNOEajvTpSC8+Y/yBMLVmR0I3z0wqOwC8c9BJJRcn5jvt9tCsQrnJwYkEoVAye+rP/6sT9
	eaxeSPW1r33JhHYR1yhi0/UQs7A4StbbWgEYzJBmxYyVi19iX8JlV7bQIYsZoZIyBCpeLKlmpcY
	txnM4Cv1Xpflh/inHFvoi+XMtlTe+Y94raAfnW7evJmxl7VVO2zIaRIFqQzBNja5nU+XDZPcCgM
	YC0Xas8O9ZpvU8FH9yeFNDGyFFP/dWsmAcZTrPAIAw/F8TwUmAk2LoEpkPXFC/ntgS2Oo89iVwE
	qC2euIcGuYQkziyJDrR4kaZT
X-Received: by 2002:a05:600c:8b58:b0:4a1:fe26:24f0 with SMTP id 5b1f17b1804b1-4b963c6bbb5mr29049795e9.20.1794154778714;
        Sun, 08 Nov 2026 08:19:38 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:e93f:179f:cb30:5c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cb772e1sm189535415e9.0.2026.11.08.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:19:38 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Christian Schmidbauer <opensource@grische.xyz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Breno Leitao <leitao@debian.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Guillaume Nault <gnault@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 0/3] vxlan: fix stats reads after the dstats conversion
Date: Sun,  8 Nov 2026 17:19:34 +0100
Message-ID: <cover.1794153876.git.opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026-09-26-daily-reply-0002-re-vxlan-dstats-6-6-reader-and-tx-side@kernel.org>
References: <20260812091127.1349673-4-sashal@kernel.org> <20260925180809.603571-1-opensource@grische.xyz> <2026-09-26-daily-reply-0002-re-vxlan-dstats-6-6-reader-and-tx-side@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha,

This series backports the vxlan dstats reader side:

  3e2f544dd8a3 ("net: get stats64 if device if driver is configured")
  94b601bc4f85 ("net: core: Implement dstats-type stats collections")
  195f88c57737 ("vxlan: Remove generic .ndo_get_stats64")

3e2f544dd8a3 has no effect on 6.6 by itself, but is needed by
94b601bc4f85 to apply cleanly.

Tested on 6.6.161 with and without the series on two 32-bit boards, a
little-endian ARMv7 Aruba AP-325 and a big-endian PowerPC Enterasys
WS-AP3715i.

Both boards miss the vxlan drops without the series and count them with
it. On the AP-325 a stats read also hangs once rx_drops is odd, and the
series fixes that as well.

Breno Leitao (2):
  net: get stats64 if device if driver is configured
  vxlan: Remove generic .ndo_get_stats64

Jeremy Kerr (1):
  net: core: Implement dstats-type stats collections

 drivers/net/vxlan/vxlan_core.c |  2 --
 net/core/dev.c                 | 52 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)


base-commit: b5a1dc3ad4822c6edfb53429e9a3759c9b0ac2be
-- 
2.54.0

